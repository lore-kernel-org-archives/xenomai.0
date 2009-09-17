MIME-Version: 1.0
In-Reply-To: <4AB235D9.5060602@domain.hid>
References: <4303dd240909110600tf787b85td93b46086953a0d9@domain.hid>
	<4AB235D9.5060602@domain.hid>
Date: Thu, 17 Sep 2009 14:04:13 -0300
Message-ID: <4303dd240909171004l134ecbb7pc8011dcc90b91c44@domain.hid>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d7e32d3bf0690473c901d7
Subject: Re: [Xenomai-help] Problems with instalation of xenomai in ubuntu
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
Cc: xenomai@xenomai.org

--0016e6d7e32d3bf0690473c901d7
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I could complete here the installation of the Xenomai in my ubuntu.

It was really something related to the display installation. I disable the
automatic boot of gnome and I could continue the work. Now I have a working
kernel with xenomai.

Thank you for you help.

Best regards,

Flavio

PS: The console output is the following:

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30 (root@domain.hid) (gcc version 4.3.2
(Ubuntu 4.3.2-1ubuntu12) ) #1 SMP Thu Sep 17 12:39:35 BRT 2009
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
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000009f670000 (usable)
[    0.000000]  BIOS-e820: 000000009f670000 - 000000009f700000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000009f700000 - 00000000a0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] DMI present.
[    0.000000] Phoenix BIOS detected: BIOS may corrupt low RAM, working
around it.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000
(usable) ==> (reserved)
[    0.000000] last_pfn = 0x9f670 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 080000000 mask FE0000000 write-back
[    0.000000]   2 base 09F700000 mask FFFF00000 uncachable
[    0.000000]   3 base 09F800000 mask FFF800000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] init_memory_mapping: 0000000000000000-00000000377fe000
[    0.000000]  0000000000 - 0000400000 page 4k
[    0.000000]  0000400000 - 0037400000 page 2M
[    0.000000]  0037400000 - 00377fe000 page 4k
[    0.000000] kernel direct mapping tables up to 377fe000 @ 10000-15000
[    0.000000] RAMDISK: 34c45000 - 37fef498
[    0.000000] Allocated new RAMDISK: 00619000 - 039c3498
[    0.000000] Move RAMDISK from 0000000034c45000 - 0000000037fef497 to
00619000 - 039c3497
[    0.000000] 1662MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000]   node 0 low ram: 00000000 - 377fe000
[    0.000000]   node 0 bootmap 00011000 - 00017f00
[    0.000000] (9 early reservations) ==> bootmem [0000000000 - 00377fe000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==>
[0000000000 - 0000001000]
[    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==>
[0000001000 - 0000002000]
[    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE ==>
[0000006000 - 0000007000]
[    0.000000]   #3 [0000100000 - 0000615cc4]    TEXT DATA BSS ==>
[0000100000 - 0000615cc4]
[    0.000000]   #4 [000009f800 - 0000100000]    BIOS reserved ==>
[000009f800 - 0000100000]
[    0.000000]   #5 [0000616000 - 0000618178]              BRK ==>
[0000616000 - 0000618178]
[    0.000000]   #6 [0000010000 - 0000011000]          PGTABLE ==>
[0000010000 - 0000011000]
[    0.000000]   #7 [0000619000 - 00039c3498]      NEW RAMDISK ==>
[0000619000 - 00039c3498]
[    0.000000]   #8 [0000011000 - 0000018000]          BOOTMAP ==>
[0000011000 - 0000018000]
[    0.000000] found SMP MP-table at [c00f65c0] f65c0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000377fe
[    0.000000]   HighMem  0x000377fe -> 0x0009f670
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0009f670
[    0.000000] On node 0 totalpages: 652799
[    0.000000] free_area_init_node: node 0, pgdat c04d0f40, node_mem_map
c39c4200
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3951 pages, LIFO batch:0
[    0.000000]   Normal zone: 1744 pages used for memmap
[    0.000000]   Normal zone: 221486 pages, LIFO batch:31
[    0.000000]   HighMem zone: 3325 pages used for memmap
[    0.000000]   HighMem zone: 422261 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] MPTABLE: OEM ID: INTEL
[    0.000000] MPTABLE: Product ID: Napa ERB
[    0.000000] MPTABLE: APIC at: 0xFEE00000
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] Processor #1
[    0.000000] I/O APIC #2 Version 32 at 0xFEC00000.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Processors: 2
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000009f000 -
00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 -
00000000000dc000
[    0.000000] PM: Registered nosave memory: 00000000000dc000 -
0000000000100000
[    0.000000] Allocating PCI resources starting at a4000000 (gap:
a0000000:40000000)
[    0.000000] NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 13 pages at c4dbe000, static data 30652
bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total
pages: 647698
[    0.000000] Kernel command line: root=/dev/sda3 ro
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] NR_IRQS:320
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1662.670 MHz processor.
[    0.004000] I-pipe 2.4-05: pipeline enabled.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)
[    0.004000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.004000] allocated 13057920 bytes of page_cgroup
[    0.004000] please try cgroup_disable=memory option if you don't want
[    0.004000] Initializing HighMem for node 0 (000377fe:0009f670)
[    0.004000] Memory: 2518088k/2611648k available (2771k kernel code,
92244k reserved, 1213k data, 396k init, 1702344k highmem)
[    0.004000] virtual kernel memory layout:
[    0.004000]     fixmap  : 0xfff9d000 - 0xfffff000   ( 392 kB)
[    0.004000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.004000]     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
[    0.004000]     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
[    0.004000]       .init : 0xc04ee000 - 0xc0551000   ( 396 kB)
[    0.004000]       .data : 0xc03b4e12 - 0xc04e4608   (1213 kB)
[    0.004000]       .text : 0xc0100000 - 0xc03b4e12   (2771 kB)
[    0.004000] Checking if this processor honours the WP bit even in
supervisor mode...Ok.
[    0.004000] SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0,
CPUs=2, Nodes=1
[    0.004014] Calibrating delay loop (skipped), value calculated using
timer frequency.. 3325.34 BogoMIPS (lpj=6650680)
[    0.004152] Security Framework initialized
[    0.004210] SELinux:  Disabled at boot.
[    0.004266] Mount-cache hash table entries: 512
[    0.004504] Initializing cgroup subsys ns
[    0.004558] Initializing cgroup subsys cpuacct
[    0.004611] Initializing cgroup subsys memory
[    0.004681] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004763] CPU: L2 cache: 2048K
[    0.004814] CPU: Physical Processor ID: 0
[    0.004862] CPU: Processor Core ID: 0
[    0.004922] Checking 'hlt' instruction... OK.
[    0.021054] ExtINT not setup in hardware but reported by MP table
[    0.021446] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.024001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.024001] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.024001] ..... (found apic 0 pin 0) ...
[    0.069047] ....... works.
[    0.069095] CPU0: Intel(R) Core(TM)2 CPU         T5500  @ 1.66GHz
stepping 06
[    0.176265] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 4655.35
BogoMIPS (lpj=9310715)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 2048K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.268479] CPU1: Intel(R) Core(TM)2 CPU         T5500  @ 1.66GHz
stepping 06
[    0.268911] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.272038] Brought up 2 CPUs
[    0.272088] Total of 2 processors activated (7980.69 BogoMIPS).
[    0.272217] CPU0 attaching sched-domain:
[    0.272221]  domain 0: span 0-1 level MC
[    0.272225]   groups: 0 1
[    0.272233] CPU1 attaching sched-domain:
[    0.272236]  domain 0: span 0-1 level MC
[    0.272239]   groups: 1 0
[    0.272322] net_namespace: 1056 bytes
[    0.272322] Time: 13:36:52  Date: 09/17/09
[    0.272322] NET: Registered protocol family 16
[    0.272322] EISA bus registered
[    0.272322] PCI: PCI BIOS revision 2.10 entry at 0xfd875, last bus=7
[    0.272322] PCI: Using configuration type 1 for base access
[    0.276037] bio: create slab <bio-0> at 0
[    0.276093] PCI: Probing PCI hardware
[    0.276093] PCI: Probing PCI hardware (bus 00)
[    0.276093] pci 0000:00:02.0: reg 10 32bit mmio: [0xdc100000-0xdc17ffff]
[    0.276095] pci 0000:00:02.0: reg 14 io port: [0x1800-0x1807]
[    0.276102] pci 0000:00:02.0: reg 18 32bit mmio: [0xc0000000-0xcfffffff]
[    0.276109] pci 0000:00:02.0: reg 1c 32bit mmio: [0xdc200000-0xdc23ffff]
[    0.276164] pci 0000:00:02.1: reg 10 32bit mmio: [0xdc180000-0xdc1fffff]
[    0.276308] pci 0000:00:1b.0: reg 10 64bit mmio: [0xdc240000-0xdc243fff]
[    0.276380] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.276438] pci 0000:00:1b.0: PME# disabled
[    0.276584] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.276641] pci 0000:00:1c.0: PME# disabled
[    0.276793] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.276848] pci 0000:00:1c.1: PME# disabled
[    0.277001] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.277058] pci 0000:00:1c.2: PME# disabled
[    0.277185] pci 0000:00:1d.0: reg 20 io port: [0x1820-0x183f]
[    0.277262] pci 0000:00:1d.1: reg 20 io port: [0x1840-0x185f]
[    0.277339] pci 0000:00:1d.2: reg 20 io port: [0x1860-0x187f]
[    0.280010] pci 0000:00:1d.3: reg 20 io port: [0x1880-0x189f]
[    0.280093] pci 0000:00:1d.7: reg 10 32bit mmio: [0xdc444000-0xdc4443ff]
[    0.280167] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.280227] pci 0000:00:1d.7: PME# disabled
[    0.280473] pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6
ACPI/GPIO/TCO
[    0.280547] pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6
GPIO
[    0.280607] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0400
(mask 0003)
[    0.280679] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 1640
(mask 007f)
[    0.280827] pci 0000:00:1f.2: reg 10 io port: [0x00-0x07]
[    0.280837] pci 0000:00:1f.2: reg 14 io port: [0x00-0x03]
[    0.280847] pci 0000:00:1f.2: reg 18 io port: [0x00-0x07]
[    0.280857] pci 0000:00:1f.2: reg 1c io port: [0x00-0x03]
[    0.280867] pci 0000:00:1f.2: reg 20 io port: [0x18b0-0x18bf]
[    0.280909] pci 0000:00:1f.2: PME# supported from D3hot
[    0.280965] pci 0000:00:1f.2: PME# disabled
[    0.281086] pci 0000:00:1f.3: reg 20 io port: [0x18c0-0x18df]
[    0.281276] pci 0000:00:1c.1: bridge io port: [0x2000-0x2fff]
[    0.281283] pci 0000:00:1c.1: bridge 32bit mmio: [0xd8000000-0xd9ffffff]
[    0.281294] pci 0000:00:1c.1: bridge 64bit mmio pref:
[0xd2000000-0xd3ffffff]
[    0.281482] pci 0000:05:00.0: reg 10 32bit mmio: [0xda000000-0xda000fff]
[    0.281737] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.281802] pci 0000:05:00.0: PME# disabled
[    0.281958] pci 0000:00:1c.2: bridge io port: [0x3000-0x3fff]
[    0.281965] pci 0000:00:1c.2: bridge 32bit mmio: [0xda000000-0xdbffffff]
[    0.281975] pci 0000:00:1c.2: bridge 64bit mmio pref:
[0xd4000000-0xd5ffffff]
[    0.282045] pci 0000:07:06.0: reg 10 32bit mmio: [0x000000-0x000fff]
[    0.282078] pci 0000:07:06.0: supports D1 D2
[    0.282081] pci 0000:07:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.282140] pci 0000:07:06.0: PME# disabled
[    0.282243] pci 0000:07:06.1: reg 10 32bit mmio: [0xdc006000-0xdc0067ff]
[    0.282254] pci 0000:07:06.1: reg 14 32bit mmio: [0xdc000000-0xdc003fff]
[    0.282325] pci 0000:07:06.1: supports D1 D2
[    0.282328] pci 0000:07:06.1: PME# supported from D0 D1 D2 D3hot
[    0.282387] pci 0000:07:06.1: PME# disabled
[    0.282485] pci 0000:07:06.2: reg 10 32bit mmio: [0xdc004000-0xdc004fff]
[    0.282559] pci 0000:07:06.2: supports D1 D2
[    0.282562] pci 0000:07:06.2: PME# supported from D0 D1 D2 D3hot
[    0.282621] pci 0000:07:06.2: PME# disabled
[    0.282722] pci 0000:07:06.3: reg 10 32bit mmio: [0xdc006800-0xdc0068ff]
[    0.282794] pci 0000:07:06.3: supports D1 D2
[    0.282797] pci 0000:07:06.3: PME# supported from D0 D1 D2 D3hot
[    0.282854] pci 0000:07:06.3: PME# disabled
[    0.282961] pci 0000:07:08.0: reg 10 32bit mmio: [0xdc005000-0xdc005fff]
[    0.282971] pci 0000:07:08.0: reg 14 io port: [0x4000-0x403f]
[    0.283033] pci 0000:07:08.0: supports D1 D2
[    0.283036] pci 0000:07:08.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.283093] pci 0000:07:08.0: PME# disabled
[    0.283197] pci 0000:00:1e.0: transparent bridge
[    0.283250] pci 0000:00:1e.0: bridge io port: [0x4000-0x4fff]
[    0.283257] pci 0000:00:1e.0: bridge 32bit mmio: [0xdc000000-0xdc0fffff]
[    0.284472] PCI: Discovered primary peer bus 01 [IRQ]
[    0.284548] pci 0000:00:1f.0: PIIX/ICH IRQ router [8086:27b9]
[    0.284629] pci 0000:00:02.0: PCI->APIC IRQ transform: INT A -> IRQ 16
[    0.284690] pci 0000:00:1b.0: PCI->APIC IRQ transform: INT A -> IRQ 22
[    0.284748] pci 0000:00:1c.0: PCI->APIC IRQ transform: INT A -> IRQ 17
[    0.284806] pci 0000:00:1c.1: PCI->APIC IRQ transform: INT B -> IRQ 16
[    0.284864] pci 0000:00:1c.2: PCI->APIC IRQ transform: INT C -> IRQ 18
[    0.284922] pci 0000:00:1d.0: PCI->APIC IRQ transform: INT A -> IRQ 23
[    0.284981] pci 0000:00:1d.1: PCI->APIC IRQ transform: INT B -> IRQ 19
[    0.285038] pci 0000:00:1d.2: PCI->APIC IRQ transform: INT C -> IRQ 18
[    0.285928] pci 0000:00:1d.3: PCI->APIC IRQ transform: INT D -> IRQ 16
[    0.285987] pci 0000:00:1d.7: PCI->APIC IRQ transform: INT A -> IRQ 23
[    0.286050] pci 0000:00:1f.2: PCI->APIC IRQ transform: INT B -> IRQ 19
[    0.286109] pci 0000:00:1f.3: PCI->APIC IRQ transform: INT B -> IRQ 19
[    0.286211] pci 0000:05:00.0: PCI->APIC IRQ transform: INT A -> IRQ 18
[    0.286271] pci 0000:07:06.0: PCI->APIC IRQ transform: INT A -> IRQ 18
[    0.286329] pci 0000:07:06.1: PCI->APIC IRQ transform: INT B -> IRQ 17
[    0.286387] pci 0000:07:06.2: PCI->APIC IRQ transform: INT A -> IRQ 18
[    0.286447] pci 0000:07:06.3: PCI->APIC IRQ transform: INT A -> IRQ 18
[    0.286505] pci 0000:07:08.0: PCI->APIC IRQ transform: INT A -> IRQ 20
[    0.304024] NET: Registered protocol family 8
[    0.304076] NET: Registered protocol family 20
[    0.304157] NetLabel: Initializing
[    0.304157] NetLabel:  domain hash size = 128
[    0.304157] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.304174] NetLabel:  unlabeled traffic allowed by default
[    0.304340] PnPBIOS: Scanning system for PnP BIOS support...
[    0.304396] PnPBIOS: Found PnP BIOS installation structure at 0xc00f65e0
[    0.304453] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf0f, dseg
0x400
[    0.304857] pnp 00:0e: io resource (0x1000-0x105f) overlaps 0000:00:1f.0
BAR 7 (0x1000-0x107f), disabling
[    0.304934] pnp 00:0e: io resource (0x1060-0x107f) overlaps 0000:00:1f.0
BAR 7 (0x1000-0x107f), disabling
[    0.306223] PnPBIOS: 25 nodes reported by PnP BIOS; 25 recorded by driver
[    0.306291] system 00:00: ioport range 0x680-0x6ff has been reserved
[    0.306347] system 00:00: ioport range 0x1640-0x164f has been reserved
[    0.306404] system 00:00: iomem range 0xe0000000-0xefffffff has been
reserved
[    0.306464] system 00:00: iomem range 0xfed14000-0xfed17fff has been
reserved
[    0.306522] system 00:00: iomem range 0xfed18000-0xfed18fff has been
reserved
[    0.306578] system 00:00: iomem range 0xfed19000-0xfed19fff has been
reserved
[    0.306648] system 00:0a: iomem range 0xe0000-0xe17ff could not be
reserved
[    0.306708] system 00:0b: iomem range 0xfee00000-0xfee00fff has been
reserved
[    0.306769] system 00:0c: iomem range 0xdc000-0xdffff could not be
reserved
[    0.306831] system 00:0e: ioport range 0x4d0-0x4d1 has been reserved
[    0.306887] system 00:0e: ioport range 0x1180-0x11bf has been reserved
[    0.306943] system 00:0e: iomem range 0xfed00000-0xfed033ff could not be
reserved
[    0.308008] system 00:0e: iomem range 0xfed20000-0xfed3ffff has been
reserved
[    0.308065] system 00:0e: iomem range 0xfed45000-0xfed8ffff has been
reserved
[    0.308122] system 00:0e: iomem range 0xfef00000-0xfeffffff has been
reserved
[    0.308178] system 00:0e: iomem range 0xfed1c000-0xfed1ffff has been
reserved
[    0.308239] system 00:0f: iomem range 0xfec00000-0xfec0ffff has been
reserved
[    0.308299] system 00:10: iomem range 0xfec10000-0xfec17fff has been
reserved
[    0.308360] system 00:11: iomem range 0xfec18000-0xfec1ffff has been
reserved
[    0.308420] system 00:12: iomem range 0xfec20000-0xfec27fff has been
reserved
[    0.308482] system 00:13: iomem range 0xfec28000-0xfec2ffff has been
reserved
[    0.308542] system 00:14: iomem range 0xfec30000-0xfec37fff has been
reserved
[    0.308603] system 00:15: iomem range 0xfec38000-0xfec3ffff has been
reserved
[    0.308664] system 00:17: iomem range 0xce600-0xce7ff has been reserved
[    0.309402] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
[    0.309457] pci 0000:00:1c.0:   IO window: disabled
[    0.309515] pci 0000:00:1c.0:   MEM window: disabled
[    0.309571] pci 0000:00:1c.0:   PREFETCH window: disabled
[    0.309631] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:03
[    0.309687] pci 0000:00:1c.1:   IO window: 0x2000-0x2fff
[    0.309745] pci 0000:00:1c.1:   MEM window: 0xd8000000-0xd9ffffff
[    0.309804] pci 0000:00:1c.1:   PREFETCH window:
0x000000d2000000-0x000000d3ffffff
[    0.309881] pci 0000:00:1c.2: PCI bridge, secondary bus 0000:05
[    0.309936] pci 0000:00:1c.2:   IO window: 0x3000-0x3fff
[    0.309993] pci 0000:00:1c.2:   MEM window: 0xda000000-0xdbffffff
[    0.310051] pci 0000:00:1c.2:   PREFETCH window:
0x000000d4000000-0x000000d5ffffff
[    0.310136] pci 0000:07:06.0: CardBus bridge, secondary bus 0000:08
[    0.310191] pci 0000:07:06.0:   IO window: 0x004400-0x0044ff
[    0.310248] pci 0000:07:06.0:   IO window: 0x004800-0x0048ff
[    0.310306] pci 0000:07:06.0:   PREFETCH window: 0xa4000000-0xa7ffffff
[    0.310365] pci 0000:07:06.0:   MEM window: 0xa8000000-0xabffffff
[    0.310423] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:07
[    0.310480] pci 0000:00:1e.0:   IO window: 0x4000-0x4fff
[    0.310540] pci 0000:00:1e.0:   MEM window: 0xdc000000-0xdc0fffff
[    0.310597] pci 0000:00:1e.0:   PREFETCH window:
0x000000a4000000-0x000000a7ffffff
[    0.310688] pci 0000:00:1c.0: setting latency timer to 64
[    0.310705] pci 0000:00:1c.1: setting latency timer to 64
[    0.310721] pci 0000:00:1c.2: setting latency timer to 64
[    0.310732] pci 0000:00:1e.0: setting latency timer to 64
[    0.310743] pci 0000:07:06.0: enabling device (0000 -> 0003)
[    0.310810] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.310813] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
[    0.310817] pci_bus 0000:03: resource 0 io:  [0x2000-0x2fff]
[    0.310820] pci_bus 0000:03: resource 1 mem: [0xd8000000-0xd9ffffff]
[    0.310824] pci_bus 0000:03: resource 2 pref mem [0xd2000000-0xd3ffffff]
[    0.310828] pci_bus 0000:05: resource 0 io:  [0x3000-0x3fff]
[    0.310831] pci_bus 0000:05: resource 1 mem: [0xda000000-0xdbffffff]
[    0.310835] pci_bus 0000:05: resource 2 pref mem [0xd4000000-0xd5ffffff]
[    0.310838] pci_bus 0000:07: resource 0 io:  [0x4000-0x4fff]
[    0.310842] pci_bus 0000:07: resource 1 mem: [0xdc000000-0xdc0fffff]
[    0.310845] pci_bus 0000:07: resource 2 pref mem [0xa4000000-0xa7ffffff]
[    0.310849] pci_bus 0000:07: resource 3 io:  [0x00-0xffff]
[    0.310852] pci_bus 0000:07: resource 4 mem: [0x000000-0xffffffff]
[    0.310855] pci_bus 0000:08: resource 0 io:  [0x4400-0x44ff]
[    0.310859] pci_bus 0000:08: resource 1 io:  [0x4800-0x48ff]
[    0.310862] pci_bus 0000:08: resource 2 pref mem [0xa4000000-0xa7ffffff]
[    0.310866] pci_bus 0000:08: resource 3 mem: [0xa8000000-0xabffffff]
[    0.310869] pci_bus 0000:01: resource 0 io:  [0x00-0xffff]
[    0.310873] pci_bus 0000:01: resource 1 mem: [0x000000-0xffffffff]
[    0.310907] NET: Registered protocol family 2
[    0.352031] IP route cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.352406] TCP established hash table entries: 131072 (order: 8, 1048576
bytes)
[    0.352967] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.353293] TCP: Hash tables configured (established 131072 bind 65536)
[    0.353349] TCP reno registered
[    0.364049] NET: Registered protocol family 1
[    0.364173] Trying to unpack rootfs image as initramfs...
[    2.165491] Freeing initrd memory: 52905k freed
[    2.201774] audit: initializing netlink socket (disabled)
[    2.201855] type=2000 audit(1253194614.199:1): initialized
[    2.208588] I-pipe: Domain Xenomai registered.
[    2.208701] Xenomai: hal/i386 started.
[    2.210638] Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon) loaded.
[    2.210866] Xenomai: SMI-enabled chipset found, but SMI workaround
disabled
[    2.210868]          (check CONFIG_XENO_HW_SMI_WORKAROUND). You may
encounter
[    2.210869]          high interrupt latencies!
[    2.211078] Xenomai: starting native API services.
[    2.211813] Xenomai: starting POSIX services.
[    2.211910] Xenomai: starting RTDM services.
[    2.212192] highmem bounce pool size: 64 pages
[    2.212248] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    2.220241] VFS: Disk quotas dquot_6.5.2
[    2.220409] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    2.220611] msgmni has been set to 1698
[    2.220971] alg: No test for stdrng (krng)
[    2.221037] io scheduler noop registered
[    2.221089] io scheduler anticipatory registered
[    2.221140] io scheduler deadline registered
[    2.221286] io scheduler cfq registered (default)
[    2.221351] pci 0000:00:02.0: Boot video device
[    2.599461] Clocksource tsc unstable (delta = -153132033 ns)
[    3.647965] pci 0000:00:1d.7: EHCI: BIOS handoff failed (BIOS bug?)
01010001
[    3.648163] pci 0000:07:08.0: Firmware left e100 interrupts enabled;
disabling
[    3.648320] pcieport-driver 0000:00:1c.0: irq 24 for MSI/MSI-X
[    3.648320] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    3.648320] pcieport-driver 0000:00:1c.1: irq 25 for MSI/MSI-X
[    3.648320] pcieport-driver 0000:00:1c.1: setting latency timer to 64
[    3.648320] pcieport-driver 0000:00:1c.2: irq 26 for MSI/MSI-X
[    3.648320] pcieport-driver 0000:00:1c.2: setting latency timer to 64
[    3.648320] isapnp: Scanning for PnP cards...
[    4.317659] isapnp: No Plug & Play device found
[    4.420097] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.428069] brd: module loaded
[    4.428207] input: Macintosh mouse button emulation as
/devices/virtual/input/input0
[    4.436039] PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
[    4.437658] i8042.c: Detected active multiplexing controller, rev 1.1.
[    4.440782] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.440838] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    4.440896] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    4.440950] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    4.441004] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    4.441124] mice: PS/2 mouse device common for all mice
[    4.441124] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    4.441124] rtc0: alarms up to one day, 114 bytes nvram
[    4.441124] EISA: Probing bus 0 at eisa.0
[    4.441124] Cannot allocate resource for EISA slot 1
[    4.441124] Cannot allocate resource for EISA slot 2
[    4.441124] Cannot allocate resource for EISA slot 3
[    4.441124] Cannot allocate resource for EISA slot 4
[    4.441124] EISA: Detected 0 cards.
[    4.441124] cpuidle: using governor ladder
[    4.441124] cpuidle: using governor menu
[    4.441124] TCP cubic registered
[    4.441124] Using IPI No-Shortcut mode
[    4.441124] PM: Resume from disk failed.
[    4.441124] registered taskstats version 1
[    4.441124]   Magic number: 9:255:635
[    4.441124] tty ptyce: hash matches
[    4.441124] pci_express 0000:00:1c.1:pcie01: hash matches
[    4.441124] rtc_cmos 00:06: setting system clock to 2009-09-17 13:36:56
UTC (1253194616)
[    4.441124] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    4.441124] EDD information not available.
[    4.444054] Freeing unused kernel memory: 396k freed
[    4.444387] Write protecting the kernel text: 2772k
[    4.444476] Write protecting the kernel read-only data: 992k
[    4.492141] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input1
[    4.648023] fuse init (API version 7.11)
[    5.142470] usbcore: registered new interface driver usbfs
[    5.142554] usbcore: registered new interface driver hub
[    5.142640] usbcore: registered new device driver usb
[    5.151538] uhci_hcd: USB Universal Host Controller Interface driver
[    5.152018] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    5.152023] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    5.152137] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus
number 1
[    5.156008] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001820
[    5.156249] usb usb1: configuration #1 chosen from 1 choice
[    5.156340] hub 1-0:1.0: USB hub found
[    5.156398] hub 1-0:1.0: 2 ports detected
[    5.156624] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    5.156629] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    5.156708] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus
number 2
[    5.160166] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001840
[    5.160345] usb usb2: configuration #1 chosen from 1 choice
[    5.160434] hub 2-0:1.0: USB hub found
[    5.160493] hub 2-0:1.0: 2 ports detected
[    5.160674] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    5.160679] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    5.167977] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus
number 3
[    5.168080] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001860
[    5.169125] usb usb3: configuration #1 chosen from 1 choice
[    5.169213] hub 3-0:1.0: USB hub found
[    5.169271] hub 3-0:1.0: 2 ports detected
[    5.169452] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[    5.169457] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    5.169539] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus
number 4
[    5.169642] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001880
[    5.169809] usb usb4: configuration #1 chosen from 1 choice
[    5.169896] hub 4-0:1.0: USB hub found
[    5.169959] hub 4-0:1.0: 2 ports detected
[    5.180241] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.180302] Warning! ehci_hcd should always be loaded before uhci_hcd and
ohci_hcd, not after
[    5.180427] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    5.180433] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    5.180527] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus
number 5
[    5.184490] ehci_hcd 0000:00:1d.7: debug port 1
[    5.184550] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    5.184560] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xdc444000
[    5.189138] SCSI subsystem initialized
[    5.227956] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    5.227956] usb usb5: configuration #1 chosen from 1 choice
[    5.227956] hub 5-0:1.0: USB hub found
[    5.227956] hub 5-0:1.0: 8 ports detected
[    5.331087] libata version 3.00 loaded.
[    5.333398] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    5.333457] e100: Copyright(c) 1999-2006 Intel Corporation
[    5.375956] e100 0000:07:08.0: PME# disabled
[    5.472295] e100: eth0: e100_probe: addr 0xdc005000, irq 20, MAC addr
00:a0:d1:59:b8:e4
[    5.507429] ata_piix 0000:00:1f.2: version 2.13
[    5.507455] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[    5.568041] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[17]
MMIO=[dc006000-dc0067ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[    5.660022] ata_piix 0000:00:1f.2: setting latency timer to 64
[    5.660514] scsi0 : ata_piix
[    5.660704] scsi1 : ata_piix
[    5.660803] ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x18b0 irq
14
[    5.660860] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x18b8 irq
15
[    5.828517] ata1.00: ATA-7: FUJITSU MHV2160BT PL, 00000050, max UDMA/100
[    5.828579] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    5.856010] ata1.00: configured for UDMA/100
[    5.856255] scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2160B
0000 PQ: 0 ANSI: 5
[    5.919983] usb 2-1: new full speed USB device using uhci_hcd and address
2
[    6.020521] ata2.00: ATAPI: MATSHITADVD-RAM UJ-841S, 1.60, max UDMA/33
[    6.052461] ata2.00: configured for UDMA/33
[    6.054835] scsi 1:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ-841S
1.60 PQ: 0 ANSI: 5
[    6.140713] usb 2-1: configuration #1 chosen from 1 choice
[    6.234259] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[    6.234365] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[    6.278913] Driver 'sd' needs updating - please use bus_type methods
[    6.282350] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160
GB/149 GiB)
[    6.282444] sd 0:0:0:0: [sda] Write Protect is off
[    6.282498] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.282532] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    6.282734]  sda: sda1 sda2 sda3 sda4
[    6.376263] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.380316] Driver 'sr' needs updating - please use bus_type methods
[    6.407964] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2
cdda tray
[    6.408038] Uniform CD-ROM driver Revision: 3.20
[    6.408202] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    7.096499] PM: Starting manual resume from disk
[    7.096499] PM: Resume from partition 8:4
[    7.096499] PM: Checking hibernation image.
[    7.096499] PM: Resume from disk failed.
[    7.192009] kjournald starting.  Commit interval 5 seconds
[    7.192009] EXT3-fs: mounted filesystem with writeback data mode.
[   17.554039] udevd version 124 started
[   18.382658] Linux agpgart interface v0.103
[   18.501940] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   18.567976] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   18.619956] agpgart-intel 0000:00:00.0: Intel 945GM Chipset
[   18.624264] agpgart-intel 0000:00:00.0: detected 7932K stolen memory
[   18.627283] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xc0000000
[   18.749242] intel_rng: FWH not detected
[   19.446939] yenta_cardbus 0000:07:06.0: CardBus bridge found [1179:ff10]
[   19.447025] yenta_cardbus 0000:07:06.0: Enabling burst memory read
transactions
[   19.447103] yenta_cardbus 0000:07:06.0: Using CSCINT to route CSC
interrupts to PCI
[   19.447178] yenta_cardbus 0000:07:06.0: Routing CardBus interrupts to PCI
[   19.447241] yenta_cardbus 0000:07:06.0: TI: mfunc 0x01a01b22, devctl 0x66
[   19.627078] Bluetooth: Core ver 2.15
[   19.627700] NET: Registered protocol family 31
[   19.627756] Bluetooth: HCI device and connection manager initialized
[   19.627812] Bluetooth: HCI socket layer initialized
[   19.676971] yenta_cardbus 0000:07:06.0: ISA IRQ mask 0x02f8, PCI irq 18
[   19.677037] yenta_cardbus 0000:07:06.0: Socket status: 30000006
[   19.677094] pci_bus 0000:07: Raising subordinate bus# of parent bus (#07)
from #07 to #0b
[   19.677174] yenta_cardbus 0000:07:06.0: pcmcia: parent PCI bridge I/O
window: 0x4000 - 0x4fff
[   19.677248] pcmcia_socket pcmcia_socket0: cs: IO port probe
0x4000-0x4fff: clean.
[   19.677742] yenta_cardbus 0000:07:06.0: pcmcia: parent PCI bridge Memory
window: 0xdc000000 - 0xdc0fffff
[   19.677818] yenta_cardbus 0000:07:06.0: pcmcia: parent PCI bridge Memory
window: 0xa4000000 - 0xa7ffffff
[   19.731956] iTCO_vendor_support: vendor-support=0
[   19.959956] cfg80211: Calling CRDA to update world regulatory domain
[   20.138706] Bluetooth: Generic Bluetooth USB driver ver 0.5
[   20.138859] usbcore: registered new interface driver btusb
[   20.417425] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
[   20.417602] iTCO_wdt: Found a ICH7-M or ICH7-U TCO device (Version=2,
TCOBASE=0x1060)
[   20.418154] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   21.286015] sdhci: Secure Digital Host Controller Interface driver
[   21.286079] sdhci: Copyright(c) Pierre Ossman
[   21.316636] sdhci-pci 0000:07:06.3: SDHCI controller found [104c:803c]
(rev 0)
[   21.316808] Registered led device: mmc0::
[   21.316903] mmc0: SDHCI controller on PCI [0000:07:06.3] using DMA
[   21.584131] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps:
0xa04713/0x0
[   21.584131] synaptics: Toshiba Satellite A105 detected, limiting rate to
40pps.
[   21.636042] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio4/input/input2
[   22.460059] iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection
driver for Linux, 1.2.26ks
[   22.460140] iwl3945: Copyright(c) 2003-2009 Intel Corporation
[   22.460346] iwl3945 0000:05:00.0: setting latency timer to 64
[   22.552254] iwl3945 0000:05:00.0: Tunable channels: 11 802.11bg, 13
802.11a channels
[   22.552330] iwl3945 0000:05:00.0: Detected Intel Wireless WiFi Link
3945ABG
[   22.552562] iwl3945 0000:05:00.0: irq 27 for MSI/MSI-X
[   22.608172] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x100-0x3af:
clean.
[   22.610149] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x3e0-0x4ff:
excluding 0x400-0x407
[   22.619961] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x820-0x8ff:
clean.
[   22.620762] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xc00-0xcf7:
clean.
[   22.621713] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xa00-0xaff:
clean.
[   22.984406] phy0: Selected rate control algorithm 'iwl-3945-rs'
[   23.495965] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   23.709132] hda_codec: Unknown model for ALC861, trying auto-probe from
BIOS...
[   24.981622] lp: driver loaded but no devices found
[   25.469878] Adding 5116692k swap on /dev/sda4.  Priority:-1 extents:1
across:5116692k
[   26.120552] EXT3 FS on sda3, internal journal
[   27.906961] ip_tables: (C) 2000-2006 Netfilter Core Team
[   31.087956] warning: `avahi-daemon' uses 32-bit capabilities (legacy
support in use)
[   31.599964] ppdev: user-space parallel port driver
[   34.899956] NET: Registered protocol family 10
[   34.899956] lo: Disabled Privacy Extensions
[   36.450590] Bluetooth: L2CAP ver 2.13
[   36.450594] Bluetooth: L2CAP socket layer initialized
[   36.542030] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   36.542034] Bluetooth: BNEP filters: protocol multicast
[   36.670790] Bluetooth: RFCOMM socket layer initialized
[   36.670790] Bluetooth: RFCOMM TTY layer initialized
[   36.670790] Bluetooth: RFCOMM ver 1.11
[   37.018939] Bridge firewalling registered
[   37.298038] Bluetooth: SCO (Voice Link) ver 0.6
[   37.298043] Bluetooth: SCO socket layer initialized
[   41.077531] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   41.078303] iwl3945 0000:05:00.0: firmware: requesting
iwlwifi-3945-2.ucode
[   41.124010] iwl3945 0000:05:00.0: iwlwifi-3945-2.ucode firmware file req
failed: -2
[   41.124087] iwl3945 0000:05:00.0: firmware: requesting
iwlwifi-3945-1.ucode
[   41.164318] iwl3945 0000:05:00.0: Loaded firmware iwlwifi-3945-1.ucode,
which is deprecated.  Please use API v2 instead.
[   41.164427] iwl3945 0000:05:00.0: Firmware has old API version. Expected
2, got 1. New firmware can be obtained from
http://www.intellinuxwireless.org.
[   41.164427] iwl3945 0000:05:00.0: loaded firmware version 2.14.1.5
[   41.213732] Registered led device: iwl-phy0::radio
[   41.213732] Registered led device: iwl-phy0::assoc
[   41.213732] Registered led device: iwl-phy0::RX
[   41.213732] Registered led device: iwl-phy0::TX
[   41.240136] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   41.423956] NET: Registered protocol family 17

2009/9/17 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Flavio de Castro Alves Filho wrote:
> > Hello,
> >
> > I am new with Xenomai and I am having problems in booting a compiled
> kernel
> > into Ubuntu 8.10. I could compile the kernel with the appropriate patch,
> > configured grub to load the new kernel. But, when I boot the new kernel,
> it
> > performs all the boot configurations and at the end, when the gnome is
> about
> > to be loaded, the computer starts to blink the display and then blocks.
>
> Ok, I misread your description.
>
> >
> > I am using the following configuration:
> >
> > - x86 platform (my notebook ... an intel core2duo machine)
> > - xenomai version 2.4.9
> > - linux 2.6.30
> > - ubuntu linux 8.10
> > I performed the following steps:
> >
> > - downloaded file linux-2.6.30.tar.bz2 from kernel.org
> > - downloaded file xenomai-2.4.9.tar.bz2 from xenomai website
> > - from my home directory, I decompressed both files
> > - applied the patch, running the "scripts/prepare-kernel.sh" and provided
> > the path for my source files "/home/flavio/linux-2.6.30". The script had
> > correctly found the patch to be applied to my sources.
> > - make xconfig:
> >    - disabled HPET timer support
>
> Try keeping it.
>
> >    - disabled PC Speaker
> >    - disabled Power Management Support
>
> Only disable APM, try enabling ACPI, except the "ACPI Processor" option.
>
> >    - disabled CPU frequency scaling
> >    - enabled VxWorks emulator
> >    - enabled RTAI emulator
> >    - enabled Testing drivers
> > - make
> > - make modules
> > - sudo make modules_install
>
> If you have a proprietary graphics module, you need to recompile that
> module too.
>
> > - sudo make install
> > - cd /boot
> > - sudo update-initramfs -c -k 2.6.30
> > - created an entry in grub list:
>
> >
> > title Xenomai 2.4.9 Linux 2.6.30
> > root (hd0,2)
> > kernel /boot/vmlinuz-2.6.30 root=/dev/sda3 ro
> > initrd /boot/initrd.img-2.6.30
> > savedefault
> > boot
> >
> > Just as a remark, I performed before the same procedure, except for the
> > xenomai patch, and I could execute the linux 2.6.30 kernel in my
> computer.
> >
> > Had anybody passed by the same experience? I have no idea what the
> problem
> > could be.
>
> Please show us the console output anyway.
>
> --
>                                             Gilles.
>



-- 
Flavio de Castro Alves Filho
Embedded Software Services
www.phiinnovations.com
+55 11 84 94 56 76

--0016e6d7e32d3bf0690473c901d7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I could complete here the installation of the Xenomai in my u=
buntu.<br><br>It was really something related to the display installation. =
I disable the automatic boot of gnome and I could continue the work. Now I =
have a working kernel with xenomai.<br>
<br>Thank you for you help.<br><br>Best regards,<br><br>Flavio<br><br>PS: T=
he console output is the following:<br><br>[=A0=A0=A0 0.000000] Initializin=
g cgroup subsys cpuset<br>[=A0=A0=A0 0.000000] Initializing cgroup subsys c=
pu<br>[=A0=A0=A0 0.000000] Linux version 2.6.30 (root@domain.hid) (gcc v=
ersion 4.3.2 (Ubuntu 4.3.2-1ubuntu12) ) #1 SMP Thu Sep 17 12:39:35 BRT 2009=
<br>
[=A0=A0=A0 0.000000] KERNEL supported cpus:<br>[=A0=A0=A0 0.000000]=A0=A0 I=
ntel GenuineIntel<br>[=A0=A0=A0 0.000000]=A0=A0 AMD AuthenticAMD<br>[=A0=A0=
=A0 0.000000]=A0=A0 NSC Geode by NSC<br>[=A0=A0=A0 0.000000]=A0=A0 Cyrix Cy=
rixInstead<br>[=A0=A0=A0 0.000000]=A0=A0 Centaur CentaurHauls<br>
[=A0=A0=A0 0.000000]=A0=A0 Transmeta GenuineTMx86<br>[=A0=A0=A0 0.000000]=
=A0=A0 Transmeta TransmetaCPU<br>[=A0=A0=A0 0.000000]=A0=A0 UMC UMC UMC UMC=
<br>[=A0=A0=A0 0.000000] BIOS-provided physical RAM map:<br>[=A0=A0=A0 0.00=
0000]=A0 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)<br>
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 000000000009f800 - 00000000000a0000 (res=
erved)<br>[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000000dc000 - 00000000001=
00000 (reserved)<br>[=A0=A0=A0 0.000000]=A0 BIOS-e820: 0000000000100000 - 0=
00000009f670000 (usable)<br>
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 000000009f670000 - 000000009f700000 (ACP=
I NVS)<br>[=A0=A0=A0 0.000000]=A0 BIOS-e820: 000000009f700000 - 00000000a00=
00000 (reserved)<br>[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000e0000000 - 0=
0000000f0000000 (reserved)<br>
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000fec00000 - 00000000fec10000 (res=
erved)<br>[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000fed00000 - 00000000fed=
00400 (reserved)<br>[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000fed14000 - 0=
0000000fed1a000 (reserved)<br>
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (res=
erved)<br>[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000fee00000 - 00000000fee=
01000 (reserved)<br>[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000ff000000 - 0=
000000100000000 (reserved)<br>
[=A0=A0=A0 0.000000] DMI present.<br>[=A0=A0=A0 0.000000] Phoenix BIOS dete=
cted: BIOS may corrupt low RAM, working around it.<br>[=A0=A0=A0 0.000000] =
e820 update range: 0000000000000000 - 0000000000010000 (usable) =3D=3D&gt; =
(reserved)<br>[=A0=A0=A0 0.000000] last_pfn =3D 0x9f670 max_arch_pfn =3D 0x=
100000<br>
[=A0=A0=A0 0.000000] MTRR default type: uncachable<br>[=A0=A0=A0 0.000000] =
MTRR fixed ranges enabled:<br>[=A0=A0=A0 0.000000]=A0=A0 00000-9FFFF write-=
back<br>[=A0=A0=A0 0.000000]=A0=A0 A0000-BFFFF uncachable<br>[=A0=A0=A0 0.0=
00000]=A0=A0 C0000-CFFFF write-protect<br>
[=A0=A0=A0 0.000000]=A0=A0 D0000-DFFFF uncachable<br>[=A0=A0=A0 0.000000]=
=A0=A0 E0000-FFFFF write-protect<br>[=A0=A0=A0 0.000000] MTRR variable rang=
es enabled:<br>[=A0=A0=A0 0.000000]=A0=A0 0 base 000000000 mask F80000000 w=
rite-back<br>[=A0=A0=A0 0.000000]=A0=A0 1 base 080000000 mask FE0000000 wri=
te-back<br>
[=A0=A0=A0 0.000000]=A0=A0 2 base 09F700000 mask FFFF00000 uncachable<br>[=
=A0=A0=A0 0.000000]=A0=A0 3 base 09F800000 mask FFF800000 uncachable<br>[=
=A0=A0=A0 0.000000]=A0=A0 4 disabled<br>[=A0=A0=A0 0.000000]=A0=A0 5 disabl=
ed<br>[=A0=A0=A0 0.000000]=A0=A0 6 disabled<br>[=A0=A0=A0 0.000000]=A0=A0 7=
 disabled<br>
[=A0=A0=A0 0.000000] init_memory_mapping: 0000000000000000-00000000377fe000=
<br>[=A0=A0=A0 0.000000]=A0 0000000000 - 0000400000 page 4k<br>[=A0=A0=A0 0=
.000000]=A0 0000400000 - 0037400000 page 2M<br>[=A0=A0=A0 0.000000]=A0 0037=
400000 - 00377fe000 page 4k<br>
[=A0=A0=A0 0.000000] kernel direct mapping tables up to 377fe000 @ 10000-15=
000<br>[=A0=A0=A0 0.000000] RAMDISK: 34c45000 - 37fef498<br>[=A0=A0=A0 0.00=
0000] Allocated new RAMDISK: 00619000 - 039c3498<br>[=A0=A0=A0 0.000000] Mo=
ve RAMDISK from 0000000034c45000 - 0000000037fef497 to 00619000 - 039c3497<=
br>
[=A0=A0=A0 0.000000] 1662MB HIGHMEM available.<br>[=A0=A0=A0 0.000000] 887M=
B LOWMEM available.<br>[=A0=A0=A0 0.000000]=A0=A0 mapped low ram: 0 - 377fe=
000<br>[=A0=A0=A0 0.000000]=A0=A0 low ram: 0 - 377fe000<br>[=A0=A0=A0 0.000=
000]=A0=A0 node 0 low ram: 00000000 - 377fe000<br>
[=A0=A0=A0 0.000000]=A0=A0 node 0 bootmap 00011000 - 00017f00<br>[=A0=A0=A0=
 0.000000] (9 early reservations) =3D=3D&gt; bootmem [0000000000 - 00377fe0=
00]<br>[=A0=A0=A0 0.000000]=A0=A0 #0 [0000000000 - 0000001000]=A0=A0 BIOS d=
ata page =3D=3D&gt; [0000000000 - 0000001000]<br>
[=A0=A0=A0 0.000000]=A0=A0 #1 [0000001000 - 0000002000]=A0=A0=A0 EX TRAMPOL=
INE =3D=3D&gt; [0000001000 - 0000002000]<br>[=A0=A0=A0 0.000000]=A0=A0 #2 [=
0000006000 - 0000007000]=A0=A0=A0=A0=A0=A0 TRAMPOLINE =3D=3D&gt; [000000600=
0 - 0000007000]<br>[=A0=A0=A0 0.000000]=A0=A0 #3 [0000100000 - 0000615cc4]=
=A0=A0=A0 TEXT DATA BSS =3D=3D&gt; [0000100000 - 0000615cc4]<br>
[=A0=A0=A0 0.000000]=A0=A0 #4 [000009f800 - 0000100000]=A0=A0=A0 BIOS reser=
ved =3D=3D&gt; [000009f800 - 0000100000]<br>[=A0=A0=A0 0.000000]=A0=A0 #5 [=
0000616000 - 0000618178]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BRK =3D=3D&=
gt; [0000616000 - 0000618178]<br>[=A0=A0=A0 0.000000]=A0=A0 #6 [0000010000 =
- 0000011000]=A0=A0=A0=A0=A0=A0=A0=A0=A0 PGTABLE =3D=3D&gt; [0000010000 - 0=
000011000]<br>
[=A0=A0=A0 0.000000]=A0=A0 #7 [0000619000 - 00039c3498]=A0=A0=A0=A0=A0 NEW =
RAMDISK =3D=3D&gt; [0000619000 - 00039c3498]<br>[=A0=A0=A0 0.000000]=A0=A0 =
#8 [0000011000 - 0000018000]=A0=A0=A0=A0=A0=A0=A0=A0=A0 BOOTMAP =3D=3D&gt; =
[0000011000 - 0000018000]<br>[=A0=A0=A0 0.000000] found SMP MP-table at [c0=
0f65c0] f65c0<br>
[=A0=A0=A0 0.000000] Zone PFN ranges:<br>[=A0=A0=A0 0.000000]=A0=A0 DMA=A0=
=A0=A0=A0=A0 0x00000010 -&gt; 0x00001000<br>[=A0=A0=A0 0.000000]=A0=A0 Norm=
al=A0=A0 0x00001000 -&gt; 0x000377fe<br>[=A0=A0=A0 0.000000]=A0=A0 HighMem=
=A0 0x000377fe -&gt; 0x0009f670<br>[=A0=A0=A0 0.000000] Movable zone start =
PFN for each node<br>
[=A0=A0=A0 0.000000] early_node_map[2] active PFN ranges<br>[=A0=A0=A0 0.00=
0000]=A0=A0=A0=A0 0: 0x00000010 -&gt; 0x0000009f<br>[=A0=A0=A0 0.000000]=A0=
=A0=A0=A0 0: 0x00000100 -&gt; 0x0009f670<br>[=A0=A0=A0 0.000000] On node 0 =
totalpages: 652799<br>[=A0=A0=A0 0.000000] free_area_init_node: node 0, pgd=
at c04d0f40, node_mem_map c39c4200<br>
[=A0=A0=A0 0.000000]=A0=A0 DMA zone: 32 pages used for memmap<br>[=A0=A0=A0=
 0.000000]=A0=A0 DMA zone: 0 pages reserved<br>[=A0=A0=A0 0.000000]=A0=A0 D=
MA zone: 3951 pages, LIFO batch:0<br>[=A0=A0=A0 0.000000]=A0=A0 Normal zone=
: 1744 pages used for memmap<br>[=A0=A0=A0 0.000000]=A0=A0 Normal zone: 221=
486 pages, LIFO batch:31<br>
[=A0=A0=A0 0.000000]=A0=A0 HighMem zone: 3325 pages used for memmap<br>[=A0=
=A0=A0 0.000000]=A0=A0 HighMem zone: 422261 pages, LIFO batch:31<br>[=A0=A0=
=A0 0.000000] Using APIC driver default<br>[=A0=A0=A0 0.000000] Intel Multi=
Processor Specification v1.4<br>
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 Virtual Wire compatibility mode.<br>[=A0=
=A0=A0 0.000000] MPTABLE: OEM ID: INTEL=A0=A0 <br>[=A0=A0=A0 0.000000] MPTA=
BLE: Product ID: Napa ERB=A0=A0=A0 <br>[=A0=A0=A0 0.000000] MPTABLE: APIC a=
t: 0xFEE00000<br>[=A0=A0=A0 0.000000] Processor #0 (Bootup-CPU)<br>
[=A0=A0=A0 0.000000] Processor #1<br>[=A0=A0=A0 0.000000] I/O APIC #2 Versi=
on 32 at 0xFEC00000.<br>[=A0=A0=A0 0.000000] Enabling APIC mode:=A0 Flat.=
=A0 Using 1 I/O APICs<br>[=A0=A0=A0 0.000000] Processors: 2<br>[=A0=A0=A0 0=
.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs<br>
[=A0=A0=A0 0.000000] nr_irqs_gsi: 24<br>[=A0=A0=A0 0.000000] PM: Registered=
 nosave memory: 000000000009f000 - 00000000000a0000<br>[=A0=A0=A0 0.000000]=
 PM: Registered nosave memory: 00000000000a0000 - 00000000000dc000<br>[=A0=
=A0=A0 0.000000] PM: Registered nosave memory: 00000000000dc000 - 000000000=
0100000<br>
[=A0=A0=A0 0.000000] Allocating PCI resources starting at a4000000 (gap: a0=
000000:40000000)<br>[=A0=A0=A0 0.000000] NR_CPUS:2 nr_cpumask_bits:2 nr_cpu=
_ids:2 nr_node_ids:1<br>[=A0=A0=A0 0.000000] PERCPU: Embedded 13 pages at c=
4dbe000, static data 30652 bytes<br>
[=A0=A0=A0 0.000000] Built 1 zonelists in Zone order, mobility grouping on.=
=A0 Total pages: 647698<br>[=A0=A0=A0 0.000000] Kernel command line: root=
=3D/dev/sda3 ro<br>[=A0=A0=A0 0.000000] Enabling fast FPU save and restore.=
.. done.<br>[=A0=A0=A0 0.000000] Enabling unmasked SIMD FPU exception suppo=
rt... done.<br>
[=A0=A0=A0 0.000000] Initializing CPU#0<br>[=A0=A0=A0 0.000000] NR_IRQS:320=
<br>[=A0=A0=A0 0.000000] PID hash table entries: 4096 (order: 12, 16384 byt=
es)<br>[=A0=A0=A0 0.000000] Fast TSC calibration using PIT<br>[=A0=A0=A0 0.=
000000] Detected 1662.670 MHz processor.<br>
[=A0=A0=A0 0.004000] I-pipe 2.4-05: pipeline enabled.<br>[=A0=A0=A0 0.00400=
0] Console: colour VGA+ 80x25<br>[=A0=A0=A0 0.004000] console [tty0] enable=
d<br>[=A0=A0=A0 0.004000] Dentry cache hash table entries: 131072 (order: 7=
, 524288 bytes)<br>[=A0=A0=A0 0.004000] Inode-cache hash table entries: 655=
36 (order: 6, 262144 bytes)<br>
[=A0=A0=A0 0.004000] allocated 13057920 bytes of page_cgroup<br>[=A0=A0=A0 =
0.004000] please try cgroup_disable=3Dmemory option if you don&#39;t want<b=
r>[=A0=A0=A0 0.004000] Initializing HighMem for node 0 (000377fe:0009f670)<=
br>[=A0=A0=A0 0.004000] Memory: 2518088k/2611648k available (2771k kernel c=
ode, 92244k reserved, 1213k data, 396k init, 1702344k highmem)<br>
[=A0=A0=A0 0.004000] virtual kernel memory layout:<br>[=A0=A0=A0 0.004000]=
=A0=A0=A0=A0 fixmap=A0 : 0xfff9d000 - 0xfffff000=A0=A0 ( 392 kB)<br>[=A0=A0=
=A0 0.004000]=A0=A0=A0=A0 pkmap=A0=A0 : 0xff800000 - 0xffc00000=A0=A0 (4096=
 kB)<br>[=A0=A0=A0 0.004000]=A0=A0=A0=A0 vmalloc : 0xf7ffe000 - 0xff7fe000=
=A0=A0 ( 120 MB)<br>
[=A0=A0=A0 0.004000]=A0=A0=A0=A0 lowmem=A0 : 0xc0000000 - 0xf77fe000=A0=A0 =
( 887 MB)<br>[=A0=A0=A0 0.004000]=A0=A0=A0=A0=A0=A0 .init : 0xc04ee000 - 0x=
c0551000=A0=A0 ( 396 kB)<br>[=A0=A0=A0 0.004000]=A0=A0=A0=A0=A0=A0 .data : =
0xc03b4e12 - 0xc04e4608=A0=A0 (1213 kB)<br>[=A0=A0=A0 0.004000]=A0=A0=A0=A0=
=A0=A0 .text : 0xc0100000 - 0xc03b4e12=A0=A0 (2771 kB)<br>
[=A0=A0=A0 0.004000] Checking if this processor honours the WP bit even in =
supervisor mode...Ok.<br>[=A0=A0=A0 0.004000] SLUB: Genslabs=3D13, HWalign=
=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D1<br>[=A0=A0=A0 0.004=
014] Calibrating delay loop (skipped), value calculated using timer frequen=
cy.. 3325.34 BogoMIPS (lpj=3D6650680)<br>
[=A0=A0=A0 0.004152] Security Framework initialized<br>[=A0=A0=A0 0.004210]=
 SELinux:=A0 Disabled at boot.<br>[=A0=A0=A0 0.004266] Mount-cache hash tab=
le entries: 512<br>[=A0=A0=A0 0.004504] Initializing cgroup subsys ns<br>[=
=A0=A0=A0 0.004558] Initializing cgroup subsys cpuacct<br>
[=A0=A0=A0 0.004611] Initializing cgroup subsys memory<br>[=A0=A0=A0 0.0046=
81] CPU: L1 I cache: 32K, L1 D cache: 32K<br>[=A0=A0=A0 0.004763] CPU: L2 c=
ache: 2048K<br>[=A0=A0=A0 0.004814] CPU: Physical Processor ID: 0<br>[=A0=
=A0=A0 0.004862] CPU: Processor Core ID: 0<br>
[=A0=A0=A0 0.004922] Checking &#39;hlt&#39; instruction... OK.<br>[=A0=A0=
=A0 0.021054] ExtINT not setup in hardware but reported by MP table<br>[=A0=
=A0=A0 0.021446] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D0 pin2=
=3D0<br>[=A0=A0=A0 0.024001] ..MP-BIOS bug: 8254 timer not connected to IO-=
APIC<br>
[=A0=A0=A0 0.024001] ...trying to set up timer (IRQ0) through the 8259A ...=
<br>[=A0=A0=A0 0.024001] ..... (found apic 0 pin 0) ...<br>[=A0=A0=A0 0.069=
047] ....... works.<br>[=A0=A0=A0 0.069095] CPU0: Intel(R) Core(TM)2 CPU=A0=
=A0=A0=A0=A0=A0=A0=A0 T5500=A0 @ 1.66GHz stepping 06<br>
[=A0=A0=A0 0.176265] Booting processor 1 APIC 0x1 ip 0x6000<br>[=A0=A0=A0 0=
.004000] Initializing CPU#1<br>[=A0=A0=A0 0.004000] Calibrating delay using=
 timer specific routine.. 4655.35 BogoMIPS (lpj=3D9310715)<br>[=A0=A0=A0 0.=
004000] CPU: L1 I cache: 32K, L1 D cache: 32K<br>
[=A0=A0=A0 0.004000] CPU: L2 cache: 2048K<br>[=A0=A0=A0 0.004000] CPU: Phys=
ical Processor ID: 0<br>[=A0=A0=A0 0.004000] CPU: Processor Core ID: 1<br>[=
=A0=A0=A0 0.268479] CPU1: Intel(R) Core(TM)2 CPU=A0=A0=A0=A0=A0=A0=A0=A0 T5=
500=A0 @ 1.66GHz stepping 06<br>[=A0=A0=A0 0.268911] checking TSC synchroni=
zation [CPU#0 -&gt; CPU#1]: passed.<br>
[=A0=A0=A0 0.272038] Brought up 2 CPUs<br>[=A0=A0=A0 0.272088] Total of 2 p=
rocessors activated (7980.69 BogoMIPS).<br>[=A0=A0=A0 0.272217] CPU0 attach=
ing sched-domain:<br>[=A0=A0=A0 0.272221]=A0 domain 0: span 0-1 level MC<br=
>[=A0=A0=A0 0.272225]=A0=A0 groups: 0 1<br>
[=A0=A0=A0 0.272233] CPU1 attaching sched-domain:<br>[=A0=A0=A0 0.272236]=
=A0 domain 0: span 0-1 level MC<br>[=A0=A0=A0 0.272239]=A0=A0 groups: 1 0<b=
r>[=A0=A0=A0 0.272322] net_namespace: 1056 bytes<br>[=A0=A0=A0 0.272322] Ti=
me: 13:36:52=A0 Date: 09/17/09<br>[=A0=A0=A0 0.272322] NET: Registered prot=
ocol family 16<br>
[=A0=A0=A0 0.272322] EISA bus registered<br>[=A0=A0=A0 0.272322] PCI: PCI B=
IOS revision 2.10 entry at 0xfd875, last bus=3D7<br>[=A0=A0=A0 0.272322] PC=
I: Using configuration type 1 for base access<br>[=A0=A0=A0 0.276037] bio: =
create slab &lt;bio-0&gt; at 0<br>
[=A0=A0=A0 0.276093] PCI: Probing PCI hardware<br>[=A0=A0=A0 0.276093] PCI:=
 Probing PCI hardware (bus 00)<br>[=A0=A0=A0 0.276093] pci 0000:00:02.0: re=
g 10 32bit mmio: [0xdc100000-0xdc17ffff]<br>[=A0=A0=A0 0.276095] pci 0000:0=
0:02.0: reg 14 io port: [0x1800-0x1807]<br>
[=A0=A0=A0 0.276102] pci 0000:00:02.0: reg 18 32bit mmio: [0xc0000000-0xcff=
fffff]<br>[=A0=A0=A0 0.276109] pci 0000:00:02.0: reg 1c 32bit mmio: [0xdc20=
0000-0xdc23ffff]<br>[=A0=A0=A0 0.276164] pci 0000:00:02.1: reg 10 32bit mmi=
o: [0xdc180000-0xdc1fffff]<br>
[=A0=A0=A0 0.276308] pci 0000:00:1b.0: reg 10 64bit mmio: [0xdc240000-0xdc2=
43fff]<br>[=A0=A0=A0 0.276380] pci 0000:00:1b.0: PME# supported from D0 D3h=
ot D3cold<br>[=A0=A0=A0 0.276438] pci 0000:00:1b.0: PME# disabled<br>[=A0=
=A0=A0 0.276584] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold<br>
[=A0=A0=A0 0.276641] pci 0000:00:1c.0: PME# disabled<br>[=A0=A0=A0 0.276793=
] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold<br>[=A0=A0=A0 0.276=
848] pci 0000:00:1c.1: PME# disabled<br>[=A0=A0=A0 0.277001] pci 0000:00:1c=
.2: PME# supported from D0 D3hot D3cold<br>
[=A0=A0=A0 0.277058] pci 0000:00:1c.2: PME# disabled<br>[=A0=A0=A0 0.277185=
] pci 0000:00:1d.0: reg 20 io port: [0x1820-0x183f]<br>[=A0=A0=A0 0.277262]=
 pci 0000:00:1d.1: reg 20 io port: [0x1840-0x185f]<br>[=A0=A0=A0 0.277339] =
pci 0000:00:1d.2: reg 20 io port: [0x1860-0x187f]<br>
[=A0=A0=A0 0.280010] pci 0000:00:1d.3: reg 20 io port: [0x1880-0x189f]<br>[=
=A0=A0=A0 0.280093] pci 0000:00:1d.7: reg 10 32bit mmio: [0xdc444000-0xdc44=
43ff]<br>[=A0=A0=A0 0.280167] pci 0000:00:1d.7: PME# supported from D0 D3ho=
t D3cold<br>[=A0=A0=A0 0.280227] pci 0000:00:1d.7: PME# disabled<br>
[=A0=A0=A0 0.280473] pci 0000:00:1f.0: quirk: region 1000-107f claimed by I=
CH6 ACPI/GPIO/TCO<br>[=A0=A0=A0 0.280547] pci 0000:00:1f.0: quirk: region 1=
180-11bf claimed by ICH6 GPIO<br>[=A0=A0=A0 0.280607] pci 0000:00:1f.0: ICH=
7 LPC Generic IO decode 1 PIO at 0400 (mask 0003)<br>
[=A0=A0=A0 0.280679] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at =
1640 (mask 007f)<br>[=A0=A0=A0 0.280827] pci 0000:00:1f.2: reg 10 io port: =
[0x00-0x07]<br>[=A0=A0=A0 0.280837] pci 0000:00:1f.2: reg 14 io port: [0x00=
-0x03]<br>[=A0=A0=A0 0.280847] pci 0000:00:1f.2: reg 18 io port: [0x00-0x07=
]<br>
[=A0=A0=A0 0.280857] pci 0000:00:1f.2: reg 1c io port: [0x00-0x03]<br>[=A0=
=A0=A0 0.280867] pci 0000:00:1f.2: reg 20 io port: [0x18b0-0x18bf]<br>[=A0=
=A0=A0 0.280909] pci 0000:00:1f.2: PME# supported from D3hot<br>[=A0=A0=A0 =
0.280965] pci 0000:00:1f.2: PME# disabled<br>
[=A0=A0=A0 0.281086] pci 0000:00:1f.3: reg 20 io port: [0x18c0-0x18df]<br>[=
=A0=A0=A0 0.281276] pci 0000:00:1c.1: bridge io port: [0x2000-0x2fff]<br>[=
=A0=A0=A0 0.281283] pci 0000:00:1c.1: bridge 32bit mmio: [0xd8000000-0xd9ff=
ffff]<br>[=A0=A0=A0 0.281294] pci 0000:00:1c.1: bridge 64bit mmio pref: [0x=
d2000000-0xd3ffffff]<br>
[=A0=A0=A0 0.281482] pci 0000:05:00.0: reg 10 32bit mmio: [0xda000000-0xda0=
00fff]<br>[=A0=A0=A0 0.281737] pci 0000:05:00.0: PME# supported from D0 D3h=
ot D3cold<br>[=A0=A0=A0 0.281802] pci 0000:05:00.0: PME# disabled<br>[=A0=
=A0=A0 0.281958] pci 0000:00:1c.2: bridge io port: [0x3000-0x3fff]<br>
[=A0=A0=A0 0.281965] pci 0000:00:1c.2: bridge 32bit mmio: [0xda000000-0xdbf=
fffff]<br>[=A0=A0=A0 0.281975] pci 0000:00:1c.2: bridge 64bit mmio pref: [0=
xd4000000-0xd5ffffff]<br>[=A0=A0=A0 0.282045] pci 0000:07:06.0: reg 10 32bi=
t mmio: [0x000000-0x000fff]<br>
[=A0=A0=A0 0.282078] pci 0000:07:06.0: supports D1 D2<br>[=A0=A0=A0 0.28208=
1] pci 0000:07:06.0: PME# supported from D0 D1 D2 D3hot D3cold<br>[=A0=A0=
=A0 0.282140] pci 0000:07:06.0: PME# disabled<br>[=A0=A0=A0 0.282243] pci 0=
000:07:06.1: reg 10 32bit mmio: [0xdc006000-0xdc0067ff]<br>
[=A0=A0=A0 0.282254] pci 0000:07:06.1: reg 14 32bit mmio: [0xdc000000-0xdc0=
03fff]<br>[=A0=A0=A0 0.282325] pci 0000:07:06.1: supports D1 D2<br>[=A0=A0=
=A0 0.282328] pci 0000:07:06.1: PME# supported from D0 D1 D2 D3hot<br>[=A0=
=A0=A0 0.282387] pci 0000:07:06.1: PME# disabled<br>
[=A0=A0=A0 0.282485] pci 0000:07:06.2: reg 10 32bit mmio: [0xdc004000-0xdc0=
04fff]<br>[=A0=A0=A0 0.282559] pci 0000:07:06.2: supports D1 D2<br>[=A0=A0=
=A0 0.282562] pci 0000:07:06.2: PME# supported from D0 D1 D2 D3hot<br>[=A0=
=A0=A0 0.282621] pci 0000:07:06.2: PME# disabled<br>
[=A0=A0=A0 0.282722] pci 0000:07:06.3: reg 10 32bit mmio: [0xdc006800-0xdc0=
068ff]<br>[=A0=A0=A0 0.282794] pci 0000:07:06.3: supports D1 D2<br>[=A0=A0=
=A0 0.282797] pci 0000:07:06.3: PME# supported from D0 D1 D2 D3hot<br>[=A0=
=A0=A0 0.282854] pci 0000:07:06.3: PME# disabled<br>
[=A0=A0=A0 0.282961] pci 0000:07:08.0: reg 10 32bit mmio: [0xdc005000-0xdc0=
05fff]<br>[=A0=A0=A0 0.282971] pci 0000:07:08.0: reg 14 io port: [0x4000-0x=
403f]<br>[=A0=A0=A0 0.283033] pci 0000:07:08.0: supports D1 D2<br>[=A0=A0=
=A0 0.283036] pci 0000:07:08.0: PME# supported from D0 D1 D2 D3hot D3cold<b=
r>
[=A0=A0=A0 0.283093] pci 0000:07:08.0: PME# disabled<br>[=A0=A0=A0 0.283197=
] pci 0000:00:1e.0: transparent bridge<br>[=A0=A0=A0 0.283250] pci 0000:00:=
1e.0: bridge io port: [0x4000-0x4fff]<br>[=A0=A0=A0 0.283257] pci 0000:00:1=
e.0: bridge 32bit mmio: [0xdc000000-0xdc0fffff]<br>
[=A0=A0=A0 0.284472] PCI: Discovered primary peer bus 01 [IRQ]<br>[=A0=A0=
=A0 0.284548] pci 0000:00:1f.0: PIIX/ICH IRQ router [8086:27b9]<br>[=A0=A0=
=A0 0.284629] pci 0000:00:02.0: PCI-&gt;APIC IRQ transform: INT A -&gt; IRQ=
 16<br>[=A0=A0=A0 0.284690] pci 0000:00:1b.0: PCI-&gt;APIC IRQ transform: I=
NT A -&gt; IRQ 22<br>
[=A0=A0=A0 0.284748] pci 0000:00:1c.0: PCI-&gt;APIC IRQ transform: INT A -&=
gt; IRQ 17<br>[=A0=A0=A0 0.284806] pci 0000:00:1c.1: PCI-&gt;APIC IRQ trans=
form: INT B -&gt; IRQ 16<br>[=A0=A0=A0 0.284864] pci 0000:00:1c.2: PCI-&gt;=
APIC IRQ transform: INT C -&gt; IRQ 18<br>
[=A0=A0=A0 0.284922] pci 0000:00:1d.0: PCI-&gt;APIC IRQ transform: INT A -&=
gt; IRQ 23<br>[=A0=A0=A0 0.284981] pci 0000:00:1d.1: PCI-&gt;APIC IRQ trans=
form: INT B -&gt; IRQ 19<br>[=A0=A0=A0 0.285038] pci 0000:00:1d.2: PCI-&gt;=
APIC IRQ transform: INT C -&gt; IRQ 18<br>
[=A0=A0=A0 0.285928] pci 0000:00:1d.3: PCI-&gt;APIC IRQ transform: INT D -&=
gt; IRQ 16<br>[=A0=A0=A0 0.285987] pci 0000:00:1d.7: PCI-&gt;APIC IRQ trans=
form: INT A -&gt; IRQ 23<br>[=A0=A0=A0 0.286050] pci 0000:00:1f.2: PCI-&gt;=
APIC IRQ transform: INT B -&gt; IRQ 19<br>
[=A0=A0=A0 0.286109] pci 0000:00:1f.3: PCI-&gt;APIC IRQ transform: INT B -&=
gt; IRQ 19<br>[=A0=A0=A0 0.286211] pci 0000:05:00.0: PCI-&gt;APIC IRQ trans=
form: INT A -&gt; IRQ 18<br>[=A0=A0=A0 0.286271] pci 0000:07:06.0: PCI-&gt;=
APIC IRQ transform: INT A -&gt; IRQ 18<br>
[=A0=A0=A0 0.286329] pci 0000:07:06.1: PCI-&gt;APIC IRQ transform: INT B -&=
gt; IRQ 17<br>[=A0=A0=A0 0.286387] pci 0000:07:06.2: PCI-&gt;APIC IRQ trans=
form: INT A -&gt; IRQ 18<br>[=A0=A0=A0 0.286447] pci 0000:07:06.3: PCI-&gt;=
APIC IRQ transform: INT A -&gt; IRQ 18<br>
[=A0=A0=A0 0.286505] pci 0000:07:08.0: PCI-&gt;APIC IRQ transform: INT A -&=
gt; IRQ 20<br>[=A0=A0=A0 0.304024] NET: Registered protocol family 8<br>[=
=A0=A0=A0 0.304076] NET: Registered protocol family 20<br>[=A0=A0=A0 0.3041=
57] NetLabel: Initializing<br>
[=A0=A0=A0 0.304157] NetLabel:=A0 domain hash size =3D 128<br>[=A0=A0=A0 0.=
304157] NetLabel:=A0 protocols =3D UNLABELED CIPSOv4<br>[=A0=A0=A0 0.304174=
] NetLabel:=A0 unlabeled traffic allowed by default<br>[=A0=A0=A0 0.304340]=
 PnPBIOS: Scanning system for PnP BIOS support...<br>
[=A0=A0=A0 0.304396] PnPBIOS: Found PnP BIOS installation structure at 0xc0=
0f65e0<br>[=A0=A0=A0 0.304453] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000=
:0xbf0f, dseg 0x400<br>[=A0=A0=A0 0.304857] pnp 00:0e: io resource (0x1000-=
0x105f) overlaps 0000:00:1f.0 BAR 7 (0x1000-0x107f), disabling<br>
[=A0=A0=A0 0.304934] pnp 00:0e: io resource (0x1060-0x107f) overlaps 0000:0=
0:1f.0 BAR 7 (0x1000-0x107f), disabling<br>[=A0=A0=A0 0.306223] PnPBIOS: 25=
 nodes reported by PnP BIOS; 25 recorded by driver<br>[=A0=A0=A0 0.306291] =
system 00:00: ioport range 0x680-0x6ff has been reserved<br>
[=A0=A0=A0 0.306347] system 00:00: ioport range 0x1640-0x164f has been rese=
rved<br>[=A0=A0=A0 0.306404] system 00:00: iomem range 0xe0000000-0xeffffff=
f has been reserved<br>[=A0=A0=A0 0.306464] system 00:00: iomem range 0xfed=
14000-0xfed17fff has been reserved<br>
[=A0=A0=A0 0.306522] system 00:00: iomem range 0xfed18000-0xfed18fff has be=
en reserved<br>[=A0=A0=A0 0.306578] system 00:00: iomem range 0xfed19000-0x=
fed19fff has been reserved<br>[=A0=A0=A0 0.306648] system 00:0a: iomem rang=
e 0xe0000-0xe17ff could not be reserved<br>
[=A0=A0=A0 0.306708] system 00:0b: iomem range 0xfee00000-0xfee00fff has be=
en reserved<br>[=A0=A0=A0 0.306769] system 00:0c: iomem range 0xdc000-0xdff=
ff could not be reserved<br>[=A0=A0=A0 0.306831] system 00:0e: ioport range=
 0x4d0-0x4d1 has been reserved<br>
[=A0=A0=A0 0.306887] system 00:0e: ioport range 0x1180-0x11bf has been rese=
rved<br>[=A0=A0=A0 0.306943] system 00:0e: iomem range 0xfed00000-0xfed033f=
f could not be reserved<br>[=A0=A0=A0 0.308008] system 00:0e: iomem range 0=
xfed20000-0xfed3ffff has been reserved<br>
[=A0=A0=A0 0.308065] system 00:0e: iomem range 0xfed45000-0xfed8ffff has be=
en reserved<br>[=A0=A0=A0 0.308122] system 00:0e: iomem range 0xfef00000-0x=
feffffff has been reserved<br>[=A0=A0=A0 0.308178] system 00:0e: iomem rang=
e 0xfed1c000-0xfed1ffff has been reserved<br>
[=A0=A0=A0 0.308239] system 00:0f: iomem range 0xfec00000-0xfec0ffff has be=
en reserved<br>[=A0=A0=A0 0.308299] system 00:10: iomem range 0xfec10000-0x=
fec17fff has been reserved<br>[=A0=A0=A0 0.308360] system 00:11: iomem rang=
e 0xfec18000-0xfec1ffff has been reserved<br>
[=A0=A0=A0 0.308420] system 00:12: iomem range 0xfec20000-0xfec27fff has be=
en reserved<br>[=A0=A0=A0 0.308482] system 00:13: iomem range 0xfec28000-0x=
fec2ffff has been reserved<br>[=A0=A0=A0 0.308542] system 00:14: iomem rang=
e 0xfec30000-0xfec37fff has been reserved<br>
[=A0=A0=A0 0.308603] system 00:15: iomem range 0xfec38000-0xfec3ffff has be=
en reserved<br>[=A0=A0=A0 0.308664] system 00:17: iomem range 0xce600-0xce7=
ff has been reserved<br>[=A0=A0=A0 0.309402] pci 0000:00:1c.0: PCI bridge, =
secondary bus 0000:02<br>
[=A0=A0=A0 0.309457] pci 0000:00:1c.0:=A0=A0 IO window: disabled<br>[=A0=A0=
=A0 0.309515] pci 0000:00:1c.0:=A0=A0 MEM window: disabled<br>[=A0=A0=A0 0.=
309571] pci 0000:00:1c.0:=A0=A0 PREFETCH window: disabled<br>[=A0=A0=A0 0.3=
09631] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:03<br>
[=A0=A0=A0 0.309687] pci 0000:00:1c.1:=A0=A0 IO window: 0x2000-0x2fff<br>[=
=A0=A0=A0 0.309745] pci 0000:00:1c.1:=A0=A0 MEM window: 0xd8000000-0xd9ffff=
ff<br>[=A0=A0=A0 0.309804] pci 0000:00:1c.1:=A0=A0 PREFETCH window: 0x00000=
0d2000000-0x000000d3ffffff<br>
[=A0=A0=A0 0.309881] pci 0000:00:1c.2: PCI bridge, secondary bus 0000:05<br=
>[=A0=A0=A0 0.309936] pci 0000:00:1c.2:=A0=A0 IO window: 0x3000-0x3fff<br>[=
=A0=A0=A0 0.309993] pci 0000:00:1c.2:=A0=A0 MEM window: 0xda000000-0xdbffff=
ff<br>[=A0=A0=A0 0.310051] pci 0000:00:1c.2:=A0=A0 PREFETCH window: 0x00000=
0d4000000-0x000000d5ffffff<br>
[=A0=A0=A0 0.310136] pci 0000:07:06.0: CardBus bridge, secondary bus 0000:0=
8<br>[=A0=A0=A0 0.310191] pci 0000:07:06.0:=A0=A0 IO window: 0x004400-0x004=
4ff<br>[=A0=A0=A0 0.310248] pci 0000:07:06.0:=A0=A0 IO window: 0x004800-0x0=
048ff<br>[=A0=A0=A0 0.310306] pci 0000:07:06.0:=A0=A0 PREFETCH window: 0xa4=
000000-0xa7ffffff<br>
[=A0=A0=A0 0.310365] pci 0000:07:06.0:=A0=A0 MEM window: 0xa8000000-0xabfff=
fff<br>[=A0=A0=A0 0.310423] pci 0000:00:1e.0: PCI bridge, secondary bus 000=
0:07<br>[=A0=A0=A0 0.310480] pci 0000:00:1e.0:=A0=A0 IO window: 0x4000-0x4f=
ff<br>[=A0=A0=A0 0.310540] pci 0000:00:1e.0:=A0=A0 MEM window: 0xdc000000-0=
xdc0fffff<br>
[=A0=A0=A0 0.310597] pci 0000:00:1e.0:=A0=A0 PREFETCH window: 0x000000a4000=
000-0x000000a7ffffff<br>[=A0=A0=A0 0.310688] pci 0000:00:1c.0: setting late=
ncy timer to 64<br>[=A0=A0=A0 0.310705] pci 0000:00:1c.1: setting latency t=
imer to 64<br>[=A0=A0=A0 0.310721] pci 0000:00:1c.2: setting latency timer =
to 64<br>
[=A0=A0=A0 0.310732] pci 0000:00:1e.0: setting latency timer to 64<br>[=A0=
=A0=A0 0.310743] pci 0000:07:06.0: enabling device (0000 -&gt; 0003)<br>[=
=A0=A0=A0 0.310810] pci_bus 0000:00: resource 0 io:=A0 [0x00-0xffff]<br>[=
=A0=A0=A0 0.310813] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]<=
br>
[=A0=A0=A0 0.310817] pci_bus 0000:03: resource 0 io:=A0 [0x2000-0x2fff]<br>=
[=A0=A0=A0 0.310820] pci_bus 0000:03: resource 1 mem: [0xd8000000-0xd9fffff=
f]<br>[=A0=A0=A0 0.310824] pci_bus 0000:03: resource 2 pref mem [0xd2000000=
-0xd3ffffff]<br>
[=A0=A0=A0 0.310828] pci_bus 0000:05: resource 0 io:=A0 [0x3000-0x3fff]<br>=
[=A0=A0=A0 0.310831] pci_bus 0000:05: resource 1 mem: [0xda000000-0xdbfffff=
f]<br>[=A0=A0=A0 0.310835] pci_bus 0000:05: resource 2 pref mem [0xd4000000=
-0xd5ffffff]<br>
[=A0=A0=A0 0.310838] pci_bus 0000:07: resource 0 io:=A0 [0x4000-0x4fff]<br>=
[=A0=A0=A0 0.310842] pci_bus 0000:07: resource 1 mem: [0xdc000000-0xdc0ffff=
f]<br>[=A0=A0=A0 0.310845] pci_bus 0000:07: resource 2 pref mem [0xa4000000=
-0xa7ffffff]<br>
[=A0=A0=A0 0.310849] pci_bus 0000:07: resource 3 io:=A0 [0x00-0xffff]<br>[=
=A0=A0=A0 0.310852] pci_bus 0000:07: resource 4 mem: [0x000000-0xffffffff]<=
br>[=A0=A0=A0 0.310855] pci_bus 0000:08: resource 0 io:=A0 [0x4400-0x44ff]<=
br>[=A0=A0=A0 0.310859] pci_bus 0000:08: resource 1 io:=A0 [0x4800-0x48ff]<=
br>
[=A0=A0=A0 0.310862] pci_bus 0000:08: resource 2 pref mem [0xa4000000-0xa7f=
fffff]<br>[=A0=A0=A0 0.310866] pci_bus 0000:08: resource 3 mem: [0xa8000000=
-0xabffffff]<br>[=A0=A0=A0 0.310869] pci_bus 0000:01: resource 0 io:=A0 [0x=
00-0xffff]<br>[=A0=A0=A0 0.310873] pci_bus 0000:01: resource 1 mem: [0x0000=
00-0xffffffff]<br>
[=A0=A0=A0 0.310907] NET: Registered protocol family 2<br>[=A0=A0=A0 0.3520=
31] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)<br>[=
=A0=A0=A0 0.352406] TCP established hash table entries: 131072 (order: 8, 1=
048576 bytes)<br>
[=A0=A0=A0 0.352967] TCP bind hash table entries: 65536 (order: 7, 524288 b=
ytes)<br>[=A0=A0=A0 0.353293] TCP: Hash tables configured (established 1310=
72 bind 65536)<br>[=A0=A0=A0 0.353349] TCP reno registered<br>[=A0=A0=A0 0.=
364049] NET: Registered protocol family 1<br>
[=A0=A0=A0 0.364173] Trying to unpack rootfs image as initramfs...<br>[=A0=
=A0=A0 2.165491] Freeing initrd memory: 52905k freed<br>[=A0=A0=A0 2.201774=
] audit: initializing netlink socket (disabled)<br>[=A0=A0=A0 2.201855] typ=
e=3D2000 audit(1253194614.199:1): initialized<br>
[=A0=A0=A0 2.208588] I-pipe: Domain Xenomai registered.<br>[=A0=A0=A0 2.208=
701] Xenomai: hal/i386 started.<br>[=A0=A0=A0 2.210638] Xenomai: real-time =
nucleus v2.4.9.1 (Big Bad Moon) loaded.<br>[=A0=A0=A0 2.210866] Xenomai: SM=
I-enabled chipset found, but SMI workaround disabled<br>
[=A0=A0=A0 2.210868]=A0=A0=A0=A0=A0=A0=A0=A0=A0 (check CONFIG_XENO_HW_SMI_W=
ORKAROUND). You may encounter<br>[=A0=A0=A0 2.210869]=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 high interrupt latencies!<br>[=A0=A0=A0 2.211078] Xenomai: starting =
native API services.<br>[=A0=A0=A0 2.211813] Xenomai: starting POSIX servic=
es.<br>
[=A0=A0=A0 2.211910] Xenomai: starting RTDM services.<br>[=A0=A0=A0 2.21219=
2] highmem bounce pool size: 64 pages<br>[=A0=A0=A0 2.212248] HugeTLB regis=
tered 4 MB page size, pre-allocated 0 pages<br>[=A0=A0=A0 2.220241] VFS: Di=
sk quotas dquot_6.5.2<br>
[=A0=A0=A0 2.220409] Dquot-cache hash table entries: 1024 (order 0, 4096 by=
tes)<br>[=A0=A0=A0 2.220611] msgmni has been set to 1698<br>[=A0=A0=A0 2.22=
0971] alg: No test for stdrng (krng)<br>[=A0=A0=A0 2.221037] io scheduler n=
oop registered<br>[=A0=A0=A0 2.221089] io scheduler anticipatory registered=
<br>
[=A0=A0=A0 2.221140] io scheduler deadline registered<br>[=A0=A0=A0 2.22128=
6] io scheduler cfq registered (default)<br>[=A0=A0=A0 2.221351] pci 0000:0=
0:02.0: Boot video device<br>[=A0=A0=A0 2.599461] Clocksource tsc unstable =
(delta =3D -153132033 ns)<br>
[=A0=A0=A0 3.647965] pci 0000:00:1d.7: EHCI: BIOS handoff failed (BIOS bug?=
) 01010001<br>[=A0=A0=A0 3.648163] pci 0000:07:08.0: Firmware left e100 int=
errupts enabled; disabling<br>[=A0=A0=A0 3.648320] pcieport-driver 0000:00:=
1c.0: irq 24 for MSI/MSI-X<br>
[=A0=A0=A0 3.648320] pcieport-driver 0000:00:1c.0: setting latency timer to=
 64<br>[=A0=A0=A0 3.648320] pcieport-driver 0000:00:1c.1: irq 25 for MSI/MS=
I-X<br>[=A0=A0=A0 3.648320] pcieport-driver 0000:00:1c.1: setting latency t=
imer to 64<br>
[=A0=A0=A0 3.648320] pcieport-driver 0000:00:1c.2: irq 26 for MSI/MSI-X<br>=
[=A0=A0=A0 3.648320] pcieport-driver 0000:00:1c.2: setting latency timer to=
 64<br>[=A0=A0=A0 3.648320] isapnp: Scanning for PnP cards...<br>[=A0=A0=A0=
 4.317659] isapnp: No Plug &amp; Play device found<br>
[=A0=A0=A0 4.420097] Serial: 8250/16550 driver, 4 ports, IRQ sharing enable=
d<br>[=A0=A0=A0 4.428069] brd: module loaded<br>[=A0=A0=A0 4.428207] input:=
 Macintosh mouse button emulation as /devices/virtual/input/input0<br>[=A0=
=A0=A0 4.436039] PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,=
12<br>
[=A0=A0=A0 4.437658] i8042.c: Detected active multiplexing controller, rev =
1.1.<br>[=A0=A0=A0 4.440782] serio: i8042 KBD port at 0x60,0x64 irq 1<br>[=
=A0=A0=A0 4.440838] serio: i8042 AUX0 port at 0x60,0x64 irq 12<br>[=A0=A0=
=A0 4.440896] serio: i8042 AUX1 port at 0x60,0x64 irq 12<br>
[=A0=A0=A0 4.440950] serio: i8042 AUX2 port at 0x60,0x64 irq 12<br>[=A0=A0=
=A0 4.441004] serio: i8042 AUX3 port at 0x60,0x64 irq 12<br>[=A0=A0=A0 4.44=
1124] mice: PS/2 mouse device common for all mice<br>[=A0=A0=A0 4.441124] r=
tc_cmos 00:06: rtc core: registered rtc_cmos as rtc0<br>
[=A0=A0=A0 4.441124] rtc0: alarms up to one day, 114 bytes nvram<br>[=A0=A0=
=A0 4.441124] EISA: Probing bus 0 at eisa.0<br>[=A0=A0=A0 4.441124] Cannot =
allocate resource for EISA slot 1<br>[=A0=A0=A0 4.441124] Cannot allocate r=
esource for EISA slot 2<br>
[=A0=A0=A0 4.441124] Cannot allocate resource for EISA slot 3<br>[=A0=A0=A0=
 4.441124] Cannot allocate resource for EISA slot 4<br>[=A0=A0=A0 4.441124]=
 EISA: Detected 0 cards.<br>[=A0=A0=A0 4.441124] cpuidle: using governor la=
dder<br>[=A0=A0=A0 4.441124] cpuidle: using governor menu<br>
[=A0=A0=A0 4.441124] TCP cubic registered<br>[=A0=A0=A0 4.441124] Using IPI=
 No-Shortcut mode<br>[=A0=A0=A0 4.441124] PM: Resume from disk failed.<br>[=
=A0=A0=A0 4.441124] registered taskstats version 1<br>[=A0=A0=A0 4.441124]=
=A0=A0 Magic number: 9:255:635<br>
[=A0=A0=A0 4.441124] tty ptyce: hash matches<br>[=A0=A0=A0 4.441124] pci_ex=
press 0000:00:1c.1:pcie01: hash matches<br>[=A0=A0=A0 4.441124] rtc_cmos 00=
:06: setting system clock to 2009-09-17 13:36:56 UTC (1253194616)<br>[=A0=
=A0=A0 4.441124] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found<br>
[=A0=A0=A0 4.441124] EDD information not available.<br>[=A0=A0=A0 4.444054]=
 Freeing unused kernel memory: 396k freed<br>[=A0=A0=A0 4.444387] Write pro=
tecting the kernel text: 2772k<br>[=A0=A0=A0 4.444476] Write protecting the=
 kernel read-only data: 992k<br>
[=A0=A0=A0 4.492141] input: AT Translated Set 2 keyboard as /devices/platfo=
rm/i8042/serio0/input/input1<br>[=A0=A0=A0 4.648023] fuse init (API version=
 7.11)<br>[=A0=A0=A0 5.142470] usbcore: registered new interface driver usb=
fs<br>[=A0=A0=A0 5.142554] usbcore: registered new interface driver hub<br>
[=A0=A0=A0 5.142640] usbcore: registered new device driver usb<br>[=A0=A0=
=A0 5.151538] uhci_hcd: USB Universal Host Controller Interface driver<br>[=
=A0=A0=A0 5.152018] uhci_hcd 0000:00:1d.0: setting latency timer to 64<br>[=
=A0=A0=A0 5.152023] uhci_hcd 0000:00:1d.0: UHCI Host Controller<br>
[=A0=A0=A0 5.152137] uhci_hcd 0000:00:1d.0: new USB bus registered, assigne=
d bus number 1<br>[=A0=A0=A0 5.156008] uhci_hcd 0000:00:1d.0: irq 23, io ba=
se 0x00001820<br>[=A0=A0=A0 5.156249] usb usb1: configuration #1 chosen fro=
m 1 choice<br>
[=A0=A0=A0 5.156340] hub 1-0:1.0: USB hub found<br>[=A0=A0=A0 5.156398] hub=
 1-0:1.0: 2 ports detected<br>[=A0=A0=A0 5.156624] uhci_hcd 0000:00:1d.1: s=
etting latency timer to 64<br>[=A0=A0=A0 5.156629] uhci_hcd 0000:00:1d.1: U=
HCI Host Controller<br>
[=A0=A0=A0 5.156708] uhci_hcd 0000:00:1d.1: new USB bus registered, assigne=
d bus number 2<br>[=A0=A0=A0 5.160166] uhci_hcd 0000:00:1d.1: irq 19, io ba=
se 0x00001840<br>[=A0=A0=A0 5.160345] usb usb2: configuration #1 chosen fro=
m 1 choice<br>
[=A0=A0=A0 5.160434] hub 2-0:1.0: USB hub found<br>[=A0=A0=A0 5.160493] hub=
 2-0:1.0: 2 ports detected<br>[=A0=A0=A0 5.160674] uhci_hcd 0000:00:1d.2: s=
etting latency timer to 64<br>[=A0=A0=A0 5.160679] uhci_hcd 0000:00:1d.2: U=
HCI Host Controller<br>
[=A0=A0=A0 5.167977] uhci_hcd 0000:00:1d.2: new USB bus registered, assigne=
d bus number 3<br>[=A0=A0=A0 5.168080] uhci_hcd 0000:00:1d.2: irq 18, io ba=
se 0x00001860<br>[=A0=A0=A0 5.169125] usb usb3: configuration #1 chosen fro=
m 1 choice<br>
[=A0=A0=A0 5.169213] hub 3-0:1.0: USB hub found<br>[=A0=A0=A0 5.169271] hub=
 3-0:1.0: 2 ports detected<br>[=A0=A0=A0 5.169452] uhci_hcd 0000:00:1d.3: s=
etting latency timer to 64<br>[=A0=A0=A0 5.169457] uhci_hcd 0000:00:1d.3: U=
HCI Host Controller<br>
[=A0=A0=A0 5.169539] uhci_hcd 0000:00:1d.3: new USB bus registered, assigne=
d bus number 4<br>[=A0=A0=A0 5.169642] uhci_hcd 0000:00:1d.3: irq 16, io ba=
se 0x00001880<br>[=A0=A0=A0 5.169809] usb usb4: configuration #1 chosen fro=
m 1 choice<br>
[=A0=A0=A0 5.169896] hub 4-0:1.0: USB hub found<br>[=A0=A0=A0 5.169959] hub=
 4-0:1.0: 2 ports detected<br>[=A0=A0=A0 5.180241] ehci_hcd: USB 2.0 &#39;E=
nhanced&#39; Host Controller (EHCI) Driver<br>[=A0=A0=A0 5.180302] Warning!=
 ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after<b=
r>
[=A0=A0=A0 5.180427] ehci_hcd 0000:00:1d.7: setting latency timer to 64<br>=
[=A0=A0=A0 5.180433] ehci_hcd 0000:00:1d.7: EHCI Host Controller<br>[=A0=A0=
=A0 5.180527] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus n=
umber 5<br>[=A0=A0=A0 5.184490] ehci_hcd 0000:00:1d.7: debug port 1<br>
[=A0=A0=A0 5.184550] ehci_hcd 0000:00:1d.7: cache line size of 32 is not su=
pported<br>[=A0=A0=A0 5.184560] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xdc4=
44000<br>[=A0=A0=A0 5.189138] SCSI subsystem initialized<br>[=A0=A0=A0 5.22=
7956] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00<br>
[=A0=A0=A0 5.227956] usb usb5: configuration #1 chosen from 1 choice<br>[=
=A0=A0=A0 5.227956] hub 5-0:1.0: USB hub found<br>[=A0=A0=A0 5.227956] hub =
5-0:1.0: 8 ports detected<br>[=A0=A0=A0 5.331087] libata version 3.00 loade=
d.<br>[=A0=A0=A0 5.333398] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2=
-NAPI<br>
[=A0=A0=A0 5.333457] e100: Copyright(c) 1999-2006 Intel Corporation<br>[=A0=
=A0=A0 5.375956] e100 0000:07:08.0: PME# disabled<br>[=A0=A0=A0 5.472295] e=
100: eth0: e100_probe: addr 0xdc005000, irq 20, MAC addr 00:a0:d1:59:b8:e4<=
br>[=A0=A0=A0 5.507429] ata_piix 0000:00:1f.2: version 2.13<br>
[=A0=A0=A0 5.507455] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]<br>[=A0=
=A0=A0 5.568041] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[17]=A0 MMI=
O=3D[dc006000-dc0067ff]=A0 Max Packet=3D[2048]=A0 IR/IT contexts=3D[4/8]<br=
>[=A0=A0=A0 5.660022] ata_piix 0000:00:1f.2: setting latency timer to 64<br=
>
[=A0=A0=A0 5.660514] scsi0 : ata_piix<br>[=A0=A0=A0 5.660704] scsi1 : ata_p=
iix<br>[=A0=A0=A0 5.660803] ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmd=
ma 0x18b0 irq 14<br>[=A0=A0=A0 5.660860] ata2: PATA max UDMA/100 cmd 0x170 =
ctl 0x376 bmdma 0x18b8 irq 15<br>
[=A0=A0=A0 5.828517] ata1.00: ATA-7: FUJITSU MHV2160BT PL, 00000050, max UD=
MA/100<br>[=A0=A0=A0 5.828579] ata1.00: 312581808 sectors, multi 16: LBA48 =
NCQ (depth 0/32)<br>[=A0=A0=A0 5.856010] ata1.00: configured for UDMA/100<b=
r>[=A0=A0=A0 5.856255] scsi 0:0:0:0: Direct-Access=A0=A0=A0=A0 ATA=A0=A0=A0=
=A0=A0 FUJITSU MHV2160B 0000 PQ: 0 ANSI: 5<br>
[=A0=A0=A0 5.919983] usb 2-1: new full speed USB device using uhci_hcd and =
address 2<br>[=A0=A0=A0 6.020521] ata2.00: ATAPI: MATSHITADVD-RAM UJ-841S, =
1.60, max UDMA/33<br>[=A0=A0=A0 6.052461] ata2.00: configured for UDMA/33<b=
r>[=A0=A0=A0 6.054835] scsi 1:0:0:0: CD-ROM=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 MATSHITA DVD-RAM UJ-841S=A0 1.60 PQ: 0 ANSI: 5<br>
[=A0=A0=A0 6.140713] usb 2-1: configuration #1 chosen from 1 choice<br>[=A0=
=A0=A0 6.234259] scsi 0:0:0:0: Attached scsi generic sg0 type 0<br>[=A0=A0=
=A0 6.234365] scsi 1:0:0:0: Attached scsi generic sg1 type 5<br>[=A0=A0=A0 =
6.278913] Driver &#39;sd&#39; needs updating - please use bus_type methods<=
br>
[=A0=A0=A0 6.282350] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors:=
 (160 GB/149 GiB)<br>[=A0=A0=A0 6.282444] sd 0:0:0:0: [sda] Write Protect i=
s off<br>[=A0=A0=A0 6.282498] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00<br>=
[=A0=A0=A0 6.282532] sd 0:0:0:0: [sda] Write cache: enabled, read cache: en=
abled, doesn&#39;t support DPO or FUA<br>
[=A0=A0=A0 6.282734]=A0 sda: sda1 sda2 sda3 sda4<br>[=A0=A0=A0 6.376263] sd=
 0:0:0:0: [sda] Attached SCSI disk<br>[=A0=A0=A0 6.380316] Driver &#39;sr&#=
39; needs updating - please use bus_type methods<br>[=A0=A0=A0 6.407964] sr=
0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray<br>
[=A0=A0=A0 6.408038] Uniform CD-ROM driver Revision: 3.20<br>[=A0=A0=A0 6.4=
08202] sr 1:0:0:0: Attached scsi CD-ROM sr0<br>[=A0=A0=A0 7.096499] PM: Sta=
rting manual resume from disk<br>[=A0=A0=A0 7.096499] PM: Resume from parti=
tion 8:4<br>[=A0=A0=A0 7.096499] PM: Checking hibernation image.<br>
[=A0=A0=A0 7.096499] PM: Resume from disk failed.<br>[=A0=A0=A0 7.192009] k=
journald starting.=A0 Commit interval 5 seconds<br>[=A0=A0=A0 7.192009] EXT=
3-fs: mounted filesystem with writeback data mode.<br>[=A0=A0 17.554039] ud=
evd version 124 started<br>
[=A0=A0 18.382658] Linux agpgart interface v0.103<br>[=A0=A0 18.501940] pci=
_hotplug: PCI Hot Plug PCI Core version: 0.5<br>[=A0=A0 18.567976] shpchp: =
Standard Hot Plug PCI Controller Driver version: 0.4<br>[=A0=A0 18.619956] =
agpgart-intel 0000:00:00.0: Intel 945GM Chipset<br>
[=A0=A0 18.624264] agpgart-intel 0000:00:00.0: detected 7932K stolen memory=
<br>[=A0=A0 18.627283] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0=
xc0000000<br>[=A0=A0 18.749242] intel_rng: FWH not detected<br>[=A0=A0 19.4=
46939] yenta_cardbus 0000:07:06.0: CardBus bridge found [1179:ff10]<br>
[=A0=A0 19.447025] yenta_cardbus 0000:07:06.0: Enabling burst memory read t=
ransactions<br>[=A0=A0 19.447103] yenta_cardbus 0000:07:06.0: Using CSCINT =
to route CSC interrupts to PCI<br>[=A0=A0 19.447178] yenta_cardbus 0000:07:=
06.0: Routing CardBus interrupts to PCI<br>
[=A0=A0 19.447241] yenta_cardbus 0000:07:06.0: TI: mfunc 0x01a01b22, devctl=
 0x66<br>[=A0=A0 19.627078] Bluetooth: Core ver 2.15<br>[=A0=A0 19.627700] =
NET: Registered protocol family 31<br>[=A0=A0 19.627756] Bluetooth: HCI dev=
ice and connection manager initialized<br>
[=A0=A0 19.627812] Bluetooth: HCI socket layer initialized<br>[=A0=A0 19.67=
6971] yenta_cardbus 0000:07:06.0: ISA IRQ mask 0x02f8, PCI irq 18<br>[=A0=
=A0 19.677037] yenta_cardbus 0000:07:06.0: Socket status: 30000006<br>[=A0=
=A0 19.677094] pci_bus 0000:07: Raising subordinate bus# of parent bus (#07=
) from #07 to #0b<br>
[=A0=A0 19.677174] yenta_cardbus 0000:07:06.0: pcmcia: parent PCI bridge I/=
O window: 0x4000 - 0x4fff<br>[=A0=A0 19.677248] pcmcia_socket pcmcia_socket=
0: cs: IO port probe 0x4000-0x4fff: clean.<br>[=A0=A0 19.677742] yenta_card=
bus 0000:07:06.0: pcmcia: parent PCI bridge Memory window: 0xdc000000 - 0xd=
c0fffff<br>
[=A0=A0 19.677818] yenta_cardbus 0000:07:06.0: pcmcia: parent PCI bridge Me=
mory window: 0xa4000000 - 0xa7ffffff<br>[=A0=A0 19.731956] iTCO_vendor_supp=
ort: vendor-support=3D0<br>[=A0=A0 19.959956] cfg80211: Calling CRDA to upd=
ate world regulatory domain<br>
[=A0=A0 20.138706] Bluetooth: Generic Bluetooth USB driver ver 0.5<br>[=A0=
=A0 20.138859] usbcore: registered new interface driver btusb<br>[=A0=A0 20=
.417425] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05<br>[=A0=A0 20.4176=
02] iTCO_wdt: Found a ICH7-M or ICH7-U TCO device (Version=3D2, TCOBASE=3D0=
x1060)<br>
[=A0=A0 20.418154] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)=
<br>[=A0=A0 21.286015] sdhci: Secure Digital Host Controller Interface driv=
er<br>[=A0=A0 21.286079] sdhci: Copyright(c) Pierre Ossman<br>[=A0=A0 21.31=
6636] sdhci-pci 0000:07:06.3: SDHCI controller found [104c:803c] (rev 0)<br=
>
[=A0=A0 21.316808] Registered led device: mmc0::<br>[=A0=A0 21.316903] mmc0=
: SDHCI controller on PCI [0000:07:06.3] using DMA<br>[=A0=A0 21.584131] Sy=
naptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04713/0x0<br>[=
=A0=A0 21.584131] synaptics: Toshiba Satellite A105 detected, limiting rate=
 to 40pps.<br>
[=A0=A0 21.636042] input: SynPS/2 Synaptics TouchPad as /devices/platform/i=
8042/serio4/input/input2<br>[=A0=A0 22.460059] iwl3945: Intel(R) PRO/Wirele=
ss 3945ABG/BG Network Connection driver for Linux, 1.2.26ks<br>[=A0=A0 22.4=
60140] iwl3945: Copyright(c) 2003-2009 Intel Corporation<br>
[=A0=A0 22.460346] iwl3945 0000:05:00.0: setting latency timer to 64<br>[=
=A0=A0 22.552254] iwl3945 0000:05:00.0: Tunable channels: 11 802.11bg, 13 8=
02.11a channels<br>[=A0=A0 22.552330] iwl3945 0000:05:00.0: Detected Intel =
Wireless WiFi Link 3945ABG<br>
[=A0=A0 22.552562] iwl3945 0000:05:00.0: irq 27 for MSI/MSI-X<br>[=A0=A0 22=
.608172] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x100-0x3af: clean=
.<br>[=A0=A0 22.610149] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x3=
e0-0x4ff: excluding 0x400-0x407<br>
[=A0=A0 22.619961] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x820-0x=
8ff: clean.<br>[=A0=A0 22.620762] pcmcia_socket pcmcia_socket0: cs: IO port=
 probe 0xc00-0xcf7: clean.<br>[=A0=A0 22.621713] pcmcia_socket pcmcia_socke=
t0: cs: IO port probe 0xa00-0xaff: clean.<br>
[=A0=A0 22.984406] phy0: Selected rate control algorithm &#39;iwl-3945-rs&#=
39;<br>[=A0=A0 23.495965] HDA Intel 0000:00:1b.0: setting latency timer to =
64<br>[=A0=A0 23.709132] hda_codec: Unknown model for ALC861, trying auto-p=
robe from BIOS...<br>
[=A0=A0 24.981622] lp: driver loaded but no devices found<br>[=A0=A0 25.469=
878] Adding 5116692k swap on /dev/sda4.=A0 Priority:-1 extents:1 across:511=
6692k <br>[=A0=A0 26.120552] EXT3 FS on sda3, internal journal<br>[=A0=A0 2=
7.906961] ip_tables: (C) 2000-2006 Netfilter Core Team<br>
[=A0=A0 31.087956] warning: `avahi-daemon&#39; uses 32-bit capabilities (le=
gacy support in use)<br>[=A0=A0 31.599964] ppdev: user-space parallel port =
driver<br>[=A0=A0 34.899956] NET: Registered protocol family 10<br>[=A0=A0 =
34.899956] lo: Disabled Privacy Extensions<br>
[=A0=A0 36.450590] Bluetooth: L2CAP ver 2.13<br>[=A0=A0 36.450594] Bluetoot=
h: L2CAP socket layer initialized<br>[=A0=A0 36.542030] Bluetooth: BNEP (Et=
hernet Emulation) ver 1.3<br>[=A0=A0 36.542034] Bluetooth: BNEP filters: pr=
otocol multicast<br>
[=A0=A0 36.670790] Bluetooth: RFCOMM socket layer initialized<br>[=A0=A0 36=
.670790] Bluetooth: RFCOMM TTY layer initialized<br>[=A0=A0 36.670790] Blue=
tooth: RFCOMM ver 1.11<br>[=A0=A0 37.018939] Bridge firewalling registered<=
br>[=A0=A0 37.298038] Bluetooth: SCO (Voice Link) ver 0.6<br>
[=A0=A0 37.298043] Bluetooth: SCO socket layer initialized<br>[=A0=A0 41.07=
7531] ADDRCONF(NETDEV_UP): eth0: link is not ready<br>[=A0=A0 41.078303] iw=
l3945 0000:05:00.0: firmware: requesting iwlwifi-3945-2.ucode<br>[=A0=A0 41=
.124010] iwl3945 0000:05:00.0: iwlwifi-3945-2.ucode firmware file req faile=
d: -2<br>
[=A0=A0 41.124087] iwl3945 0000:05:00.0: firmware: requesting iwlwifi-3945-=
1.ucode<br>[=A0=A0 41.164318] iwl3945 0000:05:00.0: Loaded firmware iwlwifi=
-3945-1.ucode, which is deprecated.=A0 Please use API v2 instead.<br>[=A0=
=A0 41.164427] iwl3945 0000:05:00.0: Firmware has old API version. Expected=
 2, got 1. New firmware can be obtained from <a href=3D"http://www.intellin=
