#!/bin/bash
#SBATCH -J calibrate
#SBATCH -o calibrate_%j.txt
#SBATCH -e calibrate_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --time=04:00:00
#SBATCH --mail-user=qwu2@iu.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH -p general

module load matlab
module load dynare
cd /N/slate/qwu2/sofr/model
matlab < calibrate.m