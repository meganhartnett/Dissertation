#!/bin/sh
#$ -cwd
#$ -V
#$ -N Samtools
#$ -l h_rt=24:00:00
#$ -l h_vmem=64G

module load igmm/apps/anaconda/5.0.0.1
source activate /exports/cmvm/eddie/sbms/groups/young-lab/megan/.conda/envs/CAGE2r
cd /exports/eddie/scratch/s2210624/tr_trimming_qc/
samtools view -S -b SRR5293430_cutadapt_q_cut_34_trim.bowtie1.sam > SRR5293430_cutadapt_q_cut_34_trim.bowtie1.bam
samtools sort  SRR5293430_cutadapt_q_cut_34_trim.bowtie1.bam -o  SRR5293430_cutadapt_q_cut_34_trim.bowtie1.sorted.bam
samtools index SRR5293430_cutadapt_q_cut_34_trim.bowtie1.sorted.bam
