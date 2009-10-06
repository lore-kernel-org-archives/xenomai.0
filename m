Message-ID: <4ACB4389.10109@domain.hid>
Date: Tue, 06 Oct 2009 15:18:01 +0200
From: Roman Pisl <rpisl@domain.hid>
MIME-Version: 1.0
References: <4AC5E895.8010107@domain.hid> <4AC5F49E.3070608@domain.hid>
	<4AC5FEAD.7000608@domain.hid> <4AC77576.9070700@domain.hid>
	<4AC9E655.5090006@domain.hid> <4AC9ED6B.4050004@domain.hid>
	<4AC9F4FA.5070409@domain.hid> <4ACA013F.8040602@domain.hid>
In-Reply-To: <4ACA013F.8040602@domain.hid>
Content-Type: multipart/mixed; boundary="------------050200080008060807070706"
Subject: Re: [Xenomai-help] Freeze on SMP x86-64
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------050200080008060807070706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

...
>
> Is there a chance to grab the panic log via serial line? The first of
> your two screenshots indicate that there might have happened something
> interesting before the NMI triggered, but it's scrolled out of sight.
>
> Jan
>

Hello,
here I send kernel panic (triggered by rt_task_sleep and latency test) 
grabbed via serial line.

I'm ready to help with resolving this issue.

Regards
Roman


--------------050200080008060807070706
Content-Type: text/plain;
 name="panic.latency"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="panic.latency"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.31.1-xenomai-i2.4-06 (root@domain.hid) (gcc version 4.4.1 (Gentoo 4.4.1 p1.0) ) #3 SMP Tue Oct 6 14:45:26 CEST 2009
