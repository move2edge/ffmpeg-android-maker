git clone https://github.com/tanersener/ffmpeg-kit.git || (cd ffmpeg-kit && git pull origin main && cd .. ) && \
docker run \
  -v $(pwd):/mnt/ffmpeg-android-maker \
   -e FAM_ARGS="--enable-libopus" \
ffmpeg-android-maker:m2e
