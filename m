MIME-Version: 1.0
Date: Tue, 16 Oct 2012 20:35:10 -0300
Message-ID: <CAFNBftfgRC66N1JBEj5-e+ya4s5-RUqzeXsNs_iK6BTFrLmJ=w@mail.gmail.com>
From: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Latency tests - iMX53qsb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I could successfully create a Yocto based embedded Linux build such as
discussed in the following thread:

http://www.mail-archive.com/xenomai@xenomai.org/msg01284.html

Now I'm facing another challenge: how do I set up the kernel
configuration in order to have a correct latency performance.

I'm using Freescale's iMX53 Quick Start Board. Below it is the latency resu=
lts:

root@imx53qsb:~# latency
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|1250000.000|-1928116.749|-1428616.749|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|1366850.547|1866350.547|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000| 366850.547| 866350.547|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-633149.453|-133649.453|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-1633149.453|-1133649.453|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|1661817.843|-2133649.453|       0|
0|1250000.000|-1428616.749
RTD|1250000.000| 661817.843|1161317.843|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-338182.157| 161317.843|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-1338182.157|-838682.157|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|1956785.139|-1838682.157|       0|
0|1250000.000|-1428616.749
RTD|1250000.000| 956785.139|1456285.139|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000| -43214.861| 456285.139|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-1043214.861|-543714.861|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|-2043214.861|-1543714.861|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|1251752.435|1751252.435|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000| 251752.435| 751252.435|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-748247.565|-248747.565|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-1748247.565|-1248747.565|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|1546719.731|2046219.731|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000| 546719.731|1046219.731|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-453280.269|  46219.731|       0|     0|1250000.000|-142861=
6.749
RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|1250000.000|-1453280.269|-953780.269|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|1841687.027|-1953780.269|       0|
0|1250000.000|-1428616.749
RTD|1250000.000| 841687.027|1341187.027|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-158312.973| 341187.027|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-1158312.973|-658812.973|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|2136654.323|-1658812.973|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|1136654.323|1636154.323|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000| 136654.323| 636154.323|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-863345.677|-363845.677|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-1863345.677|-1363845.677|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|1431621.619|1931121.619|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000| 431621.619| 931121.619|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-568378.381| -68878.381|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-1568378.381|-1068878.381|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|1726588.915|-2068878.381|       0|
0|1250000.000|-1428616.749
RTD|1250000.000| 726588.915|1226088.915|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-273411.085| 226088.915|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-1273411.085|-773911.085|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|2021556.211|-1773911.085|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|1021556.211|1521056.211|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|  21556.211| 521056.211|       0|     0|1250000.000|-142861=
6.749
RTT|  00:00:43  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|1250000.000|-978443.789|-478943.789|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-1978443.789|-1478943.789|       0|
0|1250000.000|-1428616.749
RTD|1250000.000|1316523.507|1816023.507|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000| 316523.507| 816023.507|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-683476.493|-183976.493|       0|     0|1250000.000|-142861=
6.749
RTD|1250000.000|-1683476.493|-1183976.493|       0|
0|1250000.000|-1428616.749
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|1250000.000| 341687.027|-1428616.749|       0|     0|    00:00:49/00:00=
:49
root@imx53qsb:~#

My kernel boot message is the following:

root@imx53qsb:~# dmesg
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.35.3-11.09.01+yocto-gd86aa36-svn795-dirty
(raul@phi04) (gcc version 4.6.4 20120303 (prerelease) (GCC) ) #1
PREEMPT Tue Oct 16 12:26:08 BRT 2012
CPU: ARMv7 Processor [412fc085] revision 5 (ARMv7), cr=3D10c53c7d
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Freescale MX53 LOCO Board
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 253952
free_area_init_node: node 0, pgdat 808c9a8c, node_mem_map 8092d000
  DMA zone: 224 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 28448 pages, LIFO batch:7
  Normal zone: 2848 pages used for memmap
  Normal zone: 222432 pages, LIFO batch:31
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 250880
Kernel command line: console=3Dttymxc0,115200 root=3D/dev/mmcblk0p2 rw
rootfstype=3Dext3 rootwait
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 480MB 512MB =3D 992MB total
Memory: 997716k/997716k available, 18092k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xf8e00000 - 0xffe00000   ( 112 MB)
    vmalloc : 0xe0800000 - 0xf4000000   ( 312 MB)
    lowmem  : 0x80000000 - 0xe0000000   (1536 MB)
    pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
    modules : 0x7f000000 - 0x7fe00000   (  14 MB)
      .init : 0x80008000 - 0x8002e000   ( 152 kB)
      .text : 0x8002e000 - 0x8084f000   (8324 kB)
      .data : 0x80876000 - 0x808ca900   ( 339 kB)
SLUB: Genslabs=3D9, HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1, No=
des=3D1
Hierarchical RCU implementation.
	RCU-based detection of stalled CPUs is disabled.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:368
MXC GPIO hardware
MXC IRQ initialized
I-pipe, 8.000 MHz clocksource
MXC_Early serial console at MMIO 0x53fbc000 (options '115200')
bootconsole [ttymxc0] enabled
I-pipe 1.18-03: pipeline enabled.
Console: colour dummy device 80x30
Calibrating delay loop... 999.42 BogoMIPS (lpj=3D4997120)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys blkio
CPU: Testing write buffer coherency: ok
devtmpfs: initialized
regulator: core version 0.5
NET: Registered protocol family 16
i.MX IRAM pool: 128 KB@0xe0840000
IRAM READY
CPU is i.MX53 Revision 2.1
Using SDMA I.API
MXC DMA API initialized
IMX usb wakeup probe
the wakeup pdata is 0x808839f8
IMX usb wakeup probe
the wakeup pdata is 0x80883aac
bio: create slab <bio-0> at 0
SCSI subsystem initialized
libata version 3.00 loaded.
Freescale USB OTG Driver loaded, $Revision: 1.55 $

****************************** NOTICE *****************************
You have seen this notice as you have enabled OTG driver for mx53 LOCO boar=
d
For mx53 loco board, the OTG function is unavailable due to hardware limita=
tion
So, Only one usb function (device or host) can be available for certain ima=
ge
Please config your kernel to disable OTG and the usb function you
don't want to use
And remain the other usb function you would like to use

Below OTG configs should be removed:
CONFIG_MXC_OTG, CONFIG_USB_OTG

Choose one of below configs for host or device function
But DO NOT choose them together

OTG host config
CONFIG_USB_EHCI_ARC_OTG

OTG device config
CONFIG_USB_GADGET

usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
IPU DMFC NORMAL mode: 1(0~1), 5B(4,5), 5F(6,7)
PMIC Light driver loading...
Advanced Linux Sound Architecture Driver Version 1.0.23.
Bluetooth: Core ver 2.15
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
mc34708 Rev 2.4 FinVer 0 detected
PMIC MC34708 ID:0x14
regulator: SW1: 650 <--> 1437 mV at 1250 mV
regulator: SW1B: 650 <--> 1437 mV at 1100 mV
regulator: SW2: 650 <--> 1437 mV at 1300 mV
regulator: SW3: 650 <--> 1425 mV at 1200 mV
regulator: SW4A: 1200 <--> 3300 mV at 1500 mV
regulator: SW4B: 1200 <--> 3300 mV at 1500 mV
regulator: SW5: 1200 <--> 1975 mV at 1800 mV
regulator: SWBST:
regulator: VPLL: 1200 <--> 1800 mV at 1800 mV
regulator: VREFDDR:
regulator: VDAC: 2500 <--> 2775 mV at 2775 mV
regulator: VUSB:
regulator: VUSB2: 2500 <--> 3000 mV at 2500 mV
regulator: VGEN1: 1200 <--> 1550 mV at 1300 mV
regulator: VGEN2: 2500 <--> 3300 mV at 2500 mV
pmic 0-0008: Loaded
Switching to clocksource ipipe_tsc
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
UDP hash table entries: 512 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
LPMode driver module loaded
Static Power Management for Freescale i.MX5
PM driver module loaded
sdram autogating driver module loaded
Bus freq driver module loaded
DI1 is primary
mxc_dvfs_core_probe
DVFS driver module loaded
DVFS PER driver module loaded
I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.6.1 (Light Years Away) loaded.
Xenomai: debug mode enabled.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 1948
alg: No test for stdrng (krng)
cryptodev: driver loaded.
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
regulator: get() with no identifier
By setting, SII driver will not be enabled
By setting, LDB driver will not be enabled
mxc_ipu mxc_ipu: Channel already disabled 9
mxc_ipu mxc_ipu: Channel already uninitialized 9
IPU DMFC DP HIGH RESOLUTION: 1(0,1), 5B(2~5), 5F(6,7)
DMFC high resolution has set, will not change
Console: switching to colour frame buffer device 128x48
mxc_ipu mxc_ipu: Channel already disabled 7
mxc_ipu mxc_ipu: Channel already uninitialized 7
mxc_ipu mxc_ipu: Channel already disabled 10
mxc_ipu mxc_ipu: Channel already uninitialized 10
Serial: MXC Internal UART driver
mxcintuart.0: ttymxc0 at MMIO 0x53fbc000 (irq =3D 31) is a Freescale i.MX
console [ttymxc0] enabled, bootconsole disabled
mxcintuart.1: ttymxc1 at MMIO 0x53fc0000 (irq =3D 32) is a Freescale i.MX
mxcintuart.2: ttymxc2 at MMIO 0x5000c000 (irq =3D 33) is a Freescale i.MX
mxcintuart.3: ttymxc3 at MMIO 0x53ff0000 (irq =3D 13) is a Freescale i.MX
mxcintuart.4: ttymxc4 at MMIO 0x63f90000 (irq =3D 86) is a Freescale i.MX
loop: module loaded
No sata disk.
MXC MTD nand Driver 3.0
vcan: Virtual CAN interface driver
Freescale FlexCAN Driver
FEC Ethernet Driver
fec_enet_mii_bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 18, io base 0x53f80000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
fsl-ehci fsl-ehci.1: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.1: new USB bus registered, assigned bus number 2
fsl-ehci fsl-ehci.1: irq 14, io base 0x53f80200
fsl-ehci fsl-ehci.1: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
usbcore: registered new interface driver cdc_acm
cdc_acm: v0.26:USB Abstract Control Model driver for USB modems and
ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
ARC USBOTG Device Controller driver (1 August 2005)
mice: PS/2 mouse device common for all mice
input: gpio-keys as /devices/platform/gpio-keys/input/input0
MXC keypad loaded
input: mxc_power_key as /devices/virtual/input/input1
PMIC powerkey probe
egalax_ts 2-0004: egalax_ts: failed to read firmware version
egalax_ts: probe of 2-0004 failed with error -5
p1003_fwv33 2-0041: couldn't read panel infomation.
p1003_fwv33: probe of 2-0041 failed with error -5
DA9052 TSI Device Driver, v1.0
mxc_rtc mxc_rtc.0: rtc core: registered mxc_rtc as rtc0
pmic rtc probe start
pmic_rtc mc34708_rtc.1: rtc core: registered mc34708_rtc as rtc1
pmic rtc probe succeed
i2c /dev entries driver
IR NEC protocol handler initialized
IR RC5(x) protocol handler initialized
IR RC6 protocol handler initialized
IR JVC protocol handler initialized
IR Sony protocol handler initialized
Linux video capture interface: v2.00
mxc_v4l2_output mxc_v4l2_output.0: Registered device video0
usbcore: registered new interface driver uvcvideo
USB Video Class driver (v0.1.0)
APM Battery Driver
check mma8450 chip ID
mma8450 0-001c: build time Oct 16 2012 12:23:15
input: mma8450 as /devices/virtual/input/input2
add mma8450 i2c driver
MXC WatchDog Driver 2.0
MXC Watchdog # 0 Timer: initial timeout 60 sec
Bluetooth: Virtual HCI driver ver 1.3
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCIATH3K protocol initialized
Bluetooth: Generic Bluetooth USB driver ver 0.6
usbcore: registered new interface driver btusb
PMIC ADC start probe
VPU initialized
mxc_asrc registered
gpu mmu enabled
mxsdhci: MXC Secure Digital Host Controller Interface driver
mxsdhci: MXC SDHCI Controller Driver.
mmc0: SDHCI detect irq 0 irq 1 INTERNAL DMA
mxsdhci: MXC SDHCI Controller Driver.
mmc1: SDHCI detect irq 203 irq 3 INTERNAL DMA
Registered led device: pmic_ledsr
Registered led device: pmic_ledsg
Registered led device: pmic_ledsb
Registered led device: USR
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
Cirrus Logic CS42888 ALSA SoC Codec Driver
sgtl5000-i2c 1-000a: SGTL5000 revision 17
mxc_spdif mxc_spdif.0: MXC SPDIF Audio Transmitter
No device for codec mxc spdif
No device for DAI mxc spdif
No device for DAI imx-ssi-1-0
No device for DAI imx-ssi-1-1
No device for DAI imx-ssi-2-0
No device for DAI imx-ssi-2-1
No device for DAI imx-spdif-dai
DMA Sound Buffer Allocated: Playback UseIram=3D1 ext_ram=3D0
buf->addr=3Df8016000 buf->area=3De0856000 size=3D24576
DMA Sound Buffer Allocated: Capture  UseIram=3D1 ext_ram=3D1
buf->addr=3Dcf4e8000 buf->area=3Df98ad000 size=3D24576
asoc: SGTL5000 <-> imx-ssi-2-0 mapping ok
DMA Sound Buffer Allocated: Playback UseIram=3D1 ext_ram=3D1
buf->addr=3Dcf538000 buf->area=3Df98b3000 size=3D24576
asoc: mxc spdif <-> imx-spdif-dai mapping ok
ALSA device list:
  #0: imx-3stack (SGTL5000)
  #1: imx-3stack-spdif (mxc spdif)
