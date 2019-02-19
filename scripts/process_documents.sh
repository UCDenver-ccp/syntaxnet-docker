#!/bin/bash

/opt/tensorflow/syntaxnet/syntaxnet/demo_first_only.sh
/opt/tensorflow/syntaxnet/syntaxnet/demo_second_only.sh

# clean up - remove intermediate files, rename and compress output files
for file in /syntaxnet-input/*.out.out.conll; do
    mv "$file" "${file%.out.out.conll}.conll"
done

rm /syntaxnet-input/*.out.conll

gzip -f /syntaxnet-input/*.conll
