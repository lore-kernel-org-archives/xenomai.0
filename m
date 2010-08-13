From: Hemal C.Bavishi <Hemal.Bavishi@domain.hid>
Date: Fri, 13 Aug 2010 15:58:46 +0530
Message-ID: <E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065789@domain.hid>
References: <76E258664B189C4CBEF125491CA11ECC9458403922@domain.hid>
	<76E258664B189C4CBEF125491CA11ECC9458403925@domain.hid>
	<1281597159.1730.71.camel@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD14F757@domain.hid>,
	<4C642F04.4020008@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065786@domain.hid>,
	<4C651A5D.9030101@domain.hid>,
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065788@domain.hid>
In-Reply-To: <E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065788@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xenomai
 2.5.3 [was: HELP]
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Hemal C.Bavishi" <Hemal.Bavishi@domain.hid>, Stefan Kisdaroczi <kisda@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Stefan,

I have taken the snapshopts of the command prompt and attached below for yo=
ur reference

root@domain.hid:~# update-initramfs -c -k all
update-initramfs: Generating /boot/initrd.img-2.6.32-24-generic
update-initramfs: Generating /boot/initrd.img-2.6.32-21-generic
root@domain.hid:~# update-grub
Generating grub.cfg ...
Found linux image: /boot/vmlinuz-2.6.32.15-xenomai-2.5.4
Found linux image: /boot/vmlinuz-2.6.32-24-generic
Found initrd image: /boot/initrd.img-2.6.32-24-generic
Found linux image: /boot/vmlinuz-2.6.32-21-generic
Found initrd image: /boot/initrd.img-2.6.32-21-generic
Found memtest86+ image: /boot/memtest86+.bin
Found Microsoft Windows XP Professional on /dev/sda1
done
root@domain.hid:~#

Best Regards,
Hemal Bavishi
________________________________________
From: Hemal C.Bavishi
Sent: Friday, August 13, 2010 3:47 PM
To: Stefan Kisdaroczi
Cc: xenomai@xenomai.org
Subject: RE: [Xenomai-help] 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xenomai=
 2.5.3 [was: HELP]

Dear Stefan,

Yes, but even after that it's not generating/showing the initrd entry.

Have a look into the boot log message. This might help you in identifying t=
he cause of an error

Please find below the log message:=3D> from  0.733061 to  0.733630 is the c=
ause of an error

