#!/bin/sh
#SBATCH --mincpus 24
#SBATCH -p longq
#SBATCH -t 30:00:00
#SBATCH -e run_td3_hc3.sh.err
#SBATCH -o run_td3_hc3.sh.out
rm log.txt; 
export EXP_INTERP='/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3' ;
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 144 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 145 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 146 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 147 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 148 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 149 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 150 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 151 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 152 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 153 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 154 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 155 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 156 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 157 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 158 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 159 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 160 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 161 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 162 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 163 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 164 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 165 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 166 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 167 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 168 --exp_name td3_hc & 
wait