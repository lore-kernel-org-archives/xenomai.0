MIME-Version: 1.0
From: Pierre C <cpierre0031@gmail.com>
Date: Wed, 2 Nov 2016 14:08:06 +0100
Message-ID: <CALJb2vCvm7ogxOgqrJh9Au5W3LwPVWONCFcq8sYoxtaU+O0cvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] [RTnet]: Kernel panic during the HW monitoring
 initialisation of an I350-T4 card.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everybody,

I have a "rt_igb" driver initialization problem on the Intel Ethernet
Server Adapter I350-T4 card.
During the HW monitoring initialization of this card (ex: pci@0000:05:00.0),
i have a kernel panic.
PS: if the card monitoring ("CONFIG_IGB_HWMON") is unselected on the "igb"
linux driver, the problem disappears (normal because the "igb_sysfs_init"
function is not called).
It's a "rt_igb" driver bug or a normal behavior because the card monitoring
should not be activated  (for performance issues)?

Xenomai: V3.0.2
Kernel: 3.14.44

Thanks alot, in advance, for your answer.

dmesg display:
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.14.44xenomai-debug (root@DEBIAN) (gcc
version 4.9.2 (Debian 4.9.2-10) ) #3 SMP PREEMPT Tue Oct 4 03:34:04 EDT 2016
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.14.44xenomai-debug
root=UUID=9861d077-d577-47c1-bc90-42b9acba1bb6 ro quiet
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000078e30fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000078e31000-0x000000007973dfff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000007973e000-0x0000000079c13fff] ACPI
NVS
[    0.000000] BIOS-e820: [mem 0x0000000079c14000-0x000000008fffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed44fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000047fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.0 present.
[    0.000000] DMI: Supermicro Super Server/X10SRL-F, BIOS 2.0 12/17/2015
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x480000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000080000000 mask 3FFF80000000 uncachable
[    0.000000]   1 base 380000000000 mask 3FC000000000 uncachable
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new
0x7010600070106
[    0.000000] e820: last_pfn = 0x78e31 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fda60-0x000fda6f] mapped at
[ffff8800000fda60]
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x02c70000, 0x02c70fff] PGTABLE
[    0.000000] BRK [0x02c71000, 0x02c71fff] PGTABLE
[    0.000000] BRK [0x02c72000, 0x02c72fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x47fe00000-0x47fffffff]
[    0.000000]  [mem 0x47fe00000-0x47fffffff] page 1G
[    0.000000] init_memory_mapping: [mem 0x47c000000-0x47fdfffff]
[    0.000000]  [mem 0x47c000000-0x47fdfffff] page 1G
[    0.000000] init_memory_mapping: [mem 0x400000000-0x47bffffff]
[    0.000000]  [mem 0x400000000-0x47bffffff] page 1G
[    0.000000] init_memory_mapping: [mem 0x00100000-0x78e30fff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x78dfffff] page 2M
[    0.000000]  [mem 0x78e00000-0x78e30fff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x3ffffffff]
[    0.000000]  [mem 0x100000000-0x3ffffffff] page 1G
[    0.000000] RAMDISK: [mem 0x357f2000-0x36bf0fff]
[    0.000000] ACPI: RSDP 0x00000000000F0580 000024 (v02 SUPERM)
[    0.000000] ACPI: XSDT 0x0000000079788098 0000B4 (v01
01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000797B8D50 00010C (v05 SUPERM SMCI--MB
01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000797881E8 030B62 (v02 SUPERM SMCI--MB
01072009 INTL 20091013)
[    0.000000] ACPI: FACS 0x0000000079C12F80 000040
[    0.000000] ACPI: APIC 0x00000000797B8E60 0000E4 (v03 SUPERM SMCI--MB
01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000797B8F48 000044 (v01 SUPERM SMCI--MB
01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x00000000797B8F90 00009C (v01 SUPERM SMCI--MB
01072009 AMI  00010013)
[    0.000000] ACPI: SPMI 0x00000000797B9030 000040 (v05 SUPERM SMCI--MB
00000000 AMI. 00000000)
[    0.000000] ACPI: MCFG 0x00000000797B9070 00003C (v01 SUPERM SMCI--MB
01072009 MSFT 00000097)
[    0.000000] ACPI: UEFI 0x00000000797B90B0 000042 (v01 SUPERM SMCI--MB
01072009      00000000)
[    0.000000] ACPI: HPET 0x00000000797B90F8 000038 (v01 SUPERM SMCI--MB
00000001 INTL 20091013)
[    0.000000] ACPI: WDDT 0x00000000797B9130 000040 (v01 SUPERM SMCI--MB
00000000 INTL 20091013)
[    0.000000] ACPI: SSDT 0x00000000797B9170 017141 (v02 SUPERM PmMgt
00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000797D02B8 00264C (v02 SUPERM SpsNm
00000002 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000797D2908 000064 (v02 SUPERM SpsNvs
00000002 INTL 20120913)
[    0.000000] ACPI: PRAD 0x00000000797D2970 000102 (v02 SUPERM SMCI--MB
00000002 INTL 20120913)
[    0.000000] ACPI: DMAR 0x00000000797D2A78 0000C4 (v01 SUPERM SMCI--MB
00000001 INTL 20091013)
[    0.000000] ACPI: HEST 0x00000000797D2B40 00027C (v01 SUPERM SMCI--MB
00000001 INTL 00000001)
[    0.000000] ACPI: BERT 0x00000000797D2DC0 000030 (v01 SUPERM SMCI--MB
00000001 INTL 00000001)
[    0.000000] ACPI: ERST 0x00000000797D2DF0 000230 (v01 SUPERM SMCI--MB
00000001 INTL 00000001)
[    0.000000] ACPI: EINJ 0x00000000797D3020 000130 (v01 SUPERM SMCI--MB
00000001 INTL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000047fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x47fffffff]
[    0.000000]   NODE_DATA [mem 0x47fffa000-0x47fffdfff]
[    0.000000]  [ffffea0000000000-ffffea000fbfffff] PMD ->
[ffff88046f600000-ffff88047d5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x47fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0x78e30fff]
[    0.000000]   node   0: [mem 0x100000000-0x47fffffff]
[    0.000000] On node 0 totalpages: 4165070
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 6714 pages used for memmap
[    0.000000]   DMA32 zone: 491057 pages, LIFO batch:31
[    0.000000]   Normal zone: 50176 pages used for memmap
[    0.000000]   Normal zone: 3670016 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x08] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x10] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x12] lapic_id[0x12] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x14] lapic_id[0x14] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x16] lapic_id[0x16] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x18] lapic_id[0x18] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x18] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI
0-23
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec01000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 2, version 32, address 0xfec01000, GSI
24-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 10 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 64
[    0.000000] e820: [mem 0x90000000-0xfed1bfff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:10
nr_node_ids:1
[    0.000000] PERCPU: Embedded 161 pages/cpu @ffff88047ec00000 s630656
r8192 d20608 u1048576
[    0.000000] pcpu-alloc: s630656 r8192 d20608 u1048576 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 [0] 02 03 [0] 04 05 [0] 06 07
[    0.000000] pcpu-alloc: [0] 08 09
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 4108103
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-3.14.44xenomai-debug
root=UUID=9861d077-d577-47c1-bc90-42b9acba1bb6 ro quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 16308432K/16660280K available (8450K kernel code,
3809K rwdata, 1916K rodata, 2088K init, 10904K bss, 351848K reserved)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]     RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000]     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=10.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=10
[    0.000000] NR_IRQS:33024 nr_irqs:1168 16
[    0.000000] Interrupt pipeline (release #12)
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 67108864 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want
memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2299.914 MHz processor
[    0.000032] Calibrating delay loop (skipped), value calculated using
timer frequency.. 4599.82 BogoMIPS (lpj=9199656)
[    0.000036] pid_max: default: 32768 minimum: 301
[    0.000049] ACPI: Core revision 20131218
[    0.052064] ACPI: All ACPI Tables successfully acquired
[    0.057095] Security Framework initialized
[    0.057105] AppArmor: AppArmor disabled by boot time parameter
[    0.057106] Yama: becoming mindful.
[    0.058339] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes)
[    0.061790] Inode-cache hash table entries: 1048576 (order: 11, 8388608
bytes)
[    0.063219] Mount-cache hash table entries: 32768 (order: 6, 262144
bytes)
[    0.063241] Mountpoint-cache hash table entries: 32768 (order: 6, 262144
bytes)
[    0.063499] Initializing cgroup subsys memory
[    0.063504] Initializing cgroup subsys devices
[    0.063507] Initializing cgroup subsys freezer
[    0.063509] Initializing cgroup subsys net_cls
[    0.063511] Initializing cgroup subsys blkio
[    0.063512] Initializing cgroup subsys perf_event
[    0.063515] Initializing cgroup subsys net_prio
[    0.063542] CPU: Physical Processor ID: 0
[    0.063544] CPU: Processor Core ID: 0
[    0.064315] mce: CPU supports 22 MCE banks
[    0.064352] CPU0: Thermal monitoring enabled (TM1)
[    0.064385] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
tlb_flushall_shift: 6
[    0.064497] Freeing SMP alternatives memory: 20K (ffffffff821c4000 -
ffffffff821c9000)
[    0.064500] ftrace: allocating 21503 entries in 84 pages
[    0.073691] dmar: Host address width 46
[    0.073694] dmar: DRHD base: 0x000000fbffc000 flags: 0x1
[    0.073704] dmar: IOMMU 0: reg_base_addr fbffc000 ver 1:0 cap
d2078c106f0466 ecap f020de
[    0.073706] dmar: RMRR base: 0x0000007ba77000 end: 0x0000007ba86fff
[    0.073708] dmar: ATSR flags: 0x0
[    0.073710] dmar: RHSA base: 0x000000fbffc000 proximity domain: 0x0
[    0.073802] IOAPIC id 1 under DRHD base  0xfbffc000 IOMMU 0
[    0.073803] IOAPIC id 2 under DRHD base  0xfbffc000 IOMMU 0
[    0.073805] HPET id 0 under DRHD base 0xfbffc000
[    0.073806] Queued invalidation will be enabled to support x2apic and
Intr-remapping.
[    0.073808] Your BIOS is broken and requested that x2apic be disabled.
This will slightly decrease performance.
Use 'intremap=no_x2apic_optout' to override BIOS request.
[    0.073908] Enabled IRQ remapping in xapic mode
[    0.073909] x2apic not enabled, IRQ remapping is in xapic mode
[    0.073913] Switched APIC routing to physical flat.
[    0.074442] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.114110] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz
(fam: 06, model: 3f, stepping: 02)
[    0.114119] TSC deadline timer enabled
[    0.114129] Performance Events: PEBS fmt2+, 16-deep LBR, Haswell events,
full-width counters, Intel PMU driver.
[    0.114153] ... version:                3
[    0.114154] ... bit width:              48
[    0.114156] ... generic registers:      8
[    0.114157] ... value mask:             0000ffffffffffff
[    0.114158] ... max period:             0000ffffffffffff
[    0.114160] ... fixed-purpose events:   3
[    0.114161] ... event mask:             00000007000000ff
[    0.146328] x86: Booting SMP configuration:
[    0.146333] .... node  #0, CPUs:        #1
[    0.160498] NMI watchdog: enabled on all CPUs, permanently consumes one
hw-PMU counter.
[    0.166288]   #2  #3  #4  #5  #6  #7  #8  #9
[    0.320491] x86: Booted up 1 node, 10 CPUs
[    0.320497] smpboot: Total of 10 processors activated (45998.28 BogoMIPS)
[    0.340385] devtmpfs: initialized
[    0.346980] gcov: version magic: 0x3430392a
[    0.347149] PM: Registering ACPI NVS region [mem 0x7973e000-0x79c13fff]
(5070848 bytes)
[    0.348541] pinctrl core: initialized pinctrl subsystem
[    0.348690] NET: Registered protocol family 16
[    0.348818] cpuidle: using governor ladder
[    0.348820] cpuidle: using governor menu
[    0.348855] ACPI FADT declares the system doesn't support PCIe ASPM, so
disable it
[    0.348857] ACPI: bus type PCI registered
[    0.348860] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.348923] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0x80000000-0x8fffffff] (base 0x80000000)
[    0.348926] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    0.349139] PCI: Using configuration type 1 for base access
[    0.351360] bio: create slab <bio-0> at 0
[    0.351853] ACPI: Added _OSI(Module Device)
[    0.351857] ACPI: Added _OSI(Processor Device)
[    0.351860] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.351861] ACPI: Added _OSI(Processor Aggregator Device)
[    0.409253] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.509888] ACPI: Dynamic OEM Table Load:
[    0.509893] ACPI: PRAD 0x0000000000000000 000102 (v02 SUPERM SMCI--MB
00000002 INTL 20120913)
[    0.569395] ACPI: Interpreter enabled
[    0.569402] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State
[\_S1_] (20131218/hwxface-580)
[    0.569408] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State
[\_S2_] (20131218/hwxface-580)
[    0.569413] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State
[\_S3_] (20131218/hwxface-580)
[    0.569421] ACPI: (supports S0 S5)
[    0.569423] ACPI: Using IOAPIC for interrupt routing
[    0.569464] HEST: Enabling Firmware First mode for corrected errors.
[    0.569812] HEST: Table parsing has been initialized.
[    0.569816] PCI: Using host bridge windows from ACPI; if necessary, use
"pci=nocrs" and report a bug
[    0.571348] ACPI: No dock devices found.
[    0.652858] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
[    0.652864] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.656990] acpi PNP0A03:03: _OSC: platform does not support [AER]
[    0.658437] acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME
PCIeCapability]
[    0.658505] PCI host bridge to bus 0000:ff
[    0.658509] pci_bus 0000:ff: root bus resource [bus ff]
[    0.658528] pci 0000:ff:0b.0: [8086:2f81] type 00 class 0x088000
[    0.658607] pci 0000:ff:0b.1: [8086:2f36] type 00 class 0x110100
[    0.658670] pci 0000:ff:0b.2: [8086:2f37] type 00 class 0x110100
[    0.658734] pci 0000:ff:0c.0: [8086:2fe0] type 00 class 0x088000
[    0.658796] pci 0000:ff:0c.1: [8086:2fe1] type 00 class 0x088000
[    0.658855] pci 0000:ff:0c.2: [8086:2fe2] type 00 class 0x088000
[    0.658916] pci 0000:ff:0c.3: [8086:2fe3] type 00 class 0x088000
[    0.658975] pci 0000:ff:0c.4: [8086:2fe4] type 00 class 0x088000
[    0.659034] pci 0000:ff:0c.5: [8086:2fe5] type 00 class 0x088000
[    0.659095] pci 0000:ff:0c.6: [8086:2fe6] type 00 class 0x088000
[    0.659155] pci 0000:ff:0c.7: [8086:2fe7] type 00 class 0x088000
[    0.659214] pci 0000:ff:0d.0: [8086:2fe8] type 00 class 0x088000
[    0.659275] pci 0000:ff:0d.1: [8086:2fe9] type 00 class 0x088000
[    0.659340] pci 0000:ff:0f.0: [8086:2ff8] type 00 class 0x088000
[    0.659400] pci 0000:ff:0f.1: [8086:2ff9] type 00 class 0x088000
[    0.659458] pci 0000:ff:0f.2: [8086:2ffa] type 00 class 0x088000
[    0.659517] pci 0000:ff:0f.3: [8086:2ffb] type 00 class 0x088000
[    0.659576] pci 0000:ff:0f.4: [8086:2ffc] type 00 class 0x088000
[    0.659636] pci 0000:ff:0f.5: [8086:2ffd] type 00 class 0x088000
[    0.659696] pci 0000:ff:0f.6: [8086:2ffe] type 00 class 0x088000
[    0.659757] pci 0000:ff:10.0: [8086:2f1d] type 00 class 0x088000
[    0.659817] pci 0000:ff:10.1: [8086:2f34] type 00 class 0x110100
[    0.659880] pci 0000:ff:10.5: [8086:2f1e] type 00 class 0x088000
[    0.659939] pci 0000:ff:10.6: [8086:2f7d] type 00 class 0x110100
[    0.659998] pci 0000:ff:10.7: [8086:2f1f] type 00 class 0x088000
[    0.660057] pci 0000:ff:12.0: [8086:2fa0] type 00 class 0x088000
[    0.660118] pci 0000:ff:12.1: [8086:2f30] type 00 class 0x110100
[    0.660182] pci 0000:ff:12.4: [8086:2f60] type 00 class 0x088000
[    0.660244] pci 0000:ff:12.5: [8086:2f38] type 00 class 0x110100
[    0.660309] pci 0000:ff:13.0: [8086:2fa8] type 00 class 0x088000
[    0.660376] pci 0000:ff:13.1: [8086:2f71] type 00 class 0x088000
[    0.660442] pci 0000:ff:13.2: [8086:2faa] type 00 class 0x088000
[    0.660506] pci 0000:ff:13.3: [8086:2fab] type 00 class 0x088000
[    0.660573] pci 0000:ff:13.6: [8086:2fae] type 00 class 0x088000
[    0.660635] pci 0000:ff:13.7: [8086:2faf] type 00 class 0x088000
[    0.660699] pci 0000:ff:14.0: [8086:2fb0] type 00 class 0x088000
[    0.660766] pci 0000:ff:14.1: [8086:2fb1] type 00 class 0x088000
[    0.660832] pci 0000:ff:14.2: [8086:2fb2] type 00 class 0x088000
[    0.660898] pci 0000:ff:14.3: [8086:2fb3] type 00 class 0x088000
[    0.660964] pci 0000:ff:14.4: [8086:2fbc] type 00 class 0x088000
[    0.661026] pci 0000:ff:14.5: [8086:2fbd] type 00 class 0x088000
[    0.661089] pci 0000:ff:14.6: [8086:2fbe] type 00 class 0x088000
[    0.661152] pci 0000:ff:14.7: [8086:2fbf] type 00 class 0x088000
[    0.661217] pci 0000:ff:16.0: [8086:2f68] type 00 class 0x088000
[    0.661283] pci 0000:ff:16.1: [8086:2f79] type 00 class 0x088000
[    0.661349] pci 0000:ff:16.2: [8086:2f6a] type 00 class 0x088000
[    0.661415] pci 0000:ff:16.3: [8086:2f6b] type 00 class 0x088000
[    0.661484] pci 0000:ff:16.6: [8086:2f6e] type 00 class 0x088000
[    0.661545] pci 0000:ff:16.7: [8086:2f6f] type 00 class 0x088000
[    0.661610] pci 0000:ff:17.0: [8086:2fd0] type 00 class 0x088000
[    0.661676] pci 0000:ff:17.1: [8086:2fd1] type 00 class 0x088000
[    0.661744] pci 0000:ff:17.2: [8086:2fd2] type 00 class 0x088000
[    0.661811] pci 0000:ff:17.3: [8086:2fd3] type 00 class 0x088000
[    0.661877] pci 0000:ff:17.4: [8086:2fb8] type 00 class 0x088000
[    0.661941] pci 0000:ff:17.5: [8086:2fb9] type 00 class 0x088000
[    0.662004] pci 0000:ff:17.6: [8086:2fba] type 00 class 0x088000
[    0.662066] pci 0000:ff:17.7: [8086:2fbb] type 00 class 0x088000
[    0.662137] pci 0000:ff:1e.0: [8086:2f98] type 00 class 0x088000
[    0.662199] pci 0000:ff:1e.1: [8086:2f99] type 00 class 0x088000
[    0.662262] pci 0000:ff:1e.2: [8086:2f9a] type 00 class 0x088000
[    0.662323] pci 0000:ff:1e.3: [8086:2fc0] type 00 class 0x088000
[    0.662385] pci 0000:ff:1e.4: [8086:2f9c] type 00 class 0x088000
[    0.662459] pci 0000:ff:1f.0: [8086:2f88] type 00 class 0x088000
[    0.662548] pci 0000:ff:1f.2: [8086:2f8a] type 00 class 0x088000
[    0.662624] acpi PNP0A03:03: Disabling ASPM (FADT indicates it is
unsupported)
[    0.671126] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.671132] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.671689] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.672428] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
PCIeCapability]
[    0.673042] PCI host bridge to bus 0000:00
[    0.673046] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.673048] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.673050] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
[    0.673053] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff]
[    0.673055] pci_bus 0000:00: root bus resource [mem
0xfedb0000-0xfedb000f]
[    0.673057] pci_bus 0000:00: root bus resource [mem
0xfedc0000-0xfedc000f]
[    0.673059] pci_bus 0000:00: root bus resource [mem
0x90000000-0xfbffbfff]
[    0.673068] pci 0000:00:00.0: [8086:2f00] type 00 class 0x060000
[    0.673266] pci 0000:00:01.0: [8086:2f02] type 01 class 0x060400
[    0.673318] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.673436] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.673491] pci 0000:00:01.1: [8086:2f03] type 01 class 0x060400
[    0.673543] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.673660] pci 0000:00:01.1: System wakeup disabled by ACPI
[    0.673717] pci 0000:00:02.0: [8086:2f04] type 01 class 0x060400
[    0.673768] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.673885] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.673939] pci 0000:00:02.2: [8086:2f06] type 01 class 0x060400
[    0.673990] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.674106] pci 0000:00:02.2: System wakeup disabled by ACPI
[    0.674162] pci 0000:00:03.0: [8086:2f08] type 01 class 0x060400
[    0.674213] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.674329] pci 0000:00:03.0: System wakeup disabled by ACPI
[    0.674383] pci 0000:00:03.2: [8086:2f0a] type 01 class 0x060400
[    0.674433] pci 0000:00:03.2: PME# supported from D0 D3hot D3cold
[    0.674597] pci 0000:00:03.2: System wakeup disabled by ACPI
[    0.674653] pci 0000:00:04.0: [8086:2f20] type 00 class 0x088000
[    0.674664] pci 0000:00:04.0: reg 0x10: [mem 0xfbd2c000-0xfbd2ffff 64bit]
[    0.674854] pci 0000:00:04.1: [8086:2f21] type 00 class 0x088000
[    0.674864] pci 0000:00:04.1: reg 0x10: [mem 0xfbd28000-0xfbd2bfff 64bit]
[    0.675054] pci 0000:00:04.2: [8086:2f22] type 00 class 0x088000
[    0.675064] pci 0000:00:04.2: reg 0x10: [mem 0xfbd24000-0xfbd27fff 64bit]
[    0.675254] pci 0000:00:04.3: [8086:2f23] type 00 class 0x088000
[    0.675264] pci 0000:00:04.3: reg 0x10: [mem 0xfbd20000-0xfbd23fff 64bit]
[    0.675454] pci 0000:00:04.4: [8086:2f24] type 00 class 0x088000
[    0.675464] pci 0000:00:04.4: reg 0x10: [mem 0xfbd1c000-0xfbd1ffff 64bit]
[    0.675655] pci 0000:00:04.5: [8086:2f25] type 00 class 0x088000
[    0.675665] pci 0000:00:04.5: reg 0x10: [mem 0xfbd18000-0xfbd1bfff 64bit]
[    0.675855] pci 0000:00:04.6: [8086:2f26] type 00 class 0x088000
[    0.675864] pci 0000:00:04.6: reg 0x10: [mem 0xfbd14000-0xfbd17fff 64bit]
[    0.676053] pci 0000:00:04.7: [8086:2f27] type 00 class 0x088000
[    0.676063] pci 0000:00:04.7: reg 0x10: [mem 0xfbd10000-0xfbd13fff 64bit]
[    0.676251] pci 0000:00:05.0: [8086:2f28] type 00 class 0x088000
[    0.676427] pci 0000:00:05.1: [8086:2f29] type 00 class 0x088000
[    0.676617] pci 0000:00:05.2: [8086:2f2a] type 00 class 0x088000
[    0.676794] pci 0000:00:05.4: [8086:2f2c] type 00 class 0x080020
[    0.676802] pci 0000:00:05.4: reg 0x10: [mem 0xfbd38000-0xfbd38fff]
[    0.677000] pci 0000:00:11.0: [8086:8d7c] type 00 class 0xff0000
[    0.677259] pci 0000:00:14.0: [8086:8d31] type 00 class 0x0c0330
[    0.677278] pci 0000:00:14.0: reg 0x10: [mem 0xfbd00000-0xfbd0ffff 64bit]
[    0.677335] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.677469] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.677528] pci 0000:00:16.0: [8086:8d3a] type 00 class 0x078000
[    0.677549] pci 0000:00:16.0: reg 0x10: [mem 0xfbd37000-0xfbd3700f 64bit]
[    0.677616] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.677781] pci 0000:00:16.1: [8086:8d3b] type 00 class 0x078000
[    0.677801] pci 0000:00:16.1: reg 0x10: [mem 0xfbd36000-0xfbd3600f 64bit]
[    0.677868] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
[    0.678043] pci 0000:00:1c.0: [8086:8d10] type 01 class 0x060400
[    0.678125] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.678244] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.678301] pci 0000:00:1c.4: [8086:8d18] type 01 class 0x060400
[    0.678375] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.678511] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    0.678592] pci 0000:00:1c.5: [8086:8d1a] type 01 class 0x060400
[    0.678667] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.678786] pci 0000:00:1c.5: System wakeup disabled by ACPI
[    0.678840] pci 0000:00:1c.6: [8086:8d1c] type 01 class 0x060400
[    0.678914] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.679032] pci 0000:00:1c.6: System wakeup disabled by ACPI
[    0.679093] pci 0000:00:1d.0: [8086:8d26] type 00 class 0x0c0320
[    0.679115] pci 0000:00:1d.0: reg 0x10: [mem 0xfbd33000-0xfbd333ff]
[    0.679209] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.679344] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.679403] pci 0000:00:1f.0: [8086:8d44] type 00 class 0x060100
[    0.679663] pci 0000:00:1f.2: [8086:8d02] type 00 class 0x010601
[    0.679681] pci 0000:00:1f.2: reg 0x10: [io  0xf050-0xf057]
[    0.679689] pci 0000:00:1f.2: reg 0x14: [io  0xf040-0xf043]
[    0.679697] pci 0000:00:1f.2: reg 0x18: [io  0xf030-0xf037]
[    0.679705] pci 0000:00:1f.2: reg 0x1c: [io  0xf020-0xf023]
[    0.679713] pci 0000:00:1f.2: reg 0x20: [io  0xf000-0xf01f]
[    0.679721] pci 0000:00:1f.2: reg 0x24: [mem 0xfbd32000-0xfbd327ff]
[    0.679763] pci 0000:00:1f.2: PME# supported from D3hot
[    0.679922] pci 0000:00:1f.3: [8086:8d22] type 00 class 0x0c0500
[    0.679937] pci 0000:00:1f.3: reg 0x10: [mem 0xfbd31000-0xfbd310ff 64bit]
[    0.679959] pci 0000:00:1f.3: reg 0x20: [io  0x0580-0x059f]
[    0.680378] acpiphp: Slot [0] registered
[    0.680426] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.680712] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.681005] pci 0000:00:02.0: PCI bridge to [bus 03]
[    0.681328] pci 0000:04:00.0: [8086:1521] type 00 class 0x020000
[    0.681339] pci 0000:04:00.0: reg 0x10: [mem 0xfb900000-0xfb9fffff]
[    0.681360] pci 0000:04:00.0: reg 0x1c: [mem 0xfba0c000-0xfba0ffff]
[    0.681433] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.681467] pci 0000:04:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.681482] pci 0000:04:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.681585] pci 0000:04:00.1: [8086:1521] type 00 class 0x020000
[    0.681596] pci 0000:04:00.1: reg 0x10: [mem 0xfb800000-0xfb8fffff]
[    0.681617] pci 0000:04:00.1: reg 0x1c: [mem 0xfba08000-0xfba0bfff]
[    0.681687] pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
[    0.681716] pci 0000:04:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.681730] pci 0000:04:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.681831] pci 0000:04:00.2: [8086:1521] type 00 class 0x020000
[    0.681842] pci 0000:04:00.2: reg 0x10: [mem 0xfb700000-0xfb7fffff]
[    0.681863] pci 0000:04:00.2: reg 0x1c: [mem 0xfba04000-0xfba07fff]
[    0.681933] pci 0000:04:00.2: PME# supported from D0 D3hot D3cold
[    0.681961] pci 0000:04:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.681976] pci 0000:04:00.2: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.682073] pci 0000:04:00.3: [8086:1521] type 00 class 0x020000
[    0.682084] pci 0000:04:00.3: reg 0x10: [mem 0xfb600000-0xfb6fffff]
[    0.682104] pci 0000:04:00.3: reg 0x1c: [mem 0xfba00000-0xfba03fff]
[    0.682175] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
[    0.682203] pci 0000:04:00.3: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.682218] pci 0000:04:00.3: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.686480] pci 0000:00:02.2: PCI bridge to [bus 04]
[    0.686489] pci 0000:00:02.2:   bridge window [mem 0xfb600000-0xfbafffff]
[    0.686893] pci 0000:05:00.0: [8086:1521] type 00 class 0x020000
[    0.686905] pci 0000:05:00.0: reg 0x10: [mem 0xfb400000-0xfb4fffff]
[    0.686926] pci 0000:05:00.0: reg 0x1c: [mem 0xfb50c000-0xfb50ffff]
[    0.686999] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.687032] pci 0000:05:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.687047] pci 0000:05:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.687143] pci 0000:05:00.1: [8086:1521] type 00 class 0x020000
[    0.687154] pci 0000:05:00.1: reg 0x10: [mem 0xfb300000-0xfb3fffff]
[    0.687175] pci 0000:05:00.1: reg 0x1c: [mem 0xfb508000-0xfb50bfff]
[    0.687245] pci 0000:05:00.1: PME# supported from D0 D3hot D3cold
[    0.687274] pci 0000:05:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.687289] pci 0000:05:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.687382] pci 0000:05:00.2: [8086:1521] type 00 class 0x020000
[    0.687393] pci 0000:05:00.2: reg 0x10: [mem 0xfb200000-0xfb2fffff]
[    0.687413] pci 0000:05:00.2: reg 0x1c: [mem 0xfb504000-0xfb507fff]
[    0.687484] pci 0000:05:00.2: PME# supported from D0 D3hot D3cold
[    0.687513] pci 0000:05:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.687528] pci 0000:05:00.2: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.687620] pci 0000:05:00.3: [8086:1521] type 00 class 0x020000
[    0.687631] pci 0000:05:00.3: reg 0x10: [mem 0xfb100000-0xfb1fffff]
[    0.687652] pci 0000:05:00.3: reg 0x1c: [mem 0xfb500000-0xfb503fff]
[    0.687722] pci 0000:05:00.3: PME# supported from D0 D3hot D3cold
[    0.687751] pci 0000:05:00.3: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.687766] pci 0000:05:00.3: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.694490] pci 0000:00:03.0: PCI bridge to [bus 05]
[    0.694498] pci 0000:00:03.0:   bridge window [mem 0xfb100000-0xfb5fffff]
[    0.694949] pci 0000:00:03.2: PCI bridge to [bus 06]
[    0.695026] pci 0000:00:1c.0: PCI bridge to [bus 07]
[    0.695147] pci 0000:08:00.0: [8086:1533] type 00 class 0x020000
[    0.695169] pci 0000:08:00.0: reg 0x10: [mem 0xfbc00000-0xfbc7ffff]
[    0.695199] pci 0000:08:00.0: reg 0x18: [io  0xe000-0xe01f]
[    0.695214] pci 0000:08:00.0: reg 0x1c: [mem 0xfbc80000-0xfbc83fff]
[    0.695356] pci 0000:08:00.0: PME# supported from D0 D3hot D3cold
[    0.702502] pci 0000:00:1c.4: PCI bridge to [bus 08]
[    0.702510] pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
[    0.702516] pci 0000:00:1c.4:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.702728] pci 0000:09:00.0: [8086:1533] type 00 class 0x020000
[    0.702751] pci 0000:09:00.0: reg 0x10: [mem 0xfbb00000-0xfbb7ffff]
[    0.702780] pci 0000:09:00.0: reg 0x18: [io  0xd000-0xd01f]
[    0.702796] pci 0000:09:00.0: reg 0x1c: [mem 0xfbb80000-0xfbb83fff]
[    0.702937] pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
[    0.710513] pci 0000:00:1c.5: PCI bridge to [bus 09]
[    0.710520] pci 0000:00:1c.5:   bridge window [io  0xd000-0xdfff]
[    0.710526] pci 0000:00:1c.5:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.710718] pci 0000:0a:00.0: [1a03:1150] type 01 class 0x060400
[    0.710881] pci 0000:0a:00.0: supports D1 D2
[    0.710885] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.718521] pci 0000:00:1c.6: PCI bridge to [bus 0a-0b]
[    0.718528] pci 0000:00:1c.6:   bridge window [io  0xc000-0xcfff]
[    0.718534] pci 0000:00:1c.6:   bridge window [mem 0xfa000000-0xfb0fffff]
[    0.718730] pci 0000:0b:00.0: [1a03:2000] type 00 class 0x030000
[    0.718769] pci 0000:0b:00.0: reg 0x10: [mem 0xfa000000-0xfaffffff]
[    0.718788] pci 0000:0b:00.0: reg 0x14: [mem 0xfb000000-0xfb01ffff]
[    0.718807] pci 0000:0b:00.0: reg 0x18: [io  0xc000-0xc07f]
[    0.718942] pci 0000:0b:00.0: supports D1 D2
[    0.718946] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.719090] pci 0000:0a:00.0: PCI bridge to [bus 0b]
[    0.719098] pci 0000:0a:00.0:   bridge window [io  0xc000-0xcfff]
[    0.719104] pci 0000:0a:00.0:   bridge window [mem 0xfa000000-0xfb0fffff]
[    0.719173] pci_bus 0000:00: on NUMA node 0 (pxm 0)
[    0.719175] acpi PNP0A08:00: Disabling ASPM (FADT indicates it is
unsupported)
[    0.720205] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14
15)
[    0.720289] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14
15)
[    0.720371] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 10 11 12 14
15)
[    0.720454] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 10 11 12 14
15)
[    0.720534] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14
15) *0, disabled.
[    0.720616] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14
15) *0, disabled.
[    0.720697] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14
15) *0, disabled.
[    0.720779] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14
15) *0, disabled.
[    0.720915] ACPI: Enabled 2 GPEs in block 00 to 3F
[    0.721415] vgaarb: device added:
PCI:0000:0b:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.721417] vgaarb: loaded
[    0.721419] vgaarb: bridge control possible 0000:0b:00.0
[    0.721436] ACPI: bus type USB registered
[    0.721465] usbcore: registered new interface driver usbfs
[    0.721480] usbcore: registered new interface driver hub
[    0.721529] usbcore: registered new device driver usb
[    0.721575] PCI: Using ACPI for IRQ routing
[    0.727710] PCI: pci_cache_line_size set to 64 bytes
[    0.727868] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.727871] e820: reserve RAM buffer [mem 0x78e31000-0x7bffffff]
[    0.728025] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.728034] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.730133] Switched to clocksource hpet
[    0.739716] pnp: PnP ACPI init
[    0.739732] ACPI: bus type PNP registered
[    0.740247] pnp 00:00: Plug and Play ACPI device, IDs PNP0003 (active)
[    0.740269] pnp 00:01: [dma 4]
[    0.740304] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.740358] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.740410] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.740454] pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.740544] pnp 00:05: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.740648] system 00:06: [io  0x0500-0x057f] has been reserved
[    0.740651] system 00:06: [io  0x0400-0x047f] could not be reserved
[    0.740654] system 00:06: [io  0x0580-0x059f] has been reserved
[    0.740657] system 00:06: [io  0x0600-0x061f] has been reserved
[    0.740659] system 00:06: [io  0x0880-0x0883] has been reserved
[    0.740661] system 00:06: [io  0x0800-0x081f] has been reserved
[    0.740664] system 00:06: [mem 0xfed1c000-0xfed3ffff] has been reserved
[    0.740667] system 00:06: [mem 0xfed45000-0xfed8bfff] has been reserved
[    0.740670] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    0.740672] system 00:06: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.740675] system 00:06: [mem 0xfed12000-0xfed1200f] has been reserved
[    0.740677] system 00:06: [mem 0xfed12010-0xfed1201f] has been reserved
[    0.740680] system 00:06: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    0.740683] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.741020] system 00:07: [io  0x0a00-0x0a0f] has been reserved
[    0.741023] system 00:07: [io  0x0a10-0x0a1f] has been reserved
[    0.741025] system 00:07: [io  0x0a20-0x0a2f] has been reserved
[    0.741028] system 00:07: [io  0x0a30-0x0a3f] has been reserved
[    0.741030] system 00:07: [io  0x0a40-0x0a4f] has been reserved
[    0.741033] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.741560] pnp 00:08: Plug and Play ACPI device, IDs IPI0001 (active)
[    0.742546] pnp: PnP ACPI: found 9 devices
[    0.742548] ACPI: bus type PNP unregistered
[    0.750489] pci_bus 0000:00: max bus depth: 2 pci_try_num: 3
[    0.750518] pci 0000:04:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750529] pci 0000:04:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750538] pci 0000:04:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750548] pci 0000:04:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750558] pci 0000:04:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750568] pci 0000:04:00.2: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750578] pci 0000:04:00.3: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750587] pci 0000:04:00.3: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750601] pci 0000:05:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750611] pci 0000:05:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750621] pci 0000:05:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750631] pci 0000:05:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750641] pci 0000:05:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750651] pci 0000:05:00.2: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750660] pci 0000:05:00.3: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750670] pci 0000:05:00.3: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750721] pci 0000:00:02.2: BAR 15: assigned [mem
0x90000000-0x900fffff 64bit pref]
[    0.750726] pci 0000:00:03.0: BAR 15: assigned [mem
0x90100000-0x901fffff 64bit pref]
[    0.750729] pci 0000:00:1c.0: BAR 14: assigned [mem
0x90200000-0x903fffff]
[    0.750733] pci 0000:00:1c.0: BAR 15: assigned [mem
0x90400000-0x905fffff 64bit pref]
[    0.750736] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.750739] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.750747] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.750754] pci 0000:00:02.0: PCI bridge to [bus 03]
[    0.750769] pci 0000:04:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750779] pci 0000:04:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750789] pci 0000:04:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750799] pci 0000:04:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750809] pci 0000:04:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750819] pci 0000:04:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750828] pci 0000:04:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750838] pci 0000:04:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750848] pci 0000:04:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750858] pci 0000:04:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750868] pci 0000:04:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750878] pci 0000:04:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750887] pci 0000:04:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750897] pci 0000:04:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750907] pci 0000:04:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750917] pci 0000:04:00.2: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750927] pci 0000:04:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750936] pci 0000:04:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750946] pci 0000:04:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750956] pci 0000:04:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750966] pci 0000:04:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750975] pci 0000:04:00.3: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750985] pci 0000:04:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.750995] pci 0000:04:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751005] pci 0000:04:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751015] pci 0000:04:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751024] pci 0000:04:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751034] pci 0000:04:00.2: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751044] pci 0000:04:00.3: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751054] pci 0000:04:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751064] pci 0000:04:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751073] pci 0000:04:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751083] pci 0000:04:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751093] pci 0000:04:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751102] pci 0000:04:00.2: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751112] pci 0000:04:00.3: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751122] pci 0000:04:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751125] pci 0000:04:00.0: BAR 7: assigned [mem 0x90000000-0x9001ffff
64bit pref]
[    0.751141] pci 0000:04:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751143] pci 0000:04:00.0: BAR 10: assigned [mem
0x90020000-0x9003ffff 64bit pref]
[    0.751158] pci 0000:04:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751161] pci 0000:04:00.1: BAR 7: assigned [mem 0x90040000-0x9005ffff
64bit pref]
[    0.751176] pci 0000:04:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751178] pci 0000:04:00.1: BAR 10: assigned [mem
0x90060000-0x9007ffff 64bit pref]
[    0.751193] pci 0000:04:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751196] pci 0000:04:00.2: BAR 7: assigned [mem 0x90080000-0x9009ffff
64bit pref]
[    0.751211] pci 0000:04:00.2: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751213] pci 0000:04:00.2: BAR 10: assigned [mem
0x900a0000-0x900bffff 64bit pref]
[    0.751228] pci 0000:04:00.3: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751231] pci 0000:04:00.3: BAR 7: assigned [mem 0x900c0000-0x900dffff
64bit pref]
[    0.751246] pci 0000:04:00.3: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751248] pci 0000:04:00.3: BAR 10: assigned [mem
0x900e0000-0x900fffff 64bit pref]
[    0.751256] pci 0000:00:02.2: PCI bridge to [bus 04]
[    0.751260] pci 0000:00:02.2:   bridge window [mem 0xfb600000-0xfbafffff]
[    0.751263] pci 0000:00:02.2:   bridge window [mem 0x90000000-0x900fffff
64bit pref]
[    0.751275] pci 0000:05:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751285] pci 0000:05:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751295] pci 0000:05:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751305] pci 0000:05:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751315] pci 0000:05:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751325] pci 0000:05:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751334] pci 0000:05:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751344] pci 0000:05:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751354] pci 0000:05:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751364] pci 0000:05:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751374] pci 0000:05:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751384] pci 0000:05:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751393] pci 0000:05:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751403] pci 0000:05:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751413] pci 0000:05:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751423] pci 0000:05:00.2: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751433] pci 0000:05:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751442] pci 0000:05:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751452] pci 0000:05:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751462] pci 0000:05:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751472] pci 0000:05:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751482] pci 0000:05:00.3: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751492] pci 0000:05:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751501] pci 0000:05:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751511] pci 0000:05:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751521] pci 0000:05:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751531] pci 0000:05:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751541] pci 0000:05:00.2: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751551] pci 0000:05:00.3: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751560] pci 0000:05:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751570] pci 0000:05:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751580] pci 0000:05:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751590] pci 0000:05:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751600] pci 0000:05:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751610] pci 0000:05:00.2: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751619] pci 0000:05:00.3: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751629] pci 0000:05:00.0: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751632] pci 0000:05:00.0: BAR 7: assigned [mem 0x90100000-0x9011ffff
64bit pref]
[    0.751647] pci 0000:05:00.0: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751649] pci 0000:05:00.0: BAR 10: assigned [mem
0x90120000-0x9013ffff 64bit pref]
[    0.751664] pci 0000:05:00.1: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751666] pci 0000:05:00.1: BAR 7: assigned [mem 0x90140000-0x9015ffff
64bit pref]
[    0.751682] pci 0000:05:00.1: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751684] pci 0000:05:00.1: BAR 10: assigned [mem
0x90160000-0x9017ffff 64bit pref]
[    0.751699] pci 0000:05:00.2: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751702] pci 0000:05:00.2: BAR 7: assigned [mem 0x90180000-0x9019ffff
64bit pref]
[    0.751717] pci 0000:05:00.2: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751719] pci 0000:05:00.2: BAR 10: assigned [mem
0x901a0000-0x901bffff 64bit pref]
[    0.751734] pci 0000:05:00.3: reg 0x184: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751737] pci 0000:05:00.3: BAR 7: assigned [mem 0x901c0000-0x901dffff
64bit pref]
[    0.751752] pci 0000:05:00.3: reg 0x190: [mem 0x00000000-0x00003fff
64bit pref]
[    0.751754] pci 0000:05:00.3: BAR 10: assigned [mem
0x901e0000-0x901fffff 64bit pref]
[    0.751762] pci 0000:00:03.0: PCI bridge to [bus 05]
[    0.751766] pci 0000:00:03.0:   bridge window [mem 0xfb100000-0xfb5fffff]
[    0.751769] pci 0000:00:03.0:   bridge window [mem 0x90100000-0x901fffff
64bit pref]
[    0.751773] pci 0000:00:03.2: PCI bridge to [bus 06]
[    0.751780] pci 0000:00:1c.0: PCI bridge to [bus 07]
[    0.751783] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    0.751788] pci 0000:00:1c.0:   bridge window [mem 0x90200000-0x903fffff]
[    0.751792] pci 0000:00:1c.0:   bridge window [mem 0x90400000-0x905fffff
64bit pref]
[    0.751798] pci 0000:00:1c.4: PCI bridge to [bus 08]
[    0.751801] pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
[    0.751806] pci 0000:00:1c.4:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.751813] pci 0000:00:1c.5: PCI bridge to [bus 09]
[    0.751816] pci 0000:00:1c.5:   bridge window [io  0xd000-0xdfff]
[    0.751820] pci 0000:00:1c.5:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.751828] pci 0000:0a:00.0: PCI bridge to [bus 0b]
[    0.751832] pci 0000:0a:00.0:   bridge window [io  0xc000-0xcfff]
[    0.751839] pci 0000:0a:00.0:   bridge window [mem 0xfa000000-0xfb0fffff]
[    0.751851] pci 0000:00:1c.6: PCI bridge to [bus 0a-0b]
[    0.751853] pci 0000:00:1c.6:   bridge window [io  0xc000-0xcfff]
[    0.751858] pci 0000:00:1c.6:   bridge window [mem 0xfa000000-0xfb0fffff]
[    0.751866] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.751868] pci_bus 0000:00: resource 5 [io  0x1000-0xffff]
[    0.751870] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.751872] pci_bus 0000:00: resource 7 [mem 0xfedb0000-0xfedb000f]
[    0.751874] pci_bus 0000:00: resource 8 [mem 0xfedc0000-0xfedc000f]
[    0.751876] pci_bus 0000:00: resource 9 [mem 0x90000000-0xfbffbfff]
[    0.751878] pci_bus 0000:04: resource 1 [mem 0xfb600000-0xfbafffff]
[    0.751880] pci_bus 0000:04: resource 2 [mem 0x90000000-0x900fffff 64bit
pref]
[    0.751882] pci_bus 0000:05: resource 1 [mem 0xfb100000-0xfb5fffff]
[    0.751884] pci_bus 0000:05: resource 2 [mem 0x90100000-0x901fffff 64bit
pref]
[    0.751887] pci_bus 0000:07: resource 0 [io  0x1000-0x1fff]
[    0.751889] pci_bus 0000:07: resource 1 [mem 0x90200000-0x903fffff]
[    0.751891] pci_bus 0000:07: resource 2 [mem 0x90400000-0x905fffff 64bit
pref]
[    0.751893] pci_bus 0000:08: resource 0 [io  0xe000-0xefff]
[    0.751894] pci_bus 0000:08: resource 1 [mem 0xfbc00000-0xfbcfffff]
[    0.751896] pci_bus 0000:09: resource 0 [io  0xd000-0xdfff]
[    0.751898] pci_bus 0000:09: resource 1 [mem 0xfbb00000-0xfbbfffff]
[    0.751900] pci_bus 0000:0a: resource 0 [io  0xc000-0xcfff]
[    0.751902] pci_bus 0000:0a: resource 1 [mem 0xfa000000-0xfb0fffff]
[    0.751904] pci_bus 0000:0b: resource 0 [io  0xc000-0xcfff]
[    0.751906] pci_bus 0000:0b: resource 1 [mem 0xfa000000-0xfb0fffff]
[    0.752111] NET: Registered protocol family 2
[    0.752604] TCP established hash table entries: 131072 (order: 8,
1048576 bytes)
[    0.752862] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.752968] TCP: Hash tables configured (established 131072 bind 65536)
[    0.752986] TCP: reno registered
[    0.753010] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.753066] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.753242] NET: Registered protocol family 1
[    0.753749] pci 0000:00:14.0: CONFIG_USB_XHCI_HCD is turned off,
defaulting to EHCI.
[    0.753752] pci 0000:00:14.0: USB 3.0 devices will work at USB 2.0
speeds.
[    0.754210] pci 0000:0b:00.0: Boot video device
[    0.754214] PCI: CLS 64 bytes, default 64
[    0.754265] Unpacking initramfs...
[    1.144565] Freeing initrd memory: 20476K (ffff8800357f2000 -
ffff880036bf1000)
[    1.144580] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.144583] software IO TLB [mem 0x74e31000-0x78e31000] (64MB) mapped at
[ffff880074e31000-ffff880078e30fff]
[    1.145632] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    1.145761] audit: initializing netlink subsys (disabled)
[    1.145782] audit: type=2000 audit(1477546526.032:1): initialized
[    1.251807] [Xenomai] scheduling class idle registered.
[    1.251809] [Xenomai] scheduling class rt registered.
[    1.251867] [Xenomai] SMI-enabled chipset found, but SMI workaround
disabled
          (see xenomai.smi parameter). You might encounter
          high latencies!
