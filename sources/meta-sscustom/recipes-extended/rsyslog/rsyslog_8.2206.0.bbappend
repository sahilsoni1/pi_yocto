FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGE_ARCH = "${MACHINE_ARCH}"

SRC_URI:append:qemux86-64 := " \
    file://rsyslog.conf \
    file://rsyslog.d/ss001.conf \
    file://rsyslogtest.conf \
    "

do_install:append:qemux86-64 () {
    # Create the directory if it doesn't exist
    install -d 0755 ${D}${sysconfdir}/rsyslog.d

    # Install the configuration files
    install -m 0644 ${WORKDIR}/rsyslog.conf ${D}${sysconfdir}/rsyslog.conf
    install -m 0644 ${WORKDIR}/rsyslogtest.conf ${D}${sysconfdir}/rsyslogtest.conf
    install -m 0644 ${WORKDIR}/rsyslog.d/ss001.conf ${D}${sysconfdir}/rsyslog.d/ss001.conf
}
