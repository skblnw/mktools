#!/bin/bash

DATA_DIR=$1
DROPBOX_DIR=$2

if [[ -n "$DATA_DIR" && -n "$DROPBOX_DIR" ]]; then
    cd $DATA_DIR
    rsync -av ionized.* $DROPBOX_DIR/
    cd $DATA_DIR/run
    rsync -av *.sh template-* *.log $DROPBOX_DIR/run

    prgrams="make_organize"
    for prog in $programs; do
        if ! type $prog; then
            echo "Command '$prog' does not exist."
            exit 1
        fi
    done

    if [ ! -d "$DATA_DIR/run/output-restart" ]; then
        cd $DATA_DIR
        echo -e "First, organize directory <$DATA_DIR>"
        make_organize $DATA_DIR
    fi

    rsync -av $DATA_DIR/run/output-restart $DROPBOX_DIR/run/
    rsync -av /home/kevin/Dropbox/QWD/scripts/Analysis/combine_dcd $DROPBOX_DIR/run/make_analysis/
else
    echo "<data directory> <dropbox directory>"
fi
