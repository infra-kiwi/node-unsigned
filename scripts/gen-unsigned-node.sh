#!/usr/bin/env bash
set -euo pipefail

platform="$1"
nodeVersion="$2"
arch="$3"

# https://nodejs.org/dist/v20.9.0/node-v20.9.0-linux-armv7l.tar.gz
fileName="node-${nodeVersion}-${platform}-${arch}"
url="https://nodejs.org/dist/${nodeVersion}/${fileName}.tar.gz"

wget -q "$url"
tar -xzf "${fileName}.tar.gz"

nodeBin='node'
cp "${fileName}/bin/node" "$nodeBin"

if [[ "$platform" == "darwin" ]]; then
  echo "Removing signature with codesign"
  codesign --remove-signature "$nodeBin"
fi

echo "Done"