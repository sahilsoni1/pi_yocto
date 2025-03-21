#!/bin/bash

# Define the Yocto build and config paths
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
BASE_DIR="${SCRIPT_DIR}/../"
CONFIG_DIR="${BASE_DIR}/save_configs/qemux86-64"
SOURCES_DIR="sources/"
POKY_DIR="poky"

echo "sources dir location:${BASE_DIR}${SOURCES_DIR}"
cd "${BASE_DIR}${SOURCES_DIR}" || { echo "Failed to enter sources directory"; exit 1; }

# Ensure we're in the poky directory
if [[ ! -d "${POKY_DIR}" ]]; then
    echo "no poky folder present at location ${BASE_DIR}${SOURCES_DIR} "
    exit 0
fi
# Change to build directory automatically
# cd "${BASE_DIR}${SOURCES_DIR}"

# Source Yocto build environment
source "${BASE_DIR}${SOURCES_DIR}poky/oe-init-build-env"

# Ensure Bitbake is in the PATH
export PATH="${BASE_DIR}${SOURCES_DIR}poky/bitbake/bin:$PATH"

# Copy saved configs to the build folder
cp "${CONFIG_DIR}/local.conf" "${BASE_DIR}${SOURCES_DIR}build/conf/local.conf"
cp "${CONFIG_DIR}/bblayers.conf" "${BASE_DIR}${SOURCES_DIR}build/conf/bblayers.conf"

# Verify Bitbake setup
if ! command -v bitbake &> /dev/null; then
    echo "❌ Bitbake not found. Check the setup."
    exit 0
fi

cd build
# Final confirmation
echo "✅ Yocto build environment set up with saved configurations."
echo "📍 You're now inside the build directory: $(pwd)"


