#!/bin/bash

DATA_DIR=$1
SCRIPTS_DIR=/home/kevin/Dropbox/QWD/scripts/MD/NAMD/2.10/make-combo

if [ ! -n "$DATA_DIR" ]; then
    echo "make_MD-prepare <data directory>"
else
    rsync -avh $SCRIPTS_DIR/* $DATA_DIR/run/
    mkdir -p $DATA_DIR/run/output
fi
