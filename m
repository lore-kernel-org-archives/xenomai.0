MIME-Version: 1.0
From: ali hagigat <hagigatali@gmail.com>
Date: Tue, 30 May 2017 17:32:09 +0430
Message-ID: <CAKKWdtfpTs1O5b-ihm2JP8vSm7KxZn7YAaOGO6Zy3H7we=SAYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] vortex86dx
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I use xenomai for vortex86dx and cpc307 board. the kernel hangs. why?


Linux version 2.6.30 (am@localhost.localdomain) (gcc version 4.9.3
(Buildroot 2016.05) ) #6 Tue May 30 12:41:26 IRDT 2017
KERNEL supported cpus:**************************************
  Intel GenuineIntel*      Please select boot device:      *
  AMD AuthenticAMD  ****************************************
  NSC Geode by NSC  * HDD:PM-Fastwel Embedded ATA Fla      *
  Cyrix CyrixInstead* USB:JetFlash Transcend               *
  Centaur CentaurHauls<Enter Setup>                        *
  Transmeta GenuineTMx86                                   *
  Transmeta TransmetaCPU                                   *
  UMC UMC UMC UMC   *                                      *
CPU: vendor_id 'Vortex86 SoC' unknown, using generic init. *
CPU: Your system may be unstable.                          *
BIOS-provided physical RAM map:*****************************
 BIOS-e820: 0000000000000000 - 000000000009a000 (usable)   *
 BIOS-e820: 000000000009a000 - 00000000000a0000 (reserved) *
 BIOS-e820: 00000000000efff0 - 0000000000100000 (reserved) *
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)****
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
DMI not present or invalid.
last_pfn =3D 0x10000 max_arch_pfn =3D 0x100000
init_memory_mapping: 0000000000000000-0000000010000000
256MB LOWMEM available.
  mapped low ram: 0 - 100000004 bytes nvram
  low ram: 0 - 10000000 interface driver hiddev
  node 0 low ram: 00000000 - 10000000ver usbhid
  node 0 bootmap 00001000 - 00003000
(6 early reservations) =3D=3D> bootmem [0000000000 - 0010000000]
  #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [0000000000 - 00000=
01000]
  #1 [0000100000 - 000043e824]    TEXT DATA BSS =3D=3D> [0000100000 - 00004=
3e824]
  #2 [000009a000 - 0000100000]    BIOS reserved =3D=3D> [000009a000 - 00001=
00000]
  #3 [000043f000 - 0000441000]              BRK =3D=3D> [000043f000 - 00004=
41000]4)
  #4 [0000007000 - 0000045000]          PGTABLE =3D=3D> [0000007000 - 00000=
45000]
  #5 [0000001000 - 0000003000]          BOOTMAP =3D=3D> [0000001000 - 00000=
03000]
Zone PFN ranges:correct "root=3D" boot option; here are the available parti=
tions:
  DMA      0x00000000 -> 0x00001000e-gd
  Normal   0x00001000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[2] active PFN rangesable to mount root fs on unknown-block(0=
,0)
    0: 0x00000000 -> 0x0000009aed 2.6.30 #5
    0: 0x00000100 -> 0x00010000
Allocating PCI resources starting at 20000000 (gap: 10000000:ef000000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64922
Kernel command line: root=3D/dev/sda2 nosmp tsc=3Dreliable rootdelay=3D15 r=
w
console=3DttyS0,115200n8 init=3D/bin/busybox init BOOT_IMAGE=3Dbzima
Initializing CPU#0t_root+0x4f/0x57
Experimental hierarchical RCU implementation.
Experimental hierarchical RCU init done.
NR_IRQS:167>] ? kernel_init+0x0/0xb2
PID hash table entries: 1024 (order: 10, 4096 bytes)
Fast TSC calibration using PIT
Detected 599.908 MHz processor.
I-pipe 2.4-05: pipeline enabled.
Console: colour dummy device 80x25
console [ttyS0] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255720k/262144k available (2056k kernel code, 5832k reserved,
873k data, 188k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffeb000 - 0xfffff000   (  80 kB)
    vmalloc : 0xd0800000 - 0xfffe9000   ( 759 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
      .init : 0xc03e0000 - 0xc040f000   ( 188 kB)
      .data : 0xc030224b - 0xc03dc85c   ( 873 kB)
      .text : 0xc0100000 - 0xc030224b   (2056 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
Calibrating delay loop (skipped), value calculated using timer
frequency.. 1199.81 BogoMIPS (lpj=3D5999080)
Mount-cache hash table entries: 512
CPU: Vortex86 SoC 05/02 stepping 02
Checking 'hlt' instruction... OK.
net_namespace: 296 bytes
NET: Registered protocol family 16
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Probing PCI hardware
pci 0000:00:07.0: default IRQ router [17f3:6031]
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
platform rtc_cmos: registered platform RTC device (no PNP device found)
I-pipe: Domain Xenomai registered.
Xenomai: hal/i386 started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.6.5 (Lost in a Memory) loaded.
Xenomai: debug mode enabled.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
msgmni has been set to 499
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver, 12 ports, IRQ sharing enabled
=EF=BF=BDserial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
serial8250: ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A
serial8250: ttyS3 at I/O 0x2e8 (irq =3D 3) is a 16550A
brd: module loaded
loop: module loaded
usbcore: registered new interface driver ub
Uniform Multi-Platform E-IDE driver
piix 0000:00:0c.0: IDE controller (0x17f3:0x1011 rev 0x01)
PIIX_IDE 0000:00:0c.0: guessed PCI INT A -> IRQ 14
piix 0000:00:0c.0: IDE port disabled
piix 0000:00:0c.0: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfb00-0xfb07
hda: Fastwel Embedded ATA Flash Disk, ATA DISK drive

