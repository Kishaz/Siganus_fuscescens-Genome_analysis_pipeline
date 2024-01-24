#!/bin/bash

# Replace [working_directory], [protein_database_url], [genome_file], [output_directory], and [output_species] with actual values
working_directory="/path/to/your/gene_prediction"
protein_database_url="https://bioinf.uni-greifswald.de/bioinf/partitioned_odb11/Vertebrata.fa.gz"
genome_file="/path/to/your/genome/Teleost-rnd2.fasta.masked.masked"
output_directory="/path/to/your/output_directory"
output_species="Danio_rerio"

# Create a directory for gene prediction
mkdir "${working_directory}"
cd "${working_directory}"

# Download the Vertebrata protein sequences
wget "${protein_database_url}"
gzip -d Vertebrata.fa.gz

# Run Docker container shell
docker run --user 1000:100 --rm -it -v "${working_directory}:${working_directory}" teambraker/braker3:latest bash

# Move to the working directory within the container
cd "${working_directory}"

# Run BRAKER with specified parameters
braker.pl --genome="${genome_file}" --prot_seq=Vertebrata.fa --species="${output_species}" --threads=30 --gff3 --softmasking

# Move generated files to the desired output directory
mv *.bam *.bam.bai *.gb *.gff *.log *.stderr *.fasta "${output_directory}"
