Message-ID: <5182B42F.9090907@bollue.de>
Date: Thu, 02 May 2013 20:45:03 +0200
From: Kai Bollue <mlist1@bollue.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] native/heap: "removing non-linked element"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello,

we experience a crash upon unbinding of a previously deleted (and =

cleaned up) shared heap.
Scheme:
- Process A calls rt_heap_create() (with H_SHARED flag), waits for some =

time and then terminates.
- Process B calls rt_heap_bind() on that heap, uses it and calls =

rt_heap_unbind() (or terminates) after process A has terminated.

Then the system crashes after the output of "Xenomai: removing =

non-linked element, holder=3Dffffc900125e4940, qslot=3Dffff880427aa90f8 at =

kernel/xenomai/skins/native/heap.c:374".

The crash does not always happen, but can quite reliably be reproduced =

by starting process A in a loop from bash (while [ TRUE ]; do ...) and =

keeping process B running.

Two aspects seem to be crucial:
- Calling rt_heap_delete() in process A is not sufficient to reproduce =

the problem, the process has to terminate (the cleaning up seems to be =

relevant).
- We could only reproduce the crash as long as process B accessed the =

heap after process A had terminated (e.g. using memcpy).

As a workaround, it could be tried to avoid access to a deleted heap, =

but it is not always possible to detect the termination of process A on =

time in such a constellation.

The system:
- AMD AM3 FX-8350
- Debian 6.0
- Kernel 3.5.7
- Xenomai 2.6.2.1

We also tested this on an older system (Xenomai 2.6.0, Kernel 2.6.37): =

Here, both processes hung indefinitely and could not be killed, but the =

system did not crash.

Any hints are appreciated.

Attachments:
- Console output
- Code of process A
- Code of process B


Best regards,
Kai
-------------- next part --------------
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.5.7-xenomai-2.6.2.1 (root@IRT176) (gcc versi=
on 4.4.5 (Debian 4.4.5-8) ) #11 SMP PREEMPT Mon Apr 29 15:50:28 CEST 2013
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-3.5.7-xenomai-2.6.2=
.1 root=3DUUID=3Dac291233-b3d4-4b70-b409-b36931bc7d7c ro isolcpus=3D0,1 con=
sole=3DttyS0,115200
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000be1e3fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000be1e4000-0x00000000be4e7fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000be4e8000-0x00000000be8dafff] ACPI =
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
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn =3D 0x43f000 max_arch_pfn =3D 0x400000000
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] e820: last_pfn =3D 0xbf800 max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fda50-0x000fda5f] mapped at =
[ffff8800000fda50]
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0xbf7fffff]
[    0.000000] init_memory_mapping: [mem 0x100000000-0x43effffff]
[    0.000000] RAMDISK: [mem 0x37847000-0x37feffff]
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
[    0.000000]   node   0: [mem 0x00100000-0xbe1e3fff]
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
[    0.000000] PM: Registered nosave memory: 00000000be1e4000 - 00000000be4=
e8000
[    0.000000] PM: Registered nosave memory: 00000000be4e8000 - 00000000be8=
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
l pages: 4113878
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.5.7-xenoma=
i-2.6.2.1 root=3DUUID=3Dac291233-b3d4-4b70-b409-b36931bc7d7c ro isolcpus=3D=
0,1 console=3DttyS0,115200
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Xenomai: forcing noxsave
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Node 0: aperture @ b4000000 size 32 MB
[    0.000000] Aperture pointing to e820 RAM. Ignoring.
[    0.000000] Your BIOS doesn't leave a aperture memory hole
[    0.000000] Please enable the IOMMU option in the BIOS setup
[    0.000000] This costs you 64 MB of RAM
[    0.000000] Mapping aperture over 65536 KB of RAM @ b4000000
[    0.000000] PM: Registered nosave memory: 00000000b4000000 - 00000000b80=
00000
[    0.000000] Memory: 16284520k/17809408k available (3938k kernel code, 10=
75600k absent, 449288k reserved, 2706k data, 3884k init)
[    0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D8, Nodes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:33024 nr_irqs:1288 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Interrupt pipeline (release #3)
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] Fast TSC calibration failed
[    0.004000] TSC: Unable to calibrate against PIT
[    0.005000] TSC: using HPET reference calibration
[    0.006000] Detected 3991.266 MHz processor.
[    0.000004] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 7982.53 BogoMIPS (lpj=3D3991266)
[    0.010603] pid_max: default: 32768 minimum: 301
[    0.015233] Security Framework initialized
[    0.019321] SELinux:  Disabled at boot.
[    0.024606] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes)
[    0.035904] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes)
[    0.044677] Mount-cache hash table entries: 256
[    0.049387] Initializing cgroup subsys cpuacct
[    0.053818] Initializing cgroup subsys devices
[    0.058255] Initializing cgroup subsys freezer
[    0.062691] Initializing cgroup subsys net_cls
[    0.067154] CPU: Physical Processor ID: 0
[    0.071174] CPU: Processor Core ID: 0
[    0.074824] mce: CPU supports 7 MCE banks
[    0.078833] LVT offset 1 assigned for vector 0xf9
[    0.083650] ACPI: Core revision 20120320
[    0.115145] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.131117] CPU0: AMD FX(tm)-8350 Eight-Core Processor            steppi=
ng 00
[    0.239782] Performance Events: AMD Family 15h PMU driver.
[    0.245281] ... version:                0
[    0.249283] ... bit width:              48
[    0.253365] ... generic registers:      6
[    0.257361] ... value mask:             0000ffffffffffff
[    0.262664] ... max period:             00007fffffffffff
[    0.267965] ... fixed-purpose events:   0
[    0.271969] ... event mask:             000000000000003f
[    0.286691] Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 Ok.
[    0.406335] Brought up 8 CPUs
[    0.409304] Total of 8 processors activated (63860.25 BogoMIPS).
[    0.425072] devtmpfs: initialized
[    0.431633] PM: Registering ACPI NVS region [mem 0xbe4e8000-0xbe8dafff] =
(4141056 bytes)
[    0.440115] PM: Registering ACPI NVS region [mem 0xbee2f000-0xbf034fff] =
(2121728 bytes)
[    0.448638] dummy: =

[    0.450923] NET: Registered protocol family 16
[    0.456035] ACPI: bus type pci registered
[    0.460201] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.469496] PCI: not using MMCONFIG
[    0.472988] PCI: Using configuration type 1 for base access
[    0.478558] PCI: Using configuration type 1 for extended access
[    0.488074] bio: create slab <bio-0> at 0
[    0.492330] ACPI: Added _OSI(Module Device)
[    0.496536] ACPI: Added _OSI(Processor Device)
[    0.500988] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.505700] ACPI: Added _OSI(Processor Aggregator Device)
[    0.562800] ACPI: Executed 3 blocks of module-level executable AML code
[    0.615465] ACPI: Interpreter enabled
[    0.619146] ACPI: (supports S0 S3 S4 S5)
[    0.623271] ACPI: Using IOAPIC for interrupt routing
[    0.628921] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.638442] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACP=
I motherboard resources
[    0.787290] ACPI: No dock devices found.
[    0.791219] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.801378] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.809085] pci_root PNP0A03:00: host bridge window [io  0x0000-0x03af]
[    0.815701] pci_root PNP0A03:00: host bridge window [io  0x03e0-0x0cf7]
[    0.822308] pci_root PNP0A03:00: host bridge window [io  0x03b0-0x03df]
[    0.828913] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
[    0.835520] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x00=
0bffff]
[    0.842829] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x00=
0dffff]
[    0.850129] pci_root PNP0A03:00: host bridge window [mem 0xc0000000-0xff=
ffffff]
[    0.857543] PCI host bridge to bus 0000:00
[    0.861650] pci_bus 0000:00: root bus resource [io  0x0000-0x03af]
[    0.867831] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
[    0.874006] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df]
[    0.880180] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.886356] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f]
[    0.893223] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dfff=
f]
[    0.900089] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfffffff=
f]
[    0.917689] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    0.925670] pci 0000:00:03.0: PCI bridge to [bus 02-02]
[    0.931552] pci 0000:00:09.0: PCI bridge to [bus 03-03]
[    0.937447] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
[    0.943270] pci 0000:00:14.4: PCI bridge to [bus 05-05] (subtractive dec=
ode)
[    0.950582] pci 0000:00:15.0: PCI bridge to [bus 06-06]
[    0.956559] pci 0000:07:00.0: disabling ASPM on pre-1.1 PCIe device.  Yo=
u can enable it with 'pcie_aspm=3Dforce'
[    0.966567] pci 0000:00:15.1: PCI bridge to [bus 07-07]
[    0.974559] pci 0000:00:15.2: PCI bridge to [bus 08-08]
[    0.982540] pci 0000:00:15.3: PCI bridge to [bus 09-09]
[    0.991796]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.997474]  pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND), return=
ed control mask: 0x1d
[    1.005984] ACPI _OSC control for PCIe not granted, disabling ASPM
[    1.087409] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11 14 15) *0
[    1.094023] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11 14 15) *0
[    1.100646] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11 14 15) *0
[    1.107298] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11 14 15) *0
[    1.113859] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11 14 15) *0
[    1.120375] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11 14 15) *0
[    1.126876] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11 14 15) *0
[    1.133388] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11 14 15) *0
[    1.140039] vgaarb: device added: PCI:0000:01:00.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    1.148155] vgaarb: loaded
[    1.150883] vgaarb: bridge control possible 0000:01:00.0
[    1.156311] PCI: Using ACPI for IRQ routing
[    1.178909] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.183914] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    1.192104] Switching to clocksource hpet
[    1.210263] pnp: PnP ACPI init
[    1.213368] ACPI: bus type pnp registered
[    1.219148] system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
[    1.231904] system 00:02: [mem 0xfec20000-0xfec200ff] could not be reser=
ved
[    1.241844] system 00:04: [io  0x040b] has been reserved
[    1.247170] system 00:04: [io  0x04d6] has been reserved
[    1.252496] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    1.258427] system 00:04: [io  0x0c14] has been reserved
[    1.263754] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    1.269679] system 00:04: [io  0x0c52] has been reserved
[    1.275007] system 00:04: [io  0x0c6c] has been reserved
[    1.280333] system 00:04: [io  0x0c6f] has been reserved
[    1.285653] system 00:04: [io  0x0cd0-0x0cd1] has been reserved
[    1.291585] system 00:04: [io  0x0cd2-0x0cd3] has been reserved
[    1.297519] system 00:04: [io  0x0cd4-0x0cd5] has been reserved
[    1.303451] system 00:04: [io  0x0cd6-0x0cd7] has been reserved
[    1.309383] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    1.315315] system 00:04: [io  0x0800-0x089f] has been reserved
[    1.321240] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    1.327174] system 00:04: [io  0x0900-0x090f] has been reserved
[    1.333106] system 00:04: [io  0x0910-0x091f] has been reserved
[    1.339046] system 00:04: [io  0xfe00-0xfefe] has been reserved
[    1.344984] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[    1.351950] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    1.358573] system 00:04: [mem 0xfed80000-0xfed8ffff] has been reserved
[    1.365198] system 00:04: [mem 0xfed61000-0xfed70fff] has been reserved
[    1.371824] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    1.378450] system 00:04: [mem 0xfed00000-0xfed00fff] has been reserved
[    1.385073] system 00:04: [mem 0xffc00000-0xffffffff] has been reserved
[    1.392434] system 00:05: [io  0x0290-0x029f] has been reserved
[    1.401208] system 00:09: [io  0x04d0-0x04d1] has been reserved
[    1.410861] pnp: PnP ACPI: found 14 devices
[    1.415063] ACPI: ACPI bus type pnp unregistered
[    1.433518] pci 0000:07:00.0: no compatible bridge window for [mem 0xfff=
e0000-0xffffffff pref]
[    1.442308] pci 0000:00:15.1: BAR 15: assigned [mem 0xd0100000-0xd01ffff=
f pref]
[    1.449624] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    1.454864] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    1.460976] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    1.467769] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xcfffffff=
 64bit pref]
