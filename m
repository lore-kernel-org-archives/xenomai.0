Message-ID: <5176C108.5050102@bollue.de>
Date: Tue, 23 Apr 2013 19:12:40 +0200
From: Kai Bollue <mlist1@bollue.de>
MIME-Version: 1.0
References: <51757858.6040604@bollue.de> <51767C09.3070502@siemens.com>
	<51769250.7050504@bollue.de> <5176950F.3040702@siemens.com>
	<5176AB28.7000305@bollue.de> <5176AC37.1040405@siemens.com>
In-Reply-To: <5176AC37.1040405@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: Re: [Xenomai] Sporadic freeze using RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 23.04.2013 17:43, Jan Kiszka wrote:
>
> Here is the first (and hopefully the only) problem:
>
> [  100.359484] I-pipe: Detected illicit call from head domain 'Xenomai'
> [  100.359484] <3>        into a regular Linux service
> [  100.493487]  |  #*func    	   [  100.493482] Pid: 0, comm: swapper/6 T=
ainted: G           O 3.5.7-xenomai-2.6.2.1 #7
> [  100.493483] Call Trace:
> [  100.493485] I-pipe tracer log (100 points):
> [  100.493510]  |  #*func    	        0 ipipe_prepare_panic+0x7 (ipipe_ro=
ot_only+0x5d)
> [  100.493536]  |  #*func    	        0 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
> [  100.493563]  |  #*func    	       -1 add_preempt_count+0x9 (_raw_spin_=
lock_irqsave+0x56)
> [  100.493588]  |  # func    	       -1 _raw_spin_lock_irqsave+0x7 (alloc=
_iommu+0x68)
> [  100.493612]  |  # func    	       -1 alloc_iommu+0x11 (dma_map_area+0x=
58)
> [  100.493640]  |  # func    	       -1 dma_map_area+0x11 (gart_map_page+=
0x67)
> [  100.493666]  |  # func    	       -1 gart_map_page+0x8 (pci_map_single=
+0x82 [rt_eepro100])
> [  100.493693]  |  # func    	       -1 __phys_addr+0x4 (pci_map_single+0=
x53 [rt_eepro100])
> [  100.493721]  |  # func    	       -1 ___xnpod_lock_sched+0x4 (__xnpod_=
lock_sched+0x21 [rt_eepro100])
> [  100.493747]  |  + begin   0x80000000     -2 speedo_start_xmit+0x3a [rt=
_eepro100] (rtdev_locked_xmit+0x33 [rtnet])
> [  100.493778]     + func    	       -2 speedo_start_xmit+0x11 [rt_eepro1=
00] (rtdev_locked_xmit+0x33 [rtnet])
>
> You have an IOMMU enabled, but the rt_eepro100 is lacking support for
> premapping its DMA buffers so that it does not call into Linux IOMMU
> remapping code during runtime. The latter raises the error above.
>
> Unless you depend on the IOMMU (unlikely unless KVM is on your feature
> list), disable it and retry.

OK, now we disabled IOMMU support in the kernel. Unfortunately, still =

the same problem.


Regards,
Kai
-------------- next part --------------
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.5.7-xenomai-2.6.2.1 (root@IRT176) (gcc versi=
on 4.4.5 (Debian 4.4.5-8) ) #9 SMP PREEMPT Tue Apr 23 18:46:04 CEST 2013
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-3.5.7-xenomai-2.6.2=
.1 root=3DUUID=3Dac291233-b3d4-4b70-b409-b36931bc7d7c ro console=3DttyS0,11=
5200
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000be1e4fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000be1e5000-0x00000000be4e8fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000be4e9000-0x00000000be8dafff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000be8db000-0x00000000bee2dfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000bee2e000-0x00000000bee2efff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bee2f000-0x00000000bf034fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf035000-0x00000000bf452fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf453000-0x00000000bf7f3fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000bf7f4000-0x00000000bf7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec20000-0x00000000fec20fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed61000-0x00000000fed70fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fef00000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100001000-0x000000043effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.7 present.
[    0.000000] e820: last_pfn =3D 0x43f000 max_arch_pfn =3D 0x400000000
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] e820: last_pfn =3D 0xbf800 max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fda10-0x000fda1f] mapped at =
[ffff8800000fda10]
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0xbf7fffff]
[    0.000000] init_memory_mapping: [mem 0x100000000-0x43effffff]
[    0.000000] RAMDISK: [mem 0x3784a000-0x37feffff]
[    0.000000] ACPI: RSDP 00000000000f0490 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 00000000be8c8070 00064 (v01 ALASKA    A M I 01072=
009 AMI  00010013)
[    0.000000] ACPI: FACP 00000000be8d1090 0010C (v05 ALASKA    A M I 01072=
009 AMI  00010013)
[    0.000000] ACPI Warning: Optional field Pm2ControlBlock has zero addres=
s or length: 0x0000000000000000/0x1 (20120320/tbfadt-579)
[    0.000000] ACPI: DSDT 00000000be8c8170 08F1C (v02 ALASKA    A M I 00000=
000 INTL 20051117)
[    0.000000] ACPI: FACS 00000000be8d4080 00040
[    0.000000] ACPI: APIC 00000000be8d11a0 0009E (v03 ALASKA    A M I 01072=
009 AMI  00010013)
[    0.000000] ACPI: FPDT 00000000be8d1240 00044 (v01 ALASKA    A M I 01072=
009 AMI  00010013)
[    0.000000] ACPI: MCFG 00000000be8d1288 0003C (v01 ALASKA    A M I 01072=
009 MSFT 00010013)
[    0.000000] ACPI: AAFT 00000000be8d12c8 00062 (v01 ALASKA OEMAAFT  01072=
009 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000be8d1330 00038 (v01 ALASKA    A M I 01072=
009 AMI  00000005)
[    0.000000] ACPI: SSDT 00000000be8d1368 01714 (v01 AMD    POWERNOW 00000=
001 AMD  00000001)
[    0.000000] ACPI: BGRT 00000000be8d2a80 00038 (v00 ALASKA    A M I 01072=
009 AMI  00010013)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000043effffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x43effffff]
[    0.000000]   NODE_DATA [mem 0x43effc000-0x43effffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00010000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x43effffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00010000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0xbe1e4fff]
[    0.000000]   node   0: [mem 0xbee2e000-0xbee2efff]
[    0.000000]   node   0: [mem 0xbf035000-0xbf452fff]
[    0.000000]   node   0: [mem 0xbf7f4000-0xbf7fffff]
[    0.000000]   node   0: [mem 0x100001000-0x43effffff]
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x10] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x11] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x12] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x13] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x14] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x15] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x16] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x17] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: IOAPIC (id[0x0a] address[0xfec20000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 10, version 33, address 0xfec20000, GSI 2=
4-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x43538210 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000=
9f000
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 00000000001=
00000
[    0.000000] PM: Registered nosave memory: 00000000be1e5000 - 00000000be4=
e9000
[    0.000000] PM: Registered nosave memory: 00000000be4e9000 - 00000000be8=
db000
[    0.000000] PM: Registered nosave memory: 00000000be8db000 - 00000000bee=
2e000
[    0.000000] PM: Registered nosave memory: 00000000bee2f000 - 00000000bf0=
35000
[    0.000000] PM: Registered nosave memory: 00000000bf453000 - 00000000bf7=
f4000
[    0.000000] PM: Registered nosave memory: 00000000bf800000 - 00000000fec=
00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec=
01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fec=
10000
[    0.000000] PM: Registered nosave memory: 00000000fec10000 - 00000000fec=
11000
[    0.000000] PM: Registered nosave memory: 00000000fec11000 - 00000000fec=
20000
[    0.000000] PM: Registered nosave memory: 00000000fec20000 - 00000000fec=
21000
[    0.000000] PM: Registered nosave memory: 00000000fec21000 - 00000000fed=
00000
[    0.000000] PM: Registered nosave memory: 00000000fed00000 - 00000000fed=
01000
[    0.000000] PM: Registered nosave memory: 00000000fed01000 - 00000000fed=
61000
[    0.000000] PM: Registered nosave memory: 00000000fed61000 - 00000000fed=
71000
[    0.000000] PM: Registered nosave memory: 00000000fed71000 - 00000000fed=
80000
[    0.000000] PM: Registered nosave memory: 00000000fed80000 - 00000000fed=
90000
[    0.000000] PM: Registered nosave memory: 00000000fed90000 - 00000000fef=
00000
[    0.000000] PM: Registered nosave memory: 00000000fef00000 - 00000001000=
00000
[    0.000000] PM: Registered nosave memory: 0000000100000000 - 00000001000=
01000
[    0.000000] e820: [mem 0xbf800000-0xfebfffff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 n=
r_node_ids:1
[    0.000000] PERCPU: Embedded 800 pages/cpu @ffff88042c600000 s3248064 r8=
192 d20544 u4194304
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 4113879
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.5.7-xenoma=
i-2.6.2.1 root=3DUUID=3Dac291233-b3d4-4b70-b409-b36931bc7d7c ro console=3Dt=
tyS0,115200
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Xenomai: forcing noxsave
[    0.000000] Memory: 16350104k/17809408k available (3894k kernel code, 10=
75596k absent, 383708k reserved, 2749k data, 3860k init)
[    0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D8, Nodes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:33024 nr_irqs:1288 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Interrupt pipeline (release #3)
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] Fast TSC calibration using PIT
[    0.001000] Detected 3991.123 MHz processor.
[    0.000004] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 7982.24 BogoMIPS (lpj=3D3991123)
[    0.010602] pid_max: default: 32768 minimum: 301
[    0.015232] Security Framework initialized
[    0.019320] SELinux:  Disabled at boot.
[    0.024603] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes)
[    0.035962] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes)
[    0.044767] Mount-cache hash table entries: 256
[    0.049477] Initializing cgroup subsys cpuacct
[    0.053913] Initializing cgroup subsys devices
[    0.058349] Initializing cgroup subsys freezer
[    0.062785] Initializing cgroup subsys net_cls
[    0.067242] CPU: Physical Processor ID: 0
[    0.071243] CPU: Processor Core ID: 0
[    0.074902] mce: CPU supports 7 MCE banks
[    0.078909] LVT offset 1 assigned for vector 0xf9
[    0.083726] ACPI: Core revision 20120320
[    0.115018] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.130986] CPU0: AMD FX(tm)-8350 Eight-Core Processor            steppi=
ng 00
[    0.239008] Performance Events: AMD Family 15h PMU driver.
[    0.244502] ... version:                0
[    0.248506] ... bit width:              48
[    0.252595] ... generic registers:      6
[    0.256599] ... value mask:             0000ffffffffffff
[    0.261901] ... max period:             00007fffffffffff
[    0.267203] ... fixed-purpose events:   0
[    0.271206] ... event mask:             000000000000003f
[    0.285918] Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 Ok.
[    0.405557] Brought up 8 CPUs
[    0.408523] Total of 8 processors activated (63857.96 BogoMIPS).
[    0.424306] devtmpfs: initialized
[    0.430894] PM: Registering ACPI NVS region [mem 0xbe4e9000-0xbe8dafff] =
(4136960 bytes)
[    0.439396] PM: Registering ACPI NVS region [mem 0xbee2f000-0xbf034fff] =
(2121728 bytes)
[    0.447914] dummy: =

[    0.450198] NET: Registered protocol family 16
[    0.455261] ACPI: bus type pci registered
[    0.459445] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.468737] PCI: not using MMCONFIG
[    0.472240] PCI: Using configuration type 1 for base access
[    0.477816] PCI: Using configuration type 1 for extended access
[    0.487469] bio: create slab <bio-0> at 0
[    0.491697] ACPI: Added _OSI(Module Device)
[    0.495895] ACPI: Added _OSI(Processor Device)
[    0.500352] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.505063] ACPI: Added _OSI(Processor Aggregator Device)
[    0.562015] ACPI: Executed 3 blocks of module-level executable AML code
[    0.613233] ACPI: Interpreter enabled
[    0.616918] ACPI: (supports S0 S3 S4 S5)
[    0.621055] ACPI: Using IOAPIC for interrupt routing
[    0.626716] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.636237] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACP=
I motherboard resources
[    0.785781] ACPI: No dock devices found.
[    0.789714] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.799887] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.807597] pci_root PNP0A03:00: host bridge window [io  0x0000-0x03af]
[    0.814214] pci_root PNP0A03:00: host bridge window [io  0x03e0-0x0cf7]
[    0.820831] pci_root PNP0A03:00: host bridge window [io  0x03b0-0x03df]
[    0.827447] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
[    0.834064] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x00=
0bffff]
[    0.841369] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x00=
0dffff]
[    0.848677] pci_root PNP0A03:00: host bridge window [mem 0xc0000000-0xff=
ffffff]
[    0.856109] PCI host bridge to bus 0000:00
[    0.860214] pci_bus 0000:00: root bus resource [io  0x0000-0x03af]
[    0.866399] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
[    0.872581] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df]
[    0.878765] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.884949] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f]
[    0.891823] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dfff=
f]
[    0.898699] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfffffff=
f]
[    0.915489] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    0.921416] pci 0000:00:09.0: PCI bridge to [bus 02-02]
[    0.927299] pci 0000:00:0a.0: PCI bridge to [bus 03-03]
[    0.933116] pci 0000:00:14.4: PCI bridge to [bus 04-04] (subtractive dec=
ode)
[    0.940424] pci 0000:00:15.0: PCI bridge to [bus 05-05]
[    0.946383] pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  Yo=
u can enable it with 'pcie_aspm=3Dforce'
[    0.956394] pci 0000:00:15.1: PCI bridge to [bus 06-06]
[    0.963380] pci 0000:00:15.2: PCI bridge to [bus 07-07]
[    0.971360] pci 0000:00:15.3: PCI bridge to [bus 08-08]
[    0.980450]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.986119]  pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND), return=
ed control mask: 0x1d
[    0.994632] ACPI _OSC control for PCIe not granted, disabling ASPM
[    1.073374] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11 14 15) *0
[    1.079988] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11 14 15) *0
[    1.086606] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11 14 15) *0
[    1.093238] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11 14 15) *0
[    1.099804] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11 14 15) *0
[    1.106312] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11 14 15) *0
[    1.112822] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11 14 15) *0
[    1.119337] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11 14 15) *0
[    1.125982] vgaarb: device added: PCI:0000:01:00.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    1.134094] vgaarb: loaded
[    1.136817] vgaarb: bridge control possible 0000:01:00.0
[    1.142255] PCI: Using ACPI for IRQ routing
[    1.165199] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.170195] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    1.178373] Switching to clocksource hpet
[    1.196701] pnp: PnP ACPI init
[    1.199826] ACPI: bus type pnp registered
[    1.205636] system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
[    1.218426] system 00:02: [mem 0xfec20000-0xfec200ff] could not be reser=
ved
[    1.228364] system 00:04: [io  0x040b] has been reserved
[    1.233689] system 00:04: [io  0x04d6] has been reserved
[    1.239015] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    1.244947] system 00:04: [io  0x0c14] has been reserved
[    1.250276] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    1.256207] system 00:04: [io  0x0c52] has been reserved
[    1.261535] system 00:04: [io  0x0c6c] has been reserved
[    1.266862] system 00:04: [io  0x0c6f] has been reserved
[    1.272190] system 00:04: [io  0x0cd0-0x0cd1] has been reserved
[    1.278122] system 00:04: [io  0x0cd2-0x0cd3] has been reserved
[    1.284054] system 00:04: [io  0x0cd4-0x0cd5] has been reserved
[    1.289990] system 00:04: [io  0x0cd6-0x0cd7] has been reserved
[    1.295931] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    1.301862] system 00:04: [io  0x0800-0x089f] has been reserved
[    1.307795] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    1.313726] system 00:04: [io  0x0900-0x090f] has been reserved
[    1.319658] system 00:04: [io  0x0910-0x091f] has been reserved
[    1.325594] system 00:04: [io  0xfe00-0xfefe] has been reserved
[    1.331527] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[    1.338504] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    1.345129] system 00:04: [mem 0xfed80000-0xfed8ffff] has been reserved
[    1.351755] system 00:04: [mem 0xfed61000-0xfed70fff] has been reserved
[    1.358378] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    1.365003] system 00:04: [mem 0xfed00000-0xfed00fff] has been reserved
[    1.371626] system 00:04: [mem 0xffc00000-0xffffffff] has been reserved
[    1.378963] system 00:05: [io  0x0290-0x029f] has been reserved
[    1.387768] system 00:09: [io  0x04d0-0x04d1] has been reserved
[    1.397478] pnp: PnP ACPI: found 14 devices
[    1.401678] ACPI: ACPI bus type pnp unregistered
[    1.419708] pci 0000:06:00.0: no compatible bridge window for [mem 0xfff=
e0000-0xffffffff pref]
[    1.428517] pci 0000:00:15.1: BAR 15: assigned [mem 0xd0100000-0xd01ffff=
f pref]
[    1.435833] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    1.441083] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    1.447203] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    1.454031] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xcfffffff=
 64bit pref]
