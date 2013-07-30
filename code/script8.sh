#!/bin/bash -l
# author: pena
#SBATCH -J multimedusa_%j
#SBATCH -o multi_out_%j
#SBATCH -e multi_err_%j
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH -t 71:00:00
#SBATCH --mem-per-cpu=2000
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mycalesis@gmail.com

# commands to manage the batch script
#   submission command
#     sbatch [script-file]
#   status command
#     squeue -u pena
#   termination command
#     scancel [jobid]

# For more information
#   man sbatch
#   more examples in Taito guide in http://datakeskus.csc.fi/web/guest/taito-user-guide

# copy this script to your terminal and then add your commands here

#example run commands

#srun ./my_serial_program

module swap intel gcc/4.7.2
module swap intelmpi  openmpi/1.6.4
module load R/2.15.3
srun Rscript code/supp_mat_06_multiMEDUSA.R output/set_8.nex output/set_8.nex_mct.nex output/set_8.nex_raw_data_summary.csv output/set_8.nex_raw_data.csv
