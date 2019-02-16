#!/bin/sh
#SBATCH --mincpus 5
#SBATCH -p longq
#SBATCH -t 24:00:00
#SBATCH -e run_sac.sh.err
#SBATCH -o run_sac.sh.out
rm log.txt; 
export EXP_INTERP='/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3' ;
$EXP_INTERP sac.py --env FetchPush-v1 --trial_id 0 --exp_name tests_sac & 
$EXP_INTERP sac.py --env FetchPush-v1 --trial_id 1 --exp_name tests_sac & 
$EXP_INTERP sac.py --env FetchPush-v1 --trial_id 2 --exp_name tests_sac & 
$EXP_INTERP sac.py --env FetchPush-v1 --trial_id 3 --exp_name tests_sac & 
$EXP_INTERP sac.py --env FetchPush-v1 --trial_id 4 --exp_name tests_sac & 
wait