Best Regards,
Hemal Bavishi

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.32.15-xenomai-2.5.4 (root@domain.hid) (gcc ver=
sion 4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #1 SMP Fri Aug 13 05:13:06 CEST 2010
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003f7d0000 (usable)
[    0.000000]  BIOS-e820: 000000003f7d0000 - 000000003f7e5600 (reserved)
[    0.000000]  BIOS-e820: 000000003f7e5600 - 00000003f7f8000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003f7f8000 - 000000003f800000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed20000 - 00000000fed9b000 (reserved)
[    0.000000]  BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000] DMI 2.4 present.
[    0.000000] last_pfn =3D 0x3f7d0 max_arch_pfn =3D 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FC0000000 write-back
[    0.000000]   1 base F3F800000 mask FFF800000 uncachable
[    0.000000]   2 base 0FEDA0000 mask FFFFE0000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] e820 update range: 0000000000002000 - 0000000000006000 (usab=
le) =3D=3D> (reserved)
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000002000 (usable)
[    0.000000]  modified: 0000000000002000 - 0000000000006000 (reserved)
[    0.000000]  modified: 0000000000006000 - 000000000009fc00 (usable)
[    0.000000]  modified: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 000000003f7d0000 (usable)
[    0.000000]  modified: 000000003f7d0000 - 000000003f7e5600 (reserved)
[    0.000000]  modified: 000000003f7e5600 - 000000003f7f8000 (ACPI NVS)
[    0.000000]  modified: 000000003f7f8000 - 000000003f800000 (reserved)
[    0.000000]  modified: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  modified: 00000000fed20000 - 00000000fed9b000 (reserved)
[    0.000000]  modified: 00000000feda0000 - 00000000fedc0000 (reserved)
[    0.000000]  modified: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  modified: 00000000ffb00000 - 00000000ffc00000 (reserved)
[    0.000000]  modified: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000] initial memory mapped : 0 - 00c00000
[    0.000000] init_memory_mapping: 0000000000000000-00000000377fe000
[    0.000000]  0000000000 - 0000400000 page 4k
[    0.000000]  0000400000 - 0037400000 page 2M
[    0.000000]  0037400000 - 00377fe000 page 4k
[    0.000000] kernel direct mapping tables up to 377fe000 @ 7000-c000
[    0.000000] 127MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000]   node 0 low ram: 00000000 - 377fe000
[    0.000000]   node 0 bootmap 00008000 - 0000ef00
[    0.000000] (8 early reservations) =3D=3D> bootmem [0000000000 - 00377fe=
000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [000=
0000000 - 0000001000]
[    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE =3D=3D> [000=
0001000 - 0000002000]
[    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE =3D=3D> [000=
0006000 - 0000007000]
[    0.000000]   #3 [0000100000 - 0000879918]    TEXT DATA BSS =3D=3D> [000=
0100000 - 0000879918]
[    0.000000]   #4 [000009fc00 - 0000100000]    BIOS reserved =3D=3D> [000=
009fc00 - 0000100000]
[    0.000000]   #5 [000087a000 - 000087d160]              BRK =3D=3D> [000=
087a000 - 000087d160]
[    0.000000]   #6 [0000007000 - 0000008000]          PGTABLE =3D=3D> [000=
0007000 - 0000008000]
[    0.000000]   #7 [0000008000 - 000000f000]          BOOTMAP =3D=3D> [000=
0008000 - 000000f000]
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000377fe
[    0.000000]   HighMem  0x000377fe -> 0x0003f7d0
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00000002
[    0.000000]     0: 0x00000006 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0003f7d0
[    0.000000] On node 0 totalpages: 259947
[    0.000000] free_area_init_node: node 0, pgdat c071a720, node_mem_map c1=
001000
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3963 pages, LIFO batch:0
[    0.000000]   Normal zone: 1744 pages used for memmap
[    0.000000]   Normal zone: 221486 pages, LIFO batch:31
[    0.000000]   HighMem zone: 256 pages used for memmap
[    0.000000]   HighMem zone: 32466 pages, LIFO batch:7
[    0.000000] Using APIC driver default
[    0.000000] SFI: Simple Firmware Interface v0.7 http://simplefirmware.or=
g
[    0.000000] SMP: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] Found and enabled local APIC!
[    0.000000] nr_irqs_gsi: 16
[    0.000000] PM: Registered nosave memory: 0000000000002000 - 00000000000=
06000
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 00000000001=
00000
[    0.000000] Allocating PCI resources starting at 3f800000 (gap: 3f800000=
:bf400000)
[    0.000000] NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] PERCPU: Embedded 24 pages/cpu @c1800000 s74904 r0 d23400 u41=
94304
[    0.000000] pcpu-alloc: s74904 r0 d23400 u4194304 alloc=3D1*4194304
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 257915
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-2.6.32.15-xe=
nomai-2.5.4 root=3D/dev/sda7 ro quiet splash
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] allocated 5200960 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t memory cgroups
[    0.000000] Initializing HighMem for node 0 (000377fe:0003f7d0)
[    0.000000] Memory: 1017616k/1040192k available (4374k kernel code, 2180=
4k reserved, 1913k data, 576k init, 130888k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff1e000 - 0xfffff000   ( 900 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
[    0.000000]       .init : 0xc0725000 - 0xc07b5000   ( 576 kB)
[    0.000000]       .data : 0xc0545a6a - 0xc0724088   (1913 kB)
[    0.000000]       .text : 0xc0100000 - 0xc0545a6a   (4374 kB)
[    0.000000] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.000000] SLUB: Genslabs=3D13, HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D1, Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:2304 nr_irqs:256
[    0.000000] I-pipe 2.7-01: pipeline enabled.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1662.492 MHz processor.
[    0.004004] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 3324.98 BogoMIPS (lpj=3D6649968)
[    0.004031] Security Framework initialized
[    0.004038] SELinux:  Disabled at boot.
[    0.004051] Mount-cache hash table entries: 512
[    0.004292] Initializing cgroup subsys ns
[    0.004298] Initializing cgroup subsys cpuacct
[    0.004306] Initializing cgroup subsys memory
[    0.004328] Initializing cgroup subsys devices
[    0.004335] Initializing cgroup subsys freezer
[    0.004339] Initializing cgroup subsys net_cls
[    0.004376] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004382] CPU: L2 cache: 2048K
[    0.004387] CPU: Unsupported number of siblings 2
[    0.004392] mce: CPU supports 6 MCE banks
[    0.004401] CPU0: Thermal monitoring handled by SMI
[    0.004412] Performance Events: Core2 events, Intel PMU driver.
[    0.004435] ... version:                2
[    0.004438] ... bit width:              40
[    0.004442] ... generic registers:      2
[    0.004446] ... value mask:             000000ffffffffff
[    0.004449] ... max period:             000000007fffffff
[    0.004453] ... fixed-purpose events:   3
[    0.004457] ... event mask:             0000000700000003
[    0.004463] Checking 'hlt' instruction... OK.
[    0.021776] SMP alternatives: switching to UP code
[    0.033709] Freeing SMP alternatives: 30k freed
[    0.033723] ftrace: converting mcount calls to 0f 1f 44 00 00
[    0.033729] ftrace: allocating 18962 entries in 38 pages
[    0.050614] Enabling APIC mode:  Flat.  Using 0 I/O APICs
[    0.050619] weird, boot CPU (#0) not listed by the BIOS.
[    0.050622] SMP motherboard not detected.
[    0.156021] SMP disabled
[    0.156181] Brought up 1 CPUs
[    0.156185] Total of 1 processors activated (3324.98 BogoMIPS).
[    0.156710] CPU0 attaching NULL sched-domain.
[    0.156905] devtmpfs: initialized
[    0.160539] HP Compaq Laptop series board detected. Selecting BIOS-metho=
d for reboots.
[    0.165093] regulator: core version 0.5
[    0.165195] Time: 10:44:16  Date: 08/13/10
[    0.165643] NET: Registered protocol family 16
[    0.167041] EISA bus registered
[    0.178158] PCI: PCI BIOS revision 2.10 entry at 0xf0322, last bus=3D32
[    0.178187] PCI: Using configuration type 1 for base access
[    0.188351] bio: create slab <bio-0> at 0
[    0.189418] vgaarb: loaded
[    0.191033] SCSI subsystem initialized
[    0.191374] libata version 3.00 loaded.
[    0.192183] usbcore: registered new interface driver usbfs
[    0.192346] usbcore: registered new interface driver hub
[    0.192611] usbcore: registered new device driver usb
[    0.193808] PCI: Probing PCI hardware
[    0.193836] PCI: Probing PCI hardware (bus 00)
[    0.194592] pci 0000:00:02.0: reg 10 32bit mmio: [0xf4400000-0xf447ffff]=

[    0.194646] pci 0000:00:02.0: reg 14 io port: [0x4000-0x4007]
[    0.194698] pci 0000:00:02.0: reg 18 32bit mmio pref: [0xe0000000-0xefff=
ffff]
[    0.194752] pci 0000:00:02.0: reg 1c 32bit mmio: [0xf4480000-0xf44bffff]=

[    0.195125] pci 0000:00:02.1: reg 10 32bit mmio: [0xf4500000-0xf457ffff]=

[    0.195847] pci 0000:00:1b.0: reg 10 64bit mmio: [0xf4580000-0xf4583fff]=

[    0.196212] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.196254] pci 0000:00:1b.0: PME# disabled
[    0.196690] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.196732] pci 0000:00:1c.0: PME# disabled
[    0.197179] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.197220] pci 0000:00:1c.1: PME# disabled
[    0.197689] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.197731] pci 0000:00:1c.3: PME# disabled
[    0.198045] pci 0000:00:1d.0: reg 20 io port: [0x4020-0x403f]
[    0.198361] pci 0000:00:1d.1: reg 20 io port: [0x4040-0x405f]
[    0.198677] pci 0000:00:1d.2: reg 20 io port: [0x4060-0x407f]
[    0.199010] pci 0000:00:1d.3: reg 20 io port: [0x4080-0x409f]
[    0.199347] pci 0000:00:1d.7: reg 10 32bit mmio: [0xf4584000-0xf45843ff]=

[    0.199651] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.199693] pci 0000:00:1d.7: PME# disabled
[    0.200511] pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
[    0.200560] pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 AC=
PI/GPIO/TCO
[    0.200601] pci 0000:00:1f.0: quirk: region 1100-113f claimed by ICH6 GP=
IO
[    0.200639] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0500 (=
mask 007f)
[    0.200693] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 4 PIO at 0238 (=
mask 0007)
[    0.201008] pci 0000:00:1f.2: reg 10 io port: [0x00-0x07]
[    0.201061] pci 0000:00:1f.2: reg 14 io port: [0x00-0x03]
[    0.201114] pci 0000:00:1f.2: reg 18 io port: [0x00-0x07]
[    0.201168] pci 0000:00:1f.2: reg 1c io port: [0x00-0x03]
[    0.201221] pci 0000:00:1f.2: reg 20 io port: [0x40a0-0x40af]
[    0.201402] pci 0000:00:1f.2: PME# supported from D3hot
[    0.201442] pci 0000:00:1f.2: PME# disabled
[    0.202197] pci 0000:10:00.0: reg 10 32bit mmio: [0xf4000000-0xf4000fff]=

