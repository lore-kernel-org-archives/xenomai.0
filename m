MIME-Version: 1.0
Date: Tue, 25 Mar 2014 21:25:57 -0400
Message-ID: <CAK4EZFTBCxVWrbMS9DTnR72bcVnSkrkEDCfCZye4u-BREFGoBg@mail.gmail.com>
From: Adam Vaughan <vaughana@umich.edu>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Raspberry Pi Xenomai Linux + Minimal Raspian Net Install
	Guide
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I don't know if you want to add this to the Xenomai wiki, but attached
is a complete guide from start to finish for the Raspberry Pi build
process, the relevant patches, and the net installation of a minimal
Raspbian distro.

I suppose the formatting could be worked on, but I believe it covers
every gotcha with the RPi I'm aware of.  I think it might be helpful
to beginners.
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
# >> SKIP AHEAD << while the OS is installed automagically...


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
// Get Xenomai 2.6.3 and commit d996a1b RPi Linux 3.8.y as per documentation
//
mkdir ~/Xenomai-RPi
cd ~/Xenomai-RPi
wget -q -O - http://download.gna.org/xenomai/stable/xenomai-2.6.3.tar.bz2 |=
 tar -xjf -
cd ~/Xenomai-RPi
git clone --depth=3D1 -b rpi-3.8.y git://github.com/raspberrypi/linux.git
cd linux
git checkout d996a1b


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Patch for Xenomai
//
cd ~/Xenomai-RPi/linux
patch -Np1 < ../xenomai-2.6.3/ksrc/arch/arm/patches/raspberry/ipipe-core-3.=
8.13-raspberry-pre-2.patch
../xenomai-2.6.3/scripts/./prepare-kernel.sh --arch=3Darm --linux=3D./ --ad=
eos=3D../xenomai-2.6.3/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-3.patch
patch -Np1 < ../xenomai-2.6.3/ksrc/arch/arm/patches/raspberry/ipipe-core-3.=
8.13-raspberry-post-2.patch


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Patches to allow disabled USB FIQ and to correct for USB driver issues
// discussed on the Xenomai mailing list...
//
// NOTE:  If you don't apply the last 3 patches a custom FIQ will occasiona=
lly
//        not fire.  I haven't fully validated that it indeed fixes the iss=
ue
//        with a logic analyzer, but I have yet to see a missed FIQ on my
//        ordinary (not mixed signal) scope.
//
cd ~/Xenomai-RPi/linux
#
#
#
echo -e 'diff --git a/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c b/drivers=
/usb/host/dwc_otg/dwc_otg_hcd_intr.c
index 7d521d9..f3004d4 100644
--- a/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
+++ b/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
@@ -742,8 +742,10 @@ int32_t dwc_otg_hcd_handle_sof_intr(dwc_otg_hcd_t * hc=
d)
        }
 =

        /* Clear interrupt */
-       //gintsts.b.sofintr =3D 1;
-       //DWC_WRITE_REG32(&hcd->core_if->core_global_regs->gintsts, gintsts=
.d32);
+       if (!fiq_fix_enable) {
+               gintsts.b.sofintr =3D 1;
+               DWC_WRITE_REG32(&hcd->core_if->core_global_regs->gintsts, g=
intsts.d32);
+       }
 =

        return 1;
 }' | patch -p1 --ignore-whitespace
#
#
#
echo -e 'diff --git a/arch/arm/include/asm/ipipe_hwirq.h b/arch/arm/include=
/asm/ipipe_hwirq.h
index 6b864aa..bd8cda1 100644
--- a/arch/arm/include/asm/ipipe_hwirq.h
+++ b/arch/arm/include/asm/ipipe_hwirq.h
@@ -200,9 +200,9 @@ static inline void hard_local_irq_restore(unsigned long=
 x)
                ipipe_unstall_root();                   \\
        } while (0)

-#define local_fiq_enable() ipipe_unstall_root()
+#define local_fiq_enable() hard_local_fiq_enable_notrace()

