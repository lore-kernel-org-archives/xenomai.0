Message-ID: <920250.14934.qm@domain.hid>
Date: Thu, 5 May 2011 09:30:47 +0100 (BST)
From: Franz Engel <franz_lambert_engel@domain.hid>
In-Reply-To: <4DC2457A.8020506@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-598098314-1304584247=:14934"
Subject: Re: [Xenomai-help] Problem with the configuration of new system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--0-598098314-1304584247=:14934
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

>On 2011-05-05 07:30, Franz Engel wrote:
>> Hi,
>>=20
>> =0AAfter some days to learn how I receive logs on another PC, here is my=
 =0Alog. The problem is that the PC hangs after a few seconds.=20
>> =A0=A0=A0=20
>> =A0=A0=A0 pre { font-family: "Liberation Serif"; }p { margin-bottom: 0.2=
1cm; }
>>=20
>> #[?25l#[H#[J#[2;25HGNU GRUB=A0 version 1.98-1ubuntu10
>>=20
>>=20
>>=0A [=A0 =A0 0.000000] Linux version 2.6.32.20-adeos (root@domain.hid=
) (gcc=0A version 4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #1 SMP Wed May 4 22:06:49=
 CEST =0A2011

>Can you retry with a recent 2.6.37? .32 is unmaintained (ipipe-wise) for
>quite a while now, and many patches were developed since then.

>Jan

[=A0=A0=A0 0.000000] Initializing cgroup subsys cpu=0D
[=A0=A0=A0 0.000000] Linux version 2.6.37.6 (root@domain.hid) (gcc vers=
ion 4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #1 SMP Thu May 5 10:09:01 CEST 2011=0D
[=A0=A0=A0 0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-2.6.37.6 root=
=3D/dev/sda1 ro console=3DttyS0, 38400 console=3Dtty0=0D
[=A0=A0=A0 0.000000] BIOS-provided physical RAM map:=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 0000000000000000 - 000000000009fc00 (usa=
ble)=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 000000000009fc00 - 00000000000a0000 (res=
erved)=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000000e5000 - 0000000000100000 (res=
erved)=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 0000000000100000 - 00000000bf780000 (usa=
ble)=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000bf78e000 - 00000000bf790000 (res=
erved)=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000bf790000 - 00000000bf79e000 (ACP=
I data)=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000bf79e000 - 00000000bf7d0000 (ACP=
I NVS)=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000bf7d0000 - 00000000bf7e0000 (res=
erved)=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000bf7ed000 - 00000000c0000000 (res=
erved)=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000e0000000 - 00000000f0000000 (res=
erved)=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000fee00000 - 00000000fee01000 (res=
erved)=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000ffe00000 - 0000000100000000 (res=
erved)=0D
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 0000000100000000 - 0000000340000000 (usa=
ble)=0D
[=A0=A0=A0 0.000000] NX (Execute Disable) protection: active=0D
[=A0=A0=A0 0.000000] DMI present.=0D
[=A0=A0=A0 0.000000] No AGP bridge found=0D
[=A0=A0=A0 0.000000] last_pfn =3D 0x340000 max_arch_pfn =3D 0x400000000=0D
[=A0=A0=A0 0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701=
0600070106=0D
[=A0=A0=A0 0.000000] last_pfn =3D 0xbf780 max_arch_pfn =3D 0x400000000=0D
[=A0=A0=A0 0.000000] found SMP MP-table at [ffff8800000ff780] ff780=0D
[=A0=A0=A0 0.000000] Using GB pages for direct mapping=0D
[=A0=A0=A0 0.000000] init_memory_mapping: 0000000000000000-00000000bf780000=
=0D
[=A0=A0=A0 0.000000] init_memory_mapping: 0000000100000000-0000000340000000=
=0D
[=A0=A0=A0 0.000000] ACPI: RSDP 00000000000fb620 00024 (v02 ACPIAM)=0D
[=A0=A0=A0 0.000000] ACPI: XSDT 00000000bf790100 00084 (v01 062810 XSDT1507=
 20100628 MSFT 00000097)=0D
[=A0=A0=A0 0.000000] ACPI: FACP 00000000bf790290 000F4 (v03 062810 FACP1507=
 20100628 MSFT 00000097)=0D
[=A0=A0=A0 0.000000] ACPI: DSDT 00000000bf790540 05B3D (v01=A0 S0081 S00810=
02 00000002 INTL 20060113)=0D
[=A0=A0=A0 0.000000] ACPI: FACS 00000000bf79e000 00040=0D
[=A0=A0=A0 0.000000] ACPI: APIC 00000000bf790390 0011E (v01 062810 APIC1507=
 20100628 MSFT 00000097)=0D
[=A0=A0=A0 0.000000] ACPI: MCFG 00000000bf7904b0 0003C (v01 062810 OEMMCFG=
=A0 20100628 MSFT 00000097)=0D
[=A0=A0=A0 0.000000] ACPI: SPMI 00000000bf7904f0 00041 (v05 062810 OEMSPMI=
=A0 20100628 MSFT 00000097)=0D
[=A0=A0=A0 0.000000] ACPI: OEMB 00000000bf79e040 00072 (v01 062810 OEMB1507=
 20100628 MSFT 00000097)=0D
[=A0=A0=A0 0.000000] ACPI: SRAT 00000000bf798540 00168 (v01 062810 OEMSRAT=
=A0 00000001 INTL 00000001)=0D
[=A0=A0=A0 0.000000] ACPI: HPET 00000000bf7986b0 00038 (v01 062810 OEMHPET=
=A0 20100628 MSFT 00000097)=0D
[=A0=A0=A0 0.000000] ACPI: SSDT 00000000bf7a17f0 0154F (v01 DpgPmm=A0=A0=A0=
 CpuPm 00000012 INTL 20060113)=0D
[=A0=A0=A0 0.000000] ACPI: EINJ 00000000bf7986f0 00130 (v01=A0 AMIER AMI_EI=
NJ 20100628 MSFT 00000097)=0D
[=A0=A0=A0 0.000000] ACPI: BERT 00000000bf798880 00030 (v01=A0 AMIER AMI_BE=
RT 20100628 MSFT 00000097)=0D
[=A0=A0=A0 0.000000] ACPI: ERST 00000000bf7988b0 001B0 (v01=A0 AMIER AMI_ER=
ST 20100628 MSFT 00000097)=0D
[=A0=A0=A0 0.000000] ACPI: HEST 00000000bf798a60 000A8 (v01=A0 AMIER ABC_HE=
ST 20100628 MSFT 00000097)=0D
[=A0=A0=A0 0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0=0D
[=A0=A0=A0 0.000000] SRAT: PXM 1 -> APIC 0x20 -> Node 1=0D
[=A0=A0=A0 0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0=0D
[=A0=A0=A0 0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0=0D
[=A0=A0=A0 0.000000] SRAT: PXM 0 -> APIC 0x10 -> Node 0=0D
[=A0=A0=A0 0.000000] SRAT: PXM 0 -> APIC 0x12 -> Node 0=0D
[=A0=A0=A0 0.000000] SRAT: PXM 0 -> APIC 0x14 -> Node 0=0D
[=A0=A0=A0 0.000000] SRAT: PXM 1 -> APIC 0x22 -> Node 1=0D
[=A0=A0=A0 0.000000] SRAT: PXM 1 -> APIC 0x24 -> Node 1=0D
[=A0=A0=A0 0.000000] SRAT: PXM 1 -> APIC 0x30 -> Node 1=0D
[=A0=A0=A0 0.000000] SRAT: PXM 1 -> APIC 0x32 -> Node 1=0D
[=A0=A0=A0 0.000000] SRAT: PXM 1 -> APIC 0x34 -> Node 1=0D
[=A0=A0=A0 0.000000] SRAT: Node 0 PXM 0 0-c0000000=0D
[=A0=A0=A0 0.000000] SRAT: Node 0 PXM 0 100000000-1c0000000=0D
[=A0=A0=A0 0.000000] SRAT: Node 1 PXM 1 1c0000000-340000000=0D
[=A0=A0=A0 0.000000] SRAT: Node 0 [0,c0000000) + [100000000,1c0000000) -> [=
0,1c0000000)=0D
[=A0=A0=A0 0.000000] Initmem setup node 0 0000000000000000-00000001c0000000=
=0D
[=A0=A0=A0 0.000000]=A0=A0 NODE_DATA [00000001bfffb000 - 00000001bfffffff]=
=0D
[=A0=A0=A0 0.000000] Initmem setup node 1 00000001c0000000-0000000340000000=
=0D
[=A0=A0=A0 0.000000]=A0=A0 NODE_DATA [000000033fffb000 - 000000033fffffff]=
=0D
[=A0=A0=A0 0.000000] Zone PFN ranges:=0D
[=A0=A0=A0 0.000000]=A0=A0 DMA=A0=A0=A0=A0=A0 0x00000010 -> 0x00001000=0D
[=A0=A0=A0 0.000000]=A0=A0 DMA32=A0=A0=A0 0x00001000 -> 0x00100000=0D
[=A0=A0=A0 0.000000]=A0=A0 Normal=A0=A0 0x00100000 -> 0x00340000=0D
[=A0=A0=A0 0.000000] Movable zone start PFN for each node=0D
[=A0=A0=A0 0.000000] early_node_map[4] active PFN ranges=0D
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 0: 0x00000010 -> 0x0000009f=0D
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 0: 0x00000100 -> 0x000bf780=0D
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 0: 0x00100000 -> 0x001c0000=0D
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 1: 0x001c0000 -> 0x00340000=0D
[=A0=A0=A0 0.000000] ACPI: PM-Timer IO Port: 0x808=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x10] enabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x12] enabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x14] enabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x20] enabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x22] enabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x24] enabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x30] enabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x32] enabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x34] enabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x8c] disabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x8d] disabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x8e] disabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x8f] disabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x11] lapic_id[0x90] disabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x12] lapic_id[0x91] disabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x13] lapic_id[0x92] disabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x14] lapic_id[0x93] disabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x15] lapic_id[0x94] disabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x16] lapic_id[0x95] disabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x17] lapic_id[0x96] disabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x18] lapic_id[0x97] disabled)=0D
[=A0=A0=A0 0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])=
=0D
[=A0=A0=A0 0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0]=
)=0D
[=A0=A0=A0 0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, =
GSI 0-23=0D
[=A0=A0=A0 0.000000] ACPI: IOAPIC (id[0x03] address[0xfec8a000] gsi_base[24=
])=0D
[=A0=A0=A0 0.000000] IOAPIC[1]: apic_id 3, version 32, address 0xfec8a000, =
GSI 24-47=0D
[=A0=A0=A0 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl df=
l)=0D
[=A0=A0=A0 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high l=
evel)=0D
[=A0=A0=A0 0.000000] Using ACPI (MADT) for SMP configuration information=0D
[=A0=A0=A0 0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000=0D
[=A0=A0=A0 0.000000] SMP: Allowing 24 CPUs, 12 hotplug CPUs=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 000000000009f000 - 00000=
000000a0000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000=
000000e5000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000000e5000 - 00000=
00000100000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000bf780000 - 00000=
000bf78e000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000bf78e000 - 00000=
000bf790000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000bf790000 - 00000=
000bf79e000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000bf79e000 - 00000=
000bf7d0000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000bf7d0000 - 00000=
000bf7e0000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000bf7e0000 - 00000=
000bf7ed000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000bf7ed000 - 00000=
000c0000000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000c0000000 - 00000=
000e0000000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000=
000f0000000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000f0000000 - 00000=
000fee00000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000=
000fee01000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000=
000ffe00000=0D
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000ffe00000 - 00000=
00100000000=0D
[=A0=A0=A0 0.000000] Allocating PCI resources starting at c0000000 (gap: c0=
000000:20000000)=0D
[=A0=A0=A0 0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids=
:24 nr_node_ids:2=0D
[=A0=A0=A0 0.000000] PERCPU: Embedded 62 pages/cpu @ffff8800bee00000 s22406=
4 r8192 d21696 u262144=0D
[=A0=A0=A0 0.000000] Built 2 zonelists in Zone order, mobility grouping on.=
=A0 Total pages: 3096841=0D
[=A0=A0=A0 0.000000] Policy zone: Normal=0D
[=A0=A0=A0 0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-2.6.37=
.6 root=3D/dev/sda1 ro console=3DttyS0, 38400 console=3Dtty0=0D
[=A0=A0=A0 0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)=
=0D
[=A0=A0=A0 0.000000] Checking aperture...=0D
[=A0=A0=A0 0.000000] No AGP bridge found=0D
[=A0=A0=A0 0.000000] Memory: 12315164k/13631488k available (5797k kernel co=
de, 1057732k absent, 258592k reserved, 4946k data, 940k init)=0D
[=A0=A0=A0 0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Order=3D0-3, MinObj=
ects=3D0, CPUs=3D24, Nodes=3D2=0D
[=A0=A0=A0 0.000000] Hierarchical RCU implementation.=0D
[=A0=A0=A0 0.000000] =A0=A0=A0 RCU-based detection of stalled CPUs is disab=
led.=0D
[=A0=A0=A0 0.000000] NR_IRQS:4352 nr_irqs:1280 16=0D
[=A0=A0=A0 0.000000] Extended CMOS year: 2000=0D
[=A0=A0=A0 0.000000] I-pipe 2.9-01: pipeline enabled.=0D
[=A0=A0=A0 0.000000] Console: colour VGA+ 80x25=0D
[=A0=A0=A0 0.000000] console [tty0] enabled=0D
[=A0=A0=A0 0.000000] console [ttyS0] enabled=0D
[=A0=A0=A0 0.000000] allocated 125829120 bytes of page_cgroup=0D
[=A0=A0=A0 0.000000] please try 'cgroup_disable=3Dmemory' option if you don=
't want memory cgroups=0D
[=A0=A0=A0 0.000000] Fast TSC calibration using PIT=0D
[=A0=A0=A0 0.010000] Detected 2666.457 MHz processor.=0D
[=A0=A0=A0 0.000010] Calibrating delay loop (skipped), value calculated usi=
ng timer frequency.. 5332.91 BogoMIPS (lpj=3D26664570)=0D
[=A0=A0=A0 0.032212] pid_max: default: 32768 minimum: 301=0D
[=A0=A0=A0 0.046124] Security Framework initialized=0D
[=A0=A0=A0 0.058456] AppArmor: AppArmor initialized=0D
[=A0=A0=A0 0.072177] Dentry cache hash table entries: 2097152 (order: 12, 1=
6777216 bytes)=0D
[=A0=A0=A0 0.097914] Inode-cache hash table entries: 1048576 (order: 11, 83=
88608 bytes)=0D
[=A0=A0=A0 0.120977] Mount-cache hash table entries: 256=0D
[=A0=A0=A0 0.134742] Initializing cgroup subsys ns=0D
[=A0=A0=A0 0.146828] ns_cgroup deprecated: consider using the 'clone_childr=
en' flag without the ns_cgroup.=0D
[=A0=A0=A0 0.173502] Initializing cgroup subsys cpuacct=0D
[=A0=A0=A0 0.187753] Initializing cgroup subsys memory=0D
[=A0=A0=A0 0.200873] Initializing cgroup subsys devices=0D
[=A0=A0=A0 0.214246] Initializing cgroup subsys freezer=0D
[=A0=A0=A0 0.227610] Initializing cgroup subsys net_cls=0D
[=A0=A0=A0 0.241002] CPU: Physical Processor ID: 0=0D
[=A0=A0=A0 0.253064] CPU: Processor Core ID: 0=0D
[=A0=A0=A0 0.264092] mce: CPU supports 9 MCE banks=0D
[=A0=A0=A0 0.276162] CPU0: Thermal monitoring enabled (TM1)=0D
[=A0=A0=A0 0.290590] Performance Events: PEBS fmt1+, Westmere events, Intel=
 PMU driver.=0D
[=A0=A0=A0 0.312527] ... version:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 3=0D
[=A0=A0=A0 0.324592] ... bit width:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
48=0D
[=A0=A0=A0 0.336917] ... generic registers:=A0=A0=A0=A0=A0 4=0D
[=A0=A0=A0 0.348982] ... value mask:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00=
00ffffffffffff=0D
[=A0=A0=A0 0.364946] ... max period:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00=
0000007fffffff=0D
[=A0=A0=A0 0.380911] ... fixed-purpose events:=A0=A0 3=0D
[=A0=A0=A0 0.392975] ... event mask:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00=
0000070000000f=0D
[=A0=A0=A0 0.409057] ACPI: Core revision 20101013=0D
[=A0=A0=A0 0.452149] ftrace: allocating 21658 entries in 85 pages=0D
[=A0=A0=A0 0.473904] Setting APIC routing to physical flat=0D
[=A0=A0=A0 0.488481] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 p=
in2=3D-1=0D
[=A0=A0=A0 0.606546] ..MP-BIOS bug: 8254 timer not connected to IO-APIC=0D
[=A0=A0=A0 0.624096] ...trying to set up timer (IRQ0) through the 8259A ...=
=0D
[=A0=A0=A0 0.642688] ..... (found apic 0 pin 2) ...=0D
[=A0=A0=A0 0.755620] ....... works.=0D
[=A0=A0=A0 0.763800] CPU0: Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 X5650=A0 @ 2.67GHz stepping 02=0D
[=A0=A0=A0 0.904246] Booting Node=A0=A0 0, Processors=A0 #1 #2 #3 #4 #5 Ok.=
=0D
[=A0=A0=A0 1.815952] Booting Node=A0=A0 1, Processors=A0 #6 #7 #8 #9 #10 #1=
1=0D
[=A0=A0=A0 2.904211] Brought up 12 CPUs=0D
[=A0=A0=A0 2.914024] Total of 12 processors activated (64001.38 BogoMIPS).=
=0D
[=A0=A0=A0 2.939799] devtmpfs: initialized=0D
[=A0=A0=A0 2.950023] regulator: core version 0.5=0D
[=A0=A0=A0 2.961609] regulator: dummy:=A0=0D
[=A0=A0=A0 2.970829] Time:=A0 8:28:48=A0 Date: 05/05/11=0D
[=A0=A0=A0 2.983192] NET: Registered protocol family 16=0D
[=A0=A0=A0 2.997423] ACPI: bus type pci registered=0D
[=A0=A0=A0 3.009577] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0=
000000-0xefffffff] (base 0xe0000000)=0D
[=A0=A0=A0 3.037557] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved =
in E820=0D
[=A0=A0=A0 3.084430] PCI: Using configuration type 1 for base access=0D
[=A0=A0=A0 3.101880] bio: create slab <bio-0> at 0=0D
[=A0=A0=A0 3.116740] ACPI: Executed 1 blocks of module-level executable AML=
 code=0D
[=A0=A0=A0 3.184411] ACPI: SSDT 00000000bf79e0c0 029DC (v01 DpgPmm=A0 P001I=
st 00000011 INTL 20060113)=0D
[=A0=A0=A0 3.209925] ACPI: Dynamic OEM Table Load:=0D
[=A0=A0=A0 3.222136] ACPI: SSDT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (null) 029DC =
(v01 DpgPmm=A0 P001Ist 00000011 INTL 20060113)=0D
[=A0=A0=A0 3.247414] ACPI: SSDT 00000000bf7a0aa0 007FC (v01=A0 PmRef=A0 P00=
1Cst 00003001 INTL 20060113)=0D
[=A0=A0=A0 3.273697] ACPI: Dynamic OEM Table Load:=0D
[=A0=A0=A0 3.285914] ACPI: SSDT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (null) 007FC =
(v01=A0 PmRef=A0 P001Cst 00003001 INTL 20060113)=0D
[=A0=A0=A0 3.311132] ACPI: SSDT 00000000bf7a12a0 0054E (v01=A0 PmRef=A0 Cpu=
0Tst 00003000 INTL 20060113)=0D
[=A0=A0=A0 3.336568] ACPI: Dynamic OEM Table Load:=0D
[=A0=A0=A0 3.348786] ACPI: SSDT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (null) 0054E =
(v01=A0 PmRef=A0 Cpu0Tst 00003000 INTL 20060113)=0D
[=A0=A0=A0 3.395232] ACPI: Interpreter enabled=0D
[=A0=A0=A0 3.406277] ACPI: (supports S0 S1 S4 S5)=0D
[=A0=A0=A0 3.418390] ACPI: Using IOAPIC for interrupt routing=0D
[=A0=A0=A0 3.434716] ACPI Exception: AE_NOT_FOUND, Evaluating _PRW (2010101=
3/scan-723)=0D
[=A0=A0=A0 3.456624] ACPI Exception: AE_NOT_FOUND, Evaluating _PRW (2010101=
3/scan-723)=0D
[=A0=A0=A0 3.484729] ACPI: No dock devices found.=0D
[=A0=A0=A0 3.496554] PCI: Using host bridge windows from ACPI; if necessary=
, use "pci=3Dnocrs" and report a bug=0D
[=A0=A0=A0 3.524820] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])=
=0D
[=A0=A0=A0 3.543627] pci_root PNP0A08:00: host bridge window [io=A0 0x0000-=
0x0cf7]=0D
[=A0=A0=A0 3.563504] pci_root PNP0A08:00: host bridge window [io=A0 0x0d00-=
0xffff]=0D
[=A0=A0=A0 3.583394] pci_root PNP0A08:00: host bridge window [mem 0x000a000=
0-0x000bffff]=0D
[=A0=A0=A0 3.605391] pci_root PNP0A08:00: host bridge window [mem 0x000d000=
0-0x000dffff]=0D
[=A0=A0=A0 3.627390] pci_root PNP0A08:00: host bridge window [mem 0xc000000=
0-0xdfffffff]=0D
[=A0=A0=A0 3.649383] pci_root PNP0A08:00: host bridge window [mem 0xf000000=
0-0xfed8ffff]=0D
[=A0=A0=A0 3.674037] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at =
0ca0 (mask 0003)=0D
[=A0=A0=A0 3.696814] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 4 PIO at =
0294 (mask 0003)=0D
[=A0=A0=A0 3.719880] pci 0000:00:01.0: PCI bridge to [bus 0b-0b]=0D
[=A0=A0=A0 3.735646] pci 0000:00:02.0: PCI bridge to [bus 0a-0a]=0D
[=A0=A0=A0 3.751403] pci 0000:00:03.0: PCI bridge to [bus 09-09]=0D
[=A0=A0=A0 3.768017] pci 0000:00:07.0: PCI bridge to [bus 08-08]=0D
[=A0=A0=A0 3.783774] pci 0000:00:08.0: PCI bridge to [bus 07-07]=0D
[=A0=A0=A0 3.799529] pci 0000:00:09.0: PCI bridge to [bus 06-06]=0D
[=A0=A0=A0 3.815286] pci 0000:00:0a.0: PCI bridge to [bus 05-05]=0D
[=A0=A0=A0 3.831046] pci 0000:00:1c.0: PCI bridge to [bus 04-04]=0D
[=A0=A0=A0 3.864166] pci 0000:00:1c.4: PCI bridge to [bus 03-03]=0D
[=A0=A0=A0 3.894164] pci 0000:00:1c.5: PCI bridge to [bus 02-02]=0D
[=A0=A0=A0 3.910059] pci 0000:00:1e.0: PCI bridge to [bus 01-01] (subtracti=
ve decode)=0D
[=A0=A0=A0 3.954669] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11 1=
2 14 15)=0D
[=A0=A0=A0 3.976233] ACPI: PCI Interrupt Link [LNKB] (IRQs *5)=0D
[=A0=A0=A0 3.991707] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 *7 10 11 1=
2 14 15)=0D
[=A0=A0=A0 4.013257] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 *10 11 1=
2 14 15)=0D
[=A0=A0=A0 4.035567] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12=
 14 15) *0, disabled.=0D
