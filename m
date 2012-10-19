MIME-Version: 1.0
In-Reply-To: <507F85FA.9050704@xenomai.org>
References: <CAFNBftfgRC66N1JBEj5-e+ya4s5-RUqzeXsNs_iK6BTFrLmJ=w@mail.gmail.com>
	<507E0569.5040101@xenomai.org>
	<CAFNBfteFL4Za8Va7PEd1dawWb3g1EqpdNSdhDjA9HkFDEpc8Aw@mail.gmail.com>
	<507F85FA.9050704@xenomai.org>
Date: Fri, 19 Oct 2012 12:36:51 -0300
Message-ID: <CAFNBftcwrhSLeBOZE_dc2gSzXt2icJyMX10OoguzZyXBGv+ZpQ@mail.gmail.com>
From: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Latency tests - iMX53qsb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

2012/10/18 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> On 10/18/2012 04:04 AM, Flavio Castro Alves Filho wrote:
>
>> I'm trying to build using the instruction from Xenomai package
>> (rel_imx_3.0.15_12.03.00) and I'm facing some issues.
>>
>> The kernel does not compile when I turn off 'CPU Frequency Scaling' opti=
on.
>>
>> I use imx5_defconfig from the standard kernel config files.
>>
>> When I let 'CPU Frequency Scaling' on, with Xenomai, I have the
>> message on Xenomai configuration options, but the build run with
>> success.
>>
>> Do I have to lel this option on?
>
>
> Yes, probably. Please select the "performance" governor.

In fact, it didn't work. I had to make some adjustements.

It is attached the config file that we used here and, below, the
following results.


raul@phi04:/home/prjs/chiptiming0001$ picocom -b 115200 /dev/ttyUSB0
picocom v1.4

port is        : /dev/ttyUSB0
flowcontrol    : none
baudrate is    : 115200
parity is      : none
databits are   : 8
escape is      : C-a
noinit is      : no
noreset is     : no
nolock is      : no
send_cmd is    : ascii_xfr -s -v -l10
receive_cmd is : rz -vv

Terminal ready


U-Boot 2012.04.01-00060-g560b63a (Oct 15 2012 - 13:59:04)

Board: MX53 LOCO
I2C:   ready
DRAM:  1 GiB
WARNING: Caches not enabled
CPU:   Freescale i.MX53 family rev2.1 at 1000 MHz
Reset cause: POR
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
In:    serial
Out:   serial
Err:   serial
Net:   FEC
Hit any key to stop autoboot:  0
reading boot.scr

** Unable to read "boot.scr" from mmc 0:1 **
reading uImage

2812148 bytes read
Booting from mmc ...
## Booting kernel from Legacy Image at 70800000 ...
   Image Name:   Linux-3.0.36-01244-g34621b4-dirt
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2812084 Bytes =3D 2.7 MiB
   Load Address: 70008000
   Entry Point:  70008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 3.0.36-01244-g34621b4-dirty (raul@phi04) (gcc version
4.6.4 20120303 (prerelease) (GCC) ) #6 PREEMPT Fri Oct 19 11:19:43 BRT
2012
CPU: ARMv7 Processor [412fc085] revision 5 (ARMv7), cr=3D10c53c7d
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Freescale MX53 LOCO Board
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 218112
Kernel command line: console=3Dttymxc0,115200 root=3D/dev/mmcblk0p2 rw
rootfstype=3Dext3 rootwait
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 352MB 512MB =3D 864MB total
Memory: 870388k/870388k available, 14348k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xf4600000 - 0xffe00000   ( 184 MB)
    vmalloc : 0xe0800000 - 0xf2000000   ( 280 MB)
    lowmem  : 0x80000000 - 0xe0000000   (1536 MB)
    pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
    modules : 0x7f000000 - 0x7fe00000   (  14 MB)
      .init : 0x80008000 - 0x8002e000   ( 152 kB)
      .text : 0x8002e000 - 0x80552a2c   (5267 kB)
      .data : 0x80554000 - 0x805a3660   ( 318 kB)
       .bss : 0x805a3684 - 0x8066f1b8   ( 815 kB)
