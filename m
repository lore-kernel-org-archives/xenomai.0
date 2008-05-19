Date: Mon, 19 May 2008 08:26:54 +0200
Message-Id: <1168701330@domain.hid>
MIME-Version: 1.0
From: Paradoxxa2001@domain.hid
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help]
 =?iso-8859-15?q?at91sam9263_and_user-space_support?=
 =?iso-8859-15?q?_compile_fails?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

God Morning,

I tried "make uImage" already.
I got the messages like:

uncompressing kernel---
crc error
--System halted

I saw that the scripts uses zImage to make the uImage. And the uImage is b=
uilt
from the arch/arm/boot/compressed/vmlinux. The difference what i saw is th=
at no=20
compression is used to build the uImage by the scripts.


The Kernel with the printascii Function begin to start.=20
Here are the logs:
--------------------------------------------------------------------------=
--------------------
Starting kernel ...

<5>Linux version 2.6.24-paradoxxa-pm9263 (support@domain.hid) (gcc version=
 4.2.3 (Sourcery G++ Lite 2
008q1-126)) #7 Mon May 19 08:01:12 CEST 2008
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
Machine: Ronetix PM9263/BB9263
<4>Ignoring unrecognised tag 0x54410008
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 16384
<7>  DMA zone: 128 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 16256 pages, LIFO batch:3
<7>  Normal zone: 0 pages used for memmap
<7>  Movable zone: 0 pages used for memmap
Clocks: CPU 199 MHz, master 99 MHz, main 18.432 MHz
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256=

<5>Kernel command line: root=3D/dev/mtdblock4 rootfstype=3Djffs2 fbcon=3Drotate:=
3 mtdparts=3Dphysmap-flash.0
:256k(u-boot)ro,64k(u-boot-env)ro,1408k(kernel),-(rootfs);nand:-(nand) ip=3D=
10.0.0.17:10.0.0.20:10.0.0
.20:255.255.255.0:PM9263:eth0:off
<6>AT91: 160 gpio irqs in 5 banks
PID hash table entries: 256 (order: 8, 1024 bytes)
<6>I-pipe 1.9-01: pipeline enabled.
Console: colour dummy device 80x30
<6>console [tty0] enabled
<6>console [ttyS0] enabled
Linux version 2.6.24-paradoxxa-pm9263 (support@domain.hid) (gcc version 4.=
2.3 (Sourcery G++ Lite 2008
q1-126)) #7 Mon May 19 08:01:12 CEST 2008
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
Machine: Ronetix PM9263/BB9263
Ignoring unrecognised tag 0x54410008
Memory policy: ECC disabled, Data cache writeback
Clocks: CPU 199 MHz, master 99 MHz, main 18.432 MHz
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256=

Kernel command line: root=3D/dev/mtdblock4 rootfstype=3Djffs2 fbcon=3Drotate:3 m=
tdparts=3Dphysmap-flash.0:25
6k(u-boot)ro,64k(u-boot-env)ro,1408k(kernel),-(rootfs);nand:-(nand) ip=3D10.=
0.0.17:10.0.0.20:10.0.0.20
:255.255.255.0:PM9263:eth0:off
AT91: 160 gpio irqs in 5 banks
PID hash table entries: 256 (order: 8, 1024 bytes)
I-pipe 1.9-01: pipeline enabled.
Console: colour dummy device 80x30
console [tty0] enabled
console [ttyS0] enabled
<6>Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
<6>Memory:Memory: 64MB 64MB =3D 64MB total
 =3D 64MB total
