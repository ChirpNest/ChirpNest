DESCRIPTION = "KIWI Server"
HOMEPAGE = "https://example.org/"
PRIORITY = "optional"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SRC_URI = " \
    http://www.keller-druck2.ch/swupdate/ChirpNest/kiwi-server_2020-06-04_11-23_linux_arm_7.tar.gz \
    file://kiwi-server.init \
    file://kiwi-server.monit \
    file://kiwi-server.toml \
"
SRC_URI[sha256sum] = "fd4c2b21459ce5a5162c2c0a1f2c5fb9f459c40f35d9e321a5f54cc93cca801a"
PR = "r1"

inherit update-rc.d

INITSCRIPT_NAME = "kiwi-server"
INITSCRIPT_PARAMS = "defaults"

S = "${WORKDIR}"
BIN_DIR = "/opt/kiwi-server"
CONF_DIR = "${sysconfdir}/kiwi-server"

do_install() {
    install -d ${D}${BIN_DIR}
    install -m 0755 kiwi-server ${D}${BIN_DIR}/

    install -d ${D}${CONF_DIR}
    install -m 0640 ${WORKDIR}/kiwi-server.toml ${D}${CONF_DIR}/kiwi-server.toml

    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/kiwi-server.init ${D}${sysconfdir}/init.d/kiwi-server

    install -d ${D}${sysconfdir}/monit.d
    install -m 0644 ${WORKDIR}/kiwi-server.monit ${D}${sysconfdir}/monit.d/kiwi-server
}


FILES_${PN} += "${BIN_DIR}"
FILES_${PN}-dbg += "${BIN_DIR}/.debug"

CONFFILES_${PN} += "${CONF_DIR}/kiwi-server.toml"