[=A0=A0=A0 4.060682] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12=
 14 *15)=0D
[=A0=A0=A0 4.082237] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 6 7 10 11 12=
 *14 15)=0D
[=A0=A0=A0 4.103793] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 10 *11 1=
2 14 15)=0D
[=A0=A0=A0 4.125385] vgaarb: device added: PCI:0000:01:01.0,decodes=3Dio+me=
m,owns=3Dio+mem,locks=3Dnone=0D
[=A0=A0=A0 4.149722] vgaarb: loaded=0D
[=A0=A0=A0 4.157951] SCSI subsystem initialized=0D
[=A0=A0=A0 4.169334] usbcore: registered new interface driver usbfs=0D
[=A0=A0=A0 4.185844] usbcore: registered new interface driver hub=0D
[=A0=A0=A0 4.201850] usbcore: registered new device driver usb=0D
[=A0=A0=A0 4.217206] wmi: Mapper loaded=0D
[=A0=A0=A0 4.226424] PCI: Using ACPI for IRQ routing=0D
[=A0=A0=A0 4.239200] NetLabel: Initializing=0D
[=A0=A0=A0 4.249459] NetLabel:=A0 domain hash size =3D 128=0D
[=A0=A0=A0 4.262564] NetLabel:=A0 protocols =3D UNLABELED CIPSOv4=0D
[=A0=A0=A0 4.278173] NetLabel:=A0 unlabeled traffic allowed by default=0D
[=A0=A0=A0 4.294964] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0=0D
[=A0=A0=A0 4.310820] hpet0: 4 comparators, 64-bit 14.318180 MHz counter=0D
[=A0=A0=A0 4.330393] Switching to clocksource tsc=0D
[=A0=A0=A0 4.343584] AppArmor: AppArmor Filesystem Enabled=0D
[=A0=A0=A0 4.357764] pnp: PnP ACPI init=0D
[=A0=A0=A0 4.366993] ACPI: bus type pnp registered=0D
[=A0=A0=A0 4.381589] pnp: PnP ACPI: found 16 devices=0D
[=A0=A0=A0 4.394183] ACPI: ACPI bus type pnp unregistered=0D
[=A0=A0=A0 4.408098] system 00:01: [mem 0xfbf00000-0xfbffffff] has been res=
erved=0D
[=A0=A0=A0 4.427982] system 00:01: [mem 0xfc000000-0xfcffffff] has been res=
erved=0D
[=A0=A0=A0 4.447874] system 00:01: [mem 0xfd000000-0xfdffffff] has been res=
erved=0D
[=A0=A0=A0 4.467764] system 00:01: [mem 0xfe000000-0xfebfffff] has been res=
erved=0D
[=A0=A0=A0 4.487655] system 00:01: [mem 0xfec8a000-0xfec8afff] could not be=
 reserved=0D
[=A0=A0=A0 4.508585] system 00:01: [mem 0xfed10000-0xfed10fff] has been res=
erved=0D
[=A0=A0=A0 4.528478] system 00:06: [io=A0 0x0290-0x029f] has been reserved=
=0D
[=A0=A0=A0 4.547172] system 00:07: [io=A0 0x04d0-0x04d1] has been reserved=
=0D
[=A0=A0=A0 4.564982] system 00:07: [io=A0 0x0ca0-0x0caf] has been reserved=
=0D
[=A0=A0=A0 4.582792] system 00:07: [io=A0 0x0800-0x087f] has been reserved=
=0D
[=A0=A0=A0 4.600605] system 00:07: [io=A0 0x0500-0x057f] has been reserved=
=0D
[=A0=A0=A0 4.618414] system 00:07: [mem 0xfed1c000-0xfed1ffff] has been res=
erved=0D
[=A0=A0=A0 4.638305] system 00:07: [mem 0xfed20000-0xfed3ffff] has been res=
erved=0D
[=A0=A0=A0 4.658195] system 00:07: [mem 0xfed40000-0xfed8ffff] has been res=
erved=0D
[=A0=A0=A0 4.678087] system 00:0b: [mem 0xfec00000-0xfec00fff] could not be=
 reserved=0D
[=A0=A0=A0 4.699015] system 00:0b: [mem 0xfee00000-0xfee00fff] has been res=
erved=0D
[=A0=A0=A0 4.718909] system 00:0e: [mem 0xe0000000-0xefffffff] has been res=
erved=0D
[=A0=A0=A0 4.738802] system 00:0f: [mem 0x00000000-0x0009ffff] could not be=
 reserved=0D
[=A0=A0=A0 4.759729] system 00:0f: [mem 0x000c0000-0x000cffff] has been res=
erved=0D
[=A0=A0=A0 4.779618] system 00:0f: [mem 0x000e0000-0x000fffff] could not be=
 reserved=0D
[=A0=A0=A0 4.801356] system 00:0f: [mem 0x00100000-0xbfffffff] could not be=
 reserved=0D
[=A0=A0=A0 4.822286] system 00:0f: [mem 0xfed90000-0xffffffff] could not be=
 reserved=0D
[=A0=A0=A0 4.849053] pci 0000:00:1c.0: BAR 14: assigned [mem 0xc0000000-0xc=
01fffff]=0D
[=A0=A0=A0 4.869715] pci 0000:00:1c.0: BAR 15: assigned [mem 0xc0200000-0xc=
03fffff 64bit pref]=0D
[=A0=A0=A0 4.893272] pci 0000:00:1c.4: BAR 15: assigned [mem 0xc0400000-0xc=
05fffff 64bit pref]=0D
[=A0=A0=A0 4.916826] pci 0000:00:1c.5: BAR 15: assigned [mem 0xc0600000-0xc=
07fffff 64bit pref]=0D
[=A0=A0=A0 4.940383] pci 0000:00:1c.0: BAR 13: assigned [io=A0 0x1000-0x1ff=
f]=0D
[=A0=A0=A0 4.958973] pci 0000:00:01.0: PCI bridge to [bus 0b-0b]=0D
[=A0=A0=A0 4.974704] pci 0000:00:01.0:=A0=A0 bridge window [io=A0 disabled]=
=0D
[=A0=A0=A0 4.991734] pci 0000:00:01.0:=A0=A0 bridge window [mem disabled]=
=0D
[=A0=A0=A0 5.008765] pci 0000:00:01.0:=A0=A0 bridge window [mem pref disabl=
ed]=0D
[=A0=A0=A0 5.027097] pci 0000:00:02.0: PCI bridge to [bus 0a-0a]=0D
[=A0=A0=A0 5.043606] pci 0000:00:02.0:=A0=A0 bridge window [io=A0 disabled]=
=0D
[=A0=A0=A0 5.060638] pci 0000:00:02.0:=A0=A0 bridge window [mem disabled]=
=0D
[=A0=A0=A0 5.077669] pci 0000:00:02.0:=A0=A0 bridge window [mem pref disabl=
ed]=0D
[=A0=A0=A0 5.096001] pci 0000:00:03.0: PCI bridge to [bus 09-09]=0D
[=A0=A0=A0 5.111727] pci 0000:00:03.0:=A0=A0 bridge window [io=A0 disabled]=
=0D
[=A0=A0=A0 5.128761] pci 0000:00:03.0:=A0=A0 bridge window [mem disabled]=
=0D
[=A0=A0=A0 5.145791] pci 0000:00:03.0:=A0=A0 bridge window [mem pref disabl=
ed]=0D
[=A0=A0=A0 5.164125] pci 0000:00:07.0: PCI bridge to [bus 08-08]=0D
[=A0=A0=A0 5.179850] pci 0000:00:07.0:=A0=A0 bridge window [io=A0 disabled]=
=0D
[=A0=A0=A0 5.196883] pci 0000:00:07.0:=A0=A0 bridge window [mem disabled]=
=0D
[=A0=A0=A0 5.213913] pci 0000:00:07.0:=A0=A0 bridge window [mem pref disabl=
ed]=0D
[=A0=A0=A0 5.232246] pci 0000:00:08.0: PCI bridge to [bus 07-07]=0D
[=A0=A0=A0 5.247972] pci 0000:00:08.0:=A0=A0 bridge window [io=A0 disabled]=
=0D
[=A0=A0=A0 5.265005] pci 0000:00:08.0:=A0=A0 bridge window [mem disabled]=
=0D
[=A0=A0=A0 5.282036] pci 0000:00:08.0:=A0=A0 bridge window [mem pref disabl=
ed]=0D
[=A0=A0=A0 5.301174] pci 0000:00:09.0: PCI bridge to [bus 06-06]=0D
[=A0=A0=A0 5.316900] pci 0000:00:09.0:=A0=A0 bridge window [io=A0 disabled]=
=0D
[=A0=A0=A0 5.333933] pci 0000:00:09.0:=A0=A0 bridge window [mem disabled]=
=0D
[=A0=A0=A0 5.350963] pci 0000:00:09.0:=A0=A0 bridge window [mem pref disabl=
ed]=0D
[=A0=A0=A0 5.369296] pci 0000:00:0a.0: PCI bridge to [bus 05-05]=0D
[=A0=A0=A0 5.385024] pci 0000:00:0a.0:=A0=A0 bridge window [io=A0 disabled]=
=0D
[=A0=A0=A0 5.402056] pci 0000:00:0a.0:=A0=A0 bridge window [mem disabled]=
=0D
[=A0=A0=A0 5.419086] pci 0000:00:0a.0:=A0=A0 bridge window [mem pref disabl=
ed]=0D
[=A0=A0=A0 5.437419] pci 0000:00:1c.0: PCI bridge to [bus 04-04]=0D
[=A0=A0=A0 5.453148] pci 0000:00:1c.0:=A0=A0 bridge window [io=A0 0x1000-0x=
1fff]=0D
[=A0=A0=A0 5.471480] pci 0000:00:1c.0:=A0=A0 bridge window [mem 0xc0000000-=
0xc01fffff]=0D
[=A0=A0=A0 5.491889] pci 0000:00:1c.0:=A0=A0 bridge window [mem 0xc0200000-=
0xc03fffff 64bit pref]=0D
[=A0=A0=A0 5.515188] pci 0000:00:1c.4: PCI bridge to [bus 03-03]=0D
[=A0=A0=A0 5.530917] pci 0000:00:1c.4:=A0=A0 bridge window [io=A0 0xe000-0x=
efff]=0D
[=A0=A0=A0 5.549247] pci 0000:00:1c.4:=A0=A0 bridge window [mem 0xfbe00000-=
0xfbefffff]=0D
[=A0=A0=A0 5.570438] pci 0000:00:1c.4:=A0=A0 bridge window [mem 0xc0400000-=
0xc05fffff 64bit pref]=0D
[=A0=A0=A0 5.593736] pci 0000:00:1c.5: PCI bridge to [bus 02-02]=0D
[=A0=A0=A0 5.609465] pci 0000:00:1c.5:=A0=A0 bridge window [io=A0 0xd000-0x=
dfff]=0D
[=A0=A0=A0 5.627797] pci 0000:00:1c.5:=A0=A0 bridge window [mem 0xfbd00000-=
0xfbdfffff]=0D
[=A0=A0=A0 5.648206] pci 0000:00:1c.5:=A0=A0 bridge window [mem 0xc0600000-=
0xc07fffff 64bit pref]=0D
[=A0=A0=A0 5.671505] pci 0000:00:1e.0: PCI bridge to [bus 01-01]=0D
[=A0=A0=A0 5.687234] pci 0000:00:1e.0:=A0=A0 bridge window [io=A0 0xc000-0x=
cfff]=0D
[=A0=A0=A0 5.705567] pci 0000:00:1e.0:=A0=A0 bridge window [mem 0xfaf00000-=
0xfb7fffff]=0D
[=A0=A0=A0 5.725975] pci 0000:00:1e.0:=A0=A0 bridge window [mem pref disabl=
ed]=0D
[=A0=A0=A0 5.744349] pci 0000:00:1c.0: enabling device (0104 -> 0107)=0D
[=A0=A0=A0 5.761367] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> =
IRQ 17=0D
[=A0=A0=A0 5.781520] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> =
IRQ 17=0D
[=A0=A0=A0 5.801673] pci 0000:00:1c.5: PCI INT B -> GSI 16 (level, low) -> =
IRQ 16=0D
[=A0=A0=A0 5.822620] NET: Registered protocol family 2=0D
[=A0=A0=A0 5.836116] IP route cache hash table entries: 524288 (order: 10, =
4194304 bytes)=0D
[=A0=A0=A0 5.859630] TCP established hash table entries: 524288 (order: 11,=
 8388608 bytes)=0D
[=A0=A0=A0 5.883566] TCP bind hash table entries: 65536 (order: 8, 1048576 =
bytes)=0D
[=A0=A0=A0 5.903886] TCP: Hash tables configured (established 524288 bind 6=
5536)=0D
[=A0=A0=A0 5.923765] TCP reno registered=0D
[=A0=A0=A0 5.934161] UDP hash table entries: 8192 (order: 6, 262144 bytes)=
=0D
[=A0=A0=A0 5.952568] UDP-Lite hash table entries: 8192 (order: 6, 262144 by=
tes)=0D
[=A0=A0=A0 5.972409] NET: Registered protocol family 1=0D
[=A0=A0=A0 5.985767] PCI-DMA: Using software bounce buffering for IO (SWIOT=
LB)=0D
[=A0=A0=A0 6.005123] Placing 64MB software IO TLB between ffff8800bae00000 =
- ffff8800bee00000=0D
[=A0=A0=A0 6.028420] software IO TLB at phys 0xbae00000 - 0xbee00000=0D
[=A0=A0=A0 6.045876] audit: initializing netlink socket (disabled)=0D
[=A0=A0=A0 6.062123] type=3D2000 audit(1304584127.130:1): initialized=0D
[=A0=A0=A0 6.088884] I-pipe: Domain Xenomai registered.=0D
[=A0=A0=A0 6.102518] Xenomai: hal/x86_64 started.=0D
[=A0=A0=A0 6.114349] Xenomai: scheduling class idle registered.=0D
[=A0=A0=A0 6.129794] Xenomai: scheduling class rt registered.=0D
[=A0=A0=A0 6.145957] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) l=
oaded.=0D
[=A0=A0=A0 6.166302] Xenomai: SMI-enabled chipset found, but SMI workaround=
 disabled=0D
