#!/bin/bash

DATA_DIR=$1
TITAN_DIR=$2

if [[ -n "$DATA_DIR" && -n "titan:$TITAN_DIR" ]]; then

    if [ ! -d "$DATA_DIR" ]; then
        echo "Target directory $DATA_DIR does not exist."
        exit 1
    fi
    
    prgrams="make_organize"
    for prog in $programs; do
        if ! type $prog; then
            echo "Command '$prog' does not exist."
            exit 1
        fi
    done

    cd $DATA_DIR
    if [ ! -d "$DATA_DIR/run/output-restart" ]; then
        echo -e "First, organize directory <$DATA_DIR>"
        make_organize $DATA_DIR
    fi

    LAST=`ls -v $DATA_DIR/run/output-restart/ | awk -F "." '{print $1}' | sort -u | tail -1 | sed -n -e 's/.*NPT-//p'`
    if [ $LAST -eq 1 ]; then
        echo -e "Copying strctures to Titan..."
        rsync -av ionized.* toppar* titan:$TITAN_DIR/
        echo -e "Copying MD parameters to Titan..."
        rsync -av /home/kevin/Dropbox/QWD/scripts/MD/NAMD/2.10/make-titan/ titan:$TITAN_DIR/run/
        echo -e "Copying restart files to Titan..."
        rsync -av $DATA_DIR/run/output-restart/*.restart.* titan:$TITAN_DIR/run/output/
    else
        echo -e "The largest number in restart files is $LAST, which is larger than 1"
        echo -e "Copying only restart files to Titan..."
        rsync -av $DATA_DIR/run/output-restart/*.restart.* titan:$TITAN_DIR/run/output/
    fi

    echo -e "Done with no effort! Check carefully if there's any error message."
else
    echo "rsync_data2titan <data directory> <Titan directory>"
    exit 0
fi
