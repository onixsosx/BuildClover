#!/bin/bash

# $1 = path to Clover
# $2 = toolchain (XCODE8, GCC53 etc.)

echo -e "\033[1mRunning Pre-build expansion script for buildme.\033[0m"

cd $BUILDCLOVER_DIR
#boot6
./ebuild.sh -fr -D NO_GRUB_DRIVERS_EMBEDDED -t $2
if [[ $? != 0 ]]; then
	echo -e "\033[1mFAIL: Building Clover failed.\033[0m"
	echo
	exit 1
fi
#boot7
./ebuild.sh -fr -mc --no-usb -D NO_GRUB_DRIVERS_EMBEDDED -t $2
if [[ $? != 0 ]]; then
	echo -e "\033[1mFAIL: Building Clover failed.\033[0m"
	echo
	exit 1
fi
##############################################################

echo
echo -e "\033[1mRunning Post-build expansion script for buildme.\033[0m"

if [[ ! -d $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/kexts/Off ]]; then
	mkdir -p $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/kexts/Off
fi
if [[ ! -d $BUILDCLOVER_DIR/FileSystems/HFSPlus/X64 ]]; then
	mkdir -p $BUILDCLOVER_DIR/FileSystems/HFSPlus/X64
fi
#x64
echo -e "\033[1mCopying Custom EFI drivers.\033[0m"
cp -f "$SRC_DIR"/drivers/HFSPlus.efi $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/UEFI/HFSPlus.efi
cp -f "$SRC_DIR"/drivers/HFSPlus.efi $BUILDCLOVER_DIR/FileSystems/HFSPlus/X64/HFSPlus.efi
#x32
if [[ ! -d $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers32 ]]; then
	mkdir -p $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers32
fi
cp -f "${SRC_DIR}"/drivers/CLOVERIA32.efi $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/CLOVERIA32.efi
cp -f "${SRC_DIR}"/drivers/FSInject-32.efi $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers32/FSInject-32.efi
cp -f "${SRC_DIR}"/drivers/bdmesg-32.efi $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/tools/bdmesg-32.efi
cp -f "${SRC_DIR}"/drivers/boot3 $BUILDCLOVER_DIR/CloverPackage/CloverV2/Bootloaders/x64/boot3
echo -e "\033[1mRemoving unneeded drivers & folders.\033[0m"
## drivers/BIOS
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/BIOS/XhciDxe.efi
## drivers/off/BIOS
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/BIOS/FileSystem/GrubEXFAT.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/BIOS/FileSystem/GrubISO9660.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/BIOS/FileSystem/GrubNTFS.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/BIOS/FileSystem/GrubUDF.efi
rm -Rf $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/BIOS/FileVault2
## drivers/off/UEFI
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/FileSystem/Fat.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/FileSystem/VBoxExt2.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/FileSystem/VBoxExt4.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/FileSystem/VBoxHfs.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/FileSystem/VBoxIso9600.efi
rm -Rf $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/FileVault2
rm -Rf $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/HID
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/Other/CsmVideoDxe.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/Other/EnglishDxe.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/Other/NvmExpressDxe.efi
rm -f $BUILDCLOVER_DIR/CloverPackage/CloverV2/EFI/CLOVER/drivers/off/UEFI/Other/OsxFatBinaryDrv.efi

exit 0
