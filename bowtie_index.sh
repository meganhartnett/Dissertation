#!/bin/sh
#$ -cwd
#$ -V
#$ -N Bowtie_Index
#$ -l h_rt=06:00:00
#$ -l h_vmem=64G

module load igmm/apps/anaconda/5.0.0.1
module load igmm/apps/bowtie/2.3.5.1
source activate /exports/cmvm/eddie/sbms/groups/young-lab/megan/.conda/envs/CAGE2r
bowtie-inspect --summary  hg38_bowtie1 
