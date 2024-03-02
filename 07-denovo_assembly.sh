#!/bin/bash

# Replace /your/full/path and your_input_file.fastq with your actual paths and file names
wkdir="/your/full/path/to/working directory"
input_fastq="your_input_file.fastq"

# Activate nextDenovo Conda Environment
conda activate nextdenovo

# Creating input file
cd "${wkdir}"
ls "${input_fastq}" > input.fofn

# Run nextDenovo in the working directory
nextDenovo assembly_config.cfg

# Deactivate nextDenovo Conda Environment
conda deactivate

