#!/bin/bash

if [ $# -eq 0 ]; then
    echo "make_XXX <WIN_col>"
    exit 1
fi

mkdir -p col

while read line; do
a=( $line )
endj=${a[0]}
for window in ${a[@]:1}; do
    echo "Window: $window End: $endj"
    eval mknamd_col_namdcolvars 40 output/us-z$window-{1..$endj}.colvars.traj > col/us-z$window-colvars.dat
    echo "Info: Colvars done"
    eval mknamd_col_namdlog 2000 12 log/us-z$window-{1..$endj}.log > col/us-z$window-ener.dat
    echo "Info: Energy done"
    eval mknamd_col_namdlog 2000 13 log/us-z$window-{1..$endj}.log > col/us-z$window-temp.dat
    echo "Info: Temperature done"
    eval mknamd_col_namdlog 2000 19 log/us-z$window-{1..$endj}.log > col/us-z$window-box.dat
    echo "Info: Box-size done"
done
done < $1
