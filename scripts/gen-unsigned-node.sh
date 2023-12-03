#!/usr/bin/env bash
set -euo pipefail

platform="$1"
nodeVersion="$2"
arch="$3"

# https://nodejs.org/dist/v20.9.0/node-v20.9.0-linux-armv7l.tar.gz
fileName="node-${nodeVersion}-${platform}-${arch}"
fileNameUnsigned="node-unsigned-${nodeVersion}-${platform}-${arch}"
url="https://nodejs.org/dist/${nodeVersion}/${fileName}.tar.gz"

wget -q "$url"
tar -xzf "${fileName}.tar.gz"

distDir="dist"
mkdir -p "$distDir"

cp "${fileName}/bin/node" "${distDir}/${fileName}"
cp "${fileName}/bin/node" "${distDir}/${fileNameUnsigned}"

if [[ "$platform" == "darwin" ]]; then
  echo "Removing signature with codesign"
  codesign --remove-signature "${distDir}/${fileNameUnsigned}"
fi

echo "Done"