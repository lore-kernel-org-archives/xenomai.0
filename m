Message-ID: <4CCB078C.1010102@domain.hid>
Date: Fri, 29 Oct 2010 19:42:36 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>
	<4CC84327.9070202@domain.hid>	<4CC92786.3030509@domain.hid>
	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>
	<4CC94E0B.9070106@domain.hid> <4CC97448.3040205@domain.hid>
	<4CC99129.50507@domain.hid> <4CC99215.80600@domain.hid>
	<4CC9944D.8050909@domain.hid> <4CC9980C.6080003@domain.hid>
In-Reply-To: <4CC9980C.6080003@domain.hid>
Content-Type: multipart/mixed; boundary="------------060804000506020809090509"
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------060804000506020809090509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:

>>> Please provide the full kernel log, ideally also with the I-pipe tracer
>>> (with panic tracing) enabled.
>> Will reconfigure/recompile and do that, with full kernel log do you mean all
>> bootup info?
> 
> That's best to avoid missing some detail or doing Q&A ping-pong.

Full trace attached (finally...)

Regards

Anders


--------------060804000506020809090509
Content-Type: text/plain;
 name="xenomai-2010-10-29"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xenomai-2010-10-29"

Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf-trace (andersb@domain.hid=
n) (gcc version 4.4.4 20100630 (Red Hat 4.4.4-10) (GCC) ) #1 SMP Fri Oct =
29 11:02:56 CEST 2010
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000ce7b4000 (usable)
 BIOS-e820: 00000000ce7b4000 - 00000000ce877000 (ACPI NVS)
 BIOS-e820: 00000000ce877000 - 00000000cfa9e000 (usable)
 BIOS-e820: 00000000cfa9e000 - 00000000cfaa0000 (reserved)
 BIOS-e820: 00000000cfaa0000 - 00000000cfb8e000 (usable)
 BIOS-e820: 00000000cfb8e000 - 00000000cfbe5000 (ACPI NVS)
 BIOS-e820: 00000000cfbe5000 - 00000000cfbe8000 (usable)
 BIOS-e820: 00000000cfbe8000 - 00000000cfbf3000 (ACPI data)
 BIOS-e820: 00000000cfbf3000 - 00000000cfbf4000 (usable)
 BIOS-e820: 00000000cfbf4000 - 00000000cfbff000 (ACPI data)
 BIOS-e820: 00000000cfbff000 - 00000000cfc00000 (usable)
 BIOS-e820: 00000000cfc00000 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f8000000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 000000012c000000 (usable)
NX (Execute Disable) protection: active
DMI 2.4 present.
e820 update range: 0000000000000000 - 0000000000001000 (usable) =3D=3D> (=
reserved)
e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
last_pfn =3D 0x12c000 max_arch_pfn =3D 0x1000000
MTRR default type: write-back
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-DFFFF write-protect
  E0000-FFFFF uncachable
MTRR variable ranges enabled:
  0 base 0CFF00000 mask FFFF00000 uncachable
  1 base 0D0000000 mask FF0000000 uncachable
  2 base 0E0000000 mask FE0000000 uncachable
  3 base 0CFBAC000 mask FFFFFF000 write-back
  4 disabled
  5 disabled
  6 disabled
  7 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
initial memory mapped : 0 - 01800000
found SMP MP-table at [c00fe200] fe200
init_memory_mapping: 0000000000000000-00000000375fe000
 0000000000 - 0000200000 page 4k
 0000200000 - 0037400000 page 2M
 0037400000 - 00375fe000 page 4k
kernel direct mapping tables up to 375fe000 @ 7000-f000
RAMDISK: 373ae000 - 37ff0000
Allocated new RAMDISK: 01368000 - 01fa9a4d
Move RAMDISK from 00000000373ae000 - 0000000037fefa4c to 01368000 - 01fa9=
a4c
ACPI: RSDP 000fe020 00014 (v00 INTEL )
ACPI: RSDT cfbfd038 00064 (v01 INTEL  DP35DP   000001B5      01000013)
ACPI: FACP cfbfc000 00074 (v01 INTEL  DP35DP   000001B5 MSFT 01000013)
ACPI: DSDT cfbf8000 03DB9 (v01 INTEL  DP35DP   000001B5 MSFT 01000013)
ACPI: FACS cfb99000 00040
ACPI: APIC cfbf7000 00078 (v01 INTEL  DP35DP   000001B5 MSFT 01000013)
ACPI: WDDT cfbf6000 00040 (v01 INTEL  DP35DP   000001B5 MSFT 01000013)
ACPI: MCFG cfbf5000 0003C (v01 INTEL  DP35DP   000001B5 MSFT 01000013)
ACPI: ASF! cfbf4000 000A6 (v32 INTEL  DP35DP   000001B5 MSFT 01000013)
ACPI: ASPT cfbf2000 0002C (v01 INTEL  DP35DP   000001B5 MSFT 01000013)
ACPI: WDTT cfbf1000 002CC (v01 INTEL  DP35DP   000001B5 MSFT 01000013)
ACPI: SSDT cfbf0000 00204 (v01 INTEL     CpuPm 000001B5 MSFT 01000013)
ACPI: SSDT cfbef000 001F9 (v01 INTEL   Cpu0Ist 000001B5 MSFT 01000013)
ACPI: SSDT cfbee000 001F9 (v01 INTEL   Cpu1Ist 000001B5 MSFT 01000013)
ACPI: SSDT cfbed000 001F9 (v01 INTEL   Cpu2Ist 000001B5 MSFT 01000013)
ACPI: SSDT cfbec000 001F9 (v01 INTEL   Cpu3Ist 000001B5 MSFT 01000013)
ACPI: SSDT cfbeb000 001CF (v01 INTEL   Cpu0Cst 000001B5 MSFT 01000013)
ACPI: SSDT cfbea000 001CF (v01 INTEL   Cpu1Cst 000001B5 MSFT 01000013)
ACPI: SSDT cfbe9000 001CF (v01 INTEL   Cpu2Cst 000001B5 MSFT 01000013)
ACPI: SSDT cfbe8000 001CF (v01 INTEL   Cpu3Cst 000001B5 MSFT 01000013)
ACPI: Local APIC address 0xfee00000
3914MB HIGHMEM available.
885MB LOWMEM available.
  mapped low ram: 0 - 375fe000
  low ram: 0 - 375fe000
  node 0 low ram: 00000000 - 375fe000
  node 0 bootmap 0000b000 - 00011ec0
(12/32 early reservations) =3D=3D> bootmem [0000000000 - 00375fe000]
  #0 [0000001000 - 0000002000]    EX TRAMPOLINE =3D=3D> [0000001000 - 000=
0002000]
  #1 [0000400000 - 000135aacc]    TEXT DATA BSS =3D=3D> [0000400000 - 000=
135aacc]
  #2 [000135b000 - 0001367136]              BRK =3D=3D> [000135b000 - 000=
1367136]
  #3 [000009fc00 - 00000fe200]    BIOS reserved =3D=3D> [000009fc00 - 000=
00fe200]
  #4 [00000fe200 - 00000fe210]     MP-table mpf =3D=3D> [00000fe200 - 000=
00fe210]
  #5 [00000fe250 - 0000100000]    BIOS reserved =3D=3D> [00000fe250 - 000=
0100000]
  #6 [00000fe210 - 00000fe250]     MP-table mpc =3D=3D> [00000fe210 - 000=
00fe250]
  #7 [0000002000 - 0000003000]       TRAMPOLINE =3D=3D> [0000002000 - 000=
0003000]
  #8 [0000003000 - 0000007000]      ACPI WAKEUP =3D=3D> [0000003000 - 000=
0007000]
  #9 [0000007000 - 000000b000]          PGTABLE =3D=3D> [0000007000 - 000=
000b000]
  #10 [0001368000 - 0001faa000]      NEW RAMDISK =3D=3D> [0001368000 - 00=
01faa000]
  #11 [000000b000 - 0000012000]          BOOTMAP =3D=3D> [000000b000 - 00=
00012000]
Zone PFN ranges:
  DMA      0x00000001 -> 0x00001000
  Normal   0x00001000 -> 0x000375fe
  HighMem  0x000375fe -> 0x0012c000
Movable zone start PFN for each node
early_node_map[8] active PFN ranges
    0: 0x00000001 -> 0x0000009f
    0: 0x00000100 -> 0x000ce7b4
    0: 0x000ce877 -> 0x000cfa9e
    0: 0x000cfaa0 -> 0x000cfb8e
    0: 0x000cfbe5 -> 0x000cfbe8
    0: 0x000cfbf3 -> 0x000cfbf4
    0: 0x000cfbff -> 0x000cfc00
    0: 0x00100000 -> 0x0012c000
On node 0 totalpages: 1030764
free_area_init_node: node 0, pgdat c0a3f880, node_mem_map c1fab020
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 3966 pages, LIFO batch:0
  Normal zone: 1740 pages used for memmap
  Normal zone: 220978 pages, LIFO batch:31
  HighMem zone: 7829 pages used for memmap
  HighMem zone: 796219 pages, LIFO batch:31
Using APIC driver default
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
SMP: Allowing 4 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 40
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
Allocating PCI resources starting at d0000000 (gap: d0000000:20000000)
setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:4 nr_node_ids:1
PERCPU: Embedded 340 pages/cpu @c4600000 s1368384 r0 d24256 u2097152
pcpu-alloc: s1368384 r0 d24256 u2097152 alloc=3D1*2097152
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3=20
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1021=
163
Kernel command line: ro root=3DUUID=3Dc3fb4b4b-4e9c-477c-8e9a-0a95d05f8e0=
8 SYSFONT=3Dlatarcyrheb-sun16 LANG=3Den_US.UTF-8 KEYTABLE=3Dsv-latin1 825=
0.nr_uarts=3D20 console=3DttyS4,115200 loglevel=3D8 maxcpus=3D1
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
allocated 24575980 bytes of page_cgroup
please try 'cgroup_disable=3Dmemory' option if you don't want memory cgro=
ups
Initializing HighMem for node 0 (000375fe:0012c000)
Memory: 4025832k/4915200k available (3947k kernel code, 97224k reserved, =
2575k data, 1860k init, 3216192k highmem)
virtual kernel memory layout:
    fixmap  : 0xffa96000 - 0xfffff000   (5540 kB)
    pkmap   : 0xff600000 - 0xff800000   (2048 kB)
    vmalloc : 0xf7dfe000 - 0xff5fe000   ( 120 MB)
    lowmem  : 0xc0000000 - 0xf75fe000   ( 885 MB)
      .init : 0xc0a5f000 - 0xc0c30000   (1860 kB)
      .data : 0xc07dae37 - 0xc0a5ea40   (2575 kB)
      .text : 0xc0400000 - 0xc07dae37   (3947 kB)
Checking if this processor honours the WP bit even in supervisor mode...O=
k.
SLUB: Genslabs=3D13, HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4,=
 Nodes=3D1
Hierarchical RCU implementation.
	RCU dyntick-idle grace-period acceleration is enabled.
	RCU lockdep checking is enabled.
	RCU-based detection of stalled CPUs is disabled.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:1280
I-pipe 2.7-04: pipeline enabled.
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
=2E.. MAX_LOCKDEP_SUBCLASSES:  8
=2E.. MAX_LOCK_DEPTH:          48
=2E.. MAX_LOCKDEP_KEYS:        8191
=2E.. CLASSHASH_SIZE:          4096
=2E.. MAX_LOCKDEP_ENTRIES:     16384
=2E.. MAX_LOCKDEP_CHAINS:      32768
=2E.. CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3823 kB
 per task-struct memory footprint: 1920 bytes
ODEBUG: 29 of 29 active objects replaced
Fast TSC calibration using PIT
Detected 2400.116 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.=
=2E 4800.23 BogoMIPS (lpj=3D2400116)
pid_max: default: 32768 minimum: 301
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
Initializing cgroup subsys blkio
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 6 MCE banks
CPU0: Thermal monitoring enabled (TM2)
Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver.
PEBS disabled due to CPU errata.
=2E.. version:                2
=2E.. bit width:              40
=2E.. generic registers:      2
=2E.. value mask:             000000ffffffffff
=2E.. max period:             000000007fffffff
=2E.. fixed-purpose events:   3
=2E.. event mask:             0000000700000003
lockdep: fixing up alternatives.
SMP alternatives: switching to UP code
ACPI: Core revision 20100428
ftrace: converting mcount calls to 0f 1f 44 00 00
ftrace: allocating 20823 entries in 41 pages
Enabling APIC mode:  Flat.  Using 1 I/O APICs
=2E.TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
=2E.MP-BIOS bug: 8254 timer not connected to IO-APIC
=2E..trying to set up timer (IRQ0) through the 8259A ...
=2E.... (found apic 0 pin 2) ...
=2E...... works.
CPU0: Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz stepping 0b
APIC calibration not consistent with PM-Timer: 103ms instead of 100ms
APIC delta adjusted to PM-Timer: 1666723 (1733126)
Brought up 1 CPUs
Total of 1 processors activated (4800.23 BogoMIPS).
devtmpfs: initialized
atomic64 test passed for i586+ platform with CX8 and with SSE
Time: 17:27:12  Date: 10/29/10
NET: Registered protocol family 16

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[ INFO: suspicious rcu_dereference_check() usage. ]
---------------------------------------------------
include/linux/cgroup.h:542 invoked rcu_dereference_check() without protec=
tion!

other info that might help us debug this:


rcu_scheduler_active =3D 1, debug_locks =3D 0
1 lock held by swapper/1:
 #0:  (net_mutex){+.+.+.}, at: [<c073d522>] register_pernet_subsys+0x17/0=