[    1.252279] I-pipe: head domain Xenomai registered.
[    1.253250] [Xenomai] Cobalt v3.0.2 (Exact Zero) [DEBUG]
[    1.253400] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.253930] VFS: Disk quotas dquot_6.5.2
[    1.253976] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.254064] msgmni has been set to 31892
[    1.254595] alg: No test for stdrng (krng)
[    1.254658] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 250)
[    1.254764] io scheduler noop registered
[    1.254766] io scheduler deadline registered
[    1.254842] io scheduler cfq registered (default)
[    1.255293] pcieport 0000:00:01.0: irq 65 for MSI/MSI-X
[    1.255500] pcieport 0000:00:01.1: irq 66 for MSI/MSI-X
[    1.255702] pcieport 0000:00:02.0: irq 67 for MSI/MSI-X
[    1.255899] pcieport 0000:00:02.2: irq 68 for MSI/MSI-X
[    1.256100] pcieport 0000:00:03.0: irq 69 for MSI/MSI-X
[    1.256298] pcieport 0000:00:03.2: irq 70 for MSI/MSI-X
[    1.256510] pcieport 0000:00:1c.0: irq 71 for MSI/MSI-X
[    1.256740] pcieport 0000:00:1c.4: irq 72 for MSI/MSI-X
[    1.256954] pcieport 0000:00:1c.5: irq 73 for MSI/MSI-X
[    1.257166] pcieport 0000:00:1c.6: irq 74 for MSI/MSI-X
[    1.257278] pcieport 0000:00:01.0: Signaling PME through PCIe PME
interrupt
[    1.257282] pcie_pme 0000:00:01.0:pcie01: service driver pcie_pme loaded
[    1.257303] pcieport 0000:00:01.1: Signaling PME through PCIe PME
interrupt
[    1.257306] pcie_pme 0000:00:01.1:pcie01: service driver pcie_pme loaded
[    1.257325] pcieport 0000:00:02.0: Signaling PME through PCIe PME
interrupt
[    1.257328] pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
[    1.257347] pcieport 0000:00:02.2: Signaling PME through PCIe PME
interrupt
[    1.257349] pci 0000:04:00.0: Signaling PME through PCIe PME interrupt
[    1.257351] pci 0000:04:00.1: Signaling PME through PCIe PME interrupt
[    1.257353] pci 0000:04:00.2: Signaling PME through PCIe PME interrupt
[    1.257354] pci 0000:04:00.3: Signaling PME through PCIe PME interrupt
[    1.257357] pcie_pme 0000:00:02.2:pcie01: service driver pcie_pme loaded
[    1.257377] pcieport 0000:00:03.0: Signaling PME through PCIe PME
interrupt
[    1.257379] pci 0000:05:00.0: Signaling PME through PCIe PME interrupt
[    1.257381] pci 0000:05:00.1: Signaling PME through PCIe PME interrupt
[    1.257382] pci 0000:05:00.2: Signaling PME through PCIe PME interrupt
[    1.257384] pci 0000:05:00.3: Signaling PME through PCIe PME interrupt
[    1.257387] pcie_pme 0000:00:03.0:pcie01: service driver pcie_pme loaded
[    1.257407] pcieport 0000:00:03.2: Signaling PME through PCIe PME
interrupt
[    1.257410] pcie_pme 0000:00:03.2:pcie01: service driver pcie_pme loaded
[    1.257430] pcieport 0000:00:1c.0: Signaling PME through PCIe PME
interrupt
[    1.257434] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    1.257454] pcieport 0000:00:1c.4: Signaling PME through PCIe PME
interrupt
[    1.257456] pci 0000:08:00.0: Signaling PME through PCIe PME interrupt
[    1.257459] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme loaded
[    1.257479] pcieport 0000:00:1c.5: Signaling PME through PCIe PME
interrupt
[    1.257481] pci 0000:09:00.0: Signaling PME through PCIe PME interrupt
[    1.257484] pcie_pme 0000:00:1c.5:pcie01: service driver pcie_pme loaded
[    1.257505] pcieport 0000:00:1c.6: Signaling PME through PCIe PME
interrupt
[    1.257507] pci 0000:0a:00.0: Signaling PME through PCIe PME interrupt
[    1.257508] pci 0000:0b:00.0: Signaling PME through PCIe PME interrupt
[    1.257512] pcie_pme 0000:00:1c.6:pcie01: service driver pcie_pme loaded
[    1.257539] ioapic: probe of 0000:00:05.4 failed with error -22
[    1.257551] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.257596] pciehp 0000:00:1c.0:pcie04: Slot #0 AttnBtn- AttnInd-
PwrInd- PwrCtrl- MRL- Interlock- NoCompl+ LLActRep+
[    1.257676] pciehp 0000:00:1c.0:pcie04: service driver pciehp loaded
[    1.257684] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.257734] intel_idle: does not run on family 6 model 63
[    1.257908] ERST: Error Record Serialization Table (ERST) support is
initialized.
[    1.257911] pstore: Registered erst as persistent store backend
[    1.258144] GHES: APEI firmware first mode is enabled by APEI bit and
WHEA _OSC.
[    1.258212] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.258892] Linux agpgart interface v0.103
[    1.259158] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    2.285408] tsc: Refined TSC clocksource calibration: 2299.998 MHz
[    2.286262] i8042: No controller found
[    2.286454] mousedev: PS/2 mouse device common for all mice
[    2.286493] rtc_cmos 00:02: RTC can wake from S4
[    2.286646] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    2.286675] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes
nvram, hpet irqs
[    2.287545] AMD IOMMUv2 driver by Joerg Roedel <joerg.roedel@amd.com>
[    2.287547] AMD IOMMUv2 functionality not available on this system
[    2.287845] TCP: cubic registered
[    2.288065] NET: Registered protocol family 10
[    2.288470] mip6: Mobile IPv6
[    2.288474] NET: Registered protocol family 17
[    2.288576] NET: Registered protocol family 33
[    2.288579] Key type rxrpc registered
[    2.288581] Key type rxrpc_s registered
[    2.288586] mpls_gso: MPLS GSO support
[    2.289293] registered taskstats version 1
[    2.290354] rtc_cmos 00:02: setting system clock to 2016-10-27 05:35:28
UTC (1477546528)
[    2.291995] Freeing unused kernel memory: 2088K (ffffffff81fba000 -
ffffffff821c4000)
[    2.291998] Write protecting the kernel read-only data: 12288k
[    2.296691] Freeing unused kernel memory: 1756K (ffff880001849000 -
ffff880001a00000)
[    2.297075] Freeing unused kernel memory: 132K (ffff880001bdf000 -
ffff880001c00000)
[    2.308021] systemd-udevd[110]: starting version 215
[    2.308541] random: systemd-udevd urandom read with 2 bits of entropy
available
[    2.400394] pps_core: LinuxPPS API ver. 1 registered
[    2.400400] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo
Giometti <giometti@linux.it>
[    2.402327] PTP clock support registered
[    2.406641] igb: Intel(R) Gigabit Ethernet Network Driver - version
5.0.5-k
[    2.406649] igb: Copyright (c) 2007-2013 Intel Corporation.
[    2.407298] igb 0000:04:00.0: irq 75 for MSI/MSI-X
[    2.407320] igb 0000:04:00.0: irq 76 for MSI/MSI-X
[    2.407342] igb 0000:04:00.0: irq 77 for MSI/MSI-X
[    2.407357] igb 0000:04:00.0: irq 78 for MSI/MSI-X
[    2.407374] igb 0000:04:00.0: irq 79 for MSI/MSI-X
[    2.407395] igb 0000:04:00.0: irq 80 for MSI/MSI-X
[    2.407410] igb 0000:04:00.0: irq 81 for MSI/MSI-X
[    2.407422] igb 0000:04:00.0: irq 82 for MSI/MSI-X
[    2.407439] igb 0000:04:00.0: irq 83 for MSI/MSI-X
[    2.409400] SCSI subsystem initialized
[    2.412328] libata version 3.00 loaded.
[    2.414084] ahci 0000:00:1f.2: version 3.0
[    2.414661] ahci 0000:00:1f.2: irq 84 for MSI/MSI-X
[    2.414764] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps
0x3f impl SATA mode
[    2.414771] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part
ems apst
[    2.453560] igb 0000:04:00.0: irq 75 for MSI/MSI-X
[    2.453576] igb 0000:04:00.0: irq 76 for MSI/MSI-X
[    2.453591] igb 0000:04:00.0: irq 77 for MSI/MSI-X
[    2.453608] igb 0000:04:00.0: irq 78 for MSI/MSI-X
[    2.453626] igb 0000:04:00.0: irq 79 for MSI/MSI-X
[    2.453643] igb 0000:04:00.0: irq 80 for MSI/MSI-X
[    2.453660] igb 0000:04:00.0: irq 81 for MSI/MSI-X
[    2.453680] igb 0000:04:00.0: irq 82 for MSI/MSI-X
[    2.453697] igb 0000:04:00.0: irq 83 for MSI/MSI-X
[    2.454755] scsi0 : ahci
[    2.455053] scsi1 : ahci
[    2.455266] scsi2 : ahci
[    2.455476] scsi3 : ahci
[    2.455684] scsi4 : ahci
[    2.455892] scsi5 : ahci
[    2.455986] ata1: SATA max UDMA/133 abar m2048@0xfbd32000 port
0xfbd32100 irq 84
[    2.455990] ata2: SATA max UDMA/133 abar m2048@0xfbd32000 port
0xfbd32180 irq 84
[    2.455994] ata3: SATA max UDMA/133 abar m2048@0xfbd32000 port
0xfbd32200 irq 84
[    2.455997] ata4: SATA max UDMA/133 abar m2048@0xfbd32000 port
0xfbd32280 irq 84
[    2.456001] ata5: SATA max UDMA/133 abar m2048@0xfbd32000 port
0xfbd32300 irq 84
[    2.456003] ata6: SATA max UDMA/133 abar m2048@0xfbd32000 port
0xfbd32380 irq 84
[    2.534137] igb 0000:04:00.0: added PHC on eth0
[    2.534141] igb 0000:04:00.0: Intel(R) Gigabit Ethernet Network
Connection
[    2.534145] igb 0000:04:00.0: eth0: (PCIe:5.0Gb/s:Width x4)
a0:36:9f:a5:1c:48
[    2.534434] igb 0000:04:00.0: eth0: PBA No: H47822-001
[    2.534436] igb 0000:04:00.0: Using MSI-X interrupts. 8 rx queue(s), 8
tx queue(s)
[    2.534739] igb 0000:04:00.1: irq 85 for MSI/MSI-X
[    2.534748] igb 0000:04:00.1: irq 86 for MSI/MSI-X
[    2.534754] igb 0000:04:00.1: irq 87 for MSI/MSI-X
[    2.534761] igb 0000:04:00.1: irq 88 for MSI/MSI-X
[    2.534769] igb 0000:04:00.1: irq 89 for MSI/MSI-X
[    2.534776] igb 0000:04:00.1: irq 90 for MSI/MSI-X
[    2.534783] igb 0000:04:00.1: irq 91 for MSI/MSI-X
[    2.534790] igb 0000:04:00.1: irq 92 for MSI/MSI-X
[    2.534797] igb 0000:04:00.1: irq 93 for MSI/MSI-X
[    2.581429] igb 0000:04:00.1: irq 85 for MSI/MSI-X
[    2.581442] igb 0000:04:00.1: irq 86 for MSI/MSI-X
[    2.581454] igb 0000:04:00.1: irq 87 for MSI/MSI-X
[    2.581466] igb 0000:04:00.1: irq 88 for MSI/MSI-X
[    2.581486] igb 0000:04:00.1: irq 89 for MSI/MSI-X
[    2.581493] igb 0000:04:00.1: irq 90 for MSI/MSI-X
[    2.581500] igb 0000:04:00.1: irq 91 for MSI/MSI-X
[    2.581507] igb 0000:04:00.1: irq 92 for MSI/MSI-X
[    2.581514] igb 0000:04:00.1: irq 93 for MSI/MSI-X
[    2.662017] igb 0000:04:00.1: added PHC on eth1
[    2.662023] igb 0000:04:00.1: Intel(R) Gigabit Ethernet Network
Connection
[    2.662027] igb 0000:04:00.1: eth1: (PCIe:5.0Gb/s:Width x4)
a0:36:9f:a5:1c:49
[    2.662320] igb 0000:04:00.1: eth1: PBA No: H47822-001
[    2.662323] igb 0000:04:00.1: Using MSI-X interrupts. 8 rx queue(s), 8
tx queue(s)
[    2.662647] igb 0000:04:00.2: irq 94 for MSI/MSI-X
[    2.662657] igb 0000:04:00.2: irq 95 for MSI/MSI-X
[    2.662664] igb 0000:04:00.2: irq 96 for MSI/MSI-X
[    2.662672] igb 0000:04:00.2: irq 97 for MSI/MSI-X
[    2.662679] igb 0000:04:00.2: irq 98 for MSI/MSI-X
[    2.662688] igb 0000:04:00.2: irq 99 for MSI/MSI-X
[    2.662696] igb 0000:04:00.2: irq 100 for MSI/MSI-X
[    2.662703] igb 0000:04:00.2: irq 101 for MSI/MSI-X
[    2.662711] igb 0000:04:00.2: irq 102 for MSI/MSI-X
[    2.709381] igb 0000:04:00.2: irq 94 for MSI/MSI-X
[    2.709396] igb 0000:04:00.2: irq 95 for MSI/MSI-X
[    2.709409] igb 0000:04:00.2: irq 96 for MSI/MSI-X
[    2.709422] igb 0000:04:00.2: irq 97 for MSI/MSI-X
[    2.709435] igb 0000:04:00.2: irq 98 for MSI/MSI-X
[    2.709448] igb 0000:04:00.2: irq 99 for MSI/MSI-X
[    2.709461] igb 0000:04:00.2: irq 100 for MSI/MSI-X
[    2.709485] igb 0000:04:00.2: irq 101 for MSI/MSI-X
[    2.709493] igb 0000:04:00.2: irq 102 for MSI/MSI-X
[    2.773207] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.773250] ata4: SATA link down (SStatus 0 SControl 300)
[    2.773298] ata2: SATA link down (SStatus 0 SControl 300)
[    2.773334] ata3: SATA link down (SStatus 0 SControl 300)
[    2.773371] ata6: SATA link down (SStatus 0 SControl 300)
[    2.773409] ata5: SATA link down (SStatus 0 SControl 300)
[    2.773785] ata1.00: ATA-10: ST2000VN0001-1SF174, AN02, max UDMA/133
[    2.773790] ata1.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth
31/32), AA
[    2.774311] ata1.00: configured for UDMA/133
[    2.774537] scsi 0:0:0:0: Direct-Access     ATA      ST2000VN0001-1SF
AN02 PQ: 0 ANSI: 5
[    2.782892] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00
TB/1.81 TiB)
[    2.782903] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    2.783103] sd 0:0:0:0: [sda] Write Protect is off
[    2.783110] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.783171] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    2.786313]  sda: sda1 sda2
[    2.786881] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.788132] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.790775] igb 0000:04:00.2: added PHC on eth2
[    2.790783] igb 0000:04:00.2: Intel(R) Gigabit Ethernet Network
Connection
[    2.790789] igb 0000:04:00.2: eth2: (PCIe:5.0Gb/s:Width x4)
a0:36:9f:a5:1c:4a
[    2.791087] igb 0000:04:00.2: eth2: PBA No: H47822-001
[    2.791091] igb 0000:04:00.2: Using MSI-X interrupts. 8 rx queue(s), 8
tx queue(s)
[    2.791517] igb 0000:04:00.3: irq 103 for MSI/MSI-X
[    2.791529] igb 0000:04:00.3: irq 104 for MSI/MSI-X
[    2.791537] igb 0000:04:00.3: irq 105 for MSI/MSI-X
[    2.791545] igb 0000:04:00.3: irq 106 for MSI/MSI-X
[    2.791554] igb 0000:04:00.3: irq 107 for MSI/MSI-X
[    2.791562] igb 0000:04:00.3: irq 108 for MSI/MSI-X
[    2.791570] igb 0000:04:00.3: irq 109 for MSI/MSI-X
[    2.791578] igb 0000:04:00.3: irq 110 for MSI/MSI-X
[    2.791586] igb 0000:04:00.3: irq 111 for MSI/MSI-X
[    2.837363] igb 0000:04:00.3: irq 103 for MSI/MSI-X
[    2.837374] igb 0000:04:00.3: irq 104 for MSI/MSI-X
[    2.837383] igb 0000:04:00.3: irq 105 for MSI/MSI-X
[    2.837391] igb 0000:04:00.3: irq 106 for MSI/MSI-X
[    2.837398] igb 0000:04:00.3: irq 107 for MSI/MSI-X
[    2.837406] igb 0000:04:00.3: irq 108 for MSI/MSI-X
[    2.837414] igb 0000:04:00.3: irq 109 for MSI/MSI-X
[    2.837422] igb 0000:04:00.3: irq 110 for MSI/MSI-X
[    2.837430] igb 0000:04:00.3: irq 111 for MSI/MSI-X
[    2.917965] igb 0000:04:00.3: added PHC on eth3
[    2.917969] igb 0000:04:00.3: Intel(R) Gigabit Ethernet Network
Connection
[    2.917974] igb 0000:04:00.3: eth3: (PCIe:5.0Gb/s:Width x4)
a0:36:9f:a5:1c:4b
[    2.918265] igb 0000:04:00.3: eth3: PBA No: H47822-001
[    2.918268] igb 0000:04:00.3: Using MSI-X interrupts. 8 rx queue(s), 8
tx queue(s)
[    2.918600] igb 0000:05:00.0: irq 112 for MSI/MSI-X
[    2.918610] igb 0000:05:00.0: irq 113 for MSI/MSI-X
[    2.918619] igb 0000:05:00.0: irq 114 for MSI/MSI-X
[    2.918627] igb 0000:05:00.0: irq 115 for MSI/MSI-X
[    2.918635] igb 0000:05:00.0: irq 116 for MSI/MSI-X
[    2.918643] igb 0000:05:00.0: irq 117 for MSI/MSI-X
[    2.918651] igb 0000:05:00.0: irq 118 for MSI/MSI-X
[    2.918659] igb 0000:05:00.0: irq 119 for MSI/MSI-X
[    2.918667] igb 0000:05:00.0: irq 120 for MSI/MSI-X
[    2.965280] igb 0000:05:00.0: irq 112 for MSI/MSI-X
[    2.965289] igb 0000:05:00.0: irq 113 for MSI/MSI-X
[    2.965297] igb 0000:05:00.0: irq 114 for MSI/MSI-X
[    2.965306] igb 0000:05:00.0: irq 115 for MSI/MSI-X
[    2.965313] igb 0000:05:00.0: irq 116 for MSI/MSI-X
[    2.965321] igb 0000:05:00.0: irq 117 for MSI/MSI-X
[    2.965329] igb 0000:05:00.0: irq 118 for MSI/MSI-X
[    2.965337] igb 0000:05:00.0: irq 119 for MSI/MSI-X
[    2.965345] igb 0000:05:00.0: irq 120 for MSI/MSI-X
[    3.046147] igb 0000:05:00.0: added PHC on eth4
[    3.046152] igb 0000:05:00.0: Intel(R) Gigabit Ethernet Network
Connection
[    3.046157] igb 0000:05:00.0: eth4: (PCIe:5.0Gb/s:Width x4)
a0:36:9f:b0:76:58
[    3.046451] igb 0000:05:00.0: eth4: PBA No: H47822-001
[    3.046454] igb 0000:05:00.0: Using MSI-X interrupts. 8 rx queue(s), 8
tx queue(s)
[    3.046780] igb 0000:05:00.1: irq 121 for MSI/MSI-X
[    3.046790] igb 0000:05:00.1: irq 122 for MSI/MSI-X
[    3.046798] igb 0000:05:00.1: irq 123 for MSI/MSI-X
[    3.046806] igb 0000:05:00.1: irq 124 for MSI/MSI-X
[    3.046814] igb 0000:05:00.1: irq 125 for MSI/MSI-X
[    3.046823] igb 0000:05:00.1: irq 126 for MSI/MSI-X
[    3.046831] igb 0000:05:00.1: irq 127 for MSI/MSI-X
[    3.046842] igb 0000:05:00.1: irq 128 for MSI/MSI-X
[    3.046850] igb 0000:05:00.1: irq 129 for MSI/MSI-X
[    3.093149] igb 0000:05:00.1: irq 121 for MSI/MSI-X
[    3.093158] igb 0000:05:00.1: irq 122 for MSI/MSI-X
[    3.093166] igb 0000:05:00.1: irq 123 for MSI/MSI-X
[    3.093173] igb 0000:05:00.1: irq 124 for MSI/MSI-X
[    3.093181] igb 0000:05:00.1: irq 125 for MSI/MSI-X
[    3.093189] igb 0000:05:00.1: irq 126 for MSI/MSI-X
[    3.093197] igb 0000:05:00.1: irq 127 for MSI/MSI-X
[    3.093206] igb 0000:05:00.1: irq 128 for MSI/MSI-X
[    3.093214] igb 0000:05:00.1: irq 129 for MSI/MSI-X
[    3.173878] igb 0000:05:00.1: added PHC on eth5
[    3.173884] igb 0000:05:00.1: Intel(R) Gigabit Ethernet Network
Connection
[    3.173888] igb 0000:05:00.1: eth5: (PCIe:5.0Gb/s:Width x4)
a0:36:9f:b0:76:59
[    3.174182] igb 0000:05:00.1: eth5: PBA No: H47822-001
[    3.174185] igb 0000:05:00.1: Using MSI-X interrupts. 8 rx queue(s), 8
tx queue(s)
[    3.174526] igb 0000:05:00.2: irq 130 for MSI/MSI-X
[    3.174537] igb 0000:05:00.2: irq 131 for MSI/MSI-X
[    3.174545] igb 0000:05:00.2: irq 132 for MSI/MSI-X
[    3.174554] igb 0000:05:00.2: irq 133 for MSI/MSI-X
[    3.174562] igb 0000:05:00.2: irq 134 for MSI/MSI-X
[    3.174571] igb 0000:05:00.2: irq 135 for MSI/MSI-X
[    3.174579] igb 0000:05:00.2: irq 136 for MSI/MSI-X
[    3.174587] igb 0000:05:00.2: irq 137 for MSI/MSI-X
[    3.174596] igb 0000:05:00.2: irq 138 for MSI/MSI-X
[    3.221123] igb 0000:05:00.2: irq 130 for MSI/MSI-X
[    3.221138] igb 0000:05:00.2: irq 131 for MSI/MSI-X
[    3.221151] igb 0000:05:00.2: irq 132 for MSI/MSI-X
[    3.221175] igb 0000:05:00.2: irq 133 for MSI/MSI-X
[    3.221183] igb 0000:05:00.2: irq 134 for MSI/MSI-X
[    3.221191] igb 0000:05:00.2: irq 135 for MSI/MSI-X
[    3.221199] igb 0000:05:00.2: irq 136 for MSI/MSI-X
[    3.221206] igb 0000:05:00.2: irq 137 for MSI/MSI-X
[    3.221215] igb 0000:05:00.2: irq 138 for MSI/MSI-X
[    3.285214] Switched to clocksource tsc
[    3.301915] igb 0000:05:00.2: added PHC on eth6
[    3.301921] igb 0000:05:00.2: Intel(R) Gigabit Ethernet Network
Connection
[    3.301928] igb 0000:05:00.2: eth6: (PCIe:5.0Gb/s:Width x4)
a0:36:9f:b0:76:5a
[    3.302224] igb 0000:05:00.2: eth6: PBA No: H47822-001
[    3.302226] igb 0000:05:00.2: Using MSI-X interrupts. 8 rx queue(s), 8
tx queue(s)
[    3.302561] igb 0000:05:00.3: irq 139 for MSI/MSI-X
[    3.302572] igb 0000:05:00.3: irq 140 for MSI/MSI-X
[    3.302581] igb 0000:05:00.3: irq 141 for MSI/MSI-X
[    3.302589] igb 0000:05:00.3: irq 142 for MSI/MSI-X
[    3.302598] igb 0000:05:00.3: irq 143 for MSI/MSI-X
[    3.302606] igb 0000:05:00.3: irq 144 for MSI/MSI-X
[    3.302614] igb 0000:05:00.3: irq 145 for MSI/MSI-X
[    3.302623] igb 0000:05:00.3: irq 146 for MSI/MSI-X
[    3.302632] igb 0000:05:00.3: irq 147 for MSI/MSI-X
[    3.349066] igb 0000:05:00.3: irq 139 for MSI/MSI-X
[    3.349078] igb 0000:05:00.3: irq 140 for MSI/MSI-X
[    3.349087] igb 0000:05:00.3: irq 141 for MSI/MSI-X
[    3.349096] igb 0000:05:00.3: irq 142 for MSI/MSI-X
[    3.349104] igb 0000:05:00.3: irq 143 for MSI/MSI-X
[    3.349113] igb 0000:05:00.3: irq 144 for MSI/MSI-X
[    3.349121] igb 0000:05:00.3: irq 145 for MSI/MSI-X
[    3.349130] igb 0000:05:00.3: irq 146 for MSI/MSI-X
[    3.349138] igb 0000:05:00.3: irq 147 for MSI/MSI-X
[    3.429781] igb 0000:05:00.3: added PHC on eth7
[    3.429788] igb 0000:05:00.3: Intel(R) Gigabit Ethernet Network
Connection
[    3.429792] igb 0000:05:00.3: eth7: (PCIe:5.0Gb/s:Width x4)
a0:36:9f:b0:76:5b
[    3.430087] igb 0000:05:00.3: eth7: PBA No: H47822-001
[    3.430090] igb 0000:05:00.3: Using MSI-X interrupts. 8 rx queue(s), 8
tx queue(s)
[    3.430604] igb 0000:08:00.0: irq 148 for MSI/MSI-X
[    3.430615] igb 0000:08:00.0: irq 149 for MSI/MSI-X
[    3.430623] igb 0000:08:00.0: irq 150 for MSI/MSI-X
[    3.430632] igb 0000:08:00.0: irq 151 for MSI/MSI-X
[    3.430640] igb 0000:08:00.0: irq 152 for MSI/MSI-X
[    3.466342] igb 0000:08:00.0: added PHC on eth8
[    3.466346] igb 0000:08:00.0: Intel(R) Gigabit Ethernet Network
Connection
[    3.466352] igb 0000:08:00.0: eth8: (PCIe:2.5Gb/s:Width x1)
0c:c4:7a:d8:84:08
[    3.466399] igb 0000:08:00.0: eth8: PBA No: 012000-000
[    3.466403] igb 0000:08:00.0: Using MSI-X interrupts. 4 rx queue(s), 4
tx queue(s)
[    3.466903] igb 0000:09:00.0: irq 153 for MSI/MSI-X
[    3.466914] igb 0000:09:00.0: irq 154 for MSI/MSI-X
[    3.466923] igb 0000:09:00.0: irq 155 for MSI/MSI-X
[    3.466932] igb 0000:09:00.0: irq 156 for MSI/MSI-X
[    3.466940] igb 0000:09:00.0: irq 157 for MSI/MSI-X
[    3.509774] igb 0000:09:00.0: added PHC on eth9
[    3.509780] igb 0000:09:00.0: Intel(R) Gigabit Ethernet Network
Connection
[    3.509784] igb 0000:09:00.0: eth9: (PCIe:2.5Gb/s:Width x1)
0c:c4:7a:d8:84:09
[    3.509834] igb 0000:09:00.0: eth9: PBA No: 011000-000
[    3.509837] igb 0000:09:00.0: Using MSI-X interrupts. 4 rx queue(s), 4
tx queue(s)
[    3.654308] EXT4-fs (sda1): mounted filesystem with ordered data mode.
Opts: (null)
[    3.941984] systemd[1]: systemd 215 running in system mode. (+PAM +AUDIT
+SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPARMOR)
[    3.942267] systemd[1]: Detected architecture 'x86-64'.
[    4.042100] systemd[1]: Inserted module 'autofs4'
[    4.046063] systemd[1]: Set hostname to <GW2>.
[    4.401913] systemd[1]: Cannot add dependency job for unit
display-manager.service, ignoring: Unit display-manager.service failed to
load: No such file or directory.
[    4.402154] systemd[1]: Starting Forward Password Requests to Wall
Directory Watch.
[    4.402223] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[    4.402235] systemd[1]: Starting Remote File Systems (Pre).
[    4.402262] systemd[1]: Reached target Remote File Systems (Pre).
[    4.402277] systemd[1]: Starting Dispatch Password Requests to Console
Directory Watch.
[    4.402309] systemd[1]: Started Dispatch Password Requests to Console
Directory Watch.
[    4.402342] systemd[1]: Starting Arbitrary Executable File Formats File
System Automount Point.
[    4.402453] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[    4.402467] systemd[1]: Starting Encrypted Volumes.
[    4.402476] systemd[1]: Reached target Encrypted Volumes.
[    4.402483] systemd[1]: Starting Swap.
[    4.402491] systemd[1]: Reached target Swap.
[    4.402498] systemd[1]: Starting Root Slice.
[    4.402519] systemd[1]: Created slice Root Slice.
[    4.402527] systemd[1]: Starting User and Session Slice.
[    4.402560] systemd[1]: Created slice User and Session Slice.
[    4.402568] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    4.402613] systemd[1]: Listening on /dev/initctl Compatibility Named
Pipe.
[    4.402622] systemd[1]: Starting Delayed Shutdown Socket.
[    4.402649] systemd[1]: Listening on Delayed Shutdown Socket.
[    4.402656] systemd[1]: Starting Journal Socket (/dev/log).
[    4.402689] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.402701] systemd[1]: Starting udev Control Socket.
[    4.402724] systemd[1]: Listening on udev Control Socket.
[    4.402734] systemd[1]: Starting udev Kernel Socket.
[    4.402754] systemd[1]: Listening on udev Kernel Socket.
[    4.402764] systemd[1]: Starting Journal Socket.
[    4.402797] systemd[1]: Listening on Journal Socket.
[    4.402813] systemd[1]: Starting System Slice.
[    4.402848] systemd[1]: Created slice System Slice.
[    4.402862] systemd[1]: Started File System Check on Root Device.
[    4.402868] systemd[1]: Starting system-getty.slice.
[    4.402908] systemd[1]: Created slice system-getty.slice.
[    4.402935] systemd[1]: Starting Increase datagram queue length...
[    4.403755] systemd[1]: Mounting Debug File System...
[    4.405021] systemd[1]: Starting udev Coldplug all Devices...
[    4.407873] systemd[1]: Started Set Up Additional Binary Formats.
[    4.407928] systemd[1]: Mounting Huge Pages File System...
[    4.409439] systemd[1]: Starting Load Kernel Modules...
[    4.410279] systemd[1]: Starting Create list of required static device
nodes for the current kernel...
[    4.411563] systemd[1]: Mounting POSIX Message Queue File System...
[    4.412699] systemd[1]: Starting Slices.
[    4.412728] systemd[1]: Reached target Slices.
[    4.475232] systemd[1]: Started Load Kernel Modules.
[    4.475527] systemd[1]: Mounted FUSE Control File System.
[    4.475609] systemd[1]: Mounted Configuration File System.
[    4.475626] systemd[1]: Starting Apply Kernel Variables...
[    4.495352] systemd[1]: Started Increase datagram queue length.
[    4.495487] systemd[1]: Starting Syslog Socket.
[    4.495524] systemd[1]: Listening on Syslog Socket.
[    4.495543] systemd[1]: Starting Journal Service...
[    4.496688] systemd[1]: Started Journal Service.
[    4.658853] systemd-udevd[236]: starting version 215
[    4.920775] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    5.031216] ipmi message handler version 39.2
[    5.033517] IPMI System Interface driver.
[    5.033812] ipmi_si: probing via ACPI
[    5.033853] ipmi_si 00:08: [io  0x0ca2] regsize 1 spacing 1 irq 0
[    5.033861] ipmi_si: Adding ACPI-specified kcs state machine
[    5.033923] ipmi_si: probing via SMBIOS
[    5.033931] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[    5.033939] ipmi_si: Adding SMBIOS-specified kcs state machine duplicate
interface
[    5.033951] ipmi_si: probing via SPMI
[    5.033958] ipmi_si: SPMI: io 0xca2 regsize 1 spacing 1 irq 0
[    5.033964] ipmi_si: Adding SPMI-specified kcs state machine duplicate
interface
[    5.033973] ipmi_si: Trying ACPI-specified kcs state machine at i/o
address 0xca2, slave address 0x0, irq 0
[    5.073120] power_meter ACPI000D:00: Found ACPI power meter.
[    5.073357] power_meter ACPI000D:00: Ignoring unsafe software power cap!
[    5.074021] input: Power Button as
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[    5.074034] ACPI: Power Button [PWRB]
[    5.074441] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    5.074450] ACPI: Power Button [PWRF]
[    5.078552] random: nonblocking pool is initialized
[    5.133556] wmi: Mapper loaded
[    5.184117] [drm] Initialized drm 1.1.0 20060810
[    5.188028] microcode: CPU0 sig=0x306f2, pf=0x1, revision=0x36
[    5.194346] i801_smbus 0000:00:1f.3: SMBus using PCI Interrupt
[    5.205068] microcode: CPU1 sig=0x306f2, pf=0x1, revision=0x36
[    5.205096] microcode: CPU2 sig=0x306f2, pf=0x1, revision=0x36
[    5.205134] microcode: CPU3 sig=0x306f2, pf=0x1, revision=0x36
[    5.205176] microcode: CPU4 sig=0x306f2, pf=0x1, revision=0x36
[    5.205216] microcode: CPU5 sig=0x306f2, pf=0x1, revision=0x36
[    5.205258] microcode: CPU6 sig=0x306f2, pf=0x1, revision=0x36
[    5.205291] microcode: CPU7 sig=0x306f2, pf=0x1, revision=0x36
[    5.205323] microcode: CPU8 sig=0x306f2, pf=0x1, revision=0x36
[    5.205351] microcode: CPU9 sig=0x306f2, pf=0x1, revision=0x36
[    5.205468] microcode: Microcode Update Driver: v2.00 <
tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    5.231232]
*** RTnet for Xenomai v3.0.2 ***

