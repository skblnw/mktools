#!/bin/bash

DATA_DIR=$1
DROPBOX_DIR=/home/kevin/Dropbox/QWD/

if [[ -n "$DATA_DIR" ]]; then
    rsync -av $DROPBOX_DIR/force-field/charmm36/toppar* $DATA_DIR
    rsync -av $DROPBOX_DIR/scripts/MD/NAMD/2.10/make-combo/ $DATA_DIR/run/
else
    echo "<data directory> <Titan directory>"
fi