[=A0=A0=A0 6.166303]=A0=A0=A0=A0=A0=A0=A0=A0=A0 (check CONFIG_XENO_HW_SMI_W=
ORKAROUND). You may encounter=0D
[=A0=A0=A0 6.166304]=A0=A0=A0=A0=A0=A0=A0=A0=A0 high interrupt latencies!=
=0D
[=A0=A0=A0 6.222214] Xenomai: starting native API services.=0D
[=A0=A0=A0 6.236634] Xenomai: starting POSIX services.=0D
[=A0=A0=A0 6.249786] Xenomai: starting RTDM services.=0D
[=A0=A0=A0 6.263337] HugeTLB registered 2 MB page size, pre-allocated 0 pag=
es=0D
[=A0=A0=A0 6.284003] VFS: Disk quotas dquot_6.5.2=0D
[=A0=A0=A0 6.295869] Dquot-cache hash table entries: 512 (order 0, 4096 byt=
es)=0D
[=A0=A0=A0 6.315820] fuse init (API version 7.15)=0D
[=A0=A0=A0 6.327723] msgmni has been set to 24053=0D
[=A0=A0=A0 6.339780] Block layer SCSI generic (bsg) driver version 0.4 load=
ed (major 253)=0D
[=A0=A0=A0 6.362036] io scheduler noop registered=0D
[=A0=A0=A0 6.373840] io scheduler deadline registered=0D
[=A0=A0=A0 6.386715] io scheduler cfq registered (default)=0D
[=A0=A0=A0 6.401070] pci_hotplug: PCI Hot Plug PCI Core version: 0.5=0D
[=A0=A0=A0 6.417852] pciehp: PCI Express Hot Plug Controller Driver version=
: 0.4=0D
[=A0=A0=A0 6.437827] input: Power Button as /devices/LNXSYSTM:00/device:00/=
PNP0C0C:00/input/input0=0D
[=A0=A0=A0 6.462429] ACPI: Power Button [PWRB]=0D
[=A0=A0=A0 6.473511] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:0=
0/input/input1=0D
[=A0=A0=A0 6.495759] ACPI: Power Button [PWRF]=0D
[=A0=A0=A0 6.508829] Linux agpgart interface v0.103=0D
[=A0=A0=A0 6.521179] Serial: 8250/16550 driver, 4 ports, IRQ sharing enable=
d=0D
[=A0=A0=A0 6.560516] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=
=0D
[=A0=A0=A0 6.722533] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A=
=0D
[=A0=A0=A0 7.242625] 00:09: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=0D
[=A0=A0=A0 7.402521] 00:0a: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A=0D
[=A0=A0=A0 7.543047] brd: module loaded=0D
[=A0=A0=A0 7.552721] loop: module loaded=0D
[=A0=A0=A0 7.562330] ata_piix 0000:00:1f.2: PCI INT A -> GSI 23 (level, low=
) -> IRQ 23=0D
[=A0=A0=A0 7.583788] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]=0D
[=A0=A0=A0 7.599919] scsi0 : ata_piix=0D
[=A0=A0=A0 7.608700] scsi1 : ata_piix=0D
[=A0=A0=A0 7.618693] ata1: SATA max UDMA/133 cmd 0xac00 ctl 0xa880 bmdma 0x=
a400 irq 23=0D
[=A0=A0=A0 7.640133] ata2: SATA max UDMA/133 cmd 0xa800 ctl 0xa480 bmdma 0x=
a408 irq 23=0D
[=A0=A0=A0 7.661595] ata_piix 0000:00:1f.5: PCI INT B -> GSI 21 (level, low=
) -> IRQ 21=0D
[=A0=A0=A0 7.683057] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]=0D
[=A0=A0=A0 7.699101] scsi2 : ata_piix=0D
[=A0=A0=A0 7.707888] scsi3 : ata_piix=0D
[=A0=A0=A0 7.717817] ata3: SATA max UDMA/133 cmd 0xbc00 ctl 0xb880 bmdma 0x=
b400 irq 21=0D
[=A0=A0=A0 7.739272] ata4: SATA max UDMA/133 cmd 0xb800 ctl 0xb480 bmdma 0x=
b408 irq 21=0D
[=A0=A0=A0 7.760970] Fixed MDIO Bus: probed=0D
[=A0=A0=A0 7.771246] PPP generic driver version 2.4.2=0D
[=A0=A0=A0 7.784126] tun: Universal TUN/TAP device driver, 1.6=0D
[=A0=A0=A0 7.799334] tun: (C) 1999-2004 Max Krasnyansky <maxk@domain.hid>=
=0D
[=A0=A0=A0 7.817984] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Dr=
iver=0D
[=A0=A0=A0 7.837635] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low=
) -> IRQ 18=0D
[=A0=A0=A0 7.859104] ehci_hcd 0000:00:1a.7: EHCI Host Controller=0D
[=A0=A0=A0 7.874852] ehci_hcd 0000:00:1a.7: new USB bus registered, assigne=
d bus number 1=0D
[=A0=A0=A0 7.941979] ehci_hcd 0000:00:1a.7: debug port 1=0D
[=A0=A0=A0 7.959515] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfbcf9000=0D
[=A0=A0=A0 7.991945] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00=0D
[=A0=A0=A0 8.009334] hub 1-0:1.0: USB hub found=0D
[=A0=A0=A0 8.020629] hub 1-0:1.0: 4 ports detected=0D
[=A0=A0=A0 8.032780] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low=
) -> IRQ 23=0D
[=A0=A0=A0 8.054234] ehci_hcd 0000:00:1d.7: EHCI Host Controller=0D
[=A0=A0=A0 8.069978] ehci_hcd 0000:00:1d.7: new USB bus registered, assigne=
d bus number 2=0D
[=A0=A0=A0 8.112645] ata3: SATA link down (SStatus 0 SControl 300)=0D
[=A0=A0=A0 8.141963] ehci_hcd 0000:00:1d.7: debug port 1=0D
[=A0=A0=A0 8.159473] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfbcfa000=0D
[=A0=A0=A0 8.191930] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00=0D
[=A0=A0=A0 8.209287] hub 2-0:1.0: USB hub found=0D
[=A0=A0=A0 8.220575] hub 2-0:1.0: 8 ports detected=0D
[=A0=A0=A0 8.232731] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver=
=0D
[=A0=A0=A0 8.251317] uhci_hcd: USB Universal Host Controller Interface driv=
er=0D
[=A0=A0=A0 8.270457] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low=
) -> IRQ 16=0D
[=A0=A0=A0 8.282000] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)=
=0D
[=A0=A0=A0 8.302971] ata4.00: ATA-7: SQF-S25M4-16G, VER2.A13, max UDMA/133=
=0D
[=A0=A0=A0 8.302974] ata4.00: 30080736 sectors, multi 0: LBA48=A0=0D
[=A0=A0=A0 8.342965] ata4.00: configured for UDMA/133=0D
[=A0=A0=A0 8.357105] uhci_hcd 0000:00:1a.0: UHCI Host Controller=0D
[=A0=A0=A0 8.362907] ata2.00: SATA link down (SStatus 0 SControl 300)=0D
[=A0=A0=A0 8.362923] ata2.01: SATA link down (SStatus 0 SControl 300)=0D
[=A0=A0=A0 8.406874] uhci_hcd 0000:00:1a.0: new USB bus registered, assigne=
d bus number 3=0D
[=A0=A0=A0 8.481940] uhci_hcd 0000:00:1a.0: irq 16, io base 0x00009400=0D
[=A0=A0=A0 8.499318] hub 3-0:1.0: USB hub found=0D
[=A0=A0=A0 8.510616] hub 3-0:1.0: 2 ports detected=0D
[=A0=A0=A0 8.511984] ata1.00: SATA link down (SStatus 0 SControl 300)=0D
[=A0=A0=A0 8.511997] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
00)=0D
[=A0=A0=A0 8.542356] ata1.01: ATA-8: ST31000524NS, SN11, max UDMA/133=0D
[=A0=A0=A0 8.542359] ata1.01: 1953525168 sectors, multi 16: LBA48 NCQ (dept=
h 0/32)=0D
[=A0=A0=A0 8.582350] ata1.01: configured for UDMA/133=0D
[=A0=A0=A0 8.582482] scsi 0:0:1:0: Direct-Access=A0=A0=A0=A0 ATA=A0=A0=A0=
=A0=A0 ST31000524NS=A0=A0=A0=A0 SN11 PQ: 0 ANSI: 5=0D
[=A0=A0=A0 8.582612] sd 0:0:1:0: Attached scsi generic sg0 type 0=0D
[=A0=A0=A0 8.582635] sd 0:0:1:0: [sda] 1953525168 512-byte logical blocks: =
(1.00 TB/931 GiB)=0D
[=A0=A0=A0 8.582703] sd 0:0:1:0: [sda] Write Protect is off=0D
[=A0=A0=A0 8.582720] scsi 3:0:0:0: Direct-Access=A0=A0=A0=A0 ATA=A0=A0=A0=
=A0=A0 SQF-S25M4-16G=A0=A0=A0 VER2 PQ: 0 ANSI: 5=0D
[=A0=A0=A0 8.582729] sd 0:0:1:0: [sda] Write cache: enabled, read cache: en=
abled, doesn't support DPO or FUA=0D
[=A0=A0=A0 8.582831] sd 3:0:0:0: Attached scsi generic sg1 type 0=0D
[=A0=A0=A0 8.582841] sd 3:0:0:0: [sdb] 30080736 512-byte logical blocks: (1=
5.4 GB/14.3 GiB)=0D
[=A0=A0=A0 8.582901] sd 3:0:0:0: [sdb] Write Protect is off=0D
[=A0=A0=A0 8.582925] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: en=
abled, doesn't support DPO or FUA=0D
[=A0=A0=A0 8.584615]=A0 sdb: sdb1=0D
[=A0=A0=A0 8.619933]=A0 sda: sda1 sda2 < sda5 >=0D
[=A0=A0=A0 8.836982] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low=
) -> IRQ 21=0D
[=A0=A0=A0 8.837017] sd 0:0:1:0: [sda] Attached SCSI disk=0D
[=A0=A0=A0 8.837019] sd 3:0:0:0: [sdb] Attached SCSI disk=0D
[=A0=A0=A0 8.886204] uhci_hcd 0000:00:1a.1: UHCI Host Controller=0D
[=A0=A0=A0 8.901956] uhci_hcd 0000:00:1a.1: new USB bus registered, assigne=
d bus number 4=0D
[=A0=A0=A0 9.001887] uhci_hcd 0000:00:1a.1: irq 21, io base 0x00009480=0D
[=A0=A0=A0 9.019259] hub 4-0:1.0: USB hub found=0D
[=A0=A0=A0 9.030556] hub 4-0:1.0: 2 ports detected=0D
[=A0=A0=A0 9.042702] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low=
) -> IRQ 23=0D
[=A0=A0=A0 9.064151] uhci_hcd 0000:00:1d.0: UHCI Host Controller=0D
[=A0=A0=A0 9.079910] uhci_hcd 0000:00:1d.0: new USB bus registered, assigne=
d bus number 5=0D
[=A0=A0=A0 9.181869] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00009800=0D
[=A0=A0=A0 9.199239] hub 5-0:1.0: USB hub found=0D
[=A0=A0=A0 9.210533] hub 5-0:1.0: 2 ports detected=0D
[=A0=A0=A0 9.222670] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low=
) -> IRQ 19=0D
[=A0=A0=A0 9.244132] uhci_hcd 0000:00:1d.1: UHCI Host Controller=0D
[=A0=A0=A0 9.259881] uhci_hcd 0000:00:1d.1: new USB bus registered, assigne=
d bus number 6=0D
[=A0=A0=A0 9.361867] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00009880=0D
[=A0=A0=A0 9.379245] hub 6-0:1.0: USB hub found=0D
[=A0=A0=A0 9.390539] hub 6-0:1.0: 2 ports detected=0D
[=A0=A0=A0 9.402683] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low=
) -> IRQ 18=0D
[=A0=A0=A0 9.424134] uhci_hcd 0000:00:1d.2: UHCI Host Controller=0D
[=A0=A0=A0 9.439886] uhci_hcd 0000:00:1d.2: new USB bus registered, assigne=
d bus number 7=0D
[=A0=A0=A0 9.531843] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00009c00=0D
[=A0=A0=A0 9.549213] hub 7-0:1.0: USB hub found=0D
[=A0=A0=A0 9.560512] hub 7-0:1.0: 2 ports detected=0D
[=A0=A0=A0 9.572653] uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low=
) -> IRQ 16=0D
[=A0=A0=A0 9.594102] uhci_hcd 0000:00:1d.3: UHCI Host Controller=0D
[=A0=A0=A0 9.609853] uhci_hcd 0000:00:1d.3: new USB bus registered, assigne=
d bus number 8=0D
[=A0=A0=A0 9.711827] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000a000=0D
[=A0=A0=A0 9.729249] hub 8-0:1.0: USB hub found=0D
[=A0=A0=A0 9.740536] hub 8-0:1.0: 2 ports detected=0D
[=A0=A0=A0 9.831839] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x=
60,0x64 irq 1,12=0D
[=A0=A0=A0 9.857332] serio: i8042 KBD port at 0x60,0x64 irq 1=0D
[=A0=A0=A0 9.872288] serio: i8042 AUX port at 0x60,0x64 irq 12=0D
[=A0=A0=A0 9.887563] mice: PS/2 mouse device common for all mice=0D
[=A0=A0=A0 9.903354] rtc_cmos 00:03: RTC can wake from S4=0D
[=A0=A0=A0 9.937089] input: AT Translated Set 2 keyboard as /devices/platfo=
rm/i8042/serio0/input/input2=0D
[=A0=A0 10.031835] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0=0D
[=A0=A0 10.050175] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet=
 irqs=0D
[=A0=A0 10.070673] device-mapper: uevent: version 1.0.3=0D
[=A0=A0 10.084682] device-mapper: ioctl: 4.18.0-ioctl (2010-06-29) initiali=
sed: dm-devel@domain.hid
[=A0=A0 10.110116] device-mapper: multipath: version 1.1.1 loaded=0D
[=A0=A0 10.126624] device-mapper: multipath round-robin: version 1.0.0 load=
ed=0D
[=A0=A0 10.146326] cpuidle: using governor ladder=0D
[=A0=A0 10.158655] cpuidle: using governor menu=0D
[=A0=A0 10.170643] TCP cubic registered=0D
[=A0=A0 10.180468] NET: Registered protocol family 10=0D
[=A0=A0 10.194195] lo: Disabled Privacy Extensions=0D
[=A0=A0 10.206922] NET: Registered protocol family 17=0D
[=A0=A0 10.220314] Registering the dns_resolver key type=0D
[=A0=A0 10.234568] registered taskstats version 1=0D
[=A0=A0 10.248313]=A0=A0 Magic number: 11:141:472=0D
[=A0=A0 10.259689] acpi LNXSYSTM:00: hash matches=0D
[=A0=A0 10.272049] rtc_cmos 00:03: setting system clock to 2011-05-05 08:28=
:55 UTC (1304584135)=0D
[=A0=A0 10.296383] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found=0D
[=A0=A0 10.314452] EDD information not available.=0D
[=A0=A0 10.326830] md: Waiting for all devices to be available before autod=
etect=0D
[=A0=A0 10.347240] md: If you don't use raid, use raid=3Dnoautodetect=0D
[=A0=A0 10.364368] md: Autodetecting RAID arrays.=0D
[=A0=A0 10.376698] md: Scanned 0 and added 0 devices.=0D
[=A0=A0 10.390061] md: autorun ...=0D
[=A0=A0 10.398487] md: ... autorun DONE.=0D
[=A0=A0 10.418738] EXT3-fs (sda1): error: couldn't mount because of unsuppo=
rted optional features (240)=0D
[=A0=A0 10.445822] EXT2-fs (sda1): error: couldn't mount because of unsuppo=
rted optional features (244)=0D
[=A0=A0 10.487922] EXT4-fs (sda1): INFO: recovery required on readonly file=
system=0D
[=A0=A0 10.508729] EXT4-fs (sda1): write access will be enabled during reco=
very=0D
[=A0=A0 10.633306] EXT4-fs (sda1): recovery complete=0D
[=A0=A0 10.648799] EXT4-fs (sda1): mounted filesystem with ordered data mod=
e. Opts: (null)=0D
[=A0=A0 10.671998] VFS: Mounted root (ext4 filesystem) readonly on device 8=
:1.=0D
[=A0=A0 10.719017] devtmpfs: mounted=0D
[=A0=A0 10.727987] Freeing unused kernel memory: 940k freed=0D
[=A0=A0 10.743087] Write protecting the kernel read-only data: 10240k=0D
[=A0=A0 10.760773] Freeing unused kernel memory: 328k freed=0D
[=A0=A0 10.775863] Freeing unused kernel memory: 1924k freed=0D
[=A0=A0 17.491241] hda-intel: no codecs found!=0D
[=A0=A0 31.812461] BUG: unable to handle kernel NULL pointer dereference at=
 0000000000000018=0D