uxwireless.org">http://www.intellinuxwireless.org</a>.<br>
[=A0=A0 41.164427] iwl3945 0000:05:00.0: loaded firmware version 2.14.1.5<b=
r>[=A0=A0 41.213732] Registered led device: iwl-phy0::radio<br>[=A0=A0 41.2=
13732] Registered led device: iwl-phy0::assoc<br>[=A0=A0 41.213732] Registe=
red led device: iwl-phy0::RX<br>
[=A0=A0 41.213732] Registered led device: iwl-phy0::TX<br>[=A0=A0 41.240136=
] ADDRCONF(NETDEV_UP): wlan0: link is not ready<br>[=A0=A0 41.423956] NET: =
Registered protocol family 17<br><br><div class=3D"gmail_quote">2009/9/17 G=
illes Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chantepe=
rdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>Flavio de Castro Alves Filho wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I am new with Xenomai and I am having problems in booting a compiled k=
ernel<br>
&gt; into Ubuntu 8.10. I could compile the kernel with the appropriate patc=
h,<br>
&gt; configured grub to load the new kernel. But, when I boot the new kerne=
l, it<br>
&gt; performs all the boot configurations and at the end, when the gnome is=
 about<br>
&gt; to be loaded, the computer starts to blink the display and then blocks=
.<br>
<br>
</div>Ok, I misread your description.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; I am using the following configuration:<br>
&gt;<br>
&gt; - x86 platform (my notebook ... an intel core2duo machine)<br>
&gt; - xenomai version 2.4.9<br>
&gt; - linux 2.6.30<br>
&gt; - ubuntu linux 8.10<br>
&gt; I performed the following steps:<br>
&gt;<br>
&gt; - downloaded file linux-2.6.30.tar.bz2 from <a href=3D"http://kernel.o=
rg" target=3D"_blank">kernel.org</a><br>
&gt; - downloaded file xenomai-2.4.9.tar.bz2 from xenomai website<br>
&gt; - from my home directory, I decompressed both files<br>
&gt; - applied the patch, running the &quot;scripts/prepare-kernel.sh&quot;=
 and provided<br>
