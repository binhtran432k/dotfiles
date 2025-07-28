#!/usr/bin/bash
IN=$1
TAR=$2
shift 2
OUT=./build

rm -rf $OUT && \
mkdir -p $OUT && \
wget -O $TAR $IN && \
tar -xf $TAR -C $OUT && \
while [ ! -z "$1" ]; do
  cp $OUT/$1 $HOME/.local/bin/$2
  shift 2
done
rm -f $TAR && \
rm -rf $OUT
