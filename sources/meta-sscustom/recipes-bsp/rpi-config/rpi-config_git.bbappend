FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://config.txt"

# Replace upstream config.txt with ours before deployment
do_deploy:prepend() {
    install -m 0644 ${WORKDIR}/config.txt ${S}/config.txt
}
