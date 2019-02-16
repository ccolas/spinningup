#!/bin/sh
#SBATCH --mincpus 5
#SBATCH -p longq
#SBATCH -t 24:00:00
#SBATCH -e run_sac.sh.err
#SBATCH -o run_sac.sh.out
rm log.txt; 
export EXP_INTERP='/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3' ;
$EXP_INTERP sac_uvfa.py --env FetchPush-v1 --trial_id 5 --exp_name tests_sac & 
$EXP_INTERP sac_uvfa.py --env FetchPush-v1 --trial_id 6 --exp_name tests_sac & 
$EXP_INTERP sac_uvfa.py --env FetchPush-v1 --trial_id 7 --exp_name tests_sac & 
$EXP_INTERP sac_uvfa.py --env FetchPush-v1 --trial_id 8 --exp_name tests_sac & 
$EXP_INTERP sac_uvfa.py --env FetchPush-v1 --trial_id 9 --exp_name tests_sac & 
$EXP_INTERP sac_uvfa.py --env FetchPush-v1 --trial_id 10 --exp_name tests_sac & 
wait