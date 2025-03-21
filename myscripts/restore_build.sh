#!/bin/bash

# Define the Yocto build and config paths
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
BASE_DIR="${SCRIPT_DIR}/../"
CONFIG_DIR="${BASE_DIR}/save_configs/qemux86-64"

# Ensure we're in the poky directory
cd "${BASE_DIR}/poky" || { echo "Failed to enter poky directory"; exit 1; }

# Source Yocto build environment
source "${BASE_DIR}/poky/oe-init-build-env"

# Ensure Bitbake is in the PATH
export PATH="${BASE_DIR}poky/bitbake/bin:$PATH"

# Copy saved configs to the build folder
cp "${CONFIG_DIR}/local.conf" "${BASE_DIR}/poky/build/conf/local.conf"
cp "${CONFIG_DIR}/bblayers.conf" "${BASE_DIR}/poky/build/conf/bblayers.conf"

# Verify Bitbake setup
if ! command -v bitbake &> /dev/null; then
    echo "❌ Bitbake not found. Check the setup."
    exit 1
fi

# Final confirmation
echo "✅ Yocto build environment set up with saved configurations."
echo "📍 You're now inside the build directory: $(pwd)"

# Change to build directory automatically
cd "${BASE_DIR}/poky/build"
