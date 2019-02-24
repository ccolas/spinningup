#!/bin/sh
#SBATCH --mincpus 24
#SBATCH -p longq
#SBATCH -t 50:00:00
#SBATCH -e run_sac_hc2.sh.err
#SBATCH -o run_sac_hc2.sh.out
rm log.txt; 
export EXP_INTERP='/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3' ;
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 120 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 121 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 122 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 123 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 124 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 125 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 126 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 127 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 128 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 129 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 130 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 131 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 132 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 133 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 134 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 135 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 136 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 137 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 138 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 139 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 140 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 141 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 142 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 143 --exp_name sac_hc & 
wait