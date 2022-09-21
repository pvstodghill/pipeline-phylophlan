#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

if [ "$PHYLOPHLAN_FORCE_NT" ] ; then
    FORCE_NT=--force_nucleotides
fi

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

