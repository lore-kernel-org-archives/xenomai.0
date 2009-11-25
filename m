Message-ID: <4B0D444F.2010402@domain.hid>
Date: Wed, 25 Nov 2009 09:50:55 -0500
From: Steve Shumway <sshumway@domain.hid>
MIME-Version: 1.0
References: <4B0D41B4.201@domain.hid> <4B0D4238.2050503@domain.hid>
In-Reply-To: <4B0D4238.2050503@domain.hid>
Content-Type: multipart/mixed; boundary="------------000906050708070608070909"
Subject: Re: [Xenomai-help] Problem with xenomai installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000906050708070608070909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached: dmesg.txt

Other logs you may be interested in?



Gilles Chanteperdrix wrote:
> Steve Shumway wrote:
>   
>> Hello;
>>
>> I've been through the installation process about 4 times now, and I 
>> don't seem to be able to get it right.
>>
>> List of problems:
>>
>> In my running system (post installation) there is no /proc/xenomai 
>> directory.
>>
>> Efforts to run any of the example programs end with:
>> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
>> (modprobe xeno_native?)
>>
>> I'm using a vanilla kernel: 2.6.30.8
>>
>> The Xenomai version I'm using is: xenomai-2.4.10
>>
>> The Adeos patch is: adeos-ipipe-2.6.30.8-x86-2.4-06.patch
>>
>> The resulting kernel does boot. I can look into /proc/config.gz and see 
>> that the realtime extensions have been configured into the kernel. What 
>> few modules there are, are all in 
>> /lib/modules/2.6.30.8-adeos-ipipe-2.6.30.8-x86-2.4-06/... just as one 
>> would expect.
>>
>> What am I doing wrong?
>>
>> Any help would be appreciated.
>>     
>
> Show us the kernel logs.
>
>   

--------------000906050708070608070909
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.30.8-adeos-ipipe-2.6.30.8-x86-2.4-06 (root@domain.hid) (gcc version 4.3.4 (Gentoo 4.3.4 p1.0, pie-10.1.5) ) #1 Wed Nov 25 08:38:37 EST 2009
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  NSC Geode by NSC
  Cyrix CyrixInstead
  Centaur CentaurHauls
  Transmeta GenuineTMx86
  Transmeta TransmetaCPU
  UMC UMC UMC UMC
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
DMI not present or invalid.
last_pfn = 0x8000 max_arch_pfn = 0x100000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-C8FFF write-protect
  C9000-FFFFF uncachable
MTRR variable ranges enabled:
  0 base 000000000 mask FF8000000 write-back
  1 base 0E0000000 mask FFC000000 write-combining
  2 disabled
  3 disabled
  4 disabled
  5 disabled
  6 disabled
  7 disabled
PAT not supported by CPU.
init_memory_mapping: 0000000000000000-0000000008000000
 0000000000 - 0000400000 page 4k
 0000400000 - 0008000000 page 2M
kernel direct mapping tables up to 8000000 @ 7000-b000
0MB HIGHMEM available.
128MB LOWMEM available.
  mapped low ram: 0 - 08000000
  low ram: 0 - 08000000
  node 0 low ram: 00000000 - 08000000
  node 0 bootmap 00001000 - 00002000
(5 early reservations) ==> bootmem [0000000000 - 0008000000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000200000 - 000083bb9c]    TEXT DATA BSS ==> [0000200000 - 000083bb9c]
  #2 [000009f000 - 0000100000]    BIOS reserved ==> [000009f000 - 0000100000]
  #3 [000083c000 - 000083f000]              BRK ==> [000083c000 - 000083f000]
  #4 [0000001000 - 0000002000]          BOOTMAP ==> [0000001000 - 0000002000]
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  Normal   0x00001000 -> 0x00008000
  HighMem  0x00008000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000000 -> 0x000000a0
    0: 0x00000100 -> 0x00008000
On node 0 totalpages: 32672
free_area_init_node: node 0, pgdat c06f1fa0, node_mem_map c1000000
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 3968 pages, LIFO batch:0
  Normal zone: 224 pages used for memmap
  Normal zone: 28448 pages, LIFO batch:7
