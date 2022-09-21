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
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'

