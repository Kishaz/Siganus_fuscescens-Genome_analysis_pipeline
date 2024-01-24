#!/bin/bash

# Replace [path_to_data] and [input_file] with the actual path and file name
data_dir="[path_to_data]"
input_file="[input_file]"

# Activate Conda Environment
conda activate porechop-abi

# Run porechop-abi
porechop_abi -abi --threads 30 -i "${data_dir}/${input_file}" -o "${data_dir}/porechoped.fastq"

# Deactivate Conda Environment
conda deactivate