SLUB: Genslabs=3D11, HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
NR_IRQS:848
TrustZone Interrupt Controller (TZIC) initialized
MXC GPIO hardware
sched_clock: 32 bits at 8MHz, resolution 125ns, wraps every 536870ms
I-pipe, 8.000 MHz clocksource
I-pipe 1.18-11: pipeline enabled.
Console: colour dummy device 80x30
Calibrating delay loop... 996.14 BogoMIPS (lpj=3D4980736)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
print_constraints: dummy:
NET: Registered protocol family 16
IRAM READY
mx5_cpu_regulator_init: failed to get cpu regulator
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Freescale USB OTG Driver loaded, $Revision: 1.55 $
print_constraints: SW1: 650 <--> 1437 mV at 1250 mV
print_constraints: SW1B: 650 <--> 1437 mV at 1250 mV
print_constraints: SW2: 650 <--> 1437 mV at 1300 mV
print_constraints: SW3: 650 <--> 1425 mV at 1200 mV
print_constraints: SW4A: 1200 <--> 3150 mV at 1500 mV
print_constraints: SW4B: 1200 <--> 3150 mV at 1500 mV
print_constraints: SW5: 1200 <--> 1850 mV at 1800 mV
print_constraints: SWBST: at 5000 mV
print_constraints: VPLL: 1200 <--> 1800 mV at 1800 mV
print_constraints: VREFDDR: 600 mV
print_constraints: VUSB: 3300 mV
print_constraints: VUSB2: 2500 <--> 3000 mV at 2500 mV
print_constraints: VDAC: 2500 <--> 2775 mV at 2775 mV
print_constraints: VGEN1: 1200 <--> 1550 mV at 1300 mV
print_constraints: VGEN2: 2500 <--> 3300 mV at 2500 mV
imx-ipuv3 imx-ipuv3.0: IPU DMFC NORMAL mode: 1(0~1), 5B(4,5), 5F(6,7)
Advanced Linux Sound Architecture Driver Version 1.0.24.
Bluetooth: Core ver 2.16
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
i2c-core: driver [max17135] using legacy suspend method
i2c-core: driver [max17135] using legacy resume method
i2c-core: driver [mc13892] using legacy suspend method
i2c-core: driver [mc13892] using legacy resume method
Switching to clocksource ipipe_tsc
Switched to NOHz mode on CPU #0
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
UDP hash table entries: 512 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Bus freq driver module loaded
sdram autogating driver module loaded
Static Power Management for Freescale i.MX5
cpaddr =3D e0840000 suspend_iram_base=3De0836000
PM driver module loaded
i.MXC CPU frequency driver
I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.6.1 (Light Years Away) loaded.
Xenomai: debug mode enabled.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
msgmni has been set to 1699
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
mxc_sdc_fb mxc_sdc_fb.0: register mxc display driver vga
_regulator_get: get() with no identifier
imx-ipuv3 imx-ipuv3.0: Channel already disabled 9
imx-ipuv3 imx-ipuv3.0: Channel already uninitialized 9
imx-ipuv3 imx-ipuv3.0: IPU DMFC DP HIGH RESOLUTION: 1(0,1), 5B(2~5), 5F(6,7)
Console: switching to colour frame buffer device 128x48
imx-ipuv3 imx-ipuv3.0: Channel already disabled 10
imx-ipuv3 imx-ipuv3.0: Channel already uninitialized 10
mxc_sdc_fb mxc_sdc_fb.1: register mxc display driver lcd
imx-ipuv3 imx-ipuv3.0: Channel already disabled 7
imx-ipuv3 imx-ipuv3.0: Channel already uninitialized 7
imx-sdma imx-sdma: loaded firmware 1.0
imx-sdma imx-sdma: initialized
Serial: IMX driver
imx-uart.0: ttymxc0 at MMIO 0x53fbc000 (irq =3D 31) is a IMX
console [ttymxc0] enabled
brd: module loaded
loop: module loaded
Can't recover from RESET HBA!
No sata disk.
vcan: Virtual CAN interface driver
FEC Ethernet Driver
fec_enet_mii_bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 18, io base 0x53f80000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
can't find transceiver
fsl-ehci fsl-ehci.0: remove, state 1
usb usb1: USB disconnect, device number 1
fsl-ehci fsl-ehci.0: USB bus 1 deregistered
fsl-ehci fsl-ehci.0: init fsl-ehci.0 fail, -19
fsl-ehci fsl-ehci.1: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.1: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.1: irq 14, io base 0x53f80200
fsl-ehci fsl-ehci.1: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
ARC USBOTG Device Controller driver (1 August 2005)
Can't find OTG driver!
mousedev: PS/2 mouse device common for all mice
input: gpio-keys as /devices/platform/gpio-keys/input/input0
i2c /dev entries driver
lirc_dev: IR Remote Control driver registered, major 253
IR NEC protocol handler initialized
IR RC5(x) protocol handler initialized
IR RC6 protocol handler initialized
IR JVC protocol handler initialized
IR Sony protocol handler initialized
IR RC5 (streamzap) protocol handler initialized
IR LIRC bridge handler initialized
Linux video capture interface: v2.00
mxc_v4l2_output mxc_v4l2_output.0: V4L2 device registered as video16
mxc_v4l2_output mxc_v4l2_output.0: V4L2 device registered as video17
mxc_v4l2_output mxc_v4l2_output.0: V4L2 device registered as video18
check mma8450 chip ID
mma8450 0-001c: build time Oct 19 2012 10:59:31
input: mma8450 as /devices/virtual/input/input1
i2c-core: driver [mma8450] using legacy suspend method
i2c-core: driver [mma8450] using legacy resume method
add mma8450 i2c driver
Bluetooth: Virtual HCI driver ver 1.3
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCIATH3K protocol initialized
Bluetooth: Generic Bluetooth USB driver ver 0.6
usbcore: registered new interface driver btusb
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
mmc0: no vmmc regulator found
mmc0: SDHCI controller on platform [sdhci-esdhc-imx.0] using DMA
mmc1: no vmmc regulator found
mmc1: SDHCI controller on platform [sdhci-esdhc-imx.2] using DMA
VPU initialized
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
mxc_spdif mxc_spdif.0: MXC SPDIF Audio
asoc: mxc-spdif <-> imx-spdif-dai.0 mapping ok
ALSA device list:
  #0: imx-spdif