Using APIC driver default
Local APIC disabled by BIOS -- you can enable it with "lapic"
nr_irqs_gsi: 16
Allocating PCI resources starting at 10000000 (gap: 8000000:f7ff0000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32416
Kernel command line: root=/dev/hda4 ro xeno_nucleus.xenomai_gid=1001 << 1003
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
NR_IRQS:288
PID hash table entries: 512 (order: 9, 2048 bytes)
Fast TSC calibration using PIT
Detected 898.678 MHz processor.
I-pipe 2.4-06: pipeline enabled.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Initializing HighMem for node 0 (00000000:00000000)
Memory: 122928k/131072k available (3726k kernel code, 7604k reserved, 1370k data, 360k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffab000 - 0xfffff000   ( 336 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xc8800000 - 0xff7fe000   ( 879 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
      .init : 0xc06fe000 - 0xc0758000   ( 360 kB)
      .data : 0xc05a3b6e - 0xc06fa3d4   (1370 kB)
      .text : 0xc0200000 - 0xc05a3b6e   (3726 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop (skipped), value calculated using timer frequency.. 1797.35 BogoMIPS (lpj=898678)
Security Framework initialized
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: Intel Celeron (Coppermine) stepping 0a
Checking 'hlt' instruction... OK.
net_namespace: 296 bytes
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb650, last bus=1
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
pci 0000:00:00.0: reg 10 32bit mmio: [0xe0000000-0xe3ffffff]
pci 0000:00:01.0: supports D1
pci 0000:00:07.1: reg 20 io port: [0xe000-0xe00f]
pci 0000:00:07.4: quirk: region 6000-607f claimed by vt82c686 HW-mon
pci 0000:00:07.4: quirk: region 5000-500f claimed by vt82c686 SMB
pci 0000:00:0c.0: reg 10 io port: [0xec00-0xecff]
pci 0000:00:0c.0: reg 14 32bit mmio: [0xe6000000-0xe60000ff]
pci 0000:00:0c.0: supports D1 D2
pci 0000:00:0c.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:00:0c.0: PME# disabled
pci 0000:00:0d.0: reg 10 32bit mmio: [0xe4000000-0xe4ffffff]
pci 0000:00:0d.0: reg 30 32bit mmio: [0x000000-0x03ffff]
pci 0000:00:07.0: VIA IRQ router [1106:0686]
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: disabled
pci 0000:00:01.0:   MEM window: disabled
pci 0000:00:01.0:   PREFETCH window: disabled
pci 0000:00:01.0: setting latency timer to 64
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
platform rtc_cmos: registered platform RTC device (no PNP device found)
Xenomai: Local APIC absent or disabled!
         Disable APIC support or pass "lapic=1" as bootparam.
Xenomai: system init failed, code -19.
Xenomai: native skin init failed, code -19.
Xenomai: starting POSIX services.
Xenomai: POSIX skin init failed, code -19.
Xenomai: RTDM skin init failed, code -19.
HugeTLB registered 4 MB page size, pre-allocated 0 pages
Installing knfsd (copyright (C) 1996 okir@domain.hid).
NTFS driver 2.1.29 [Flags: R/W].
msgmni has been set to 240
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:00:01.0: disabling DAC on VIA PCI bridge
pci 0000:00:07.0: Disabling VIA external APIC routing
pci 0000:00:0d.0: Boot video device
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
[drm] Initialized drm 1.1.0 20060810
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
parport_pc: VIA parallel port: io=0x378, irq=7
FDC 0 is a post-1991 82077
brd: module loaded
loop: module loaded
Uniform Multi-Platform E-IDE driver
via82cxxx 0000:00:07.1: VIA vt82c686b (rev 40) IDE UDMA100
via82cxxx 0000:00:07.1: IDE controller (0x1106:0x0571 rev 0x06)
via82cxxx 0000:00:07.1: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe000-0xe007
    ide1: BM-DMA at 0xe008-0xe00f
Probing IDE interface ide0...
hda: ST320011A, ATA DISK drive
hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide-gd driver 1.18
hda: max request size: 128KiB
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4
ide-cd driver 5.00
Loading iSCSI transport class v2.0-870.
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
8139too Fast Ethernet driver 0.9.28
PCI: setting IRQ 11 as level-triggered
8139too 0000:00:0c.0: found PCI INT A -> IRQ 11
eth0: RealTek RTL8139 at 0xc880e000, 00:08:9b:80:16:e4, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd: block sizes: qh 128 qtd 96 itd 160 sitd 96
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 64 td 64
uhci_hcd: USB Universal Host Controller Interface driver
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver libusual
usbcore: registered new interface driver usbled
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one day, 114 bytes nvram
EISA: Probing bus 0 at eisa.0
No iBFT detected.
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Using IPI Shortcut mode
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with writeback data mode.
VFS: Mounted root (ext3 filesystem) readonly on device 3:4.
Freeing unused kernel memory: 360k freed
udev: starting version 146
EXT3 FS on hda4, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
Adding 257032k swap on /dev/hda2.  Priority:-1 extents:1 across:257032k 
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--------------000906050708070608070909--