[    0.202699] pci 0000:10:00.0: PME# supported from D0 D3hot D3cold
[    0.202748] pci 0000:10:00.0: PME# disabled
[    0.203149] pci 0000:00:1c.1: bridge 32bit mmio: [0xf4000000-0xf40fffff]=

[    0.203532] pci 0000:00:1c.3: bridge io port: [0x2000-0x3fff]
[    0.203573] pci 0000:00:1c.3: bridge 32bit mmio: [0xf0000000-0xf3ffffff]=

[    0.203875] pci 0000:02:06.0: reg 10 32bit mmio: [0xf4100000-0xf4100fff]=

[    0.204042] pci 0000:02:06.0: supports D1 D2
[    0.204068] pci 0000:02:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.204112] pci 0000:02:06.0: PME# disabled
[    0.204320] pci 0000:02:06.1: reg 10 32bit mmio: [0xf4101000-0xf41017ff]=

[    0.204379] pci 0000:02:06.1: reg 14 32bit mmio: [0xf4104000-0xf4107fff]=

[    0.204642] pci 0000:02:06.1: supports D1 D2
[    0.204668] pci 0000:02:06.1: PME# supported from D0 D1 D2 D3hot
[    0.204710] pci 0000:02:06.1: PME# disabled
[    0.205022] pci 0000:02:0e.0: reg 10 32bit mmio: [0xf4108000-0xf4109fff]=

[    0.205300] pci 0000:02:0e.0: supports D1 D2
[    0.205326] pci 0000:02:0e.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.205368] pci 0000:02:0e.0: PME# disabled
[    0.205570] pci 0000:00:1e.0: transparent bridge
[    0.205621] pci 0000:00:1e.0: bridge 32bit mmio: [0xf4100000-0xf43fffff]=

[    0.206415] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.216128] pci 0000:00:1f.0: PIIX/ICH IRQ router [8086:27b9]
[    0.218207] NetLabel: Initializing
[    0.218229] NetLabel:  domain hash size =3D 128
[    0.218253] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.218426] NetLabel:  unlabeled traffic allowed by default
[    0.218878] hpet clockevent registered
[    0.218907] HPET: 3 timers in total, 0 timers will be used for per-cpu t=
imer
[    0.220278] Switching to clocksource tsc
[    0.250468] PnPBIOS: Scanning system for PnP BIOS support...
[    0.250505] PnPBIOS: Found PnP BIOS installation structure at 0xc00f5e10=

[    0.250535] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x5e3e, dseg 0x=
f0000
[    0.254705] pnp 00:0e: io resource (0x1100-0x112f) overlaps 0000:00:1f.0=
 BAR 14 (0x1100-0x113f), disabling
[    0.255034] PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by drive=
r
[    0.255141] system 00:02: iomem range 0x0-0x9ffff could not be reserved
[    0.255185] system 00:02: iomem range 0xe0000-0xfffff could not be reser=
ved
[    0.255229] system 00:02: iomem range 0x100000-0x3f7fffff could not be r=
eserved
[    0.255336] system 00:0e: ioport range 0x510-0x51f has been reserved
[    0.255374] system 00:0e: ioport range 0x4d0-0x4d1 has been reserved
[    0.255412] system 00:0e: ioport range 0x1000-0x107f has been reserved
[    0.255453] system 00:0e: ioport range 0x1200-0x121f has been reserved
[    0.255549] system 00:0e: iomem range 0xfff0000-0x100effff could not be =
reserved
[    0.255594] system 00:0e: iomem range 0xffb0000-0x100b03ff could not be =
reserved
[    0.257966] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:08
[    0.258002] pci 0000:00:1c.0:   IO window: 0x5000-0x5fff
[    0.258048] pci 0000:00:1c.0:   MEM window: 0x44000000-0x441fffff
[    0.258090] pci 0000:00:1c.0:   PREFETCH window: 0x00000044200000-0x0000=
00443fffff
[    0.258147] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:10
[    0.258182] pci 0000:00:1c.1:   IO window: 0x6000-0x6fff
[    0.258228] pci 0000:00:1c.1:   MEM window: 0xf4000000-0xf40fffff
[    0.258270] pci 0000:00:1c.1:   PREFETCH window: 0x00000044400000-0x0000=
00445fffff
[    0.258327] pci 0000:00:1c.3: PCI bridge, secondary bus 0000:20
[    0.258362] pci 0000:00:1c.3:   IO window: 0x2000-0x3fff
[    0.258408] pci 0000:00:1c.3:   MEM window: 0xf0000000-0xf3ffffff
[    0.258449] pci 0000:00:1c.3:   PREFETCH window: 0x00000044600000-0x0000=
00447fffff
[    0.258543] pci 0000:02:06.0: CardBus bridge, secondary bus 0000:03
[    0.258572] pci 0000:02:06.0:   IO window: 0x007000-0x0070ff
[    0.258612] pci 0000:02:06.0:   IO window: 0x007400-0x0074ff
[    0.258654] pci 0000:02:06.0:   PREFETCH window: 0x40000000-0x43ffffff
[    0.258697] pci 0000:02:06.0:   MEM window: 0x48000000-0x4bffffff
[    0.258738] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:02
[    0.258773] pci 0000:00:1e.0:   IO window: 0x7000-0x7fff
[    0.258819] pci 0000:00:1e.0:   MEM window: 0xf4100000-0xf43fffff
[    0.258860] pci 0000:00:1e.0:   PREFETCH window: 0x40000000-0x43ffffff
[    0.258965] PCI: setting IRQ 10 as level-triggered
[    0.258993] pci 0000:00:1c.0: found PCI INT A -> IRQ 10
[    0.259049] pci 0000:00:1c.0: sharing IRQ 10 with 0000:00:02.0
[    0.259342] pci 0000:00:1c.0: sharing IRQ 10 with 0000:02:0e.0
[    0.259393] pci 0000:00:1c.0: setting latency timer to 64
[    0.259545] PCI: setting IRQ 11 as level-triggered
[    0.259573] pci 0000:00:1c.1: found PCI INT B -> IRQ 11
[    0.259735] pci 0000:00:1c.1: sharing IRQ 11 with 0000:00:1d.1
[    0.259856] pci 0000:00:1c.1: sharing IRQ 11 with 0000:00:1f.2
[    0.259904] pci 0000:00:1c.1: sharing IRQ 11 with 0000:10:00.0
[    0.260000] pci 0000:00:1c.1: setting latency timer to 64
[    0.260082] pci 0000:00:1c.3: found PCI INT D -> IRQ 10
[    0.260275] pci 0000:00:1c.3: sharing IRQ 10 with 0000:00:1d.3
[    0.260415] pci 0000:00:1c.3: sharing IRQ 10 with 0000:02:06.1
[    0.260480] pci 0000:00:1c.3: setting latency timer to 64
[    0.260542] pci 0000:00:1e.0: setting latency timer to 64
[    0.260626] pci 0000:02:06.0: found PCI INT A -> IRQ 11
[    0.260803] pci 0000:02:06.0: sharing IRQ 11 with 0000:00:1d.2
[    0.260999] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.261028] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
[    0.261058] pci_bus 0000:08: resource 0 io:  [0x5000-0x5fff]
[    0.261087] pci_bus 0000:08: resource 1 mem: [0x44000000-0x441fffff]
[    0.261117] pci_bus 0000:08: resource 2 pref mem [0x44200000-0x443fffff]=

