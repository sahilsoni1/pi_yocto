PACKAGECONFIG:append = " kmsdrm egl gles2 fbcon "

PACKAGECONFIG[kmsdrm] = "-DSDL_KMSDRM=ON, -DSDL_KMSDRM=OFF, libdrm virtual/libgbm"
PACKAGECONFIG[egl]    = "-DSDL_EGL=ON, -DSDL_EGL=OFF, virtual/egl"
PACKAGECONFIG[gles2]  = "-DSDL_OPENGLES=ON, -DSDL_OPENGLES=OFF, virtual/libgl"
PACKAGECONFIG[fbcon]  = "-DSDL_VIDEODRIVER_FB=ON, -DSDL_VIDEODRIVER_FB=OFF"

DEPENDS:append = " libdrm virtual/libgbm virtual/egl"
