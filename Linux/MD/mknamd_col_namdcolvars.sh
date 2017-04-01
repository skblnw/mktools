#!/bin/bash

if [ $# -eq 0 ]; then
    echo "make_XXX <fs per frame> </path/to/colvars/traj/NPT-{1..N}.colvars.traj> > col-#.dat"
    echo "fs per frame: 40"
    exit 1
fi

FSPF="$1"

if ! [[ $FSPF =~ ^-?[0-9]+$ ]]; then
    echo "Must be an integer"
    exit 1
fi

grep -v "^#" ${@:2} | awk '{print NR*'${FSPF}'/1000000"\t"$3}'