[    0.261148] pci_bus 0000:10: resource 0 io:  [0x6000-0x6fff]
[    0.261177] pci_bus 0000:10: resource 1 mem: [0xf4000000-0xf40fffff]
[    0.261207] pci_bus 0000:10: resource 2 pref mem [0x44400000-0x445fffff]=

[    0.261238] pci_bus 0000:20: resource 0 io:  [0x2000-0x3fff]
[    0.261266] pci_bus 0000:20: resource 1 mem: [0xf0000000-0xf3ffffff]
[    0.261297] pci_bus 0000:20: resource 2 pref mem [0x44600000-0x447fffff]=

[    0.261328] pci_bus 0000:02: resource 0 io:  [0x7000-0x7fff]
[    0.261356] pci_bus 0000:02: resource 1 mem: [0xf4100000-0xf43fffff]
[    0.261386] pci_bus 0000:02: resource 2 pref mem [0x40000000-0x43ffffff]=

[    0.261417] pci_bus 0000:02: resource 3 io:  [0x00-0xffff]
[    0.261445] pci_bus 0000:02: resource 4 mem: [0x000000-0xffffffff]
[    0.261475] pci_bus 0000:03: resource 0 io:  [0x7000-0x70ff]
[    0.261503] pci_bus 0000:03: resource 1 io:  [0x7400-0x74ff]
[    0.261531] pci_bus 0000:03: resource 2 pref mem [0x40000000-0x43ffffff]=

[    0.261562] pci_bus 0000:03: resource 3 mem: [0x48000000-0x4bffffff]
[    0.261807] NET: Registered protocol family 2
[    0.262524] IP route cache hash table entries: 32768 (order: 5, 131072 b=
ytes)
[    0.265051] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes)
[    0.265671] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.266013] TCP: Hash tables configured (established 131072 bind 65536)
[    0.266043] TCP reno registered
[    0.266656] NET: Registered protocol family 1
[    0.266806] pci 0000:00:02.0: Boot video device
[    0.285382] Scanning for low memory corruption every 60 seconds
[    0.286214] audit: initializing netlink socket (disabled)
[    0.286314] type=3D2000 audit(1281696256.283:1): initialized
[    0.315615] highmem bounce pool size: 64 pages
[    0.315666] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.339069] VFS: Disk quotas dquot_6.5.2
[    0.339793] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.348440] fuse init (API version 7.13)
[    0.349611] msgmni has been set to 1732
[    0.351566] alg: No test for stdrng (krng)
[    0.352261] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    0.352294] io scheduler noop registered
[    0.352319] io scheduler anticipatory registered
[    0.352345] io scheduler deadline registered
[    0.352921] io scheduler cfq registered (default)
[    0.354259]   alloc irq_desc for 16 on node -1
[    0.354279]   alloc kstat_irqs on node -1
[    0.354346] pcieport 0000:00:1c.0: irq 16 for MSI/MSI-X
[    0.354414] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.355284]   alloc irq_desc for 17 on node -1
[    0.355304]   alloc kstat_irqs on node -1
[    0.355367] pcieport 0000:00:1c.1: irq 17 for MSI/MSI-X
[    0.355434] pcieport 0000:00:1c.1: setting latency timer to 64
[    0.356393]   alloc irq_desc for 18 on node -1
[    0.356413]   alloc kstat_irqs on node -1
[    0.356476] pcieport 0000:00:1c.3: irq 18 for MSI/MSI-X
[    0.356543] pcieport 0000:00:1c.3: setting latency timer to 64
[    0.357256] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.357550] pciehp 0000:00:1c.0:pcie04: HPC vendor_id 8086 device_id 27d=
0 ss_vid 0 ss_did 0
[    0.357928] pciehp 0000:00:1c.0:pcie04: service driver pciehp loaded
[    0.358066] pciehp 0000:00:1c.1:pcie04: HPC vendor_id 8086 device_id 27d=
2 ss_vid 0 ss_did 0
[    0.358441] pciehp 0000:00:1c.1:pcie04: service driver pciehp loaded
[    0.358580] pciehp 0000:00:1c.3:pcie04: HPC vendor_id 8086 device_id 27d=
6 ss_vid 0 ss_did 0
[    0.358936] pciehp 0000:00:1c.3:pcie04: service driver pciehp loaded
[    0.359039] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.359908] isapnp: Scanning for PnP cards...
[    0.714717] isapnp: No Plug & Play device found
[    0.730152] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.733061] PNPBIOS fault.. attempting recovery.
[    0.733149] PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attemp=
ting to continue
[    0.733249] PnPBIOS: You may need to reboot with the "pnpbios=3Doff" opt=
ion to operate stably
[    0.733349] PnPBIOS: Check with your vendor for an updated BIOS
[    0.733438] PnPBIOS: set_dev_node: unexpected status 0x3a
[    0.733526] serial 00:0c: activation failed
[    0.733630] serial: probe of 00:0c failed with error -5
[    0.747330] brd: module loaded
[    0.753851] loop: module loaded
[    0.754858] input: Macintosh mouse button emulation as /devices/virtual/=
input/input0
[    0.755777] ata_piix 0000:00:1f.2: version 2.13
[    0.755870] ata_piix 0000:00:1f.2: found PCI INT B -> IRQ 11
[    0.756034] ata_piix 0000:00:1f.2: sharing IRQ 11 with 0000:00:1d.1
[    0.756175] ata_piix 0000:00:1f.2: sharing IRQ 11 with 0000:10:00.0
[    0.756279] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[    0.756559] ata_piix 0000:00:1f.2: setting latency timer to 64
[    0.756928] scsi0 : ata_piix
[    0.757732] scsi1 : ata_piix
[    0.758230] ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x40a0 irq=
 14