x35

stack backtrace:
Pid: 1, comm: swapper Not tainted 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf-=
trace #1
Call Trace:
 [<c0461980>] lockdep_rcu_dereference+0x7d/0x86
 [<c0736141>] sock_update_classid+0x8c/0x92
 [<c0737157>] sk_alloc+0x5b/0x66
 [<c0758c1d>] __netlink_create+0x2a/0x90
 [<c075ab3d>] netlink_kernel_create+0x5f/0x14e
 [<c074995e>] rtnetlink_net_init+0x23/0x3b
 [<c074ae31>] ? rtnetlink_rcv+0x0/0x27
 [<c073d261>] ops_init+0xe3/0xeb
 [<c073d454>] register_pernet_operations+0x82/0xed
 [<c073d52e>] register_pernet_subsys+0x23/0x35
 [<c0a949ef>] rtnetlink_init+0x42/0xe0
 [<c0a9505d>] netlink_proto_init+0xf2/0x106
 [<c0a94f6b>] ? netlink_proto_init+0x0/0x106
 [<c0401154>] do_one_initcall+0x62/0x187
 [<c0a5f39b>] kernel_init+0x149/0x1ca
 [<c0a5f252>] ? kernel_init+0x0/0x1ca
 [<c0402f16>] kernel_thread_helper+0x6/0x10
ACPI: bus type pci registered
PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] =
(base 0xf0000000)
PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
PCI: Using MMCONFIG for extended config space
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: No dock devices found.
PCI: Using host bridge windows from ACPI; if necessary, use "pci=3Dnocrs"=
 and report a bug
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7]
pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
pci_root PNP0A03:00: host bridge window [mem 0x000e0000-0x000effff]
pci_root PNP0A03:00: host bridge window [mem 0xf8000000-0xfeafffff]
pci_root PNP0A03:00: host bridge window [mem 0xd0000000-0xefffffff]
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PME# disabled
pci 0000:00:03.0: reg 10: [mem 0xe2325900-0xe232590f 64bit]
pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
pci 0000:00:03.0: PME# disabled
pci 0000:00:19.0: reg 10: [mem 0xe2300000-0xe231ffff]
pci 0000:00:19.0: reg 14: [mem 0xe2324000-0xe2324fff]
pci 0000:00:19.0: reg 18: [io  0x40e0-0x40ff]
pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
pci 0000:00:19.0: PME# disabled
pci 0000:00:1a.0: reg 20: [io  0x40c0-0x40df]
pci 0000:00:1a.1: reg 20: [io  0x40a0-0x40bf]
pci 0000:00:1a.2: reg 20: [io  0x4080-0x409f]
pci 0000:00:1a.7: reg 10: [mem 0xe2325400-0xe23257ff]
pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.7: PME# disabled
pci 0000:00:1b.0: reg 10: [mem 0xe2320000-0xe2323fff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: PME# disabled
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: PME# disabled
pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.2: PME# disabled
pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.3: PME# disabled
pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.4: PME# disabled
pci 0000:00:1d.0: reg 20: [io  0x4060-0x407f]
pci 0000:00:1d.1: reg 20: [io  0x4040-0x405f]
pci 0000:00:1d.2: reg 20: [io  0x4020-0x403f]
pci 0000:00:1d.7: reg 10: [mem 0xe2325000-0xe23253ff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
pci 0000:00:1f.0: quirk: [io  0x0400-0x047f] claimed by ICH6 ACPI/GPIO/TC=
O
pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6 GPIO
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0680 (mask 007f)
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0810 (mask 007f)
pci 0000:00:1f.2: reg 10: [io  0x4458-0x445f]
pci 0000:00:1f.2: reg 14: [io  0x446c-0x446f]
pci 0000:00:1f.2: reg 18: [io  0x4450-0x4457]
pci 0000:00:1f.2: reg 1c: [io  0x4468-0x446b]
pci 0000:00:1f.2: reg 20: [io  0x4430-0x443f]
pci 0000:00:1f.2: reg 24: [io  0x4420-0x442f]
pci 0000:00:1f.3: reg 10: [mem 0xe2325800-0xe23258ff 64bit]
pci 0000:00:1f.3: reg 20: [io  0x4000-0x401f]
pci 0000:00:1f.5: reg 10: [io  0x4448-0x444f]
pci 0000:00:1f.5: reg 14: [io  0x4464-0x4467]
pci 0000:00:1f.5: reg 18: [io  0x4440-0x4447]
pci 0000:00:1f.5: reg 1c: [io  0x4460-0x4463]
pci 0000:00:1f.5: reg 20: [io  0x4410-0x441f]
pci 0000:00:1f.5: reg 24: [io  0x4400-0x440f]
pci 0000:01:00.0: reg 10: [mem 0xe1000000-0xe1ffffff]
pci 0000:01:00.0: reg 14: [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:01:00.0: reg 1c: [mem 0xe0000000-0xe0ffffff 64bit]
pci 0000:01:00.0: reg 30: [mem 0xfffe0000-0xffffffff pref]
pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable =
it with 'pcie_aspm=3Dforce'
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe1ffffff]
pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:00:1c.0: PCI bridge to [bus 02-02]
pci 0000:00:1c.0:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disab=
led)
pci 0000:03:00.0: reg 10: [io  0x3018-0x301f]
pci 0000:03:00.0: reg 14: [io  0x3024-0x3027]
pci 0000:03:00.0: reg 18: [io  0x3010-0x3017]
pci 0000:03:00.0: reg 1c: [io  0x3020-0x3023]
pci 0000:03:00.0: reg 20: [io  0x3000-0x300f]
pci 0000:03:00.0: reg 24: [mem 0xe2200000-0xe22001ff]
pci 0000:03:00.0: supports D1
pci 0000:03:00.0: PME# supported from D0 D1 D3hot
pci 0000:03:00.0: PME# disabled
pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable =
it with 'pcie_aspm=3Dforce'
pci 0000:00:1c.1: PCI bridge to [bus 03-03]
pci 0000:00:1c.1:   bridge window [io  0x3000-0x3fff]
pci 0000:00:1c.1:   bridge window [mem 0xe2200000-0xe22fffff]
pci 0000:00:1c.1:   bridge window [mem 0xfff00000-0x000fffff pref] (disab=
led)
pci 0000:00:1c.2: PCI bridge to [bus 04-04]
pci 0000:00:1c.2:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:1c.2:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:00:1c.2:   bridge window [mem 0xfff00000-0x000fffff pref] (disab=
led)
pci 0000:00:1c.3: PCI bridge to [bus 05-05]
pci 0000:00:1c.3:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:1c.3:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:00:1c.3:   bridge window [mem 0xfff00000-0x000fffff pref] (disab=
led)
pci 0000:06:00.0: reg 10: [io  0x2010-0x2017]
pci 0000:06:00.0: reg 14: [mem 0xe2105000-0xe2105fff]
pci 0000:06:00.0: reg 20: [mem 0xe2104000-0xe2104fff]
pci 0000:06:00.0: supports D1 D2
pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:06:00.0: PME# disabled
pci 0000:06:00.1: reg 10: [io  0x2008-0x200f]
pci 0000:06:00.1: reg 14: [mem 0xe2103000-0xe2103fff]
pci 0000:06:00.1: reg 20: [mem 0xe2102000-0xe2102fff]
pci 0000:06:00.1: supports D1 D2
pci 0000:06:00.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:06:00.1: PME# disabled
pci 0000:06:00.2: reg 10: [io  0x2000-0x2007]
pci 0000:06:00.2: reg 14: [io  0x2018-0x201b]
pci 0000:06:00.2: reg 18: [mem 0xe2101000-0xe2101fff]
pci 0000:06:00.2: reg 20: [mem 0xe2100000-0xe2100fff]
pci 0000:06:00.2: supports D1 D2
pci 0000:06:00.2: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:06:00.2: PME# disabled
pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable =
it with 'pcie_aspm=3Dforce'
pci 0000:00:1c.4: PCI bridge to [bus 06-06]
pci 0000:00:1c.4:   bridge window [io  0x2000-0x2fff]
pci 0000:00:1c.4:   bridge window [mem 0xe2100000-0xe21fffff]
pci 0000:00:1c.4:   bridge window [mem 0xfff00000-0x000fffff pref] (disab=
led)
pci 0000:07:00.0: reg 10: [mem 0xe2044000-0xe2044fff]
pci 0000:07:00.0: supports D1 D2
pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot
pci 0000:07:00.0: PME# disabled
pci 0000:07:01.0: reg 10: [mem 0xe2020000-0xe203ffff]
pci 0000:07:01.0: reg 14: [mem 0xe2000000-0xe201ffff]
pci 0000:07:01.0: reg 18: [io  0x1000-0x103f]
pci 0000:07:01.0: reg 30: [mem 0xfffe0000-0xffffffff pref]
pci 0000:07:01.0: PME# supported from D0 D3hot D3cold
pci 0000:07:01.0: PME# disabled
pci 0000:07:02.0: reg 10: [io  0x0000-0x0007]
pci 0000:07:02.0: reg 14: [io  0x0000-0x0007]
pci 0000:07:02.0: reg 18: [io  0x0000-0x0007]
pci 0000:07:02.0: reg 1c: [io  0x0000-0x0007]
pci 0000:07:02.1: reg 10: [io  0x0000-0x0007]
pci 0000:07:02.1: reg 14: [io  0x0000-0x0007]
pci 0000:07:02.1: reg 18: [io  0x0000-0x0007]
pci 0000:07:02.1: reg 1c: [io  0x0000-0x0007]
pci 0000:07:03.0: reg 10: [mem 0xe2045000-0xe20457ff]
pci 0000:07:03.0: reg 14: [mem 0xe2040000-0xe2043fff]
pci 0000:07:03.0: supports D1 D2
pci 0000:07:03.0: PME# supported from D0 D1 D2 D3hot
pci 0000:07:03.0: PME# disabled
pci 0000:00:1e.0: PCI bridge to [bus 07-07] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:1e.0:   bridge window [mem 0xe2000000-0xe20fffff]
pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disab=
led)
pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode=
)
pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode=
)
pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractiv=
e decode)
pci 0000:00:1e.0:   bridge window [mem 0x000e0000-0x000effff] (subtractiv=
e decode)
pci 0000:00:1e.0:   bridge window [mem 0xf8000000-0xfeafffff] (subtractiv=
e decode)
pci 0000:00:1e.0:   bridge window [mem 0xd0000000-0xefffffff] (subtractiv=
e decode)
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11 12)
HEST: Table is not found!
vgaarb: device added: PCI:0000:01:00.0,decodes=3Dio+mem,owns=3Dio+mem,loc=
ks=3Dnone
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
reserve RAM buffer: 000000000009fc00 - 000000000009ffff=20
reserve RAM buffer: 00000000ce7b4000 - 00000000cfffffff=20
reserve RAM buffer: 00000000cfa9e000 - 00000000cfffffff=20
reserve RAM buffer: 00000000cfb8e000 - 00000000cfffffff=20
reserve RAM buffer: 00000000cfbe8000 - 00000000cfffffff=20
reserve RAM buffer: 00000000cfbf4000 - 00000000cfffffff=20
reserve RAM buffer: 00000000cfc00000 - 00000000cfffffff=20
NetLabel: Initializing
NetLabel:  domain hash size =3D 128
NetLabel:  protocols =3D UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
hpet clockevent registered
HPET: 4 timers in total, 0 timers will be used for per-cpu timer
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
hpet0: 4 comparators, 64-bit 14.318180 MHz counter
Switching to clocksource tsc
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: [mem 0xf0000000-0xf7ffffff] has been reserved
system 00:01: [mem 0xfeb00000-0xfeb03fff] has been reserved
system 00:01: [mem 0xfed13000-0xfed13fff] has been reserved
system 00:01: [mem 0xfed14000-0xfed17fff] has been reserved
system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
system 00:01: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:01: [mem 0xfed45000-0xfed99fff] has been reserved
system 00:01: [mem 0x000c0000-0x000dffff] could not be reserved
system 00:01: [mem 0x000e0000-0x000fffff] could not be reserved
system 00:01: [mem 0xffc00000-0xffffffff] could not be reserved
system 00:06: [io  0x0500-0x053f] has been reserved
system 00:06: [io  0x0400-0x047f] has been reserved
system 00:06: [io  0x0680-0x06ff] has been reserved
pci 0000:01:00.0: no compatible bridge window for [mem 0xfffe0000-0xfffff=
fff pref]
pci 0000:07:01.0: no compatible bridge window for [mem 0xfffe0000-0xfffff=
fff pref]
pci 0000:00:1c.0: BAR 14: assigned [mem 0xf8000000-0xf81fffff]
pci 0000:00:1c.0: BAR 15: assigned [mem 0xf8200000-0xf83fffff 64bit pref]=

pci 0000:00:1c.1: BAR 15: assigned [mem 0xf8400000-0xf85fffff 64bit pref]=

pci 0000:00:1c.2: BAR 14: assigned [mem 0xf8600000-0xf87fffff]
pci 0000:00:1c.2: BAR 15: assigned [mem 0xf8800000-0xf89fffff 64bit pref]=

pci 0000:00:1c.3: BAR 14: assigned [mem 0xf8a00000-0xf8bfffff]
pci 0000:00:1c.3: BAR 15: assigned [mem 0xf8c00000-0xf8dfffff 64bit pref]=

pci 0000:00:1c.4: BAR 15: assigned [mem 0xf8e00000-0xf8ffffff 64bit pref]=

