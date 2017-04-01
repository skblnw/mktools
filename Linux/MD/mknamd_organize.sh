#!/bin/bash

DATA_DIR=$1

if [ ! -n $DATA_DIR ]; then
    DIR=$DATA_DIR
else
    DIR=`pwd`
    read -p "make_organize $DIR, you sure? [y]" -n 1 -r
    echo 
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

if [ ! -d "$DIR/output" ]; then
    echo "Directory $DIR/output does not exist"
    exit 1
fi

LAST=`ls -v $DIR/output/NPT-*.dcd | tail -1 | sed -n -e 's/.*NPT-//p' | sed -n -e 's/.dcd//p'`
if [ $LAST -gt 1 ]; then
    echo -e "The largest index for DCD files is $LAST"
    cd $DIR
    mkdir -p output-dcd output-restart
    rsync -av output/NPT-$LAST.restart.* output-restart/

    mv output/*.dcd output-dcd
    wait

    echo -e "There are some 'old' and 'BAK' files, of size: `find output/ -type f \( -name "*.old" -o -name "*.BAK" \) -print0 | du --files0-from=- -ch | tail -1`"
    echo -e "Done with no effort! Check carefully if there's any error message."
else
    cd $DIR
    rsync -av output/NPT-1.restart.* output-restart/
    echo -e "The largest index for DCD files is $LAST, which is smaller than 2. Exit"
    exit 0
fi
