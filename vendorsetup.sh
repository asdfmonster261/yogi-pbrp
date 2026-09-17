#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# vendorsetup.sh - sourced by the build system when device/google/pixels is present.
# The malibu (Tensor G6) board config keys off DEVICE_BUILD_FLAG, so set it before
# lunch. One recovery image serves yogi and its Pixel 11 siblings; the running device
# is identified from ro.hardware at boot.

if [ -z "${DEVICE_BUILD_FLAG:-}" ]; then
    export DEVICE_BUILD_FLAG="malibu"
fi
