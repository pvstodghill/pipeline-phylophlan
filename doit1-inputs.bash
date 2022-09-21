#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------
# Making local copy of genomes
# ------------------------------------------------------------------------

echo 1>&2 '# Making local copy of genomes'

rm -rf ${DATA}/inputs_*
mkdir -p ${DATA}/inputs_aa ${DATA}/inputs_nt
if [ -z "$PHYLOPHLAN_FORCE_NT" ] ; then
    mkdir -p ${DATA}/inputs_aa
    cp --archive ${GENOMES}/*.faa ${DATA}/inputs_aa
else
    mkdir -p ${DATA}/inputs_nt
    cp --archive ${GENOMES}/*.fna ${DATA}/inputs_nt
fi

# ------------------------------------------------------------------------
# Copy USEARCH and ASTRAL
# ------------------------------------------------------------------------

if [ "$USEARCH_EXE_PATH" ] ; then
    echo 1>&2 "# Saving a copy of USEARCH"
    cp "$USEARCH_EXE_PATH" ${DATA}/usearch
    chmod +x ${DATA}/usearch
fi

if [ "$ASTRAL_ZIP_PATH" ] ; then
    echo 1>&2 "# Saving a copy of ASTRAL"
    unzip -q -d ${DATA} "$ASTRAL_ZIP_PATH"
    cp --archive ${DATA}/Astral/astral.*.jar ${DATA}/Astral/astral.jar
fi    

# ------------------------------------------------------------------------
# Creating config files
# ------------------------------------------------------------------------

if [ "$PHYLOPHLAN_FORCE_NT" ] ; then
    FORCE_NT=--force_nucleotides
fi

echo 1>&2 '# Creating config files'

(
    cd ${DATA}

    rm -f *.cfg
    (
	set -x


	# copied from https://github.com/biobakery/phylophlan/blob/master/phylophlan/phylophlan_write_default_configs.sh

	# # BROKEN: requires a nt database
	# # supermatrix_nt.cfg
	# phylophlan_write_config_file -o ./supermatrix_nt.cfg
	#     -d n
	#     --db_dna makeblastdb
	#     --map_dna blastn
	#     --msa mafft
	#     --trim trimal
	#     --tree1 fasttree
	#     --tree2 raxml
	#     --overwrite
	#     --verbose ${FORCE_NT}

	# # BROKEN: requires a nt database
	# # supertree_nt.cfg
	# phylophlan_write_config_file -o ./supertree_nt.cfg
	#     -d n
	#     --db_dna makeblastdb
	#     --map_dna blastn
	#     --msa mafft
	#     --trim trimal
	#     --gene_tree1 fasttree
	#     --gene_tree2 raxml
	#     --tree1 astral
	#     --overwrite
	#     --verbose ${FORCE_NT}

	if [ "$USEARCH_EXE_PATH" ] ; then
	    DB_AA=usearch
	    MAP_AA=usearch
	else
	    DB_AA=diamond
	    MAP_AA=diamond
	fi


	# supermatrix_aa.cfg
	phylophlan_write_config_file -o ./supermatrix_aa.cfg \
				     -d a \
				     --db_aa ${DB_AA} \
				     --map_aa ${MAP_AA} \
				     --msa mafft \
				     --trim trimal \
				     --tree1 fasttree \
				     --tree2 raxml \
				     --overwrite \
				     --verbose ${FORCE_NT}

	# supertree_aa.cfg
	phylophlan_write_config_file -o ./supertree_aa.cfg \
				     -d a \
				     --db_aa ${DB_AA} \
				     --map_aa ${MAP_AA} \
				     --msa mafft \
				     --trim trimal \
				     --gene_tree1 fasttree \
				     --gene_tree2 raxml \
				     --tree1 astral \
				     --overwrite \
				     --verbose ${FORCE_NT}

	# ( (
    )
)

sed -i -e 's|program_name = usearch|program_name = ./usearch|' ${DATA}/*.cfg
sed -i -e 's|astral[.-]4\.11\.1|astral|g' ${DATA}/*.cfg
sed -i -e 's|astral/|Astral/|g' ${DATA}/*.cfg

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'