[    5.231237] RTnet: initialising real-time networking
[    5.256055] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
[    5.256059] mei_me 0000:00:16.0: initialization failed.
[    5.256791] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    5.352682] systemd-journald[219]: Received request to flush runtime
journal from PID 1
[    5.369411] ACPI Warning: SystemIO range
0x0000000000000428-0x000000000000042F conflicts with OpRegion
0x0000000000000428-0x000000000000042F (\GPE0) (20131218/utaddress-254)
[    5.369420] ACPI: If an ACPI driver is available for this device, you
should use it instead of the native driver
[    5.369425] ACPI Warning: SystemIO range
0x0000000000000500-0x000000000000052F conflicts with OpRegion
0x000000000000052C-0x000000000000052D (\GPIV) (20131218/utaddress-254)
[    5.369432] ACPI: If an ACPI driver is available for this device, you
should use it instead of the native driver
[    5.369468] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    5.377506] iTCO_vendor_support: vendor-support=0
[    5.386058] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
[    5.386097] iTCO_wdt: Found a Wellsburg TCO device (Version=2,
TCOBASE=0x0460)
[    5.386274] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    5.501986] rt_igb: Intel(R) Gigabit Ethernet Network Driver - version
5.2.18-k
[    5.501990] rt_igb: Copyright (c) 2007-2014 Intel Corporation.
[    5.574684] systemd-udevd[267]: renamed network interface eth5 to rename7
[    5.583890] systemd-udevd[271]: renamed network interface eth2 to rename4
[    5.587963] [drm] AST 2300 detected
[    5.587980] [drm] dram 1632000000 1 16 01000000
[    5.588094] [TTM] Zone  kernel: Available graphics memory: 8166452 kiB
[    5.588096] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    5.588097] [TTM] Initializing pool allocator
[    5.588104] [TTM] Initializing DMA pool allocator
[    5.592577] fbcon: astdrmfb (fb0) is primary device
[    5.611647] ipmi_si 00:08: Found new BMC (man_id: 0x002a7c, prod_id:
0x0832, dev_id: 0x20)
[    5.613057] ipmi_si 00:08: IPMI kcs interface initialized
[    5.616103] systemd-udevd[274]: renamed network interface eth8 to eth99
[    5.617351] AVX2 version of gcm_enc/dec engaged.
[    5.622148] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[    5.641486] Console: switching to colour frame buffer device 128x48
[    5.643730] alg: No test for crc32 (crc32-pclmul)
[    5.648025] systemd-udevd[256]: renamed network interface eth7 to rename9
[    5.666174] ast 0000:0b:00.0: fb0: astdrmfb frame buffer device
[    5.666177] ast 0000:0b:00.0: registered panic notifier
[    5.666181] [drm] Initialized ast 0.1.0 20120228 for 0000:0b:00.0 on
minor 0
[    5.679897] systemd-udevd[250]: renamed network interface eth1 to rename3
[    5.723879] systemd-udevd[253]: renamed network interface eth3 to eth8
[    5.743827] systemd-udevd[255]: renamed network interface eth6 to eth3
[    5.767859] systemd-udevd[245]: renamed network interface eth0 to eth5
[    5.803886] systemd-udevd[273]: renamed network interface eth9 to eth0
[    5.825890] systemd-udevd[249]: renamed network interface eth4 to eth1
[    5.851848] systemd-udevd[267]: renamed network interface eth5 to eth2
[    5.883922] systemd-udevd[271]: renamed network interface eth2 to eth7
[    5.892020] systemd-udevd[256]: renamed network interface eth7 to eth4
[    5.915851] systemd-udevd[250]: renamed network interface eth1 to eth6
[    7.052332] IPv6: ADDRCONF(NETDEV_UP): eth99: link is not ready
[    9.914622] igb: eth99 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: RX
[    9.915020] IPv6: ADDRCONF(NETDEV_CHANGE): eth99: link becomes ready
[   15.348296] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   15.465070] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   15.580986] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[   15.700894] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   15.820834] IPv6: ADDRCONF(NETDEV_UP): eth4: link is not ready
[   15.940770] IPv6: ADDRCONF(NETDEV_UP): eth5: link is not ready
[   16.060724] IPv6: ADDRCONF(NETDEV_UP): eth6: link is not ready
[   16.180641] IPv6: ADDRCONF(NETDEV_UP): eth7: link is not ready
[   16.300600] IPv6: ADDRCONF(NETDEV_UP): eth8: link is not ready
[   18.062541] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: RX/TX
[   18.062935] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[87757.586664] RTnet: unloaded
[87758.616480]
*** RTnet for Xenomai v3.0.2 ***

