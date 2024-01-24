#!/bin/bash

# Replace [minimap2_environment], [samtools_environment], [purge_haplotigs_environment], [genome_fasta], [ont_reads], [illumina_reads1], [illumina_reads2], and [output_directory] with actual values
minimap2_environment="minimap2.24"
samtools_environment="samtools-1.15.1"
purge_haplotigs_environment="purge_haplotigs"
genome_fasta="/path/to/your/genome.nextpolish.fasta"
ont_reads="/path/to/your/JG2022_porechoped.fastq"
illumina_reads1="/path/to/your/SF_S1_L001_R1_001.fastq"
illumina_reads2="/path/to/your/SF_S1_L001_R2_001.fastq"
output_directory="/path/to/your/output_directory"

# Activate Minimap2 Conda Environment
conda activate "${minimap2_environment}"

# Map long reads
minimap2 -t 30 -ax map-ont "${genome_fasta}" "${ont_reads}" > aln_ONT.sam \
    2> minimap2_ONTSEQ_log.txt  # for Oxford Nanopore reads

# Map short reads (Illumina)
minimap2 -t 30 -ax sr "${genome_fasta}" "${illumina_reads1}" "${illumina_reads2}" > aln_illumina.sam \
    2> minimap2_illuminaSEQ_log.txt  # paired-end alignment

# Deactivate Minimap2 Conda Environment
conda deactivate

# Activate Samtools Conda Environment
conda activate "${samtools_environment}"

# Convert SAM to BAM
samtools sort aln_ONT.sam -m 1G -o aligned_ONT.bam -T tmp.ali
samtools sort aln_illumina.sam -m 1G -o aligned_illumina.bam -T tmp.ali

# Deactivate Samtools Conda Environment
conda deactivate

# Index the reference genome sequence
samtools faidx "${genome_fasta}"

# Activate Purge Haplotigs Conda Environment
conda activate "${purge_haplotigs_environment}"

### Test ###
# purge_haplotigs test

# Step 1: Generate read-depth histograms
purge_haplotigs readhist -b aligned_ONT.bam -g "${genome_fasta}" -threads 30  # for long reads
purge_haplotigs readhist -b aligned_illumina.bam -g "${genome_fasta}" -threads 30  # for short reads

# Choose read-depth cutoffs for low, midpoint, and high read depth

# Step 2: Flag 'suspect' and 'junk' contigs
purge_haplotigs contigcov -i aligned_ONT.bam.gencov -l 5 -m 30 -h 140  # for long reads
purge_haplotigs contigcov -i aligned_illumina.bam.gencov -l 1 -m 3 -h 55  # for short reads

# Step 3: Identify and remove haplotigs
purge_haplotigs purge -g "${genome_fasta}" -c coverage_stats.csv -a 70 -d -b aligned_ONT.bam -threads 30
purge_haplotigs purge -g "${genome_fasta}" -c coverage_stats.csv -a 60 -d -b aligned_illumina.bam -threads 30
purge_haplotigs purge -g cns_p_ctg.fasta -c coverage_stats.csv -a 60

# Deactivate Purge Haplotigs Conda Environment
conda deactivate