[    0.758263] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x40a8 irq=
 15
[    0.762500] Fixed MDIO Bus: probed
[    0.762921] PPP generic driver version 2.4.2
[    0.763347] tun: Universal TUN/TAP device driver, 1.6
[    0.763373] tun: (C) 1999-2004 Max Krasnyansky <maxk@domain.hid>
[    0.765124] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.765283] ehci_hcd 0000:00:1d.7: found PCI INT A -> IRQ 10
[    0.765432] ehci_hcd 0000:00:1d.7: sharing IRQ 10 with 0000:00:1d.0
[    0.765688] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    0.765725] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    0.766091] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus =
number 1
[    0.766200] ehci_hcd 0000:00:1d.7: using broken periodic workaround
[    0.766270] ehci_hcd 0000:00:1d.7: debug port 1
[    0.770206] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supporte=
d
[    0.770272] ehci_hcd 0000:00:1d.7: irq 10, io mem 0xf4584000
[    0.783542] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.784637] usb usb1: configuration #1 chosen from 1 choice
[    0.784949] hub 1-0:1.0: USB hub found
[    0.785057] hub 1-0:1.0: 8 ports detected
[    0.785873] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.786033] uhci_hcd: USB Universal Host Controller Interface driver
[    0.786266] uhci_hcd 0000:00:1d.0: found PCI INT A -> IRQ 10
[    0.786476] uhci_hcd 0000:00:1d.0: sharing IRQ 10 with 0000:00:1d.7
[    0.786648] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    0.786682] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.787035] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus =
number 2
[    0.787140] uhci_hcd 0000:00:1d.0: irq 10, io base 0x00004020
[    0.788265] usb usb2: configuration #1 chosen from 1 choice
[    0.788571] hub 2-0:1.0: USB hub found
[    0.788646] hub 2-0:1.0: 2 ports detected
[    0.789195] uhci_hcd 0000:00:1d.1: found PCI INT B -> IRQ 11
[    0.789450] uhci_hcd 0000:00:1d.1: sharing IRQ 11 with 0000:00:1f.2
[    0.789499] uhci_hcd 0000:00:1d.1: sharing IRQ 11 with 0000:10:00.0
[    0.789605] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    0.789640] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.790013] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus =
number 3
[    0.790121] uhci_hcd 0000:00:1d.1: irq 11, io base 0x00004040
[    0.791341] usb usb3: configuration #1 chosen from 1 choice
[    0.791702] hub 3-0:1.0: USB hub found
[    0.791788] hub 3-0:1.0: 2 ports detected
[    0.792332] uhci_hcd 0000:00:1d.2: found PCI INT C -> IRQ 11
[    0.792623] uhci_hcd 0000:00:1d.2: sharing IRQ 11 with 0000:02:06.0
[    0.792714] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    0.792749] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.793135] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus =
number 4
[    0.793237] uhci_hcd 0000:00:1d.2: irq 11, io base 0x00004060
[    0.794306] usb usb4: configuration #1 chosen from 1 choice
[    0.794613] hub 4-0:1.0: USB hub found
[    0.794698] hub 4-0:1.0: 2 ports detected
[    0.795254] uhci_hcd 0000:00:1d.3: found PCI INT D -> IRQ 10
[    0.795602] uhci_hcd 0000:00:1d.3: sharing IRQ 10 with 0000:02:06.1
[    0.795677] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[    0.795712] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    0.796094] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus =
number 5
[    0.796197] uhci_hcd 0000:00:1d.3: irq 10, io base 0x00004080
[    0.797271] usb usb5: configuration #1 chosen from 1 choice
[    0.797578] hub 5-0:1.0: USB hub found
[    0.797652] hub 5-0:1.0: 2 ports detected
[    0.798685] PNP: PS/2 Controller [PNP0303,PNP0f0e] at 0x60,0x64 irq 1,12=

[    0.800563] i8042.c: Detected active multiplexing controller, rev 1.1.
[    0.801344] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.801393] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    0.801680] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    0.801961] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    0.802241] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    0.803611] mice: PS/2 mouse device common for all mice
[    0.804657] rtc_cmos 00:08: rtc core: registered rtc_cmos as rtc0
[    0.804760] rtc0: alarms up to one day, 114 bytes nvram, hpet irqs
[    0.806135] device-mapper: uevent: version 1.0.3
[    0.807080] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised:=
 dm-devel@domain.hid
