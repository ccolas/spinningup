#!/bin/sh
#SBATCH --mincpus 24
#SBATCH -p longq
#SBATCH -t 30:00:00
#SBATCH -e run_td3_hc3.sh.err
#SBATCH -o run_td3_hc3.sh.out
rm log.txt; 
export EXP_INTERP='/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3' ;
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 72 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 73 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 74 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 75 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 76 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 77 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 78 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 79 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 80 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 81 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 82 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 83 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 84 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 85 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 86 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 87 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 88 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 89 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 90 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 91 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 92 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 93 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 94 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 95 --exp_name td3_hc & 
wait