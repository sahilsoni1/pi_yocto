# pi_yocto
demo project for raspberrypi_4
# For run the build
source oe-init-build-env  ../build/
# check layers are fine.
bitbake-layers show-layers --debug
# First, make sure you've set up your Yocto build environment and then build the image:
bitbake -c cleanall systemd
bitbake -c fetch systemd
bitbake core-image-full-cmdline

# Once the build is complete, use the runqemu command:
runqemu qemux86-64