[    1.461800] pci 0000:00:09.0: PCI bridge to [bus 02-02]
[    1.467052] pci 0000:00:09.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    1.473869] pci 0000:00:0a.0: PCI bridge to [bus 03-03]
[    1.479125] pci 0000:00:0a.0:   bridge window [mem 0xfe800000-0xfe8fffff]
[    1.485954] pci 0000:00:14.4: PCI bridge to [bus 04-04]
[    1.491198] pci 0000:00:14.4:   bridge window [io  0xd000-0xdfff]
[    1.497314] pci 0000:00:14.4:   bridge window [mem 0xfe300000-0xfe5fffff]
[    1.504142] pci 0000:00:15.0: PCI bridge to [bus 05-05]
[    1.509422] pci 0000:06:00.0: BAR 6: assigned [mem 0xd0100000-0xd011ffff=
 pref]
[    1.516657] pci 0000:00:15.1: PCI bridge to [bus 06-06]
[    1.521899] pci 0000:00:15.1:   bridge window [io  0xc000-0xcfff]
[    1.528013] pci 0000:00:15.1:   bridge window [mem 0xfe700000-0xfe7fffff]
[    1.534827] pci 0000:00:15.1:   bridge window [mem 0xd0100000-0xd01fffff=
 pref]
[    1.542075] pci 0000:00:15.2: PCI bridge to [bus 07-07]
[    1.547316] pci 0000:00:15.2:   bridge window [io  0xb000-0xbfff]
[    1.553432] pci 0000:00:15.2:   bridge window [mem 0xfe600000-0xfe6fffff]
[    1.560258] pci 0000:00:15.3: PCI bridge to [bus 08-08]
[    1.565504] pci 0000:00:15.3:   bridge window [io  0xa000-0xafff]
[    1.571636] pci 0000:00:15.3:   bridge window [mem 0xd0000000-0xd00fffff=
 64bit pref]
[    1.579945] NET: Registered protocol family 2
[    1.586414] IP route cache hash table entries: 524288 (order: 10, 419430=
4 bytes)
[    1.598806] TCP established hash table entries: 524288 (order: 11, 83886=
08 bytes)
[    1.608378] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.615284] TCP: Hash tables configured (established 524288 bind 65536)
[    1.621906] TCP: reno registered
[    1.625289] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    1.631568] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    1.638362] NET: Registered protocol family 1
[    1.897549] pci 0000:04:06.0: Firmware left e100 interrupts enabled; dis=
abling
[    1.905092] Unpacking initramfs...
[    2.120049] Freeing initrd memory: 7832k freed
[    2.128663] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.135227] software IO TLB [mem 0xba1e5000-0xbe1e4fff] (64MB) mapped at=
 [ffff8800ba1e5000-ffff8800be1e4fff]
[    2.147891] LVT offset 0 assigned for vector 0x400
[    2.152789] perf: AMD IBS detected (0x000000ff)
[    2.157821] audit: initializing netlink socket (disabled)
[    2.163266] type=3D2000 audit(1366743479.611:1): initialized
[    2.182861] I-pipe: head domain Xenomai registered.
[    2.188207] Xenomai: hal/x86_64 started.
[    2.192369] Xenomai: scheduling class idle registered.
[    2.197540] Xenomai: scheduling class rt registered.
[    2.209853] Xenomai: real-time nucleus v2.6.2.1 (Day At The Beach) loade=
d.
[    2.216752] Xenomai: debug mode enabled.
[    2.228375] Xenomai: starting native API services.
[    2.233197] Xenomai: starting POSIX services.
[    2.237850] Xenomai: starting RTDM services.
[    2.243872] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.258717] VFS: Disk quotas dquot_6.5.2
[    2.262844] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.269730] msgmni has been set to 31949
[    2.274634] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[    2.282060] io scheduler noop registered
[    2.286065] io scheduler deadline registered
[    2.290518] io scheduler cfq registered (default)
[    2.297650] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.324652] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    2.352760] 00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    2.359358] Linux agpgart interface v0.103
[    2.366087] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    2.375901] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.381022] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.386789] mousedev: PS/2 mouse device common for all mice
[    2.392564] rtc_cmos 00:07: RTC can wake from S4
[    2.397567] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
[    2.403758] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.410979] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Te=
am
[    2.418056] rtcan: registered rtcan0
[    2.421683] rtcan0: VIRT driver loaded
[    2.425505] rtcan: registered rtcan1
[    2.429135] rtcan1: VIRT driver loaded
[    2.433376] TCP: cubic registered
[    2.437330] NET: Registered protocol family 10
[    2.442531] mip6: Mobile IPv6
[    2.445536] NET: Registered protocol family 17
[    2.450038] Key type dns_resolver registered
[    2.455066] registered taskstats version 1
[    2.461528] rtc_cmos 00:07: setting system clock to 2013-04-23 18:58:02 =
UTC (1366743482)
[    2.515982] Freeing unused kernel memory: 3860k freed
[    2.523624] Write protecting the kernel read-only data: 6144k
[    2.537658] Freeing unused kernel memory: 192k freed
[    2.571745] Freeing unused kernel memory: 788k freed
Loading, please wait...
[    2.636869] udev[74]: starting version 164
[    2.758608] SCSI subsystem initialized
[    2.760423] ACPI: bus type usb registered
[    2.760570] usbcore: registered new interface driver usbfs
[    2.760643] usbcore: registered new interface driver hub
[    2.761803] usbcore: registered new device driver usb
[    2.763491] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.764370] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    2.777582] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    2.777593] e100: Copyright(c) 1999-2006 Intel Corporation
[    2.809207] r8169 0000:06:00.0: eth0: RTL8168b/8111b at 0xffffc9000187e0=
00, f8:d1:11:02:8b:e5, XID 18000000 IRQ 72
[    2.818337] ehci_hcd 0000:00:12.2: EHCI Host Controller
[    2.818368] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus =
number 1
[    2.818398] ehci_hcd 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    2.818785] ehci_hcd 0000:00:12.2: debug port 1
[    2.818967] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfeb09000
[    2.824121] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    2.824394] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    2.824406] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.824416] usb usb1: Product: EHCI Host Controller
[    2.824425] usb usb1: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ehci_hcd
[    2.824437] usb usb1: SerialNumber: 0000:00:12.2
[    2.825477] hub 1-0:1.0: USB hub found
[    2.825521] hub 1-0:1.0: 5 ports detected
[    2.858665] e100 0000:04:06.0: eth1: addr 0xfe500000, irq 21, MAC addr 0=
0:90:27:8f:f6:c4
[    2.863184] firewire_ohci 0000:07:00.0: added OHCI v1.10 device as card =
0, 4 IR + 8 IT contexts, quirks 0x11
[    2.915699] ehci_hcd 0000:00:13.2: EHCI Host Controller
[    2.915834] r8169 0000:06:00.0: eth0: jumbo features [frames: 4080 bytes=
, tx checksumming: ko]
[    2.916063] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    2.935946] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus =
number 2
[    2.936925] r8169 0000:08:00.0: eth2: RTL8168evl/8111evl at 0xffffc90001=
876000, bc:5f:f4:8b:f4:94, XID 0c900800 IRQ 73
[    2.936933] r8169 0000:08:00.0: eth2: jumbo features [frames: 9200 bytes=
, tx checksumming: ko]
[    2.964021] ehci_hcd 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    2.973093] ehci_hcd 0000:00:13.2: debug port 1
[    2.978029] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfeb07000
[    2.989763] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    2.996014] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.003134] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.010820] usb usb2: Product: EHCI Host Controller
[    3.016006] usb usb2: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ehci_hcd
[    3.023130] usb usb2: SerialNumber: 0000:00:13.2
[    3.028544] hub 2-0:1.0: USB hub found
[    3.032512] hub 2-0:1.0: 5 ports detected
[    3.037410] ehci_hcd 0000:00:16.2: EHCI Host Controller
[    3.042996] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus =
number 3
[    3.050802] ehci_hcd 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    3.060013] ehci_hcd 0000:00:16.2: debug port 1
[    3.064760] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfeb04000
[    3.076579] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    3.082814] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.090040] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.097666] usb usb3: Product: EHCI Host Controller
[    3.102875] usb usb3: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ehci_hcd
[    3.109998] usb usb3: SerialNumber: 0000:00:16.2
[    3.115547] hub 3-0:1.0: USB hub found
[    3.119505] hub 3-0:1.0: 4 ports detected
[    3.124606] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0x=
f impl SATA mode
[    3.133004] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp=
 pio slum part =

