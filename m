From: "Charlton, John" <john.charlton@domain.hid>
Date: Wed, 12 Aug 2009 15:08:45 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE20060EFA4F19@domain.hid>
References: <CF7FB0793253794F9F45991443E5FE20060EFA4BEC@us194mx002.tycoelectronics.net>
	<4A81CA67.9060301@domain.hid> <4A81CE4F.9060301@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4DEE@us194mx002.tycoelectronics.net>
	<4A82DC78.9060408@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4EE1@domain.hid>
	<4A83108E.10309@domain.hid>
In-Reply-To: <4A83108E.10309@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=20

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Wednesday, August 12, 2009 2:57 PM
To: Charlton, John
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented

Ok. Could you show us the boot logs?


--=20
					    Gilles.

I just noticed that the kernel is ignoring the xeno_nucleus.xenomai_guid=3D=
1000 command line option.

This is the boot log from dmesg:

Linux version 2.6.27.7 (oe@domain.hid) (gcc version 4.2.4) #1 Thu Aug 6 15:56:49 E=
DT 2009
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dff0000 (usable)
 BIOS-e820: 000000000dff0000 - 000000000dff8000 (ACPI data)
 BIOS-e820: 000000000dff8000 - 000000000e000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
DMI not present or invalid.
last_pfn =3D 0xdff0 max_arch_pfn =3D 0x100000
kernel direct mapping tables up to dff0000 @ 7000-d000
0MB HIGHMEM available.
223MB LOWMEM available.
  mapped low ram: 0 - 0dff0000
  low ram: 00000000 - 0dff0000
  bootmap 00001000 - 00002c00
(6 early reservations) =3D=3D> bootmem [0000000000 - 000dff0000]
  #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [0000000000 - 00000=
01000]
  #1 [0000100000 - 0000607910]    TEXT DATA BSS =3D=3D> [0000100000 - 00006=
07910]
  #2 [0000608000 - 000060b000]    INIT_PG_TABLE =3D=3D> [0000608000 - 00006=
0b000]
  #3 [000009fc00 - 0000100000]    BIOS reserved =3D=3D> [000009fc00 - 00001=
00000]
  #4 [0000007000 - 0000009000]          PGTABLE =3D=3D> [0000007000 - 00000=
09000]
  #5 [0000001000 - 0000003000]          BOOTMAP =3D=3D> [0000001000 - 00000=
03000]
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  Normal   0x00001000 -> 0x0000dff0
  HighMem  0x0000dff0 -> 0x0000dff0
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000000 -> 0x0000009f
    0: 0x00000100 -> 0x0000dff0
On node 0 totalpages: 57231
free_area_init_node: node 0, pgdat c0577cc0, node_mem_map c1000000
  DMA zone: 3967 pages, LIFO batch:0
  Normal zone: 52816 pages, LIFO batch:15