[    1.475528] pci 0000:00:03.0: PCI bridge to [bus 02-02]
[    1.480764] pci 0000:00:03.0:   bridge window [io  0xd000-0xdfff]
[    1.486876] pci 0000:00:03.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    1.493684] pci 0000:00:09.0: PCI bridge to [bus 03-03]
[    1.498932] pci 0000:00:09.0:   bridge window [mem 0xfe800000-0xfe8fffff]
[    1.505737] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
[    1.510979] pci 0000:00:0a.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    1.517784] pci 0000:00:14.4: PCI bridge to [bus 05-05]
[    1.523022] pci 0000:00:14.4:   bridge window [io  0xc000-0xcfff]
[    1.529161] pci 0000:00:14.4:   bridge window [mem 0xfe600000-0xfe6fffff]
[    1.535974] pci 0000:00:15.0: PCI bridge to [bus 06-06]
[    1.541242] pci 0000:07:00.0: BAR 6: assigned [mem 0xd0100000-0xd011ffff=
 pref]
[    1.548470] pci 0000:00:15.1: PCI bridge to [bus 07-07]
[    1.553712] pci 0000:00:15.1:   bridge window [io  0xb000-0xbfff]
[    1.559824] pci 0000:00:15.1:   bridge window [mem 0xfe500000-0xfe5fffff]
[    1.566621] pci 0000:00:15.1:   bridge window [mem 0xd0100000-0xd01fffff=
 pref]
[    1.573856] pci 0000:00:15.2: PCI bridge to [bus 08-08]
[    1.579094] pci 0000:00:15.2:   bridge window [io  0xa000-0xafff]
[    1.585206] pci 0000:00:15.2:   bridge window [mem 0xfe400000-0xfe4fffff]
[    1.592016] pci 0000:00:15.3: PCI bridge to [bus 09-09]
[    1.597265] pci 0000:00:15.3:   bridge window [io  0x9000-0x9fff]
[    1.603388] pci 0000:00:15.3:   bridge window [mem 0xd0000000-0xd00fffff=
 64bit pref]
[    1.611729] NET: Registered protocol family 2
[    1.618175] IP route cache hash table entries: 524288 (order: 10, 419430=
4 bytes)
[    1.630581] TCP established hash table entries: 524288 (order: 11, 83886=
08 bytes)
[    1.640162] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.647066] TCP: Hash tables configured (established 524288 bind 65536)
[    1.653685] TCP: reno registered
[    1.657060] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    1.663357] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    1.670132] NET: Registered protocol family 1
[    1.929476] Unpacking initramfs...
[    2.143681] Freeing initrd memory: 7844k freed
[    2.155681] PCI-DMA: Disabling AGP.
[    2.159425] PCI-DMA: aperture base @ b4000000 size 65536 KB
[    2.165006] PCI-DMA: using GART IOMMU.
[    2.168773] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    2.201385] LVT offset 0 assigned for vector 0x400
[    2.206264] perf: AMD IBS detected (0x000000ff)
[    2.211279] audit: initializing netlink socket (disabled)
[    2.216711] type=3D2000 audit(1367522231.978:1): initialized
[    2.236056] I-pipe: head domain Xenomai registered.
[    2.241409] Xenomai: hal/x86_64 started.
[    2.245542] Xenomai: scheduling class idle registered.
[    2.250706] Xenomai: scheduling class rt registered.
[    2.263165] Xenomai: real-time nucleus v2.6.2.1 (Day At The Beach) loade=
d.
[    2.270061] Xenomai: debug mode enabled.
[    2.281580] Xenomai: starting native API services.
[    2.286396] Xenomai: starting POSIX services.
[    2.291056] Xenomai: starting RTDM services.
[    2.297026] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.311506] VFS: Disk quotas dquot_6.5.2
[    2.315621] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.322473] msgmni has been set to 31949
[    2.327405] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[    2.334821] io scheduler noop registered
[    2.338796] io scheduler deadline registered
[    2.343220] io scheduler cfq registered (default)
[    2.350508] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.377498] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    2.405486] 00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    2.411946] Linux agpgart interface v0.103
[    2.416738] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    2.426699] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.431816] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.437630] mousedev: PS/2 mouse device common for all mice
[    2.443395] rtc_cmos 00:07: RTC can wake from S4
[    2.448387] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
[    2.454577] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.461796] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Te=
am
[    2.469243] rtcan: registered rtcan0
[    2.472850] rtcan0: VIRT driver loaded
[    2.476674] rtcan: registered rtcan1
[    2.480365] rtcan1: VIRT driver loaded
[    2.484581] TCP: cubic registered
[    2.488368] NET: Registered protocol family 10
[    2.493872] mip6: Mobile IPv6
[    2.496879] NET: Registered protocol family 17
[    2.501374] Key type dns_resolver registered
[    2.506393] registered taskstats version 1
[    2.512967] rtc_cmos 00:07: setting system clock to 2013-05-02 19:17:13 =
UTC (1367522233)
[    2.568230] Freeing unused kernel memory: 3884k freed
[    2.575986] Write protecting the kernel read-only data: 6144k
[    2.588456] Freeing unused kernel memory: 148k freed
[    2.621918] Freeing unused kernel memory: 768k freed
Loading, please wait...
[    2.684762] udev[73]: starting version 164
[    2.806143] e1000e: Intel(R) PRO/1000 Network Driver - 2.0.0-k
[    2.812268] e1000e: Copyright(c) 1999 - 2012 Intel Corporation.
[    2.817072] ACPI: bus type usb registered
[    2.817237] usbcore: registered new interface driver usbfs
[    2.817309] usbcore: registered new interface driver hub
[    2.817627] usbcore: registered new device driver usb
[    2.819599] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.824743] SCSI subsystem initialized
[    2.840135] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    2.857030] r8169 0000:07:00.0: eth0: RTL8168b/8111b at 0xffffc90012a3a0=
00, f8:d1:11:02:8b:e5, XID 18000000 IRQ 72
[    2.861110] e1000e 0000:02:00.0: Disabling ASPM L0s L1
[    2.863569] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 200=
4)
[    2.863700] 8139cp 0000:05:06.0: This (id 10ec:8139 rev 10) is not an 81=
39C+ compatible chip, use 8139too
[    2.865304] 8139too: 8139too Fast Ethernet driver 0.9.28
[    2.865833] ehci_hcd 0000:00:12.2: EHCI Host Controller
[    2.865867] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus =
number 1
[    2.865898] ehci_hcd 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    2.866305] ehci_hcd 0000:00:12.2: debug port 1
[    2.866489] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfeb09000
[    2.871784] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    2.872038] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    2.872050] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.872061] usb usb1: Product: EHCI Host Controller
[    2.872072] usb usb1: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ehci_hcd
[    2.872083] usb usb1: SerialNumber: 0000:00:12.2
[    2.873111] hub 1-0:1.0: USB hub found
[    2.873157] hub 1-0:1.0: 5 ports detected
[    2.973913] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0x=
f impl SATA mode
[    2.974729] 8139too 0000:05:06.0: eth1: RealTek RTL8139 at 0xffffc900018=
74000, 00:50:bf:6b:3c:65, IRQ 21
[    2.979290] r8169 0000:07:00.0: eth0: jumbo features [frames: 4080 bytes=
, tx checksumming: ko]
[    2.979411] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    2.980831] e1000e 0000:02:00.0: (unregistered net_device): Interrupt Th=
rottling Rate (ints/sec) set to dynamic conservative mode
[    3.019120] firewire_ohci 0000:08:00.0: added OHCI v1.10 device as card =
0, 4 IR + 8 IT contexts, quirks 0x11
[    3.019372] r8169 0000:09:00.0: eth2: RTL8168evl/8111evl at 0xffffc90001=
878000, bc:5f:f4:8b:f4:94, XID 0c900800 IRQ 76
[    3.019378] r8169 0000:09:00.0: eth2: jumbo features [frames: 9200 bytes=
, tx checksumming: ko]
[    3.020182] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp=
 pio slum part =