-#define local_fiq_disable() ipipe_stall_root()
+#define local_fiq_disable() hard_local_fiq_disable_notrace()

 #define arch_local_irq_restore(flags)                  \\
        do {                                            \\
' | patch -p1 --ignore-whitespace
#
#
#
echo -e 'diff --git a/drivers/usb/host/dwc_common_port/dwc_common_linux.c b=
/drivers/usb/host/dwc_common_port/dwc_common_linux.c
index 0812d3a..6d01261 100644
--- a/drivers/usb/host/dwc_common_port/dwc_common_linux.c
+++ b/drivers/usb/host/dwc_common_port/dwc_common_linux.c
@@ -585,6 +585,7 @@ void DWC_MODIFY_REG32(uint32_t volatile *reg, uint32_t =
clear_mask, uint32_t set_
        local_irq_save(flags);
        local_fiq_disable();
        writel((readl(reg) & ~clear_mask) | set_mask, reg);
+       local_fiq_enable();
        local_irq_restore(flags);
 }

diff --git a/drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c b/drivers/usb/host=
/dwc_otg/dwc_otg_cil_intr.c
index b5a007d..10eead2 100644
--- a/drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c
+++ b/drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c
@@ -1354,6 +1354,7 @@ static inline uint32_t dwc_otg_read_common_intr(dwc_o=
tg_core_if_t * core_if, gin
                gintmsk.d32 |=3D gintmsk_common.d32;
                gintsts_saved.d32 &=3D ~gintmsk_common.d32;
                reenable_gintmsk->d32 =3D gintmsk.d32;
+               local_fiq_enable();
                local_irq_restore(flags);
        }

diff --git a/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c b/drivers/usb/host=
/dwc_otg/dwc_otg_hcd_intr.c
index 7d521d9..86d9cbe 100644
--- a/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
+++ b/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
@@ -97,6 +97,7 @@ void notrace _fiq_print(FIQDBG_T dbg_lvl, char *fmt, ...)
                memcpy(buffer + wptr, text, 16);
                wptr =3D (wptr + 16) % sizeof(buffer);
        }
+       local_fiq_enable();
        local_irq_restore(flags);
 }
 #endif
' | patch -p1 --ignore-whitespace


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Build the Linux kernel with Xenomai
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
#
make ARCH=3Darm menuconfig
#
# Some config changes to consider are below...
#
# I use the GPIO with low latency FIQ code, so I don't want anything else
# interfering with it, hence some of the suggested GPIO config changes.
#
# The worst case Xenomai response time is ~50 us, but you get all Xenomai O=
S features
# The worst case FIQ response time is ~1 us, but you're on your own as far =
as an OS goes
#
# Config change #01:  General setup -> Optimize very unlikely/likely branch=
es (YES)
# Config change #02:  System Type -> Broadcom BCM2708 Implementations -> BC=
M2708 gpio support (NO)
# Config change #03:  CPU Power Management -> CPU idle PM support (NO)
# Config change #04:  CPU Power Management -> CPU Frequency scaling (NO)
# Config change #05:  Device Drivers -> Sound Card support (NO)
# Config change #06:  Device Drivers -> USB support -> USB announce new dev=
ices (NO)
# Config change #07:  Device Drivers -> LED Support (NO)
#
make ARCH=3Darm CROSS_COMPILE=3D~/tools/arm-bcm2708/gcc-linaro-arm-linux-gn=
ueabihf-raspbian/bin/arm-linux-gnueabihf- -j 8 > /dev/null


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// The RPi system should be installed, now update it...
//
// On Raspberry Pi through ssh, or using keyboard.
//
// The default password:  raspbian
//
// On desktop PC:  ssh root@RPi_IP_ADDRESS_OR_HOSTNAME
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
# After halted, place the SD card back in the desktop for installation of c=
ustom Linux Kernel + Xenomai


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Install custom Linux Kernel + Xenomai
//
# After halted, place the SD card back in the desktop for installation of c=
ustom Linux Kernel + Xenomai
#
sudo echo 'Run this separately to cache sudo password first...'
#
sudo mount -t ext4 /dev/sde2 /mnt/gentoo && sudo mount -t vfat /dev/sde1 /m=
nt/gentoo/boot
sudo cp ~/Xenomai-RPi/linux/arch/arm/boot/zImage /mnt/gentoo/boot/kernel.img
cd ~/Xenomai-RPi/linux
sudo make modules_install ARCH=3Darm INSTALL_MOD_PATH=3D/mnt/gentoo
sudo make headers_install ARCH=3Darm INSTALL_HDR_PATH=3D/mnt/gentoo
sudo cp -R ~/Xenomai-RPi/linux /mnt/gentoo/usr/src/linux-3.8.13-quick+
#
cd ~/Xenomai-RPi/xenomai-2.6.3
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
ssh root@RPi_IP_ADDRESS_OR_HOSTNAME
echo 0 > /proc/xenomai/latency
/usr/xenomai/bin/./latency -p 100


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
// Basic benchmark for the system, more elaborate benchmarks are at:
// http://www.roylongbottom.org.uk/Raspberry%20Pi%20Benchmarks.htm
//
# Place the SD card back in the Raspberry Pi and boot the system...
ssh root@RPi_IP_ADDRESS_OR_HOSTNAME
wget http://home.iae.nl/users/mhx/flops.c
gcc -O2 -DUNIX flops.c -o flops
./flops


