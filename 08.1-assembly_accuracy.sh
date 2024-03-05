#!/bin/bash

# Activate Inspector environment
conda activate inspector # v1.2

# Run Inspector
inspector.py -c /path/to/your/assembly.fasta \
             -r /path/to/your/nano_reads.fastq \
             -o /path/to/your/output_directory/ \
             --datatype nanopore

# Deactivate Conda environment
conda deactivate
