#!/bin/bash

if [ $# -eq 0 ]; then
    echo "make_XXX <fs per frame> <col#> </path/to/log/NPT-{1..N}.log> > col-#.dat"
    echo "fs per frame: 1000"
    echo "ENERGY:12 TEMP:13 PRESSURE:17 BOX:19"
    exit 1
fi

FSPF="$1"
col="$2"

if ! [[ $FSPF =~ ^-?[0-9]+$ ]]; then
    echo "Must be an integer"
    exit 1
fi

grep "^ENERGY" ${@:3} | awk '{print NR*'${FSPF}'/1000000"\t"$'${col}'}'
