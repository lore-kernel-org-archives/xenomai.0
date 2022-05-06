From: Asier Tamayo <asier.tamayo@onaedm.com>
Subject: System freezes with Vortex86DX3 board and old Xenomai version
Date: Fri, 6 May 2022 07:08:01 +0000
Message-ID: <AS8P190MB14002FCB14BF86EE42EEE16DF4C59@AS8P190MB1400.EURP190.PROD.OUTLOOK.COM>
Content-Language: es-ES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello all,

I have a system already working correctly with an old Kernel 2.6.34 and Xen=
omai version 2.5.5 on 2 different boards:
- Intel N270 processor + Intel 82945GSE North Bridge + Intel 82801GBM South=
 Bridge.
- AMD Embedded G-Series T52R processor + AMD Fusion Controller Hub.
Now I am trying to make it run on a Vortex86DX3 SOC. Has anyone managed to =
run Xenomai in this board? With which Xenomai/Linux version? Have you had t=
o patch the kernel?

My system starts correctly many times, but from time to time it freezes: I =
cannot see any kernel message, the cycles in the rtdm drivers are not calle=
d.... I do not know where the problem is.  Any clue regarding what to check=
, what steps to take, who can help me (even in a professional way)... would=
 be greatly appreciated. I know that the version is really old and that I s=
hould be trying both a newer version and a compatible hardware, but at this=
 moment I need to keep the old Linux and Xenomai.

Linux/Xenomai freezes around 1 out of 20 times I start all the Xenomai task=
s of my system. It freezes even launching several latency Xenomai tests. It=
 does not occur if I do not start any Xenomai task. Does anyone know why it=
 is happening only under high load of the Xenomai system?

I can provide you with any information you may need. To start with, I attac=
h some of it:

Parameters passed to the kernel:
                append console=3DttyS0,115200 video=3Dvesafb:1024x768-16@60=
 vga=3D0x317 splash=3Dverbose rw vmalloc=3D512M clocksource=3Dtsc acpi=3Dof=
f noapic pci=3Dnomsi
                I have also tried tsc=3Dreliable, but it makes no differenc=
e

The kernel has been configured, among others, with: CONFIG_M686, CONFIG_X86=
_GENERIC, CONFIG_X86_TSC, CONFIG_X86_LOCAL_APIC, CONFIG_X86_IO_APIC, CONFIG=
_PM, CONFIG_ACPI, CONFIG_PCI, CONFIG_PCIEPORTBUS, CONFIG_ARCH_SUPPORTS_MSI,=
 CONFIG_PCI_MSI, CONFIG_PCI_IOAPIC, CONFIG_PARPORT, CONFIG_PARPORT_PC, as w=
ell as lots of debug flags. For these tests, local APIC is defined, but I h=
ave also tried not enabling it and it hangs in a similar way.

The content of /proc/cpuinfo:
processor       : 0
vendor_id       : Vortex86 SoC
cpu family      : 6
model           : 1
model name      : Vortex86DX3
stepping        : 1
cpu MHz         : 1000.110
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu pse tsc msr cx8 apic sep pge cmov mmx fxsr sse
bogomips        : 2000.22
clflush size    : 32
cache_alignment : 32
address sizes   : 32 bits physical, 32 bits virtual
power management:

The content of /proc/xenomai/timer:
                status=3Don:setup=3D0:clock=3D4057142075783:timerdev=3Dlapi=
c:clockdev=3Dtsc

Best regards,

Asier.


NOTE: Most of the times the system freezes, but it has also given me some s=
tack traces. I attach an initial dmesg and the stack trace.