[    3.023173] scsi0 : ahci
[    3.024540] scsi1 : ahci
[    3.025004] scsi2 : ahci
[    3.025513] scsi3 : ahci
[    3.025922] ata1: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b10=
0 irq 19
[    3.025932] ata2: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b18=
0 irq 19
[    3.025941] ata3: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b20=
0 irq 19
[    3.025950] ata4: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b28=
0 irq 19
[    3.098766] ehci_hcd 0000:00:13.2: EHCI Host Controller
[    3.104853] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus =
number 2
[    3.112525] ehci_hcd 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    3.121573] ehci_hcd 0000:00:13.2: debug port 1
[    3.126441] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfeb07000
[    3.170936] e1000e 0000:02:00.0: eth3: (PCI Express:2.5GT/s:Width x1) 68=
:05:ca:02:bb:f3
[    3.179290] e1000e 0000:02:00.0: eth3: Intel(R) PRO/1000 Network Connect=
ion
[    3.180220] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    3.180483] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.180496] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.180508] usb usb2: Product: EHCI Host Controller
[    3.180519] usb usb2: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ehci_hcd
[    3.180531] usb usb2: SerialNumber: 0000:00:13.2
[    3.181693] hub 2-0:1.0: USB hub found
[    3.181743] hub 2-0:1.0: 5 ports detected
[    3.184597] scsi4 : pata_atiixp
[    3.184911] scsi5 : pata_atiixp
[    3.191294] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq=
 14
[    3.191300] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf008 irq=
 15
[    3.199105] Refined TSC clocksource calibration: 3991.362 MHz.
[    3.199117] Switching to clocksource tsc
[    3.264039] e1000e 0000:02:00.0: eth3: MAC: 3, PHY: 8, PBA No: E46981-007
[    3.264068] ehci_hcd 0000:00:16.2: EHCI Host Controller
[    3.264106] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus =
number 3
[    3.264135] ehci_hcd 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    3.264289] ehci_hcd 0000:00:16.2: debug port 1
[    3.264366] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfeb04000
[    3.269962] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    3.270230] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.270242] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.270253] usb usb3: Product: EHCI Host Controller
[    3.270266] usb usb3: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ehci_hcd
[    3.270278] usb usb3: SerialNumber: 0000:00:16.2
[    3.271429] hub 3-0:1.0: USB hub found
[    3.271476] hub 3-0:1.0: 4 ports detected
[    3.274950] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.353775] ohci_hcd 0000:00:12.0: OHCI Host Controller
[    3.359176] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus =
number 4
[    3.366729] ata1: SATA link down (SStatus 0 SControl 300)
[    3.366800] ata4: SATA link down (SStatus 0 SControl 300)
[    3.366927] ata3: SATA link down (SStatus 0 SControl 300)
[    3.384005] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfeb0a000
[    3.444677] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.451780] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.459297] usb usb4: Product: OHCI Host Controller
[    3.464387] usb usb4: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ohci_hcd
[    3.471397] usb usb4: SerialNumber: 0000:00:12.0
[    3.473216] firewire_core 0000:08:00.0: created device fw0: GUID 008f130=
0d3d31300, S400
[    3.485133] hub 4-0:1.0: USB hub found
[    3.489030] hub 4-0:1.0: 5 ports detected
[    3.493744] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    3.499107] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus =
number 5
[    3.506844] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfeb08000
[    3.537359] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.544969] ata2.00: ATA-8: Hitachi HDS721010CLA330, JP4OA3MA, max UDMA/=
133
[    3.552216] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/3=
2), AA
[    3.561093] ata2.00: configured for UDMA/133
[    3.567405] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.574515] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.576615] scsi 1:0:0:0: Direct-Access     ATA      Hitachi HDS72101 JP=
4O PQ: 0 ANSI: 5
[    3.590443] usb usb5: Product: OHCI Host Controller
[    3.595658] usb usb5: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ohci_hcd
[    3.602040] sd 1:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    3.602511] sd 1:0:0:0: [sda] Write Protect is off
[    3.602688] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    3.624410]  sda: sda1 sda2 sda3
[    3.626243] sd 1:0:0:0: [sda] Attached SCSI disk
[    3.633012] usb usb5: SerialNumber: 0000:00:13.0
[    3.638405] hub 5-0:1.0: USB hub found
[    3.642386] hub 5-0:1.0: 5 ports detected
[    3.647292] ohci_hcd 0000:00:14.5: OHCI Host Controller
[    3.652786] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus =
number 6
[    3.660500] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfeb06000
[    3.721138] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.728317] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.735822] usb usb6: Product: OHCI Host Controller
[    3.740964] usb usb6: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ohci_hcd
[    3.748105] usb usb6: SerialNumber: 0000:00:14.5
[    3.753524] hub 6-0:1.0: USB hub found
[    3.757444] hub 6-0:1.0: 2 ports detected
[    3.762232] ohci_hcd 0000:00:16.0: OHCI Host Controller
[    3.767886] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus =
number 7
[    3.775837] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfeb05000
[    3.817755] usb 4-3: new low-speed USB device number 2 using ohci_hcd
[    3.836814] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.843961] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.851680] usb usb7: Product: OHCI Host Controller
[    3.856840] usb usb7: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ohci_hcd
[    3.864023] usb usb7: SerialNumber: 0000:00:16.0
[    3.869378] hub 7-0:1.0: USB hub found
[    3.873319] hub 7-0:1.0: 4 ports detected
[    3.970514] usb 4-3: New USB device found, idVendor=3D046d, idProduct=3D=
c018
[    3.977381] usb 4-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.984692] usb 4-3: Product: USB Optical Mouse
[    3.989374] usb 4-3: Manufacturer: Logitech
[    4.117107] usb 4-4: new low-speed USB device number 3 using ohci_hcd
[    4.276869] usb 4-4: New USB device found, idVendor=3D046a, idProduct=3D=
0001
[    4.283861] usb 4-4: New USB device strings: Mfr=3D1, Product=3D0, Seria=
lNumber=3D0
[    4.291306] usb 4-4: Manufacturer: Cherry GmbH
[    4.320978] usbcore: registered new interface driver usbhid
[    4.326767] usbhid: USB HID core driver
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... =
done.
Begin: Running /scripts/local-premount ... [    4.794359] PM: Starting manu=
al resume from disk
done.
[    4.830216] EXT4-fs (sda1): INFO: recovery required on readonly filesyst=
em
[    4.837515] EXT4-fs (sda1): write access will be enabled during recovery
[    5.197081] EXT4-fs (sda1): orphan cleanup on readonly fs
[    5.204221] EXT4-fs (sda1): 20 orphan inodes deleted
[    5.209352] EXT4-fs (sda1): recovery complete
[    5.273719] EXT4-fs (sda1): mounted filesystem with ordered data mode. O=
pts: (null)
Begin: Running /scripts/local-bottom ... done.
done.
Begin: Running /scripts/init-bottom ... done.
INIT: version 2.88 booting
Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevd[    6.664048] udev[333]: star=
ting version 164
.
Synthesizing the initial hotplug events...done.
[    6.961721] wmi: Mapper loaded
Waiting for /dev to be fully populated...[    6.980313] input: Power Button=
 as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[    6.988953] ACPI: Power Button [PWRB]
[    6.993321] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input1
[    7.001361] ACPI: Power Button [PWRF]
[    7.070562] microcode: CPU0: patch_level=3D0x06000817
[    7.114742] MCE: In-kernel MCE decoding enabled.
[    7.141209] input: PC Speaker as /devices/platform/pcspkr/input/input2
[    7.168783] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    7.174467] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus =
number 8
[    7.187007] xhci_hcd 0000:03:00.0: irq 48, io mem 0xfe800000
[    7.194181] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    7.201600] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    7.209113] usb usb8: Product: xHCI Host Controller
[    7.214358] usb usb8: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 xhci_hcd
[    7.221526] usb usb8: SerialNumber: 0000:03:00.0
[    7.227009] hub 8-0:1.0: USB hub found
[    7.231013] hub 8-0:1.0: 2 ports detected
[    7.235711] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    7.241086] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus =
number 9
[    7.248860] usb usb9: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[    7.255997] usb usb9: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    7.263545] usb usb9: Product: xHCI Host Controller
[    7.268682] usb usb9: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 xhci_hcd
[    7.275724] usb usb9: SerialNumber: 0000:03:00.0
[    7.281120] hub 9-0:1.0: USB hub found
[    7.285072] hub 9-0:1.0: 2 ports detected
[    7.295395] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    7.300777] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus =
number 10
[    7.313261] xhci_hcd 0000:04:00.0: irq 47, io mem 0xfe700000
[    7.320443] usb usb10: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    7.327527] usb usb10: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    7.335195] usb usb10: Product: xHCI Host Controller
[    7.340732] usb usb10: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 xhci_hcd
[    7.347814] usb usb10: SerialNumber: 0000:04:00.0
[    7.356104] hub 10-0:1.0: USB hub found
[    7.360195] hub 10-0:1.0: 2 ports detected
[    7.364281] EDAC MC: Ver: 2.1.0
[    7.368183] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    7.373687] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus =
number 11
[    7.381740] usb usb11: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[    7.382638] AMD64 EDAC driver v3.4.0
[    7.382879] EDAC amd64: DRAM ECC disabled.
[    7.396988] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
[    7.396988]  Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
[    7.396988]  (Note that use of the override may cause unknown side effec=
ts.)
[    7.397003] usb usb11: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    7.397009] usb usb11: Product: xHCI Host Controller
[    7.397014] usb usb11: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 xhci_hcd
[    7.397019] usb usb11: SerialNumber: 0000:04:00.0
[    7.446770] hub 11-0:1.0: USB hub found
[    7.450971] hub 11-0:1.0: 2 ports detected
[    7.478913] kvm: Nested Virtualization enabled
[    7.483598] kvm: Nested Paging enabled
[    7.488944] input: Logitech USB Optical Mouse as /devices/pci0000:00/000=
0:00:12.0/usb4/4-3/4-3:1.0/input/input3
[    7.500051] hid-generic 0003:046D:C018.0001: input,hidraw0: USB HID v1.1=
1 Mouse [Logitech USB Optical Mouse] on usb-0000:00:12.0-3/input0
[    7.513441] input: Cherry GmbH as /devices/pci0000:00/0000:00:12.0/usb4/=
4-4/4-4:1.0/input/input4
[    7.523537] hid-generic 0003:046A:0001.0002: input,hidraw1: USB HID v1.1=
1 Keyboard [Cherry GmbH] on usb-0000:00:12.0-4/input0
[    7.564871] [drm] Initialized drm 1.1.0 20060810
[    7.687738] ACPI Warning: 0x0000000000000b00-0x0000000000000b07 SystemIO=
 conflicts with Region \SOR1 1 (20120320/utaddress-251)
