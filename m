MIME-Version: 1.0
Date: Sun, 23 Feb 2014 21:51:06 -0500
Message-ID: <CAK4EZFTvbPWwM=gJRg9dqVP7KfExF7gtxpRWJgmNP-6KJbjYwA@mail.gmail.com>
From: Adam Vaughan <vaughana@umich.edu>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Raspberry Pi SD Card Issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Paul,

Thank you for making the Raspberry Pi patch.  To avoid hijacking the
interrupt thread, I'm starting a new thread.  An outstanding issue I've
been having with the Xenomai 3.8.13 Raspberry Pi kernel (and 3.5.7 using
your earlier patch [1]) is that heavy SD card access kills the system.

Over ssh:

RPi ~ # df -h
Filesystem      Size  Used Avail Use% Mounted on
rootfs          7.1G  3.2G  3.6G  47% /
/dev/root       7.1G  3.2G  3.6G  47% /
tmpfs           244M  192K  244M   1% /run
udev             10M     0   10M   0% /dev
shm             244M     0  244M   0% /dev/shm

RPi ~ # dd if=3D/dev/zero of=3D/root/dummy bs=3D1M count=3D1024
Segmentation fault

Attached is a picture of the dump (sorry for the fuzzy picture, I don't
have my UART board working at the moment to get the full listing or a good
camera at my lab).  The issue is repeatable, but can vary in the amount of
time from instantaneous to a few seconds before it occurs.  It also happens
decompressing large archives, and I've also experienced issues during
bootup when the system should be doing mostly reads.

My workaround has been to just do large writes on my desktop SD card
reader, which works fine for the same exact card:

desktop ~ # dd if=3D/dev/zero of=3D/mnt/gentoo/root/dummy bs=3D1M count=3D1=
024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 51.3844 s, 20.9 MB/s

For a while I thought my SD card was bad, but the card never errors out on
my desktop, and when I tried a different (slower) SD card, I had the same
issue on the RPi.  The main card I've been using is a SanDisk Extreme Pro 8
GB which is listed as compatible with the RPi [2] and I'm using the most
recent RPi firmware which apparently has some fixes for SD cards.  I've
also repaired any ext4 errors that have occurred, ostensibly because I've
needed to power cycle RPi when the system segfaults.

I haven't observed issues with a fresh image of Raspbian, and I just tried
out the same dd command twice after swapping the Xenomai RPi 3.8.13 kernel
for a recent Raspian kernel on on the same SD card:

RPi ~ # uname -a
Linux RPi 3.10-3-rpi #1 Debian 3.10.11-1+rpi3 (2014-01-01) armv6l BCM2708
GNU/Linux

RPi ~ # dd if=3D/dev/zero of=3D/root/dummy bs=3D1M count=3D1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 56.0862 s, 19.1 MB/s

RPi ~ # dd if=3D/dev/zero of=3D/root/dummy bs=3D1M count=3D1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 55.1734 s, 19.5 MB/s

So it would appear to be the kernel itself?  Do you have any suggestions
for how to proceed?  I'm not super comfortable making kernel patches to
roll in more recent drivers, but I'm be happy to help out anyway I can.

Thanks!

-Adam

[1]
http://www.blaess.fr/christophe/2013/02/15/raspberry-pi-interruptions-gpio-=
avec-rtdm
[2]  http://elinux.org/RPi_SD_cards

For reference, this is how I've been building my kernel Xenomai kernel:

wget -q -O - http://download.gna.org/xenomai/stable/xenomai-2.6.3.tar.bz2 |
tar -xjvf -

git clone --depth=3D1 -b rpi-3.8.y git://github.com/raspberrypi/linux.git
cd linux
git checkout d996a1b

patch -Np1 <
../xenomai-2.6.3/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspberr=
y-pre-2.patch
../xenomai-2.6.3/scripts/./prepare-kernel.sh --arch=3Darm --linux=3D./
--adeos=3D../xenomai-2.6.3/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-3.pa=
tch
patch -Np1 <
../xenomai-2.6.3/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspberr=
y-post-2.patch

Apply patch manually from:  https://github.com/raspberrypi/linux/issues/355

make mrproper
wget https://www.dropbox.com/s/dcju74md5sz45at/rpi_xenomai_config
mv rpi_xenomai_config .config
make ARCH=3Darm oldconfig

make ARCH=3Darm
CROSS_COMPILE=3D~/x-tools/armv6j-hardfloat-linux-gnueabi/bin/armv6j-hardflo=
at-linux-gnueabi-
-j 8
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ext4 error.jpg
Type: image/jpeg
Size: 138064 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140223/217fbad=
c/attachment.jpg>
