FROM ubuntu:20.04

# Arguments that can be overridden in 'docker build' command:
# Versions of Android SDK and NDK. The CMake is installed via NDK.
ARG VERSION_SDK=6858069
ARG VERSION_NDK=21.4.7075529
ARG VERSION_CMAKE=3.10.2.4988404

# Package to install via pip3
ARG VERSION_MESON=0.58.2

# The HOME variable isn't available for ENV directive (during building an image).
# So we define one manually. For alpine and ubuntu it should be '/root'
ARG HOME_TWIN=/root

# Creating mandatory environment variables
ENV ANDROID_SDK_HOME=${HOME_TWIN}/android-sdk
ENV ANDROID_NDK_HOME=${ANDROID_SDK_HOME}/ndk/${VERSION_NDK}

# Installing basic software
RUN apt-get update && apt-get install -y --no-install-recommends \
  python3 \
  python3-pip \
  python3-setuptools \
  python3-wheel \
  ninja-build \
  build-essential \
  openjdk-8-jdk-headless \
  curl \
  unzip \
  bash \
  nasm \
  pkg-config \
  make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
  git \
  autoconf \
  automake \
  libtool \
  cmake \
  gcc \
  gperf \ 
  texinfo \
  yasm \
  nasm \
  bison \
  autogen \ 
  patch

# Meson has to be installed in a different way
RUN pip3 install meson==$VERSION_MESON

# Download the Android SDK
RUN curl https://dl.google.com/android/repository/commandlinetools-linux-${VERSION_SDK}_latest.zip --output ${HOME_TWIN}/android-sdk.zip
# Unzip it and remove the archive
RUN mkdir -p ${HOME_TWIN}/android-sdk && \
  unzip -qq ${HOME_TWIN}/android-sdk.zip -d ${HOME_TWIN}/android-sdk && \
  rm ${HOME_TWIN}/android-sdk.zip

# Installing components through the Android SDK
RUN installAndroidComponent() { yes | ${ANDROID_SDK_HOME}/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_SDK_HOME} "$1" > /dev/null; } && \
  installAndroidComponent "ndk;${VERSION_NDK}" && \
  installAndroidComponent "cmake;${VERSION_CMAKE}"

RUN apt update && DEBIAN_FRONTEND="noninteractive" apt install -y --no-install-recommends git \
  autoconf \
  automake \
  libtool \
  cmake \
  gcc \
  gperf \ 
  texinfo \
  yasm \
  nasm \
  bison \
  autogen \ 
  patch

RUN git clone https://github.com/tanersener/ffmpeg-kit.git

WORKDIR /ffmpeg-kit
RUN cd /ffmpeg-kit

# The command to be executed when a container is running
CMD export ANDROID_SDK_ROOT=$ANDROID_SDK_HOME && export ANDROID_NDK_ROOT=$ANDROID_NDK_HOME && cd /ffmpeg-kit && ./android.sh
CMD export ANDROID_SDK_ROOT=$ANDROID_SDK_HOME && export ANDROID_NDK_ROOT=$ANDROID_NDK_HOME && cd /ffmpeg-kit && ./android.sh
