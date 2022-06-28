#!/bin/sh
#$ -cwd
#$ -V
#$ -N Cutadapt_trim_3030
#$ -l h_rt=06:00:00
#$ -l h_vmem=64G

module load igmm/apps/anaconda/5.0.0.1
module load igmm/apps/cutadapt/1.16
source activate /exports/cmvm/eddie/sbms/groups/young-lab/megan/.conda/envs/CAGE2r
cd  /exports/eddie/scratch/s2210624/tr_trimming_qc/
for file in $(cat tr2.txt)
do
f_name=$(basename $file _1.fastq.gz)
cutadapt --quality-cutoff 30,30 $file | cutadapt -l 34 - | cutadapt -g XNNNCAGCAG - -m 25 --untrimmed-output "$f_name"_untrimmed_cutadapt_q3030_cut_34_trim.txt --too-short-output "$f_name"_too_short_cutadapt_q3030_cut_34_trim.txt -o "$f_name"_cutadapt_q3030_cut_34_trim.fastq.gz
done
cd /exports/cmvm/eddie/sbms/groups/young-lab/megan
