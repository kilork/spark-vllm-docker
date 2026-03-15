#!/bin/bash
set -e

MODEL_NAME=${MODEL_NAME:-Intel/MiniMax-M2.5-int4-AutoRound}
MODEL_HUB=${MODEL_NAME/\//"--"}
MODEL_PREFIX=/root/.cache/huggingface/hub/models--${MODEL_HUB}
MODEL_PATH=$MODEL_PREFIX/snapshots/$(cat ${MODEL_PREFIX}/refs/main)

TOKENIZER=/minimax-m2.5-tokenizer

mkdir $TOKENIZER
cd $TOKENIZER
cp $MODEL_PATH/{chat_template.jinja,tokenizer.json,tokenizer_config.json}
sed -i 's/"tokenizer_class": *"[^"]*"/"tokenizer_class": "TokenizersBackend"/' tokenizer_config.json
tail -n5 tokenizer_config.json
