#!/bin/bash

# Replace [path_to_data] and [file_prefix] with the actual path and file prefix
data_dir="[path_to_data]"
file_prefix="[file_prefix]"

# Activate Conda Environment
conda activate jellyfish

# Count all k-mers
jellyfish count -C -m 21 -s 100M -t 20 "${data_dir}/${file_prefix}.fastq"

# Compute the histogram of the k-mer occurrences
jellyfish histo -t 20 "${data_dir}/mer_counts.jf" > "${data_dir}/reads.histo"

# Load reads.histo into GenomeScope
# Note: This step requires manual interaction with the GenomeScope web interface.
# Please visit http://qb.cshl.edu/genomescope/ and follow the provided instructions.
# Use the following parameters during the GenomeScope analysis:
# -Description: ${file_prefix}
# -k-mer: 21
# -Read length: 1000
# -Max coverage: -1 (no filter)
# Deactivate Conda Environment

conda deactivate