TCP cubic registered
NET: Registered protocol family 17
can: controller area network core (rev 20090105 abi 8)
NET: Registered protocol family 29
can: raw protocol (rev 20090105)
can: broadcast manager protocol (rev 20090105 t)
Bluetooth: L2CAP ver 2.14
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.6
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 2
registered taskstats version 1
input: mxc_ts as /devices/virtual/input/input3
mxc input touchscreen loaded
mxc_rtc mxc_rtc.0: setting system clock to 1970-01-01 00:00:00 UTC (0)
Waiting for root device /dev/mmcblk0p2...
mmc0: new SD card at address 5bff
mmcblk0: mmc0:5bff SD01G 982 MiB
 mmcblk0: p1 p2
EXT3-fs: barriers not enabled
ehci_fsl_bus_suspend, DR
ehci_fsl_bus_suspend, Host 1
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p2): using internal journal
EXT3-fs (mmcblk0p2): recovery complete
EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) on device 179:2.
devtmpfs: mounted
Freeing init memory: 152K
<30>udevd[1291]: starting version 173
eth0: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_addr=3D0:00, irq=
=3D-1)
root@imx53qsb:~#

Does anybody have any clue about how to improve this latency test?

Best regards,

Flavio

--=20
Flavio de Castro Alves Filho

flavio.alves@gmail.com
www.linuxembarcado.com
Twitter: http://twitter.com/#!/fraviofii
LinkedIn profile: www.linkedin.com/in/flaviocastroalves

