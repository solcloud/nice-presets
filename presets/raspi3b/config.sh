#!/bin/bash

export DISK_SIZE_GB=1
export LINUX_VERSION='5.17.2'

export ARCH=arm64
export CROSS_COMPILE='aarch64-linux-gnu-' # pacman -S aarch64-linux-gnu-gcc

export NICE_QEMU_KVM=0
export NICE_QEMU_AHCI_SUPPORT=0
export NICE_QEMU_ARCH=aarch64
export NICE_QEMU_EXTRA_OPTS="-M raspi3b -dtb $TARGET/boot/dts/broadcom/bcm2837-rpi-3-b.dtb -device usb-net,netdev=net0"
export QEMU_RAM=1G
export QEMU_CONSOLE='ttyAMA0'
export QEMU_PROCESSOR_CORES=4
export NICE_PRIMARY_DISK_INTERFACE=sd

export NICE_ARCH=aarch64
export DISTRO=void
export DISTRO_ISO=/data/dwn/void-live-x86_64-20210930.iso
