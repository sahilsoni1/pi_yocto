require recipes-graphics/images/core-image-weston.bb

DESCRIPTION = "Weston Debug Image"

IMAGE_INSTALL:append = " \
	gdb \
	gdbserver \
	valgrind \
	v4l-utils \
    mpv \
    lua \
    libass \
    gstreamer1.0 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-good-video4linux2 \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-bad-videoparsersbad \
"
IMAGE_FEATURES:append = " dbg-pkgs dev-pkgs debug-tweaks tools-debug "
