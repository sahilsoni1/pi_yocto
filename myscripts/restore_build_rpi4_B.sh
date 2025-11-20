#!/bin/bash

###############################################################################
# restore_build_rpi4_B.sh
#
# Safe version:
#   - DOES NOT require `source`
#   - DOES NOT modify current shell environment
#   - DOES NOT break devshell
###############################################################################

set -e

script_log="setup_yocto.log"
exec > >(tee -a "$script_log") 2>&1

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
BASE_DIR="${SCRIPT_DIR}/../"
CONFIG_DIR="${BASE_DIR}/save_configs/rpi4_B"
SOURCES_DIR="${BASE_DIR}/sources/"
POKY_DIR="${SOURCES_DIR}/poky"
BUILD_DIR="${SOURCES_DIR}build_rpi4_B"

echo "Script directory: $SCRIPT_DIR"
echo "Sources directory: $SOURCES_DIR"

# Ensure poky exists
if [[ ! -d "$POKY_DIR" ]]; then
    echo "❌ poky folder NOT present at $POKY_DIR"
    exit 1
fi

# Ensure build directory exists
mkdir -p "${BUILD_DIR}/conf"

# Copy saved configs
cp "${CONFIG_DIR}/local.conf"    "${BUILD_DIR}/conf/local.conf"
cp "${CONFIG_DIR}/bblayers.conf" "${BUILD_DIR}/conf/bblayers.conf"

echo "✔ Config files restored."

echo ""
echo "===================================================="
echo " Yocto RPi4 Build Environment Restored Successfully "
echo " To start building, run:"
echo ""
echo "   cd ${SOURCES_DIR}"
echo "   source poky/oe-init-build-env build_rpi4_B"
echo "   bitbake core-image-weston"
echo ""
echo "===================================================="
