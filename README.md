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

# rsyslog extend 
bitbake -c cleanall rsyslog
bitbake rsyslog
bitbake core-image-full-cmdline
## Verify the Recipe Source
bitbake-layers show-recipes | grep rsyslog
bitbake -e rsyslog | grep ^SRC_URI
Use bitbake -c devshell rsyslog and ls $WORKDIR to inspect if the files are copied.

# Once the build is complete, use the runqemu command:
runqemu qemux86-64
# get toolchain
bitbake core-image-weston-debug -c populate_sdk

bitbake -c pydevshell rpi-config
print(d.getVar('WORKDIR'))
print(d.getVar('FILESEXTRAPATHS'))
print(d.getVar('SRC_URI'))
print(d.getVar('D'))
print(d.getVar('PN'))
bitbake libsdl2 -c logerror
