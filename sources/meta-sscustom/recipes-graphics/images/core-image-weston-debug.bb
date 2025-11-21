require recipes-graphics/images/core-image-weston.bb

DESCRIPTION = "Weston Debug Image"

IMAGE_INSTALL:append = " gdb gdbserver valgrind "
IMAGE_FEATURES:append = " dbg-pkgs dev-pkgs debug-tweaks tools-debug "
