#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <fuzzer name> [additional arguments]"
    exit
fi
fuzzer_name=$1
corpus_directory=`realpath corpora/$fuzzer_name`
if [ ! -d $corpus_directory ]; then
    echo "Error: $corpus_directory does not exist"
    exit
fi
shift
docker run -v $corpus_directory:/root/work/corpus -i -t dcrd-fuzzers /root/work/fuzzer-$fuzzer_name -custom_guided=1 -use_value_profile=1 /root/work/corpus "$@"