[    0.000000] Command line: root=/dev/sda3 nmi_watchdog=2 console=ttyS0,115200
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cd9ffc00 (usable)
[    0.000000]  BIOS-e820: 00000000cd9ffc00 - 00000000cda53c00 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cda53c00 - 00000000cda55c00 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cda55c00 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000128000000 (usable)
[    0.000000] DMI 2.5 present.
[    0.000000] last_pfn = 0x128000 max_arch_pfn = 0x400000000
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] last_pfn = 0xcd9ff max_arch_pfn = 0x400000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000cd9ff000
[    0.000000] init_memory_mapping: 0000000100000000-0000000128000000
[    0.000000] ACPI: RSDP 00000000000fec00 00024 (v02 DELL  )
[    0.000000] ACPI: XSDT 00000000000fc7cb 00074 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: FACP 00000000000fc8fb 000F4 (v03 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: DSDT 00000000ffe9cff8 054AD (v01   DELL    dt_ex 00001000 INTL 20050624)
[    0.000000] ACPI: FACS 00000000cd9ffc00 00040
[    0.000000] ACPI: SSDT 00000000ffea25c4 000AA (v01   DELL    st_ex 00001000 INTL 20050624)
[    0.000000] ACPI: APIC 00000000000fc9ef 00092 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: BOOT 00000000000fca81 00028 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: ASF! 00000000000fcaa9 00096 (v32 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: MCFG 00000000000fcb3f 0003E (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: HPET 00000000000fcb7d 00038 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: TCPA 00000000000fcdd9 00032 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: DMAR 00000000000fce0b 00120 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: SLIC 00000000000fcbb5 00176 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] (7 early reservations) ==> bootmem [0000000000 - 0128000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0001000000 - 000179bb94]    TEXT DATA BSS ==> [0001000000 - 000179bb94]
[    0.000000]   #3 [000009a000 - 0000100000]    BIOS reserved ==> [000009a000 - 0000100000]
[    0.000000]   #4 [000179c000 - 000179c1f0]              BRK ==> [000179c000 - 000179c1f0]
[    0.000000]   #5 [0000008000 - 000000c000]          PGTABLE ==> [0000008000 - 000000c000]
[    0.000000]   #6 [000000c000 - 000000d000]          PGTABLE ==> [000000c000 - 000000d000]
[    0.000000] found SMP MP-table at [ffff8800000fe710] fe710
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00128000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009a
[    0.000000]     0: 0x00000100 -> 0x000cd9ff
[    0.000000]     0: 0x00100000 -> 0x00128000
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x01] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x02] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x03] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] 8 Processors exceeds NR_CPUS limit of 4
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] Allocating PCI resources starting at d0000000 (gap: d0000000:10000000)
[    0.000000] NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 30 pages at ffff880028022000, static data 93856 bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 989291
[    0.000000] Kernel command line: root=/dev/sda3 nmi_watchdog=2 console=ttyS0,115200
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] xsave/xrstor: enabled xstate_bv 0x3, cntxt size 0x240
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.000000] Placing 64MB software IO TLB between ffff880020000000 - ffff880024000000
[    0.000000] software IO TLB at phys 0x20000000 - 0x24000000
[    0.000000] Memory: 3884988k/4849664k available (4260k kernel code, 825756k absent, 137936k reserved, 2034k data, 432k init)
[    0.000000] SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:384
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2659.879 MHz processor.
[    0.000042] I-pipe 2.4-06: pipeline enabled.
[    0.003096] Console: colour VGA+ 80x25
[    0.003113] console [ttyS0] enabled
[    0.004000] HPET: 8 timers in total, 4 timers will be used for per-cpu timer
[    0.004008] Calibrating delay loop (skipped), value calculated using timer frequency.. 5319.75 BogoMIPS (lpj=10639516)
[    0.012022] Mount-cache hash table entries: 256
[    0.016112] Initializing cgroup subsys ns
[    0.020004] Initializing cgroup subsys cpuacct
[    0.024006] Initializing cgroup subsys freezer
[    0.028010] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.033650] CPU: L2 cache: 3072K
[    0.036003] CPU: Physical Processor ID: 0
[    0.040002] CPU: Processor Core ID: 0
[    0.044003] mce: CPU supports 6 MCE banks
[    0.048006] CPU0: Thermal monitoring enabled (TM2)
[    0.052003] Performance Counters: Core2 events, Intel PMU driver.
[    0.060003] ... version:                 2
[    0.064002] ... bit width:               40
[    0.068002] ... generic counters:        2
[    0.072002] ... value mask:              000000ffffffffff
[    0.076002] ... max period:              000000007fffffff
[    0.080002] ... fixed-purpose counters:  3
[    0.084002] ... counter mask:            0000000700000003
[    0.088011] Freeing SMP alternatives: 35k freed
[    0.092021] ACPI: Core revision 20090521
[    0.336906] Setting APIC routing to flat
[    0.340306] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.344001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.344001] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.344001] ..... (found apic 0 pin 2) ...
[    0.386514] ....... works.
[    0.388002] CPU0: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz stepping 0a
[    0.400001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 5319.98 BogoMIPS (lpj=10639975)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 3072K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] mce: CPU supports 6 MCE banks
[    0.004000] CPU1: Thermal monitoring enabled (TM2)
[    0.004000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[    0.489164] CPU1: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz stepping 0a
[    0.497224] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.500072] Booting processor 2 APIC 0x2 ip 0x6000
[    0.004000] Initializing CPU#2
[    0.004000] Calibrating delay using timer specific routine.. 5320.00 BogoMIPS (lpj=10640017)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 3072K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 2
[    0.004000] mce: CPU supports 6 MCE banks
[    0.004000] CPU2: Thermal monitoring enabled (TM2)
[    0.004000] x86 PAT enabled: cpu 2, old 0x7040600070406, new 0x7010600070106
[    0.597282] CPU2: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz stepping 0a
[    0.605223] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    0.608059] Booting processor 3 APIC 0x3 ip 0x6000
[    0.004000] Initializing CPU#3
[    0.004000] Calibrating delay using timer specific routine.. 5320.00 BogoMIPS (lpj=10640010)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 3072K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 3
[    0.004000] mce: CPU supports 6 MCE banks
[    0.004000] CPU3: Thermal monitoring enabled (TM2)
[    0.004000] x86 PAT enabled: cpu 3, old 0x7040600070406, new 0x7010600070106
[    0.705231] CPU3: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz stepping 0a
[    0.713225] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
[    0.716018] Brought up 4 CPUs
[    0.720004] Total of 4 processors activated (21279.75 BogoMIPS).
[    0.724038] Testing NMI watchdog ... OK.
[    0.809597] NET: Registered protocol family 16
[    0.812029] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.816004] ACPI: bus type pci registered
[    0.820006] PCI: Using configuration type 1 for base access
[    0.832034] bio: create slab <bio-0> at 0
[    0.902534] ACPI: BIOS _OSI(Linux) query ignored
[    0.934344] ACPI: Interpreter enabled
[    0.936004] ACPI: (supports S0 S5)
[    0.940547] ACPI: Using IOAPIC for interrupt routing
[    1.052369] ACPI Warning: Incorrect checksum in table [TCPA] - 00, should be 7F 20090521 tbutils-246
[    1.062354] ACPI: ACPI Dock Station Driver: 1 docks/bays found
[    1.072373] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    1.076208] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.080007] pci 0000:00:03.0: PME# disabled
[    1.088337] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    1.092005] pci 0000:00:19.0: PME# disabled
[    1.096270] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    1.100006] pci 0000:00:1a.7: PME# disabled
[    1.104071] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.108010] pci 0000:00:1b.0: PME# disabled
[    1.112050] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.116006] pci 0000:00:1c.0: PME# disabled
[    1.120050] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.124005] pci 0000:00:1c.1: PME# disabled
[    1.132254] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    1.136006] pci 0000:00:1d.7: PME# disabled
[    1.140203] pci 0000:00:1f.2: PME# supported from D3hot
[    1.144005] pci 0000:00:1f.2: PME# disabled
[    1.148204] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot
[    1.152006] pci 0000:03:00.0: PME# disabled
[    1.156078] pci 0000:03:02.0: PME# supported from D1 D2 D3hot D3cold
[    1.160006] pci 0000:03:02.0: PME# disabled
[    1.164041] pci 0000:00:1e.0: transparent bridge
[    2.617387] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
[    2.625933] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 15)
[    2.633859] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
[    2.641581] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
[    2.649576] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
[    2.658550] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 9 10 11 12 15)
[    2.666297] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
[    2.674117] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 15)
[    2.681298] SCSI subsystem initialized
[    2.684038] usbcore: registered new interface driver usbfs
[    2.688026] usbcore: registered new interface driver hub
[    2.692038] usbcore: registered new device driver usb
[    2.696038] PCI: Using ACPI for IRQ routing
[    2.748009] pnp: PnP ACPI init
[    2.751047] ACPI: bus type pnp registered
[    2.807235] pnp: PnP ACPI: found 9 devices
[    2.811319] ACPI: ACPI bus type pnp unregistered
[    2.815931] system 00:01: ioport range 0x800-0x85f has been reserved
[    2.822265] system 00:01: ioport range 0xc00-0xc7f has been reserved
[    2.828598] system 00:01: ioport range 0x860-0x8ff has been reserved
[    2.840075] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:01
[    2.845977] pci 0000:00:1c.0:   IO window: disabled
[    2.850840] pci 0000:00:1c.0:   MEM window: 0xfe500000-0xfe5fffff
[    2.856915] pci 0000:00:1c.0:   PREFETCH window: disabled
[    2.862298] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:02
[    2.868199] pci 0000:00:1c.1:   IO window: disabled
[    2.873063] pci 0000:00:1c.1:   MEM window: 0xfe400000-0xfe4fffff
[    2.879138] pci 0000:00:1c.1:   PREFETCH window: disabled
[    2.884521] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:03
[    2.890424] pci 0000:00:1e.0:   IO window: 0xd000-0xdfff
[    2.895720] pci 0000:00:1e.0:   MEM window: 0xfe300000-0xfe3fffff
[    2.901796] pci 0000:00:1e.0:   PREFETCH window: disabled
[    2.907187] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.913874] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    2.920591] NET: Registered protocol family 2
[    2.924951] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    2.932426] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    2.941140] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    2.948226] TCP: Hash tables configured (established 262144 bind 65536)
[    2.954820] TCP reno registered
[    2.958036] NET: Registered protocol family 1
[    2.962563] Simple Boot Flag at 0x7a set to 0x1
[    2.968879] audit: initializing netlink socket (disabled)
[    2.974267] type=2000 audit(1254841152.972:1): initialized
[    2.982428] I-pipe: Domain Xenomai registered.
[    2.986954] Xenomai: hal/x86_64 started.
[    2.990884] Xenomai: scheduling class idle registered.
[    2.996006] Xenomai: scheduling class rt registered.
[    3.003798] Xenomai: real-time nucleus v2.5-rc3 (Flying In A Blue Dream) loaded.
[    3.011332] Xenomai: NMI watchdog started (threshold=100 us).
[    3.017097] Xenomai: starting native API services.
[    3.021878] Xenomai: starting POSIX services.
[    3.026629] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.038214] Installing knfsd (copyright (C) 1996 okir@domain.hid).
[    3.045233] fuse init (API version 7.12)
[    3.049409] msgmni has been set to 7589
[    3.053722] alg: No test for stdrng (krng)
[    3.058013] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    3.065387] io scheduler noop registered
[    3.069296] io scheduler anticipatory registered
[    3.073899] io scheduler deadline registered
[    3.078167] io scheduler cfq registered (default)
[    3.083571] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    3.093304] Non-volatile memory driver v1.3
[    3.097476] Linux agpgart interface v0.103
[    3.101569] agpgart-intel 0000:00:00.0: Intel Q45/Q43 Chipset
[    3.108156] agpgart-intel 0000:00:00.0: detected 32764K stolen memory
[    3.116739] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    3.123641] [drm] Initialized drm 1.1.0 20060810
[    3.128261] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    3.798656] [drm] TMDS-8: set mode 1920x1080 13
[    4.028846] Console: switching to colour frame buffer device 240x67
[    4.043889] [drm] fb0: inteldrmfb frame buffer device
[    4.048938] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    4.056122] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.316147] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    4.322666] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    4.328370] serial 0000:00:03.3: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    4.335408] 0000:00:03.3: ttyS1 at I/O 0xec98 (irq = 17) is a 16550A
[    4.344169] brd: module loaded
[    4.348340] loop: module loaded
[    4.351839] ahci 0000:00:1f.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    4.358698] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x2f impl RAID mode
[    4.366850] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio ems 
[    4.404066] scsi0 : ahci
[    4.406833] scsi1 : ahci
[    4.409536] scsi2 : ahci
[    4.412235] scsi3 : ahci
[    4.414936] scsi4 : ahci
[    4.417638] scsi5 : ahci
[    4.421777] ata1: SATA max UDMA/133 abar m2048@domain.hid port 0xff970100 irq 31
[    4.429155] ata2: SATA max UDMA/133 abar m2048@domain.hid port 0xff970180 irq 31
[    4.436528] ata3: SATA max UDMA/133 abar m2048@domain.hid port 0xff970200 irq 31
[    4.443902] ata4: SATA max UDMA/133 abar m2048@domain.hid port 0xff970280 irq 31
[    4.451274] ata5: DUMMY
[    4.453712] ata6: SATA max UDMA/133 abar m2048@domain.hid port 0xff970380 irq 31
[    4.461429] Intel(R) PRO/1000 Network Driver - version 7.3.21-k3-NAPI
[    4.467850] Copyright (c) 1999-2006 Intel Corporation.
[    4.473035] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
[    4.478935] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    4.484767] e1000e 0000:00:19.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[    4.491708] e1000e 0000:00:19.0: pci_enable_pcie_error_reporting failed 0xfffffffb
[    4.608581] 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:24:e8:39:3c:95
[    4.615954] 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    4.622321] 0000:00:19.0: eth0: MAC: 8, PHY: 8, PBA No: 2021ff-0ff
[    4.628547] Intel(R) Gigabit Ethernet Network Driver - version 1.3.16-k2
[    4.635227] Copyright (c) 2007-2009 Intel Corporation.
[    4.640409] Intel(R) Virtual Function Network Driver - version 1.0.0-k0
[    4.647003] Copyright (c) 2009 Intel Corporation.
[    4.651760] <6>8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    4.658181] 8139cp 0000:03:02.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    4.667772] tun: Universal TUN/TAP device driver, 1.6
[    4.672807] tun: (C) 1999-2004 Max Krasnyansky <maxk@domain.hid>
[    4.679165] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.685686] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[    4.692808] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    4.698110] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    4.709392] ehci_hcd 0000:00:1a.7: debug port 1
[    4.713927] ehci_hcd 0000:00:1a.7: irq 22, io mem 0xfe6da000
[    4.732011] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    4.737776] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    4.744543] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.751743] usb usb1: Product: EHCI Host Controller
[    4.756606] usb usb1: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 ehci_hcd
[    4.763544] usb usb1: SerialNumber: 0000:00:1a.7
[    4.768233] usb usb1: configuration #1 chosen from 1 choice
[    4.773866] hub 1-0:1.0: USB hub found
[    4.777608] hub 1-0:1.0: 6 ports detected
[    4.780039] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.780059] ata3: SATA link down (SStatus 4 SControl 300)
[    4.780080] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.780095] ata4: SATA link down (SStatus 4 SControl 300)
[    4.780112] ata6: SATA link down (SStatus 0 SControl 300)
[    4.806901] ata2.00: ATAPI: PLDS DVD+/-RW DH-16AAS, JD12, max UDMA/100, ATAPI AN
[    4.806924] ata1.00: ATA-8: ST3500418AS, CC44, max UDMA/133
[    4.806926] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    4.809380] ata2.00: configured for UDMA/100
[    4.833961] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    4.841084] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    4.846367] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    4.847286] ata1.00: configured for UDMA/133
[    4.847374] scsi 0:0:0:0: Direct-Access     ATA      ST3500418AS      CC44 PQ: 0 ANSI: 5
[    4.847587] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.847663] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    4.847697] sd 0:0:0:0: [sda] Write Protect is off
[    4.847716] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.892588] scsi 1:0:0:0: CD-ROM            PLDS     DVD+-RW DH-16AAS JD12 PQ: 0 ANSI: 5
[    4.896513] ehci_hcd 0000:00:1d.7: debug port 1
[    4.896533] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xff980000
[    4.900473]  sda:
[    4.908013] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    4.908033] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    4.908035] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.908036] usb usb2: Product: EHCI Host Controller
[    4.908038] usb usb2: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 ehci_hcd
[    4.908039] usb usb2: SerialNumber: 0000:00:1d.7
[    4.908122] usb usb2: configuration #1 chosen from 1 choice
[    4.908187] hub 2-0:1.0: USB hub found
[    4.908191] hub 2-0:1.0: 6 ports detected
[    4.908291] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.908348] uhci_hcd: USB Universal Host Controller Interface driver
[    4.908433] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    4.908441] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    4.908511] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    4.908518] uhci_hcd 0000:00:1a.0: detected 2 ports
[    4.908551] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ff20
[    4.908585] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    4.908586] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.908588] usb usb3: Product: UHCI Host Controller
[    4.908589] usb usb3: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhci_hcd
[    4.908591] usb usb3: SerialNumber: 0000:00:1a.0
[    4.908669] usb usb3: configuration #1 chosen from 1 choice
[    4.908741] hub 3-0:1.0: USB hub found
[    4.908746] hub 3-0:1.0: 2 ports detected
[    4.908792] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    4.908799] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    4.908874] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    4.908881] uhci_hcd 0000:00:1a.1: detected 2 ports
[    4.908914] uhci_hcd 0000:00:1a.1: irq 17, io base 0x0000ff00
[    4.908946] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    4.908947] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.908949] usb usb4: Product: UHCI Host Controller
[    4.908950] usb usb4: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhci_hcd
[    4.908952] usb usb4: SerialNumber: 0000:00:1a.1
[    4.909038] usb usb4: configuration #1 chosen from 1 choice
[    4.909109] hub 4-0:1.0: USB hub found
[    4.909114] hub 4-0:1.0: 2 ports detected
[    4.909159] uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[    4.909167] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    4.909234] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    4.909241] uhci_hcd 0000:00:1a.2: detected 2 ports
[    4.909265] uhci_hcd 0000:00:1a.2: irq 22, io base 0x0000fc00
[    4.909297] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    4.909299] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.909300] usb usb5: Product: UHCI Host Controller
[    4.909302] usb usb5: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhci_hcd
[    4.909303] usb usb5: SerialNumber: 0000:00:1a.2
[    4.909384] usb usb5: configuration #1 chosen from 1 choice
[    4.909447] hub 5-0:1.0: USB hub found
[    4.909452] hub 5-0:1.0: 2 ports detected
[    4.909498] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    4.909506] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    4.909574] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    4.909581] uhci_hcd 0000:00:1d.0: detected 2 ports
[    4.909605] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000ff80
[    4.909636] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    4.909638] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.909639] usb usb6: Product: UHCI Host Controller
[    4.909641] usb usb6: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhci_hcd
[    4.909642] usb usb6: SerialNumber: 0000:00:1d.0
[    4.909722] usb usb6: configuration #1 chosen from 1 choice
[    4.909793] hub 6-0:1.0: USB hub found
[    4.909797] hub 6-0:1.0: 2 ports detected
[    4.909845] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    4.909851] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    4.909919] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    4.909926] uhci_hcd 0000:00:1d.1: detected 2 ports
[    4.909950] uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000ff60
[    4.909985] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    4.909987] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.909988] usb usb7: Product: UHCI Host Controller
[    4.909990] usb usb7: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhci_hcd
[    4.909991] usb usb7: SerialNumber: 0000:00:1d.1
[    4.910069] usb usb7: configuration #1 chosen from 1 choice
[    4.910135] hub 7-0:1.0: USB hub found
[    4.910139] hub 7-0:1.0: 2 ports detected
[    4.910186] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    4.910193] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    4.910258] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    4.910265] uhci_hcd 0000:00:1d.2: detected 2 ports
[    4.910300] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
[    4.910340] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    4.910342] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.910343] usb usb8: Product: UHCI Host Controller
[    4.910345] usb usb8: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhci_hcd
[    4.910346] usb usb8: SerialNumber: 0000:00:1d.2
[    4.910427] usb usb8: configuration #1 chosen from 1 choice
[    4.910500] hub 8-0:1.0: USB hub found
[    4.910504] hub 8-0:1.0: 2 ports detected
[    4.910659] usbcore: registered new interface driver usblp
[    4.910661] Initializing USB Mass Storage driver...
[    4.910734] usbcore: registered new interface driver usb-storage
[    4.910735] USB Mass Storage support registered.
[    4.910803] usbcore: registered new interface driver libusual
[    4.911018] PNP: No PS/2 controller found. Probing ports directly.
[    4.925152]  sda1 sda2 sda3 sda4 < sda5 sda6 >
[    5.455328] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.456069] serio: i8042 KBD port at 0x60,0x64 irq 1
[    5.456074] serio: i8042 AUX port at 0x60,0x64 irq 12
[    5.456195] mice: PS/2 mouse device common for all mice
[    5.456339] rtc_cmos 00:05: RTC can wake from S4
[    5.456401] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    5.456433] rtc0: alarms up to one day, 242 bytes nvram, hpet irqs
[    5.456487] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    5.456611] cpuidle: using governor ladder
[    5.456612] cpuidle: using governor menu
[    5.458055] usbcore: registered new interface driver hiddev
[    5.458110] usbcore: registered new interface driver usbhid
[    5.458111] usbhid: v2.6:USB HID core driver
[    5.458129] Netfilter messages via NETLINK v0.30.
[    5.458141] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    5.458328] ctnetlink v0.93: registering with nfnetlink.
[    5.458413] ip_tables: (C) 2000-2006 Netfilter Core Team
[    5.458433] TCP cubic registered
[    5.458434] Initializing XFRM netlink socket
[    5.458691] NET: Registered protocol family 10
[    5.458857] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    5.458873] IPv6 over IPv4 tunneling driver
[    5.458994] NET: Registered protocol family 17
[    5.459129] RPC: Registered udp transport module.
[    5.459131] RPC: Registered tcp transport module.
[    5.585623] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    5.593090] Uniform CD-ROM driver Revision: 3.20
[    5.597922] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    5.675001] kjournald starting.  Commit interval 5 seconds
[    5.675011] EXT3-fs: mounted filesystem with writeback data mode.
[    5.675022] VFS: Mounted root (ext3 filesystem) readonly on device 8:3.
[    5.675045] Freeing unused kernel memory: 432k freed
[    6.096012] usb 5-1: new full speed USB device using uhci_hcd and address 2
[    6.297373] usb 5-1: New USB device found, idVendor=413c, idProduct=2101
[    6.304061] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.311178] usb 5-1: Product: Dell Smart Card Reader Keyboard
[    6.316907] usb 5-1: Manufacturer: Dell
[    6.320841] usb 5-1: configuration #1 chosen from 1 choice
[    6.333696] input: Dell Dell Smart Card Reader Keyboard as /devices/pci0000:00/0000:00:1a.2/usb5/5-1/5-1:1.0/input/input0
[    6.344805] generic-usb 0003:413C:2101.0001: input,hidraw0: USB HID v1.11 Keyboard [Dell Dell Smart Card Reader Keyboard] on usb-0000:00:1a.2-1/input0
[    6.600024] usb 5-2: new low speed USB device using uhci_hcd and address 3
[   64.668504] BUG: NMI Watchdog detected LOCKUP on CPU0, ip ffffffff8134b8c6, registers:
[   64.668504] CPU 0 
[   64.668504] Modules linked in: 8139too
[   64.668504] Pid: 4969, comm: sampling-4967 Not tainted 2.6.31.1-xenomai-i2.4-06 #3 OptiPlex 960                 
[   64.668504] RIP: 0010:[<ffffffff8134b8c6>]  [<ffffffff8134b8c6>] rthal_nmi_arm+0x86/0xe2
[   64.668504] RSP: 0018:ffff880126559cb8  EFLAGS: 00000086
[   64.668504] RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 00000000000000c2
[   64.668504] RDX: 0000000000000000 RSI: 0000000000000187 RDI: 0000000000000001
[   64.668504] RBP: ffffffff8178e6c0 R08: 0000000000006340 R09: 0000000000000639
[   64.668504] R10: 0000000000000007 R11: 0000000000000006 R12: 000000000004dcb3
[   64.668504] R13: 000000344a47cb20 R14: 0000000000000006 R15: 0000000000000000
[   64.668504] FS:  00007f8d8cd19950(0000) GS:ffff880028022000(0000) knlGS:0000000000000000
[   64.668504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   64.668504] CR2: 00007f8d8c90b82e CR3: 0000000121980000 CR4: 00000000000406f0
[   64.668504] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   64.668504] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[   64.668504] I-pipe domain Xenomai
[   64.668504] Stack:
[   64.668504]  0000000000000000 ffffffff8174ce40 ffffc9000001ee98 ffffffff810792c3
[   64.668504] <0> fffffffdffffffff 0000000000000187 ffffffff8173b600 0000000000000008
[   64.668504] <0> 000000000000e550 ffffffff8106f1f3 0000000000000000 ffffffff8107ad2f
[   64.668504] Call Trace:
[   64.668504]  [<ffffffff810792c3>] ? xnintr_clock_handler+0x63/0x171
[   64.668504]  [<ffffffff8106f1f3>] ? __virq_end+0x37/0xe0
[   64.668504]  [<ffffffff8107ad2f>] ? xnpod_suspend_thread+0x16c/0x1a8
[   64.668504]  [<ffffffff8106fa2d>] ? __ipipe_restore_pipeline_head+0x64/0x6e
[   64.668504]  [<ffffffff81087435>] ? rt_task_set_periodic+0x8a/0x9a
[   64.668504]  [<ffffffff81089ba4>] ? __rt_task_set_periodic+0x89/0x97
[   64.668504]  [<ffffffff810880b3>] ? __xn_safe_copy_to_user+0x28/0x38
[   64.668504]  [<ffffffff8108351c>] ? hisyscall_event+0x13d/0x27d
[   64.668504]  [<ffffffff8106f384>] ? __ipipe_dispatch_event+0xe8/0x1e1
[   64.668504]  [<ffffffff81029358>] ? enqueue_task+0x28/0x33
[   64.668504]  [<ffffffff8101ed36>] ? __ipipe_syscall_root+0x5b/0xc2
[   64.668504]  [<ffffffff81422bb8>] ? __ipipe_syscall_root_thunk+0x35/0x6a
[   64.668504]  [<ffffffff8100af44>] ? system_call_after_swapgs+0x54/0x79
[   64.668504] Code: 00 19 ff 83 65 1c fe 83 e7 01 0f ae f8 f6 83 dd e6 78 81 10 48 8b 8b c8 e6 78 81 74 07 31 d2 83 c8 ff eb 05 83 c8 ff 89 c2 0f 30 <90> 65 48 8b 14 25 a0 cb 00 00 48 c7 c0 50 e5 00 00 48 8b 84 02 
[   64.668504] ---[ end trace 8f1e7db5aa2a3b0e ]---
[   66.372023] ata2.00: qc timeout (cmd 0xa1)
[   66.376110] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   66.382184] ata2.00: revalidation failed (errno=-5)
[   66.387061] ata2: hard resetting link
[   66.708023] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   71.712019] ata2.00: qc timeout (cmd 0xef)
[   71.716106] ata2.00: failed to enable ATAPI AN (err_mask=0x4)
[   71.721855] ata2.00: failed to set xfermode (err_mask=0x40)
[   71.727410] ata2: limiting SATA link speed to 1.5 Gbps
[   71.732533] ata2.00: limiting speed to UDMA/100:PIO3
[   71.737482] ata2: hard resetting link
[   72.060023] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   76.793247] ata2.00: configured for UDMA/100
[   81.796023] ata2.00: qc timeout (cmd 0xa0)
[   81.800110] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
[   81.805579] ata2.00: disabled
[   81.808531] ata2: hard resetting link
[   82.128022] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   82.134186] ata2: EH complete
[  106.808519] ata1.00: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x6 frozen
[  106.815552] ata1.00: cmd 61/10:08:64:88:d7/00:00:05:00:00/40 tag 1 ncq 8192 out
[  106.815553]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  106.830204] ata1.00: status: { DRDY }
[  106.833857] ata1: hard resetting link
[  107.157519] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  112.161015] ata1.00: qc timeout (cmd 0x27)
[  112.165102] ata1.00: failed to read native max address (err_mask=0x4)
[  112.171521] ata1.00: HPA support seems broken, skipping HPA handling
[  112.177854] ata1.00: revalidation failed (errno=-5)
[  112.182718] ata1: hard resetting link
[  112.505020] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  117.509015] ata1.00: qc timeout (cmd 0xec)
[  117.513102] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  117.519176] ata1.00: revalidation failed (errno=-5)
[  117.524041] ata1: limiting SATA link speed to 1.5 Gbps
[  117.529165] ata1: hard resetting link
[  117.849020] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  127.853014] ata1.00: qc timeout (cmd 0xec)
[  127.857102] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  127.863177] ata1.00: revalidation failed (errno=-5)
[  127.868041] ata1.00: disabled
[  127.871001] ata1.00: device reported invalid CHS sector 0
[  127.876387] ata1: hard resetting link
[  128.201021] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  128.207187] ata1: EH complete
[  128.210153] sd 0:0:0:0: [sda] Unhandled error code
[  128.214930] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  128.222491] end_request: I/O error, dev sda, sector 98011236
[  128.228142] Aborting journal on device sda3.
[  128.232409] EXT3-fs error (device sda3) in ext3_reserve_inode_write: Journal has aborted
[  128.240476] sd 0:0:0:0: [sda] Unhandled error code
[  128.244473] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  128.244473] end_request: I/O error, dev sda, sector 98008860
[  128.244473] Buffer I/O error on device sda3, logical block 1545
[  128.244473] lost page write due to I/O error on sda3
[  128.269332] sd 0:0:0:0: [sda] Unhandled error code
[  128.274108] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  128.281663] end_request: I/O error, dev sda, sector 97996500
[  128.287304] Buffer I/O error on device sda3, logical block 0
[  128.292945] lost page write due to I/O error on sda3
[  128.297898] EXT3-fs error (device sda3) in ext3_dirty_inode: Journal has aborted
[  128.305293] journal commit I/O error
[  128.305302] ------------[ cut here ]------------
[  128.305307] WARNING: at fs/buffer.c:1152 mark_buffer_dirty+0x23/0x71()
[  128.305309] Hardware name: OptiPlex 960                 
[  128.305310] Modules linked in: 8139too
[  128.305313] Pid: 4191, comm: metalog Tainted: G      D    2.6.31.1-xenomai-i2.4-06 #3
[  128.305315] Call Trace:
[  128.305319]  [<ffffffff8103465c>] ? warn_slowpath_common+0x76/0x8c
[  128.305321]  [<ffffffff810e2648>] ? mark_buffer_dirty+0x23/0x71
[  128.305324]  [<ffffffff81119580>] ? T.699+0x4d/0x59
[  128.305326]  [<ffffffff8111960b>] ? ext3_handle_error+0x7f/0xa6
[  128.305328]  [<ffffffff8111968c>] ? __ext3_std_error+0x5a/0x61
[  128.305331]  [<ffffffff811196c9>] ? __ext3_journal_stop+0x36/0x3d
[  128.305333]  [<ffffffff810ddd74>] ? __mark_inode_dirty+0x26/0xf6
[  128.305336]  [<ffffffff810d53b5>] ? file_update_time+0xa6/0xe6
[  128.305340]  [<ffffffff8109d8bf>] ? __generic_file_aio_write_nolock+0x164/0x285
[  128.305343]  [<ffffffff8109dc48>] ? generic_file_aio_write+0x60/0xb9
[  128.305346]  [<ffffffff81110263>] ? ext3_file_write+0x15/0x92
[  128.305349]  [<ffffffff810c5615>] ? do_sync_write+0xcf/0x10b
[  128.305352]  [<ffffffff81046077>] ? autoremove_wake_function+0x0/0x2a
[  128.305354]  [<ffffffff810c5b34>] ? vfs_write+0xa0/0xdd
[  128.305358]  [<ffffffff81422bb8>] ? __ipipe_syscall_root_thunk+0x35/0x6a
[  128.305360]  [<ffffffff810c5c24>] ? sys_write+0x45/0x6b
[  128.305363]  [<ffffffff8100af7f>] ? system_call_fastpath+0x16/0x1b
[  128.305365] ---[ end trace 8f1e7db5aa2a3b0f ]---
[  128.305374] sd 0:0:0:0: [sda] Unhandled error code
[  128.305376] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  128.305378] end_request: I/O error, dev sda, sector 97996500
[  128.305380] Buffer I/O error on device sda3, logical block 0
[  128.305381] lost page write due to I/O error on sda3
[  128.305386] ext3_abort called.
[  128.305387] EXT3-fs error (device sda3): ext3_journal_start_sb: Detected aborted journal
[  128.305389] Remounting filesystem read-only

