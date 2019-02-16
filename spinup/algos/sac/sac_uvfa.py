import os
import numpy as np
import tensorflow as tf
import gym
import time
from spinup.algos.sac import core
from spinup.algos.sac.core import get_vars
from spinup.utils.logx import EpochLogger

from spinup.algos.sac.replay_buffers import UVFAReplayBuffer

os.environ['LD_LIBRARY_PATH']+=':'+os.environ['HOME']+'/.mujoco/mjpro150/bin:'



"""

Soft Actor-Critic

(With slight variations that bring it closer to TD3)

"""
def sac(env_fn, env_id, actor_critic=core.mlp_actor_critic, ac_kwargs=dict(), seed=int(np.random.randint(1e6)),
        steps_per_epoch=25000, epochs=200, replay_size=int(1e6), gamma=0.99,
        polyak=0.995, lr=1e-3, alpha=0.2, batch_size=100, start_steps=10000, 
        max_ep_len=50, logger_kwargs=dict(), save_freq=1, return_func='last_equal_0'):
    """

    Args:
        env_fn : A function which creates a copy of the environment.
            The environment must satisfy the OpenAI Gym API.

        actor_critic: A function which takes in placeholder symbols 
            for state, ``x_ph``, and action, ``a_ph``, and returns the main 
            outputs from the agent's Tensorflow computation graph:

            ===========  ================  ======================================
            Symbol       Shape             Description
            ===========  ================  ======================================
            ``mu``       (batch, act_dim)  | Computes mean actions from policy
                                           | given states.
            ``pi``       (batch, act_dim)  | Samples actions from policy given 
                                           | states.
            ``logp_pi``  (batch,)          | Gives log probability, according to
                                           | the policy, of the action sampled by
                                           | ``pi``. Critical: must be differentiable
                                           | with respect to policy parameters all
                                           | the way through action sampling.
            ``q1``       (batch,)          | Gives one estimate of Q* for 
                                           | states in ``x_ph`` and actions in
                                           | ``a_ph``.
            ``q2``       (batch,)          | Gives another estimate of Q* for 
                                           | states in ``x_ph`` and actions in
                                           | ``a_ph``.
            ``q1_pi``    (batch,)          | Gives the composition of ``q1`` and 
                                           | ``pi`` for states in ``x_ph``: 
                                           | q1(x, pi(x)).
            ``q2_pi``    (batch,)          | Gives the composition of ``q2`` and 
                                           | ``pi`` for states in ``x_ph``: 
                                           | q2(x, pi(x)).
            ``v``        (batch,)          | Gives the value estimate for states
                                           | in ``x_ph``. 
            ===========  ================  ======================================

        ac_kwargs (dict): Any kwargs appropriate for the actor_critic 
            function you provided to SAC.

        seed (int): Seed for random number generators.

        steps_per_epoch (int): Number of steps of interaction (state-action pairs) 
            for the agent and the environment in each epoch.

        epochs (int): Number of epochs to run and train agent.

        replay_size (int): Maximum length of replay buffer.

        gamma (float): Discount factor. (Always between 0 and 1.)

        polyak (float): Interpolation factor in polyak averaging for target 
            networks. Target networks are updated towards main networks 
            according to:

            .. math:: \\theta_{\\text{targ}} \\leftarrow 
                \\rho \\theta_{\\text{targ}} + (1-\\rho) \\theta

            where :math:`\\rho` is polyak. (Always between 0 and 1, usually 
            close to 1.)

        lr (float): Learning rate (used for both policy and value learning).

        alpha (float): Entropy regularization coefficient. (Equivalent to 
            inverse of reward scale in the original SAC paper.)

        batch_size (int): Minibatch size for SGD.

        start_steps (int): Number of steps for uniform-random action selection,
            before running real policy. Helps exploration.

        max_ep_len (int): Maximum length of trajectory / episode / rollout.

        logger_kwargs (dict): Keyword args for EpochLogger.

        save_freq (int): How often (in terms of gap between epochs) to save
            the current policy and value function.

        return_func (str): Method to compute the return from the episode rewards.
            'sum' returns the sum, 'last_equal_0' returns 1 if the last reward is 0, 0 otherwise

    """

    logger = EpochLogger(**logger_kwargs)
    logger.save_config(locals())

    tf.set_random_seed(seed)
    np.random.seed(seed)

    env, test_env = env_fn(), env_fn()
    env.seed(seed)
    test_env.seed(10 * seed)
    obs_dim = env.observation_space.spaces['observation'].shape[0]
    act_dim = env.action_space.shape[0]
    goal_dim = 3

    reward_func = env.unwrapped.compute_reward

    # # Action limit for clamping: critically, assumes all dimensions share the same bound!
    # act_limit = env.action_space.high[0]

    # Share information about action space with policy architecture
    ac_kwargs['action_space'] = env.action_space

    # Inputs to computation graph
    x_ph, a_ph, x2_ph, r_ph, d_ph, g_ph = core.placeholders(obs_dim, act_dim, obs_dim, None, None, goal_dim)

    # Main outputs from computation graph
    with tf.variable_scope('main'):
        in_ph = tf.concat([x_ph, g_ph], axis=1)
        mu, pi, logp_pi, q1, q2, q1_pi, q2_pi, v = actor_critic(in_ph, a_ph, **ac_kwargs)
    
    # Target value network
    with tf.variable_scope('target'):
        in2_ph = tf.concat([x2_ph, g_ph], axis=1)
        _, _, _, _, _, _, _, v_targ  = actor_critic(in2_ph, a_ph, **ac_kwargs)

    # Experience buffer
    replay_buffer = UVFAReplayBuffer(obs_dim, act_dim, goal_dim, size=replay_size,
                                     ep_length=max_ep_len, reward_func=reward_func, ratio_replay=0.)

    # Count variables
    var_counts = tuple(core.count_vars(scope) for scope in 
                       ['main/pi', 'main/q1', 'main/q2', 'main/v', 'main'])
    print(('\nNumber of parameters: \t pi: %d, \t' + \
           'q1: %d, \t q2: %d, \t v: %d, \t total: %d\n')%var_counts)

    # Min Double-Q:
    min_q_pi = tf.minimum(q1_pi, q2_pi)

    # Targets for Q and V regression
    q_backup = tf.stop_gradient(r_ph + gamma*(1-d_ph)*v_targ)
    v_backup = tf.stop_gradient(min_q_pi - alpha * logp_pi)

    # Soft actor-critic losses
    pi_loss = tf.reduce_mean(alpha * logp_pi - q1_pi)
    q1_loss = 0.5 * tf.reduce_mean((q_backup - q1)**2)
    q2_loss = 0.5 * tf.reduce_mean((q_backup - q2)**2)
    v_loss = 0.5 * tf.reduce_mean((v_backup - v)**2)
    value_loss = q1_loss + q2_loss + v_loss

    # Policy train op 
    # (has to be separate from value train op, because q1_pi appears in pi_loss)
    pi_optimizer = tf.train.AdamOptimizer(learning_rate=lr)
    train_pi_op = pi_optimizer.minimize(pi_loss, var_list=get_vars('main/pi'))

    # Value train op
    # (control dep of train_pi_op because sess.run otherwise evaluates in nondeterministic order)
    value_optimizer = tf.train.AdamOptimizer(learning_rate=lr)
    value_params = get_vars('main/q') + get_vars('main/v')
    with tf.control_dependencies([train_pi_op]):
        train_value_op = value_optimizer.minimize(value_loss, var_list=value_params)

    # Polyak averaging for target variables
    # (control flow because sess.run otherwise evaluates in nondeterministic order)
    with tf.control_dependencies([train_value_op]):
        target_update = tf.group([tf.assign(v_targ, polyak*v_targ + (1-polyak)*v_main)
                                  for v_main, v_targ in zip(get_vars('main'), get_vars('target'))])

    # All ops to call during one training step
    step_ops = [pi_loss, q1_loss, q2_loss, v_loss, q1, q2, v, logp_pi, 
                train_pi_op, train_value_op, target_update]

    # Initializing targets to match main variables
    target_init = tf.group([tf.assign(v_targ, v_main)
                              for v_main, v_targ in zip(get_vars('main'), get_vars('target'))])

    sess = tf.Session()
    sess.run(tf.global_variables_initializer())
    sess.run(target_init)

    # Setup model saving
    logger.setup_tf_saver(sess, inputs={'x': x_ph, 'a': a_ph}, 
                                outputs={'mu': mu, 'pi': pi, 'q1': q1, 'q2': q2, 'v': v})

    def compute_return(rewards, return_func='sum'):
        if return_func == 'sum':
            return np.sum(rewards)

        elif return_func == 'last_equal_0':
            return np.float(rewards[-1] == 0)

    def unpack_obs(obs):
        return obs['observation'], obs['desired_goal'], obs['achieved_goal']

    def get_action(o, goal, deterministic=False):
        act_op = mu if deterministic else pi
        return sess.run(act_op, feed_dict={x_ph: o.reshape(1,-1), g_ph: goal.reshape(1, -1)})[0]

    def test_agent(n=10, return_func='sum'):
        global sess, mu, pi, q1, q2, q1_pi, q2_pi
        for j in range(n):
            eval_obs_out, r, d, ep_rews, ep_len = test_env.reset(), 0, False, [], 0
            o, goal, _ = unpack_obs(eval_obs_out)
            while not(d or (ep_len == max_ep_len)):
                # Take deterministic actions at test time 
                obs_out, r, d, _ = test_env.step(get_action(o, goal, True))
                o, goal, _ = unpack_obs(obs_out)
                ep_rews.append(r)
                ep_len += 1
            ep_ret = compute_return(ep_rews, return_func=return_func)
            logger.store(TestEpRet=ep_ret, TestEpLen=ep_len)

    start_time = time.time()
    obs_out, r, d, ep_rews, ep_len = env.reset(), 0, False, [], 0
    o, goal, _ = unpack_obs(obs_out)
    total_steps = steps_per_epoch * epochs

    # Main loop: collect experience in env and update/log each epoch
    for t in range(total_steps):

        """
        Until start_steps have elapsed, randomly sample actions
        from a uniform distribution for better exploration. Afterwards, 
        use the learned policy. 
        """
        if t > start_steps:
            a = get_action(o, goal)
        else:
            a = env.action_space.sample()

        # Step the env
        obs2_out, r, d, _= env.step(a)
        o2, goal, outcome = unpack_obs(obs2_out)
        ep_rews.append(r)
        ep_len += 1

        # Ignore the "done" signal if it comes from hitting the time
        # horizon (that is, when it's an artificial terminal signal
        # that isn't based on the agent's state)
        d = False if ep_len==max_ep_len else d

        # Store experience to replay buffer
        replay_buffer.store(o, a, r, o2, d, goal, outcome)

        # Super critical, easy to overlook step: make sure to update 
        # most recent observation!
        o = o2

        if d or (ep_len == max_ep_len):
            """
            Perform all SAC updates at the end of the trajectory.
            This is a slight difference from the SAC specified in the
            original paper.
            """
            for j in range(ep_len):
                batch = replay_buffer.sample_batch(batch_size)
                feed_dict = {x_ph: batch['obs_1'],
                             x2_ph: batch['obs_2'],
                             a_ph: batch['acts'],
                             r_ph: batch['rews'],
                             d_ph: batch['dones'],
                             g_ph: batch['goals']
                            }
                outs = sess.run(step_ops, feed_dict)
                logger.store(LossPi=outs[0], LossQ1=outs[1], LossQ2=outs[2],
                             LossV=outs[3], Q1Vals=outs[4], Q2Vals=outs[5],
                             VVals=outs[6], LogPi=outs[7])

            ep_ret = compute_return(ep_rews, return_func=return_func)
            logger.store(EpRet=ep_ret, EpLen=ep_len)
            obs_out, r, d, ep_rews, ep_len = env.reset(), 0, False, [], 0
            o, goal, outcome = unpack_obs(obs_out)


        # End of epoch wrap-up
        if t > 0 and t % steps_per_epoch == 0:
            epoch = t // steps_per_epoch

            # Save model
            if (epoch % save_freq == 0) or (epoch == epochs-1):
                logger.save_state({'env': env}, None)

            # Test the performance of the deterministic version of the agent.
            test_agent(return_func=return_func)

            # Log info about epoch
            logger.log_tabular('Epoch', epoch)
            logger.log_tabular('EpRet', with_min_and_max=True)
            logger.log_tabular('TestEpRet', with_min_and_max=True)
            logger.log_tabular('EpLen', average_only=True)
            logger.log_tabular('TestEpLen', average_only=True)
            logger.log_tabular('TotalEnvInteracts', t)
            logger.log_tabular('Q1Vals', with_min_and_max=True) 
            logger.log_tabular('Q2Vals', with_min_and_max=True) 
            logger.log_tabular('VVals', with_min_and_max=True) 
            logger.log_tabular('LogPi', with_min_and_max=True)
            logger.log_tabular('LossPi', average_only=True)
            logger.log_tabular('LossQ1', average_only=True)
            logger.log_tabular('LossQ2', average_only=True)
            logger.log_tabular('LossV', average_only=True)
            logger.log_tabular('Time', time.time()-start_time)
            logger.dump_tabular()

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--env', type=str, default='FetchReach-v1')
    parser.add_argument('--trial_id', type=int, default=0)
    parser.add_argument('--hid', type=int, default=300)
    parser.add_argument('--l', type=int, default=1)
    parser.add_argument('--gamma', type=float, default=0.99)
    parser.add_argument('--seed', '-s', type=int, default=int(np.random.randint(1e6)))
    parser.add_argument('--epochs', type=int, default=300)
    parser.add_argument('--exp_name', type=str, default='tests_sac')
    args = parser.parse_args()

    from spinup.utils.run_utils import setup_logger_kwargs
    logger_kwargs = setup_logger_kwargs(args.env, args.trial_id, args.exp_name)

    sac(lambda : gym.make(args.env), env_id=args.env, actor_critic=core.mlp_actor_critic,
        ac_kwargs=dict(hidden_sizes=[args.hid]*args.l),
        gamma=args.gamma, seed=args.seed, epochs=args.epochs,
        logger_kwargs=logger_kwargs)