[    0.000000] Linux version 2.6.34.12-ELinOS-1-ipipe (elinos@ubuntu) (gcc =
version 4.4.5 (GCC) ) #471 Fri Apr 29 13:36:10 CEST 2022
[    0.000000] CPU: vendor_id 'Vortex86 SoC' unknown, using generic init.
[    0.000000] CPU: Your system may be unstable.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001bfd0000 (usable)
[    0.000000]  BIOS-e820: 000000001bfd0000 - 000000001bfde000 (ACPI data)
[    0.000000]  BIOS-e820: 000000001bfde000 - 000000001c000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU or di=
sabled in BIOS!
[    0.000000] DMI present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working around =
it.
[    0.000000] last_pfn =3D 0x1bfd0 max_arch_pfn =3D 0x100000
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009fc00 (usable)
[    0.000000]  modified: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 000000001bfd0000 (usable)
[    0.000000]  modified: 000000001bfd0000 - 000000001bfde000 (ACPI data)
[    0.000000]  modified: 000000001bfde000 - 000000001c000000 (ACPI NVS)
[    0.000000]  modified: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] init_memory_mapping: 0000000000000000-000000001bfd0000
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 447MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 1bfd0000
[    0.000000]   low ram: 0 - 1bfd0000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x0001bfd0
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0001bfd0
[    0.000000] Allocating PCI resources starting at 1c000000 (gap: 1c000000=
:e3f80000)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 113631
[    0.000000] Kernel command line: acpi=3Doff noapic console=3DttyS0,11520=
0 video=3Dvesafb:1024x768-16@60 vga=3D0x317 splash=3Dverbose rw vmalloc=3D5=
12M tsc=3Dreliable BOOT_IMAGE=3Dlinux_start
[    0.000000] bootsplash: verbose mode.
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] Subtract (23 early reservations)
[    0.000000]   #0 [0001000000 - 00049585ec]   TEXT DATA BSS
[    0.000000]   #1 [000009fc00 - 0000100000]   BIOS reserved
[    0.000000]   #2 [0004959000 - 000496c16b]             BRK
[    0.000000]   #3 [0000010000 - 000006d000]         PGTABLE
[    0.000000]   #4 [000496d000 - 000496e000]         BOOTMEM
[    0.000000]   #5 [000496e000 - 0004cee000]         BOOTMEM
[    0.000000]   #6 [0004958600 - 0004958604]         BOOTMEM
[    0.000000]   #7 [0004958640 - 00049586c0]         BOOTMEM
[    0.000000]   #8 [00049586c0 - 00049586ec]         BOOTMEM
[    0.000000]   #9 [0004cee000 - 0004cef000]         BOOTMEM
[    0.000000]   #10 [0004958700 - 00049587e0]         BOOTMEM
[    0.000000]   #11 [0004958800 - 0004958840]         BOOTMEM
[    0.000000]   #12 [0004958840 - 0004958880]         BOOTMEM
[    0.000000]   #13 [0004958880 - 00049588c0]         BOOTMEM
[    0.000000]   #14 [00049588c0 - 0004958900]         BOOTMEM
[    0.000000]   #15 [0004958900 - 0004958940]         BOOTMEM
[    0.000000]   #16 [0004958940 - 0004958980]         BOOTMEM
[    0.000000]   #17 [0004958980 - 00049589c0]         BOOTMEM
[    0.000000]   #18 [00049589c0 - 0004958a4d]         BOOTMEM
[    0.000000]   #19 [0004958a80 - 0004958b0d]         BOOTMEM
[    0.000000]   #20 [0004cef000 - 0004cf1000]         BOOTMEM
[    0.000000]   #21 [0004cf1000 - 0004d31000]         BOOTMEM
[    0.000000]   #22 [0004d31000 - 0004d51000]         BOOTMEM
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 394948k/458560k available (4523k kernel code, 63160k=
 reserved, 1939k data, 51620k init, 0k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfffd1000 - 0xfffff000   ( 184 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xdc7d0000 - 0xff7fe000   ( 560 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xdbfd0000   ( 447 MB)
[    0.000000]       .init : 0xc1650000 - 0xc48b9000   (51620 kB)
[    0.000000]       .data : 0xc146af4c - 0xc164fe18   (1939 kB)
[    0.000000]       .text : 0xc1000000 - 0xc146af4c   (4523 kB)
[    0.000000] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.000000] SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, MinObjects=
=3D0, CPUs=3D1, Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] RCU-based detection of stalled CPUs is enabled.
[    0.000000] NR_IRQS:16
[    0.000000] I-pipe 2.7-04: pipeline enabled.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 799.968 MHz processor.
[    0.003010] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 1599.93 BogoMIPS (lpj=3D799968)
[    0.005540] Mount-cache hash table entries: 512
[    0.008041] Performance Events:
[    0.009006] CPU: Vortex86 SoC Vortex86DX3                               =
       stepping 01
[    0.013012] Checking 'hlt' instruction... OK.
[    0.019497] ftrace: converting mcount calls to 0f 1f 44 00 00
[    0.020016] ftrace: allocating 15466 entries in 31 pages
[    0.060579] NET: Registered protocol family 16
[    0.075864] PCI: Using configuration type 1 for base access
[    0.145256] bio: create slab <bio-0> at 0
[    0.149017] ACPI: Interpreter disabled.
[    0.158728] SCSI subsystem initialized
[    0.163596] usbcore: registered new interface driver usbfs
[    0.165240] usbcore: registered new interface driver hub
[    0.167405] usbcore: registered new device driver usb
[    0.171258] PCI: Probing PCI hardware
[    0.178210] pci 0000:00:01.0: PCI bridge to [bus 01-02]
[    0.180218] pci 0000:01:00.0: PCI bridge to [bus 02-02]
[    0.183073] pci 0000:00:02.0: PCI bridge to [bus 03-03]
[    0.198853] pci 0000:00:07.0: default IRQ router [17f3:6035]
[    0.208036] cfg80211: Calling CRDA to update world regulatory domain
[    0.210554] Switching to clocksource tsc
[    0.630506] pnp: PnP ACPI: disabled
[    0.642468] pci 0000:00:01.0: BAR 8: assigned [mem 0x1c000000-0x1c1fffff=
]
[    0.649405] pci 0000:00:01.0: BAR 9: assigned [mem 0x1c200000-0x1c3fffff=
 pref]
[    0.656760] pci 0000:00:02.0: BAR 8: assigned [mem 0x1c400000-0x1c7fffff=
]
[    0.663681] pci 0000:00:01.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.669896] pci 0000:01:00.0: PCI bridge to [bus 02-02]
[    0.675224] pci 0000:01:00.0:   bridge window [io  disabled]
[    0.681004] pci 0000:01:00.0:   bridge window [mem disabled]
[    0.686786] pci 0000:01:00.0:   bridge window [mem pref disabled]
[    0.693018] pci 0000:00:01.0: PCI bridge to [bus 01-02]
[    0.698353] pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
[    0.704569] pci 0000:00:01.0:   bridge window [mem 0x1c000000-0x1c1fffff=
]
[    0.711475] pci 0000:00:01.0:   bridge window [mem 0x1c200000-0x1c3fffff=
 pref]
[    0.718826] pci 0000:00:02.0: PCI bridge to [bus 03-03]
[    0.724160] pci 0000:00:02.0:   bridge window [io  0xd000-0xdfff]
[    0.730375] pci 0000:00:02.0:   bridge window [mem 0x1c400000-0x1c7fffff=
]
[    0.737281] pci 0000:00:02.0:   bridge window [mem 0xf7f00000-0xf7ffffff=
 pref]
