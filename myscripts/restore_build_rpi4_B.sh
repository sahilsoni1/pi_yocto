#!/bin/bash

###############################################################################
# restore_build_rpi4_B.sh
#
# Restores build directory for Raspberry Pi 4 Model B using existing saved
# bblayers.conf and local.conf.
#
# NOTE:
#   - This script DOES NOT generate config files.
#   - It only copies already prepared files from:
#        save_configs/rpi4_B/bblayers.conf
#        save_configs/rpi4_B/local.conf
###############################################################################

# ---- PREVENT WRONG EXECUTION ----
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "❌ Please run this script using: source restore_build_rpi4_B.sh"
    exit 1
fi
# ---------------------------------

script_log="setup_yocto.log"
exec > >(tee -a "$script_log") 2>&1

# Define the Yocto build and config paths
SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASE_DIR="${SCRIPT_DIR}/../"
CONFIG_DIR="${BASE_DIR}/save_configs/rpi4_B"
SOURCES_DIR="sources/"
POKY_DIR="poky"
BUILD_DIR="${BASE_DIR}${SOURCES_DIR}build_rpi4_B/"

echo "SCRIPT_DIR dir location:${SCRIPT_DIR}"
echo "sources dir location:${BASE_DIR}${SOURCES_DIR}"

cd "${BASE_DIR}${SOURCES_DIR}" || { echo "Failed to enter sources directory"; exit 1; }

# Ensure poky exists
if [[ ! -d "${POKY_DIR}" ]]; then
    echo "❌ poky folder NOT present at location ${BASE_DIR}${SOURCES_DIR}"
    exit 1
fi

# Prepare the build_rpi4_B directory
mkdir -p "${BUILD_DIR}/conf"

# Source Yocto build environment for the RPi4 build directory
source "${BASE_DIR}${SOURCES_DIR}poky/oe-init-build-env" "build_rpi4_B"

# Ensure Bitbake is in the PATH
export PATH="${BASE_DIR}${SOURCES_DIR}poky/bitbake/bin:$PATH"

# Copy saved configs to the build_rpi4_B folder
cp "${CONFIG_DIR}/local.conf"    "${BUILD_DIR}conf/local.conf"
cp "${CONFIG_DIR}/bblayers.conf" "${BUILD_DIR}conf/bblayers.conf"

# Verify Bitbake setup
if ! command -v bitbake &> /dev/null; then
    echo "❌ Bitbake not found. Check environment setup."
    exit 1
fi


# Final confirmation
echo "Yocto build environment set up with saved RPi4_B configurations."
echo "You're now inside the build directory: ${BUILD_DIR}"

echo "=============================================="
echo "Raspberry Pi 4 build restore complete!"
echo "To build, run:"
echo ""
echo "    cd ${BUILD_DIR}"
echo "    bitbake core-image-weston"
echo ""
echo "=============================================="
