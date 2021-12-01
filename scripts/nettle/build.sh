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

export PKG_CONFIG_PATH=${INSTALL_DIR}:$PKG_CONFIG_PATH 

./configure \
    --prefix=${INSTALL_DIR} \
    --host=${TARGET} \
    --with-sysroot=${SYSROOT_PATH} \
    --enable-mini-gmp \
    --with-pic \
    --disable-rtcd \
    --disable-doc \
    --disable-extra-programs

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install
