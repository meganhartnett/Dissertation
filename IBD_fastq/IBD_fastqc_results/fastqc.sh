#!/bin/sh
#$ -cwd
#$ -V
#$ -N fastqc
#$ -l h_rt=06:00:00
#$ -l h_vmem=128G

module load igmm/apps/anaconda/5.0.0.1
module load igmm/apps/FastQC/0.11.9
source activate /exports/cmvm/eddie/sbms/groups/young-lab/megan/.conda/envs/CAGE2r

# For file in directory with the file extension .fq.gz then loop through and run fastqc
for file in $(ls /exports/cmvm/eddie/sbms/groups/young-lab/megan/IBD_fastq/*1.fastq.gz)
do
fname=$(basename $file _1.fastq.gz)
echo "$fname"
if [[ ! -f /exports/cmvm/eddie/sbms/groups/young-lab/megan/IBD_fastq/IBD_fastqc_results/"$fname"_1_fastqc.zip ]]
then
echo "$file"
fastqc -t 6  $file
echo "done"
fi
done

