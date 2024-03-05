# Genome Analysis Pipeline

This repository contains scripts for various steps in the genome analysis pipeline used for the de novo assembly and annotation of the Siganus fuscescens whole genome.
Raw data can be accessed through the DDBJ Reads Archive under BioProject- PRJDB15411. 

## Scripts

### 00-reads_quality_check.sh
- **Description:** Script for checking the quality of reads.
- **Usage:** `./00-reads_quality_check.sh`

### 01-filtering-trimming-Illumina_reads.sh
- **Description:** Script for filtering and trimming Illumina reads.
- **Usage:** `./01-filtering-trimming-Illumina_reads.sh`

### 02-nanoplot.sh
- **Description:** Script for generating Nanopore read plots.
- **Usage:** `./02-nanoplot.sh`

### 03-trimming-Nanopore_reads.sh
- **Description:** Script for trimming Nanopore reads.
- **Usage:** `./03-trimming-Nanopore_reads.sh`

### 04-filtering-Nanopore_reads.sh
- **Description:** Script for filtering Nanopore reads.
- **Usage:** `./04-filtering-Nanopore_reads.sh`

### 05-check4contaminants.sh
- **Description:** Script for checking contaminants.
- **Usage:** `./05-check4contaminants.sh`

### 06-genome_size_estimation.sh
- **Description:** Script for estimating genome size.
- **Usage:** `./06-genome_size_estimation.sh`

### 07-denovo_assembly.sh
- **Description:** Script for denovo assembly.
- **Usage:** `./07-denovo_assembly.sh`

### 08.0-assembly_stats.sh
- **Description:** Script for obtaining assembly statistics.
- **Usage:** `./08.0-assembly_stats.sh`

### 08.1-assembly_accuracy.sh
- **Description:** Script for evaluating assembly accuracy.
- **Usage:** `./08.1-assembly_accuracy.sh`

### 09-assembly_completeness.sh
- **Description:** Script for assessing assembly completeness.
- **Usage:** `./09-assembly_completeness.sh`

### 10-polish_assembly.sh
- **Description:** Script for polishing the assembly.
- **Usage:** `./10-polish_assembly.sh`

### 11-remove_haplotigs.sh
- **Description:** Script for removing haplotigs from the assembly.
- **Usage:** `./11-remove_haplotigs.sh`

### 12-predict_mask_repeats.sh
- **Description:** Script for predicting and masking repeats.
- **Usage:** `./12-predict_mask_repeats.sh`

### 13-gene prediction.sh
- **Description:** Script for gene prediction.
- **Usage:** `./13-gene_prediction.sh`

### 14-tRNA-scan.sh
- **Description:** Script for scanning tRNAs.
- **Usage:** `./14-tRNA-scan.sh`

### 15-orthofinder.sh
- **Description:** Script for running OrthoFinder.
- **Usage:** `./15-orthofinder.sh`

### 16-mitogenome_assembly.sh
- **Description:** Script for assembling the mitogenome.
- **Usage:** `./16-mitogenome_assembly.sh`