<5>Memory: 61184KB available (3220K code, 388K data, 108K init)
Memory: 61184KB available (3220K code, 388K data, 108K init)
<7>Calibrating delay loop... 99.12 BogoMIPS (lpj=3D495616)
Mount-cache hash table entries: 512
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: CPU: Testing write buffer coherenc=
y: ok
ok
<6>net=5Fnamespace: 64 bytes
net=5Fnamespace: 64 bytes
<6>NET: Registered protocol family 16
NET: Registered protocol family 16
<6>usbcore: registered new interface driver usbfs
usbcore: registered new interface driver usbfs
<6>usbcore: registered new interface driver hub
usbcore: registered new interface driver hub
<6>usbcore: registered new device driver usb
usbcore: registered new device driver usb
<6>NET: Registered protocol family 2
NET: Registered protocol family 2
<6>Time: at91=5Ftc0 clocksource has been installed.
Time: at91=5Ftc0 clocksource has been installed.
<6>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
<6>TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
<6>TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
<6>TCP: Hash tables configured (established 2048 bind 2048)
TCP: Hash tables configured (established 2048 bind 2048)
<6>TCP reno registered
TCP reno registered
<4>NetWinder Floating Point Emulator V0.97 (double precision)
NetWinder Floating Point Emulator V0.97 (double precision)
<6>I-pipe: Domain Xenomai registered.
I-pipe: Domain Xenomai registered.
<6>Xenomai: hal/arm started.
Xenomai: hal/arm started.
<6>Xenomai: real-time nucleus v2.4.3 (Back to Shalla-Bal) loaded.
Xenomai: real-time nucleus v2.4.3 (Back to Shalla-Bal) loaded.
<6>Xenomai: starting native API services.
Xenomai: starting native API services.
<6>Xenomai: starting POSIX services.
Xenomai: starting POSIX services.
<6>Xenomai: starting RTDM services.
Xenomai: starting RTDM services.
<6>JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
<6>io scheduler noop registered
io scheduler noop registered
<6>io scheduler anticipatory registered (default)
io scheduler anticipatory registered (default)
<6>atmel=5Flcdfb atmel=5Flcdfb.0: 4096KiB frame buffer at 70000000 (mapped at =
c5000000)
atmel=5Flcdfb atmel=5Flcdfb.0: 4096KiB frame buffer at 70000000 (mapped at c50=
00000)
Console: switching to colour frame buffer device 40x30
Console: switching to colour frame buffer device 40x30
<6>atmel=5Flcdfb atmel=5Flcdfb.0: fb0: Atmel LCDC at 0x00700000 (mapped at c48=
50000), irq 26
atmel=5Flcdfb atmel=5Flcdfb.0: fb0: Atmel LCDC at 0x00700000 (mapped at c48500=
00), irq 26
<6>atmel=5Fusart.0: ttyS0 at MMIO 0xfeffee00 (irq =3D 1) is a ATMEL=5FSERIAL
atmel=5Fusart.0: ttyS0 at MMIO 0xfeffee00 (irq =3D 1) is a ATMEL=5FSERIAL
<6>atmel=5Fusart.1: ttyS1 at MMIO 0xfff8c000 (irq =3D 7) is a ATMEL=5FSERIAL
atmel=5Fusart.1: ttyS1 at MMIO 0xfff8c000 (irq =3D 7) is a ATMEL=5FSERIAL
<6>MACB=5Fmii=5Fbus: probed
MACB=5Fmii=5Fbus: probed
<6>eth0: Atmel MACB at 0xfffbc000 irq 21 (02:00:11:53:d0:85)
eth0: Atmel MACB at 0xfffbc000 irq 21 (02:00:11:53:d0:85)
<6>eth0: attached PHY driver [Generic PHY] (mii=5Fbus:phy=5Faddr=3Dffffffff:01, =
irq=3D-1)
eth0: attached PHY driver [Generic PHY] (mii=5Fbus:phy=5Faddr=3Dffffffff:01, irq=
=3D-1)
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 50MHz system bus speed for PIO modes; override with idebu=
s=3Dxx
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=3Dx=
x
<5>physmap platform flash device: 04000000 at 10000000
physmap platform flash device: 04000000 at 10000000
<6>physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
<7>physmap-flash.0: Found an alias at 0x400000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x800000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0xc00000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x1000000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x1400000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x1800000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x1c00000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x2000000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x2400000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x2800000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x2c00000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x3000000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x3400000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x3800000 for the chip at 0x0
<7>physmap-flash.0: Found an alias at 0x3c00000 for the chip at 0x0
 Amd/Fujitsu Extended Query Table at 0x0040
 Amd/Fujitsu Extended Query Table at 0x0040
