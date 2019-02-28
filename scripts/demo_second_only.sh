#!/bin/bash
# Copyright 2016 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

# A script that runs a tokenizer, a part-of-speech tagger and a dependency
# parser on an English text file, with one sentence per line.
#
# Example usage:
#  echo "Parsey McParseface is my favorite parser!" | syntaxnet/demo.sh

# To run on a conll formatted file, add the --conll command line argument.
#

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

# assume default model if not specified
if [[ -z ${MODEL} ]]; then
    MODEL="default"
fi

echo "------ SyntaxNet using ${MODEL} model. ------"

if [ ${MODEL} = "default" ]; then
    MODEL_DIR="syntaxnet/models/parsey_mcparseface"
    HIDDEN_LAYER_SIZES="512,512"
    ARG_PREFIX="brain_parser"
    GRAPH_BUILDER="structured"
    TASK_CONTEXT="${MODEL_DIR}/context.pbtxt"
    MODEL_PATH="${MODEL_DIR}/parser-params"
elif [ ${MODEL} = "craft" ]; then
    MODEL_DIR="/opt/tensorflow/syntaxnet/syntaxnet/models/brain_parser/structured/200x200-0.02-100-0.9-0"
    HIDDEN_LAYER_SIZES="200,200"
    ARG_PREFIX="brain_parser"
    GRAPH_BUILDER="structured"
    TASK_CONTEXT="${MODEL_DIR}/context2"
    MODEL_PATH="${MODEL_DIR}/model"
else
    echo "Parameters for specified model (${MODEL}) not available. Valid models are 'default' and 'craft'. Exiting..."
    exit 1
fi

PARSER_EVAL=bazel-bin/syntaxnet/parser_eval

[[ "$1" == "--conll" ]] && INPUT_FORMAT=stdin-conll || INPUT_FORMAT=stdin
OUTPUT_FORMAT=stdout-conll

  $PARSER_EVAL \
  --input=craft-parser-in \
  --output=craft-parser-out \
  --hidden_layer_sizes=${HIDDEN_LAYER_SIZES} \
  --arg_prefix=${ARG_PREFIX} \
  --graph_builder=${GRAPH_BUILDER} \
  --task_context=${TASK_CONTEXT} \
  --model_path=${MODEL_PATH} \
  --slim_model \
  --batch_size=1024 \
  --alsologtostderr
