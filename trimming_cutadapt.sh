#!/bin/sh
#$ -cwd
#$ -V
#$ -N Cutadapt_trim
#$ -l h_rt=06:00:00
#$ -l h_vmem=16G

module load igmm/apps/anaconda/5.0.0.1
module load igmm/apps/cutadapt/1.16
source activate /exports/cmvm/eddie/sbms/groups/young-lab/megan/.conda/envs/CAGE2r
cd  /exports/eddie/scratch/s2210624/tr_trimming_qc/
for file in $(cat tr2.txt)
do
f_name=$(basename $file _1.fastq.gz)
cutadapt -a NNTCGTATGCCGTCTTCTGCTTG -g NNNCAGCAG $file  | cutadapt --quality-cutoff 30 - -o "$f_name"_cutadapt.fastq.gz
done
cd /exports/cmvm/eddie/sbms/groups/young-lab/megan