<5>number of CFI chips: 1
number of CFI chips: 1
<5>cfi=5Fcmdset=5F0002: Disabling erase-suspend-program due to code brokenness=
.
cfi=5Fcmdset=5F0002: Disabling erase-suspend-program due to code brokenness.
<5>4 cmdlinepart partitions found on MTD device physmap-flash.0
4 cmdlinepart partitions found on MTD device physmap-flash.0
<5>Creating 4 MTD partitions on "physmap-flash.0":
Creating 4 MTD partitions on "physmap-flash.0":
<5>0x00000000-0x00040000 : "u-boot"
0x00000000-0x00040000 : "u-boot"
<5>0x00040000-0x00050000 : "u-boot-env"
0x00040000-0x00050000 : "u-boot-env"
<5>0x00050000-0x001b0000 : "kernel"
0x00050000-0x001b0000 : "kernel"
<5>0x001b0000-0x00400000 : "rootfs"
0x001b0000-0x00400000 : "rootfs"
<6>NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron NAND 256MiB 3=
,3V 8-bit)
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron NAND 256MiB 3,3V=
 8-bit)
<6>AT91 NAND: 8-bit, Software ECC
AT91 NAND: 8-bit, Software ECC
<6>Scanning device for bad blocks
Scanning device for bad blocks
<5>Creating 1 MTD partitions on "at91=5Fnand":
Creating 1 MTD partitions on "at91=5Fnand":
<5>0x00000000-0x10000000 : "nand"
0x00000000-0x10000000 : "nand"
<6>atmel=5Fspi atmel=5Fspi.0: Atmel SPI Controller at 0xfffa4000 (irq 14)
atmel=5Fspi atmel=5Fspi.0: Atmel SPI Controller at 0xfffa4000 (irq 14)
<6>mtd=5Fdataflash spi0.0: AT45DB321x (4224 KBytes)
mtd=5Fdataflash spi0.0: AT45DB321x (4224 KBytes)
<6>atmel=5Fspi atmel=5Fspi.1: Atmel SPI Controller at 0xfffa8000 (irq 15)
atmel=5Fspi atmel=5Fspi.1: Atmel SPI Controller at 0xfffa8000 (irq 15)
<6>at91=5Fcf: irqs det #62, io #56
at91=5Fcf: irqs det #62, io #56
<7>ohci=5Fhcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
<6>at91=5Fohci at91=5Fohci: AT91 OHCI
at91=5Fohci at91=5Fohci: AT91 OHCI
<6>at91=5Fohci at91=5Fohci: new USB bus registered, assigned bus number 1
at91=5Fohci at91=5Fohci: new USB bus registered, assigned bus number 1
<6>at91=5Fohci at91=5Fohci: irq 29, io mem 0x00a00000
at91=5Fohci at91=5Fohci: irq 29, io mem 0x00a00000
<6>usb usb1: configuration #1 chosen from 1 choice
usb usb1: configuration #1 chosen from 1 choice
<6>hub 1-0:1.0: USB hub found
hub 1-0:1.0: USB hub found
<6>hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: 2 ports detected
<6>mice: PS/2 mouse device common for all mice
mice: PS/2 mouse device common for all mice
<6>ads7846 spi1.0: touchscreen, irq 31
ads7846 spi1.0: touchscreen, irq 31
<6>input: ADS784x Touchscreen as /class/input/input0
input: ADS784x Touchscreen as /class/input/input0
<6>rtc-at91sam9 at91=5Frtt.0: rtc core: registered at91=5Frtt as rtc0
rtc-at91sam9 at91=5Frtt.0: rtc core: registered at91=5Frtt as rtc0
<6>Driver for 1-wire Dallas network protocol.
Driver for 1-wire Dallas network protocol.
<6>pm926x=5Fw1, gpio pin 95
pm926x=5Fw1, gpio pin 95
<6>Registered led device: led0
Registered led device: led0
<6>Registered led device: led1
Registered led device: led1
<6>usbcore: registered new interface driver usbhid
usbcore: registered new interface driver usbhid
<6>drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
<6>Advanced Linux Sound Architecture Driver Version 1.0.15 (Tue Nov 20 19:=
16:42 2007 UTC).
Advanced Linux Sound Architecture Driver Version 1.0.15 (Tue Nov 20 19:16:=
42 2007 UTC).
<6>ALSA sound/arm/at91-ac97.c:564: ALSA sound/arm/at91-ac97.c:564: AC97C r=
egs =3D FFFA0000
AC97C regs =3D FFFA0000
<6>ALSA sound/arm/at91-ac97.c:565: ALSA sound/arm/at91-ac97.c:565: AC97C i=
rq  =3D 18
AC97C irq  =3D 18
<4>ALSA sound/arm/at91-ac97.c:493: ALSA sound/arm/at91-ac97.c:493: at91-ac=
97: codec read timeout 1
at91-ac97: codec read timeout 1
<4>ALSA sound/arm/at91-ac97.c:493: <4>ALSA sound/arm/at91-ac97.c:493: at91=
-ac97: codec read timeout
1
at91-ac97: codec read timeout 1
<4>ALSA sound/arm/at91-ac97.c:493: <4>ALSA sound/arm/at91-ac97.c:493: at91=
-ac97: codec read timeout
1
at91-ac97: codec read timeout 1
<4>ALSA sound/arm/at91-ac97.c:493: <4>ALSA sound/arm/at91-ac97.c:493: at91=
-ac97: codec read timeout
1
at91-ac97: codec read timeout 1
<6>ASoC version 0.13.1
<6>ASoC version 0.13.1
<6>ALSA device list:
ALSA device list:
<6>  #0: Atmel AC97 Controller at 0xfffa0000, irq 18
  #0: Atmel AC97 Controller at 0xfffa0000, irq 18
