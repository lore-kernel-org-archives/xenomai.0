MIME-Version: 1.0
In-Reply-To: <5332A14F.2070303@xenomai.org>
References: <CAK4EZFTBCxVWrbMS9DTnR72bcVnSkrkEDCfCZye4u-BREFGoBg@mail.gmail.com>
 <CAEbDrgkmpYUeizDvZ9gr-VVB-WD+wm=M_saB24E-8BvWj=BphQ@mail.gmail.com>
 <5332A14F.2070303@xenomai.org>
Date: Wed, 26 Mar 2014 19:45:07 -0400
Message-ID: <CAK4EZFSWuzPgQ8QWn8tY8Wpmojca+vgezSkFMXsS13kBOx7qsA@mail.gmail.com>
From: Adam Vaughan <vaughana@umich.edu>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Raspberry Pi Xenomai Linux + Minimal Raspian Net
 Install Guide
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> The -post patch should be updated to contain these patches. That is what
> the -post patch is made for.

Attached is a Xenomai patch for the
ipipe-core-3.8.13-raspberry-post-2.patch file.

As noted earlier, this patch covers USB driver issues discussed on the
Xenomai mailing list and allows you to disable the USB FIQ with
dwc_otg.fiq_fix_enable=3D0 dwc_otg.fiq_split_enable=3D0 in the Raspberry
Pi's cmdline.txt .  I haven't finished validating that custom FIQ code
(not from the USB driver) runs completely correctly with a logic
analyzer, but so far I haven't observed any issues on my regular
scope.  This consideration doesn't apply to almost all users, so I
don't think you need to worry about it.

So its all in one place, I've also attached is an updated guide for
minimal Raspbian and Xenomai with the attached patch.  I've double
checked that every step works and builds a functional Xenomai + Linux
kernel that lets you load custom FIQ code to toggle / read GPIO pins.
I have not tested that GPIO interrupts for Xenomai work, but I see no
reason why they wouldn't provided you enable the driver in the kernel
configuration (which I do not enable).

> Just to add, when compiling the same for 3.10 kernel the USB patches
> are not required. The ipipe patch 3.10 also does not apply cleanly but
> it is straightforward to adjust it.

I would like to switch to 3.10 in the future, but right now I'm going
to stick with 3.8 because I feel it's the most thoroughly vetted
version with Xenomai.
-------------- next part --------------
Note:  If you follow the listing below verbatim, it >> WILL ERASE EVERYTHIN=
G << on your SD card.

Adjust:

(1)  /dev/sde to match your SD card device on your desktop / laptop
(2)  /mnt/gentoo to match your mount point for the SD card
(3)  If you're not using keyboard, the hostname to remote in with ssh
(4)  --depth=3DX to get compensate for any new commits
(5)  -j 8 to an appropriate number of cores on your box
(6)  Remove -quick from the paths if you use a different config
(7)  If needed, adjust the path to the location of fixes_for_usb_driver_and=
_fiq.patch