[=A0=A0 31.835959] IP: [<ffffffff81023c00>] __ipipe_get_ioapic_irq_vector+0=
x30/0x40=0D
[=A0=A0 31.857122] PGD 32bd90067 PUD 332714067 PMD 0=A0=0D
[=A0=A0 31.870488] Oops: 0000 [#1] SMP=A0=0D
[=A0=A0 31.880213] last sysfs file: /sys/devices/pci0000:00/0000:00:1c.5/00=
00:02:00.0/irq=0D
[=A0=A0 31.902885] CPU 0=A0=0D
[=A0=A0 31.908370] Modules linked in: binfmt_misc ppdev dm_crypt snd_hda_in=
tel snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss e1000e snd_pcm snd_se=
q_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd=
_timer snd_seq_device shpchp snd ioatdma dca lp soundcore psmouse snd_page_=
alloc serio_raw parport=0D
[=A0=A0 31.993160]=A0=0D
[=A0=A0 31.997632] Pid: 0, comm: swapper Not tainted 2.6.37.6 #1 System man=
ufacturer System Product Name/Z8NA-D6(C)=0D
[=A0=A0 32.027194] RIP: 0010:[<ffffffff81023c00>]=A0 [<ffffffff81023c00>] _=
_ipipe_get_ioapic_irq_vector+0x30/0x40=0D
[=A0=A0 32.055613] RSP: 0018:ffff8800bee03d08=A0 EFLAGS: 00010046=0D
[=A0=A0 32.071502] RAX: 0000000000000000 RBX: ffffffff81c38740 RCX: 0000000=
000000000=0D
[=A0=A0 32.092874] RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000=
000000020=0D
[=A0=A0 32.114246] RBP: ffff8800bee03d08 R08: ffff8800bee0e860 R09: ffff880=
0bee0e850=0D
[=A0=A0 32.135592] R10: ffff8800bee0e848 R11: 0000000000000002 R12: 0000000=
000032a60=0D
[=A0=A0 32.156940] R13: 000000000000e840 R14: ffffffff81c38748 R15: ffff880=
0bee0c460=0D
[=A0=A0 32.178313] FS:=A0 0000000000000000(0000) GS:ffff8800bee00000(0000) =
knlGS:0000000000000000=0D
[=A0=A0 32.202545] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b=0D
[=A0=A0 32.219757] CR2: 0000000000000018 CR3: 0000000327910000 CR4: 0000000=
0000006f0=0D
[=A0=A0 32.241105] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000=0D
[=A0=A0 32.262477] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400=0D
[=A0=A0 32.283850] Process swapper (pid: 0, threadinfo ffffffff81a00000, ta=
sk ffffffff81a0b020)=0D
[=A0=A0 32.308056] Stack:=0D
[=A0=A0 32.314063]=A0 ffff8800bee03d58 ffffffff810c0615 ffffffff813ff0ca ff=
ffffff810237d0=0D
[=A0=A0 32.336293]=A0 ffffffff81024d95 0000000000000000 0000000000000010 00=
00000000000017=0D
[=A0=A0 32.358525]=A0 ffff8800bee0c460 ffffffff81a01fd8 ffff8800bee03d68 ff=
ffffff810c0e81=0D
[=A0=A0 32.380781] Call Trace:=0D
[=A0=A0 32.388087]=A0 <IRQ>=A0=0D
[=A0=A0 32.394382]=A0 [<ffffffff810c0615>] __ipipe_sync_stage+0x195/0x1f3=
=0D
[=A0=A0 32.412375]=A0 [<ffffffff813ff0ca>] ? ata_bmdma_interrupt+0x18a/0x23=
0=0D
[=A0=A0 32.431146]=A0 [<ffffffff810237d0>] ? smp_irq_move_cleanup_interrupt=
+0x0/0x130=0D
[=A0=A0 32.452259]=A0 [<ffffffff81024d95>] ? physflat_cpu_mask_to_apicid_an=
d+0x35/0x70=0D
[=A0=A0 32.473631]=A0 [<ffffffff810c0e81>] __ipipe_unstall_root+0x31/0x40=
=0D
[=A0=A0 32.491625]=A0 [<ffffffff8105ad03>] __do_softirq+0x63/0x230=0D
[=A0=A0 32.507798]=A0 [<ffffffff8100442e>] call_softirq+0x1e/0x50=0D
[=A0=A0 32.523710]=A0 [<ffffffff81005e25>] do_softirq+0xa5/0xe0=0D
[=A0=A0 32.539101]=A0 [<ffffffff8105ac15>] irq_exit+0x85/0x90=0D
[=A0=A0 32.553976]=A0 [<ffffffff815a70fa>] do_IRQ+0x7a/0x100=0D
[=A0=A0 32.568588]=A0 [<ffffffff810c066d>] __ipipe_sync_stage+0x1ed/0x1f3=
=0D
[=A0=A0 32.586579]=A0 [<ffffffff815a7080>] ? do_IRQ+0x0/0x100=0D
[=A0=A0 32.601427]=A0 [<ffffffff810c0673>] ? __xirq_end+0x0/0xd=0D
[=A0=A0 32.616818]=A0 [<ffffffff815a7080>] ? do_IRQ+0x0/0x100=0D
[=A0=A0 32.631666]=A0 [<ffffffff810c0b0e>] __ipipe_walk_pipeline+0x10e/0x12=
0=0D
[=A0=A0 32.650439]=A0 [<ffffffff8101ef2f>] __ipipe_handle_irq+0x13f/0x300=
=0D
[=A0=A0 32.668431]=A0 [<ffffffff810b9ce0>] ? __ipipe_ack_fasteoi_irq+0x0/0x=
20=0D
[=A0=A0 32.687465]=A0 [<ffffffff8159f953>] common_interrupt+0x13/0x2c=0D
[=A0=A0 32.704415]=A0 <EOI>=A0=0D
[=A0=A0 32.710735]=A0 [<ffffffff8101f2ab>] ? __ipipe_halt_root+0x2b/0x40=0D
[=A0=A0 32.728468]=A0 [<ffffffff8100c01b>] default_idle+0x4b/0xb0=0D
[=A0=A0 32.744379]=A0 [<ffffffff81001e7c>] cpu_idle+0xcc/0x150=0D
[=A0=A0 32.759513]=A0 [<ffffffff815888b2>] rest_init+0x72/0x80=0D
[=A0=A0 32.774646]=A0 [<ffffffff81ab7e62>] start_kernel+0x43d/0x448=0D
[=A0=A0 32.791077]=A0 [<ffffffff81ab7321>] x86_64_start_reservations+0x131/=
0x135=0D
[=A0=A0 32.810890]=A0 [<ffffffff81ab7457>] x86_64_start_kernel+0x132/0x139=
=0D
[=A0=A0 32.829141] Code: 1f 44 00 00 8d 87 00 ef ff ff 83 f8 1f 77 0c 8d 87=
 ea ef ff ff c9 c3 0f 1f 40 00 e8 cb 61 09 00 31 d2 48 85 c0 74 04 48 8b 50=
 18 <0f> b6 42 18 c9 c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 48=A0=0D
[=A0=A0 32.887280] RIP=A0 [<ffffffff81023c00>] __ipipe_get_ioapic_irq_vecto=
r+0x30/0x40=0D
[=A0=A0 32.908704]=A0 RSP <ffff8800bee03d08>=0D
[=A0=A0 32.919130] CR2: 0000000000000018=0D
[=A0=A0 32.929039] ---[ end trace 8c9c4ef442ceeb7d ]---=0D
[=A0=A0 32.942869] Kernel panic - not syncing: Fatal exception in interrupt=
=0D
[=A0=A0 32.961877] Pid: 0, comm: swapper Tainted: G=A0=A0=A0=A0=A0 D=A0=A0=
=A0=A0 2.6.37.6 #1=0D
[=A0=A0 32.980649] Call Trace:=0D
[=A0=A0 32.987981]=A0 <IRQ>=A0 [<ffffffff8159bdcf>] panic+0x91/0x1a1=0D
[=A0=A0 33.004207]=A0 [<ffffffff81055005>] ? kmsg_dump+0x185/0x1b0=0D
[=A0=A0 33.020380]=A0 [<ffffffff815a09b2>] oops_end+0xf2/0x100=0D
[=A0=A0 33.035513]=A0 [<ffffffff8103005b>] no_context+0xfb/0x260=0D
[=A0=A0 33.051167]=A0 [<ffffffff81576a9d>] ? packet_rcv_spkt+0x4d/0x1a0=0D
[=A0=A0 33.068636]=A0 [<ffffffff810302f5>] __bad_area_nosemaphore+0x135/0x1=
f0=0D
[=A0=A0 33.087670]=A0 [<ffffffff810303c3>] bad_area_nosemaphore+0x13/0x20=
=0D
[=A0=A0 33.105661]=A0 [<ffffffff815a32fc>] do_page_fault+0x33c/0x4c0=0D
[=A0=A0 33.122357]=A0 [<ffffffff812ec075>] ? blk_complete_request+0x25/0x30=
=0D
[=A0=A0 33.140867]=A0 [<ffffffff813c794f>] ? scsi_done+0x2f/0x70=0D
[=A0=A0 33.156521]=A0 [<ffffffff813f024a>] ? ata_scsi_qc_complete+0x6a/0x49=
0=0D
[=A0=A0 33.175292]=A0 [<ffffffff813e8386>] ? ata_sg_clean+0x66/0xd0=0D
[=A0=A0 33.191725]=A0 [<ffffffff813e8480>] ? __ata_qc_complete+0x90/0x140=
=0D
[=A0=A0 33.209718]=A0 [<ffffffff8101f6b4>] __ipipe_handle_exception+0x144/0=
x3c0=0D
[=A0=A0 33.229270]=A0 [<ffffffff813fdc7b>] ? ata_hsm_qc_complete+0x4b/0x130=
=0D
[=A0=A0 33.247784]=A0 [<ffffffff8159fbe6>] page_fault+0x26/0x70=0D
[=A0=A0 33.263176]=A0 [<ffffffff81023c00>] ? __ipipe_get_ioapic_irq_vector+=
0x30/0x40=0D
[=A0=A0 33.284028]=A0 [<ffffffff81023bf5>] ? __ipipe_get_ioapic_irq_vector+=
0x25/0x40=0D
[=A0=A0 33.304882]=A0 [<ffffffff810c0615>] __ipipe_sync_stage+0x195/0x1f3=
=0D
[=A0=A0 33.322873]=A0 [<ffffffff813ff0ca>] ? ata_bmdma_interrupt+0x18a/0x23=
0=0D
[=A0=A0 33.341646]=A0 [<ffffffff810237d0>] ? smp_irq_move_cleanup_interrupt=
+0x0/0x130=0D
[=A0=A0 33.362758]=A0 [<ffffffff81024d95>] ? physflat_cpu_mask_to_apicid_an=
d+0x35/0x70=0D
[=A0=A0 33.384133]=A0 [<ffffffff810c0e81>] __ipipe_unstall_root+0x31/0x40=
=0D
[=A0=A0 33.402124]=A0 [<ffffffff8105ad03>] __do_softirq+0x63/0x230=0D
[=A0=A0 33.418298]=A0 [<ffffffff8100442e>] call_softirq+0x1e/0x50=0D
[=A0=A0 33.434209]=A0 [<ffffffff81005e25>] do_softirq+0xa5/0xe0=0D
[=A0=A0 33.449601]=A0 [<ffffffff8105ac15>] irq_exit+0x85/0x90=0D
[=A0=A0 33.464449]=A0 [<ffffffff815a70fa>] do_IRQ+0x7a/0x100=0D
[=A0=A0 33.479062]=A0 [<ffffffff810c066d>] __ipipe_sync_stage+0x1ed/0x1f3=
=0D
[=A0=A0 33.497055]=A0 [<ffffffff815a7080>] ? do_IRQ+0x0/0x100=0D
[=A0=A0 33.511926]=A0 [<ffffffff810c0673>] ? __xirq_end+0x0/0xd=0D
[=A0=A0 33.527318]=A0 [<ffffffff815a7080>] ? do_IRQ+0x0/0x100=0D
[=A0=A0 33.542166]=A0 [<ffffffff810c0b0e>] __ipipe_walk_pipeline+0x10e/0x12=
0=0D
[=A0=A0 33.560938]=A0 [<ffffffff8101ef2f>] __ipipe_handle_irq+0x13f/0x300=
=0D
[=A0=A0 33.578932]=A0 [<ffffffff810b9ce0>] ? __ipipe_ack_fasteoi_irq+0x0/0x=
20=0D
[=A0=A0 33.597964]=A0 [<ffffffff8159f953>] common_interrupt+0x13/0x2c=0D
[=A0=A0 33.614915]=A0 <EOI>=A0 [<ffffffff8101f2ab>] ? __ipipe_halt_root+0x2=
b/0x40=0D
[=A0=A0 33.634469]=A0 [<ffffffff8100c01b>] default_idle+0x4b/0xb0=0D
[=A0=A0 33.650381]=A0 [<ffffffff81001e7c>] cpu_idle+0xcc/0x150=0D
[=A0=A0 33.665513]=A0 [<ffffffff815888b2>] rest_init+0x72/0x80=0D
[=A0=A0 33.680646]=A0 [<ffffffff81ab7e62>] start_kernel+0x43d/0x448=0D
[=A0=A0 33.697079]=A0 [<ffffffff81ab7321>] x86_64_start_reservations+0x131/=
0x135=0D
[=A0=A0 33.716892]=A0 [<ffffffff81ab7457>] x86_64_start_kernel+0x132/0x139


--0-598098314-1304584247=:14934
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><b>&gt;</b><b>On 2011-05-05 07:30, Franz Enge=
l wrote:<br></b><b>&gt;</b><b>&gt; Hi,<br></b><b>&gt;</b><b>&gt; <br></b><b=
>&gt;</b><b>&gt; =0AAfter some days to learn how I receive logs on another =
PC, here is my =0Alog. The problem is that the PC hangs after a few seconds=
. <br></b><b>&gt;</b><b>&gt; </b><b>&nbsp;&nbsp;&nbsp; <br></b><b>&gt;</b><=
b>&gt; &nbsp;&nbsp;&nbsp; pre { font-family: "Liberation Serif"; }p { margi=
n-bottom: 0.21cm; }<br></b><b>&gt;</b><b>&gt; <br></b><b>&gt;</b><b>&gt; #[=
?25l#[H#[J#[2;25HGNU GRUB&nbsp; version 1.98-1ubuntu10<br></b><b>&gt;</b><b=
>&gt; <br></b><b>&gt;</b><b>&gt; <br></b><b>&gt;</b><b>&gt;=0A [&nbsp; &nbs=
p; 0.000000] Linux version 2.6.32.20-adeos (root@domain.hid) (gcc=0A ve=
rsion 4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #1 SMP Wed May 4 22:06:49 CEST =0A201=
1<br><br></b><b>&gt;</b><b>Can you retry with a recent 2.6.37? .32 is unmai=
ntained (ipipe-wise) for<br></b><b>&gt;</b><b>quite a while now, and many p=
atches were developed since then.<br><br></b><b>&gt;</b><b>Jan<br></b><br>[=
&nbsp;&nbsp;&nbsp; 0.000000] Initializing cgroup subsys cpu=0D<br>[&nbsp;&n=
bsp;&nbsp; 0.000000] Linux version 2.6.37.6 (root@domain.hid) (gcc vers=
ion 4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #1 SMP Thu May 5 10:09:01 CEST 2011=0D<=
br>[&nbsp;&nbsp;&nbsp; 0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-2=
.6.37.6 root=3D/dev/sda1 ro console=3DttyS0, 38400 console=3Dtty0=0D<br>[&n=
bsp;&nbsp;&nbsp; 0.000000] BIOS-provided physical RAM map:=0D<br>[&nbsp;&nb=
sp;&nbsp; 0.000000]&nbsp; BIOS-e820: 0000000000000000 - 000000000009fc00 (u=
sable)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 000000000009fc0=
0 - 00000000000a0000 (reserved)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; B=
IOS-e820: 00000000000e5000 - 0000000000100000 (reserved)=0D<br>[&nbsp;&nbsp=
;&nbsp;
 0.000000]&nbsp; BIOS-e820: 0000000000100000 - 00000000bf780000 (usable)=0D=
<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 00000000bf78e000 - 00000=
000bf790000 (reserved)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:=
 00000000bf790000 - 00000000bf79e000 (ACPI data)=0D<br>[&nbsp;&nbsp;&nbsp; =
0.000000]&nbsp; BIOS-e820: 00000000bf79e000 - 00000000bf7d0000 (ACPI NVS)=
=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 00000000bf7d0000 - 00=
000000bf7e0000 (reserved)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e8=
20: 00000000bf7ed000 - 00000000c0000000 (reserved)=0D<br>[&nbsp;&nbsp;&nbsp=
; 0.000000]&nbsp; BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)=
=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 00000000fee00000 - 00=
000000fee01000 (reserved)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e8=
20: 00000000ffe00000 - 0000000100000000 (reserved)=0D<br>[&nbsp;&nbsp;&nbsp=
; 0.000000]&nbsp; BIOS-e820: 0000000100000000 - 0000000340000000 (usable)
=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] NX (Execute Disable) protection: activ=
e=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] DMI present.=0D<br>[&nbsp;&nbsp;&nbsp=
; 0.000000] No AGP bridge found=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] last_pf=
n =3D 0x340000 max_arch_pfn =3D 0x400000000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000=
000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106=0D<br=
>[&nbsp;&nbsp;&nbsp; 0.000000] last_pfn =3D 0xbf780 max_arch_pfn =3D 0x4000=
00000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] found SMP MP-table at [ffff880000=
0ff780] ff780=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] Using GB pages for direct=
 mapping=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] init_memory_mapping: 000000000=
0000000-00000000bf780000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] init_memory_ma=
pping: 0000000100000000-0000000340000000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000=
] ACPI: RSDP 00000000000fb620 00024 (v02 ACPIAM)=0D<br>[&nbsp;&nbsp;&nbsp; =
0.000000] ACPI: XSDT 00000000bf790100 00084 (v01 062810 XSDT1507 20100628 M=
SFT 00000097)
=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: FACP 00000000bf790290 000F4 (v03=
 062810 FACP1507 20100628 MSFT 00000097)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000=
] ACPI: DSDT 00000000bf790540 05B3D (v01&nbsp; S0081 S0081002 00000002 INTL=
 20060113)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: FACS 00000000bf79e000 =
00040=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: APIC 00000000bf790390 0011E=
 (v01 062810 APIC1507 20100628 MSFT 00000097)=0D<br>[&nbsp;&nbsp;&nbsp; 0.0=
00000] ACPI: MCFG 00000000bf7904b0 0003C (v01 062810 OEMMCFG&nbsp; 20100628=
 MSFT 00000097)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: SPMI 00000000bf79=
04f0 00041 (v05 062810 OEMSPMI&nbsp; 20100628 MSFT 00000097)=0D<br>[&nbsp;&=
nbsp;&nbsp; 0.000000] ACPI: OEMB 00000000bf79e040 00072 (v01 062810 OEMB150=
7 20100628 MSFT 00000097)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: SRAT 00=
000000bf798540 00168 (v01 062810 OEMSRAT&nbsp; 00000001 INTL 00000001)=0D<b=
r>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: HPET 00000000bf7986b0 00038 (v01 0628=
10
 OEMHPET&nbsp; 20100628 MSFT 00000097)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] =
ACPI: SSDT 00000000bf7a17f0 0154F (v01 DpgPmm&nbsp;&nbsp;&nbsp; CpuPm 00000=
012 INTL 20060113)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: EINJ 00000000b=
f7986f0 00130 (v01&nbsp; AMIER AMI_EINJ 20100628 MSFT 00000097)=0D<br>[&nbs=
p;&nbsp;&nbsp; 0.000000] ACPI: BERT 00000000bf798880 00030 (v01&nbsp; AMIER=
 AMI_BERT 20100628 MSFT 00000097)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI:=
 ERST 00000000bf7988b0 001B0 (v01&nbsp; AMIER AMI_ERST 20100628 MSFT 000000=
97)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: HEST 00000000bf798a60 000A8 (=
v01&nbsp; AMIER ABC_HEST 20100628 MSFT 00000097)=0D<br>[&nbsp;&nbsp;&nbsp; =
0.000000] SRAT: PXM 0 -&gt; APIC 0x00 -&gt; Node 0=0D<br>[&nbsp;&nbsp;&nbsp=
; 0.000000] SRAT: PXM 1 -&gt; APIC 0x20 -&gt; Node 1=0D<br>[&nbsp;&nbsp;&nb=
sp; 0.000000] SRAT: PXM 0 -&gt; APIC 0x02 -&gt; Node 0=0D<br>[&nbsp;&nbsp;&=
nbsp; 0.000000] SRAT: PXM 0 -&gt; APIC 0x04 -&gt; Node 0=0D<br>[&nbsp;&nbsp=
;&nbsp;
 0.000000] SRAT: PXM 0 -&gt; APIC 0x10 -&gt; Node 0=0D<br>[&nbsp;&nbsp;&nbs=
p; 0.000000] SRAT: PXM 0 -&gt; APIC 0x12 -&gt; Node 0=0D<br>[&nbsp;&nbsp;&n=
bsp; 0.000000] SRAT: PXM 0 -&gt; APIC 0x14 -&gt; Node 0=0D<br>[&nbsp;&nbsp;=
&nbsp; 0.000000] SRAT: PXM 1 -&gt; APIC 0x22 -&gt; Node 1=0D<br>[&nbsp;&nbs=
p;&nbsp; 0.000000] SRAT: PXM 1 -&gt; APIC 0x24 -&gt; Node 1=0D<br>[&nbsp;&n=
bsp;&nbsp; 0.000000] SRAT: PXM 1 -&gt; APIC 0x30 -&gt; Node 1=0D<br>[&nbsp;=
&nbsp;&nbsp; 0.000000] SRAT: PXM 1 -&gt; APIC 0x32 -&gt; Node 1=0D<br>[&nbs=
p;&nbsp;&nbsp; 0.000000] SRAT: PXM 1 -&gt; APIC 0x34 -&gt; Node 1=0D<br>[&n=
bsp;&nbsp;&nbsp; 0.000000] SRAT: Node 0 PXM 0 0-c0000000=0D<br>[&nbsp;&nbsp=
;&nbsp; 0.000000] SRAT: Node 0 PXM 0 100000000-1c0000000=0D<br>[&nbsp;&nbsp=
;&nbsp; 0.000000] SRAT: Node 1 PXM 1 1c0000000-340000000=0D<br>[&nbsp;&nbsp=
;&nbsp; 0.000000] SRAT: Node 0 [0,c0000000) + [100000000,1c0000000) -&gt; [=
0,1c0000000)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] Initmem setup node 0
 0000000000000000-00000001c0000000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp=
;&nbsp; NODE_DATA [00000001bfffb000 - 00000001bfffffff]=0D<br>[&nbsp;&nbsp;=
&nbsp; 0.000000] Initmem setup node 1 00000001c0000000-0000000340000000=0D<=
br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; NODE_DATA [000000033fffb000 - =
000000033fffffff]=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] Zone PFN ranges:=0D<b=
r>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x00000010 -&gt; 0x00001000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nb=
sp; DMA32&nbsp;&nbsp;&nbsp; 0x00001000 -&gt; 0x00100000=0D<br>[&nbsp;&nbsp;=
&nbsp; 0.000000]&nbsp;&nbsp; Normal&nbsp;&nbsp; 0x00100000 -&gt; 0x00340000=
=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] Movable zone start PFN for each node=
=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] early_node_map[4] active PFN ranges=0D=
<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; 0: 0x00000010 -&g=
t; 0x0000009f=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; 0=
: 0x00000100
 -&gt; 0x000bf780=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbs=
