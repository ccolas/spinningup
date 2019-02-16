import numpy as np


class ReplayBuffer:
    """
    A simple FIFO experience replay buffer for SAC agents.
    """

    def __init__(self, obs_dim, act_dim, size):
        self.obs1_buf = np.zeros([size, obs_dim], dtype=np.float32)
        self.obs2_buf = np.zeros([size, obs_dim], dtype=np.float32)
        self.acts_buf = np.zeros([size, act_dim], dtype=np.float32)
        self.rews_buf = np.zeros(size, dtype=np.float32)
        self.done_buf = np.zeros(size, dtype=np.float32)
        self.ptr, self.size, self.max_size = 0, 0, size

    def store(self, obs, act, rew, next_obs, done):
        self.obs1_buf[self.ptr] = obs
        self.obs2_buf[self.ptr] = next_obs
        self.acts_buf[self.ptr] = act
        self.rews_buf[self.ptr] = rew
        self.done_buf[self.ptr] = done
        self.ptr = (self.ptr+1) % self.max_size
        self.size = min(self.size+1, self.max_size)

    def sample_batch(self, batch_size=32):
        idxs = np.random.randint(0, self.size, size=batch_size)
        return dict(obs1=self.obs1_buf[idxs],
                    obs2=self.obs2_buf[idxs],
                    acts=self.acts_buf[idxs],
                    rews=self.rews_buf[idxs],
                    done=self.done_buf[idxs])




class UVFAReplayBuffer:
    """
    A simple FIFO experience replay buffer for SAC agents.
    """

    def __init__(self, obs_dim, act_dim, goal_dim, size, ep_length, reward_func, ratio_replay=0.8):

        self._storage = []
        self.ep_length = ep_length
        self.reward_func = reward_func
        self.obs_dim = obs_dim
        self.act_dim = act_dim
        self.goal_dim = goal_dim
        self.p_ep, self.size, self.ep_size, self.tr_count =  0, 0, 0, 0
        self.max_size, self.max_ep_size = size, size // ep_length
        self.ep_length = ep_length

        self.current_episode = dict(obs_1=np.zeros([ep_length, obs_dim], dtype=np.float32),
                                    obs_2=np.zeros([ep_length, obs_dim], dtype=np.float32),
                                    acts=np.zeros([ep_length, act_dim], dtype=np.float32),
                                    rews=np.zeros(size, dtype=np.float32),
                                    dones=np.zeros(size, dtype=np.float32),
                                    goals=np.zeros([ep_length, goal_dim], dtype=np.float32),
                                    outcomes = np.zeros([ep_length, goal_dim], dtype=np.float32)
                                    )
        self.replay_ratio = ratio_replay
        self._keys = ['obs_1', 'obs_2', 'rews', 'acts', 'dones', 'goals', 'outcomes']

    def store(self, obs, act, rew, next_obs, done, goal, outcome):

        self.current_episode['obs_1'][self.tr_count, :] = obs
        self.current_episode['obs_2'][self.tr_count, :] = next_obs
        self.current_episode['acts'][self.tr_count, :] = act
        self.current_episode['rews'][self.tr_count] = rew
        self.current_episode['dones'][self.tr_count] = done
        self.current_episode['goals'][self.tr_count, :] = goal
        self.current_episode['outcomes'][self.tr_count, :] = outcome
        self.tr_count += 1
        self.size = min(self.size + 1, self.max_size)

        if done or self.tr_count == self.ep_length:
            # save the current episode in storage
            if self.p_ep >= len(self._storage):
                self._storage.append(self.current_episode.copy())
            else:
                self._storage[self.p_ep] = self.current_episode.copy()

            # update the episode pointer, and create new current episode
            self.p_ep = (self.p_ep + 1) % self.max_ep_size
            self.current_episode = dict(obs_1=np.zeros([self.ep_length, self.obs_dim], dtype=np.float32),
                                        obs_2=np.zeros([self.ep_length, self.obs_dim], dtype=np.float32),
                                        acts=np.zeros([self.ep_length, self.act_dim], dtype=np.float32),
                                        rews=np.zeros(self.size, dtype=np.float32),
                                        dones=np.zeros(self.size, dtype=np.float32),
                                        goals=np.zeros([self.ep_length, self.goal_dim], dtype=np.float32),
                                        outcomes=np.zeros([self.ep_length, self.goal_dim], dtype=np.float32)
                                        )
            self.tr_count = 0
            self.ep_size = min(self.ep_size + 1, self.max_ep_size)

    def sample_batch(self, batch_size=32):
        eps = np.random.randint(0, self.ep_size, size=batch_size)
        tr_idxs = np.random.randint(0, self.ep_length, size=batch_size)
        

        batch = dict(obs_1=np.zeros([batch_size, self.obs_dim], dtype=np.float32),
                     obs_2=np.zeros([batch_size, self.obs_dim], dtype=np.float32),
                     acts=np.zeros([batch_size, self.act_dim], dtype=np.float32),
                     rews=np.zeros(batch_size, dtype=np.float32),
                     dones=np.zeros(batch_size, dtype=np.float32),
                     goals=np.zeros([batch_size, self.goal_dim], dtype=np.float32),
                     outcomes=np.zeros([batch_size, self.goal_dim], dtype=np.float32)
                     )
        
        for k in self._keys:
            for i in range(batch_size):
                batch[k][i] = self._storage[eps[i]][k][tr_idxs[i]]
        
        # replay
        if self.replay_ratio > 0.:
            replayed_idx = np.argwhere(np.random.random(size=batch_size) < self.replay_ratio)
            replayed_eps = eps[replayed_idx]
            future_idx = []
            for id in replayed_idx:
                future_idx.append(np.random.randint(id, self.ep_length))

            for i, ep, future_i in zip(replayed_idx, replayed_eps, future_idx):
                new_goal =  self._storage[ep]['outcomes'][future_i, :]
                outcome =  self._storage[ep]['outcomes'][i, :]
                new_reward = self.reward_func(new_goal, outcome)
                batch['goals'][i, :] = new_goal
                batch['rews'][i, :] = new_reward

        return batch