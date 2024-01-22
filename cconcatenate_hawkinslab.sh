#!/bin/bash
#$ -S /bin/bash
#$ -pe serial 1
#$ -l mfree=75G -l h_rt=170:00:00
#$ -cwd 
########################################################################################
### Basic info:
##Job Name: concatenate_hawkinslab.sh
##Author Name: Andressa Oliveira de Lima 
##Email: aolima@uw.edu
##concatenate *.fastq files 
#########################################################################################

Conda activate ## activate your conda environment
##
dir=/net/hawkins/vol1/NEXTSEQ_runs/${X} ## X:Replace for the folder path 


sample=( ##name of samples
"Tx10_ProximalCecum_M129_ATAC_S10"
"Tx1_Bursa_M129_ATAC_S1"
"Tx2_Bursa_M139_ATAC_S2"
"Tx3_Thymus_M129_ATAC_S3"
"Tx4_Thymus_M139_ATAC_S4"
"Tx5_Jejunum_M129_ATAC_S5"
"Tx6_Jejunum_M139_ATAC_S6"
"Tx7_Ileum_M129_ATAC_S7"
"Tx8_Ileum_M139_ATAC_S8"
"Tx9_ProximalCecum_M120_ATAC_S9"
)


cd $dir

for file in ${sample[@]}; do

cat ${file}_*_R1_001.fastq.gz >  ${file}_R1.fastq.gz
cat ${file}_*_R2_001.fastq.gz >  ${file}_R2.fastq.gz
done

conda activate

fastqc *_R1.fastq.gz
fastqc *_R2.fastq.gz

multiqc *.zip 
