#!/bin/bash
function die() {
  echo "$@"
  exit 1
}


GIT_DIRECTORY=ffmpeg-git
if [[ ! -d "$FFMPEG_SOURCES" ]]; then
  mkdir -p sources/ffmpeg
  cd sources/ffmpeg
  git clone https://github.com/opensesamemedia/FFmpeg ${GIT_DIRECTORY} || die "Could not clone"
  cd ../..
fi
docker run \
  -v $(pwd):/mnt/ffmpeg-android-maker \
   -e FAM_ARGS="--disable-everything \
   --disable-programs \
   --disable-docs \
   --enable-encoder=pcm_f32le,libopus \
   --enable-decoder=pcm_f32le,libopus \
   --enable-muxer=pcm_f32le,rtsp,rtp \
   --enable-demuxer=pcm_f32le,rtsp,rtp \
   --enable-filter=abuffer,volume,aformat,abuffersink \
   --enable-gnutls --enable-libopus --disable-gpl " \
ffmpeg-android-maker:m2e