[    7.699928] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[    7.894828] sp5100_tco: SP5100 TCO WatchDog Timer Driver v0.01
[    7.901159] sp5100_tco: mmio address 0xbafe00 already in use
[    8.014698] [drm] radeon kernel modesetting enabled.
[    8.021144] [drm] initializing kernel modesetting (CEDAR 0x1002:0x68E1 0=
x174B:0x3000).
[    8.029808] [drm] register mmio base: 0xFEA20000
[    8.034678] [drm] register mmio size: 131072
[    8.039583] ATOM BIOS: AMD
[    8.042568] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x0000=
00003FFFFFFF (1024M used)
[    8.051827] radeon 0000:01:00.0: GTT: 512M 0x0000000040000000 - 0x000000=
005FFFFFFF
[    8.051891] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    8.051941] microcode: CPU1: patch_level=3D0x06000817
[    8.058743] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    8.058781] microcode: CPU2: patch_level=3D0x06000817
[    8.065574] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    8.065616] microcode: CPU3: patch_level=3D0x06000817
[    8.072178] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    8.072224] microcode: CPU4: patch_level=3D0x06000817
[    8.079585] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    8.079615] microcode: CPU5: patch_level=3D0x06000817
[    8.087656] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    8.087701] microcode: CPU6: patch_level=3D0x06000817
[    8.098924] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    8.140555] microcode: CPU7: patch_level=3D0x06000817
[    8.156146] [drm] Detected VRAM RAM=3D1024M, BAR=3D256M
[    8.161168] [drm] RAM width 64bits DDR
[    8.162647] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    8.162856] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.f=
snet.co.uk>, Peter Oruba
[    8.181605] [TTM] Zone  kernel: Available graphics memory: 8181558 kiB
[    8.188435] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    8.195536] [TTM] Initializing pool allocator
[    8.200264] [TTM] Initializing DMA pool allocator
[    8.205335] [drm] radeon: 1024M of VRAM memory ready
[    8.210569] [drm] radeon: 512M of GTT memory ready.
[    8.215854] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    8.222715] [drm] Driver supports precise vblank timestamp query.
[    8.229486] radeon 0000:01:00.0: radeon: using MSI.
[    8.234875] [drm] radeon: irq initialized.
[    8.239169] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    8.247304] [drm] Loading CEDAR Microcode
[    8.449488] r600_cp: Failed to load firmware "radeon/CEDAR_pfp.bin"
[    8.456047] [drm:evergreen_startup] *ERROR* Failed to load firmware!
[    8.462756] radeon 0000:01:00.0: disabling GPU acceleration
[    8.469535] radeon 0000:01:00.0: ffff8804287da000 unpin not necessary
[    8.476509] radeon 0000:01:00.0: ffff8804287dd800 unpin not necessary
[    8.483385] radeon 0000:01:00.0: ffff8804287dd800 unpin not necessary
[    8.491582] [drm] Radeon Display Connectors
[    8.495947] [drm] Connector 0:
[    8.499212] [drm]   HDMI-A-1
[    8.502247] [drm]   HPD4
[    8.504965] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644=
c 0x644c
[    8.512807] [drm]   Encoders:
[    8.516005] [drm]     DFP1: INTERNAL_UNIPHY1
[    8.520579] [drm] Connector 1:
[    8.523883] [drm]   DVI-I-1
[    8.526982] [drm]   HPD1
[    8.529719] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646=
c 0x646c
[    8.537546] [drm]   Encoders:
[    8.540809] [drm]     DFP2: INTERNAL_UNIPHY
[    8.545253] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    8.550162] [drm] Connector 2:
[    8.553400] [drm]   VGA-1
[    8.556233] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643=
c 0x643c
[    8.564075] [drm]   Encoders:
[    8.567272] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
[    8.572536] [drm] Internal thermal controller without fan control
[    8.579091] [drm] radeon: power management initialized
[    8.653542] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/s=
ound/card0/input5
[    8.662356] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14=
.2/sound/card0/input6
[    8.671726] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:=
00:14.2/sound/card0/input7
[    8.681294] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:=
00:14.2/sound/card0/input8
[    8.687211] [drm] fb mappable at 0xC0040000
[    8.687217] [drm] vram apper at 0xC0000000
[    8.687222] [drm] size 5242880
[    8.687227] [drm] fb depth is 24
[    8.687231] [drm]    pitch is 5120
[    8.687447] fbcon: radeondrmfb (fb0) is primary device
[    8.964806] Console: switching to colour frame buffer device 160x64
[    8.714618] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0=
000:00:14.2/sound/card0/input9
[    8.714978] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000=
:00:14.2/sound/card0/input10
[    8.993996] fb0: radeondrmfb frame buffer device
[    8.998801] drm: registered panic notifier
[    9.003007] [drm] Initialized radeon 2.18.0 20080528 for 0000:01:00.0 on=
 minor 0
[    9.011036] hda-intel: 0000:01:00.1: Handle VGA-switcheroo audio client
[    9.041234] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:02.0/0000:01:00.1/sound/card1/input11
done.
Setting parameters of disc: (none).
Setting preliminary keymap...done.
Activating swap...[    9.692200] Adding 19530748k swap on /dev/sda2.  Prior=
ity:-1 extents:1 across:19530748k =

done.
[    9.715209] EXT4-fs (sda1): re-mounted. Opts: (null)
Checking root file system...fsck from util-linux-ng 2.17.2
/dev/sda1: clean, 600382/7331840 files, 5756987/29296640 blocks
done.
[    9.914710] EXT4-fs (sda1): re-mounted. Opts: errors=3Dremount-ro
Cleaning up ifupdown....
[   10.021525] loop: module loaded
Loading kernel modules...done.
Setting up networking....
Activating lvm and md swap...done.
Checking file systems...fsck from util-linux-ng 2.17.2
/dev/sda3: recovering journal
/dev/sda3: Clearing orphaned inode 38011061 (uid=3D1000, gid=3D1000, mode=
=3D0100600, size=3D632)
/dev/sda3: clean, 24069/52510720 files, 5361699/210010880 blocks
done.
Mounting local filesystems...[   17.757287] EXT4-fs (sda3): mounted filesys=
tem with ordered data mode. Opts: (null)
done.
Activating swapfile swap...done.
Cleaning up temporary files....
Setting kernel variables ...done.
Configuring network interfaces...Internet Systems Consortium DHCP Client 4.=
1.1-P1
Copyright 2004-2010 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

[   18.381495] r8169 0000:09:00.0: eth0: unable to load firmware patch rtl_=
nic/rtl8168e-3.fw (-2)
[   18.397215] r8169 0000:09:00.0: eth0: link down
[   18.397263] r8169 0000:09:00.0: eth0: link down
[   18.407840] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
Listening on LPF/eth0/bc:5f:f4:8b:f4:94
Sending on   LPF/eth0/bc:5f:f4:8b:f4:94
Sending on   Socket/fallback
[   19.986412] r8169 0000:09:00.0: eth0: link up
[   19.992130] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPACK from [...]
bound to [...] -- renewal in 35971 seconds.
[   21.612947] r8169 0000:07:00.0: eth1: link down
[   21.617856] r8169 0000:07:00.0: eth1: link down
[   21.623919] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   21.808993] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[   21.919159] 8139too 0000:05:06.0: eth3: link down
[   21.925332] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
done.
Starting portmap daemon....
Starting NFS common utilities: statd.
Cleaning up temporary files....
Setting up ALSA...done.
[   22.379519] fuse init (API version 7.19)
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
Starting system message bus: dbus[   23.601945] e1000e: eth2 NIC Link is Up=
 100 Mbps Full Duplex, Flow Control: Rx/Tx
