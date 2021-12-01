#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

NETTLE_MAJOR_VERSION=3.6
NETTLE_VERSION=3.5

downloadTarArchive \
  "nettle" \
  "https://ftp.gnu.org/gnu/nettle/nettle-3.5.tar.gz"
