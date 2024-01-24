#!/bin/bash

# Replace [path_to_data] with the actual path to your data directory
data_dir="[path_to_data]"

# Activate Conda Environment
conda activate fastqc

# Run FastQC on the input fastq file
fastqc "${data_dir}/input.fastq" -o "${data_dir}/fastqc_raw/" -t 30

# Deactivate Conda Environment
conda deactivate
