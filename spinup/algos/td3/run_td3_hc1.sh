#!/bin/sh
#SBATCH --mincpus 24
#SBATCH -p longq
#SBATCH -t 30:00:00
#SBATCH -e run_td3_hc1.sh.err
#SBATCH -o run_td3_hc1.sh.out
rm log.txt; 
export EXP_INTERP='/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3' ;
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 169 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 170 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 171 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 172 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 173 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 174 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 175 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 176 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 177 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 178 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 179 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 180 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 181 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 182 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 183 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 184 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 185 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 186 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 187 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 188 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 189 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 190 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 191 --exp_name td3_hc & 
$EXP_INTERP td3.py --env HalfCheetah-v2 --trial_id 192 --exp_name td3_hc & 
wait