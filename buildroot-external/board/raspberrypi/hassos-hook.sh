#!/bin/bash
# shellcheck disable=SC2155

function hassos_pre_image() {
    local BOOT_DATA="$(path_boot_dir)"

    cp -t "${BOOT_DATA}" \
        "${BINARIES_DIR}/u-boot.bin" \
        "${BINARIES_DIR}/boot.scr"
    cp -t "${BOOT_DATA}" \
        "${BINARIES_DIR}"/*.dtb \
        "${BINARIES_DIR}/rpi-firmware/bootcode.bin" \
        "${BINARIES_DIR}/rpi-firmware/fixup.dat" \
        "${BINARIES_DIR}/rpi-firmware/start.elf"
    cp -r "${BINARIES_DIR}/rpi-firmware/overlays" "${BOOT_DATA}/"
    cp -f "${BOARD_DIR}/../boot-env.txt" "${BOOT_DATA}/config.txt"

    # Set cmd options
    echo "dwc_otg.lpm_enable=0 console=tty1" > "${BOOT_DATA}/cmdline.txt"

    # Enable 64bit support
    if [ "${BOARD_ID}" == "rpi3-64" ]; then
        echo "arm_64bit=1" >> "${BOOT_DATA}/config.txt"
    fi
}


function hassos_post_image() {
    convert_disk_image_gz
}