[    0.807711] device-mapper: multipath: version 1.1.0 loaded
[    0.807743] device-mapper: multipath round-robin: version 1.0.0 loaded
[    0.809050] EISA: Probing bus 0 at eisa.0
[    0.809088] Cannot allocate resource for EISA slot 1
[    0.809119] Cannot allocate resource for EISA slot 2
[    0.809151] Cannot allocate resource for EISA slot 3
[    0.809182] Cannot allocate resource for EISA slot 4
[    0.809213] Cannot allocate resource for EISA slot 5
[    0.809245] Cannot allocate resource for EISA slot 6
[    0.809277] Cannot allocate resource for EISA slot 7
[    0.809317] EISA: Detected 0 cards.
[    0.809342] cpuidle: using governor ladder
[    0.809368] cpuidle: using governor menu
[    0.813509] TCP cubic registered
[    0.815858] NET: Registered protocol family 10
[    0.820035] lo: Disabled Privacy Extensions
[    0.823053] NET: Registered protocol family 17
[    0.823297] Using IPI No-Shortcut mode
[    0.824045] PM: Resume from disk failed.
[    0.824159] registered taskstats version 1
[    0.825746] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    0.827450]   Magic number: 6:731:729
[    0.827607] rtc_cmos 00:08: setting system clock to 2010-08-13 10:44:17 =
UTC (1281696257)
[    0.827642] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    0.827669] EDD information not available.
[    0.928041] ata1.00: ATA-7: ST9120821AS, 7.24, max UDMA/100
[    0.928070] ata1.00: 234441648 sectors, multi 16: LBA48
[    0.944139] ata1.00: configured for UDMA/100
[    0.944856] scsi 0:0:0:0: Direct-Access     ATA      ST9120821AS      7.=
24 PQ: 0 ANSI: 5
[    0.946413] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    0.947296] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB=
/111 GiB)
[    0.948027] sd 0:0:0:0: [sda] Write Protect is off
[    0.948054] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.948405] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.950288]  sda:
[    0.952059] ata2.00: ATAPI: TSSTcorpCD/DVDW TS-L632D, HH15, max MWDMA2
[    0.963263]  sda1 sda2 < sda5
[    0.984257] ata2.00: configured for MWDMA2
[    1.001265]  sda6
[    1.008348] scsi 1:0:0:0: CD-ROM            TSSTcorp CD/DVDW TS-L632D HH=
15 PQ: 0 ANSI: 5
[    1.018801]  sda7 sda8 > sda4
[    1.032705] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.064122] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 =
cdda tray
[    1.064157] Uniform CD-ROM driver Revision: 3.20
[    1.065092] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    1.065577] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    1.066036] md: Waiting for all devices to be available before autodetec=
t
[    1.066066] md: If you don't use raid, use raid=3Dnoautodetect
[    1.067116] md: Autodetecting RAID arrays.
[    1.067139] md: Scanned 0 and added 0 devices.
[    1.067163] md: autorun ...
[    1.067183] md: ... autorun DONE.
[    1.079159] EXT3-fs: sda7: couldn't mount because of unsupported optiona=
l features (240).
[    1.079861] EXT2-fs: sda7: couldn't mount because of unsupported optiona=
l features (240).
[    1.117183] EXT4-fs (sda7): mounted filesystem with ordered data mode
[    1.117275] VFS: Mounted root (ext4 filesystem) readonly on device 8:7.
[    1.149050] devtmpfs: mounted
[    1.149156] Freeing unused kernel memory: 576k freed
[    1.150462] Write protecting the kernel text: 4376k
[    1.150673] Write protecting the kernel read-only data: 1652k
[    1.384116] usb 2-1: new full speed USB device using uhci_hcd and addres=
s 2
[    1.559019] usb 2-1: configuration #1 chosen from 1 choice
[   14.117475] udev: starting version 151
[   16.541624] Bluetooth: Core ver 2.15
[   16.548839] NET: Registered protocol family 31
[   16.548865] Bluetooth: HCI device and connection manager initialized
[   16.548898] Bluetooth: HCI socket layer initialized
[   16.597897] Linux agpgart interface v0.103
[   17.301293] cfg80211: Calling CRDA to update world regulatory domain
[   17.359736] cfg80211: World regulatory domain updated:
[   17.359764]   (start_freq - end_freq @ bandwidth), (max_antenna_gain, ma=
x_eirp)
[   17.359796]   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mB=
m)
[   17.359826]   (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mB=
m)
[   17.359856]   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mB=
m)
[   17.359886]   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mB=
m)
[   17.359916]   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mB=
m)
[   17.495622] intel_rng: FWH not detected
[   17.923552] Adding 868344k swap on /dev/sda8.  Priority:-1 extents:1 acr=
oss:868344k
[   18.031670] Bluetooth: Generic Bluetooth USB driver ver 0.6
[   18.047791] usbcore: registered new interface driver btusb
[   18.242939] lp: driver loaded but no devices found
[   18.913379] [drm] Initialized drm 1.1.0 20060810
[   18.966658] ohci1394 0000:02:06.1: found PCI INT B -> IRQ 10
[   18.967646] ohci1394 0000:02:06.1: sharing IRQ 10 with 0000:00:1d.3
[   19.090509] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[10]  MMIO=3D=
[f4101000-f41017ff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/8]
[   19.111576] agpgart-intel 0000:00:00.0: Intel 945GM Chipset
[   19.112679] agpgart-intel 0000:00:00.0: detected 7932K stolen memory
[   19.124084] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe000000=
0
[   19.314419] b44 0000:02:0e.0: found PCI INT A -> IRQ 10
[   19.314479] b44 0000:02:0e.0: sharing IRQ 10 with 0000:00:02.0
[   19.392470] ssb: Sonics Silicon Backplane found on PCI device 0000:02:0e=
.0
[   19.392719] b44.c:v2.0
[   19.393532] yenta_cardbus 0000:02:06.0: CardBus bridge found [103c:30a2]=

[   19.393625] yenta_cardbus 0000:02:06.0: Enabling burst memory read trans=
actions
[   19.393670] yenta_cardbus 0000:02:06.0: Using INTVAL to route CSC interr=
upts to PCI
[   19.393702] yenta_cardbus 0000:02:06.0: Routing CardBus interrupts to PC=
I
[   19.393746] yenta_cardbus 0000:02:06.0: TI: mfunc 0x01011b22, devctl 0x6=
4
[   19.418601] eth0: Broadcom 44xx/47xx 10/100BaseT Ethernet 00:17:08:44:85=
:c9
[   19.972881] yenta_cardbus 0000:02:06.0: ISA IRQ mask 0x02f8, PCI irq 11
[   19.972915] yenta_cardbus 0000:02:06.0: Socket status: 30000006
[   19.972945] pci_bus 0000:02: Raising subordinate bus# of parent bus (#02=
) from #03 to #06
[   19.973004] yenta_cardbus 0000:02:06.0: pcmcia: parent PCI bridge I/O wi=
ndow: 0x7000 - 0x7fff
[   19.973044] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x7000-0x7ff=
f: clean.
[   19.979459] yenta_cardbus 0000:02:06.0: pcmcia: parent PCI bridge Memory=
 window: 0xf4100000 - 0xf43fffff
[   19.979500] yenta_cardbus 0000:02:06.0: pcmcia: parent PCI bridge Memory=
 window: 0x40000000 - 0x43ffffff
[   20.319501] i915 0000:00:02.0: found PCI INT A -> IRQ 10
[   20.319828] i915 0000:00:02.0: sharing IRQ 10 with 0000:02:0e.0
[   20.319884] i915 0000:00:02.0: setting latency timer to 64
[   20.413244] [drm] set up 7M of stolen space
[   20.434230] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x2580b1, caps: 0=
xa04793/0x300000
[   20.434270] serio: Synaptics pass-through port at isa0060/serio4/input0
[   20.581134] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042=
/serio4/input/input2
[   21.829040] [drm] TV-14: set mode NTSC 480i 0
[   22.363069] fb0: inteldrmfb frame buffer device
[   22.363094] registered panic notifier
[   22.363131] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on mi=
nor 0
[   22.578973] iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection=
 driver for Linux, 1.2.26ks
[   22.579011] iwl3945: Copyright(c) 2003-2009 Intel Corporation
[   22.579278] iwl3945 0000:10:00.0: found PCI INT A -> IRQ 11
[   22.579443] iwl3945 0000:10:00.0: sharing IRQ 11 with 0000:00:1d.1
[   22.579565] iwl3945 0000:10:00.0: sharing IRQ 11 with 0000:00:1f.2
[   22.579691] iwl3945 0000:10:00.0: setting latency timer to 64
[   22.844631] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x100-0x3af:=
 excluding 0x378-0x37f
[   22.867012] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x3e0-0x4ff:=
 clean.
[   22.875426] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x820-0x8ff:=
 clean.
[   22.876934] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xc00-0xcf7:=
 clean.
[   22.879357] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xa00-0xaff:=
 clean.
