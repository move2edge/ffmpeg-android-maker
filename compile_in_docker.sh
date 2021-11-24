docker run --rm \
  -v $(pwd):/mnt/ffmpeg-android-maker \
   -e FAM_ARGS="--enable-gnutls" \
  javernaut/ffmpeg-android-maker:custom
