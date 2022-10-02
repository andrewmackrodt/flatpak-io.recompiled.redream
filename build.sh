#!/bin/bash
set -euo pipefail

runtimeVersion=$(sed -nE "s/runtime-version: '([^']+)'/\1/p" io.recompiled.redream.yml)

function isRuntimeInstalled() {
  local stdout=$(
      flatpak list --runtime --columns=application,branch \
        | awk '$1 == "'$1'" && $2 == "'$runtimeVersion'" { print $0 }' \
    )

  [[ "$stdout" != "" ]] && return 0 || return 1
}

if ! isRuntimeInstalled "org.freedesktop.Platform"; then
  flatpak install -y flathub "org.freedesktop.Platform//$runtimeVersion"
fi

if ! isRuntimeInstalled "org.freedesktop.Sdk"; then
  flatpak install -y flathub "org.freedesktop.Sdk//$runtimeVersion"
fi

defaultBranch="beta"
flatpak-builder "--default-branch=$defaultBranch" --force-clean --repo=repo build-dir io.recompiled.redream.yml
flatpak build-update-repo "--default-branch=$defaultBranch" repo
flatpak build-bundle repo redream.flatpak io.recompiled.redream "$defaultBranch"

if [[ "$*" == *run* ]]; then
  flatpak install -y --user redream.flatpak
  flatpak run io.recompiled.redream
fi