[   23.609869] e1000e 0000:02:00.0: eth2: 10/100 speed: disabling TSO
[   23.617647] IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
.
[   23.894697] r8169 0000:07:00.0: eth1: link up
[   23.900444] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
Starting virtual private network daemon:.
Not starting GNOME Display Manager; it is not the default display manager.
Starting Hardware abstraction layer: haldLoading cpufreq kernel modules...d=
one (none).
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.
Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon.
Starting anac(h)ronistic cron: anacron.
[   25.783469] Bluetooth: Core ver 2.16
[   25.787451] NET: Registered protocol family 31
[   25.792052] Bluetooth: HCI device and connection manager initialized
[   25.798753] Bluetooth: HCI socket layer initialized
[   25.803999] Bluetooth: L2CAP socket layer initialized
[   25.809429] Bluetooth: SCO socket layer initialized
[   25.977302] sshd (1720): /proc/1720/oom_adj is deprecated, please use /p=
roc/1720/oom_score_adj instead.
Starting OpenBSD Secure Shell server: sshd.
Starting kerneloops:
[   26.049754] Bluetooth: RFCOMM TTY layer initialized
[   26.054974] Bluetooth: RFCOMM socket layer initialized
[   26.060387] Bluetooth: RFCOMM ver 1.11
.
Starting bluetooth: bluetoothd.
[   26.203619] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   26.209156] Bluetooth: BNEP filters: protocol multicast
[   26.287640] Bridge firewalling registered
Starting K Display Manager: kdm.
Starting MTA: exim4.
CPUFreq Utilities: Setting ondemand CPUFreq governor...disabled, governor n=
ot available...done.
[   27.186463] lp: driver loaded but no devices found
[   27.379346] ppdev: user-space parallel port driver
Starting Common Unix Printing System: cupsd.
saned disabled; edit /etc/default/saned
Starting ISC DHCP server: dhcpd.
[   41.498586] [drm:drm_edid_block_valid] *ERROR* EDID checksum is invalid,=
 remainder is 89
[   41.506699] Raw EDID:
[   41.509017]  	00 ff ff ff ff ff ff 00 05 23 50 74 df 1c 00 00
[   41.514802]  	26 0f 01 03 6d 22 1b 78 ea 2c 12 a2 5a 4a 99 25
[   41.520580]  	1b 4e 56 bf ef 00 71 40 71 4a 71 4f 81 40 81 4a
[   41.526355]  	81 4f 81 80 01 01 30 2a 00 98 51 00 2a 40 30 70
[   41.532128]  	13 00 52 0e 11 00 00 1e 00 00 00 fd 00 3f ff ff
[   41.537912]  	ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   41.543694]  	ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   41.549472]  	ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   92.754121] =

[   92.754121] *** RTnet 0.9.13 - built on Apr 29 2013 16:02:03 ***
[   92.754121] =

[   92.763198] RTnet: initialising real-time networking
[   92.846114] rt_e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k-rt
[   92.852506] rt_e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
[   92.858835] rt_e1000e 0000:02:00.0: Disabling ASPM L0s =

[   92.968823] RTnet: registered rteth0
[   92.972435] rt_e1000e: (PCI Express:2.5GT/s:Width x1) 68:05:ca:02:bb:f3
[   92.979211] rt_e1000e: Intel(R) PRO/1000 Network Connection
[   92.984832] rt_e1000e: MAC: 3, PHY: 8, PBA No: E46981-007
[   93.001047] rt_8139too Fast Ethernet driver 0.9.24-rt0.7
[   93.007163] RTnet: registered rteth1
[   95.657041] e1000e: rteth0 NIC Link is Up 100 Mbps Full Duplex, Flow Con=
trol: Rx/Tx
[   95.664732] rt_e1000e: 10/100 speed: disabling TSO
[  139.387397] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  139.400421] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  139.810779] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  139.823930] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  140.234364] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  140.247439] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  140.657365] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  140.670294] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  141.080817] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  141.093991] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  141.504538] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  141.517469] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  141.927329] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  141.940314] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  142.350210] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  142.363141] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  142.772777] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  142.785741] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  143.199284] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  143.212187] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  143.621848] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  143.634819] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  144.044665] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  144.057608] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  144.467899] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  144.480895] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  144.890848] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  144.903890] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  145.314088] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  145.327031] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  145.737003] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  145.749988] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  146.160527] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  146.173483] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  146.623418] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  146.632374] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  147.172285] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  147.181227] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  147.721618] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  147.730556] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  148.269788] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  148.278745] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  148.823173] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  148.832105] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  149.372405] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  149.381361] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  149.921594] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  149.930541] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  150.487414] xnheap: destroying shared heap 'rt_heap: CrashHeap' with 100=
02432 bytes still in use.
[  150.496394] Xenomai: native: cleaning up heap "CrashHeap" (ret=3D0).
[  150.637622] Xenomai: removing non-linked element, holder=3Dffffc900125e4=
940, qslot=3Dffff880427aa90f8 at kernel/xenomai/skins/native/heap.c:374
[  150.649925] =

[  150.649925]  CPU  PID    PRI      TIMEOUT  STAT      NAME
[  150.656965] >  0  0       -1      0        00500080  ROOT/0
[  150.662518] >  1  0       -1      0        00500080  ROOT/1
[  150.668077] >  2  0       -1      0        00500080  ROOT/2
[  150.673630]    2  0        1      1        00000084  rttcp timerwheel
[  150.680046]    2  2799    99      0        00300380  FrontendTask
[  150.686117] >  3  0       -1      0        00500080  ROOT/3
[  150.691669] >  4  0       -1      0        00500080  ROOT/4
[  150.697222] >  5  0       -1      0        00500080  ROOT/5
[  150.702774] >  6  0       -1      0        00500080  ROOT/6
[  150.708326] >  7  0       -1      0        00500080  ROOT/7
[  150.713877]    7  0       98      0        00000082  rtnet-stack
[  150.719863]    7  0        0      0        00000082  rtnet-rtpc
[  150.725759] Master time base: clock=3D688652423381
[  150.730361] Current CPU: #2
[  150.733146]  ffff8803f1237df0 0000000000000000 ffffc900125e3600 00000000=
00000000
[  150.740583]  ffffc900125e4940 00007f816d915000 00007f816cf88000 ffff8803=
f1237e38
[  150.748022]  ffffffff81004d80 ffff8803f1237e68 ffffffff810f8a24[  150.75=
2998] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  150.752998] 	  waiter =3D kernel/xenomai/skins/rtdm/drvlib.c:857 (rtdm_e=
vent_signal(), CPU #7)
[  150.752998] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  150.753001]  ffff88042a4dfc08 00000000000000d3 ffffffff8162dc10 00000000=
00000007
[  150.753009]  0000000000000000 ffffffff814c932c 0000000000000359 ffff8804=
2a4dfc50
[  150.753016]  ffffffff81004d80 ffff88042a4dfcc0 ffffffff810cf862 ffffffff=
814c893f
[  150.753023] Call Trace:
[  150.753027]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  150.753034]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  150.753041]  [<ffffffff81112f93>] ? T.935+0x6d/0xbf
[  150.753048]  [<ffffffff81113197>] ? rtdm_event_signal+0x26/0x78
[  150.753053]  [<ffffffffa04baaa3>] ? e1000_intr_msix_rx+0x83/0x91 [rt_e10=
00e]
[  150.753061]  [<ffffffff810ce442>] ? xnintr_irq_handler+0x9d/0x1df
[  150.753066]  [<ffffffff8109b4f7>] ? __ipipe_end_fasteoi_irq+0x20/0x20
[  150.753072]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  150.753078]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  150.753083]  [<ffffffff813ce379>] ? common_interrupt+0x79/0xaf
[  150.753088]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  150.753094]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  150.753099]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  150.753103]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  150.753107]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  150.753112]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  150.794431] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  150.794431] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #6)
[  150.794431] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  150.794433]  ffff88042a4dbca8 00000000000000d1 ffffffff8162dc10 00000000=
00000006
[  150.794440]  0000000000000000 ffffffff814c6f44 000000000000006d ffff8804=
2a4dbcf0
[  150.794448]  ffffffff81004d80 ffff88042a4dbd60 ffffffff810cf862 ffffffff=
814c893f
[  150.794455] Call Trace:
[  150.794458]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  150.794462]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  150.794469]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  150.794473]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  150.794478]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  150.794483]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  150.794488]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  150.794495]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  150.794500]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  150.794504]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  150.794509]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  150.794513]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  150.825465] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  150.825465] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #4)
[  150.825465] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  150.825467]  ffff88042a4cfca8 00000000000000d1 ffffffff8162dc10 00000000=
00000004
[  150.825471]  0000000000000000 ffffffff814c6f44 000000000000006d ffff8804=
2a4cfcf0
[  150.825474]  ffffffff81004d80 ffff88042a4cfd60 ffffffff810cf862 ffffffff=
814c893f
[  150.825478] Call Trace:
[  150.825480]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  150.825485]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  150.825488]  [<ffffffff810a671a>] ? ipipe_trace_function+0x1c/0x1e
[  150.825491]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  150.825494]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  150.825496]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  150.825499]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  150.825503]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  150.825506]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  150.825509]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  150.825512]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  150.825514]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  150.825517]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  150.825520]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  151.077696] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  151.077696] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #0)
[  151.077696] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  151.077699]  ffffffff81603cb8 00000000000000d1 ffffffff8162dc10 00000000=
00000000
[  151.077707]  0000000000000000 ffffffff814c6f44 000000000000006d ffffffff=
81603d00
[  151.077714]  ffffffff81004d80 ffffffff81603d70 ffffffff810cf862 ffffffff=
814c893f
[  151.077722] Call Trace:
[  151.077726]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  151.077732]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  151.077739]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  151.077745] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  151.077745] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #1)
[  151.077745] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  151.077746]  ffff88042a4c3ca8 [<ffffffff810ce2e8>] ? xnintr_clock_handle=
r+0xc9/0x186
[  151.077750]  00000000000000d1 ffffffff8162dc10 [<ffffffff810a36c1>] ? __=
ipipe_dispatch_irq+0x178/0x222
[  151.077756]  0000000000000001
[  151.077761]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  151.077762]  0000000000000000 ffffffff814c6f44 000000000000006d [<ffffff=
ff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  151.077769]  ffff88042a4c3cf0
[  151.077773]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  151.077773]  ffffffff81004d80 ffff88042a4c3d60 ffffffff810cf862 [<ffffff=
ff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  151.077779]  ffffffff814c893f
[  151.077783]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  151.077784] Call Trace:
[  151.077785]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  151.077788]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  151.077793]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  151.077794]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  151.077797]  [<ffffffff813b72cf>] ? rest_init+0x83/0x87
[  151.077800]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  151.077805]  [<ffffffff81998d32>] ? start_kernel+0x3f7/0x404
[  151.077806]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  151.077810]  [<ffffffff81998770>] ? kernel_init+0x1d3/0x1d3
[  151.077811]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  151.077814]  [<ffffffff819982b4>] ? x86_64_start_reservations+0xb8/0xbd
[  151.077817]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  151.077822]  [<ffffffff819983ea>] ? x86_64_start_kernel+0x131/0x138
[  151.077823]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  151.077828]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  151.077834]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  151.077838]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  151.077843]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  151.077847]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  151.077852]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  151.078643] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  151.078643] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #5)
[  151.078643] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  151.078644]  ffff88042a4d3ca8 00000000000000d1 ffffffff8162dc10 00000000=
00000005
[  151.078652]  0000000000000000 ffffffff814c6f44 000000000000006d ffff8804=
2a4d3cf0
[  151.078659]  ffffffff81004d80 ffff88042a4d3d60 ffffffff810cf862 ffffffff=
814c893f
[  151.078667] Call Trace:
[  151.078670]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  151.078674]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  151.078680]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  151.078685]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  151.078689]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  151.078694]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  151.078699]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  151.078704]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  151.078710]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  151.078714]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  151.078718]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  151.078722]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  151.078727]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  151.151548] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  151.151548] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #3)
[  151.151548] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  151.151551]  ffff88042a4cbca8 00000000000000d1 ffffffff8162dc10 00000000=
00000003
[  151.151562]  0000000000000000 ffffffff814c6f44 000000000000006d ffff8804=
2a4cbcf0
[  151.151574]  ffffffff81004d80 ffff88042a4cbd60 ffffffff810cf862 ffffffff=
814c893f
[  151.151584] Call Trace:
[  151.151590]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  151.151600]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  151.151611]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  151.151621]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  151.151629]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  151.151637]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  151.151645]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  151.151652]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  151.151662]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  151.151670]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  151.151676]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  151.151683]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  151.151692]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6