p; 0: 0x00100000 -&gt; 0x001c0000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;=
&nbsp;&nbsp;&nbsp; 1: 0x001c0000 -&gt; 0x00340000=0D<br>[&nbsp;&nbsp;&nbsp;=
 0.000000] ACPI: PM-Timer IO Port: 0x808=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000=
] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)=0D<br>[&nbsp;&nbsp;&nb=
sp; 0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)=0D<br>[&nb=
sp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled=
)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0=
x10] enabled)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (acpi_id[0x05=
] lapic_id[0x12] enabled)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (=
acpi_id[0x06] lapic_id[0x14] enabled)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] A=
CPI: LAPIC (acpi_id[0x07] lapic_id[0x20] enabled)=0D<br>[&nbsp;&nbsp;&nbsp;=
 0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x22] enabled)=0D<br>[&nbsp;=
&nbsp;&nbsp;
 0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x24] enabled)=0D<br>[&nbsp;=
&nbsp;&nbsp; 0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x30] enabled)=
=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x=
32] enabled)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (acpi_id[0x0c]=
 lapic_id[0x34] enabled)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (a=
cpi_id[0x0d] lapic_id[0x8c] disabled)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] A=
CPI: LAPIC (acpi_id[0x0e] lapic_id[0x8d] disabled)=0D<br>[&nbsp;&nbsp;&nbsp=
; 0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x8e] disabled)=0D<br>[&nbs=
p;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x8f] disabled=
)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (acpi_id[0x11] lapic_id[0=
x90] disabled)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (acpi_id[0x1=
2] lapic_id[0x91] disabled)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC=
 (acpi_id[0x13] lapic_id[0x92] disabled)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000=
] ACPI: LAPIC
 (acpi_id[0x14] lapic_id[0x93] disabled)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000=
] ACPI: LAPIC (acpi_id[0x15] lapic_id[0x94] disabled)=0D<br>[&nbsp;&nbsp;&n=
bsp; 0.000000] ACPI: LAPIC (acpi_id[0x16] lapic_id[0x95] disabled)=0D<br>[&=
nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (acpi_id[0x17] lapic_id[0x96] disab=
led)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (acpi_id[0x18] lapic_i=
d[0x97] disabled)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC_NMI (acpi=
_id[0xff] high level lint[0x1])=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: I=
OAPIC (id[0x01] address[0xfec00000] gsi_base[0])=0D<br>[&nbsp;&nbsp;&nbsp; =
0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23=0D=
<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: IOAPIC (id[0x03] address[0xfec8a000=
] gsi_base[24])=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] IOAPIC[1]: apic_id 3, v=
ersion 32, address 0xfec8a000, GSI 24-47=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000=
] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)=0D<br>[&nbsp;&nb=
sp;&nbsp;
 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)=0D<b=
r>[&nbsp;&nbsp;&nbsp; 0.000000] Using ACPI (MADT) for SMP configuration inf=
ormation=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: HPET id: 0x8086a301 base=
: 0xfed00000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] SMP: Allowing 24 CPUs, 12 =
hotplug CPUs=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] PM: Registered nosave memo=
ry: 000000000009f000 - 00000000000a0000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]=
 PM: Registered nosave memory: 00000000000a0000 - 00000000000e5000=0D<br>[&=
nbsp;&nbsp;&nbsp; 0.000000] PM: Registered nosave memory: 00000000000e5000 =
- 0000000000100000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] PM: Registered nosav=
e memory: 00000000bf780000 - 00000000bf78e000=0D<br>[&nbsp;&nbsp;&nbsp; 0.0=
00000] PM: Registered nosave memory: 00000000bf78e000 - 00000000bf790000=0D=
<br>[&nbsp;&nbsp;&nbsp; 0.000000] PM: Registered nosave memory: 00000000bf7=
90000 - 00000000bf79e000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] PM: Registered=
 nosave
 memory: 00000000bf79e000 - 00000000bf7d0000=0D<br>[&nbsp;&nbsp;&nbsp; 0.00=
0000] PM: Registered nosave memory: 00000000bf7d0000 - 00000000bf7e0000=0D<=
br>[&nbsp;&nbsp;&nbsp; 0.000000] PM: Registered nosave memory: 00000000bf7e=
0000 - 00000000bf7ed000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] PM: Registered =
nosave memory: 00000000bf7ed000 - 00000000c0000000=0D<br>[&nbsp;&nbsp;&nbsp=
; 0.000000] PM: Registered nosave memory: 00000000c0000000 - 00000000e00000=
00=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] PM: Registered nosave memory: 000000=
00e0000000 - 00000000f0000000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] PM: Regis=
tered nosave memory: 00000000f0000000 - 00000000fee00000=0D<br>[&nbsp;&nbsp=
;&nbsp; 0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000=
fee01000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] PM: Registered nosave memory: =
00000000fee01000 - 00000000ffe00000=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] PM:=
 Registered nosave memory: 00000000ffe00000 - 0000000100000000=0D<br>[&nbsp=
;&nbsp;&nbsp;
 0.000000] Allocating PCI resources starting at c0000000 (gap: c0000000:200=
00000)=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] setup_percpu: NR_CPUS:64 nr_cpum=
ask_bits:64 nr_cpu_ids:24 nr_node_ids:2=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]=
 PERCPU: Embedded 62 pages/cpu @ffff8800bee00000 s224064 r8192 d21696 u2621=
44=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] Built 2 zonelists in Zone order, mob=
ility grouping on.&nbsp; Total pages: 3096841=0D<br>[&nbsp;&nbsp;&nbsp; 0.0=
00000] Policy zone: Normal=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] Kernel comma=
nd line: BOOT_IMAGE=3D/boot/vmlinuz-2.6.37.6 root=3D/dev/sda1 ro console=3D=
ttyS0, 38400 console=3Dtty0=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] PID hash ta=
ble entries: 4096 (order: 3, 32768 bytes)=0D<br>[&nbsp;&nbsp;&nbsp; 0.00000=
0] Checking aperture...=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] No AGP bridge f=
ound=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] Memory: 12315164k/13631488k availa=
ble (5797k kernel code, 1057732k absent, 258592k reserved, 4946k data, 940k=
 init)
=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Ord=
er=3D0-3, MinObjects=3D0, CPUs=3D24, Nodes=3D2=0D<br>[&nbsp;&nbsp;&nbsp; 0.=
000000] Hierarchical RCU implementation.=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000=
] &nbsp;&nbsp;&nbsp; RCU-based detection of stalled CPUs is disabled.=0D<br=
>[&nbsp;&nbsp;&nbsp; 0.000000] NR_IRQS:4352 nr_irqs:1280 16=0D<br>[&nbsp;&n=
bsp;&nbsp; 0.000000] Extended CMOS year: 2000=0D<br>[&nbsp;&nbsp;&nbsp; 0.0=
00000] I-pipe 2.9-01: pipeline enabled.=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000]=
 Console: colour VGA+ 80x25=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] console [tt=
y0] enabled=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] console [ttyS0] enabled=0D<=
br>[&nbsp;&nbsp;&nbsp; 0.000000] allocated 125829120 bytes of page_cgroup=
=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] please try 'cgroup_disable=3Dmemory' o=
ption if you don't want memory cgroups=0D<br>[&nbsp;&nbsp;&nbsp; 0.000000] =
Fast TSC calibration using PIT=0D<br>[&nbsp;&nbsp;&nbsp; 0.010000] Detected=
 2666.457 MHz processor.
=0D<br>[&nbsp;&nbsp;&nbsp; 0.000010] Calibrating delay loop (skipped), valu=
e calculated using timer frequency.. 5332.91 BogoMIPS (lpj=3D26664570)=0D<b=
r>[&nbsp;&nbsp;&nbsp; 0.032212] pid_max: default: 32768 minimum: 301=0D<br>=
[&nbsp;&nbsp;&nbsp; 0.046124] Security Framework initialized=0D<br>[&nbsp;&=
nbsp;&nbsp; 0.058456] AppArmor: AppArmor initialized=0D<br>[&nbsp;&nbsp;&nb=
sp; 0.072177] Dentry cache hash table entries: 2097152 (order: 12, 16777216=
 bytes)=0D<br>[&nbsp;&nbsp;&nbsp; 0.097914] Inode-cache hash table entries:=
 1048576 (order: 11, 8388608 bytes)=0D<br>[&nbsp;&nbsp;&nbsp; 0.120977] Mou=
nt-cache hash table entries: 256=0D<br>[&nbsp;&nbsp;&nbsp; 0.134742] Initia=
lizing cgroup subsys ns=0D<br>[&nbsp;&nbsp;&nbsp; 0.146828] ns_cgroup depre=
cated: consider using the 'clone_children' flag without the ns_cgroup.=0D<b=
r>[&nbsp;&nbsp;&nbsp; 0.173502] Initializing cgroup subsys cpuacct=0D<br>[&=
nbsp;&nbsp;&nbsp; 0.187753] Initializing cgroup subsys memory=0D<br>[&nbsp;=
&nbsp;&nbsp;
 0.200873] Initializing cgroup subsys devices=0D<br>[&nbsp;&nbsp;&nbsp; 0.2=
14246] Initializing cgroup subsys freezer=0D<br>[&nbsp;&nbsp;&nbsp; 0.22761=
0] Initializing cgroup subsys net_cls=0D<br>[&nbsp;&nbsp;&nbsp; 0.241002] C=
PU: Physical Processor ID: 0=0D<br>[&nbsp;&nbsp;&nbsp; 0.253064] CPU: Proce=
ssor Core ID: 0=0D<br>[&nbsp;&nbsp;&nbsp; 0.264092] mce: CPU supports 9 MCE=
 banks=0D<br>[&nbsp;&nbsp;&nbsp; 0.276162] CPU0: Thermal monitoring enabled=
 (TM1)=0D<br>[&nbsp;&nbsp;&nbsp; 0.290590] Performance Events: PEBS fmt1+, =
Westmere events, Intel PMU driver.=0D<br>[&nbsp;&nbsp;&nbsp; 0.312527] ... =
version:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 3=0D<br>[&nbsp;&nbsp;&nbsp; 0.324592] ... bit width=
:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 48=0D<br>[&nbsp;&nbsp;&nbsp; 0.336917] ... generic registers:&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 4=0D<br>[&nbsp;&nbsp;&nbsp; 0.348982] ... value
 mask:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0000ffffffffffff=0D<br>[&nbsp;&nbsp;&nbsp; 0.364946] ... max period:&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000=
0007fffffff=0D<br>[&nbsp;&nbsp;&nbsp; 0.380911] ... fixed-purpose events:&n=
bsp;&nbsp; 3=0D<br>[&nbsp;&nbsp;&nbsp; 0.392975] ... event mask:&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000000700000=
00f=0D<br>[&nbsp;&nbsp;&nbsp; 0.409057] ACPI: Core revision 20101013=0D<br>=
[&nbsp;&nbsp;&nbsp; 0.452149] ftrace: allocating 21658 entries in 85 pages=
=0D<br>[&nbsp;&nbsp;&nbsp; 0.473904] Setting APIC routing to physical flat=
=0D<br>[&nbsp;&nbsp;&nbsp; 0.488481] ..TIMER: vector=3D0x30 apic1=3D0 pin1=
=3D2 apic2=3D-1 pin2=3D-1=0D<br>[&nbsp;&nbsp;&nbsp; 0.606546] ..MP-BIOS bug=
: 8254 timer not connected to IO-APIC=0D<br>[&nbsp;&nbsp;&nbsp; 0.624096] .=
..trying to set up timer (IRQ0) through the 8259A ...=0D<br>[&nbsp;&nbsp;&n=
bsp; 0.642688] .....
 (found apic 0 pin 2) ...=0D<br>[&nbsp;&nbsp;&nbsp; 0.755620] ....... works=
.=0D<br>[&nbsp;&nbsp;&nbsp; 0.763800] CPU0: Intel(R) Xeon(R) CPU&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; X5650&nbsp; @ 2.67GHz ste=
pping 02=0D<br>[&nbsp;&nbsp;&nbsp; 0.904246] Booting Node&nbsp;&nbsp; 0, Pr=
ocessors&nbsp; #1 #2 #3 #4 #5 Ok.=0D<br>[&nbsp;&nbsp;&nbsp; 1.815952] Booti=
ng Node&nbsp;&nbsp; 1, Processors&nbsp; #6 #7 #8 #9 #10 #11=0D<br>[&nbsp;&n=
bsp;&nbsp; 2.904211] Brought up 12 CPUs=0D<br>[&nbsp;&nbsp;&nbsp; 2.914024]=
 Total of 12 processors activated (64001.38 BogoMIPS).=0D<br>[&nbsp;&nbsp;&=
nbsp; 2.939799] devtmpfs: initialized=0D<br>[&nbsp;&nbsp;&nbsp; 2.950023] r=
egulator: core version 0.5=0D<br>[&nbsp;&nbsp;&nbsp; 2.961609] regulator: d=
ummy:&nbsp;=0D<br>[&nbsp;&nbsp;&nbsp; 2.970829] Time:&nbsp; 8:28:48&nbsp; D=
ate: 05/05/11=0D<br>[&nbsp;&nbsp;&nbsp; 2.983192] NET: Registered protocol =
family 16=0D<br>[&nbsp;&nbsp;&nbsp; 2.997423] ACPI: bus type pci registered
=0D<br>[&nbsp;&nbsp;&nbsp; 3.009577] PCI: MMCONFIG for domain 0000 [bus 00-=
ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)=0D<br>[&nbsp;&nbsp;&nb=
sp; 3.037557] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820=
=0D<br>[&nbsp;&nbsp;&nbsp; 3.084430] PCI: Using configuration type 1 for ba=
se access=0D<br>[&nbsp;&nbsp;&nbsp; 3.101880] bio: create slab &lt;bio-0&gt=
; at 0=0D<br>[&nbsp;&nbsp;&nbsp; 3.116740] ACPI: Executed 1 blocks of modul=
e-level executable AML code=0D<br>[&nbsp;&nbsp;&nbsp; 3.184411] ACPI: SSDT =
00000000bf79e0c0 029DC (v01 DpgPmm&nbsp; P001Ist 00000011 INTL 20060113)=0D=
<br>[&nbsp;&nbsp;&nbsp; 3.209925] ACPI: Dynamic OEM Table Load:=0D<br>[&nbs=
p;&nbsp;&nbsp; 3.222136] ACPI: SSDT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; (null) 029DC (v01 DpgPmm&nbsp; P001Ist 00000011 INTL 2=
0060113)=0D<br>[&nbsp;&nbsp;&nbsp; 3.247414] ACPI: SSDT 00000000bf7a0aa0 00=
7FC (v01&nbsp; PmRef&nbsp; P001Cst 00003001 INTL 20060113)=0D<br>[&nbsp;&nb=
sp;&nbsp;
 3.273697] ACPI: Dynamic OEM Table Load:=0D<br>[&nbsp;&nbsp;&nbsp; 3.285914=
] ACPI: SSDT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (n=
ull) 007FC (v01&nbsp; PmRef&nbsp; P001Cst 00003001 INTL 20060113)=0D<br>[&n=
bsp;&nbsp;&nbsp; 3.311132] ACPI: SSDT 00000000bf7a12a0 0054E (v01&nbsp; PmR=
ef&nbsp; Cpu0Tst 00003000 INTL 20060113)=0D<br>[&nbsp;&nbsp;&nbsp; 3.336568=
] ACPI: Dynamic OEM Table Load:=0D<br>[&nbsp;&nbsp;&nbsp; 3.348786] ACPI: S=
SDT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (null) 0054=
E (v01&nbsp; PmRef&nbsp; Cpu0Tst 00003000 INTL 20060113)=0D<br>[&nbsp;&nbsp=
;&nbsp; 3.395232] ACPI: Interpreter enabled=0D<br>[&nbsp;&nbsp;&nbsp; 3.406=
277] ACPI: (supports S0 S1 S4 S5)=0D<br>[&nbsp;&nbsp;&nbsp; 3.418390] ACPI:=
 Using IOAPIC for interrupt routing=0D<br>[&nbsp;&nbsp;&nbsp; 3.434716] ACP=
I Exception: AE_NOT_FOUND, Evaluating _PRW (20101013/scan-723)=0D<br>[&nbsp=
;&nbsp;&nbsp; 3.456624] ACPI Exception: AE_NOT_FOUND, Evaluating _PRW
 (20101013/scan-723)=0D<br>[&nbsp;&nbsp;&nbsp; 3.484729] ACPI: No dock devi=
ces found.=0D<br>[&nbsp;&nbsp;&nbsp; 3.496554] PCI: Using host bridge windo=
ws from ACPI; if necessary, use "pci=3Dnocrs" and report a bug=0D<br>[&nbsp=
;&nbsp;&nbsp; 3.524820] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-f=
f])=0D<br>[&nbsp;&nbsp;&nbsp; 3.543627] pci_root PNP0A08:00: host bridge wi=
ndow [io&nbsp; 0x0000-0x0cf7]=0D<br>[&nbsp;&nbsp;&nbsp; 3.563504] pci_root =
PNP0A08:00: host bridge window [io&nbsp; 0x0d00-0xffff]=0D<br>[&nbsp;&nbsp;=
&nbsp; 3.583394] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x=
000bffff]=0D<br>[&nbsp;&nbsp;&nbsp; 3.605391] pci_root PNP0A08:00: host bri=
dge window [mem 0x000d0000-0x000dffff]=0D<br>[&nbsp;&nbsp;&nbsp; 3.627390] =
pci_root PNP0A08:00: host bridge window [mem 0xc0000000-0xdfffffff]=0D<br>[=
&nbsp;&nbsp;&nbsp; 3.649383] pci_root PNP0A08:00: host bridge window [mem 0=
xf0000000-0xfed8ffff]=0D<br>[&nbsp;&nbsp;&nbsp; 3.674037] pci 0000:00:1f.0:=
 ICH7 LPC
 Generic IO decode 2 PIO at 0ca0 (mask 0003)=0D<br>[&nbsp;&nbsp;&nbsp; 3.69=
6814] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 4 PIO at 0294 (mask 0003=
)=0D<br>[&nbsp;&nbsp;&nbsp; 3.719880] pci 0000:00:01.0: PCI bridge to [bus =
0b-0b]=0D<br>[&nbsp;&nbsp;&nbsp; 3.735646] pci 0000:00:02.0: PCI bridge to =
[bus 0a-0a]=0D<br>[&nbsp;&nbsp;&nbsp; 3.751403] pci 0000:00:03.0: PCI bridg=
e to [bus 09-09]=0D<br>[&nbsp;&nbsp;&nbsp; 3.768017] pci 0000:00:07.0: PCI =
bridge to [bus 08-08]=0D<br>[&nbsp;&nbsp;&nbsp; 3.783774] pci 0000:00:08.0:=
 PCI bridge to [bus 07-07]=0D<br>[&nbsp;&nbsp;&nbsp; 3.799529] pci 0000:00:=
09.0: PCI bridge to [bus 06-06]=0D<br>[&nbsp;&nbsp;&nbsp; 3.815286] pci 000=
0:00:0a.0: PCI bridge to [bus 05-05]=0D<br>[&nbsp;&nbsp;&nbsp; 3.831046] pc=
i 0000:00:1c.0: PCI bridge to [bus 04-04]=0D<br>[&nbsp;&nbsp;&nbsp; 3.86416=
6] pci 0000:00:1c.4: PCI bridge to [bus 03-03]=0D<br>[&nbsp;&nbsp;&nbsp; 3.=
894164] pci 0000:00:1c.5: PCI bridge to [bus 02-02]=0D<br>[&nbsp;&nbsp;&nbs=
p; 3.910059] pci
 0000:00:1e.0: PCI bridge to [bus 01-01] (subtractive decode)=0D<br>[&nbsp;=
&nbsp;&nbsp; 3.954669] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11=
 12 14 15)=0D<br>[&nbsp;&nbsp;&nbsp; 3.976233] ACPI: PCI Interrupt Link [LN=
KB] (IRQs *5)=0D<br>[&nbsp;&nbsp;&nbsp; 3.991707] ACPI: PCI Interrupt Link =
[LNKC] (IRQs 3 4 6 *7 10 11 12 14 15)=0D<br>[&nbsp;&nbsp;&nbsp; 4.013257] A=
CPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 *10 11 12 14 15)=0D<br>[&nbsp;=
&nbsp;&nbsp; 4.035567] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 =
12 14 15) *0, disabled.=0D<br>[&nbsp;&nbsp;&nbsp; 4.060682] ACPI: PCI Inter=
rupt Link [LNKF] (IRQs 3 4 6 7 10 11 12 14 *15)=0D<br>[&nbsp;&nbsp;&nbsp; 4=
.082237] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 6 7 10 11 12 *14 15)=0D<=
br>[&nbsp;&nbsp;&nbsp; 4.103793] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 =
6 7 10 *11 12 14 15)=0D<br>[&nbsp;&nbsp;&nbsp; 4.125385] vgaarb: device add=
ed: PCI:0000:01:01.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone=0D<br>[&nb=
sp;&nbsp;&nbsp;
 4.149722] vgaarb: loaded=0D<br>[&nbsp;&nbsp;&nbsp; 4.157951] SCSI subsyste=
