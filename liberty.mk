#
# Copyright (C) 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


DEVICE_PACKAGE_OVERLAYS := device/htc/liberty/overlay

## (1) First, the most specific values, i.e. the aspects that are specific to GSM

# Keylayouts
PRODUCT_COPY_FILES += \
    device/htc/liberty/prebuilt/usr/keylayout/liberty-keypad.kl:system/usr/keylayout/liberty-keypad.kl \
    device/htc/liberty/prebuilt/usr/keychars/liberty-keypad.kcm.bin:system/usr/keychars/liberty-keypad.kcm.bin \
    device/htc/liberty/prebuilt/usr/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl \
    device/htc/liberty/prebuilt/usr/keylayout/synaptics-rmi-touchscreen.kl:system/usr/keylayout/synaptics-rmi-touchscreen.kl \
    device/htc/liberty/prebuilt/usr/keylayout/atmel-touchscreen.kl:system/usr/keylayout/atmel-touchscreen.kl

# Input device calibration files
PRODUCT_COPY_FILES += \
    device/htc/liberty/prebuilt/usr/idc/synaptics-rmi-touchscreen.idc:system/usr/idc/synaptics-rmi-touchscreen.idc \
    device/htc/liberty/prebuilt/usr/idc/atmel-touchscreen.idc:system/usr/idc/atmel-touchscreen.idc \
    device/htc/liberty/prebuilt/usr/idc/curcial-oj.idc:system/usr/idc/curcial-oj.idc

PRODUCT_COPY_FILES += \
    device/htc/liberty/init.liberty.rc:root/init.liberty.rc \
    device/htc/liberty/init.liberty.usb.rc:root/init.liberty.usb.rc \
    device/htc/liberty/ueventd.liberty.rc:root/ueventd.liberty.rc

PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libhtc_ril.so \
    ro.ril.enable.dtm=1 \
    ro.ril.hsdpa.category=8 \
    ro.ril.hsupa.category=5 \
    ro.ril.disable.fd.plmn.prefix=23402,23410,23411 \
    ro.ril.def.agps.mode=1 \
    ro.ril.hsxpa=2 \
    ro.ril.gprsclass=12 \
    mobiledata.interfaces=rmnet0,rmnet1,rmnet2,gprs,ppp0 \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15 \
    ro.sf.lcd_density=160 \
    ro.opengles.version=131072 \
    ro.telephony.ril.v3=signalstrength

# Default network type.
# 0 => WCDMA preferred.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=0

# For emmc phone storage
PRODUCT_PROPERTY_OVERRIDES += \
    ro.phone_storage = 0


# This is a 512MB device, so 32mb heapsize
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=32m

## (1) First, the most specific values, i.e. the aspects that are specific to GSM

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/htc/liberty/liberty-vendor.mk)

## (3)  Finally, the least specific parts, i.e. the non-GSM-specific aspects
PRODUCT_PROPERTY_OVERRIDES += \
    settings.display.autobacklight=1 \
    settings.display.brightness=143 \
    persist.service.mount.playsnd=0 \
    ro.com.google.locationfeatures=1 \
    ro.setupwizard.mode=OPTIONAL \
    ro.setupwizard.enable_bypass=1 \
    ro.media.dec.aud.wma.enabled=1 \
    ro.media.dec.vid.wmv.enabled=1 \
    dalvik.vm.dexopt-flags=m=y \
    net.bt.name=Liberty \
    ro.config.sync=yes \
    persist.sys.usb.config=mass_storage,adb \
    dalvik.vm.dexopt-data-only=1 \
    debug.sf.hw=1 \
    debug.qctwa.statusbar=1 \
    debug.qctwa.preservebuf=1 \
    com.qc.hardware=true \
    com.qc.hdmi_out=false

# Override /proc/sys/vm/dirty_ratio on UMS
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vold.umsdirtyratio=20

PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

# media config xml file
PRODUCT_COPY_FILES += \
    device/htc/liberty/media_profiles.xml:system/etc/media_profiles.xml

