#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

NETTLE_VERSION=3.4.1

downloadTarArchive \
  "nettle" \
  "https://ftp.gnu.org/gnu/nettle/nettle-${NETTLE_VERSION}.tar.gz"