m initialized=0D<br>[&nbsp;&nbsp;&nbsp; 4.169334] usbcore: registered new i=
nterface driver usbfs=0D<br>[&nbsp;&nbsp;&nbsp; 4.185844] usbcore: register=
ed new interface driver hub=0D<br>[&nbsp;&nbsp;&nbsp; 4.201850] usbcore: re=
gistered new device driver usb=0D<br>[&nbsp;&nbsp;&nbsp; 4.217206] wmi: Map=
per loaded=0D<br>[&nbsp;&nbsp;&nbsp; 4.226424] PCI: Using ACPI for IRQ rout=
ing=0D<br>[&nbsp;&nbsp;&nbsp; 4.239200] NetLabel: Initializing=0D<br>[&nbsp=
;&nbsp;&nbsp; 4.249459] NetLabel:&nbsp; domain hash size =3D 128=0D<br>[&nb=
sp;&nbsp;&nbsp; 4.262564] NetLabel:&nbsp; protocols =3D UNLABELED CIPSOv4=
=0D<br>[&nbsp;&nbsp;&nbsp; 4.278173] NetLabel:&nbsp; unlabeled traffic allo=
wed by default=0D<br>[&nbsp;&nbsp;&nbsp; 4.294964] hpet0: at MMIO 0xfed0000=
0, IRQs 2, 8, 0, 0=0D<br>[&nbsp;&nbsp;&nbsp; 4.310820] hpet0: 4 comparators=
, 64-bit 14.318180 MHz counter=0D<br>[&nbsp;&nbsp;&nbsp; 4.330393] Switchin=
g to clocksource tsc
=0D<br>[&nbsp;&nbsp;&nbsp; 4.343584] AppArmor: AppArmor Filesystem Enabled=
=0D<br>[&nbsp;&nbsp;&nbsp; 4.357764] pnp: PnP ACPI init=0D<br>[&nbsp;&nbsp;=
&nbsp; 4.366993] ACPI: bus type pnp registered=0D<br>[&nbsp;&nbsp;&nbsp; 4.=
381589] pnp: PnP ACPI: found 16 devices=0D<br>[&nbsp;&nbsp;&nbsp; 4.394183]=
 ACPI: ACPI bus type pnp unregistered=0D<br>[&nbsp;&nbsp;&nbsp; 4.408098] s=
ystem 00:01: [mem 0xfbf00000-0xfbffffff] has been reserved=0D<br>[&nbsp;&nb=
sp;&nbsp; 4.427982] system 00:01: [mem 0xfc000000-0xfcffffff] has been rese=
rved=0D<br>[&nbsp;&nbsp;&nbsp; 4.447874] system 00:01: [mem 0xfd000000-0xfd=
ffffff] has been reserved=0D<br>[&nbsp;&nbsp;&nbsp; 4.467764] system 00:01:=
 [mem 0xfe000000-0xfebfffff] has been reserved=0D<br>[&nbsp;&nbsp;&nbsp; 4.=
487655] system 00:01: [mem 0xfec8a000-0xfec8afff] could not be reserved=0D<=
br>[&nbsp;&nbsp;&nbsp; 4.508585] system 00:01: [mem 0xfed10000-0xfed10fff] =
has been reserved=0D<br>[&nbsp;&nbsp;&nbsp; 4.528478] system 00:06: [io&nbs=
p; 0x0290-0x029f]
 has been reserved=0D<br>[&nbsp;&nbsp;&nbsp; 4.547172] system 00:07: [io&nb=
sp; 0x04d0-0x04d1] has been reserved=0D<br>[&nbsp;&nbsp;&nbsp; 4.564982] sy=
stem 00:07: [io&nbsp; 0x0ca0-0x0caf] has been reserved=0D<br>[&nbsp;&nbsp;&=
nbsp; 4.582792] system 00:07: [io&nbsp; 0x0800-0x087f] has been reserved=0D=
<br>[&nbsp;&nbsp;&nbsp; 4.600605] system 00:07: [io&nbsp; 0x0500-0x057f] ha=
s been reserved=0D<br>[&nbsp;&nbsp;&nbsp; 4.618414] system 00:07: [mem 0xfe=
d1c000-0xfed1ffff] has been reserved=0D<br>[&nbsp;&nbsp;&nbsp; 4.638305] sy=
stem 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved=0D<br>[&nbsp;&nbs=
p;&nbsp; 4.658195] system 00:07: [mem 0xfed40000-0xfed8ffff] has been reser=
ved=0D<br>[&nbsp;&nbsp;&nbsp; 4.678087] system 00:0b: [mem 0xfec00000-0xfec=
00fff] could not be reserved=0D<br>[&nbsp;&nbsp;&nbsp; 4.699015] system 00:=
0b: [mem 0xfee00000-0xfee00fff] has been reserved=0D<br>[&nbsp;&nbsp;&nbsp;=
 4.718909] system 00:0e: [mem 0xe0000000-0xefffffff] has been reserved
=0D<br>[&nbsp;&nbsp;&nbsp; 4.738802] system 00:0f: [mem 0x00000000-0x0009ff=
ff] could not be reserved=0D<br>[&nbsp;&nbsp;&nbsp; 4.759729] system 00:0f:=
 [mem 0x000c0000-0x000cffff] has been reserved=0D<br>[&nbsp;&nbsp;&nbsp; 4.=
779618] system 00:0f: [mem 0x000e0000-0x000fffff] could not be reserved=0D<=
br>[&nbsp;&nbsp;&nbsp; 4.801356] system 00:0f: [mem 0x00100000-0xbfffffff] =
could not be reserved=0D<br>[&nbsp;&nbsp;&nbsp; 4.822286] system 00:0f: [me=
m 0xfed90000-0xffffffff] could not be reserved=0D<br>[&nbsp;&nbsp;&nbsp; 4.=
849053] pci 0000:00:1c.0: BAR 14: assigned [mem 0xc0000000-0xc01fffff]=0D<b=
r>[&nbsp;&nbsp;&nbsp; 4.869715] pci 0000:00:1c.0: BAR 15: assigned [mem 0xc=
0200000-0xc03fffff 64bit pref]=0D<br>[&nbsp;&nbsp;&nbsp; 4.893272] pci 0000=
:00:1c.4: BAR 15: assigned [mem 0xc0400000-0xc05fffff 64bit pref]=0D<br>[&n=
bsp;&nbsp;&nbsp; 4.916826] pci 0000:00:1c.5: BAR 15: assigned [mem 0xc06000=
00-0xc07fffff 64bit pref]=0D<br>[&nbsp;&nbsp;&nbsp; 4.940383] pci 0000:00:1=
c.0: BAR 13:
 assigned [io&nbsp; 0x1000-0x1fff]=0D<br>[&nbsp;&nbsp;&nbsp; 4.958973] pci =
0000:00:01.0: PCI bridge to [bus 0b-0b]=0D<br>[&nbsp;&nbsp;&nbsp; 4.974704]=
 pci 0000:00:01.0:&nbsp;&nbsp; bridge window [io&nbsp; disabled]=0D<br>[&nb=
sp;&nbsp;&nbsp; 4.991734] pci 0000:00:01.0:&nbsp;&nbsp; bridge window [mem =
disabled]=0D<br>[&nbsp;&nbsp;&nbsp; 5.008765] pci 0000:00:01.0:&nbsp;&nbsp;=
 bridge window [mem pref disabled]=0D<br>[&nbsp;&nbsp;&nbsp; 5.027097] pci =
0000:00:02.0: PCI bridge to [bus 0a-0a]=0D<br>[&nbsp;&nbsp;&nbsp; 5.043606]=
 pci 0000:00:02.0:&nbsp;&nbsp; bridge window [io&nbsp; disabled]=0D<br>[&nb=
sp;&nbsp;&nbsp; 5.060638] pci 0000:00:02.0:&nbsp;&nbsp; bridge window [mem =
disabled]=0D<br>[&nbsp;&nbsp;&nbsp; 5.077669] pci 0000:00:02.0:&nbsp;&nbsp;=
 bridge window [mem pref disabled]=0D<br>[&nbsp;&nbsp;&nbsp; 5.096001] pci =
0000:00:03.0: PCI bridge to [bus 09-09]=0D<br>[&nbsp;&nbsp;&nbsp; 5.111727]=
 pci 0000:00:03.0:&nbsp;&nbsp; bridge window [io&nbsp; disabled]=0D<br>[&nb=
sp;&nbsp;&nbsp;
 5.128761] pci 0000:00:03.0:&nbsp;&nbsp; bridge window [mem disabled]=0D<br=
>[&nbsp;&nbsp;&nbsp; 5.145791] pci 0000:00:03.0:&nbsp;&nbsp; bridge window =
[mem pref disabled]=0D<br>[&nbsp;&nbsp;&nbsp; 5.164125] pci 0000:00:07.0: P=
CI bridge to [bus 08-08]=0D<br>[&nbsp;&nbsp;&nbsp; 5.179850] pci 0000:00:07=
.0:&nbsp;&nbsp; bridge window [io&nbsp; disabled]=0D<br>[&nbsp;&nbsp;&nbsp;=
 5.196883] pci 0000:00:07.0:&nbsp;&nbsp; bridge window [mem disabled]=0D<br=
>[&nbsp;&nbsp;&nbsp; 5.213913] pci 0000:00:07.0:&nbsp;&nbsp; bridge window =
[mem pref disabled]=0D<br>[&nbsp;&nbsp;&nbsp; 5.232246] pci 0000:00:08.0: P=
CI bridge to [bus 07-07]=0D<br>[&nbsp;&nbsp;&nbsp; 5.247972] pci 0000:00:08=
.0:&nbsp;&nbsp; bridge window [io&nbsp; disabled]=0D<br>[&nbsp;&nbsp;&nbsp;=
 5.265005] pci 0000:00:08.0:&nbsp;&nbsp; bridge window [mem disabled]=0D<br=
>[&nbsp;&nbsp;&nbsp; 5.282036] pci 0000:00:08.0:&nbsp;&nbsp; bridge window =
[mem pref disabled]=0D<br>[&nbsp;&nbsp;&nbsp; 5.301174] pci 0000:00:09.0: P=
CI bridge to
 [bus 06-06]=0D<br>[&nbsp;&nbsp;&nbsp; 5.316900] pci 0000:00:09.0:&nbsp;&nb=
sp; bridge window [io&nbsp; disabled]=0D<br>[&nbsp;&nbsp;&nbsp; 5.333933] p=
ci 0000:00:09.0:&nbsp;&nbsp; bridge window [mem disabled]=0D<br>[&nbsp;&nbs=
p;&nbsp; 5.350963] pci 0000:00:09.0:&nbsp;&nbsp; bridge window [mem pref di=
sabled]=0D<br>[&nbsp;&nbsp;&nbsp; 5.369296] pci 0000:00:0a.0: PCI bridge to=
 [bus 05-05]=0D<br>[&nbsp;&nbsp;&nbsp; 5.385024] pci 0000:00:0a.0:&nbsp;&nb=
sp; bridge window [io&nbsp; disabled]=0D<br>[&nbsp;&nbsp;&nbsp; 5.402056] p=
ci 0000:00:0a.0:&nbsp;&nbsp; bridge window [mem disabled]=0D<br>[&nbsp;&nbs=
p;&nbsp; 5.419086] pci 0000:00:0a.0:&nbsp;&nbsp; bridge window [mem pref di=
sabled]=0D<br>[&nbsp;&nbsp;&nbsp; 5.437419] pci 0000:00:1c.0: PCI bridge to=
 [bus 04-04]=0D<br>[&nbsp;&nbsp;&nbsp; 5.453148] pci 0000:00:1c.0:&nbsp;&nb=
sp; bridge window [io&nbsp; 0x1000-0x1fff]=0D<br>[&nbsp;&nbsp;&nbsp; 5.4714=
80] pci 0000:00:1c.0:&nbsp;&nbsp; bridge window [mem 0xc0000000-0xc01fffff]
=0D<br>[&nbsp;&nbsp;&nbsp; 5.491889] pci 0000:00:1c.0:&nbsp;&nbsp; bridge w=
indow [mem 0xc0200000-0xc03fffff 64bit pref]=0D<br>[&nbsp;&nbsp;&nbsp; 5.51=
5188] pci 0000:00:1c.4: PCI bridge to [bus 03-03]=0D<br>[&nbsp;&nbsp;&nbsp;=
 5.530917] pci 0000:00:1c.4:&nbsp;&nbsp; bridge window [io&nbsp; 0xe000-0xe=
fff]=0D<br>[&nbsp;&nbsp;&nbsp; 5.549247] pci 0000:00:1c.4:&nbsp;&nbsp; brid=
ge window [mem 0xfbe00000-0xfbefffff]=0D<br>[&nbsp;&nbsp;&nbsp; 5.570438] p=
ci 0000:00:1c.4:&nbsp;&nbsp; bridge window [mem 0xc0400000-0xc05fffff 64bit=
 pref]=0D<br>[&nbsp;&nbsp;&nbsp; 5.593736] pci 0000:00:1c.5: PCI bridge to =
[bus 02-02]=0D<br>[&nbsp;&nbsp;&nbsp; 5.609465] pci 0000:00:1c.5:&nbsp;&nbs=
p; bridge window [io&nbsp; 0xd000-0xdfff]=0D<br>[&nbsp;&nbsp;&nbsp; 5.62779=
7] pci 0000:00:1c.5:&nbsp;&nbsp; bridge window [mem 0xfbd00000-0xfbdfffff]=
=0D<br>[&nbsp;&nbsp;&nbsp; 5.648206] pci 0000:00:1c.5:&nbsp;&nbsp; bridge w=
indow [mem 0xc0600000-0xc07fffff 64bit pref]=0D<br>[&nbsp;&nbsp;&nbsp; 5.67=
1505] pci
 0000:00:1e.0: PCI bridge to [bus 01-01]=0D<br>[&nbsp;&nbsp;&nbsp; 5.687234=
] pci 0000:00:1e.0:&nbsp;&nbsp; bridge window [io&nbsp; 0xc000-0xcfff]=0D<b=
r>[&nbsp;&nbsp;&nbsp; 5.705567] pci 0000:00:1e.0:&nbsp;&nbsp; bridge window=
 [mem 0xfaf00000-0xfb7fffff]=0D<br>[&nbsp;&nbsp;&nbsp; 5.725975] pci 0000:0=
0:1e.0:&nbsp;&nbsp; bridge window [mem pref disabled]=0D<br>[&nbsp;&nbsp;&n=
bsp; 5.744349] pci 0000:00:1c.0: enabling device (0104 -&gt; 0107)=0D<br>[&=
nbsp;&nbsp;&nbsp; 5.761367] pci 0000:00:1c.0: PCI INT A -&gt; GSI 17 (level=
, low) -&gt; IRQ 17=0D<br>[&nbsp;&nbsp;&nbsp; 5.781520] pci 0000:00:1c.4: P=
CI INT A -&gt; GSI 17 (level, low) -&gt; IRQ 17=0D<br>[&nbsp;&nbsp;&nbsp; 5=
.801673] pci 0000:00:1c.5: PCI INT B -&gt; GSI 16 (level, low) -&gt; IRQ 16=
=0D<br>[&nbsp;&nbsp;&nbsp; 5.822620] NET: Registered protocol family 2=0D<b=
r>[&nbsp;&nbsp;&nbsp; 5.836116] IP route cache hash table entries: 524288 (=
order: 10, 4194304 bytes)=0D<br>[&nbsp;&nbsp;&nbsp; 5.859630] TCP establish=
ed hash table
 entries: 524288 (order: 11, 8388608 bytes)=0D<br>[&nbsp;&nbsp;&nbsp; 5.883=
566] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)=0D<br>[&n=
bsp;&nbsp;&nbsp; 5.903886] TCP: Hash tables configured (established 524288 =
bind 65536)=0D<br>[&nbsp;&nbsp;&nbsp; 5.923765] TCP reno registered=0D<br>[=
&nbsp;&nbsp;&nbsp; 5.934161] UDP hash table entries: 8192 (order: 6, 262144=
 bytes)=0D<br>[&nbsp;&nbsp;&nbsp; 5.952568] UDP-Lite hash table entries: 81=
92 (order: 6, 262144 bytes)=0D<br>[&nbsp;&nbsp;&nbsp; 5.972409] NET: Regist=
ered protocol family 1=0D<br>[&nbsp;&nbsp;&nbsp; 5.985767] PCI-DMA: Using s=
oftware bounce buffering for IO (SWIOTLB)=0D<br>[&nbsp;&nbsp;&nbsp; 6.00512=
3] Placing 64MB software IO TLB between ffff8800bae00000 - ffff8800bee00000=
=0D<br>[&nbsp;&nbsp;&nbsp; 6.028420] software IO TLB at phys 0xbae00000 - 0=
xbee00000=0D<br>[&nbsp;&nbsp;&nbsp; 6.045876] audit: initializing netlink s=
ocket (disabled)=0D<br>[&nbsp;&nbsp;&nbsp; 6.062123] type=3D2000 audit(1304=
584127.130:1):
 initialized=0D<br>[&nbsp;&nbsp;&nbsp; 6.088884] I-pipe: Domain Xenomai reg=
istered.=0D<br>[&nbsp;&nbsp;&nbsp; 6.102518] Xenomai: hal/x86_64 started.=
=0D<br>[&nbsp;&nbsp;&nbsp; 6.114349] Xenomai: scheduling class idle registe=
red.=0D<br>[&nbsp;&nbsp;&nbsp; 6.129794] Xenomai: scheduling class rt regis=
tered.=0D<br>[&nbsp;&nbsp;&nbsp; 6.145957] Xenomai: real-time nucleus v2.5.=
6 (Wormhole Wizards) loaded.=0D<br>[&nbsp;&nbsp;&nbsp; 6.166302] Xenomai: S=
MI-enabled chipset found, but SMI workaround disabled=0D<br>[&nbsp;&nbsp;&n=
bsp; 6.166303]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (check=
 CONFIG_XENO_HW_SMI_WORKAROUND). You may encounter=0D<br>[&nbsp;&nbsp;&nbsp=
; 6.166304]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; high inte=
rrupt latencies!=0D<br>[&nbsp;&nbsp;&nbsp; 6.222214] Xenomai: starting nati=
ve API services.=0D<br>[&nbsp;&nbsp;&nbsp; 6.236634] Xenomai: starting POSI=
X services.=0D<br>[&nbsp;&nbsp;&nbsp; 6.249786] Xenomai: starting RTDM serv=
ices.
=0D<br>[&nbsp;&nbsp;&nbsp; 6.263337] HugeTLB registered 2 MB page size, pre=
-allocated 0 pages=0D<br>[&nbsp;&nbsp;&nbsp; 6.284003] VFS: Disk quotas dqu=
ot_6.5.2=0D<br>[&nbsp;&nbsp;&nbsp; 6.295869] Dquot-cache hash table entries=
: 512 (order 0, 4096 bytes)=0D<br>[&nbsp;&nbsp;&nbsp; 6.315820] fuse init (=
API version 7.15)=0D<br>[&nbsp;&nbsp;&nbsp; 6.327723] msgmni has been set t=
o 24053=0D<br>[&nbsp;&nbsp;&nbsp; 6.339780] Block layer SCSI generic (bsg) =
driver version 0.4 loaded (major 253)=0D<br>[&nbsp;&nbsp;&nbsp; 6.362036] i=
o scheduler noop registered=0D<br>[&nbsp;&nbsp;&nbsp; 6.373840] io schedule=
r deadline registered=0D<br>[&nbsp;&nbsp;&nbsp; 6.386715] io scheduler cfq =
registered (default)=0D<br>[&nbsp;&nbsp;&nbsp; 6.401070] pci_hotplug: PCI H=
ot Plug PCI Core version: 0.5=0D<br>[&nbsp;&nbsp;&nbsp; 6.417852] pciehp: P=
CI Express Hot Plug Controller Driver version: 0.4=0D<br>[&nbsp;&nbsp;&nbsp=
; 6.437827] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:0=
0/input/input0
=0D<br>[&nbsp;&nbsp;&nbsp; 6.462429] ACPI: Power Button [PWRB]=0D<br>[&nbsp=
;&nbsp;&nbsp; 6.473511] input: Power Button as /devices/LNXSYSTM:00/LNXPWRB=
N:00/input/input1=0D<br>[&nbsp;&nbsp;&nbsp; 6.495759] ACPI: Power Button [P=
WRF]=0D<br>[&nbsp;&nbsp;&nbsp; 6.508829] Linux agpgart interface v0.103=0D<=
br>[&nbsp;&nbsp;&nbsp; 6.521179] Serial: 8250/16550 driver, 4 ports, IRQ sh=
aring enabled=0D<br>[&nbsp;&nbsp;&nbsp; 6.560516] serial8250: ttyS0 at I/O =
0x3f8 (irq =3D 4) is a 16550A=0D<br>[&nbsp;&nbsp;&nbsp; 6.722533] serial825=
0: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A=0D<br>[&nbsp;&nbsp;&nbsp; 7.2=
42625] 00:09: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=0D<br>[&nbsp;&nbsp=
;&nbsp; 7.402521] 00:0a: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A=0D<br>[=
&nbsp;&nbsp;&nbsp; 7.543047] brd: module loaded=0D<br>[&nbsp;&nbsp;&nbsp; 7=
.552721] loop: module loaded=0D<br>[&nbsp;&nbsp;&nbsp; 7.562330] ata_piix 0=
000:00:1f.2: PCI INT A -&gt; GSI 23 (level, low) -&gt; IRQ 23=0D<br>[&nbsp;=
&nbsp;&nbsp; 7.583788]
 ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]=0D<br>[&nbsp;&nbsp;&nbsp; 7.599=
919] scsi0 : ata_piix=0D<br>[&nbsp;&nbsp;&nbsp; 7.608700] scsi1 : ata_piix=
=0D<br>[&nbsp;&nbsp;&nbsp; 7.618693] ata1: SATA max UDMA/133 cmd 0xac00 ctl=
 0xa880 bmdma 0xa400 irq 23=0D<br>[&nbsp;&nbsp;&nbsp; 7.640133] ata2: SATA =
