FROM ubuntu:20.04

# Arguments that can be overridden in 'docker build' command:
# Versions of Android SDK and NDK. The CMake is installed via NDK.
ARG VERSION_SDK=6858069
ARG VERSION_NDK=23.1.7779620
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
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
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
  autoconf \
  automake \
  libtool \
  libopus-dev \
  cmake \
  gcc \
  gperf \ 
  texinfo \
  yasm \
  bison \
  autogen \ 
  patch \
  git \
  gettext \
  autopoint \
  wget \
  pkg-config \
  libgmp3-dev \
  libmpfr-dev \
  make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://ftp.gnu.org/gnu/nettle/nettle-3.5.tar.gz && \
 tar xvfz nettle-3.5.tar.gz

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

#WORKDIR /ffmpeg-kit
#RUN cd /ffmpeg-kit

# The command to be executed when a container is running
#CMD export ANDROID_SDK_ROOT=$ANDROID_SDK_HOME && \
    #export ANDROID_NDK_ROOT=$ANDROID_NDK_HOME && \
    #./android.sh --enable-gnutls --no-archive
CMD cd /mnt/ffmpeg-android-maker && ./ffmpeg-android-maker.sh ${FAM_ARGS}