[    0.744656] pci 0000:00:01.0: enabling device (0104 -> 0107)
[    0.751600] NET: Registered protocol family 2
[    0.756871] IP route cache hash table entries: 4096 (order: 2, 16384 byt=
es)
[    0.767562] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes)
[    0.775229] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[    0.782077] TCP: Hash tables configured (established 16384 bind 16384)
[    0.788710] TCP reno registered
[    0.791961] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.797916] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.805557] NET: Registered protocol family 1
[    2.812622] DMA-API: preallocated 32768 debug entries
[    2.817800] DMA-API: debugging enabled by kernel config
[    2.825636] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    2.833410] microcode: no support for this CPU vendor
[    2.838565] Scanning for low memory corruption every 60 seconds
[    2.848581] I-pipe: Domain Xenomai registered.
[    2.853233] Xenomai: hal/i386 started.
[    2.857320] Xenomai: scheduling class idle registered.
[    2.862591] Xenomai: scheduling class rt registered.
[    2.896645] Xenomai: real-time nucleus v2.5.5 (Ghosts) loaded.
[    2.902606] Xenomai: debug mode enabled.
[    2.913646] Xenomai: starting native API services.
[    2.918566] Xenomai: starting POSIX services.
[    2.924670] Xenomai: starting RTDM services.
[    3.130900] Slow work thread pool: Starting up
[    3.136147] Slow work thread pool: Ready
[    3.141271] msgmni has been set to 771
[    3.148856] alg: No test for stdrng (krng)
[    3.156459] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    3.163995] io scheduler noop registered
[    3.168065] io scheduler deadline registered
[    3.176564] io scheduler cfq registered (default)
[    3.202860] vesafb: framebuffer at 0xf8000000, mapped to 0xdca00000, usi=
ng 6144k, total 8192k
[    3.211528] vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D4
[    3.217742] vesafb: protected mode interface info at c7c1:0000
[    3.223693] vesafb: pmi: set display start =3D c00c7c50, set palette =3D=
 c00c7c6d
[    3.230947] vesafb: scrolling: redraw
[    3.234728] vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
[    3.243304] bootsplash 3.1.6-2004/03/31: looking for picture...
[    3.331403]  silentjpeg size 50841 bytes,
[    3.331548] ...found (1024x768, 25499 bytes, v3).
[    3.349873] Console: switching to colour frame buffer device 128x48
[    3.463758] fb0: VESA VGA frame buffer device
[    3.469782] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Te=
am
[    3.477335] RTCAN SJA1000 driver initialized
[    4.233958] ppdev: user-space parallel port driver
[    4.239104] Linux agpgart interface v0.103
[    4.243973] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 secon=
ds, margin is 60 seconds).
[    4.253088] Hangcheck: Using get_cycles().
[    4.257331] intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855=
GM/865G/915G/915GM/945G/945GM/945GME/965G/965GM chipsets
[    4.269100] intelfb: Version 0.9.6
[    4.273512] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    4.281123] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    4.289668] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[    4.307781] parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
[    4.313934] parport0: irq 0 detected
[    7.417218] floppy0: no floppy controllers found
[    7.431347] scsi0 : pata_rdc
[    7.441147] scsi1 : pata_rdc
[    7.445962] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xe000 irq=
 14
[    7.453072] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xe008 irq=
 15
[    7.469312] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    7.475532] e100: Copyright(c) 1999-2006 Intel Corporation
[    7.488183] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    7.494456] r8169 0000:03:00.0: (unregistered net_device): unknown MAC, =
using family default
[    7.503143] r8169 0000:03:00.0: no MSI. Back to INTx.
[    7.513254] r8169 0000:03:00.0: eth0: RTL8168b/8111b at 0xdc9c6000, 00:1=
b:eb:5b:4c:fe, XID 0c900800 IRQ 11
[    7.526747] usbcore: registered new interface driver asix
[    7.532857] usbcore: registered new interface driver rtl8187
[    7.540670] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    7.547709] ehci_hcd 0000:00:0a.1: EHCI Host Controller
[    7.554775] ehci_hcd 0000:00:0a.1: new USB bus registered, assigned bus =
number 1
[    7.584245] ehci_hcd 0000:00:0a.1: irq 14, io mem 0xfebfec00
[    7.596109] ehci_hcd 0000:00:0a.1: USB 2.0 started, EHCI 1.00
[    7.603224] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    7.610146] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    7.617497] usb usb1: Product: EHCI Host Controller
[    7.622493] usb usb1: Manufacturer: Linux 2.6.34.12-ELinOS-1-ipipe ehci_=
hcd
[    7.629579] usb usb1: SerialNumber: 0000:00:0a.1
[    7.637716] hub 1-0:1.0: USB hub found
[    7.641730] hub 1-0:1.0: 4 ports detected
[    7.648947] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    7.655606] ohci_hcd 0000:00:0a.0: OHCI Host Controller
[    7.663138] ohci_hcd 0000:00:0a.0: new USB bus registered, assigned bus =
number 2
[    7.671195] ohci_hcd 0000:00:0a.0: irq 5, io mem 0xfebff000
[    7.677631] ata2.00: ATA-9: SATADOM-SH TYPE D 3SE, S130604, max UDMA/133
[    7.684465] ata2.00: 1974672 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    7.692649] ata2.00: configured for UDMA/100
[    7.699269] scsi 1:0:0:0: Direct-Access     ATA      SATADOM-SH TYPE  S1=
30 PQ: 0 ANSI: 5
[    7.715163] sd 1:0:0:0: [sda] 1974672 512-byte logical blocks: (1.01 GB/=
964 MiB)
[    7.725496] sd 1:0:0:0: [sda] Write Protect is off
[    7.761919] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    7.768844] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    7.776195] usb usb2: Product: OHCI Host Controller
[    7.781191] usb usb2: Manufacturer: Linux 2.6.34.12-ELinOS-1-ipipe ohci_=
hcd
[    7.788277] usb usb2: SerialNumber: 0000:00:0a.0
[    7.796547] hub 2-0:1.0: USB hub found
[    7.800574] hub 2-0:1.0: 4 ports detected
[    7.807678] uhci_hcd: USB Universal Host Controller Interface driver
[    7.817098] Initializing USB Mass Storage driver...
[    7.823342] usbcore: registered new interface driver usb-storage
[    7.829467] USB Mass Storage support registered.
[    7.834761] usbcore: registered new interface driver ums-datafab
[    7.841511] usbcore: registered new interface driver ums-freecom
[    7.848276] usbcore: registered new interface driver ums-isd200
[    7.855101] usbcore: registered new interface driver ums-jumpshot
[    7.861879] usbcore: registered new interface driver ums-sddr09
[    7.868555] usbcore: registered new interface driver ums-sddr55
[    7.875337] usbcore: registered new interface driver ums-usbat
[    7.882825] usbcore: registered new interface driver usbserial
[    7.889357] USB Serial support registered for generic
[    7.895253] usbcore: registered new interface driver usbserial_generic
[    7.901906] usbserial: USB Serial Driver core
[    7.907123] USB Serial support registered for FTDI USB Serial Device
[    7.915429] usbcore: registered new interface driver ftdi_sio
[    7.921293] ftdi_sio: v1.5.0:USB FTDI Serial Converters Driver
[    7.927744] USB Serial support registered for pl2303
[    7.933651] usbcore: registered new interface driver pl2303
[    7.939343] pl2303: Prolific PL2303 USB to serial adaptor driver
[    7.945971] USB Serial support registered for TI USB 3410 1 port adapter
[    7.953399] USB Serial support registered for TI USB 5052 2 port adapter
[    7.961243] usbcore: registered new interface driver ti_usb_3410_5052
[    7.967809] ti_usb_3410_5052: v0.9:TI USB 3410/5052 Serial Driver
[    7.976434] PNP: No PS/2 controller found. Probing ports directly.
[    7.987251] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    8.001958]  sda:
[    8.006393] serio: i8042 KBD port at 0x60,0x64 irq 1
[    8.011744] serio: i8042 AUX port at 0x60,0x64 irq 12
[    8.020661] mice: PS/2 mouse device common for all mice
[    8.026777]  sda1 sda2 sda3
[    8.042025] sd 1:0:0:0: [sda] Attached SCSI disk
[    8.050803] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    8.057476] rtc0: alarms up to one day, 114 bytes nvram
[    8.063308] i2c /dev entries driver
[    8.083302] device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised:=
 dm-devel@redhat.com<mailto:dm-devel@redhat.com>
