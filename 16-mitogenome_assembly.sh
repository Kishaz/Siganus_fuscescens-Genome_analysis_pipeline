# Download MitoZ container
docker pull guanliangmeng/mitoz:3.4

# Set your working directory
WORKING_DIRECTORY="/your/working/directory/"

# Run container and display MitoZ help
docker run -v "${WORKING_DIRECTORY}:${WORKING_DIRECTORY}" -w "${WORKING_DIRECTORY}" --rm guanliangmeng/mitoz:3.4 mitoz -h
docker run -v "${WORKING_DIRECTORY}:${WORKING_DIRECTORY}" -w "${WORKING_DIRECTORY}" --rm guanliangmeng/mitoz:3.4 mitoz-tools -h

# Shell into the container
docker run -v "${WORKING_DIRECTORY}:${WORKING_DIRECTORY}" -w "${WORKING_DIRECTORY}" --rm -it guanliangmeng/mitoz:3.4 

# In the container, you can then run MitoZ or MitoZ tools
# Example: Run MitoZ command
docker run -v "${WORKING_DIRECTORY}:${WORKING_DIRECTORY}" -w "${WORKING_DIRECTORY}" --rm guanliangmeng/mitoz:3.4 mitoz all \
--outprefix SF-TUMSAT-2022 \
--thread_number 30 \
--clade Chordata \
--genetic_code 2 \
--species_name "Siganus fuscescens" \
--fq1 Sfus1_1.fastq.gz \
--fq2 Sfus1_2.fastq.gz \
--fastq_read_length 151 \
--data_size_for_mt_assembly 0.3 \
--assembler megahit \
--kmers_megahit 59 79 99 119 141 \
--memory 100 \
--requiring_taxa Siganus
