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

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

./configure \
    --prefix=${INSTALL_DIR} \
    --host=${TARGET} \
    --with-sysroot=${SYSROOT_PATH} \
    --with-pic \
    --with-included-libtasn1 \
    --with-included-unistring \
    --without-idn \
    --without-p11-kit \
    --enable-static \
    ${HARDWARE_OPTIONS} \
    --disable-openssl-compatibility \
    --disable-shared \
    --disable-fast-install \
    --disable-code-coverage \
    --disable-doc \
    --disable-manpages \
    --disable-guile \
    --disable-tests \
    --disable-tools \
    --disable-maintainer-mode

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install
