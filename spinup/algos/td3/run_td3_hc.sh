#!/bin/sh
#SBATCH --mincpus 24
#SBATCH -p longq
#SBATCH -t 30:00:00
#SBATCH -e run_td3_hc.sh.err
#SBATCH -o run_td3_hc.sh.out
rm log.txt; 
export EXP_INTERP='/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3' ;
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 96 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 97 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 98 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 99 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 100 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 101 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 102 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 103 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 104 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 105 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 106 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 107 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 108 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 109 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 110 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 111 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 112 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 113 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 114 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 115 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 116 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 117 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 118 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 119 --exp_name td3_hc & 
wait