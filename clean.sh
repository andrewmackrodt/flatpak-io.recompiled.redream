#!/bin/bash
set -euo pipefail
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

declare -a paths=()
paths+=( .flatpak-builder )
paths+=( build-dir )
paths+=( repo )
paths+=( redream.flatpak )

for p in "${paths[@]}"; do
  if [[ -d "./$p" ]] || [[ -f "./$p" ]]; then
    echo -n "Removing ./$p .. "
    rm -rf "./$p"
    echo "OK"
  fi
done