PRODUCT_PACKAGES += \
    librs_jni \
    lights.liberty \
    gralloc.msm7x27 \
    copybit.msm7x27 \
    sensors.liberty \
    audio.primary.liberty \
    audio_policy.liberty \
    audio.a2dp.default \
    gps.liberty \
    libmm-omxcore \
    libOmxCore \
    hwcomposer.default \
    hwcomposer.msm7x27 \
    com.android.future.usb.accessory \
    e2fsck \
    camera.liberty

PRODUCT_COPY_FILES += \
    device/htc/liberty/vold.fstab:system/etc/vold.fstab \
    device/common/gps/gps.conf_US:system/etc/gps.conf \
    vendor/cm/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml \
    device/htc/liberty/prebuilt/etc/init.d/05mountsd:system/etc/init.d/05mountsd \
    device/htc/liberty/prebuilt/lib/libcamera.so:system/lib/libcamera.so

# Kernel modules

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/htc/liberty/prebuilt/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Prebuilt Modules
PRODUCT_COPY_FILES += \
    device/htc/liberty/prebuilt/lib/modules/bcm4329.ko:system/lib/modules/bcm4329.ko \
    device/htc/liberty/prebuilt/lib/modules/gan-eth.ko:system/lib/modules/gan-eth.ko \
    device/htc/liberty/prebuilt/etc/firmware/bcm4329.hcd:system/etc/firmware/bcm4329.hcd \
    device/htc/liberty/prebuilt/etc/firmware/fw_bcm4329.bin:system/etc/firmware/fw_bcm4329.bin \
    device/htc/liberty/prebuilt/etc/firmware/fw_bcm4329_apsta.bin:system/etc/firmware/fw_bcm4329_apsta.bin \

# ICS GPU drivers from Qualcomm
PRODUCT_COPY_FILES += \
    device/htc/liberty/prebuilt/lib/libC2D2.so:system/lib/libC2D2.so \
    device/htc/liberty/prebuilt/lib/libgsl.so:system/lib/libgsl.so \
    device/htc/liberty/prebuilt/lib/libOpenVG.so:system/lib/libOpenVG.so \
    device/htc/liberty/prebuilt/lib/libsc-a2xx.so:system/lib/libsc-a2xx.so \
    device/htc/liberty/prebuilt/lib/egl/eglsubAndroid.so:system/lib/egl/eglsubAndroid.so \
    device/htc/liberty/prebuilt/lib/egl/libEGL_adreno200.so:system/lib/egl/libEGL_adreno200.so \
    device/htc/liberty/prebuilt/lib/egl/libGLES_android.so:system/lib/egl/libGLES_android.so \
    device/htc/liberty/prebuilt/lib/egl/libGLESv1_CM_adreno200.so:system/lib/egl/libGLESv1_CM_adreno200.so \
    device/htc/liberty/prebuilt/lib/egl/libGLESv2_adreno200.so:system/lib/egl/libGLESv2_adreno200.so \
    device/htc/liberty/prebuilt/lib/egl/libq3dtools_adreno200.so:system/lib/egl/libq3dtools_adreno200.so \
    device/htc/liberty/prebuilt/etc/firmware/leia_pfp_470.fw:system/etc/firmware/leia_pfp_470.fw \
    device/htc/liberty/prebuilt/etc/firmware/leia_pm4_470.fw:system/etc/firmware/leia_pm4_470.fw \
    device/htc/liberty/prebuilt/etc/firmware/yamato_pfp.fw:system/etc/firmware/yamato_pfp.fw \
    device/htc/liberty/prebuilt/etc/firmware/yamato_pm4.fw:system/etc/firmware/yamato_pm4.fw

# media profiles and capabilities spec
$(call inherit-product, device/htc/liberty/media_a1026.mk)

# Sets copy files for all HTC-specific device
PRODUCT_COPY_FILES += device/htc/liberty/prebuilt/etc/ecclist_for_mcc.conf:system/etc/ecclist_for_mcc.conf

# Prebuilt libraries that are needed to build open-source libraries
PRODUCT_COPY_FILES += \
    device/htc/liberty/prebuilt/lib/libcamera.so:obj/lib/libcamera.so

$(call inherit-product, build/target/product/full_base_telephony.mk)

PRODUCT_NAME := generic_liberty
PRODUCT_MANUFACTURER := HTC
PRODUCT_DEVICE := liberty
