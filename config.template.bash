# directory into which the results are written.
#DATA=.
#DATA=data # default

# ------------------------------------------------------------------------

GENOMES=FIXME # path to directory full of STRAIN1.faa, STRAIN2,faa, ...

# ------------------------------------------------------------------------

# Must select one:
# PHYLOPHAN_DIVERSITY=low    # for species- and strain-level phylogenies
# PHYLOPHAN_DIVERSITY=medium # for genus- and family-level phylogenies
# PHYLOPHAN_DIVERSITY=high   # for tree-of-life and higher-ranked taxonomic levels phylogenies

# ------------------------------------------------------------------------


# # Uncomment to get packages from HOWTO
# PACKAGES_FROM=howto

# uncomment to use conda
PACKAGES_FROM=conda
CONDA_ENV=pipeline-phylophlan

#THREADS=$(nproc --all)

# ------------------------------------------------------------------------