pci 0000:00:1e.0: BAR 15: assigned [mem 0xf9000000-0xf90fffff pref]
pci 0000:00:1c.0: BAR 13: assigned [io  0x5000-0x5fff]
pci 0000:00:1c.2: BAR 13: assigned [io  0x6000-0x6fff]
pci 0000:00:1c.3: BAR 13: assigned [io  0x7000-0x7fff]
pci 0000:01:00.0: BAR 6: can't assign mem pref (size 0x20000)
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [io  disabled]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe1ffffff]
pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:00:1c.0: PCI bridge to [bus 02-02]
pci 0000:00:1c.0:   bridge window [io  0x5000-0x5fff]
pci 0000:00:1c.0:   bridge window [mem 0xf8000000-0xf81fffff]
pci 0000:00:1c.0:   bridge window [mem 0xf8200000-0xf83fffff 64bit pref]
pci 0000:00:1c.1: PCI bridge to [bus 03-03]
pci 0000:00:1c.1:   bridge window [io  0x3000-0x3fff]
pci 0000:00:1c.1:   bridge window [mem 0xe2200000-0xe22fffff]
pci 0000:00:1c.1:   bridge window [mem 0xf8400000-0xf85fffff 64bit pref]
pci 0000:00:1c.2: PCI bridge to [bus 04-04]
pci 0000:00:1c.2:   bridge window [io  0x6000-0x6fff]
pci 0000:00:1c.2:   bridge window [mem 0xf8600000-0xf87fffff]
pci 0000:00:1c.2:   bridge window [mem 0xf8800000-0xf89fffff 64bit pref]
pci 0000:00:1c.3: PCI bridge to [bus 05-05]
pci 0000:00:1c.3:   bridge window [io  0x7000-0x7fff]
pci 0000:00:1c.3:   bridge window [mem 0xf8a00000-0xf8bfffff]
pci 0000:00:1c.3:   bridge window [mem 0xf8c00000-0xf8dfffff 64bit pref]
pci 0000:00:1c.4: PCI bridge to [bus 06-06]
pci 0000:00:1c.4:   bridge window [io  0x2000-0x2fff]
pci 0000:00:1c.4:   bridge window [mem 0xe2100000-0xe21fffff]
pci 0000:00:1c.4:   bridge window [mem 0xf8e00000-0xf8ffffff 64bit pref]
pci 0000:07:01.0: BAR 6: assigned [mem 0xf9000000-0xf901ffff pref]
pci 0000:07:02.0: BAR 0: assigned [io  0x1040-0x1047]
pci 0000:07:02.0: BAR 0: set to [io  0x1040-0x1047] (PCI address [0x1040-=
0x1047]
pci 0000:07:02.0: BAR 1: assigned [io  0x1048-0x104f]
pci 0000:07:02.0: BAR 1: set to [io  0x1048-0x104f] (PCI address [0x1048-=
0x104f]
pci 0000:07:02.0: BAR 2: assigned [io  0x1050-0x1057]
pci 0000:07:02.0: BAR 2: set to [io  0x1050-0x1057] (PCI address [0x1050-=
0x1057]
pci 0000:07:02.0: BAR 3: assigned [io  0x1058-0x105f]
pci 0000:07:02.0: BAR 3: set to [io  0x1058-0x105f] (PCI address [0x1058-=
0x105f]
pci 0000:07:02.1: BAR 0: assigned [io  0x1060-0x1067]
pci 0000:07:02.1: BAR 0: set to [io  0x1060-0x1067] (PCI address [0x1060-=
0x1067]
pci 0000:07:02.1: BAR 1: assigned [io  0x1068-0x106f]
pci 0000:07:02.1: BAR 1: set to [io  0x1068-0x106f] (PCI address [0x1068-=
0x106f]
pci 0000:07:02.1: BAR 2: assigned [io  0x1070-0x1077]
pci 0000:07:02.1: BAR 2: set to [io  0x1070-0x1077] (PCI address [0x1070-=
0x1077]
pci 0000:07:02.1: BAR 3: assigned [io  0x1078-0x107f]
pci 0000:07:02.1: BAR 3: set to [io  0x1078-0x107f] (PCI address [0x1078-=
0x107f]
pci 0000:00:1e.0: PCI bridge to [bus 07-07]
pci 0000:00:1e.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:1e.0:   bridge window [mem 0xe2000000-0xe20fffff]
pci 0000:00:1e.0:   bridge window [mem 0xf9000000-0xf90fffff pref]
pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:01.0: setting latency timer to 64
pci 0000:00:1c.0: enabling device (0000 -> 0003)
pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:00:1c.1: PCI INT B -> GSI 20 (level, low) -> IRQ 20
pci 0000:00:1c.1: setting latency timer to 64
pci 0000:00:1c.2: enabling device (0000 -> 0003)
pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
pci 0000:00:1c.2: setting latency timer to 64
pci 0000:00:1c.3: enabling device (0000 -> 0003)
pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
pci 0000:00:1c.3: setting latency timer to 64
pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.4: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000effff]
pci_bus 0000:00: resource 8 [mem 0xf8000000-0xfeafffff]
pci_bus 0000:00: resource 9 [mem 0xd0000000-0xefffffff]
pci_bus 0000:01: resource 1 [mem 0xe0000000-0xe1ffffff]
pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
pci_bus 0000:02: resource 1 [mem 0xf8000000-0xf81fffff]
pci_bus 0000:02: resource 2 [mem 0xf8200000-0xf83fffff 64bit pref]
pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
pci_bus 0000:03: resource 1 [mem 0xe2200000-0xe22fffff]
pci_bus 0000:03: resource 2 [mem 0xf8400000-0xf85fffff 64bit pref]
pci_bus 0000:04: resource 0 [io  0x6000-0x6fff]
pci_bus 0000:04: resource 1 [mem 0xf8600000-0xf87fffff]
pci_bus 0000:04: resource 2 [mem 0xf8800000-0xf89fffff 64bit pref]
pci_bus 0000:05: resource 0 [io  0x7000-0x7fff]
pci_bus 0000:05: resource 1 [mem 0xf8a00000-0xf8bfffff]
pci_bus 0000:05: resource 2 [mem 0xf8c00000-0xf8dfffff 64bit pref]
pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
pci_bus 0000:06: resource 1 [mem 0xe2100000-0xe21fffff]
pci_bus 0000:06: resource 2 [mem 0xf8e00000-0xf8ffffff 64bit pref]
pci_bus 0000:07: resource 0 [io  0x1000-0x1fff]
pci_bus 0000:07: resource 1 [mem 0xe2000000-0xe20fffff]
pci_bus 0000:07: resource 2 [mem 0xf9000000-0xf90fffff pref]
pci_bus 0000:07: resource 4 [io  0x0000-0x0cf7]
pci_bus 0000:07: resource 5 [io  0x0d00-0xffff]
pci_bus 0000:07: resource 6 [mem 0x000a0000-0x000bffff]
pci_bus 0000:07: resource 7 [mem 0x000e0000-0x000effff]
pci_bus 0000:07: resource 8 [mem 0xf8000000-0xfeafffff]
pci_bus 0000:07: resource 9 [mem 0xd0000000-0xefffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 9, 2621440 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
UDP hash table entries: 512 (order: 3, 49152 bytes)
UDP-Lite hash table entries: 512 (order: 3, 49152 bytes)
NET: Registered protocol family 1
pci 0000:01:00.0: Boot video device
PCI: CLS 64 bytes, default 64
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 12552k freed
DMA-API: preallocated 32768 debug entries
DMA-API: debugging enabled by kernel config
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
type=3D2000 audit(1288373236.514:1): initialized
highmem bounce pool size: 64 pages
HugeTLB registered 2 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 1605
SELinux:  Registering netfilter hooks
cryptomgr_test used greatest stack depth: 6572 bytes left
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pcieport 0000:00:01.0: setting latency timer to 64
pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
pcieport 0000:00:1c.0: setting latency timer to 64
pcieport 0000:00:1c.0: irq 41 for MSI/MSI-X
pcieport 0000:00:1c.1: setting latency timer to 64
pcieport 0000:00:1c.1: irq 42 for MSI/MSI-X
pcieport 0000:00:1c.2: setting latency timer to 64
pcieport 0000:00:1c.2: irq 43 for MSI/MSI-X
pcieport 0000:00:1c.3: setting latency timer to 64
pcieport 0000:00:1c.3: irq 44 for MSI/MSI-X
pcieport 0000:00:1c.4: setting latency timer to 64
pcieport 0000:00:1c.4: irq 45 for MSI/MSI-X
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
pci-stub: invalid id string ""
input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/=
input0
ACPI: Sleep Button [SLPB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
ACPI: Power Button [PWRF]
ACPI: acpi_idle registered with cpuidle
Monitor-Mwait will be used to enter C-1 state
ERST: Table is not found!
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
Serial: 8250/16550 driver, 20 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a NS16550A
00:08: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial 0000:06:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
0000:06:00.0: ttyS4 at I/O 0x2010 (irq =3D 16) is a ST16650V2
console [ttyS4] enabled
serial 0000:06:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
0000:06:00.1: ttyS5 at I/O 0x2008 (irq =3D 17) is a ST16650V2
serial 0000:07:02.0: enabling device (0000 -> 0001)
serial 0000:07:02.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
0000:07:02.0: ttyS6 at I/O 0x1040 (irq =3D 18) is a 16550A
0000:07:02.0: ttyS7 at I/O 0x1048 (irq =3D 18) is a 16550A
0000:07:02.0: ttyS8 at I/O 0x1050 (irq =3D 18) is a 16550A
0000:07:02.0: ttyS9 at I/O 0x1058 (irq =3D 18) is a 16550A
serial 0000:07:02.1: enabling device (0000 -> 0001)
serial 0000:07:02.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
0000:07:02.1: ttyS10 at I/O 0x1060 (irq =3D 18) is a 16550A
0000:07:02.1: ttyS11 at I/O 0x1068 (irq =3D 18) is a 16550A
0000:07:02.1: ttyS12 at I/O 0x1070 (irq =3D 18) is a 16550A
0000:07:02.1: ttyS13 at I/O 0x1078 (irq =3D 18) is a 16550A
brd: module loaded
loop: module loaded
ata_piix 0000:00:1f.2: version 2.13
ata_piix 0000:00:1f.2: PCI INT A -> GSI 21 (level, low) -> IRQ 21
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ata_piix 0000:00:1f.2: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x4458 ctl 0x446c bmdma 0x4430 irq 21
ata2: SATA max UDMA/133 cmd 0x4450 ctl 0x4468 bmdma 0x4438 irq 21
ata_piix 0000:00:1f.5: PCI INT A -> GSI 21 (level, low) -> IRQ 21
ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
ata_piix 0000:00:1f.5: setting latency timer to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0x4448 ctl 0x4464 bmdma 0x4410 irq 21
ata4: SATA max UDMA/133 cmd 0x4440 ctl 0x4460 bmdma 0x4418 irq 21
Fixed MDIO Bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 17 (level, low) -> IRQ 17
ehci_hcd 0000:00:1a.7: setting latency timer to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
ehci_hcd 0000:00:1a.7: cache line size of 64 is not supported
ehci_hcd 0000:00:1a.7: irq 17, io mem 0xe2325400
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf-trac=
e ehci_hcd
usb usb1: SerialNumber: 0000:00:1a.7
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 64 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xe2325000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0002
usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb2: Product: EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf-trac=
e ehci_hcd
usb usb2: SerialNumber: 0000:00:1d.7
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1a.0: setting latency timer to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 18, io base 0x000040c0
usb usb3: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb3: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf-trac=
e uhci_hcd
usb usb3: SerialNumber: 0000:00:1a.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:1a.1: setting latency timer to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x000040a0
usb usb4: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb4: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf-trac=
e uhci_hcd
usb usb4: SerialNumber: 0000:00:1a.1
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 17 (level, low) -> IRQ 17
uhci_hcd 0000:00:1a.2: setting latency timer to 64
uhci_hcd 0000:00:1a.2: UHCI Host Controller
uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1a.2: irq 17, io base 0x00004080
usb usb5: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb5: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf-trac=
e uhci_hcd
usb usb5: SerialNumber: 0000:00:1a.2
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00004060
usb usb6: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb6: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb6: Product: UHCI Host Controller
usb usb6: Manufacturer: Linux 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf-trac=
e uhci_hcd
usb usb6: SerialNumber: 0000:00:1d.0
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00004040
usb usb7: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb7: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb7: Product: UHCI Host Controller
usb usb7: Manufacturer: Linux 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf-trac=
e uhci_hcd
usb usb7: SerialNumber: 0000:00:1d.1
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00004020
usb usb8: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb8: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb8: Product: UHCI Host Controller
usb usb8: Manufacturer: Linux 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf-trac=
e uhci_hcd
usb usb8: SerialNumber: 0000:00:1d.2
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
rtc_cmos 00:03: RTC can wake from S4
rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
usb 4-1: new low speed USB device using uhci_hcd and address 2
rtc0: alarms up to one month, 114 bytes nvram, hpet irqs
device-mapper: uevent: version 1.0.3
ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.01: SATA link down (SStatus 0 SControl 300)
ata2.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.01: SATA link down (SStatus 0 SControl 300)
ata2.01: link offline, clearing class 3 to NONE
device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@domain.hid=
hat.com
ata1.00: ATA-8: SAMSUNG HD501LJ, CR100-12, max UDMA7
ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata2.00: ATAPI: TSSTcorp CDDVDW SH-S203D, SB00, max UDMA/100
cpuidle: using governor ladder
cpuidle: using governor menu
ata2.00: configured for UDMA/100
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI=
: 5
usbcore: registered new interface driver hiddev
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
scsi 1:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203D  SB00 PQ: 0 ANSI=
: 5
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't supp=
ort DPO or FUA
CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
nf_conntrack.acct=3D1 kernel parameter, acct=3D1 nf_conntrack module opti=
on or
sysctl net.netfilter.nf_conntrack_acct=3D1 to enable it.
sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
usb 4-1: New USB device found, idVendor=3D045e, idProduct=3D0084
usb 4-1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 4-1: Product: Basic Optical Mouse
usb 4-1: Manufacturer: Microsoft
 sda:
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5
 sda2 < sda5
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
Initializing XFRM netlink socket
 sda6
input: Microsoft Basic Optical Mouse as /devices/pci0000:00/0000:00:1a.1/=
usb4/4-1/4-1:1.0/input/input2
NET: Registered protocol family 17
 sda7 >
Using IPI No-Shortcut mode
PM: Resume from disk failed.
generic-usb 0003:045E:0084.0001: input,hidraw0: USB HID v1.10 Mouse [Micr=
osoft Basic Optical Mouse] on usb-0000:00:1a.1-1/input0
sd 0:0:0:0: [sda] Attached SCSI disk
registered taskstats version 1
IMA: No TPM chip found, activating TPM-bypass!
  Magic number: 14:932:492
serial 0000:06:00.0: hash matches
rtc_cmos 00:03: setting system clock to 2010-10-29 17:27:23 UTC (12883732=
43)
Initalizing network drop monitor service
Freeing unused kernel memory: 1860k freed
Write protecting the kernel text: 3948k
Write protecting the kernel read-only data: 1924k
mknod used greatest stack depth: 6468 bytes left
usb 4-2: new full speed USB device using uhci_hcd and address 3
mount used greatest stack depth: 6424 bytes left
mkdir used greatest stack depth: 6412 bytes left
usb 4-2: New USB device found, idVendor=3D04b3, idProduct=3D301a
usb 4-2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 4-2: Product: USB 1.1 2port downstream low power hub
usb 4-2: Manufacturer: Lite-On Technology
hub 4-2:1.0: USB hub found
hub 4-2:1.0: 3 ports detected
dracut: dracut-005-3.fc13
udev: starting version 153
usb 4-2.1: new full speed USB device using uhci_hcd and address 4
async/0 used greatest stack depth: 6280 bytes left
usb 4-2.1: New USB device found, idVendor=3D04b3, idProduct=3D301b
usb 4-2.1: New USB device strings: Mfr=3D1, Product=3D3, SerialNumber=3D0=

usb 4-2.1: Product: USB Productivity Option Keyboard( has the hub in # 1 =
)
usb 4-2.1: Manufacturer: Lite-On Technology
input: Lite-On Technology USB Productivity Option Keyboard( has the hub i=
n # 1 ) as /devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2.1/4-2.1:1.0/inpu=
t/input3
async/1 used greatest stack depth: 6156 bytes left
generic-usb 0003:04B3:301B.0002: input,hidraw1: USB HID v1.10 Keyboard [L=
ite-On Technology USB Productivity Option Keyboard( has the hub in # 1 )]=
 on usb-0000:00:1a.1-2.1/input0
input: Lite-On Technology USB Productivity Option Keyboard( has the hub i=
n # 1 ) as /devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2.1/4-2.1:1.1/inpu=
t/input4
generic-usb 0003:04B3:301B.0003: input,hidraw2: USB HID v1.10 Device [Lit=
e-On Technology USB Productivity Option Keyboard( has the hub in # 1 )] o=
n usb-0000:00:1a.1-2.1/input1
[drm] Initialized drm 1.1.0 20060810
nouveau 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
nouveau 0000:01:00.0: setting latency timer to 64
[drm] nouveau 0000:01:00.0: Detected an NV40 generation card (0x246100b1)=

[drm] nouveau 0000:01:00.0: Attempting to load BIOS image from PRAMIN
[drm] nouveau 0000:01:00.0: ... BIOS checksum invalid
[drm] nouveau 0000:01:00.0: Attempting to load BIOS image from PROM
[drm] nouveau 0000:01:00.0: ... appears to be valid
[drm] nouveau 0000:01:00.0: BIT BIOS found
[drm] nouveau 0000:01:00.0: Bios version 05.72.22.75
[drm] nouveau 0000:01:00.0: TMDS table script pointers not stubbed
[drm] nouveau 0000:01:00.0: BIT table 'd' not found
[drm] nouveau 0000:01:00.0: Found Display Configuration Block version 3.0=

[drm] nouveau 0000:01:00.0: Raw DCB entry 0: 01000300 00000028
[drm] nouveau 0000:01:00.0: Raw DCB entry 1: 02011310 00000028
[drm] nouveau 0000:01:00.0: Raw DCB entry 2: 01011312 00000000
[drm] nouveau 0000:01:00.0: Raw DCB entry 3: 020223f1 0080c020
[drm] nouveau 0000:01:00.0: DCB connector table: VHER 0x30 5 10 2
[drm] nouveau 0000:01:00.0:   0: 0x00000000: type 0x00 idx 0 tag 0xff
[drm] nouveau 0000:01:00.0:   1: 0x00001130: type 0x30 idx 1 tag 0x07
[drm] nouveau 0000:01:00.0:   2: 0x00000210: type 0x10 idx 2 tag 0xff
[drm] nouveau 0000:01:00.0:   3: 0x00000211: type 0x11 idx 3 tag 0xff
[drm] nouveau 0000:01:00.0: Parsing VBIOS init table 0 at offset 0xD272
[drm] nouveau 0000:01:00.0: Parsing VBIOS init table 1 at offset 0xD576
[drm] nouveau 0000:01:00.0: Parsing VBIOS init table 2 at offset 0xDA93
[drm] nouveau 0000:01:00.0: Parsing VBIOS init table 3 at offset 0xDC0E
[drm] nouveau 0000:01:00.0: Parsing VBIOS init table 4 at offset 0xDD83
[drm] nouveau 0000:01:00.0: Detected 128MiB VRAM
[TTM] Zone  kernel: Available graphics memory: 412026 kiB.
[TTM] Zone highmem: Available graphics memory: 2020122 kiB.
[TTM] Initializing pool allocator.
[drm] nouveau 0000:01:00.0: 64 MiB GART (aperture)
[drm] nouveau 0000:01:00.0: Allocating FIFO number 0
[drm] nouveau 0000:01:00.0: nouveau_channel_alloc: initialised FIFO 0
[drm] nouveau 0000:01:00.0: Initial CRTC_OWNER is 0
[drm] nouveau 0000:01:00.0: Saving VGA fonts
[drm] nouveau 0000:01:00.0: Detected a VGA connector
[drm] nouveau 0000:01:00.0: Detected a DVI-I connector
[drm] nouveau 0000:01:00.0: Detected a TV connector
[drm] nouveau 0000:01:00.0: Setting dpms mode 3 on vga encoder (output 0)=

[drm] nouveau 0000:01:00.0: Setting dpms mode 3 on vga encoder (output 1)=

[drm] nouveau 0000:01:00.0: Setting dpms mode 3 on tmds encoder (output 2=
)
[drm] nouveau 0000:01:00.0: Setting dpms mode 3 on TV encoder (output 3)
[drm] nouveau 0000:01:00.0: allocated 1280x1024 fb: 0x49000, bo f5e5c8c0
fbcon: nouveaufb (fb0) is primary device
[drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga encoder (output 0)=

[drm] nouveau 0000:01:00.0: Output VGA-1 is running on CRTC 0 using outpu=
t A
Console: switching to colour frame buffer device 160x64
fb0: nouveaufb frame buffer device
drm: registered panic notifier
Slow work thread pool: Starting up
Slow work thread pool: Ready
[drm] Initialized nouveau 0.0.16 20090420 for 0000:01:00.0 on minor 0
modprobe used greatest stack depth: 5712 bytes left
dracut: Starting plymouth daemon
pata_marvell 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
pata_marvell 0000:03:00.0: setting latency timer to 64
scsi4 : pata_marvell
scsi5 : pata_marvell
ata5: PATA max UDMA/100 cmd 0x3018 ctl 0x3024 bmdma 0x3000 irq 17
ata6: DUMMY
firewire_ohci 0000:07:00.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
firewire_ohci: Added fw-ohci device 0000:07:00.0, OHCI v1.0, 8 IR + 8 IT =
contexts, quirks 0x0
firewire_ohci 0000:07:03.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
firewire_ohci: Added fw-ohci device 0000:07:03.0, OHCI v1.10, 4 IR + 8 IT=
 contexts, quirks 0x2
firewire_core: created device fw0: GUID 30bd050200002031, S400
firewire_core: created device fw1: GUID 00902700003372d2, S400
EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null)
dracut: Mounted root filesystem /dev/sda5
dracut: Loading SELinux policy
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
type=3D1404 audit(1288373255.500:2): selinux=3D0 auid=3D4294967295 ses=3D=
4294967295
dracut: /sbin/load_policy: Can't load policy file /etc/selinux/targeted/p=
olicy/policy.15: No such file or directory
dracut: Switching root
		Welcome to Fedora=20
		Press 'I' to enter interactive startup.
Starting udev: udevd[355]: specified group 'xenomai' unknown

[  OK  ]
Setting hostname calvin:  [  OK  ]
Setting up Logical Volume Management:   No volume groups found
[  OK  ]
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext4 (1) -- /] fsck.ext4 -a /dev/sda5=20
/dev/sda5: clean, 744890/3055616 files, 6685987/12209384 blocks
[/sbin/fsck.ext3 (1) -- /local] fsck.ext3 -a /dev/sda7=20
/local: clean, 747259/53002240 files, 10901333/105978789 blocks
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Enabling /etc/fstab swaps:  [  OK  ]
Entering non-interactive startup
Running DKMS auto installation service for kernel 2.6.35.7_xenomai-2.5.5.=
2_rtnet-39f7fcf-trace
=2EStopping regler_firewall (client): [  OK  ]
Starting regler_firewall (client): [  OK  ]
Starting auditd: [  OK  ]
Starting portreserve: [  OK  ]
/etc/rc5.d/S13cpuspeed: line 86: /sys/devices/system/cpu/cpu1/cpufreq/sca=
ling_governor: No such file or directory
/etc/rc5.d/S13cpuspeed: line 86: /sys/devices/system/cpu/cpu2/cpufreq/sca=
ling_governor: No such file or directory
/etc/rc5.d/S13cpuspeed: line 86: /sys/devices/system/cpu/cpu3/cpufreq/sca=
ling_governor: No such file or directory
/etc/rc5.d/S13cpuspeed: line 86: /sys/devices/system/cpu/cpu1/cpufreq/sca=
ling_min_freq: No such file or directory
/etc/rc5.d/S13cpuspeed: line 86: /sys/devices/system/cpu/cpu2/cpufreq/sca=
ling_min_freq: No such file or directory
/etc/rc5.d/S13cpuspeed: line 86: /sys/devices/system/cpu/cpu3/cpufreq/sca=
ling_min_freq: No such file or directory
cut: /sys/devices/system/cpu/cpu3/cpufreq/scaling_available_frequencies: =
No such file or directory
/etc/rc5.d/S13cpuspeed: line 86: echo: write error: Invalid argument
/etc/rc5.d/S13cpuspeed: line 86: /sys/devices/system/cpu/cpu1/cpufreq/sca=
ling_max_freq: No such file or directory
/etc/rc5.d/S13cpuspeed: line 86: /sys/devices/system/cpu/cpu2/cpufreq/sca=
ling_max_freq: No such file or directory
/etc/rc5.d/S13cpuspeed: line 86: /sys/devices/system/cpu/cpu3/cpufreq/sca=
ling_max_freq: No such file or directory
Enabling ondemand cpu frequency scaling: [  OK  ]
Starting irqbalance: [  OK  ]
Starting rpcbind: [  OK  ]
Starting mdmonitor: [  OK  ]
Starting system message bus: [  OK  ]
Starting Avahi daemon... [  OK  ]
Starting NFS statd: [  OK  ]
Starting RPC idmapd: [  OK  ]
Starting HAL daemon: [  OK  ]
Retrigger failed udev events[  OK  ]
Starting PC/SC smart card daemon (pcscd): [  OK  ]
Starting network_standalone:
Starting sendmail: [  OK  ]
Starting sm-client: [  OK  ]
Starting cups: [  OK  ]
Setting network parameters... [  OK  ]
Starting NetworkManager daemon: [  OK  ]
modem-manager: ModemManager (version 0.4-4.git20100720.fc13) starting...
modem-manager: Loaded plugin Longcheer
modem-manager: Loaded plugin Ericsson MBM
modem-manager: Loaded plugin SimTech
modem-manager: Loaded plugin Option
modem-manager: Loaded plugin AnyData
modem-manager: Loaded plugin Sierra
modem-manager: Loaded plugin Huawei
modem-manager: Loaded plugin Gobi
modem-manager: Loaded plugin Novatel
modem-manager: Loaded plugin MotoC
modem-manager: Loaded plugin Nokia
modem-manager: Loaded plugin ZTE
modem-manager: Loaded plugin Option High-Speed
nm-dispatcher.action: nm_dispatcher_action: Invalid connection: '(null)' =
/ 'connection setting not found' invalid: 1
ipsec_setup: Starting Openswan IPsec U2.6.27/K2.6.35.7_xenomai-2.5.5.2_rt=
net-39f7fcf-trace...
modem-manager: (tty/ttyS1): port's parent platform driver is not whitelis=
ted
modem-manager: (tty/ttyS14): port's parent platform driver is not whiteli=
sted
modem-manager: (tty/ttyS15): port's parent platform driver is not whiteli=
sted
modem-manager: (tty/ttyS16): port's parent platform driver is not whiteli=
sted
modem-manager: (tty/ttyS17): port's parent platform driver is not whiteli=
sted
modem-manager: (tty/ttyS18): port's parent platform driver is not whiteli=
sted
modem-manager: (tty/ttyS19): port's parent platform driver is not whiteli=
sted
modem-manager: (tty/ttyS2): port's parent platform driver is not whitelis=
ted
modem-manager: (tty/ttyS3): port's parent platform driver is not whitelis=
ted
modem-manager: (tty/ttyS0): could not get port's parent device
nm-dispatcher.action: nm_dispatcher_action: Invalid connection: '(null)' =
/ 'connection setting not found' invalid: 1
pluto[1406]: nss directory plutomain: /etc/ipsec.d
pluto[1406]: NSS Initialized
pluto[1406]: Non-fips mode set in /proc/sys/crypto/fips_enabled
pluto[1406]: Starting Pluto (Openswan Version 2.6.27; Vendor ID OEnTNwILv=
V~\134) pid:1406
pluto[1406]: Non-fips mode set in /proc/sys/crypto/fips_enabled
pluto[1406]: Setting NAT-Traversal port-4500 floating to on
pluto[1406]:    port floating activation criteria nat_t=3D1/port_float=3D=
1
pluto[1406]:    NAT-Traversal support  [enabled]
pluto[1406]: 1 bad entries in virtual_private - none loaded
pluto[1406]: ike_alg_register_enc(): Activating OAKLEY_TWOFISH_CBC_SSH: O=
k (ret=3D0)
pluto[1406]: ike_alg_register_enc(): Activating OAKLEY_TWOFISH_CBC: Ok (r=
et=3D0)
pluto[1406]: ike_alg_register_enc(): Activating OAKLEY_SERPENT_CBC: Ok (r=
et=3D0)
pluto[1406]: ike_alg_register_enc(): Activating OAKLEY_AES_CBC: Ok (ret=3D=
0)
pluto[1406]: ike_alg_register_enc(): Activating OAKLEY_BLOWFISH_CBC: Ok (=
ret=3D0)
pluto[1406]: ike_alg_register_hash(): Activating OAKLEY_SHA2_512: Ok (ret=
=3D0)
pluto[1406]: ike_alg_register_hash(): Activating OAKLEY_SHA2_256: Ok (ret=
=3D0)
pluto[1406]: no helpers will be started, all cryptographic operations wil=
l be done inline
pluto[1406]: Using Linux 2.6 IPsec interface code on 2.6.35.7_xenomai-2.5=
=2E5.2_rtnet-39f7fcf-trace (experimental code)
Enabling Bluetooth devices:
Starting sshd: [  OK  ]
Starting abrt daemon: [  OK  ]
Starting crond: [  OK  ]
pluto[1406]: ike_alg_register_enc(): Activating aes_ccm_8: Ok (ret=3D0)
pluto[1406]: ike_alg_add(): ERROR: Algorithm already exists
pluto[1406]: ike_alg_register_enc(): Activating aes_ccm_12: FAILED (ret=3D=
-17)
pluto[1406]: ike_alg_add(): ERROR: Algorithm already exists
pluto[1406]: ike_alg_register_enc(): Activating aes_ccm_16: FAILED (ret=3D=
-17)
pluto[1406]: ike_alg_add(): ERROR: Algorithm already exists
pluto[1406]: ike_alg_register_enc(): Activating aes_gcm_8: FAILED (ret=3D=
-17)
pluto[1406]: ike_alg_add(): ERROR: Algorithm already exists
pluto[1406]: ike_alg_register_enc(): Activating aes_gcm_12: FAILED (ret=3D=
-17)
pluto[1406]: ike_alg_add(): ERROR: Algorithm already exists
pluto[1406]: ike_alg_register_enc(): Activating aes_gcm_16: FAILED (ret=3D=
-17)
pluto[1406]: Could not change to directory '/etc/ipsec.d/cacerts': /
pluto[1406]: Could not change to directory '/etc/ipsec.d/aacerts': /
pluto[1406]: Could not change to directory '/etc/ipsec.d/ocspcerts': /
pluto[1406]: Could not change to directory '/etc/ipsec.d/crls'
pluto[1406]: listening for IKE messages
pluto[1406]: NAT-Traversal: Trying new style NAT-T
pluto[1406]: NAT-Traversal: ESPINUDP(1) setup failed for new style NAT-T =
family IPv4 (errno=3D19)
pluto[1406]: NAT-Traversal: Trying old style NAT-T
pluto[1406]: adding interface eth4/eth4 192.168.67.246:500
pluto[1406]: adding interface eth4/eth4 192.168.67.246:4500
pluto[1406]: adding interface eth0/eth0 130.235.83.112:500
pluto[1406]: adding interface eth0/eth0 130.235.83.112:4500
pluto[1406]: adding interface lo/lo 127.0.0.1:500
pluto[1406]: adding interface lo/lo 127.0.0.1:4500
pluto[1406]: adding interface lo/lo ::1:500
pluto[1406]: loading secrets from "/etc/ipsec.secrets"
pluto[1406]: no secrets filename matched "/etc/ipsec.d/*.secrets"
[  OK  ] atd: [  OK  ]
Registering binary handler for Windows applications: [  OK  ]

Fedora release 13 (Goddard)
Kernel 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf-trace on an i686 (/dev/ttyS=
4)

Kickstart-installed from sperry-02 at Fri Oct 15 11:46:04 CEST 2010
calvin login: simcom (? for help) > simcom (? for help) > SysRq : Changin=
g Loglevel
Loglevel set to 8
e1000 0000:07:01.0: PCI INT A disabled
nm-dispatcher.action: nm_dispatcher_action: Invalid connection: '(null)' =
/ 'connection setting not found' invalid: 1
nm-dispatcher.action: Error in get_property: Method "Get" with signature =
"ss" on interface "org.freedesktop.DBus.Properties" doesn't exist


rt_e1000 0000:07:01.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
e1000: 0000:07:01.0: e1000_probe: (PCI:33MHz:32-bit) 00:1b:21:7c:9f:0c
RTnet: registered rteth0
e1000: rteth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: rteth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
FS-Cache: Loaded
FS-Cache: Netfs 'nfs' registered for caching
mount.nfs used greatest stack depth: 4516 bytes left
I-pipe: Detected illicit call from domain 'Xenomai'
<3>        into a service reserved for domain 'Linux' and below.
Pid: 2259, comm: raw_test Not tainted 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7=
fcf-trace #1
Call Trace:
 [<c0492506>] ipipe_check_context+0x1b9/0x1c6
 [<c07d47de>] _raw_spin_lock_irqsave+0x17/0x87
 [<c05dd0dc>] dma_entry_alloc+0xf/0x6b
 [<c05dd339>] debug_dma_map_page+0x5d/0x12c
 [<f9fddb8c>] pci_map_single+0x8a/0x96 [rt_e1000]
 [<f9fddf45>] e1000_xmit_frame+0x318/0x458 [rt_e1000]
 [<f9cd6843>] ? rt_eth_header+0x0/0xa5 [rtnet]
 [<f9cd410c>] rtdev_xmit+0x17/0x3a [rtnet]
 [<f8aa42a0>] rt_packet_sendmsg+0x1b1/0x1e9 [rtpacket]
 [<f99b133e>] __rt_dev_sendmsg+0x41/0x60 [xeno_rtdm]
 [<f99b2d26>] sys_rtdm_sendmsg+0x53/0x63 [xeno_rtdm]
 [<f91286d3>] hisyscall_event+0x129/0x2b7 [xeno_nucleus]
 [<f91285aa>] ? hisyscall_event+0x0/0x2b7 [xeno_nucleus]
 [<c0492ce9>] __ipipe_dispatch_event+0x176/0x366
 [<c0420329>] __ipipe_syscall_root+0x4f/0x18e
 [<c07d50d5>] system_call+0x2d/0x53
I-pipe tracer log (100 points):
 |  #*func                    0 ipipe_trace_panic_freeze+0x4 (ipipe_check=
_context+0x13f)
 |  #*func                    0 ipipe_check_context+0x9 (_raw_spin_lock_i=
rqsave+0x17)
 |  #*func                    0 _raw_spin_lock_irqsave+0x6 (dma_entry_all=
oc+0xf)
 |  #*func                    0 nommu_map_page+0xc (pci_map_single+0x69 [=
rt_e1000])
 |  #*func                   -1 pci_map_single+0xc [rt_e1000] (e1000_xmit=
_frame+0x318 [rt_e1000])
 |  +*begin   0x80000000     -1 e1000_xmit_frame+0xdf [rt_e1000] (rtdev_x=
mit+0x17 [rtnet])
    +*func                   -2 e1000_xmit_frame+0x9 [rt_e1000] (rtdev_xm=
it+0x17 [rtnet])
    +*func                   -2 rtdev_xmit+0x5 [rtnet] (rt_packet_sendmsg=
+0x1b1 [rtpacket])
    +*func                   -2 rt_memcpy_fromkerneliovec+0x9 [rtnet] (rt=
_packet_sendmsg+0x19f [rtpacket])
    +*func                   -3 rt_eth_header+0x6 [rtnet] (rt_packet_send=
msg+0x15d [rtpacket])
 |  +*end     0x80000000     -3 __ipipe_restore_pipeline_head+0x11b (ipip=
e_restore_pipeline_head+0x86 [rtnet])
 |  #*func                   -3 __ipipe_restore_pipeline_head+0x5 (ipipe_=
restore_pipeline_head+0x86 [rtnet])
 |  #*func                   -4 ipipe_restore_pipeline_head+0x5 [rtnet] (=
rtskb_dequeue+0x42 [rtnet])
 |  +*begin   0x80000000     -4 ipipe_test_and_stall_pipeline_head+0x1b [=
rtnet] (rtskb_dequeue+0x11 [rtnet])
    +*func                   -4 ipipe_test_and_stall_pipeline_head+0x4 [r=
tnet] (rtskb_dequeue+0x11 [rtnet])
    +*func                   -4 rtskb_dequeue+0x5 [rtnet] (alloc_rtskb+0x=
12 [rtnet])
    +*func                   -5 alloc_rtskb+0x4 [rtnet] (rt_packet_sendms=
g+0xe0 [rtpacket])
 |  +*end     0x80000000     -5 __ipipe_restore_pipeline_head+0x11b (ipip=
e_restore_pipeline_head+0x86 [rtnet])
 |  #*func                   -5 __ipipe_restore_pipeline_head+0x5 (ipipe_=
restore_pipeline_head+0x86 [rtnet])
 |  #*func                   -5 ipipe_restore_pipeline_head+0x5 [rtnet] (=
rtdev_get_by_index+0x52 [rtnet])
 |  +*begin   0x80000000     -5 ipipe_test_and_stall_pipeline_head+0x1b [=
rtnet] (rtdev_get_by_index+0x19 [rtnet])
    +*func                   -6 ipipe_test_and_stall_pipeline_head+0x4 [r=
tnet] (rtdev_get_by_index+0x19 [rtnet])
    +*func                   -6 rtdev_get_by_index+0x5 [rtnet] (rt_packet=
_sendmsg+0xbf [rtpacket])
    +*func                   -6 rt_packet_sendmsg+0x9 [rtpacket] (__rt_de=
v_sendmsg+0x41 [xeno_rtdm])
 |  +*end     0x80000001     -6 rtdm_in_rt_context+0x66 [xeno_rtdm] (__rt=
_dev_sendmsg+0x31 [xeno_rtdm])
 |  +*begin   0x80000001     -7 rtdm_in_rt_context+0x22 [xeno_rtdm] (__rt=
_dev_sendmsg+0x31 [xeno_rtdm])
    +*func                   -7 rtdm_in_rt_context+0x6 [xeno_rtdm] (__rt_=
dev_sendmsg+0x31 [xeno_rtdm])
 |  +*end     0x80000000     -7 __ipipe_restore_pipeline_head+0x11b (ipip=
e_restore_pipeline_head+0x86 [xeno_rtdm])
 |  #*func                   -7 __ipipe_restore_pipeline_head+0x5 (ipipe_=
restore_pipeline_head+0x86 [xeno_rtdm])
 |  #*func                   -8 ipipe_restore_pipeline_head+0x5 [xeno_rtd=
m] (xnlock_put_irqrestore+0x22 [xeno_rtdm])
 |  #*func                   -8 xnlock_put_irqrestore+0x3 [xeno_rtdm] (rt=
dm_context_get+0x38 [xeno_rtdm])
 |  +*begin   0x80000000     -8 ipipe_test_and_stall_pipeline_head+0x1b [=
xeno_rtdm] (__xnlock_get_irqsave+0x11 [xeno_rtdm])
    +*func                   -8 ipipe_test_and_stall_pipeline_head+0x4 [x=
eno_rtdm] (__xnlock_get_irqsave+0x11 [xeno_rtdm])
    +*func                   -8 __xnlock_get_irqsave+0x5 [xeno_rtdm] (rtd=
m_context_get+0x1d [xeno_rtdm])
    +*func                   -9 rtdm_context_get+0x5 [xeno_rtdm] (__rt_de=
v_sendmsg+0x23 [xeno_rtdm])
    +*func                   -9 __rt_dev_sendmsg+0x9 [xeno_rtdm] (sys_rtd=
m_sendmsg+0x53 [xeno_rtdm])
    +*func                   -9 __copy_from_user_ll_nozero+0x6 (sys_rtdm_=
sendmsg+0x41 [xeno_rtdm])
    +*func                   -9 sys_rtdm_sendmsg+0x9 [xeno_rtdm] (hisysca=
ll_event+0x129 [xeno_nucleus])
    +*func                   -9 hisyscall_event+0x9 [xeno_nucleus] (__ipi=
pe_dispatch_event+0x176)
 |  +*end     0x80000001    -10 __ipipe_dispatch_event+0x167 (__ipipe_sys=
call_root+0x4f)
 |  +*begin   0x80000001    -10 __ipipe_dispatch_event+0x2c (__ipipe_sysc=
all_root+0x4f)
    +*func                  -10 __ipipe_dispatch_event+0x9 (__ipipe_sysca=
ll_root+0x4f)
    +*func                  -10 __ipipe_event_monitored_p+0x9 (__ipipe_sy=
scall_root+0x3b)
    +*func                  -10 __ipipe_syscall_root+0x9 (system_call+0x2=
d)
 |  +*end     0x80000001    -12 __ipipe_syscall_root+0x10a (system_call+0=
x2d)
 |  +*begin   0x80000001    -12 __ipipe_syscall_root+0x6c (system_call+0x=
2d)
 |  +*end     0x80000001    -12 __ipipe_dispatch_event+0x351 (__ipipe_sys=
call_root+0x4f)
 |  +*begin   0x80000001    -12 __ipipe_dispatch_event+0x199 (__ipipe_sys=
call_root+0x4f)
    +*func                  -13 __copy_to_user_ll+0x6 (__xn_safe_copy_to_=
user+0x28 [xeno_native])
    +*func                  -13 __xn_safe_copy_to_user+0x6 [xeno_native] =
(__rt_timer_read+0x35 [xeno_native])
    +*func                  -13 xnarch_tsc_to_ns+0x6 [xeno_nucleus] (xnar=
ch_get_cpu_time+0x10 [xeno_nucleus])
    +*func                  -13 xnarch_get_cpu_time+0x4 [xeno_nucleus] (_=
_rt_timer_read+0x1a [xeno_native])
    +*func                  -13 __rt_timer_read+0x8 [xeno_native] (hisysc=
all_event+0x129 [xeno_nucleus])
    +*func                  -14 hisyscall_event+0x9 [xeno_nucleus] (__ipi=
pe_dispatch_event+0x176)
 |  +*end     0x80000001    -14 __ipipe_dispatch_event+0x167 (__ipipe_sys=
call_root+0x4f)
 |  +*begin   0x80000001    -14 __ipipe_dispatch_event+0x2c (__ipipe_sysc=
all_root+0x4f)
    +*func                  -14 __ipipe_dispatch_event+0x9 (__ipipe_sysca=
ll_root+0x4f)
    +*func                  -14 __ipipe_event_monitored_p+0x9 (__ipipe_sy=
scall_root+0x3b)
    +*func                  -15 __ipipe_syscall_root+0x9 (system_call+0x2=
d)
 |  +*end     0x80000001    -15 __ipipe_syscall_root+0x10a (system_call+0=
x2d)
 |  +*begin   0x80000001    -16 __ipipe_syscall_root+0x6c (system_call+0x=
2d)
 |  +*end     0x80000001    -16 __ipipe_dispatch_event+0x351 (__ipipe_sys=
call_root+0x4f)
 |  +*begin   0x80000001    -16 __ipipe_dispatch_event+0x199 (__ipipe_sys=
call_root+0x4f)
    +*func                  -16 rtdm_context_unlock+0x3 [xeno_rtdm] (__rt=
_dev_recvmsg+0x56 [xeno_rtdm])
 |  +*end     0x80000000    -17 __ipipe_restore_pipeline_head+0x11b (xnlo=
ck_put_irqrestore.clone.0+0x9d [xeno_rtdm])
 |  #*func                  -17 __ipipe_restore_pipeline_head+0x5 (xnlock=
_put_irqrestore.clone.0+0x9d [xeno_rtdm])
 |  #*func                  -17 xnlock_put_irqrestore.clone.0+0x5 [xeno_r=