[    3.143666] scsi0 : ahci
[    3.146409] Refined TSC clocksource calibration: 3991.357 MHz.
[    3.146787] scsi1 : ahci
[    3.147195] scsi2 : ahci
[    3.147659] scsi3 : ahci
[    3.148011] ata1: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b10=
0 irq 19
[    3.148018] ata2: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b18=
0 irq 19
[    3.148024] ata3: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b20=
0 irq 19
[    3.148032] ata4: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b28=
0 irq 19
[    3.149976] scsi4 : pata_atiixp
[    3.150386] scsi5 : pata_atiixp
[    3.156827] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq=
 14
[    3.156832] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf008 irq=
 15
[    3.167188] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.217238] ohci_hcd 0000:00:12.0: OHCI Host Controller
[    3.217996] Switching to clocksource tsc
[    3.227023] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus =
number 4
[    3.234823] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfeb0a000
[    3.295201] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.302197] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.309726] usb usb4: Product: OHCI Host Controller
[    3.314808] usb usb4: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ohci_hcd
[    3.321938] usb usb4: SerialNumber: 0000:00:12.0
[    3.327988] hub 4-0:1.0: USB hub found
[    3.332030] hub 4-0:1.0: 5 ports detected
[    3.336751] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    3.342272] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus =
number 5
[    3.350157] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfeb08000
[    3.364441] firewire_core 0000:07:00.0: created device fw0: GUID 008f130=
0d3d31300, S400
[    3.410963] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.418133] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.425794] usb usb5: Product: OHCI Host Controller
[    3.431033] usb usb5: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ohci_hcd
[    3.438218] usb usb5: SerialNumber: 0000:00:13.0
[    3.443526] hub 5-0:1.0: USB hub found
[    3.447494] hub 5-0:1.0: 5 ports detected
[    3.452287] ohci_hcd 0000:00:14.5: OHCI Host Controller
[    3.452755] ata3: SATA link down (SStatus 0 SControl 300)
[    3.452825] ata1: SATA link down (SStatus 0 SControl 300)
[    3.452871] ata4: SATA link down (SStatus 0 SControl 300)
[    3.474254] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus =
number 6
[    3.482025] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfeb06000
[    3.542640] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.549790] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.557469] usb usb6: Product: OHCI Host Controller
[    3.562509] usb usb6: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ohci_hcd
[    3.569425] usb usb6: SerialNumber: 0000:00:14.5
[    3.574858] hub 6-0:1.0: USB hub found
[    3.578808] hub 6-0:1.0: 2 ports detected
[    3.583641] ohci_hcd 0000:00:16.0: OHCI Host Controller
[    3.589077] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus =
number 7
[    3.597008] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfeb05000
[    3.607427] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.615074] ata2.00: ATA-8: Hitachi HDS721010CLA330, JP4OA3MA, max UDMA/=
133
[    3.622243] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/3=
2), AA
[    3.631049] ata2.00: configured for UDMA/133
[    3.635979] scsi 1:0:0:0: Direct-Access     ATA      Hitachi HDS72101 JP=
4O PQ: 0 ANSI: 5
[    3.657431] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.657655] sd 1:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    3.658028] sd 1:0:0:0: [sda] Write Protect is off
[    3.658186] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    3.671277] usb 4-3: new low-speed USB device number 2 using ohci_hcd
[    3.680220]  sda: sda1 sda2 sda3
[    3.681962] sd 1:0:0:0: [sda] Attached SCSI disk
[    3.701501] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.708978] usb usb7: Product: OHCI Host Controller
[    3.713982] usb usb7: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ohci_hcd
[    3.720880] usb usb7: SerialNumber: 0000:00:16.0
[    3.726433] hub 7-0:1.0: USB hub found
[    3.730382] hub 7-0:1.0: 4 ports detected
[    3.849992] usb 4-3: New USB device found, idVendor=3D046a, idProduct=3D=
0001
[    3.856990] usb 4-3: New USB device strings: Mfr=3D1, Product=3D0, Seria=
lNumber=3D0
[    3.864614] usb 4-3: Manufacturer: Cherry GmbH
[    3.993576] usb 4-4: new low-speed USB device number 3 using ohci_hcd
[    4.149358] usb 4-4: New USB device found, idVendor=3D046d, idProduct=3D=
c018
[    4.156364] usb 4-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    4.163864] usb 4-4: Product: USB Optical Mouse
[    4.168644] usb 4-4: Manufacturer: Logitech
[    4.199428] usbcore: registered new interface driver usbhid
[    4.205229] usbhid: USB HID core driver
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... =
done.
Begin: Running /scripts/local-premount ... [    4.645511] PM: Starting manu=
al resume from disk
done.
[    4.738514] EXT4-fs (sda1): mounted filesystem with ordered data mode. O=
pts: (null)
Begin: Running /scripts/local-bottom ... done.
done.
Begin: Running /scripts/init-bottom ... done.
INIT: version 2.88 booting
Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevd[    6.154379] udev[329]: star=
ting version 164
.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully pop[    6.436348] input: Power Button as /devi=
ces/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[    6.440480] wmi: Mapper loaded
ulated...[    6.448306] ACPI: Power Button [PWRB]
[    6.453035] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input1
[    6.460763] ACPI: Power Button [PWRF]
[    6.549431] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    6.554863] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 8
[    6.567702] xhci_hcd 0000:02:00.0: irq 48, io mem 0xfe900000
[    6.576368] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    6.583371] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    6.591138] usb usb8: Product: xHCI Host Controller
[    6.596191] usb usb8: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 xhci_hcd
[    6.602780] input: PC Speaker as /devices/platform/pcspkr/input/input2
[    6.610460] usb usb8: SerialNumber: 0000:02:00.0
[    6.611486] microcode: CPU0: patch_level=3D0x06000817
[    6.621033] hub 8-0:1.0: USB hub found
[    6.624944] hub 8-0:1.0: 2 ports detected
[    6.630023] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    6.635548] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 9
[    6.643442] usb usb9: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[    6.650545] usb usb9: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    6.658020] usb usb9: Product: xHCI Host Controller
[    6.663258] usb usb9: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 xhci_hcd
[    6.670229] usb usb9: SerialNumber: 0000:02:00.0
[    6.672296] MCE: In-kernel MCE decoding enabled.
[    6.680334] hub 9-0:1.0: USB hub found
[    6.684225] hub 9-0:1.0: 2 ports detected
[    6.695015] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    6.700516] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus =
number 10
[    6.712857] xhci_hcd 0000:03:00.0: irq 47, io mem 0xfe800000
[    6.720057] usb usb10: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    6.726233] input: Cherry GmbH as /devices/pci0000:00/0000:00:12.0/usb4/=
4-3/4-3:1.0/input/input3
[    6.726481] hid-generic 0003:046A:0001.0001: input,hidraw0: USB HID v1.1=
1 Keyboard [Cherry GmbH] on usb-0000:00:12.0-3/input0
[    6.726924] input: Logitech USB Optical Mouse as /devices/pci0000:00/000=
0:00:12.0/usb4/4-4/4-4:1.0/input/input4
[    6.727369] hid-generic 0003:046D:C018.0002: input,hidraw1: USB HID v1.1=
1 Mouse [Logitech USB Optical Mouse] on usb-0000:00:12.0-4/input0
[    6.771574] usb usb10: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    6.779160] usb usb10: Product: xHCI Host Controller
[    6.784339] usb usb10: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 xhci_hcd
[    6.784818] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[    6.784780] ACPI Warning: 0x0000000000000b00-0x0000000000000b07 SystemIO=
 conflicts with Region \SOR1 1 (20120320/utaddress-251)
[    6.802012] usb usb10: SerialNumber: 0000:03:00.0
[    6.819587] hub 10-0:1.0: USB hub found
[    6.823517] hub 10-0:1.0: 2 ports detected
[    6.828177] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    6.833575] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus =
number 11
[    6.841566] usb usb11: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[    6.848734] usb usb11: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    6.856456] usb usb11: Product: xHCI Host Controller
[    6.861606] usb usb11: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 xhci_hcd
[    6.868844] usb usb11: SerialNumber: 0000:03:00.0
[    6.874343] hub 11-0:1.0: USB hub found
[    6.878397] hub 11-0:1.0: 2 ports detected
[    6.891135] EDAC MC: Ver: 2.1.0
[    6.906020] AMD64 EDAC driver v3.4.0
[    6.909904] EDAC amd64: DRAM ECC disabled.
[    6.914305] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
[    6.914305]  Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
[    6.914305]  (Note that use of the override may cause unknown side effec=
ts.)
[    7.021890] sp5100_tco: SP5100 TCO WatchDog Timer Driver v0.01
[    7.028332] sp5100_tco: mmio address 0xbafe00 already in use
[    7.169251] kvm: Nested Virtualization enabled
[    7.174007] kvm: Nested Paging enabled
[    7.300790] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    7.308536] microcode: CPU1: patch_level=3D0x06000817
[    7.320536] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    7.328136] microcode: CPU2: patch_level=3D0x06000817
[    7.332657] [drm] Initialized drm 1.1.0 20060810
[    7.344833] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    7.352284] microcode: CPU3: patch_level=3D0x06000817
[    7.364084] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    7.371447] microcode: CPU4: patch_level=3D0x06000817
[    7.383334] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    7.384851] [drm] radeon kernel modesetting enabled.
[    7.385952] [drm] initializing kernel modesetting (CEDAR 0x1002:0x68E1 0=
x174B:0x3000).
[    7.403797] microcode: CPU5: patch_level=3D0x06000817
[    7.404010] [drm] register mmio base: 0xFEA20000
[    7.404017] [drm] register mmio size: 131072
[    7.404417] ATOM BIOS: AMD
[    7.404534] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x0000=
00003FFFFFFF (1024M used)
[    7.404540] radeon 0000:01:00.0: GTT: 512M 0x0000000040000000 - 0x000000=
005FFFFFFF
[    7.448936] [drm] Detected VRAM RAM=3D1024M, BAR=3D256M
[    7.454039] [drm] RAM width 64bits DDR
[    7.455743] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    7.455796] microcode: CPU6: patch_level=3D0x06000817
[    7.470863] [TTM] Zone  kernel: Available graphics memory: 8181388 kiB
[    7.471410] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    7.471454] microcode: CPU7: patch_level=3D0x06000817
[    7.478356] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    7.478552] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.f=
snet.co.uk>, Peter Oruba
[    7.506063] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    7.512962] [TTM] Initializing pool allocator
[    7.517565] [TTM] Initializing DMA pool allocator
[    7.522518] [drm] radeon: 1024M of VRAM memory ready
[    7.527777] [drm] radeon: 512M of GTT memory ready.
[    7.533043] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    7.539936] [drm] Driver supports precise vblank timestamp query.
[    7.546503] radeon 0000:01:00.0: radeon: using MSI.
[    7.551706] [drm] radeon: irq initialized.
[    7.556007] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    7.563348] [drm] Loading CEDAR Microcode
[    7.665387] r600_cp: Failed to load firmware "radeon/CEDAR_pfp.bin"
[    7.672010] [drm:evergreen_startup] *ERROR* Failed to load firmware!
[    7.678656] radeon 0000:01:00.0: disabling GPU acceleration
[    7.685648] radeon 0000:01:00.0: ffff88042707d000 unpin not necessary
[    7.692350] radeon 0000:01:00.0: ffff88042707d800 unpin not necessary
[    7.699149] radeon 0000:01:00.0: ffff88042707d800 unpin not necessary
[    7.707385] [drm] Radeon Display Connectors
[    7.711756] [drm] Connector 0:
[    7.715055] [drm]   HDMI-A-1
[    7.718114] [drm]   HPD4
[    7.720800] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644=
c 0x644c
[    7.728554] [drm]   Encoders:
[    7.731725] [drm]     DFP1: INTERNAL_UNIPHY1
[    7.736127] [drm] Connector 1:
[    7.739347] [drm]   DVI-I-1
[    7.742344] [drm]   HPD1
[    7.744980] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646=
c 0x646c
[    7.752643] [drm]   Encoders:
[    7.755793] [drm]     DFP2: INTERNAL_UNIPHY
[    7.760178] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    7.765018] [drm] Connector 2:
[    7.768213] [drm]   VGA-1
[    7.771056] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643=
c 0x643c
[    7.778622] [drm]   Encoders:
[    7.781803] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
[    7.786768] [drm] Internal thermal controller without fan control
[    7.793406] [drm] radeon: power management initialized
[    7.805511] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/s=
ound/card0/input5
[    7.814614] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14=
.2/sound/card0/input6
[    7.823845] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:=
00:14.2/sound/card0/input7
[    7.833597] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:=
00:14.2/sound/card0/input8
[    7.843282] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0=
000:00:14.2/sound/card0/input9
[    7.853451] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000=
:00:14.2/sound/card0/input10
[    7.904506] [drm] fb mappable at 0xC0040000
[    7.909077] [drm] vram apper at 0xC0000000
[    7.913282] [drm] size 5242880
[    7.916472] [drm] fb depth is 24
[    7.919844] [drm]    pitch is 5120
[    7.923725] fbcon: radeondrmfb (fb0) is primary device
[    8.178120] Console: switching to colour frame buffer device 160x64
[    8.187087] fb0: radeondrmfb frame buffer device
[    8.191934] drm: registered panic notifier
[    8.196284] [drm] Initialized radeon 2.18.0 20080528 for 0000:01:00.0 on=
 minor 0
