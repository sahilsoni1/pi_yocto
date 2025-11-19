# README: Flashing Yocto Weston Image to Raspberry Pi 4

This document explains how to burn a Yocto-generated `.wic` image onto an SD card for Raspberry Pi 4 using Linux.

---

## 📘 1. Copy the Yocto Image

Navigate to the Yocto deploy directory:

```
cd <yocto-project>/sources/build_rpi4_B/tmp/deploy/images/raspberrypi4-64/
```

Copy the image to your working folder:

```
cp core-image-weston-raspberrypi4-64-*.rootfs.wic.bz2 ~/images/
cd ~/images/
```

---

## 📦 2. Install Required Tools

Install bzip2 for decompressing `.bz2` files:

```
sudo apt-get install bzip2
```

Check that `bunzip2` exists:

```
which bunzip2
```

---

## 📂 3. Decompress the Image (if needed)

Yocto often creates **hardlinks**, so decompressing directly may warn or fail.

### ✔ Recommended Safe Method

Make a normal copy:

```
cp core-image-weston-raspberrypi4-64-*.rootfs.wic.bz2 myimage.wic.bz2
bunzip2 myimage.wic.bz2
```

This yields:

```
myimage.wic
```

---

## ⚡ 4. (Recommended) Flash Using bmaptool

`bmaptool` is faster and works directly on `.bz2` files.

Install it:

```
sudo apt-get install bmap-tools
```

Flash directly:

```
sudo bmaptool copy core-image-weston-raspberrypi4-64-*.rootfs.wic.bz2 /dev/sdX
```

Replace `/dev/sdX` with your SD card.

---

## 🔍 5. Identify Your SD Card

Insert SD card and run:

```
lsblk
```

Look for a device with size 8–32 GB, such as:

```
sda      14.8G
├─sda1
└─sda2
```

Here the SD card is `/dev/sda`.

⚠ **Never use /dev/sda1 or any numbered partition—use the whole device.**

---

## 🔓 6. Unmount the SD Card

Before flashing:

```
sudo umount /dev/sda1
sudo umount /dev/sda*
```

---

## 📝 7. Flash the Image Using dd

If you decompressed the image, flash it with `dd`:

```
sudo dd if=myimage.wic of=/dev/sda bs=4M status=progress conv=fsync
sync
```

This writes the Yocto filesystem and bootloader to the SD card.

---

## 🔎 8. Verify SD Card Layout

After flashing, confirm with:

```
lsblk
```

Expected output:

```
sda
├─sda1   ~70M     (boot partition)
└─sda2   ~700M    (root filesystem)
```

This confirms the Yocto image is installed correctly.

---

## 🚀 9. Boot the Raspberry Pi 4

1. Insert SD card
2. Connect HDMI & keyboard
3. Apply power
4. The Weston GUI should appear

---

## 📎 Appendix: Example Command History

```
cp core-image-weston-raspberrypi4-64-20251119094856.rootfs.wic.bz2 <path>
cd images/
sudo apt-get install bzip2
bunzip2 <image>.bz2
sudo dd if=myimage.wic of=/dev/sda bs=4M status=progress conv=fsync
sync
lsblk
```

---

## ✔ Need More?

I can help you customize:

* ffmpeg integration
* Weston auto-start apps
* Enable SSH, I2C, SPI, UART
* Create custom Yocto images
* Make script-based auto flashing

Just ask!
