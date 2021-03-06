#!/bin/bash

export PASH_TOP=${PASH_TOP:-${BASH_SOURCE%/*}}
export PASH_PARSER=${PASH_TOP}/parser/parse_to_json.native
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib/"

if ! command -v python3 &> /dev/null
then
    echo "Python >=3 could not be found"
    exit
fi

PASH_FROM_SH="pa.sh" python3 $PASH_TOP/compiler/pash.py "$@"
