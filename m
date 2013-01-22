In-Reply-To: <50F3DD9A.9050306@gmail.com>
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>
	<50F3DD9A.9050306@gmail.com>
MIME-Version: 1.0
Message-ID: <OF5CF00330.868585F8-ON85257AFA.00801D57-85257AFB.00000E92@aanddtech.com>
From: mfornero@aanddtech.com
Date: Mon, 21 Jan 2013 19:00:53 -0500
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Stefan Roese <stefan.roese@gmail.com> wrote on 01/14/2013 05:27:38 AM:

> From: Stefan Roese <stefan.roese@gmail.com>
> To: mfornero@aanddtech.com,=20
> Cc: Xenomai@xenomai.org
> Date: 01/14/2013 05:27 AM
> Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
>=20
> Hi Matthew,
>=20
> On 01/12/2013 06:21 PM, mfornero@aanddtech.com wrote:
> >    I'm looking for recommendations on how to best port ipipe support=20
to a
> >    new ARM SoC. The SoC has started to show up in mainline, but many=20
of
> >    the features haven't made it over yet. Xilinx maintains a git repo
> >    here:
> >=20
> >    git://git.xilinx.com/linux-xlnx.git
> >=20
> >    And it look like they've synced with mainline 3.6
> >=20
> >    The two approaches I've considered were either trying to port ipipe =

to
> >    stock 3.6 (or at least the generic and ARM bits) or trying to=20
backport
> >    the Xilinx code to 3.5.3. I started with the later approach, but=20
some
> >    changes to the common clock architecture between 3.5 and 3.6 make=20
this
> >    somewhat difficult.
> >=20
> >    Any thoughts on which approach would be better?
>=20
> I'm also working on supporting Zynq in I-pipe. My approach was to use
> the Xilinx 3.5.0 code version (git tag "xilinx-14.3-build2"). And port
> the I-pipe version from Gilles git repository to it. I still need to do
> some cleanup then I can send you the latest version.
>=20
> Best regards,
> Stefan
>=20
>=20

Hello All,

I've followed a similar approach to Stefan since my previous email, and=20
have a somewhat working port of Xenomai now running on the Zynq Board. We=20
are currently using a ZedBoard, instead of the Xilinx ZC702 eval board,=20
but the processor core section should be almost identical.

My build is mostly working, but I am running into issues with the SDHC=20
controller shortly after booting. It appears that controller stops getting =

interrupts and eventually locks up the system. If I turn off Xenomai in=20
the kernel config, the issue goes away. Haven't tried Xenomai as a=20
loadable module yet.

The issue seems to be somewhat erratic, as I was able to run the latency=20
test for a couple of hours this morning without observing it. Now however, =

it seems to show up on every boot (I don't believe I changed anything, but =

it's possible).

For reference, I'm booting from a SDHC partitioned as such:
        1) vfat         256 MB <-- This partition holds the first stage=20
bootloader, uboot, the device tree and the Kernel zImage
        2) ext4         768 MB <-- This partition is the rootfs (busybox + =

xenomai)

The kernel boot command line is:
        bootargs =3D "console=3DttyPS0,115200 root=3D/dev/mmcblk0p2 rw=20
earlyprintk rootfstype=3Dext4 rootwait devtmpfs.mount=3D1";

And I'm using the uboot compilation shipped with the ZedBoard.

My ipipe port can be found here:
git://github.com/mfornero/ipipe.git

Best Regards,

Matthew Fornero

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Warning before hang
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

mmc0: Timeout waiting for hardware interrupt.
------------[ cut here ]------------
WARNING: at drivers/mmc/host/sdhci.c:963 sdhci=5Fsend=5Fcommand+0x28/0xbb8()
Modules linked in:
[<c0013ea8>] (unwind=5Fbacktrace+0x0/0x11c) from [<c0021524>]=20
(warn=5Fslowpath=5Fcommon+0x4c/0x64)
[<c0021524>] (warn=5Fslowpath=5Fcommon+0x4c/0x64) from [<c0021554>]=20
(warn=5Fslowpath=5Fnull+0x18/0x1c)
[<c0021554>] (warn=5Fslowpath=5Fnull+0x18/0x1c) from [<c0318150>]=20
(sdhci=5Fsend=5Fcommand+0x28/0xbb8)
[<c0318150>] (sdhci=5Fsend=5Fcommand+0x28/0xbb8) from [<c0319574>]=20
(sdhci=5Ffinish=5Fdata+0x2b4/0x2e8)
[<c0319574>] (sdhci=5Ffinish=5Fdata+0x2b4/0x2e8) from [<c0319608>]=20
(sdhci=5Ftimeout=5Ftimer+0x60/0xac)
[<c0319608>] (sdhci=5Ftimeout=5Ftimer+0x60/0xac) from [<c002d0e8>]=20
(run=5Ftimer=5Fsoftirq+0x17c/0x234)
[<c002d0e8>] (run=5Ftimer=5Fsoftirq+0x17c/0x234) from [<c00279dc>]=20
(=5F=5Fdo=5Fsoftirq+0xb4/0x160)
[<c00279dc>] (=5F=5Fdo=5Fsoftirq+0xb4/0x160) from [<c0027ee4>]=20
(irq=5Fexit+0x48/0xa0)
[<c0027ee4>] (irq=5Fexit+0x48/0xa0) from [<c000edd0>] (handle=5FIRQ+0x8c/0x=
d0)
[<c000edd0>] (handle=5FIRQ+0x8c/0xd0) from [<c0067ca4>]=20
(=5F=5Fipipe=5Fdo=5Fsync=5Fstage+0x1c8/0x214)
[<c0067ca4>] (=5F=5Fipipe=5Fdo=5Fsync=5Fstage+0x1c8/0x214) from [<c000840c>=
]=20
(=5F=5Fipipe=5Fgrab=5Firq+0x70/0x88)
[<c000840c>] (=5F=5Fipipe=5Fgrab=5Firq+0x70/0x88) from [<c00085bc>]=20
(gic=5Fhandle=5Firq+0x38/0x5c)
Exception stack(0xde867f90 to 0xde867fd8)
7f80:                                     c000f0ec c001bdc8 60000013=20
c000e000
7fa0: 00000000 00543000 00000001 00000000 1e85c06a 00000015 10c0387d=20
c05a6b64
7fc0: 0000406a 413fc090 00000000 00000000 00000000 de867fe8
[<c00085bc>] (gic=5Fhandle=5Firq+0x38/0x5c) from [<c000e000>]=20
(=5F=5Firq=5Fsvc+0x40/0x6c)
Exception stack(0xde867fa0 to 0xde867fe8)
7fa0: 00000000 00543000 00000001 00000000 1e85c06a 00000015 10c0387d=20
c05a6b64
7fc0: 0000406a 413fc090 00000000 00000000 00000000 de867fe8 c000f0ec=20
c001bdc8
7fe0: 60000013 ffffffff
[<c000e000>] (=5F=5Firq=5Fsvc+0x40/0x6c) from [<c001bdc8>]=20
(cpu=5Fv7=5Fdo=5Fidle+0x8/0xc)
---[ end trace 321451b5cef4ef74 ]---


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Software Versions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Xenomai: git://git.xenomai.org/xenomai-head.git
                commit c6a53047d1ba3182d8d93d892adf80efbb02932c
                Author: Jan Kiszka <jan.kiszka@siemens.com>
                Date:   Fri Jan 18 19:01:04 2013 +0100

Ipipe: git://git.denx.de/ipipe.git [The commit I rebased the xilinx work=20
against]
        commit 1048e16bca4d22f7f14adfcc9ea5103d774d8595
        Author: Jan Kiszka <jan.kiszka@siemens.com>
        Date:   Fri Jan 18 16:38:00 2013 +0100

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Boot Log
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Xilinx First Stage Boot Loader
Release 14.3 Jan  4 2013-14:54:20
Devcfg driver initialized
Silicon Version 1.0
Boot mode is SD
SD Init Done
Flash BaseAddress E0100000
Reboot status register 0x60000000
ImageStartAddress =3D 00000000
PartitionNumber =3D 00000000
flash read base addr E0100000, image base 0
FSBL main: Skip partition
Reboot status register 0x61000000
ImageStartAddress =3D 00000000
PartitionNumber =3D 00000001
flash read base addr E0100000, image base 0
Reset USB...
SUCCESSFUL=5FHANDOFF
  FSBLStatus =3D 0x1


U-Boot 2012.04.01 (Jan 07 2013 - 13:42:00)

DRAM:  512 MiB
WARNING: Caches not enabled
MMC:   SDHCI: 0
Using default environment

In:    serial
Out:   serial
Err:   serial
Net:   zynq=5Fgem
Hit any key to stop autoboot:  0
Copying Linux from SD to RAM...
Device: SDHCI
Manufacturer ID: 1b
OEM: 534d
Name: 00000
Tran Speed: 25000000
Rd Block Len: 512
SD version 2.0
High Capacity: Yes
Capacity: 7.6 GiB
Bus Width: 4-bit
reading zImage

2992664 bytes read
reading devicetree.dtb

9652 bytes read

## Starting application at 0x00008000 ...
Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.5.7-14.3-build2-00291-gd1b9d48-dirty=20
(mfornero@hwbuild.andt.local) (gcc version 4.6.1 (Sourcery CodeBench Lite=20
2011.09-70) ) #1 SMP PREEMPT Mon Jan 21 18:34:31 EST 2013
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=3D18c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Xilinx Zynq Platform, model: Xilinx Zynq ZED
bootconsole [earlycon0] enabled
cma: CMA: reserved 16 MiB at 1f000000
Memory policy: ECC disabled, Data cache writealloc
PERCPU: Embedded 9 pages/cpu @c0a8b000 s13248 r8192 d15424 u36864
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:=20
129920
Kernel command line: console=3DttyPS0,115200 root=3D/dev/mmcblk0p2 rw=20
earlyprintk rootfstype=3Dext4 rootwait devtmpfs.mount=3D1
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 512MB =3D 512MB total
Memory: 496564k/496564k available, 27724k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc052352c   (5230 kB)
      .init : 0xc0524000 - 0xc05543c0   ( 193 kB)
      .data : 0xc0556000 - 0xc05a6720   ( 322 kB)
       .bss : 0xc05a6744 - 0xc0602284   ( 367 kB)
Preemptible hierarchical RCU implementation.
        Dump stacks of tasks blocking RCU-preempt GP.