tdm] (rtdm_sem_timeddown+0xa3 [xeno_rtdm])
 |  +*begin   0x80000000    -17 __xnlock_get_irqsave.clone.1+0x1b [xeno_r=
tdm] (rtdm_sem_timeddown+0x1e [xeno_rtdm])
    +*func                  -18 __xnlock_get_irqsave.clone.1+0x4 [xeno_rt=
dm] (rtdm_sem_timeddown+0x1e [xeno_rtdm])
    +*func                  -18 rtdm_sem_timeddown+0x9 [xeno_rtdm] (rt_pa=
cket_recvmsg+0x58 [rtpacket])
    +*func                  -18 rt_packet_recvmsg+0x9 [rtpacket] (__rt_de=
v_recvmsg+0x41 [xeno_rtdm])
 |  +*end     0x80000001    -18 rtdm_in_rt_context+0x66 [xeno_rtdm] (__rt=
_dev_recvmsg+0x31 [xeno_rtdm])
 |  +*begin   0x80000001    -18 rtdm_in_rt_context+0x22 [xeno_rtdm] (__rt=
_dev_recvmsg+0x31 [xeno_rtdm])
    +*func                  -19 rtdm_in_rt_context+0x6 [xeno_rtdm] (__rt_=
dev_recvmsg+0x31 [xeno_rtdm])
 |  +*end     0x80000000    -19 __ipipe_restore_pipeline_head+0x11b (ipip=
e_restore_pipeline_head+0x86 [xeno_rtdm])
 |  #*func                  -19 __ipipe_restore_pipeline_head+0x5 (ipipe_=
