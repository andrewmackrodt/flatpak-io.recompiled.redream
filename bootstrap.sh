#!/bin/bash
BIN_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)

declare -a directories=()
directories+=( cache )
directories+=( saves )
directories+=( states )

for d in "${directories[@]}"; do
  target=$(readlink "$BIN_PATH/$d")

  if [[ ! -d "$target" ]]; then
    mkdir -p "$target"
  fi
done

declare -a files=()
files+=( boot.bin )
files+=( flash.bin )
files+=( redream.cfg )
files+=( redream.log )
files+=( vmu0.bin )
files+=( vmu1.bin )
files+=( vmu2.bin )
files+=( vmu3.bin )

for f in "${files[@]}"; do
  target=$(readlink "$BIN_PATH/$f")
  dirname=$(dirname "$target")

  if [[ ! -d "$dirname" ]]; then
    mkdir -p "$dirname"
  fi
done

exec "$BIN_PATH/redream-gui" "$@"