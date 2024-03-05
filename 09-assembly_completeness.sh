#!/bin/bash

# Replace [busco_environment], [input_fasta], [output_directory], and [busco_lineage] with actual values
busco_environment="busco5.4.3"
input_fasta="/path/to/your/assembly.fasta"
output_directory="/path/to/your/busco_output"
busco_lineage="actinopterygii_odb10"
cpu_threads=30

# Activate Conda Environment
conda activate "${busco_environment}"

# Run BUSCO analysis
busco -m geno -i "${input_fasta}" -o "${output_directory}" -l "${busco_lineage}" -c "${cpu_threads}"

# Deactivate Conda Environment
conda deactivate

# Plot BUSCO results
python3 /path/to/your/busco/bin/generate_plot.py --working_directory /path/to/your/busco_summaries