[  151.651680]  ffffc900125e3688
[  151.654880] Call Trace:
[  151.657333]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  151.662634]  [<ffffffff810f8a24>] ? __heap_post_release+0x150/0x217
[  151.668903]  [<ffffffff810cce39>] ? xnheap_vmclose+0x1bd/0x1c2
[  151.674723]  [<ffffffff81137e3d>] ? remove_vma+0x33/0x7f
[  151.680025]  [<ffffffff8113920d>] ? do_munmap+0x2f1/0x32b
[  151.685414]  [<ffffffff8113928c>] ? vm_munmap+0x45/0x60
[  151.690636]  [<ffffffff811392cd>] ? sys_munmap+0x26/0x2f
[  151.695938]  [<ffffffff813d40c6>] ? system_call_fastpath+0x16/0x1b
[  151.702100] I-pipe tracer log (100 points):
[  151.706274]  |  *+func    	        0 ipipe_trace_panic_freeze+0x9 (xnarc=
h_begin_panic+0x9)
[  151.714740]  |   +begin   0x80000000      0 __xnlock_get_irqsave+0x2f (_=
_heap_post_release+0x3b)
[  151.723745]      +func    	        0 __heap_post_release+0xd (xnheap_vmc=
lose+0x1bd)
[  151.731613]      +func    	        0 __slab_free+0x11 (kfree+0xdc)
[  151.738017]      +func    	       -1 __phys_addr+0x4 (virt_to_head_page+=
0x9)
[  151.745253]      +func    	       -1 kfree+0xd (__vunmap+0xb2)
[  151.751324]      +func    	       -1 __slab_free+0x11 (kfree+0xdc)
[  151.757706]      +func    	       -1 __phys_addr+0x4 (virt_to_head_page+=
0x9)
[  151.764988]      +func    	       -1 kfree+0xd (__vunmap+0xb2)
[  151.771016]      +func    	       -1 __slab_free+0x11 (kfree+0xdc)
[  151.777407]      +func    	       -1 __phys_addr+0x4 (virt_to_head_page+=
0x9)
[  151.784644]      +func    	       -1 kfree+0xd (__vunmap+0xaa)
[  151.790699]  |   +end     0x80000000     -2 hard_local_irq_enable+0x15 (=
ipipe_unstall_root+0x2d)
[  151.799685]  |   #func    	       -2 ipipe_root_only+0x9 (ipipe_unstall_=
root+0x13)
[  151.807476]  |   #begin   0x80000000     -2 hard_local_irq_disable+0x16 =
(ipipe_unstall_root+0xe)
[  151.816434]      #func    	       -2 ipipe_unstall_root+0x4 (ipipe_resto=
re_root+0x39)
[  151.824488]  |   #end     0x80000001     -2 hard_local_irq_restore+0x1b =
(ipipe_root_only+0x51)
[  151.833274]  |   #begin   0x80000001     -2 hard_local_irq_save+0x1b (ip=
ipe_root_only+0x13)
[  151.841827]      #func    	       -2 ipipe_root_only+0x9 (ipipe_restore_=
root+0x16)
[  151.849602]      #func    	       -2 ipipe_restore_root+0x9 (arch_local_=
irq_restore+0x14)
[  151.857981]  |   #end     0x80000001     -2 debug_smp_processor_id+0x97 =
(free_hot_cold_page+0x10b)
[  151.867123]  |   #begin   0x80000001     -2 debug_smp_processor_id+0x43 =
(free_hot_cold_page+0x10b)
[  151.876256]      +func    	       -3 get_pageblock_flags_group+0x4 (free=
_hot_cold_page+0x55)
[  151.884911]      +func    	       -3 free_pages_prepare+0xb (free_hot_co=
ld_page+0x3e)
[  151.892955]      +func    	       -3 free_hot_cold_page+0x11 (__free_pag=
es+0x1d)
[  151.900582]      +func    	       -3 __free_pages+0x4 (__vunmap+0x8e)
[  151.907207]  |   +end     0x80000000     -3 hard_local_irq_enable+0x15 (=
ipipe_unstall_root+0x2d)
[  151.916167]  |   #func    	       -3 ipipe_root_only+0x9 (ipipe_unstall_=
root+0x13)
[  151.923942]  |   #begin   0x80000000     -3 hard_local_irq_disable+0x16 =
(ipipe_unstall_root+0xe)
[  151.932942]      #func    	       -3 ipipe_unstall_root+0x4 (ipipe_resto=
re_root+0x39)
[  151.940962]  |   #end     0x80000001     -3 hard_local_irq_restore+0x1b =
(ipipe_root_only+0x51)
[  151.949800]  |   #begin   0x80000001     -3 hard_local_irq_save+0x1b (ip=
ipe_root_only+0x13)
[  151.958343]      #func    	       -4 ipipe_root_only+0x9 (ipipe_restore_=
root+0x16)
[  151.966091]      #func    	       -4 ipipe_restore_root+0x9 (arch_local_=
irq_restore+0x14)
[  151.974482]  |   #end     0x80000001     -4 debug_smp_processor_id+0x97 =
(free_hot_cold_page+0x10b)
[  151.983639]  |   #begin   0x80000001     -4 debug_smp_processor_id+0x43 =
(free_hot_cold_page+0x10b)
[  151.992789]      +func    	       -4 get_pageblock_flags_group+0x4 (free=
_hot_cold_page+0x55)
[  152.001419]      +func    	       -4 free_pages_prepare+0xb (free_hot_co=
ld_page+0x3e)
[  152.009455]      +func    	       -4 free_hot_cold_page+0x11 (__free_pag=
es+0x1d)
[  152.017056]      +func    	       -4 __free_pages+0x4 (__vunmap+0x8e)
[  152.023688]  |   +end     0x80000000     -4 hard_local_irq_enable+0x15 (=
ipipe_unstall_root+0x2d)
[  152.032683]  |   #func    	       -5 ipipe_root_only+0x9 (ipipe_unstall_=
root+0x13)
[  152.040484]  |   #begin   0x80000000     -5 hard_local_irq_disable+0x16 =
(ipipe_unstall_root+0xe)
[  152.049468]      #func    	       -5 ipipe_unstall_root+0x4 (ipipe_resto=
re_root+0x39)
[  152.057487]  |   #end     0x80000001     -5 hard_local_irq_restore+0x1b =
(ipipe_root_only+0x51)
[  152.066308]  |   #begin   0x80000001     -5 hard_local_irq_save+0x1b (ip=
ipe_root_only+0x13)
[  152.074869]      #func    	       -5 ipipe_root_only+0x9 (ipipe_restore_=
root+0x16)
[  152.082635]      #func    	       -5 ipipe_restore_root+0x9 (arch_local_=
irq_restore+0x14)
[  152.090990]  |   #end     0x80000001     -5 debug_smp_processor_id+0x97 =
(free_hot_cold_page+0x10b)
[  152.100155]  |   #begin   0x80000001     -5 debug_smp_processor_id+0x43 =
(free_hot_cold_page+0x10b)
[  152.109306]      +func    	       -5 get_pageblock_flags_group+0x4 (free=
_hot_cold_page+0x55)
[  152.117954]      +func    	       -5 free_pages_prepare+0xb (free_hot_co=
ld_page+0x3e)
[  152.125963]      +func    	       -6 free_hot_cold_page+0x11 (__free_pag=
es+0x1d)
[  152.133564]      +func    	       -6 __free_pages+0x4 (__vunmap+0x8e)
[  152.140205]  |   +end     0x80000000     -6 hard_local_irq_enable+0x15 (=
ipipe_unstall_root+0x2d)
[  152.149173]  |   #func    	       -6 ipipe_root_only+0x9 (ipipe_unstall_=
root+0x13)
[  152.156932]  |   #begin   0x80000000     -6 hard_local_irq_disable+0x16 =
(ipipe_unstall_root+0xe)
[  152.165900]      #func    	       -6 ipipe_unstall_root+0x4 (ipipe_resto=
re_root+0x39)
[  152.173915]  |   #end     0x80000001     -6 hard_local_irq_restore+0x1b =
(ipipe_root_only+0x51)
[  152.182703]  |   #begin   0x80000001     -6 hard_local_irq_save+0x1b (ip=
ipe_root_only+0x13)
[  152.191283]      #func    	       -6 ipipe_root_only+0x9 (ipipe_restore_=
root+0x16)
[  152.199040]      #func    	       -6 ipipe_restore_root+0x9 (arch_local_=
irq_restore+0x14)
[  152.207427]  |   #end     0x80000001     -7 debug_smp_processor_id+0x97 =
(free_hot_cold_page+0x10b)
[  152.216569]  |   #begin   0x80000001     -7 debug_smp_processor_id+0x43 =
(free_hot_cold_page+0x10b)
[  152.225729]      +func    	       -7 get_pageblock_flags_group+0x4 (free=
_hot_cold_page+0x55)
[  152.234351]      +func    	       -7 free_pages_prepare+0xb (free_hot_co=
ld_page+0x3e)
[  152.242376]      +func    	       -7 free_hot_cold_page+0x11 (__free_pag=
es+0x1d)
[  152.249978]      +func    	       -7 __free_pages+0x4 (__vunmap+0x8e)
[  152.256603]  |   +end     0x80000000     -7 hard_local_irq_enable+0x15 (=
ipipe_unstall_root+0x2d)
[  152.265586]  |   #func    	       -7 ipipe_root_only+0x9 (ipipe_unstall_=
root+0x13)
[  152.273345]  |   #begin   0x80000000     -7 hard_local_irq_disable+0x16 =
(ipipe_unstall_root+0xe)
[  152.282340]      #func    	       -8 ipipe_unstall_root+0x4 (ipipe_resto=
re_root+0x39)
[  152.290407]  |   #end     0x80000001     -8 hard_local_irq_restore+0x1b =
(ipipe_root_only+0x51)
[  152.299193]  |   #begin   0x80000001     -8 hard_local_irq_save+0x1b (ip=
ipe_root_only+0x13)
[  152.307720]      #func    	       -8 ipipe_root_only+0x9 (ipipe_restore_=
root+0x16)
[  152.315540]      #func    	       -8 ipipe_restore_root+0x9 (arch_local_=
irq_restore+0x14)
[  152.323911]  |   #end     0x80000001     -8 debug_smp_processor_id+0x97 =
(free_hot_cold_page+0x10b)
[  152.333094]  |   #begin   0x80000001     -8 debug_smp_processor_id+0x43 =
(free_hot_cold_page+0x10b)
[  152.342253]      +func    	       -8 get_pageblock_flags_group+0x4 (free=
_hot_cold_page+0x55)
[  152.350920]      +func    	       -8 free_pages_prepare+0xb (free_hot_co=
ld_page+0x3e)
[  152.358953]      +func    	       -8 free_hot_cold_page+0x11 (__free_pag=
es+0x1d)
[  152.366529]      +func    	       -9 __free_pages+0x4 (__vunmap+0x8e)
[  152.373179]      +func    	       -9 free_vmap_area_noflush+0x9 (free_un=
map_vmap_area+0x25)
[  152.381741]      +func    	       -9 vunmap_page_range+0x11 (free_unmap_=
vmap_area+0x1d)
[  152.389924]      +func    	       -9 free_unmap_vmap_area+0x9 (remove_vm=
_area+0x6a)
[  152.397801]      +func    	       -9 sub_preempt_count+0x4 (_raw_write_u=
nlock+0x1a)
[  152.405662]      +func    	       -9 _raw_write_unlock+0x4 (remove_vm_ar=
ea+0x62)
[  152.413247]  |   +end     0x80000001    -10 hard_local_irq_restore+0x1b =
(ipipe_root_only+0x51)
[  152.422076]  |   +begin   0x80000001    -10 hard_local_irq_save+0x1b (ip=
ipe_root_only+0x13)
[  152.430621]      +func    	      -10 ipipe_root_only+0x9 (add_preempt_co=
unt+0x15)
[  152.438334]      +func    	      -10 add_preempt_count+0x9 (_raw_write_l=
ock+0x1b)
[  152.446013]      +func    	      -10 _raw_write_lock+0x9 (remove_vm_area=
+0x35)
[  152.453450]      +func    	      -10 sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
[  152.461209]      +func    	      -10 _raw_spin_unlock+0x4 (find_vmap_are=
a+0x4d)
[  152.468734]  |   +end     0x80000001    -11 hard_local_irq_restore+0x1b =
(ipipe_root_only+0x51)
[  152.477570]  |   +begin   0x80000001    -11 hard_local_irq_save+0x1b (ip=
ipe_root_only+0x13)
[  152.486097]      +func    	      -11 ipipe_root_only+0x9 (add_preempt_co=
unt+0x15)
[  152.493777]      +func    	      -11 add_preempt_count+0x9 (_raw_spin_lo=
ck+0x1b)
[  152.501389]      +func    	      -11 _raw_spin_lock+0x9 (find_vmap_area+=
0x1b)
[  152.508723]      +func    	      -11 find_vmap_area+0x7 (remove_vm_area+=
0x11)
[  203.440240] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  203.440240] 	  waiter =3D kernel/xenomai/skins/rtdm/drvlib.c:857 (rtdm_e=
vent_signal(), CPU #7)
[  203.440240] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  203.462755]  ffff88042a4dfc08 00000000000000d3 ffffffff8162dc10 00000000=
00000007
[  203.470208]  0000000000000000 ffffffff814c932c 0000000000000359 ffff8804=
2a4dfc50
[  203.477647]  ffffffff81004d80 ffff88042a4dfcc0 ffffffff810cf862 ffffffff=
814c893f
[  203.485092] Call Trace:
[  203.487537]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  203.492835]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  203.498400]  [<ffffffff81112f93>] ? T.935+0x6d/0xbf
[  203.503266]  [<ffffffff81113197>] ? rtdm_event_signal+0x26/0x78
[  203.509175]  [<ffffffffa04baaa3>] ? e1000_intr_msix_rx+0x83/0x91 [rt_e10=
00e]
[  203.516205]  [<ffffffff810ce442>] ? xnintr_irq_handler+0x9d/0x1df
[  203.522284]  [<ffffffff8109b4f7>] ? __ipipe_end_fasteoi_irq+0x20/0x20
[  203.522765] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  203.522765] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #6)
[  203.522765] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  203.522776]  0000000000000000 ffffffff814c6f44 000000000000006d ffff8804=
2a4dbcf0
[  203.522786]  ffffffff81004d80 ffff88042a4dbd60 ffffffff810cf862 ffffffff=
814c893f
[  203.522796] Call Trace:
[  203.522801]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  203.522807]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  203.522817]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  203.522827]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  203.522835]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  203.522843]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  203.522850]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  203.522861]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  203.522868]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  203.522874]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  203.522881]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  203.522889]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  203.545104] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  203.545104] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #4)
[  203.545104] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  203.545106]  ffff88042a4cfca8 00000000000000d1 ffffffff8162dc10 00000000=
00000004
[  203.545113]  0000000000000000 ffffffff814c6f44 000000000000006d ffff8804=
2a4cfcf0
[  203.545120]  ffffffff81004d80 ffff88042a4cfd60 ffffffff810cf862 ffffffff=
814c893f
[  203.545128] Call Trace:
[  203.545131]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  203.545135]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  203.545140]  [<ffffffff810a671a>] ? ipipe_trace_function+0x1c/0x1e
[  203.545145]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  203.545150]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  203.545155]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  203.545160]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  203.545165]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  203.545170]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  203.545176]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  203.545181]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  203.545185]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  203.545189]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  203.545194]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  203.522768]  ffff88042a4dbca8 00000000000000d1 ffffffff8162dc10 00000000=
00000006
[  203.765901]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  203.779637]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  203.785804]  [<ffffffff813ce379>] ? common_interrupt+0x79/0xaf
[  203.791623]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  203.797530]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  203.803437]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  203.809343]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  203.814816]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  203.820032]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  203.820431] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  203.820431] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #5)
[  203.820431] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  203.820439]  0000000000000000 ffffffff814c6f44 000000000000006d ffff8804=
2a4d3cf0
[  203.820446]  ffffffff81004d80 ffff88042a4d3d60 ffffffff810cf862 ffffffff=
814c893f
[  203.820453] Call Trace:
[  203.820456]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  203.820460]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  203.820467]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  203.820471]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  203.820476]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  203.820481]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  203.820486]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  203.820491]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  203.820496]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  203.820501]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  203.820505]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  203.820510]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  203.820514]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  203.820433]  ffff88042a4d3ca8 00000000000000d1 ffffffff8162dc10 00000000=
00000005
[  204.075276] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  204.075276] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #3)
[  204.075276] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  204.104977]  ffff88042a4cbca8 00000000000000d1 ffffffff8162dc10 00000000=
00000003
[  204.112414]  0000000000000000 ffffffff814c6f44 000000000000006d ffff8804=
2a4cbcf0
[  204.119851]  ffffffff81004d80 ffff88042a4cbd60 ffffffff810cf862 ffffffff=
814c893f
[  204.127323] Call Trace:
[  204.129768]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  204.130577] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  204.130577] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #0)
[  204.130577] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  204.130584]  0000000000000000 ffffffff814c6f44 000000000000006d ffffffff=
81603d00
[  204.130592]  ffffffff81004d80 ffffffff81603d70 ffffffff810cf862 ffffffff=
814c893f
[  204.130599] Call Trace:
[  204.130602]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  204.130606]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  204.130612] [  204.130615] Xenomai: stuck on nucleus lock ffffffff8162dc=
10
[  204.130615] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #1)
[  204.130615] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  204.130617]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  204.130618]  ffff88042a4c3ca8 00000000000000d1 ffffffff8162dc10 [<ffffff=
ff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  204.130624]  0000000000000001
[  204.130628]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  204.130629]  0000000000000000 ffffffff814c6f44 [<ffffffff8101bc5d>] ? __=
ipipe_handle_irq+0x108/0x162
[  204.130634]  000000000000006d ffff88042a4c3cf0 [<ffffffff813d4c79>] ? ap=
ic_timer_interrupt+0x79/0xc0
[  204.130639] =

