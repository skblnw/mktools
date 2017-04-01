#!/bin/bash

if [ $# -eq 0 ]; then
    echo "make_XXX <col#> </path/to/log/NPT-{1..N}.log> > col-#.dat"
    exit 1
fi

#rm -f col-*.dat

prefix=`basename "${@: -1}" | awk -F '-' '{print $1}'`
prefix_lower=`echo "$prefix" | tr '[:upper:]' '[:lower:]'`
#FIRST=`echo $1 | sed -n -e 's/.*'$prefix'-//p' | sed -n -e 's/.dcd//p'`
#LAST=`echo "${@: -1}" | sed -n -e 's/.*'$prefix'-//p' | sed -n -e 's/.dcd//p'`

col="$1"
grep "^ENERGY" ${@:2} | awk {'print $'$col}

# Energy, Temperature
if false; then
for col in 12 13; do
    touch col-$col.dat
    if false; then
    for name in heat pre-npt cons-50 cons-30 cons-10 cons-5 cons-3 cons-1; do
        filename="../../$name.log"
        grep "^ENERGY" $filename | awk {'print $'$col} >> col-$col.dat
    done
    fi

    if false; then
    for name in {1..100}; do
        filename="../../NPT-$name.log"
        grep "^ENERGY" $filename | awk {'print $'$col} >> col-$col.dat
    done
    fi
done
fi

# Box Size
if false; then
for col in 19; do
    touch col-$col.dat
    if false; then
    for name in pre-npt; do
        filename="../../$name.log"
        grep "^ENERGY" $filename | awk {'print $'$col} >> col-$col.dat
    done
    fi

    if false; then
    for name in {1..100}; do
        filename="../../NPT-$name.log"
        grep "^ENERGY" $filename | awk {'print $'$col} >> col-$col.dat
    done
    fi
done
fi
