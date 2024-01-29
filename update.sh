#!/bin/bash

LINEAGE_PRODUCT_OUT="$1"
[ -d "$LINEAGE_PRODUCT_OUT" ] || exit 1

for d in Mi8937 Mi439 Mi8937_4_19 Mi439_4_19 Tiare_4_19; do
    twrp_device=$(echo -n $d|tr '[:upper:]' '[:lower:]')
    if [ ! -d "$LINEAGE_PRODUCT_OUT/$d" ]; then continue; fi
    rm -rf $twrp_device
    mkdir $twrp_device
    if [ -f "$LINEAGE_PRODUCT_OUT/$d/obj/RECOVERY_KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb" ]; then
        cp $LINEAGE_PRODUCT_OUT/$d/obj/RECOVERY_KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb  $twrp_device/
    else
        cp $LINEAGE_PRODUCT_OUT/$d/obj/KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb  $twrp_device/
    fi
    cp $LINEAGE_PRODUCT_OUT/$d/vendor/lib/modules/*.ko $twrp_device/
    if [ -f "$LINEAGE_PRODUCT_OUT/$d/dtbo.img" ]; then
        cp $LINEAGE_PRODUCT_OUT/$d/dtbo.img $twrp_device/
    fi
    chmod 644 $twrp_device/*.*
done

exit 0