oprofile: hardware counters not available
oprofile: using timer interrupt.
TCP cubic registered
NET: Registered protocol family 17
can: controller area network core (rev 20090105 abi 8)
NET: Registered protocol family 29
can: raw protocol (rev 20090105)
can: broadcast manager protocol (rev 20090105 t)
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
Registering the dns_resolver key type
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 2
mxc_dvfs_core_probe
DVFS driver module loaded
regulator_init_complete: VPLL: incomplete constraints, leaving on
Waiting for root device /dev/mmcblk0p2...
mmc0: new SD card at address 5bff
mmcblk0: mmc0:5bff SD01G 982 MiB
 mmcblk0: p1 p2
EXT3-fs: barriers not enabled
EXT3-fs (mmcblk0p2): warning: maximal mount count reached, running
e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p2): using internal journal
EXT3-fs (mmcblk0p2): recovery complete
EXT3-fs (mmcblk0p2): mounted filesystem with ordered data mode
VFS: Mounted root (ext3 filesystem) on device 179:2.
Freeing init memory: 152K
INIT: version 2.88 booting
Starting udev
imx-ipuv3 imx-ipuv3.0: Channel already disabled 9
imx-ipuv3 imx-ipuv3.0: Channel already uninitialized 9
Starting Bootlog daemon: bootlogd: cannot allocate pseudo tty: No such
file or directory
bootlogd.
Caching udev devnodes
Populating dev cachemv: can't rename '/tmp/uname': No such file or directory
Configuring network interfaces... eth0: Freescale FEC PHY driver [SMSC
LAN8710/LAN8720] (mii_bus:phy_addr=3D1:00, irq=3D-1)
done.
Mon Oct 15 17:20:00 UTC 2012
INIT: Entering runlevel: 5
Starting syslogd/klogd: done
Stopping Bootlog daemon: bootlogd.

