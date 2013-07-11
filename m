From: Younes CHALABI <y.chalabi@sinters.fr>
Date: Thu, 11 Jul 2013 11:35:28 +0000
Message-ID: <A46EF8CF1BBB8E4B8A27B73E177C4664033F268F@MAIL-SINTERS-01.sinters-int.fr>
References: <A46EF8CF1BBB8E4B8A27B73E177C466402463ADE@MAIL-SINTERS-01.sinters-int.fr>,
	<51DBF250.9070804@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C466402464B37@MAIL-SINTERS-01.sinters-int.fr>,
	<51DC560F.90805@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033EC616@MAIL-SINTERS-01.sinters-int.fr>,
	<51DDB5C3.7010307@xenomai.org>
In-Reply-To: <51DDB5C3.7010307@xenomai.org>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] RE : RE : RE : No boot kernel with xenomai on i.MX6Q
 Sabrelite
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,

Thanks for your answers.

It seems that I have a kernel panic while the boot and the cpu cores shut d=
own one after the other still the target doesn't respond, and any new displ=
ay is shown.=20

Using :=20

     - Linux : rel_imx_3.0.15_12.03.00 (linux-3.0 Freescle Release)

     - Patches :      1) adeos-ipipe-3.0.36-arm-1.18-11-pre.patch
                          2) adeos-ipipe-3.0.36-arm-1.18-11.patch
                          3) adeos-ipipe-3.0.36-arm-1.18-11-post.patch

     - Xenomai : xenomai-2.6.2.1

     - U-boot : From LTIB u-Boot 2009.08

     - Rootfs : From LTIB

     - Host PC : Ubuntu-12.10

     - Target : Freescale i.MX6Q Sabrelite

     - Kernel : uImage From the : build_directory/linux/arch/arm/boot

Here is the log :

U-Boot 2009.08 (Apr 25 2013 - 01:13:09)

CPU: Freescale i.MX6 family TO1.2 at 792 MHz
Thermal sensor with ratio =3D 186
Temperature:   34 C, calibration data 0x59c5137d
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
   Image Name:   Linux-3.0.36
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3815200 Bytes =3D  3.6 MB
   Load Address: 10008000
   Entry Point:  10008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 3.0.36 (younes@younes-Latitude-E6530) (gcc version 4.7.3 (Sou=
rcery CodeBench Lite 2013.05-24) ) #1 SMP PREEMPT Thu Jul 11 12:31:00 CEST =
2013
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10c53c7d
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Freescale i.MX 6Quad Sabre-Lite Board
Memory policy: ECC disabled, Data cache writealloc
PERCPU: Embedded 9 pages/cpu @8c008000 s14752 r8192 d13920 u36864
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 227328
Kernel command line: console=3Dttymxc1,115200 root=3D/dev/mmcblk0p1 rootwai=
t rw video=3Dmxcfb0:dev=3Dldb,LDB-XGA,if=3DRGB666 video=3Dmxcfb0:dev=3Dhdmi=
,1920x1080M@60,if=3DRGB24
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 640MB 256MB =3D 896MB total
Memory: 896628k/896628k available, 151948k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xf4600000 - 0xffe00000   ( 184 MB)
    vmalloc : 0xc0800000 - 0xf2000000   ( 792 MB)
    lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
    pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
    modules : 0x7f000000 - 0x7fe00000   (  14 MB)
      .init : 0x80008000 - 0x80044000   ( 240 kB)
      .text : 0x80044000 - 0x80ac9f30   (10776 kB)
      .data : 0x80aca000 - 0x80b1d340   ( 333 kB)
       .bss : 0x80b1d364 - 0x80b7074c   ( 333 kB)
SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
Preemptible hierarchical RCU implementation.
NR_IRQS:496
MXC GPIO hardware
sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 1431655ms
MXC_Early serial console at MMIO 0x21e8000 (options '115200')
bootconsole [ttymxc1] enabled
I-pipe 1.18-11: pipeline enabled.
Console: colour dummy device 80x30
Calibrating delay loop... 1980.82 BogoMIPS (lpj=3D9904128)
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
SMP: Total of 4 processors activated (7923.30 BogoMIPS).
print_constraints: dummy:=20
NET: Registered protocol family 16
cpaddr =3D c0840000 wait_iram_base=3Dc0816000
print_constraints: vddpu: 725 <--> 1300 mV at 700 mV fast normal=20
print_constraints: vddcore: 725 <--> 1300 mV at 1225 mV fast normal=20
print_constraints: vddsoc: 725 <--> 1300 mV at 1200 mV fast normal=20
print_constraints: vdd2p5: 2000 <--> 2775 mV at 2400 mV fast normal=20
print_constraints: vdd1p1: 800 <--> 1400 mV at 1100 mV fast normal=20
print_constraints: vdd3p0: 2800 <--> 3150 mV at 3000 mV fast normal=20
hw-breakpoint: found 6 breakpoint and 1 watchpoint registers.
hw-breakpoint: 1 breakpoint(s) reserved for watchpoint single-step.
hw-breakpoint: maximum watchpoint size is 4 bytes.
L310 cache controller enabled
l2x0: 16 ways, CACHE_ID 0x410000c7, AUX_CTRL 0x02070000, Cache size: 104857=
6 B
IMX usb wakeup probe
IMX usb wakeup probe
bio: create slab <bio-0> at 0
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
add wake up source irq 75
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
Switching to clocksource ipipe_tsc  ---------------------------------------=
---------------------------------------------------------------------------=
-----------------------> Before stops here !
Switched to NOHz mode on CPU #0
Switched to NOHz mode on CPU #2
Switched to NOHz mode on CPU #1
Switched to NOHz mode on CPU #3
Unable to handle kernel paging request at virtual address ffffffff
pgd =3D 80004000
[ffffffff] *pgd=3D4fffe821, *pte=3D00000000, *ppte=3D00000000
Internal error: Oops: 17 [#1] PREEMPT SMP
Modules linked in:
CPU: 0    Not tainted  (3.0.36 #1)
PC is at kmem_cache_alloc+0xb8/0x120
LR is at __ipipe_test_and_stall_root+0x34/0x3c
pc : [<80176050>]    lr : [<80052f68>]    psr: 60000013
sp : bff8bef0  ip : 00000000  fp : 00000000
r10: 000000d0  r9 : 802f8358  r8 : 000024d8
r7 : 80adfae0  r6 : bfff9300  r5 : 80adfae0  r4 : ffffffff
r3 : 80045a00  r2 : 0bfc8000  r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 1000404a  DAC: 00000015
Process swapper (pid: 1, stack limit =3D 0xbff8a2f0)
Stack: (0xbff8bef0 to 0xbff8c000)
bee0:                                     80b527c8 000025c6 bfe3aa80 000000=
04
bf00: bfd213dc 00000004 00000002 80afbda0 00000000 802f8358 80afbff8 000000=
01
bf20: 80afbda4 bfe3aa80 00000004 802f8c20 00000014 80afbff8 80b5ff6c bfff00=
00
bf40: 00000000 00000001 00000000 80b60190 00000000 80b1d380 8001fd28 000000=
00
bf60: 00000000 8001f1d8 00000000 00000001 00000002 8001f714 80a38670 801c8d=
14
bf80: bfd23810 80b5fb7c 00000000 bff8a000 00000013 8001ebe8 80a07cb0 000000=
13
bfa0: 80035608 80035608 800359d0 800447bc 00000000 00000864 bff59500 800359=
d0
bfc0: 8004b074 00000013 80035608 800359d0 8004b074 00000000 00000000 000000=
00
bfe0: 00000000 8000898c 00000000 00000000 800088cc 8004b074 ffffffff ffffff=
ff
[<80176050>] (kmem_cache_alloc+0xb8/0x120) from [<802f8358>] (con_insert_un=
ipair+0xb8/0x104)
[<802f8358>] (con_insert_unipair+0xb8/0x104) from [<802f8c20>] (con_set_def=
ault_unimap+0xec/0x170)
[<802f8c20>] (con_set_default_unimap+0xec/0x170) from [<8001f1d8>] (console=
_map_init+0x40/0x50)
[<8001f1d8>] (console_map_init+0x40/0x50) from [<8001f714>] (vty_init+0x198=
/0x1a8)
[<8001f714>] (vty_init+0x198/0x1a8) from [<8001ebe8>] (tty_init+0x12c/0x144=
)
[<8001ebe8>] (tty_init+0x12c/0x144) from [<800447bc>] (do_one_initcall+0x11=
8/0x170)
[<800447bc>] (do_one_initcall+0x118/0x170) from [<8000898c>] (kernel_init+0=
xc0/0x148)
[<8000898c>] (kernel_init+0xc0/0x148) from [<8004b074>] (kernel_thread_exit=
+0x0/0x8)
Code: ee102fb0 e5961014 e202200f e7972102 (e7941001)=20
---[ end trace da227214a82491b7 ]---
Kernel panic - not syncing: Attempted to kill init!
[<80050164>] (unwind_backtrace+0x0/0xf8) from [<8053e1dc>] (panic+0x80/0x19=
8)
[<8053e1dc>] (panic+0x80/0x198) from [<80078990>] (do_exit+0x6a0/0x74c)
[<80078990>] (do_exit+0x6a0/0x74c) from [<8004de18>] (die+0x258/0x2c0)
[<8004de18>] (die+0x258/0x2c0) from [<8053dd84>] (__do_kernel_fault.part.4+=
0x64/0x74)
[<8053dd84>] (__do_kernel_fault.part.4+0x64/0x74) from [<80054d54>] (do_pag=
e_fault+0x228/0x3f0)
[<80054d54>] (do_page_fault+0x228/0x3f0) from [<80044498>] (do_DataAbort+0x=
38/0x17c)
[<80044498>] (do_DataAbort+0x38/0x17c) from [<80049f10>] (__dabt_svc+0x70/0=
xa0)
Exception stack(0xbff8bea8 to 0xbff8bef0)
bea0:                   00000000 00000000 0bfc8000 80045a00 ffffffff 80adfa=
e0
bec0: bfff9300 80adfae0 000024d8 802f8358 000000d0 00000000 00000000 bff8be=
f0
bee0: 80052f68 80176050 60000013 ffffffff
[<80049f10>] (__dabt_svc+0x70/0xa0) from [<80176050>] (kmem_cache_alloc+0xb=
8/0x120)
[<80176050>] (kmem_cache_alloc+0xb8/0x120) from [<802f8358>] (con_insert_un=
ipair+0xb8/0x104)
[<802f8358>] (con_insert_unipair+0xb8/0x104) from [<802f8c20>] (con_set_def=
ault_unimap+0xec/0x170)
[<802f8c20>] (con_set_default_unimap+0xec/0x170) from [<8001f1d8>] (console=
_map_init+0x40/0x50)
[<8001f1d8>] (console_map_init+0x40/0x50) from [<8001f714>] (vty_init+0x198=
/0x1a8)
[<8001f714>] (vty_init+0x198/0x1a8) from [<8001ebe8>] (tty_init+0x12c/0x144=
)
[<8001ebe8>] (tty_init+0x12c/0x144) from [<800447bc>] (do_one_initcall+0x11=
8/0x170)
[<800447bc>] (do_one_initcall+0x118/0x170) from [<8000898c>] (kernel_init+0=
xc0/0x148)
[<8000898c>] (kernel_init+0xc0/0x148) from [<8004b074>] (kernel_thread_exit=
+0x0/0x8)
CPU1: stopping
[<80050164>] (unwind_backtrace+0x0/0xf8) from [<80044450>] (do_IPI+0x124/0x=
134)
[<80044450>] (do_IPI+0x124/0x134) from [<800b21b8>] (__ipipe_sync_stage+0x2=
50/0x260)
Exception stack(0xbffadf50 to 0xbffadf98)
df40:                                     80adfae0 80040838 80042c98 80b299=
00
df60: ffffffff bffadf90 f2a00100 00000006 bffac000 80ae2cac bffac000 000000=
00
df80: 00000000 800442c4 ffffffff 80049f80 00000000 8c011838
[<800b21b8>] (__ipipe_sync_stage+0x250/0x260) from [<800442c4>] (__ipipe_gr=
ab_ipi+0x30/0x98)
[<800442c4>] (__ipipe_grab_ipi+0x30/0x98) from [<80049f80>] (__irq_svc+0x40=
/0xd4)
Exception stack(0xbffadf90 to 0xbffadfd8)
df80:                                     00000000 8c011838 00000000 000000=
00
dfa0: 8c011838 80b1d424 80547218 bffac000 80ae2cac 412fc09a 00000000 000000=
00
dfc0: 00000000 bffadfd8 8004b110 80057e4c 60000013 ffffffff
[<80049f80>] (__irq_svc+0x40/0xd4) from [<80057e4c>] (cpu_v7_do_idle+0x8/0x=
c)
[<80057e4c>] (cpu_v7_do_idle+0x8/0xc) from [<1053acf4>] (0x1053acf4)
CPU3: stopping
[<80050164>] (unwind_backtrace+0x0/0xf8) from [<80044450>] (do_IPI+0x124/0x=
134)
[<80044450>] (do_IPI+0x124/0x134) from [<800b21b8>] (__ipipe_sync_stage+0x2=
50/0x260)
Exception stack(0xbff01f50 to 0xbff01f98)
1f40:                                     80adfae0 80040838 80042c98 80b299=
00
1f60: ffffffff bff01f90 f2a00100 00000006 bff00000 80ae2cac bff00000 000000=
00
1f80: 00000000 800442c4 ffffffff 80049f80 00000000 8c023838
[<800b21b8>] (__ipipe_sync_stage+0x250/0x260) from [<800442c4>] (__ipipe_gr=
ab_ipi+0x30/0x98)
[<800442c4>] (__ipipe_grab_ipi+0x30/0x98) from [<80049f80>] (__irq_svc+0x40=
/0xd4)
Exception stack(0xbff01f90 to 0xbff01fd8)
1f80:                                     00000000 8c023838 00000000 000000=
00
1fa0: 8c023838 80b1d424 80547218 bff00000 80ae2cac 412fc09a 00000000 000000=
00
1fc0: 00000000 bff01fd8 8004b110 80057e4c 60000053 ffffffff
[<80049f80>] (__irq_svc+0x40/0xd4) from [<80057e4c>] (cpu_v7_do_idle+0x8/0x=
c)
[<80057e4c>] (cpu_v7_do_idle+0x8/0xc) from [<1053acf4>] (0x1053acf4)
CPU2: stopping
[<80050164>] (unwind_backtrace+0x0/0xf8) from [<80044450>] (do_IPI+0x124/0x=
134)
[<80044450>] (do_IPI+0x124/0x134) from [<800b21b8>] (__ipipe_sync_stage+0x2=
50/0x260)
Exception stack(0xbffb5f50 to 0xbffb5f98)
5f40:                                     80adfae0 80040838 80042c98 80b299=
00
5f60: ffffffff bffb5f90 f2a00100 00000006 bffb4000 80ae2cac bffb4000 000000=
00
5f80: 00000000 800442c4 ffffffff 80049f80 00000000 8c01a838
[<800b21b8>] (__ipipe_sync_stage+0x250/0x260) from [<800442c4>] (__ipipe_gr=
ab_ipi+0x30/0x98)
[<800442c4>] (__ipipe_grab_ipi+0x30/0x98) from [<80049f80>] (__irq_svc+0x40=
/0xd4)
Exception stack(0xbffb5f90 to 0xbffb5fd8)
5f80:                                     00000000 8c01a838 00000000 000000=
00
5fa0: 8c01a838 80b1d424 80547218 bffb4000 80ae2cac 412fc09a 00000000 000000=
00
5fc0: 00000000 bffb5fd8 8004b110 80057e4c 60000013 ffffffff
[<80049f80>] (__irq_svc+0x40/0xd4) from [<80057e4c>] (cpu_v7_do_idle+0x8/0x=
c)
[<80057e4c>] (cpu_v7_do_idle+0x8/0xc) from [<1053acf4>] (0x1053acf4)

At this point, any new entry is displayed.

Regards.

Younes CHALABI


