From: "George Pontis" <GPontis@z9.com>
References: <mailman.252.1366321778.1444.xenomai@xenomai.org>
In-Reply-To: <mailman.252.1366321778.1444.xenomai@xenomai.org>
Date: Mon, 22 Apr 2013 19:35:16 -0700
Message-ID: <00f801ce3fcb$30850ce0$918f26a0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: [Xenomai] for-core-3.8 on ARM ( i.MX53 )
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I took a crack at building a 3.8 kernel with Xenomai 2.6.2.1 for ARM, based
on the work in progress toward that ipipe patch.

It was necessary to apply a patch similar to one posted by Philippe Gerum
in:

Commit: 3412ebdad0b10477b205bcb041ff1fe9e1d1239f
Author: Philippe Gerum <rpm at xenomai.org>
Date:   Fri Aug 31 10:23:54 2012 +0200

---

in this case, the patch needed to be applied to:
 
arch/arm/include/asm/xenomai/wrappers.h

There were two snippets:


-#define wrap_strncpy_from_user(dstP, srcP, n)	__strncpy_from_user(dstP,
srcP, n)
+#include <asm/uaccess.h>
 


+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+#define wrap_strncpy_from_user(dstP, srcP, n)	strncpy_from_user(dstP,
srcP, n)
+#else
+#define wrap_strncpy_from_user(dstP, srcP, n)	__strncpy_from_user(dstP,
srcP, n)
+#endif
+


This built successfully, but the kernel hung late in the boot sequence. The
initial messages about the
ipipe and Xenomai look normal. Note that there are some other kernel patches
involved to enable some
new peripherals. We don't have much time with them yet but they seem good on
their own.
The boot log was this:

barebox / : boot
do_tftpb: /.tftp_tmp_path/zImageM -> /image
100Mbps full duplex link detected
        [#################################################################]
booting kernel from /image
booting Linux kernel with devicetree
Booting Linux on physical CPU 0x0
Linux version 3.8.0 (gpontis@ubuntuVm) (gcc version 4.7.2 (Buildroot
2013.02) ) #1 Mon Apr 22 18:46:00 PDT 2013
CPU: ARMv7 Processor [412fc085] revision 5 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Freescale i.MX53 (Device Tree Support), model: NVS 10315 board
based on Freescale i.MX53
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttymxc1,115200
ip=192.168.1.80:192.168.1.20:192.168.1.1:255.255.255.0::eth0: root=/dev/nfs
nfsroot=192.168.1.20:/var/share/rootM,v3,tcp noinitrd
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
__ex_table already sorted, skipping sort
Memory: 512MB = 512MB total
Memory: 512888k/512888k available, 11400k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xa0800000 - 0xff000000   (1512 MB)
    lowmem  : 0x80000000 - 0xa0000000   ( 512 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x8057ffe4   (5600 kB)
      .init : 0x80580000 - 0x805aed3c   ( 188 kB)
      .data : 0x805b0000 - 0x805e8840   ( 227 kB)
       .bss : 0x805e8840 - 0x8069e6d4   ( 728 kB)
SLUB: Genslabs=11, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:16 nr_irqs:16 16
TrustZone Interrupt Controller (TZIC) initialized
sched_clock: 32 bits at 33MHz, resolution 30ns, wraps every 128849ms
I-pipe, 33.333 MHz clocksource
CPU identified as i.MX53, silicon rev 2.1
Interrupt pipeline (release #3)
Console: colour dummy device 80x30
Calibrating delay loop... 531.66 BogoMIPS (lpj=2658304)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x7042afb8 - 0x7042afec
devtmpfs: initialized
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
imx53-pinctrl 53fa8000.iomuxc: initialized IMX pinctrl driver
bio: create slab <bio-0> at 0
3P2V: 3200 mV 
bl-en-supply: no parameters
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
mc13xxx 0-0008: mc34708: rev 2.4, fin: 0, fab: 0
i2c i2c-0: IMX I2C adapter registered
i2c i2c-1: IMX I2C adapter registered
Advanced Linux Sound Architecture Driver Initialized.
Switching to clocksource ipipe_tsc
NET: Registered protocol family 2
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
I-pipe: head domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.6.2.1 (Day At The Beach) loaded.
Xenomai: debug mode enabled.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
fuse init (API version 7.20)
msgmni has been set to 1001
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
imx-sdma 63fb0000.sdma: initialized
Serial: IMX driver
53fbc000.serial: ttymxc0 at MMIO 0x53fbc000 (irq = 47) is a IMX
53fc0000.serial: ttymxc1 at MMIO 0x53fc0000 (irq = 48) is a IMX
console [ttymxc1] enabled
[drm] Initialized drm 1.1.0 20060810
brd: module loaded
loop: module loaded
No NAND device found
spi_imx 50010000.ecspi: master is unqueued, this is deprecated
m25p80 spi32766.1: m25p32 (4096 Kbytes)
6 ofpart partitions found on MTD device spi32766.1
Creating 6 MTD partitions on "spi32766.1":
0x000000000000-0x000000050000 : "barebox"
0x000000050000-0x000000060000 : "env0"
0x000000060000-0x000000380000 : "kernel"
0x000000380000-0x0000003e0000 : "fpga"
0x0000003e0000-0x0000003f0000 : "nvs_data0"
0x0000003f0000-0x000000400000 : "nvs_data1"
spi_imx 50010000.ecspi: probed
libphy: fec_enet_mii_bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-mxc: Freescale On-Chip EHCI Host driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mousedev: PS/2 mouse device common for all mice
input: mc13783-ts as
/devices/soc.0/50000000.aips/53fec000.i2c/i2c-0/0-0008/mc34708-ts/input/inpu
t0
mc13xxx-rtc mc34708-rtc: rtc core: registered mc34708-rtc as rtc0
i2c /dev entries driver
imx2-wdt 53f98000.wdog: IMX2+ Watchdog Timer enabled. timeout=60s
(nowayout=0)
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: no vqmmc regulator found
mmc0: no vmmc regulator found
mmc0: SDHCI controller on 50004000.esdhc [50004000.esdhc] using DMA
mmc1: no vqmmc regulator found
mmc1: no vmmc regulator found
mmc1: SDHCI controller on 50008000.esdhc [50008000.esdhc] using DMA
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
[drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[drm] No driver support for vblank timestamp query.
[drm] Initialized imx-drm 1.0.0 20120507 on minor 0
imx-ipuv3 18000000.ipu: pinctrl_get_select_default failed with -19
imx-ipuv3 18000000.ipu: DI0 base: 0x1e040000 remapped to a08b4000
imx-ipuv3 18000000.ipu: DI1 base: 0x1e048000 remapped to a08b6000
resource: 0x1e030000 - 0x1e030fff
resource: 0x1e038000 - 0x1e038fff
imx-ipuv3 18000000.ipu: IPUv3M probed
sgtl5000 1-000a: clock-frequency missing or invalid
imx-sgtl5000: probe of sound.8 failed with error -22
TCP: cubic registered
NET: Registered protocol family 17
Key type dns_resolver registered
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 2
mc13xxx-rtc mc34708-rtc: hctosys: unable to read the hardware clock
Console: switching to colour frame buffer device 80x30
imx-drm imx-drm: fb0:  frame buffer device
imx-drm imx-drm: registered panic notifier
eth0: Freescale FEC PHY driver [Generic PHY]
(mii_bus:phy_addr=63fec000.etherne:01, irq=-1)


At this point the kernel would normally display some info on the mmc/SD
cards, but that is probably not
related to the hang. It makes no difference if the board has cards inserted
or not. Any suggestions on
tracing the source of the hang would be appreciated.

George



