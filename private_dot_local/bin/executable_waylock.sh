#!/bin/sh

chayang -d 0.3 || exit 1

waylock \
  -init-color 0x282a36 \
  -input-color 0x8d63d9 \
  -input-alt-color 0x9d63e9 \
  -fail-color 0xef4545 \
  -fork-on-lock
