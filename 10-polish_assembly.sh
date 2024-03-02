#!/bin/bash

# Replace [your_paths_here] and [your_file_names_here] with your actual paths and file names
wkdir="path/to/Create a working directory"
genome_fasta="nd.asm.fasta.fasta"
short_reads1="sf_S4_L001_R1_001.fastq"
short_reads2="sf_S4_L001_R2_001.fastq"
#long_reads1="reads1.fq"
#long_reads2="reads2.fa.gz"
#hybrid_short_reads1="reads_R1_001.fastq"
#hybrid_short_reads2="reads_R2_001.fastq"
#hybrid_long_reads="JG2022-T_porechoped.fastq"

# Activate nextPolish Conda Environment
conda activate nextdenovo

# Run nextPolish for short reads only
cd "${wkdir}"
ls "${short_reads1}" "${short_reads2}" > sgs.fofn
nextPolish short_reads_polishing_config.cfg

# Run nextPolish for long reads only
#ls "${long_reads1}" "${long_reads2}" > lgs.fofn
#nextPolish run.cfg

# Run nextPolish for short and long reads
#ls "${hybrid_short_reads1}" "${hybrid_short_reads2}" > sgs.fofn
#ls "${hybrid_long_reads}" > lgs.fofn
#nextPolish run.cfg

# Deactivate nextPolish Conda Environment
conda deactivate