[   22.931022] iwl3945 0000:10:00.0: Tunable channels: 13 802.11bg, 23 802.=
11a channels
[   22.931057] iwl3945 0000:10:00.0: Detected Intel Wireless WiFi Link 3945=
ABG
[   22.931300]   alloc irq_desc for 19 on node -1
[   22.931320]   alloc kstat_irqs on node -1
[   22.931413] iwl3945 0000:10:00.0: irq 19 for MSI/MSI-X
[   23.243428] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   23.532590] phy0: Selected rate control algorithm 'iwl-3945-rs'
[   23.745904] Console: switching to colour frame buffer device 160x50
[   23.899375] iwl3945 0000:10:00.0: firmware: requesting iwlwifi-3945-2.uc=
ode
[   23.927454] [drm] LVDS-8: set mode 1280x800 1d
[   24.061337] iwl3945 0000:10:00.0: loaded firmware version 15.32.2.9
[   24.279574] Registered led device: iwl-phy0::radio
[   24.279896] Registered led device: iwl-phy0::assoc
[   24.280214] Registered led device: iwl-phy0::RX
[   24.280432] Registered led device: iwl-phy0::TX
[   24.290038] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   25.118551] [drm] TV-14: set mode NTSC 480i 0
[   25.628049] [drm] TV-14: set mode NTSC 480i 0
[   26.626083] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   27.200237] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.=
0/input/input3
[   28.011762] [drm] TV-14: set mode NTSC 480i 0
[   28.163207] [drm] TV-14: set mode NTSC 480i 0
[   28.474828] [drm] TV-14: set mode NTSC 480i 0
[   28.626344] [drm] TV-14: set mode NTSC 480i 0
[   31.083342] [drm] TV-14: set mode NTSC 480i 0
[   31.235415] [drm] TV-14: set mode NTSC 480i 0
[   31.541119] [drm] TV-14: set mode NTSC 480i 0
[   31.693094] [drm] TV-14: set mode NTSC 480i 0
[   32.000795] [drm] TV-14: set mode NTSC 480i 0
[   32.153251] [drm] TV-14: set mode NTSC 480i 0
[   37.533439] [drm] TV-14: set mode NTSC 480i 0
[   38.105040] [drm] TV-14: set mode NTSC 480i 0
[   41.746799] [drm] TV-14: set mode NTSC 480i 0
[   41.975840] [drm] TV-14: set mode NTSC 480i 0
[   48.186196] Bluetooth: L2CAP ver 2.14
[   48.186221] Bluetooth: L2CAP socket layer initialized
[   48.295042] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   48.295071] Bluetooth: BNEP filters: protocol multicast
[   48.369171] ppdev: user-space parallel port driver
[   48.748320] Bridge firewalling registered
[   48.962700] Bluetooth: SCO (Voice Link) ver 0.6
[   48.962727] Bluetooth: SCO socket layer initialized
[   49.311784] Bluetooth: RFCOMM TTY layer initialized
[   49.311824] Bluetooth: RFCOMM socket layer initialized
[   49.311850] Bluetooth: RFCOMM ver 1.11
[   53.953351] wlan0: direct probe to AP 00:25:5e:73:f1:11 (try 1)
[   53.953443] wlan0: deauthenticating from 00:25:5e:73:f1:11 by local choi=
ce (reason=3D3)
[   53.953621] wlan0: direct probe to AP 00:25:5e:73:f1:11 (try 1)
[   53.956650] wlan0: direct probe responded
[   53.956675] wlan0: authenticate with AP 00:25:5e:73:f1:11 (try 1)
[   53.963252] wlan0: authenticated
[   53.963501] wlan0: associate with AP 00:25:5e:73:f1:11 (try 1)
[   53.966296] wlan0: RX AssocResp from 00:25:5e:73:f1:11 (capab=3D0x11 sta=
tus=3D0 aid=3D1)
[   53.966329] wlan0: associated
[   53.973133] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   55.134407] padlock: VIA PadLock not detected.
[   64.064033] wlan0: no IPv6 routers present



________________________________________
From: Stefan Kisdaroczi [kisda@domain.hid]
Sent: Friday, August 13, 2010 3:41 PM
To: Hemal C.Bavishi
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xenomai=
 2.5.3 [was: HELP]

On 13.08.2010 09:43, Hemal C.Bavishi wrote:
> Dear Stefan,
>
> Thank you very much for your response and showing your interest in resolv=
ing this issue. We tried building debian package to install xenomai as sugg=
ested by you and followed the same steps as described but it hangs up after=
 reboot. After some initial analysis, I found that it's not generating init=
rd entry in boot kernel despite of upddate -initramfs -c -k all command. Do=
 you have any clue?
>

Did you call update-grub after update-initramfs?

Stefan

> Thanks,
>
> Best Regards,
> Hemal Bavishi
> ________________________________________
> From: xenomai-help-bounces@domain.hid [xenomai-help-bounces@domain.hid] On Beha=
lf Of Stefan Kisdaroczi [kisda@domain.hid]
> Sent: Thursday, August 12, 2010 10:57 PM
> To: xenomai@xenomai.org; Zafar Iqbal
> Subject: Re: [Xenomai-help] 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xenom=
ai 2.5.3 [was: HELP]
>
> Hi,
>
> to build and install Xenomai on Ubuntu try the "Building Debian packages"=
 howto [1].
