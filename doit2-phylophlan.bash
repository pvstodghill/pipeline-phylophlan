#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

if [ "$PHYLOPHLAN_FORCE_NT" ] ; then
    FORCE_NT=--force_nucleotides
fi

# ------------------------------------------------------------------------
# Creating config files
# ------------------------------------------------------------------------

echo 1>&2 '# Creating config files'

(
    cd ${DATA}

    rm -f *.cfg
    (
	set -x

	# copied from https://github.com/biobakery/phylophlan/blob/master/phylophlan/phylophlan_write_default_configs.sh

# # supermatrix_nt.cfg
# phylophlan_write_config_file -o ./supermatrix_nt.cfg \
#     -d n \
#     --db_dna makeblastdb \
#     --map_dna blastn \
#     --msa mafft \
#     --trim trimal \
#     --tree1 fasttree \
#     --tree2 raxml \
#     --overwrite \
#     --verbose ${FORCE_NT}

# # supertree_nt.cfg
# phylophlan_write_config_file -o ./supertree_nt.cfg \
#     -d n \
#     --db_dna makeblastdb \
#     --map_dna blastn \
#     --msa mafft \
#     --trim trimal \
#     --gene_tree1 fasttree \
#     --gene_tree2 raxml \
#     --tree1 astral \
#     --overwrite \
#     --verbose ${FORCE_NT}

# supermatrix_aa.cfg
phylophlan_write_config_file -o ./supermatrix_aa.cfg \
    -d a \
    --db_aa diamond \
    --map_dna diamond \
    --map_aa diamond \
    --msa mafft \
    --trim trimal \
    --tree1 fasttree \
    --tree2 raxml \
    --overwrite \
    --verbose ${FORCE_NT}

# supertree_aa.cfg
phylophlan_write_config_file -o ./supertree_aa.cfg \
    -d a \
    --db_aa diamond \
    --map_dna diamond \
    --map_aa diamond \
    --msa mafft \
    --trim trimal \
    --gene_tree1 fasttree \
    --gene_tree2 raxml \
    --tree1 astral \
    --overwrite \
    --verbose ${FORCE_NT}
    )
)

# ------------------------------------------------------------------------
# Running Phylophan
# ------------------------------------------------------------------------

echo 1>&2 '# Running Phylophan'

rm -rf ${DATA}/outputs_*

for CONFIG in ${PHYLOPHLAN_CONFIGS} ; do
    echo 1>&2 "## ${CONFIG}"

    if [ -e "${CONFIG}" ] ; then
	cp --force ${DATA}/"$(basename ${CONFIG})"
	CONFIG_FILE="$(basename ${CONFIG})"
    elif [ -e "${DATA}/${CONFIG}" ] ; then
	CONFIG_FILE="${CONFIG}"
    else
	echo 1>&2 "Cannot find: ${CONFIG}"
	exit 1
    fi
    CONFIG_NAME="$(basename "${CONFIG}" .cfg)"
    if [ -z "$PHYLOPHLAN_FORCE_NT" ] ; then
	INPUTS=inputs_aa
    else
	INPUTS=inputs_nt
    fi

    OUTPUTS=outputs_${CONFIG_NAME}

    (
	cd ${DATA}
	set -x
	phylophlan -i ${INPUTS} -t a \
		   -o ${OUTPUTS} \
		   -d "${PHYLOPHLAN_DB}" \
		    ${FORCE_NT} \
		   --databases_folder db_files \
		   --diversity "${PHYLOPHLAN_DIVERSITY}" \
		   -f ${CONFIG_FILE} \
		   --nproc ${THREADS}
    )

done

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'

