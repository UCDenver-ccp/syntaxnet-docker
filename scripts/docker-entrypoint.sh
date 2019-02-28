#!/bin/bash

function print_usage {
    echo "Usage:"
    echo "$(basename $0) [OPTIONS]"
    echo "  [-m <model-indicator>]: Optional argument. If left blank, the default SyntaxNet model is used. If 'craft', a model trained on the CRAFT corpus is used."
}

while getopts "m:h" OPTION; do
    case ${OPTION} in
        # An indicator for the model to use
        m) MODEL=$OPTARG
           ;;
        # HELP!
        h) print_usage; exit 0
           ;;
    esac
done

# if model isn't set, use the default
if [[ -z ${MODEL} ]]; then
    MODEL="default"
fi

/opt/tensorflow/syntaxnet/syntaxnet/demo_first_only.sh -m ${MODEL}
/opt/tensorflow/syntaxnet/syntaxnet/demo_second_only.sh -m ${MODEL}

# clean up - remove intermediate files, rename and compress output files
for file in /syntaxnet-input/*.out.out.conll; do
    mv "$file" "${file%.out.out.conll}.conll"
done

rm /syntaxnet-input/*.out.conll

gzip -f /syntaxnet-input/*.conll