restore_pipeline_head+0x86 [xeno_rtdm])
 |  #*func                  -19 ipipe_restore_pipeline_head+0x5 [xeno_rtd=
m] (xnlock_put_irqrestore+0x22 [xeno_rtdm])
 |  #*func                  -20 xnlock_put_irqrestore+0x3 [xeno_rtdm] (rt=
dm_context_get+0x38 [xeno_rtdm])
 |  +*begin   0x80000000    -20 ipipe_test_and_stall_pipeline_head+0x1b [=
xeno_rtdm] (__xnlock_get_irqsave+0x11 [xeno_rtdm])
    +*func                  -20 ipipe_test_and_stall_pipeline_head+0x4 [x=
eno_rtdm] (__xnlock_get_irqsave+0x11 [xeno_rtdm])
    +*func                  -20 __xnlock_get_irqsave+0x5 [xeno_rtdm] (rtd=
m_context_get+0x1d [xeno_rtdm])
    +*func                  -20 rtdm_context_get+0x5 [xeno_rtdm] (__rt_de=
v_recvmsg+0x23 [xeno_rtdm])
    +*func                  -21 __rt_dev_recvmsg+0x9 [xeno_rtdm] (sys_rtd=
m_recvmsg+0x53 [xeno_rtdm])
    +*func                  -21 __copy_from_user_ll_nozero+0x6 (sys_rtdm_=
recvmsg+0x41 [xeno_rtdm])
    +*func                  -21 sys_rtdm_recvmsg+0x9 [xeno_rtdm] (hisysca=
ll_event+0x129 [xeno_nucleus])
    +*func                  -21 hisyscall_event+0x9 [xeno_nucleus] (__ipi=
pe_dispatch_event+0x176)
 |  +*end     0x80000001    -21 __ipipe_dispatch_event+0x167 (__ipipe_sys=
call_root+0x4f)
 |  +*begin   0x80000001    -22 __ipipe_dispatch_event+0x2c (__ipipe_sysc=
all_root+0x4f)
    +*func                  -22 __ipipe_dispatch_event+0x9 (__ipipe_sysca=
ll_root+0x4f)
    +*func                  -22 __ipipe_event_monitored_p+0x9 (__ipipe_sy=
scall_root+0x3b)
    +*func                  -22 __ipipe_syscall_root+0x9 (system_call+0x2=
d)
 |  +*end     0x80000001    -24 __ipipe_syscall_root+0x10a (system_call+0=
x2d)
 |  +*begin   0x80000001    -24 __ipipe_syscall_root+0x6c (system_call+0x=
2d)
 |  +*end     0x80000001    -24 __ipipe_dispatch_event+0x351 (__ipipe_sys=
call_root+0x4f)
 |  +*begin   0x80000001    -24 __ipipe_dispatch_event+0x199 (__ipipe_sys=
call_root+0x4f)
    +*func                  -25 rtdm_context_unlock+0x3 [xeno_rtdm] (__rt=
_dev_ioctl+0xb9 [xeno_rtdm])
    +*func                  -25 rt_socket_common_ioctl+0x9 [rtnet] (rt_pa=
cket_ioctl+0x1b [rtpacket])
    +*func                  -25 rt_packet_ioctl+0x5 [rtpacket] (__rt_dev_=
ioctl+0x46 [xeno_rtdm])
 |  +*end     0x80000001    -25 rtdm_in_rt_context+0x66 [xeno_rtdm] (__rt=
_dev_ioctl+0x36 [xeno_rtdm])
 |  +*begin   0x80000001    -26 rtdm_in_rt_context+0x22 [xeno_rtdm] (__rt=
_dev_ioctl+0x36 [xeno_rtdm])
------------[ cut here ]------------
WARNING: at lib/dma-debug.c:820 check_unmap+0x315/0x5ca()
Hardware name:        =20
rt_e1000 0000:07:01.0: DMA-API: device driver frees DMA memory with wrong=
 function [device address=3D0x00000000335be280] [size=3D74 bytes] [mapped=
 as single] [unmapped as page]
