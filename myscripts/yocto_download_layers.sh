#!/bin/bash

###############################################################################
# Yocto Unified Layer Downloader
# Supports: qemu | rpi4_B
# This script ONLY downloads and checks out Yocto layers.
# No build configuration is done here.
###############################################################################

set -e

if [[ "$#" -ne 1 ]]; then
    echo "Usage: $0 [qemu | rpi4_B]"
    exit 1
fi

TARGET=$1

if [[ "$TARGET" != "qemu" && "$TARGET" != "rpi4_B" ]]; then
    echo "Invalid target: $TARGET"
    echo "Usage: $0 [qemu | rpi4_B]"
    exit 1
fi

###############################################################################
# Paths
###############################################################################

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
BASE_DIR="${SCRIPT_DIR}/../"
SRC_DIR="${BASE_DIR}/sources"

# Repositories
POKY_REPO="git://git.yoctoproject.org/poky"
POKY_BRANCH="kirkstone"
POKY_COMMIT="378cd5368d34d9ed4b20c9a2c17f53dd64fc48c9"

OE_REPO="https://github.com/openembedded/meta-openembedded.git"
OE_BRANCH="kirkstone"
OE_COMMIT="f8dddbfcbfe502cb71375a7a907e61a92e8d4474"

# Raspberry Pi layer (only when needed)
RPI_REPO="https://github.com/agherzan/meta-raspberrypi.git"
RPI_BRANCH="kirkstone"
RPI_COMMIT="255500dd9f6a01a3445ac491d1abc401801e3bad"

POKY_DIR="${SRC_DIR}/poky"
OE_DIR="${SRC_DIR}/meta-openembedded"
RPI_DIR="${SRC_DIR}/meta-raspberrypi"

###############################################################################
echo "=============================="
echo " Yocto Layer Downloader"
echo " Target: $TARGET"
echo " Sources dir: $SRC_DIR"
echo "=============================="
###############################################################################

mkdir -p "${SRC_DIR}"
cd "${SRC_DIR}"

###############################################################################
# Download Poky
###############################################################################

echo "---- Poky ----"
if [[ ! -d "${POKY_DIR}" ]]; then
    echo "Cloning Poky (${POKY_BRANCH})..."
    git clone -b "${POKY_BRANCH}" "${POKY_REPO}"
else
    echo "Poky already exists, skipping clone."
fi
cd "${POKY_DIR}" && git fetch --all && git checkout "${POKY_COMMIT}" && cd ..

###############################################################################
# Download meta-openembedded
###############################################################################

echo "---- meta-openembedded ----"
if [[ ! -d "${OE_DIR}" ]]; then
    echo "Cloning meta-openembedded (${OE_BRANCH})..."
    git clone -b "${OE_BRANCH}" "${OE_REPO}"
else
    echo "meta-openembedded already exists, skipping clone."
fi
cd "${OE_DIR}" && git fetch --all && git checkout "${OE_COMMIT}" && cd ..

###############################################################################
# Download meta-raspberrypi (only for RPi4_B)
###############################################################################

if [[ "$TARGET" == "rpi4_B" ]]; then
    echo "---- meta-raspberrypi ----"
    if [[ ! -d "${RPI_DIR}" ]]; then
        echo "Cloning meta-raspberrypi (${RPI_BRANCH})..."
        git clone -b "${RPI_BRANCH}" "${RPI_REPO}"
    else
        echo "meta-raspberrypi already exists, skipping clone."
    fi
    cd "${RPI_DIR}" && git fetch --all && git checkout "${RPI_COMMIT}" && cd ..
fi

###############################################################################
echo "=============================="
echo "Layer download completed."
echo "Downloaded layers:"
echo " - poky"
echo " - meta-openembedded"
if [[ "$TARGET" == "rpi4_B" ]]; then
    echo " - meta-raspberrypi"
fi
echo "=============================="
###############################################################################