NR=5FIRQS:512
Zynq clock init
xlnx,ps7-ttc-1.00.a #0 at 0xe0800000, irq=3D43
I-pipe, 333.333 MHz clocksource
sched=5Fclock: 32 bits at 100 Hz, resolution 10000000ns, wraps every=20
4294967286ms
Interrupt pipeline (release #2)
Console: colour dummy device 80x30
Calibrating delay loop... 1332.01 BogoMIPS (lpj=3D6660096)
pid=5Fmax: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
I-pipe, 333.333 MHz timer
hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 counters=20
available
Setting up static identity map for 0x3d3080 - 0x3d30b4
L310 cache controller enabled
l2x0: 8 ways, CACHE=5FID 0x410000c8, AUX=5FCTRL 0x72360000, Cache size: 524=
288=20
B
Map SLCR registers
CPU1: Booted secondary processor
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
I-pipe, 333.333 MHz timer
Brought up 2 CPUs
SMP: Total of 2 processors activated (2664.03 BogoMIPS).
devtmpfs: initialized
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
xgpiops e000a000.ps7-gpio: gpio at 0xe000a000 mapped to 0xe0808000
registering platform device 'pl330' id 0
registering platform device 'arm-pmu' id 0
registering platform device 'zynq-dvfs' id 0
hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint=20
registers.
hw-breakpoint: maximum watchpoint size is 4 bytes.
xslcr xslcr.0: at 0xF8000000 mapped to 0xF8000000
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Linux video capture interface: v2.00
Switching to clocksource ipipe=5Ftsc
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 5, 196608 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP: reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pl330 dev 0 probe success
I-pipe: head domain Xenomai registered.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.6.2 (Day At The Beach) loaded.
Xenomai: debug mode enabled.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 1001
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
e0001=AC=CB=BD=B1[ttyPS0] enabled, bootconsole disabled
console [ttyPS0] enabled, bootconsole disabled
xdevcfg f8007000.ps7-dev-cfg: ioremap f8007000 to e08a2000 with size 1000
brd: module loaded
loop: module loaded
xqspips e000d000.ps7-qspi: master is unqueued, this is deprecated
xqspips e000d000.ps7-qspi: at 0xE000D000 mapped to 0xE08A4000, irq=3D51
XEMACPS mii bus: probed
xemacps e000b000.ps7-ethernet: pdev->id -1, baseaddr 0xe000b000, irq 54
ehci=5Fhcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
xusbps-ehci xusbps-ehci.0: Xilinx PS USB EHCI Host Controller
xusbps-ehci xusbps-ehci.0: new USB bus registered, assigned bus number 1
xusbps-ehci xusbps-ehci.0: irq 53, io mem 0x00000000
xusbps-ehci xusbps-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
Xilinx PS USB Device Controller driver (Apr 01, 2011)
mousedev: PS/2 mouse device common for all mice
i2c /dev entries driver
gspca=5Fmain: v2.14.0 registered
usbcore: registered new interface driver uvcvideo
USB Video Class driver (1.1.1)
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: Invalid maximum block size, assuming 512 bytes
mmc0: SDHCI controller on e0100000.ps7-sdio [e0100000.ps7-sdio] using ADMA
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
Registering SWP/SWPB emulation handler
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Waiting for root device /dev/mmcblk0p2...
mmc0: new high speed SDHC card at address 0001
mmcblk0: mmc0:0001 00000 7.60 GiB
 mmcblk0: p1 p2
EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts:=20
(null)
VFS: Mounted root (ext4 filesystem) on device 179:2.
devtmpfs: mounted
Freeing init memory: 192K
Starting rcS...
++ Mounting filesystem
++ Setting up mdev
++ Starting network
++ Starting telnet daemon
++ Starting http daemon
++ Starting ftp daemon
++ Starting dropbear (ssh) daemon
rcS Complete
xemacps e000b000.ps7-ethernet: Set clk to 124999998 Hz
xemacps e000b000.ps7-ethernet: link up (1000/FULL)
mmc0: Timeout waiting for hardware interrupt.
------------[ cut here ]------------
WARNING: at drivers/mmc/host/sdhci.c:963 sdhci=5Fsend=5Fcommand+0x28/0xbb8()
Modules linked in:
[<c0013ea8>] (unwind=5Fbacktrace+0x0/0x11c) from [<c0021524>]=20
(warn=5Fslowpath=5Fcommon+0x4c/0x64)
[<c0021524>] (warn=5Fslowpath=5Fcommon+0x4c/0x64) from [<c0021554>]=20
(warn=5Fslowpath=5Fnull+0x18/0x1c)
[<c0021554>] (warn=5Fslowpath=5Fnull+0x18/0x1c) from [<c0318150>]=20
(sdhci=5Fsend=5Fcommand+0x28/0xbb8)
[<c0318150>] (sdhci=5Fsend=5Fcommand+0x28/0xbb8) from [<c0319574>]=20
(sdhci=5Ffinish=5Fdata+0x2b4/0x2e8)
[<c0319574>] (sdhci=5Ffinish=5Fdata+0x2b4/0x2e8) from [<c0319608>]=20
(sdhci=5Ftimeout=5Ftimer+0x60/0xac)
[<c0319608>] (sdhci=5Ftimeout=5Ftimer+0x60/0xac) from [<c002d0e8>]=20
(run=5Ftimer=5Fsoftirq+0x17c/0x234)
[<c002d0e8>] (run=5Ftimer=5Fsoftirq+0x17c/0x234) from [<c00279dc>]=20
(=5F=5Fdo=5Fsoftirq+0xb4/0x160)
[<c00279dc>] (=5F=5Fdo=5Fsoftirq+0xb4/0x160) from [<c0027ee4>]=20
(irq=5Fexit+0x48/0xa0)
[<c0027ee4>] (irq=5Fexit+0x48/0xa0) from [<c000edd0>] (handle=5FIRQ+0x8c/0x=
d0)
[<c000edd0>] (handle=5FIRQ+0x8c/0xd0) from [<c0067ca4>]=20
(=5F=5Fipipe=5Fdo=5Fsync=5Fstage+0x1c8/0x214)
[<c0067ca4>] (=5F=5Fipipe=5Fdo=5Fsync=5Fstage+0x1c8/0x214) from [<c000840c>=
]=20
(=5F=5Fipipe=5Fgrab=5Firq+0x70/0x88)
[<c000840c>] (=5F=5Fipipe=5Fgrab=5Firq+0x70/0x88) from [<c00085bc>]=20
(gic=5Fhandle=5Firq+0x38/0x5c)
Exception stack(0xde867f90 to 0xde867fd8)
7f80:                                     c000f0ec c001bdc8 60000013=20
c000e000
7fa0: 00000000 00543000 00000001 00000000 1e85c06a 00000015 10c0387d=20
c05a6b64
7fc0: 0000406a 413fc090 00000000 00000000 00000000 de867fe8
[<c00085bc>] (gic=5Fhandle=5Firq+0x38/0x5c) from [<c000e000>]=20
(=5F=5Firq=5Fsvc+0x40/0x6c)
Exception stack(0xde867fa0 to 0xde867fe8)
7fa0: 00000000 00543000 00000001 00000000 1e85c06a 00000015 10c0387d=20
c05a6b64
7fc0: 0000406a 413fc090 00000000 00000000 00000000 de867fe8 c000f0ec=20
c001bdc8
7fe0: 60000013 ffffffff
[<c000e000>] (=5F=5Firq=5Fsvc+0x40/0x6c) from [<c001bdc8>]=20
(cpu=5Fv7=5Fdo=5Fidle+0x8/0xc)
---[ end trace 321451b5cef4ef74 ]---
mmc0: Timeout waiting for hardware interrupt.
mmc0: Timeout waiting for hardware interrupt.
mmcblk0: error -110 sending status command, retrying

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Kernel Config
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#
# Automatically generated file; DO NOT EDIT.
# Linux/arm 3.5.7-14.3-build2 Kernel Configuration
#
CONFIG=5FARM=3Dy
CONFIG=5FMIGHT=5FHAVE=5FPCI=3Dy
CONFIG=5FSYS=5FSUPPORTS=5FAPM=5FEMULATION=3Dy
CONFIG=5FGENERIC=5FGPIO=3Dy
CONFIG=5FHAVE=5FPROC=5FCPU=3Dy
CONFIG=5FSTACKTRACE=5FSUPPORT=3Dy
CONFIG=5FLOCKDEP=5FSUPPORT=3Dy
CONFIG=5FTRACE=5FIRQFLAGS=5FSUPPORT=3Dy
CONFIG=5FGENERIC=5FLOCKBREAK=3Dy
CONFIG=5FRWSEM=5FGENERIC=5FSPINLOCK=3Dy
CONFIG=5FARCH=5FHAS=5FCPUFREQ=3Dy
CONFIG=5FGENERIC=5FHWEIGHT=3Dy
CONFIG=5FGENERIC=5FCALIBRATE=5FDELAY=3Dy
CONFIG=5FNEED=5FDMA=5FMAP=5FSTATE=3Dy
CONFIG=5FVECTORS=5FBASE=3D0xffff0000
# CONFIG=5FARM=5FPATCH=5FPHYS=5FVIRT is not set
CONFIG=5FPHYS=5FOFFSET=3D0x0
CONFIG=5FGENERIC=5FBUG=3Dy
CONFIG=5FDEFCONFIG=5FLIST=3D"/lib/modules/$UNAME=5FRELEASE/.config"
CONFIG=5FHAVE=5FIRQ=5FWORK=3Dy
CONFIG=5FIRQ=5FWORK=3Dy

#
# General setup
#
CONFIG=5FEXPERIMENTAL=3Dy
CONFIG=5FINIT=5FENV=5FARG=5FLIMIT=3D32
CONFIG=5FCROSS=5FCOMPILE=3D"-xeno-2.6"
CONFIG=5FLOCALVERSION=3D""
CONFIG=5FLOCALVERSION=5FAUTO=3Dy
CONFIG=5FHAVE=5FKERNEL=5FGZIP=3Dy
CONFIG=5FHAVE=5FKERNEL=5FLZMA=3Dy
CONFIG=5FHAVE=5FKERNEL=5FXZ=3Dy
CONFIG=5FHAVE=5FKERNEL=5FLZO=3Dy
CONFIG=5FKERNEL=5FGZIP=3Dy
# CONFIG=5FKERNEL=5FLZMA is not set
# CONFIG=5FKERNEL=5FXZ is not set
# CONFIG=5FKERNEL=5FLZO is not set
CONFIG=5FDEFAULT=5FHOSTNAME=3D"(none)"
CONFIG=5FSWAP=3Dy
CONFIG=5FSYSVIPC=3Dy
CONFIG=5FSYSVIPC=5FSYSCTL=3Dy
# CONFIG=5FPOSIX=5FMQUEUE is not set
# CONFIG=5FBSD=5FPROCESS=5FACCT is not set
# CONFIG=5FFHANDLE is not set
# CONFIG=5FTASKSTATS is not set
# CONFIG=5FAUDIT is not set
CONFIG=5FHAVE=5FGENERIC=5FHARDIRQS=3Dy

#
# IRQ subsystem
#
CONFIG=5FGENERIC=5FHARDIRQS=3Dy
CONFIG=5FGENERIC=5FIRQ=5FPROBE=3Dy
CONFIG=5FGENERIC=5FIRQ=5FSHOW=3Dy
CONFIG=5FHARDIRQS=5FSW=5FRESEND=3Dy
CONFIG=5FIRQ=5FDOMAIN=3Dy
CONFIG=5FIRQ=5FDOMAIN=5FDEBUG=3Dy
CONFIG=5FGENERIC=5FTIME=5FVSYSCALL=3Dy
CONFIG=5FKTIME=5FSCALAR=3Dy
CONFIG=5FGENERIC=5FCLOCKEVENTS=3Dy
CONFIG=5FGENERIC=5FCLOCKEVENTS=5FBUILD=3Dy
CONFIG=5FGENERIC=5FCLOCKEVENTS=5FBROADCAST=3Dy

#
# Timers subsystem
#
CONFIG=5FTICK=5FONESHOT=3Dy
CONFIG=5FNO=5FHZ=3Dy
CONFIG=5FHIGH=5FRES=5FTIMERS=3Dy

#
# RCU Subsystem
#
CONFIG=5FTREE=5FPREEMPT=5FRCU=3Dy
CONFIG=5FPREEMPT=5FRCU=3Dy
CONFIG=5FRCU=5FFANOUT=3D32
CONFIG=5FRCU=5FFANOUT=5FLEAF=3D16
# CONFIG=5FRCU=5FFANOUT=5FEXACT is not set
# CONFIG=5FRCU=5FFAST=5FNO=5FHZ is not set
# CONFIG=5FTREE=5FRCU=5FTRACE is not set
# CONFIG=5FRCU=5FBOOST is not set
CONFIG=5FIKCONFIG=3Dy
CONFIG=5FIKCONFIG=5FPROC=3Dy
CONFIG=5FLOG=5FBUF=5FSHIFT=3D14
# CONFIG=5FCGROUPS is not set
# CONFIG=5FCHECKPOINT=5FRESTORE is not set
# CONFIG=5FNAMESPACES is not set
# CONFIG=5FSCHED=5FAUTOGROUP is not set
CONFIG=5FSYSFS=5FDEPRECATED=3Dy
CONFIG=5FSYSFS=5FDEPRECATED=5FV2=3Dy
# CONFIG=5FRELAY is not set
CONFIG=5FBLK=5FDEV=5FINITRD=3Dy
CONFIG=5FINITRAMFS=5FSOURCE=3D""
CONFIG=5FRD=5FGZIP=3Dy
# CONFIG=5FRD=5FBZIP2 is not set
# CONFIG=5FRD=5FLZMA is not set
# CONFIG=5FRD=5FXZ is not set
# CONFIG=5FRD=5FLZO is not set
CONFIG=5FCC=5FOPTIMIZE=5FFOR=5FSIZE=3Dy
CONFIG=5FSYSCTL=3Dy
CONFIG=5FANON=5FINODES=3Dy
CONFIG=5FEXPERT=3Dy
CONFIG=5FUID16=3Dy
CONFIG=5FSYSCTL=5FSYSCALL=3Dy
CONFIG=5FKALLSYMS=3Dy
# CONFIG=5FKALLSYMS=5FALL is not set
CONFIG=5FHOTPLUG=3Dy
CONFIG=5FPRINTK=3Dy
CONFIG=5FBUG=3Dy
CONFIG=5FELF=5FCORE=3Dy
CONFIG=5FBASE=5FFULL=3Dy
CONFIG=5FFUTEX=3Dy
CONFIG=5FEPOLL=3Dy
CONFIG=5FSIGNALFD=3Dy
CONFIG=5FTIMERFD=3Dy
CONFIG=5FEVENTFD=3Dy
CONFIG=5FSHMEM=3Dy
CONFIG=5FAIO=3Dy
CONFIG=5FEMBEDDED=3Dy
CONFIG=5FHAVE=5FPERF=5FEVENTS=3Dy
CONFIG=5FPERF=5FUSE=5FVMALLOC=3Dy

#
# Kernel Performance Events And Counters
#
CONFIG=5FPERF=5FEVENTS=3Dy
# CONFIG=5FDEBUG=5FPERF=5FUSE=5FVMALLOC is not set
CONFIG=5FVM=5FEVENT=5FCOUNTERS=3Dy
CONFIG=5FCOMPAT=5FBRK=3Dy
CONFIG=5FSLAB=3Dy
# CONFIG=5FSLUB is not set
# CONFIG=5FSLOB is not set
# CONFIG=5FPROFILING is not set
CONFIG=5FHAVE=5FOPROFILE=3Dy
# CONFIG=5FKPROBES is not set
# CONFIG=5FJUMP=5FLABEL is not set
CONFIG=5FHAVE=5FKPROBES=3Dy
CONFIG=5FHAVE=5FKRETPROBES=3Dy
CONFIG=5FHAVE=5FARCH=5FTRACEHOOK=3Dy
CONFIG=5FHAVE=5FDMA=5FATTRS=3Dy
CONFIG=5FHAVE=5FDMA=5FCONTIGUOUS=3Dy
CONFIG=5FUSE=5FGENERIC=5FSMP=5FHELPERS=3Dy
CONFIG=5FGENERIC=5FSMP=5FIDLE=5FTHREAD=3Dy
CONFIG=5FHAVE=5FREGS=5FAND=5FSTACK=5FACCESS=5FAPI=3Dy
CONFIG=5FHAVE=5FCLK=3Dy
CONFIG=5FHAVE=5FDMA=5FAPI=5FDEBUG=3Dy
CONFIG=5FHAVE=5FHW=5FBREAKPOINT=3Dy
CONFIG=5FHAVE=5FARCH=5FJUMP=5FLABEL=3Dy

#
# GCOV-based kernel profiling
#
# CONFIG=5FGCOV=5FKERNEL is not set
CONFIG=5FHAVE=5FGENERIC=5FDMA=5FCOHERENT=3Dy
CONFIG=5FSLABINFO=3Dy
CONFIG=5FRT=5FMUTEXES=3Dy
CONFIG=5FBASE=5FSMALL=3D0
CONFIG=5FMODULES=3Dy
# CONFIG=5FMODULE=5FFORCE=5FLOAD is not set
CONFIG=5FMODULE=5FUNLOAD=3Dy
CONFIG=5FMODULE=5FFORCE=5FUNLOAD=3Dy
CONFIG=5FMODVERSIONS=3Dy
# CONFIG=5FMODULE=5FSRCVERSION=5FALL is not set
CONFIG=5FSTOP=5FMACHINE=3Dy
CONFIG=5FBLOCK=3Dy
CONFIG=5FLBDAF=3Dy
# CONFIG=5FBLK=5FDEV=5FBSG is not set
# CONFIG=5FBLK=5FDEV=5FBSGLIB is not set
# CONFIG=5FBLK=5FDEV=5FINTEGRITY is not set

#
# Partition Types
#
# CONFIG=5FPARTITION=5FADVANCED is not set
CONFIG=5FMSDOS=5FPARTITION=3Dy

#
# IO Schedulers
#
CONFIG=5FIOSCHED=5FNOOP=3Dy
CONFIG=5FIOSCHED=5FDEADLINE=3Dy
CONFIG=5FIOSCHED=5FCFQ=3Dy
# CONFIG=5FDEFAULT=5FDEADLINE is not set
CONFIG=5FDEFAULT=5FCFQ=3Dy
# CONFIG=5FDEFAULT=5FNOOP is not set
CONFIG=5FDEFAULT=5FIOSCHED=3D"cfq"
# CONFIG=5FINLINE=5FSPIN=5FTRYLOCK is not set
# CONFIG=5FINLINE=5FSPIN=5FTRYLOCK=5FBH is not set
# CONFIG=5FINLINE=5FSPIN=5FLOCK is not set
# CONFIG=5FINLINE=5FSPIN=5FLOCK=5FBH is not set
# CONFIG=5FINLINE=5FSPIN=5FLOCK=5FIRQ is not set
# CONFIG=5FINLINE=5FSPIN=5FLOCK=5FIRQSAVE is not set
CONFIG=5FUNINLINE=5FSPIN=5FUNLOCK=3Dy
# CONFIG=5FINLINE=5FSPIN=5FUNLOCK=5FBH is not set
# CONFIG=5FINLINE=5FSPIN=5FUNLOCK=5FIRQ is not set
# CONFIG=5FINLINE=5FSPIN=5FUNLOCK=5FIRQRESTORE is not set
# CONFIG=5FINLINE=5FREAD=5FTRYLOCK is not set
# CONFIG=5FINLINE=5FREAD=5FLOCK is not set
# CONFIG=5FINLINE=5FREAD=5FLOCK=5FBH is not set
# CONFIG=5FINLINE=5FREAD=5FLOCK=5FIRQ is not set
# CONFIG=5FINLINE=5FREAD=5FLOCK=5FIRQSAVE is not set
# CONFIG=5FINLINE=5FREAD=5FUNLOCK is not set
# CONFIG=5FINLINE=5FREAD=5FUNLOCK=5FBH is not set
# CONFIG=5FINLINE=5FREAD=5FUNLOCK=5FIRQ is not set
# CONFIG=5FINLINE=5FREAD=5FUNLOCK=5FIRQRESTORE is not set
# CONFIG=5FINLINE=5FWRITE=5FTRYLOCK is not set
# CONFIG=5FINLINE=5FWRITE=5FLOCK is not set
# CONFIG=5FINLINE=5FWRITE=5FLOCK=5FBH is not set
# CONFIG=5FINLINE=5FWRITE=5FLOCK=5FIRQ is not set
# CONFIG=5FINLINE=5FWRITE=5FLOCK=5FIRQSAVE is not set
# CONFIG=5FINLINE=5FWRITE=5FUNLOCK is not set
# CONFIG=5FINLINE=5FWRITE=5FUNLOCK=5FBH is not set
# CONFIG=5FINLINE=5FWRITE=5FUNLOCK=5FIRQ is not set
# CONFIG=5FINLINE=5FWRITE=5FUNLOCK=5FIRQRESTORE is not set
CONFIG=5FMUTEX=5FSPIN=5FON=5FOWNER=3Dy

#
# Real-time sub-system
#
CONFIG=5FXENOMAI=3Dy
CONFIG=5FXENO=5FGENERIC=5FSTACKPOOL=3Dy
CONFIG=5FXENO=5FFASTSYNCH=5FDEP=3Dy
CONFIG=5FXENO=5FFASTSYNCH=3Dy
CONFIG=5FXENO=5FOPT=5FNUCLEUS=3Dy
CONFIG=5FXENO=5FOPT=5FPERVASIVE=3Dy
# CONFIG=5FXENO=5FOPT=5FPRIOCPL is not set
CONFIG=5FXENO=5FOPT=5FPIPELINE=5FHEAD=3Dy
# CONFIG=5FXENO=5FOPT=5FSCHED=5FCLASSES is not set
CONFIG=5FXENO=5FOPT=5FPIPE=3Dy
CONFIG=5FXENO=5FOPT=5FVFILE=3Dy
CONFIG=5FXENO=5FOPT=5FPIPE=5FNRDEV=3D32
CONFIG=5FXENO=5FOPT=5FREGISTRY=5FNRSLOTS=3D512
CONFIG=5FXENO=5FOPT=5FSYS=5FHEAPSZ=3D256
CONFIG=5FXENO=5FOPT=5FSYS=5FSTACKPOOLSZ=3D128
CONFIG=5FXENO=5FOPT=5FSEM=5FHEAPSZ=3D12
CONFIG=5FXENO=5FOPT=5FGLOBAL=5FSEM=5FHEAPSZ=3D12
CONFIG=5FXENO=5FOPT=5FSTATS=3Dy
CONFIG=5FXENO=5FOPT=5FDEBUG=3Dy
# CONFIG=5FXENO=5FOPT=5FDEBUG=5FNUCLEUS is not set
CONFIG=5FXENO=5FOPT=5FDEBUG=5FXNLOCK=3Dy
# CONFIG=5FXENO=5FOPT=5FDEBUG=5FQUEUES is not set
# CONFIG=5FXENO=5FOPT=5FDEBUG=5FREGISTRY is not set
# CONFIG=5FXENO=5FOPT=5FDEBUG=5FTIMERS is not set
CONFIG=5FXENO=5FOPT=5FDEBUG=5FSYNCH=5FRELAX=3Dy
CONFIG=5FXENO=5FOPT=5FWATCHDOG=3Dy
CONFIG=5FXENO=5FOPT=5FWATCHDOG=5FTIMEOUT=3D4
# CONFIG=5FXENO=5FOPT=5FSHIRQ is not set
CONFIG=5FXENO=5FOPT=5FSELECT=3Dy
CONFIG=5FXENO=5FOPT=5FHOSTRT=3Dy

#
# Timing
#
# CONFIG=5FXENO=5FOPT=5FTIMING=5FPERIODIC is not set
CONFIG=5FXENO=5FOPT=5FTIMING=5FVIRTICK=3D1000
CONFIG=5FXENO=5FOPT=5FTIMING=5FSCHEDLAT=3D0

#
# Scalability
#
# CONFIG=5FXENO=5FOPT=5FSCALABLE=5FSCHED is not set
CONFIG=5FXENO=5FOPT=5FTIMER=5FLIST=3Dy
# CONFIG=5FXENO=5FOPT=5FTIMER=5FHEAP is not set
# CONFIG=5FXENO=5FOPT=5FTIMER=5FWHEEL is not set

#
# Machine
#
CONFIG=5FIPIPE=5FWANT=5FPREEMPTIBLE=5FSWITCH=3Dy
CONFIG=5FIPIPE=5FWANT=5FACTIVE=5FMM=3Dy
CONFIG=5FSELECT=5FHW=5FUNLOCKED=5FSWITCH=5FON=5FSMP=3Dy
CONFIG=5FXENO=5FHW=5FFPU=3Dy
CONFIG=5FXENO=5FHW=5FUNLOCKED=5FSWITCH=3Dy

#
# Interfaces
#
CONFIG=5FXENO=5FSKIN=5FNATIVE=3Dy
CONFIG=5FXENO=5FOPT=5FNATIVE=5FPERIOD=3D0
CONFIG=5FXENO=5FOPT=5FNATIVE=5FPIPE=3Dy
CONFIG=5FXENO=5FOPT=5FNATIVE=5FPIPE=5FBUFSZ=3D1024
CONFIG=5FXENO=5FOPT=5FNATIVE=5FSEM=3Dy
CONFIG=5FXENO=5FOPT=5FNATIVE=5FEVENT=3Dy
CONFIG=5FXENO=5FOPT=5FNATIVE=5FMUTEX=3Dy
CONFIG=5FXENO=5FOPT=5FNATIVE=5FCOND=3Dy
CONFIG=5FXENO=5FOPT=5FNATIVE=5FQUEUE=3Dy
CONFIG=5FXENO=5FOPT=5FNATIVE=5FBUFFER=3Dy
CONFIG=5FXENO=5FOPT=5FNATIVE=5FHEAP=3Dy
CONFIG=5FXENO=5FOPT=5FNATIVE=5FALARM=3Dy
CONFIG=5FXENO=5FOPT=5FNATIVE=5FMPS=3Dy
# CONFIG=5FXENO=5FOPT=5FNATIVE=5FINTR is not set
CONFIG=5FXENO=5FOPT=5FDEBUG=5FNATIVE=3Dy
CONFIG=5FXENO=5FSKIN=5FPOSIX=3Dy
CONFIG=5FXENO=5FOPT=5FPOSIX=5FPERIOD=3D0
# CONFIG=5FXENO=5FOPT=5FPOSIX=5FSHM is not set
# CONFIG=5FXENO=5FOPT=5FPOSIX=5FINTR is not set
CONFIG=5FXENO=5FOPT=5FPOSIX=5FSELECT=3Dy
CONFIG=5FXENO=5FOPT=5FDEBUG=5FPOSIX=3Dy
# CONFIG=5FXENO=5FSKIN=5FPSOS is not set
# CONFIG=5FXENO=5FSKIN=5FUITRON is not set
# CONFIG=5FXENO=5FSKIN=5FVRTX is not set
# CONFIG=5FXENO=5FSKIN=5FVXWORKS is not set
# CONFIG=5FXENO=5FOPT=5FNOWARN=5FDEPRECATED is not set
CONFIG=5FXENO=5FSKIN=5FRTDM=3Dy
CONFIG=5FXENO=5FOPT=5FRTDM=5FPERIOD=3D0
CONFIG=5FXENO=5FOPT=5FRTDM=5FFILDES=3D128
CONFIG=5FXENO=5FOPT=5FRTDM=5FSELECT=3Dy
# CONFIG=5FXENO=5FOPT=5FDEBUG=5FRTDM is not set
CONFIG=5FXENO=5FOPT=5FDEBUG=5FRTDM=5FAPPL=3Dy

#
# Drivers
#

#
# Serial drivers
#
# CONFIG=5FXENO=5FDRIVERS=5F16550A is not set

#
# Testing drivers
#
CONFIG=5FXENO=5FDRIVERS=5FTIMERBENCH=3Dy
# CONFIG=5FXENO=5FDRIVERS=5FKLATENCY is not set
# CONFIG=5FXENO=5FDRIVERS=5FIRQBENCH is not set
CONFIG=5FXENO=5FDRIVERS=5FSWITCHTEST=3Dy
# CONFIG=5FXENO=5FDRIVERS=5FRTDMTEST is not set

#
# CAN drivers
#
# CONFIG=5FXENO=5FDRIVERS=5FCAN is not set

#
# ANALOGY drivers
#
# CONFIG=5FXENO=5FDRIVERS=5FANALOGY is not set

#
# Real-time IPC drivers
#
# CONFIG=5FXENO=5FDRIVERS=5FRTIPC is not set
# CONFIG=5FFREEZER is not set

#
# System Type
#
CONFIG=5FMMU=3Dy
# CONFIG=5FARCH=5FINTEGRATOR is not set
# CONFIG=5FARCH=5FREALVIEW is not set
# CONFIG=5FARCH=5FVERSATILE is not set
# CONFIG=5FARCH=5FVEXPRESS is not set
# CONFIG=5FARCH=5FAT91 is not set
# CONFIG=5FARCH=5FBCMRING is not set
# CONFIG=5FARCH=5FHIGHBANK is not set
# CONFIG=5FARCH=5FCLPS711X is not set
# CONFIG=5FARCH=5FCNS3XXX is not set
# CONFIG=5FARCH=5FGEMINI is not set
# CONFIG=5FARCH=5FPRIMA2 is not set
# CONFIG=5FARCH=5FEBSA110 is not set
# CONFIG=5FARCH=5FEP93XX is not set
# CONFIG=5FARCH=5FFOOTBRIDGE is not set
# CONFIG=5FARCH=5FMXC is not set
# CONFIG=5FARCH=5FMXS is not set
# CONFIG=5FARCH=5FNETX is not set
# CONFIG=5FARCH=5FH720X is not set
# CONFIG=5FARCH=5FIOP13XX is not set
# CONFIG=5FARCH=5FIOP32X is not set
# CONFIG=5FARCH=5FIOP33X is not set
# CONFIG=5FARCH=5FIXP4XX is not set
# CONFIG=5FARCH=5FDOVE is not set
# CONFIG=5FARCH=5FKIRKWOOD is not set
# CONFIG=5FARCH=5FLPC32XX is not set
# CONFIG=5FARCH=5FMV78XX0 is not set
# CONFIG=5FARCH=5FORION5X is not set
# CONFIG=5FARCH=5FMMP is not set
# CONFIG=5FARCH=5FKS8695 is not set
# CONFIG=5FARCH=5FW90X900 is not set
# CONFIG=5FARCH=5FTEGRA is not set
# CONFIG=5FARCH=5FPICOXCELL is not set
# CONFIG=5FARCH=5FPNX4008 is not set
# CONFIG=5FARCH=5FPXA is not set
# CONFIG=5FARCH=5FMSM is not set
# CONFIG=5FARCH=5FSHMOBILE is not set
# CONFIG=5FARCH=5FRPC is not set
# CONFIG=5FARCH=5FSA1100 is not set
# CONFIG=5FARCH=5FS3C24XX is not set
# CONFIG=5FARCH=5FS3C64XX is not set
# CONFIG=5FARCH=5FS5P64X0 is not set
# CONFIG=5FARCH=5FS5PC100 is not set
# CONFIG=5FARCH=5FS5PV210 is not set
# CONFIG=5FARCH=5FEXYNOS is not set
# CONFIG=5FARCH=5FSHARK is not set
# CONFIG=5FARCH=5FU300 is not set
# CONFIG=5FARCH=5FU8500 is not set
# CONFIG=5FARCH=5FNOMADIK is not set
# CONFIG=5FARCH=5FDAVINCI is not set
# CONFIG=5FARCH=5FOMAP is not set
# CONFIG=5FPLAT=5FSPEAR is not set
# CONFIG=5FARCH=5FVT8500 is not set
CONFIG=5FARCH=5FZYNQ=3Dy
# CONFIG=5FGPIO=5FPCA953X is not set
# CONFIG=5FKEYBOARD=5FGPIO=5FPOLLED is not set

#
# Xilinx Specific Options
#
CONFIG=5FZYNQ=5FEARLY=5FUART1=3Dy
# CONFIG=5FZYNQ=5FEARLY=5FUART=5FEP107 is not set
CONFIG=5FXILINX=5FFIXED=5FDEVTREE=5FADDR=3Dy
CONFIG=5FXILINX=5FL1=5FPREFETCH=3Dy
CONFIG=5FXILINX=5FL2=5FPREFETCH=3Dy
# CONFIG=5FXILINX=5FTEST is not set
# CONFIG=5FXILINX=5FAXIPCIE is not set
CONFIG=5FIPIPE=5FARM=5FKUSER=5FTSC=3Dy

#
# Processor Type
#
CONFIG=5FCPU=5FV7=3Dy
CONFIG=5FCPU=5F32v6K=3Dy
CONFIG=5FCPU=5F32v7=3Dy
CONFIG=5FCPU=5FABRT=5FEV7=3Dy
CONFIG=5FCPU=5FPABRT=5FV7=3Dy
CONFIG=5FCPU=5FCACHE=5FV7=3Dy
CONFIG=5FCPU=5FCACHE=5FVIPT=3Dy
CONFIG=5FCPU=5FCOPY=5FV6=3Dy
CONFIG=5FCPU=5FTLB=5FV7=3Dy
CONFIG=5FCPU=5FHAS=5FASID=3Dy
CONFIG=5FCPU=5FCP15=3Dy
CONFIG=5FCPU=5FCP15=5FMMU=3Dy

#
# Processor Features
#
# CONFIG=5FARM=5FLPAE is not set
# CONFIG=5FARCH=5FPHYS=5FADDR=5FT=5F64BIT is not set
CONFIG=5FARM=5FTHUMB=3Dy
# CONFIG=5FARM=5FTHUMBEE is not set
CONFIG=5FSWP=5FEMULATE=3Dy
# CONFIG=5FCPU=5FICACHE=5FDISABLE is not set
# CONFIG=5FCPU=5FDCACHE=5FDISABLE is not set
# CONFIG=5FCPU=5FBPREDICT=5FDISABLE is not set
CONFIG=5FOUTER=5FCACHE=3Dy
CONFIG=5FOUTER=5FCACHE=5FSYNC=3Dy
CONFIG=5FCACHE=5FL2X0=3Dy
CONFIG=5FCACHE=5FPL310=3Dy
CONFIG=5FARM=5FL1=5FCACHE=5FSHIFT=5F6=3Dy
CONFIG=5FARM=5FL1=5FCACHE=5FSHIFT=3D6
CONFIG=5FARM=5FDMA=5FMEM=5FBUFFERABLE=3Dy
CONFIG=5FARM=5FNR=5FBANKS=3D8
CONFIG=5FCPU=5FHAS=5FPMU=3Dy
CONFIG=5FMULTI=5FIRQ=5FHANDLER=3Dy
# CONFIG=5FARM=5FERRATA=5F430973 is not set
# CONFIG=5FARM=5FERRATA=5F458693 is not set
# CONFIG=5FARM=5FERRATA=5F460075 is not set
# CONFIG=5FARM=5FERRATA=5F742230 is not set
# CONFIG=5FARM=5FERRATA=5F742231 is not set
CONFIG=5FPL310=5FERRATA=5F588369=3Dy
# CONFIG=5FARM=5FERRATA=5F720789 is not set
CONFIG=5FPL310=5FERRATA=5F727915=3Dy
# CONFIG=5FARM=5FERRATA=5F743622 is not set
# CONFIG=5FARM=5FERRATA=5F751472 is not set
CONFIG=5FPL310=5FERRATA=5F753970=3Dy
# CONFIG=5FARM=5FERRATA=5F754322 is not set
# CONFIG=5FARM=5FERRATA=5F754327 is not set
# CONFIG=5FARM=5FERRATA=5F764369 is not set
CONFIG=5FPL310=5FERRATA=5F769419=3Dy
CONFIG=5FARM=5FGIC=3Dy
CONFIG=5FICST=3Dy

#
# Bus support
#
CONFIG=5FARM=5FAMBA=3Dy
CONFIG=5FISA=5FDMA=5FAPI=3Dy
# CONFIG=5FPCI is not set
# CONFIG=5FPCI=5FSYSCALL is not set
# CONFIG=5FARCH=5FSUPPORTS=5FMSI is not set
# CONFIG=5FPCCARD is not set

#
# Kernel Features
#
CONFIG=5FHAVE=5FSMP=3Dy
CONFIG=5FSMP=3Dy
CONFIG=5FSMP=5FON=5FUP=3Dy
CONFIG=5FARM=5FCPU=5FTOPOLOGY=3Dy
CONFIG=5FSCHED=5FMC=3Dy
CONFIG=5FSCHED=5FSMT=3Dy
CONFIG=5FHAVE=5FARM=5FSCU=3Dy
# CONFIG=5FARM=5FARCH=5FTIMER is not set
CONFIG=5FHAVE=5FARM=5FTWD=3Dy
CONFIG=5FVMSPLIT=5F3G=3Dy
# CONFIG=5FVMSPLIT=5F2G is not set
# CONFIG=5FVMSPLIT=5F1G is not set
CONFIG=5FPAGE=5FOFFSET=3D0xC0000000
CONFIG=5FNR=5FCPUS=3D4
CONFIG=5FHOTPLUG=5FCPU=3Dy
CONFIG=5FLOCAL=5FTIMERS=3Dy
CONFIG=5FARCH=5FNR=5FGPIO=3D0
CONFIG=5FIPIPE=3Dy
CONFIG=5FIPIPE=5FCORE=3Dy
CONFIG=5FIPIPE=5FCORE=5FAPIREV=3D2
CONFIG=5FIPIPE=5FWANT=5FAPIREV=5F2=3Dy
CONFIG=5FIPIPE=5FTARGET=5FAPIREV=3D2
CONFIG=5FIPIPE=5FLEGACY=3Dy
CONFIG=5FIPIPE=5FHAVE=5FHOSTRT=3Dy
CONFIG=5FIPIPE=5FDELAYED=5FATOMICSW=3Dy
# CONFIG=5FPREEMPT=5FNONE is not set
# CONFIG=5FPREEMPT=5FVOLUNTARY is not set
CONFIG=5FPREEMPT=3Dy
CONFIG=5FPREEMPT=5FCOUNT=3Dy
CONFIG=5FHZ=3D100
# CONFIG=5FTHUMB2=5FKERNEL is not set
CONFIG=5FAEABI=3Dy
# CONFIG=5FOABI=5FCOMPAT is not set
# CONFIG=5FARCH=5FSPARSEMEM=5FDEFAULT is not set
# CONFIG=5FARCH=5FSELECT=5FMEMORY=5FMODEL is not set
CONFIG=5FHAVE=5FARCH=5FPFN=5FVALID=3Dy
CONFIG=5FHIGHMEM=3Dy
# CONFIG=5FHIGHPTE is not set
CONFIG=5FHW=5FPERF=5FEVENTS=3Dy
CONFIG=5FSELECT=5FMEMORY=5FMODEL=3Dy
CONFIG=5FFLATMEM=5FMANUAL=3Dy
CONFIG=5FFLATMEM=3Dy
CONFIG=5FFLAT=5FNODE=5FMEM=5FMAP=3Dy
CONFIG=5FHAVE=5FMEMBLOCK=3Dy
CONFIG=5FPAGEFLAGS=5FEXTENDED=3Dy
CONFIG=5FSPLIT=5FPTLOCK=5FCPUS=3D4
# CONFIG=5FCOMPACTION is not set
CONFIG=5FMIGRATION=3Dy
# CONFIG=5FPHYS=5FADDR=5FT=5F64BIT is not set
CONFIG=5FZONE=5FDMA=5FFLAG=3D0
CONFIG=5FBOUNCE=3Dy
CONFIG=5FVIRT=5FTO=5FBUS=3Dy
# CONFIG=5FKSM is not set
CONFIG=5FDEFAULT=5FMMAP=5FMIN=5FADDR=3D4096
CONFIG=5FCROSS=5FMEMORY=5FATTACH=3Dy
# CONFIG=5FCLEANCACHE is not set
# CONFIG=5FFRONTSWAP is not set
CONFIG=5FFORCE=5FMAX=5FZONEORDER=3D11
CONFIG=5FALIGNMENT=5FTRAP=3Dy
# CONFIG=5FUACCESS=5FWITH=5FMEMCPY is not set
# CONFIG=5FSECCOMP is not set
# CONFIG=5FCC=5FSTACKPROTECTOR is not set
# CONFIG=5FDEPRECATED=5FPARAM=5FSTRUCT is not set

#
# Boot options
#
CONFIG=5FUSE=5FOF=3Dy
CONFIG=5FZBOOT=5FROM=5FTEXT=3D0x0
CONFIG=5FZBOOT=5FROM=5FBSS=3D0x0
# CONFIG=5FARM=5FAPPENDED=5FDTB is not set
CONFIG=5FCMDLINE=3D"console=3DttyPS0,115200n8 root=3D/dev/ram rw=20
initrd=3D0x00800000,16M earlyprintk=20
mtdparts=3Dphysmap-flash.0:512K(nor-fsbl),512K(nor-u-boot),5M(nor-linux),9M=
(nor-user),1M(nor-scratch),-(nor-rootfs)"
CONFIG=5FCMDLINE=5FFROM=5FBOOTLOADER=3Dy
# CONFIG=5FCMDLINE=5FEXTEND is not set
# CONFIG=5FCMDLINE=5FFORCE is not set
# CONFIG=5FXIP=5FKERNEL is not set
# CONFIG=5FKEXEC is not set
# CONFIG=5FCRASH=5FDUMP is not set
# CONFIG=5FAUTO=5FZRELADDR is not set

#
# CPU Power Management
#

#
# CPU Frequency scaling
#
# CONFIG=5FCPU=5FFREQ is not set
# CONFIG=5FCPU=5FIDLE is not set

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
CONFIG=5FVFP=3Dy
CONFIG=5FVFPv3=3Dy
CONFIG=5FNEON=3Dy

#
# Userspace binary formats
#
CONFIG=5FBINFMT=5FELF=3Dy
CONFIG=5FARCH=5FBINFMT=5FELF=5FRANDOMIZE=5FPIE=3Dy
# CONFIG=5FCORE=5FDUMP=5FDEFAULT=5FELF=5FHEADERS is not set
CONFIG=5FHAVE=5FAOUT=3Dy
# CONFIG=5FBINFMT=5FAOUT is not set
# CONFIG=5FBINFMT=5FMISC is not set

#
# Power management options
#
# CONFIG=5FSUSPEND is not set
CONFIG=5FPM=5FRUNTIME=3Dy
CONFIG=5FPM=3Dy
# CONFIG=5FPM=5FDEBUG is not set
# CONFIG=5FAPM=5FEMULATION is not set
CONFIG=5FARCH=5FHAS=5FOPP=3Dy
CONFIG=5FPM=5FOPP=3Dy
CONFIG=5FPM=5FCLK=3Dy
CONFIG=5FARCH=5FSUSPEND=5FPOSSIBLE=3Dy
# CONFIG=5FARM=5FCPU=5FSUSPEND is not set
CONFIG=5FNET=3Dy

#
# Networking options
#
CONFIG=5FPACKET=3Dy
CONFIG=5FUNIX=3Dy
# CONFIG=5FUNIX=5FDIAG is not set
CONFIG=5FXFRM=3Dy
# CONFIG=5FXFRM=5FUSER is not set
# CONFIG=5FXFRM=5FSUB=5FPOLICY is not set
# CONFIG=5FXFRM=5FMIGRATE is not set
# CONFIG=5FXFRM=5FSTATISTICS is not set
# CONFIG=5FNET=5FKEY is not set
CONFIG=5FINET=3Dy
CONFIG=5FIP=5FMULTICAST=3Dy
# CONFIG=5FIP=5FADVANCED=5FROUTER is not set
CONFIG=5FIP=5FPNP=3Dy
CONFIG=5FIP=5FPNP=5FDHCP=3Dy
CONFIG=5FIP=5FPNP=5FBOOTP=3Dy
CONFIG=5FIP=5FPNP=5FRARP=3Dy
CONFIG=5FNET=5FIPIP=3Dm
# CONFIG=5FNET=5FIPGRE=5FDEMUX is not set
# CONFIG=5FIP=5FMROUTE is not set
# CONFIG=5FARPD is not set
# CONFIG=5FSYN=5FCOOKIES is not set
# CONFIG=5FINET=5FAH is not set
# CONFIG=5FINET=5FESP is not set
# CONFIG=5FINET=5FIPCOMP is not set
# CONFIG=5FINET=5FXFRM=5FTUNNEL is not set
CONFIG=5FINET=5FTUNNEL=3Dm
CONFIG=5FINET=5FXFRM=5FMODE=5FTRANSPORT=3Dy
CONFIG=5FINET=5FXFRM=5FMODE=5FTUNNEL=3Dy
CONFIG=5FINET=5FXFRM=5FMODE=5FBEET=3Dy
CONFIG=5FINET=5FLRO=3Dy
CONFIG=5FINET=5FDIAG=3Dy
CONFIG=5FINET=5FTCP=5FDIAG=3Dy
# CONFIG=5FINET=5FUDP=5FDIAG is not set
# CONFIG=5FTCP=5FCONG=5FADVANCED is not set
CONFIG=5FTCP=5FCONG=5FCUBIC=3Dy
CONFIG=5FDEFAULT=5FTCP=5FCONG=3D"cubic"
# CONFIG=5FTCP=5FMD5SIG is not set
CONFIG=5FIPV6=3Dm
# CONFIG=5FIPV6=5FPRIVACY is not set
# CONFIG=5FIPV6=5FROUTER=5FPREF is not set
# CONFIG=5FIPV6=5FOPTIMISTIC=5FDAD is not set
# CONFIG=5FINET6=5FAH is not set
# CONFIG=5FINET6=5FESP is not set
# CONFIG=5FINET6=5FIPCOMP is not set
# CONFIG=5FIPV6=5FMIP6 is not set
# CONFIG=5FINET6=5FXFRM=5FTUNNEL is not set
# CONFIG=5FINET6=5FTUNNEL is not set
CONFIG=5FINET6=5FXFRM=5FMODE=5FTRANSPORT=3Dm
CONFIG=5FINET6=5FXFRM=5FMODE=5FTUNNEL=3Dm
CONFIG=5FINET6=5FXFRM=5FMODE=5FBEET=3Dm
# CONFIG=5FINET6=5FXFRM=5FMODE=5FROUTEOPTIMIZATION is not set
CONFIG=5FIPV6=5FSIT=3Dm
# CONFIG=5FIPV6=5FSIT=5F6RD is not set
CONFIG=5FIPV6=5FNDISC=5FNODETYPE=3Dy
# CONFIG=5FIPV6=5FTUNNEL is not set
# CONFIG=5FIPV6=5FMULTIPLE=5FTABLES is not set
# CONFIG=5FIPV6=5FMROUTE is not set
# CONFIG=5FNETWORK=5FSECMARK is not set
# CONFIG=5FNETWORK=5FPHY=5FTIMESTAMPING is not set
# CONFIG=5FNETFILTER is not set
# CONFIG=5FIP=5FDCCP is not set
# CONFIG=5FIP=5FSCTP is not set
# CONFIG=5FRDS is not set
# CONFIG=5FTIPC is not set
# CONFIG=5FATM is not set
# CONFIG=5FL2TP is not set
# CONFIG=5FBRIDGE is not set
# CONFIG=5FNET=5FDSA is not set
CONFIG=5FVLAN=5F8021Q=3Dm
# CONFIG=5FVLAN=5F8021Q=5FGVRP is not set
# CONFIG=5FDECNET is not set
# CONFIG=5FLLC2 is not set
# CONFIG=5FIPX is not set
# CONFIG=5FATALK is not set
# CONFIG=5FX25 is not set
# CONFIG=5FLAPB is not set
# CONFIG=5FWAN=5FROUTER is not set
# CONFIG=5FPHONET is not set
# CONFIG=5FIEEE802154 is not set
# CONFIG=5FNET=5FSCHED is not set
# CONFIG=5FDCB is not set
# CONFIG=5FBATMAN=5FADV is not set
# CONFIG=5FOPENVSWITCH is not set
CONFIG=5FRPS=3Dy
CONFIG=5FRFS=5FACCEL=3Dy
CONFIG=5FXPS=3Dy
CONFIG=5FBQL=3Dy
# CONFIG=5FBPF=5FJIT is not set

#
# Network testing
#
# CONFIG=5FNET=5FPKTGEN is not set
# CONFIG=5FHAMRADIO is not set
# CONFIG=5FCAN is not set
# CONFIG=5FIRDA is not set
# CONFIG=5FBT is not set
# CONFIG=5FAF=5FRXRPC is not set
CONFIG=5FWIRELESS=3Dy
# CONFIG=5FCFG80211 is not set
# CONFIG=5FLIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
# CONFIG=5FWIMAX is not set
# CONFIG=5FRFKILL is not set
# CONFIG=5FNET=5F9P is not set
# CONFIG=5FCAIF is not set
# CONFIG=5FCEPH=5FLIB is not set
# CONFIG=5FNFC is not set
CONFIG=5FHAVE=5FBPF=5FJIT=3Dy

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG=5FUEVENT=5FHELPER=5FPATH=3D"/sbin/hotplug"
CONFIG=5FDEVTMPFS=3Dy
CONFIG=5FDEVTMPFS=5FMOUNT=3Dy
CONFIG=5FSTANDALONE=3Dy
CONFIG=5FPREVENT=5FFIRMWARE=5FBUILD=3Dy
CONFIG=5FFW=5FLOADER=3Dm
CONFIG=5FFIRMWARE=5FIN=5FKERNEL=3Dy
CONFIG=5FEXTRA=5FFIRMWARE=3D""
# CONFIG=5FDEBUG=5FDRIVER is not set
# CONFIG=5FDEBUG=5FDEVRES is not set
# CONFIG=5FSYS=5FHYPERVISOR is not set
# CONFIG=5FGENERIC=5FCPU=5FDEVICES is not set
# CONFIG=5FDMA=5FSHARED=5FBUFFER is not set
CONFIG=5FCMA=3Dy
# CONFIG=5FCMA=5FDEBUG is not set

#
# Default contiguous memory area size:
#
CONFIG=5FCMA=5FSIZE=5FMBYTES=3D16
CONFIG=5FCMA=5FSIZE=5FSEL=5FMBYTES=3Dy
# CONFIG=5FCMA=5FSIZE=5FSEL=5FPERCENTAGE is not set
# CONFIG=5FCMA=5FSIZE=5FSEL=5FMIN is not set
# CONFIG=5FCMA=5FSIZE=5FSEL=5FMAX is not set
CONFIG=5FCMA=5FALIGNMENT=3D8
CONFIG=5FCMA=5FAREAS=3D7
CONFIG=5FCONNECTOR=3Dy
CONFIG=5FPROC=5FEVENTS=3Dy
CONFIG=5FMTD=3Dy
# CONFIG=5FMTD=5FTESTS is not set
# CONFIG=5FMTD=5FREDBOOT=5FPARTS is not set
CONFIG=5FMTD=5FCMDLINE=5FPARTS=3Dy
# CONFIG=5FMTD=5FAFS=5FPARTS is not set
CONFIG=5FMTD=5FOF=5FPARTS=3Dy
# CONFIG=5FMTD=5FAR7=5FPARTS is not set

#
# User Modules And Translation Layers
#
CONFIG=5FMTD=5FCHAR=3Dy
CONFIG=5FMTD=5FBLKDEVS=3Dy
CONFIG=5FMTD=5FBLOCK=3Dy
# CONFIG=5FFTL is not set
# CONFIG=5FNFTL is not set
# CONFIG=5FINFTL is not set
# CONFIG=5FRFD=5FFTL is not set
# CONFIG=5FSSFDC is not set
# CONFIG=5FSM=5FFTL is not set
# CONFIG=5FMTD=5FOOPS is not set
# CONFIG=5FMTD=5FSWAP is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG=5FMTD=5FCFI=3Dy
# CONFIG=5FMTD=5FJEDECPROBE is not set
CONFIG=5FMTD=5FGEN=5FPROBE=3Dy
# CONFIG=5FMTD=5FCFI=5FADV=5FOPTIONS is not set
CONFIG=5FMTD=5FMAP=5FBANK=5FWIDTH=5F1=3Dy
CONFIG=5FMTD=5FMAP=5FBANK=5FWIDTH=5F2=3Dy
CONFIG=5FMTD=5FMAP=5FBANK=5FWIDTH=5F4=3Dy
# CONFIG=5FMTD=5FMAP=5FBANK=5FWIDTH=5F8 is not set
# CONFIG=5FMTD=5FMAP=5FBANK=5FWIDTH=5F16 is not set
# CONFIG=5FMTD=5FMAP=5FBANK=5FWIDTH=5F32 is not set
CONFIG=5FMTD=5FCFI=5FI1=3Dy
CONFIG=5FMTD=5FCFI=5FI2=3Dy
# CONFIG=5FMTD=5FCFI=5FI4 is not set
# CONFIG=5FMTD=5FCFI=5FI8 is not set
# CONFIG=5FMTD=5FCFI=5FINTELEXT is not set
CONFIG=5FMTD=5FCFI=5FAMDSTD=3Dy
# CONFIG=5FMTD=5FCFI=5FSTAA is not set
CONFIG=5FMTD=5FCFI=5FUTIL=3Dy
# CONFIG=5FMTD=5FRAM is not set
# CONFIG=5FMTD=5FROM is not set
# CONFIG=5FMTD=5FABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG=5FMTD=5FCOMPLEX=5FMAPPINGS is not set
CONFIG=5FMTD=5FPHYSMAP=3Dy
# CONFIG=5FMTD=5FPHYSMAP=5FCOMPAT is not set
CONFIG=5FMTD=5FPHYSMAP=5FOF=3Dy
# CONFIG=5FMTD=5FPLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG=5FMTD=5FDATAFLASH is not set
CONFIG=5FMTD=5FM25P80=3Dy
# CONFIG=5FM25PXX=5FUSE=5FFAST=5FREAD is not set
# CONFIG=5FMTD=5FSST25L is not set
# CONFIG=5FMTD=5FSLRAM is not set
# CONFIG=5FMTD=5FPHRAM is not set
# CONFIG=5FMTD=5FMTDRAM is not set
# CONFIG=5FMTD=5FBLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG=5FMTD=5FDOC2000 is not set
# CONFIG=5FMTD=5FDOC2001 is not set
# CONFIG=5FMTD=5FDOC2001PLUS is not set
# CONFIG=5FMTD=5FDOCG3 is not set
CONFIG=5FMTD=5FNAND=5FECC=3Dy
# CONFIG=5FMTD=5FNAND=5FECC=5FSMC is not set
CONFIG=5FMTD=5FNAND=3Dy
# CONFIG=5FMTD=5FNAND=5FVERIFY=5FWRITE is not set
# CONFIG=5FMTD=5FNAND=5FECC=5FBCH is not set
# CONFIG=5FMTD=5FSM=5FCOMMON is not set
# CONFIG=5FMTD=5FNAND=5FMUSEUM=5FIDS is not set
# CONFIG=5FMTD=5FNAND=5FGPIO is not set
CONFIG=5FMTD=5FNAND=5FIDS=3Dy
# CONFIG=5FMTD=5FNAND=5FDISKONCHIP is not set
# CONFIG=5FMTD=5FNAND=5FDOCG4 is not set
# CONFIG=5FMTD=5FNAND=5FNANDSIM is not set
# CONFIG=5FMTD=5FNAND=5FPLATFORM is not set
# CONFIG=5FMTD=5FALAUDA is not set
CONFIG=5FMTD=5FNAND=5FXILINX=5FPS=3Dy
# CONFIG=5FMTD=5FONENAND is not set

#
# LPDDR flash memory drivers
#
# CONFIG=5FMTD=5FLPDDR is not set
# CONFIG=5FMTD=5FUBI is not set
CONFIG=5FDTC=3Dy
CONFIG=5FOF=3Dy

#
# Device Tree and Open Firmware support
#
CONFIG=5FPROC=5FDEVICETREE=3Dy
# CONFIG=5FOF=5FSELFTEST is not set
CONFIG=5FOF=5FFLATTREE=3Dy
CONFIG=5FOF=5FEARLY=5FFLATTREE=3Dy
CONFIG=5FOF=5FADDRESS=3Dy
CONFIG=5FOF=5FIRQ=3Dy
CONFIG=5FOF=5FDEVICE=3Dy
CONFIG=5FOF=5FI2C=3Dy
CONFIG=5FOF=5FNET=3Dy
CONFIG=5FOF=5FMDIO=3Dy
CONFIG=5FOF=5FMTD=3Dy
# CONFIG=5FPARPORT is not set
CONFIG=5FBLK=5FDEV=3Dy
# CONFIG=5FBLK=5FDEV=5FCOW=5FCOMMON is not set
CONFIG=5FBLK=5FDEV=5FLOOP=3Dy
CONFIG=5FBLK=5FDEV=5FLOOP=5FMIN=5FCOUNT=3D8
# CONFIG=5FBLK=5FDEV=5FCRYPTOLOOP is not set
# CONFIG=5FBLK=5FDEV=5FDRBD is not set
# CONFIG=5FBLK=5FDEV=5FNBD is not set
# CONFIG=5FBLK=5FDEV=5FUB is not set
CONFIG=5FBLK=5FDEV=5FRAM=3Dy
CONFIG=5FBLK=5FDEV=5FRAM=5FCOUNT=3D16
CONFIG=5FBLK=5FDEV=5FRAM=5FSIZE=3D16384
# CONFIG=5FBLK=5FDEV=5FXIP is not set
# CONFIG=5FCDROM=5FPKTCDVD is not set
# CONFIG=5FATA=5FOVER=5FETH is not set
# CONFIG=5FMG=5FDISK is not set
# CONFIG=5FBLK=5FDEV=5FRBD is not set

#
# Misc devices
#
# CONFIG=5FSENSORS=5FLIS3LV02D is not set
# CONFIG=5FAD525X=5FDPOT is not set
# CONFIG=5FATMEL=5FPWM is not set
# CONFIG=5FICS932S401 is not set
# CONFIG=5FENCLOSURE=5FSERVICES is not set
# CONFIG=5FAPDS9802ALS is not set
# CONFIG=5FISL29003 is not set
# CONFIG=5FISL29020 is not set
# CONFIG=5FSENSORS=5FTSL2550 is not set
# CONFIG=5FSENSORS=5FBH1780 is not set
# CONFIG=5FSENSORS=5FBH1770 is not set
# CONFIG=5FSENSORS=5FAPDS990X is not set
# CONFIG=5FHMC6352 is not set
# CONFIG=5FDS1682 is not set
# CONFIG=5FTI=5FDAC7512 is not set
# CONFIG=5FBMP085=5FI2C is not set
# CONFIG=5FBMP085=5FSPI is not set
# CONFIG=5FUSB=5FSWITCH=5FFSA9480 is not set
CONFIG=5FSI570=3Dy
# CONFIG=5FC2PORT is not set

#
# EEPROM support
#
CONFIG=5FEEPROM=5FAT24=3Dy
CONFIG=5FEEPROM=5FAT25=3Dy
# CONFIG=5FEEPROM=5FLEGACY is not set
# CONFIG=5FEEPROM=5FMAX6875 is not set
# CONFIG=5FEEPROM=5F93CX6 is not set
# CONFIG=5FEEPROM=5F93XX46 is not set
# CONFIG=5FIWMC3200TOP is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG=5FTI=5FST is not set
# CONFIG=5FSENSORS=5FLIS3=5FSPI is not set
# CONFIG=5FSENSORS=5FLIS3=5FI2C is not set

#
# Altera FPGA firmware download module
#
# CONFIG=5FALTERA=5FSTAPL is not set

#
# SCSI device support
#
CONFIG=5FSCSI=5FMOD=3Dy
# CONFIG=5FRAID=5FATTRS is not set
CONFIG=5FSCSI=3Dy
CONFIG=5FSCSI=5FDMA=3Dy
# CONFIG=5FSCSI=5FTGT is not set
# CONFIG=5FSCSI=5FNETLINK is not set
CONFIG=5FSCSI=5FPROC=5FFS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG=5FBLK=5FDEV=5FSD=3Dy
# CONFIG=5FCHR=5FDEV=5FST is not set
# CONFIG=5FCHR=5FDEV=5FOSST is not set
# CONFIG=5FBLK=5FDEV=5FSR is not set
CONFIG=5FCHR=5FDEV=5FSG=3Dy
# CONFIG=5FCHR=5FDEV=5FSCH is not set
CONFIG=5FSCSI=5FMULTI=5FLUN=3Dy
# CONFIG=5FSCSI=5FCONSTANTS is not set
# CONFIG=5FSCSI=5FLOGGING is not set
# CONFIG=5FSCSI=5FSCAN=5FASYNC is not set
CONFIG=5FSCSI=5FWAIT=5FSCAN=3Dm

#
# SCSI Transports
#
# CONFIG=5FSCSI=5FSPI=5FATTRS is not set
# CONFIG=5FSCSI=5FFC=5FATTRS is not set
# CONFIG=5FSCSI=5FISCSI=5FATTRS is not set
# CONFIG=5FSCSI=5FSAS=5FATTRS is not set
# CONFIG=5FSCSI=5FSAS=5FLIBSAS is not set
# CONFIG=5FSCSI=5FSRP=5FATTRS is not set
CONFIG=5FSCSI=5FLOWLEVEL=3Dy
# CONFIG=5FISCSI=5FTCP is not set
# CONFIG=5FISCSI=5FBOOT=5FSYSFS is not set
# CONFIG=5FLIBFC is not set
# CONFIG=5FLIBFCOE is not set
# CONFIG=5FSCSI=5FDEBUG is not set
# CONFIG=5FSCSI=5FDH is not set
# CONFIG=5FSCSI=5FOSD=5FINITIATOR is not set
# CONFIG=5FATA is not set
# CONFIG=5FMD is not set
# CONFIG=5FTARGET=5FCORE is not set
CONFIG=5FNETDEVICES=3Dy
CONFIG=5FNET=5FCORE=3Dy
# CONFIG=5FBONDING is not set
# CONFIG=5FDUMMY is not set
# CONFIG=5FEQUALIZER is not set
# CONFIG=5FMII is not set
# CONFIG=5FNET=5FTEAM is not set
# CONFIG=5FMACVLAN is not set
# CONFIG=5FNETCONSOLE is not set
# CONFIG=5FNETPOLL is not set
# CONFIG=5FNET=5FPOLL=5FCONTROLLER is not set
# CONFIG=5FTUN is not set
# CONFIG=5FVETH is not set

#
# CAIF transport drivers
#
CONFIG=5FETHERNET=3Dy
CONFIG=5FNET=5FVENDOR=5FBROADCOM=3Dy
# CONFIG=5FB44 is not set
# CONFIG=5FNET=5FCALXEDA=5FXGMAC is not set
CONFIG=5FNET=5FVENDOR=5FCHELSIO=3Dy
CONFIG=5FNET=5FVENDOR=5FCIRRUS=3Dy
# CONFIG=5FCS89x0 is not set
# CONFIG=5FDM9000 is not set
# CONFIG=5FDNET is not set
CONFIG=5FNET=5FVENDOR=5FFARADAY=3Dy
# CONFIG=5FFTMAC100 is not set
# CONFIG=5FFTGMAC100 is not set
CONFIG=5FNET=5FVENDOR=5FINTEL=3Dy
CONFIG=5FNET=5FVENDOR=5FI825XX=3Dy
# CONFIG=5FZNET is not set
CONFIG=5FNET=5FVENDOR=5FMARVELL=3Dy
CONFIG=5FNET=5FVENDOR=5FMICREL=3Dy
# CONFIG=5FKS8851 is not set
# CONFIG=5FKS8851=5FMLL is not set
CONFIG=5FNET=5FVENDOR=5FMICROCHIP=3Dy
# CONFIG=5FENC28J60 is not set
CONFIG=5FNET=5FVENDOR=5FNATSEMI=3Dy
CONFIG=5FNET=5FVENDOR=5F8390=3Dy
# CONFIG=5FAX88796 is not set
# CONFIG=5FETHOC is not set
CONFIG=5FNET=5FVENDOR=5FSEEQ=3Dy
# CONFIG=5FSEEQ8005 is not set
CONFIG=5FNET=5FVENDOR=5FSMSC=3Dy
# CONFIG=5FSMC91X is not set
# CONFIG=5FSMC911X is not set
# CONFIG=5FSMSC911X is not set
CONFIG=5FNET=5FVENDOR=5FSTMICRO=3Dy
# CONFIG=5FSTMMAC=5FETH is not set
CONFIG=5FNET=5FVENDOR=5FWIZNET=3Dy
# CONFIG=5FWIZNET=5FW5100 is not set
# CONFIG=5FWIZNET=5FW5300 is not set
CONFIG=5FNET=5FVENDOR=5FXILINX=3Dy
CONFIG=5FXILINX=5FPS=5FEMAC=3Dy
# CONFIG=5FXILINX=5FPS=5FEMAC=5FHWTSTAMP is not set
CONFIG=5FPHYLIB=3Dy

#
# MII PHY device drivers
#
# CONFIG=5FAMD=5FPHY is not set
CONFIG=5FMARVELL=5FPHY=3Dy
# CONFIG=5FDAVICOM=5FPHY is not set
# CONFIG=5FQSEMI=5FPHY is not set
# CONFIG=5FLXT=5FPHY is not set
# CONFIG=5FCICADA=5FPHY is not set
CONFIG=5FVITESSE=5FPHY=3Dy
# CONFIG=5FSMSC=5FPHY is not set
# CONFIG=5FBROADCOM=5FPHY is not set
# CONFIG=5FICPLUS=5FPHY is not set
# CONFIG=5FREALTEK=5FPHY is not set
# CONFIG=5FNATIONAL=5FPHY is not set
# CONFIG=5FSTE10XP is not set
# CONFIG=5FLSI=5FET1011C=5FPHY is not set
# CONFIG=5FMICREL=5FPHY is not set
# CONFIG=5FFIXED=5FPHY is not set
CONFIG=5FMDIO=5FBITBANG=3Dy
# CONFIG=5FMDIO=5FGPIO is not set
# CONFIG=5FMDIO=5FBUS=5FMUX=5FGPIO is not set
# CONFIG=5FMICREL=5FKS8995MA is not set
# CONFIG=5FPPP is not set
# CONFIG=5FSLIP is not set

#
# USB Network Adapters
#
# CONFIG=5FUSB=5FCATC is not set
# CONFIG=5FUSB=5FKAWETH is not set
# CONFIG=5FUSB=5FPEGASUS is not set
# CONFIG=5FUSB=5FRTL8150 is not set
# CONFIG=5FUSB=5FUSBNET is not set
# CONFIG=5FUSB=5FIPHETH is not set
CONFIG=5FWLAN=3Dy
# CONFIG=5FUSB=5FZD1201 is not set
# CONFIG=5FHOSTAP is not set
# CONFIG=5FWL=5FTI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG=5FWAN is not set
# CONFIG=5FISDN is not set

#
# Input device support
#
CONFIG=5FINPUT=3Dy
# CONFIG=5FINPUT=5FFF=5FMEMLESS is not set
# CONFIG=5FINPUT=5FPOLLDEV is not set
CONFIG=5FINPUT=5FSPARSEKMAP=3Dy
# CONFIG=5FINPUT=5FMATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG=5FINPUT=5FMOUSEDEV=3Dy
CONFIG=5FINPUT=5FMOUSEDEV=5FPSAUX=3Dy
CONFIG=5FINPUT=5FMOUSEDEV=5FSCREEN=5FX=3D1024
CONFIG=5FINPUT=5FMOUSEDEV=5FSCREEN=5FY=3D768
# CONFIG=5FINPUT=5FJOYDEV is not set
CONFIG=5FINPUT=5FEVDEV=3Dy
CONFIG=5FINPUT=5FEVBUG=3Dy

#
# Input Device Drivers
#
CONFIG=5FINPUT=5FKEYBOARD=3Dy
# CONFIG=5FKEYBOARD=5FADP5588 is not set
# CONFIG=5FKEYBOARD=5FADP5589 is not set
CONFIG=5FKEYBOARD=5FATKBD=3Dy
# CONFIG=5FKEYBOARD=5FQT1070 is not set
# CONFIG=5FKEYBOARD=5FQT2160 is not set
# CONFIG=5FKEYBOARD=5FLKKBD is not set
# CONFIG=5FKEYBOARD=5FGPIO is not set
# CONFIG=5FKEYBOARD=5FTCA6416 is not set
# CONFIG=5FKEYBOARD=5FTCA8418 is not set
# CONFIG=5FKEYBOARD=5FMATRIX is not set
# CONFIG=5FKEYBOARD=5FLM8333 is not set
# CONFIG=5FKEYBOARD=5FMAX7359 is not set
# CONFIG=5FKEYBOARD=5FMCS is not set
# CONFIG=5FKEYBOARD=5FMPR121 is not set
# CONFIG=5FKEYBOARD=5FNEWTON is not set
# CONFIG=5FKEYBOARD=5FOPENCORES is not set
# CONFIG=5FKEYBOARD=5FSAMSUNG is not set
# CONFIG=5FKEYBOARD=5FSTOWAWAY is not set
# CONFIG=5FKEYBOARD=5FSUNKBD is not set
# CONFIG=5FKEYBOARD=5FOMAP4 is not set
# CONFIG=5FKEYBOARD=5FXTKBD is not set
CONFIG=5FINPUT=5FMOUSE=3Dy
CONFIG=5FMOUSE=5FPS2=3Dy
CONFIG=5FMOUSE=5FPS2=5FALPS=3Dy
CONFIG=5FMOUSE=5FPS2=5FLOGIPS2PP=3Dy
CONFIG=5FMOUSE=5FPS2=5FSYNAPTICS=3Dy
CONFIG=5FMOUSE=5FPS2=5FTRACKPOINT=3Dy
# CONFIG=5FMOUSE=5FPS2=5FELANTECH is not set
# CONFIG=5FMOUSE=5FPS2=5FSENTELIC is not set
# CONFIG=5FMOUSE=5FPS2=5FTOUCHKIT is not set
# CONFIG=5FMOUSE=5FSERIAL is not set
# CONFIG=5FMOUSE=5FAPPLETOUCH is not set
# CONFIG=5FMOUSE=5FBCM5974 is not set
# CONFIG=5FMOUSE=5FVSXXXAA is not set
# CONFIG=5FMOUSE=5FGPIO is not set
# CONFIG=5FMOUSE=5FSYNAPTICS=5FI2C is not set
# CONFIG=5FMOUSE=5FSYNAPTICS=5FUSB is not set
# CONFIG=5FINPUT=5FJOYSTICK is not set
# CONFIG=5FINPUT=5FTABLET is not set
# CONFIG=5FINPUT=5FTOUCHSCREEN is not set
# CONFIG=5FINPUT=5FMISC is not set

#
# Hardware I/O ports
#
CONFIG=5FSERIO=3Dy
CONFIG=5FSERIO=5FSERPORT=3Dy
# CONFIG=5FSERIO=5FAMBAKMI is not set
CONFIG=5FSERIO=5FLIBPS2=3Dy
# CONFIG=5FSERIO=5FRAW is not set
# CONFIG=5FSERIO=5FALTERA=5FPS2 is not set
# CONFIG=5FSERIO=5FPS2MULT is not set
# CONFIG=5FGAMEPORT is not set

#
# Character devices
#
CONFIG=5FVT=3Dy
CONFIG=5FCONSOLE=5FTRANSLATIONS=3Dy
CONFIG=5FVT=5FCONSOLE=3Dy
CONFIG=5FHW=5FCONSOLE=3Dy
CONFIG=5FVT=5FHW=5FCONSOLE=5FBINDING=3Dy
CONFIG=5FUNIX98=5FPTYS=3Dy
# CONFIG=5FDEVPTS=5FMULTIPLE=5FINSTANCES is not set
# CONFIG=5FLEGACY=5FPTYS is not set
# CONFIG=5FSERIAL=5FNONSTANDARD is not set
# CONFIG=5FN=5FGSM is not set
# CONFIG=5FTRACE=5FSINK is not set
# CONFIG=5FDEVKMEM is not set

#
# Serial drivers
#
# CONFIG=5FSERIAL=5F8250 is not set

#
# Non-8250 serial port support
#
# CONFIG=5FSERIAL=5FAMBA=5FPL010 is not set
# CONFIG=5FSERIAL=5FAMBA=5FPL011 is not set
# CONFIG=5FSERIAL=5FMAX3100 is not set
# CONFIG=5FSERIAL=5FMAX3107 is not set
CONFIG=5FSERIAL=5FCORE=3Dy
CONFIG=5FSERIAL=5FCORE=5FCONSOLE=3Dy
# CONFIG=5FSERIAL=5FTIMBERDALE is not set
# CONFIG=5FSERIAL=5FALTERA=5FJTAGUART is not set
# CONFIG=5FSERIAL=5FALTERA=5FUART is not set
# CONFIG=5FSERIAL=5FIFX6X60 is not set
CONFIG=5FSERIAL=5FXILINX=5FPS=5FUART=3Dy
CONFIG=5FSERIAL=5FXILINX=5FPS=5FUART=5FCONSOLE=3Dy
# CONFIG=5FTTY=5FPRINTK is not set
# CONFIG=5FHVC=5FDCC is not set
# CONFIG=5FIPMI=5FHANDLER is not set
# CONFIG=5FHW=5FRANDOM is not set
CONFIG=5FXILINX=5FDEVCFG=3Dy
# CONFIG=5FR3964 is not set
# CONFIG=5FRAW=5FDRIVER is not set
# CONFIG=5FTCG=5FTPM is not set
CONFIG=5FI2C=3Dy
CONFIG=5FI2C=5FBOARDINFO=3Dy
CONFIG=5FI2C=5FCOMPAT=3Dy
CONFIG=5FI2C=5FCHARDEV=3Dy
CONFIG=5FI2C=5FMUX=3Dy

#
# Multiplexer I2C Chip support
#
# CONFIG=5FI2C=5FMUX=5FGPIO is not set
# CONFIG=5FI2C=5FMUX=5FPCA9541 is not set
CONFIG=5FI2C=5FMUX=5FPCA954x=3Dy
CONFIG=5FI2C=5FHELPER=5FAUTO=3Dy

#
# I2C Hardware Bus support
#

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG=5FI2C=5FDESIGNWARE=5FPLATFORM is not set
# CONFIG=5FI2C=5FGPIO is not set
# CONFIG=5FI2C=5FOCORES is not set
# CONFIG=5FI2C=5FPCA=5FPLATFORM is not set
# CONFIG=5FI2C=5FPXA=5FPCI is not set
# CONFIG=5FI2C=5FSIMTEC is not set
CONFIG=5FI2C=5FXILINX=5FPS=3Dy
# CONFIG=5FI2C=5FXILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG=5FI2C=5FDIOLAN=5FU2C is not set
# CONFIG=5FI2C=5FPARPORT=5FLIGHT is not set
# CONFIG=5FI2C=5FTAOS=5FEVM is not set
# CONFIG=5FI2C=5FTINY=5FUSB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG=5FI2C=5FSTUB is not set
# CONFIG=5FI2C=5FDEBUG=5FCORE is not set
# CONFIG=5FI2C=5FDEBUG=5FALGO is not set
# CONFIG=5FI2C=5FDEBUG=5FBUS is not set
CONFIG=5FSPI=3Dy
# CONFIG=5FSPI=5FDEBUG is not set
CONFIG=5FSPI=5FMASTER=3Dy

#
# SPI Master Controller Drivers
#
# CONFIG=5FSPI=5FALTERA is not set
# CONFIG=5FSPI=5FBITBANG is not set
# CONFIG=5FSPI=5FGPIO is not set
# CONFIG=5FSPI=5FOC=5FTINY is not set
# CONFIG=5FSPI=5FPL022 is not set
# CONFIG=5FSPI=5FPXA2XX=5FPCI is not set
# CONFIG=5FSPI=5FXILINX is not set
CONFIG=5FSPI=5FXILINX=5FPS=5FQSPI=3Dy
CONFIG=5FSPI=5FXILINX=5FPS=5FSPI=3Dy
# CONFIG=5FSPI=5FDESIGNWARE is not set

#
# SPI Protocol Masters
#
# CONFIG=5FSPI=5FSPIDEV is not set
# CONFIG=5FSPI=5FTLE62X0 is not set
# CONFIG=5FHSI is not set

#
# PPS support
#
# CONFIG=5FPPS is not set

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable Device Drivers -> PPS to see the PTP clock options.
#
CONFIG=5FARCH=5FHAVE=5FCUSTOM=5FGPIO=5FH=3Dy
CONFIG=5FARCH=5FREQUIRE=5FGPIOLIB=3Dy
CONFIG=5FGPIOLIB=3Dy
CONFIG=5FOF=5FGPIO=3Dy
# CONFIG=5FDEBUG=5FGPIO is not set
CONFIG=5FGPIO=5FSYSFS=3Dy

#
# Memory mapped GPIO drivers:
#
# CONFIG=5FGPIO=5FGENERIC=5FPLATFORM is not set
# CONFIG=5FGPIO=5FEM is not set
# CONFIG=5FGPIO=5FPL061 is not set
# CONFIG=5FGPIO=5FXILINX is not set
CONFIG=5FGPIO=5FXILINX=5FPS=3Dy

#
# I2C GPIO expanders:
#
# CONFIG=5FGPIO=5FMAX7300 is not set
# CONFIG=5FGPIO=5FMAX732X is not set
# CONFIG=5FGPIO=5FPCF857X is not set
# CONFIG=5FGPIO=5FSX150X is not set
# CONFIG=5FGPIO=5FADP5588 is not set

#
# PCI GPIO expanders:
#

#
# SPI GPIO expanders:
#
# CONFIG=5FGPIO=5FMAX7301 is not set
# CONFIG=5FGPIO=5FMCP23S08 is not set
# CONFIG=5FGPIO=5FMC33880 is not set
# CONFIG=5FGPIO=5F74X164 is not set

#
# AC97 GPIO expanders:
#

#
# MODULbus GPIO expanders:
#
# CONFIG=5FW1 is not set
# CONFIG=5FPOWER=5FSUPPLY is not set
# CONFIG=5FHWMON is not set
# CONFIG=5FTHERMAL is not set
CONFIG=5FWATCHDOG=3Dy
CONFIG=5FWATCHDOG=5FCORE=3Dy
# CONFIG=5FWATCHDOG=5FNOWAYOUT is not set

#
# Watchdog Device Drivers
#
# CONFIG=5FSOFT=5FWATCHDOG is not set
# CONFIG=5FARM=5FSP805=5FWATCHDOG is not set
# CONFIG=5FDW=5FWATCHDOG is not set
CONFIG=5FMPCORE=5FWATCHDOG=3Dy
CONFIG=5FXILINX=5FPS=5FWATCHDOG=3Dy
# CONFIG=5FMAX63XX=5FWATCHDOG is not set

#
# USB-based Watchdog Cards
#
# CONFIG=5FUSBPCWATCHDOG is not set
CONFIG=5FSSB=5FPOSSIBLE=3Dy

#
# Sonics Silicon Backplane
#
# CONFIG=5FSSB is not set
CONFIG=5FBCMA=5FPOSSIBLE=3Dy

#
# Broadcom specific AMBA
#
# CONFIG=5FBCMA is not set

#
# Multifunction device drivers
#
# CONFIG=5FMFD=5FCORE is not set
# CONFIG=5FMFD=5F88PM860X is not set
# CONFIG=5FMFD=5FSM501 is not set
# CONFIG=5FMFD=5FASIC3 is not set
# CONFIG=5FHTC=5FEGPIO is not set
# CONFIG=5FHTC=5FPASIC3 is not set
# CONFIG=5FHTC=5FI2CPLD is not set
# CONFIG=5FMFD=5FLM3533 is not set
# CONFIG=5FTPS6105X is not set
# CONFIG=5FTPS65010 is not set
# CONFIG=5FTPS6507X is not set
# CONFIG=5FMFD=5FTPS65217 is not set
# CONFIG=5FMFD=5FTPS65910 is not set
# CONFIG=5FMFD=5FTPS65912=5FI2C is not set
# CONFIG=5FMFD=5FTPS65912=5FSPI is not set
# CONFIG=5FTWL4030=5FCORE is not set
# CONFIG=5FTWL6040=5FCORE is not set
# CONFIG=5FMFD=5FSTMPE is not set
# CONFIG=5FMFD=5FTC3589X is not set
# CONFIG=5FMFD=5FTMIO is not set
# CONFIG=5FMFD=5FT7L66XB is not set
# CONFIG=5FMFD=5FTC6387XB is not set
# CONFIG=5FMFD=5FTC6393XB is not set
# CONFIG=5FPMIC=5FDA903X is not set
# CONFIG=5FMFD=5FDA9052=5FSPI is not set
# CONFIG=5FMFD=5FDA9052=5FI2C is not set
# CONFIG=5FPMIC=5FADP5520 is not set
# CONFIG=5FMFD=5FMAX77693 is not set
# CONFIG=5FMFD=5FMAX8925 is not set
# CONFIG=5FMFD=5FMAX8997 is not set
# CONFIG=5FMFD=5FMAX8998 is not set
# CONFIG=5FMFD=5FS5M=5FCORE is not set
# CONFIG=5FMFD=5FWM8400 is not set
# CONFIG=5FMFD=5FWM831X=5FI2C is not set
# CONFIG=5FMFD=5FWM831X=5FSPI is not set
# CONFIG=5FMFD=5FWM8350=5FI2C is not set
# CONFIG=5FMFD=5FWM8994 is not set
# CONFIG=5FMFD=5FPCF50633 is not set
# CONFIG=5FMFD=5FMC13XXX=5FSPI is not set
# CONFIG=5FMFD=5FMC13XXX=5FI2C is not set
# CONFIG=5FABX500=5FCORE is not set
# CONFIG=5FEZX=5FPCAP is not set
# CONFIG=5FMFD=5FWL1273=5FCORE is not set
# CONFIG=5FMFD=5FTPS65090 is not set
# CONFIG=5FMFD=5FAAT2870=5FCORE is not set
# CONFIG=5FMFD=5FRC5T583 is not set
# CONFIG=5FMFD=5FPALMAS is not set
# CONFIG=5FREGULATOR is not set
CONFIG=5FMEDIA=5FSUPPORT=3Dy

#
# Multimedia core support
#
# CONFIG=5FMEDIA=5FCONTROLLER is not set
CONFIG=5FVIDEO=5FDEV=3Dy
CONFIG=5FVIDEO=5FV4L2=5FCOMMON=3Dy
# CONFIG=5FDVB=5FCORE is not set
CONFIG=5FVIDEO=5FMEDIA=3Dy

#
# Multimedia drivers
#
# CONFIG=5FRC=5FCORE is not set
# CONFIG=5FMEDIA=5FATTACH is not set
CONFIG=5FMEDIA=5FTUNER=3Dy
# CONFIG=5FMEDIA=5FTUNER=5FCUSTOMISE is not set
CONFIG=5FMEDIA=5FTUNER=5FSIMPLE=3Dy
CONFIG=5FMEDIA=5FTUNER=5FTDA8290=3Dy
CONFIG=5FMEDIA=5FTUNER=5FTDA827X=3Dy
CONFIG=5FMEDIA=5FTUNER=5FTDA18271=3Dy
CONFIG=5FMEDIA=5FTUNER=5FTDA9887=3Dy
CONFIG=5FMEDIA=5FTUNER=5FTEA5761=3Dy
CONFIG=5FMEDIA=5FTUNER=5FTEA5767=3Dy
CONFIG=5FMEDIA=5FTUNER=5FMT20XX=3Dy
CONFIG=5FMEDIA=5FTUNER=5FXC2028=3Dy
CONFIG=5FMEDIA=5FTUNER=5FXC5000=3Dy
CONFIG=5FMEDIA=5FTUNER=5FXC4000=3Dy
CONFIG=5FMEDIA=5FTUNER=5FMC44S803=3Dy
CONFIG=5FVIDEO=5FV4L2=3Dy
CONFIG=5FVIDEOBUF2=5FCORE=3Dy
CONFIG=5FVIDEOBUF2=5FMEMOPS=3Dy
CONFIG=5FVIDEOBUF2=5FVMALLOC=3Dy
CONFIG=5FVIDEO=5FCAPTURE=5FDRIVERS=3Dy
# CONFIG=5FVIDEO=5FADV=5FDEBUG is not set
# CONFIG=5FVIDEO=5FFIXED=5FMINOR=5FRANGES is not set
# CONFIG=5FVIDEO=5FHELPER=5FCHIPS=5FAUTO is not set

#
# Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
# CONFIG=5FVIDEO=5FTVAUDIO is not set
# CONFIG=5FVIDEO=5FTDA7432 is not set
# CONFIG=5FVIDEO=5FTDA9840 is not set
# CONFIG=5FVIDEO=5FTEA6415C is not set
# CONFIG=5FVIDEO=5FTEA6420 is not set
# CONFIG=5FVIDEO=5FMSP3400 is not set
# CONFIG=5FVIDEO=5FCS5345 is not set
# CONFIG=5FVIDEO=5FCS53L32A is not set
# CONFIG=5FVIDEO=5FTLV320AIC23B is not set
# CONFIG=5FVIDEO=5FWM8775 is not set
# CONFIG=5FVIDEO=5FWM8739 is not set
# CONFIG=5FVIDEO=5FVP27SMPX is not set

#
# RDS decoders
#
# CONFIG=5FVIDEO=5FSAA6588 is not set

#
# Video decoders
#
# CONFIG=5FVIDEO=5FADV7180 is not set
# CONFIG=5FVIDEO=5FADV7183 is not set
# CONFIG=5FVIDEO=5FBT819 is not set
# CONFIG=5FVIDEO=5FBT856 is not set
# CONFIG=5FVIDEO=5FBT866 is not set
# CONFIG=5FVIDEO=5FKS0127 is not set
# CONFIG=5FVIDEO=5FSAA7110 is not set
# CONFIG=5FVIDEO=5FSAA711X is not set
# CONFIG=5FVIDEO=5FSAA7191 is not set
# CONFIG=5FVIDEO=5FTVP514X is not set
# CONFIG=5FVIDEO=5FTVP5150 is not set
# CONFIG=5FVIDEO=5FTVP7002 is not set
# CONFIG=5FVIDEO=5FVPX3220 is not set

#
# Video and audio decoders
#
# CONFIG=5FVIDEO=5FSAA717X is not set
# CONFIG=5FVIDEO=5FCX25840 is not set

#
# MPEG video encoders
#
# CONFIG=5FVIDEO=5FCX2341X is not set

#
# Video encoders
#
# CONFIG=5FVIDEO=5FSAA7127 is not set
# CONFIG=5FVIDEO=5FSAA7185 is not set
# CONFIG=5FVIDEO=5FADV7170 is not set
# CONFIG=5FVIDEO=5FADV7175 is not set
# CONFIG=5FVIDEO=5FADV7343 is not set
# CONFIG=5FVIDEO=5FAK881X is not set

#
# Camera sensor devices
#
# CONFIG=5FVIDEO=5FOV7670 is not set
# CONFIG=5FVIDEO=5FVS6624 is not set
# CONFIG=5FVIDEO=5FMT9V011 is not set
# CONFIG=5FVIDEO=5FTCM825X is not set
# CONFIG=5FVIDEO=5FSR030PC30 is not set

#
# Flash devices
#

#
# Video improvement chips
#
# CONFIG=5FVIDEO=5FUPD64031A is not set
# CONFIG=5FVIDEO=5FUPD64083 is not set

#
# Miscelaneous helper chips
#
# CONFIG=5FVIDEO=5FTHS7303 is not set
# CONFIG=5FVIDEO=5FM52790 is not set
# CONFIG=5FVIDEO=5FVIVI is not set
CONFIG=5FV4L=5FUSB=5FDRIVERS=3Dy
CONFIG=5FUSB=5FVIDEO=5FCLASS=3Dy
CONFIG=5FUSB=5FVIDEO=5FCLASS=5FINPUT=5FEVDEV=3Dy
CONFIG=5FUSB=5FGSPCA=3Dy
# CONFIG=5FUSB=5FM5602 is not set
# CONFIG=5FUSB=5FSTV06XX is not set
# CONFIG=5FUSB=5FGL860 is not set
# CONFIG=5FUSB=5FGSPCA=5FBENQ is not set
# CONFIG=5FUSB=5FGSPCA=5FCONEX is not set
# CONFIG=5FUSB=5FGSPCA=5FCPIA1 is not set
# CONFIG=5FUSB=5FGSPCA=5FETOMS is not set
# CONFIG=5FUSB=5FGSPCA=5FFINEPIX is not set
# CONFIG=5FUSB=5FGSPCA=5FJEILINJ is not set
# CONFIG=5FUSB=5FGSPCA=5FJL2005BCD is not set
# CONFIG=5FUSB=5FGSPCA=5FKINECT is not set
# CONFIG=5FUSB=5FGSPCA=5FKONICA is not set
# CONFIG=5FUSB=5FGSPCA=5FMARS is not set
# CONFIG=5FUSB=5FGSPCA=5FMR97310A is not set
# CONFIG=5FUSB=5FGSPCA=5FNW80X is not set
# CONFIG=5FUSB=5FGSPCA=5FOV519 is not set
# CONFIG=5FUSB=5FGSPCA=5FOV534 is not set
# CONFIG=5FUSB=5FGSPCA=5FOV534=5F9 is not set
# CONFIG=5FUSB=5FGSPCA=5FPAC207 is not set
# CONFIG=5FUSB=5FGSPCA=5FPAC7302 is not set
# CONFIG=5FUSB=5FGSPCA=5FPAC7311 is not set
# CONFIG=5FUSB=5FGSPCA=5FSE401 is not set
# CONFIG=5FUSB=5FGSPCA=5FSN9C2028 is not set
# CONFIG=5FUSB=5FGSPCA=5FSN9C20X is not set
# CONFIG=5FUSB=5FGSPCA=5FSONIXB is not set
# CONFIG=5FUSB=5FGSPCA=5FSONIXJ is not set
# CONFIG=5FUSB=5FGSPCA=5FSPCA500 is not set
# CONFIG=5FUSB=5FGSPCA=5FSPCA501 is not set
# CONFIG=5FUSB=5FGSPCA=5FSPCA505 is not set
# CONFIG=5FUSB=5FGSPCA=5FSPCA506 is not set
# CONFIG=5FUSB=5FGSPCA=5FSPCA508 is not set
# CONFIG=5FUSB=5FGSPCA=5FSPCA561 is not set
# CONFIG=5FUSB=5FGSPCA=5FSPCA1528 is not set
# CONFIG=5FUSB=5FGSPCA=5FSQ905 is not set
# CONFIG=5FUSB=5FGSPCA=5FSQ905C is not set
# CONFIG=5FUSB=5FGSPCA=5FSQ930X is not set
# CONFIG=5FUSB=5FGSPCA=5FSTK014 is not set
# CONFIG=5FUSB=5FGSPCA=5FSTV0680 is not set
# CONFIG=5FUSB=5FGSPCA=5FSUNPLUS is not set
# CONFIG=5FUSB=5FGSPCA=5FT613 is not set
# CONFIG=5FUSB=5FGSPCA=5FTOPRO is not set
# CONFIG=5FUSB=5FGSPCA=5FTV8532 is not set
# CONFIG=5FUSB=5FGSPCA=5FVC032X is not set
# CONFIG=5FUSB=5FGSPCA=5FVICAM is not set
# CONFIG=5FUSB=5FGSPCA=5FXIRLINK=5FCIT is not set
# CONFIG=5FUSB=5FGSPCA=5FZC3XX is not set
# CONFIG=5FVIDEO=5FPVRUSB2 is not set
# CONFIG=5FVIDEO=5FHDPVR is not set
# CONFIG=5FVIDEO=5FEM28XX is not set
# CONFIG=5FVIDEO=5FUSBVISION is not set
# CONFIG=5FUSB=5FSN9C102 is not set
# CONFIG=5FUSB=5FPWC is not set
# CONFIG=5FVIDEO=5FCPIA2 is not set
# CONFIG=5FUSB=5FZR364XX is not set
# CONFIG=5FUSB=5FSTKWEBCAM is not set
# CONFIG=5FUSB=5FS2255 is not set
# CONFIG=5FV4L=5FPLATFORM=5FDRIVERS is not set
# CONFIG=5FV4L=5FMEM2MEM=5FDRIVERS is not set
# CONFIG=5FRADIO=5FADAPTERS is not set

#
# Graphics support
#
# CONFIG=5FDRM is not set
# CONFIG=5FVGASTATE is not set
# CONFIG=5FVIDEO=5FOUTPUT=5FCONTROL is not set
CONFIG=5FFB=3Dy
# CONFIG=5FFIRMWARE=5FEDID is not set
# CONFIG=5FFB=5FDDC is not set
# CONFIG=5FFB=5FBOOT=5FVESA=5FSUPPORT is not set
CONFIG=5FFB=5FCFB=5FFILLRECT=3Dy
CONFIG=5FFB=5FCFB=5FCOPYAREA=3Dy
CONFIG=5FFB=5FCFB=5FIMAGEBLIT=3Dy
# CONFIG=5FFB=5FCFB=5FREV=5FPIXELS=5FIN=5FBYTE is not set
# CONFIG=5FFB=5FSYS=5FFILLRECT is not set
# CONFIG=5FFB=5FSYS=5FCOPYAREA is not set
# CONFIG=5FFB=5FSYS=5FIMAGEBLIT is not set
# CONFIG=5FFB=5FFOREIGN=5FENDIAN is not set
# CONFIG=5FFB=5FSYS=5FFOPS is not set
# CONFIG=5FFB=5FWMT=5FGE=5FROPS is not set
# CONFIG=5FFB=5FSVGALIB is not set
# CONFIG=5FFB=5FMACMODES is not set
# CONFIG=5FFB=5FBACKLIGHT is not set
# CONFIG=5FFB=5FMODE=5FHELPERS is not set
# CONFIG=5FFB=5FTILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG=5FFB=5FARMCLCD is not set
# CONFIG=5FFB=5FUVESA is not set
# CONFIG=5FFB=5FS1D13XXX is not set
# CONFIG=5FFB=5FSMSCUFX is not set
# CONFIG=5FFB=5FUDL is not set
# CONFIG=5FFB=5FXILINX is not set
# CONFIG=5FFB=5FVIRTUAL is not set
# CONFIG=5FFB=5FMETRONOME is not set
# CONFIG=5FFB=5FBROADSHEET is not set
# CONFIG=5FFB=5FAUO=5FK190X is not set
CONFIG=5FFB=5FXYLON=3Dy
# CONFIG=5FFB=5FXYLON=5FPLATFORM is not set
CONFIG=5FFB=5FXYLON=5FOF=3Dy
# CONFIG=5FFB=5FXYLON=5FEXT=5FPIXCLK is not set
# CONFIG=5FFB=5FXYLON=5FZYNQ=5FPS=5FPIXCLK is not set
CONFIG=5FFB=5FXYLON=5FZC702=5FPIXCLK=3Dy
# CONFIG=5FEXYNOS=5FVIDEO is not set
# CONFIG=5FBACKLIGHT=5FLCD=5FSUPPORT is not set

#
# Console display driver support
#
CONFIG=5FDUMMY=5FCONSOLE=3Dy
CONFIG=5FFRAMEBUFFER=5FCONSOLE=3Dy
# CONFIG=5FFRAMEBUFFER=5FCONSOLE=5FDETECT=5FPRIMARY is not set
# CONFIG=5FFRAMEBUFFER=5FCONSOLE=5FROTATION is not set
CONFIG=5FFONTS=3Dy
CONFIG=5FFONT=5F8x8=3Dy
CONFIG=5FFONT=5F8x16=3Dy
# CONFIG=5FFONT=5F6x11 is not set
# CONFIG=5FFONT=5F7x14 is not set
# CONFIG=5FFONT=5FPEARL=5F8x8 is not set
# CONFIG=5FFONT=5FACORN=5F8x8 is not set
# CONFIG=5FFONT=5FMINI=5F4x6 is not set
# CONFIG=5FFONT=5FSUN8x16 is not set
# CONFIG=5FFONT=5FSUN12x22 is not set
# CONFIG=5FFONT=5F10x18 is not set
# CONFIG=5FLOGO is not set
# CONFIG=5FSOUND is not set

#
# HID support
#
CONFIG=5FHID=3Dy
# CONFIG=5FHIDRAW is not set
CONFIG=5FHID=5FGENERIC=3Dy

#
# Special HID drivers
#
# CONFIG=5FHID=5FA4TECH is not set
# CONFIG=5FHID=5FACRUX is not set
# CONFIG=5FHID=5FAPPLE is not set
# CONFIG=5FHID=5FAUREAL is not set
# CONFIG=5FHID=5FBELKIN is not set
# CONFIG=5FHID=5FCHERRY is not set
# CONFIG=5FHID=5FCHICONY is not set
# CONFIG=5FHID=5FCYPRESS is not set
# CONFIG=5FHID=5FDRAGONRISE is not set
# CONFIG=5FHID=5FEMS=5FFF is not set
# CONFIG=5FHID=5FEZKEY is not set
# CONFIG=5FHID=5FHOLTEK is not set
# CONFIG=5FHID=5FKEYTOUCH is not set
# CONFIG=5FHID=5FKYE is not set
# CONFIG=5FHID=5FUCLOGIC is not set
# CONFIG=5FHID=5FWALTOP is not set
# CONFIG=5FHID=5FGYRATION is not set
# CONFIG=5FHID=5FTWINHAN is not set
# CONFIG=5FHID=5FKENSINGTON is not set
# CONFIG=5FHID=5FLCPOWER is not set
# CONFIG=5FHID=5FLOGITECH is not set
CONFIG=5FHID=5FMICROSOFT=3Dy
# CONFIG=5FHID=5FMONTEREY is not set
# CONFIG=5FHID=5FMULTITOUCH is not set
# CONFIG=5FHID=5FNTRIG is not set
# CONFIG=5FHID=5FORTEK is not set
# CONFIG=5FHID=5FPANTHERLORD is not set
# CONFIG=5FHID=5FPETALYNX is not set
# CONFIG=5FHID=5FPICOLCD is not set
# CONFIG=5FHID=5FPRIMAX is not set
# CONFIG=5FHID=5FROCCAT is not set
# CONFIG=5FHID=5FSAITEK is not set
# CONFIG=5FHID=5FSAMSUNG is not set
# CONFIG=5FHID=5FSONY is not set
# CONFIG=5FHID=5FSPEEDLINK is not set
# CONFIG=5FHID=5FSUNPLUS is not set
# CONFIG=5FHID=5FGREENASIA is not set
# CONFIG=5FHID=5FSMARTJOYPLUS is not set
# CONFIG=5FHID=5FTIVO is not set
# CONFIG=5FHID=5FTOPSEED is not set
# CONFIG=5FHID=5FTHRUSTMASTER is not set
# CONFIG=5FHID=5FZEROPLUS is not set
# CONFIG=5FHID=5FZYDACRON is not set

#
# USB HID support
#
CONFIG=5FUSB=5FHID=3Dy
# CONFIG=5FHID=5FPID is not set
# CONFIG=5FUSB=5FHIDDEV is not set
# CONFIG=5FUSB=5FARCH=5FHAS=5FOHCI is not set
CONFIG=5FUSB=5FARCH=5FHAS=5FEHCI=3Dy
# CONFIG=5FUSB=5FARCH=5FHAS=5FXHCI is not set
CONFIG=5FUSB=5FSUPPORT=3Dy
CONFIG=5FUSB=5FCOMMON=3Dy
CONFIG=5FUSB=5FARCH=5FHAS=5FHCD=3Dy
CONFIG=5FUSB=3Dy
# CONFIG=5FUSB=5FDEBUG is not set
# CONFIG=5FUSB=5FANNOUNCE=5FNEW=5FDEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG=5FUSB=5FDYNAMIC=5FMINORS is not set
CONFIG=5FUSB=5FSUSPEND=3Dy
CONFIG=5FUSB=5FOTG=3Dy
# CONFIG=5FUSB=5FOTG=5FWHITELIST is not set
# CONFIG=5FUSB=5FOTG=5FBLACKLIST=5FHUB is not set
# CONFIG=5FUSB=5FDWC3 is not set
# CONFIG=5FUSB=5FMON is not set
# CONFIG=5FUSB=5FWUSB=5FCBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG=5FUSB=5FC67X00=5FHCD is not set
CONFIG=5FUSB=5FEHCI=5FHCD=3Dy
CONFIG=5FUSB=5FEHCI=5FROOT=5FHUB=5FTT=3Dy
# CONFIG=5FUSB=5FEHCI=5FTT=5FNEWSCHED is not set
CONFIG=5FUSB=5FXUSBPS=5FDR=5FOF=3Dy
CONFIG=5FUSB=5FEHCI=5FXUSBPS=3Dy
# CONFIG=5FUSB=5FOXU210HP=5FHCD is not set
# CONFIG=5FUSB=5FISP116X=5FHCD is not set
# CONFIG=5FUSB=5FISP1760=5FHCD is not set
# CONFIG=5FUSB=5FISP1362=5FHCD is not set
# CONFIG=5FUSB=5FEHCI=5FHCD=5FPLATFORM is not set
# CONFIG=5FUSB=5FSL811=5FHCD is not set
# CONFIG=5FUSB=5FR8A66597=5FHCD is not set
# CONFIG=5FUSB=5FMUSB=5FHDRC is not set
# CONFIG=5FUSB=5FCHIPIDEA is not set
# CONFIG=5FUSB=5FRENESAS=5FUSBHS is not set

#
# USB Device Class drivers
#
# CONFIG=5FUSB=5FACM is not set
# CONFIG=5FUSB=5FPRINTER is not set
# CONFIG=5FUSB=5FWDM is not set
# CONFIG=5FUSB=5FTMC is not set

#
# NOTE: USB=5FSTORAGE depends on SCSI but BLK=5FDEV=5FSD may
#

#
# also be needed; see USB=5FSTORAGE Help for more info
#
CONFIG=5FUSB=5FSTORAGE=3Dy
# CONFIG=5FUSB=5FSTORAGE=5FDEBUG is not set
# CONFIG=5FUSB=5FSTORAGE=5FREALTEK is not set
# CONFIG=5FUSB=5FSTORAGE=5FDATAFAB is not set
# CONFIG=5FUSB=5FSTORAGE=5FFREECOM is not set
# CONFIG=5FUSB=5FSTORAGE=5FISD200 is not set
# CONFIG=5FUSB=5FSTORAGE=5FUSBAT is not set
# CONFIG=5FUSB=5FSTORAGE=5FSDDR09 is not set
# CONFIG=5FUSB=5FSTORAGE=5FSDDR55 is not set
# CONFIG=5FUSB=5FSTORAGE=5FJUMPSHOT is not set
# CONFIG=5FUSB=5FSTORAGE=5FALAUDA is not set
# CONFIG=5FUSB=5FSTORAGE=5FONETOUCH is not set
# CONFIG=5FUSB=5FSTORAGE=5FKARMA is not set
# CONFIG=5FUSB=5FSTORAGE=5FCYPRESS=5FATACB is not set
# CONFIG=5FUSB=5FSTORAGE=5FENE=5FUB6250 is not set
# CONFIG=5FUSB=5FUAS is not set
# CONFIG=5FUSB=5FLIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG=5FUSB=5FMDC800 is not set
# CONFIG=5FUSB=5FMICROTEK is not set

#
# USB port drivers
#
# CONFIG=5FUSB=5FSERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG=5FUSB=5FEMI62 is not set
# CONFIG=5FUSB=5FEMI26 is not set
# CONFIG=5FUSB=5FADUTUX is not set
# CONFIG=5FUSB=5FSEVSEG is not set
# CONFIG=5FUSB=5FRIO500 is not set
# CONFIG=5FUSB=5FLEGOTOWER is not set
# CONFIG=5FUSB=5FLCD is not set
# CONFIG=5FUSB=5FLED is not set
# CONFIG=5FUSB=5FCYPRESS=5FCY7C63 is not set
# CONFIG=5FUSB=5FCYTHERM is not set
# CONFIG=5FUSB=5FIDMOUSE is not set
# CONFIG=5FUSB=5FFTDI=5FELAN is not set
# CONFIG=5FUSB=5FAPPLEDISPLAY is not set
# CONFIG=5FUSB=5FSISUSBVGA is not set
# CONFIG=5FUSB=5FLD is not set
# CONFIG=5FUSB=5FTRANCEVIBRATOR is not set
# CONFIG=5FUSB=5FIOWARRIOR is not set
# CONFIG=5FUSB=5FTEST is not set
# CONFIG=5FUSB=5FISIGHTFW is not set
# CONFIG=5FUSB=5FYUREX is not set

#
# USB Physical Layer drivers
#
# CONFIG=5FUSB=5FISP1301 is not set
CONFIG=5FUSB=5FGADGET=3Dy
# CONFIG=5FUSB=5FGADGET=5FDEBUG is not set
# CONFIG=5FUSB=5FGADGET=5FDEBUG=5FFILES is not set
# CONFIG=5FUSB=5FGADGET=5FDEBUG=5FFS is not set
CONFIG=5FUSB=5FGADGET=5FVBUS=5FDRAW=3D2
CONFIG=5FUSB=5FGADGET=5FSTORAGE=5FNUM=5FBUFFERS=3D2

#
# USB Peripheral Controller
#
CONFIG=5FUSB=5FGADGET=5FXUSBPS=3Dy
CONFIG=5FXUSBPS=5FERRATA=5FDT654401=3Dy
CONFIG=5FUSB=5FXUSBPS=3Dy
# CONFIG=5FUSB=5FFUSB300 is not set
# CONFIG=5FUSB=5FR8A66597 is not set
# CONFIG=5FUSB=5FGADGET=5FXILINX is not set
# CONFIG=5FUSB=5FMV=5FUDC is not set
# CONFIG=5FUSB=5FM66592 is not set
# CONFIG=5FUSB=5FNET2272 is not set
# CONFIG=5FUSB=5FDUMMY=5FHCD is not set
CONFIG=5FUSB=5FGADGET=5FDUALSPEED=3Dy
CONFIG=5FUSB=5FZERO=3Dm
# CONFIG=5FUSB=5FZERO=5FHNPTEST is not set
# CONFIG=5FUSB=5FETH is not set
# CONFIG=5FUSB=5FG=5FNCM is not set
# CONFIG=5FUSB=5FGADGETFS is not set
# CONFIG=5FUSB=5FFUNCTIONFS is not set
CONFIG=5FUSB=5FFILE=5FSTORAGE=3Dm
# CONFIG=5FUSB=5FFILE=5FSTORAGE=5FTEST is not set
# CONFIG=5FUSB=5FMASS=5FSTORAGE is not set
# CONFIG=5FUSB=5FG=5FSERIAL is not set
# CONFIG=5FUSB=5FG=5FPRINTER is not set
# CONFIG=5FUSB=5FCDC=5FCOMPOSITE is not set
# CONFIG=5FUSB=5FG=5FACM=5FMS is not set
# CONFIG=5FUSB=5FG=5FMULTI is not set
# CONFIG=5FUSB=5FG=5FHID is not set
# CONFIG=5FUSB=5FG=5FDBGP is not set
# CONFIG=5FUSB=5FG=5FWEBCAM is not set

#
# OTG and related infrastructure
#
CONFIG=5FUSB=5FOTG=5FUTILS=3Dy
# CONFIG=5FUSB=5FGPIO=5FVBUS is not set
# CONFIG=5FUSB=5FULPI is not set
# CONFIG=5FNOP=5FUSB=5FXCEIV is not set
CONFIG=5FUSB=5FXUSBPS=5FOTG=3Dy
CONFIG=5FMMC=3Dy
# CONFIG=5FMMC=5FDEBUG is not set
# CONFIG=5FMMC=5FUNSAFE=5FRESUME is not set
# CONFIG=5FMMC=5FCLKGATE is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG=5FMMC=5FBLOCK=3Dy
CONFIG=5FMMC=5FBLOCK=5FMINORS=3D8
CONFIG=5FMMC=5FBLOCK=5FBOUNCE=3Dy
# CONFIG=5FSDIO=5FUART is not set
# CONFIG=5FMMC=5FTEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG=5FMMC=5FARMMMCI is not set
CONFIG=5FMMC=5FSDHCI=3Dy
CONFIG=5FMMC=5FSDHCI=5FPLTFM=3Dy
CONFIG=5FMMC=5FSDHCI=5FOF=5FXILINX=5FPS=3Dy
# CONFIG=5FMMC=5FSDHCI=5FPXAV3 is not set
# CONFIG=5FMMC=5FSDHCI=5FPXAV2 is not set
# CONFIG=5FMMC=5FWBSD is not set
# CONFIG=5FMMC=5FDW is not set
# CONFIG=5FMMC=5FVUB300 is not set
# CONFIG=5FMMC=5FUSHC is not set
# CONFIG=5FMEMSTICK is not set
# CONFIG=5FNEW=5FLEDS is not set
# CONFIG=5FACCESSIBILITY is not set
CONFIG=5FRTC=5FLIB=3Dy
CONFIG=5FRTC=5FCLASS=3Dy
CONFIG=5FRTC=5FHCTOSYS=3Dy
CONFIG=5FRTC=5FHCTOSYS=5FDEVICE=3D"rtc0"
# CONFIG=5FRTC=5FDEBUG is not set

#
# RTC interfaces
#
CONFIG=5FRTC=5FINTF=5FSYSFS=3Dy
CONFIG=5FRTC=5FINTF=5FPROC=3Dy
CONFIG=5FRTC=5FINTF=5FDEV=3Dy
# CONFIG=5FRTC=5FINTF=5FDEV=5FUIE=5FEMUL is not set
# CONFIG=5FRTC=5FDRV=5FTEST is not set

#
# I2C RTC drivers
#
# CONFIG=5FRTC=5FDRV=5FDS1307 is not set
# CONFIG=5FRTC=5FDRV=5FDS1374 is not set
# CONFIG=5FRTC=5FDRV=5FDS1672 is not set
# CONFIG=5FRTC=5FDRV=5FDS3232 is not set
# CONFIG=5FRTC=5FDRV=5FMAX6900 is not set
# CONFIG=5FRTC=5FDRV=5FRS5C372 is not set
# CONFIG=5FRTC=5FDRV=5FISL1208 is not set
# CONFIG=5FRTC=5FDRV=5FISL12022 is not set
# CONFIG=5FRTC=5FDRV=5FX1205 is not set
CONFIG=5FRTC=5FDRV=5FPCF8563=3Dy
# CONFIG=5FRTC=5FDRV=5FPCF8583 is not set
# CONFIG=5FRTC=5FDRV=5FM41T80 is not set
# CONFIG=5FRTC=5FDRV=5FBQ32K is not set
# CONFIG=5FRTC=5FDRV=5FS35390A is not set
# CONFIG=5FRTC=5FDRV=5FFM3130 is not set
# CONFIG=5FRTC=5FDRV=5FRX8581 is not set
# CONFIG=5FRTC=5FDRV=5FRX8025 is not set
# CONFIG=5FRTC=5FDRV=5FEM3027 is not set
# CONFIG=5FRTC=5FDRV=5FRV3029C2 is not set

#
# SPI RTC drivers
#
# CONFIG=5FRTC=5FDRV=5FM41T93 is not set
# CONFIG=5FRTC=5FDRV=5FM41T94 is not set
# CONFIG=5FRTC=5FDRV=5FDS1305 is not set
# CONFIG=5FRTC=5FDRV=5FDS1390 is not set
# CONFIG=5FRTC=5FDRV=5FMAX6902 is not set
# CONFIG=5FRTC=5FDRV=5FR9701 is not set
# CONFIG=5FRTC=5FDRV=5FRS5C348 is not set
# CONFIG=5FRTC=5FDRV=5FDS3234 is not set
# CONFIG=5FRTC=5FDRV=5FPCF2123 is not set

#
# Platform RTC drivers
#
# CONFIG=5FRTC=5FDRV=5FCMOS is not set
# CONFIG=5FRTC=5FDRV=5FDS1286 is not set
# CONFIG=5FRTC=5FDRV=5FDS1511 is not set
# CONFIG=5FRTC=5FDRV=5FDS1553 is not set
# CONFIG=5FRTC=5FDRV=5FDS1742 is not set
# CONFIG=5FRTC=5FDRV=5FSTK17TA8 is not set
# CONFIG=5FRTC=5FDRV=5FM48T86 is not set
# CONFIG=5FRTC=5FDRV=5FM48T35 is not set
# CONFIG=5FRTC=5FDRV=5FM48T59 is not set
# CONFIG=5FRTC=5FDRV=5FMSM6242 is not set
# CONFIG=5FRTC=5FDRV=5FBQ4802 is not set
# CONFIG=5FRTC=5FDRV=5FRP5C01 is not set
# CONFIG=5FRTC=5FDRV=5FV3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG=5FRTC=5FDRV=5FPL030 is not set
# CONFIG=5FRTC=5FDRV=5FPL031 is not set
# CONFIG=5FDMADEVICES is not set
# CONFIG=5FAUXDISPLAY is not set
CONFIG=5FUIO=3Dy
CONFIG=5FUIO=5FPDRV=3Dy
CONFIG=5FUIO=5FPDRV=5FGENIRQ=3Dy

#
# Virtio drivers
#
# CONFIG=5FVIRTIO=5FBALLOON is not set
# CONFIG=5FVIRTIO=5FMMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG=5FSTAGING is not set
CONFIG=5FCLKDEV=5FLOOKUP=3Dy
CONFIG=5FHAVE=5FCLK=5FPREPARE=3Dy
CONFIG=5FCOMMON=5FCLK=3Dy

#
# Common Clock Framework
#
CONFIG=5FCOMMON=5FCLK=5FDEBUG=3Dy

#
# Hardware Spinlock drivers
#
CONFIG=5FIOMMU=5FSUPPORT=3Dy

#
# Remoteproc drivers (EXPERIMENTAL)
#

#
# Rpmsg drivers (EXPERIMENTAL)
#
# CONFIG=5FVIRT=5FDRIVERS is not set
# CONFIG=5FPM=5FDEVFREQ is not set
# CONFIG=5FEXTCON is not set
# CONFIG=5FMEMORY is not set
# CONFIG=5FIIO is not set

#
# File systems
#
CONFIG=5FEXT2=5FFS=3Dy
# CONFIG=5FEXT2=5FFS=5FXATTR is not set
# CONFIG=5FEXT2=5FFS=5FXIP is not set
CONFIG=5FEXT3=5FFS=3Dy
# CONFIG=5FEXT3=5FDEFAULTS=5FTO=5FORDERED is not set
CONFIG=5FEXT3=5FFS=5FXATTR=3Dy
# CONFIG=5FEXT3=5FFS=5FPOSIX=5FACL is not set
# CONFIG=5FEXT3=5FFS=5FSECURITY is not set
CONFIG=5FEXT4=5FFS=3Dy
CONFIG=5FEXT4=5FFS=5FXATTR=3Dy
# CONFIG=5FEXT4=5FFS=5FPOSIX=5FACL is not set
# CONFIG=5FEXT4=5FFS=5FSECURITY is not set
# CONFIG=5FEXT4=5FDEBUG is not set
CONFIG=5FJBD=3Dy
# CONFIG=5FJBD=5FDEBUG is not set
CONFIG=5FJBD2=3Dy
# CONFIG=5FJBD2=5FDEBUG is not set
CONFIG=5FFS=5FMBCACHE=3Dy
# CONFIG=5FREISERFS=5FFS is not set
# CONFIG=5FJFS=5FFS is not set
# CONFIG=5FXFS=5FFS is not set
# CONFIG=5FGFS2=5FFS is not set
# CONFIG=5FBTRFS=5FFS is not set
# CONFIG=5FNILFS2=5FFS is not set
# CONFIG=5FFS=5FPOSIX=5FACL is not set
CONFIG=5FFILE=5FLOCKING=3Dy
CONFIG=5FFSNOTIFY=3Dy
# CONFIG=5FDNOTIFY is not set
CONFIG=5FINOTIFY=5FUSER=3Dy
# CONFIG=5FFANOTIFY is not set
# CONFIG=5FQUOTA is not set
# CONFIG=5FQUOTACTL is not set
# CONFIG=5FAUTOFS4=5FFS is not set
# CONFIG=5FFUSE=5FFS is not set

#
# Caches
#
# CONFIG=5FFSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG=5FISO9660=5FFS is not set
# CONFIG=5FUDF=5FFS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG=5FFAT=5FFS=3Dy
CONFIG=5FMSDOS=5FFS=3Dy
CONFIG=5FVFAT=5FFS=3Dy
CONFIG=5FFAT=5FDEFAULT=5FCODEPAGE=3D437
CONFIG=5FFAT=5FDEFAULT=5FIOCHARSET=3D"iso8859-1"
# CONFIG=5FNTFS=5FFS is not set

#
# Pseudo filesystems
#
CONFIG=5FPROC=5FFS=3Dy
CONFIG=5FPROC=5FSYSCTL=3Dy
CONFIG=5FPROC=5FPAGE=5FMONITOR=3Dy
CONFIG=5FSYSFS=3Dy
CONFIG=5FTMPFS=3Dy
# CONFIG=5FTMPFS=5FPOSIX=5FACL is not set
# CONFIG=5FTMPFS=5FXATTR is not set
# CONFIG=5FHUGETLB=5FPAGE is not set
# CONFIG=5FCONFIGFS=5FFS is not set
CONFIG=5FMISC=5FFILESYSTEMS=3Dy
# CONFIG=5FADFS=5FFS is not set
# CONFIG=5FAFFS=5FFS is not set
# CONFIG=5FHFS=5FFS is not set
# CONFIG=5FHFSPLUS=5FFS is not set
# CONFIG=5FBEFS=5FFS is not set
# CONFIG=5FBFS=5FFS is not set
# CONFIG=5FEFS=5FFS is not set
CONFIG=5FJFFS2=5FFS=3Dy
CONFIG=5FJFFS2=5FFS=5FDEBUG=3D0
CONFIG=5FJFFS2=5FFS=5FWRITEBUFFER=3Dy
# CONFIG=5FJFFS2=5FFS=5FWBUF=5FVERIFY is not set
CONFIG=5FJFFS2=5FSUMMARY=3Dy
# CONFIG=5FJFFS2=5FFS=5FXATTR is not set
# CONFIG=5FJFFS2=5FCOMPRESSION=5FOPTIONS is not set
CONFIG=5FJFFS2=5FZLIB=3Dy
# CONFIG=5FJFFS2=5FLZO is not set
CONFIG=5FJFFS2=5FRTIME=3Dy
# CONFIG=5FJFFS2=5FRUBIN is not set
# CONFIG=5FLOGFS is not set
# CONFIG=5FCRAMFS is not set
# CONFIG=5FSQUASHFS is not set
# CONFIG=5FVXFS=5FFS is not set
# CONFIG=5FMINIX=5FFS is not set
# CONFIG=5FOMFS=5FFS is not set
# CONFIG=5FHPFS=5FFS is not set
# CONFIG=5FQNX4FS=5FFS is not set
# CONFIG=5FQNX6FS=5FFS is not set
# CONFIG=5FROMFS=5FFS is not set
# CONFIG=5FPSTORE is not set
# CONFIG=5FSYSV=5FFS is not set
# CONFIG=5FUFS=5FFS is not set
CONFIG=5FNETWORK=5FFILESYSTEMS=3Dy
CONFIG=5FNFS=5FFS=3Dy
CONFIG=5FNFS=5FV2=3Dy
CONFIG=5FNFS=5FV3=3Dy
# CONFIG=5FNFS=5FV3=5FACL is not set
# CONFIG=5FNFS=5FV4 is not set
CONFIG=5FROOT=5FNFS=3Dy
# CONFIG=5FNFSD is not set
CONFIG=5FLOCKD=3Dy
CONFIG=5FLOCKD=5FV4=3Dy
CONFIG=5FNFS=5FCOMMON=3Dy
CONFIG=5FSUNRPC=3Dy
# CONFIG=5FSUNRPC=5FDEBUG is not set
# CONFIG=5FCEPH=5FFS is not set
# CONFIG=5FCIFS is not set
# CONFIG=5FNCP=5FFS is not set
# CONFIG=5FCODA=5FFS is not set
# CONFIG=5FAFS=5FFS is not set
CONFIG=5FNLS=3Dy
CONFIG=5FNLS=5FDEFAULT=3D"iso8859-1"
CONFIG=5FNLS=5FCODEPAGE=5F437=3Dy
# CONFIG=5FNLS=5FCODEPAGE=5F737 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F775 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F850 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F852 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F855 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F857 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F860 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F861 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F862 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F863 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F864 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F865 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F866 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F869 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F936 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F950 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F932 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F949 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F874 is not set
# CONFIG=5FNLS=5FISO8859=5F8 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F1250 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F1251 is not set
CONFIG=5FNLS=5FASCII=3Dy
CONFIG=5FNLS=5FISO8859=5F1=3Dy
# CONFIG=5FNLS=5FISO8859=5F2 is not set
# CONFIG=5FNLS=5FISO8859=5F3 is not set
# CONFIG=5FNLS=5FISO8859=5F4 is not set
# CONFIG=5FNLS=5FISO8859=5F5 is not set
# CONFIG=5FNLS=5FISO8859=5F6 is not set
# CONFIG=5FNLS=5FISO8859=5F7 is not set
# CONFIG=5FNLS=5FISO8859=5F9 is not set
# CONFIG=5FNLS=5FISO8859=5F13 is not set
# CONFIG=5FNLS=5FISO8859=5F14 is not set
# CONFIG=5FNLS=5FISO8859=5F15 is not set
# CONFIG=5FNLS=5FKOI8=5FR is not set
# CONFIG=5FNLS=5FKOI8=5FU is not set
# CONFIG=5FNLS=5FMAC=5FROMAN is not set
# CONFIG=5FNLS=5FMAC=5FCELTIC is not set
# CONFIG=5FNLS=5FMAC=5FCENTEURO is not set
# CONFIG=5FNLS=5FMAC=5FCROATIAN is not set
# CONFIG=5FNLS=5FMAC=5FCYRILLIC is not set
# CONFIG=5FNLS=5FMAC=5FGAELIC is not set
# CONFIG=5FNLS=5FMAC=5FGREEK is not set
# CONFIG=5FNLS=5FMAC=5FICELAND is not set
# CONFIG=5FNLS=5FMAC=5FINUIT is not set
# CONFIG=5FNLS=5FMAC=5FROMANIAN is not set
# CONFIG=5FNLS=5FMAC=5FTURKISH is not set
# CONFIG=5FNLS=5FUTF8 is not set

#
# Kernel hacking
#
# CONFIG=5FPRINTK=5FTIME is not set
CONFIG=5FDEFAULT=5FMESSAGE=5FLOGLEVEL=3D4
# CONFIG=5FENABLE=5FWARN=5FDEPRECATED is not set
# CONFIG=5FENABLE=5FMUST=5FCHECK is not set
CONFIG=5FFRAME=5FWARN=3D1024
# CONFIG=5FMAGIC=5FSYSRQ is not set
# CONFIG=5FSTRIP=5FASM=5FSYMS is not set
# CONFIG=5FREADABLE=5FASM is not set
# CONFIG=5FUNUSED=5FSYMBOLS is not set
CONFIG=5FDEBUG=5FFS=3Dy
# CONFIG=5FHEADERS=5FCHECK is not set
# CONFIG=5FDEBUG=5FSECTION=5FMISMATCH is not set
# CONFIG=5FIPIPE=5FDEBUG is not set
CONFIG=5FDEBUG=5FKERNEL=3Dy
# CONFIG=5FDEBUG=5FSHIRQ is not set
# CONFIG=5FLOCKUP=5FDETECTOR is not set
# CONFIG=5FHARDLOCKUP=5FDETECTOR is not set
# CONFIG=5FPANIC=5FON=5FOOPS is not set
CONFIG=5FPANIC=5FON=5FOOPS=5FVALUE=3D0
# CONFIG=5FDETECT=5FHUNG=5FTASK is not set
# CONFIG=5FSCHED=5FDEBUG is not set
# CONFIG=5FSCHEDSTATS is not set
CONFIG=5FTIMER=5FSTATS=3Dy
# CONFIG=5FDEBUG=5FOBJECTS is not set
# CONFIG=5FDEBUG=5FSLAB is not set
# CONFIG=5FDEBUG=5FKMEMLEAK is not set
# CONFIG=5FDEBUG=5FPREEMPT is not set
# CONFIG=5FDEBUG=5FRT=5FMUTEXES is not set
# CONFIG=5FRT=5FMUTEX=5FTESTER is not set
# CONFIG=5FDEBUG=5FSPINLOCK is not set
# CONFIG=5FDEBUG=5FMUTEXES is not set
# CONFIG=5FDEBUG=5FLOCK=5FALLOC is not set
# CONFIG=5FPROVE=5FLOCKING is not set
# CONFIG=5FSPARSE=5FRCU=5FPOINTER is not set
# CONFIG=5FLOCK=5FSTAT is not set
# CONFIG=5FDEBUG=5FATOMIC=5FSLEEP is not set
# CONFIG=5FDEBUG=5FLOCKING=5FAPI=5FSELFTESTS is not set
# CONFIG=5FDEBUG=5FSTACK=5FUSAGE is not set
# CONFIG=5FDEBUG=5FKOBJECT is not set
# CONFIG=5FDEBUG=5FHIGHMEM is not set
# CONFIG=5FDEBUG=5FBUGVERBOSE is not set
# CONFIG=5FDEBUG=5FINFO is not set
# CONFIG=5FDEBUG=5FVM is not set
# CONFIG=5FDEBUG=5FWRITECOUNT is not set
# CONFIG=5FDEBUG=5FMEMORY=5FINIT is not set
# CONFIG=5FDEBUG=5FLIST is not set
# CONFIG=5FTEST=5FLIST=5FSORT is not set
# CONFIG=5FDEBUG=5FSG is not set
# CONFIG=5FDEBUG=5FNOTIFIERS is not set
# CONFIG=5FDEBUG=5FCREDENTIALS is not set
# CONFIG=5FBOOT=5FPRINTK=5FDELAY is not set
# CONFIG=5FRCU=5FTORTURE=5FTEST is not set
CONFIG=5FRCU=5FCPU=5FSTALL=5FTIMEOUT=3D60
# CONFIG=5FRCU=5FCPU=5FSTALL=5FVERBOSE is not set
# CONFIG=5FRCU=5FCPU=5FSTALL=5FINFO is not set
# CONFIG=5FRCU=5FTRACE is not set
# CONFIG=5FBACKTRACE=5FSELF=5FTEST is not set
# CONFIG=5FDEBUG=5FBLOCK=5FEXT=5FDEVT is not set
# CONFIG=5FDEBUG=5FFORCE=5FWEAK=5FPER=5FCPU is not set
# CONFIG=5FDEBUG=5FPER=5FCPU=5FMAPS is not set
# CONFIG=5FLKDTM is not set
# CONFIG=5FCPU=5FNOTIFIER=5FERROR=5FINJECT is not set
# CONFIG=5FFAULT=5FINJECTION is not set
# CONFIG=5FDEBUG=5FPAGEALLOC is not set
CONFIG=5FHAVE=5FFUNCTION=5FTRACER=3Dy
CONFIG=5FHAVE=5FFUNCTION=5FGRAPH=5FTRACER=3Dy
CONFIG=5FHAVE=5FDYNAMIC=5FFTRACE=3Dy
CONFIG=5FHAVE=5FFTRACE=5FMCOUNT=5FRECORD=3Dy
CONFIG=5FHAVE=5FC=5FRECORDMCOUNT=3Dy
CONFIG=5FTRACING=5FSUPPORT=3Dy
# CONFIG=5FFTRACE is not set
CONFIG=5FDYNAMIC=5FDEBUG=3Dy
# CONFIG=5FDMA=5FAPI=5FDEBUG is not set
# CONFIG=5FATOMIC64=5FSELFTEST is not set
# CONFIG=5FSAMPLES is not set
CONFIG=5FHAVE=5FARCH=5FKGDB=3Dy
# CONFIG=5FKGDB is not set
# CONFIG=5FTEST=5FKSTRTOX is not set
# CONFIG=5FSTRICT=5FDEVMEM is not set
CONFIG=5FARM=5FUNWIND=3Dy
# CONFIG=5FDEBUG=5FUSER is not set
CONFIG=5FDEBUG=5FLL=3Dy
CONFIG=5FDEBUG=5FLL=5FUART=5FNONE=3Dy
# CONFIG=5FDEBUG=5FICEDCC is not set
# CONFIG=5FDEBUG=5FSEMIHOSTING is not set
CONFIG=5FEARLY=5FPRINTK=3Dy
# CONFIG=5FOC=5FETM is not set

#
# Security options
#
# CONFIG=5FKEYS is not set
# CONFIG=5FSECURITY=5FDMESG=5FRESTRICT is not set
# CONFIG=5FSECURITY is not set
# CONFIG=5FSECURITYFS is not set
CONFIG=5FDEFAULT=5FSECURITY=5FDAC=3Dy
CONFIG=5FDEFAULT=5FSECURITY=3D""
CONFIG=5FCRYPTO=3Dy

#
# Crypto core or helper
#
# CONFIG=5FCRYPTO=5FFIPS is not set
CONFIG=5FCRYPTO=5FALGAPI=3Dy
CONFIG=5FCRYPTO=5FALGAPI2=3Dy
CONFIG=5FCRYPTO=5FHASH=3Dy
CONFIG=5FCRYPTO=5FHASH2=3Dy
CONFIG=5FCRYPTO=5FRNG=3Dm
CONFIG=5FCRYPTO=5FRNG2=3Dm
# CONFIG=5FCRYPTO=5FMANAGER is not set
# CONFIG=5FCRYPTO=5FMANAGER2 is not set
# CONFIG=5FCRYPTO=5FUSER is not set
# CONFIG=5FCRYPTO=5FGF128MUL is not set
# CONFIG=5FCRYPTO=5FNULL is not set
# CONFIG=5FCRYPTO=5FPCRYPT is not set
# CONFIG=5FCRYPTO=5FCRYPTD is not set
# CONFIG=5FCRYPTO=5FAUTHENC is not set
# CONFIG=5FCRYPTO=5FTEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG=5FCRYPTO=5FCCM is not set
# CONFIG=5FCRYPTO=5FGCM is not set
# CONFIG=5FCRYPTO=5FSEQIV is not set

#
# Block modes
#
# CONFIG=5FCRYPTO=5FCBC is not set
# CONFIG=5FCRYPTO=5FCTR is not set
# CONFIG=5FCRYPTO=5FCTS is not set
# CONFIG=5FCRYPTO=5FECB is not set
# CONFIG=5FCRYPTO=5FLRW is not set
# CONFIG=5FCRYPTO=5FPCBC is not set
# CONFIG=5FCRYPTO=5FXTS is not set

#
# Hash modes
#
# CONFIG=5FCRYPTO=5FHMAC is not set
# CONFIG=5FCRYPTO=5FXCBC is not set
# CONFIG=5FCRYPTO=5FVMAC is not set

#
# Digest
#
CONFIG=5FCRYPTO=5FCRC32C=3Dy
# CONFIG=5FCRYPTO=5FGHASH is not set
# CONFIG=5FCRYPTO=5FMD4 is not set
# CONFIG=5FCRYPTO=5FMD5 is not set
# CONFIG=5FCRYPTO=5FMICHAEL=5FMIC is not set
# CONFIG=5FCRYPTO=5FRMD128 is not set
# CONFIG=5FCRYPTO=5FRMD160 is not set
# CONFIG=5FCRYPTO=5FRMD256 is not set
# CONFIG=5FCRYPTO=5FRMD320 is not set
# CONFIG=5FCRYPTO=5FSHA1 is not set
# CONFIG=5FCRYPTO=5FSHA256 is not set
# CONFIG=5FCRYPTO=5FSHA512 is not set
# CONFIG=5FCRYPTO=5FTGR192 is not set
# CONFIG=5FCRYPTO=5FWP512 is not set

#
# Ciphers
#
CONFIG=5FCRYPTO=5FAES=3Dm
# CONFIG=5FCRYPTO=5FANUBIS is not set
# CONFIG=5FCRYPTO=5FARC4 is not set
# CONFIG=5FCRYPTO=5FBLOWFISH is not set
# CONFIG=5FCRYPTO=5FCAMELLIA is not set
# CONFIG=5FCRYPTO=5FCAST5 is not set
# CONFIG=5FCRYPTO=5FCAST6 is not set
# CONFIG=5FCRYPTO=5FDES is not set
# CONFIG=5FCRYPTO=5FFCRYPT is not set
# CONFIG=5FCRYPTO=5FKHAZAD is not set
# CONFIG=5FCRYPTO=5FSALSA20 is not set
# CONFIG=5FCRYPTO=5FSEED is not set
# CONFIG=5FCRYPTO=5FSERPENT is not set
# CONFIG=5FCRYPTO=5FTEA is not set
# CONFIG=5FCRYPTO=5FTWOFISH is not set

#
# Compression
#
# CONFIG=5FCRYPTO=5FDEFLATE is not set
# CONFIG=5FCRYPTO=5FZLIB is not set
# CONFIG=5FCRYPTO=5FLZO is not set

#
# Random Number Generation
#
CONFIG=5FCRYPTO=5FANSI=5FCPRNG=3Dm
# CONFIG=5FCRYPTO=5FUSER=5FAPI=5FHASH is not set
# CONFIG=5FCRYPTO=5FUSER=5FAPI=5FSKCIPHER is not set
CONFIG=5FCRYPTO=5FHW=3Dy
# CONFIG=5FBINARY=5FPRINTF is not set

#
# Library routines
#
CONFIG=5FBITREVERSE=3Dy
CONFIG=5FGENERIC=5FPCI=5FIOMAP=3Dy
CONFIG=5FGENERIC=5FIO=3Dy
# CONFIG=5FCRC=5FCCITT is not set
CONFIG=5FCRC16=3Dy
# CONFIG=5FCRC=5FT10DIF is not set
# CONFIG=5FCRC=5FITU=5FT is not set
CONFIG=5FCRC32=3Dy
# CONFIG=5FCRC32=5FSELFTEST is not set
CONFIG=5FCRC32=5FSLICEBY8=3Dy
# CONFIG=5FCRC32=5FSLICEBY4 is not set
# CONFIG=5FCRC32=5FSARWATE is not set
# CONFIG=5FCRC32=5FBIT is not set
# CONFIG=5FCRC7 is not set
# CONFIG=5FLIBCRC32C is not set
# CONFIG=5FCRC8 is not set
CONFIG=5FZLIB=5FINFLATE=3Dy
CONFIG=5FZLIB=5FDEFLATE=3Dy
# CONFIG=5FXZ=5FDEC is not set
# CONFIG=5FXZ=5FDEC=5FBCJ is not set
CONFIG=5FDECOMPRESS=5FGZIP=3Dy
CONFIG=5FHAS=5FIOMEM=3Dy
CONFIG=5FHAS=5FIOPORT=3Dy
CONFIG=5FHAS=5FDMA=3Dy
CONFIG=5FCPU=5FRMAP=3Dy
CONFIG=5FDQL=3Dy
CONFIG=5FNLATTR=3Dy
# CONFIG=5FAVERAGE is not set
# CONFIG=5FCORDIC is not set
# CONFIG=5FDDR is not set