Modules linked in: nfs fscache rtpacket xeno_native nfsd lockd nfs_acl au=
th_rpcgss exportfs deflate zlib_deflate ctr camellia cast5 rmd160 crypto_=
null ccm serpent blowfish twofish twofish_common ecb xcbc cbc sha256_gene=
ric sha512_generic des_generic aes_i586 aes_generic ah6 ah4 esp6 esp4 xfr=
m4_mode_beet xfrm4_tunnel tunnel4 xfrm4_mode_tunnel xfrm4_mode_transport =
xfrm6_mode_transport xfrm6_mode_ro xfrm6_mode_beet xfrm6_mode_tunnel ipco=
mp ipcomp6 xfrm_ipcomp xfrm6_tunnel tunnel6 af_key sunrpc ipv6 cpufreq_on=
demand acpi_cpufreq mperf uinput snd_hda_codec_idt rt_e1000 snd_hda_intel=
 rtnet snd_hda_codec xeno_rtdm snd_hwdep snd_seq snd_seq_device xeno_nucl=
eus snd_pcm ppdev snd_timer parport_pc e1000 microcode snd e1000e iTCO_wd=
t i2c_i801 pcspkr serio_raw parport iTCO_vendor_support soundcore snd_pag=
e_alloc firewire_ohci ata_generic firewire_core pata_acpi crc_itu_t pata_=
marvell nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core [last unload=
ed: scsi_wait_scan]
Pid: 1764, comm: sshd Not tainted 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf-=
trace #1
Call Trace:
 [<c043b11a>] warn_slowpath_common+0x6a/0x7f
 [<c05dcbf5>] ? check_unmap+0x315/0x5ca
 [<c043b1a2>] warn_slowpath_fmt+0x2b/0x2f
 [<c05dcbf5>] check_unmap+0x315/0x5ca
 [<c05dd03b>] debug_dma_unmap_page+0x5a/0x62
 [<f9fde0ee>] e1000_unmap_and_free_tx_resource+0x69/0x8a [rt_e1000]
 [<f9fdfc17>] e1000_intr+0x37c/0x58d [rt_e1000]
 [<f911d886>] xnintr_shirq_handler+0x78/0x1af [xeno_nucleus]
 [<c0493603>] __ipipe_dispatch_wired_nocheck+0xe1/0x176
 [<c04936fd>] __ipipe_dispatch_wired+0x65/0x6a
 [<c048d641>] ? __ipipe_ack_fasteoi_irq+0x0/0x10
 [<c04200f8>] __ipipe_handle_irq+0x10d/0x2ef
 [<c04693bb>] ? raw_local_irq_restore+0x3/0x18
 [<c0402ef6>] common_interrupt+0x36/0x50
 [<c04693bb>] ? raw_local_irq_restore+0x3/0x18
 [<c04900d8>] ? _rcu_barrier+0x12/0x99
 [<c049587d>] __ipipe_trace+0x5cb/0x5d3
 [<c04693bb>] ? raw_local_irq_restore+0x3/0x18
 [<c0495e8d>] ? ipipe_trace_function+0x19/0x1c
 [<c0402f43>] ? ftrace_call+0x5/0x8
 [<c04693c0>] ? raw_local_irq_restore+0x8/0x18
 [<c07d4ee4>] ? _raw_spin_unlock_irqrestore+0x34/0x4b
 [<c05d78e3>] ? debug_object_activate+0xd7/0x10f
 [<c0495e8d>] ? ipipe_trace_function+0x19/0x1c
 [<c0446a40>] ? debug_activate+0x19/0x47
 [<c0447624>] ? __mod_timer+0x76/0x10f
 [<c0495e01>] ? ipipe_trace_max_reset+0x44/0x8c
 [<c04477d8>] ? mod_timer_pending+0x14/0x16
 [<c075db0d>] ? __nf_ct_refresh_acct+0x52/0xbb
 [<c0762e04>] ? tcp_packet+0xcbd/0xedd
 [<c04939a4>] ? __ipipe_restore_root+0x34/0x37
 [<c0460cc2>] ? raw_local_irq_restore+0x11/0x13
 [<c04644e3>] ? lock_release+0x1bd/0x1c4
 [<c075d474>] ? rcu_read_unlock+0x1c/0x1e
 [<c075ded7>] ? nf_conntrack_find_get+0xaa/0xb4
 [<c075f1aa>] ? nf_conntrack_in+0x5e8/0x741
 [<c079d306>] ? ipv4_conntrack_local+0x37/0x41
 [<c075bdf8>] ? nf_iterate+0x34/0x67
 [<c076ca63>] ? dst_output+0x0/0x1a
 [<c075c01b>] ? nf_hook_slow+0x49/0xb5
 [<c076ca63>] ? dst_output+0x0/0x1a
 [<c076d7c4>] ? __ip_local_out+0x8b/0x95
 [<c076ca63>] ? dst_output+0x0/0x1a
 [<c076d7de>] ? ip_local_out+0x10/0x1f
 [<c076dd8f>] ? ip_queue_xmit+0x2e3/0x349
 [<c0776c2b>] ? tcp_init_cwnd+0x3/0x40
 [<c0495e8d>] ? ipipe_trace_function+0x19/0x1c
 [<c0402f43>] ? ftrace_call+0x5/0x8
 [<c077e64b>] ? tcp_transmit_skb+0x68f/0x6c5
 [<c07809f2>] ? tcp_write_xmit+0x75c/0x83a
 [<c0780b1e>] ? __tcp_push_pending_frames+0x1d/0x4c
 [<c0773f94>] ? tcp_push+0x86/0x8c
 [<c0775fe5>] ? tcp_sendmsg+0x63a/0x712
 [<c07322ea>] ? __sock_sendmsg+0x56/0x5f
 [<c0734103>] ? sock_aio_write+0xb2/0xbb
 [<c04ee32f>] ? do_sync_write+0x8f/0xca
 [<c0402f43>] ? ftrace_call+0x5/0x8
 [<c0598691>] ? cap_file_permission+0x8/0xc
 [<c059743c>] ? security_file_permission+0x14/0x16
 [<c04ee4d1>] ? rw_verify_area+0x9d/0xc0
 [<c04ee88c>] ? vfs_write+0x93/0xe4
 [<c04ee97b>] ? sys_write+0x40/0x62
 [<c040291d>] ? sysenter_do_call+0x12/0x16