[    8.204290] hda-intel: 0000:01:00.1: Handle VGA-switcheroo audio client
[    8.234955] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:02.0/0000:01:00.1/sound/card1/input11
done.
Setting parameters of disc: (none).
Setting preliminary keymap...done.
Activating swap...[    8.883498] Adding 19530748k swap on /dev/sda2.  Prior=
ity:-1 extents:1 across:19530748k =

done.
[    8.907274] EXT4-fs (sda1): re-mounted. Opts: (null)
Checking root file system...fsck from util-linux-ng 2.17.2
/dev/sda1: clean, 314277/7331840 files, 3258260/29296640 blocks
done.
[    9.114242] EXT4-fs (sda1): re-mounted. Opts: errors=3Dremount-ro
Cleaning up ifupdown....
[    9.222488] loop: module loaded
Loading kernel modules...done.
Setting up networking....
Activating lvm and md swap...done.
Checking file systems...fsck from util-linux-ng 2.17.2
/dev/sda3: clean, 5580/52510720 files, 9690499/210010880 blocks
done.
Mounting local filesystems...[   10.032588] EXT4-fs (sda3): mounted filesys=
tem with ordered data mode. Opts: (null)
done.
Activating swapfile swap...done.
Cleaning up temporary files....
Configuring network interfaces...Internet Systems Consortium DHCP Client 4.=
1.1-P1
Copyright 2004-2010 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

[   10.718372] r8169 0000:08:00.0: eth0: unable to load firmware patch rtl_=
nic/rtl8168e-3.fw (-2)
[   10.739954] r8169 0000:08:00.0: eth0: link down
[   10.746101] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
Listening on LPF/eth0/bc:5f:f4:8b:f4:94
Sending on   LPF/eth0/bc:5f:f4:8b:f4:94
Sending on   Socket/fallback
Setting kernel variables ...done.
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 4
[   12.527721] r8169 0000:08:00.0: eth0: link up
[   12.533624] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 11
DHCPOFFER from [...]
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPACK from [...]
bound to [...] -- renewal in 35697 seconds.
[   16.536802] r8169 0000:06:00.0: eth1: link down
[   16.536858] r8169 0000:06:00.0: eth1: link down
[   16.547746] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
SIOCSIFADDR: No such device
eth2: ERROR while getting interface flags: No such device
SIOCSIFNETMASK: No such device
eth2: ERROR while getting interface flags: No such device
Failed to bring up eth2.
[   16.769148] e100 0000:04:06.0: eth3: NIC Link is Up 100 Mbps Full Duplex
[   16.777244] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   16.784478] IPv6: ADDRCONF(NETDEV_CHANGE): eth3: link becomes ready
done.
Starting portmap daemon....
Starting NFS common utilities: statd.
Cleaning up temporary files....
Setting up ALSA...done.
[   17.202032] fuse init (API version 7.19)
Setting console screen modes.
Rcannot (un)set powersave mode
Skipping font and keymap setup (handled by console-setup).
Setting up console font and keymap...done.
Setting sensors limits.
INIT: Entering runlevel: 2
Using makefile-style concurrent boot in runlevel 2.
Starting portmap daemon...Already running..
Starting NFS common utilities: statd.
Starting enhanced syslogd: rsyslogd.
Enabling additional executable binary formats: binfmt-support.
Starting ACPI services....
Starting system message bus: dbus[   18.642629] r8169 0000:06:00.0: eth1: l=
ink up
[   18.648440] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
.
Starting virtual private network daemon:.
Loading cpufreq kernel modules...done (none).
Not starting GNOME Display Manager; it is not the default display manager.
Starting deferred execution scheduler: atd.
Starting anac(h)ronistic cron: anacron.
Starting periodic command scheduler: cron.
CPUFreq Utilities: Setting ondemand CPUFreq governor...disabled, governor n=
ot available...done.
[   19.800888] Bluetooth: Core ver 2.16
[   19.804792] NET: Registered protocol family 31
[   19.809507] Bluetooth: HCI device and connection manager initialized
[   19.816105] Bluetooth: HCI socket layer initialized
[   19.821504] Bluetooth: L2CAP socket layer initialized
[   19.826700] Bluetooth: SCO socket layer initialized
[   19.934896] sshd (1623): /proc/1623/oom_adj is deprecated, please use /p=
roc/1623/oom_score_adj instead.
Starting OpenBSD Secure Shell server: sshd.
[   20.075425] Bluetooth: RFCOMM TTY layer initialized
[   20.080500] Bluetooth: RFCOMM socket layer initialized
[   20.085869] Bluetooth: RFCOMM ver 1.11
Starting bluetooth: bluetoothd.
Starting kerneloops:
Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon.
[   20.333358] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   20.338978] Bluetooth: BNEP filters: protocol multicast
[   20.496019] lp: driver loaded but no devices found
[   20.569166] Bridge firewalling registered
[   20.654657] ppdev: user-space parallel port driver
Starting MTA: exim4.
Starting Common Unix Printing System: cupsd.
saned disabled; edit /etc/default/saned
Starting Hardware abstraction layer: hald.
Starting K Display Manager: kdm.
Starting ISC DHCP server: dhcpd.
[   79.223392] =

[   79.223392] *** RTnet 0.9.13 - built on Apr 23 2013 15:01:51 ***
[   79.223392] =

[   79.232385] RTnet: initialising real-time networking
[   79.321594] rteth0: 0000:04:06.0, 00:90:27:8F:F6:C4, IRQ 21.
[   79.327671] RTnet: registered rteth0
[   94.327110] I-pipe: Detected illicit call from head domain 'Xenomai'
[   94.327110] <3>        into a regular Linux service
[   94.338291] Pid: 0, comm: swapper/5 Tainted: G           O 3.5.7-xenomai=
-2.6.2.1 #9
[   94.345918] Call Trace:
[   94.348358] I-pipe tracer log (100 points):
[   94.352526]  |  #*func    	        0 ipipe_trace_panic_freeze+0x9 (ipipe=
_root_only+0x62)
[   94.360774]  |  #*func    	        0 ipipe_prepare_panic+0x7 (ipipe_root=
_only+0x5d)
[   94.368618]  |  #*func    	        0 ipipe_root_only+0x9 (add_preempt_co=
unt+0x15)
[   94.376263]  |  #*func    	        0 add_preempt_count+0x9 (_raw_spin_lo=
ck_irqsave+0x56)
[   94.384515]  |  # func    	        0 _raw_spin_lock_irqsave+0x7 (swiotlb=
_tbl_map_single+0x96)
[   94.392925]  |  # func    	       -1 __phys_addr+0x4 ( |  # func    	   =
    -1 __phys_addr+0x4 (pci_map_single+0x53 [rt_eepro100])