[    8.094124] cpuidle: using governor ladder
[    8.104196] usbcore: registered new interface driver hiddev
[    8.110666] usbcore: registered new interface driver usbhid
[    8.116364] usbhid: USB HID core driver
[    8.127225] ip_tables: (C) 2000-2006 Netfilter Core Team
[    8.132965] TCP cubic registered
[    8.136309] NET: Registered protocol family 17
[    8.147946] rtc_cmos rtc_cmos: setting system clock to 2008-08-08 00:06:=
38 UTC (1218153998)
[    8.159998] debug: unmapping init memory c1650000..c48b9000
[    8.174751] Write protecting the kernel text: 4524k
[    8.179754] Testing CPA: Reverting c1000000-c146b000
[    8.185628] Testing CPA: write protecting again
[    8.191260] Write protecting the kernel read-only data: 1572k
[    8.197138] Testing CPA: undo c146b000-c15f4000
[    8.202098] Testing CPA: write protecting again
[    8.426218] usb 2-1: new low speed USB device using ohci_hcd and address=
 2
[    8.574944] usb 2-1: New USB device found, idVendor=3D04f2, idProduct=3D=
1516
[    8.581802] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    8.589067] usb 2-1: Product: USB Keyboard
[    8.593280] usb 2-1: Manufacturer: Chicony
[    8.621181] input: Chicony  USB Keyboard as /devices/pci0000:00/0000:00:=
0a.0/usb2/2-1/2-1:1.0/input/input0
[    8.633708] generic-usb 0003:04F2:1516.0001: input,hidraw0: USB HID v1.1=
1 Keyboard [Chicony  USB Keyboard] on usb-0000:00:0a.0-1/input0
[    8.670814] input: Chicony  USB Keyboard as /devices/pci0000:00/0000:00:=
0a.0/usb2/2-1/2-1:1.1/input/input1
[    8.683321] generic-usb 0003:04F2:1516.0002: input,hidraw1: USB HID v1.1=
1 Device [Chicony  USB Keyboard] on usb-0000:00:0a.0-1/input1
[    8.915220] usb 2-2: new low speed USB device using ohci_hcd and address=
 3
[    9.060194] usb 2-2: New USB device found, idVendor=3D04b3, idProduct=3D=
310d
[    9.067071] usb 2-2: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    9.095852] input: HID 04b3:310d as /devices/pci0000:00/0000:00:0a.0/usb=
2/2-2/2-2:1.0/input/input2
[    9.108970] generic-usb 0003:04B3:310D.0003: input,hidraw2: USB HID v1.1=
1 Mouse [HID 04b3:310d] on usb-0000:00:0a.0-2/input0
[   21.135842] r8169 0000:03:00.0: eth0: link up
[   21.140360] r8169 0000:03:00.0: eth0: link up
[   32.847124] CPA self-test:
[   32.902258]  4k 114640 large 0 gb 0 x 114640[c0000000-dbfcf000] miss 0
[   32.984600]  4k 114640 large 0 gb 0 x 114640[c0000000-dbfcf000] miss 0
[   33.059110]  4k 114640 large 0 gb 0 x 114640[c0000000-dbfcf000] miss 0
[   33.065764] ok.

[   46.849405] Xenomai: registered exported object dispsem-436 (semaphores)=
                --> several latency tests launched
