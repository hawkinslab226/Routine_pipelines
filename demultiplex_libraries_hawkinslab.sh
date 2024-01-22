#!/bin/bash
#$ -S /bin/bash
#$ -pe serial X ## number of nodes 
#$ -l mfree= XG -l h_rt=00:00:00  ##adjust the job header; X: memory; h_rt: job required hours   
#$  -cwd  
########################################################################################
### Basic info:
##Job Name: demultiplex_libraries_hawkinslab.sh
##Author Name: Andressa Oliveira de Lima (job adapted previously used in the lab) 
##Email: aolima@uw.edu
##Bcl2fastq demultiplexing NGS libraries (convert *.bcl to *.fastq files)
#########################################################################################

module load bcl2fastq/2.20 ##cluster module 

## Change dir to location of seq data for each run
dir=/net/fields/vol2/fieldslab-inst/nextseq/${X}  #X: replace for the seq location path            

## Change out to location where you want fastq files to go
out=/net/hawkins/vol1/NEXTSEQ_runs/${Y}  #Y: create a folder in "NEXTSEQ_runs" with the date of the seq run and replace it 

## sheet needs to be modified using excel or generating using script
sheet=/net/hawkins/vol1/NEXTSEQ_runs/${Y}/SampleSheet_{date}.csv #date: replace for the date of seq run 

bcl2fastq -R $dir \
         --use-bases-mask Y*,I8,I8,Y* \
         --minimum-trimmed-read-length 8 \
         --mask-short-adapter-reads 8 \
         --ignore-missing-bcls \
         --barcode-mismatches 1 \
          -o $out \
         --sample-sheet $sheet
		 

##change parameters 
# --use-bases-mask: if you need to masked the i5 (in case you only have i7) 
--use-bases-mask Y*,I8,N*,Y*

##not allow mismatches 
--barcode-mismatches 0