After adjusting you can copy and paste each section below to your terminal.
I've decided not to script this because there are many steps that you should
examine the output of each step to make sure everything is going to plan.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Automatically install minimal Raspbian OS through net installer...
//
echo "wget -q -O - http://hifi.iki.fi/raspbian-ua-netinst/raspbian-ua-netin=
st-20140115-gitf8f70f8.img.xz | xzcat - > /dev/sde" | sudo sh
sync
#
# >> BOOT THE RPi SYSTEM WITH THE SD CARD <<
#
# It will automatically a minimal net install over Ethernet.
#
# >> SKIP AHEAD << to the next section while the OS is installed automagica=
lly...


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Blow away existing tools...
//
rm -Rf ~/tools  # Cross compile toolchain directory
rm -Rf ~/Xenomai-RPi  # Staging directory for Linux and Xenomai code


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Get RPi cross compile tools...
//
cd ~/
git clone --depth=3D1 git://github.com/raspberrypi/tools.git
cd ~/tools
git checkout e810a0b


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Get from git Xenomai 2.6 and commit d996a1b RPi Linux 3.8.y as per docum=
entation
//
mkdir ~/Xenomai-RPi
cd ~/Xenomai-RPi
git clone --depth=3D1 git://git.xenomai.org/xenomai-2.6.git
git clone --depth=3D1 -b rpi-3.8.y git://github.com/raspberrypi/linux.git
cd linux
git checkout d996a1b


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Patch Xenomai Raspberry Pi post patch...
// >> SKIP THIS STEP << if the patch has already been applied to the Xenoma=
i 2.6 git repository
//
cd ~/Xenomai-RPi/xenomai-2.6
git checkout 4081e1b
patch -p1 < ~/fixes_for_usb_driver_and_fiq.patch


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Patch Linux for Xenomai
//
cd ~/Xenomai-RPi/linux
patch -Np1 < ../xenomai-2.6/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.=
13-raspberry-pre-2.patch
../xenomai-2.6/scripts/./prepare-kernel.sh --arch=3Darm --linux=3D./ --adeo=
s=3D../xenomai-2.6/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-3.patch
patch -Np1 < ../xenomai-2.6/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.=
13-raspberry-post-2.patch


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Set the base Linux kernel config
//
cd ~/Xenomai-RPi/linux
make ARCH=3Darm mrproper
#
# OPTION:  make ARCH=3Darm bcmrpi_defconfig  # Builds a lot of stuff...
# OPTION:  make ARCH=3Darm bcmrpi_quick_defconfig  # Quick compilations whe=
n developing
# OPTION:  make ARCH=3Darm bcmrpi_cutdown_defconfig
# OPTION:  wget https://www.dropbox.com/s/dcju74md5sz45at/rpi_xenomai_confi=
g && mv rpi_xenomai_config .config && make ARCH=3Darm oldconfig
#
# MY CURRENT CHOICE:
#
make ARCH=3Darm bcmrpi_quick_defconfig


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Configure the Linux kernel with Xenomai
//
// Some config changes to consider are below...
//
// I use the GPIO with low latency FIQ code, so I don't want anything else
// interfering with it, hence some of the suggested GPIO config changes.
//
// The worst case Xenomai response time is ~50 us, but you get all Xenomai =
OS features
// The worst case FIQ response time is ~1.5 us, but you're on your own as f=
ar as an OS goes
//
// Config change #01:  General setup -> Optimize very unlikely/likely branc=
hes (YES)
// Config change #02:  System Type -> Broadcom BCM2708 Implementations -> B=
CM2708 gpio support (NO)
// Config change #03:  CPU Power Management -> CPU idle PM support (NO)
// Config change #04:  CPU Power Management -> CPU Frequency scaling (NO)
// Config change #05:  Device Drivers -> Sound Card support (NO)
// Config change #06:  Device Drivers -> USB support -> USB announce new de=
vices (NO)
// Config change #07:  Device Drivers -> LED Support (NO)
//
make ARCH=3Darm menuconfig


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Build the Linux kernel with Xenomai
//
make ARCH=3Darm CROSS_COMPILE=3D~/tools/arm-bcm2708/gcc-linaro-arm-linux-gn=
ueabihf-raspbian/bin/arm-linux-gnueabihf- -j 8 > /dev/null


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// The RPi system should have net installed by now... you need to update / =
configure the net install.
//
// On Raspberry Pi through ssh, or using keyboard.
//
// The default password:  raspbian
//
// On desktop PC:  ssh root@RPi_IP_ADDRESS_OR_FQDN  (FQDN =3D fully qualifi=
ed domain name)
//
passwd  # Set the root password...
dpkg-reconfigure locales
dpkg-reconfigure tzdata
apt-get update
apt-get install build-essential
apt-get install nano
#
# You might want to change the ssh port to cut down on ssh attacks...
#
halt
#
# After halted, power off the RPi and place the SD card back in the desktop
# for installation of custom Linux Kernel + Xenomai


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Quickly cache sudo password...
//
sudo echo 'Run this sudo echo separately to quickly cache the sudo password=
 before copying and pasting the next section.'


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Install custom Linux Kernel + Xenomai
//
// After updated, configured, halted and power off, place the SD card back
// in the desktop for installation of custom Linux Kernel + Xenomai
//
sudo mount -t ext4 /dev/sde2 /mnt/gentoo && sudo mount -t vfat /dev/sde1 /m=
nt/gentoo/boot
sudo cp ~/Xenomai-RPi/linux/arch/arm/boot/zImage /mnt/gentoo/boot/kernel.img
cd ~/Xenomai-RPi/linux
sudo make modules_install ARCH=3Darm INSTALL_MOD_PATH=3D/mnt/gentoo
sudo make headers_install ARCH=3Darm INSTALL_HDR_PATH=3D/mnt/gentoo
sudo cp -R ~/Xenomai-RPi/linux /mnt/gentoo/usr/src/linux-3.8.13-quick+
#
cd ~/Xenomai-RPi/xenomai-2.6
PATH=3D$PATH:~/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin
make clean
./configure --host=3Darm-linux-gnueabihf CFLAGS=3D'-march=3Darmv6' LDFLAGS=
=3D'-march=3Darmv6'
make -j 8
sudo PATH=3D$PATH:~/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbi=
an/bin make install DESTDIR=3D/mnt/gentoo
#
sudo rm /mnt/gentoo/lib/modules/3.8.13-quick+/build
sudo rm /mnt/gentoo/lib/modules/3.8.13-quick+/source
sudo ln -s /usr/src/linux-3.8.13-quick+ /mnt/gentoo/lib/modules/3.8.13-quic=
k+/build
sudo ln -s /usr/src/linux-3.8.13-quick+ /mnt/gentoo/lib/modules/3.8.13-quic=
k+/source
#
echo 'echo -e "dwc_otg.fiq_fix_enable=3D0 dwc_otg.fiq_split_enable=3D0 root=
=3D/dev/mmcblk0p2 rootfstype=3Dext4 rootwait elevator=3Dnoop\n" > /mnt/gent=
oo/boot/cmdline.txt' | sudo sh
echo 'echo -e "gpu_mem=3D16\ndisable_l2cache=3D0\ndisable_pvt=3D1\n" > /mnt=
/gentoo/boot/config.txt' | sudo sh
#
sudo sync && sudo umount /mnt/gentoo/boot && sudo umount /mnt/gentoo
#
# disable_pvt=3D1 in config.txt is to avoid this issue:
# http://www.raspberrypi.org/forum/viewtopic.php?f=3D37&t=3D7696
#
# "However, every 500ms the CPU is taking some sort of exception..."
#
# "Could be sdram PVT. The GPU monitors the temperature of the sdram,
#  and adjusts the refresh, momentarily DISABLING sdram, which the
#  ARM may see the effect of."  (emphasis added)
#
# Place the SD card back in the Raspberry Pi and boot the system...


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Test Xenomai (you should add load to the system)
//
# Place the SD card back in the Raspberry Pi and boot the system...
ssh root@RPi_IP_ADDRESS_OR_FQDN
echo 0 > /proc/xenomai/latency
/usr/xenomai/bin/./latency -p 100


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Basic benchmark for the system, more elaborate benchmarks are at:
// http://www.roylongbottom.org.uk/Raspberry%20Pi%20Benchmarks.htm
//
# Place the SD card back in the Raspberry Pi and boot the system...
ssh root@RPi_IP_ADDRESS_OR_FQDN
wget http://home.iae.nl/users/mhx/flops.c
gcc -O2 -DUNIX flops.c -o flops
./flops


-------------- next part --------------
A non-text attachment was scrubbed...
Name: fixes_for_usb_driver_and_fiq.patch
Type: text/x-patch
Size: 2967 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140326/7f269c2=
f/attachment.bin>
