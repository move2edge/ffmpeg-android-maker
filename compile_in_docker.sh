#!/bin/bash
function die() {
  echo "$@"
  exit 1
}

time docker run \
  -v $(pwd):/mnt/ffmpeg-android-maker \
   -e FAM_ARGS="--target-abis=arm,arm64,x86_64 \
   --source-git-branch=${1} \
   --enable-gnutls --enable-libopus --disable-gpl " \
ffmpeg-android-maker:m2e