--------------050200080008060807070706
Content-Type: text/plain;
 name="panic.rt_task_sleep"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="panic.rt_task_sleep"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.31.1-xenomai-i2.4-06 (root@domain.hid) (gcc version 4.4.1 (Gentoo 4.4.1 p1.0) ) #3 SMP Tue Oct 6 14:45:26 CEST 2009
[    0.000000] Command line: root=/dev/sda3 nmi_watchdog=2 console=ttyS0,115200
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cd9ffc00 (usable)
[    0.000000]  BIOS-e820: 00000000cd9ffc00 - 00000000cda53c00 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cda53c00 - 00000000cda55c00 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cda55c00 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000128000000 (usable)
[    0.000000] DMI 2.5 present.
[    0.000000] last_pfn = 0x128000 max_arch_pfn = 0x400000000
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] last_pfn = 0xcd9ff max_arch_pfn = 0x400000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000cd9ff000
[    0.000000] init_memory_mapping: 0000000100000000-0000000128000000
[    0.000000] ACPI: RSDP 00000000000fec00 00024 (v02 DELL  )
[    0.000000] ACPI: XSDT 00000000000fc7cb 00074 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: FACP 00000000000fc8fb 000F4 (v03 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: DSDT 00000000ffe9cff8 054AD (v01   DELL    dt_ex 00001000 INTL 20050624)
[    0.000000] ACPI: FACS 00000000cd9ffc00 00040
[    0.000000] ACPI: SSDT 00000000ffea25c4 000AA (v01   DELL    st_ex 00001000 INTL 20050624)
[    0.000000] ACPI: APIC 00000000000fc9ef 00092 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: BOOT 00000000000fca81 00028 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: ASF! 00000000000fcaa9 00096 (v32 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: MCFG 00000000000fcb3f 0003E (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: HPET 00000000000fcb7d 00038 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: TCPA 00000000000fcdd9 00032 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: DMAR 00000000000fce0b 00120 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] ACPI: SLIC 00000000000fcbb5 00176 (v01 DELL    B10K    00000015 ASL  00000061)
[    0.000000] (7 early reservations) ==> bootmem [0000000000 - 0128000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0001000000 - 000179bb94]    TEXT DATA BSS ==> [0001000000 - 000179bb94]
[    0.000000]   #3 [000009a000 - 0000100000]    BIOS reserved ==> [000009a000 - 0000100000]
[    0.000000]   #4 [000179c000 - 000179c1f0]              BRK ==> [000179c000 - 000179c1f0]
[    0.000000]   #5 [0000008000 - 000000c000]          PGTABLE ==> [0000008000 - 000000c000]
[    0.000000]   #6 [000000c000 - 000000d000]          PGTABLE ==> [000000c000 - 000000d000]
[    0.000000] found SMP MP-table at [ffff8800000fe710] fe710
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00128000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009a
[    0.000000]     0: 0x00000100 -> 0x000cd9ff
[    0.000000]     0: 0x00100000 -> 0x00128000
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x01] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x02] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x03] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] 8 Processors exceeds NR_CPUS limit of 4
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] Allocating PCI resources starting at d0000000 (gap: d0000000:10000000)
[    0.000000] NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 30 pages at ffff880028022000, static data 93856 bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 989291
[    0.000000] Kernel command line: root=/dev/sda3 nmi_watchdog=2 console=ttyS0,115200
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] xsave/xrstor: enabled xstate_bv 0x3, cntxt size 0x240
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.000000] Placing 64MB software IO TLB between ffff880020000000 - ffff880024000000
[    0.000000] software IO TLB at phys 0x20000000 - 0x24000000
[    0.000000] Memory: 3884988k/4849664k available (4260k kernel code, 825756k absent, 137936k reserved, 2034k data, 432k init)
[    0.000000] SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:384
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2660.296 MHz processor.
[    0.000042] I-pipe 2.4-06: pipeline enabled.
[    0.003092] Console: colour VGA+ 80x25
[    0.003109] console [ttyS0] enabled
[    0.004000] HPET: 8 timers in total, 4 timers will be used for per-cpu timer
[    0.004007] Calibrating delay loop (skipped), value calculated using timer frequency.. 5320.59 BogoMIPS (lpj=10641184)
[    0.012022] Mount-cache hash table entries: 256
[    0.016112] Initializing cgroup subsys ns
[    0.020003] Initializing cgroup subsys cpuacct
[    0.024006] Initializing cgroup subsys freezer
[    0.028010] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.033651] CPU: L2 cache: 3072K
[    0.036003] CPU: Physical Processor ID: 0
[    0.040002] CPU: Processor Core ID: 0
[    0.044003] mce: CPU supports 6 MCE banks
[    0.048006] CPU0: Thermal monitoring enabled (TM2)
[    0.052003] Performance Counters: Core2 events, Intel PMU driver.
[    0.060003] ... version:                 2
[    0.064002] ... bit width:               40
[    0.068002] ... generic counters:        2
[    0.072002] ... value mask:              000000ffffffffff
[    0.076002] ... max period:              000000007fffffff
[    0.080002] ... fixed-purpose counters:  3
[    0.084002] ... counter mask:            0000000700000003
[    0.088010] Freeing SMP alternatives: 35k freed
[    0.092021] ACPI: Core revision 20090521
[    0.337289] Setting APIC routing to flat
[    0.340306] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.344001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.344001] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.344001] ..... (found apic 0 pin 2) ...
[    0.386913] ....... works.
[    0.388002] CPU0: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz stepping 0a
[    0.400001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 5319.90 BogoMIPS (lpj=10639813)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 3072K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] mce: CPU supports 6 MCE banks
[    0.004000] CPU1: Thermal monitoring enabled (TM2)
[    0.004000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[    0.489182] CPU1: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz stepping 0a
[    0.497225] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.500071] Booting processor 2 APIC 0x2 ip 0x6000
[    0.004000] Initializing CPU#2
[    0.004000] Calibrating delay using timer specific routine.. 5319.92 BogoMIPS (lpj=10639859)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 3072K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 2
[    0.004000] mce: CPU supports 6 MCE banks
[    0.004000] CPU2: Thermal monitoring enabled (TM2)
[    0.004000] x86 PAT enabled: cpu 2, old 0x7040600070406, new 0x7010600070106
[    0.597223] CPU2: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz stepping 0a
[    0.605225] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    0.608058] Booting processor 3 APIC 0x3 ip 0x6000
[    0.004000] Initializing CPU#3
[    0.004000] Calibrating delay using timer specific routine.. 5319.94 BogoMIPS (lpj=10639895)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 3072K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 3
[    0.004000] mce: CPU supports 6 MCE banks
[    0.004000] CPU3: Thermal monitoring enabled (TM2)
[    0.004000] x86 PAT enabled: cpu 3, old 0x7040600070406, new 0x7010600070106
[    0.705252] CPU3: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz stepping 0a
[    0.713225] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
[    0.716017] Brought up 4 CPUs
[    0.720004] Total of 4 processors activated (21280.37 BogoMIPS).
[    0.724037] Testing NMI watchdog ... OK.
[    0.809639] NET: Registered protocol family 16
[    0.812035] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.816004] ACPI: bus type pci registered
[    0.820006] PCI: Using configuration type 1 for base access
[    0.832039] bio: create slab <bio-0> at 0
[    0.901847] ACPI: BIOS _OSI(Linux) query ignored
[    0.933799] ACPI: Interpreter enabled
[    0.936004] ACPI: (supports S0 S5)
[    0.940549] ACPI: Using IOAPIC for interrupt routing
[    1.052138] ACPI Warning: Incorrect checksum in table [TCPA] - 00, should be 7F 20090521 tbutils-246
[    1.065819] ACPI: ACPI Dock Station Driver: 1 docks/bays found
[    1.079930] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    1.080208] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.084007] pci 0000:00:03.0: PME# disabled
[    1.088363] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    1.092006] pci 0000:00:19.0: PME# disabled
[    1.096269] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    1.100006] pci 0000:00:1a.7: PME# disabled
[    1.104071] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.108005] pci 0000:00:1b.0: PME# disabled
[    1.112049] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.116006] pci 0000:00:1c.0: PME# disabled
[    1.120051] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.124006] pci 0000:00:1c.1: PME# disabled
[    1.128300] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    1.132006] pci 0000:00:1d.7: PME# disabled
[    1.136203] pci 0000:00:1f.2: PME# supported from D3hot
[    1.140006] pci 0000:00:1f.2: PME# disabled
[    1.144203] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot
[    1.148006] pci 0000:03:00.0: PME# disabled
[    1.152078] pci 0000:03:02.0: PME# supported from D1 D2 D3hot D3cold
[    1.156006] pci 0000:03:02.0: PME# disabled
[    1.160042] pci 0000:00:1e.0: transparent bridge
[    2.609858] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
[    2.618932] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 15)
[    2.626676] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
[    2.634569] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
[    2.642383] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
[    2.651364] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 9 10 11 12 15)
[    2.659032] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
[    2.666935] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 15)
[    2.674195] SCSI subsystem initialized
[    2.676039] usbcore: registered new interface driver usbfs
[    2.680026] usbcore: registered new interface driver hub
[    2.684039] usbcore: registered new device driver usb
[    2.688038] PCI: Using ACPI for IRQ routing
[    2.736008] pnp: PnP ACPI init
[    2.739045] ACPI: bus type pnp registered
[    2.795170] pnp: PnP ACPI: found 9 devices
[    2.799255] ACPI: ACPI bus type pnp unregistered
[    2.803867] system 00:01: ioport range 0x800-0x85f has been reserved
[    2.810201] system 00:01: ioport range 0xc00-0xc7f has been reserved
[    2.816534] system 00:01: ioport range 0x860-0x8ff has been reserved
[    2.828014] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:01
[    2.833915] pci 0000:00:1c.0:   IO window: disabled
[    2.838777] pci 0000:00:1c.0:   MEM window: 0xfe500000-0xfe5fffff
[    2.844852] pci 0000:00:1c.0:   PREFETCH window: disabled
[    2.850234] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:02
[    2.856135] pci 0000:00:1c.1:   IO window: disabled
[    2.860997] pci 0000:00:1c.1:   MEM window: 0xfe400000-0xfe4fffff
[    2.867076] pci 0000:00:1c.1:   PREFETCH window: disabled
[    2.872457] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:03
[    2.878358] pci 0000:00:1e.0:   IO window: 0xd000-0xdfff
[    2.883654] pci 0000:00:1e.0:   MEM window: 0xfe300000-0xfe3fffff
[    2.889729] pci 0000:00:1e.0:   PREFETCH window: disabled
[    2.895118] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.901805] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    2.908521] NET: Registered protocol family 2
[    2.912883] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    2.920355] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    2.929073] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    2.936162] TCP: Hash tables configured (established 262144 bind 65536)
[    2.942755] TCP reno registered
[    2.945968] NET: Registered protocol family 1
[    2.950495] Simple Boot Flag at 0x7a set to 0x1
[    2.956874] audit: initializing netlink socket (disabled)
[    2.962262] type=2000 audit(1254841457.960:1): initialized
[    2.970427] I-pipe: Domain Xenomai registered.
[    2.974954] Xenomai: hal/x86_64 started.
[    2.978881] Xenomai: scheduling class idle registered.
[    2.984002] Xenomai: scheduling class rt registered.
[    2.991684] Xenomai: real-time nucleus v2.5-rc3 (Flying In A Blue Dream) loaded.
[    2.999215] Xenomai: NMI watchdog started (threshold=100 us).
[    3.004977] Xenomai: starting native API services.
[    3.009756] Xenomai: starting POSIX services.
[    3.014500] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.026510] Installing knfsd (copyright (C) 1996 okir@domain.hid).
[    3.033532] fuse init (API version 7.12)
[    3.037706] msgmni has been set to 7589
[    3.042333] alg: No test for stdrng (krng)
[    3.046587] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    3.053964] io scheduler noop registered
[    3.057875] io scheduler anticipatory registered
[    3.062477] io scheduler deadline registered
[    3.066743] io scheduler cfq registered (default)
[    3.072202] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    3.082087] Non-volatile memory driver v1.3
[    3.086256] Linux agpgart interface v0.103
[    3.090347] agpgart-intel 0000:00:00.0: Intel Q45/Q43 Chipset
[    3.096914] agpgart-intel 0000:00:00.0: detected 32764K stolen memory
[    3.105504] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    3.112410] [drm] Initialized drm 1.1.0 20060810
[    3.117038] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    3.786611] [drm] TMDS-8: set mode 1920x1080 13
[    4.016795] Console: switching to colour frame buffer device 240x67
[    4.031836] [drm] fb0: inteldrmfb frame buffer device
[    4.036884] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    4.044072] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.304141] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    4.310660] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    4.316364] serial 0000:00:03.3: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    4.323400] 0000:00:03.3: ttyS1 at I/O 0xec98 (irq = 17) is a 16550A
[    4.332153] brd: module loaded
[    4.336329] loop: module loaded
[    4.339825] ahci 0000:00:1f.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    4.346683] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x2f impl RAID mode
[    4.354835] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio ems 
[    4.392065] scsi0 : ahci
[    4.394830] scsi1 : ahci
[    4.397533] scsi2 : ahci
[    4.400232] scsi3 : ahci
[    4.402932] scsi4 : ahci
[    4.405632] scsi5 : ahci
[    4.409768] ata1: SATA max UDMA/133 abar m2048@domain.hid port 0xff970100 irq 31
[    4.417145] ata2: SATA max UDMA/133 abar m2048@domain.hid port 0xff970180 irq 31
[    4.424516] ata3: SATA max UDMA/133 abar m2048@domain.hid port 0xff970200 irq 31
[    4.431887] ata4: SATA max UDMA/133 abar m2048@domain.hid port 0xff970280 irq 31
[    4.439258] ata5: DUMMY
[    4.441696] ata6: SATA max UDMA/133 abar m2048@domain.hid port 0xff970380 irq 31
[    4.449431] Intel(R) PRO/1000 Network Driver - version 7.3.21-k3-NAPI
[    4.455850] Copyright (c) 1999-2006 Intel Corporation.
[    4.461035] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
[    4.466935] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    4.472766] e1000e 0000:00:19.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[    4.479707] e1000e 0000:00:19.0: pci_enable_pcie_error_reporting failed 0xfffffffb
[    4.596585] 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:24:e8:39:3c:95
[    4.603955] 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    4.610320] 0000:00:19.0: eth0: MAC: 8, PHY: 8, PBA No: 2021ff-0ff
[    4.616544] Intel(R) Gigabit Ethernet Network Driver - version 1.3.16-k2
[    4.623224] Copyright (c) 2007-2009 Intel Corporation.
[    4.628405] Intel(R) Virtual Function Network Driver - version 1.0.0-k0
[    4.634998] Copyright (c) 2009 Intel Corporation.
[    4.639754] <6>8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    4.646173] 8139cp 0000:03:02.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    4.655763] tun: Universal TUN/TAP device driver, 1.6
[    4.660798] tun: (C) 1999-2004 Max Krasnyansky <maxk@domain.hid>
[    4.667154] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.673676] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[    4.680797] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    4.686099] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    4.697375] ehci_hcd 0000:00:1a.7: debug port 1
[    4.701909] ehci_hcd 0000:00:1a.7: irq 22, io mem 0xfe6da000
[    4.720010] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    4.725775] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    4.732540] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.739739] usb usb1: Product: EHCI Host Controller
[    4.744600] usb usb1: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 ehci_hcd
[    4.751539] usb usb1: SerialNumber: 0000:00:1a.7
[    4.756227] usb usb1: configuration #1 chosen from 1 choice
[    4.761858] hub 1-0:1.0: USB hub found
[    4.765599] hub 1-0:1.0: 6 ports detected
[    4.768033] ata3: SATA link down (SStatus 4 SControl 300)
[    4.768057] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.768077] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.768092] ata4: SATA link down (SStatus 4 SControl 300)
[    4.768110] ata6: SATA link down (SStatus 0 SControl 300)
[    4.794949] ata2.00: ATAPI: PLDS DVD+/-RW DH-16AAS, JD12, max UDMA/100, ATAPI AN
[    4.794972] ata1.00: ATA-8: ST3500418AS, CC44, max UDMA/133
[    4.794974] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    4.807483] ata2.00: configured for UDMA/100
[    4.821927] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    4.829048] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    4.834331] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    4.834360] ata1.00: configured for UDMA/133
[    4.834443] scsi 0:0:0:0: Direct-Access     ATA      ST3500418AS      CC44 PQ: 0 ANSI: 5
[    4.834660] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.834735] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    4.834769] sd 0:0:0:0: [sda] Write Protect is off
[    4.834787] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.837133] scsi 1:0:0:0: CD-ROM            PLDS     DVD+-RW DH-16AAS JD12 PQ: 0 ANSI: 5
[    4.892523] ehci_hcd 0000:00:1d.7: debug port 1
[    4.897055] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    4.897076] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xff980000
[    4.901048]  sda: sda1 sda2 sda3 sda4 <
[    4.908017] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    4.908037] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    4.908039] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.908040] usb usb2: Product: EHCI Host Controller
[    4.908041] usb usb2: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 ehci_hcd
[    4.908043] usb usb2: SerialNumber: 0000:00:1d.7
[    4.908107] usb usb2: configuration #1 chosen from 1 choice
[    4.908152] hub 2-0:1.0: USB hub found
[    4.908156] hub 2-0:1.0: 6 ports detected
[    4.908236] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.908269] uhci_hcd: USB Universal Host Controller Interface driver
[    4.908330] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    4.908338] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    4.908384] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    4.908390] uhci_hcd 0000:00:1a.0: detected 2 ports
[    4.908422] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ff20
[    4.908456] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    4.908458] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.908460] usb usb3: Product: UHCI Host Controller
[    4.908461] usb usb3: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhci_hcd
[    4.908462] usb usb3: SerialNumber: 0000:00:1a.0
[    4.908516] usb usb3: configuration #1 chosen from 1 choice
[    4.908561] hub 3-0:1.0: USB hub found
[    4.908566] hub 3-0:1.0: 2 ports detected
[    4.908613] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    4.908619] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    4.908669] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    4.908675] uhci_hcd 0000:00:1a.1: detected 2 ports
[    4.908709] uhci_hcd 0000:00:1a.1: irq 17, io base 0x0000ff00
[    4.908742] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    4.908744] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.908745] usb usb4: Product: UHCI Host Controller
[    4.908746] usb usb4: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhci_hcd
[    4.908748] usb usb4: SerialNumber: 0000:00:1a.1
[    4.908802] usb usb4: configuration #1 chosen from 1 choice
[    4.908847] hub 4-0:1.0: USB hub found
[    4.908852] hub 4-0:1.0: 2 ports detected
[    4.908898] uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[    4.908905] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    4.908949] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    4.908956] uhci_hcd 0000:00:1a.2: detected 2 ports
[    4.908980] uhci_hcd 0000:00:1a.2: irq 22, io base 0x0000fc00
[    4.909012] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    4.909013] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.909015] usb usb5: Product: UHCI Host Controller
[    4.909016] usb usb5: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhci_hcd
[    4.909018] usb usb5: SerialNumber: 0000:00:1a.2
[    4.909072] usb usb5: configuration #1 chosen from 1 choice
[    4.909116] hub 5-0:1.0: USB hub found
[    4.909121] hub 5-0:1.0: 2 ports detected
[    4.909166] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    4.909174] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    4.909217] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    4.909223] uhci_hcd 0000:00:1d.0: detected 2 ports
[    4.909247] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000ff80
[    4.909279] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    4.909280] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.909282] usb usb6: Product: UHCI Host Controller
[    4.909283] usb usb6: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhci_hcd
[    4.909285] usb usb6: SerialNumber: 0000:00:1d.0
[    4.909339] usb usb6: configuration #1 chosen from 1 choice
[    4.909384] hub 6-0:1.0: USB hub found
[    4.909389] hub 6-0:1.0: 2 ports detected
[    4.909437] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    4.909444] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    4.909486] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    4.909493] uhci_hcd 0000:00:1d.1: detected 2 ports
[    4.909517] uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000ff60
[    4.909552] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    4.909554] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.909555] usb usb7: Product: UHCI Host Controller
[    4.909557] usb usb7: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhci_hcd
[    4.909558] usb usb7: SerialNumber: 0000:00:1d.1
[    4.909614] usb usb7: configuration #1 chosen from 1 choice
[    4.909658] hub 7-0:1.0: USB hub found
[    4.909662] hub 7-0:1.0: 2 ports detected
[    4.909710] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    4.909717] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    4.909761] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    4.909767] uhci_hcd 0000:00:1d.2: detected 2 ports
[    4.909802] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
[    4.909844] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    4.909845] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.909847] usb usb8: Product: UHCI Host Controller
[    4.909848] usb usb8: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhci_hcd
[    4.909849] usb usb8: SerialNumber: 0000:00:1d.2
[    4.909905] usb usb8: configuration #1 chosen from 1 choice
[    4.909952] hub 8-0:1.0: USB hub found
[    4.909957] hub 8-0:1.0: 2 ports detected
[    4.910058] usbcore: registered new interface driver usblp
[    4.910060] Initializing USB Mass Storage driver...
[    4.910105] usbcore: registered new interface driver usb-storage
[    4.910107] USB Mass Storage support registered.
[    4.910153] usbcore: registered new interface driver libusual
[    4.910262] PNP: No PS/2 controller found. Probing ports directly.
[    4.912836] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.912841] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.912894] mice: PS/2 mouse device common for all mice
[    4.912994] rtc_cmos 00:05: RTC can wake from S4
[    4.913041] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    4.913072] rtc0: alarms up to one day, 242 bytes nvram, hpet irqs
[    4.913109] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    4.913185] cpuidle: using governor ladder
[    4.913186] cpuidle: using governor menu
[    4.913933] usbcore: registered new interface driver hiddev
[    4.913965] usbcore: registered new interface driver usbhid
[    4.913966] usbhid: v2.6:USB HID core driver
[    4.913985] Netfilter messages via NETLINK v0.30.
[    4.913997] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    4.914140] ctnetlink v0.93: registering with nfnetlink.
[    4.914224] ip_tables: (C) 2000-2006 Netfilter Core Team
[    4.914243] TCP cubic registered
[    4.914244] Initializing XFRM netlink socket
[    4.914409] NET: Registered protocol family 10
[    4.914578] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    4.914594] IPv6 over IPv4 tunneling driver
[    4.914696] NET: Registered protocol family 17
[    4.914811] RPC: Registered udp transport module.
[    4.914813] RPC: Registered tcp transport module.
[    5.570876]  sda5
[    5.570912] Uniform CD-ROM driver Revision: 3.20
[    5.577735] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    5.605284]  sda6 >
[    5.608088] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.656996] EXT3-fs: INFO: recovery required on readonly filesystem.
[    5.663331] EXT3-fs: write access will be enabled during recovery.
[    5.779108] kjournald starting.  Commit interval 5 seconds
[    5.779122] EXT3-fs: recovery complete.
[    5.788609] EXT3-fs: mounted filesystem with writeback data mode.
[    5.794734] VFS: Mounted root (ext3 filesystem) readonly on device 8:3.
[    5.801345] Freeing unused kernel memory: 432k freed
[    6.097512] usb 5-1: new full speed USB device using uhci_hcd and address 2
[    6.297869] usb 5-1: New USB device found, idVendor=413c, idProduct=2101
[    6.304566] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.311678] usb 5-1: Product: Dell Smart Card Reader Keyboard
[    6.317403] usb 5-1: Manufacturer: Dell
[    6.321353] usb 5-1: configuration #1 chosen from 1 choice
[    6.333114] input: Dell Dell Smart Card Reader Keyboard as /devices/pci0000:00/0000:00:1a.2/usb5/5-1/5-1:1.0/input/input0
[    6.344140] generic-usb 0003:413C:2101.0001: input,hidraw0: USB HID v1.11 Keyboard [Dell Dell Smart Card Reader Keyboard] on usb-0000:00:1a.2-1/input0
[    6.596514] usb 5-2: new low speed USB device using uhci_hcd and address 3
[    6.772819] usb 5-2: New USB device found, idVendor=0461, idProduct=4d51
[    6.779516] usb 5-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    6.786631] usb 5-2: Product: DELL Laser Mouse
[    6.791184] usb 5-2: configuration #1 chosen from 1 choice
[    6.813060] input: DELL Laser Mouse as /devices/pci0000:00/0000:00:1a.2/usb5/5-2/5-2:1.0/input/input1
[    6.822433] generic-usb 0003:0461:4D51.0002: input,hidraw1: USB HID v1.11 Mouse [DELL Laser Mouse] on usb-0000:00:1a.2-2/input0
[   55.052934] NMI watchdog detected timer latency above 100 us
[   55.052934]  on CPU0, ip ffffffff8106f212, registers:
[   55.052934] CPU 0 
[   55.052934] Modules linked in: 8139too
[   55.052934] Pid: 357, comm: gatekeeper/0 Not tainted 2.6.31.1-xenomai-i2.4-06 #3 OptiPlex 960                 
[   55.052934] RIP: 0010:[<ffffffff8106f212>]  [<ffffffff8106f212>] __virq_end+0x56/0xe0
[   55.052934] RSP: 0018:ffff880126dcfc90  EFLAGS: 00000086
[   55.052934] RAX: ffff880028033718 RBX: 0000000000000187 RCX: ffffffff81744d00
[   55.052934] RDX: ffff880028030550 RSI: ffffffd1bb1b7b38 RDI: 0000000000000001
[   55.052934] RBP: ffffffff8173b600 R08: 0000000000006340 R09: 0000000000000639
[   55.052934] R10: ffffffff8106f1b6 R11: 0000000000000006 R12: 0000000000000008
[   55.052934] R13: 000000000000e550 R14: 0000000000000006 R15: 0000000000000000
[   55.052934] FS:  0000000000000000(0000) GS:ffff880028022000(0000) knlGS:0000000000000000
[   55.052934] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[   55.052934] CR2: 00007f608117b188 CR3: 0000000121973000 CR4: 00000000000406f0
[   55.052934] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   55.052934] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[   55.052934] I-pipe domain Xenomai
[   55.052934] Stack:
[   55.052934]  0000000000000286 ffffffff81009cb6 0000000000000000 ffffffffffffffff
[   55.052934] <0> ffffffff8173b608 0000000000000030 0000018081079a13 000000000000e550
[   55.052934] <0> 00000000000127b0 000000000000cda0 0000000000000001 ffffffff8173b600
[   55.052934] Call Trace:
[   55.505012]  [<ffffffff81009cb6>] ? __switch_to+0x16e/0x1f2
[   55.505012]  [<ffffffff8106f50f>] ? ipipe_suspend_domain+0x92/0xcb
[   55.513011]  [<ffffffff8106f5dc>] ? __ipipe_walk_pipeline+0x94/0xee
[   55.513011]  [<ffffffff8101ea11>] ? __ipipe_handle_irq+0xbb/0x257
[   55.529010]  [<ffffffff8101ee36>] ? ipipe_trigger_irq+0x4e/0x65
[   55.529010]  [<ffffffff8108224f>] ? rpi_pop+0xc9/0x103
[   55.529010]  [<ffffffff81082618>] ? gatekeeper_thread+0x16e/0x182
[   55.529010]  [<ffffffff810309e6>] ? default_wake_function+0x0/0xe
[   55.529010]  [<ffffffff810824aa>] ? gatekeeper_thread+0x0/0x182
[   55.529010]  [<ffffffff810824aa>] ? gatekeeper_thread+0x0/0x182
[   55.561010]  [<ffffffff81045d41>] ? kthread+0x88/0x90
[   55.561010]  [<ffffffff8100c51a>] ? child_rip+0xa/0x20
[   55.561010]  [<ffffffff81045cb9>] ? kthread+0x0/0x90
[   55.561010]  [<ffffffff8100c510>] ? child_rip+0x0/0x20
[   55.561010] Code: c1 e0 06 48 8b 74 28 18 ff 54 05 10 48 63 45 00 48 69 c0 98 10 00 00 65 48 8b 14 25 a0 cb 00 00 4c 01 ea 48 8d 04 02 0f ba 28 01 <fa> 65 48 8b 04 25 a0 cb 00 00 48 8b 54 24 38 48 8b 7c 24 40 48 
[   55.561010] ---[ end trace 8bf32139b6d11c7d ]---
[   55.561010] Kernel panic - not syncing: Non maskable interrupt
[   55.561010] Pid: 357, comm: gatekeeper/0 Tainted: G      D    2.6.31.1-xenomai-i2.4-06 #3
[   55.561010] Call Trace:
[   55.625012]  <NMI>  [<ffffffff81420dbe>] ? panic+0x78/0x11c
[   55.625012]  [<ffffffff8106fac5>] ? __ipipe_unstall_root+0x2f/0x30
[   55.625012]  [<ffffffff81423e69>] ? die_nmi+0xa3/0x10f
[   55.625012]  [<ffffffff8134b2ad>] ? rthal_latency_above_max+0x38/0x42
[   55.625012]  [<ffffffff8142418b>] ? p6_rearm+0x10/0x34
[   55.625012]  [<ffffffff8142526b>] ? notifier_call_chain+0x2e/0x5b
[   55.625012]  [<ffffffff8134b5fc>] ? rthal_nmi_watchdog_tick+0x64/0x112
[   55.625012]  [<ffffffff814239d4>] ? do_nmi+0xd6/0x2b4
[   55.625012]  [<ffffffff8142348a>] ? nmi+0x1a/0x20
[   55.625012]  [<ffffffff8106f1b6>] ? __xirq_end+0x7e/0x84
[   55.625012]  [<ffffffff8106f212>] ? __virq_end+0x56/0xe0
[   55.625012]  <<EOE>>  [<ffffffff81009cb6>] ? __switch_to+0x16e/0x1f2
[   55.625012]  [<ffffffff8106f50f>] ? ipipe_suspend_domain+0x92/0xcb
[   55.625012]  [<ffffffff8106f5dc>] ? __ipipe_walk_pipeline+0x94/0xee
[   55.625012]  [<ffffffff8101ea11>] ? __ipipe_handle_irq+0xbb/0x257
[   55.625012]  [<ffffffff8101ee36>] ? ipipe_trigger_irq+0x4e/0x65
[   55.625012]  [<ffffffff8108224f>] ? rpi_pop+0xc9/0x103
[   55.625012]  [<ffffffff81082618>] ? gatekeeper_thread+0x16e/0x182
[   55.625012]  [<ffffffff810309e6>] ? default_wake_function+0x0/0xe
[   55.625012]  [<ffffffff810824aa>] ? gatekeeper_thread+0x0/0x182
[   55.625012]  [<ffffffff810824aa>] ? gatekeeper_thread+0x0/0x182
[   55.625012]  [<ffffffff81045d41>] ? kthread+0x88/0x90
[   55.625012]  [<ffffffff8100c51a>] ? child_rip+0xa/0x20
[   55.753012]  [<ffffffff81045cb9>] ? kthread+0x0/0x90
[   55.753012]  [<ffffffff8100c510>] ? child_rip+0x0/0x20
[   55.753012] [drm:intelfb_panic] *ERROR* panic occurred, switching back to text console

--------------050200080008060807070706--