<6>TCP cubic registered
TCP cubic registered
<6>NET: Registered protocol family 1
NET: Registered protocol family 1
<6>NET: Registered protocol family 17
NET: Registered protocol family 17
<6>RPC: Registered udp transport module.
RPC: Registered udp transport module.
<6>RPC: Registered tcp transport module.
RPC: Registered tcp transport module.
<6>rtc-at91sam9 at91=5Frtt.0: setting system clock to 2008-05-19 08:15:34 UT=
C (1211184934)
rtc-at91sam9 at91=5Frtt.0: setting system clock to 2008-05-19 08:15:34 UTC (=
1211184934)
IP-Config: Complete:IP-Config: Complete:
      device=3Deth0
      device=3Deth0, addr=3D10.0.0.17, addr=3D10.0.0.17, mask=3D255.255.255.0, mas=
k=3D255.255.255.0, gw=3D10.0.0
.20, gw=3D10.0.0.20,
     host=3DPM9263, domain=3D, nis-domain=3D(none),
     host=3DPM9263, domain=3D, nis-domain=3D(none),
     bootserver=3D10.0.0.20,
     bootserver=3D10.0.0.20, rootserver=3D10.0.0.20, rootserver=3D10.0.0.20, roo=
tpath=3D, rootpath=3D

<1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00001
Unable to handle kernel NULL pointer dereference at virtual address 000000=
01
<1>pgd =3D c0004000
pgd =3D c0004000
<1>[00000001] *pgd=3D00000000[00000001] *pgd=3D00000000