[   94.392945]  |  # func    	       -1 ___xnpod_lock_sched+0x4 (__xnpod_lo=
ck_sched+0x21 [rt_eepro100])
[   94.392954]  |  + begin   0x80000000     -2 speedo_start_xmit+0x3a [rt_e=
epro100] (rtdev_locked_xmit+0x33 [rtnet])
[   94.392964]     + func    	       -2 speedo_start_xmit+0x11 [rt_eepro100=
] (rtdev_locked_xmit+0x33 [rtnet])
[   94.392974]  |  + end     0x80000000     -2 hard_local_irq_enable+0x15 (=
__ipipe_restore_head+0x73)
[   94.392983]  |  # func    	       -2 __ipipe_restore_head+0x9 (ipipe_res=
tore_pipeline_head+0x5b)
[   94.392993]  |  + begin   0x80000000     -2 ipipe_test_and_stall_pipelin=
e_head+0x16 (T.935+0x1c)
[   94.393002]     + func    	       -2 rtdm_mutex_timedlock+0x11 (rtdm_mut=
ex_lock+0x12)
[   94.393010]     + func    	       -3 rtdm_mutex_lock+0x4 (rtdev_locked_x=
mit+0x27 [rtnet])
[   94.393020]     + func    	       -3 rtdev_locked_xmit+0xd [rtnet] (rtde=
v_xmit+0x1c [rtnet])
[   94.393030]     + func    	       -3 rtdev_xmit+0x7 [rtnet] (rt_ip_build=
_xmit+0x225 [rtipv4])
[   94.393040]     + func    	       -3 rt_eth_header+0x5 [rtnet] (rt_ip_bu=
ild_xmit+0x219 [rtipv4])
[   94.393050]     + func    	       -4 csum_partial_copy_nocheck+0x4 (rt_i=
cmp_glue_request_bits+0x42 [rtipv4])
[   94.393060]     + func    	       -4 csum_partial_copy_nocheck+0x4 (rt_i=
cmp_glue_request_bits+0x2a [rtipv4])
[   94.393070]     + func    	       -4 rt_icmp_glue_request_bits+0xd [rtip=
v4] (rt_ip_build_xmit+0x1eb [rtipv4])
[   94.393080]  |  + end     0x80000000     -4 hard_local_irq_enable+0x15 (=
__ipipe_restore_head+0x73)
[   94.393089]  |  # func    	       -4 __ipipe_restore_head+0x9 (ipipe_res=
tore_pipeline_head+0x5b [rtnet])
[   94.393099]  |  # func    	       -5 xnsched_pick_next+0x11 (__xnpod_sch=
edule+0xf3)
[   94.393108]  |  # [   -1] -<?>-    0     -5 __xnpod_schedule+0x88 (xnpod=
_schedule+0x36)
[   94.393117]  |  # func    	       -5 __xnpod_schedule+0x14 (xnpod_schedu=
le+0x36)
[   94.393125]  |  # func    	       -5 ___xnpod_unlock_sched+0x4 (__xnpod_=
unlock_sched+0x21 [rtnet])
[   94.393134]  |  # func    	       -5 ___xnpod_lock_sched+0x4 (__xnpod_lo=
ck_sched+0x21 [rtnet])
[   94.393144]  |  + begin   0x80000000     -5 ipipe_test_and_stall_pipelin=
e_head+0x16 [rtnet] (rtskb_dequeue+0x17 [rtnet])
[   94.393155]     + func    	       -6 alloc_rtskb+0x9 [rtnet] (rt_ip_buil=
d_xmit+0x120 [rtipv4])
[   94.393165]  |  + end     0x80000000     -6 hard_local_irq_enable+0x15 (=
__ipipe_restore_head+0x73)
[   94.393174]  |  # func    	       -6 __ipipe_restore_head+0x9 (ipipe_res=
tore_pipeline_head+0x5b [rtipv4])
[   94.393183]  |  # func    	       -6 xnsched_pick_next+0x11 (__xnpod_sch=
edule+0xf3)
[   94.393192]  |  # [   -1] -<?>-    0     -7 __xnpod_schedule+0x88 (xnpod=
_schedule+0x36)
[   94.393200]  |  # func    	       -7 __xnpod_schedule+0x14 (xnpod_schedu=
le+0x36)
[   94.393208]  |  # func    	       -7 ___xnpod_unlock_sched+0x4 (rt_ip_bu=
ild_xmit+0xf6 [rtipv4])
[   94.393217]  |  # func    	       -7 ___xnpod_lock_sched+0x4 (rt_ip_buil=
d_xmit+0xbd [rtipv4])
[   94.393226]  |  + begin   0x80000000     -7 ipipe_test_and_stall_pipelin=
e_head+0x16 [rtipv4] (rt_ip_build_xmit+0x7b [rtipv4])
[   94.393236]     + func    	       -7 rt_hard_mtu+0x4 [rtnet] (rt_ip_buil=
d_xmit+0x42 [rtipv4])
[   94.393246]     + func    	       -8 rt_ip_build_xmit+0x11 [rtipv4] (rt_=
icmp_send_request+0x90 [rtipv4])
[   94.393256]     + func    	       -8 rt_hard_mtu+0x4 [rtnet] (rt_icmp_se=
nd_request+0x5e [rtipv4])
[   94.393266]  |  + end     0x80000000     -8 hard_local_irq_enable+0x15 (=
__ipipe_restore_head+0x73)
[   94.393275]  |  # func    	       -8 __ipipe_restore_head+0x9 (ipipe_res=
tore_pipeline_head+0x5b [rtipv4])
[   94.393284]  |  # func    	       -9 xnsched_pick_next+0x11 (__xnpod_sch=
edule+0xf3)
[   94.393292]  |  # [   -1] -<?>-    0     -9 __xnpod_schedule+0x88 (xnpod=
_schedule+0x36)
[   94.393300]  |  # func    	       -9 __xnpod_schedule+0x14 (xnpod_schedu=
le+0x36)
[   94.393308]  |  # func    	       -9 ___xnpod_unlock_sched+0x4 (__xnpod_=
unlock_sched+0x21 [rtipv4])
[   94.393317]  |  # func    	       -9 ___xnpod_lock_sched+0x4 (__xnpod_lo=
ck_sched+0x21 [rtipv4])
[   94.393326]  |  + begin   0x80000000     -9 ipipe_test_and_stall_pipelin=
e_head+0x16 [rtipv4] (rt_ip_route_output+0x25 [rtipv4])
[   94.393336]     + func    	      -10 rt_ip_route_output+0xf [rtipv4] (rt=
_icmp_send_request+0x40 [rtipv4])
[   94.393346]     + func    	      -10 rt_icmp_send_request+0xd [rtipv4] (=
rt_icmp_send_echo+0xd9 [rtipv4])
[   94.393356]     + func    	      -10 xnarch_tsc_to_ns+0x4 (xnarch_get_cp=
u_time+0x1c)
[   94.393364]     + func    	      -10 xnarch_get_cpu_time+0x4 (rt_icmp_se=
nd_echo+0xa2 [rtipv4])
[   94.393373]  |  + end     0x80000000    -10 hard_local_irq_enable+0x15 (=
__ipipe_restore_head+0x73)
[   94.393382]  |  # func    	      -10 __ipipe_restore_head+0x9 (ipipe_res=
tore_pipeline_head+0x5b [rtipv4])
[   94.393391]  |  # func    	      -11 xnsched_pick_next+0x11 (__xnpod_sch=
edule+0xf3)
[   94.393399]  |  # [   -1] -<?>-    0    -11 __xnpod_schedule+0x88 (xnpod=
_schedule+0x36)
[   94.393407]  |  # func    	      -11 __xnpod_schedule+0x14 (xnpod_schedu=
le+0x36)
[   94.393415]  |  # func    	      -11 ___xnpod_unlock_sched+0x4 (__xnpod_=
unlock_sched+0x21 [rtipv4])
[   94.393424]  |  # func    	      -11 ___xnpod_lock_sched+0x4 (__xnpod_lo=
ck_sched+0x21 [rtipv4])
[   94.393433]  |  + begin   0x80000000    -12 ipipe_test_and_stall_pipelin=
e_head+0x16 [rtipv4] (rt_ip_frag_invalidate_socket+0x1f [rtipv4])
[   94.393443]  |  + end     0x80000000    -12 hard_local_irq_enable+0x15 (=
__ipipe_restore_head+0x73)
[   94.393452]  |  # func    	      -12 __ipipe_restore_head+0x9 (ipipe_res=
tore_pipeline_head+0x5b [rtipv4])
[   94.393461]  |  # func    	      -12 xnsched_pick_next+0x11 (__xnpod_sch=
edule+0xf3)
[   94.393469]  |  # [   -1] -<?>-    0    -12 __xnpod_schedule+0x88 (xnpod=
_schedule+0x36)
[   94.393478]  |  # func    	      -13 __xnpod_schedule+0x14 (xnpod_schedu=
le+0x36)
[   94.393485]  |  # func    	      -13 ___xnpod_unlock_sched+0x4 (__xnpod_=
unlock_sched+0x21 [rtipv4])
[   94.393494]  |  # func    	      -13 ___xnpod_lock_sched+0x4 (__xnpod_lo=
ck_sched+0x21 [rtipv4])
[   94.393503]  |  + begin   0x80000000    -13 ipipe_test_and_stall_pipelin=
e_head+0x16 [rtipv4] (rt_ip_frag_invalidate_socket+0x1f [rtipv4])
[   94.393513]  |  + end     0x80000000    -13 hard_local_irq_enable+0x15 (=
__ipipe_restore_head+0x73)
[   94.393522]  |  # func    	      -13 __ipipe_restore_head+0x9 (ipipe_res=
tore_pipeline_head+0x5b [rtipv4])
[   94.393531]  |  # func    	      -14 xnsched_pick_next+0x11 (__xnpod_sch=
edule+0xf3)
[   94.393539]  |  # [   -1] -<?>-    0    -14 __xnpod_schedule+0x88 (xnpod=
_schedule+0x36)
[   94.393548]  |  # func    	      -14 __xnpod_schedule+0x14 (xnpod_schedu=
le+0x36)
[   94.393555]  |  # func    	      -14 ___xnpod_unlock_sched+0x4 (__xnpod_=
unlock_sched+0x21 [rtipv4])
[   94.393564]  |  # func    	      -14 ___xnpod_lock_sched+0x4 (__xnpod_lo=
ck_sched+0x21 [rtipv4])
[   94.393573]  |  + begin   0x80000000    -14 ipipe_test_and_stall_pipelin=
e_head+0x16 [rtipv4] (rt_ip_frag_invalidate_socket+0x1f [rtipv4])
[   94.393583]  |  + end     0x80000000    -14 hard_local_irq_enable+0x15 (=
__ipipe_restore_head+0x73)
[   94.393592]  |  # func    	      -14 __ipipe_restore_head+0x9 (ipipe_res=
tore_pipeline_head+0x5b [rtipv4])
[   94.393601]  |  # func    	      -15 xnsched_pick_next+0x11 (__xnpod_sch=
edule+0xf3)
[   94.393610]  |  # [   -1] -<?>-    0    -15 __xnpod_schedule+0x88 (xnpod=
_schedule+0x36)
[   94.393618]  |  # func    	      -15 __xnpod_schedule+0x14 (xnpod_schedu=
le+0x36)
[   94.393626]  |  # func    	      -15 ___xnpod_unlock_sched+0x4 (__xnpod_=
unlock_sched+0x21 [rtipv4])
[   94.393635]  |  # func    	      -15 ___xnpod_lock_sched+0x4 (__xnpod_lo=
ck_sched+0x21 [rtipv4])
[   94.393644]  |  + begin   0x80000000    -15 ipipe_test_and_stall_pipelin=
e_head+0x16 [rtipv4] (rt_ip_frag_invalidate_socket+0x1f [rtipv4])
[   94.393654]  |  + end     0x80000000    -16 hard_local_irq_enable+0x15 (=
__ipipe_restore_head+0x73)
[   94.393662]  |  # func    	      -16 __ipipe_restore_head+0x9 (ipipe_res=
tore_pipeline_head+0x5b [rtipv4])
[   94.393671]  |  # func    	      -16 xnsched_pick_next+0x11 (__xnpod_sch=
edule+0xf3)
[   94.393680]  |  # [   -1] -<?>-    0    -16 __xnpod_schedule+0x88 (xnpod=
_schedule+0x36)
[   94.393688]  |  # func    	      -16 __xnpod_schedule+0x14 (xnpod_schedu=
le+0x36)
[   94.393696]  |  # func    	      -17 ___xnpod_unlock_sched+0x4 (__xnpod_=
unlock_sched+0x21 [rtipv4])
[   94.393705]  |  # func    	      -17 ___xnpod_lock_sched+0x4 (__xnpod_lo=
ck_sched+0x21 [rtipv4])
[   94.393714]  |  + begin   0x80000000    -17 ipipe_test_and_stall_pipelin=
e_head+0x16 [rtipv4] (rt_ip_frag_invalidate_socket+0x1f [rtipv4])
[   94.393724]  |  + end     0x80000000    -17 hard_local_irq_enable+0x15 (=
__ipipe_restore_head+0x73)
[   94.393732]  |  # func    	      -17 __ipipe_restore_head+0x9 (ipipe_res=
tore_pipeline_head+0x5b [rtipv4])
[   94.393742]  |  # func    	      -18 xnsched_pick_next+0x11 (__xnpod_sch=
edule+0xf3)
[   94.393750]  |  # [   -1] -<?>-    0    -18 __xnpod_schedule+0x88 (xnpod=
_schedule+0x36)
[   94.393758]  |  # func    	      -18 __xnpod_schedule+0x14 (xnpod_schedu=
le+0x36)
[   94.393766]  |  # func    	      -18 ___xnpod_unlock_sched+0x4 (__xnpod_=
unlock_sched+0x21 [rtipv4])
[   94.393775]  |  # func    	      -18 ___xnpod_lock_sched+0x4 (__xnpod_lo=
ck_sched+0x21 [rtipv4])
[   94.393785] ------------[ cut here ]------------
[   94.393787] WARNING: at kernel/ipipe/core.c:1661 __ipipe_spin_unlock_deb=
ug+0x32/0x3b()
[   94.393788] Hardware name: To Be Filled By O.E.M.
[   94.393789] Modules linked in: rt_eepro100(O) rtudp(O) rttcp(O) rtipv4(O=
) rtnet(O) parport_pc ppdev bridge lp parport stp llc bnep rfcomm bluetooth=
 rfkill binfmt_misc fuse loop snd_hda_codec_hdmi snd_hda_codec_realtek snd_=
hda_intel snd_hda_codec radeon ttm drm_kms_helper drm kvm_amd snd_hwdep i2c=
_algo_bit kvm snd_pcm crc32c_intel sp5100_tco evdev edac_core snd_seq snd_t=
imer snd_seq_device tpm_tis i2c_piix4 hid_generic i2c_core snd k10temp edac=
_mce_amd tpm mxm_wmi soundcore snd_page_alloc tpm_bios fam15h_power microco=
de pcspkr psmouse xhci_hcd serio_raw wmi button ext4 mbcache jbd2 crc16 usb=
hid hid sd_mod crc_t10dif ata_generic ohci_hcd pata_atiixp ahci libahci lib=
ata firewire_ohci firewire_core crc_itu_t r8169 ehci_hcd mii usbcore scsi_m=
od usb_common [last unloaded: e100]
[   94.393853] Pid: 0, comm: swapper/5 Tainted: G           O 3.5.7-xenomai=
-2.6.2.1 #9
[   94.393854] Call Trace:
[   94.393855] ---[ end trace 27c7440cdfa30ab2 ]---
[   94.392934] map_single+0x25)
[  115.939265] ------------[ cut here ]------------
[  115.943874] WARNING: at include/linux/ipipe_debug.h:88 ipipe_restore_pip=
eline_head+0x2d/0x6a [rt_eepro100]()
[  115.953670] Hardware name: To Be Filled By O.E.M.
[  115.958356] Modules linked in: rt_eepro100(O) rtudp(O) rttcp(O) rtipv4(O=
) rtnet(O) parport_pc ppdev bridge lp parport stp llc bnep rfcomm bluetooth=
 rfkill binfmt_misc fuse loop snd_hda_codec_hdmi snd_hda_codec_realtek snd_=
