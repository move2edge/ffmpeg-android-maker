#!/usr/bin/env bash

HARDWARE_OPTIONS=""
case ${ANDROID_ABI} in
    x86)
        HARDWARE_OPTIONS="--disable-hardware-acceleration"
    ;;
    *)
        HARDWARE_OPTIONS="--enable-hardware-acceleration"
    ;;
esac
case $ANDROID_ABI in
  x86)
    EXTRA_BUILD_FLAGS="--target=x86-android-gcc --disable-sse4_1 --disable-avx --disable-avx2 --disable-avx512"
    VPX_AS=${FAM_YASM}
    ;;
  x86_64)
    EXTRA_BUILD_FLAGS="--target=x86_64-android-gcc --disable-avx --disable-avx2 --disable-avx512"
    VPX_AS=${FAM_YASM}
    ;;
  armeabi-v7a)
    EXTRA_BUILD_FLAGS="--target=armv7-android-gcc --enable-thumb --disable-neon"
    ;;
  arm64-v8a)
    EXTRA_BUILD_FLAGS="--target=arm64-android-gcc --enable-thumb"
    ;;
esac

export PKG_CONFIG_PATH=${INSTALL_DIR}:$PKG_CONFIG_PATH 

${MAKE_EXECUTABLE} distclean

CC=${FAM_CC} \
CXX=${FAM_CXX} \
AR=${FAM_AR} \
LD=${FAM_LD} \
AS=${VPX_AS} \
STRIP=${FAM_STRIP} \
NM=${FAM_NM} \
./configure \
    ${EXTRA_BUILD_FLAGS} \
    ${HARDWARE_OPTIONS} \
    --prefix=${INSTALL_DIR} \
    --host=${TARGET} \
    --with-sysroot=${SYSROOT_PATH} \
    --with-pic \
    --enable-mini-gmp \
    --disable-openssl \
    --enable-static \
    --disable-shared

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install