---[ end trace 68d2153eed419a5b ]---
Mapped at:
 [<c05dd339>] debug_dma_map_page+0x5d/0x12c
 [<f9fddb8c>] pci_map_single+0x8a/0x96 [rt_e1000]
 [<f9fddf45>] e1000_xmit_frame+0x318/0x458 [rt_e1000]
 [<f9cd410c>] rtdev_xmit+0x17/0x3a [rtnet]
 [<f8aa42a0>] rt_packet_sendmsg+0x1b1/0x1e9 [rtpacket]
------------[ cut here ]------------
WARNING: at include/linux/ipipe.h:538 ipipe_restore_pipeline_head+0x2b/0x=
95 [rt_e1000]()
Hardware name:        =20
Modules linked in: nfs fscache rtpacket xeno_native nfsd lockd nfs_acl au=
th_rpcgss exportfs deflate zlib_deflate ctr camellia cast5 rmd160 crypto_=
null ccm serpent blowfish twofish twofish_common ecb xcbc cbc sha256_gene=
ric sha512_generic des_generic aes_i586 aes_generic ah6 ah4 esp6 esp4 xfr=
m4_mode_beet xfrm4_tunnel tunnel4 xfrm4_mode_tunnel xfrm4_mode_transport =
xfrm6_mode_transport xfrm6_mode_ro xfrm6_mode_beet xfrm6_mode_tunnel ipco=
mp ipcomp6 xfrm_ipcomp xfrm6_tunnel tunnel6 af_key sunrpc ipv6 cpufreq_on=
demand acpi_cpufreq mperf uinput snd_hda_codec_idt rt_e1000 snd_hda_intel=
 rtnet snd_hda_codec xeno_rtdm snd_hwdep snd_seq snd_seq_device xeno_nucl=
eus snd_pcm ppdev snd_timer parport_pc e1000 microcode snd e1000e iTCO_wd=
t i2c_i801 pcspkr serio_raw parport iTCO_vendor_support soundcore snd_pag=
e_alloc firewire_ohci ata_generic firewire_core pata_acpi crc_itu_t pata_=
marvell nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core [last unload=
ed: scsi_wait_scan]
Pid: 2259, comm: raw_test Tainted: G        W   2.6.35.7_xenomai-2.5.5.2_=
rtnet-39f7fcf-trace #1
Call Trace:
 [<c043b11a>] warn_slowpath_common+0x6a/0x7f
 [<f9fddbc3>] ? ipipe_restore_pipeline_head+0x2b/0x95 [rt_e1000]
 [<c043b143>] warn_slowpath_null+0x14/0x18
 [<f9fddbc3>] ipipe_restore_pipeline_head+0x2b/0x95 [rt_e1000]
 [<f9fde07b>] e1000_xmit_frame+0x44e/0x458 [rt_e1000]
 [<f9cd6843>] ? rt_eth_header+0x0/0xa5 [rtnet]
 [<f9cd410c>] rtdev_xmit+0x17/0x3a [rtnet]
 [<f8aa42a0>] rt_packet_sendmsg+0x1b1/0x1e9 [rtpacket]
 [<f99b133e>] __rt_dev_sendmsg+0x41/0x60 [xeno_rtdm]
 [<f99b2d26>] sys_rtdm_sendmsg+0x53/0x63 [xeno_rtdm]
 [<f91286d3>] hisyscall_event+0x129/0x2b7 [xeno_nucleus]
 [<f91285aa>] ? hisyscall_event+0x0/0x2b7 [xeno_nucleus]
 [<c0492ce9>] __ipipe_dispatch_event+0x176/0x366
 [<c0420329>] __ipipe_syscall_root+0x4f/0x18e
 [<c07d50d5>] system_call+0x2d/0x53
---[ end trace 68d2153eed419a5c ]---
BUG: spinlock lockup on CPU#0, gatekeeper/0/633, c0a21680
Pid: 633, comm: gatekeeper/0 Tainted: G        W   2.6.35.7_xenomai-2.5.5=
=2E2_rtnet-39f7fcf-trace #1
Call Trace:
 [<c05d5f58>] do_raw_spin_lock+0xfd/0x123
 [<c07d483a>] _raw_spin_lock_irqsave+0x73/0x87
 [<c05dce6e>] check_unmap+0x58e/0x5ca
 [<c05dd03b>] debug_dma_unmap_page+0x5a/0x62
 [<f9fdeab8>] pci_unmap_single.clone.0+0x4e/0x59 [rt_e1000]
 [<f9fdfa1d>] e1000_intr+0x182/0x58d [rt_e1000]
 [<f911d886>] xnintr_shirq_handler+0x78/0x1af [xeno_nucleus]
 [<c0493603>] __ipipe_dispatch_wired_nocheck+0xe1/0x176
 [<c04936fd>] __ipipe_dispatch_wired+0x65/0x6a
 [<c048d641>] ? __ipipe_ack_fasteoi_irq+0x0/0x10
 [<c04200f8>] __ipipe_handle_irq+0x10d/0x2ef
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c0402ef6>] common_interrupt+0x36/0x50
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c04e007b>] ? try_to_merge_with_ksm_page+0x10b/0x45b
 [<c0469ad2>] __module_address+0x5a/0x67
 [<c0469b03>] ? __module_text_address+0x10/0x49
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c0469b49>] ? is_module_text_address+0xd/0x14
 [<c04501c3>] ? __kernel_text_address+0x5a/0x60
 [<c04051f6>] ? print_context_stack+0x80/0x96
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c040b094>] ? save_stack_address+0x0/0x2d
 [<c0404473>] ? dump_trace+0x7b/0xa8
 [<c040b254>] ? save_stack_trace+0x22/0x3e
 [<c05dd123>] ? dma_entry_alloc+0x56/0x6b
 [<c05dd339>] ? debug_dma_map_page+0x5d/0x12c
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<f8d376be>] ? e1000_alloc_rx_buffers+0xa1/0x167 [e1000e]
 [<f8d36b58>] ? e1000_clean_rx_irq+0x2ab/0x302 [e1000e]
 [<f8d36e8e>] ? e1000_clean+0x6c/0x1f9 [e1000e]
 [<c074024a>] ? net_rx_action+0xa1/0x1b3
 [<c0440c1a>] ? __do_softirq+0xc3/0x181
 [<c0440d30>] ? do_softirq+0x58/0x7a
 [<c0440e7b>] ? irq_exit+0x44/0x77
 [<c0403c31>] ? do_IRQ+0x94/0xaa
 [<c0492991>] ? __ipipe_sync_stage+0x1c9/0x1ce
 [<c0403b9d>] ? do_IRQ+0x0/0xaa
 [<c0492996>] ? __xirq_end+0x0/0x49
 [<c0403b9d>] ? do_IRQ+0x0/0xaa
 [<c0493394>] ? __ipipe_walk_pipeline+0x1c6/0x1e4
 [<c0493691>] ? __ipipe_dispatch_wired_nocheck+0x16f/0x176
 [<c04936fd>] ? __ipipe_dispatch_wired+0x65/0x6a
 [<c04200f8>] ? __ipipe_handle_irq+0x10d/0x2ef
 [<c04209c4>] ? ipipe_trigger_irq+0x64/0x88
 [<c049396c>] ? __ipipe_unstall_root+0x7b/0x7f
 [<c07d4ead>] ? _raw_spin_unlock_irq+0x2c/0x2f
 [<c04322dc>] ? finish_task_switch+0x59/0xbe
 [<f911f14b>] ? __xnpod_schedule+0x84/0x6b6 [xeno_nucleus]
 [<c049381d>] ? __ipipe_restore_pipeline_head+0x11b/0x123
 [<f9127528>] ? xnpod_schedule+0x34/0x36 [xeno_nucleus]
 [<f912767a>] ? gatekeeper_thread+0x150/0x15f [xeno_nucleus]
 [<c0437159>] ? default_wake_function+0x0/0x12
 [<f912752a>] ? gatekeeper_thread+0x0/0x15f [xeno_nucleus]
 [<c0451bea>] ? kthread+0x64/0x69
 [<c0451b86>] ? kthread+0x0/0x69
 [<c0402f16>] ? kernel_thread_helper+0x6/0x10
sending NMI to all CPUs:
NMI backtrace for cpu 0
Modules linked in: nfs fscache rtpacket xeno_native nfsd lockd nfs_acl au=
th_rpcgss exportfs deflate zlib_deflate ctr camellia cast5 rmd160 crypto_=
null ccm serpent blowfish twofish twofish_common ecb xcbc cbc sha256_gene=
ric sha512_generic des_generic aes_i586 aes_generic ah6 ah4 esp6 esp4 xfr=
m4_mode_beet xfrm4_tunnel tunnel4 xfrm4_mode_tunnel xfrm4_mode_transport =
xfrm6_mode_transport xfrm6_mode_ro xfrm6_mode_beet xfrm6_mode_tunnel ipco=
mp ipcomp6 xfrm_ipcomp xfrm6_tunnel tunnel6 af_key sunrpc ipv6 cpufreq_on=
demand acpi_cpufreq mperf uinput snd_hda_codec_idt rt_e1000 snd_hda_intel=
 rtnet snd_hda_codec xeno_rtdm snd_hwdep snd_seq snd_seq_device xeno_nucl=
eus snd_pcm ppdev snd_timer parport_pc e1000 microcode snd e1000e iTCO_wd=
t i2c_i801 pcspkr serio_raw parport iTCO_vendor_support soundcore snd_pag=
e_alloc firewire_ohci ata_generic firewire_core pata_acpi crc_itu_t pata_=
marvell nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core [last unload=
ed: scsi_wait_scan]

Pid: 633, comm: gatekeeper/0 Tainted: G        W   2.6.35.7_xenomai-2.5.5=
=2E2_rtnet-39f7fcf-trace #1 DP35DP/       =20
EIP: 0060:[<c05d1a6e>] EFLAGS: 00000083 CPU: 0
EIP is at delay_tsc+0x37/0x61
EAX: a1230248 EBX: 00000048 ECX: 00000000 EDX: 00000105
ESI: a1230248 EDI: a1230200 EBP: f575b924 ESP: f575b90c
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
Process gatekeeper/0 (pid: 633, ti=3Df575a000 task=3Df4d3d600 task.ti=3Df=
575a000)
I-pipe domain Xenomai
Stack:
 00249f87 00000002 f575b92c 00000001 8f0edd20 00000000 f575b92c c05d1a0e