> You need probably to call update-initramfs as mentioned here [2].
>
> Please use exactly the xenomai and kernel versions as described in the ho=
wto.
>
> Regards Stefan
>
> [1] http://www.xenomai.org/index.php/Building_Debian_packages
> [2] http://www.mail-archive.com/xenomai@xenomai.org
>
> Am 12.08.2010 17:40, schrieb Hemal C.Bavishi:
>
>> Dear Mr. Gerum,
>>
>>
>>
>> We have followed following steps to install xenomai patch on UBUNTU. Aft=
er repeated attempt in multiple system, still we are facing
>> same issues.
>>
>>
>>
>> We have used following version for installing xenomai patch on UBUNTU
>>
>>
>>
>> 1. linux Kernel: linux-2.6.32.18
>>
>> 2. Xenomai patch: xenomai-2.5.4
>>
>> 3. Operating System: UBUNTU 10.04
>>
>>
>>
>>
>>
>> Following Steps have been followed to install xenomai patch on UBUNTU:
>>
>>
>>
>> 1. Copied the linux tar file into /usr/src
>>
>> 2. Copied the xenomai tar file into /usr/src
>>
>> 3. untar the linux and xenomai file
>>
>> 4. cd /usr/src/xenomai-2.2.0/scripts/prepare-kernal.sh and appropriate l=
inux directory, architecture(i686) and adeos path were given
>>
>> 5. Make a copy of the .config file of the running kernel in the present =
directory.
>>
>> 6. Next ran make menuconfig and made the following changes:
>>
>>
>>
>> I.          Selected Processor and feature -> Preemption Mode
>>
>> II.         Power Management option
>>
>>             a. Disabled ACPI.
>>
>>             b. Disabled Frequency Scaling
>>
>> 7. Build the Kernel(make command)
>>
>> 8. copying the image of the kernel to the boot folder
>>
>>     cp arch/x86/boot/bzImage /boot/vmlinuz-2.6.32.18-xenomai-2.5.4
>>
>> 9. At last, I tried to reboot the system in the new kernel image and fou=
nd the following issues:
>>
>>
>>
>>
>>
>> dev_node is not supported in this system.
>>
>> IO APIC#0 ID is already in use.
>>
>> PnBIOS: Unable to get nod information.
>>
>> Sdb1 could not mount because of the unsupported optional Feature.
>>
>>
>>
>>
>>
>> Best Regards,
>>
>> Hemal Bavishi
>>
>> Principal Engineer
>>
>>
>>
>> KPIT Infosystems GmbH | Franziska - Bilek - Weg 9 | 80339 Munich
>>
>> Phone: +49(0) 89 45 23 5 83 - 06 | Mobile: +49 162 426 9950 | Fax: +49 (=
0) 89 45 23 5 83 - 07
>>
>>  http://www.kpitcummins.com <http://www.kpitcummins.com/>| mailto:Hemal.=
Bavishi@domain.hid
>>
>> _Frankfurt Branch Office_:
>> KPIT Infosystems GmbH | Mainzer Landstrasse 176 | 60327 Frankfurt | Germ=
any
>>
>> Gesch?ftsf?hrer/Managing Director: Sanjay Mandal
>> Handelsregister/Commercial Register: M?nchen/Munich HRB 163288
>> Sitz der Gesellschaft/Place of Business: M?nchen/Munich | Umsatzsteuernu=
mmer/VAT Number: DE251280557
>>
>> Disclaimer: This message contains information that may be privileged or =
confidential and is the property of KPIT Cummins. It is
>> intended only for the person to whom it is addressed. If you are not the=
 intended recipient, you are not authorized to read, print,
>> retain copy, disseminate, distribute, or use this message or any part th=
ereof. If you receive this message in error, please notify
>> the sender immediately and delete all copies of this message. KPIT Cummi=
ns does not accept any liability for virus infected mails.
>>
>> *P** **Please consider the impact on the environment before printing thi=
s e-mail*
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> -----Original Message-----
>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>> Sent: Thursday, August 12, 2010 9:13 AM
>> To: Zafar Iqbal
>> Cc: Hemal C.Bavishi; Xenomai-help@domain.hid
>> Subject: Re: 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xenomai 2.5.3 [was:=
 HELP]
>>
>>
>>
>> On Thu, 2010-08-12 at 11:46 +0530, Zafar Iqbal wrote:
>>
>>
>>> Dear Sir,
>>>
>>
>>>
>>
>>>
>>
>>> I am Using Ubuntu 10.4 in my system with kernel version 2.6.32.18.
>>>
>>
>>> I downloaded xenomai-2.5.3 and ptached into linux-2.6.32.18 after that =
I compiled the whole kenel.using make.
>>>
>>
>>> After that I made the image of the compiled kernel : make bzImage
>>>
>>
>>> then copied the image to the location as in the boot folder with the fo=
llowing command cp arch/x86/boot/bzImage
>>>
>> /boot/vmlinuz-2.6.32.18-xenomai-2.5.3
>>
>>
>>> then I updated my GRUB with the command update-grub.
>>>
>>
>>>
>>
>>> When I Tried to reboot the System with the Xenomai patched Kernel my sy=
stem hanged up and it is not able to boot with the new
>>>
>> kernel image.
>>
>>
>>>
>>
>>> Can you please suggest whats the wrong here.
>>>
>>
>>
>> A few hints:
>>
>>
>>
>> - that question from mainstream x86 distro users is definitely a FAQ on
>>
>> our mailing list. Did you have a look at the mailing list archive, to
>>
>> find common answers to this problem?
>>
>> https://mail.gna.org/public/xenomai-help/
>>
>>
>>
>> - Did you read the TROUBLESHOOTING file at the top of the Xenomai tree
>>
>> and on our website?
>>
>> http://www.xenomai.org/documentation/xenomai-2.5/TROUBLESHOOTING
>>
>>
>>
>> - Did you read this FAQ?
>>
>> http://www.xenomai.org/index.php/FAQs#Tips_and_tricks_setting_up_your_x8=
6_kernel
>>
>>
>>
>> - Do you mind sending a bit more information than "my system hanged up"?=

>>
>> Any boot log to share? A kernel config file maybe? Did you disable the
>>
>> quiet boot option to see kernel messages while booting? Are there any
>>
>> messages at all? Our mail archive is full of advices regarding the way
>>
>> to troubleshoot a boot issue on x86, make sure to read them first.
>>
>>
>>
>> - Please always provide a meaningful subject line, so that people having=

>>
>> the same issue could later find and reuse the information from that
>>
>> thread.  "HELP" - particularly on a list called xenomai-help - does not
>>
>> qualify, at all. Because it could be seen as a waste of time by your
>>
>> recipients, it may even be counter-productive, and tends to bury your
>>
>> mail.
>>
>>
>>
>> - Please stop posting to xenomai-help-owner, really. This address is for=

>>
>> sending requests related to your mailing list subscription, only.
>>
>>
>>
>> - Please do not re-post the very same question multiple times within
>>
>> less than 24 hours. It makes no sense; you can check that your previous
>>
>> message did arrive in our mail archive, so no need to spam the list with=

>>
>> a rehash of your previous post. If people did not answer you yet, it may=

>>
>> be because: 1) you did not provide sufficient input for them to think
>>
>> about your issue, 2) they don't have time to answer you at the moment,
>>
>> 3) they don't care, 4) they don't know, or any combination thereof.
>>
>>
>>
>>
>>>
>>
>>>
>>
>>> Thanks and Regards,
>>>
>>
>>> Zafar
>>>
>>
>>>
>>
>>>
>>
>>>
>>
>>
>> --
>>
>> Philippe.
>>
>>
>>
>>
>>
>>
>>
>>
>> This message contains information that may be privileged or confidential=
 and is the property of the KPIT Cummins Infosystems Ltd. It
>> is intended only for the person to whom it is addressed. If you are not =
the intended recipient, you are not authorized to read,
>> print, retain copy, disseminate, distribute, or use this message or any =
part thereof. If you receive this message in error, please
>> notify the sender immediately and delete all copies of this message. KPI=
T Cummins Infosystems Ltd. does not accept any liability for
>> virus infected mails.
>>
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>
>



