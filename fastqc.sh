#!/bin/sh
#$ -cwd
#$ -V
#$ -N Fastqc
#$ -l h_rt=06:00:00
#$ -l h_vmem=16G

module load igmm/apps/anaconda/5.0.0.1
source activate /exports/cmvm/eddie/sbms/groups/young-lab/megan/.conda/envs/CAGE2r
cd /exports/eddie/scratch/s2210624/tr_trimming_qc/
#for file in $(ls *_cutadapt_q_cut_34_trim.fastq.gz)
#do
time fastqc SRR5293430_cutadapt_q3030_cut_34_trim.fastq.gz
#done
