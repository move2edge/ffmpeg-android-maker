git clone https://github.com/tanersener/ffmpeg-kit.git || (cd ffmpeg-kit && git pull origin main && cd .. ) && \
docker run --rm \
  -v $(pwd)/ffmpeg-kit:/ffmpeg-kit \
ffmpeg-android-maker:m2e