&gt; the path for my source files &quot;/home/flavio/linux-2.6.30&quot;. Th=
e script had<br>
&gt; correctly found the patch to be applied to my sources.<br>
&gt; - make xconfig:<br>
&gt; =A0 =A0- disabled HPET timer support<br>
<br>
</div>Try keeping it.<br>
<div class=3D"im"><br>
&gt; =A0 =A0- disabled PC Speaker<br>
&gt; =A0 =A0- disabled Power Management Support<br>
<br>
</div>Only disable APM, try enabling ACPI, except the &quot;ACPI Processor&=
quot; option.<br>
<div class=3D"im"><br>
&gt; =A0 =A0- disabled CPU frequency scaling<br>
&gt; =A0 =A0- enabled VxWorks emulator<br>
&gt; =A0 =A0- enabled RTAI emulator<br>
&gt; =A0 =A0- enabled Testing drivers<br>
&gt; - make<br>
&gt; - make modules<br>
&gt; - sudo make modules_install<br>
<br>
</div>If you have a proprietary graphics module, you need to recompile that=
<br>
module too.<br>
<div class=3D"im"><br>
&gt; - sudo make install<br>
&gt; - cd /boot<br>
&gt; - sudo update-initramfs -c -k 2.6.30<br>
&gt; - created an entry in grub list:<br>
<br>
&gt;<br>
&gt; title Xenomai 2.4.9 Linux 2.6.30<br>
&gt; root (hd0,2)<br>
&gt; kernel /boot/vmlinuz-2.6.30 root=3D/dev/sda3 ro<br>
&gt; initrd /boot/initrd.img-2.6.30<br>
&gt; savedefault<br>
&gt; boot<br>
&gt;<br>
&gt; Just as a remark, I performed before the same procedure, except for th=
e<br>
&gt; xenomai patch, and I could execute the linux 2.6.30 kernel in my compu=
ter.<br>
&gt;<br>
&gt; Had anybody passed by the same experience? I have no idea what the pro=
blem<br>
&gt; could be.<br>
<br>
</div>Please show us the console output anyway.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Flavio de Castro=
 Alves Filho<br>Embedded Software Services<br><a href=3D"http://www.phiinno=
vations.com">www.phiinnovations.com</a><br>+55 11 84 94 56 76<br>

--0016e6d7e32d3bf0690473c901d7--

