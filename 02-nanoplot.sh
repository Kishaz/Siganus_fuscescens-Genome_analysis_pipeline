#!/bin/bash

# Replace [path_to_data] and [file_name] with the actual path and file name
data_dir="[path_to_data]"
file_name="[file_name]"

# Activate Conda Environment
conda activate nanoplot

# Run NanoPlot
NanoPlot -t 35 --fastq "${data_dir}/${file_name}" -o "${data_dir}/nanoplot" --plots dot --legacy hex -f pdf --N50 --dpi 400

# Deactivate Conda Environment
conda deactivate
