#!/bin/bash

# $1 = path to Clover
# $2 = toolchain (XCODE8, GCC53 etc.)


echo -e "\033[1mRunning Postbuild expansion script for buildme.\033[0m"
cd $BUILDCLOVER_DIR

if [[ ! -d $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/kexts/Off ]]; then
	mkdir -p $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/kexts/Off
fi
echo -e "\033[1mRemoving unneeded drivers & folders.\033[0m"
## drivers/BIOS
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/BIOS/EnglishDxe.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/BIOS/XhciDxe.efi
## drivers/off/BIOS
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/BIOS/FileSystem/GrubEXFAT.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/BIOS/FileSystem/GrubISO9660.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/BIOS/FileSystem/GrubNTFS.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/BIOS/FileSystem/GrubUDF.efi
rm -Rf $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/BIOS/FileVault2
if [[ ! -e "$BUILDCLOVER_DIR"/CloverPackage/CloverV2/EFI/CLOVER/drivers/BIOS/OpenRuntime.efi ]]; then
	cp -fp "$BUILDCLOVER_DIR"/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/MemoryFix/OpenRuntime.efi "$BUILDCLOVER_DIR"/CloverPackage/CloverV2/EFI/CLOVER/drivers/BIOS
fi
## drivers/off/UEFI
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/FileSystem/Fat.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/FileSystem/VBoxExt2.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/FileSystem/VBoxExt4.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/FileSystem/VBoxIso9600.efi
rm -Rf $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/FileVault2
rm -Rf $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/HID
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/Other/CsmVideoDxe.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/Other/NvmExpressDxe.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/Other/OsxFatBinaryDrv.efi
## drivers/UEFI
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/UEFI/EnglishDxe.efi

exit 0