[   46.891608] Xenomai: registered exported object dispsem-437 (semaphores)
[   46.982265] Xenomai: registered exported object dispsem-438 (semaphores)
[   47.039647] Xenomai: registered exported object dispsem-439 (semaphores)
[   47.095626] Xenomai: registered exported object dispsem-442 (semaphores)
[   47.182336] Xenomai: registered exported object dispsem-445 (semaphores)
[   47.259469] Xenomai: registered exported object dispsem-448 (semaphores)
[   47.369658] Xenomai: registered exported object dispsem-452 (semaphores)
[   47.465396] Xenomai: registered exported object dispsem-454 (semaphores)
[   47.545540] Xenomai: registered exported object dispsem-458 (semaphores)
[   47.635269] Xenomai: registered exported object dispsem-460 (semaphores)
[   47.740752] Xenomai: registered exported object dispsem-463 (semaphores)
[   47.858047] Xenomai: registered exported object dispsem-467 (semaphores)
[   47.955551] Xenomai: registered exported object dispsem-471 (semaphores)
[   48.001068] Xenomai: registered exported object dispsem-474 (semaphores)
[   48.040024] Xenomai: registered exported object dispsem-477 (semaphores)
[   61.377104] Xenomai: registered exported object dispsem-485 (semaphores)
[   61.535053] Xenomai: registered exported object dispsem-486 (semaphores)
[   61.699081] Xenomai: registered exported object dispsem-487 (semaphores)
[   61.814512] Xenomai: registered exported object dispsem-490 (semaphores)
[   62.250099] Xenomai: registered exported object dispsem-493 (semaphores)
[   62.337131] Xenomai: registered exported object dispsem-496 (semaphores)
[   62.875133] Xenomai: registered exported object dispsem-499 (semaphores)
[   64.599116] Xenomai: registered exported object dispsem-501 (semaphores)
[   65.147427] Xenomai: registered exported object dispsem-505 (semaphores)
[   66.513194] Xenomai: registered exported object dispsem-506 (semaphores)
[   70.577550] Xenomai: registered exported object dispsem-510 (semaphores)
[  135.291553] BUG: soft lockup - CPU#0 stuck for 61s! [pageattr-test:16]
[  135.291553] Modules linked in:
[  135.291553] Modules linked in:
[  135.291553]
[  135.291553] Pid: 16, comm: pageattr-test Not tainted 2.6.34.12-ELinOS-1-=
ipipe #471 EMKORE                /EMKORE
[  135.291553] EIP: 0060:[<c12c18e6>] EFLAGS: 00000206 CPU: 0
[  135.291553] EIP is at io_serial_in+0x11/0x20
[  135.291553] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
[  135.291553] ESI: 00000000 EDI: 00000000 EBP: d7f8daa8 ESP: c160201c
[  135.291553]  DS: 0000 ES: 0000 FS: 0000 GS: 0000 SS: 0068
[  135.291553] Process pageattr-test (pid: 16, ti=3Dd7f8c000 task=3Dd7f8800=
0 task.ti=3Dd7f8c000)
[  135.291553] I-pipe domain Linux
[  135.291553] Stack:
[  135.291553]  00000000 00000000 b77de0f4 00000000 00000000 00000000 00000=
000 00000000
[  135.291553] <0> 00000000 00001022 00001103 ffffffff ffffffff 00000000 00=
000000 00000000
[  135.291553] <0> 00001022 00001203 ffffffff ffffffff 00000000 00000000 00=
000000 00000000
[  135.291553] Call Trace:
[  135.291553]  [<c1017fb0>] ? mc_sysdev_add+0x0/0x110
[  135.291553] BUG: unable to handle kernel NULL pointer dereference at 000=
003c0
[  135.291553] IP: [<c1006101>] print_context_stack+0x81/0x110
[  135.291553] *pde =3D 00000000
[  135.291553] Oops: 0000 [#1] DEBUG_PAGEALLOC
[  135.291553] last sysfs file: /sys/devices/virtual/block/dm-1/uevent
[  135.291553] Modules linked in:
[  135.291553]
[  135.291553] Pid: 16, comm: pageattr-test Not tainted 2.6.34.12-ELinOS-1-=
ipipe #471 EMKORE                /EMKORE
[  135.291553] EIP: 0060:[<c1006101>] EFLAGS: 00000016 CPU: 0
[  135.291553] EIP is at print_context_stack+0x81/0x110
[  135.291553] EAX: 00000000 EBX: c16020b4 ECX: ffff917a EDX: c1602000
[  135.291553] ESI: 00000000 EDI: c146d6f8 EBP: d7f8db80 ESP: d7f8db5c
[  135.291553]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
[  135.291553] Process pageattr-test (pid: 16, ti=3Dd7f8c000 task=3Dd7f8800=
0 task.ti=3Dd7f8c000)
[  135.291553] I-pipe domain Linux
[  135.291553] Stack:
[  135.291553]  c1017fb0 c1603ffc d7f8dbac ffffe000 c1602000 d7f8dbac c1602=
01c c146d6f8
[  135.291553] <0> c1602000 d7f8dbac c10051c7 c146d6f8 c1566e01 00000000 d7=
f8db9c d7f8dbb8
[  135.291553] <0> 00000000 00000000 c1601fe0 c1566e01 d7f8dbd0 c1005f2c d7=
f8dbac c146d6f8
[  135.291553] Call Trace:
[  135.291553]  [<c1017fb0>] ? mc_sysdev_add+0x0/0x110
[  135.291553]  [<c10051c7>] ? dump_trace+0x87/0xe0
[  135.291553]  [<c1005f2c>] ? show_trace_log_lvl+0x4c/0x60
[  135.291553]  [<c1004e5b>] ? show_stack_log_lvl+0x5b/0xf0
[  135.291553]  [<c1004fd8>] ? show_registers+0xe8/0x250
[  135.291553]  [<c1060f5a>] ? ipipe_trace_function+0x2a/0x30
[  135.291553]  [<c10095e3>] ? show_regs+0x13/0x30
[  135.291553]  [<c1058e6e>] ? softlockup_tick+0x10e/0x180
[  135.291553]  [<c1035aec>] ? run_local_timers+0x1c/0x20
[  135.291553]  [<c1035b18>] ? update_process_times+0x28/0x60
[  135.291553]  [<c1035b8f>] ? update_root_process_times+0x3f/0x50
[  135.291553]  [<c104fb4f>] ? tick_sched_timer+0x5f/0x1f0
[  135.291553]  [<c104faf0>] ? tick_sched_timer+0x0/0x1f0
[  135.291553]  [<c1045b78>] ? __run_hrtimer+0x58/0x110
[  135.291553]  [<c1045e50>] ? hrtimer_interrupt+0xf0/0x270
[  135.291553]  [<c1017060>] ? __ipipe_ack_irq+0x0/0x10
[  135.291553]  [<c1005249>] ? timer_interrupt+0x19/0x20
[  135.291553]  [<c105975b>] ? handle_IRQ_event+0x5b/0x1e0
[  135.291553]  [<c1060f5a>] ? ipipe_trace_function+0x2a/0x30
[  135.291553]  [<c105bb6e>] ? handle_level_irq+0x3e/0x90
[  135.291553]  [<c1004d47>] ? handle_irq+0x37/0x60
[  135.291553]  [<c1469f24>] ? do_IRQ+0x44/0x9c
[  135.291553]  [<c105e5a1>] ? __ipipe_sync_stage+0x151/0x156
[  135.291553]  [<c1469ee0>] ? do_IRQ+0x0/0x9c
[  135.291553]  [<c105e5a6>] ? __xirq_end+0x0/0xa7
[  135.291553]  [<c1060f5a>] ? ipipe_trace_function+0x2a/0x30
[  135.291553]  [<c105e9b5>] ? __ipipe_walk_pipeline+0x95/0xb0
[  135.291553]  [<c105ebfb>] ? __ipipe_dispatch_wired_nocheck+0x5b/0x90
[  135.291553]  [<c1017060>] ? __ipipe_ack_irq+0x0/0x10
[  135.291553]  [<c105ec4b>] ? __ipipe_dispatch_wired+0x1b/0x30
[  135.291553]  [<c1017226>] ? __ipipe_handle_irq+0x176/0x1f0
[  135.291553]  [<c1003176>] ? common_interrupt+0x36/0x50
[  135.291553]  [<c101a64d>] ? lookup_address+0xd/0x80
[  135.291553]  [<c101007b>] ? ftrace_raw_output_mce_record+0x4b/0x150
[  135.291553]  [<c10604ee>] ? __ipipe_trace+0x18e/0x600
[  135.291553]  [<c1060f5a>] ? ipipe_trace_function+0x2a/0x30
[  135.291553]  [<c10031c3>] ? ftrace_call+0x5/0x8
[  135.291553]  [<c101a652>] ? lookup_address+0x12/0x80
[  135.291553]  [<c101a78d>] ? print_split+0x6d/0x1a0
[  135.291553]  [<c1060f5a>] ? ipipe_trace_function+0x2a/0x30
[  135.291553]  [<c10031c3>] ? ftrace_call+0x5/0x8
[  135.291553]  [<c101bb78>] ? do_pageattr_test+0x358/0x440
[  135.291553]  [<c101b820>] ? do_pageattr_test+0x0/0x440
[  135.291553]  [<c1041f54>] ? kthread+0x74/0x80
[  135.291553]  [<c1041ee0>] ? kthread+0x0/0x80
[  135.291553]  [<c1003196>] ? kernel_thread_helper+0x6/0x10
[  135.291553] Code: 9b 03 00 85 c0 74 2c 8b 45 f0 83 c0 04 39 c3 74 79 8b =
7d 08 31 c9 8b 55 dc 8b 45 0c ff 57 08 8b 55 ec 81 7d dc f2 31 00 c1 8b 02 =
<8b> 90 c0 03 00 00 74 1f 83 c3 04 85 f6 75 a8 3b 5d ec 76 a7 3b
[  135.291553] EIP: [<c1006101>] print_context_stack+0x81/0x110 SS:ESP 0068=
:d7f8db5c
[  135.291553] CR2: 00000000000003c0
[  135.291553] I-pipe tracer log (100 points):
[  135.291553]  |   #end     0xffffffcf      0 common_interrupt+0x40 (__ipi=
pe_trace+0x18e)
[  135.291553]  |   #func                    0 __ipipe_walk_pipeline+0x6 (_=
_ipipe_dispatch_wired_nocheck+0x5b)
[  135.291553]  |  #*[   16] pageatt -1     -1 __xnpod_schedule+0x330 (xnin=
tr_clock_handler+0x1e2)
[  135.291553]  |  #*func                   -2 xnsched_pick_next+0x9 (__xnp=
od_schedule+0x98)
[  135.291553]  |  #*[  444] samplin 50     -2 __xnpod_schedule+0x79 (xnpod=
_suspend_thread+0x82a)
[  135.291553]  |  #*func                   -2 __xnpod_schedule+0x9 (xnpod_=
suspend_thread+0x82a)
[  135.291553]  |  #*func                   -3 xnpod_suspend_thread+0x9 (xn=
pod_wait_thread_period+0x10f)
[  135.291553]  |  +*begin   0x80000000     -3 xnpod_wait_thread_period+0x2=
3b (rt_task_wait_period+0x34)
[  135.291553]     +*func                   -4 xnpod_wait_thread_period+0x9=
 (rt_task_wait_period+0x34)
