# For QEMU layers
./yocto_download_layers.sh qemu

# For Raspberry Pi 4 Model B layers
./yocto_download_layers.sh rpi4_B


# Best Practices
Always call it using source
source poky/oe-init-build-env build_rpi4_B