Internal error: Oops: 5 [#1]
Internal error: Oops: 5 [#1]
Modules linked in:Modules linked in:

CPU: 0    Not tainted  (2.6.24-paradoxxa-pm9263 #7)
CPU: 0    Not tainted  (2.6.24-paradoxxa-pm9263 #7)
PC is at name=5Fto=5Fdev=5Ft+0x160/0x28c
PC is at name=5Fto=5Fdev=5Ft+0x160/0x28c
LR is at name=5Fto=5Fdev=5Ft+0x13c/0x28c
LR is at name=5Fto=5Fdev=5Ft+0x13c/0x28c
pc : [<c0023810>]    lr : [<c00237ec>]    psr: 20000013
sp : c3c17f2c  ip : c3c17f2c  fp : c3c17f78
pc : [<c0023810>]    lr : [<c00237ec>]    psr: 20000013
sp : c3c17f2c  ip : c3c17f2c  fp : c3c17f78
r10: 00000000  r9 : 00000000  r8 : c3c16000
r10: 00000000  r9 : 00000000  r8 : c3c16000
r7 : 00000000  r6 : 00000000  r5 : c001d871  r4 : c3c17f30
r7 : 00000000  r6 : 00000000  r5 : c001d871  r4 : c3c17f30
r3 : 00000001  r2 : 00000001  r1 : 0000006d  r0 : 00001730
r3 : 00000001  r2 : 00000001  r1 : 0000006d  r0 : 00001730
Flags: nzCv  IRQs on  FIQs on  Mode SVC=5F32  ISA ARM  Segment kernel
Flags: nzCv  IRQs on  FIQs on  Mode SVC=5F32  ISA ARM  Segment kernel
Control: 0005317f  Table: 20004000  DAC: 00000017
Control: 0005317f  Table: 20004000  DAC: 00000017
Process swapper (pid: 1, stack limit =3D 0xc3c16258)
Process swapper (pid: 1, stack limit =3D 0xc3c16258)
Stack: (0xc3c17f2c to 0xc3c18000)
Stack: (0xc3c17f2c to 0xc3c18000)
7f20: 7f20:                                                       00000000=
 00000000 6264746d 6264746
d 6b636f6c 6b636f6c c3c10034 c3c10034 c3c17f48 c3c17f48

7f40: 7f40: c004b3fc c004b3fc c006185c c006185c 00000003 00000003 00000000=
 00000000 00000000 0000000
0 00000000 00000000 00000001 00000001 c001d86c c001d86c

7f60: 7f60: c001d85c c001d85c 00000000 00000000 c001c070 c001c070 c3c17f94=
 c3c17f94 c3c17f7c c3c17f7
c c0009328 c0009328 c00236c0 c00236c0 c3c17f88 c3c17f88

7f80: 7f80: c036a4e0 c036a4e0 00000000 00000000 c3c17ff4 c3c17ff4 c3c17f98=
 c3c17f98 c0008a98 c0008a9
8 c00092a4 c00092a4 00000000 00000000 00000000 00000000

7fa0: 7fa0: 00000000 00000000 c3c17fb0 c3c17fb0 c0024060 c0024060 c0037720=
 c0037720 00000000 0000000
0 00000000 00000000 c0008868 c0008868 c003ddbc c003ddbc

7fc0: 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000=
 00000000 00000000 0000000
0 00000000 00000000 00000000 00000000 00000000 00000000

7fe0: 7fe0: 00000000 00000000 00000000 00000000 00000000 00000000 c3c17ff8=
 c3c17ff8 c003ddbc c003ddb
c c0008878 c0008878 0f73fc8c 0f73fc8c 1f13ac4e 1f13ac4e

Backtrace: Backtrace:

[<c00236b0>] [<c00236b0>] (name=5Fto=5Fdev=5Ft+0x0/0x28c) (name=5Fto=5Fdev=5Ft+0x0/0x2=
8c) from [<c0009328>] from
 [<c0009328>] (prepare=5Fnamespace+0x94/0x16c)
(prepare=5Fnamespace+0x94/0x16c)
 r7:c001c070 r7:c001c070 r6:00000000 r6:00000000 r5:c001d85c r5:c001d85c r=
4:c001d86c r4:c001d86c

[<c0009294>] [<c0009294>] (prepare=5Fnamespace+0x0/0x16c) (prepare=5Fnamespace=
+0x0/0x16c) from [<c0008a9
8>] from [<c0008a98>] (kernel=5Finit+0x230/0x290)
(kernel=5Finit+0x230/0x290)
 r5:00000000 r5:00000000 r4:c036a4e0 r4:c036a4e0

[<c0008868>] [<c0008868>] (kernel=5Finit+0x0/0x290) (kernel=5Finit+0x0/0x290) =
from [<c003ddbc>] from [<c
003ddbc>] (do=5Fexit+0x0/0x790)
(do=5Fexit+0x0/0x790)
Code: Code: 20000220 20000220 e2833001 e2833001 e50b3020 e50b3020 e51b2020=
 e51b2020 (e5d21000) (e5d2
1000)

<4>---[ end trace aae4ab6fc1a48acc ]---
---[ end trace aae4ab6fc1a48acc ]---
<0>Kernel panic - not syncing: Attempted to kill init!
Kernel panic - not syncing: Attempted to kill init!
<6>eth0: link up (100/Full)
eth0: link up (100/Full)


--------------------------------------------------------------------------=
--------------------

Thomas


-----Urspr=FCngliche Nachricht-----
Von: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
Gesendet: 16.05.08 17:28:23
An: Paradoxxa2001@domain.hid
CC: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] at91sam9263 and user-space support compile fai=
ls

On Fri, May 16, 2008 at 4:34 PM,  <Paradoxxa2001@domain.hid> wrote:
> OK, i will include the printascii function.
> Thank you for your patience. I appreciate you.

You are welcome. Have you tried "make uImage" =3F

--=20
 Gilles

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help



=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/=3Fmc=3D100071&distributionid=3D000000000066


