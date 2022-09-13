#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------
# Making local copy of genomes
# ------------------------------------------------------------------------

echo 1>&2 '# Making local copy of genomes'

rm -rf ${DATA}/inputs
mkdir -p ${DATA}/inputs
cp --archive ${GENOMES}/*.faa ${DATA}/inputs


# ------------------------------------------------------------------------
# Creating config files
# ------------------------------------------------------------------------

echo 1>&2 '# Creating config files'

cd ${DATA}

phylophlan_write_default_configs.sh

# ------------------------------------------------------------------------
# Running Phylophan
# ------------------------------------------------------------------------

echo 1>&2 '# Running Phylophan'

rm -rf outputs

phylophlan -i inputs -t a \
	   -o outputs \
	   -d phylophlan --databases_folder db_files \
	   --diversity ${PHYLOPHAN_DIVERSITY} \
	   -f supermatrix_aa.cfg \
	   --nproc ${THREADS}

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'

