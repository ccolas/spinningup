#!/usr/bin/python
# -*- coding: utf-8 -*-

import datetime

PATH_TO_INTERPRETER = "/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3"  # plafrim

env = 'FetchPush-v1'
trial_id = list(range(0, 5))
exp_name = 'tests_sac'  #'DDPG'  #'DDPG'

script_path = '../algos/sac/'
filename = 'run_sac.sh'
filepath = script_path + filename
with open(filepath, 'w') as f:
    f.write('#!/bin/sh\n')
    f.write('#SBATCH --mincpus 5\n')
    f.write('#SBATCH -p longq\n')
    f.write('#SBATCH -t 24:00:00\n')
    f.write('#SBATCH -e ' + filename + '.err\n')
    f.write('#SBATCH -o ' + filename + '.out\n')
    f.write('rm log.txt; \n')
    f.write("export EXP_INTERP='%s' ;\n" % PATH_TO_INTERPRETER)

    for seed in range(len(trial_id)):
        t_id = trial_id[seed]
        name = (exp_name+" : trial %s, %s" % (str(t_id), str(datetime.datetime.now()))).title()
        f.write("$EXP_INTERP sac.py --env %s --trial_id %s --exp_name %s & \n" % (env, str(seed), exp_name))
    f.write('wait')