#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

if [ "$PHYLOPHLAN_FORCE_NT" ] ; then
    FORCE_NT=--force_nucletides
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
	phylophlan_write_default_configs.sh ${FORCE_NT}
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
    case "${CONFIG_NAME}" in
	*_aa)
	    INPUTS=inputs_aa
	    TYPE=a
	    ;;
	*_nt)
	    INPUTS=inputs_nt
	    TYPE=n
	    ;;
	*)
	    echo 1>&2 "Cannot determine type: ${CONFIG_NAME}"
	    exit 1
    esac

    OUTPUTS=outputs_${CONFIG_NAME}

    (
	cd ${DATA}
	set -x
	phylophlan -i ${INPUTS} -t ${TYPE} \
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

