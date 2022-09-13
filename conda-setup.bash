#! /bin/bash

set -e

CONDA_PREFIX=$(dirname $(dirname $(type -p conda)))
. "${CONDA_PREFIX}/etc/profile.d/conda.sh"

PACKAGES=

PACKAGES+=" muscle=3.8.1551"
PACKAGES+=" phylophlan"

set -x

conda env remove -y --name pipeline-phylophlan
conda create -y --name pipeline-phylophlan
conda activate pipeline-phylophlan

conda install -y ${PACKAGES}
