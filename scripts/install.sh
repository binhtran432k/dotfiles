#!/usr/bin/bash
IN=$1
TAR=$2
shift 2
OUT=./build

rm -rf $OUT && \
mkdir -p $OUT && \
wget -O $TAR $IN && \
tar -xf $TAR -C $OUT && \
for f in "$@"; do
  cp "$OUT/$f" ~/.local/bin
done && \
rm -f $TAR && \
rm -rf $OUT
