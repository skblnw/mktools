#!/bin/bash

if [ $# -eq 0 ]; then
    echo "make_XXX <prefix>"
    exit 1
fi

PREFIX=$1

FIRST=`ls -v ${PREFIX}-*.log | head -1 | awk -F '-' '{print $2}' | sed -n -e 's/.log//p'`
LAST=`ls -v ${PREFIX}-*.log | tail -1 | awk -F '-' '{print $2}' | sed -n -e 's/.log//p'`
echo -e "Info: Start from $FIRST to $LAST"

> info_dcdfreq.dat
for ((ii=$FIRST; $ii<=$LAST; ii++)); do
    FREQ=`grep -i 'dcd freq' ${PREFIX}-$ii.log | awk '{print $4}'`
    if [ ! -z "$FREQ" ]; then
        echo -e "${ii}\t${FREQ}" >> info_dcdfreq.dat
    else
        echo -e "${ii}\tNOT FOUND" >> info_dcdfreq.dat
    fi
done