max UDMA/133 cmd 0xa800 ctl 0xa480 bmdma 0xa408 irq 23=0D<br>[&nbsp;&nbsp;&=
nbsp; 7.661595] ata_piix 0000:00:1f.5: PCI INT B -&gt; GSI 21 (level, low) =
-&gt; IRQ 21=0D<br>[&nbsp;&nbsp;&nbsp; 7.683057] ata_piix 0000:00:1f.5: MAP=
 [ P0 -- P1 -- ]=0D<br>[&nbsp;&nbsp;&nbsp; 7.699101] scsi2 : ata_piix=0D<br=
>[&nbsp;&nbsp;&nbsp; 7.707888] scsi3 : ata_piix=0D<br>[&nbsp;&nbsp;&nbsp; 7=
.717817] ata3: SATA max UDMA/133 cmd 0xbc00 ctl 0xb880 bmdma 0xb400 irq 21=
=0D<br>[&nbsp;&nbsp;&nbsp; 7.739272] ata4: SATA max UDMA/133 cmd 0xb800 ctl=
 0xb480 bmdma 0xb408 irq 21=0D<br>[&nbsp;&nbsp;&nbsp; 7.760970] Fixed MDIO =
Bus: probed=0D<br>[&nbsp;&nbsp;&nbsp; 7.771246] PPP generic driver version =
2.4.2
=0D<br>[&nbsp;&nbsp;&nbsp; 7.784126] tun: Universal TUN/TAP device driver, =
1.6=0D<br>[&nbsp;&nbsp;&nbsp; 7.799334] tun: (C) 1999-2004 Max Krasnyansky =
&lt;maxk@domain.hid&gt;=0D<br>[&nbsp;&nbsp;&nbsp; 7.817984] ehci_hcd: USB=
 2.0 'Enhanced' Host Controller (EHCI) Driver=0D<br>[&nbsp;&nbsp;&nbsp; 7.8=
37635] ehci_hcd 0000:00:1a.7: PCI INT C -&gt; GSI 18 (level, low) -&gt; IRQ=
 18=0D<br>[&nbsp;&nbsp;&nbsp; 7.859104] ehci_hcd 0000:00:1a.7: EHCI Host Co=
ntroller=0D<br>[&nbsp;&nbsp;&nbsp; 7.874852] ehci_hcd 0000:00:1a.7: new USB=
 bus registered, assigned bus number 1=0D<br>[&nbsp;&nbsp;&nbsp; 7.941979] =
ehci_hcd 0000:00:1a.7: debug port 1=0D<br>[&nbsp;&nbsp;&nbsp; 7.959515] ehc=
i_hcd 0000:00:1a.7: irq 18, io mem 0xfbcf9000=0D<br>[&nbsp;&nbsp;&nbsp; 7.9=
91945] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00=0D<br>[&nbsp;&nbsp=
;&nbsp; 8.009334] hub 1-0:1.0: USB hub found=0D<br>[&nbsp;&nbsp;&nbsp; 8.02=
0629] hub 1-0:1.0: 4 ports detected=0D<br>[&nbsp;&nbsp;&nbsp; 8.032780] ehc=
i_hcd
 0000:00:1d.7: PCI INT A -&gt; GSI 23 (level, low) -&gt; IRQ 23=0D<br>[&nbs=
p;&nbsp;&nbsp; 8.054234] ehci_hcd 0000:00:1d.7: EHCI Host Controller=0D<br>=
[&nbsp;&nbsp;&nbsp; 8.069978] ehci_hcd 0000:00:1d.7: new USB bus registered=
, assigned bus number 2=0D<br>[&nbsp;&nbsp;&nbsp; 8.112645] ata3: SATA link=
 down (SStatus 0 SControl 300)=0D<br>[&nbsp;&nbsp;&nbsp; 8.141963] ehci_hcd=
 0000:00:1d.7: debug port 1=0D<br>[&nbsp;&nbsp;&nbsp; 8.159473] ehci_hcd 00=
00:00:1d.7: irq 23, io mem 0xfbcfa000=0D<br>[&nbsp;&nbsp;&nbsp; 8.191930] e=
hci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00=0D<br>[&nbsp;&nbsp;&nbsp; =
8.209287] hub 2-0:1.0: USB hub found=0D<br>[&nbsp;&nbsp;&nbsp; 8.220575] hu=
b 2-0:1.0: 8 ports detected=0D<br>[&nbsp;&nbsp;&nbsp; 8.232731] ohci_hcd: U=
SB 1.1 'Open' Host Controller (OHCI) Driver=0D<br>[&nbsp;&nbsp;&nbsp; 8.251=
317] uhci_hcd: USB Universal Host Controller Interface driver=0D<br>[&nbsp;=
&nbsp;&nbsp; 8.270457] uhci_hcd 0000:00:1a.0: PCI INT A -&gt; GSI 16 (level=
, low) -&gt;
 IRQ 16=0D<br>[&nbsp;&nbsp;&nbsp; 8.282000] ata4: SATA link up 3.0 Gbps (SS=
tatus 123 SControl 300)=0D<br>[&nbsp;&nbsp;&nbsp; 8.302971] ata4.00: ATA-7:=
 SQF-S25M4-16G, VER2.A13, max UDMA/133=0D<br>[&nbsp;&nbsp;&nbsp; 8.302974] =
ata4.00: 30080736 sectors, multi 0: LBA48&nbsp;=0D<br>[&nbsp;&nbsp;&nbsp; 8=
.342965] ata4.00: configured for UDMA/133=0D<br>[&nbsp;&nbsp;&nbsp; 8.35710=
5] uhci_hcd 0000:00:1a.0: UHCI Host Controller=0D<br>[&nbsp;&nbsp;&nbsp; 8.=
362907] ata2.00: SATA link down (SStatus 0 SControl 300)=0D<br>[&nbsp;&nbsp=
;&nbsp; 8.362923] ata2.01: SATA link down (SStatus 0 SControl 300)=0D<br>[&=
nbsp;&nbsp;&nbsp; 8.406874] uhci_hcd 0000:00:1a.0: new USB bus registered, =
assigned bus number 3=0D<br>[&nbsp;&nbsp;&nbsp; 8.481940] uhci_hcd 0000:00:=
1a.0: irq 16, io base 0x00009400=0D<br>[&nbsp;&nbsp;&nbsp; 8.499318] hub 3-=
0:1.0: USB hub found=0D<br>[&nbsp;&nbsp;&nbsp; 8.510616] hub 3-0:1.0: 2 por=
ts detected=0D<br>[&nbsp;&nbsp;&nbsp; 8.511984] ata1.00: SATA link down (SS=
tatus 0 SControl
 300)=0D<br>[&nbsp;&nbsp;&nbsp; 8.511997] ata1.01: SATA link up 3.0 Gbps (S=
Status 123 SControl 300)=0D<br>[&nbsp;&nbsp;&nbsp; 8.542356] ata1.01: ATA-8=
: ST31000524NS, SN11, max UDMA/133=0D<br>[&nbsp;&nbsp;&nbsp; 8.542359] ata1=
.01: 1953525168 sectors, multi 16: LBA48 NCQ (depth 0/32)=0D<br>[&nbsp;&nbs=
p;&nbsp; 8.582350] ata1.01: configured for UDMA/133=0D<br>[&nbsp;&nbsp;&nbs=
p; 8.582482] scsi 0:0:1:0: Direct-Access&nbsp;&nbsp;&nbsp;&nbsp; ATA&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ST31000524NS&nbsp;&nbsp;&nbsp;&nbsp; SN11 PQ: 0 ANS=
I: 5=0D<br>[&nbsp;&nbsp;&nbsp; 8.582612] sd 0:0:1:0: Attached scsi generic =
sg0 type 0=0D<br>[&nbsp;&nbsp;&nbsp; 8.582635] sd 0:0:1:0: [sda] 1953525168=
 512-byte logical blocks: (1.00 TB/931 GiB)=0D<br>[&nbsp;&nbsp;&nbsp; 8.582=
703] sd 0:0:1:0: [sda] Write Protect is off=0D<br>[&nbsp;&nbsp;&nbsp; 8.582=
720] scsi 3:0:0:0: Direct-Access&nbsp;&nbsp;&nbsp;&nbsp; ATA&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SQF-S25M4-16G&nbsp;&nbsp;&nbsp; VER2 PQ: 0 ANSI: 5
=0D<br>[&nbsp;&nbsp;&nbsp; 8.582729] sd 0:0:1:0: [sda] Write cache: enabled=
, read cache: enabled, doesn't support DPO or FUA=0D<br>[&nbsp;&nbsp;&nbsp;=
 8.582831] sd 3:0:0:0: Attached scsi generic sg1 type 0=0D<br>[&nbsp;&nbsp;=
&nbsp; 8.582841] sd 3:0:0:0: [sdb] 30080736 512-byte logical blocks: (15.4 =
GB/14.3 GiB)=0D<br>[&nbsp;&nbsp;&nbsp; 8.582901] sd 3:0:0:0: [sdb] Write Pr=
otect is off=0D<br>[&nbsp;&nbsp;&nbsp; 8.582925] sd 3:0:0:0: [sdb] Write ca=
che: enabled, read cache: enabled, doesn't support DPO or FUA=0D<br>[&nbsp;=
&nbsp;&nbsp; 8.584615]&nbsp; sdb: sdb1=0D<br>[&nbsp;&nbsp;&nbsp; 8.619933]&=
nbsp; sda: sda1 sda2 &lt; sda5 &gt;=0D<br>[&nbsp;&nbsp;&nbsp; 8.836982] uhc=
i_hcd 0000:00:1a.1: PCI INT B -&gt; GSI 21 (level, low) -&gt; IRQ 21=0D<br>=
[&nbsp;&nbsp;&nbsp; 8.837017] sd 0:0:1:0: [sda] Attached SCSI disk=0D<br>[&=
nbsp;&nbsp;&nbsp; 8.837019] sd 3:0:0:0: [sdb] Attached SCSI disk=0D<br>[&nb=
sp;&nbsp;&nbsp; 8.886204] uhci_hcd 0000:00:1a.1: UHCI Host Controller
=0D<br>[&nbsp;&nbsp;&nbsp; 8.901956] uhci_hcd 0000:00:1a.1: new USB bus reg=
istered, assigned bus number 4=0D<br>[&nbsp;&nbsp;&nbsp; 9.001887] uhci_hcd=
 0000:00:1a.1: irq 21, io base 0x00009480=0D<br>[&nbsp;&nbsp;&nbsp; 9.01925=
9] hub 4-0:1.0: USB hub found=0D<br>[&nbsp;&nbsp;&nbsp; 9.030556] hub 4-0:1=
.0: 2 ports detected=0D<br>[&nbsp;&nbsp;&nbsp; 9.042702] uhci_hcd 0000:00:1=
d.0: PCI INT A -&gt; GSI 23 (level, low) -&gt; IRQ 23=0D<br>[&nbsp;&nbsp;&n=
bsp; 9.064151] uhci_hcd 0000:00:1d.0: UHCI Host Controller=0D<br>[&nbsp;&nb=
sp;&nbsp; 9.079910] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned=
 bus number 5=0D<br>[&nbsp;&nbsp;&nbsp; 9.181869] uhci_hcd 0000:00:1d.0: ir=
q 23, io base 0x00009800=0D<br>[&nbsp;&nbsp;&nbsp; 9.199239] hub 5-0:1.0: U=
SB hub found=0D<br>[&nbsp;&nbsp;&nbsp; 9.210533] hub 5-0:1.0: 2 ports detec=
ted=0D<br>[&nbsp;&nbsp;&nbsp; 9.222670] uhci_hcd 0000:00:1d.1: PCI INT B -&=
gt; GSI 19 (level, low) -&gt; IRQ 19=0D<br>[&nbsp;&nbsp;&nbsp; 9.244132] uh=
ci_hcd
 0000:00:1d.1: UHCI Host Controller=0D<br>[&nbsp;&nbsp;&nbsp; 9.259881] uhc=
i_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6=0D<br>[&n=
bsp;&nbsp;&nbsp; 9.361867] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000988=
0=0D<br>[&nbsp;&nbsp;&nbsp; 9.379245] hub 6-0:1.0: USB hub found=0D<br>[&nb=
sp;&nbsp;&nbsp; 9.390539] hub 6-0:1.0: 2 ports detected=0D<br>[&nbsp;&nbsp;=
&nbsp; 9.402683] uhci_hcd 0000:00:1d.2: PCI INT C -&gt; GSI 18 (level, low)=
 -&gt; IRQ 18=0D<br>[&nbsp;&nbsp;&nbsp; 9.424134] uhci_hcd 0000:00:1d.2: UH=
CI Host Controller=0D<br>[&nbsp;&nbsp;&nbsp; 9.439886] uhci_hcd 0000:00:1d.=
2: new USB bus registered, assigned bus number 7=0D<br>[&nbsp;&nbsp;&nbsp; =
9.531843] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00009c00=0D<br>[&nbsp;&n=
bsp;&nbsp; 9.549213] hub 7-0:1.0: USB hub found=0D<br>[&nbsp;&nbsp;&nbsp; 9=
.560512] hub 7-0:1.0: 2 ports detected=0D<br>[&nbsp;&nbsp;&nbsp; 9.572653] =
uhci_hcd 0000:00:1d.3: PCI INT D -&gt; GSI 16 (level, low) -&gt; IRQ 16
=0D<br>[&nbsp;&nbsp;&nbsp; 9.594102] uhci_hcd 0000:00:1d.3: UHCI Host Contr=
oller=0D<br>[&nbsp;&nbsp;&nbsp; 9.609853] uhci_hcd 0000:00:1d.3: new USB bu=
s registered, assigned bus number 8=0D<br>[&nbsp;&nbsp;&nbsp; 9.711827] uhc=
i_hcd 0000:00:1d.3: irq 16, io base 0x0000a000=0D<br>[&nbsp;&nbsp;&nbsp; 9.=
729249] hub 8-0:1.0: USB hub found=0D<br>[&nbsp;&nbsp;&nbsp; 9.740536] hub =
8-0:1.0: 2 ports detected=0D<br>[&nbsp;&nbsp;&nbsp; 9.831839] PNP: PS/2 Con=
troller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12=0D<br>[&nbsp;&nbs=
p;&nbsp; 9.857332] serio: i8042 KBD port at 0x60,0x64 irq 1=0D<br>[&nbsp;&n=
bsp;&nbsp; 9.872288] serio: i8042 AUX port at 0x60,0x64 irq 12=0D<br>[&nbsp=
;&nbsp;&nbsp; 9.887563] mice: PS/2 mouse device common for all mice=0D<br>[=
&nbsp;&nbsp;&nbsp; 9.903354] rtc_cmos 00:03: RTC can wake from S4=0D<br>[&n=
bsp;&nbsp;&nbsp; 9.937089] input: AT Translated Set 2 keyboard as /devices/=
platform/i8042/serio0/input/input2=0D<br>[&nbsp;&nbsp; 10.031835] rtc_cmos =
00:03: rtc core:
 registered rtc_cmos as rtc0=0D<br>[&nbsp;&nbsp; 10.050175] rtc0: alarms up=
 to one month, y3k, 114 bytes nvram, hpet irqs=0D<br>[&nbsp;&nbsp; 10.07067=
3] device-mapper: uevent: version 1.0.3=0D<br>[&nbsp;&nbsp; 10.084682] devi=
ce-mapper: ioctl: 4.18.0-ioctl (2010-06-29) initialised: dm-devel@domain.hid=
m=0D<br>[&nbsp;&nbsp; 10.110116] device-mapper: multipath: version 1.1.1 lo=
aded=0D<br>[&nbsp;&nbsp; 10.126624] device-mapper: multipath round-robin: v=
ersion 1.0.0 loaded=0D<br>[&nbsp;&nbsp; 10.146326] cpuidle: using governor =
ladder=0D<br>[&nbsp;&nbsp; 10.158655] cpuidle: using governor menu=0D<br>[&=
nbsp;&nbsp; 10.170643] TCP cubic registered=0D<br>[&nbsp;&nbsp; 10.180468] =
NET: Registered protocol family 10=0D<br>[&nbsp;&nbsp; 10.194195] lo: Disab=
led Privacy Extensions=0D<br>[&nbsp;&nbsp; 10.206922] NET: Registered proto=
col family 17=0D<br>[&nbsp;&nbsp; 10.220314] Registering the dns_resolver k=
ey type=0D<br>[&nbsp;&nbsp; 10.234568] registered taskstats version 1=0D<br=
>[&nbsp;&nbsp;
 10.248313]&nbsp;&nbsp; Magic number: 11:141:472=0D<br>[&nbsp;&nbsp; 10.259=
689] acpi LNXSYSTM:00: hash matches=0D<br>[&nbsp;&nbsp; 10.272049] rtc_cmos=
 00:03: setting system clock to 2011-05-05 08:28:55 UTC (1304584135)=0D<br>=
[&nbsp;&nbsp; 10.296383] BIOS EDD facility v0.16 2004-Jun-25, 0 devices fou=
nd=0D<br>[&nbsp;&nbsp; 10.314452] EDD information not available.=0D<br>[&nb=
sp;&nbsp; 10.326830] md: Waiting for all devices to be available before aut=
odetect=0D<br>[&nbsp;&nbsp; 10.347240] md: If you don't use raid, use raid=
=3Dnoautodetect=0D<br>[&nbsp;&nbsp; 10.364368] md: Autodetecting RAID array=
s.=0D<br>[&nbsp;&nbsp; 10.376698] md: Scanned 0 and added 0 devices.=0D<br>=
[&nbsp;&nbsp; 10.390061] md: autorun ...=0D<br>[&nbsp;&nbsp; 10.398487] md:=
 ... autorun DONE.=0D<br>[&nbsp;&nbsp; 10.418738] EXT3-fs (sda1): error: co=