hda_intel snd_hda_codec radeon ttm drm_kms_helper drm kvm_amd snd_hwdep i2c=
_algo_bit kvm snd_pcm crc32c_intel sp5100_tco evdev edac_core snd_seq snd_t=
imer snd_seq_device tpm_tis i2c_piix4 hid_generic i2c_core snd k10temp edac=
_mce_amd tpm mxm_wmi soundcore snd_page_alloc tpm_bios fam15h_power microco=
de pcspkr psmouse xhci_hcd serio_raw wmi button ext4 mbcache jbd2 crc16 usb=
hid hid sd_mod crc_t10dif ata_generic ohci_hcd pata_atiixp ahci libahci lib=
ata firewire_ohci firewire_core crc_itu_t r8169 ehci_hcd mii usbcore scsi_m=
od usb_common [last unloaded: e100]
[  116.027950] Pid: 0, comm: swapper/5 Tainted: G        W  O 3.5.7-xenomai=
-2.6.2.1 #9
[  116.035584] Call Trace:
[  116.038024] ---[ end trace 27c7440cdfa30ab3 ]---
[  225.005376] invalid use of FPU in Xenomai context at __switch_to+0x62/0x=
23e
[  225.012346] Xenomai: suspending kernel thread ffffffffa02faf80 ('rtnet-r=
tpc') at 0xffffffff81001786 after exception #0x7
[  225.023184] Xenomai: assertion failed at kernel/xenomai/nucleus/pod.c:23=
59 (xnthread_lock_count(curr) > 0)
[  225.032808] Xenomai: Unbalanced lock/unlock
[  225.036810] =

[  225.036810]  CPU  PID    PRI      TIMEOUT  STAT      NAME
[  225.043852] >  0  0       -1      0        00500080  ROOT/0
[  225.049413] >  1  0       -1      0        00500080  ROOT/1
[  225.054973] >  2  0       -1      0        00500080  ROOT/2
[  225.060532] >  3  0       -1      0        00500080  ROOT/3
[  225.066094] >  4  0       -1      0        00500080  ROOT/4
[  225.071655] >  5  0       -1      0        00500080  ROOT/5
[  225.077214]    5  0       98      0        00000082  rtnet-stack
[  225.083200]    5  0        0      0        00004081  rtnet-rtpc
[  225.089107]    5  0        1      1        00000084  rttcp timerwheel
[  225.095532] >  6  0       -1      0        00500080  ROOT/6
[  225.101092] >  7  0       -1      0        00500080  ROOT/7
[  225.106652] Master time base: clock=3D987321037744
[  225.111255] Current CPU: #5
[  225.114046]  ffff880427905ca8 0000000000000000 ffff88041e1e8220 ffff8804=
1e1e8418
[  225.121484]  ffff88041e1e8000 ffff8804257f9d00 ffff8800378a10c0 ffff8804=
27905cf0
[  225.128921]  ffffffff81004d80 ffff880427905d00 ffffffff810d1184 ffff8804=
27905d10
[  225.136366] Call Trace:
[  225.144975] Xenomai: stuck on nucleus lock ffffffff8162da50
[  225.144975] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #7)
[  225.144975] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  225.166619]  ffff8804177afa78 00000000000000c9 ffffffff8162da50 00000000=
00000007
[  225.174056]  0000000000000000 ffffffff814c4f91 0000000000000892 ffff8804=
177afac0
[  225.181495]  ffffffff81004d80 ffff8804177afb30 ffffffff810ceba2 ffffffff=
814c4f91
[  225.188942] Call Trace:
[  225.191395]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  225.196694]  [<ffffffff810ceba2>] ? __xnlock_spin+0xa2/0xc3
[  225.202256]  [<ffffffff810cec29>] ? __xnlock_get_irqsave+0x66/0xaa
[  225.208422]  [<ffffffff810d0ac6>] ? __xnpod_schedule+0x58/0x67e
[  225.214327]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  225.219195]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  225.224066]  [<ffffffff810a214f>] ? __ipipe_spin_unlock_irqrestore+0x34/=
0x39
[  225.231095]  [<ffffffff8101e25b>] ? release_ioapic_irq+0x3f/0x44
[  225.237090]  [<ffffffff810cd44d>] ? xnpod_schedule+0x36/0x38
[  225.242735]  [<ffffffff810cdd84>] ? xnintr_shirq_handler+0x20c/0x21b
[  225.249078]  [<ffffffff810a2a01>] ? __ipipe_dispatch_irq+0x178/0x222
[  225.255415]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  225.261580]  [<ffffffff813c33f9>] ? common_interrupt+0x79/0xaf
[  225.267403]  [<ffffffff8121aa6d>] ? __write_lock_failed+0xd/0x20
[  225.273394]  [<ffffffff813c2bf8>] ? _raw_write_lock_irq+0x43/0x47
[  225.279481]  [<ffffffff8102ee8c>] ? copy_process+0xd48/0x1331
[  225.285226]  [<ffffffff8102f67c>] ? do_fork+0xe8/0x274
[  225.290353]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  225.295223]  [<ffffffff810097d4>] ? sys_vfork+0x25/0x27
[  225.300437]  [<ffffffff813c9513>] ? stub_vfork+0x13/0x20
[  225.305737]  [<ffffffff813c9146>] ? system_call_fastpath+0x16/0x1b
[  225.852632] Xenomai: stuck on nucleus lock ffffffff8162da50
[  225.852632] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #4)
[  225.852632] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  225.853871] Xenomai: stuck on nucleus lock ffffffff8162da50
[  225.853871] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #2)
[  225.853871] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  225.853880]  0000000000000000 ffffffff814c4d8d 000000000000006d ffff8804=
175f76f0
[  225.853888]  ffffffff81004d80 ffff8804175f7760 ffffffff810ceba2[  225.85=
3893] Xenomai: stuck on nucleus lock ffffffff8162da50
[  225.853893] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #3)
[  225.853893] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  225.853894]  ffffffff814c4f91 ffff88042a517b28
[  225.853897]  00000000000000cdCall Trace:
[  225.853899]  ffffffff8162da50 0000000000000003
[  225.853902]  0000000000000000 [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  225.853908]  ffffffff814c4d8d 000000000000006d [<ffffffff810ceba2>] ? __=
xnlock_spin+0xa2/0xc3
[  225.853914]  ffff88042a517b70
[  225.853916]  ffffffff81004d80 ffff88042a517be0 [<ffffffff810cd526>] ? T.=
922+0x5a/0x93
[  225.853922]  ffffffff810ceba2 ffffffff814c4f91
[  225.853927]  [<ffffffff810cd628>] ? xnintr_clock_handler+0xc9/0x186
[  225.853928] Call Trace:
[  225.853929]  [<ffffffff810a2a01>] ? __ipipe_dispatch_irq+0x178/0x222
[  225.853932]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  225.853935]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  225.853941]  [<ffffffff810ceba2>] ? __xnlock_spin+0xa2/0xc3
[  225.853942]  [<ffffffff813c9cf9>] ? apic_timer_interrupt+0x79/0xc0
[  225.853946]  [<ffffffff810cd526>] ? T.922+0x5a/0x93
[  225.853949]  [<ffffffff813c3294>] ? _raw_spin_lock+0x30/0x39
[  225.853952]  [<ffffffff810cd628>] ? xnintr_clock_handler+0xc9/0x186
[  225.853958]  [<ffffffff813c327f>] ? _raw_spin_lock+0x1b/0x39
[  225.853958]  [<ffffffff810a2a01>] ? __ipipe_dispatch_irq+0x178/0x222
[  225.853964]  [<ffffffff8105f594>] ? double_rq_lock+0x5b/0x60
[  225.853965]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  225.853969]  [<ffffffff81060c26>] ? load_balance+0x23f/0x589
[  225.853970]  [<ffffffff813c9cf9>] ? apic_timer_interrupt+0x79/0xc0
[  225.853975]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  225.853976]  [<ffffffff813c3294>] ? _raw_spin_lock+0x30/0x39
[  225.853979]  [<ffffffff81061d2c>] ? idle_balance+0xab/0x122
[  225.853984]  [<ffffffff81059033>] ? double_rq_lock+0x53/0x60
[  225.853985]  [<ffffffff81114690>] ? sleep_on_page+0x12/0x12
[  225.853990]  [<ffffffff8105de28>] ? __migrate_task+0x6f/0xf0
[  225.853991]  [<ffffffff813c1d9c>] ? __schedule+0x281/0x4f3
[  225.853994]  [<ffffffff8105dea9>] ? __migrate_task+0xf0/0xf0
[  225.853997]  [<ffffffff81114690>] ? sleep_on_page+0x12/0x12
[  225.854002]  [<ffffffff8105dedc>] ? migration_cpu_stop+0x33/0x3c
[  225.854002]  [<ffffffff813c2156>] ? schedule+0x1c/0x1e
[  225.854008]  [<ffffffff8108da49>] ? cpu_stopper_thread+0x11d/0x1e0
[  225.854009]  [<ffffffff813c21e4>] ? io_schedule+0x8c/0xcf
[  225.854011]  [<ffffffff81058e1c>] ? need_resched+0x1e/0x28
[  225.854016]  [<ffffffff8111469e>] ? sleep_on_page_killable+0xe/0x35
[  225.854017]  [<ffffffff813c20b4>] ? thread_return+0xa6/0xbd
[  225.854022]  [<ffffffff813c0e2c>] ? __wait_on_bit+0x48/0x7b
[  225.854022]  [<ffffffff8108d92c>] ? copy_pid_ns+0x297/0x297
[  225.854026]  [<ffffffff81114816>] ? wait_on_page_bit_killable+0x74/0x7b
[  225.854030]  [<ffffffff8104dcef>] ? kthread+0x89/0x91
[  225.854031]  [<ffffffff8104e0e8>] ? autoremove_wake_function+0x39/0x39
[  225.854034]  [<ffffffff813cade4>] ? kernel_thread_helper+0x4/0x10
[  225.854037]  [<ffffffff81114922>] ? __lock_page_or_retry+0x45/0x92
[  225.854040]  [<ffffffff8104dc66>] ? kthreadd+0x144/0x144
[  225.854043]  [<ffffffff81116127>] ? filemap_fault+0x1b7/0x346
[  225.854047]  [<ffffffff813cade0>] ? gs_change+0xb/0xb
[  225.854051] Xenomai: stuck on nucleus lock ffffffff8162da50
[  225.854051] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #6)
[  225.854051] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  225.854053]  ffff88042a54bb28 00000000000000cd ffffffff8162da50 00000000=
00000006 [<ffffffff81133a3d>] ? __do_fault+0xa6/0x392
[  225.854063] =