[  135.291553]     +*func                   -4 rt_task_wait_period+0x3 (__r=
t_task_wait_period+0x1b)
[  135.291553]     +*func                   -5 __rt_task_wait_period+0xc (h=
isyscall_event+0x174)
[  135.291553]     +*func                   -5 hisyscall_event+0x9 (__ipipe=
_dispatch_event+0x8e)
[  135.291553]  |  +*end     0x80000001     -5 __ipipe_dispatch_event+0x15b=
 (__ipipe_syscall_root+0x48)
[  135.291553]  |  +*begin   0x80000001     -6 __ipipe_dispatch_event+0x1f3=
 (__ipipe_syscall_root+0x48)
[  135.291553]     +*func                   -6 __ipipe_dispatch_event+0x9 (=
__ipipe_syscall_root+0x48)
[  135.291553]     +*func                   -7 __ipipe_syscall_root+0xf (sy=
stem_call+0x2d)
[  135.291553]  |  +*end     0x80000001     -8 __ipipe_syscall_root+0xaa (s=
ystem_call+0x2d)
[  135.291553]  |  +*begin   0x80000001     -9 __ipipe_syscall_root+0xbb (s=
ystem_call+0x2d)
[  135.291553]  |  +*end     0x80000001     -9 __ipipe_dispatch_event+0x1c5=
 (__ipipe_syscall_root+0x48)
[  135.291553]  |  +*begin   0x80000001    -10 __ipipe_dispatch_event+0x16e=
 (__ipipe_syscall_root+0x48)