uldn't mount because of unsupported optional features (240)=0D<br>[&nbsp;&n=
bsp; 10.445822] EXT2-fs (sda1): error: couldn't mount because of unsupporte=
d optional features
 (244)=0D<br>[&nbsp;&nbsp; 10.487922] EXT4-fs (sda1): INFO: recovery requir=
ed on readonly filesystem=0D<br>[&nbsp;&nbsp; 10.508729] EXT4-fs (sda1): wr=
ite access will be enabled during recovery=0D<br>[&nbsp;&nbsp; 10.633306] E=
XT4-fs (sda1): recovery complete=0D<br>[&nbsp;&nbsp; 10.648799] EXT4-fs (sd=
a1): mounted filesystem with ordered data mode. Opts: (null)=0D<br>[&nbsp;&=
nbsp; 10.671998] VFS: Mounted root (ext4 filesystem) readonly on device 8:1=
.=0D<br>[&nbsp;&nbsp; 10.719017] devtmpfs: mounted=0D<br>[&nbsp;&nbsp; 10.7=
27987] Freeing unused kernel memory: 940k freed=0D<br>[&nbsp;&nbsp; 10.7430=
87] Write protecting the kernel read-only data: 10240k=0D<br>[&nbsp;&nbsp; =
10.760773] Freeing unused kernel memory: 328k freed=0D<br>[&nbsp;&nbsp; 10.=
775863] Freeing unused kernel memory: 1924k freed=0D<br>[&nbsp;&nbsp; 17.49=
1241] hda-intel: no codecs found!=0D<br>[&nbsp;&nbsp; 31.812461] BUG: unabl=
e to handle kernel NULL pointer dereference at 0000000000000018=0D<br>[&nbs=
p;&nbsp; 31.835959]
 IP: [&lt;ffffffff81023c00&gt;] __ipipe_get_ioapic_irq_vector+0x30/0x40=0D<=
br>[&nbsp;&nbsp; 31.857122] PGD 32bd90067 PUD 332714067 PMD 0&nbsp;=0D<br>[=
&nbsp;&nbsp; 31.870488] Oops: 0000 [#1] SMP&nbsp;=0D<br>[&nbsp;&nbsp; 31.88=
0213] last sysfs file: /sys/devices/pci0000:00/0000:00:1c.5/0000:02:00.0/ir=
q=0D<br>[&nbsp;&nbsp; 31.902885] CPU 0&nbsp;=0D<br>[&nbsp;&nbsp; 31.908370]=
 Modules linked in: binfmt_misc ppdev dm_crypt snd_hda_intel snd_hda_codec =
snd_hwdep snd_pcm_oss snd_mixer_oss e1000e snd_pcm snd_seq_dummy snd_seq_os=
s snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_dev=
ice shpchp snd ioatdma dca lp soundcore psmouse snd_page_alloc serio_raw pa=
rport=0D<br>[&nbsp;&nbsp; 31.993160]&nbsp;=0D<br>[&nbsp;&nbsp; 31.997632] P=
id: 0, comm: swapper Not tainted 2.6.37.6 #1 System manufacturer System Pro=
duct Name/Z8NA-D6(C)=0D<br>[&nbsp;&nbsp; 32.027194] RIP: 0010:[&lt;ffffffff=
81023c00&gt;]&nbsp; [&lt;ffffffff81023c00&gt;]
 __ipipe_get_ioapic_irq_vector+0x30/0x40=0D<br>[&nbsp;&nbsp; 32.055613] RSP=
: 0018:ffff8800bee03d08&nbsp; EFLAGS: 00010046=0D<br>[&nbsp;&nbsp; 32.07150=
2] RAX: 0000000000000000 RBX: ffffffff81c38740 RCX: 0000000000000000=0D<br>=
[&nbsp;&nbsp; 32.092874] RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0=
000000000000020=0D<br>[&nbsp;&nbsp; 32.114246] RBP: ffff8800bee03d08 R08: f=
fff8800bee0e860 R09: ffff8800bee0e850=0D<br>[&nbsp;&nbsp; 32.135592] R10: f=
fff8800bee0e848 R11: 0000000000000002 R12: 0000000000032a60=0D<br>[&nbsp;&n=
bsp; 32.156940] R13: 000000000000e840 R14: ffffffff81c38748 R15: ffff8800be=
e0c460=0D<br>[&nbsp;&nbsp; 32.178313] FS:&nbsp; 0000000000000000(0000) GS:f=
fff8800bee00000(0000) knlGS:0000000000000000=0D<br>[&nbsp;&nbsp; 32.202545]=
 CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 000000008005003b=0D<br>[&nbsp;&nbsp;=
 32.219757] CR2: 0000000000000018 CR3: 0000000327910000 CR4: 00000000000006=
f0=0D<br>[&nbsp;&nbsp; 32.241105] DR0: 0000000000000000 DR1: 00000000000000=
00 DR2:
 0000000000000000=0D<br>[&nbsp;&nbsp; 32.262477] DR3: 0000000000000000 DR6:=
 00000000ffff0ff0 DR7: 0000000000000400=0D<br>[&nbsp;&nbsp; 32.283850] Proc=
ess swapper (pid: 0, threadinfo ffffffff81a00000, task ffffffff81a0b020)=0D=
<br>[&nbsp;&nbsp; 32.308056] Stack:=0D<br>[&nbsp;&nbsp; 32.314063]&nbsp; ff=
ff8800bee03d58 ffffffff810c0615 ffffffff813ff0ca ffffffff810237d0=0D<br>[&n=
bsp;&nbsp; 32.336293]&nbsp; ffffffff81024d95 0000000000000000 0000000000000=
010 0000000000000017=0D<br>[&nbsp;&nbsp; 32.358525]&nbsp; ffff8800bee0c460 =
ffffffff81a01fd8 ffff8800bee03d68 ffffffff810c0e81=0D<br>[&nbsp;&nbsp; 32.3=
80781] Call Trace:=0D<br>[&nbsp;&nbsp; 32.388087]&nbsp; &lt;IRQ&gt;&nbsp;=
=0D<br>[&nbsp;&nbsp; 32.394382]&nbsp; [&lt;ffffffff810c0615&gt;] __ipipe_sy=
nc_stage+0x195/0x1f3=0D<br>[&nbsp;&nbsp; 32.412375]&nbsp; [&lt;ffffffff813f=
f0ca&gt;] ? ata_bmdma_interrupt+0x18a/0x230=0D<br>[&nbsp;&nbsp; 32.431146]&=
nbsp; [&lt;ffffffff810237d0&gt;] ? smp_irq_move_cleanup_interrupt+0x0/0x130
=0D<br>[&nbsp;&nbsp; 32.452259]&nbsp; [&lt;ffffffff81024d95&gt;] ? physflat=
_cpu_mask_to_apicid_and+0x35/0x70=0D<br>[&nbsp;&nbsp; 32.473631]&nbsp; [&lt=
;ffffffff810c0e81&gt;] __ipipe_unstall_root+0x31/0x40=0D<br>[&nbsp;&nbsp; 3=
2.491625]&nbsp; [&lt;ffffffff8105ad03&gt;] __do_softirq+0x63/0x230=0D<br>[&=
nbsp;&nbsp; 32.507798]&nbsp; [&lt;ffffffff8100442e&gt;] call_softirq+0x1e/0=
x50=0D<br>[&nbsp;&nbsp; 32.523710]&nbsp; [&lt;ffffffff81005e25&gt;] do_soft=
irq+0xa5/0xe0=0D<br>[&nbsp;&nbsp; 32.539101]&nbsp; [&lt;ffffffff8105ac15&gt=
;] irq_exit+0x85/0x90=0D<br>[&nbsp;&nbsp; 32.553976]&nbsp; [&lt;ffffffff815=
a70fa&gt;] do_IRQ+0x7a/0x100=0D<br>[&nbsp;&nbsp; 32.568588]&nbsp; [&lt;ffff=
ffff810c066d&gt;] __ipipe_sync_stage+0x1ed/0x1f3=0D<br>[&nbsp;&nbsp; 32.586=
579]&nbsp; [&lt;ffffffff815a7080&gt;] ? do_IRQ+0x0/0x100=0D<br>[&nbsp;&nbsp=
; 32.601427]&nbsp; [&lt;ffffffff810c0673&gt;] ? __xirq_end+0x0/0xd=0D<br>[&=
nbsp;&nbsp; 32.616818]&nbsp; [&lt;ffffffff815a7080&gt;] ? do_IRQ+0x0/0x100
=0D<br>[&nbsp;&nbsp; 32.631666]&nbsp; [&lt;ffffffff810c0b0e&gt;] __ipipe_wa=
lk_pipeline+0x10e/0x120=0D<br>[&nbsp;&nbsp; 32.650439]&nbsp; [&lt;ffffffff8=
101ef2f&gt;] __ipipe_handle_irq+0x13f/0x300=0D<br>[&nbsp;&nbsp; 32.668431]&=
nbsp; [&lt;ffffffff810b9ce0&gt;] ? __ipipe_ack_fasteoi_irq+0x0/0x20=0D<br>[=
&nbsp;&nbsp; 32.687465]&nbsp; [&lt;ffffffff8159f953&gt;] common_interrupt+0=
x13/0x2c=0D<br>[&nbsp;&nbsp; 32.704415]&nbsp; &lt;EOI&gt;&nbsp;=0D<br>[&nbs=
p;&nbsp; 32.710735]&nbsp; [&lt;ffffffff8101f2ab&gt;] ? __ipipe_halt_root+0x=
2b/0x40=0D<br>[&nbsp;&nbsp; 32.728468]&nbsp; [&lt;ffffffff8100c01b&gt;] def=
ault_idle+0x4b/0xb0=0D<br>[&nbsp;&nbsp; 32.744379]&nbsp; [&lt;ffffffff81001=
e7c&gt;] cpu_idle+0xcc/0x150=0D<br>[&nbsp;&nbsp; 32.759513]&nbsp; [&lt;ffff=
ffff815888b2&gt;] rest_init+0x72/0x80=0D<br>[&nbsp;&nbsp; 32.774646]&nbsp; =
[&lt;ffffffff81ab7e62&gt;] start_kernel+0x43d/0x448=0D<br>[&nbsp;&nbsp; 32.=
791077]&nbsp; [&lt;ffffffff81ab7321&gt;] x86_64_start_reservations+0x131/0x=
135
=0D<br>[&nbsp;&nbsp; 32.810890]&nbsp; [&lt;ffffffff81ab7457&gt;] x86_64_sta=
rt_kernel+0x132/0x139=0D<br>[&nbsp;&nbsp; 32.829141] Code: 1f 44 00 00 8d 8=
7 00 ef ff ff 83 f8 1f 77 0c 8d 87 ea ef ff ff c9 c3 0f 1f 40 00 e8 cb 61 0=
9 00 31 d2 48 85 c0 74 04 48 8b 50 18 &lt;0f&gt; b6 42 18 c9 c3 66 2e 0f 1f=
 84 00 00 00 00 00 55 48 89 e5 48&nbsp;=0D<br>[&nbsp;&nbsp; 32.887280] RIP&=
nbsp; [&lt;ffffffff81023c00&gt;] __ipipe_get_ioapic_irq_vector+0x30/0x40=0D=
<br>[&nbsp;&nbsp; 32.908704]&nbsp; RSP &lt;ffff8800bee03d08&gt;=0D<br>[&nbs=
p;&nbsp; 32.919130] CR2: 0000000000000018=0D<br>[&nbsp;&nbsp; 32.929039] --=
-[ end trace 8c9c4ef442ceeb7d ]---=0D<br>[&nbsp;&nbsp; 32.942869] Kernel pa=
nic - not syncing: Fatal exception in interrupt=0D<br>[&nbsp;&nbsp; 32.9618=
77] Pid: 0, comm: swapper Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D&nbsp;&=
nbsp;&nbsp;&nbsp; 2.6.37.6 #1=0D<br>[&nbsp;&nbsp; 32.980649] Call Trace:=0D=
<br>[&nbsp;&nbsp; 32.987981]&nbsp; &lt;IRQ&gt;&nbsp; [&lt;ffffffff8159bdcf&=
gt;]
 panic+0x91/0x1a1=0D<br>[&nbsp;&nbsp; 33.004207]&nbsp; [&lt;ffffffff8105500=
5&gt;] ? kmsg_dump+0x185/0x1b0=0D<br>[&nbsp;&nbsp; 33.020380]&nbsp; [&lt;ff=
ffffff815a09b2&gt;] oops_end+0xf2/0x100=0D<br>[&nbsp;&nbsp; 33.035513]&nbsp=
; [&lt;ffffffff8103005b&gt;] no_context+0xfb/0x260=0D<br>[&nbsp;&nbsp; 33.0=
51167]&nbsp; [&lt;ffffffff81576a9d&gt;] ? packet_rcv_spkt+0x4d/0x1a0=0D<br>=
[&nbsp;&nbsp; 33.068636]&nbsp; [&lt;ffffffff810302f5&gt;] __bad_area_nosema=
phore+0x135/0x1f0=0D<br>[&nbsp;&nbsp; 33.087670]&nbsp; [&lt;ffffffff810303c=
3&gt;] bad_area_nosemaphore+0x13/0x20=0D<br>[&nbsp;&nbsp; 33.105661]&nbsp; =
[&lt;ffffffff815a32fc&gt;] do_page_fault+0x33c/0x4c0=0D<br>[&nbsp;&nbsp; 33=
.122357]&nbsp; [&lt;ffffffff812ec075&gt;] ? blk_complete_request+0x25/0x30=
=0D<br>[&nbsp;&nbsp; 33.140867]&nbsp; [&lt;ffffffff813c794f&gt;] ? scsi_don=
e+0x2f/0x70=0D<br>[&nbsp;&nbsp; 33.156521]&nbsp; [&lt;ffffffff813f024a&gt;]=
 ? ata_scsi_qc_complete+0x6a/0x490=0D<br>[&nbsp;&nbsp; 33.175292]&nbsp;
 [&lt;ffffffff813e8386&gt;] ? ata_sg_clean+0x66/0xd0=0D<br>[&nbsp;&nbsp; 33=
.191725]&nbsp; [&lt;ffffffff813e8480&gt;] ? __ata_qc_complete+0x90/0x140=0D=
<br>[&nbsp;&nbsp; 33.209718]&nbsp; [&lt;ffffffff8101f6b4&gt;] __ipipe_handl=
e_exception+0x144/0x3c0=0D<br>[&nbsp;&nbsp; 33.229270]&nbsp; [&lt;ffffffff8=
13fdc7b&gt;] ? ata_hsm_qc_complete+0x4b/0x130=0D<br>[&nbsp;&nbsp; 33.247784=
]&nbsp; [&lt;ffffffff8159fbe6&gt;] page_fault+0x26/0x70=0D<br>[&nbsp;&nbsp;=
 33.263176]&nbsp; [&lt;ffffffff81023c00&gt;] ? __ipipe_get_ioapic_irq_vecto=
r+0x30/0x40=0D<br>[&nbsp;&nbsp; 33.284028]&nbsp; [&lt;ffffffff81023bf5&gt;]=
 ? __ipipe_get_ioapic_irq_vector+0x25/0x40=0D<br>[&nbsp;&nbsp; 33.304882]&n=
bsp; [&lt;ffffffff810c0615&gt;] __ipipe_sync_stage+0x195/0x1f3=0D<br>[&nbsp=
;&nbsp; 33.322873]&nbsp; [&lt;ffffffff813ff0ca&gt;] ? ata_bmdma_interrupt+0=
x18a/0x230=0D<br>[&nbsp;&nbsp; 33.341646]&nbsp; [&lt;ffffffff810237d0&gt;] =
? smp_irq_move_cleanup_interrupt+0x0/0x130=0D<br>[&nbsp;&nbsp; 33.362758]&n=
bsp;
 [&lt;ffffffff81024d95&gt;] ? physflat_cpu_mask_to_apicid_and+0x35/0x70=0D<=
br>[&nbsp;&nbsp; 33.384133]&nbsp; [&lt;ffffffff810c0e81&gt;] __ipipe_unstal=
l_root+0x31/0x40=0D<br>[&nbsp;&nbsp; 33.402124]&nbsp; [&lt;ffffffff8105ad03=
&gt;] __do_softirq+0x63/0x230=0D<br>[&nbsp;&nbsp; 33.418298]&nbsp; [&lt;fff=
fffff8100442e&gt;] call_softirq+0x1e/0x50=0D<br>[&nbsp;&nbsp; 33.434209]&nb=
sp; [&lt;ffffffff81005e25&gt;] do_softirq+0xa5/0xe0=0D<br>[&nbsp;&nbsp; 33.=
449601]&nbsp; [&lt;ffffffff8105ac15&gt;] irq_exit+0x85/0x90=0D<br>[&nbsp;&n=
bsp; 33.464449]&nbsp; [&lt;ffffffff815a70fa&gt;] do_IRQ+0x7a/0x100=0D<br>[&=
nbsp;&nbsp; 33.479062]&nbsp; [&lt;ffffffff810c066d&gt;] __ipipe_sync_stage+=
0x1ed/0x1f3=0D<br>[&nbsp;&nbsp; 33.497055]&nbsp; [&lt;ffffffff815a7080&gt;]=
 ? do_IRQ+0x0/0x100=0D<br>[&nbsp;&nbsp; 33.511926]&nbsp; [&lt;ffffffff810c0=
673&gt;] ? __xirq_end+0x0/0xd=0D<br>[&nbsp;&nbsp; 33.527318]&nbsp; [&lt;fff=
fffff815a7080&gt;] ? do_IRQ+0x0/0x100=0D<br>[&nbsp;&nbsp; 33.542166]&nbsp;
 [&lt;ffffffff810c0b0e&gt;] __ipipe_walk_pipeline+0x10e/0x120=0D<br>[&nbsp;=
&nbsp; 33.560938]&nbsp; [&lt;ffffffff8101ef2f&gt;] __ipipe_handle_irq+0x13f=
/0x300=0D<br>[&nbsp;&nbsp; 33.578932]&nbsp; [&lt;ffffffff810b9ce0&gt;] ? __=
ipipe_ack_fasteoi_irq+0x0/0x20=0D<br>[&nbsp;&nbsp; 33.597964]&nbsp; [&lt;ff=
ffffff8159f953&gt;] common_interrupt+0x13/0x2c=0D<br>[&nbsp;&nbsp; 33.61491=
5]&nbsp; &lt;EOI&gt;&nbsp; [&lt;ffffffff8101f2ab&gt;] ? __ipipe_halt_root+0=
x2b/0x40=0D<br>[&nbsp;&nbsp; 33.634469]&nbsp; [&lt;ffffffff8100c01b&gt;] de=
fault_idle+0x4b/0xb0=0D<br>[&nbsp;&nbsp; 33.650381]&nbsp; [&lt;ffffffff8100=
1e7c&gt;] cpu_idle+0xcc/0x150=0D<br>[&nbsp;&nbsp; 33.665513]&nbsp; [&lt;fff=
fffff815888b2&gt;] rest_init+0x72/0x80=0D<br>[&nbsp;&nbsp; 33.680646]&nbsp;=
 [&lt;ffffffff81ab7e62&gt;] start_kernel+0x43d/0x448=0D<br>[&nbsp;&nbsp; 33=
.697079]&nbsp; [&lt;ffffffff81ab7321&gt;] x86_64_start_reservations+0x131/0=
x135=0D<br>[&nbsp;&nbsp; 33.716892]&nbsp; [&lt;ffffffff81ab7457&gt;]
 x86_64_start_kernel+0x132/0x139<br><div class=3D"plainMail"><b><br></b></d=
iv></td></tr></table>
--0-598098314-1304584247=:14934--