[  225.854064]  0000000000000000 ffffffff814c4d8d 000000000000006d [<ffffff=
ff811348bf>] ? handle_pte_fault+0x2bd/0x817
[  225.854072]  ffff88042a54bb70
[  225.854075]  ffffffff81004d80 ffff88042a54bbe0 [<ffffffff81134f63>] ? ha=
ndle_mm_fault+0x14a/0x15e
[  225.854081]  ffffffff810ceba2 ffffffff814c4f91
[  225.854087]  [<ffffffff813c5ec0>] ? do_page_fault+0x33c/0x361
[  225.854088] Call Trace:
[  225.854090]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  225.854094]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  225.854098]  [<ffffffff810ceba2>] ? __xnlock_spin+0xa2/0xc3
[  225.854104]  [<ffffffff8101c1c2>] ? __ipipe_handle_exception+0x214/0x234
[  225.854105]  [<ffffffff810cd526>] ? T.922+0x5a/0x93
[  225.854112]  [<ffffffff81156d3f>] ? do_sys_open+0xf4/0x106
[  225.854113]  [<ffffffff810cd628>] ? xnintr_clock_handler+0xc9/0x186
[  225.854117]  [<ffffffff813c36e6>] ? page_fault+0x26/0x70
[  225.854121]  [<ffffffff810a2a01>] ? __ipipe_dispatch_irq+0x178/0x222
[  225.854126]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  225.854131]  [<ffffffff813c9cf9>] ? apic_timer_interrupt+0x79/0xc0
[  225.854137]  [<ffffffff813c3294>] ? _raw_spin_lock+0x30/0x39
[  225.854142]  [<ffffffff81059033>] ? double_rq_lock+0x53/0x60
[  225.854147]  [<ffffffff8105de28>] ? __migrate_task+0x6f/0xf0
[  225.854153]  [<ffffffff8105dea9>] ? __migrate_task+0xf0/0xf0
[  225.854157]  [<ffffffff8105dedc>] ? migration_cpu_stop+0x33/0x3c
[  225.854161]  [<ffffffff8108da49>] ? cpu_stopper_thread+0x11d/0x1e0
[  225.854167]  [<ffffffff81058e1c>] ? need_resched+0x1e/0x28
[  225.854171]  [<ffffffff813c20b4>] ? thread_return+0xa6/0xbd
[  225.854178]  [<ffffffff8108d92c>] ? copy_pid_ns+0x297/0x297
[  225.854182]  [<ffffffff8104dcef>] ? kthread+0x89/0x91
[  225.854188]  [<ffffffff813cade4>] ? kernel_thread_helper+0x4/0x10
[  225.854195]  [<ffffffff8104dc66>] ? kthreadd+0x144/0x144
[  225.854198]  [<ffffffff813cade0>] ? gs_change+0xb/0xb
[  225.854217] Xenomai: stuck on nucleus lock ffffffff8162da50
[  225.854217] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #0)
[  225.854217] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  225.854220]  ffff880417da7a08 00000000000000cd ffffffff8162da50 00000000=
00000000
[  225.854228]  0000000000000000 ffffffff814c4d8d 000000000000006d ffff8804=
17da7a50
[  225.854235]  ffffffff81004d80 ffff880417da7ac0 ffffffff810ceba2 ffffffff=
814c4f91[  225.854242] Xenomai: stuck on nucleus lock ffffffff8162da50
[  225.854242] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #1)
[  225.854242] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  225.854243] =

[  225.854244]  ffff88041e137ab8Call Trace:
[  225.854246]  00000000000000cd ffffffff8162da50 0000000000000001
[  225.854254]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  225.854255]  0000000000000000 ffffffff814c4d8d [<ffffffff810ceba2>] ? __=
xnlock_spin+0xa2/0xc3
[  225.854261]  000000000000006d ffff88041e137b00
[  225.854266]  [<ffffffff810cd526>] ? T.922+0x5a/0x93
[  225.854267]  ffffffff81004d80 ffff88041e137b70 ffffffff810ceba2 [<ffffff=
ff810cd628>] ? xnintr_clock_handler+0xc9/0x186
[  225.854274]  ffffffff814c4f91
[  225.854278]  [<ffffffff810a2a01>] ? __ipipe_dispatch_irq+0x178/0x222
[  225.854279] Call Trace:
[  225.854280]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  225.854284]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  225.854287]  [<ffffffff813c9cf9>] ? apic_timer_interrupt+0x79/0xc0
[  225.854293]  [<ffffffff810ceba2>] ? __xnlock_spin+0xa2/0xc3
[  225.854294]  [<ffffffff813c3294>] ? _raw_spin_lock+0x30/0x39
[  225.854297]  [<ffffffff810cd526>] ? T.922+0x5a/0x93
[  225.854302]  [<ffffffff813c327f>] ? _raw_spin_lock+0x1b/0x39
[  225.854303]  [<ffffffff810cd628>] ? xnintr_clock_handler+0xc9/0x186
[  225.854308]  [<ffffffff8105f594>] ? double_rq_lock+0x5b/0x60
[  225.854309]  [<ffffffff810a2a01>] ? __ipipe_dispatch_irq+0x178/0x222
[  225.854314]  [<ffffffff81060c26>] ? load_balance+0x23f/0x589
[  225.854315]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  225.854320]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  225.854321]  [<ffffffff813c9cf9>] ? apic_timer_interrupt+0x79/0xc0
[  225.854324]  [<ffffffff81061d2c>] ? idle_balance+0xab/0x122
[  225.854327]  [<ffffffff8105df73>] ? try_to_wake_up+0x8e/0x1e4
[  225.854330]  [<ffffffff813c1d9c>] ? __schedule+0x281/0x4f3
[  225.854336]  [<ffffffff8105df13>] ? try_to_wake_up+0x2e/0x1e4
[  225.854337]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  225.854341]  [<ffffffff813c2156>] ? schedule+0x1c/0x1e
[  225.854342]  [<ffffffff8105e0db>] ? default_wake_function+0x12/0x14
[  225.854347]  [<ffffffff81035750>] ? do_wait+0x1c4/0x238
[  225.854348]  [<ffffffff8103351d>] ? child_wait_callback+0x50/0x58
[  225.854351]  [<ffffffff81035862>] ? sys_wait4+0x9e/0xc1
[  225.854356]  [<ffffffff810589ad>] ? __wake_up_common+0x55/0x88
[  225.854357]  [<ffffffff8101bd39>] ? __ipipe_syscall_root+0x12/0xab
[  225.854360]  [<ffffffff81058d17>] ? __wake_up_sync_key+0x43/0x5f
[  225.854363]  [<ffffffff810334cd>] ? wait_noreap_copyout+0x11a/0x11a
[  225.854365]  [<ffffffff8103354b>] ? __wake_up_parent+0x26/0x28
[  225.854368]  [<ffffffff813c9146>] ? system_call_fastpath+0x16/0x1b
[  225.854374]  [<ffffffff81042de9>] ? do_notify_parent+0x1fa/0x222
[  225.854377]  [<ffffffff810a1e1c>] ? ipipe_root_only+0x51/0xa1
[  225.854381]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  225.854387]  [<ffffffff81035311>] ? do_exit+0x735/0x848
[  225.854393]  [<ffffffff8103549b>] ? do_group_exit+0x77/0x9f
[  225.854398]  [<ffffffff810354da>] ? sys_exit_group+0x17/0x1b
[  225.854402]  [<ffffffff813c9146>] ? system_call_fastpath+0x16/0x1b
[  225.853874]  ffff8804175f76a8 00000000000000cd ffffffff8162da50 00000000=
00000002
[  226.753622]  ffff88041772bc68[  226.763782]  00000000000000cd ffffffff81=
62da50 0000000000000004
[  226.769734]  0000000000000000 ffffffff814c4d8d 000000000000006d ffff8804=
1772bcb0
[  226.777187]  ffffffff81004d80 ffff88041772bd20 ffffffff810ceba2 ffffffff=
814c4f91
Call Trace:
[  226.785799]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  226.791100]  [<ffffffff810ceba2>] ? __xnlock_spin+0xa2/0xc3
[  226.796663]  [<ffffffff810cd526>] ? T.922+0x5a/0x93
[  226.801528]  [<ffffffff810cd628>] ? xnintr_clock_handler+0xc9/0x186
[  226.807781]  [<ffffffff810a2a01>] ? __ipipe_dispatch_irq+0x178/0x222
[  226.814121]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  226.820288]  [<ffffffff813c9cf9>] ? apic_timer_interrupt+0x79/0xc0
[  226.826454]  [<ffffffff8121aa6d>] ? __write_lock_failed+0xd/0x20
[  226.832445]  [<ffffffff813c2bf8>] ? _raw_write_lock_irq+0x43/0x47
[  226.838526]  [<ffffffff81034f1d>] ? do_exit+0x341/0x848
[  226.843739]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  226.848609]  [<ffffffff8103549b>] ? do_group_exit+0x77/0x9f
[  226.854169]  [<ffffffff810354da>] ? sys_exit_group+0x17/0x1b
[  226.859816]  [<ffffffff813c9146>] ? system_call_fastpath+0x16/0x1b
[  278.018447] Xenomai: stuck on nucleus lock ffffffff8162da50
[  278.018447] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #7)
[  278.018447] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  278.040099]  ffff8804177afa78 00000000000000c9 ffffffff8162da50 00000000=
00000007
[  278.047553]  0000000000000000 ffffffff814c4f91 0000000000000892 ffff8804=
177afac0
[  278.054998]  ffffffff81004d80 ffff8804177afb30 ffffffff810ceba2 ffffffff=
814c4f91
[  278.062444] Call Trace:
[  278.064889]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  278.070188]  [<ffffffff810ceba2>] ? __xnlock_spin+0xa2/0xc3
[  278.075750]  [<ffffffff810cec29>] ? __xnlock_get_irqsave+0x66/0xaa
[  278.081917]  [<ffffffff810d0ac6>] ? __xnpod_schedule+0x58/0x67e
[  278.087823]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  278.092691]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  278.097562]  [<ffffffff810a214f>] ? __ipipe_spin_unlock_irqrestore+0x34/=
0x39
[  278.104592]  [<ffffffff8101e25b>] ? release_ioapic_irq+0x3f/0x44
[  278.110585]  [<ffffffff810cd44d>] ? xnpod_schedule+0x36/0x38
[  278.116232]  [<ffffffff810cdd84>] ? xnintr_shirq_handler+0x20c/0x21b
[  278.122574]  [<ffffffff810a2a01>] ? __ipipe_dispatch_irq+0x178/0x222
[  278.128911]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  278.135076]  [<ffffffff813c33f9>] ? common_interrupt+0x79/0xaf
[  278.140898]  [<ffffffff8121aa6d>] ? __write_lock_failed+0xd/0x20
[  278.146890]  [<ffffffff813c2bf8>] ? _raw_write_lock_irq+0x43/0x47
[  278.152969]  [<ffffffff8102ee8c>] ? copy_process+0xd48/0x1331
[  278.158705]  [<ffffffff8102f67c>] ? do_fork+0xe8/0x274
[  278.163832]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  278.168702]  [<ffffffff810097d4>] ? sys_vfork+0x25/0x27
[  278.173915]  [<ffffffff813c9513>] ? stub_vfork+0x13/0x20
[  278.179217]  [<ffffffff813c9146>] ? system_call_fastpath+0x16/0x1b
[  278.644282] Xenomai: stuck on nucleus lock ffffffff8162da50
[  278.644282] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #6)
[  278.644282] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  278.666269]  ffff88042a54bb28 00000000000000cd ffffffff8162da50 00000000=
00000006
[  278.673707]  0000000000000000 ffffffff814c4d8d 000000000000006d ffff8804=
2a54bb70
[  278.681145]  ffffffff81004d80 ffff88042a54bbe0 ffffffff810ceba2 ffffffff=
814c4f91
[  278.688583] Call Trace:
[  278.691035]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  278.696352]  [<ffffffff810ceba2>] ? __xnlock_spin+0xa2/0xc3
[  278.701915]  [<ffffffff810cd526>] ? T.922+0x5a/0x93
[  278.706783]  [<ffffffff810cd628>] ? xnintr_clock_handler+0xc9/0x186
[  278.713036]  [<ffffffff810a2a01>] ? __ipipe_dispatch_irq+0x178/0x222
[  278.715818] Xenomai: stuck on nucleus lock ffffffff8162da50
[  278.715818] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #3)
[  278.715818] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  278.715825]  0000000000000000 ffffffff814c4d8d 000000000000006d ffff8804=
2a517b70
[  278.715833]  ffffffff81004d80 ffff88042a517be0 ffffffff810ceba2 ffffffff=
814c4f91
[  278.715840] Call Trace:
[  278.715843]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  278.715847]  [<ffffffff810ceba2>] ? __xnlock_spin+0xa2/0xc3
[  278.715853]  [<ffffffff810cd526>] ? T.922+0x5a/0x93
[  278.715859] Xenomai: stuck on nucleus lock ffffffff8162da50
[  278.715859] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #2)
[  278.715859] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  278.715859]  ffff8804175f76a8 [<ffffffff810cd628>] ? xnintr_clock_handle=
r+0xc9/0x186
[  278.715864]  00000000000000cd ffffffff8162da50 [<ffffffff810a2a01>] ? __=
ipipe_dispatch_irq+0x178/0x222
[  278.715869]  0000000000000002
[  278.715873]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  278.715874]  0000000000000000 ffffffff814c4d8d [<ffffffff813c9cf9>] ? ap=
ic_timer_interrupt+0x79/0xc0
[  278.715880]  000000000000006d ffff8804175f76f0
[  278.715882]  ffffffff81004d80 [<ffffffff813c3294>] ? _raw_spin_lock+0x30=
/0x39
[  278.715887]  ffff8804175f7760 ffffffff810ceba2 ffffffff814c4f91 [<ffffff=
ff81059033>] ? double_rq_lock+0x53/0x60
[  278.715893] =