[  204.130640]  ffffffff81004d80 [<ffffffff8101be71>] ? __ipipe_halt_root+0=
x4e/0x52
[  204.130644]  ffff88042a4c3d60 ffffffff810cf862 ffffffff814c893f [<ffffff=
ff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  204.130650] =

[  204.130651] Call Trace:
[  204.130652]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  204.130655]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  204.130660]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  204.130660]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  204.130665]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  204.130666]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  204.130671]  [<ffffffff813b72cf>] ? rest_init+0x83/0x87
[  204.130672]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  204.130677]  [<ffffffff81998d32>] ? start_kernel+0x3f7/0x404
[  204.130677]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  204.130682]  [<ffffffff81998770>] ? kernel_init+0x1d3/0x1d3
[  204.130683]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  204.130687]  [<ffffffff819982b4>] ? x86_64_start_reservations+0xb8/0xbd
[  204.130689]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  204.130694]  [<ffffffff819983ea>] ? x86_64_start_kernel+0x131/0x138
[  204.130695]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  204.130701]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  204.130706]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  204.130710]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  204.130714]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  204.130719]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  204.130579]  ffffffff81603cb8 00000000000000d1 ffffffff8162dc10 00000000=
00000000
[  204.396601]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  204.409555]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  204.414423]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  204.420675]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  204.427015]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  204.433181]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  204.439346]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  204.445255]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  204.451158]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  204.457067]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  204.462539]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  204.467755]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  256.295957] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  256.295957] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #4)
[  256.295957] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  256.318297]  ffff88042a4cfca8 00000000000000d1 ffffffff8162dc10 00000000=
00000004
[  256.325733]  0000000000000000 ffffffff814c6f44 000000000000006d ffff8804=
2a4cfcf0
[  256.333173]  ffffffff81004d80 ffff88042a4cfd60 ffffffff810cf862 ffffffff=
814c893f
[  256.340617] Call Trace:
[  256.343087]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  256.348388]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  256.353950]  [<ffffffff810a671a>] ? ipipe_trace_function+0x1c/0x1e
[  256.360116]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  256.364984]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  256.371238]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  256.377576]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  256.383742]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  256.389908]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  256.395816]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  256.401721]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  256.407627]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  256.413102]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  256.418318]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  256.442233] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  256.442233] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #6)
[  256.442233] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  256.464572]  ffff88042a4dbca8 00000000000000d1 ffffffff8162dc10 00000000=
00000006
[  256.472008]  0000000000000000 ffffffff814c6f44 000000000000006d ffff8804=
2a4dbcf0
[  256.479447]  ffffffff81004d80 ffff88042a4dbd60 ffffffff810cf862 ffffffff=
814c893f
[  256.486884] Call Trace:
[  256.489328]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  256.494629]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  256.500190]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  256.505060]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  256.511311]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  256.517649]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  256.523817]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  256.529985]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  256.535890]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  256.541795]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  256.547269]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  256.552487]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  256.633507] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  256.633507] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #5)
[  256.633507] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  256.655845]  ffff88042a4d3ca8 00000000000000d1 ffffffff8162dc10 00000000=
00000005
[  256.663290]  0000000000000000 ffffffff814c6f44 000000000000006d ffff8804=
2a4d3cf0
[  256.670737]  ffffffff81004d80 ffff88042a4d3d60 ffffffff810cf862 ffffffff=
814c893f
[  256.678182] Call Trace:
[  256.680628]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  256.685926]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  256.691488]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  256.696356]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  256.702610]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  256.708949]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  256.709103] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  256.709103] 	  waiter =3D kernel/xenomai/skins/rtdm/drvlib.c:857 (rtdm_e=
vent_signal(), CPU #7)
[  256.709103] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  256.709111]  0000000000000000 ffffffff814c932c 0000000000000359 ffff8804=
2a4dfc50
[  256.709118]  ffffffff81004d80 ffff88042a4dfcc0 ffffffff810cf862 ffffffff=
814c893f
[  256.709126] Call Trace:
[  256.709129]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  256.709133]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  256.709139]  [<ffffffff81112f93>] ? T.935+0x6d/0xbf
[  256.709144]  [<ffffffff81113197>] ? rtdm_event_signal+0x26/0x78
[  256.709150]  [<ffffffffa04baaa3>] ? e1000_intr_msix_rx+0x83/0x91 [rt_e10=
00e]
[  256.709156]  [<ffffffff810ce442>] ? xnintr_irq_handler+0x9d/0x1df
[  256.709161]  [<ffffffff8109b4f7>] ? __ipipe_end_fasteoi_irq+0x20/0x20
[  256.709166]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  256.709171]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  256.709176]  [<ffffffff813ce379>] ? common_interrupt+0x79/0xaf
[  256.709181]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  256.709186]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  256.709191]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  256.709195]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  256.709199]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  256.709204]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  256.736783] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  256.736783] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #3)
[  256.736783] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  256.736785]  ffff88042a4cbca8 00000000000000d1 ffffffff8162dc10 00000000=
00000003
[  256.736793]  0000000000000000 ffffffff814c6f44 000000000000006d ffff8804=
2a4cbcf0
[  256.736800]  ffffffff81004d80 ffff88042a4cbd60 ffffffff810cf862 ffffffff=
814c893f
[  256.736807] Call Trace:
[  256.736811]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  256.736815]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  256.736821]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  256.736826]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  256.736830]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  256.736835]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  256.736840]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  256.736845]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  256.736851]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  256.736855]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  256.736859]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  256.736864]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  256.736869]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  256.709105]  ffff88042a4dfc08 00000000000000d3 ffffffff8162dc10 00000000=
00000007
[  256.971148]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  256.984703]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  256.990613]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  256.996518]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  257.002423]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  257.007899]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  257.013114]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
[  257.015917] Xenomai: stuck on nucleus lock ffffffff8162dc10
[  257.015917] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #0)
[  257.015917] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  257.015924]  0000000000000000 ffffffff814c6f44 000000000000006d ffffffff=
81603d00
[  257.015932]  ffffffff81004d80 ffffffff81603d70 ffffffff810cf862 ffffffff=
814c893f
[  257.015939] Call Trace:
[  257.015942]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  257.015946]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  257.015952]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  257.015957]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  257.015962] [  257.015964] Xenomai: stuck on nucleus lock ffffffff8162dc=
10
[  257.015964] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #1)
[  257.015964] 	  owner	 =3D kernel/xenomai/skins/native/heap.c:372 (__heap=
_post_release(), CPU #2)
[  257.015967]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  257.015968]  ffff88042a4c3ca8 00000000000000d1 [<ffffffff8101bc5d>] ? __=
ipipe_handle_irq+0x108/0x162
[  257.015973]  ffffffff8162dc10 0000000000000001 [<ffffffff813d4c79>] ? ap=
ic_timer_interrupt+0x79/0xc0
[  257.015978] =

