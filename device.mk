# Copyright (C) 2025 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# Inherit common device configuration
$(call inherit-product, device/samsung/exynos7885-common/exynos7885-common.mk)

# Inherit proprietary files setup
$(call inherit-product, vendor/samsung/a30s/a30s-vendor.mk)

# Inherit dalvik config
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Target Info
TARGET_DEVICE := a30s
TARGET_SOC := exynos7904

# Bootanimation
TARGET_SCREEN_HEIGHT := 2280
TARGET_SCREEN_WIDTH := 1080

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint-service.samsung

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# Under-display fingerprint: illumination colour and icon size (SystemUI), and
# the size of the enrollment target (Settings)
PRODUCT_PACKAGES += \
    A30sUdfpsSystemUIOverlay \
    A30sUdfpsSettingsOverlay

# RIL: the modem keeps asking the CASS daemon for replies on /dev/umts_cass (cass
# answers through VaultKeeper in the TEE). With nobody answering, the A30s modem
# restarts itself about every 30 s and the SIM drops out. Blobs from the stock
# A307FNXXS4CWH1 firmware.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilts/vendor/bin/cass:$(TARGET_COPY_OUT_VENDOR)/bin/cass \
    $(LOCAL_PATH)/prebuilts/vendor/bin/vaultkeeperd:$(TARGET_COPY_OUT_VENDOR)/bin/vaultkeeperd \
    $(LOCAL_PATH)/prebuilts/vendor/bin/vendor.samsung.hardware.security.vaultkeeper@2.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/vendor.samsung.hardware.security.vaultkeeper@2.0-service \
    $(LOCAL_PATH)/prebuilts/vendor/etc/init/cass.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/cass.rc \
    $(LOCAL_PATH)/prebuilts/vendor/etc/init/vaultkeeper_common.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vaultkeeper_common.rc \
    $(LOCAL_PATH)/prebuilts/vendor/lib64/libdsms_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdsms_vendor.so \
    $(LOCAL_PATH)/prebuilts/vendor/lib64/libvkservice.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libvkservice.so \
    $(LOCAL_PATH)/prebuilts/vendor/lib64/vendor.samsung.frameworks.security.dsms@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.samsung.frameworks.security.dsms@1.0.so \
    $(LOCAL_PATH)/prebuilts/vendor/lib64/vendor.samsung.hardware.security.vaultkeeper@2.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.samsung.hardware.security.vaultkeeper@2.0.so

# RIL: hand rild the SEH radio response functions (needs the common
# hardware/samsung patch for rilds without ISehRadio 2.2)
PRODUCT_PACKAGES += \
    sehradiomanager

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay-lineage

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

