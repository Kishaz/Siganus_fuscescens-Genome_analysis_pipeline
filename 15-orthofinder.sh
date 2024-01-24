# Activate the OrthoFinder environment
conda activate orthofinder

# Note: Before running the script, download protein coding genes from Ensembl or NCBI, and unzip them.
# Ensure the files are renamed using short simple names like C_chanos..

# Set the path to the directory containing protein coding genes
PROTEOMES_DIR="/path/to/your/proteomes_directory"

# Change to the directory containing protein coding genes
cd "${PROTEOMES_DIR}"

# Use a script provided with OrthoFinder to extract the longest transcript variant per gene
for file in *fa ; do
    python /path/to/orthofinder/tools/primary_transcript.py "${file}"
done

# Run OrthoFinder
orthofinder -f "${PROTEOMES_DIR}" -t 30
