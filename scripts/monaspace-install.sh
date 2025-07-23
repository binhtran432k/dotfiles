#!/usr/bin/bash
NAME=$1

IN=https://github.com/githubnext/monaspace/raw/refs/heads/main/fonts/variable/Monaspace${NAME}VarVF%5Bwght,wdth,slnt%5D.ttf
OUT=$HOME/.local/share/fonts/Monaspace${NAME}VarVF[wght,wdth,slnt].ttf

rm -f "$OUT"
wget -O "$OUT" "$IN"
