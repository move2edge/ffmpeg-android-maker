#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

GNUTLS_MAJOR_VERSION=3.6
GNUTLS_VERSION=3.6.7

downloadTarArchive \
  "gnutls" \
  "https://www.gnupg.org/ftp/gcrypt/gnutls/v${GNUTLS_MAJOR_VERSION}/gnutls-${GNUTLS_VERSION}.tar.xz"
