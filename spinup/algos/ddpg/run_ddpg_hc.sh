#!/bin/sh
#SBATCH --mincpus 24
#SBATCH -p longq
#SBATCH -t 30:00:00
#SBATCH -e run_ddpg_hc.sh.err
#SBATCH -o run_ddpg_hc.sh.out
rm log.txt; 
export EXP_INTERP='/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3' ;
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 0 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 1 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 2 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 3 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 4 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 5 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 6 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 7 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 8 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 9 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 10 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 11 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 12 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 13 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 14 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 15 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 16 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 17 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 18 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 19 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 20 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 21 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 22 --exp_name ddpg_hc & 
$EXP_INTERP ddpg.py --env HalfCheetah-v2 --trial_id 23 --exp_name ddpg_hc & 
wait