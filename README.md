# Tooling for creating a Te Kahu Ora Raspberry Pi image.

## Creating a new image

* //TODO python environment setup documentation
* Download the latest Raspberry Pi Buster image.
* Mount a SD card (8GB is large enough)
* Prepare the new image with:
```
./image-prepare <sd-mount-point>
```
* If needed set WiFi country and add your local WiFi details. Bushnet is added by default.
```
./cardtool wifi country <sd-mount-point> NZ
./cardtool wifi set <sd-mount-point> <ssid> <psk>
```
* Eject the SD card from the computer and install into the Raspberry Pi and let it boot.
* Ensure that you can ssh onto the Raspberry Pi over your network.
* configure the new iamge with:
```
./image-configure
```
* Run salt state.apply on Raspberry Pi

* Insert the SD card back into your computer.
* Run the finalise script
```
./image-finalise
//TODO deal with getting unique name for salt
```
* if pishrink.sh is causing issues try looking here https://github.com/gmenezesg/fix_orphaned_inode_list

