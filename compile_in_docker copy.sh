docker run --rm \
  -v $(pwd):/mnt/ffmpeg-android-maker \
   -e FAM_ARGS="-gnutls" \
  javernaut/ffmpeg-android-maker:m2e

# -e FAM_ARGS="--enable-libopus  --enable-avcodec --enable-swresample  --enable-gnutls --enable-avformat" \
    # -e FAM_ARGS="-gnutls -libopus" \
