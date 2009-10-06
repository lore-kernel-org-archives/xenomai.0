Message-ID: <4ACB6332.8010904@domain.hid>
Date: Tue, 06 Oct 2009 17:33:06 +0200
From: Roman Pisl <rpisl@domain.hid>
MIME-Version: 1.0
References: <4AC5E895.8010107@domain.hid>
	<4AC5F49E.3070608@domain.hid>	<4AC5FEAD.7000608@domain.hid>
	<4AC77576.9070700@domain.hid>	<4AC9E655.5090006@domain.hid>
	<4AC9ED6B.4050004@domain.hid>	<4AC9F4FA.5070409@domain.hid>
	<4ACA013F.8040602@domain.hid> <4ACB4389.10109@domain.hid>
	<4ACB4C70.80406@domain.hid>
In-Reply-To: <4ACB4C70.80406@domain.hid>
Content-Type: multipart/mixed; boundary="------------080500090604080700030008"
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
--------------080500090604080700030008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 6.10.2009 15:56, Jan Kiszka wrote:
> Roman Pisl wrote:
>> ...
>>>
>>> Is there a chance to grab the panic log via serial line? The first of
>>> your two screenshots indicate that there might have happened something
>>> interesting before the NMI triggered, but it's scrolled out of sight.
>>>
>>> Jan
>>>
>>
>> Hello,
>> here I send kernel panic (triggered by rt_task_sleep and latency test)
>> grabbed via serial line.
>
> Hmm, still only NMI alarms...
>
>>
>> I'm ready to help with resolving this issue.
>
> Could you try enabling the I-pipe tracer with function tracing? It
> should dump a trace of the functions that were executed before the
> watchdog triggered. You may need to extend the number of tracepoints a
> bit, try "echo 1000>  /proc/ipipe/trace/back_trace_points".
>
> Jan
>

After trying for a while, I managed to get this.

Roman

--------------080500090604080700030008
Content-Type: text/plain;
 name="panic.rt_task_sleep.ipipe"
Content-Disposition: attachment;
 filename="panic.rt_task_sleep.ipipe"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.31.1-xenomai-i2.4-06 (root@domain.hid) (gcc=
 version 4.4.1 (Gentoo 4.4.1 p1.0) ) #7 SMP Tue Oct 6 17:10:50 CEST 2009
