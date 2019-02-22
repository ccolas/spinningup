#!/bin/sh
#SBATCH --mincpus 24
#SBATCH -p longq
#SBATCH -t 30:00:00
#SBATCH -e run_sac_hc2.sh.err
#SBATCH -o run_sac_hc2.sh.out
rm log.txt; 
export EXP_INTERP='/cm/shared/apps/intel/composer_xe/python3.5/intelpython3/bin/python3' ;
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 48 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 49 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 50 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 51 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 52 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 53 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 54 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 55 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 56 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 57 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 58 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 59 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 60 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 61 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 62 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 63 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 64 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 65 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 66 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 67 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 68 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 69 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 70 --exp_name sac_hc & 
$EXP_INTERP sac.py --env HalfCheetah-v2 --trial_id 71 --exp_name sac_hc & 
wait