[  257.015979]  0000000000000000 [<ffffffff8101be71>] ? __ipipe_halt_root+0=
x4e/0x52
[  257.015983]  ffffffff814c6f44 000000000000006d ffff88042a4c3cf0 [<ffffff=
ff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  257.015989] =

[  257.015990]  ffffffff81004d80 [<ffffffff8101be71>] ? __ipipe_halt_root+0=
x4e/0x52
[  257.015994]  ffff88042a4c3d60 ffffffff810cf862 [<ffffffff81009f5a>] ? de=
fault_idle+0x4c/0x80
[  257.015999]  ffffffff814c893f
[  257.016003]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  257.016004] Call Trace:
[  257.016005]  [<ffffffff813b72cf>] ? rest_init+0x83/0x87
[  257.016008]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  257.016013]  [<ffffffff81998d32>] ? start_kernel+0x3f7/0x404
[  257.016014]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  257.016018]  [<ffffffff81998770>] ? kernel_init+0x1d3/0x1d3
[  257.016019]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  257.016021]  [<ffffffff819982b4>] ? x86_64_start_reservations+0xb8/0xbd
[  257.016024]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  257.016027]  [<ffffffff819983ea>] ? x86_64_start_kernel+0x131/0x138
[  257.016030]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  257.016035]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  257.016040]  [<ffffffff813d4c79>] ? apic_timer_interrupt+0x79/0xc0
[  257.016044]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  257.016050]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  257.016055]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  257.016059]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  257.016063]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  257.016068]  [<ffffffff813c57bf>] ? start_secondary+0x1df/0x1e6
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ProcessA.c
Type: text/x-csrc
Size: 720 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130502/976660a=
f/attachment.c>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ProcessB.c
Type: text/x-csrc
Size: 1228 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130502/976660a=
f/attachment-0001.c>
