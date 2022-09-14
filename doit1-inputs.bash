#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------
# Making local copy of genomes
# ------------------------------------------------------------------------

echo 1>&2 '# Making local copy of genomes'

rm -rf ${DATA}/inputs_*
mkdir -p ${DATA}/inputs_aa ${DATA}/inputs_nt
cp --archive ${GENOMES}/*.faa ${DATA}/inputs_aa
cp --archive ${GENOMES}/*.fna ${DATA}/inputs_nt


# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'

