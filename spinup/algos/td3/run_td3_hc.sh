#!/bin/sh
#SBATCH --mincpus 24
#SBATCH -p longq
#SBATCH -t 30:00:00
#SBATCH -e run_td3_hc.sh.err
#SBATCH -o run_td3_hc.sh.out
rm log.txt; 
export EXP_INTERP='/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3' ;
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 24 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 25 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 26 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 27 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 28 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 29 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 30 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 31 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 32 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 33 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 34 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 35 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 36 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 37 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 38 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 39 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 40 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 41 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 42 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 43 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 44 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 45 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 46 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 47 --exp_name td3_hc & 
wait