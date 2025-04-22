#!/bin/bash

# Define the Yocto build and config paths
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
BASE_DIR="${SCRIPT_DIR}/../"
# Define repositories and directories
POKY_REPO="git://git.yoctoproject.org/poky"
OE_REPO="https://github.com/openembedded/meta-openembedded.git"
SOURCES_DIR="sources/"
POKY_DIR="poky"
OE_DIR="meta-openembedded"

# Set fixed branch and commit
POKY_BRANCH="kirkstone"
POKY_COMMIT="378cd5368d34d9ed4b20c9a2c17f53dd64fc48c9"   # Replace with your desired commit

OE_BRANCH="kirkstone"
OE_COMMIT="f8dddbfcbfe502cb71375a7a907e61a92e8d4474"    # Replace with your desired commit

echo "sources dir location:${BASE_DIR}${SOURCES_DIR}"
cd "${BASE_DIR}${SOURCES_DIR}" || { echo "Failed to enter sources directory"; exit 1; }

# Ensure we're in the poky directory

echo "Cloning Poky and OpenEmbedded with branch: ${POKY_BRANCH}"
# Clone Poky repo
if [[ ! -d "${POKY_DIR}" ]]; then
    echo "Cloning Poky from ${POKY_REPO} on branch ${POKY_BRANCH}"
    git clone -b "${POKY_BRANCH}" "${POKY_REPO}" || { echo "Failed to clone Poky branch ${POKY_BRANCH}"; exit 1; }
else
    echo "Poky already exists, skipping clone."
fi

# Checkout fixed commit for Poky
echo "Checking out commit ${POKY_COMMIT} for Poky"
cd "${POKY_DIR}" || exit
git fetch --all
git checkout "${POKY_COMMIT}" || { echo "Failed to checkout commit ${POKY_COMMIT}"; exit 1; }
cd ..

# Clone OpenEmbedded layers
if [[ ! -d "${OE_DIR}" ]]; then
    echo "Cloning OpenEmbedded from ${OE_REPO} on branch ${OE_BRANCH}"
    git clone -b "${OE_BRANCH}" "${OE_REPO}" || { echo "Failed to clone OE branch ${OE_BRANCH}"; exit 1; }
else
    echo "OpenEmbedded meta layers already exist, skipping clone."
fi

# Checkout fixed commit for OpenEmbedded
echo "Checking out commit ${OE_COMMIT} for OpenEmbedded"
cd "${OE_DIR}" || exit
git fetch --all
git checkout "${OE_COMMIT}" || { echo "Failed to checkout commit ${OE_COMMIT}"; exit 1; }
cd ..

echo "Clone and checkout complete with fixed branches and commits."
echo "sources dir location:${BASE_DIR}${SOURCES_DIR}"