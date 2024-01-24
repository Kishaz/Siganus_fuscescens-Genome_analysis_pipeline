#!/bin/bash

# Activate Conda Environment
conda activate fastp-0.23.2

# Execute Fastp for Quality Control
fastp \
  --in1=<input_read1.fq> \
  --out1=<cleaned_read1.fq> \
  --in2=<input_read2.fq> \
  --out2=<cleaned_read2.fq> \
  --detect_adapter_for_pe \
  --html=fastp_out/Illumina_fastP_QC_Report.html \
  --thread=16

# Deactivate Conda Environment
conda deactivate
