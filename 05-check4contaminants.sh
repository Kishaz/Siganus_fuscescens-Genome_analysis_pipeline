#!/bin/bash

# Replace [genome_analysis_path], [data_path], [output_file], [taxonomy_output], [library_output], and [index_name] with actual paths and file names
genome_analysis_path="/your/genome/analysis/path"
data_path="/your/data/path"
output_file="${genome_analysis_path}/centrifuge-output_file"
taxonomy_output="${genome_analysis_path}/taxonomy"
library_output="${genome_analysis_path}/library"
index_name="abv"

# Activate Conda Environment
conda activate centrifuge

# Building index on all complete bacterial, viral, fungal, archaea, and human genomes

## Download NCBI taxonomy
centrifuge-download -o "${taxonomy_output}" taxonomy

## Download bacterial, archaeal, and fungal genomes
centrifuge-download -P 30 -o "${library_output}" -m -d "bacteria,archaea,fungi" refseq > "${genome_analysis_path}/seqid2taxid.map"

## Download viral genomes
centrifuge-download -P 30 -o "${library_output}" -m -d "viral" refseq > "${genome_analysis_path}/seqid2taxid.map"

## Download vertebrate mammalian genomes
centrifuge-download -P 30 -o "${library_output}" -d "vertebrate_mammalian" -a "Chromosome" -t 9606 refseq >> "${genome_analysis_path}/seqid2taxid.map"

# Concatenate downloaded sequences for building the index

## Concatenate bacterial sequences
cd "${library_output}/bacteria"
cat *.fna > "${genome_analysis_path}/input-sequences_bacteria.fna"

## Concatenate vertebrate mammalian sequences
cd "${library_output}/vertebrate_mammalian"
cat *.fna > "${genome_analysis_path}/input-sequences_mammalia.fna"

## Concatenate fungal sequences
cd "${library_output}/fungi"
cat *.fna > "${genome_analysis_path}/input-sequences_fungi.fna"

## Concatenate all sequences
cat "${genome_analysis_path}/input-sequences_bacteria.fna" \
    "${genome_analysis_path}/input-sequences_mammalia.fna" \
    "${genome_analysis_path}/input-sequences_fungi.fna" > "${genome_analysis_path}/input-sequences.fna"

# Build centrifuge index with 30 threads
centrifuge-build -p 30 --conversion-table "${genome_analysis_path}/seqid2taxid.map" \
                 --taxonomy-tree "${taxonomy_output}/nodes.dmp" \
                 --name-table "${taxonomy_output}/names.dmp" \
                 "${genome_analysis_path}/input-sequences.fna" "${index_name}"

# Run centrifuge
centrifuge -p 30 -x "${index_name}" -U "${data_path}/your_input_fastq_file.fastq" -S "${output_file}"

# Deactivate Conda Environment
conda deactivate