[87758.616488] RTnet: initialising real-time networking
[87758.634402] rt_igb: Intel(R) Gigabit Ethernet Network Driver - version
5.2.18-k
[87758.634406] rt_igb: Copyright (c) 2007-2014 Intel Corporation.
[87758.635159] igb 0000:09:00.0: removed PHC on eth0
[87758.708382] rt_igb 0000:09:00.0: irq 153 for MSI/MSI-X
[87758.708404] rt_igb 0000:09:00.0: irq 154 for MSI/MSI-X
[87758.788335] RTnet: registered rteth0
[87758.788344] rt_igb 0000:09:00.0: Intel(R) Gigabit Ethernet Network
Connection
[87758.788350] rt_igb 0000:09:00.0: rteth0: (PCIe:2.5Gb/s:Width x1)
0c:c4:7a:d8:84:09
[87758.788413] rt_igb 0000:09:00.0: rteth0: PBA No: 011000-000
[87758.788415] rt_igb 0000:09:00.0: Using MSI-X interrupts. 1 rx queue(s),
1 tx queue(s)
[87758.788752] igb 0000:05:00.0: removed PHC on eth1
[87758.883549] rt_igb 0000:05:00.0: irq 112 for MSI/MSI-X
[87758.883561] rt_igb 0000:05:00.0: irq 113 for MSI/MSI-X
[87759.009973] RTnet: registered rteth1
[87759.010056] ------------[ cut here ]------------
[87759.010063] WARNING: CPU: 7 PID: 1999 at include/linux/kref.h:47
kobject_get+0x64/0xb0()
[87759.010065] Modules linked in: rt_igb rtipv4 rtnet x86_pkg_temp_thermal
coretemp crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel
aes_x86_64 ast lrw ttm gf128mul glue_helper ablk_helper iTCO_wdt
iTCO_vendor_support lpc_ich cryptd drm_kms_helper mei_me evdev mfd_core
i2c_i801 microcode drm syscopyarea sysfillrect sysimgblt tpm_tis mei wmi
tpm ipmi_si ipmi_msghandler button acpi_power_meter processor shpchp
thermal_sys autofs4 ext4 crc16 mbcache jbd2 sg sd_mod crc_t10dif
crct10dif_generic crct10dif_pclmul crct10dif_common ahci libahci libata
scsi_mod igb i2c_algo_bit i2c_core ptp pps_core [last unloaded: rtnet]
[87759.010120] CPU: 7 PID: 1999 Comm: RTnet_init.sh Not tainted
3.14.44xenomai-debug #3
[87759.010122] Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0
12/17/2015
[87759.010124]  0000000000000009 ffffffff818240b2 0000000000000000
ffffffff8107b90f
[87759.010130]  ffff880463fdf030 ffff880463925500 0000000000000000
ffff880463fdf020
[87759.010134]  ffff880463fdf004 ffffffff8107b966 ffffffff81465034
ffff880463925510
[87759.010139] Call Trace:
[87759.010145]  [<ffffffff818240b2>] ? dump_stack+0x90/0xec
[87759.010151]  [<ffffffff8107b90f>] ? warn_slowpath_common+0xaf/0xe0
[87759.010155]  [<ffffffff8107b966>] ? warn_slowpath_null+0x26/0x30
[87759.010158]  [<ffffffff81465034>] ? kobject_get+0x64/0xb0
[87759.010164]  [<ffffffff815b9e33>] ? device_add+0x133/0xa90
[87759.010168]  [<ffffffff810e3864>] ? complete_all+0x54/0x70
[87759.010172]  [<ffffffff8109021f>] ? init_timer_key+0x4f/0x110
[87759.010175]  [<ffffffff815bac96>] ? device_register+0x26/0x30
[87759.010182]  [<ffffffffa00927d8>] ? i2c_new_device+0x218/0x3c0 [i2c_core]
[87759.010187]  [<ffffffffa05b48cd>] ? igb_sysfs_init+0xdd/0x240 [rt_igb]
[87759.010192]  [<ffffffffa05b8b45>] ? igb_probe+0x13a5/0x16c0 [rt_igb]
[87759.010197]  [<ffffffff814bd55d>] ? local_pci_probe+0x4d/0xe0
[87759.010200]  [<ffffffff814bef58>] ? pci_device_probe+0x158/0x1f0
[87759.010204]  [<ffffffff815bee46>] ? driver_probe_device+0xe6/0x5d0
[87759.010208]  [<ffffffff815bd469>] ? bind_store+0x179/0x1f0
[87759.010211]  [<ffffffff815bb8c1>] ? drv_attr_store+0x31/0x50
[87759.010216]  [<ffffffff81383c0e>] ? sysfs_kf_write+0x4e/0x70
[87759.010219]  [<ffffffff813895aa>] ? kernfs_fop_write+0x10a/0x1c0
[87759.010223]  [<ffffffff812d400f>] ? vfs_write+0xef/0x2c0
[87759.010227]  [<ffffffff812d4746>] ? SyS_write+0x66/0x120
[87759.010230]  [<ffffffff81301018>] ? __close_fd+0xc8/0x100
[87759.010234]  [<ffffffff8183b6ec>] ? system_call_fastpath+0x1a/0x1f
[87759.010236] ---[ end trace 7f21018c99fd5419 ]---
[87759.010244] BUG: unable to handle kernel NULL pointer dereference at
0000000000000018
[87759.010286] IP: [<ffffffff8146509d>] kobject_namespace+0x1d/0x90
[87759.010312] PGD 73f8e067 PUD 74902067 PMD 0
[87759.010333] Oops: 0000 [#1] PREEMPT SMP
[87759.010354] Modules linked in: rt_igb rtipv4 rtnet x86_pkg_temp_thermal
coretemp crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel
aes_x86_64 ast lrw ttm gf128mul glue_helper ablk_helper iTCO_wdt
iTCO_vendor_support lpc_ich cryptd drm_kms_helper mei_me evdev mfd_core
i2c_i801 microcode drm syscopyarea sysfillrect sysimgblt tpm_tis mei wmi
tpm ipmi_si ipmi_msghandler button acpi_power_meter processor shpchp
thermal_sys autofs4 ext4 crc16 mbcache jbd2 sg sd_mod crc_t10dif
crct10dif_generic crct10dif_pclmul crct10dif_common ahci libahci libata
scsi_mod igb i2c_algo_bit i2c_core ptp pps_core [last unloaded: rtnet]
[87759.010639] CPU: 7 PID: 1999 Comm: RTnet_init.sh Tainted: G        W
3.14.44xenomai-debug #3
[87759.010670] Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0
12/17/2015
[87759.010697] task: ffff88046448aa20 ti: ffff880036960000 task.ti:
ffff880036960000
[87759.010723] RIP: 0010:[<ffffffff8146509d>]  [<ffffffff8146509d>]
kobject_namespace+0x1d/0x90
[87759.010757] RSP: 0018:ffff880036963c48  EFLAGS: 00010206
[87759.010776] RAX: ffff880463925510 RBX: ffff880463fdf030 RCX:
0000000000000000
[87759.010801] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff880463fdf030
[87759.010826] RBP: ffff880463fdf030 R08: 0000000000000513 R09:
00000000000c51ae
[87759.010851] R10: 0000000000000004 R11: 0000000000000000 R12:
ffff880463925510
[87759.010876] R13: ffff880463fdf020 R14: ffff880463fdf004 R15:
0000000000000000
[87759.010902] FS:  00007f93e47b1700(0000) GS:ffff88047f300000(0000)
knlGS:0000000000000000
[87759.010930] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[87759.010951] CR2: 0000000000000018 CR3: 00000000748fb000 CR4:
00000000001407e0
[87759.010977] I-pipe domain Linux
[87759.010989] Stack:
[87759.010998]  ffffffff81465c89 7f21018c99fd5419 0000000000000000
0000000000000000
[87759.011031]  ffff880463fdf030 ffff880463925510 ffff880463fdf020
ffffffff81466407
[87759.011064]  ffff880463fdf030 ffff880036963cf0 0000000000000000
ffffffff81466514
[87759.011096] Call Trace:
[87759.011109]  [<ffffffff81465c89>] ? kobject_add_internal+0x189/0x700
[87759.011133]  [<ffffffff81466407>] ? kobject_add_varg+0x37/0x70
[87759.011156]  [<ffffffff81466514>] ? kobject_add+0x54/0xa0
[87759.011178]  [<ffffffff815b9e8f>] ? device_add+0x18f/0xa90
[87759.011200]  [<ffffffff810e3864>] ? complete_all+0x54/0x70
[87759.011221]  [<ffffffff8109021f>] ? init_timer_key+0x4f/0x110
[87759.011244]  [<ffffffff815bac96>] ? device_register+0x26/0x30
[87759.011271]  [<ffffffffa00927d8>] ? i2c_new_device+0x218/0x3c0 [i2c_core]
[87759.011299]  [<ffffffffa05b48cd>] ? igb_sysfs_init+0xdd/0x240 [rt_igb]
[87759.011325]  [<ffffffffa05b8b45>] ? igb_probe+0x13a5/0x16c0 [rt_igb]
[87759.011351]  [<ffffffff814bd55d>] ? local_pci_probe+0x4d/0xe0
[87759.011373]  [<ffffffff814bef58>] ? pci_device_probe+0x158/0x1f0
[87759.011398]  [<ffffffff815bee46>] ? driver_probe_device+0xe6/0x5d0
[87759.011421]  [<ffffffff815bd469>] ? bind_store+0x179/0x1f0
[87759.011443]  [<ffffffff815bb8c1>] ? drv_attr_store+0x31/0x50
[87759.011465]  [<ffffffff81383c0e>] ? sysfs_kf_write+0x4e/0x70
[87759.011488]  [<ffffffff813895aa>] ? kernfs_fop_write+0x10a/0x1c0
[87759.012305]  [<ffffffff812d400f>] ? vfs_write+0xef/0x2c0
[87759.013118]  [<ffffffff812d4746>] ? SyS_write+0x66/0x120
[87759.013930]  [<ffffffff81301018>] ? __close_fd+0xc8/0x100
[87759.014724]  [<ffffffff8183b6ec>] ? system_call_fastpath+0x1a/0x1f
[87759.015502] Code: 83 05 c7 34 65 01 01 eb 8f 0f 1f 44 00 00 48 8b 47 18
48 83 05 d4 38 65 01 01 48 85 c0 74 5f 48 8b 50 28 48 83 05 cb 38 65 01 01
<48> 8b 52 18 48 85 d2 74 4a 48 83 05 c2 38 65 01 01 53 48 89 fb
[87759.017234] RIP  [<ffffffff8146509d>] kobject_namespace+0x1d/0x90
[87759.018047]  RSP <ffff880036963c48>
[87759.018830] CR2: 0000000000000018
[87759.039504] ---[ end trace 7f21018c99fd541a ]---
