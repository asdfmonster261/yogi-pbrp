#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# device.mk - Package list and build props for the malibu (Tensor G6) family:
# yogi (Pixel 11 Pro Fold) and its Pixel 11 siblings cubs, grizzly, kodiak.
#
# Boot-only bring-up: the FBE/metadata-decryption helpers (recovery_storageproxyd,
# recovery_weaver) are deliberately left out until there is hardware to test decrypt on.

LOCAL_PATH := device/google/pixels

# Virtual A/B OTA (compression)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# API & VNDK
PRODUCT_SHIPPING_API_LEVEL := 34
PRODUCT_TARGET_VNDK_VERSION := 34

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
ENABLE_VIRTUAL_AB := true
BOARD_USES_METADATA_PARTITION := true

# Boot control HAL (Pixel implementation, built from pixel-source/bootctrl)
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-service-pixel \
    android.hardware.boot@1.2-impl-pixel

# Core recovery packages
PRODUCT_PACKAGES += \
    fastbootd \
    update_engine \
    update_engine_sideload \
    update_verifier

# Vendor services
PRODUCT_PACKAGES += \
    vndservicemanager \
    vndservice \
    bootctl

# Libraries
PRODUCT_PACKAGES += \
    libtrusty \
    libsysutils \
    libhidltransport.vendor

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libsysutils.so

TARGET_RECOVERY_DEVICE_MODULES += libion
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so

# Keystore/Gatekeeper via Trusty (the KeyMint HAL prebuilt lives in prebuilt/malibu)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.keystore=trusty \
    ro.hardware.gatekeeper=trusty

# Default build fingerprint (yogi); overridden per device at runtime.
PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="yogi-user 17 CD1A.260714.001.A9 15938155 release-keys" \
    BuildFingerprint=google/yogi/yogi:17/CD1A.260714.001.A9/15938155:user/release-keys \
    DeviceProduct=yogi

PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# First-stage ramdisk fstab (pixel-source/conf-malibu/f2fs -> fstab.malibu*)
PRODUCT_PACKAGES += fstab.malibu.vendor_ramdisk
PRODUCT_PACKAGES += fstab.malibu-fips.vendor_ramdisk

# Recovery-ramdisk userspace tools
PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    resize.f2fs.vendor_ramdisk \
    dump.f2fs.vendor_ramdisk \
    fsck.vendor_ramdisk \
    tune2fs.vendor_ramdisk \
    e2fsck.vendor_ramdisk
