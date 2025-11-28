# Enable GPL (required for x264)
PACKAGECONFIG:append = " gpl x264"

# Add SDL2 (available in ffmpeg-5.0.1)
PACKAGECONFIG:append = " sdl2"

# Enable OpenGL ES (correct name is gles2)
PACKAGECONFIG:append = " gles2"

# Remove invalid ones test
PACKAGECONFIG:remove = " v4l2-request kmsdrm v4l2 libv4l opengl"
