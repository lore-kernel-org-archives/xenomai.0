From: Younes CHALABI <y.chalabi@sinters.fr>
Date: Tue, 9 Jul 2013 10:40:32 +0000
Message-ID: <A46EF8CF1BBB8E4B8A27B73E177C466402463ADE@MAIL-SINTERS-01.sinters-int.fr>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] No boot kernel with xenomai on i.MX6Q Sabrelite
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi to all,

I am currently trying to deploy Xenomai-2.6.2.1 patched to Linux-3.0.35 (Fr=
eescale Release) on the i.MX6Q Sabrelite board.

I followed this procedure for the installation : http://www.xenomai.org/doc=
umentation/xenomai-2.6/html/README.INSTALL/#arm

When I boot the target with an microSD card, the kernel starts to uncompres=
sing but at one moment stops at this line : Switching to clocksource ipipe_=
tsc ; and nothing happens after.

Any suggestion will be welcome.

Best regards.

Younes CHALABI

Here is the log :

U-Boot 2009.08 (Apr 25 2013 - 01:13:09)

CPU: Freescale i.MX6 family TO1.2 at 792 MHz
Thermal sensor with ratio =3D 186
Temperature:   26 C, calibration data 0x59c5137d
mx6q pll1: 792MHz
mx6q pll2: 528MHz
mx6q pll3: 480MHz
mx6q pll8: 50MHz
ipg clock     : 66000000Hz
ipg per clock : 66000000Hz
uart clock    : 80000000Hz
cspi clock    : 60000000Hz
ahb clock     : 132000000Hz
axi clock   : 264000000Hz
emi_slow clock: 132000000Hz
ddr clock     : 528000000Hz
usdhc1 clock  : 198000000Hz
usdhc2 clock  : 198000000Hz
usdhc3 clock  : 198000000Hz
usdhc4 clock  : 198000000Hz
nfc clock     : 24000000Hz
Board: MX6Q-SABRELITE:[ POR]
Boot Device: I2C
I2C:   ready
DRAM:   1 GB
MMC:   FSL_USDHC: 0,FSL_USDHC: 1
JEDEC ID: 0xbf:0x25:0x41
Reading SPI NOR flash 0xc0000 [0x2000 bytes] -> ram 0x276009b8
SUCCESS

*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   got MAC address from IIM: 00:00:00:00:00:00
FEC0 [PRIME]
Hit any key to stop autoboot:  0=20
mmc1 is current device

MMC read: dev # 1, block # 2048, count 8192 ... 8192 blocks read: OK
## Booting kernel from Legacy Image at 10800000 ...
   Image Name:   Linux-3.0.36-2508-g54750ff
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4088948 Bytes =3D  3.9 MB
   Load Address: 10008000
   Entry Point:  10008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 3.0.36-2508-g54750ff (younes@younes-Latitude-E6530) (gcc vers=
ion 4.7.3 (Sourcery CodeBench Lite 2013.05-24) ) #1 SMP PREEMPT Wed Jun 19 =
17:18:50 CEST 2013
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10c53c7d
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Freescale i.MX 6Quad Sabre-Lite Board
Memory policy: ECC disabled, Data cache writealloc
CPU identified as i.MX6Q, silicon rev 1.2
PERCPU: Embedded 10 pages/cpu @8c008000 s17088 r8192 d15680 u40960
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 227328
Kernel command line: console=3Dttymxc1,115200 root=3D/dev/mmcblk0p1 rootwai=
t rw video=3Dmxcfb0:dev=3Dldb,LDB-XGA,if=3DRGB666 video=3Dmxcfb0:dev=3Dhdmi=
,1920x1080M@60,if=3DRGB24
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 640MB 256MB =3D 896MB total
Memory: 895884k/895884k available, 152692k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xf4600000 - 0xffe00000   ( 184 MB)
    vmalloc : 0xc0800000 - 0xf2000000   ( 792 MB)
    lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
    pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
    modules : 0x7f000000 - 0x7fe00000   (  14 MB)
      .init : 0x80008000 - 0x80049000   ( 260 kB)
      .text : 0x80049000 - 0x80b41c28   (11236 kB)
      .data : 0x80b42000 - 0x80babfe0   ( 424 kB)
       .bss : 0x80bac004 - 0x80c26c8c   ( 492 kB)
SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
Preemptible hierarchical RCU implementation.
NR_IRQS:624
MXC GPIO hardware
sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 1431655ms
arm_max_freq=3D1GHz
MXC_Early serial console at MMIO 0x21e8000 (options '115200')
bootconsole [ttymxc1] enabled
I-pipe 1.18-11: pipeline enabled.
Console: colour dummy device 80x30
Calibrating delay loop... 1987.37 BogoMIPS (lpj=3D9936896)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
I-pipe, 498.000 MHz timer
I-pipe, 498.000 MHz clocksource
hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 counters availabl=
e
CPU1: Booted secondary processor
I-pipe, 498.000 MHz timer
CPU2: Booted secondary processor
I-pipe, 498.000 MHz timer
CPU3: Booted secondary processor
I-pipe, 498.000 MHz timer
Brought up 4 CPUs
SMP: Total of 4 processors activated (7949.51 BogoMIPS).
print_constraints: dummy:=20
NET: Registered protocol family 16
print_constraints: vddpu: 725 <--> 1300 mV at 700 mV fast normal=20
print_constraints: vddcore: 725 <--> 1300 mV at 1250 mV fast normal=20
print_constraints: vddsoc: 725 <--> 1300 mV at 1200 mV fast normal=20
print_constraints: vdd2p5: 2000 <--> 2775 mV at 2400 mV fast normal=20
print_constraints: vdd1p1: 800 <--> 1400 mV at 1100 mV fast normal=20
print_constraints: vdd3p0: 2625 <--> 3400 mV at 3000 mV fast normal=20
hw-breakpoint: found 6 breakpoint and 1 watchpoint registers.
hw-breakpoint: 1 breakpoint(s) reserved for watchpoint single-step.
hw-breakpoint: maximum watchpoint size is 4 bytes.
L310 cache controller enabled
l2x0: 16 ways, CACHE_ID 0x410000c7, AUX_CTRL 0x02070000, Cache size: 104857=
6 B
bio: create slab <bio-0> at 0
mxs-dma mxs-dma-apbh: initialized
print_constraints: VDDA: 2500 mV=20
print_constraints: VDDIO: 3300 mV=20
machine_constraints_voltage: VDDD: unsupportable voltage constraints
reg-fixed-voltage reg-fixed-voltage.2: Failed to register regulator: -22
reg-fixed-voltage: probe of reg-fixed-voltage.2 failed with error -22
print_constraints: vmmc: 3300 mV=20
SCSI subsystem initialized
spi_imx imx6q-ecspi.0: probed
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Freescale USB OTG Driver loaded, $Revision: 1.55 $
imx-ipuv3 imx-ipuv3.0: IPU DMFC NORMAL mode: 1(0~1), 5B(4,5), 5F(6,7)
imx-ipuv3 imx-ipuv3.1: IPU DMFC NORMAL mode: 1(0~1), 5B(4,5), 5F(6,7)
mxc_mipi_csi2 mxc_mipi_csi2: i.MX MIPI CSI2 driver probed
mxc_mipi_csi2 mxc_mipi_csi2: i.MX MIPI CSI2 dphy version is 0x3130302a
MIPI CSI2 driver module loaded
Advanced Linux Sound Architecture Driver Version 1.0.24.
Bluetooth: Core ver 2.16
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
cfg80211: Calling CRDA to update world regulatory domain
i2c-core: driver [max17135] using legacy suspend method
i2c-core: driver [max17135] using legacy resume method
Switching to clocksource ipipe_tsc

