# directory into which the results are written.
#DATA=.
#DATA=data # default

# ------------------------------------------------------------------------

GENOMES=FIXME # path to directory full of STRAIN1.faa, STRAIN2,faa, ...

# ------------------------------------------------------------------------

# Must select one:
# PHYLOPHLAN_DIVERSITY=low    # for species- and strain-level phylogenies
# PHYLOPHLAN_DIVERSITY=medium # for genus- and family-level phylogenies
# PHYLOPHLAN_DIVERSITY=high   # for tree-of-life and higher-ranked taxonomic levels phylogenies

PHYLOPHLAN_DB=phylophlan
#PHYLOPHLAN_DB=amphora2

PHYLOPHLAN_CONFIGS=
PHYLOPHLAN_CONFIGS+=" supermatrix_aa.cfg"
#PHYLOPHLAN_CONFIGS+=" supermatrix_nt.cfg" ## phylophlan and amphora2 are only aa
#PHYLOPHLAN_CONFIGS+=" supertree_aa.cfg" ## requires astral?
#PHYLOPHLAN_CONFIGS+=" supertree_nt.cfg" ## phylophlan and amphora2 are only aa

#PHYLOPHLAN_FORCE_NT=yes

# ------------------------------------------------------------------------

# # Uncomment to get packages from HOWTO
# PACKAGES_FROM=howto

# uncomment to use conda
PACKAGES_FROM=conda
CONDA_ENV=pipeline-phylophlan

#THREADS=$(nproc --all)

# ------------------------------------------------------------------------