<0> f575b938 c041a485 c0a21680 f575b970 c05d5f5d c0939d5f 00000000 f4d3d9=
20
<0> 00000279 c0a21680 00000001 f4d3d920 8f0edd20 f4d3d600 c0a21680 c0a216=
90
Call Trace:
 [<c05d1a0e>] ? __const_udelay+0x34/0x36
 [<c041a485>] ? arch_trigger_all_cpu_backtrace+0x47/0x54
 [<c05d5f5d>] ? do_raw_spin_lock+0x102/0x123
 [<c07d483a>] ? _raw_spin_lock_irqsave+0x73/0x87
 [<c05dce6e>] ? check_unmap+0x58e/0x5ca
 [<c05dd03b>] ? debug_dma_unmap_page+0x5a/0x62
 [<f9fdeab8>] ? pci_unmap_single.clone.0+0x4e/0x59 [rt_e1000]
 [<f9fdfa1d>] ? e1000_intr+0x182/0x58d [rt_e1000]
 [<f911d886>] ? xnintr_shirq_handler+0x78/0x1af [xeno_nucleus]
 [<c0493603>] ? __ipipe_dispatch_wired_nocheck+0xe1/0x176
 [<c04936fd>] ? __ipipe_dispatch_wired+0x65/0x6a
 [<c048d641>] ? __ipipe_ack_fasteoi_irq+0x0/0x10
 [<c04200f8>] ? __ipipe_handle_irq+0x10d/0x2ef
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c0402ef6>] ? common_interrupt+0x36/0x50
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c04e007b>] ? try_to_merge_with_ksm_page+0x10b/0x45b
 [<c0469ad2>] ? __module_address+0x5a/0x67
 [<c0469b03>] ? __module_text_address+0x10/0x49
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c0469b49>] ? is_module_text_address+0xd/0x14
 [<c04501c3>] ? __kernel_text_address+0x5a/0x60
 [<c04051f6>] ? print_context_stack+0x80/0x96
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c040b094>] ? save_stack_address+0x0/0x2d
 [<c0404473>] ? dump_trace+0x7b/0xa8
 [<c040b254>] ? save_stack_trace+0x22/0x3e
 [<c05dd123>] ? dma_entry_alloc+0x56/0x6b
 [<c05dd339>] ? debug_dma_map_page+0x5d/0x12c
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<f8d376be>] ? e1000_alloc_rx_buffers+0xa1/0x167 [e1000e]
 [<f8d36b58>] ? e1000_clean_rx_irq+0x2ab/0x302 [e1000e]
 [<f8d36e8e>] ? e1000_clean+0x6c/0x1f9 [e1000e]
 [<c074024a>] ? net_rx_action+0xa1/0x1b3
 [<c0440c1a>] ? __do_softirq+0xc3/0x181
 [<c0440d30>] ? do_softirq+0x58/0x7a
 [<c0440e7b>] ? irq_exit+0x44/0x77
 [<c0403c31>] ? do_IRQ+0x94/0xaa
 [<c0492991>] ? __ipipe_sync_stage+0x1c9/0x1ce
 [<c0403b9d>] ? do_IRQ+0x0/0xaa
 [<c0492996>] ? __xirq_end+0x0/0x49
 [<c0403b9d>] ? do_IRQ+0x0/0xaa
 [<c0493394>] ? __ipipe_walk_pipeline+0x1c6/0x1e4
 [<c0493691>] ? __ipipe_dispatch_wired_nocheck+0x16f/0x176
 [<c04936fd>] ? __ipipe_dispatch_wired+0x65/0x6a
 [<c04200f8>] ? __ipipe_handle_irq+0x10d/0x2ef
 [<c04209c4>] ? ipipe_trigger_irq+0x64/0x88
 [<c049396c>] ? __ipipe_unstall_root+0x7b/0x7f
 [<c07d4ead>] ? _raw_spin_unlock_irq+0x2c/0x2f
 [<c04322dc>] ? finish_task_switch+0x59/0xbe
 [<f911f14b>] ? __xnpod_schedule+0x84/0x6b6 [xeno_nucleus]
 [<c049381d>] ? __ipipe_restore_pipeline_head+0x11b/0x123
 [<f9127528>] ? xnpod_schedule+0x34/0x36 [xeno_nucleus]
 [<f912767a>] ? gatekeeper_thread+0x150/0x15f [xeno_nucleus]
 [<c0437159>] ? default_wake_function+0x0/0x12
 [<f912752a>] ? gatekeeper_thread+0x0/0x15f [xeno_nucleus]
 [<c0451bea>] ? kthread+0x64/0x69
 [<c0451b86>] ? kthread+0x0/0x69
 [<c0402f16>] ? kernel_thread_helper+0x6/0x10
Code: e3 ff 64 8b 0d 58 3f ae c0 89 45 e8 8d 76 00 0f ae e8 0f 31 89 c7 8=
d 76 00 0f ae e8 0f 31 89 c3 89 c6 29 fb 3b 5d e8 73 22 f3 90 <64> 8b 1d =
58 3f ae c0 39 d9 74 e0 89 fa 29 f2 01 55 e8 8d 76 00=20
Call Trace:
 [<c05d1a0e>] __const_udelay+0x34/0x36
 [<c041a485>] arch_trigger_all_cpu_backtrace+0x47/0x54
 [<c05d5f5d>] do_raw_spin_lock+0x102/0x123
 [<c07d483a>] _raw_spin_lock_irqsave+0x73/0x87
 [<c05dce6e>] check_unmap+0x58e/0x5ca
 [<c05dd03b>] debug_dma_unmap_page+0x5a/0x62
 [<f9fdeab8>] pci_unmap_single.clone.0+0x4e/0x59 [rt_e1000]
 [<f9fdfa1d>] e1000_intr+0x182/0x58d [rt_e1000]
 [<f911d886>] xnintr_shirq_handler+0x78/0x1af [xeno_nucleus]
 [<c0493603>] __ipipe_dispatch_wired_nocheck+0xe1/0x176
 [<c04936fd>] __ipipe_dispatch_wired+0x65/0x6a
 [<c048d641>] ? __ipipe_ack_fasteoi_irq+0x0/0x10
 [<c04200f8>] __ipipe_handle_irq+0x10d/0x2ef
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c0402ef6>] common_interrupt+0x36/0x50
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c04e007b>] ? try_to_merge_with_ksm_page+0x10b/0x45b
 [<c0469ad2>] __module_address+0x5a/0x67
 [<c0469b03>] ? __module_text_address+0x10/0x49
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c0469b49>] ? is_module_text_address+0xd/0x14
 [<c04501c3>] ? __kernel_text_address+0x5a/0x60
 [<c04051f6>] ? print_context_stack+0x80/0x96
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c040b094>] ? save_stack_address+0x0/0x2d
 [<c0404473>] ? dump_trace+0x7b/0xa8
 [<c040b254>] ? save_stack_trace+0x22/0x3e
 [<c05dd123>] ? dma_entry_alloc+0x56/0x6b
 [<c05dd339>] ? debug_dma_map_page+0x5d/0x12c
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<f8d376be>] ? e1000_alloc_rx_buffers+0xa1/0x167 [e1000e]
 [<f8d36b58>] ? e1000_clean_rx_irq+0x2ab/0x302 [e1000e]
 [<f8d36e8e>] ? e1000_clean+0x6c/0x1f9 [e1000e]
 [<c074024a>] ? net_rx_action+0xa1/0x1b3
 [<c0440c1a>] ? __do_softirq+0xc3/0x181
 [<c0440d30>] ? do_softirq+0x58/0x7a
 [<c0440e7b>] ? irq_exit+0x44/0x77
 [<c0403c31>] ? do_IRQ+0x94/0xaa
 [<c0492991>] ? __ipipe_sync_stage+0x1c9/0x1ce
 [<c0403b9d>] ? do_IRQ+0x0/0xaa
 [<c0492996>] ? __xirq_end+0x0/0x49
 [<c0403b9d>] ? do_IRQ+0x0/0xaa
 [<c0493394>] ? __ipipe_walk_pipeline+0x1c6/0x1e4
 [<c0493691>] ? __ipipe_dispatch_wired_nocheck+0x16f/0x176
 [<c04936fd>] ? __ipipe_dispatch_wired+0x65/0x6a
 [<c04200f8>] ? __ipipe_handle_irq+0x10d/0x2ef
 [<c04209c4>] ? ipipe_trigger_irq+0x64/0x88
 [<c049396c>] ? __ipipe_unstall_root+0x7b/0x7f
 [<c07d4ead>] ? _raw_spin_unlock_irq+0x2c/0x2f
 [<c04322dc>] ? finish_task_switch+0x59/0xbe
 [<f911f14b>] ? __xnpod_schedule+0x84/0x6b6 [xeno_nucleus]
 [<c049381d>] ? __ipipe_restore_pipeline_head+0x11b/0x123
 [<f9127528>] ? xnpod_schedule+0x34/0x36 [xeno_nucleus]
 [<f912767a>] ? gatekeeper_thread+0x150/0x15f [xeno_nucleus]
 [<c0437159>] ? default_wake_function+0x0/0x12
 [<f912752a>] ? gatekeeper_thread+0x0/0x15f [xeno_nucleus]
 [<c0451bea>] ? kthread+0x64/0x69
 [<c0451b86>] ? kthread+0x0/0x69
 [<c0402f16>] ? kernel_thread_helper+0x6/0x10
Pid: 633, comm: gatekeeper/0 Tainted: G        W   2.6.35.7_xenomai-2.5.5=
=2E2_rtnet-39f7fcf-trace #1
Call Trace:
 [<c040890d>] ? show_regs+0x1f/0x25
 [<c07d6ae3>] default_nmi_watchdog_tick+0x9d/0x160
 [<c07d5f12>] do_nmi+0xbb/0x2c5
 [<c07d5ac1>] nmi_stack_correct+0x28/0x2d
 [<c05d1a6e>] ? delay_tsc+0x37/0x61
 [<c05d1a0e>] __const_udelay+0x34/0x36
 [<c041a485>] arch_trigger_all_cpu_backtrace+0x47/0x54
 [<c05d5f5d>] do_raw_spin_lock+0x102/0x123
 [<c07d483a>] _raw_spin_lock_irqsave+0x73/0x87
 [<c05dce6e>] check_unmap+0x58e/0x5ca
 [<c05dd03b>] debug_dma_unmap_page+0x5a/0x62
 [<f9fdeab8>] pci_unmap_single.clone.0+0x4e/0x59 [rt_e1000]
 [<f9fdfa1d>] e1000_intr+0x182/0x58d [rt_e1000]
 [<f911d886>] xnintr_shirq_handler+0x78/0x1af [xeno_nucleus]
 [<c0493603>] __ipipe_dispatch_wired_nocheck+0xe1/0x176
 [<c04936fd>] __ipipe_dispatch_wired+0x65/0x6a
 [<c048d641>] ? __ipipe_ack_fasteoi_irq+0x0/0x10
 [<c04200f8>] __ipipe_handle_irq+0x10d/0x2ef
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c0402ef6>] common_interrupt+0x36/0x50
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c04e007b>] ? try_to_merge_with_ksm_page+0x10b/0x45b
 [<c0469ad2>] __module_address+0x5a/0x67
 [<c0469b03>] ? __module_text_address+0x10/0x49
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c0469b49>] ? is_module_text_address+0xd/0x14
 [<c04501c3>] ? __kernel_text_address+0x5a/0x60
 [<c04051f6>] ? print_context_stack+0x80/0x96
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<c040b094>] ? save_stack_address+0x0/0x2d
 [<c0404473>] ? dump_trace+0x7b/0xa8
 [<c040b254>] ? save_stack_trace+0x22/0x3e
 [<c05dd123>] ? dma_entry_alloc+0x56/0x6b
 [<c05dd339>] ? debug_dma_map_page+0x5d/0x12c
 [<f8d373a2>] ? dma_map_single_attrs.clone.2+0x7a/0x86 [e1000e]
 [<f8d376be>] ? e1000_alloc_rx_buffers+0xa1/0x167 [e1000e]
 [<f8d36b58>] ? e1000_clean_rx_irq+0x2ab/0x302 [e1000e]
 [<f8d36e8e>] ? e1000_clean+0x6c/0x1f9 [e1000e]
 [<c074024a>] ? net_rx_action+0xa1/0x1b3
 [<c0440c1a>] ? __do_softirq+0xc3/0x181
 [<c0440d30>] ? do_softirq+0x58/0x7a
 [<c0440e7b>] ? irq_exit+0x44/0x77
 [<c0403c31>] ? do_IRQ+0x94/0xaa
 [<c0492991>] ? __ipipe_sync_stage+0x1c9/0x1ce
 [<c0403b9d>] ? do_IRQ+0x0/0xaa
 [<c0492996>] ? __xirq_end+0x0/0x49
 [<c0403b9d>] ? do_IRQ+0x0/0xaa
 [<c0493394>] ? __ipipe_walk_pipeline+0x1c6/0x1e4
 [<c0493691>] ? __ipipe_dispatch_wired_nocheck+0x16f/0x176
 [<c04936fd>] ? __ipipe_dispatch_wired+0x65/0x6a
 [<c04200f8>] ? __ipipe_handle_irq+0x10d/0x2ef
 [<c04209c4>] ? ipipe_trigger_irq+0x64/0x88
 [<c049396c>] ? __ipipe_unstall_root+0x7b/0x7f
 [<c07d4ead>] ? _raw_spin_unlock_irq+0x2c/0x2f
 [<c04322dc>] ? finish_task_switch+0x59/0xbe
 [<f911f14b>] ? __xnpod_schedule+0x84/0x6b6 [xeno_nucleus]
 [<c049381d>] ? __ipipe_restore_pipeline_head+0x11b/0x123
 [<f9127528>] ? xnpod_schedule+0x34/0x36 [xeno_nucleus]
 [<f912767a>] ? gatekeeper_thread+0x150/0x15f [xeno_nucleus]
 [<c0437159>] ? default_wake_function+0x0/0x12
 [<f912752a>] ? gatekeeper_thread+0x0/0x15f [xeno_nucleus]
 [<c0451bea>] ? kthread+0x64/0x69
 [<c0451b86>] ? kthread+0x0/0x69
 [<c0402f16>] ? kernel_thread_helper+0x6/0x10


--------------060804000506020809090509--

