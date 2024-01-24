#!/bin/bash

# Replace [quast_environment], [output_directory], and [input_fasta] with actual values
quast_environment="quast5.2"
output_directory="/path/to/your/quast_output/quast_flye_5000_2iter"
input_fasta="/path/to/your/flye_5000_2iter/assembly.fasta"

# Activate Conda Environment
conda activate "${quast_environment}"

# Run QUAST for genome assembly evaluation
quast.py --output-dir "${output_directory}" -m 0 "${input_fasta}"

# Deactivate Conda Environment
conda deactivate