[  135.291553]  |  +*end     0xffffffcf    -10 common_interrupt+0x40 (__ipi=
pe_restore_pipeline_head+0x54)
[  135.291553]  |  #*[  444] samplin 50    -11 __xnpod_schedule+0x330 (xnin=
tr_clock_handler+0x1e2)
[  135.291553]  |  #*func                  -12 xnsched_pick_next+0x9 (__xnp=
od_schedule+0x98)
[  135.291553]  |  #*[  498] samplin 60    -13 __xnpod_schedule+0x79 (xnpod=
_suspend_thread+0x82a)
[  135.291553]  |  #*func                  -13 __xnpod_schedule+0x9 (xnpod_=
suspend_thread+0x82a)
[  135.291553]  |  #*func                  -14 xnpod_suspend_thread+0x9 (xn=
pod_wait_thread_period+0x10f)
[  135.291553]  |  +*begin   0x80000000    -14 xnpod_wait_thread_period+0x2=
3b (rt_task_wait_period+0x34)
[  135.291553]     +*func                  -14 xnpod_wait_thread_period+0x9=
 (rt_task_wait_period+0x34)
[  135.291553]     +*func                  -15 rt_task_wait_period+0x3 (__r=
t_task_wait_period+0x1b)
[  135.291553]     +*func                  -15 __rt_task_wait_period+0xc (h=
isyscall_event+0x174)
[  135.291553]     +*func                  -16 hisyscall_event+0x9 (__ipipe=
_dispatch_event+0x8e)
[  135.291553]  |  +*end     0x80000001    -16 __ipipe_dispatch_event+0x15b=
 (__ipipe_syscall_root+0x48)
[  135.291553]  |  +*begin   0x80000001    -17 __ipipe_dispatch_event+0x1f3=
 (__ipipe_syscall_root+0x48)
[  135.291553]     +*func                  -17 __ipipe_dispatch_event+0x9 (=
__ipipe_syscall_root+0x48)
[  135.291553]     +*func                  -17 __ipipe_syscall_root+0xf (sy=
stem_call+0x2d)
[  135.291553]  |  +*end     0x80000001    -19 __ipipe_syscall_root+0xaa (s=
ystem_call+0x2d)
[  135.291553]  |  +*begin   0x80000001    -19 __ipipe_syscall_root+0xbb (s=
ystem_call+0x2d)
[  135.291553]  |  +*end     0x80000001    -20 __ipipe_dispatch_event+0x1c5=
 (__ipipe_syscall_root+0x48)
[  135.291553]  |  +*begin   0x80000001    -20 __ipipe_dispatch_event+0x16e=
 (__ipipe_syscall_root+0x48)
[  135.291553]  |  +*end     0x80000000    -21 __ipipe_restore_pipeline_hea=
d+0x52 (xnpod_wait_thread_period+0x20a)
[  135.291553]  |  #*func                  -21 __ipipe_restore_pipeline_hea=
d+0x6 (xnpod_wait_thread_period+0x20a)
[  135.291553]  |  #*func                  -22 xntimer_get_overruns+0xf (xn=
pod_wait_thread_period+0x135)
[  135.291553]  |  #*[  498] samplin 60    -22 __xnpod_schedule+0x330 (xnpo=
d_suspend_thread+0x82a)
[  135.291553]  |  #*func                  -24 xnsched_pick_next+0x9 (__xnp=
od_schedule+0x98)
[  135.291553]  |  #*[  489] samplin 60    -24 __xnpod_schedule+0x79 (xnpod=
_suspend_thread+0x82a)
[  135.291553]  |  #*func                  -24 __xnpod_schedule+0x9 (xnpod_=
suspend_thread+0x82a)
[  135.291553]  |  #*func                  -25 xnpod_suspend_thread+0x9 (xn=
pod_wait_thread_period+0x10f)
[  135.291553]  |  +*begin   0x80000000    -26 xnpod_wait_thread_period+0x2=
3b (rt_task_wait_period+0x34)
[  135.291553]     +*func                  -26 xnpod_wait_thread_period+0x9=
 (rt_task_wait_period+0x34)
[  135.291553]     +*func                  -26 rt_task_wait_period+0x3 (__r=
t_task_wait_period+0x1b)
[  135.291553]     +*func                  -27 __rt_task_wait_period+0xc (h=
isyscall_event+0x174)
[  135.291553]     +*func                  -27 hisyscall_event+0x9 (__ipipe=
_dispatch_event+0x8e)
[  135.291553]  |  +*end     0x80000001    -28 __ipipe_dispatch_event+0x15b=
 (__ipipe_syscall_root+0x48)
[  135.291553]  |  +*begin   0x80000001    -28 __ipipe_dispatch_event+0x1f3=
 (__ipipe_syscall_root+0x48)
[  135.291553]     +*func                  -29 __ipipe_dispatch_event+0x9 (=
__ipipe_syscall_root+0x48)
[  135.291553]     +*func                  -29 __ipipe_syscall_root+0xf (sy=
stem_call+0x2d)
[  135.291553]  |  +*end     0xffffffcf    -31 common_interrupt+0x40 (__ipi=
pe_syscall_root+0x90)
[  135.291553]  |  #*func                  -32 xnsched_pick_next+0x9 (__xnp=
od_schedule+0x98)
[  135.291553]  |  #*[  489] samplin 60    -33 __xnpod_schedule+0x79 (xnint=
r_clock_handler+0x1e2)
[  135.291553]  |  #*func                  -33 __xnpod_schedule+0x9 (xnintr=
_clock_handler+0x1e2)
[  135.291553]  |  #*event   tick@33       -36 xntimer_next_local_shot+0xa3=
 (xntimer_tick_aperiodic+0x65)