Yocto (Built by Poky 7.0.1) 1.2.1
 ttymxc0

imx53qsb login: root
Password:

root@imx53qsb:~#
root@imx53qsb:~#
root@imx53qsb:~#
root@imx53qsb:~#
root@imx53qsb:~#
root@imx53qsb:~#
root@imx53qsb:~#
root@imx53qsb:~#
root@imx53qsb:~# latency
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      1.875|      2.750|     23.500|       0|     0|      1.875|     23=
.500
RTD|      2.000|      3.250|     34.000|       0|     0|      1.875|     34=
.000
RTD|      2.000|      3.000|     30.875|       0|     0|      1.875|     34=
.000
RTD|      2.000|      3.000|     27.250|       0|     0|      1.875|     34=
.000
RTD|      2.000|      3.000|     29.625|       0|     0|      1.875|     34=
.000
RTD|      2.000|      2.875|     28.875|       0|     0|      1.875|     34=
.000
RTD|      2.000|      3.250|     33.875|       0|     0|      1.875|     34=
.000
RTD|      2.000|      2.875|     27.500|       0|     0|      1.875|     34=
.000
RTD|      2.000|      3.000|     29.375|       0|     0|      1.875|     34=
.000
RTD|      2.000|      2.875|     28.375|       0|     0|      1.875|     34=
.000
RTD|      2.000|      3.000|     28.875|       0|     0|      1.875|     34=
.000
RTD|      1.875|      3.250|     32.000|       0|     0|      1.875|     34=
.000
RTD|      2.000|      2.875|     28.375|       0|     0|      1.875|     34=
.000
RTD|      2.000|      3.000|     37.875|       0|     0|      1.875|     37=
.875
RTD|      2.000|      4.625|     40.375|       0|     0|      1.875|     40=
.375
RTD|      1.875|      2.875|     33.750|       0|     0|      1.875|     40=
.375
RTD|      2.000|      3.250|     34.750|       0|     0|      1.875|     40=
.375
RTD|      2.000|      2.875|     30.375|       0|     0|      1.875|     40=
.375
RTD|      2.000|      3.000|     31.375|       0|     0|      1.875|     40=
.375
RTD|      2.000|      2.875|     28.125|       0|     0|      1.875|     40=
.375
RTD|      2.000|      2.875|     28.375|       0|     0|      1.875|     40=
.375
RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      2.000|      3.125|     33.500|       0|     0|      1.875|     40=
.375
RTD|      2.000|      3.000|     30.375|       0|     0|      1.875|     40=
.375
RTD|      2.000|      3.000|     41.625|       0|     0|      1.875|     41=
.625
RTD|      1.875|      2.875|     30.375|       0|     0|      1.875|     41=
.625
RTD|      2.000|      3.000|     31.000|       0|     0|      1.875|     41=
.625
=03---|-----------|-----------|-----------|--------|------|----------------=
---------
RTS|      1.875|      3.000|     41.625|       0|     0|    00:00:27/00:00:=
27
root@imx53qsb:~#



>
> --
>                                                                 Gilles.



-- =

Flavio de Castro Alves Filho

flavio.alves@gmail.com
www.linuxembarcado.com
Twitter: http://twitter.com/#!/fraviofii
LinkedIn profile: www.linkedin.com/in/flaviocastroalves
-------------- next part --------------
A non-text attachment was scrubbed...
Name: defconfig_imx53
Type: application/octet-stream
Size: 63485 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20121019/c99cd39=
3/attachment.obj>
