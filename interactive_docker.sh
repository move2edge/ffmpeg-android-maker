#git clone https://github.com/tanersener/ffmpeg-kit.git || (cd ffmpeg-kit && git pull origin main && cd .. ) && \
docker run -it \
  -v $(pwd):/mnt/ffmpeg-android-maker \
   -e FAM_ARGS="--enable-gnutls --target-abis=x86_64,arm64" \
ffmpeg-android-maker:m2e /bin/bash