[  135.291553]  |  #*func                  -37 xntimer_next_local_shot+0xf =
(xntimer_tick_aperiodic+0x65)
[  135.291553]  |  #*[  498] samplin 60    -39 xnpod_resume_thread+0xe0 (xn=
thread_periodic_handler+0x25)
[  135.291553]  |  #*func                  -39 xnpod_resume_thread+0x9 (xnt=
hread_periodic_handler+0x25)
[  135.291553]  |  #*func                  -39 xnthread_periodic_handler+0x=
3 (xntimer_tick_aperiodic+0x4ad)
[  135.291553]  |  #*func                  -41 xntimer_tick_aperiodic+0x9 (=
xnintr_clock_handler+0xbe)
[  135.291553]  |  #*func                  -41 xnintr_clock_handler+0x9 (__=
ipipe_dispatch_wired_nocheck+0x46)
[  135.291553]  |  +*func                  -42 __ipipe_dispatch_wired_noche=
ck+0x11 (__ipipe_dispatch_wired+0x1b)
[  135.291553]  |  +*func                  -42 __ipipe_dispatch_wired+0x3 (=
__ipipe_handle_irq+0x176)
[  135.291553]  |  #*func                  -42 __ipipe_spin_unlock_irqresto=
re+0x4 (mask_and_ack_8259A+0xe9)
[  135.291553]  |  +*func                  -44 __ipipe_spin_lock_irqsave+0x=
4 (mask_and_ack_8259A+0x22)
[  135.291553]  |  +*func                  -45 mask_and_ack_8259A+0x8 (__ip=
ipe_ack_level_irq+0x24)
[  135.291553]  |  +*func                  -45 __ipipe_ack_level_irq+0xd (_=
_ipipe_ack_irq+0xc)
[  135.291553]  |  +*func                  -45 __ipipe_ack_irq+0x3 (__ipipe=
_handle_irq+0x1bd)
[  135.291553]  |  +*func                  -46 irq_to_desc+0x3 (__ipipe_han=
dle_irq+0x1b7)
[  135.291553]  |  +*func                  -46 __ipipe_handle_irq+0x9 (comm=
on_interrupt+0x36)
[  135.291553]  |  +*begin   0xffffffcf    -47 common_interrupt+0x2f (__ipi=
pe_syscall_root+0x90)
[  135.291553]  |  +*end     0x80000001    -49 __ipipe_syscall_root+0xaa (s=
ystem_call+0x2d)
[  135.291553]  |  +*begin   0x80000001    -50 __ipipe_syscall_root+0xbb (s=
ystem_call+0x2d)
[  135.291553]  |  +*end     0x80000001    -50 __ipipe_dispatch_event+0x1c5=
 (__ipipe_syscall_root+0x48)
[  135.291553]  |  +*begin   0x80000001    -51 __ipipe_dispatch_event+0x16e=
 (__ipipe_syscall_root+0x48)
[  135.291553]  |  +*end     0x80000000    -51 __ipipe_restore_pipeline_hea=
d+0x52 (xnpod_wait_thread_period+0x20a)
[  135.291553]  |  #*func                  -52 __ipipe_restore_pipeline_hea=
d+0x6 (xnpod_wait_thread_period+0x20a)
[  135.291553]  |  #*func                  -52 xntimer_get_overruns+0xf (xn=
pod_wait_thread_period+0x135)
[  135.291553]  |  #*[  489] samplin 60    -53 __xnpod_schedule+0x330 (xnpo=
d_suspend_thread+0x82a)
[  135.291553]  |  #*func                  -54 xnsched_pick_next+0x9 (__xnp=
od_schedule+0x98)
[  135.291553]  |  #*[  495] samplin 60    -54 __xnpod_schedule+0x79 (xnpod=
_suspend_thread+0x82a)
[  135.291553]  |  #*func                  -55 __xnpod_schedule+0x9 (xnpod_=
suspend_thread+0x82a)
[  135.291553]  |  #*func                  -55 xnpod_suspend_thread+0x9 (xn=
pod_wait_thread_period+0x10f)
[  135.291553]  |  +*begin   0x80000000    -56 xnpod_wait_thread_period+0x2=
3b (rt_task_wait_period+0x34)
[  135.291553]     +*func                  -56 xnpod_wait_thread_period+0x9=
 (rt_task_wait_period+0x34)
[  135.291553]     +*func                  -57 rt_task_wait_period+0x3 (__r=
t_task_wait_period+0x1b)
[  135.291553]     +*func                  -57 __rt_task_wait_period+0xc (h=
isyscall_event+0x174)
[  135.291553]     +*func                  -57 hisyscall_event+0x9 (__ipipe=
_dispatch_event+0x8e)
[  135.291553]  |  +*end     0x80000001    -58 __ipipe_dispatch_event+0x15b=
 (__ipipe_syscall_root+0x48)
[  135.291553]  |  +*begin   0x80000001    -58 __ipipe_dispatch_event+0x1f3=
 (__ipipe_syscall_root+0x48)
[  135.291553]     +*func                  -59 __ipipe_dispatch_event+0x9 (=
__ipipe_syscall_root+0x48)
[  135.291553]     +*func                  -59 __ipipe_syscall_root+0xf (sy=
stem_call+0x2d)
[  135.291553]  |  +*end     0x80000001    -60 __ipipe_syscall_root+0xaa (s=
ystem_call+0x2d)
[  135.291553]  |  +*begin   0x80000001    -61 __ipipe_syscall_root+0xbb (s=
ystem_call+0x2d)
[  135.291553] ---[ end trace aa1f0ddc83c57176 ]---
[  135.291553] Kernel panic - not syncing: Fatal exception in interrupt
Aviso legal: Este mensaje y los documentos adjuntos pueden contener informa=
ci?n confidencial. Si usted lo ha recibido por error debe saber que la info=
rmaci?n contenida en el mismo es reservada y su uso no autorizado esta proh=
ibido por la ley, por lo que le rogamos que nos lo comunique por la misma v=
?a y proceda a borrar el mensaje. Legal advice: The contents of this email =
and any attachments may contain confidential information. If you have recei=
ved it by mistake please be aware that the information is private and confi=
dential and as such its non authorised use is legally protected, therefore =
we ask you to contact the sender and delete the message.
