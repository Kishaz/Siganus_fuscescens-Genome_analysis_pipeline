#!/bin/bash

# Replace [nanofilt_environment], [input_fastq], and [output_fastq] with actual values
nanofilt_environment="nanofilt"
input_fastq="/path/to/your/porechop/porechopped.fastq"
output_fastq="/path/to/your/nanofilt_output/nanofilt_trimmed.fastq"

# Activate Conda Environment
conda activate "${nanofilt_environment}"

# Run NanoFilt with length threshold 5000 and headcrop 10
NanoFilt -l 5000 --headcrop 10 < "${input_fastq}" > "${output_fastq}_len5000.fastq"

# Run NanoFilt with length threshold 10000 and headcrop 10
# Note: This command overwrites the previous output, update accordingly if separate files are needed
NanoFilt -l 10000 --headcrop 10 < "${input_fastq}" > "${output_fastq}_len10000.fastq"

# Deactivate Conda Environment
conda deactivate