[  278.715893] Call Trace:
[  278.715897]  [<ffffffff8105de28>] ? __migrate_task+0x6f/0xf0
[  278.715898]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  278.715900]  [<ffffffff8105dea9>] ? __migrate_task+0xf0/0xf0
[  278.715905]  [<ffffffff810ceba2>] ? __xnlock_spin+0xa2/0xc3
[  278.715906]  [<ffffffff8105dedc>] ? migration_cpu_stop+0x33/0x3c
[  278.715909]  [<ffffffff810cd526>] ? T.922+0x5a/0x93
[  278.715914]  [<ffffffff8108da49>] ? cpu_stopper_thread+0x11d/0x1e0
[  278.715915]  [<ffffffff810cd628>] ? xnintr_clock_handler+0xc9/0x186
[  278.715918]  [<ffffffff81058e1c>] ? need_resched+0x1e/0x28
[  278.715921]  [<ffffffff810a2a01>] ? __ipipe_dispatch_irq+0x178/0x222
[  278.715926]  [<ffffffff813c20b4>] ? thread_return+0xa6/0xbd
[  278.715927]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  278.715930]  [<ffffffff8108d92c>] ? copy_pid_ns+0x297/0x297
[  278.715933]  [<ffffffff813c9cf9>] ? apic_timer_interrupt+0x79/0xc0
[  278.715937]  [<ffffffff8104dcef>] ? kthread+0x89/0x91
[  278.715939]  [<ffffffff813c3294>] ? _raw_spin_lock+0x30/0x39
[  278.715942]  [<ffffffff813cade4>] ? kernel_thread_helper+0x4/0x10
[  278.715947]  [<ffffffff813c327f>] ? _raw_spin_lock+0x1b/0x39
[  278.715948]  [<ffffffff8104dc66>] ? kthreadd+0x144/0x144
[  278.715952]  [<ffffffff8105f594>] ? double_rq_lock+0x5b/0x60
[  278.715953]  [<ffffffff813cade0>] ? gs_change+0xb/0xb
[  278.715958]  [<ffffffff81060c26>] ? load_balance+0x23f/0x589
[  278.715959]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  278.715968]  [<ffffffff81061d2c>] ? idle_balance+0xab/0x122
[  278.715973]  [<ffffffff81114690>] ? sleep_on_page+0x12/0x12
[  278.715977]  [<ffffffff813c1d9c>] ? __schedule+0x281/0x4f3
[  278.715984]  [<ffffffff81114690>] ? sleep_on_page+0x12/0x12
[  278.715988]  [<ffffffff813c2156>] ? schedule+0x1c/0x1e
[  278.715992]  [<ffffffff813c21e4>] ? io_schedule+0x8c/0xcf
[  278.715996]  [<ffffffff8111469e>] ? sleep_on_page_killable+0xe/0x35
[  278.716000]  [<ffffffff813c0e2c>] ? __wait_on_bit+0x48/0x7b
[  278.716005]  [<ffffffff81114816>] ? wait_on_page_bit_killable+0x74/0x7b
[  278.716009]  [<ffffffff8104e0e8>] ? autoremove_wake_function+0x39/0x39
[  278.716014]  [<ffffffff81114922>] ? __lock_page_or_retry+0x45/0x92
[  278.716019]  [<ffffffff81116127>] ? filemap_fault+0x1b7/0x346
[  278.716026]  [<ffffffff81133a3d>] ? __do_fault+0xa6/0x392
[  278.716033]  [<ffffffff811348bf>] ? handle_pte_fault+0x2bd/0x817
[  278.716040]  [<ffffffff81134f63>] ? handle_mm_fault+0x14a/0x15e
[  278.716045]  [<ffffffff813c5ec0>] ? do_page_fault+0x33c/0x361
[  278.716050]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  278.716058]  [<ffffffff8101c1c2>] ? __ipipe_handle_exception+0x214/0x234
[  278.716063]  [<ffffffff81156d3f>] ? do_sys_open+0xf4/0x106
[  278.716068]  [<ffffffff813c36e6>] ? page_fault+0x26/0x70
[  278.746567] Xenomai: stuck on nucleus lock ffffffff8162da50
[  278.746567] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #0)
[  278.746567] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  278.746569]  ffff880417da7a08 00000000000000cd ffffffff8162da50 00000000=
00000000
[  278.746576]  0000000000000000 ffffffff814c4d8d 000000000000006d ffff8804=
17da7a50
[  278.746584]  ffffffff81004d80 ffff880417da7ac0 ffffffff810ceba2 ffffffff=
814c4f91
[  278.746591] Call Trace:
[  278.746594]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  278.746598]  [<ffffffff810ceba2>] ? __xnlock_spin+0xa2/0xc3
[  278.746604] Xenomai: stuck on nucleus lock ffffffff8162da50
[  278.746604] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #1)
[  278.746604] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  278.746605]  ffff88041e137ab8 [<ffffffff810cd526>] ? T.922+0x5a/0x93
[  278.746609]  00000000000000cd ffffffff8162da50 0000000000000001 [<ffffff=
ff810cd628>] ? xnintr_clock_handler+0xc9/0x186
[  278.746616] =

[  278.746617]  0000000000000000 ffffffff814c4d8d [<ffffffff810a2a01>] ? __=
ipipe_dispatch_irq+0x178/0x222
[  278.746622]  000000000000006d ffff88041e137b00 [<ffffffff8101bc5d>] ? __=
ipipe_handle_irq+0x108/0x162
[  278.746627] =

[  278.746628]  ffffffff81004d80 ffff88041e137b70 [<ffffffff813c9cf9>] ? ap=
ic_timer_interrupt+0x79/0xc0
[  278.746633]  ffffffff810ceba2 ffffffff814c4f91
[  278.746636] Call Trace:
[  278.746639]  [<ffffffff813c3294>] ? _raw_spin_lock+0x30/0x39
[  278.746640]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  278.746645]  [<ffffffff813c327f>] ? _raw_spin_lock+0x1b/0x39
[  278.746646]  [<ffffffff810ceba2>] ? __xnlock_spin+0xa2/0xc3
[  278.746650]  [<ffffffff8105f594>] ? double_rq_lock+0x5b/0x60
[  278.746651]  [<ffffffff810cd526>] ? T.922+0x5a/0x93
[  278.746656]  [<ffffffff81060c26>] ? load_balance+0x23f/0x589
[  278.746656]  [<ffffffff810cd628>] ? xnintr_clock_handler+0xc9/0x186
[  278.746661]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  278.746662]  [<ffffffff810a2a01>] ? __ipipe_dispatch_irq+0x178/0x222
[  278.746666]  [<ffffffff81061d2c>] ? idle_balance+0xab/0x122
[  278.746670]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  278.746671]  [<ffffffff813c1d9c>] ? __schedule+0x281/0x4f3
[  278.746674]  [<ffffffff813c9cf9>] ? apic_timer_interrupt+0x79/0xc0
[  278.746677]  [<ffffffff813c2156>] ? schedule+0x1c/0x1e
[  278.746680]  [<ffffffff8105df73>] ? try_to_wake_up+0x8e/0x1e4
[  278.746685]  [<ffffffff81035750>] ? do_wait+0x1c4/0x238
[  278.746685]  [<ffffffff8105df13>] ? try_to_wake_up+0x2e/0x1e4
[  278.746688]  [<ffffffff81035862>] ? sys_wait4+0x9e/0xc1
[  278.746693]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  278.746694]  [<ffffffff8101bd39>] ? __ipipe_syscall_root+0x12/0xab
[  278.746697]  [<ffffffff8105e0db>] ? default_wake_function+0x12/0x14
[  278.746700]  [<ffffffff810334cd>] ? wait_noreap_copyout+0x11a/0x11a
[  278.746704]  [<ffffffff8103351d>] ? child_wait_callback+0x50/0x58
[  278.746705]  [<ffffffff813c9146>] ? system_call_fastpath+0x16/0x1b
[  278.746710]  [<ffffffff810589ad>] ? __wake_up_common+0x55/0x88
[  278.746712]  [<ffffffff81058d17>] ? __wake_up_sync_key+0x43/0x5f
[  278.746717]  [<ffffffff8103354b>] ? __wake_up_parent+0x26/0x28
[  278.746721]  [<ffffffff81042de9>] ? do_notify_parent+0x1fa/0x222
[  278.746727]  [<ffffffff810a1e1c>] ? ipipe_root_only+0x51/0xa1
[  278.746731]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  278.746736]  [<ffffffff81035311>] ? do_exit+0x735/0x848
[  278.746743]  [<ffffffff8103549b>] ? do_group_exit+0x77/0x9f
[  278.746747]  [<ffffffff810354da>] ? sys_exit_group+0x17/0x1b
[  278.746751]  [<ffffffff813c9146>] ? system_call_fastpath+0x16/0x1b
[  278.999540] Xenomai: stuck on nucleus lock ffffffff8162da50
[  278.999540] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #4)
[  278.999540] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:1372 (xnpod_suspe=
nd_thread(), CPU #5)
[  278.999542]  ffff88041772bc68 00000000000000cd ffffffff8162da50 00000000=
00000004
[  278.999550]  0000000000000000 ffffffff814c4d8d 000000000000006d ffff8804=
1772bcb0
[  278.999557]  ffffffff81004d80 ffff88041772bd20 ffffffff810ceba2 ffffffff=
814c4f91
[  278.999565] Call Trace:
[  278.999568]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  278.999572]  [<ffffffff810ceba2>] ? __xnlock_spin+0xa2/0xc3
[  278.999578]  [<ffffffff810cd526>] ? T.922+0x5a/0x93
[  278.999584]  [<ffffffff810cd628>] ? xnintr_clock_handler+0xc9/0x186
[  278.999589]  [<ffffffff810a2a01>] ? __ipipe_dispatch_irq+0x178/0x222
[  278.999594]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  278.999599]  [<ffffffff813c9cf9>] ? apic_timer_interrupt+0x79/0xc0
[  278.999605]  [<ffffffff8121aa6d>] ? __write_lock_failed+0xd/0x20
[  278.999611]  [<ffffffff813c2bf8>] ? _raw_write_lock_irq+0x43/0x47
[  278.999615]  [<ffffffff81034f1d>] ? do_exit+0x341/0x848
[  278.999620]  [<ffffffff813c8efb>] ? trace+0x3a/0x6f
[  278.999626]  [<ffffffff8103549b>] ? do_group_exit+0x77/0x9f
[  278.999630]  [<ffffffff810354da>] ? sys_exit_group+0x17/0x1b
[  278.999635]  [<ffffffff813c9146>] ? system_call_fastpath+0x16/0x1b
[  278.715820]  ffff88042a517b28 00000000000000cd ffffffff8162da50 00000000=
00000003
[  279.562576]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  279.576140]  [<ffffffff813c9cf9>] ? apic_timer_interrupt+0x79/0xc0
[  279.582308]  [<ffffffff813c3294>] ? _raw_spin_lock+0x30/0x39
[  279.587955]  [<ffffffff81059033>] ? double_rq_lock+0x53/0x60
[  279.593600]  [<ffffffff8105de28>] ? __migrate_task+0x6f/0xf0
[  279.599248]  [<ffffffff8105dea9>] ? __migrate_task+0xf0/0xf0
[  279.604897]  [<ffffffff8105dedc>] ? migration_cpu_stop+0x33/0x3c
[  279.610890]  [<ffffffff8108da49>] ? cpu_stopper_thread+0x11d/0x1e0
[  279.617055]  [<ffffffff81058e1c>] ? need_resched+0x1e/0x28
[  279.622530]  [<ffffffff813c20b4>] ? thread_return+0xa6/0xbd
[  279.628091]  [<ffffffff8108d92c>] ? copy_pid_ns+0x297/0x297
[  279.633669]  [<ffffffff8104dcef>] ? kthread+0x89/0x91
[  279.638712]  [<ffffffff813cade4>] ? kernel_thread_helper+0x4/0x10
[  279.644791]  [<ffffffff8104dc66>] ? kthreadd+0x144/0x144
[  279.650090]  [<ffffffff813cade0>] ? gs_change+0xb/0xb
