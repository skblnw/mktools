#!/bin/bash

OLD_NAME=$1
NEW_NAME=$2

for ii in ${OLD_NAME}.*; do
    mv -i "${ii}" "${ii/$OLD_NAME/$NEW_NAME}"
done
