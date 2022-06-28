#!/bin/sh
#$ -cwd
#$ -V
#$ -N Bowtie
#$ -l h_rt=24:00:00
#$ -l h_vmem=64G

module load igmm/apps/anaconda/5.0.0.1
source activate /exports/cmvm/eddie/sbms/groups/young-lab/megan/.conda/envs/CAGE2r
cd /exports/eddie/scratch/s2210624/tr_trimming_qc/
for file in $(ls *_cutadapt_q_cut_34_trim.fastq.gz)
do
f_name=$(basename $file .fastq.gz)
if [[ ! -e "$f_name".bowtie1.sam ]]
then
zcat $file  | bowtie --threads 6 --sam hg38_bowtie1  -q - -v 2 -a --best "$f_name".bowtie1.sam
fi
done
