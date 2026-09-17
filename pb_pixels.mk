#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# PitchBlack Recovery product for the malibu (Tensor G6) family: yogi (Pixel 11 Pro
# Fold) and its Pixel 11 siblings cubs, grizzly and kodiak. One recovery image serves
# all four; the device is identified at runtime from ro.hardware. Set DEVICE_BUILD_FLAG
# to malibu (vendorsetup.sh does this) before lunching pb_pixels.

# Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# PitchBlack config, in place of TWRP's vendor/twrp/config/common.mk.
$(call inherit-product, vendor/pb/config/common.mk)

# The device tree itself.
$(call inherit-product, device/google/pixels/device.mk)

# Trust Google's OTA signing key so a stock full OTA verifies for update_engine
# sideload; the default otacerts carries only the AOSP test and LineageOS keys.
PRODUCT_EXTRA_RECOVERY_KEYS += \
    device/google/pixels/security/google-ota

# "pixels" is the shared target across the malibu family; the image auto-detects the
# device at runtime. version.mk strips the pb_ prefix; PB_CODE feeds the maintainer
# lookup in vendor/pb/config/common.mk.
PRODUCT_RELEASE_NAME := pixels
PB_CODE := pixels
PRODUCT_DEVICE := $(PRODUCT_RELEASE_NAME)
PRODUCT_NAME := pb_$(PRODUCT_RELEASE_NAME)
PRODUCT_BRAND := google
PRODUCT_MODEL := Pixel Series
PRODUCT_MANUFACTURER := Google
PRODUCT_GMS_CLIENTID_BASE := android-google