Allocating PCI resources starting at 10000000 (gap: e000000:f1f80000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 56783
Kernel command line: root=3D/dev/hdc1 ro xeno_nucleus.xenomai_guid=3D1000 l=
ang=3Dus toram noeject frugal
Unknown boot option `xeno_nucleus.xenomai_guid=3D1000': ignoring
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
TSC: Using PIT calibration value
Detected 400.905 MHz processor.
I-pipe 2.1-02: pipeline enabled.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 221632k/229312k available (3399k kernel code, 7172k reserved, 1205k=
 data, 224k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffed000 - 0xfffff000   (  72 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xce800000 - 0xff7fe000   ( 783 MB)
    lowmem  : 0xc0000000 - 0xcdff0000   ( 223 MB)
      .init : 0xc0582000 - 0xc05ba000   ( 224 kB)
      .data : 0xc0451da0 - 0xc057f238   (1205 kB)
      .text : 0xc0100000 - 0xc0451da0   (3399 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
Calibrating delay loop (skipped), value calculated using timer frequency.. =
801.81 BogoMIPS (lpj=3D1603620)
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Celeron(TM) CPU                 400MHz stepping 04
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 0k freed
net_namespace: 588 bytes
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb51, last bus=3D1
PCI: Using configuration type 1 for base access
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: 0000:00:00.0 reg 10 32bit mmio: [e0000000, e3ffffff]
pci 0000:00:01.0: supports D1
PCI: 0000:00:07.1 reg 20 io port: [fc00, fc0f]
PCI: 0000:00:07.2 reg 20 io port: [e800, e81f]
PCI: 0000:00:07.3 reg 20 io port: [ec00, ec1f]
pci 0000:00:07.4: quirk: region 0c00-0c7f claimed by vt82c686 HW-mon
pci 0000:00:07.4: quirk: region 0400-040f claimed by vt82c686 SMB
PCI: 0000:00:0f.0 reg 10 io port: [e400, e4ff]
PCI: 0000:00:0f.0 reg 14 32bit mmio: [dfffff00, dfffffff]
pci 0000:00:0f.0: supports D1
pci 0000:00:0f.0: supports D2
pci 0000:00:0f.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:00:0f.0: PME# disabled
PCI: 0000:01:00.0 reg 10 32bit mmio: [dfe80000, dfefffff]
PCI: 0000:01:00.0 reg 14 32bit mmio: [d0000000, d7ffffff]
PCI: 0000:01:00.0 reg 30 32bit mmio: [dfe70000, dfe7ffff]
pci 0000:01:00.0: supports D1
pci 0000:01:00.0: supports D2
PCI: bridge 0000:00:01.0 32bit mmio: [dfd00000, dfefffff]
PCI: bridge 0000:00:01.0 32bit mmio pref: [cfc00000, dfbfffff]
pci 0000:00:07.0: VIA IRQ router [1106/0686]
pnp: the driver 'system' has been registered
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: disabled
pci 0000:00:01.0:   MEM window: 0xdfd00000-0xdfefffff
pci 0000:00:01.0:   PREFETCH window: 0x000000cfc00000-0x000000dfbfffff
pci 0000:00:01.0: setting latency timer to 64
bus: 00 index 0 io port: [0, ffff]
bus: 00 index 1 mmio: [0, ffffffff]
bus: 01 index 0 mmio: [0, 0]
bus: 01 index 1 mmio: [dfd00000, dfefffff]
bus: 01 index 2 mmio: [cfc00000, dfbfffff]
bus: 01 index 3 mmio: [0, 0]
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
platform rtc_cmos: registered platform RTC device (no PNP device found)
audit: initializing netlink socket (disabled)
type=3D2000 audit(1250085919.048:1): initialized
I-pipe: Domain Xenomai registered.
Xenomai: hal/i386 started.
Xenomai: real-time nucleus v2.4.6 (Bamboo) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
Xenomai: starting RTAI emulator.
Installing knfsd (copyright (C) 1996 okir@domain.hid).
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
JFS: nTxBlock =3D 1732, nTxLock =3D 13859
msgmni has been set to 433
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: VIA PCI bridge detected.Disabling DAC.
pci 0000:01:00.0: Boot video device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.103
[drm] Initialized drm 1.1.0 20060810
Serial: 8250/16550 driver4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
serial8250: ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A
serial8250: ttyS3 at I/O 0x2e8 (irq =3D 3) is a 16550A
pnp: the driver 'serial' has been registered
floppy0: no floppy controllers found
brd: module loaded
8139too Fast Ethernet driver 0.9.28
PCI: setting IRQ 12 as level-triggered
8139too 0000:00:0f.0: found PCI INT A -> IRQ 12
eth0: RealTek RTL8139 at 0xe400, 00:08:9b:ab:be:5d, IRQ 12
eth0:  Identified 8139 chip type 'RTL-8101'
Uniform Multi-Platform E-IDE driver
via82cxxx 0000:00:07.1: VIA vt82c686b (rev 40) IDE UDMA100
via82cxxx 0000:00:07.1: IDE controller (0x1106:0x0571 rev 0x06)
via82cxxx 0000:00:07.1: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07
    ide1: BM-DMA at 0xfc08-0xfc0f
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: CF CARD 2GB, ATA DISK drive
hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO2
hdc: MWDMA2 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide_generic: please use "probe_mask=3D0x3f" module parameter for probing al=
l legacy ISA IDE ports
ide_generic: I/O resource 0x1F0-0x1F7 not free.
ide_generic: I/O resource 0x170-0x177 not free.
hdc: max request size: 128KiB
hdc: 3940272 sectors (2017 MB) w/1KiB Cache, CHS=3D3909/16/63
 hdc: hdc1
Driver 'sd' needs updating - please use bus_type methods
ieee1394: raw1394: /dev/raw1394 device initialized
SSFDC read-only Flash Translation layer
No valid DiskOnChip devices found
usbmon: debugfs is not available
116x: driver isp116x-hcd, 03 Nov 2005
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
PCI: setting IRQ 10 as level-triggered
uhci_hcd 0000:00:07.2: found PCI INT D -> IRQ 10
uhci_hcd 0000:00:07.2: sharing IRQ 10 with 0000:00:07.3
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 10, io base 0x0000e800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:07.3: found PCI INT D -> IRQ 10
uhci_hcd 0000:00:07.3: sharing IRQ 10 with 0000:00:07.2
uhci_hcd 0000:00:07.3: UHCI Host Controller
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.3: irq 10, io base 0x0000ec00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
sl811: driver sl811-hcd, 19 May 2005
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
pnp: the driver 'i8042 kbd' has been registered
pnp: the driver 'i8042 aux' has been registered
pnp: the driver 'i8042 kbd' has been unregistered
pnp: the driver 'i8042 aux' has been unregistered
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Using IPI Shortcut mode
input: AT Translated Set 2 keyboard as /class/input/input0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
Write protecting the kernel text: 3400k
Write protecting the kernel read-only data: 976k
agpgart: Detected VIA ProSavage PM133/PL133/PN133 chipset
agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xe0000000
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
savagefb: mapped io at cea00000
savagefb: probed videoram:  32768k
savagefb: Detected current MCLK value of 14318 kHz
savagefb: mapped framebuffer at ceb00000, pbase =3D=3D d0000000
savagefb v0.4.0_2.6: 32640kB VRAM, using 800x600, 37.878kHz, 60Hz
fb: S3 TwisterP frame buffer device
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1=

