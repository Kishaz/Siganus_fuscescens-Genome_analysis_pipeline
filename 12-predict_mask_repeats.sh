# Set the path to the working directory
WORK_DIR="/path/to/your/working/directory"

# Download dfam-tetools.sh wrapper script
curl -sSLO https://github.com/Dfam-consortium/TETools/raw/master/dfam-tetools.sh
chmod +x dfam-tetools.sh
./dfam-tetools.sh

# Create a RepeatModeler database
BuildDatabase -name YOUR_SPECIES_NAME /path/to/your/genome.fasta
RepeatModeler -database YOUR_SPECIES_NAME -threads 30 -LTRStruct -engine ncbi

# Run RepeatMasker
RepeatMasker -species YOUR_SPECIES_NAME -lib /path/to/Dfam_curatedonly.h5 -lib /path/to/JG2022-families.fa -s /path/to/your/genome.fasta -threads 30

# Run runcoseg.pl
runcoseg.pl -d -m 50 -c ALU.cons -s ALU.seqs -i ALU.ins

# Interpret RepeatModeler results
# ... (Your interpretation code here)

# Organize the reads by adding the species name
cat JG2022_S.fuscescens-families.fa | seqkit fx2tab | awk '{ print "YOUR_SPECIES_"$0 }' | seqkit tab2fx > YOUR_SPECIES-families.neat.fa

# Split the library into known and unknown elements
cat YOUR_SPECIES-families.neat.fa | seqkit fx2tab | grep -v "Unknown" | seqkit tab2fx > YOUR_SPECIES-families.neat.fa.known
cat YOUR_SPECIES-families.neat.fa | seqkit fx2tab | grep "Unknown" | seqkit tab2fx > YOUR_SPECIES-families.neat.fa.unknown

# Quantify the number of classified and unknown elements
echo "Number of known elements: $(grep -c ">" YOUR_SPECIES-families.neat.fa.known)"
echo "Number of unknown elements: $(grep -c ">" YOUR_SPECIES-families.neat.fa.unknown)"

# Download the latest Dfam database
wget https://dfam.org/releases/Dfam_3.7/families/Dfam_curatedonly.h5.gz
gzip -d Dfam_curatedonly.h5.gz

# Soft mask the assembly using RepeatMasker
conda activate RepeatMasker-4.1.5

# Round 1: Custom database
RepeatMasker -lib YOUR_SPECIES-families.fa -xsmall -poly -gff /path/to/your/genome.fasta -pa 30

# Round 2: Dfam database
RepeatMasker -species "Teleost fish" -xsmall -poly -gff /path/to/Teleost-input.fasta.masked -pa 30

# Downloaded Dfam database - treated as custom
RepeatMasker -lib /path/to/Dfam_curatedonly.h5 -xsmall -poly -gff /path/to/your/genome.fasta -pa 30

# Combined - treated as custom
RepeatMasker -lib /path/to/Dfam_curatedonly.h5 -lib YOUR_SPECIES-families.fa -xsmall /path/to/your/genome.fasta -poly -gff -pa 30

# Post-analysis
# Set the path to the working directory
WORK_DIR="/path/to/your/working/directory"

# Create a directory for full results
mkdir -p "${WORK_DIR}/masked_full_out"

# Combine full RepeatMasker result files - .cat.gz
cat "${WORK_DIR}/repeatmodeler/masking/iterative-masking-v3.7/species-specific/curated.fasta.cat.gz" \
    "${WORK_DIR}/repeatmodeler/masking/iterative-masking-v3.7/teleost-dfam3.7/curated.fasta-SF-TE.masked.cat.gz" \
    > "${WORK_DIR}/masked_full_out/curated.fasta.full_mask.cat.gz"

# Combine RepeatMasker tabular files for all repeats - .out
cat "${WORK_DIR}/repeatmodeler/masking/iterative-masking-v3.7/species-specific/curated.fasta.out" \
    "${WORK_DIR}/repeatmodeler/masking/iterative-masking-v3.7/teleost-dfam3.7/curated.fasta-SF-TE.masked.out" | tail -n +4 \
    > "${WORK_DIR}/masked_full_out/curated.fasta.full_mask.out"

# Copy RepeatMasker tabular files for simple repeats - .out
cat "${WORK_DIR}/01_simple_out/reference-genome.simple_mask.out" > "${WORK_DIR}/masked_full_out/reference-genome.simple_mask.out"

# Combine RepeatMasker tabular files for complex, interspersed repeats - .out
cat "${WORK_DIR}/repeatmodeler/masking/iterative-masking-v3.7/species-specific/curated.fasta.tbl" \
    "${WORK_DIR}/repeatmodeler/masking/iterative-masking-v3.7/teleost-dfam3.7/curated.fasta-SF-TE.masked.tbl" | tail -n +4 \
    > "${WORK_DIR}/masked_full_out/curated.fasta.TE_mask.tbl"