[    0.000000] Command line: root=3D/dev/sda3 nmi_watchdog=3D2 console=3D=
ttyS0,115200 kernel.ftrace_dump_on_oops=3D1
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cd9ffc00 (usable)
[    0.000000]  BIOS-e820: 00000000cd9ffc00 - 00000000cda53c00 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cda53c00 - 00000000cda55c00 (ACPI data=
)
[    0.000000]  BIOS-e820: 00000000cda55c00 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000128000000 (usable)
[    0.000000] DMI 2.5 present.
[    0.000000] last_pfn =3D 0x128000 max_arch_pfn =3D 0x400000000
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600=
070106
[    0.000000] last_pfn =3D 0xcd9ff max_arch_pfn =3D 0x400000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000cd9ff000
[    0.000000] init_memory_mapping: 0000000100000000-0000000128000000
[    0.000000] ACPI: RSDP 00000000000fec00 00024 (v02 DELL  )
[    0.000000] ACPI: XSDT 00000000000fc7cb 00074 (v01 DELL    B10K    000=
00015 ASL  00000061)
[    0.000000] ACPI: FACP 00000000000fc8fb 000F4 (v03 DELL    B10K    000=
00015 ASL  00000061)
[    0.000000] ACPI: DSDT 00000000ffe9cff8 054AD (v01   DELL    dt_ex 000=
01000 INTL 20050624)
[    0.000000] ACPI: FACS 00000000cd9ffc00 00040
[    0.000000] ACPI: SSDT 00000000ffea25c4 000AA (v01   DELL    st_ex 000=
01000 INTL 20050624)
[    0.000000] ACPI: APIC 00000000000fc9ef 00092 (v01 DELL    B10K    000=
00015 ASL  00000061)
[    0.000000] ACPI: BOOT 00000000000fca81 00028 (v01 DELL    B10K    000=
00015 ASL  00000061)
[    0.000000] ACPI: ASF! 00000000000fcaa9 00096 (v32 DELL    B10K    000=
00015 ASL  00000061)
[    0.000000] ACPI: MCFG 00000000000fcb3f 0003E (v01 DELL    B10K    000=
00015 ASL  00000061)
[    0.000000] ACPI: HPET 00000000000fcb7d 00038 (v01 DELL    B10K    000=
00015 ASL  00000061)
[    0.000000] ACPI: TCPA 00000000000fcdd9 00032 (v01 DELL    B10K    000=
00015 ASL  00000061)
[    0.000000] ACPI: DMAR 00000000000fce0b 00120 (v01 DELL    B10K    000=
00015 ASL  00000061)
[    0.000000] ACPI: SLIC 00000000000fcbb5 00176 (v01 DELL    B10K    000=
00015 ASL  00000061)
[    0.000000] (7 early reservations) =3D=3D> bootmem [0000000000 - 01280=
00000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [0=
000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE =3D=3D> [0=
000006000 - 0000008000]
[    0.000000]   #2 [0001000000 - 0001cfc2d4]    TEXT DATA BSS =3D=3D> [0=
001000000 - 0001cfc2d4]
[    0.000000]   #3 [000009a000 - 0000100000]    BIOS reserved =3D=3D> [0=
00009a000 - 0000100000]
[    0.000000]   #4 [0001cfd000 - 0001cfd1f0]              BRK =3D=3D> [0=
001cfd000 - 0001cfd1f0]
[    0.000000]   #5 [0000008000 - 000000c000]          PGTABLE =3D=3D> [0=
000008000 - 000000c000]
[    0.000000]   #6 [000000c000 - 000000d000]          PGTABLE =3D=3D> [0=
00000c000 - 000000d000]
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
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI =
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level=
)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] 8 Processors exceeds NR_CPUS limit of 4
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] Allocating PCI resources starting at d0000000 (gap: d00000=
00:10000000)
[    0.000000] NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 1312 pages at ffff88002be00000, static da=
ta 5341408 bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal pages: 989291
[    0.000000] Kernel command line: root=3D/dev/sda3 nmi_watchdog=3D2 con=
sole=3DttyS0,115200 kernel.ftrace_dump_on_oops=3D1
[    0.000000] Unknown boot option `kernel.ftrace_dump_on_oops=3D1': igno=
ring
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 419430=
4 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 =
bytes)
[    0.000000] Initializing CPU#0
[    0.000000] xsave/xrstor: enabled xstate_bv 0x3, cntxt size 0x240
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.000000] Placing 64MB software IO TLB between ffff880020000000 - ff=
ff880024000000
[    0.000000] software IO TLB at phys 0x20000000 - 0x24000000
[    0.000000] Memory: 3859008k/4849664k available (4374k kernel code, 82=
5756k absent, 163992k reserved, 2164k data, 5556k init)
[    0.000000] SLUB: Genslabs=3D13, HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D4, Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:384
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2660.246 MHz processor.
[    0.000059] I-pipe 2.4-06: pipeline enabled.
[    0.003119] Console: colour VGA+ 80x25
[    0.003138] console [ttyS0] enabled
[    0.004000] HPET: 8 timers in total, 4 timers will be used for per-cpu=
 timer
[    0.004009] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 5320.49 BogoMIPS (lpj=3D10640984)
[    0.012036] Mount-cache hash table entries: 256
[    0.016176] Initializing cgroup subsys ns
[    0.020006] Initializing cgroup subsys cpuacct
[    0.024009] Initializing cgroup subsys freezer
[    0.028013] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.036004] CPU: L2 cache: 3072K
[    0.039208] CPU: Physical Processor ID: 0
[    0.040004] CPU: Processor Core ID: 0
[    0.044005] mce: CPU supports 6 MCE banks
[    0.048008] CPU0: Thermal monitoring enabled (TM2)
[    0.052005] Performance Counters: Core2 events, Intel PMU driver.
[    0.061654] ... version:                 2
[    0.064004] ... bit width:               40
[    0.068004] ... generic counters:        2
[    0.072004] ... value mask:              000000ffffffffff
[    0.076004] ... max period:              000000007fffffff
[    0.080004] ... fixed-purpose counters:  3
[    0.084004] ... counter mask:            0000000700000003
[    0.088015] Freeing SMP alternatives: 36k freed
[    0.092024] ACPI: Core revision 20090521
[    0.340009] ftrace: converting mcount calls to 0f 1f 44 00 00
[    0.344007] ftrace: allocating 21378 entries in 84 pages
[    0.363390] Setting APIC routing to flat
[    0.364326] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.368001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.368001] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.368001] ..... (found apic 0 pin 2) ...
[    0.409050] ....... works.
[    0.411737] CPU0: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz step=
ping 0a
[    0.420001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 5319.90 B=
ogoMIPS (lpj=3D10639816)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 3072K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] mce: CPU supports 6 MCE banks
[    0.004000] CPU1: Thermal monitoring enabled (TM2)
[    0.004000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600=
070106
[    0.509450] CPU1: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz step=
ping 0a
[    0.517228] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.520090] Booting processor 2 APIC 0x2 ip 0x6000
[    0.004000] Initializing CPU#2
[    0.004000] Calibrating delay using timer specific routine.. 5319.93 B=
ogoMIPS (lpj=3D10639868)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 3072K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 2
[    0.004000] mce: CPU supports 6 MCE banks
[    0.004000] CPU2: Thermal monitoring enabled (TM2)
[    0.004000] x86 PAT enabled: cpu 2, old 0x7040600070406, new 0x7010600=
070106
[    0.617633] CPU2: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz step=
ping 0a
[    0.628007] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    0.632071] Booting processor 3 APIC 0x3 ip 0x6000
[    0.004000] Initializing CPU#3
[    0.004000] Calibrating delay using timer specific routine.. 5319.92 B=
ogoMIPS (lpj=3D10639858)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 3072K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 3
[    0.004000] mce: CPU supports 6 MCE banks
[    0.004000] CPU3: Thermal monitoring enabled (TM2)
[    0.004000] x86 PAT enabled: cpu 3, old 0x7040600070406, new 0x7010600=
070106
[    0.729440] CPU3: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz step=
ping 0a
[    0.737227] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
[    0.740018] Brought up 4 CPUs
[    0.744006] Total of 4 processors activated (21280.26 BogoMIPS).
[    0.748040] Testing NMI watchdog ... OK.
[    0.836521] NET: Registered protocol family 16
[    0.844233] ACPI FADT declares the system doesn't support PCIe ASPM, s=
o disable it
[    0.848027] ACPI: bus type pci registered
[    0.852026] PCI: Using configuration type 1 for base access
[    0.900308] bio: create slab <bio-0> at 0
[    1.053800] ACPI: BIOS _OSI(Linux) query ignored
[    1.103303] ACPI: Interpreter enabled
[    1.104020] ACPI: (supports S0 S5)
[    1.108665] ACPI: Using IOAPIC for interrupt routing
[    1.316858] ACPI Warning: Incorrect checksum in table [TCPA] - 00, sho=
uld be 7F 20090521 tbutils-246
[    1.333260] ACPI: ACPI Dock Station Driver: 1 docks/bays found
[    1.352061] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    1.357248] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.360036] pci 0000:00:03.0: PME# disabled
[    1.365474] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    1.368031] pci 0000:00:19.0: PME# disabled
[    1.373311] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    1.376029] pci 0000:00:1a.7: PME# disabled
[    1.380366] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.384032] pci 0000:00:1b.0: PME# disabled
[    1.388268] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.392028] pci 0000:00:1c.0: PME# disabled
[    1.396265] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.400032] pci 0000:00:1c.1: PME# disabled
[    1.409378] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    1.412032] pci 0000:00:1d.7: PME# disabled
[    1.420740] pci 0000:00:1f.2: PME# supported from D3hot
[    1.424028] pci 0000:00:1f.2: PME# disabled
[    1.429294] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot
[    1.432029] pci 0000:03:00.0: PME# disabled
[    1.436365] pci 0000:03:02.0: PME# supported from D1 D2 D3hot D3cold
[    1.440029] pci 0000:03:02.0: PME# disabled
[    1.444276] pci 0000:00:1e.0: transparent bridge
[    3.828482] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 1=
2 15)
[    3.837335] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 1=
2 15)
[    3.845942] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 1=
2 15)
[    3.855050] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 1=
2 15)
[    3.863883] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12=
 15) *0, disabled.
[    3.869834] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 9 10 11 1=
2 15)
[    3.878767] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 1=
2 15)
[    3.887626] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 1=
2 15)
[    3.892765] SCSI subsystem initialized
[    3.896636] usbcore: registered new interface driver usbfs
[    3.900146] usbcore: registered new interface driver hub
[    3.904110] usbcore: registered new device driver usb
[    3.912134] PCI: Using ACPI for IRQ routing
[    3.968087] pnp: PnP ACPI init
[    3.971183] ACPI: bus type pnp registered
[    4.068187] pnp: PnP ACPI: found 9 devices
[    4.072315] ACPI: ACPI bus type pnp unregistered
[    4.076998] system 00:01: ioport range 0x800-0x85f has been reserved
[    4.083381] system 00:01: ioport range 0xc00-0xc7f has been reserved
[    4.089760] system 00:01: ioport range 0x860-0x8ff has been reserved
[    4.104192] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:01
[    4.110134] pci 0000:00:1c.0:   IO window: disabled
[    4.115048] pci 0000:00:1c.0:   MEM window: 0xfe500000-0xfe5fffff
[    4.121168] pci 0000:00:1c.0:   PREFETCH window: disabled
[    4.126595] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:02
[    4.132535] pci 0000:00:1c.1:   IO window: disabled
[    4.137448] pci 0000:00:1c.1:   MEM window: 0xfe400000-0xfe4fffff
[    4.143570] pci 0000:00:1c.1:   PREFETCH window: disabled
[    4.149000] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:03
[    4.154948] pci 0000:00:1e.0:   IO window: 0xd000-0xdfff
[    4.160294] pci 0000:00:1e.0:   MEM window: 0xfe300000-0xfe3fffff
[    4.166416] pci 0000:00:1e.0:   PREFETCH window: disabled
[    4.171877] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[    4.178656] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ =
17
[    4.185650] NET: Registered protocol family 2
[    4.190148] IP route cache hash table entries: 131072 (order: 8, 10485=
76 bytes)
[    4.198020] TCP established hash table entries: 262144 (order: 10, 419=
4304 bytes)
[    4.207033] TCP bind hash table entries: 65536 (order: 8, 1048576 byte=
s)
[    4.214177] TCP: Hash tables configured (established 262144 bind 65536=
)
[    4.220813] TCP reno registered
[    4.224294] NET: Registered protocol family 1
[    4.229449] Simple Boot Flag at 0x7a set to 0x1
[    4.242939] audit: initializing netlink socket (disabled)
[    4.248500] type=3D2000 audit(1254849243.245:1): initialized
[    4.259383] I-pipe: Domain Xenomai registered.
[    4.264174] Xenomai: hal/x86_64 started.
[    4.268201] Xenomai: scheduling class idle registered.
[    4.273381] Xenomai: scheduling class rt registered.
[    4.292942] Xenomai: real-time nucleus v2.5-rc3 (Flying In A Blue Drea=
m) loaded.
[    4.301131] Xenomai: NMI watchdog started (threshold=3D100 us).
[    4.307024] I-pipe: Detected stalled topmost domain, probably caused b=
y a bug.
[    4.307026]         A critical section may have been left unterminated=
.
[    4.310892] Pid: 1, comm: swapper Not tainted 2.6.31.1-xenomai-i2.4-06=
 #7
[    4.327586] Call Trace:
[    4.330028]  <NMI>  [<ffffffff8107e122>] ipipe_check_context+0x1f1/0x2=
03
[    4.336733]  [<ffffffff8144037a>] do_nmi+0x44/0x2ac
[    4.341602]  [<ffffffff8143ff2a>] nmi+0x1a/0x20
[    4.346125]  [<ffffffff810819ad>] ? __ipipe_trace+0x23d/0x681
[    4.351855]  <<EOE>>  [<ffffffff810a7569>] ? ipipe_restore_pipeline_he=
ad+0x7/0x6b
[    4.359346]  [<ffffffff810824ae>] ipipe_trace_function+0x1c/0x1e
[    4.365338]  [<ffffffff8100afd6>] ftrace_call+0x5/0x2b
[    4.370464]  [<ffffffff810a756e>] ? ipipe_restore_pipeline_head+0xc/0x=
6b
[    4.377149]  [<ffffffff810a75f0>] xnlock_put_irqrestore+0x23/0x25
[    4.383228]  [<ffffffff810a798c>] xnshadow_register_interface+0x68/0x9=
d
[    4.389828]  [<ffffffff810ae0c7>] __native_syscall_init+0x15/0x3b
[    4.395906]  [<ffffffff810aca31>] __native_skin_init+0x1fc/0x263
[    4.401899]  [<ffffffff810ac835>] ? __native_skin_init+0x0/0x263
[    4.407891]  [<ffffffff810ac835>] ? __native_skin_init+0x0/0x263
[    4.413884]  [<ffffffff81009069>] do_one_initcall+0x5e/0x17d
[    4.419530]  [<ffffffff81b7c795>] kernel_init+0x16e/0x1c4
[    4.424917]  [<ffffffff8100c9ba>] child_rip+0xa/0x20
[    4.429872]  [<ffffffff81b7c627>] ? kernel_init+0x0/0x1c4
[    4.435259]  [<ffffffff8100c9b0>] ? child_rip+0x0/0x20
[    4.440385] I-pipe tracer log (100 points):
[    4.444559]  |  *+func                    0 xnlock_put_irqrestore+0x4 =
(xnshadow_register_interface+0x68)
[    4.454141]  |  *+func                    0 __xnlock_get+0x4 (__xnlock=
_get_irqsave+0x23)
[    4.462339]  |   +begin   0x80000000      0 ipipe_test_and_stall_pipel=
ine_head+0x20 (__xnlock_get_irqsave+0x17)
[    4.472533]      +func                    0 ipipe_test_and_stall_pipel=
ine_head+0x9 (__xnlock_get_irqsave+0x17)
[    4.482629]      +func                   -1 __xnlock_get_irqsave+0x9 (=
xnshadow_register_interface+0x31)
[    4.492141]      +func                   -1 xnshadow_register_interfac=
e+0xd (__native_syscall_init+0x15)
[    4.501721]      +func                   -1 __native_syscall_init+0x4 =
(__native_skin_init+0x1fc)
[    4.510608]      +func                   -1 __native_alarm_pkg_init+0x=
4 (__native_skin_init+0x1f1)
[    4.519674]      +func                   -1 __native_heap_pkg_init+0x4=
 (__native_skin_init+0x1e6)
[    4.528664]      +func                   -2 __native_queue_pkg_init+0x=
4 (__native_skin_init+0x1db)
[    4.537730]      +func                   -7 __native_pipe_pkg_init+0x4=
 (__native_skin_init+0x1d0)
[    4.546701]      +func                   -8 __native_cond_pkg_init+0x4=
 (__native_skin_init+0x1c5)
[    4.555679]      +func                   -8 __native_mutex_pkg_init+0x=
4 (__native_skin_init+0x1ba)
[    4.564753]      +func                   -8 __native_event_pkg_init+0x=
4 (__native_skin_init+0x1ab)
[    4.573820]      +func                   -8 __native_sem_pkg_init+0x4 =
(__native_skin_init+0x19c)
[    4.582700]  |   +end     0x80000000     -9 __ipipe_restore_pipeline_h=
ead+0xfa (ipipe_restore_pipeline_head+0x66)
[    4.593074]  |  *+func                   -9 __ipipe_restore_pipeline_h=
ead+0x7 (ipipe_restore_pipeline_head+0x66)
[    4.603343]  |  *+func                   -9 ipipe_restore_pipeline_hea=
d+0x7 (T.622+0x24)
[    4.611548]  |  *+func                   -9 T.622+0x4 (xnpod_add_hook+=
0x8f)
[    4.618621]  |  *+func                  -10 xnlock_put_irqrestore+0x7 =
(xnheap_alloc+0x175)
[    4.626994]  |  *+func                  -10 get_free_range+0xd (xnheap=
_alloc+0xae)
[    4.634674]  |  *+func                  -11 __xnlock_get_irqsave+0x7 (=
xnheap_alloc+0x89)
[    4.642875]  |  *+func                  -11 xnheap_alloc+0x11 (xnpod_a=
dd_hook+0x64)
[    4.650641]  |   +begin   0x80000000    -12 ipipe_test_and_stall_pipel=
ine_head+0x20 (T.625+0xe)
[    4.659447]      +func                  -12 ipipe_test_and_stall_pipel=
ine_head+0x9 (T.625+0xe)
[    4.668174]      +func                  -12 T.625+0x4 (xnpod_add_hook+=
0x1a)
[    4.675232]      +func                  -12 xnpod_add_hook+0xb (__nati=
ve_task_pkg_init+0x1a)
[    4.683782]      +func                  -12 __native_task_pkg_init+0x4=
 (__native_skin_init+0x18d)
[    4.692773]      +func                  -17 cpumask_weight+0x4 (xnpod_=
enable_timesource+0x120)
[    4.701491]  |   +end     0x80000000    -17 __ipipe_restore_pipeline_h=
ead+0xfa (ipipe_restore_pipeline_head+0x66)
[    4.711846]  |  *+func                  -18 __ipipe_restore_pipeline_h=
ead+0x7 (ipipe_restore_pipeline_head+0x66)
[    4.722134]  |  *+func                  -18 ipipe_restore_pipeline_hea=
d+0x7 (T.622+0x24)
[    4.730332]  |  *+func                  -18 T.622+0x4 (xnpod_enable_ti=
mesource+0x116)
[    4.738273]  |  *+func                  -18 _flat_send_IPI_mask+0x11 (=
flat_send_IPI_mask+0x11)
[    4.746987]  |  *+func                  -18 flat_send_IPI_mask+0x4 (__=
ipipe_send_ipi+0x84)
[    4.755360]  |  *+func                  -19 T.421+0x4 (__ipipe_send_ip=
i+0x68)
[    4.762609]  |  *+func                  -19 __ipipe_send_ipi+0x11 (ipi=
pe_send_ipi+0xe)
[    4.770636]  |  *+func                  -19 ipipe_send_ipi+0x4 (xntime=
r_next_remote_shot+0x30)
[    4.779354]  |  *+func                  -19 xntimer_next_remote_shot+0=
x4 (xntimer_start_aperiodic+0x123)
[    4.788950]  |  *+func                  -19 xntimer_enqueue_aperiodic+=
0x4 (xntimer_start_aperiodic+0xc6)
[    4.798532]  |  *+func                  -19 xnarch_ns_to_tsc+0x4 (xnti=
mer_start_aperiodic+0x6f)
[    4.807330]  |  *+func                  -20 xntimer_start_aperiodic+0x=
b (xntimer_start+0xe)
[    4.815794]  |  *+func                  -20 xntimer_start+0x4 (xnpod_e=
nable_timesource+0x10e)
[    4.824435]  |   +begin   0x80000000    -20 ipipe_test_and_stall_pipel=
ine_head+0x20 (T.625+0xe)
[    4.833238]      +func                  -20 ipipe_test_and_stall_pipel=
ine_head+0x9 (T.625+0xe)
[    4.841955]      +func                  -20 T.625+0x4 (xnpod_enable_ti=
mesource+0xdb)
[    4.849813]  |   +end     0x80000001    -21 ipipe_critical_exit+0x76 (=
ipipe_request_tickdev+0x110)
[    4.858868]  |   +func                  -21 T.421+0x4 (ipipe_critical_=
exit+0x4b)
[    4.866378]  |   +func                  -21 T.421+0x4 (ipipe_critical_=
exit+0x4b)
[    4.873889]  |   +func                  -22 ipipe_critical_exit+0x9 (i=
pipe_request_tickdev+0x110)
[    4.882862]  |   +func                  -22 __ipipe_check_lapic+0x4 (_=
_ipipe_check_tickdev+0x25)
[    4.891754]  |   +func                  -22 __ipipe_check_tickdev+0x4 =
(ipipe_request_tickdev+0x8e)
[    4.900830]  |   +func                  -42 __default_send_IPI_shortcu=
t+0x11 (flat_send_IPI_allbutself+0x8f)
[    4.910759]  |   +func                  -42 flat_send_IPI_allbutself+0=
x9 (ipipe_critical_enter+0xa5)
[    4.919990]  |   +begin   0x80000001    -43 ipipe_critical_enter+0x21 =
(ipipe_request_tickdev+0x30)
[    4.929066]      +func                  -43 ipipe_critical_enter+0x7 (=
ipipe_request_tickdev+0x30)
[    4.938044]      +func                  -43 ipipe_request_tickdev+0x11=
 (rthal_timer_request+0x6c)
[    4.947017]      +func                  -43 rthal_timer_request+0xd (x=
npod_enable_timesource+0xba)
[    4.956092]      +func                  -43 cpumask_weight+0x4 (xnpod_=
enable_timesource+0x120)
[    4.964809]  |   +end     0x80000000    -43 __ipipe_restore_pipeline_h=
ead+0xfa (ipipe_restore_pipeline_head+0x66)
[    4.975165]  |  *+func                  -44 __ipipe_restore_pipeline_h=
ead+0x7 (ipipe_restore_pipeline_head+0x66)
[    4.985455]  |  *+func                  -44 ipipe_restore_pipeline_hea=
d+0x7 (T.622+0x24)
[    4.993660]  |  *+func                  -44 T.622+0x4 (xnpod_enable_ti=
mesource+0x116)
[    5.001606]  |  *+func                  -44 _flat_send_IPI_mask+0x11 (=
flat_send_IPI_mask+0x11)
[    5.010320]  |  *+func                  -44 flat_send_IPI_mask+0x4 (__=
ipipe_send_ipi+0x84)
[    5.018691]  |  *+func                  -44 T.421+0x4 (__ipipe_send_ip=
i+0x68)
[    5.025944]  |  *+func                  -45 __ipipe_send_ipi+0x11 (ipi=
pe_send_ipi+0xe)
[    5.033965]  |  *+func                  -45 ipipe_send_ipi+0x4 (xntime=
r_next_remote_shot+0x30)
[    5.042691]  |  *+func                  -45 xntimer_next_remote_shot+0=
x4 (xntimer_start_aperiodic+0x123)
[    5.052283]  |  *+func                  -45 xntimer_enqueue_aperiodic+=
0x4 (xntimer_start_aperiodic+0xc6)
[    5.061868]  |  *+func                  -45 xnarch_ns_to_tsc+0x4 (xnti=
mer_start_aperiodic+0x6f)
[    5.070671]  |  *+func                  -45 xntimer_start_aperiodic+0x=
b (xntimer_start+0xe)
[    5.079129]  |  *+func                  -46 xntimer_start+0x4 (xnpod_e=
nable_timesource+0x10e)
[    5.087764]  |   +begin   0x80000000    -46 ipipe_test_and_stall_pipel=
ine_head+0x20 (T.625+0xe)
[    5.096584]      +func                  -46 ipipe_test_and_stall_pipel=
ine_head+0x9 (T.625+0xe)
[    5.105302]      +func                  -46 T.625+0x4 (xnpod_enable_ti=
mesource+0xdb)
[    5.113154]  |   +end     0x80000001    -46 ipipe_critical_exit+0x76 (=
ipipe_request_tickdev+0x110)
[    5.122220]  |   +func                  -47 T.421+0x4 (ipipe_critical_=
exit+0x4b)
[    5.129723]  |   +func                  -47 T.421+0x4 (ipipe_critical_=
exit+0x4b)
[    5.137230]  |   +func                  -47 ipipe_critical_exit+0x9 (i=
pipe_request_tickdev+0x110)
[    5.146207]  |   +func                  -47 __ipipe_check_lapic+0x4 (_=
_ipipe_check_tickdev+0x25)
[    5.155092]  |   +func                  -48 __ipipe_check_tickdev+0x4 =
(ipipe_request_tickdev+0x8e)
[    5.164168]  |   +func                  -68 __default_send_IPI_shortcu=
t+0x11 (flat_send_IPI_allbutself+0x8f)
[    5.174098]  |   +func                  -72 flat_send_IPI_allbutself+0=
x9 (ipipe_critical_enter+0xa5)
[    5.183328]  |   +begin   0x80000001    -72 ipipe_critical_enter+0x21 =
(ipipe_request_tickdev+0x30)
[    5.192409]      +func                  -73 ipipe_critical_enter+0x7 (=
ipipe_request_tickdev+0x30)
[    5.201387]      +func                  -73 ipipe_request_tickdev+0x11=
 (rthal_timer_request+0x6c)
[    5.210365]      +func                  -73 rthal_timer_request+0xd (x=
npod_enable_timesource+0xba)
[    5.219422]      +func                  -73 cpumask_weight+0x4 (xnpod_=
enable_timesource+0x120)
[    5.228158]  |   +end     0x80000000    -73 __ipipe_restore_pipeline_h=
ead+0xfa (ipipe_restore_pipeline_head+0x66)
[    5.238521]  |  *+func                  -73 __ipipe_restore_pipeline_h=
ead+0x7 (ipipe_restore_pipeline_head+0x66)
[    5.248802]  |  *+func                  -74 ipipe_restore_pipeline_hea=
d+0x7 (T.622+0x24)
[    5.256999]  |  *+func                  -74 T.622+0x4 (xnpod_enable_ti=
mesource+0x116)
[    5.264942]  |  *+func                  -74 _flat_send_IPI_mask+0x11 (=
flat_send_IPI_mask+0x11)
[    5.273660]  |  *+func                  -74 flat_send_IPI_mask+0x4 (__=
ipipe_send_ipi+0x84)
[    5.282028]  |  *+func                  -74 T.421+0x4 (__ipipe_send_ip=
i+0x68)
[    5.289276]  |  *+func                  -74 __ipipe_send_ipi+0x11 (ipi=
pe_send_ipi+0xe)
[    5.297305]  |  *+func                  -75 ipipe_send_ipi+0x4 (xntime=
r_next_remote_shot+0x30)
[    5.306023]  |  *+func                  -75 xntimer_next_remote_shot+0=
x4 (xntimer_start_aperiodic+0x123)
[    5.315599]  |  *+func                  -75 xntimer_enqueue_aperiodic+=
0x4 (xntimer_start_aperiodic+0xc6)
[    5.324917] ------------[ cut here ]------------
[    5.329797] WARNING: at include/linux/ipipe.h:570 ipipe_test_foreign_s=
tack+0x3c/0xb2()
[    5.337692] Hardware name: OptiPlex 960                =20
[    5.342988] Modules linked in:
[    5.345860] Pid: 1, comm: swapper Not tainted 2.6.31.1-xenomai-i2.4-06=
 #7
[    5.352812] Call Trace:
[    5.352812]  <NMI>  [<ffffffff8103caa9>] warn_slowpath_common+0x7c/0x9=
4
[    5.361862]  [<ffffffff8103cad5>] warn_slowpath_null+0x14/0x16
[    5.367680]  [<ffffffff8100d518>] ipipe_test_foreign_stack+0x3c/0xb2
[    5.374017]  [<ffffffff81440593>] do_nmi+0x25d/0x2ac
[    5.378969]  [<ffffffff8143ff2a>] nmi+0x1a/0x20
[    5.383488]  [<ffffffff810819ad>] ? __ipipe_trace+0x23d/0x681
[    5.389221]  <<EOE>>  [<ffffffff810a7569>] ? ipipe_restore_pipeline_he=
ad+0x7/0x6b
[    5.396695]  [<ffffffff810824ae>] ipipe_trace_function+0x1c/0x1e
[    5.402687]  [<ffffffff8100afd6>] ftrace_call+0x5/0x2b
[    5.407812]  [<ffffffff810a756e>] ? ipipe_restore_pipeline_head+0xc/0x=
6b
[    5.414495]  [<ffffffff810a75f0>] xnlock_put_irqrestore+0x23/0x25
[    5.420571]  [<ffffffff810a798c>] xnshadow_register_interface+0x68/0x9=
d
[    5.427168]  [<ffffffff810ae0c7>] __native_syscall_init+0x15/0x3b
[    5.433245]  [<ffffffff810aca31>] __native_skin_init+0x1fc/0x263
[    5.439234]  [<ffffffff810ac835>] ? __native_skin_init+0x0/0x263
[    5.445224]  [<ffffffff810ac835>] ? __native_skin_init+0x0/0x263
[    5.451214]  [<ffffffff81009069>] do_one_initcall+0x5e/0x17d
[    5.456857]  [<ffffffff81b7c795>] kernel_init+0x16e/0x1c4
[    5.462241]  [<ffffffff8100c9ba>] child_rip+0xa/0x20
[    5.467192]  [<ffffffff81b7c627>] ? kernel_init+0x0/0x1c4
[    5.472578]  [<ffffffff8100c9b0>] ? child_rip+0x0/0x20
[    5.477704] ---[ end trace a7919e7f17c0a725 ]---
[    5.482312] ------------[ cut here ]------------
[    5.486916] WARNING: at include/linux/ipipe.h:570 ipipe_test_foreign_s=
tack+0x79/0xb2()
[    5.494809] Hardware name: OptiPlex 960                =20
[    5.500104] Modules linked in:
[    5.500104] Pid: 1, comm: swapper Tainted: G        W  2.6.31.1-xenoma=
i-i2.4-06 #7
[    5.510702] Call Trace:
[    5.513142]  <NMI>  [<ffffffff8103caa9>] warn_slowpath_common+0x7c/0x9=
4
[    5.519750]  [<ffffffff8103cad5>] warn_slowpath_null+0x14/0x16
[    5.525568]  [<ffffffff8100d555>] ipipe_test_foreign_stack+0x79/0xb2
[    5.531904]  [<ffffffff81440593>] do_nmi+0x25d/0x2ac
[    5.536857]  [<ffffffff8143ff2a>] nmi+0x1a/0x20
[    5.541376]  [<ffffffff810819ad>] ? __ipipe_trace+0x23d/0x681
[    5.547106]  <<EOE>>  [<ffffffff810a7569>] ? ipipe_restore_pipeline_he=
ad+0x7/0x6b
[    5.554583]  [<ffffffff810824ae>] ipipe_trace_function+0x1c/0x1e
[    5.560574]  [<ffffffff8100afd6>] ftrace_call+0x5/0x2b
[    5.565700]  [<ffffffff810a756e>] ? ipipe_restore_pipeline_head+0xc/0x=
6b
[    5.572384]  [<ffffffff810a75f0>] xnlock_put_irqrestore+0x23/0x25
[    5.578461]  [<ffffffff810a798c>] xnshadow_register_interface+0x68/0x9=
d
[    5.585056]  [<ffffffff810ae0c7>] __native_syscall_init+0x15/0x3b
[    5.591132]  [<ffffffff810aca31>] __native_skin_init+0x1fc/0x263
[    5.597122]  [<ffffffff810ac835>] ? __native_skin_init+0x0/0x263
[    5.603112]  [<ffffffff810ac835>] ? __native_skin_init+0x0/0x263
[    5.609102]  [<ffffffff81009069>] do_one_initcall+0x5e/0x17d
[    5.614744]  [<ffffffff81b7c795>] kernel_init+0x16e/0x1c4
[    5.620129]  [<ffffffff8100c9ba>] child_rip+0xa/0x20
[    5.625082]  [<ffffffff81b7c627>] ? kernel_init+0x0/0x1c4
[    5.630467]  [<ffffffff8100c9b0>] ? child_rip+0x0/0x20
[    5.635591] ---[ end trace a7919e7f17c0a726 ]---
[    5.640203] Xenomai: starting native API services.
[    5.644986] Xenomai: starting POSIX services.
[    5.649835] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    5.662796] Installing knfsd (copyright (C) 1996 okir@domain.hid).
[    5.670333] fuse init (API version 7.12)
[    5.674648] msgmni has been set to 7538
[    5.679509] alg: No test for stdrng (krng)
[    5.683861] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 253)
[    5.691242] io scheduler noop registered
[    5.695157] io scheduler anticipatory registered
[    5.699764] io scheduler deadline registered
[    5.704037] io scheduler cfq registered (default)
[    5.709850] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    5.722494] Non-volatile memory driver v1.3
[    5.726757] Linux agpgart interface v0.103
[    5.730907] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
=FF[    5.992296] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    5.999033] 00:07: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    6.004803] serial 0000:00:03.3: PCI INT B -> GSI 17 (level, low) -> I=
RQ 17
[    6.011883] 0000:00:03.3: ttyS1 at I/O 0xec98 (irq =3D 17) is a 16550A
[    6.022046] brd: module loaded
[    6.026863] loop: module loaded
[    6.030486] ahci 0000:00:1f.2: PCI INT C -> GSI 18 (level, low) -> IRQ=
 18
[    6.037387] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps =
0x2f impl RAID mode
[    6.045546] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio ems=20
[    6.080098] scsi0 : ahci
[    6.082941] scsi1 : ahci
[    6.085725] scsi2 : ahci
[    6.088505] scsi3 : ahci
[    6.091280] scsi4 : ahci
[    6.094058] scsi5 : ahci
[    6.098659] ata1: SATA max UDMA/133 abar m2048@domain.hid port 0xff970=
100 irq 30
[    6.106041] ata2: SATA max UDMA/133 abar m2048@domain.hid port 0xff970=
180 irq 30
[    6.113418] ata3: SATA max UDMA/133 abar m2048@domain.hid port 0xff970=
200 irq 30
[    6.120795] ata4: SATA max UDMA/133 abar m2048@domain.hid port 0xff970=
280 irq 30
[    6.128170] ata5: DUMMY
[    6.130602] ata6: SATA max UDMA/133 abar m2048@domain.hid port 0xff970=
380 irq 30
[    6.138507] Intel(R) PRO/1000 Network Driver - version 7.3.21-k3-NAPI
[    6.144930] Copyright (c) 1999-2006 Intel Corporation.
[    6.150153] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
[    6.156058] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    6.161904] e1000e 0000:00:19.0: PCI INT A -> GSI 21 (level, low) -> I=
RQ 21
[    6.168852] e1000e 0000:00:19.0: pci_enable_pcie_error_reporting faile=
d 0xfffffffb
[    6.284646] 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:24:e=
8:39:3c:95
[    6.292023] 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    6.298397] 0000:00:19.0: eth0: MAC: 8, PHY: 8, PBA No: 2021ff-0ff
[    6.304657] Intel(R) Gigabit Ethernet Network Driver - version 1.3.16-=
k2
[    6.311341] Copyright (c) 2007-2009 Intel Corporation.
[    6.316566] Intel(R) Virtual Function Network Driver - version 1.0.0-k=
0
[    6.323164] Copyright (c) 2009 Intel Corporation.
[    6.327960] <6>8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    6.334386] 8139cp 0000:03:02.0: This (id 10ec:8139 rev 10) is not an =
8139C+ compatible chip, use 8139too
[    6.344017] tun: Universal TUN/TAP device driver, 1.6
[    6.349055] tun: (C) 1999-2004 Max Krasnyansky <maxk@domain.hid>
[    6.355501] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.362042] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 22 (level, low) ->=
 IRQ 22
[    6.369172] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    6.374517] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bu=
s number 1
[    6.385808] ehci_hcd 0000:00:1a.7: debug port 1
[    6.390358] ehci_hcd 0000:00:1a.7: irq 22, io mem 0xfe6da000
[    6.408020] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    6.413817] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    6.420588] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    6.427792] usb usb1: Product: EHCI Host Controller
[    6.432657] usb usb1: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 ehc=
i_hcd
[    6.439600] usb usb1: SerialNumber: 0000:00:1a.7
[    6.444344] usb usb1: configuration #1 chosen from 1 choice
[    6.450026] hub 1-0:1.0: USB hub found
[    6.453776] hub 1-0:1.0: 6 ports detected
[    6.456038] ata3: SATA link down (SStatus 4 SControl 300)
[    6.456067] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.456092] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    6.456112] ata4: SATA link down (SStatus 4 SControl 300)
[    6.456138] ata6: SATA link down (SStatus 0 SControl 300)
[    6.482951] ata2.00: ATAPI: PLDS DVD+/-RW DH-16AAS, JD12, max UDMA/100=
, ATAPI AN
[    6.482980] ata1.00: ATA-8: ST3500418AS, CC44, max UDMA/133
[    6.482983] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/3=
2)
[    6.495489] ata2.00: configured for UDMA/100
[    6.510076] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[    6.510083] ata2: irq_stat 0x40000001
[    6.510091] ata2: hard resetting link
[    6.522361] ata1.00: configured for UDMA/133
[    6.522500] scsi 0:0:0:0: Direct-Access     ATA      ST3500418AS      =
CC44 PQ: 0 ANSI: 5
[    6.522897] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.523031] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 =
GB/465 GiB)
[    6.523113] sd 0:0:0:0: [sda] Write Protect is off
[    6.523158] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
[    6.562820] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) ->=
 IRQ 23
[    6.569951] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    6.575271] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bu=
s number 2
[    6.586564] ehci_hcd 0000:00:1d.7: debug port 1
[    6.591115] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xff980000
[    6.600734]  sda:
[    6.608021] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    6.613986] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    6.620757] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    6.627959] usb usb2: Product: EHCI Host Controller
[    6.632824] usb usb2: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 ehc=
i_hcd
[    6.639767] usb usb2: SerialNumber: 0000:00:1d.7
[    6.644430]  sda1 sda2 sda3 sda4 <
[    6.647906] usb usb2: configuration #1 chosen from 1 choice
[    6.653565] hub 2-0:1.0: USB hub found
[    6.657314] hub 2-0:1.0: 6 ports detected
[    6.661527] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.667752] uhci_hcd: USB Universal Host Controller Interface driver
[    6.674139]  sda5
[    6.675944] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) ->=
 IRQ 16
[    6.683260] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    6.688571] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bu=
s number 3
[    6.695955] uhci_hcd 0000:00:1a.0: detected 2 ports
[    6.700863] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ff20
[    6.706655] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    6.713427] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    6.720629] usb usb3: Product: UHCI Host Controller
[    6.725493] usb usb3: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhc=
i_hcd
[    6.732436] usb usb3: SerialNumber: 0000:00:1a.0
[    6.737102]  sda6 >
[    6.739375] usb usb3: configuration #1 chosen from 1 choice
[    6.745031] hub 3-0:1.0: USB hub found
[    6.748799] hub 3-0:1.0: 2 ports detected
[    6.752983] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 17 (level, low) ->=
 IRQ 17
[    6.757039] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.764756] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    6.770061] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bu=
s number 4
[    6.777442] uhci_hcd 0000:00:1a.1: detected 2 ports
[    6.782346] uhci_hcd 0000:00:1a.1: irq 17, io base 0x0000ff00
[    6.788138] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    6.794909] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    6.802111] usb usb4: Product: UHCI Host Controller
[    6.806977] usb usb4: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhc=
i_hcd
[    6.813920] usb usb4: SerialNumber: 0000:00:1a.1
[    6.818641] usb usb4: configuration #1 chosen from 1 choice
[    6.824330] hub 4-0:1.0: USB hub found
[    6.828080] hub 4-0:1.0: 2 ports detected
[    6.832173] uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 22 (level, low) ->=
 IRQ 22
[    6.839300] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    6.844613] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bu=
s number 5
[    6.852015] uhci_hcd 0000:00:1a.2: detected 2 ports
[    6.856927] uhci_hcd 0000:00:1a.2: irq 22, io base 0x0000fc00
[    6.862721] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    6.869491] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    6.876695] usb usb5: Product: UHCI Host Controller
[    6.881579] usb usb5: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhc=
i_hcd
[    6.888521] usb usb5: SerialNumber: 0000:00:1a.2
[    6.893253] usb usb5: configuration #1 chosen from 1 choice
[    6.898922] hub 5-0:1.0: USB hub found
[    6.902670] hub 5-0:1.0: 2 ports detected
[    6.906764] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) ->=
 IRQ 23
[    6.913890] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    6.919208] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bu=
s number 6
[    6.926590] uhci_hcd 0000:00:1d.0: detected 2 ports
[    6.931499] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000ff80
[    6.937294] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    6.944065] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    6.951268] usb usb6: Product: UHCI Host Controller
[    6.956133] usb usb6: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhc=
i_hcd
[    6.963074] usb usb6: SerialNumber: 0000:00:1d.0
[    6.967814] usb usb6: configuration #1 chosen from 1 choice
[    6.973491] hub 6-0:1.0: USB hub found
[    6.977240] hub 6-0:1.0: 2 ports detected
[    6.981332] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 17 (level, low) ->=
 IRQ 17
[    6.988459] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    6.993778] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bu=
s number 7
[    7.001158] uhci_hcd 0000:00:1d.1: detected 2 ports
[    7.006103] uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000ff60
[    7.011900] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    7.018670] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    7.025873] usb usb7: Product: UHCI Host Controller
[    7.030738] usb usb7: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhc=
i_hcd
[    7.037679] usb usb7: SerialNumber: 0000:00:1d.1
[    7.042415] usb usb7: configuration #1 chosen from 1 choice
[    7.048095] hub 7-0:1.0: USB hub found
[    7.051826] hub 7-0:1.0: 2 ports detected
[    7.055925] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) ->=
 IRQ 18
[    7.063050] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    7.068380] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bu=
s number 8
[    7.075761] uhci_hcd 0000:00:1d.2: detected 2 ports
[    7.080693] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
[    7.086484] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    7.093256] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    7.100488] usb usb8: Product: UHCI Host Controller
[    7.105355] usb usb8: Manufacturer: Linux 2.6.31.1-xenomai-i2.4-06 uhc=
i_hcd
[    7.112299] usb usb8: SerialNumber: 0000:00:1d.2
[    7.117040] usb usb8: configuration #1 chosen from 1 choice
[    7.122721] hub 8-0:1.0: USB hub found
[    7.126474] hub 8-0:1.0: 2 ports detected
[    7.130726] usbcore: registered new interface driver usblp
[    7.136202] Initializing USB Mass Storage driver...
[    7.141201] usbcore: registered new interface driver usb-storage
[    7.147194] USB Mass Storage support registered.
[    7.151925] usbcore: registered new interface driver libusual
[    7.157999] PNP: No PS/2 controller found. Probing ports directly.
[    7.166817] serio: i8042 KBD port at 0x60,0x64 irq 1
[    7.171777] serio: i8042 AUX port at 0x60,0x64 irq 12
[    7.176936] mice: PS/2 mouse device common for all mice
[    7.182390] rtc_cmos 00:05: RTC can wake from S4
[    7.187114] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    7.193215] rtc0: alarms up to one day, 242 bytes nvram, hpet irqs
[    7.199474] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) =
-> IRQ 18
[    7.206958] cpuidle: using governor ladder
[    7.211046] cpuidle: using governor menu
[    7.217313] usbcore: registered new interface driver hiddev
[    7.222958] usbcore: registered new interface driver usbhid
[    7.225527] usb 5-1: new full speed USB device using uhci_hcd and addr=
ess 2
[    7.235492] usbhid: v2.6:USB HID core driver
[    7.235578] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    7.245955] Netfilter messages via NETLINK v0.30.
[    7.248433] ata2.00: configured for UDMA/100
[    7.254920] ata2: EH complete
[    7.254934] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    7.255194] ctnetlink v0.93: registering with nfnetlink.
[    7.255301] ip_tables: (C) 2000-2006 Netfilter Core Team
[    7.255335] TCP cubic registered
[    7.255337] Initializing XFRM netlink socket
[    7.255678] NET: Registered protocol family 10
[    7.255952] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    7.255979] IPv6 over IPv4 tunneling driver
[    7.256166] NET: Registered protocol family 17
[    7.256385] RPC: Registered udp transport module.
[    7.256388] RPC: Registered tcp transport module.
[    7.331059] scsi 1:0:0:0: CD-ROM            PLDS     DVD+-RW DH-16AAS =
JD12 PQ: 0 ANSI: 5
[    7.344674] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form=
2 cdda tray
[    7.352140] Uniform CD-ROM driver Revision: 3.20
[    7.357172] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    7.405359] EXT3-fs: INFO: recovery required on readonly filesystem.
[    7.411704] EXT3-fs: write access will be enabled during recovery.
[    7.421659] usb 5-1: New USB device found, idVendor=3D413c, idProduct=3D=
2101
[    7.428380] usb 5-1: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[    7.435559] usb 5-1: Product: Dell Smart Card Reader Keyboard
[    7.441339] usb 5-1: Manufacturer: Dell
[    7.445291] usb 5-1: configuration #1 chosen from 1 choice
[    7.458028] input: Dell Dell Smart Card Reader Keyboard as /devices/pc=
i0000:00/0000:00:1a.2/usb5/5-1/5-1:1.0/input/input0
[    7.469543] generic-usb 0003:413C:2101.0001: input,hidraw0: USB HID v1=
.11 Keyboard [Dell Dell Smart Card Reader Keyboard] on usb-0000:00:1a.2-1=
/input0
[    7.519076] kjournald starting.  Commit interval 5 seconds
[    7.519097] EXT3-fs: recovery complete.
[    7.520404] EXT3-fs: mounted filesystem with writeback data mode.
[    7.520418] VFS: Mounted root (ext3 filesystem) readonly on device 8:3=
.
[    7.541124] Freeing unused kernel memory: 5556k freed
[    7.596023] usb 5-2: new low speed USB device using uhci_hcd and addre=
ss 3
[    7.773623] usb 5-2: New USB device found, idVendor=3D0461, idProduct=3D=
4d51
[    7.780318] usb 5-2: New USB device strings: Mfr=3D0, Product=3D2, Ser=
ialNumber=3D0
[    7.787451] usb 5-2: Product: DELL Laser Mouse
[    7.792288] usb 5-2: configuration #1 chosen from 1 choice
[   59.161513] BUG: Unhandled exception over domain Xenomai at 0xffffffff=
810800fc - switching to ROOT
[   59.161513] Pid: 350, comm: gatekeeper/0 Tainted: G        W  2.6.31.1=
-xenomai-i2.4-06 #7
[   59.161513] Call Trace:
[   59.161513]  <NMI>  [<ffffffff81021f70>] __ipipe_handle_exception+0x3d=
a/0x409
[   59.161513]  [<ffffffff8100c51c>] invalid_op+0x1c/0x60
[   59.161513]  [<ffffffff810800fc>] ? __ipipe_restore_root+0x87/0xb8
[   59.161513]  [<ffffffff81056f39>] cpu_clock+0x5a/0x62
[   59.161513]  [<ffffffff8103d52a>] vprintk+0x233/0x354
[   59.161513]  [<ffffffff8103d61f>] ? vprintk+0x328/0x354
[   59.161513]  [<ffffffff8143d5ac>] printk+0x1e7/0x28a
[   59.161513]  [<ffffffff81440871>] die_nmi+0x56/0x18e
[   59.161513]  [<ffffffff81440de6>] default_nmi_watchdog_tick+0x12b/0x1a=
a
[   59.161513]  [<ffffffff8135bfe0>] rthal_nmi_watchdog_tick+0x88/0x114
[   59.161513]  [<ffffffff810561f0>] ? notify_die+0x2e/0x30
[   59.161513]  [<ffffffff8144040a>] do_nmi+0xd4/0x2ac
[   59.161513]  [<ffffffff8143ff2a>] nmi+0x1a/0x20
[   59.161513]  [<ffffffff8135c2f4>] ? rthal_nmi_arm+0xe1/0x176
[   59.161513]  <<EOE>>  [<ffffffff810a45bc>] xntimer_next_local_shot+0x1=
1b/0x120
[   59.161513]  [<ffffffff810a4707>] xntimer_tick_aperiodic+0x146/0x152
[   59.161513]  [<ffffffff8109db01>] xnintr_clock_handler+0x69/0x179
[   59.161513]  [<ffffffff8107ecd9>] __virq_end+0x68/0x1b2
[   59.161513]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.161513]  [<ffffffff8107f488>] ipipe_suspend_domain+0x19a/0x282
[   59.161513]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.161513]  [<ffffffff8107f6e8>] __ipipe_walk_pipeline+0x178/0x23c
[   59.161513]  [<ffffffff8107fcd8>] __ipipe_dispatch_wired_nocheck+0x1d8=
/0x1e7
[   59.161513]  [<ffffffff8107fdaa>] __ipipe_dispatch_wired+0xc3/0xcc
[   59.161513]  [<ffffffff81021477>] __ipipe_handle_irq+0x128/0x3ca
[   59.161513]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.161513]  [<ffffffff81021b6b>] ipipe_trigger_irq+0x71/0x9c
[   59.161513]  [<ffffffff8108006f>] ? __ipipe_unstall_root+0xd1/0xd7
[   59.161513]  [<ffffffff81030959>] ? raw_local_irq_enable+0xe/0x10
[   59.161513]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.161513]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.161513]  [<ffffffff8109f037>] __xnpod_schedule+0xa0/0x6ae
[   59.161513]  [<ffffffff810a7ebf>] xnpod_schedule+0x32/0x34
[   59.161513]  [<ffffffff810a803a>] gatekeeper_thread+0x179/0x18f
[   59.161513]  [<ffffffff8103766d>] ? default_wake_function+0x0/0x14
[   59.161513]  [<ffffffff81061656>] ? raw_local_irq_restore+0x19/0x1b
[   59.161513]  [<ffffffff8143f874>] ? _spin_unlock_irqrestore+0x16/0x18
[   59.161513]  [<ffffffff810a7ec1>] ? gatekeeper_thread+0x0/0x18f
[   59.161513]  [<ffffffff810521ba>] kthread+0x8f/0x97
[   59.161513]  [<ffffffff8100c9ba>] child_rip+0xa/0x20
[   59.161513]  [<ffffffff8105212b>] ? kthread+0x0/0x97
[   59.161513]  [<ffffffff8100c9b0>] ? child_rip+0x0/0x20
[   59.161513] ------------[ cut here ]------------
[   59.561515] kernel BUG at kernel/ipipe/core.c:331!
[   59.561515] invalid opcode: 0000 [#1] SMP=20
[   59.561515] last sysfs file: /sys/devices/pci0000:00/0000:00:1e.0/0000=
:03:02.0/resource
[   59.561515] CPU 0=20
[   59.561515] Modules linked in: 8139too
[   59.561515] Pid: 350, comm: gatekeeper/0 Tainted: G        W  2.6.31.1=
-xenomai-i2.4-06 #7 OptiPlex 960                =20
[   59.561515] RIP: 0010:[<ffffffff810800fc>]  [<ffffffff810800fc>] __ipi=
pe_restore_root+0x87/0xb8
[   59.561515] RSP: 0018:ffff88002be07cd8  EFLAGS: 00010006
[   59.561515] RAX: ffff88002be00000 RBX: 0000000000000092 RCX: 000000000=
0000003
[   59.561515] RDX: ffff88002be00000 RSI: ffffffff81be7790 RDI: 000000000=
0000001
[   59.561515] RBP: ffff88002be07cf8 R08: ffff88002be07d18 R09: 000000000=
0000073
[   59.561515] R10: ffffffff8165b610 R11: 0000000000000000 R12: ffffffff8=
1c9ddc0
[   59.561515] R13: 0000000000000001 R14: 0000000000000000 R15: 000000000=
0000000
[   59.561515] FS:  0000000000000000(0000) GS:ffff88002be00000(0000) knlG=
S:0000000000000000
[   59.561515] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[   59.561515] CR2: 000000000060a190 CR3: 0000000123d35000 CR4: 000000000=
00406f0
[   59.561515] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[   59.561515] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 000000000=
0000400
[   59.561515] Process gatekeeper/0 (pid: 350, threadinfo ffff88012729c00=
0, task ffff88012799e500)
[   59.561515] Stack:
[   59.561515]  0000000000000000 0000000dc64d0d06 0000000000000000 ffff88=
002be07d48
[   59.561515] <0> ffff88002be07d18 ffffffff81056f39 ffffffff81c677b3 000=
0000000000027
[   59.561515] <0> ffff88002be07db8 ffffffff8103d52a 00000000ffffffff fff=
f88002be07d78
[   59.561515] Call Trace:
[   59.561515]  <NMI>=20
[   59.561515]  [<ffffffff81056f39>] cpu_clock+0x5a/0x62
[   59.561515]  [<ffffffff8103d52a>] vprintk+0x233/0x354
[   59.561515]  [<ffffffff8103d61f>] ? vprintk+0x328/0x354
[   59.561515]  [<ffffffff8143d5ac>] printk+0x1e7/0x28a
[   59.561515]  [<ffffffff81440871>] die_nmi+0x56/0x18e
[   59.561515]  [<ffffffff81440de6>] default_nmi_watchdog_tick+0x12b/0x1a=
a
[   59.561515]  [<ffffffff8135bfe0>] rthal_nmi_watchdog_tick+0x88/0x114
[   59.561515]  [<ffffffff810561f0>] ? notify_die+0x2e/0x30
[   59.561515]  [<ffffffff8144040a>] do_nmi+0xd4/0x2ac
[   59.561515]  [<ffffffff8143ff2a>] nmi+0x1a/0x20
[   59.561515]  [<ffffffff8135c2f4>] ? rthal_nmi_arm+0xe1/0x176
[   59.561515]  <<EOE>>=20
[   59.561515]  [<ffffffff810a45bc>] xntimer_next_local_shot+0x11b/0x120
[   59.561515]  [<ffffffff810a4707>] xntimer_tick_aperiodic+0x146/0x152
[   59.561515]  [<ffffffff8109db01>] xnintr_clock_handler+0x69/0x179
[   59.561515]  [<ffffffff8107ecd9>] __virq_end+0x68/0x1b2
[   59.561515]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.561515]  [<ffffffff8107f488>] ipipe_suspend_domain+0x19a/0x282
[   59.561515]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.561515]  [<ffffffff8107f6e8>] __ipipe_walk_pipeline+0x178/0x23c
[   59.561515]  [<ffffffff8107fcd8>] __ipipe_dispatch_wired_nocheck+0x1d8=
/0x1e7
[   59.561515]  [<ffffffff8107fdaa>] __ipipe_dispatch_wired+0xc3/0xcc
[   59.561515]  [<ffffffff81021477>] __ipipe_handle_irq+0x128/0x3ca
[   59.561515]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.561515]  [<ffffffff81021b6b>] ipipe_trigger_irq+0x71/0x9c
[   59.561515]  [<ffffffff8108006f>] ? __ipipe_unstall_root+0xd1/0xd7
[   59.561515]  [<ffffffff81030959>] ? raw_local_irq_enable+0xe/0x10
[   59.561515]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.561515]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.561515]  [<ffffffff8109f037>] __xnpod_schedule+0xa0/0x6ae
[   59.561515]  [<ffffffff810a7ebf>] xnpod_schedule+0x32/0x34
[   59.561515]  [<ffffffff810a803a>] gatekeeper_thread+0x179/0x18f
[   59.561515]  [<ffffffff8103766d>] ? default_wake_function+0x0/0x14
[   59.561515]  [<ffffffff81061656>] ? raw_local_irq_restore+0x19/0x1b
[   59.561515]  [<ffffffff8143f874>] ? _spin_unlock_irqrestore+0x16/0x18
[   59.561515]  [<ffffffff810a7ec1>] ? gatekeeper_thread+0x0/0x18f
[   59.561515]  [<ffffffff810521ba>] kthread+0x8f/0x97
[   59.561515]  [<ffffffff8100c9ba>] child_rip+0xa/0x20
[   59.561515]  [<ffffffff8105212b>] ? kthread+0x0/0x97
[   59.561515]  [<ffffffff8100c9b0>] ? child_rip+0x0/0x20
[   59.561515] Code: 01 00 00 00 65 48 8b 04 25 a0 cb 00 00 4d 85 f6 4e 8=
b 24 20 74 0a bf 01 00 00 80 e8 21 25 00 00 53 9d 49 81 fc c0 1f c7 81 74=
 04 <0f> 0b eb fe 4d 85 ed 74 1a 9c fa 65 48 8b 04 25 a0 cb 00 00 48=20
[   59.961515] RIP  [<ffffffff810800fc>] __ipipe_restore_root+0x87/0xb8
[   59.961515]  RSP <ffff88002be07cd8>
[   59.961515] ---[ end trace a7919e7f17c0a728 ]---
[   59.961515] Kernel panic - not syncing: Fatal exception in interrupt
[   59.961515] Pid: 350, comm: gatekeeper/0 Tainted: G      D W  2.6.31.1=
-xenomai-i2.4-06 #7
[   59.961515] Call Trace:
[   59.961515]  <NMI>  [<ffffffff8143d321>] panic+0x7a/0x11e
[   59.961515]  [<ffffffff8144074e>] oops_end+0x92/0x9f
[   59.961515]  [<ffffffff8100f219>] die+0x5a/0x63
[   59.961515]  [<ffffffff81440196>] do_trap+0x115/0x124
[   59.961515]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.961515]  [<ffffffff8100d340>] do_invalid_op+0x94/0x9d
[   59.961515]  [<ffffffff810800fc>] ? __ipipe_restore_root+0x87/0xb8
[   59.961515]  [<ffffffff81081191>] ? ipipe_trace_panic_dump+0x16/0x290
[   59.961515]  [<ffffffff8100f2b2>] ? show_trace+0x15/0x17
[   59.961515]  [<ffffffff8143d29e>] ? dump_stack+0x77/0x80
[   59.961515]  [<ffffffff81021f86>] __ipipe_handle_exception+0x3f0/0x409
[   59.961515]  [<ffffffff8100c51c>] invalid_op+0x1c/0x60
[   59.961515]  [<ffffffff810800fc>] ? __ipipe_restore_root+0x87/0xb8
[   59.961515]  [<ffffffff81056f39>] cpu_clock+0x5a/0x62
[   59.961515]  [<ffffffff8103d52a>] vprintk+0x233/0x354
[   59.961515]  [<ffffffff8103d61f>] ? vprintk+0x328/0x354
[   59.961515]  [<ffffffff8143d5ac>] printk+0x1e7/0x28a
[   59.961515]  [<ffffffff81440871>] die_nmi+0x56/0x18e
[   59.961515]  [<ffffffff81440de6>] default_nmi_watchdog_tick+0x12b/0x1a=
a
[   59.961515]  [<ffffffff8135bfe0>] rthal_nmi_watchdog_tick+0x88/0x114
[   59.961515]  [<ffffffff810561f0>] ? notify_die+0x2e/0x30
[   59.961515]  [<ffffffff8144040a>] do_nmi+0xd4/0x2ac
[   59.961515]  [<ffffffff8143ff2a>] nmi+0x1a/0x20
[   59.961515]  [<ffffffff8135c2f4>] ? rthal_nmi_arm+0xe1/0x176
[   59.961515]  <<EOE>>  [<ffffffff810a45bc>] xntimer_next_local_shot+0x1=
1b/0x120
[   59.961515]  [<ffffffff810a4707>] xntimer_tick_aperiodic+0x146/0x152
[   59.961515]  [<ffffffff8109db01>] xnintr_clock_handler+0x69/0x179
[   59.961515]  [<ffffffff8107ecd9>] __virq_end+0x68/0x1b2
[   59.961515]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.961515]  [<ffffffff8107f488>] ipipe_suspend_domain+0x19a/0x282
[   59.961515]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.961515]  [<ffffffff8107f6e8>] __ipipe_walk_pipeline+0x178/0x23c
[   59.961515]  [<ffffffff8107fcd8>] __ipipe_dispatch_wired_nocheck+0x1d8=
/0x1e7
[   59.961515]  [<ffffffff8107fdaa>] __ipipe_dispatch_wired+0xc3/0xcc
[   59.961515]  [<ffffffff81021477>] __ipipe_handle_irq+0x128/0x3ca
[   59.961515]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.961515]  [<ffffffff81021b6b>] ipipe_trigger_irq+0x71/0x9c
[   59.961515]  [<ffffffff8108006f>] ? __ipipe_unstall_root+0xd1/0xd7
[   59.961515]  [<ffffffff81030959>] ? raw_local_irq_enable+0xe/0x10
[   59.961515]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.961515]  [<ffffffff8100afd6>] ? ftrace_call+0x5/0x2b
[   59.961515]  [<ffffffff8109f037>] __xnpod_schedule+0xa0/0x6ae
[   59.961515]  [<ffffffff810a7ebf>] xnpod_schedule+0x32/0x34
[   59.961515]  [<ffffffff810a803a>] gatekeeper_thread+0x179/0x18f
[   59.961515]  [<ffffffff8103766d>] ? default_wake_function+0x0/0x14
[   59.961515]  [<ffffffff81061656>] ? raw_local_irq_restore+0x19/0x1b
[   59.961515]  [<ffffffff8143f874>] ? _spin_unlock_irqrestore+0x16/0x18
[   59.961515]  [<ffffffff810a7ec1>] ? gatekeeper_thread+0x0/0x18f
[   59.961515]  [<ffffffff810521ba>] kthread+0x8f/0x97
[   59.961515]  [<ffffffff8100c9ba>] child_rip+0xa/0x20
[   59.961515]  [<ffffffff8105212b>] ? kthread+0x0/0x97
[   59.961515]  [<ffffffff8100c9b0>] ? child_rip+0x0/0x20

--------------080500090604080700030008--

