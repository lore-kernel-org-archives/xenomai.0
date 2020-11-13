From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: [Xenomai over dovetail] Kernel hang in rcu_barrier after xenomai_init
Date: Fri, 13 Nov 2020 02:12:40 +0000
Message-ID: <MWHPR11MB17100D1F48C3EF22B3C6A329F2E60@MWHPR11MB1710.namprd11.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Recently I have been working on wip/dovetail branch to port xenomai over
dovetail. After fixed all TODOs for porting xenomai, kernel init now can
successfully finish xenomai init till hang in rcu_barrier.=20
Its call path is like this start_kernel->arch_call_rest_init->rest_init->
kernel_thread(kernel_init, NULL, CLONE_FS)->kernel_init->mark_readonly
->rcu_barrier when hang issue happen.=20

According to my debug , before call xenomai_init, all callback function=20
registerred with call_rcu can be invoked successfully after a period of tim=
e.
The first problematic call_rcu which its callback never be invoked can be=20
traced back to call xenomai_init  (actually I just found only one call_rcu=
=20
called during xenomai_init) before call rcu_barrier.=20

In addition , after xenomai_init is completed , all following callbacks wit=
h=20
registerred through call_rcus called by other driver init are also never=20
invoked till call rcu_barrier.

Is it not safe to call call_rcu with enabling xenomai over dovetail in this=
=20
case? What I should do to fix this issue?  Please help comment.

I have pushed all my patches onto my public branch=20
https://github.com/hongzhanchen/xenomai/tree/hzchen/dovetail ,please feel=20
free to check them.=20

Thanks for your help in advance.

Follow is kernel log which I added my debug info.

[    0.000000] Linux version 5.8.0+ (intel@intel-Z97X-UD5H) (gcc (Ubuntu 7.=
5.0-3ubuntu1~18.04) 7.5.0, GNU ld (GNU Binutils for Ubuntu) 2.30) #149 SMP =
IRQPIPE Thu Nov 12 20:24:49 EST 2020
[    0.000000] Command line: root=3D/dev/nfs rw nfsroot=3D192.168.1.100:/va=
r/lib/lava/dispatcher/tmp/484/extract-nfsrootfs-ie4gqo3a,tcp,hard,intr,vers=
=3D3 isolcpus=3D1-3 nosmt processor.max_cstate=3D0 intel.max_cstate=3D0 pro=
cessor_idle.max_cstate=3D0 intel_idle.max_cstate=3D0 nohz_ful irqaffinity=
=3D0 idle=3Dpoll nohalt nmi_watchdog=3D0 nosoftlockup intel_pstate=3Ddisabl=
e i915.enable_dc=3D0 i915.disable_power_well=3D0 clocksource=3Dtsc tsc=3Dre=
liable rcu_nocb_poll rcu_nocbs=3D1-3 nosmap audit=3D0 noefi initcall_debug =
loglevel=3D8 console=3DttyS0,115200n8 lava_mac=3D{LAVA_MAC}
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai =20
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d3ff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009d400-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003fffffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000403fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000040400000-0x0000000085c1afff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x0000000085c1b000-0x0000000085c1bfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000085c1c000-0x0000000085c1cfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000085c1d000-0x000000008c086fff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000008c087000-0x000000008c4f6fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000008c4f7000-0x000000008c573fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000008c574000-0x000000008c9a8fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000008c9a9000-0x000000008cffefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000008cfff000-0x000000008cffffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000008d000000-0x000000008fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000046dffffff] usabl=
e
[    0.000000] SMT: disabled
[    0.000000] process: using polling idle threads
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[    0.000000] tsc: Detected 2100.000 MHz processor
[    0.000998] tsc: Detected 2099.944 MHz TSC
[    0.000998] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.001001] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001011] last_pfn =3D 0x46e000 max_arch_pfn =3D 0x400000000
[    0.001015] MTRR default type: write-back
[    0.001016] MTRR fixed ranges enabled:
[    0.001018]   00000-9FFFF write-back
[    0.001019]   A0000-BFFFF uncachable
[    0.001020]   C0000-FFFFF write-protect
[    0.001022] MTRR variable ranges enabled:
[    0.001024]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.001025]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.001027]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.001028]   3 base 008E000000 mask 7FFE000000 uncachable
[    0.001029]   4 base 008D800000 mask 7FFF800000 uncachable
[    0.001030]   5 disabled
[    0.001031]   6 disabled
[    0.001032]   7 disabled
[    0.001033]   8 disabled
[    0.001034]   9 disabled
[    0.001452] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.002026] last_pfn =3D 0x8d000 max_arch_pfn =3D 0x400000000
[    0.011908] found SMP MP-table at [mem 0x000fcdf0-0x000fcdff]
[    0.012026] check: Scanning 1 areas for low memory corruption
[    0.012035] Using GB pages for direct mapping
[    0.012552] RAMDISK: [mem 0x7faee000-0x7fffffff]
[    0.012559] ACPI: Early table checksum verification disabled
[    0.012563] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.012568] ACPI: XSDT 0x000000008C5100A0 0000BC (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.012574] ACPI: FACP 0x000000008C54C9C0 000114 (v06 ALASKA A M I    01=
072009 AMI  00010013)
[    0.012581] ACPI: DSDT 0x000000008C5101E8 03C7D4 (v02 ALASKA A M I    01=
072009 INTL 20160527)
[    0.012585] ACPI: FACS 0x000000008C9A8080 000040
[    0.012588] ACPI: APIC 0x000000008C54CAD8 000084 (v04 ALASKA A M I    01=
072009 AMI  00010013)
[    0.012592] ACPI: FPDT 0x000000008C54CB60 000044 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.012595] ACPI: FIDT 0x000000008C54CBA8 00009C (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.012599] ACPI: MCFG 0x000000008C54CC48 00003C (v01 ALASKA A M I    01=
072009 MSFT 00000097)
[    0.012602] ACPI: SSDT 0x000000008C54CC88 001B5F (v02 CpuRef CpuSsdt  00=
003000 INTL 20160527)
[    0.012606] ACPI: SSDT 0x000000008C54E7E8 0031C6 (v02 SaSsdt SaSsdt   00=
003000 INTL 20160527)
[    0.012609] ACPI: HPET 0x000000008C5519B0 000038 (v01 ALASKA A M I    00=
000002      01000013)
[    0.012613] ACPI: SSDT 0x000000008C5519E8 000FAE (v02 ALASKA Ther_Rvp 00=
001000 INTL 20160527)
[    0.012617] ACPI: SSDT 0x000000008C552998 00304A (v02 INTEL  xh_whld4 00=
000000 INTL 20160527)
[    0.012620] ACPI: UEFI 0x000000008C5559E8 000042 (v01 ALASKA A M I    00=
000002      01000013)
[    0.012624] ACPI: LPIT 0x000000008C555A30 000094 (v01 ALASKA A M I    00=
000002      01000013)
[    0.012627] ACPI: SSDT 0x000000008C555AC8 0027DE (v02 ALASKA PtidDevc 00=
001000 INTL 20160527)
[    0.012631] ACPI: SSDT 0x000000008C5582A8 0014E2 (v02 ALASKA TbtTypeC 00=
000000 INTL 20160527)
[    0.012634] ACPI: DBGP 0x000000008C559790 000034 (v01 ALASKA A M I    00=
000002      01000013)
[    0.012638] ACPI: DBG2 0x000000008C5597C8 000054 (v00 ALASKA A M I    00=
000002      01000013)
[    0.012641] ACPI: SSDT 0x000000008C559820 001B67 (v02 ALASKA UsbCTabl 00=
001000 INTL 20160527)
[    0.012645] ACPI: SSDT 0x000000008C55B388 000144 (v02 Intel  ADebTabl 00=
001000 INTL 20160527)
[    0.012648] ACPI: WSMT 0x000000008C55B4D0 000028 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.012658] ACPI: Local APIC address 0xfee00000
[    0.013062] No NUMA configuration found
[    0.013063] Faking a node at [mem 0x0000000000000000-0x000000046dffffff]
[    0.013078] NODE_DATA(0) allocated [mem 0x46dfd5000-0x46dffffff]
[    0.013551] Zone ranges:
[    0.013552]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.013554]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.013556]   Normal   [mem 0x0000000100000000-0x000000046dffffff]
[    0.013558]   Device   empty
[    0.013559] Movable zone start for each node
[    0.013563] Early memory node ranges
[    0.013565]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.013566]   node   0: [mem 0x0000000000100000-0x000000003fffffff]
[    0.013567]   node   0: [mem 0x0000000040400000-0x0000000085c1afff]
[    0.013569]   node   0: [mem 0x0000000085c1d000-0x000000008c086fff]
[    0.013570]   node   0: [mem 0x000000008cfff000-0x000000008cffffff]
[    0.013571]   node   0: [mem 0x0000000100000000-0x000000046dffffff]
[    0.014173] Zeroed struct page in unavailable ranges: 25566 pages
[    0.014174] Initmem setup node 0 [mem 0x0000000000001000-0x000000046dfff=
fff]
[    0.014176] On node 0 totalpages: 4168738
[    0.014178]   DMA zone: 64 pages used for memmap
[    0.014179]   DMA zone: 25 pages reserved
[    0.014180]   DMA zone: 3996 pages, LIFO batch:0
[    0.014223]   DMA32 zone: 8883 pages used for memmap
[    0.014224]   DMA32 zone: 568454 pages, LIFO batch:63
[    0.019223]   Normal zone: 56192 pages used for memmap
[    0.019225]   Normal zone: 3596288 pages, LIFO batch:63
[    0.050824] Reserving Intel graphics memory at [mem 0x8e000000-0x8ffffff=
f]
[    0.051104] ACPI: PM-Timer IO Port: 0x1808
[    0.051107] ACPI: Local APIC address 0xfee00000
[    0.051114] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.051115] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.051116] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.051117] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.051165] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.051167] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.051169] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.051171] ACPI: IRQ0 used by override.
[    0.051172] ACPI: IRQ9 used by override.
[    0.051175] Using ACPI (MADT) for SMP configuration information
[    0.051177] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.051180] TSC deadline timer available
[    0.051181] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.051205] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.051207] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0=
x0009dfff]
[    0.051208] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0=
x0009ffff]
[    0.051209] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000dffff]
[    0.051210] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0=
x000fffff]
[    0.051213] PM: hibernation: Registered nosave memory: [mem 0x40000000-0=
x403fffff]
[    0.051215] PM: hibernation: Registered nosave memory: [mem 0x85c1b000-0=
x85c1bfff]
[    0.051216] PM: hibernation: Registered nosave memory: [mem 0x85c1c000-0=
x85c1cfff]
[    0.051218] PM: hibernation: Registered nosave memory: [mem 0x8c087000-0=
x8c4f6fff]
[    0.051219] PM: hibernation: Registered nosave memory: [mem 0x8c4f7000-0=
x8c573fff]
[    0.051220] PM: hibernation: Registered nosave memory: [mem 0x8c574000-0=
x8c9a8fff]
[    0.051221] PM: hibernation: Registered nosave memory: [mem 0x8c9a9000-0=
x8cffefff]
[    0.051223] PM: hibernation: Registered nosave memory: [mem 0x8d000000-0=
x8fffffff]
[    0.051224] PM: hibernation: Registered nosave memory: [mem 0x90000000-0=
xdfffffff]
[    0.051225] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0=
xefffffff]
[    0.051226] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0=
xfdffffff]
[    0.051227] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.051228] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.051229] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.051230] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfedfffff]
[    0.051231] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.051232] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xfeffffff]
[    0.051233] PM: hibernation: Registered nosave memory: [mem 0xff000000-0=
xffffffff]
[    0.051235] [mem 0x90000000-0xdfffffff] available for PCI devices
[    0.051237] Booting paravirtualized kernel on bare hardware
[    0.051240] clocksource: refined-jiffies: freq: 0 Hz, mask: 0xffffffff m=
ax_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.051247] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr=
_node_ids:1
[    0.051556] percpu: Embedded 106 pages/cpu s397312 r8192 d28672 u524288
[    0.051565] pcpu-alloc: s397312 r8192 d28672 u524288 alloc=3D1*2097152
[    0.051566] pcpu-alloc: [0] 0 1 2 3=20
[    0.051599] Built 1 zonelists, mobility grouping on.  Total pages: 41035=
74
[    0.051600] Policy zone: Normal
[    0.051603] Kernel command line: root=3D/dev/nfs rw nfsroot=3D192.168.1.=
100:/var/lib/lava/dispatcher/tmp/484/extract-nfsrootfs-ie4gqo3a,tcp,hard,in=
tr,vers=3D3 isolcpus=3D1-3 nosmt processor.max_cstate=3D0 intel.max_cstate=
=3D0 processor_idle.max_cstate=3D0 intel_idle.max_cstate=3D0 nohz_ful irqaf=
finity=3D0 idle=3Dpoll nohalt nmi_watchdog=3D0 nosoftlockup intel_pstate=3D=
disable i915.enable_dc=3D0 i915.disable_power_well=3D0 clocksource=3Dtsc ts=
c=3Dreliable rcu_nocb_poll rcu_nocbs=3D1-3 nosmap audit=3D0 noefi initcall_=
debug loglevel=3D8 console=3DttyS0,115200n8 lava_mac=3D{LAVA_MAC}
[    0.052088] audit: disabled (until reboot)
[    0.053292] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.053830] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.053905] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.110597] Memory: 16245408K/16674952K available (16388K kernel code, 2=
972K rwdata, 5972K rodata, 2784K init, 39152K bss, 429544K reserved, 0K cma=
-reserved)
[    0.110606] random: get_random_u64 called from __kmem_cache_create+0x41/=
0x550 with crng_init=3D0
[    0.110745] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.110759] ftrace: allocating 50530 entries in 198 pages
[    0.138610] ftrace: allocated 198 pages with 4 groups
[    0.138746] rcu: Hierarchical RCU implementation.
[    0.138748] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D4.
[    0.138749] 	Trampoline variant of Tasks RCU enabled.
[    0.138750] 	Rude variant of Tasks RCU enabled.
[    0.138751] 	Tracing variant of Tasks RCU enabled.
[    0.138752] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.138753] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.143132] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
[    0.143691] IRQ pipeline enabled
[    0.143692] rcu: 	Offload RCU callbacks from CPUs: 1-3.
[    0.143693] rcu: 	Poll for callbacks from no-CBs CPUs.
[    0.143693] random: crng done (trusting CPU's manufacturer)
[    0.143701] calling  con_init+0x0/0x23e @ 0
[    0.145549] Console: colour VGA+ 80x25
[    0.145553] initcall con_init+0x0/0x23e returned 0 after 0 usecs
[    0.145555] calling  hvc_console_init+0x0/0x19 @ 0
[    0.145558] initcall hvc_console_init+0x0/0x19 returned 0 after 0 usecs
[    0.145560] calling  univ8250_console_init+0x0/0x2d @ 0
[    1.455151] printk: console [ttyS0] enabled
[    1.459370] initcall univ8250_console_init+0x0/0x2d returned 0 after 0 u=
secs
[    1.466465] calling  kgdboc_earlycon_late_init+0x0/0x25 @ 0
[    1.472079] initcall kgdboc_earlycon_late_init+0x0/0x25 returned 0 after=
 0 usecs
[    1.479535] ACPI: Core revision 20200528
[    1.483989] clocksource: hpet: freq: 23999999 Hz, mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    1.494753] ----chz tick_setup_device start mode =3D 0x0
[    1.499935] ----chz tick_setup_device before setup mode =3D 0x0
[    1.505723] ---chz newdev->features =3D 0x103
[    1.509942] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0+ #149
[    1.516079] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[    1.522650] IRQ stage: Linux
[    1.525561] Call Trace:
[    1.528040]  dump_stack+0x93/0xc5
[    1.531387]  tick_setup_periodic+0x16/0xb0
[    1.535516]  tick_setup_device+0x260/0x270
[    1.539650]  tick_check_new_device+0xd4/0x100
[    1.544040]  clockevents_register_device+0x70/0x100
[    1.548955]  clockevents_config_and_register+0x2e/0x40
[    1.554136]  hpet_enable+0x31c/0x3b2
[    1.557744]  hpet_time_init+0xe/0x4e
[    1.561352]  x86_late_time_init+0x1b/0x35
[    1.565396]  start_kernel+0x4ef/0x5b0
[    1.569093]  x86_64_start_reservations+0x24/0x26
[    1.573746]  x86_64_start_kernel+0x74/0x77
[    1.577879]  secondary_startup_64+0xa4/0xb0
[    1.582093] chz name =3D hpet
[    1.584993] APIC: Switch to symmetric I/O mode setup
[    1.592282] x2apic: IRQ remapping doesn't support X2APIC mode
[    1.605537] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    1.629203] clocksource: tsc-early: freq: 2099944000 Hz, mask: 0xfffffff=
fffffffff max_cycles: 0x1e44fb6c2ab, max_idle_ns: 440795206594 ns
[    1.641613] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4199.88 BogoMIPS (lpj=3D8399776)
[    1.645613] pid_max: default: 32768 minimum: 301
[    1.649646] LSM: Security Framework initializing
[    1.653622] Yama: becoming mindful.
[    1.657170] AppArmor: AppArmor initialized
[    1.657690] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    1.661651] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    1.665850] ----------call_rcu 1---------
[    1.669686] x86/cpu: VMX (outside TXT) disabled by BIOS
[    1.673631] mce: CPU0: Thermal monitoring enabled (TM1)
[    1.677640] process: WARNING: polling idle and HT enabled, performance m=
ay degrade
[    1.681614] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    1.685612] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    1.689615] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    1.693615] Spectre V2 : Mitigation: Enhanced IBRS
[    1.697612] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    1.701614] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    1.705615] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl and seccomp
[    1.709614] TAA: Vulnerable: Clear CPU buffers attempted, no microcode
[    1.713613] SRBDS: Vulnerable: No microcode
[    1.721696] Freeing SMP alternatives memory: 48K
[    1.729707] ----chz tick_setup_device start mode =3D 0x0
[    1.733611]  td->evtdev->name =3Dhpet
[    1.733611]  td->evtdev->event_handler =3D0xab730b80
[    1.733611] ----chz tick_setup_device before setup mode =3D 0x0
[    1.733611] ---chz newdev->features =3D 0x102
[    1.733611] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0+ #149
[    1.733611] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[    1.733611] IRQ stage: Linux
[    1.733611] Call Trace:
[    1.733611]  dump_stack+0x93/0xc5
[    1.733611]  tick_setup_periodic+0x16/0xb0
[    1.733611]  tick_setup_device+0x260/0x270
[    1.733611]  ? tick_periodic+0x80/0x80
[    1.733611]  tick_check_new_device+0xd4/0x100
[    1.733611]  clockevents_register_device+0x70/0x100
[    1.733611]  clockevents_config_and_register+0x2e/0x40
[    1.733611]  setup_APIC_timer+0xed/0xf0
[    1.733611]  setup_boot_APIC_clock+0x49c/0x4bf
[    1.733611]  ? init_freq_invariance+0x2d2/0x3c0
[    1.733611]  native_smp_prepare_cpus+0x1e8/0x295
[    1.733611]  kernel_init_freeable+0xd8/0x29c
[    1.733611]  ? rest_init+0xb0/0xb0
[    1.733611]  kernel_init+0xe/0x110
[    1.733611]  ret_from_fork+0x1f/0x30
[    1.733611] chz name =3D lapic-deadline
[    1.733611] TSC deadline timer enabled
[    1.733611] smpboot: CPU0: Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz (fam=
ily: 0x6, model: 0x8e, stepping: 0xc)
[    1.733748] calling  trace_init_flags_sys_enter+0x0/0xf @ 1
[    1.737615] initcall trace_init_flags_sys_enter+0x0/0xf returned 0 after=
 0 usecs
[    1.741614] calling  trace_init_flags_sys_exit+0x0/0xf @ 1
[    1.745614] initcall trace_init_flags_sys_exit+0x0/0xf returned 0 after =
0 usecs
[    1.749614] calling  init_hw_perf_events+0x0/0x53e @ 1
[    1.753612] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    1.757613] ... version:                4
[    1.761612] ... bit width:              48
[    1.765612] ... generic registers:      8
[    1.769613] ... value mask:             0000ffffffffffff
[    1.773612] ... max period:             00007fffffffffff
[    1.777612] ... fixed-purpose events:   3
[    1.781612] ... event mask:             00000007000000ff
[    1.785636] initcall init_hw_perf_events+0x0/0x53e returned 0 after 3125=
0 usecs
[    1.789614] calling  init_real_mode+0x0/0x1f2 @ 1
[    1.793621] initcall init_real_mode+0x0/0x1f2 returned 0 after 0 usecs
[    1.797614] calling  trace_init_perf_perm_irq_work_exit+0x0/0x18 @ 1
[    1.801613] initcall trace_init_perf_perm_irq_work_exit+0x0/0x18 returne=
d 0 after 0 usecs
[    1.805614] calling  register_nmi_cpu_backtrace_handler+0x0/0x1b @ 1
[    1.809614] initcall register_nmi_cpu_backtrace_handler+0x0/0x1b returne=
d 0 after 0 usecs
[    1.813614] calling  numachip_system_init+0x0/0x6c @ 1
[    1.817614] initcall numachip_system_init+0x0/0x6c returned 0 after 0 us=
ecs
[    1.821614] calling  kvm_setup_vsyscall_timeinfo+0x0/0x12b @ 1
[    1.825614] initcall kvm_setup_vsyscall_timeinfo+0x0/0x12b returned 0 af=
ter 0 usecs
[    1.829614] calling  spawn_ksoftirqd+0x0/0x3e @ 1
[    1.833634] initcall spawn_ksoftirqd+0x0/0x3e returned 0 after 0 usecs
[    1.837614] calling  migration_init+0x0/0x19 @ 1
[    1.841614] initcall migration_init+0x0/0x19 returned 0 after 0 usecs
[    1.845614] calling  srcu_bootup_announce+0x0/0x35 @ 1
[    1.849612] rcu: Hierarchical SRCU implementation.
[    1.853614] initcall srcu_bootup_announce+0x0/0x35 returned 0 after 3906=
 usecs
[    1.857614] calling  rcu_spawn_core_kthreads+0x0/0x81 @ 1
[    1.861614] initcall rcu_spawn_core_kthreads+0x0/0x81 returned 0 after 0=
 usecs
[    1.865614] calling  rcu_spawn_gp_kthread+0x0/0x16d @ 1
[    1.869635] initcall rcu_spawn_gp_kthread+0x0/0x16d returned 0 after 0 u=
secs
[    1.873614] calling  check_cpu_stall_init+0x0/0x20 @ 1
[    1.877614] initcall check_cpu_stall_init+0x0/0x20 returned 0 after 0 us=
ecs
[    1.881614] calling  rcu_sysrq_init+0x0/0x28 @ 1
[    1.885614] initcall rcu_sysrq_init+0x0/0x28 returned 0 after 0 usecs
[    1.889614] calling  cpu_stop_init+0x0/0x8b @ 1
[    1.893638] initcall cpu_stop_init+0x0/0x8b returned 0 after 0 usecs
[    1.897616] calling  init_events+0x0/0x49 @ 1
[    1.901624] initcall init_events+0x0/0x49 returned 0 after 0 usecs
[    1.905615] calling  init_trace_printk+0x0/0x12 @ 1
[    1.909616] initcall init_trace_printk+0x0/0x12 returned 0 after 0 usecs
[    1.913613] calling  event_trace_enable_again+0x0/0x44 @ 1
[    1.917614] initcall event_trace_enable_again+0x0/0x44 returned 0 after =
0 usecs
[    1.921614] calling  jump_label_init_module+0x0/0x17 @ 1
[    1.925614] initcall jump_label_init_module+0x0/0x17 returned 0 after 0 =
usecs
[    1.929615] calling  dynamic_debug_init+0x0/0x25f @ 1
[    1.934660] initcall dynamic_debug_init+0x0/0x25f returned 0 after 0 use=
cs
[    1.937614] calling  initialize_ptr_random+0x0/0x50 @ 1
[    1.941621] initcall initialize_ptr_random+0x0/0x50 returned 0 after 0 u=
secs
[    1.945616] calling  efi_memreserve_root_init+0x0/0x2e @ 1
[    1.949615] initcall efi_memreserve_root_init+0x0/0x2e returned 0 after =
0 usecs
[    1.953613] calling  efi_earlycon_remap_fb+0x0/0x57 @ 1
[    1.957613] initcall efi_earlycon_remap_fb+0x0/0x57 returned 0 after 0 u=
secs
[    1.961613] calling  idle_inject_init+0x0/0x17 @ 1
[    1.965634] initcall idle_inject_init+0x0/0x17 returned 0 after 0 usecs
[    1.969753] ----------call_rcu 1---------
[    1.973663] smp: Bringing up secondary CPUs ...
[    1.977619] ----------call_rcu 1---------
[    1.981748] x86: Booting SMP configuration:
[    1.985616] .... node  #0, CPUs:      #1
[    1.461984] ----chz tick_setup_device start mode =3D 0x0
[    1.461984] ----chz tick_setup_device before setup mode =3D 0x0
[    1.461984] ---chz newdev->features =3D 0x102
[    1.461984] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.8.0+ #149
[    1.461984] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[    1.461984] IRQ stage: Linux
[    1.461984] Call Trace:
[    1.461984]  dump_stack+0x93/0xc5
[    1.461984]  tick_setup_periodic+0x16/0xb0
[    1.461984]  tick_setup_device+0x260/0x270
[    1.461984]  tick_check_new_device+0xd4/0x100
[    1.461984]  clockevents_register_device+0x70/0x100
[    1.461984]  clockevents_config_and_register+0x2e/0x40
[    1.461984]  setup_APIC_timer+0xed/0xf0
[    1.461984]  setup_secondary_APIC_clock+0xe/0x20
[    1.461984]  start_secondary+0x14a/0x1a0
[    1.461984]  secondary_startup_64+0xa4/0xb0
[    1.461984] chz name =3D lapic-deadline
[    2.069685] ----------call_rcu 1---------
[    2.073621] ----------call_rcu 1---------
[    2.077780]  #2
[    1.461984] ----chz tick_setup_device start mode =3D 0x0
[    1.461984] ----chz tick_setup_device before setup mode =3D 0x0
[    1.461984] ---chz newdev->features =3D 0x102
[    1.461984] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.8.0+ #149
[    1.461984] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[    1.461984] IRQ stage: Linux
[    1.461984] Call Trace:
[    1.461984]  dump_stack+0x93/0xc5
[    1.461984]  tick_setup_periodic+0x16/0xb0
[    1.461984]  tick_setup_device+0x260/0x270
[    1.461984]  tick_check_new_device+0xd4/0x100
[    1.461984]  clockevents_register_device+0x70/0x100
[    1.461984]  clockevents_config_and_register+0x2e/0x40
[    1.461984]  setup_APIC_timer+0xed/0xf0
[    1.461984]  setup_secondary_APIC_clock+0xe/0x20
[    1.461984]  start_secondary+0x14a/0x1a0
[    1.461984]  secondary_startup_64+0xa4/0xb0
[    1.461984] chz name =3D lapic-deadline
[    2.157669] ----------call_rcu 1---------
[    2.161763]  #3
[    1.461984] ----chz tick_setup_device start mode =3D 0x0
[    2.165617] ----------call_rcu 1---------
[    1.461984] ----chz tick_setup_device before setup mode =3D 0x0
[    1.461984] ---chz newdev->features =3D 0x102
[    1.461984] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.8.0+ #149
[    1.461984] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[    1.461984] IRQ stage: Linux
[    1.461984] Call Trace:
[    1.461984]  dump_stack+0x93/0xc5
[    1.461984]  tick_setup_periodic+0x16/0xb0
[    1.461984]  tick_setup_device+0x260/0x270
[    1.461984]  tick_check_new_device+0xd4/0x100
[    1.461984]  clockevents_register_device+0x70/0x100
[    1.461984]  clockevents_config_and_register+0x2e/0x40
[    1.461984]  setup_APIC_timer+0xed/0xf0
[    1.461984]  setup_secondary_APIC_clock+0xe/0x20
[    1.461984]  start_secondary+0x14a/0x1a0
[    1.461984]  secondary_startup_64+0xa4/0xb0
[    1.461984] chz name =3D lapic-deadline
[    2.241669] ----------call_rcu 1---------
[    2.245632] smp: Brought up 1 node, 4 CPUs
[    2.249615] smpboot: Max logical packages: 1
[    2.253613] smpboot: Total of 4 processors activated (16799.55 BogoMIPS)
[    2.258514] devtmpfs: initialized
[    2.261662] x86/mm: Memory block size: 128MB
[    2.274173] calling  bpf_jit_charge_init+0x0/0x3a @ 1
[    2.277615] initcall bpf_jit_charge_init+0x0/0x3a returned 0 after 0 use=
cs
[    2.281617] calling  ipc_ns_init+0x0/0x44 @ 1
[    2.285619] initcall ipc_ns_init+0x0/0x44 returned 0 after 0 usecs
[    2.289614] calling  init_mmap_min_addr+0x0/0x1b @ 1
[    2.293616] initcall init_mmap_min_addr+0x0/0x1b returned 0 after 0 usec=
s
[    2.297615] calling  pci_realloc_setup_params+0x0/0x3d @ 1
[    2.301614] initcall pci_realloc_setup_params+0x0/0x3d returned 0 after =
0 usecs
[    2.305614] calling  net_ns_init+0x0/0x122 @ 1
[    2.309655] initcall net_ns_init+0x0/0x122 returned 0 after 0 usecs
[    2.313799] calling  e820__register_nvs_regions+0x0/0x3d @ 1
[    2.317622] PM: Registering ACPI NVS region [mem 0x85c1b000-0x85c1bfff] =
(4096 bytes)
[    2.321613] PM: Registering ACPI NVS region [mem 0x8c574000-0x8c9a8fff] =
(4411392 bytes)
[    2.325684] initcall e820__register_nvs_regions+0x0/0x3d returned 0 afte=
r 7812 usecs
[    2.329614] calling  cpufreq_register_tsc_scaling+0x0/0x32 @ 1
[    2.333615] initcall cpufreq_register_tsc_scaling+0x0/0x32 returned 0 af=
ter 0 usecs
[    2.337614] calling  fpu__init_dovetail+0x0/0x32 @ 1
[    2.341624] initcall fpu__init_dovetail+0x0/0x32 returned 182 after 0 us=
ecs
[    2.345616] calling  reboot_init+0x0/0x45 @ 1
[    2.349619] initcall reboot_init+0x0/0x45 returned 0 after 0 usecs
[    2.353615] calling  init_lapic_sysfs+0x0/0x29 @ 1
[    2.357617] initcall init_lapic_sysfs+0x0/0x29 returned 0 after 0 usecs
[    2.361614] calling  alloc_frozen_cpus+0x0/0x23 @ 1
[    2.365618] initcall alloc_frozen_cpus+0x0/0x23 returned 0 after 0 usecs
[    2.369614] calling  cpu_hotplug_pm_sync_init+0x0/0x19 @ 1
[    2.373618] initcall cpu_hotplug_pm_sync_init+0x0/0x19 returned 0 after =
0 usecs
[    2.377614] calling  wq_sysfs_init+0x0/0x30 @ 1
[    2.381634] initcall wq_sysfs_init+0x0/0x30 returned 0 after 0 usecs
[    2.385614] calling  ksysfs_init+0x0/0x9c @ 1
[    2.389624] initcall ksysfs_init+0x0/0x9c returned 0 after 0 usecs
[    2.393614] calling  sugov_register+0x0/0x17 @ 1
[    2.397618] initcall sugov_register+0x0/0x17 returned 0 after 0 usecs
[    2.401614] calling  pm_init+0x0/0x79 @ 1
[    2.405644] initcall pm_init+0x0/0x79 returned 0 after 0 usecs
[    2.409614] calling  pm_disk_init+0x0/0x1e @ 1
[    2.413620] initcall pm_disk_init+0x0/0x1e returned 0 after 0 usecs
[    2.417614] calling  swsusp_header_init+0x0/0x31 @ 1
[    2.421618] initcall swsusp_header_init+0x0/0x31 returned 0 after 0 usec=
s
[    2.425614] calling  rcu_set_runtime_mode+0x0/0x1c @ 1
[    2.429616] initcall rcu_set_runtime_mode+0x0/0x1c returned 0 after 0 us=
ecs
[    2.433614] calling  rcu_spawn_tasks_kthread+0x0/0x50 @ 1
[    2.437635] initcall rcu_spawn_tasks_kthread+0x0/0x50 returned 0 after 0=
 usecs
[    2.441614] calling  rcu_spawn_tasks_rude_kthread+0x0/0x19 @ 1
[    2.445633] initcall rcu_spawn_tasks_rude_kthread+0x0/0x19 returned 0 af=
ter 0 usecs
[    2.449614] calling  rcu_spawn_tasks_trace_kthread+0x0/0x50 @ 1
[    2.453632] initcall rcu_spawn_tasks_trace_kthread+0x0/0x50 returned 0 a=
fter 0 usecs
[    2.457615] calling  init_jiffies_clocksource+0x0/0x1e @ 1
[    2.461615] clocksource: jiffies: freq: 0 Hz, mask: 0xffffffff max_cycle=
s: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    2.465619] initcall init_jiffies_clocksource+0x0/0x1e returned 0 after =
3906 usecs
[    2.469615] calling  futex_init+0x0/0x100 @ 1
[    2.473621] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    2.477620] initcall futex_init+0x0/0x100 returned 0 after 3906 usecs
[    2.481614] calling  cgroup_wq_init+0x0/0x2e @ 1
[    2.485626] initcall cgroup_wq_init+0x0/0x2e returned 0 after 0 usecs
[    2.489614] calling  cgroup1_wq_init+0x0/0x2e @ 1
[    2.493625] initcall cgroup1_wq_init+0x0/0x2e returned 0 after 0 usecs
[    2.497614] calling  ftrace_mod_cmd_init+0x0/0x12 @ 1
[    2.501618] initcall ftrace_mod_cmd_init+0x0/0x12 returned 0 after 0 use=
cs
[    2.505613] calling  init_wakeup_tracer+0x0/0x32 @ 1
[    2.509619] initcall init_wakeup_tracer+0x0/0x32 returned 0 after 0 usec=
s
[    2.513613] calling  init_graph_trace+0x0/0x64 @ 1
[    2.517621] initcall init_graph_trace+0x0/0x64 returned 0 after 0 usecs
[    2.521614] calling  init_zero_pfn+0x0/0x3d @ 1
[    2.525615] initcall init_zero_pfn+0x0/0x3d returned 0 after 0 usecs
[    2.529616] calling  init_per_zone_wmark_min+0x0/0x75 @ 1
[    2.533618] initcall init_per_zone_wmark_min+0x0/0x75 returned 0 after 0=
 usecs
[    2.537614] calling  mem_cgroup_swap_init+0x0/0x56 @ 1
[    2.541620] initcall mem_cgroup_swap_init+0x0/0x56 returned 0 after 0 us=
ecs
[    2.545613] calling  memory_failure_init+0x0/0xa6 @ 1
[    2.549615] initcall memory_failure_init+0x0/0xa6 returned 0 after 0 use=
cs
[    2.553614] calling  cma_init_reserved_areas+0x0/0x1a6 @ 1
[    2.557614] initcall cma_init_reserved_areas+0x0/0x1a6 returned 0 after =
0 usecs
[    2.561613] calling  fsnotify_init+0x0/0x4e @ 1
[    2.565625] initcall fsnotify_init+0x0/0x4e returned 0 after 0 usecs
[    2.569613] calling  filelock_init+0x0/0x9d @ 1
[    2.573628] initcall filelock_init+0x0/0x9d returned 0 after 0 usecs
[    2.577614] calling  init_script_binfmt+0x0/0x1b @ 1
[    2.581615] initcall init_script_binfmt+0x0/0x1b returned 0 after 0 usec=
s
[    2.585614] calling  init_elf_binfmt+0x0/0x1b @ 1
[    2.589613] initcall init_elf_binfmt+0x0/0x1b returned 0 after 0 usecs
[    2.593614] calling  configfs_init+0x0/0x99 @ 1
[    2.597620] initcall configfs_init+0x0/0x99 returned 0 after 0 usecs
[    2.601614] calling  debugfs_init+0x0/0x55 @ 1
[    2.605619] initcall debugfs_init+0x0/0x55 returned 0 after 0 usecs
[    2.609614] calling  tracefs_init+0x0/0x40 @ 1
[    2.613619] initcall tracefs_init+0x0/0x40 returned 0 after 0 usecs
[    2.617614] calling  securityfs_init+0x0/0x6e @ 1
[    2.621631] initcall securityfs_init+0x0/0x6e returned 0 after 0 usecs
[    2.625614] calling  prandom_init+0x0/0xbb @ 1
[    2.629619] initcall prandom_init+0x0/0xbb returned 0 after 0 usecs
[    2.633614] calling  pinctrl_init+0x0/0xb3 @ 1
[    2.637613] pinctrl core: initialized pinctrl subsystem
[    2.641629] initcall pinctrl_init+0x0/0xb3 returned 0 after 3906 usecs
[    2.645614] calling  gpiolib_dev_init+0x0/0xcc @ 1
[    2.649626] initcall gpiolib_dev_init+0x0/0xcc returned 0 after 0 usecs
[    2.653615] calling  sfi_sysfs_init+0x0/0xd8 @ 1
[    2.657615] initcall sfi_sysfs_init+0x0/0xd8 returned 0 after 0 usecs
[    2.661615] calling  virtio_init+0x0/0x30 @ 1
[    2.665621] initcall virtio_init+0x0/0x30 returned 0 after 0 usecs
[    2.669614] calling  regulator_init+0x0/0x9d @ 1
[    2.673681] initcall regulator_init+0x0/0x9d returned 0 after 0 usecs
[    2.677615] calling  iommu_init+0x0/0x30 @ 1
[    2.681620] initcall iommu_init+0x0/0x30 returned 0 after 0 usecs
[    2.685615] calling  component_debug_init+0x0/0x22 @ 1
[    2.689620] initcall component_debug_init+0x0/0x22 returned 0 after 0 us=
ecs
[    2.693614] calling  early_resume_init+0x0/0x9c @ 1
[    2.697780] PM: RTC time: 09:41:47, date: 2020-11-13
[    2.701618] initcall early_resume_init+0x0/0x9c returned 0 after 3906 us=
ecs
[    2.705615] calling  thermal_init+0x0/0x11d @ 1
[    2.709617] thermal_sys: Registered thermal governor 'fair_share'
[    2.709618] thermal_sys: Registered thermal governor 'bang_bang'
[    2.713613] thermal_sys: Registered thermal governor 'step_wise'
[    2.717616] thermal_sys: Registered thermal governor 'user_space'
[    2.721616] initcall thermal_init+0x0/0x11d returned 0 after 11718 usecs
[    2.729614] calling  opp_debug_init+0x0/0x22 @ 1
[    2.733618] initcall opp_debug_init+0x0/0x22 returned 0 after 0 usecs
[    2.737614] calling  cpufreq_core_init+0x0/0x3f @ 1
[    2.741619] initcall cpufreq_core_init+0x0/0x3f returned 0 after 0 usecs
[    2.745614] calling  cpufreq_gov_performance_init+0x0/0x17 @ 1
[    2.749618] initcall cpufreq_gov_performance_init+0x0/0x17 returned 0 af=
ter 0 usecs
[    2.753614] calling  cpuidle_init+0x0/0x26 @ 1
[    2.757622] initcall cpuidle_init+0x0/0x26 returned 0 after 0 usecs
[    2.761615] calling  capsule_reboot_register+0x0/0x17 @ 1
[    2.765619] initcall capsule_reboot_register+0x0/0x17 returned 0 after 0=
 usecs
[    2.769613] calling  sock_init+0x0/0x99 @ 1
[    2.773721] initcall sock_init+0x0/0x99 returned 0 after 0 usecs
[    2.777614] calling  net_inuse_init+0x0/0x29 @ 1
[    2.781621] initcall net_inuse_init+0x0/0x29 returned 0 after 0 usecs
[    2.785613] calling  net_defaults_init+0x0/0x29 @ 1
[    2.789617] initcall net_defaults_init+0x0/0x29 returned 0 after 0 usecs
[    2.793613] calling  init_default_flow_dissectors+0x0/0x55 @ 1
[    2.797615] initcall init_default_flow_dissectors+0x0/0x55 returned 0 af=
ter 0 usecs
[    2.801613] calling  netpoll_init+0x0/0x2d @ 1
[    2.805613] initcall netpoll_init+0x0/0x2d returned 0 after 0 usecs
[    2.809613] calling  netlink_proto_init+0x0/0x181 @ 1
[    2.813629] NET: Registered protocol family 16
[    2.817627] initcall netlink_proto_init+0x0/0x181 returned 0 after 3906 =
usecs
[    2.821616] calling  tcp_bpf_v4_build_proto+0x0/0x71 @ 1
[    2.825614] initcall tcp_bpf_v4_build_proto+0x0/0x71 returned 0 after 0 =
usecs
[    2.829614] calling  udp_bpf_v4_build_proto+0x0/0x3b @ 1
[    2.833614] initcall udp_bpf_v4_build_proto+0x0/0x3b returned 0 after 0 =
usecs
[    2.837613] calling  bsp_pm_check_init+0x0/0x19 @ 1
[    2.841617] initcall bsp_pm_check_init+0x0/0x19 returned 0 after 0 usecs
[    2.845794] calling  irq_sysfs_init+0x0/0x9b @ 1
[    2.855608] initcall irq_sysfs_init+0x0/0x9b returned 0 after 3906 usecs
[    2.857616] calling  dma_atomic_pool_init+0x0/0x156 @ 1
[    2.861775] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    2.865771] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    2.869778] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    2.873621] initcall dma_atomic_pool_init+0x0/0x156 returned 0 after 117=
18 usecs
[    2.877615] calling  audit_init+0x0/0x177 @ 1
[    2.881613] initcall audit_init+0x0/0x177 returned 0 after 0 usecs
[    2.885613] calling  release_early_probes+0x0/0x3d @ 1
[    2.889613] initcall release_early_probes+0x0/0x3d returned 0 after 0 us=
ecs
[    2.893614] calling  bdi_class_init+0x0/0x4e @ 1
[    2.897622] initcall bdi_class_init+0x0/0x4e returned 0 after 0 usecs
[    2.901614] calling  mm_sysfs_init+0x0/0x2e @ 1
[    2.905619] initcall mm_sysfs_init+0x0/0x2e returned 0 after 0 usecs
[    2.909614] calling  kobject_uevent_init+0x0/0x12 @ 1
[    2.913620] initcall kobject_uevent_init+0x0/0x12 returned 0 after 0 use=
cs
[    2.917614] calling  gpiolib_sysfs_init+0x0/0xaa @ 1
[    2.921621] initcall gpiolib_sysfs_init+0x0/0xaa returned 0 after 0 usec=
s
[    2.925614] calling  acpi_gpio_setup_params+0x0/0x6f @ 1
[    2.929616] initcall acpi_gpio_setup_params+0x0/0x6f returned 0 after 0 =
usecs
[    2.933614] calling  pcibus_class_init+0x0/0x1e @ 1
[    2.937619] initcall pcibus_class_init+0x0/0x1e returned 0 after 0 usecs
[    2.941614] calling  pci_driver_init+0x0/0x27 @ 1
[    2.945627] initcall pci_driver_init+0x0/0x27 returned 0 after 0 usecs
[    2.949614] calling  rio_bus_init+0x0/0x45 @ 1
[    2.953624] initcall rio_bus_init+0x0/0x45 returned 0 after 0 usecs
[    2.957614] calling  backlight_class_init+0x0/0xac @ 1
[    2.961620] initcall backlight_class_init+0x0/0xac returned 0 after 0 us=
ecs
[    2.965614] calling  tty_class_init+0x0/0x39 @ 1
[    2.969619] initcall tty_class_init+0x0/0x39 returned 0 after 0 usecs
[    2.973614] calling  vtconsole_class_init+0x0/0xe3 @ 1
[    2.977636] initcall vtconsole_class_init+0x0/0xe3 returned 0 after 0 us=
ecs
[    2.981614] calling  serdev_init+0x0/0x22 @ 1
[    2.985623] initcall serdev_init+0x0/0x22 returned 0 after 0 usecs
[    2.989614] calling  iommu_dev_init+0x0/0x1e @ 1
[    2.993620] initcall iommu_dev_init+0x0/0x1e returned 0 after 0 usecs
[    2.997614] calling  mipi_dsi_bus_init+0x0/0x17 @ 1
[    3.001622] initcall mipi_dsi_bus_init+0x0/0x17 returned 0 after 0 usecs
[    3.005614] calling  software_node_init+0x0/0x30 @ 1
[    3.009621] initcall software_node_init+0x0/0x30 returned 0 after 0 usec=
s
[    3.013614] calling  wakeup_sources_debugfs_init+0x0/0x29 @ 1
[    3.017620] initcall wakeup_sources_debugfs_init+0x0/0x29 returned 0 aft=
er 0 usecs
[    3.021614] calling  wakeup_sources_sysfs_init+0x0/0x35 @ 1
[    3.025620] initcall wakeup_sources_sysfs_init+0x0/0x35 returned 0 after=
 0 usecs
[    3.029614] calling  isa_bus_init+0x0/0x3e @ 1
[    3.033631] initcall isa_bus_init+0x0/0x3e returned 0 after 0 usecs
[    3.037614] calling  register_node_type+0x0/0x34 @ 1
[    3.041632] initcall register_node_type+0x0/0x34 returned 0 after 0 usec=
s
[    3.045614] calling  regmap_initcall+0x0/0x12 @ 1
[    3.049620] initcall regmap_initcall+0x0/0x12 returned 0 after 0 usecs
[    3.053614] calling  sram_init+0x0/0x19 @ 1
[    3.057623] initcall sram_init+0x0/0x19 returned 0 after 0 usecs
[    3.061614] calling  syscon_init+0x0/0x19 @ 1
[    3.065621] initcall syscon_init+0x0/0x19 returned 0 after 0 usecs
[    3.069613] calling  spi_init+0x0/0xc5 @ 1
[    3.073625] initcall spi_init+0x0/0xc5 returned 0 after 0 usecs
[    3.077614] calling  i2c_init+0x0/0xb9 @ 1
[    3.081627] initcall i2c_init+0x0/0xb9 returned 0 after 0 usecs
[    3.085614] calling  eisa_init+0x0/0x2d @ 1
[    3.089621] EISA bus registered
[    3.092791] initcall eisa_init+0x0/0x2d returned 0 after 0 usecs
[    3.093614] calling  init_ladder+0x0/0x2a @ 1
[    3.097625] cpuidle: using governor ladder
[    3.101614] initcall init_ladder+0x0/0x2a returned 0 after 3906 usecs
[    3.105615] calling  init_menu+0x0/0x17 @ 1
[    3.109619] cpuidle: using governor menu
[    3.113571] initcall init_menu+0x0/0x17 returned 0 after 0 usecs
[    3.113614] calling  teo_governor_init+0x0/0x17 @ 1
[    3.117618] initcall teo_governor_init+0x0/0x17 returned 0 after 0 usecs
[    3.121613] calling  pcc_init+0x0/0x9f @ 1
[    3.125616] initcall pcc_init+0x0/0x9f returned -19 after 0 usecs
[    3.129614] calling  amd_postcore_init+0x0/0x11c @ 1
[    3.133613] initcall amd_postcore_init+0x0/0x11c returned 0 after 0 usec=
s
[    3.137799] calling  bts_init+0x0/0xc2 @ 1
[    3.141619] initcall bts_init+0x0/0xc2 returned 0 after 0 usecs
[    3.145614] calling  pt_init+0x0/0x346 @ 1
[    3.149622] initcall pt_init+0x0/0x346 returned 0 after 0 usecs
[    3.153614] calling  boot_params_ksysfs_init+0x0/0x2a3 @ 1
[    3.157620] initcall boot_params_ksysfs_init+0x0/0x2a3 returned 0 after =
0 usecs
[    3.161613] calling  sbf_init+0x0/0xd2 @ 1
[    3.165615] initcall sbf_init+0x0/0xd2 returned 0 after 0 usecs
[    3.169614] calling  arch_kdebugfs_init+0x0/0x22 @ 1
[    3.173619] initcall arch_kdebugfs_init+0x0/0x22 returned 0 after 0 usec=
s
[    3.177614] calling  intel_pconfig_init+0x0/0x88 @ 1
[    3.181615] initcall intel_pconfig_init+0x0/0x88 returned 0 after 0 usec=
s
[    3.185614] calling  mtrr_if_init+0x0/0x64 @ 1
[    3.189618] initcall mtrr_if_init+0x0/0x64 returned 0 after 0 usecs
[    3.193615] calling  activate_jump_labels+0x0/0x3a @ 1
[    3.197615] initcall activate_jump_labels+0x0/0x3a returned 0 after 0 us=
ecs
[    3.201615] calling  ffh_cstate_init+0x0/0x30 @ 1
[    3.205618] initcall ffh_cstate_init+0x0/0x30 returned 0 after 0 usecs
[    3.209615] calling  activate_jump_labels+0x0/0x3a @ 1
[    3.213615] initcall activate_jump_labels+0x0/0x3a returned 0 after 0 us=
ecs
[    3.217614] calling  kvm_alloc_cpumask+0x0/0xa2 @ 1
[    3.221614] initcall kvm_alloc_cpumask+0x0/0xa2 returned 0 after 0 usecs
[    3.225615] calling  gigantic_pages_init+0x0/0x28 @ 1
[    3.229617] initcall gigantic_pages_init+0x0/0x28 returned 0 after 0 use=
cs
[    3.233614] calling  kcmp_cookies_init+0x0/0x3d @ 1
[    3.237616] initcall kcmp_cookies_init+0x0/0x3d returned 0 after 0 usecs
[    3.241614] calling  cryptomgr_init+0x0/0x17 @ 1
[    3.245617] initcall cryptomgr_init+0x0/0x17 returned 0 after 0 usecs
[    3.249614] calling  acpi_pci_init+0x0/0x67 @ 1
[    3.253614] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    3.257616] ACPI: bus type PCI registered
[    3.261613] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.265615] initcall acpi_pci_init+0x0/0x67 returned 0 after 11718 usecs
[    3.269614] calling  dma_channel_table_init+0x0/0xe1 @ 1
[    3.273622] initcall dma_channel_table_init+0x0/0xe1 returned 0 after 0 =
usecs
[    3.277613] calling  dma_bus_init+0x0/0x117 @ 1
[    3.281649] initcall dma_bus_init+0x0/0x117 returned 0 after 0 usecs
[    3.285616] calling  iommu_dma_init+0x0/0x10 @ 1
[    3.289619] initcall iommu_dma_init+0x0/0x10 returned 0 after 0 usecs
[    3.293614] calling  dmi_id_init+0x0/0x382 @ 1
[    3.297648] initcall dmi_id_init+0x0/0x382 returned 0 after 0 usecs
[    3.301614] calling  numachip_timer_init+0x0/0x5a @ 1
[    3.305615] initcall numachip_timer_init+0x0/0x5a returned -19 after 0 u=
secs
[    3.309613] calling  ts_dmi_init+0x0/0x67 @ 1
[    3.313617] initcall ts_dmi_init+0x0/0x67 returned 0 after 0 usecs
[    3.317615] calling  pci_arch_init+0x0/0x6b @ 1
[    3.321639] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    3.325615] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E82=
0
[    3.329633] PCI: Using configuration type 1 for base access
[    3.333617] initcall pci_arch_init+0x0/0x6b returned 0 after 11718 usecs
[    3.337795] calling  init_vdso+0x0/0x25 @ 1
[    3.341622] initcall init_vdso+0x0/0x25 returned 0 after 0 usecs
[    3.345614] calling  fixup_ht_bug+0x0/0xb9 @ 1
[    3.349614] initcall fixup_ht_bug+0x0/0xb9 returned 0 after 0 usecs
[    3.353614] calling  topology_init+0x0/0xce @ 1
[    3.357926] initcall topology_init+0x0/0xce returned 0 after 0 usecs
[    3.361614] calling  intel_epb_init+0x0/0x6e @ 1
[    3.365622] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    3.369627] initcall intel_epb_init+0x0/0x6e returned 0 after 3906 usecs
[    3.373616] calling  mtrr_init_finialize+0x0/0x47 @ 1
[    3.377614] initcall mtrr_init_finialize+0x0/0x47 returned 0 after 0 use=
cs
[    3.381615] calling  eisa_bus_probe+0x0/0x3d @ 1
[    3.385621] initcall eisa_bus_probe+0x0/0x3d returned 0 after 0 usecs
[    3.389613] calling  uid_cache_init+0x0/0x9f @ 1
[    3.393620] initcall uid_cache_init+0x0/0x9f returned 0 after 0 usecs
[    3.397614] calling  param_sysfs_init+0x0/0x1ef @ 1
[    3.401719]  radix_tree_node_free node =3D 0xffff9d78dbc57908
[    3.405612] ----------call_rcu 1---------
[    3.409677]  radix_tree_node_free node =3D 0xffff9d78dbc57d98
[    3.413614] ----------call_rcu 1---------
[    3.417672]  radix_tree_node_free node =3D 0xffff9d78dbc56910
[    3.421613] ----------call_rcu 1---------
[    3.425685]  radix_tree_node_free node =3D 0xffff9d78dbc6cdb0
[    3.429613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc57908
[    3.433615] ----------call_rcu 1---------
[    3.437636]  radix_tree_node_free node =3D 0xffff9d78dbc6fb50
[    3.441613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc57d98
[    3.441614]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc56910
[    3.449612] ----------call_rcu 1---------
[    3.453628]  radix_tree_node_free node =3D 0xffff9d78dbc6cff8
[    3.457613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cdb0
[    3.461614] ----------call_rcu 1---------
[    3.465628]  radix_tree_node_free node =3D 0xffff9d78dbc6cdb0
[    3.469613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6fb50
[    3.473614] ----------call_rcu 1---------
[    3.477629]  radix_tree_node_free node =3D 0xffff9d78dbc6fb50
[    3.481612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cff8
[    3.485614] ----------call_rcu 1---------
[    3.489629]  radix_tree_node_free node =3D 0xffff9d78dbc6f908
[    3.493612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cdb0
[    3.497614] ----------call_rcu 1---------
[    3.501618]  radix_tree_node_free node =3D 0xffff9d78dbc6cff8
[    3.505612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6fb50
[    3.509614] ----------call_rcu 1---------
[    3.513630]  radix_tree_node_free node =3D 0xffff9d78dbc6fb50
[    3.517612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f908
[    3.521614] ----------call_rcu 1---------
[    3.525631]  radix_tree_node_free node =3D 0xffff9d78dbc6f908
[    3.529612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cff8
[    3.533614] ----------call_rcu 1---------
[    3.537631]  radix_tree_node_free node =3D 0xffff9d78dbc6cff8
[    3.541612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6fb50
[    3.545614] ----------call_rcu 1---------
[    3.549631]  radix_tree_node_free node =3D 0xffff9d78dbc6cdb0
[    3.553612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f908
[    3.557614] ----------call_rcu 1---------
[    3.561618]  radix_tree_node_free node =3D 0xffff9d78dbc6fb50
[    3.565613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cff8
[    3.569614] ----------call_rcu 1---------
[    3.573632]  radix_tree_node_free node =3D 0xffff9d78dbc6cff8
[    3.577612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cdb0
[    3.581614] ----------call_rcu 1---------
[    3.585632]  radix_tree_node_free node =3D 0xffff9d78dbc6cdb0
[    3.589612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6fb50
[    3.593614] ----------call_rcu 1---------
[    3.597674]  radix_tree_node_free node =3D 0xffff9d78dbc6c000
[    3.601613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cff8
[    3.605614] ----------call_rcu 1---------
[    3.609676]  radix_tree_node_free node =3D 0xffff9d78dbc6e910
[    3.613612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cdb0
[    3.617614] ----------call_rcu 1---------
[    3.621623]  radix_tree_node_free node =3D 0xffff9d78dbc6cdb0
[    3.625612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c000
[    3.629614] ----------call_rcu 1---------
[    3.633623]  radix_tree_node_free node =3D 0xffff9d78dbc6c000
[    3.637612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e910
[    3.641614] ----------call_rcu 1---------
[    3.645624]  radix_tree_node_free node =3D 0xffff9d78dbc6e910
[    3.649612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cdb0
[    3.653614] ----------call_rcu 1---------
[    3.657624]  radix_tree_node_free node =3D 0xffff9d78dbc6cdb0
[    3.661613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c000
[    3.665614] ----------call_rcu 1---------
[    3.669625]  radix_tree_node_free node =3D 0xffff9d78dbc6c000
[    3.673612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e910
[    3.677614] ----------call_rcu 1---------
[    3.681626]  radix_tree_node_free node =3D 0xffff9d78dbc6e910
[    3.685612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cdb0
[    3.689614] ----------call_rcu 1---------
[    3.693626]  radix_tree_node_free node =3D 0xffff9d78dbc6cdb0
[    3.697612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c000
[    3.701614] ----------call_rcu 1---------
[    3.705627]  radix_tree_node_free node =3D 0xffff9d78dbc6c000
[    3.709612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e910
[    3.713614] ----------call_rcu 1---------
[    3.717627]  radix_tree_node_free node =3D 0xffff9d78dbc6dda8
[    3.721612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cdb0
[    3.725614] ----------call_rcu 1---------
[    3.729618]  radix_tree_node_free node =3D 0xffff9d78dbc6e910
[    3.733612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c000
[    3.737614] ----------call_rcu 1---------
[    3.741722]  radix_tree_node_free node =3D 0xffff9d78dbc6d6d0
[    3.745614]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6dda8
[    3.749614] ----------call_rcu 1---------
[    3.753630]  radix_tree_node_free node =3D 0xffff9d78dbc6dda8
[    3.757613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e910
[    3.761614] ----------call_rcu 1---------
[    3.765627]  radix_tree_node_free node =3D 0xffff9d78dbc6e910
[    3.769612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6d6d0
[    3.773614] ----------call_rcu 1---------
[    3.777719]  radix_tree_node_free node =3D 0xffff9d78dbc6eb58
[    3.781613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6dda8
[    3.785614] ----------call_rcu 1---------
[    3.789623]  radix_tree_node_free node =3D 0xffff9d78dbc6dda8
[    3.793612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e910
[    3.797614] ----------call_rcu 1---------
[    3.801623]  radix_tree_node_free node =3D 0xffff9d78dbc6e910
[    3.805612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6eb58
[    3.809614] ----------call_rcu 1---------
[    3.813624]  radix_tree_node_free node =3D 0xffff9d78dbc6eb58
[    3.817612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6dda8
[    3.821614] ----------call_rcu 1---------
[    3.825624]  radix_tree_node_free node =3D 0xffff9d78dbc6dda8
[    3.829612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e910
[    3.833614] ----------call_rcu 1---------
[    3.837625]  radix_tree_node_free node =3D 0xffff9d78dbc6e910
[    3.841612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6eb58
[    3.845614] ----------call_rcu 1---------
[    3.849626]  radix_tree_node_free node =3D 0xffff9d78dbc6eb58
[    3.853613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6dda8
[    3.857614] ----------call_rcu 1---------
[    3.861626]  radix_tree_node_free node =3D 0xffff9d78dbc6dda8
[    3.865612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e910
[    3.869614] ----------call_rcu 1---------
[    3.873626]  radix_tree_node_free node =3D 0xffff9d78dbc6e910
[    3.877612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6eb58
[    3.881614] ----------call_rcu 1---------
[    3.885627]  radix_tree_node_free node =3D 0xffff9d78dbc6e238
[    3.889613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6dda8
[    3.893614] ----------call_rcu 1---------
[    3.897618]  radix_tree_node_free node =3D 0xffff9d78dbc6eb58
[    3.901612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e910
[    3.905614] ----------call_rcu 1---------
[    3.909628]  radix_tree_node_free node =3D 0xffff9d78dbc6e910
[    3.913612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e238
[    3.917614] ----------call_rcu 1---------
[    3.921629]  radix_tree_node_free node =3D 0xffff9d78dbc6e238
[    3.925612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6eb58
[    3.929614] ----------call_rcu 1---------
[    3.933629]  radix_tree_node_free node =3D 0xffff9d78dbc6eb58
[    3.937612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e910
[    3.941614] ----------call_rcu 1---------
[    3.945630]  radix_tree_node_free node =3D 0xffff9d78dbc6dda8
[    3.949613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e238
[    3.953614] ----------call_rcu 1---------
[    3.957618]  radix_tree_node_free node =3D 0xffff9d78dbc6e910
[    3.961612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6eb58
[    3.965614] ----------call_rcu 1---------
[    3.969631]  radix_tree_node_free node =3D 0xffff9d78dbc6eb58
[    3.973612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6dda8
[    3.977614] ----------call_rcu 1---------
[    3.981631]  radix_tree_node_free node =3D 0xffff9d78dbc6dda8
[    3.985613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e910
[    3.989614] ----------call_rcu 1---------
[    3.993700]  radix_tree_node_free node =3D 0xffff9d78dbc6efe8
[    3.997613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6eb58
[    4.001614] ----------call_rcu 1---------
[    4.005624]  radix_tree_node_free node =3D 0xffff9d78dbc6eb58
[    4.009612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6dda8
[    4.013614] ----------call_rcu 1---------
[    4.017663]  radix_tree_node_free node =3D 0xffff9d78dbc6cb68
[    4.021613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6efe8
[    4.025614] ----------call_rcu 1---------
[    4.029739]  radix_tree_node_free node =3D 0xffff9d78dbc6d918
[    4.033613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6eb58
[    4.037614] ----------call_rcu 1---------
[    4.041625]  radix_tree_node_free node =3D 0xffff9d78dbc6eb58
[    4.045613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cb68
[    4.049614] ----------call_rcu 1---------
[    4.053625]  radix_tree_node_free node =3D 0xffff9d78dbc6cb68
[    4.057612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6d918
[    4.061614] ----------call_rcu 1---------
[    4.065625]  radix_tree_node_free node =3D 0xffff9d78dbc6d918
[    4.069612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6eb58
[    4.073614] ----------call_rcu 1---------
[    4.077626]  radix_tree_node_free node =3D 0xffff9d78dbc6eb58
[    4.081613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cb68
[    4.085614] ----------call_rcu 1---------
[    4.089626]  radix_tree_node_free node =3D 0xffff9d78dbc6cb68
[    4.093612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6d918
[    4.097614] ----------call_rcu 1---------
[    4.101693]  radix_tree_node_free node =3D 0xffff9d78dbc6db60
[    4.105612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6eb58
[    4.109614] ----------call_rcu 1---------
[    4.113627]  radix_tree_node_free node =3D 0xffff9d78dbc6eb58
[    4.117613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cb68
[    4.121614] ----------call_rcu 1---------
[    4.125627]  radix_tree_node_free node =3D 0xffff9d78dbc6cb68
[    4.129612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6db60
[    4.133614] ----------call_rcu 1---------
[    4.137719]  radix_tree_node_free node =3D 0xffff9d78dbc6e6c8
[    4.141613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6eb58
[    4.145614] ----------call_rcu 1---------
[    4.149625]  radix_tree_node_free node =3D 0xffff9d78dbc6eb58
[    4.153612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cb68
[    4.157614] ----------call_rcu 1---------
[    4.161625]  radix_tree_node_free node =3D 0xffff9d78dbc6cb68
[    4.165612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e6c8
[    4.169614] ----------call_rcu 1---------
[    4.173626]  radix_tree_node_free node =3D 0xffff9d78dbc6e6c8
[    4.177613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6eb58
[    4.181614] ----------call_rcu 1---------
[    4.185657]  radix_tree_node_free node =3D 0xffff9d78dbc6c920
[    4.189612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6cb68
[    4.193614] ----------call_rcu 1---------
[    4.197688]  radix_tree_node_free node =3D 0xffff9d78dbc6f6c0
[    4.201613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e6c8
[    4.205614] ----------call_rcu 1---------
[    4.209626]  radix_tree_node_free node =3D 0xffff9d78dbc6e6c8
[    4.213612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c920
[    4.217614] ----------call_rcu 1---------
[    4.221666]  radix_tree_node_free node =3D 0xffff9d78dbc6f478
[    4.225612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f6c0
[    4.229614] ----------call_rcu 1---------
[    4.233626]  radix_tree_node_free node =3D 0xffff9d78dbc6f6c0
[    4.237613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e6c8
[    4.241614] ----------call_rcu 1---------
[    4.245627]  radix_tree_node_free node =3D 0xffff9d78dbc6e6c8
[    4.249612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f478
[    4.253614] ----------call_rcu 1---------
[    4.257643] initcall param_sysfs_init+0x0/0x1ef returned 0 after 835937 =
usecs
[    4.261612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f6c0
[    4.265616] calling  user_namespace_sysctl_init+0x0/0x39 @ 1
[    4.269629] initcall user_namespace_sysctl_init+0x0/0x39 returned 0 afte=
r 0 usecs
[    4.273613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6e6c8
[    4.277616] calling  proc_schedstat_init+0x0/0x2a @ 1
[    4.281620] initcall proc_schedstat_init+0x0/0x2a returned 0 after 0 use=
cs
[    4.285614] calling  pm_sysrq_init+0x0/0x1e @ 1
[    4.289622] initcall pm_sysrq_init+0x0/0x1e returned 0 after 0 usecs
[    4.293615] calling  create_proc_profile+0x0/0xe0 @ 1
[    4.297615] initcall create_proc_profile+0x0/0xe0 returned 0 after 0 use=
cs
[    4.301614] calling  time_ns_init+0x0/0xd @ 1
[    4.305614] initcall time_ns_init+0x0/0xd returned 0 after 0 usecs
[    4.309614] calling  crash_save_vmcoreinfo_init+0x0/0x602 @ 1
[    4.313642] initcall crash_save_vmcoreinfo_init+0x0/0x602 returned 0 aft=
er 0 usecs
[    4.317614] calling  crash_notes_memory_init+0x0/0x3b @ 1
[    4.321620] initcall crash_notes_memory_init+0x0/0x3b returned 0 after 0=
 usecs
[    4.325614] calling  cgroup_sysfs_init+0x0/0x1e @ 1
[    4.329620] initcall cgroup_sysfs_init+0x0/0x1e returned 0 after 0 usecs
[    4.333614] calling  cgroup_namespaces_init+0x0/0xd @ 1
[    4.337616] initcall cgroup_namespaces_init+0x0/0xd returned 0 after 0 u=
secs
[    4.341614] calling  user_namespaces_init+0x0/0x32 @ 1
[    4.345623] initcall user_namespaces_init+0x0/0x32 returned 0 after 0 us=
ecs
[    4.349613] calling  init_kprobes+0x0/0x19a @ 1
[    4.353877] initcall init_kprobes+0x0/0x19a returned 0 after 0 usecs
[    4.357613] calling  hung_task_init+0x0/0x60 @ 1
[    4.361639] initcall hung_task_init+0x0/0x60 returned 0 after 0 usecs
[    4.365614] calling  send_signal_irq_work_init+0x0/0x50 @ 1
[    4.369615] initcall send_signal_irq_work_init+0x0/0x50 returned 0 after=
 0 usecs
[    4.373614] calling  init_kprobe_trace_early+0x0/0x2b @ 1
[    4.377619] initcall init_kprobe_trace_early+0x0/0x2b returned 0 after 0=
 usecs
[    4.381614] calling  dev_map_init+0x0/0x52 @ 1
[    4.385618] initcall dev_map_init+0x0/0x52 returned 0 after 0 usecs
[    4.389613] calling  cpu_map_init+0x0/0x46 @ 1
[    4.393615] initcall cpu_map_init+0x0/0x46 returned 0 after 0 usecs
[    4.397614] calling  netns_bpf_init+0x0/0x17 @ 1
[    4.401617] initcall netns_bpf_init+0x0/0x17 returned 0 after 0 usecs
[    4.405613] calling  stack_map_init+0x0/0x55 @ 1
[    4.409615] initcall stack_map_init+0x0/0x55 returned 0 after 0 usecs
[    4.413614] calling  oom_init+0x0/0x35 @ 1
[    4.417631] initcall oom_init+0x0/0x35 returned 0 after 0 usecs
[    4.421614] calling  default_bdi_init+0x0/0xae @ 1
[    4.425670] initcall default_bdi_init+0x0/0xae returned 0 after 0 usecs
[    4.429615] calling  cgwb_init+0x0/0x2e @ 1
[    4.433632] initcall cgwb_init+0x0/0x2e returned 0 after 0 usecs
[    4.437614] calling  percpu_enable_async+0x0/0x14 @ 1
[    4.441615] initcall percpu_enable_async+0x0/0x14 returned 0 after 0 use=
cs
[    4.445614] calling  kcompactd_init+0x0/0xa0 @ 1
[    4.449639] initcall kcompactd_init+0x0/0xa0 returned 0 after 0 usecs
[    4.453616] calling  init_user_reserve+0x0/0x40 @ 1
[    4.457615] initcall init_user_reserve+0x0/0x40 returned 0 after 0 usecs
[    4.461614] calling  init_admin_reserve+0x0/0x40 @ 1
[    4.465614] initcall init_admin_reserve+0x0/0x40 returned 0 after 0 usec=
s
[    4.469615] calling  init_reserve_notifier+0x0/0x24 @ 1
[    4.473619] initcall init_reserve_notifier+0x0/0x24 returned 0 after 0 u=
secs
[    4.477615] calling  swap_init_sysfs+0x0/0x6a @ 1
[    4.481621] initcall swap_init_sysfs+0x0/0x6a returned 0 after 0 usecs
[    4.485614] calling  swapfile_init+0x0/0xa1 @ 1
[    4.489618] initcall swapfile_init+0x0/0xa1 returned 0 after 0 usecs
[    4.493614] calling  hugetlb_init+0x0/0x4d2 @ 1
[    4.497621] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    4.501613] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    4.505640] initcall hugetlb_init+0x0/0x4d2 returned 0 after 7812 usecs
[    4.509614] calling  ksm_init+0x0/0x19f @ 1
[    4.513646] initcall ksm_init+0x0/0x19f returned 0 after 0 usecs
[    4.517614] calling  hugepage_init+0x0/0x15d @ 1
[    4.521652] initcall hugepage_init+0x0/0x15d returned 0 after 0 usecs
[    4.525614] calling  mem_cgroup_init+0x0/0x156 @ 1
[    4.529630] initcall mem_cgroup_init+0x0/0x156 returned 0 after 0 usecs
[    4.533614] calling  page_idle_init+0x0/0x34 @ 1
[    4.537619] initcall page_idle_init+0x0/0x34 returned 0 after 0 usecs
[    4.541614] calling  sel_ib_pkey_init+0x0/0x43 @ 1
[    4.545616] initcall sel_ib_pkey_init+0x0/0x43 returned 0 after 0 usecs
[    4.549613] calling  seqiv_module_init+0x0/0x17 @ 1
[    4.553616] initcall seqiv_module_init+0x0/0x17 returned 0 after 0 usecs
[    4.557617] calling  dh_init+0x0/0x20 @ 1
[    4.561638] initcall dh_init+0x0/0x20 returned 0 after 0 usecs
[    4.565614] calling  rsa_init+0x0/0x50 @ 1
[    4.569627] free_pid pid =3D 0xffff9d78dc327380
[    4.573611] ----------call_rcu 1---------
[    4.573616] ----------call_rcu 1---------
[    4.577640] initcall rsa_init+0x0/0x50 returned 0 after 7812 usecs
[    4.581614] calling  hmac_module_init+0x0/0x17 @ 1
[    4.585624] free_pid pid =3D 0xffff9d78dc327a00
[    4.589611] ----------call_rcu 1---------
[    4.589613] delayed_put_pid pid =3D 0xffff9d78dc327380
[    4.593615] ----------call_rcu 1---------
[    4.597623] initcall hmac_module_init+0x0/0x17 returned 0 after 11718 us=
ecs
[    4.601614] ----------call_rcu 1---------
[    4.605615] calling  crypto_null_mod_init+0x0/0x6b @ 1
[    4.609654] free_pid pid =3D 0xffff9d78dc327380
[    4.613611] ----------call_rcu 1---------
[    4.613613] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    4.617612] ----------call_rcu 1---------
[    4.621615] ----------call_rcu 1---------
[    4.625639] free_pid pid =3D 0xffff9d78dc327680
[    4.629611] ----------call_rcu 1---------
[    4.629615] ----------call_rcu 1---------
[    4.633638] free_pid pid =3D 0xffff9d78dc327a00
[    4.637611] ----------call_rcu 1---------
[    4.637613] delayed_put_pid pid =3D 0xffff9d78dc327380
[    4.641613] ----------call_rcu 1---------
[    4.645615] ----------call_rcu 1---------
[    4.649628] initcall crypto_null_mod_init+0x0/0x6b returned 0 after 3906=
2 usecs
[    4.653613] delayed_put_pid pid =3D 0xffff9d78dc327680
[    4.653613] ----------call_rcu 1---------
[    4.661613] calling  md5_mod_init+0x0/0x17 @ 1
[    4.665621] free_pid pid =3D 0xffff9d78dc327b80
[    4.669611] ----------call_rcu 1---------
[    4.669613] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    4.673612] ----------call_rcu 1---------
[    4.677615] ----------call_rcu 1---------
[    4.681636] initcall md5_mod_init+0x0/0x17 returned 0 after 15625 usecs
[    4.685614] calling  sha1_generic_mod_init+0x0/0x17 @ 1
[    4.689623] free_pid pid =3D 0xffff9d78dc327a00
[    4.693611] ----------call_rcu 1---------
[    4.693613] delayed_put_pid pid =3D 0xffff9d78dc327b80
[    4.697613] ----------call_rcu 1---------
[    4.701615] ----------call_rcu 1---------
[    4.705636] initcall sha1_generic_mod_init+0x0/0x17 returned 0 after 156=
25 usecs
[    4.709614] calling  sha256_generic_mod_init+0x0/0x1c @ 1
[    4.713622] free_pid pid =3D 0xffff9d78dc327b80
[    4.717611] ----------call_rcu 1---------
[    4.717613] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    4.721613] ----------call_rcu 1---------
[    4.725615] ----------call_rcu 1---------
[    4.729646] free_pid pid =3D 0xffff9d78dc327a00
[    4.733611] ----------call_rcu 1---------
[    4.733614] ----------call_rcu 1---------
[    4.737627] initcall sha256_generic_mod_init+0x0/0x1c returned 0 after 2=
3437 usecs
[    4.741613] delayed_put_pid pid =3D 0xffff9d78dc327b80
[    4.741614] ----------call_rcu 1---------
[    4.749613] calling  sha512_generic_mod_init+0x0/0x1c @ 1
[    4.753621] free_pid pid =3D 0xffff9d78dc327680
[    4.757611] ----------call_rcu 1---------
[    4.757613] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    4.761612] ----------call_rcu 1---------
[    4.765615] ----------call_rcu 1---------
[    4.769646] free_pid pid =3D 0xffff9d78dc327a00
[    4.773611] ----------call_rcu 1---------
[    4.773614] ----------call_rcu 1---------
[    4.777626] initcall sha512_generic_mod_init+0x0/0x1c returned 0 after 2=
3437 usecs
[    4.781613] delayed_put_pid pid =3D 0xffff9d78dc327680
[    4.781614] ----------call_rcu 1---------
[    4.789614] calling  crypto_ecb_module_init+0x0/0x17 @ 1
[    4.793621] free_pid pid =3D 0xffff9d78dc327b80
[    4.797611] ----------call_rcu 1---------
[    4.797613] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    4.801612] ----------call_rcu 1---------
[    4.805615] ----------call_rcu 1---------
[    4.809622] initcall crypto_ecb_module_init+0x0/0x17 returned 0 after 15=
625 usecs
[    4.813614] calling  crypto_cbc_module_init+0x0/0x17 @ 1
[    4.817620] initcall crypto_cbc_module_init+0x0/0x17 returned 0 after 0 =
usecs
[    4.821613] delayed_put_pid pid =3D 0xffff9d78dc327b80
[    4.821613] ----------call_rcu 1---------
[    4.829613] calling  crypto_cts_module_init+0x0/0x17 @ 1
[    4.833619] initcall crypto_cts_module_init+0x0/0x17 returned 0 after 0 =
usecs
[    4.837613] calling  crypto_module_init+0x0/0x17 @ 1
[    4.841620] initcall crypto_module_init+0x0/0x17 returned 0 after 0 usec=
s
[    4.845614] calling  crypto_ctr_module_init+0x0/0x1c @ 1
[    4.849620] initcall crypto_ctr_module_init+0x0/0x1c returned 0 after 0 =
usecs
[    4.853613] calling  crypto_gcm_module_init+0x0/0x6a @ 1
[    4.857618] initcall crypto_gcm_module_init+0x0/0x6a returned 0 after 0 =
usecs
[    4.861613] calling  aes_init+0x0/0x17 @ 1
[    4.865633] initcall aes_init+0x0/0x17 returned 0 after 0 usecs
[    4.869614] calling  deflate_mod_init+0x0/0x43 @ 1
[    4.873620]  radix_tree_node_free node =3D 0xffff9d78dbc6c6d8
[    4.877611] ----------call_rcu 1---------
[    4.877611]  radix_tree_node_free node =3D 0xffff9d78dbc6f6c0
[    4.877611] ----------call_rcu 1---------
[    4.877611] free_pid pid =3D 0xffff9d78dc327b80
[    4.877611] ----------call_rcu 1---------
[    4.877615] ----------call_rcu 1---------
[    4.881644] free_pid pid =3D 0xffff9d78dc327a00
[    4.885611] ----------call_rcu 1---------
[    4.885614] ----------call_rcu 1---------
[    4.889636] free_pid pid =3D 0xffff9d78dc327680
[    4.893611] ----------call_rcu 1---------
[    4.893613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c6d8
[    4.897612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f6c0
[    4.901612] delayed_put_pid pid =3D 0xffff9d78dc327b80
[    4.905614] ----------call_rcu 1---------
[    4.909629] initcall deflate_mod_init+0x0/0x43 returned 0 after 35156 us=
ecs
[    4.913613] ----------call_rcu 1---------
[    4.913614] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    4.913615] ----------call_rcu 1---------
[    4.925613] calling  crc32c_mod_init+0x0/0x17 @ 1
[    4.929621]  radix_tree_node_free node =3D 0xffff9d78dbc6f230
[    4.933611] ----------call_rcu 1---------
[    4.933611]  radix_tree_node_free node =3D 0xffff9d78dbc6c490
[    4.933611] ----------call_rcu 1---------
[    4.933611] free_pid pid =3D 0xffff9d78dc327380
[    4.933611] ----------call_rcu 1---------
[    4.933613] delayed_put_pid pid =3D 0xffff9d78dc327680
[    4.937612] ----------call_rcu 1---------
[    4.941615] ----------call_rcu 1---------
[    4.945637] initcall crc32c_mod_init+0x0/0x17 returned 0 after 15625 use=
cs
[    4.949614] calling  crct10dif_mod_init+0x0/0x17 @ 1
[    4.953623]  radix_tree_node_free node =3D 0xffff9d78dbc6c6d8
[    4.957611] ----------call_rcu 1---------
[    4.957611]  radix_tree_node_free node =3D 0xffff9d78dbc6f6c0
[    4.957611] ----------call_rcu 1---------
[    4.957611] free_pid pid =3D 0xffff9d78dc327680
[    4.957611] ----------call_rcu 1---------
[    4.957613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f230
[    4.961612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c490
[    4.965612] delayed_put_pid pid =3D 0xffff9d78dc327380
[    4.969613] ----------call_rcu 1---------
[    4.973615] ----------call_rcu 1---------
[    4.977638] initcall crct10dif_mod_init+0x0/0x17 returned 0 after 23437 =
usecs
[    4.981614] calling  lzo_mod_init+0x0/0x3e @ 1
[    4.985623]  radix_tree_node_free node =3D 0xffff9d78dbc6f230
[    4.989611] ----------call_rcu 1---------
[    4.989611]  radix_tree_node_free node =3D 0xffff9d78dbc6c490
[    4.989611] ----------call_rcu 1---------
[    4.989611] free_pid pid =3D 0xffff9d78dc327380
[    4.989611] ----------call_rcu 1---------
[    4.989612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c6d8
[    4.993612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f6c0
[    4.997612] delayed_put_pid pid =3D 0xffff9d78dc327680
[    5.001613] ----------call_rcu 1---------
[    5.005615] ----------call_rcu 1---------
[    5.009647] free_pid pid =3D 0xffff9d78dc327680
[    5.013611] ----------call_rcu 1---------
[    5.013614] ----------call_rcu 1---------
[    5.017627] initcall lzo_mod_init+0x0/0x3e returned 0 after 31250 usecs
[    5.021613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f230
[    5.021613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c490
[    5.021614] delayed_put_pid pid =3D 0xffff9d78dc327380
[    5.021615] ----------call_rcu 1---------
[    5.037613] calling  lzorle_mod_init+0x0/0x3e @ 1
[    5.041621]  radix_tree_node_free node =3D 0xffff9d78dbc6c6d8
[    5.045611] ----------call_rcu 1---------
[    5.045611]  radix_tree_node_free node =3D 0xffff9d78dbc6f6c0
[    5.045611] ----------call_rcu 1---------
[    5.045611] free_pid pid =3D 0xffff9d78dc327a00
[    5.045611] ----------call_rcu 1---------
[    5.045613] delayed_put_pid pid =3D 0xffff9d78dc327680
[    5.049612] ----------call_rcu 1---------
[    5.053615] ----------call_rcu 1---------
[    5.057647] free_pid pid =3D 0xffff9d78dc327680
[    5.061611] ----------call_rcu 1---------
[    5.061614] ----------call_rcu 1---------
[    5.065627] initcall lzorle_mod_init+0x0/0x3e returned 0 after 23437 use=
cs
[    5.069613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c6d8
[    5.069613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f6c0
[    5.069614] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    5.069615] ----------call_rcu 1---------
[    5.085613] calling  drbg_init+0x0/0x8d @ 1
[    5.089623]  radix_tree_node_free node =3D 0xffff9d78dbc6f230
[    5.093611] ----------call_rcu 1---------
[    5.093611]  radix_tree_node_free node =3D 0xffff9d78dbc6c490
[    5.093611] ----------call_rcu 1---------
[    5.093611] free_pid pid =3D 0xffff9d78dc327380
[    5.093611] ----------call_rcu 1---------
[    5.093613] delayed_put_pid pid =3D 0xffff9d78dc327680
[    5.097612] ----------call_rcu 1---------
[    5.101615] ----------call_rcu 1---------
[    5.105647] free_pid pid =3D 0xffff9d78dc327680
[    5.109611] ----------call_rcu 1---------
[    5.109614] ----------call_rcu 1---------
[    5.113636] free_pid pid =3D 0xffff9d78dc327a00
[    5.117611] ----------call_rcu 1---------
[    5.117613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f230
[    5.121612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c490
[    5.125612] delayed_put_pid pid =3D 0xffff9d78dc327380
[    5.129613] ----------call_rcu 1---------
[    5.133615] ----------call_rcu 1---------
[    5.137639] free_pid pid =3D 0xffff9d78dc327b80
[    5.141611] ----------call_rcu 1---------
[    5.141613] delayed_put_pid pid =3D 0xffff9d78dc327680
[    5.145612] ----------call_rcu 1---------
[    5.149614] ----------call_rcu 1---------
[    5.153638] free_pid pid =3D 0xffff9d78dc327380
[    5.157611] ----------call_rcu 1---------
[    5.157613] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    5.161613] ----------call_rcu 1---------
[    5.165615] ----------call_rcu 1---------
[    5.169638] free_pid pid =3D 0xffff9d78dc327680
[    5.173611] ----------call_rcu 1---------
[    5.173613] delayed_put_pid pid =3D 0xffff9d78dc327b80
[    5.177613] ----------call_rcu 1---------
[    5.181615] ----------call_rcu 1---------
[    5.185637] free_pid pid =3D 0xffff9d78dc327a00
[    5.189611] ----------call_rcu 1---------
[    5.189613] delayed_put_pid pid =3D 0xffff9d78dc327380
[    5.193612] ----------call_rcu 1---------
[    5.197615] ----------call_rcu 1---------
[    5.201638] free_pid pid =3D 0xffff9d78dc327b80
[    5.205611] ----------call_rcu 1---------
[    5.205613] delayed_put_pid pid =3D 0xffff9d78dc327680
[    5.209613] ----------call_rcu 1---------
[    5.213614] ----------call_rcu 1---------
[    5.217642] free_pid pid =3D 0xffff9d78dc327380
[    5.221611] ----------call_rcu 1---------
[    5.221613] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    5.225612] ----------call_rcu 1---------
[    5.229615] ----------call_rcu 1---------
[    5.233638] free_pid pid =3D 0xffff9d78dc327680
[    5.237611] ----------call_rcu 1---------
[    5.237613] delayed_put_pid pid =3D 0xffff9d78dc327b80
[    5.241613] ----------call_rcu 1---------
[    5.245615] ----------call_rcu 1---------
[    5.249637] free_pid pid =3D 0xffff9d78dc327a00
[    5.253611] ----------call_rcu 1---------
[    5.253613] delayed_put_pid pid =3D 0xffff9d78dc327380
[    5.257612] ----------call_rcu 1---------
[    5.261615] ----------call_rcu 1---------
[    5.265638] free_pid pid =3D 0xffff9d78dc327b80
[    5.269611] ----------call_rcu 1---------
[    5.269613] delayed_put_pid pid =3D 0xffff9d78dc327680
[    5.273613] ----------call_rcu 1---------
[    5.277615] ----------call_rcu 1---------
[    5.281638] free_pid pid =3D 0xffff9d78dc327380
[    5.285611] ----------call_rcu 1---------
[    5.285613] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    5.289612] ----------call_rcu 1---------
[    5.293615] ----------call_rcu 1---------
[    5.297639] free_pid pid =3D 0xffff9d78dc327680
[    5.301611] ----------call_rcu 1---------
[    5.301613] delayed_put_pid pid =3D 0xffff9d78dc327b80
[    5.305613] ----------call_rcu 1---------
[    5.309614] ----------call_rcu 1---------
[    5.313637] free_pid pid =3D 0xffff9d78dc327a00
[    5.317611] ----------call_rcu 1---------
[    5.317613] delayed_put_pid pid =3D 0xffff9d78dc327380
[    5.321612] ----------call_rcu 1---------
[    5.325615] ----------call_rcu 1---------
[    5.329639] free_pid pid =3D 0xffff9d78dc327b80
[    5.333611] ----------call_rcu 1---------
[    5.333613] delayed_put_pid pid =3D 0xffff9d78dc327680
[    5.337613] ----------call_rcu 1---------
[    5.341614] ----------call_rcu 1---------
[    5.345638] free_pid pid =3D 0xffff9d78dc327380
[    5.349611] ----------call_rcu 1---------
[    5.349613] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    5.353612] ----------call_rcu 1---------
[    5.357615] ----------call_rcu 1---------
[    5.361639] free_pid pid =3D 0xffff9d78dc327680
[    5.365611] ----------call_rcu 1---------
[    5.365613] delayed_put_pid pid =3D 0xffff9d78dc327b80
[    5.369613] ----------call_rcu 1---------
[    5.373614] ----------call_rcu 1---------
[    5.377638] free_pid pid =3D 0xffff9d78dc327a00
[    5.381611] ----------call_rcu 1---------
[    5.381613] delayed_put_pid pid =3D 0xffff9d78dc327380
[    5.385612] ----------call_rcu 1---------
[    5.389615] ----------call_rcu 1---------
[    5.393639] free_pid pid =3D 0xffff9d78dc327b80
[    5.397611] ----------call_rcu 1---------
[    5.397613] delayed_put_pid pid =3D 0xffff9d78dc327680
[    5.401613] ----------call_rcu 1---------
[    5.405614] ----------call_rcu 1---------
[    5.409639] free_pid pid =3D 0xffff9d78dc327380
[    5.413611] ----------call_rcu 1---------
[    5.413613] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    5.417612] ----------call_rcu 1---------
[    5.421615] ----------call_rcu 1---------
[    5.425639] free_pid pid =3D 0xffff9d78dc327680
[    5.429611] ----------call_rcu 1---------
[    5.429613] delayed_put_pid pid =3D 0xffff9d78dc327b80
[    5.433613] ----------call_rcu 1---------
[    5.437614] ----------call_rcu 1---------
[    5.441635] initcall drbg_init+0x0/0x8d returned 0 after 343750 usecs
[    5.445613] delayed_put_pid pid =3D 0xffff9d78dc327380
[    5.445613] ----------call_rcu 1---------
[    5.453614] calling  ghash_mod_init+0x0/0x17 @ 1
[    5.457621]  radix_tree_node_free node =3D 0xffff9d78dbc6c6d8
[    5.461611] ----------call_rcu 1---------
[    5.461611]  radix_tree_node_free node =3D 0xffff9d78dbc6f6c0
[    5.461611] ----------call_rcu 1---------
[    5.461611] free_pid pid =3D 0xffff9d78dc327a00
[    5.461611] ----------call_rcu 1---------
[    5.461613] delayed_put_pid pid =3D 0xffff9d78dc327680
[    5.465613] ----------call_rcu 1---------
[    5.469615] ----------call_rcu 1---------
[    5.473638] initcall ghash_mod_init+0x0/0x17 returned 0 after 15625 usec=
s
[    5.477614] calling  init_bio+0x0/0xd9 @ 1
[    5.481622]  radix_tree_node_free node =3D 0xffff9d78dbc6f230
[    5.485611] ----------call_rcu 1---------
[    5.485611]  radix_tree_node_free node =3D 0xffff9d78dbc6c490
[    5.485611] ----------call_rcu 1---------
[    5.485611] free_pid pid =3D 0xffff9d78dc327680
[    5.485611] ----------call_rcu 1---------
[    5.485613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c6d8
[    5.489612]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f6c0
[    5.493612] delayed_put_pid pid =3D 0xffff9d78dc327a00
[    5.497613] ----------call_rcu 1---------
[    5.501615] ----------call_rcu 1---------
[    5.505665] initcall init_bio+0x0/0xd9 returned 0 after 23437 usecs
[    5.509614] calling  blk_settings_init+0x0/0x2f @ 1
[    5.513616] initcall blk_settings_init+0x0/0x2f returned 0 after 0 usecs
[    5.517613] calling  blk_ioc_init+0x0/0x2f @ 1
[    5.521623] initcall blk_ioc_init+0x0/0x2f returned 0 after 0 usecs
[    5.525613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6f230
[    5.525613]  radix_tree_node_rcu_free node =3D 0xffff9d78dbc6c490
[    5.525614] delayed_put_pid pid =3D 0xffff9d78dc327680
[    5.525615] ----------call_rcu 1---------
[    5.541613] calling  blk_softirq_init+0x0/0x76 @ 1
[    5.545619] initcall blk_softirq_init+0x0/0x76 returned 0 after 0 usecs
[    5.549614] calling  blk_mq_init+0x0/0x56 @ 1
[    5.553620] initcall blk_mq_init+0x0/0x56 returned 0 after 0 usecs
[    5.557614] calling  genhd_device_init+0x0/0x7b @ 1
[    5.561653] initcall genhd_device_init+0x0/0x7b returned 0 after 0 usecs
[    5.565614] calling  blkcg_init+0x0/0x2e @ 1
[    5.569658] initcall blkcg_init+0x0/0x2e returned 0 after 0 usecs
[    5.573614] calling  irq_poll_setup+0x0/0x71 @ 1
[    5.577622] initcall irq_poll_setup+0x0/0x71 returned 0 after 0 usecs
[    5.581614] calling  sx150x_init+0x0/0x19 @ 1
[    5.585623] initcall sx150x_init+0x0/0x19 returned 0 after 0 usecs
[    5.589614] calling  byt_gpio_init+0x0/0x19 @ 1
[    5.593621] initcall byt_gpio_init+0x0/0x19 returned 0 after 0 usecs
[    5.597614] calling  chv_pinctrl_init+0x0/0x19 @ 1
[    5.601621] initcall chv_pinctrl_init+0x0/0x19 returned 0 after 0 usecs
[    5.605614] calling  gpiolib_debugfs_init+0x0/0x29 @ 1
[    5.609620] initcall gpiolib_debugfs_init+0x0/0x29 returned 0 after 0 us=
ecs
[    5.613614] calling  palmas_gpio_init+0x0/0x19 @ 1
[    5.617621] initcall palmas_gpio_init+0x0/0x19 returned 0 after 0 usecs
[    5.621614] calling  rc5t583_gpio_init+0x0/0x19 @ 1
[    5.625621] initcall rc5t583_gpio_init+0x0/0x19 returned 0 after 0 usecs
[    5.629614] calling  tps6586x_gpio_init+0x0/0x19 @ 1
[    5.633622] initcall tps6586x_gpio_init+0x0/0x19 returned 0 after 0 usec=
s
[    5.637614] calling  tps65910_gpio_init+0x0/0x19 @ 1
[    5.641621] initcall tps65910_gpio_init+0x0/0x19 returned 0 after 0 usec=
s
[    5.645614] calling  xgpio_init+0x0/0x19 @ 1
[    5.649621] initcall xgpio_init+0x0/0x19 returned 0 after 0 usecs
[    5.653614] calling  pwm_debugfs_init+0x0/0x29 @ 1
[    5.657619] initcall pwm_debugfs_init+0x0/0x29 returned 0 after 0 usecs
[    5.661614] calling  pwm_sysfs_init+0x0/0x1e @ 1
[    5.665620] initcall pwm_sysfs_init+0x0/0x1e returned 0 after 0 usecs
[    5.669614] calling  pci_slot_init+0x0/0x50 @ 1
[    5.673618] initcall pci_slot_init+0x0/0x50 returned 0 after 0 usecs
[    5.677614] calling  fbmem_init+0x0/0xe0 @ 1
[    5.681637] initcall fbmem_init+0x0/0xe0 returned 0 after 0 usecs
[    5.685614] calling  scan_for_dmi_ipmi+0x0/0x272 @ 1
[    5.689617] initcall scan_for_dmi_ipmi+0x0/0x272 returned 0 after 0 usec=
s
[    5.693615] calling  acpi_init+0x0/0x34d @ 1
[    5.697637] ACPI: Added _OSI(Module Device)
[    5.701613] ACPI: Added _OSI(Processor Device)
[    5.705614] ACPI: Added _OSI(3.0 _SCP Extensions)
[    5.709613] ACPI: Added _OSI(Processor Aggregator Device)
[    5.713616] ACPI: Added _OSI(Linux-Dell-Video)
[    5.717613] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    5.721617] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    5.832097] ACPI: 9 ACPI AML tables successfully acquired and loaded
[    5.845084] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    5.855308] ACPI: Interpreter enabled
[    5.857684] ACPI: (supports S0 S4 S5)
[    5.861375] ACPI: Using IOAPIC for interrupt routing
[    5.861671] PCI: Using host bridge windows from ACPI; if necessary, use =
\"pci=3Dnocrs\" and report a bug
[    5.868118] ACPI: Enabled 8 GPEs in block 00 to 7F
[    5.896770] ACPI: Power Resource [USBC] (on)
[    5.903406] ACPI: Power Resource [V0PR] (on)
[    5.906352] ACPI: Power Resource [V1PR] (on)
[    5.910336] ACPI: Power Resource [V2PR] (on)
[    5.924175] ACPI: Power Resource [WRST] (on)
[    5.934696] ACPI: Power Resource [FN00] (off)
[    5.937788] ACPI: Power Resource [FN01] (off)
[    5.941765] ACPI: Power Resource [FN02] (off)
[    5.945777] ACPI: Power Resource [FN03] (off)
[    5.949767] ACPI: Power Resource [FN04] (off)
[    5.954935] ACPI: Power Resource [PIN] (off)
[    5.958507] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    5.961630] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    5.968499] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR]
[    5.969616] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    5.975088] PCI host bridge to bus 0000:00
[    5.977615] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]
[    5.981621] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    5.985613] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    5.989617] pci_bus 0000:00: root bus resource [mem 0x90000000-0xdffffff=
f window]
[    5.993613] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7ffff=
f window]
[    5.997617] pci_bus 0000:00: root bus resource [bus 00-fe]
[    6.001626] pci 0000:00:00.0: [8086:3e34] type 00 class 0x060000
[    6.005624] pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x20 @ 1
[    6.009614] pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x20 took 0 usecs
[    6.014254] pci 0000:00:02.0: [8086:3ea0] type 00 class 0x030000
[    6.017626] pci 0000:00:02.0: reg 0x10: [mem 0xa0000000-0xa0ffffff 64bit=
]
[    6.021621] pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit=
 pref]
[    6.025617] pci 0000:00:02.0: reg 0x20: [io  0x5000-0x503f]
[    6.029640] pci 0000:00:02.0: calling  efifb_fixup_resources+0x0/0x130 @=
 1
[    6.033615] pci 0000:00:02.0: efifb_fixup_resources+0x0/0x130 took 0 use=
cs
[    6.037951] pci 0000:00:12.0: [8086:9df9] type 00 class 0x118000
[    6.041640] pci 0000:00:12.0: reg 0x10: [mem 0xa141e000-0xa141efff 64bit=
]
[    6.045917] pci 0000:00:14.0: [8086:9ded] type 00 class 0x0c0330
[    6.049634] pci 0000:00:14.0: reg 0x10: [mem 0xa1400000-0xa140ffff 64bit=
]
[    6.053687] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    6.058325] pci 0000:00:14.2: [8086:9def] type 00 class 0x050000
[    6.061641] pci 0000:00:14.2: reg 0x10: [mem 0xa1416000-0xa1417fff 64bit=
]
[    6.065626] pci 0000:00:14.2: reg 0x18: [mem 0xa141d000-0xa141dfff 64bit=
]
[    6.069886] pci 0000:00:16.0: [8086:9de0] type 00 class 0x078000
[    6.073641] pci 0000:00:16.0: reg 0x10: [mem 0xa141c000-0xa141cfff 64bit=
]
[    6.077700] pci 0000:00:16.0: PME# supported from D3hot
[    6.081983] pci 0000:00:17.0: [8086:9dd3] type 00 class 0x010601
[    6.085636] pci 0000:00:17.0: reg 0x10: [mem 0xa1414000-0xa1415fff]
[    6.089620] pci 0000:00:17.0: reg 0x14: [mem 0xa141b000-0xa141b0ff]
[    6.093621] pci 0000:00:17.0: reg 0x18: [io  0x5090-0x5097]
[    6.097620] pci 0000:00:17.0: reg 0x1c: [io  0x5080-0x5083]
[    6.101620] pci 0000:00:17.0: reg 0x20: [io  0x5060-0x507f]
[    6.105620] pci 0000:00:17.0: reg 0x24: [mem 0xa141a000-0xa141a7ff]
[    6.109668] pci 0000:00:17.0: PME# supported from D3hot
[    6.113927] pci 0000:00:1a.0: [8086:9dc4] type 00 class 0x080501
[    6.117641] pci 0000:00:1a.0: reg 0x10: [mem 0xa1419000-0xa1419fff 64bit=
]
[    6.122429] pci 0000:00:1c.0: [8086:9db8] type 01 class 0x060400
[    6.125621] pci 0000:00:1c.0: calling  quirk_cmd_compl+0x0/0x70 @ 1
[    6.129617] pci 0000:00:1c.0: quirk_cmd_compl+0x0/0x70 took 0 usecs
[    6.133616] pci 0000:00:1c.0: calling  quirk_no_aersid+0x0/0x30 @ 1
[    6.137614] pci 0000:00:1c.0: quirk_no_aersid+0x0/0x30 took 0 usecs
[    6.141666] pci 0000:00:1c.0: calling  pci_fixup_transparent_bridge+0x0/=
0x20 @ 1
[    6.145614] pci 0000:00:1c.0: pci_fixup_transparent_bridge+0x0/0x20 took=
 0 usecs
[    6.149649] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    6.153973] pci 0000:00:1c.4: [8086:9dbc] type 01 class 0x060400
[    6.157624] pci 0000:00:1c.4: calling  quirk_cmd_compl+0x0/0x70 @ 1
[    6.161615] pci 0000:00:1c.4: quirk_cmd_compl+0x0/0x70 took 0 usecs
[    6.165614] pci 0000:00:1c.4: calling  quirk_no_aersid+0x0/0x30 @ 1
[    6.169614] pci 0000:00:1c.4: quirk_no_aersid+0x0/0x30 took 0 usecs
[    6.173666] pci 0000:00:1c.4: calling  pci_fixup_transparent_bridge+0x0/=
0x20 @ 1
[    6.177614] pci 0000:00:1c.4: pci_fixup_transparent_bridge+0x0/0x20 took=
 0 usecs
[    6.181657] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    6.185633] pci 0000:00:1c.4: PTM enabled (root), 4ns granularity
[    6.189976] pci 0000:00:1d.0: [8086:9db0] type 01 class 0x060400
[    6.193620] pci 0000:00:1d.0: calling  quirk_cmd_compl+0x0/0x70 @ 1
[    6.197617] pci 0000:00:1d.0: quirk_cmd_compl+0x0/0x70 took 0 usecs
[    6.201614] pci 0000:00:1d.0: calling  quirk_no_aersid+0x0/0x30 @ 1
[    6.205614] pci 0000:00:1d.0: quirk_no_aersid+0x0/0x30 took 0 usecs
[    6.209668] pci 0000:00:1d.0: calling  pci_fixup_transparent_bridge+0x0/=
0x20 @ 1
[    6.213614] pci 0000:00:1d.0: pci_fixup_transparent_bridge+0x0/0x20 took=
 0 usecs
[    6.217656] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    6.221634] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
[    6.225961] pci 0000:00:1d.1: [8086:9db1] type 01 class 0x060400
[    6.229620] pci 0000:00:1d.1: calling  quirk_cmd_compl+0x0/0x70 @ 1
[    6.233617] pci 0000:00:1d.1: quirk_cmd_compl+0x0/0x70 took 0 usecs
[    6.237614] pci 0000:00:1d.1: calling  quirk_no_aersid+0x0/0x30 @ 1
[    6.241614] pci 0000:00:1d.1: quirk_no_aersid+0x0/0x30 took 0 usecs
[    6.245665] pci 0000:00:1d.1: calling  pci_fixup_transparent_bridge+0x0/=
0x20 @ 1
[    6.249614] pci 0000:00:1d.1: pci_fixup_transparent_bridge+0x0/0x20 took=
 0 usecs
[    6.253657] pci 0000:00:1d.1: PME# supported from D0 D3hot D3cold
[    6.257634] pci 0000:00:1d.1: PTM enabled (root), 4ns granularity
[    6.261993] pci 0000:00:1f.0: [8086:9d84] type 00 class 0x060100
[    6.266128] pci 0000:00:1f.3: [8086:9dc8] type 00 class 0x040300
[    6.269690] pci 0000:00:1f.3: reg 0x10: [mem 0xa1410000-0xa1413fff 64bit=
]
[    6.273696] pci 0000:00:1f.3: reg 0x20: [mem 0xa1000000-0xa10fffff 64bit=
]
[    6.277759] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    6.282819] pci 0000:00:1f.4: [8086:9da3] type 00 class 0x0c0500
[    6.285645] pci 0000:00:1f.4: reg 0x10: [mem 0xa1418000-0xa14180ff 64bit=
]
[    6.289643] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    6.293934] pci 0000:00:1f.5: [8086:9da4] type 00 class 0x0c8000
[    6.297635] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    6.301967] acpiphp: Slot [1] registered
[    6.305619] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    6.309734] pci 0000:02:00.0: [126f:2263] type 00 class 0x010802
[    6.313648] pci 0000:02:00.0: reg 0x10: [mem 0xa1300000-0xa1303fff 64bit=
]
[    6.317888] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    6.321617] pci 0000:00:1c.4:   bridge window [mem 0xa1300000-0xa13fffff=
]
[    6.325736] pci 0000:03:00.0: [8086:157b] type 00 class 0x020000
[    6.329626] pci 0000:03:00.0: calling  quirk_f0_vpd_link+0x0/0x60 @ 1
[    6.333616] pci 0000:03:00.0: quirk_f0_vpd_link+0x0/0x60 took 0 usecs
[    6.337640] pci 0000:03:00.0: reg 0x10: [mem 0xa1200000-0xa121ffff]
[    6.341640] pci 0000:03:00.0: reg 0x18: [io  0x4000-0x401f]
[    6.345626] pci 0000:03:00.0: reg 0x1c: [mem 0xa1220000-0xa1223fff]
[    6.349768] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    6.353760] pci 0000:00:1d.0: PCI bridge to [bus 03]
[    6.357618] pci 0000:00:1d.0:   bridge window [io  0x4000-0x4fff]
[    6.361615] pci 0000:00:1d.0:   bridge window [mem 0xa1200000-0xa12fffff=
]
[    6.365735] pci 0000:04:00.0: [8086:157b] type 00 class 0x020000
[    6.369625] pci 0000:04:00.0: calling  quirk_f0_vpd_link+0x0/0x60 @ 1
[    6.373616] pci 0000:04:00.0: quirk_f0_vpd_link+0x0/0x60 took 0 usecs
[    6.377639] pci 0000:04:00.0: reg 0x10: [mem 0xa1100000-0xa111ffff]
[    6.381640] pci 0000:04:00.0: reg 0x18: [io  0x3000-0x301f]
[    6.385626] pci 0000:04:00.0: reg 0x1c: [mem 0xa1120000-0xa1123fff]
[    6.389768] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    6.393751] pci 0000:00:1d.1: PCI bridge to [bus 04]
[    6.397617] pci 0000:00:1d.1:   bridge window [io  0x3000-0x3fff]
[    6.401615] pci 0000:00:1d.1:   bridge window [mem 0xa1100000-0xa11fffff=
]
[    6.409856] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15=
) *0
[    6.413769] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15=
) *1
[    6.417754] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15=
) *0
[    6.421760] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15=
) *0
[    6.425751] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15=
) *0
[    6.429760] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15=
) *0
[    6.433766] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15=
) *0
[    6.437761] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15=
) *0
[    6.442728] initcall acpi_init+0x0/0x34d returned 0 after 726562 usecs
[    6.445617] calling  adxl_init+0x0/0x18b @ 1
[    6.449625] initcall adxl_init+0x0/0x18b returned -19 after 0 usecs
[    6.453614] calling  pnp_init+0x0/0x17 @ 1
[    6.457624] initcall pnp_init+0x0/0x17 returned 0 after 0 usecs
[    6.461614] calling  misc_init+0x0/0xc4 @ 1
[    6.465623] initcall misc_init+0x0/0xc4 returned 0 after 0 usecs
[    6.469614] calling  tpm_init+0x0/0xef @ 1
[    6.473653] initcall tpm_init+0x0/0xef returned 0 after 0 usecs
[    6.477615] calling  iommu_subsys_init+0x0/0x54 @ 1
[    6.481615] iommu: Default domain type: Translated=20
[    6.485614] initcall iommu_subsys_init+0x0/0x54 returned 0 after 3906 us=
ecs
[    6.489614] calling  vga_arb_device_init+0x0/0x26f @ 1
[    6.493651] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    6.497611] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    6.497617] pci 0000:00:02.0: vgaarb: bridge control possible
[    6.501614] vgaarb: loaded
[    6.504351] initcall vga_arb_device_init+0x0/0x26f returned 0 after 7812=
 usecs
[    6.505616] calling  cn_init+0x0/0xf0 @ 1
[    6.509623] initcall cn_init+0x0/0xf0 returned 0 after 0 usecs
[    6.513615] calling  pm860x_i2c_init+0x0/0x31 @ 1
[    6.517624] initcall pm860x_i2c_init+0x0/0x31 returned 0 after 0 usecs
[    6.521614] calling  wm8400_driver_init+0x0/0x31 @ 1
[    6.525622] initcall wm8400_driver_init+0x0/0x31 returned 0 after 0 usec=
s
[    6.529614] calling  wm831x_i2c_init+0x0/0x31 @ 1
[    6.533621] initcall wm831x_i2c_init+0x0/0x31 returned 0 after 0 usecs
[    6.537614] calling  wm831x_spi_init+0x0/0x2d @ 1
[    6.541621] initcall wm831x_spi_init+0x0/0x2d returned 0 after 0 usecs
[    6.545614] calling  wm8350_i2c_init+0x0/0x19 @ 1
[    6.549621] initcall wm8350_i2c_init+0x0/0x19 returned 0 after 0 usecs
[    6.553614] calling  tps65910_i2c_init+0x0/0x19 @ 1
[    6.557623] initcall tps65910_i2c_init+0x0/0x19 returned 0 after 0 usecs
[    6.561614] calling  tps80031_init+0x0/0x19 @ 1
[    6.565623] initcall tps80031_init+0x0/0x19 returned 0 after 0 usecs
[    6.569613] calling  ezx_pcap_init+0x0/0x19 @ 1
[    6.573622] initcall ezx_pcap_init+0x0/0x19 returned 0 after 0 usecs
[    6.577613] calling  da903x_init+0x0/0x19 @ 1
[    6.581620] initcall da903x_init+0x0/0x19 returned 0 after 0 usecs
[    6.585613] calling  da9052_spi_init+0x0/0x31 @ 1
[    6.589620] initcall da9052_spi_init+0x0/0x31 returned 0 after 0 usecs
[    6.593613] calling  da9052_i2c_init+0x0/0x31 @ 1
[    6.597620] initcall da9052_i2c_init+0x0/0x31 returned 0 after 0 usecs
[    6.601613] calling  lp8788_init+0x0/0x19 @ 1
[    6.605620] initcall lp8788_init+0x0/0x19 returned 0 after 0 usecs
[    6.609613] calling  da9055_i2c_init+0x0/0x31 @ 1
[    6.613621] initcall da9055_i2c_init+0x0/0x31 returned 0 after 0 usecs
[    6.617613] calling  max77843_i2c_init+0x0/0x19 @ 1
[    6.621620] initcall max77843_i2c_init+0x0/0x19 returned 0 after 0 usecs
[    6.625613] calling  max8925_i2c_init+0x0/0x31 @ 1
[    6.629621] initcall max8925_i2c_init+0x0/0x31 returned 0 after 0 usecs
[    6.633613] calling  max8997_i2c_init+0x0/0x19 @ 1
[    6.637620] initcall max8997_i2c_init+0x0/0x19 returned 0 after 0 usecs
[    6.641613] calling  max8998_i2c_init+0x0/0x19 @ 1
[    6.645621] initcall max8998_i2c_init+0x0/0x19 returned 0 after 0 usecs
[    6.649613] calling  ab3100_i2c_init+0x0/0x19 @ 1
[    6.653620] initcall ab3100_i2c_init+0x0/0x19 returned 0 after 0 usecs
[    6.657613] calling  tps6586x_init+0x0/0x19 @ 1
[    6.661620] initcall tps6586x_init+0x0/0x19 returned 0 after 0 usecs
[    6.665613] calling  tps65090_init+0x0/0x19 @ 1
[    6.669620] initcall tps65090_init+0x0/0x19 returned 0 after 0 usecs
[    6.673613] calling  aat2870_init+0x0/0x19 @ 1
[    6.677620] initcall aat2870_init+0x0/0x19 returned 0 after 0 usecs
[    6.681613] calling  palmas_i2c_init+0x0/0x19 @ 1
[    6.685620] initcall palmas_i2c_init+0x0/0x19 returned 0 after 0 usecs
[    6.689613] calling  rc5t583_i2c_init+0x0/0x19 @ 1
[    6.693620] initcall rc5t583_i2c_init+0x0/0x19 returned 0 after 0 usecs
[    6.697613] calling  sec_pmic_init+0x0/0x19 @ 1
[    6.701621] initcall sec_pmic_init+0x0/0x19 returned 0 after 0 usecs
[    6.705613] calling  as3711_i2c_init+0x0/0x19 @ 1
[    6.709620] initcall as3711_i2c_init+0x0/0x19 returned 0 after 0 usecs
[    6.713613] calling  libnvdimm_init+0x0/0x41 @ 1
[    6.717647] initcall libnvdimm_init+0x0/0x41 returned 0 after 0 usecs
[    6.721613] calling  dax_core_init+0x0/0xc1 @ 1
[    6.725643] initcall dax_core_init+0x0/0xc1 returned 0 after 0 usecs
[    6.729614] calling  dma_buf_init+0x0/0xce @ 1
[    6.733629] initcall dma_buf_init+0x0/0xce returned 0 after 0 usecs
[    6.737614] calling  init_scsi+0x0/0x8d @ 1
[    6.741669] SCSI subsystem initialized
[    6.745456] initcall init_scsi+0x0/0x8d returned 0 after 0 usecs
[    6.745614] calling  ata_init+0x0/0x334 @ 1
[    6.749653] libata version 3.00 loaded.
[    6.753527] initcall ata_init+0x0/0x334 returned 0 after 0 usecs
[    6.753614] calling  phy_init+0x0/0x248 @ 1
[    6.757634] initcall phy_init+0x0/0x248 returned 0 after 0 usecs
[    6.761614] calling  usb_common_init+0x0/0x27 @ 1
[    6.765621] initcall usb_common_init+0x0/0x27 returned 0 after 0 usecs
[    6.769613] calling  usb_init+0x0/0x12e @ 1
[    6.773620] ACPI: bus type USB registered
[    6.777628] usbcore: registered new interface driver usbfs
[    6.781628] usbcore: registered new interface driver hub
[    6.785628] usbcore: registered new device driver usb
[    6.789615] initcall usb_init+0x0/0x12e returned 0 after 15625 usecs
[    6.793614] calling  xdbc_init+0x0/0x152 @ 1
[    6.797614] initcall xdbc_init+0x0/0x152 returned 0 after 0 usecs
[    6.801613] calling  serio_init+0x0/0x2f @ 1
[    6.805621] initcall serio_init+0x0/0x2f returned 0 after 0 usecs
[    6.809614] calling  input_init+0x0/0x102 @ 1
[    6.813623] initcall input_init+0x0/0x102 returned 0 after 0 usecs
[    6.817614] calling  rtc_init+0x0/0x52 @ 1
[    6.821620] initcall rtc_init+0x0/0x52 returned 0 after 0 usecs
[    6.825614] calling  dw_i2c_init_driver+0x0/0x19 @ 1
[    6.829627] initcall dw_i2c_init_driver+0x0/0x19 returned 0 after 0 usec=
s
[    6.833614] calling  pps_init+0x0/0xaf @ 1
[    6.837618] pps_core: LinuxPPS API ver. 1 registered
[    6.841612] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    6.845615] initcall pps_init+0x0/0xaf returned 0 after 7812 usecs
[    6.849613] calling  ptp_init+0x0/0x9e @ 1
[    6.853617] PTP clock support registered
[    6.857568] initcall ptp_init+0x0/0x9e returned 0 after 0 usecs
[    6.857614] calling  power_supply_class_init+0x0/0x45 @ 1
[    6.861625] initcall power_supply_class_init+0x0/0x45 returned 0 after 0=
 usecs
[    6.865614] calling  hwmon_init+0x0/0xf1 @ 1
[    6.869622] initcall hwmon_init+0x0/0xf1 returned 0 after 0 usecs
[    6.873614] calling  md_init+0x0/0x194 @ 1
[    6.877662] initcall md_init+0x0/0x194 returned 0 after 0 usecs
[    6.881614] calling  edac_init+0x0/0x75 @ 1
[    6.885614] EDAC MC: Ver: 3.0.0
[    6.888908] initcall edac_init+0x0/0x75 returned 0 after 0 usecs
[    6.889614] calling  mmc_init+0x0/0x3a @ 1
[    6.893633] initcall mmc_init+0x0/0x3a returned 0 after 0 usecs
[    6.897614] calling  leds_init+0x0/0x41 @ 1
[    6.901622] initcall leds_init+0x0/0x41 returned 0 after 0 usecs
[    6.905614] calling  dmi_init+0x0/0x11b @ 1
[    6.909627] initcall dmi_init+0x0/0x11b returned 0 after 0 usecs
[    6.913614] calling  efisubsys_init+0x0/0x83 @ 1
[    6.917615] initcall efisubsys_init+0x0/0x83 returned 0 after 0 usecs
[    6.921613] calling  devfreq_init+0x0/0xd1 @ 1
[    6.925643] initcall devfreq_init+0x0/0xd1 returned 0 after 0 usecs
[    6.929614] calling  devfreq_event_init+0x0/0x54 @ 1
[    6.933622] initcall devfreq_event_init+0x0/0x54 returned 0 after 0 usec=
s
[    6.937613] calling  devfreq_simple_ondemand_init+0x0/0x17 @ 1
[    6.941618] initcall devfreq_simple_ondemand_init+0x0/0x17 returned 0 af=
ter 0 usecs
[    6.945613] calling  devfreq_performance_init+0x0/0x17 @ 1
[    6.949617] initcall devfreq_performance_init+0x0/0x17 returned 0 after =
0 usecs
[    6.953613] calling  devfreq_powersave_init+0x0/0x17 @ 1
[    6.957618] initcall devfreq_powersave_init+0x0/0x17 returned 0 after 0 =
usecs
[    6.961613] calling  devfreq_userspace_init+0x0/0x17 @ 1
[    6.965617] initcall devfreq_userspace_init+0x0/0x17 returned 0 after 0 =
usecs
[    6.969613] calling  devfreq_passive_init+0x0/0x17 @ 1
[    6.973617] initcall devfreq_passive_init+0x0/0x17 returned 0 after 0 us=
ecs
[    6.977613] calling  vme_init+0x0/0x17 @ 1
[    6.981621] initcall vme_init+0x0/0x17 returned 0 after 0 usecs
[    6.985613] calling  ras_init+0x0/0x15 @ 1
[    6.989620] initcall ras_init+0x0/0x15 returned 0 after 0 usecs
[    6.993613] calling  nvmem_init+0x0/0x17 @ 1
[    6.997621] initcall nvmem_init+0x0/0x17 returned 0 after 0 usecs
[    7.001613] calling  proto_init+0x0/0x17 @ 1
[    7.005619] initcall proto_init+0x0/0x17 returned 0 after 0 usecs
[    7.009613] calling  net_dev_init+0x0/0x23b @ 1
[    7.013699] initcall net_dev_init+0x0/0x23b returned 0 after 0 usecs
[    7.017614] calling  neigh_init+0x0/0x8a @ 1
[    7.021620] initcall neigh_init+0x0/0x8a returned 0 after 0 usecs
[    7.025613] calling  fib_notifier_init+0x0/0x17 @ 1
[    7.029618] initcall fib_notifier_init+0x0/0x17 returned 0 after 0 usecs
[    7.033613] calling  fib_rules_init+0x0/0xb1 @ 1
[    7.037618] initcall fib_rules_init+0x0/0xb1 returned 0 after 0 usecs
[    7.041613] calling  init_cgroup_netprio+0x0/0x19 @ 1
[    7.045618] initcall init_cgroup_netprio+0x0/0x19 returned 0 after 0 use=
cs
[    7.049613] calling  bpf_lwt_init+0x0/0x1c @ 1
[    7.053615] initcall bpf_lwt_init+0x0/0x1c returned 0 after 0 usecs
[    7.057613] calling  devlink_init+0x0/0x2d @ 1
[    7.061621] initcall devlink_init+0x0/0x2d returned 0 after 0 usecs
[    7.065613] calling  pktsched_init+0x0/0x114 @ 1
[    7.069620] initcall pktsched_init+0x0/0x114 returned 0 after 0 usecs
[    7.073613] calling  tc_filter_init+0x0/0x101 @ 1
[    7.077623] initcall tc_filter_init+0x0/0x101 returned 0 after 0 usecs
[    7.081613] calling  tc_action_init+0x0/0x5a @ 1
[    7.085618] initcall tc_action_init+0x0/0x5a returned 0 after 0 usecs
[    7.089613] calling  genl_init+0x0/0x3b @ 1
[    7.093621] initcall genl_init+0x0/0x3b returned 0 after 0 usecs
[    7.097613] calling  ethnl_init+0x0/0x58 @ 1
[    7.101631] initcall ethnl_init+0x0/0x58 returned 0 after 0 usecs
[    7.105614] calling  nexthop_init+0x0/0xde @ 1
[    7.109619] initcall nexthop_init+0x0/0xde returned 0 after 0 usecs
[    7.113614] calling  cipso_v4_init+0x0/0x69 @ 1
[    7.117618] initcall cipso_v4_init+0x0/0x69 returned 0 after 0 usecs
[    7.121614] calling  wireless_nlevent_init+0x0/0x3e @ 1
[    7.125619] initcall wireless_nlevent_init+0x0/0x3e returned 0 after 0 u=
secs
[    7.129614] calling  netlbl_init+0x0/0x7e @ 1
[    7.133613] NetLabel: Initializing
[    7.137046] NetLabel:  domain hash size =3D 128
[    7.137612] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    7.141633] NetLabel:  unlabeled traffic allowed by default
[    7.145614] initcall netlbl_init+0x0/0x7e returned 0 after 11718 usecs
[    7.149615] calling  rfkill_init+0x0/0x117 @ 1
[    7.153648] initcall rfkill_init+0x0/0x117 returned 0 after 0 usecs
[    7.157615] calling  pci_subsys_init+0x0/0x6c @ 1
[    7.161614] PCI: Using ACPI for IRQ routing
[    7.209965] PCI: pci_cache_line_size set to 64 bytes
[    7.213687] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
[    7.217613] e820: reserve RAM buffer [mem 0x85c1b000-0x87ffffff]
[    7.221613] e820: reserve RAM buffer [mem 0x8c087000-0x8fffffff]
[    7.225613] e820: reserve RAM buffer [mem 0x8d000000-0x8fffffff]
[    7.229613] e820: reserve RAM buffer [mem 0x46e000000-0x46fffffff]
[    7.233615] initcall pci_subsys_init+0x0/0x6c returned 0 after 70312 use=
cs
[    7.237614] calling  watchdog_init+0x0/0x8f @ 1
[    7.241650] initcall watchdog_init+0x0/0x8f returned 0 after 0 usecs
[    7.245615] calling  pci_eisa_init_early+0x0/0x107 @ 1
[    7.249621] initcall pci_eisa_init_early+0x0/0x107 returned 0 after 0 us=
ecs
[    7.253793] calling  nmi_warning_debugfs+0x0/0x2c @ 1
[    7.257620] initcall nmi_warning_debugfs+0x0/0x2c returned 0 after 0 use=
cs
[    7.261615] calling  save_microcode_in_initrd+0x0/0x5e @ 1
[    7.265618] initcall save_microcode_in_initrd+0x0/0x5e returned 0 after =
0 usecs
[    7.269615] calling  hpet_late_init+0x0/0x225 @ 1
[    7.273624] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    7.277613] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    7.283693] initcall hpet_late_init+0x0/0x225 returned 0 after 7812 usec=
s
[    7.285614] calling  init_amd_nbs+0x0/0x11e @ 1
[    7.289619] initcall init_amd_nbs+0x0/0x11e returned 0 after 0 usecs
[    7.293615] calling  clocksource_done_booting+0x0/0x47 @ 1
[    7.297627] clocksource: Switched to clocksource tsc-early
[    7.303147] initcall clocksource_done_booting+0x0/0x47 returned 0 after =
5403 usecs
[    7.310766] calling  tracer_init_tracefs+0x0/0x1d4 @ 1
[    7.524868] initcall tracer_init_tracefs+0x0/0x1d4 returned 0 after 2040=
26 usecs
[    7.532318] calling  init_trace_printk_function_export+0x0/0x32 @ 1
[    7.538636] initcall init_trace_printk_function_export+0x0/0x32 returned=
 0 after 4 usecs
[    7.546782] calling  init_graph_tracefs+0x0/0x32 @ 1
[    7.551790] initcall init_graph_tracefs+0x0/0x32 returned 0 after 4 usec=
s
[    7.558627] calling  trace_events_synth_init+0x0/0x6e @ 1
[    7.564072] initcall trace_events_synth_init+0x0/0x6e returned 0 after 4=
 usecs
[    7.571347] calling  bpf_event_init+0x0/0x14 @ 1
[    7.576000] initcall bpf_event_init+0x0/0x14 returned 0 after 3 usecs
[    7.582486] calling  init_kprobe_trace+0x0/0x18d @ 1
[    7.587490] initcall init_kprobe_trace+0x0/0x18d returned 0 after 4 usec=
s
[    7.594323] calling  init_dynamic_event+0x0/0x43 @ 1
[    7.599325] initcall init_dynamic_event+0x0/0x43 returned 0 after 3 usec=
s
[    7.606158] calling  init_uprobe_trace+0x0/0x6c @ 1
[    7.611080] initcall init_uprobe_trace+0x0/0x6c returned 0 after 4 usecs
[    7.617828] calling  bpf_init+0x0/0x4c @ 1
[    7.621969] initcall bpf_init+0x0/0x4c returned 0 after 7 usecs
[    7.627930] calling  init_pipe_fs+0x0/0x4a @ 1
[    7.632427] initcall init_pipe_fs+0x0/0x4a returned 0 after 15 usecs
[    7.638827] calling  cgroup_writeback_init+0x0/0x2b @ 1
[    7.644105] initcall cgroup_writeback_init+0x0/0x2b returned 0 after 13 =
usecs
[    7.651292] calling  inotify_user_setup+0x0/0x4d @ 1
[    7.656301] initcall inotify_user_setup+0x0/0x4d returned 0 after 9 usec=
s
[    7.663138] calling  eventpoll_init+0x0/0xc7 @ 1
[    7.667800] initcall eventpoll_init+0x0/0xc7 returned 0 after 11 usecs
[    7.674370] calling  anon_inode_init+0x0/0x5e @ 1
[    7.679127] initcall anon_inode_init+0x0/0x5e returned 0 after 14 usecs
[    7.685792] calling  init_dax_wait_table+0x0/0x47 @ 1
[    7.690898] initcall init_dax_wait_table+0x0/0x47 returned 0 after 18 us=
ecs
[    7.697904] calling  proc_locks_init+0x0/0x2d @ 1
[    7.702652] initcall proc_locks_init+0x0/0x2d returned 0 after 5 usecs
[    7.709229] calling  iomap_init+0x0/0x26 @ 1
[    7.713563] initcall iomap_init+0x0/0x26 returned 0 after 27 usecs
[    7.719791] calling  dquot_init+0x0/0x11c @ 1
[    7.724182] VFS: Disk quotas dquot_6.6.0
[    7.728161] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    7.735085] initcall dquot_init+0x0/0x11c returned 0 after 10646 usecs
[    7.741663] calling  quota_init+0x0/0x29 @ 1
[    7.745980] initcall quota_init+0x0/0x29 returned 0 after 12 usecs
[    7.752208] calling  proc_cmdline_init+0x0/0x27 @ 1
[    7.757128] initcall proc_cmdline_init+0x0/0x27 returned 0 after 4 usecs
[    7.763881] calling  proc_consoles_init+0x0/0x2a @ 1
[    7.768886] initcall proc_consoles_init+0x0/0x2a returned 0 after 3 usec=
s
[    7.775717] calling  proc_cpuinfo_init+0x0/0x24 @ 1
[    7.780636] initcall proc_cpuinfo_init+0x0/0x24 returned 0 after 3 usecs
[    7.787386] calling  proc_devices_init+0x0/0x2a @ 1
[    7.792306] initcall proc_devices_init+0x0/0x2a returned 0 after 3 usecs
[    7.799051] calling  proc_interrupts_init+0x0/0x2a @ 1
[    7.804230] initcall proc_interrupts_init+0x0/0x2a returned 0 after 3 us=
ecs
[    7.811234] calling  proc_loadavg_init+0x0/0x27 @ 1
[    7.816151] initcall proc_loadavg_init+0x0/0x27 returned 0 after 3 usecs
[    7.822897] calling  proc_meminfo_init+0x0/0x27 @ 1
[    7.827817] initcall proc_meminfo_init+0x0/0x27 returned 0 after 3 usecs
[    7.834561] calling  proc_stat_init+0x0/0x24 @ 1
[    7.839216] initcall proc_stat_init+0x0/0x24 returned 0 after 3 usecs
[    7.845698] calling  proc_uptime_init+0x0/0x27 @ 1
[    7.850532] initcall proc_uptime_init+0x0/0x27 returned 0 after 3 usecs
[    7.857193] calling  proc_version_init+0x0/0x27 @ 1
[    7.862116] initcall proc_version_init+0x0/0x27 returned 0 after 3 usecs
[    7.868865] calling  proc_softirqs_init+0x0/0x27 @ 1
[    7.873875] initcall proc_softirqs_init+0x0/0x27 returned 0 after 3 usec=
s
[    7.880710] calling  proc_kcore_init+0x0/0xd5 @ 1
[    7.885468] initcall proc_kcore_init+0x0/0xd5 returned 0 after 13 usecs
[    7.892130] calling  vmcore_init+0x0/0x5d0 @ 1
[    7.896609] initcall vmcore_init+0x0/0x5d0 returned 0 after 0 usecs
[    7.902921] calling  proc_kmsg_init+0x0/0x27 @ 1
[    7.907579] initcall proc_kmsg_init+0x0/0x27 returned 0 after 3 usecs
[    7.914062] calling  proc_page_init+0x0/0x5b @ 1
[    7.918720] initcall proc_page_init+0x0/0x5b returned 0 after 4 usecs
[    7.925207] calling  init_ramfs_fs+0x0/0x17 @ 1
[    7.929777] initcall init_ramfs_fs+0x0/0x17 returned 0 after 0 usecs
[    7.936173] calling  init_hugetlbfs_fs+0x0/0x138 @ 1
[    7.941201] initcall init_hugetlbfs_fs+0x0/0x138 returned 0 after 23 use=
cs
[    7.948125] calling  tomoyo_initerface_init+0x0/0x180 @ 1
[    7.953565] initcall tomoyo_initerface_init+0x0/0x180 returned 0 after 0=
 usecs
[    7.960830] calling  aa_create_aafs+0x0/0x3a6 @ 1
[    7.965649] AppArmor: AppArmor Filesystem Enabled
[    7.970395] initcall aa_create_aafs+0x0/0x3a6 returned 0 after 4709 usec=
s
[    7.977229] calling  safesetid_init_securityfs+0x0/0x6a @ 1
[    7.982839] initcall safesetid_init_securityfs+0x0/0x6a returned 0 after=
 0 usecs
[    7.990286] calling  blk_scsi_ioctl_init+0x0/0x3b8 @ 1
[    7.995464] initcall blk_scsi_ioctl_init+0x0/0x3b8 returned 0 after 0 us=
ecs
[    8.002468] calling  dynamic_debug_init_control+0x0/0x7c @ 1
[    8.008176] initcall dynamic_debug_init_control+0x0/0x7c returned 0 afte=
r 7 usecs
[    8.015714] calling  simplefb_init+0x0/0x19 @ 1
[    8.020299] initcall simplefb_init+0x0/0x19 returned 0 after 19 usecs
[    8.026789] calling  acpi_event_init+0x0/0x35 @ 1
[    8.031536] initcall acpi_event_init+0x0/0x35 returned 0 after 7 usecs
[    8.038114] calling  pnp_system_init+0x0/0x17 @ 1
[    8.042860] initcall pnp_system_init+0x0/0x17 returned 0 after 7 usecs
[    8.049433] calling  pnpacpi_init+0x0/0x73 @ 1
[    8.053911] pnp: PnP ACPI init
[    8.057182] system 00:00: [mem 0x40000000-0x403fffff] has been reserved
[    8.063857] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    8.071162] system 00:01: [io  0x0a00-0x0a2f] has been reserved
[    8.077126] system 00:01: [io  0x0a30-0x0a3f] has been reserved
[    8.083091] system 00:01: [io  0x0a40-0x0a4f] has been reserved
[    8.089059] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    8.095968] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b (a=
ctive)
[    8.103331] pnp 00:03: Plug and Play ACPI device, IDs PNP0f03 PNP0f13 (a=
ctive)
[    8.111587] pnp 00:04: [dma 3]
[    8.114947] pnp 00:04: Plug and Play ACPI device, IDs PNP0401 (active)
[    8.122198] pnp 00:05: [dma 0 disabled]
[    8.126122] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    8.133358] pnp 00:06: [dma 0 disabled]
[    8.137284] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    8.144498] ACPI: IRQ 7 override to edge, high
[    8.148985] pnp 00:07: [dma 0 disabled]
[    8.152906] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (active)
[    8.160113] ACPI: IRQ 7 override to edge, high
[    8.164596] pnp 00:08: [dma 0 disabled]
[    8.168514] pnp 00:08: Plug and Play ACPI device, IDs PNP0501 (active)
[    8.175726] ACPI: IRQ 7 override to edge, high
[    8.180215] pnp 00:09: [dma 0 disabled]
[    8.184138] pnp 00:09: Plug and Play ACPI device, IDs PNP0501 (active)
[    8.191351] ACPI: IRQ 7 override to edge, high
[    8.195835] pnp 00:0a: [dma 0 disabled]
[    8.199753] pnp 00:0a: Plug and Play ACPI device, IDs PNP0501 (active)
[    8.206524] system 00:0b: [io  0x0680-0x069f] has been reserved
[    8.212490] system 00:0b: [io  0x164e-0x164f] has been reserved
[    8.218462] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    8.225502] system 00:0c: [io  0x1854-0x1857] has been reserved
[    8.231474] system 00:0c: Plug and Play ACPI device, IDs INT3f0d PNP0c02=
 (active)
[    8.239386] system 00:0d: [mem 0xfed10000-0xfed17fff] has been reserved
[    8.246054] system 00:0d: [mem 0xfed18000-0xfed18fff] has been reserved
[    8.252712] system 00:0d: [mem 0xfed19000-0xfed19fff] has been reserved
[    8.259376] system 00:0d: [mem 0xe0000000-0xefffffff] has been reserved
[    8.266037] system 00:0d: [mem 0xfed20000-0xfed3ffff] has been reserved
[    8.272692] system 00:0d: [mem 0xfed90000-0xfed93fff] has been reserved
[    8.279354] system 00:0d: [mem 0xfed45000-0xfed8ffff] has been reserved
[    8.286015] system 00:0d: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    8.293031] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    8.300239] system 00:0e: [io  0x1800-0x18fe] could not be reserved
[    8.306563] system 00:0e: [mem 0xfd000000-0xfd69ffff] has been reserved
[    8.313223] system 00:0e: [mem 0xfd6b0000-0xfd6cffff] has been reserved
[    8.319887] system 00:0e: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    8.326555] system 00:0e: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    8.333565] system 00:0e: [mem 0xfe200000-0xfe7fffff] has been reserved
[    8.340230] system 00:0e: [mem 0xff000000-0xffffffff] has been reserved
[    8.346899] system 00:0e: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    8.354228] system 00:0f: [io  0x2000-0x20fe] has been reserved
[    8.360198] system 00:0f: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    8.369054] system 00:10: [mem 0xfd6e0000-0xfd6effff] has been reserved
[    8.375726] system 00:10: [mem 0xfd6d0000-0xfd6dffff] has been reserved
[    8.382391] system 00:10: [mem 0xfd6a0000-0xfd6affff] has been reserved
[    8.389049] system 00:10: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    8.397519] pnp: PnP ACPI: found 17 devices
[    8.401740] initcall pnpacpi_init+0x0/0x73 returned 0 after 339674 usecs
[    8.408491] calling  chr_dev_init+0x0/0x150 @ 1
[    8.414220] initcall chr_dev_init+0x0/0x150 returned 0 after 1131 usecs
[    8.420883] calling  firmware_class_init+0x0/0xf2 @ 1
[    8.425990] initcall firmware_class_init+0x0/0xf2 returned 0 after 10 us=
ecs
[    8.433006] calling  map_properties+0x0/0x4f4 @ 1
[    8.437744] initcall map_properties+0x0/0x4f4 returned 0 after 0 usecs
[    8.444315] calling  init_acpi_pm_clocksource+0x0/0xdc @ 1
[    8.454342] clocksource: acpi_pm: freq: 3579545 Hz, mask: 0xffffff max_c=
ycles: 0xffffff, max_idle_ns: 2085701024 ns
[    8.464843] initcall init_acpi_pm_clocksource+0x0/0xdc returned 0 after =
14646 usecs
[    8.472549] calling  powercap_init+0x0/0x28e @ 1
[    8.477241] initcall powercap_init+0x0/0x28e returned 0 after 35 usecs
[    8.483820] calling  sysctl_core_init+0x0/0x31 @ 1
[    8.488666] initcall sysctl_core_init+0x0/0x31 returned 0 after 19 usecs
[    8.495412] calling  eth_offload_init+0x0/0x19 @ 1
[    8.500240] initcall eth_offload_init+0x0/0x19 returned 0 after 0 usecs
[    8.506900] calling  ipv4_offload_init+0x0/0x79 @ 1
[    8.511813] initcall ipv4_offload_init+0x0/0x79 returned 0 after 0 usecs
[    8.518559] calling  inet_init+0x0/0x28f @ 1
[    8.522884] NET: Registered protocol family 2
[    8.527483] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    8.536266] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    8.544656] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    8.552198] TCP: Hash tables configured (established 131072 bind 65536)
[    8.558859] ----------call_rcu 1---------
[    8.562956] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear=
)
[    8.569860] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    8.577209] initcall inet_init+0x0/0x28f returned 0 after 53067 usecs
[    8.583700] calling  af_unix_init+0x0/0x53 @ 1
[    8.588185] NET: Registered protocol family 1
[    8.592585] initcall af_unix_init+0x0/0x53 returned 0 after 4303 usecs
[    8.599161] calling  ipv6_offload_init+0x0/0x84 @ 1
[    8.604077] initcall ipv6_offload_init+0x0/0x84 returned 0 after 0 usecs
[    8.610825] calling  init_sunrpc+0x0/0x73 @ 1
[    8.615319] RPC: Registered named UNIX socket transport module.
[    8.621285] RPC: Registered udp transport module.
[    8.626025] RPC: Registered tcp transport module.
[    8.630763] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    8.637253] initcall init_sunrpc+0x0/0x73 returned 0 after 21520 usecs
[    8.643824] calling  vlan_offload_init+0x0/0x25 @ 1
[    8.648741] initcall vlan_offload_init+0x0/0x25 returned 0 after 0 usecs
[    8.655484] calling  xsk_init+0x0/0xba @ 1
[    8.659625] NET: Registered protocol family 44
[    8.664109] initcall xsk_init+0x0/0xba returned 0 after 4386 usecs
[    8.670332] calling  pcibios_assign_resources+0x0/0xc7 @ 1
[    8.675868] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    8.680885] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    8.685892] pci 0000:00:1c.4:   bridge window [mem 0xa1300000-0xa13fffff=
]
[    8.692726] pci 0000:00:1d.0: PCI bridge to [bus 03]
[    8.697735] pci 0000:00:1d.0:   bridge window [io  0x4000-0x4fff]
[    8.703870] pci 0000:00:1d.0:   bridge window [mem 0xa1200000-0xa12fffff=
]
[    8.710706] pci 0000:00:1d.1: PCI bridge to [bus 04]
[    8.715704] pci 0000:00:1d.1:   bridge window [io  0x3000-0x3fff]
[    8.721842] pci 0000:00:1d.1:   bridge window [mem 0xa1100000-0xa11fffff=
]
[    8.728682] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    8.734909] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    8.741132] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    8.748052] pci_bus 0000:00: resource 7 [mem 0x90000000-0xdfffffff windo=
w]
[    8.754974] pci_bus 0000:00: resource 8 [mem 0xfc800000-0xfe7fffff windo=
w]
[    8.761892] pci_bus 0000:02: resource 1 [mem 0xa1300000-0xa13fffff]
[    8.768202] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
[    8.773818] pci_bus 0000:03: resource 1 [mem 0xa1200000-0xa12fffff]
[    8.780126] pci_bus 0000:04: resource 0 [io  0x3000-0x3fff]
[    8.785742] pci_bus 0000:04: resource 1 [mem 0xa1100000-0xa11fffff]
[    8.792335] initcall pcibios_assign_resources+0x0/0xc7 returned 0 after =
113747 usecs
[    8.800133] calling  pci_apply_final_quirks+0x0/0x135 @ 1
[    8.805580] pci 0000:00:02.0: calling  pci_fixup_video+0x0/0x110 @ 1
[    8.811980] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    8.820381] pci 0000:00:02.0: pci_fixup_video+0x0/0x110 took 8205 usecs
[    8.827048] pci 0000:00:14.0: calling  quirk_usb_early_handoff+0x0/0x6a0=
 @ 1
[    8.834554] ----------call_rcu 1---------
[    8.838600] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x6a0 took 435=
0 usecs
[    8.846016] pci 0000:03:00.0: calling  quirk_e100_interrupt+0x0/0x1a0 @ =
1
[    8.852849] pci 0000:03:00.0: quirk_e100_interrupt+0x0/0x1a0 took 0 usec=
s
[    8.859684] pci 0000:04:00.0: calling  quirk_e100_interrupt+0x0/0x1a0 @ =
1
[    8.866517] pci 0000:04:00.0: quirk_e100_interrupt+0x0/0x1a0 took 0 usec=
s
[    8.873352] PCI: CLS 64 bytes, default 64
[    8.877393] initcall pci_apply_final_quirks+0x0/0x135 returned 0 after 7=
0138 usecs
[    8.885012] calling  acpi_reserve_resources+0x0/0xf0 @ 1
[    8.890373] initcall acpi_reserve_resources+0x0/0xf0 returned 0 after 8 =
usecs
[    8.897557] calling  populate_rootfs+0x0/0x10b @ 1
[    8.902399] dentry =3D 0xffff9d78dae6d9c0
[    8.906271] ----------call_rcu 1---------
[    8.910334] dentry =3D 0xffff9d78dae6dc00
[    8.914200] ----------call_rcu 1---------
[    8.918260] dentry =3D 0xffff9d78dae6d600
[    8.922134] __d_free dentry =3D 0xffff9d78dae6d9c0
[    8.926788] ----------call_rcu 1---------
[    8.930844] Trying to unpack rootfs image as initramfs...
[    8.936280] __d_free dentry =3D 0xffff9d78dae6dc00
[    8.941196] dentry =3D 0xffff9d78dae6dc00
[    8.945067] __d_free dentry =3D 0xffff9d78dae6d600
[    8.949720] ----------call_rcu 1---------
[    8.953782] dentry =3D 0xffff9d78dae6dd80
[    8.957652] ----------call_rcu 1---------
[    8.961707] dentry =3D 0xffff9d78dae6de40
[    8.965574] ----------call_rcu 1---------
[    8.969622] __d_free dentry =3D 0xffff9d78dae6dc00
[    8.974305] dentry =3D 0xffff9d78dae6d6c0
[    8.978180] __d_free dentry =3D 0xffff9d78dae6dd80
[    8.982838] ----------call_rcu 1---------
[    8.986879] file_free file =3D 0xffff9d78da8be8c0
[    8.991444] ----------call_rcu 1---------
[    8.995503] dentry =3D 0xffff9d78dae6db40
[    8.999378] __d_free dentry =3D 0xffff9d78dae6de40
[    9.004031] ----------call_rcu 1---------
[    9.008090] dentry =3D 0xffff9d78dae6d240
[    9.011962] __d_free dentry =3D 0xffff9d78dae6d6c0
[    9.011962] file_free_rcu file =3D 0xffff9d78da8be8c0
[    9.021535] ----------call_rcu 1---------
[    9.025578] file_free file =3D 0xffff9d78da8be000
[    9.030144] ----------call_rcu 1---------
[    9.034200] dentry =3D 0xffff9d78dae6d000
[    9.038068] __d_free dentry =3D 0xffff9d78dae6db40
[    9.042725] ----------call_rcu 1---------
[    9.046780] dentry =3D 0xffff9d78dae6e480
[    9.050654] __d_free dentry =3D 0xffff9d78dae6d240
[    9.050655] file_free_rcu file =3D 0xffff9d78da8be000
[    9.060226] ----------call_rcu 1---------
[    9.064282] dentry =3D 0xffff9d78dae6e540
[    9.068155] __d_free dentry =3D 0xffff9d78dae6d000
[    9.072811] ----------call_rcu 1---------
[    9.076868] dentry =3D 0xffff9d78dae6e0c0
[    9.080735] __d_free dentry =3D 0xffff9d78dae6e480
[    9.085390] ----------call_rcu 1---------
[    9.089446] dentry =3D 0xffff9d78dae6ef00
[    9.093313] __d_free dentry =3D 0xffff9d78dae6e540
[    9.097968] ----------call_rcu 1---------
[    9.102028] dentry =3D 0xffff9d78dae6e780
[    9.105899] __d_free dentry =3D 0xffff9d78dae6e0c0
[    9.110555] ----------call_rcu 1---------
[    9.114601] file_free file =3D 0xffff9d78da8be000
[    9.119162] ----------call_rcu 1---------
[    9.123222] dentry =3D 0xffff9d78dae6e3c0
[    9.127098] __d_free dentry =3D 0xffff9d78dae6ef00
[    9.131753] ----------call_rcu 1---------
[    9.135814] dentry =3D 0xffff9d78dae6ea80
[    9.139681] __d_free dentry =3D 0xffff9d78dae6e780
[    9.139682] file_free_rcu file =3D 0xffff9d78da8be000
[    9.149254] ----------call_rcu 1---------
[    9.153298] file_free file =3D 0xffff9d78da8be8c0
[    9.157866] ----------call_rcu 1---------
[    9.161925] dentry =3D 0xffff9d78dae6e9c0
[    9.165798] __d_free dentry =3D 0xffff9d78dae6e3c0
[    9.170452] ----------call_rcu 1---------
[    9.174499] file_free file =3D 0xffff9d78da8be000
[    9.179063] ----------call_rcu 1---------
[    9.183120] dentry =3D 0xffff9d78dae6ecc0
[    9.186994] __d_free dentry =3D 0xffff9d78dae6ea80
[    9.186994] file_free_rcu file =3D 0xffff9d78da8be8c0
[    9.196563] ----------call_rcu 1---------
[    9.200619] dentry =3D 0xffff9d78dae6ec00
[    9.204486] __d_free dentry =3D 0xffff9d78dae6e9c0
[    9.204487] file_free_rcu file =3D 0xffff9d78da8be000
[    9.214058] ----------call_rcu 1---------
[    9.218120] dentry =3D 0xffff9d78dae6e180
[    9.221992] __d_free dentry =3D 0xffff9d78dae6ecc0
[    9.226649] ----------call_rcu 1---------
[    9.230689] file_free file =3D 0xffff9d78da8be000
[    9.235258] ----------call_rcu 1---------
[    9.239317] dentry =3D 0xffff9d78dae6e600
[    9.243189] __d_free dentry =3D 0xffff9d78dae6ec00
[    9.247844] ----------call_rcu 1---------
[    9.251891] file_free file =3D 0xffff9d78da8be8c0
[    9.256454] ----------call_rcu 1---------
[    9.260517] dentry =3D 0xffff9d78dae6ed80
[    9.264385] __d_free dentry =3D 0xffff9d78dae6e180
[    9.264386] file_free_rcu file =3D 0xffff9d78da8be000
[    9.273957] ----------call_rcu 1---------
[    9.278001] file_free file =3D 0xffff9d78da8bf680
[    9.282568] ----------call_rcu 1---------
[    9.286627] dentry =3D 0xffff9d78dae6e840
[    9.290500] __d_free dentry =3D 0xffff9d78dae6e600
[    9.290501] file_free_rcu file =3D 0xffff9d78da8be8c0
[    9.300072] ----------call_rcu 1---------
[    9.304133] dentry =3D 0xffff9d78dae6ee40
[    9.308004] __d_free dentry =3D 0xffff9d78dae6ed80
[    9.308005] file_free_rcu file =3D 0xffff9d78da8bf680
[    9.317572] ----------call_rcu 1---------
[    9.321617] file_free file =3D 0xffff9d78da8be8c0
[    9.326187] ----------call_rcu 1---------
[    9.330243] dentry =3D 0xffff9d78dae6e6c0
[    9.334119] __d_free dentry =3D 0xffff9d78dae6e840
[    9.338772] ----------call_rcu 1---------
[    9.342832] dentry =3D 0xffff9d78dae6eb40
[    9.346705] __d_free dentry =3D 0xffff9d78dae6ee40
[    9.346706] file_free_rcu file =3D 0xffff9d78da8be8c0
[    9.356275] ----------call_rcu 1---------
[    9.360321] file_free file =3D 0xffff9d78da8bf680
[    9.364885] ----------call_rcu 1---------
[    9.368942] dentry =3D 0xffff9d78dae6e240
[    9.372806] __d_free dentry =3D 0xffff9d78dae6e6c0
[    9.377465] ----------call_rcu 1---------
[    9.381519] dentry =3D 0xffff9d78dae6e000
[    9.385387] __d_free dentry =3D 0xffff9d78dae6eb40
[    9.385388] file_free_rcu file =3D 0xffff9d78da8bf680
[    9.394957] ----------call_rcu 1---------
[    9.399016] dentry =3D 0xffff9d78dae6d000
[    9.402889] __d_free dentry =3D 0xffff9d78dae6e240
[    9.407544] ----------call_rcu 1---------
[    9.411587] file_free file =3D 0xffff9d78da8bf680
[    9.416153] ----------call_rcu 1---------
[    9.420214] dentry =3D 0xffff9d78dae6e240
[    9.424087] __d_free dentry =3D 0xffff9d78dae6e000
[    9.428744] ----------call_rcu 1---------
[    9.432788] file_free file =3D 0xffff9d78da8be8c0
[    9.437354] ----------call_rcu 1---------
[    9.441419] dentry =3D 0xffff9d78dae6f3c0
[    9.445293] __d_free dentry =3D 0xffff9d78dae6d000
[    9.445294] file_free_rcu file =3D 0xffff9d78da8bf680
[    9.454862] ----------call_rcu 1---------
[    9.458907] file_free file =3D 0xffff9d78da8be000
[    9.463475] ----------call_rcu 1---------
[    9.467535] dentry =3D 0xffff9d78dae6f9c0
[    9.471409] __d_free dentry =3D 0xffff9d78dae6e240
[    9.471409] file_free_rcu file =3D 0xffff9d78da8be8c0
[    9.480975] ----------call_rcu 1---------
[    9.485024] file_free file =3D 0xffff9d78da8bf680
[    9.489590] ----------call_rcu 1---------
[    9.493649] dentry =3D 0xffff9d78dae6fc00
[    9.497519] ----------call_rcu 1---------
[    9.501565] __d_free dentry =3D 0xffff9d78dae6f3c0
[    9.501565] file_free_rcu file =3D 0xffff9d78da8be000
[    9.511138] file_free file =3D 0xffff9d78da8be8c0
[    9.515703] ----------call_rcu 1---------
[    9.519761] dentry =3D 0xffff9d78dae6f180
[    9.523636] __d_free dentry =3D 0xffff9d78dae6f9c0
[    9.523637] file_free_rcu file =3D 0xffff9d78da8bf680
[    9.533207] ----------call_rcu 1---------
[    9.537266] dentry =3D 0xffff9d78dae6f600
[    9.541139] __d_free dentry =3D 0xffff9d78dae6fc00
[    9.541139] file_free_rcu file =3D 0xffff9d78da8be8c0
[    9.550706] ----------call_rcu 1---------
[    9.554753] file_free file =3D 0xffff9d78da8bf680
[    9.559319] ----------call_rcu 1---------
[    9.563382] dentry =3D 0xffff9d78dae6fd80
[    9.567250] __d_free dentry =3D 0xffff9d78dae6f180
[    9.571908] ----------call_rcu 1---------
[    9.575951] file_free file =3D 0xffff9d78da8be8c0
[    9.580519] ----------call_rcu 1---------
[    9.584579] dentry =3D 0xffff9d78dae6f840
[    9.588448] __d_free dentry =3D 0xffff9d78dae6f600
[    9.588449] file_free_rcu file =3D 0xffff9d78da8bf680
[    9.598019] ----------call_rcu 1---------
[    9.602066] file_free file =3D 0xffff9d78da8be000
[    9.606631] ----------call_rcu 1---------
[    9.610693] dentry =3D 0xffff9d78dae6fe40
[    9.614562] __d_free dentry =3D 0xffff9d78dae6fd80
[    9.614563] file_free_rcu file =3D 0xffff9d78da8be8c0
[    9.624134] ----------call_rcu 1---------
[    9.628178] file_free file =3D 0xffff9d78da8bf680
[    9.632746] ----------call_rcu 1---------
[    9.636967] dentry =3D 0xffff9d78dae6f6c0
[    9.640835] __d_free dentry =3D 0xffff9d78dae6f840
[    9.640836] file_free_rcu file =3D 0xffff9d78da8be000
[    9.650405] ----------call_rcu 1---------
[    9.654449] file_free file =3D 0xffff9d78da8be8c0
[    9.659018] ----------call_rcu 1---------
[    9.663078] dentry =3D 0xffff9d78dae6fb40
[    9.666948] __d_free dentry =3D 0xffff9d78dae6fe40
[    9.666949] file_free_rcu file =3D 0xffff9d78da8bf680
[    9.676519] ----------call_rcu 1---------
[    9.680581] dentry =3D 0xffff9d78dae6f240
[    9.684453] __d_free dentry =3D 0xffff9d78dae6f6c0
[    9.684453] file_free_rcu file =3D 0xffff9d78da8be8c0
[    9.694019] ----------call_rcu 1---------
[    9.698067] file_free file =3D 0xffff9d78da8bf680
[    9.702631] ----------call_rcu 1---------
[    9.706695] dentry =3D 0xffff9d78dae6f000
[    9.710567] __d_free dentry =3D 0xffff9d78dae6fb40
[    9.715220] ----------call_rcu 1---------
[    9.719264] file_free file =3D 0xffff9d78da8be8c0
[    9.723832] ----------call_rcu 1---------
[    9.727888] dentry =3D 0xffff9d78dae6f480
[    9.731754] __d_free dentry =3D 0xffff9d78dae6f240
[    9.731754] file_free_rcu file =3D 0xffff9d78da8bf680
[    9.741324] ----------call_rcu 1---------
[    9.745380] dentry =3D 0xffff9d78dae6f300
[    9.749246] __d_free dentry =3D 0xffff9d78dae6f000
[    9.749247] file_free_rcu file =3D 0xffff9d78da8be8c0
[    9.758815] ----------call_rcu 1---------
[    9.762879] dentry =3D 0xffff9d78dae6f540
[    9.766749] __d_free dentry =3D 0xffff9d78dae6f480
[    9.771406] ----------call_rcu 1---------
[    9.775451] file_free file =3D 0xffff9d78da8be8c0
[    9.780017] ----------call_rcu 1---------
[    9.784079] dentry =3D 0xffff9d78dae6f900
[    9.787950] __d_free dentry =3D 0xffff9d78dae6f300
[    9.792605] ----------call_rcu 1---------
[    9.796649] file_free file =3D 0xffff9d78da8bf680
[    9.801212] ----------call_rcu 1---------
[    9.805615] __d_free dentry =3D 0xffff9d78dae6f540
[    9.810269] file_free_rcu file =3D 0xffff9d78da8be8c0
[    9.816358] dentry =3D 0xffff9d78dae6f540
[    9.820226] __d_free dentry =3D 0xffff9d78dae6f900
[    9.820227] file_free_rcu file =3D 0xffff9d78da8bf680
[    9.829796] ----------call_rcu 1---------
[    9.833841] file_free file =3D 0xffff9d78da8be000
[    9.838405] ----------call_rcu 1---------
[    9.842753] dentry =3D 0xffff9d78dae6f0c0
[    9.846627] ----------call_rcu 1---------
[    9.850675] file_free file =3D 0xffff9d78da8bf680
[    9.855239] ----------call_rcu 1---------
[    9.859439] dentry =3D 0xffff9d78dae6f780
[    9.863311] __d_free dentry =3D 0xffff9d78dae6f540
[    9.863312] file_free_rcu file =3D 0xffff9d78da8be000
[    9.872879] ----------call_rcu 1---------
[    9.876927] file_free file =3D 0xffff9d78da8be8c0
[    9.881490] ----------call_rcu 1---------
[    9.885556] dentry =3D 0xffff9d78dae6e240
[    9.889425] __d_free dentry =3D 0xffff9d78dae6f0c0
[    9.889426] file_free_rcu file =3D 0xffff9d78da8bf680
[    9.898991] ----------call_rcu 1---------
[    9.903041] file_free file =3D 0xffff9d78da8be000
[    9.907603] ----------call_rcu 1---------
[    9.911670] dentry =3D 0xffff9d78dae6d000
[    9.915537] __d_free dentry =3D 0xffff9d78dae6f780
[    9.915538] file_free_rcu file =3D 0xffff9d78da8be8c0
[    9.925106] ----------call_rcu 1---------
[    9.929154] file_free file =3D 0xffff9d78da8bf680
[    9.933717] ----------call_rcu 1---------
[    9.941616] __d_free dentry =3D 0xffff9d78dae6e240
[    9.946272] file_free_rcu file =3D 0xffff9d78da8be000
[    9.952545] dentry =3D 0xffff9d78dae6e240
[    9.956419] __d_free dentry =3D 0xffff9d78dae6d000
[    9.956420] file_free_rcu file =3D 0xffff9d78da8bf680
[    9.965985] ----------call_rcu 1---------
[    9.970032] file_free file =3D 0xffff9d78da8be8c0
[    9.974600] ----------call_rcu 1---------
[    9.978671] dentry =3D 0xffff9d78dae70f00
[    9.982538] ----------call_rcu 1---------
[    9.986588] file_free file =3D 0xffff9d78da8bf680
[    9.991152] ----------call_rcu 1---------
[    9.995218] dentry =3D 0xffff9d78dae703c0
[    9.999093] __d_free dentry =3D 0xffff9d78dae6e240
[    9.999093] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.008661] ----------call_rcu 1---------
[   10.012709] file_free file =3D 0xffff9d78da8be000
[   10.017274] ----------call_rcu 1---------
[   10.021615] __d_free dentry =3D 0xffff9d78dae70f00
[   10.026267] file_free_rcu file =3D 0xffff9d78da8bf680
[   10.031208] dentry =3D 0xffff9d78dae70f00
[   10.035082] __d_free dentry =3D 0xffff9d78dae703c0
[   10.035082] file_free_rcu file =3D 0xffff9d78da8be000
[   10.044652] ----------call_rcu 1---------
[   10.048698] file_free file =3D 0xffff9d78da8be8c0
[   10.053263] ----------call_rcu 1---------
[   10.057422] dentry =3D 0xffff9d78dae709c0
[   10.061292] ----------call_rcu 1---------
[   10.065338] file_free file =3D 0xffff9d78da8be000
[   10.069901] ----------call_rcu 1---------
[   10.073968] dentry =3D 0xffff9d78dae70c00
[   10.077835] __d_free dentry =3D 0xffff9d78dae70f00
[   10.077835] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.087403] ----------call_rcu 1---------
[   10.091451] file_free file =3D 0xffff9d78da8bf680
[   10.096017] ----------call_rcu 1---------
[   10.100080] dentry =3D 0xffff9d78dae70180
[   10.103948] __d_free dentry =3D 0xffff9d78dae709c0
[   10.103948] file_free_rcu file =3D 0xffff9d78da8be000
[   10.113517] ----------call_rcu 1---------
[   10.117563] file_free file =3D 0xffff9d78da8be8c0
[   10.122132] ----------call_rcu 1---------
[   10.126234] dentry =3D 0xffff9d78dae70600
[   10.130106] __d_free dentry =3D 0xffff9d78dae70c00
[   10.130107] file_free_rcu file =3D 0xffff9d78da8bf680
[   10.139676] ----------call_rcu 1---------
[   10.143722] file_free file =3D 0xffff9d78da8be000
[   10.148289] ----------call_rcu 1---------
[   10.152354] dentry =3D 0xffff9d78dae70d80
[   10.156229] __d_free dentry =3D 0xffff9d78dae70180
[   10.156230] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.165799] ----------call_rcu 1---------
[   10.169845] file_free file =3D 0xffff9d78da8bf680
[   10.174412] ----------call_rcu 1---------
[   10.178475] dentry =3D 0xffff9d78dae70840
[   10.182344] __d_free dentry =3D 0xffff9d78dae70600
[   10.182345] file_free_rcu file =3D 0xffff9d78da8be000
[   10.191912] ----------call_rcu 1---------
[   10.195957] file_free file =3D 0xffff9d78da8be8c0
[   10.200522] ----------call_rcu 1---------
[   10.204588] dentry =3D 0xffff9d78dae70e40
[   10.208458] __d_free dentry =3D 0xffff9d78dae70d80
[   10.208458] file_free_rcu file =3D 0xffff9d78da8bf680
[   10.218027] ----------call_rcu 1---------
[   10.222071] file_free file =3D 0xffff9d78da8be000
[   10.226637] ----------call_rcu 1---------
[   10.230811] dentry =3D 0xffff9d78dae706c0
[   10.234686] __d_free dentry =3D 0xffff9d78dae70840
[   10.234687] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.244252] ----------call_rcu 1---------
[   10.248299] file_free file =3D 0xffff9d78da8bf680
[   10.252866] ----------call_rcu 1---------
[   10.256935] dentry =3D 0xffff9d78dae70b40
[   10.260806] __d_free dentry =3D 0xffff9d78dae70e40
[   10.260807] file_free_rcu file =3D 0xffff9d78da8be000
[   10.270375] ----------call_rcu 1---------
[   10.274425] file_free file =3D 0xffff9d78da8be8c0
[   10.278989] ----------call_rcu 1---------
[   10.283052] dentry =3D 0xffff9d78dae70240
[   10.286921] __d_free dentry =3D 0xffff9d78dae706c0
[   10.286921] file_free_rcu file =3D 0xffff9d78da8bf680
[   10.296493] ----------call_rcu 1---------
[   10.300537] file_free file =3D 0xffff9d78da8be000
[   10.305103] ----------call_rcu 1---------
[   10.309166] dentry =3D 0xffff9d78dae70000
[   10.313034] __d_free dentry =3D 0xffff9d78dae70b40
[   10.313034] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.322606] ----------call_rcu 1---------
[   10.326652] file_free file =3D 0xffff9d78da8bf680
[   10.331218] ----------call_rcu 1---------
[   10.335413] dentry =3D 0xffff9d78dae70480
[   10.339280] __d_free dentry =3D 0xffff9d78dae70240
[   10.339281] file_free_rcu file =3D 0xffff9d78da8be000
[   10.348850] ----------call_rcu 1---------
[   10.352895] file_free file =3D 0xffff9d78da8be8c0
[   10.357463] ----------call_rcu 1---------
[   10.361528] dentry =3D 0xffff9d78dae70300
[   10.365401] __d_free dentry =3D 0xffff9d78dae70000
[   10.365401] file_free_rcu file =3D 0xffff9d78da8bf680
[   10.374972] ----------call_rcu 1---------
[   10.379020] file_free file =3D 0xffff9d78da8be000
[   10.383583] ----------call_rcu 1---------
[   10.387654] dentry =3D 0xffff9d78dae70540
[   10.391526] __d_free dentry =3D 0xffff9d78dae70480
[   10.391526] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.401093] ----------call_rcu 1---------
[   10.405142] file_free file =3D 0xffff9d78da8bf680
[   10.409708] ----------call_rcu 1---------
[   10.413771] dentry =3D 0xffff9d78dae70900
[   10.417638] __d_free dentry =3D 0xffff9d78dae70300
[   10.417638] file_free_rcu file =3D 0xffff9d78da8be000
[   10.427207] ----------call_rcu 1---------
[   10.431254] file_free file =3D 0xffff9d78da8be8c0
[   10.435821] ----------call_rcu 1---------
[   10.440073] dentry =3D 0xffff9d78dae700c0
[   10.443944] __d_free dentry =3D 0xffff9d78dae70540
[   10.443944] file_free_rcu file =3D 0xffff9d78da8bf680
[   10.453513] ----------call_rcu 1---------
[   10.457561] file_free file =3D 0xffff9d78da8be000
[   10.462128] ----------call_rcu 1---------
[   10.466197] dentry =3D 0xffff9d78dae6e240
[   10.470067] __d_free dentry =3D 0xffff9d78dae70900
[   10.470067] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.479638] ----------call_rcu 1---------
[   10.483685] file_free file =3D 0xffff9d78da8bf680
[   10.488249] ----------call_rcu 1---------
[   10.492618] dentry =3D 0xffff9d78dae71240
[   10.496487] __d_free dentry =3D 0xffff9d78dae700c0
[   10.496488] file_free_rcu file =3D 0xffff9d78da8be000
[   10.506057] ----------call_rcu 1---------
[   10.510103] file_free file =3D 0xffff9d78da8be8c0
[   10.514669] ----------call_rcu 1---------
[   10.519230] dentry =3D 0xffff9d78dae71480
[   10.523099] __d_free dentry =3D 0xffff9d78dae6e240
[   10.523100] file_free_rcu file =3D 0xffff9d78da8bf680
[   10.532669] ----------call_rcu 1---------
[   10.536714] file_free file =3D 0xffff9d78da8be000
[   10.541279] ----------call_rcu 1---------
[   10.545348] dentry =3D 0xffff9d78dae71540
[   10.549220] __d_free dentry =3D 0xffff9d78dae71240
[   10.549221] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.558791] ----------call_rcu 1---------
[   10.562835] file_free file =3D 0xffff9d78da8bf680
[   10.567401] ----------call_rcu 1---------
[   10.571470] dentry =3D 0xffff9d78dae71900
[   10.575343] __d_free dentry =3D 0xffff9d78dae71480
[   10.575344] file_free_rcu file =3D 0xffff9d78da8be000
[   10.584911] ----------call_rcu 1---------
[   10.588957] file_free file =3D 0xffff9d78da8be8c0
[   10.593523] ----------call_rcu 1---------
[   10.597615] __d_free dentry =3D 0xffff9d78dae71540
[   10.602267] file_free_rcu file =3D 0xffff9d78da8bf680
[   10.607249] dentry =3D 0xffff9d78dae71540
[   10.611124] __d_free dentry =3D 0xffff9d78dae71900
[   10.611125] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.620694] ----------call_rcu 1---------
[   10.624740] file_free file =3D 0xffff9d78da8be000
[   10.629306] ----------call_rcu 1---------
[   10.633371] dentry =3D 0xffff9d78dae710c0
[   10.637245] ----------call_rcu 1---------
[   10.641293] file_free file =3D 0xffff9d78da8be8c0
[   10.645855] ----------call_rcu 1---------
[   10.649923] dentry =3D 0xffff9d78dae71780
[   10.653790] __d_free dentry =3D 0xffff9d78dae71540
[   10.653791] file_free_rcu file =3D 0xffff9d78da8be000
[   10.663358] ----------call_rcu 1---------
[   10.667405] file_free file =3D 0xffff9d78da8bf680
[   10.671971] ----------call_rcu 1---------
[   10.676036] dentry =3D 0xffff9d78dae713c0
[   10.679906] __d_free dentry =3D 0xffff9d78dae710c0
[   10.679906] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.689474] ----------call_rcu 1---------
[   10.693519] file_free file =3D 0xffff9d78da8be000
[   10.698086] ----------call_rcu 1---------
[   10.702353] dentry =3D 0xffff9d78dae71a80
[   10.706229] __d_free dentry =3D 0xffff9d78dae71780
[   10.706230] file_free_rcu file =3D 0xffff9d78da8bf680
[   10.715795] ----------call_rcu 1---------
[   10.719843] file_free file =3D 0xffff9d78da8be8c0
[   10.724408] ----------call_rcu 1---------
[   10.728468] dentry =3D 0xffff9d78dae719c0
[   10.732339] __d_free dentry =3D 0xffff9d78dae713c0
[   10.732340] file_free_rcu file =3D 0xffff9d78da8be000
[   10.741912] ----------call_rcu 1---------
[   10.745967] dentry =3D 0xffff9d78dae71cc0
[   10.749835] __d_free dentry =3D 0xffff9d78dae71a80
[   10.749836] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.759404] ----------call_rcu 1---------
[   10.763458] dentry =3D 0xffff9d78dae71c00
[   10.767328] __d_free dentry =3D 0xffff9d78dae719c0
[   10.771984] ----------call_rcu 1---------
[   10.776037] dentry =3D 0xffff9d78dae71180
[   10.779904] __d_free dentry =3D 0xffff9d78dae71cc0
[   10.784562] ----------call_rcu 1---------
[   10.788615] dentry =3D 0xffff9d78dae71600
[   10.792484] __d_free dentry =3D 0xffff9d78dae71c00
[   10.797140] ----------call_rcu 1---------
[   10.801195] dentry =3D 0xffff9d78dae71d80
[   10.805068] __d_free dentry =3D 0xffff9d78dae71180
[   10.809725] ----------call_rcu 1---------
[   10.813779] dentry =3D 0xffff9d78dae71840
[   10.817648] __d_free dentry =3D 0xffff9d78dae71600
[   10.822304] ----------call_rcu 1---------
[   10.826358] dentry =3D 0xffff9d78dae71e40
[   10.830225] __d_free dentry =3D 0xffff9d78dae71d80
[   10.834879] ----------call_rcu 1---------
[   10.839828] dentry =3D 0xffff9d78dae716c0
[   10.843700] __d_free dentry =3D 0xffff9d78dae71840
[   10.848357] ----------call_rcu 1---------
[   10.852402] file_free file =3D 0xffff9d78da8be8c0
[   10.856966] ----------call_rcu 1---------
[   10.861032] dentry =3D 0xffff9d78dae71b40
[   10.864908] __d_free dentry =3D 0xffff9d78dae71e40
[   10.869562] ----------call_rcu 1---------
[   10.873608] file_free file =3D 0xffff9d78da8be000
[   10.878172] ----------call_rcu 1---------
[   10.882235] dentry =3D 0xffff9d78dae6e240
[   10.886104] __d_free dentry =3D 0xffff9d78dae716c0
[   10.886105] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.895675] ----------call_rcu 1---------
[   10.899722] file_free file =3D 0xffff9d78da8bf680
[   10.904287] ----------call_rcu 1---------
[   10.908351] dentry =3D 0xffff9d78dae700c0
[   10.912221] __d_free dentry =3D 0xffff9d78dae71b40
[   10.912221] file_free_rcu file =3D 0xffff9d78da8be000
[   10.921788] ----------call_rcu 1---------
[   10.925834] file_free file =3D 0xffff9d78da8be8c0
[   10.930401] ----------call_rcu 1---------
[   10.934466] dentry =3D 0xffff9d78dae72180
[   10.938333] __d_free dentry =3D 0xffff9d78dae6e240
[   10.938333] file_free_rcu file =3D 0xffff9d78da8bf680
[   10.947902] ----------call_rcu 1---------
[   10.951947] file_free file =3D 0xffff9d78da8be000
[   10.956512] ----------call_rcu 1---------
[   10.960866] dentry =3D 0xffff9d78dae72d80
[   10.964735] __d_free dentry =3D 0xffff9d78dae700c0
[   10.964736] file_free_rcu file =3D 0xffff9d78da8be8c0
[   10.974303] ----------call_rcu 1---------
[   10.978350] file_free file =3D 0xffff9d78da8bf680
[   10.982915] ----------call_rcu 1---------
[   10.986980] dentry =3D 0xffff9d78dae72e40
[   10.990849] __d_free dentry =3D 0xffff9d78dae72180
[   10.990850] file_free_rcu file =3D 0xffff9d78da8be000
[   11.000420] ----------call_rcu 1---------
[   11.004462] file_free file =3D 0xffff9d78da8be8c0
[   11.009030] ----------call_rcu 1---------
[   11.013095] dentry =3D 0xffff9d78dae726c0
[   11.016963] __d_free dentry =3D 0xffff9d78dae72d80
[   11.016964] file_free_rcu file =3D 0xffff9d78da8bf680
[   11.026533] ----------call_rcu 1---------
[   11.030580] file_free file =3D 0xffff9d78da8be000
[   11.035142] ----------call_rcu 1---------
[   11.039206] dentry =3D 0xffff9d78dae72b40
[   11.043077] __d_free dentry =3D 0xffff9d78dae72e40
[   11.043077] file_free_rcu file =3D 0xffff9d78da8be8c0
[   11.052648] ----------call_rcu 1---------
[   11.056692] file_free file =3D 0xffff9d78da8bf680
[   11.061259] ----------call_rcu 1---------
[   11.065321] dentry =3D 0xffff9d78dae72240
[   11.069189] __d_free dentry =3D 0xffff9d78dae726c0
[   11.069189] file_free_rcu file =3D 0xffff9d78da8be000
[   11.078760] ----------call_rcu 1---------
[   11.082807] file_free file =3D 0xffff9d78da8be8c0
[   11.087372] ----------call_rcu 1---------
[   11.091432] dentry =3D 0xffff9d78dae72000
[   11.095304] __d_free dentry =3D 0xffff9d78dae72b40
[   11.095305] file_free_rcu file =3D 0xffff9d78da8bf680
[   11.104876] ----------call_rcu 1---------
[   11.108919] file_free file =3D 0xffff9d78da8be000
[   11.113485] ----------call_rcu 1---------
[   11.117547] dentry =3D 0xffff9d78dae72480
[   11.121420] __d_free dentry =3D 0xffff9d78dae72240
[   11.121421] file_free_rcu file =3D 0xffff9d78da8be8c0
[   11.130987] ----------call_rcu 1---------
[   11.135033] file_free file =3D 0xffff9d78da8bf680
[   11.139598] ----------call_rcu 1---------
[   11.144185] dentry =3D 0xffff9d78dae72300
[   11.148057] __d_free dentry =3D 0xffff9d78dae72000
[   11.148057] file_free_rcu file =3D 0xffff9d78da8be000
[   11.157624] ----------call_rcu 1---------
[   11.161672] file_free file =3D 0xffff9d78da8be8c0
[   11.166235] ----------call_rcu 1---------
[   11.170299] dentry =3D 0xffff9d78dae72540
[   11.174168] dentry =3D 0xffff9d78dae72480
[   11.174169] file_free_rcu file =3D 0xffff9d78da8bf680
[   11.182955] ----------call_rcu 1---------
[   11.187017] dentry =3D 0xffff9d78dae72900
[   11.190889] __d_free dentry =3D 0xffff9d78dae72300
[   11.190889] file_free_rcu file =3D 0xffff9d78da8be8c0
[   11.200456] ----------call_rcu 1---------
[   11.204502] file_free file =3D 0xffff9d78da8bf680
[   11.209068] ----------call_rcu 1---------
[   11.213130] dentry =3D 0xffff9d78dae720c0
[   11.217003] __d_free dentry =3D 0xffff9d78dae72540
[   11.221659] ----------call_rcu 1---------
[   11.225701] file_free file =3D 0xffff9d78da8be8c0
[   11.230267] ----------call_rcu 1---------
[   11.234328] dentry =3D 0xffff9d78dae72f00
[   11.238199] __d_free dentry =3D 0xffff9d78dae72900
[   11.238200] file_free_rcu file =3D 0xffff9d78da8bf680
[   11.247770] ----------call_rcu 1---------
[   11.251813] file_free file =3D 0xffff9d78da8be000
[   11.256380] ----------call_rcu 1---------
[   11.260440] dentry =3D 0xffff9d78dae72780
[   11.264315] __d_free dentry =3D 0xffff9d78dae720c0
[   11.264315] file_free_rcu file =3D 0xffff9d78da8be8c0
[   11.273884] ----------call_rcu 1---------
[   11.281616] __d_free dentry =3D 0xffff9d78dae72f00
[   11.286268] file_free_rcu file =3D 0xffff9d78da8be000
[   11.292780] dentry =3D 0xffff9d78dae72f00
[   11.296652] __d_free dentry =3D 0xffff9d78dae72780
[   11.301309] ----------call_rcu 1---------
[   11.305351] file_free file =3D 0xffff9d78da8be8c0
[   11.309918] ----------call_rcu 1---------
[   11.313979] dentry =3D 0xffff9d78dae723c0
[   11.317849] ----------call_rcu 1---------
[   11.321914] dentry =3D 0xffff9d78dae729c0
[   11.325779] __d_free dentry =3D 0xffff9d78dae72f00
[   11.325780] file_free_rcu file =3D 0xffff9d78da8be8c0
[   11.335349] ----------call_rcu 1---------
[   11.339397] file_free file =3D 0xffff9d78da8be000
[   11.343964] ----------call_rcu 1---------
[   11.348019] dentry =3D 0xffff9d78dae72cc0
[   11.351885] __d_free dentry =3D 0xffff9d78dae723c0
[   11.356542] ----------call_rcu 1---------
[   11.360598] dentry =3D 0xffff9d78dae72c00
[   11.364474] __d_free dentry =3D 0xffff9d78dae729c0
[   11.364475] file_free_rcu file =3D 0xffff9d78da8be000
[   11.374042] ----------call_rcu 1---------
[   11.379586] dentry =3D 0xffff9d78dae700c0
[   11.383459] __d_free dentry =3D 0xffff9d78dae72cc0
[   11.388113] ----------call_rcu 1---------
[   11.392157] file_free file =3D 0xffff9d78da8be000
[   11.396720] ----------call_rcu 1---------
[   11.401616] __d_free dentry =3D 0xffff9d78dae72c00
[   11.409616] __d_free dentry =3D 0xffff9d78dae700c0
[   11.414266] file_free_rcu file =3D 0xffff9d78da8be000
[   11.428370] dentry =3D 0xffff9d78dae72c00
[   11.432243] ----------call_rcu 1---------
[   11.436292] file_free file =3D 0xffff9d78da8be8c0
[   11.440863] ----------call_rcu 1---------
[   11.444923] dentry =3D 0xffff9d78dae6e240
[   11.448794] ----------call_rcu 1---------
[   11.453088] dentry =3D 0xffff9d78dae73cc0
[   11.456960] __d_free dentry =3D 0xffff9d78dae72c00
[   11.461619] ----------call_rcu 1---------
[   11.465662] file_free file =3D 0xffff9d78da8be000
[   11.470224] ----------call_rcu 1---------
[   11.474296] dentry =3D 0xffff9d78dae73180
[   11.478168] file_free_rcu file =3D 0xffff9d78da8be8c0
[   11.478169] __d_free dentry =3D 0xffff9d78dae6e240
[   11.487739] ----------call_rcu 1---------
[   11.491782] file_free file =3D 0xffff9d78da8bf680
[   11.496350] ----------call_rcu 1---------
[   11.500410] dentry =3D 0xffff9d78dae73d80
[   11.504282] __d_free dentry =3D 0xffff9d78dae73cc0
[   11.504283] file_free_rcu file =3D 0xffff9d78da8be000
[   11.513852] ----------call_rcu 1---------
[   11.517909] dentry =3D 0xffff9d78dae73840
[   11.521782] __d_free dentry =3D 0xffff9d78dae73180
[   11.521782] file_free_rcu file =3D 0xffff9d78da8bf680
[   11.531354] ----------call_rcu 1---------
[   11.535411] dentry =3D 0xffff9d78dae73e40
[   11.539285] __d_free dentry =3D 0xffff9d78dae73d80
[   11.543942] ----------call_rcu 1---------
[   11.549375] dentry =3D 0xffff9d78dae736c0
[   11.553251] __d_free dentry =3D 0xffff9d78dae73840
[   11.557909] ----------call_rcu 1---------
[   11.561951] file_free file =3D 0xffff9d78da8bf680
[   11.566516] ----------call_rcu 1---------
[   11.573616] __d_free dentry =3D 0xffff9d78dae73e40
[   11.578491] dentry =3D 0xffff9d78dae73e40
[   11.582364] __d_free dentry =3D 0xffff9d78dae736c0
[   11.582364] file_free_rcu file =3D 0xffff9d78da8bf680
[   11.591933] ----------call_rcu 1---------
[   11.595978] file_free file =3D 0xffff9d78da8be000
[   11.600543] ----------call_rcu 1---------
[   11.604608] dentry =3D 0xffff9d78dae73b40
[   11.608476] ----------call_rcu 1---------
[   11.613616] __d_free dentry =3D 0xffff9d78dae73e40
[   11.618273] file_free_rcu file =3D 0xffff9d78da8be000
[   11.623600] dentry =3D 0xffff9d78dae73e40
[   11.627468] __d_free dentry =3D 0xffff9d78dae73b40
[   11.632126] ----------call_rcu 1---------
[   11.636169] file_free file =3D 0xffff9d78da8bf680
[   11.640735] ----------call_rcu 1---------
[   11.644797] dentry =3D 0xffff9d78dae73000
[   11.648668] ----------call_rcu 1---------
[   11.652728] dentry =3D 0xffff9d78dae73300
[   11.656600] __d_free dentry =3D 0xffff9d78dae73e40
[   11.656600] file_free_rcu file =3D 0xffff9d78da8bf680
[   11.666168] ----------call_rcu 1---------
[   11.670228] dentry =3D 0xffff9d78dae73540
[   11.674099] __d_free dentry =3D 0xffff9d78dae73000
[   11.678758] ----------call_rcu 1---------
[   11.683073] dentry =3D 0xffff9d78dae73900
[   11.686941] __d_free dentry =3D 0xffff9d78dae73300
[   11.691596] ----------call_rcu 1---------
[   11.695642] file_free file =3D 0xffff9d78da8bf680
[   11.700207] ----------call_rcu 1---------
[   11.704266] dentry =3D 0xffff9d78dae730c0
[   11.708138] __d_free dentry =3D 0xffff9d78dae73540
[   11.712795] ----------call_rcu 1---------
[   11.717616] __d_free dentry =3D 0xffff9d78dae73900
[   11.722268] file_free_rcu file =3D 0xffff9d78da8bf680
[   11.729616] __d_free dentry =3D 0xffff9d78dae730c0
[   11.746464] dentry =3D 0xffff9d78dae730c0
[   11.750334] ----------call_rcu 1---------
[   11.754384] file_free file =3D 0xffff9d78da8be000
[   11.758956] ----------call_rcu 1---------
[   11.763028] dentry =3D 0xffff9d78dae73f00
[   11.766893] ----------call_rcu 1---------
[   11.770944] file_free file =3D 0xffff9d78da8bf680
[   11.775516] ----------call_rcu 1---------
[   11.781616] __d_free dentry =3D 0xffff9d78dae730c0
[   11.789616] file_free_rcu file =3D 0xffff9d78da8be000
[   11.794535] __d_free dentry =3D 0xffff9d78dae73f00
[   11.799187] file_free_rcu file =3D 0xffff9d78da8bf680
[   11.821229] dentry =3D 0xffff9d78dae73f00
[   11.825102] ----------call_rcu 1---------
[   11.829150] file_free file =3D 0xffff9d78da8be8c0
[   11.833722] ----------call_rcu 1---------
[   11.842538] dentry =3D 0xffff9d78dae733c0
[   11.846415] ----------call_rcu 1---------
[   11.850467] file_free file =3D 0xffff9d78da8bf680
[   11.855033] __d_free dentry =3D 0xffff9d78dae73f00
[   11.859688] ----------call_rcu 1---------
[   11.865617] file_free_rcu file =3D 0xffff9d78da8be8c0
[   11.870532] __d_free dentry =3D 0xffff9d78dae733c0
[   11.876453] dentry =3D 0xffff9d78dae733c0
[   11.880330] file_free_rcu file =3D 0xffff9d78da8bf680
[   11.885246] ----------call_rcu 1---------
[   11.889290] file_free file =3D 0xffff9d78da8be000
[   11.893856] ----------call_rcu 1---------
[   11.897917] dentry =3D 0xffff9d78dae6e240
[   11.901789] ----------call_rcu 1---------
[   11.906914] dentry =3D 0xffff9d78dae74d80
[   11.910785] __d_free dentry =3D 0xffff9d78dae733c0
[   11.910786] file_free_rcu file =3D 0xffff9d78da8be000
[   11.920353] ----------call_rcu 1---------
[   11.924398] file_free file =3D 0xffff9d78da8bf680
[   11.928964] ----------call_rcu 1---------
[   11.933616] __d_free dentry =3D 0xffff9d78dae6e240
[   11.939236] dentry =3D 0xffff9d78dae74e40
[   11.943103] __d_free dentry =3D 0xffff9d78dae74d80
[   11.943104] file_free_rcu file =3D 0xffff9d78da8bf680
[   11.952674] ----------call_rcu 1---------
[   11.956719] file_free file =3D 0xffff9d78da8be000
[   11.961283] ----------call_rcu 1---------
[   11.966217] dentry =3D 0xffff9d78dae746c0
[   11.970090] ----------call_rcu 1---------
[   11.974140] file_free file =3D 0xffff9d78da8bf680
[   11.978709] __d_free dentry =3D 0xffff9d78dae74e40
[   11.978710] file_free_rcu file =3D 0xffff9d78da8be000
[   11.988278] ----------call_rcu 1---------
[   11.992338] dentry =3D 0xffff9d78dae74b40
[   11.996210] __d_free dentry =3D 0xffff9d78dae746c0
[   12.000866] ----------call_rcu 1---------
[   12.004925] dentry =3D 0xffff9d78dae74240
[   12.008796] file_free_rcu file =3D 0xffff9d78da8bf680
[   12.013716] ----------call_rcu 1---------
[   12.021616] __d_free dentry =3D 0xffff9d78dae74b40
[   12.026444] dentry =3D 0xffff9d78dae74b40
[   12.030318] __d_free dentry =3D 0xffff9d78dae74240
[   12.034975] ----------call_rcu 1---------
[   12.039018] file_free file =3D 0xffff9d78da8bf680
[   12.043582] ----------call_rcu 1---------
[   12.047862] dentry =3D 0xffff9d78dae74480
[   12.051737] ----------call_rcu 1---------
[   12.055782] file_free file =3D 0xffff9d78da8be000
[   12.060344] ----------call_rcu 1---------
[   12.064407] dentry =3D 0xffff9d78dae74540
[   12.068279] __d_free dentry =3D 0xffff9d78dae74b40
[   12.068280] file_free_rcu file =3D 0xffff9d78da8bf680
[   12.077847] ----------call_rcu 1---------
[   12.081905] dentry =3D 0xffff9d78dae74900
[   12.085780] __d_free dentry =3D 0xffff9d78dae74480
[   12.085781] file_free_rcu file =3D 0xffff9d78da8be000
[   12.095349] ----------call_rcu 1---------
[   12.099406] dentry =3D 0xffff9d78dae740c0
[   12.103273] __d_free dentry =3D 0xffff9d78dae74540
[   12.107929] ----------call_rcu 1---------
[   12.111988] dentry =3D 0xffff9d78dae74f00
[   12.115862] __d_free dentry =3D 0xffff9d78dae74900
[   12.120516] ----------call_rcu 1---------
[   12.124561] file_free file =3D 0xffff9d78da8be000
[   12.129127] ----------call_rcu 1---------
[   12.133187] dentry =3D 0xffff9d78dae74780
[   12.137058] __d_free dentry =3D 0xffff9d78dae740c0
[   12.141716] ----------call_rcu 1---------
[   12.145756] file_free file =3D 0xffff9d78da8bf680
[   12.150323] ----------call_rcu 1---------
[   12.154389] dentry =3D 0xffff9d78dae743c0
[   12.158257] __d_free dentry =3D 0xffff9d78dae74f00
[   12.158257] file_free_rcu file =3D 0xffff9d78da8be000
[   12.167825] ----------call_rcu 1---------
[   12.171872] file_free file =3D 0xffff9d78da8be8c0
[   12.176437] ----------call_rcu 1---------
[   12.180499] dentry =3D 0xffff9d78dae74a80
[   12.184369] __d_free dentry =3D 0xffff9d78dae74780
[   12.184369] file_free_rcu file =3D 0xffff9d78da8bf680
[   12.193940] ----------call_rcu 1---------
[   12.197986] file_free file =3D 0xffff9d78da8be000
[   12.202551] ----------call_rcu 1---------
[   12.206615] dentry =3D 0xffff9d78dae749c0
[   12.210485] __d_free dentry =3D 0xffff9d78dae743c0
[   12.210486] file_free_rcu file =3D 0xffff9d78da8be8c0
[   12.220054] ----------call_rcu 1---------
[   12.224099] file_free file =3D 0xffff9d78da8bf680
[   12.228665] ----------call_rcu 1---------
[   12.232725] dentry =3D 0xffff9d78dae74cc0
[   12.236596] __d_free dentry =3D 0xffff9d78dae74a80
[   12.236596] file_free_rcu file =3D 0xffff9d78da8be000
[   12.246168] ----------call_rcu 1---------
[   12.250213] file_free file =3D 0xffff9d78da8be8c0
[   12.254779] ----------call_rcu 1---------
[   12.258843] dentry =3D 0xffff9d78dae74c00
[   12.262712] __d_free dentry =3D 0xffff9d78dae749c0
[   12.262713] file_free_rcu file =3D 0xffff9d78da8bf680
[   12.272282] ----------call_rcu 1---------
[   12.276328] file_free file =3D 0xffff9d78da8be000
[   12.280893] ----------call_rcu 1---------
[   12.284956] dentry =3D 0xffff9d78dae74180
[   12.288826] __d_free dentry =3D 0xffff9d78dae74cc0
[   12.288826] file_free_rcu file =3D 0xffff9d78da8be8c0
[   12.298396] ----------call_rcu 1---------
[   12.302440] file_free file =3D 0xffff9d78da8bf680
[   12.307005] ----------call_rcu 1---------
[   12.311071] dentry =3D 0xffff9d78dae74600
[   12.314938] __d_free dentry =3D 0xffff9d78dae74c00
[   12.314939] file_free_rcu file =3D 0xffff9d78da8be000
[   12.324510] ----------call_rcu 1---------
[   12.328554] file_free file =3D 0xffff9d78da8be8c0
[   12.333122] ----------call_rcu 1---------
[   12.337183] dentry =3D 0xffff9d78dae6e240
[   12.341054] __d_free dentry =3D 0xffff9d78dae74180
[   12.341055] file_free_rcu file =3D 0xffff9d78da8bf680
[   12.350623] ----------call_rcu 1---------
[   12.354670] file_free file =3D 0xffff9d78da8be000
[   12.359236] ----------call_rcu 1---------
[   12.363606] dentry =3D 0xffff9d78dae733c0
[   12.367475] __d_free dentry =3D 0xffff9d78dae74600
[   12.367476] file_free_rcu file =3D 0xffff9d78da8be8c0
[   12.377043] ----------call_rcu 1---------
[   12.381088] file_free file =3D 0xffff9d78da8bf680
[   12.385653] ----------call_rcu 1---------
[   12.389725] dentry =3D 0xffff9d78dae75b40
[   12.393594] ----------call_rcu 1---------
[   12.397643] __d_free dentry =3D 0xffff9d78dae6e240
[   12.397644] file_free_rcu file =3D 0xffff9d78da8be000
[   12.407211] file_free file =3D 0xffff9d78da8be8c0
[   12.411776] ----------call_rcu 1---------
[   12.415839] dentry =3D 0xffff9d78dae75000
[   12.419708] __d_free dentry =3D 0xffff9d78dae733c0
[   12.419709] file_free_rcu file =3D 0xffff9d78da8bf680
[   12.429279] ----------call_rcu 1---------
[   12.433327] file_free file =3D 0xffff9d78da8be000
[   12.437892] ----------call_rcu 1---------
[   12.441953] dentry =3D 0xffff9d78dae75300
[   12.445823] __d_free dentry =3D 0xffff9d78dae75b40
[   12.445824] file_free_rcu file =3D 0xffff9d78da8be8c0
[   12.455392] ----------call_rcu 1---------
[   12.459445] file_free file =3D 0xffff9d78da8bf680
[   12.464013] ----------call_rcu 1---------
[   12.468319] dentry =3D 0xffff9d78dae75540
[   12.472192] __d_free dentry =3D 0xffff9d78dae75000
[   12.472192] file_free_rcu file =3D 0xffff9d78da8be000
[   12.481759] ----------call_rcu 1---------
[   12.485808] file_free file =3D 0xffff9d78da8be8c0
[   12.490373] ----------call_rcu 1---------
[   12.494993] dentry =3D 0xffff9d78dae75900
[   12.498864] __d_free dentry =3D 0xffff9d78dae75300
[   12.498865] file_free_rcu file =3D 0xffff9d78da8bf680
[   12.508432] ----------call_rcu 1---------
[   12.512480] file_free file =3D 0xffff9d78da8be000
[   12.517042] ----------call_rcu 1---------
[   12.521101] dentry =3D 0xffff9d78dae750c0
[   12.524978] __d_free dentry =3D 0xffff9d78dae75540
[   12.524979] file_free_rcu file =3D 0xffff9d78da8be8c0
[   12.534546] ----------call_rcu 1---------
[   12.538603] dentry =3D 0xffff9d78dae75f00
[   12.542468] __d_free dentry =3D 0xffff9d78dae75900
[   12.542469] file_free_rcu file =3D 0xffff9d78da8be000
[   12.552038] ----------call_rcu 1---------
[   12.556100] dentry =3D 0xffff9d78dae75780
[   12.559971] __d_free dentry =3D 0xffff9d78dae750c0
[   12.564627] ----------call_rcu 1---------
[   12.568682] dentry =3D 0xffff9d78dae753c0
[   12.572550] __d_free dentry =3D 0xffff9d78dae75f00
[   12.577206] ----------call_rcu 1---------
[   12.581258] dentry =3D 0xffff9d78dae75a80
[   12.585127] __d_free dentry =3D 0xffff9d78dae75780
[   12.589781] ----------call_rcu 1---------
[   12.593841] dentry =3D 0xffff9d78dae759c0
[   12.597714] __d_free dentry =3D 0xffff9d78dae753c0
[   12.602368] ----------call_rcu 1---------
[   12.606425] dentry =3D 0xffff9d78dae75cc0
[   12.610299] __d_free dentry =3D 0xffff9d78dae75a80
[   12.614955] ----------call_rcu 1---------
[   12.620023] dentry =3D 0xffff9d78dae75c00
[   12.623896] __d_free dentry =3D 0xffff9d78dae759c0
[   12.628554] ----------call_rcu 1---------
[   12.632598] file_free file =3D 0xffff9d78da8be000
[   12.637162] ----------call_rcu 1---------
[   12.641615] __d_free dentry =3D 0xffff9d78dae75cc0
[   12.646999] dentry =3D 0xffff9d78dae75cc0
[   12.650876] __d_free dentry =3D 0xffff9d78dae75c00
[   12.650876] file_free_rcu file =3D 0xffff9d78da8be000
[   12.660444] ----------call_rcu 1---------
[   12.664490] file_free file =3D 0xffff9d78da8be8c0
[   12.669057] ----------call_rcu 1---------
[   12.673774] Freeing initrd memory: 5192K
[   12.677739] initcall populate_rootfs+0x0/0x10b returned 0 after 3686863 =
usecs
[   12.684921] calling  pci_iommu_init+0x0/0x44 @ 1
[   12.689576] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   12.696059] software IO TLB: mapped [mem 0x88087000-0x8c087000] (64MB)
[   12.702634] initcall pci_iommu_init+0x0/0x44 returned 0 after 12751 usec=
s
[   12.709467] calling  ir_dev_scope_init+0x0/0x38 @ 1
[   12.714382] initcall ir_dev_scope_init+0x0/0x38 returned 0 after 0 usecs
[   12.721316] calling  amd_uncore_init+0x0/0x2c4 @ 1
[   12.726148] initcall amd_uncore_init+0x0/0x2c4 returned -19 after 0 usec=
s
[   12.732983] calling  amd_ibs_init+0x0/0x1b1 @ 1
[   12.737552] initcall amd_ibs_init+0x0/0x1b1 returned -19 after 0 usecs
[   12.744124] calling  amd_iommu_pc_init+0x0/0x246 @ 1
[   12.749124] initcall amd_iommu_pc_init+0x0/0x246 returned -19 after 0 us=
ecs
[   12.756134] calling  msr_init+0x0/0x5b @ 1
[   12.760278] initcall msr_init+0x0/0x5b returned 0 after 11 usecs
[   12.766334] __d_free dentry =3D 0xffff9d78dae75cc0
[   12.766335] file_free_rcu file =3D 0xffff9d78da8be8c0
[   12.775904] calling  intel_uncore_init+0x0/0x2e4 @ 1
[   12.781099] initcall intel_uncore_init+0x0/0x2e4 returned 0 after 188 us=
ecs
[   12.788118] calling  register_kernel_offset_dumper+0x0/0x20 @ 1
[   12.794085] initcall register_kernel_offset_dumper+0x0/0x20 returned 0 a=
fter 0 usecs
[   12.801876] calling  i8259A_init_ops+0x0/0x29 @ 1
[   12.806623] initcall i8259A_init_ops+0x0/0x29 returned 0 after 3 usecs
[   12.813198] calling  init_tsc_clocksource+0x0/0xcc @ 1
[   12.818379] initcall init_tsc_clocksource+0x0/0xcc returned 0 after 1 us=
ecs
[   12.825385] calling  add_rtc_cmos+0x0/0xd0 @ 1
[   12.829909] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[   12.837613] initcall add_rtc_cmos+0x0/0xd0 returned 0 after 7567 usecs
[   12.844193] calling  i8237A_init_ops+0x0/0x3f @ 1
[   12.848937] initcall i8237A_init_ops+0x0/0x3f returned -19 after 2 usecs
[   12.855680] calling  umwait_init+0x0/0x96 @ 1
[   12.860076] initcall umwait_init+0x0/0x96 returned -19 after 0 usecs
[   12.866473] calling  thermal_throttle_init_device+0x0/0x47 @ 1
[   12.872393] initcall thermal_throttle_init_device+0x0/0x47 returned 0 af=
ter 44 usecs
[   12.880187] calling  ioapic_init_ops+0x0/0x19 @ 1
[   12.884929] initcall ioapic_init_ops+0x0/0x19 returned 0 after 3 usecs
[   12.891498] calling  register_e820_pmem+0x0/0x49 @ 1
[   12.896502] initcall register_e820_pmem+0x0/0x49 returned 0 after 2 usec=
s
[   12.903332] calling  add_pcspkr+0x0/0x70 @ 1
[   12.907655] initcall add_pcspkr+0x0/0x70 returned 0 after 16 usecs
[   12.913883] calling  start_periodic_check_for_corruption+0x0/0x60 @ 1
[   12.920365] check: Scanning for low memory corruption every 60 seconds
[   12.926936] initcall start_periodic_check_for_corruption+0x0/0x60 return=
ed 0 after 6415 usecs
[   12.935513] calling  sysfb_init+0x0/0x9f @ 1
[   12.939864] initcall sysfb_init+0x0/0x9f returned 0 after 43 usecs
[   12.946088] calling  audit_classes_init+0x0/0x5f @ 1
[   12.951095] initcall audit_classes_init+0x0/0x5f returned 0 after 4 usec=
s
[   12.957934] calling  pt_dump_init+0x0/0x48 @ 1
[   12.962414] initcall pt_dump_init+0x0/0x48 returned 0 after 0 usecs
[   12.968721] calling  crc32c_intel_mod_init+0x0/0x5c @ 1
[   12.974037] initcall crc32c_intel_mod_init+0x0/0x5c returned 0 after 48 =
usecs
[   12.981224] calling  iosf_mbi_init+0x0/0x2f @ 1
[   12.985803] free_pid pid =3D 0xffff9d78d9f8c900
[   12.989786] ----------call_rcu 1---------
[   12.994250] ----------call_rcu 1---------
[   12.998319] initcall iosf_mbi_init+0x0/0x2f returned 0 after 12234 usecs
[   13.005071] calling  proc_execdomains_init+0x0/0x27 @ 1
[   13.010345] initcall proc_execdomains_init+0x0/0x27 returned 0 after 8 u=
secs
[   13.017436] delayed_put_pid pid =3D 0xffff9d78d9f8c900
[   13.022443] calling  register_warn_debugfs+0x0/0x29 @ 1
[   13.027714] initcall register_warn_debugfs+0x0/0x29 returned 0 after 8 u=
secs
[   13.034812] ----------call_rcu 1---------
[   13.038853] calling  cpuhp_sysfs_init+0x0/0x8c @ 1
[   13.043700] initcall cpuhp_sysfs_init+0x0/0x8c returned 0 after 17 usecs
[   13.050450] calling  ioresources_init+0x0/0x4f @ 1
[   13.055283] initcall ioresources_init+0x0/0x4f returned 0 after 7 usecs
[   13.061948] calling  init_sched_debug_procfs+0x0/0x34 @ 1
[   13.067398] initcall init_sched_debug_procfs+0x0/0x34 returned 0 after 5=
 usecs
[   13.074673] calling  psi_proc_init+0x0/0x6c @ 1
[   13.079245] initcall psi_proc_init+0x0/0x6c returned 0 after 7 usecs
[   13.085644] calling  snapshot_device_init+0x0/0x17 @ 1
[   13.090853] initcall snapshot_device_init+0x0/0x17 returned 0 after 29 u=
secs
[   13.097951] calling  irq_gc_init_ops+0x0/0x19 @ 1
[   13.102695] initcall irq_gc_init_ops+0x0/0x19 returned 0 after 3 usecs
[   13.109263] calling  irq_pm_init_ops+0x0/0x19 @ 1
[   13.114010] initcall irq_pm_init_ops+0x0/0x19 returned 0 after 2 usecs
[   13.120589] calling  klp_init+0x0/0x2e @ 1
[   13.124723] initcall klp_init+0x0/0x2e returned 0 after 4 usecs
[   13.130693] calling  timekeeping_init_ops+0x0/0x19 @ 1
[   13.135871] initcall timekeeping_init_ops+0x0/0x19 returned 0 after 3 us=
ecs
[   13.142875] calling  init_clocksource_sysfs+0x0/0x29 @ 1
[   13.148261] initcall init_clocksource_sysfs+0x0/0x29 returned 0 after 31=
 usecs
[   13.155533] calling  init_timer_list_procfs+0x0/0x37 @ 1
[   13.160886] initcall init_timer_list_procfs+0x0/0x37 returned 0 after 4 =
usecs
[   13.168077] calling  alarmtimer_init+0x0/0xde @ 1
[   13.172834] initcall alarmtimer_init+0x0/0xde returned 0 after 17 usecs
[   13.179494] calling  init_posix_timers+0x0/0x2f @ 1
[   13.184415] initcall init_posix_timers+0x0/0x2f returned 0 after 6 usecs
[   13.191165] calling  clockevents_init_sysfs+0x0/0xcb @ 1
[   13.196578] initcall clockevents_init_sysfs+0x0/0xcb returned 0 after 60=
 usecs
[   13.203847] calling  proc_dma_init+0x0/0x27 @ 1
[   13.208416] initcall proc_dma_init+0x0/0x27 returned 0 after 4 usecs
[   13.214821] calling  modules_wq_init+0x0/0x49 @ 1
[   13.219562] initcall modules_wq_init+0x0/0x49 returned 0 after 0 usecs
[   13.226134] calling  proc_modules_init+0x0/0x24 @ 1
[   13.231051] initcall proc_modules_init+0x0/0x24 returned 0 after 4 usecs
[   13.237796] calling  kallsyms_init+0x0/0x27 @ 1
[   13.242365] initcall kallsyms_init+0x0/0x27 returned 0 after 3 usecs
[   13.248761] calling  pid_namespaces_init+0x0/0x45 @ 1
[   13.253871] initcall pid_namespaces_init+0x0/0x45 returned 0 after 16 us=
ecs
[   13.260877] calling  ikconfig_init+0x0/0x49 @ 1
[   13.265450] initcall ikconfig_init+0x0/0x49 returned 0 after 3 usecs
[   13.271850] calling  audit_watch_init+0x0/0x3f @ 1
[   13.276681] initcall audit_watch_init+0x0/0x3f returned 0 after 3 usecs
[   13.283337] calling  audit_fsnotify_init+0x0/0x3f @ 1
[   13.288430] initcall audit_fsnotify_init+0x0/0x3f returned 0 after 2 use=
cs
[   13.295350] calling  audit_tree_init+0x0/0x7c @ 1
[   13.300092] initcall audit_tree_init+0x0/0x7c returned 0 after 4 usecs
[   13.306665] calling  seccomp_sysctl_init+0x0/0x31 @ 1
[   13.311760] initcall seccomp_sysctl_init+0x0/0x31 returned 0 after 7 use=
cs
[   13.318682] calling  utsname_sysctl_init+0x0/0x19 @ 1
[   13.323781] initcall utsname_sysctl_init+0x0/0x19 returned 0 after 9 use=
cs
[   13.330704] calling  init_tracepoints+0x0/0x2d @ 1
[   13.335535] initcall init_tracepoints+0x0/0x2d returned 0 after 3 usecs
[   13.342193] calling  stack_trace_init+0x0/0xb5 @ 1
[   13.347028] initcall stack_trace_init+0x0/0xb5 returned 0 after 7 usecs
[   13.353687] calling  init_mmio_trace+0x0/0x12 @ 1
[   13.358435] initcall init_mmio_trace+0x0/0x12 returned 0 after 5 usecs
[   13.365008] calling  init_blk_tracer+0x0/0x56 @ 1
[   13.369760] initcall init_blk_tracer+0x0/0x56 returned 0 after 8 usecs
[   13.376332] calling  perf_event_sysfs_init+0x0/0x8d @ 1
[   13.381821] initcall perf_event_sysfs_init+0x0/0x8d returned 0 after 215=
 usecs
[   13.389096] calling  xenomai_init+0x0/0x3b0 @ 1
[   13.393662]  xenomai_init xnsched_register_classes
[   13.398487] [Xenomai] scheduling class idle registered.
[   13.403751] [Xenomai] scheduling class rt registered.
[   13.408842]  xenomai_init xnprocfs_init_tree
[   13.413159]  xenomai_init mach_setup
[   13.416811] IRQ pipeline: high-priority Xenomai stage added.
[   13.422515]  xenomai_init xnintr_mount
[   13.430754]  xenomai_init xnpipt_mount
[   13.434538]  xenomai_initxnselect_mount
[   13.438411]  xenomai_init sys_init
[   13.442361] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0+ #149
[   13.445841] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[   13.445841] IRQ stage: Linux
[   13.445841] Call Trace:
[   13.445841]  dump_stack+0x93/0xc5
[   13.445841]  xnsched_set_policy+0x212/0x2d0
[   13.445841]  __xnthread_init+0x270/0x370
[   13.445841]  ? rdinit_setup+0x30/0x30
[   13.445841]  xnsched_init+0x161/0x220
[   13.445841]  ? rdinit_setup+0x30/0x30
[   13.445841]  xnsched_init_all+0x2f/0xb0
[   13.445841]  xenomai_init+0x2cc/0x3b0
[   13.445841]  ? xnclock_init+0x45/0x45
[   13.445841]  do_one_initcall+0x4a/0x200
[   13.445841]  kernel_init_freeable+0x226/0x29c
[   13.445841]  ? rest_init+0xb0/0xb0
[   13.445841]  kernel_init+0xe/0x110
[   13.445841]  ret_from_fork+0x1f/0x30
[   13.513088] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0+ #149
[   13.517082] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[   13.517082] IRQ stage: Linux
[   13.517082] Call Trace:
[   13.517082]  dump_stack+0x93/0xc5
[   13.517082]  xnsched_set_policy+0x212/0x2d0
[   13.517082]  __xnthread_init+0x270/0x370
[   13.517082]  ? rdinit_setup+0x30/0x30
[   13.517082]  xnsched_init+0x161/0x220
[   13.517082]  ? rdinit_setup+0x30/0x30
[   13.517082]  xnsched_init_all+0x2f/0xb0
[   13.517082]  xenomai_init+0x2cc/0x3b0
[   13.517082]  ? xnclock_init+0x45/0x45
[   13.517082]  do_one_initcall+0x4a/0x200
[   13.517082]  kernel_init_freeable+0x226/0x29c
[   13.517082]  ? rest_init+0xb0/0xb0
[   13.517082]  kernel_init+0xe/0x110
[   13.517082]  ret_from_fork+0x1f/0x30
[   13.517082] ___xnsched_run chz
[   13.517082] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0+ #149
[   13.517082] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[   13.517082] IRQ stage: Xenomai
[   13.517082] Call Trace:
[   13.517082]  dump_stack+0x93/0xc5
[   13.517082]  ___xnsched_run+0x2a/0x3c0
[   13.517082]  handle_irq_pipelined_finish+0x179/0x1a0
[   13.517082]  arch_pipeline_entry+0xee/0x120
[   13.517082]  sysvec_apic_timer_interrupt+0xe/0x10
[   13.517082]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   13.517082] RIP: 0010:io_serial_in+0x18/0x20
[   13.517082] Code: 89 e5 d3 e6 48 63 f6 48 03 77 10 8b 06 5d c3 0f 1f 00 =
0f 1f 44 00 00 0f b6 8f b9 00 00 00 8b 57 08 55 48 89 e5 d3 e6 01 f2 ec <0f=
> b6 c0 5d c3 0f 1f 00 0f 1f 44 00 00 0f b6 8f b9 00 00 00 89 d0
[   13.517082] RSP: 0000:ffffb7e6c00375a0 EFLAGS: 00000202
[   13.517082] RAX: ffffffffabd63200 RBX: ffffffffaf613840 RCX: 00000000000=
00000
[   13.517082] RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffffaf6=
13840
[   13.517082] RBP: ffffb7e6c00375a0 R08: 000000dd55fd3c78 R09: 00000000000=
00000
[   13.517082] R10: 0000000000000045 R11: ffffb7e6c0037660 R12: 00000000000=
02704
[   13.517082] R13: 0000000000000020 R14: ffffffffad43c988 R15: 00000000000=
00000
[   13.517082]  ? mem32_serial_out+0x20/0x20
[   13.517082]  wait_for_xmitr+0x47/0xb0
[   13.517082]  serial8250_console_putchar+0x1c/0x40
[   13.517082]  ? wait_for_xmitr+0xb0/0xb0
[   13.517082]  uart_console_write+0x4c/0x60
[   13.517082]  serial8250_console_write+0x2f2/0x330
[   13.517082]  univ8250_console_write+0x21/0x30
[   13.517082]  console_unlock+0x386/0x530
[   13.517082]  vprintk_emit+0x113/0x2a0
[   13.517082]  vprintk_default+0x1f/0x30
[   13.517082]  vprintk_func+0xa5/0x120
[   13.517082]  printk+0x52/0x6e
[   13.517082]  dump_stack_print_info+0x7d/0x100
[   13.517082]  dump_stack+0x83/0xc5
[   13.517082]  xnsched_set_policy+0x212/0x2d0
[   13.517082]  __xnthread_init+0x270/0x370
[   13.517082]  ? rdinit_setup+0x30/0x30
[   13.517082]  xnsched_init+0x161/0x220
[   13.517082]  ? rdinit_setup+0x30/0x30
[   13.517082]  xnsched_init_all+0x2f/0xb0
[   13.517082]  xenomai_init+0x2cc/0x3b0
[   13.517082]  ? xnclock_init+0x45/0x45
[   13.517082]  do_one_initcall+0x4a/0x200
[   13.517082]  kernel_init_freeable+0x226/0x29c
[   13.517082]  ? rest_init+0xb0/0xb0
[   13.517082]  kernel_init+0xe/0x110
[   13.517082]  ret_from_fork+0x1f/0x30
[   13.800234] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0+ #149
[   13.804228] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[   13.804228] IRQ stage: Linux
[   13.804228] Call Trace:
[   13.804228]  dump_stack+0x93/0xc5
[   13.804228]  xnsched_set_policy+0x212/0x2d0
[   13.804228]  __xnthread_init+0x270/0x370
[   13.804228]  ? rdinit_setup+0x30/0x30
[   13.804228]  xnsched_init+0x161/0x220
[   13.804228]  ? rdinit_setup+0x30/0x30
[   13.804228]  xnsched_init_all+0x2f/0xb0
[   13.804228]  xenomai_init+0x2cc/0x3b0
[   13.804228]  ? xnclock_init+0x45/0x45
[   13.804228]  do_one_initcall+0x4a/0x200
[   13.804228]  kernel_init_freeable+0x226/0x29c
[   13.804228]  ? rest_init+0xb0/0xb0
[   13.804228]  kernel_init+0xe/0x110
[   13.804228]  ret_from_fork+0x1f/0x30
[   13.804228] ___xnsched_run chz
[   13.804228] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0+ #149
[   13.804228] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[   13.804228] IRQ stage: Xenomai
[   13.804228] Call Trace:
[   13.804228]  dump_stack+0x93/0xc5
[   13.804228]  ___xnsched_run+0x2a/0x3c0
[   13.804228]  handle_irq_pipelined_finish+0x179/0x1a0
[   13.804228]  arch_pipeline_entry+0xee/0x120
[   13.804228]  sysvec_apic_timer_interrupt+0xe/0x10
[   13.804228]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   13.804228] RIP: 0010:delay_tsc+0x24/0x70
[   13.804228] Code: 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 65 44 8b =
0d ff 88 3e 54 0f 01 f9 66 90 48 c1 e2 20 48 09 c2 49 89 d0 eb 11 f3 90 <65=
> 8b 35 e5 88 3e 54 41 39 f1 75 1c 41 89 f1 0f 01 f9 66 90 48 c1
[   13.804228] RSP: 0000:ffffb7e6c0037590 EFLAGS: 00000293
[   13.804228] RAX: 000000dd7a098f80 RBX: ffffffffaf613840 RCX: 00000000000=
00000
[   13.804228] RDX: 0000000000000522 RSI: 0000000000000000 RDI: 00000000000=
00824
[   13.804228] RBP: ffffb7e6c0037590 R08: 000000dd7a098a5e R09: 00000000000=
00000
[   13.804228] R10: 0000000000000045 R11: ffffb7e6c0037660 R12: 00000000000=
02707
[   13.804228] R13: 0000000000000020 R14: ffffffffad43c992 R15: 00000000000=
00000
[   13.804228]  __const_udelay+0x46/0x50
[   13.804228]  wait_for_xmitr+0x2c/0xb0
[   13.804228]  serial8250_console_putchar+0x1c/0x40
[   13.804228]  ? wait_for_xmitr+0xb0/0xb0
[   13.804228]  uart_console_write+0x4c/0x60
[   13.804228]  serial8250_console_write+0x2f2/0x330
[   13.804228]  univ8250_console_write+0x21/0x30
[   13.804228]  console_unlock+0x386/0x530
[   13.804228]  vprintk_emit+0x113/0x2a0
[   13.804228]  vprintk_default+0x1f/0x30
[   13.804228]  vprintk_func+0xa5/0x120
[   13.804228]  printk+0x52/0x6e
[   13.804228]  dump_stack_print_info+0x7d/0x100
[   13.804228]  dump_stack+0x83/0xc5
[   13.804228]  xnsched_set_policy+0x212/0x2d0
[   13.804228]  __xnthread_init+0x270/0x370
[   13.804228]  ? rdinit_setup+0x30/0x30
[   13.804228]  xnsched_init+0x161/0x220
[   13.804228]  ? rdinit_setup+0x30/0x30
[   13.804228]  xnsched_init_all+0x2f/0xb0
[   13.804228]  xenomai_init+0x2cc/0x3b0
[   13.804228]  ? xnclock_init+0x45/0x45
[   13.804228]  do_one_initcall+0x4a/0x200
[   13.804228]  kernel_init_freeable+0x226/0x29c
[   13.804228]  ? rest_init+0xb0/0xb0
[   13.804228]  kernel_init+0xe/0x110
[   13.804228]  ret_from_fork+0x1f/0x30
[   13.870986] ___xnsched_run chz
[   13.870987] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.8.0+ #149
[   13.870987] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[   13.870987] IRQ stage: Xenomai
[   13.870988] Call Trace:
[   13.870988]  dump_stack+0x93/0xc5
[   13.870988]  ___xnsched_run+0x2a/0x3c0
[   13.870989]  handle_irq_pipelined_finish+0x179/0x1a0
[   13.870989]  arch_pipeline_entry+0xb0/0x120
[   13.870990]  sysvec_apic_timer_interrupt+0xe/0x10
[   13.870990]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   13.870990] RIP: 0010:cpu_idle_poll+0x3b/0x1e0
[   13.870991] Code: 2b d3 40 ff 65 44 8b 25 a3 ae d0 53 0f 1f 44 00 00 e8 =
a9 e9 3f ff 65 48 8b 04 25 00 6d 01 00 48 8b 00 a8 08 74 14 eb 25 f3 90 <65=
> 48 8b 04 25 00 6d 01 00 48 8b 00 a8 08 75 13 8b 05 57 54 dd 00
[   13.870992] RSP: 0000:ffffb7e6c00e3e98 EFLAGS: 00000202
[   13.870993] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 00000002ff4=
0c419
[   13.870993] RDX: 0000000000000001 RSI: 00000002ff40c673 RDI: 00000000000=
5ea80
[   13.870993] RBP: ffffb7e6c00e3eb8 R08: 0000000000000000 R09: 00000000000=
5d580
[   13.870994] R10: ffffb7e6c00e3e48 R11: 0000000000000000 R12: 00000000000=
00001
[   13.870994] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   13.870995]  ? cpu_idle_poll+0x27/0x1e0
[   13.870995]  do_idle+0x62/0x2d0
[   13.870995]  ? complete+0x43/0x50
[   13.870996]  cpu_startup_entry+0x1d/0x20
[   13.870996]  start_secondary+0x157/0x1a0
[   13.870996]  secondary_startup_64+0xa4/0xb0
[   13.870998] irq_pipeline: unexpected event on vector #ea (irq=3D524544)
[   14.221388] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0+ #149
[   14.225384] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[   14.225384] IRQ stage: Linux
[   14.225384] Call Trace:
[   14.225384]  dump_stack+0x93/0xc5
[   14.225384]  xnsched_set_policy+0x212/0x2d0
[   14.225384]  __xnthread_init+0x270/0x370
[   14.225384]  ? rdinit_setup+0x30/0x30
[   14.225384]  xnsched_init+0x161/0x220
[   14.225384]  ? rdinit_setup+0x30/0x30
[   14.225384]  xnsched_init_all+0x2f/0xb0
[   14.225384]  xenomai_init+0x2cc/0x3b0
[   14.225384]  ? xnclock_init+0x45/0x45
[   14.225384]  do_one_initcall+0x4a/0x200
[   14.225384]  kernel_init_freeable+0x226/0x29c
[   14.225384]  ? rest_init+0xb0/0xb0
[   14.225384]  kernel_init+0xe/0x110
[   14.225384]  ret_from_fork+0x1f/0x30
[   14.225384] ___xnsched_run chz
[   14.225384] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0+ #149
[   14.225384] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[   14.225384] IRQ stage: Xenomai
[   14.225384] Call Trace:
[   14.225384]  dump_stack+0x93/0xc5
[   14.225384]  ___xnsched_run+0x2a/0x3c0
[   14.225384]  handle_irq_pipelined_finish+0x179/0x1a0
[   14.225384]  arch_pipeline_entry+0xee/0x120
[   14.225384]  sysvec_apic_timer_interrupt+0xe/0x10
[   14.225384]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   14.225384] RIP: 0010:io_serial_in+0x18/0x20
[   14.225384] Code: 89 e5 d3 e6 48 63 f6 48 03 77 10 8b 06 5d c3 0f 1f 00 =
0f 1f 44 00 00 0f b6 8f b9 00 00 00 8b 57 08 55 48 89 e5 d3 e6 01 f2 ec <0f=
> b6 c0 5d c3 0f 1f 00 0f 1f 44 00 00 0f b6 8f b9 00 00 00 89 d0
[   14.225384] RSP: 0000:ffffb7e6c00375a0 EFLAGS: 00000202
[   14.225384] RAX: ffffffffabd63200 RBX: ffffffffaf613840 RCX: 00000000000=
00000
[   14.225384] RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffffaf6=
13840
[   14.225384] RBP: ffffb7e6c00375a0 R08: 000000ddae9b5c16 R09: 00000000000=
00000
[   14.225384] R10: 0000000000000049 R11: ffffb7e6c0037660 R12: 00000000000=
0270c
[   14.225384] R13: 0000000000000020 R14: ffffffffad43c985 R15: 00000000000=
00000
[   14.225384]  ? mem32_serial_out+0x20/0x20
[   14.225384]  wait_for_xmitr+0x47/0xb0
[   14.225384]  serial8250_console_putchar+0x1c/0x40
[   14.225384]  ? wait_for_xmitr+0xb0/0xb0
[   14.225384]  uart_console_write+0x4c/0x60
[   14.225384]  serial8250_console_write+0x2f2/0x330
[   14.225384]  univ8250_console_write+0x21/0x30
[   14.225384]  console_unlock+0x386/0x530
[   14.225384]  vprintk_emit+0x113/0x2a0
[   14.225384]  vprintk_default+0x1f/0x30
[   14.225384]  vprintk_func+0xa5/0x120
[   14.225384]  printk+0x52/0x6e
[   14.225384]  dump_stack_print_info+0x7d/0x100
[   14.225384]  dump_stack+0x83/0xc5
[   14.225384]  xnsched_set_policy+0x212/0x2d0
[   14.225384]  __xnthread_init+0x270/0x370
[   14.225384]  ? rdinit_setup+0x30/0x30
[   14.225384]  xnsched_init+0x161/0x220
[   14.225384]  ? rdinit_setup+0x30/0x30
[   14.225384]  xnsched_init_all+0x2f/0xb0
[   14.225384]  xenomai_init+0x2cc/0x3b0
[   14.225384]  ? xnclock_init+0x45/0x45
[   14.225384]  do_one_initcall+0x4a/0x200
[   14.225384]  kernel_init_freeable+0x226/0x29c
[   14.225384]  ? rest_init+0xb0/0xb0
[   14.225384]  kernel_init+0xe/0x110
[   14.225384]  ret_from_fork+0x1f/0x30
[   14.298614] ___xnsched_run chz
[   14.298615] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.8.0+ #149
[   14.298615] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[   14.298616] IRQ stage: Xenomai
[   14.298616] Call Trace:
[   14.298616]  dump_stack+0x93/0xc5
[   14.298617]  ___xnsched_run+0x2a/0x3c0
[   14.298617]  handle_irq_pipelined_finish+0x179/0x1a0
[   14.298617]  arch_pipeline_entry+0xb0/0x120
[   14.298618]  sysvec_apic_timer_interrupt+0xe/0x10
[   14.298618]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   14.298619] RIP: 0010:cpu_idle_poll+0x3b/0x1e0
[   14.298619] Code: 2b d3 40 ff 65 44 8b 25 a3 ae d0 53 0f 1f 44 00 00 e8 =
a9 e9 3f ff 65 48 8b 04 25 00 6d 01 00 48 8b 00 a8 08 74 14 eb 25 f3 90 <65=
> 48 8b 04 25 00 6d 01 00 48 8b 00 a8 08 75 13 8b 05 57 54 dd 00
[   14.298620] RSP: 0000:ffffb7e6c00ebe98 EFLAGS: 00000202
[   14.298621] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 00000002ff4=
0eeee
[   14.298621] RDX: 0000000000000002 RSI: 00000002ff40f15b RDI: 00000000000=
5ea80
[   14.298622] RBP: ffffb7e6c00ebeb8 R08: 0000000000000000 R09: 00000000000=
5d580
[   14.298622] R10: ffffb7e6c00ebe48 R11: 0000000000000000 R12: 00000000000=
00002
[   14.298623] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   14.298623]  ? cpu_idle_poll+0x27/0x1e0
[   14.298623]  do_idle+0x62/0x2d0
[   14.298624]  ? complete+0x43/0x50
[   14.298624]  cpu_startup_entry+0x1d/0x20
[   14.298624]  start_secondary+0x157/0x1a0
[   14.298625]  secondary_startup_64+0xa4/0xb0
[   14.649651] ___xnsched_run chz
[   14.649652] CPU: 0 PID: 21 Comm: rcuog/1 Not tainted 5.8.0+ #149
[   14.649652] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[   14.649652] IRQ stage: Xenomai
[   14.649653] Call Trace:
[   14.649653]  dump_stack+0x93/0xc5
[   14.649653]  ___xnsched_run+0x2a/0x3c0
[   14.649654]  handle_irq_pipelined_finish+0x179/0x1a0
[   14.649654]  arch_pipeline_entry+0xb0/0x120
[   14.649655]  sysvec_apic_timer_interrupt+0xe/0x10
[   14.649655]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   14.649655] RIP: 0010:__inband_irq_enable+0x36/0x50
[   14.649656] Code: fa 65 48 8b 04 25 00 6d 01 00 48 0f ba b0 28 0c 00 00 =
00 48 c7 c0 40 c6 04 00 65 48 03 05 1a c5 90 54 48 83 38 00 75 05 53 9d <5b=
> 5d c3 e8 22 fb ff ff 53 9d 5b 5d c3 0f 1f 00 66 2e 0f 1f 84 00
[   14.649657] RSP: 0000:ffffb7e6c0133e18 EFLAGS: 00000246
[   14.649657] RAX: ffff9d78ddc4c640 RBX: 0000000000000246 RCX: 00000000000=
00000
[   14.649658] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00000000000=
00000
[   14.649658] RBP: ffffb7e6c0133e20 R08: 0000000000000000 R09: 00000000000=
00000
[   14.649659] R10: ffffb7e6c0173c38 R11: 0000000000000000 R12: ffff9d78dc1=
f75c0
[   14.649659] R13: ffffb7e6c0037c30 R14: 0000000000000200 R15: ffff9d78ddc=
dea80
[   14.649659]  inband_irq_restore+0x22/0x30
[   14.649660]  _raw_spin_unlock_irqrestore+0x23/0x30
[   14.649660]  rcu_nocb_unlock_irqrestore+0x33/0x40
[   14.649660]  rcu_nocb_gp_kthread+0x439/0x5b0
[   14.649661]  ? inband_irq_restore+0x22/0x30
[   14.649661]  ? _raw_spin_unlock_irqrestore+0x23/0x30
[   14.649662]  ? rcu_nocb_do_flush_bypass+0xd0/0xd0
[   14.649662]  kthread+0x126/0x140
[   14.649662]  ? kthread_park+0x90/0x90
[   14.649662]  ret_from_fork+0x1f/0x30
[   14.649690] ___xnsched_run chz
[   14.649690] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.8.0+ #149
[   14.649691] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
[   14.649691] IRQ stage: Xenomai
[   14.649691] Call Trace:
[   14.649692]  dump_stack+0x93/0xc5
[   14.649692]  ___xnsched_run+0x2a/0x3c0
[   14.649693]  handle_irq_pipelined_finish+0x179/0x1a0
[   14.649693]  arch_pipeline_entry+0xb0/0x120
[   14.649693]  sysvec_apic_timer_interrupt+0xe/0x10
[   14.649694]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   14.649694] RIP: 0010:cpu_idle_poll+0x3b/0x1e0
[   14.649695] Code: 2b d3 40 ff 65 44 8b 25 a3 ae d0 53 0f 1f 44 00 00 e8 =
a9 e9 3f ff 65 48 8b 04 25 00 6d 01 00 48 8b 00 a8 08 74 14 eb 25 f3 90 <65=
> 48 8b 04 25 00 6d 01 00 48 8b 00 a8 08 75 13 8b 05 57 54 dd 00
[   14.649695] RSP: 0000:ffffb7e6c00f3e98 EFLAGS: 00000202
[   14.649696] RAX: 0000000000000001 RBX: 0000000000000003 RCX: 00000002ff4=
1197a
[   14.649697] RDX: 0000000000000003 RSI: 00000002ff411bbe RDI: 00000000000=
5ea80
[   14.649697] RBP: ffffb7e6c00f3eb8 R08: 0000000000000002 R09: 00000000000=
5d580
[   14.649698] R10: ffffb7e6c00f3e48 R11: 0000000000000000 R12: 00000000000=
00003
[   14.649698] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   14.649698]  ? cpu_idle_poll+0x27/0x1e0
[   14.649699]  do_idle+0x62/0x2d0
[   14.649699]  ? complete+0x43/0x50
[   14.649699]  cpu_startup_entry+0x1d/0x20
[   14.649700]  start_secondary+0x157/0x1a0
[   14.649700]  secondary_startup_64+0xa4/0xb0
[   14.939213] tsc: Refined TSC clocksource calibration: 2112.001 MHz
[   14.945441] clocksource: tsc: freq: 2112001000 Hz, mask: 0xfffffffffffff=
fff max_cycles: 0x1e71797ffd2, max_idle_ns: 440795307724 ns
[   14.957343] clocksource: Switched to clocksource tsc
[   14.962374] ----chz tick_setup_device start mode =3D 0x1
[   14.966371]  td->evtdev->name =3Dlapic-deadline
[   14.966371]  td->evtdev->event_handler =3D0xab722b30
[   14.966371] ----chz tick_setup_device before setup mode =3D 0x1
[   14.966371] ---chz newdev->features =3D 0x546
[   14.966371] tick_setup_oneshot
[   14.966371] real_device name =3Dlapic-deadline
[   14.966371] ----chz tick_setup_device start mode =3D 0x1
[   14.966371] CPU1: proxy tick device registered (264.00MHz)
[   14.966371]  td->evtdev->name =3Dlapic-deadline
[   14.966371]  td->evtdev->event_handler =3D0xab722b30
[   14.966371] ----chz tick_setup_device before setup mode =3D 0x1
[   14.966371] ---chz newdev->features =3D 0x546
[   14.966371] tick_setup_oneshot
[   14.966371] real_device name =3Dlapic-deadline
[   14.966371] ----chz tick_setup_device start mode =3D 0x1
[   14.966371] CPU3: proxy tick device registered (264.00MHz)
[   14.966371]  td->evtdev->name =3Dlapic-deadline
[   14.966371]  td->evtdev->event_handler =3D0xab722b30
[   14.966371] ----chz tick_setup_device before setup mode =3D 0x1
[   14.966371] ---chz newdev->features =3D 0x546
[   14.966371] tick_setup_oneshot
[   14.966371] real_device name =3Dlapic-deadline
[   14.966371] CPU2: proxy tick device registered (264.00MHz)
[   15.073698] ----chz tick_setup_device start mode =3D 0x1
[   15.077613]  td->evtdev->name =3Dlapic-deadline
[   15.077613]  td->evtdev->event_handler =3D0xab722b30
[   15.077613] ----chz tick_setup_device before setup mode =3D 0x1
[   15.077613] ---chz newdev->features =3D 0x546
[   15.077613] tick_setup_oneshot
[   15.077613] real_device name =3Dlapic-deadline
[   15.077613] CPU0: proxy tick device registered (264.00MHz)
[   15.077613] ------------- end register_proxy_device--------
[   15.116410]  xenomai_init mach_late_setup
[   15.120407]  xenomai_init rtdm_init
[   15.120407]  xenomai_init cobalt_init
[   15.120407] cobalt_init xndebug_init
[   15.120407] cobalt_init xnsynch_init
[   15.120407] cobalt_init cobalt_memdev_init
[   15.120407] cobalt_memdev_init cobalt_umm_set_name
[   15.120407] cobalt_memdev_init cobalt_umm_alloc
[   15.120407] cobalt_memdev_init init_vdso
[   15.120407] cobalt_memdev_init rtdm_dev_register
[   15.120407] rtdm_dev_register secondary_mode_only
[   15.120407] rtdm_dev_register realtime_core_enabled
[   15.120407] rtdm_dev_register register_driver
[   15.120407] rtdm_dev_register xnregistry_enter
[   15.120407] rtdm_dev_register device_create
[   15.120407] dentry =3D 0xffff9d78dae6e240
[   15.120407] ----------call_rcu 1---------
[   15.120407] rtdm_dev_register before return
[   15.120407] cobalt_memdev_init UMM_SHARED
[   15.120407] rtdm_dev_register secondary_mode_only
[   15.120407] rtdm_dev_register realtime_core_enabled
[   15.120407] rtdm_dev_register register_driver
[   15.120407] rtdm_dev_register xnregistry_enter
[   15.120407] rtdm_dev_register device_create
[   15.120407] rtdm_dev_register before return
[   15.120407] cobalt_memdev_init sysmem_device
[   15.120407] rtdm_dev_register secondary_mode_only
[   15.120407] rtdm_dev_register realtime_core_enabled
[   15.120407] rtdm_dev_register register_driver
[   15.120407] rtdm_dev_register xnregistry_enter
[   15.120407] rtdm_dev_register device_create
[   15.120407] rtdm_dev_register before return
[   15.120407] cobalt_init cobalt_register_personability
[   15.120407] cobalt_init cobalt_signal_init
[   15.120407] cobalt_init init_hostrt
[   15.120407] cobalt_init dovetail_start
[   15.120407] cobalt_init before return
[   15.120407]  xenomai_init rtdm_fd_init
[   15.120407] [Xenomai] Cobalt v3.1=20
[   15.120407] initcall xenomai_init+0x0/0x3b0 returned 0 after 1842888 use=
cs
[   15.120407] calling  system_trusted_keyring_init+0x0/0xfb @ 1
[   15.120407] Initialise system trusted keyrings
[   15.120407] ----------call_rcu 1---------
[   15.120407] initcall system_trusted_keyring_init+0x0/0xfb returned 0 aft=
er 8277 usecs
[   15.120407] calling  blacklist_init+0x0/0xab @ 1
[   15.120407] Key type blacklist registered
[   15.120407] initcall blacklist_init+0x0/0xab returned 0 after 3932 usecs
[   15.120407] calling  kswapd_init+0x0/0x6f @ 1
[   15.120407] initcall kswapd_init+0x0/0x6f returned 0 after 15 usecs
[   15.120407] calling  extfrag_debug_init+0x0/0x5a @ 1
[   15.120407] initcall extfrag_debug_init+0x0/0x5a returned 0 after 4 usec=
s
[   15.120407] calling  mm_compute_batch_init+0x0/0x1e @ 1
[   15.120407] initcall mm_compute_batch_init+0x0/0x1e returned 0 after 0 u=
secs
[   15.120407] calling  slab_proc_init+0x0/0x27 @ 1
[   15.120407] initcall slab_proc_init+0x0/0x27 returned 0 after 1 usecs
[   15.120407] calling  workingset_init+0x0/0x92 @ 1
[   15.120407] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=
=3D0
[   15.120407] initcall workingset_init+0x0/0x92 returned 0 after 6299 usec=
s
[   15.120407] calling  proc_vmalloc_init+0x0/0x35 @ 1
[   15.120407] initcall proc_vmalloc_init+0x0/0x35 returned 0 after 0 usecs
[   15.120407] calling  procswaps_init+0x0/0x24 @ 1
[   15.120407] initcall procswaps_init+0x0/0x24 returned 0 after 1 usecs
[   15.120407] calling  init_frontswap+0x0/0x96 @ 1
[   15.120407] initcall init_frontswap+0x0/0x96 returned 0 after 8 usecs
[   15.120407] calling  slab_sysfs_init+0x0/0xfc @ 1
[   15.120407] initcall slab_sysfs_init+0x0/0xfc returned 0 after 1465 usec=
s
[   15.120407] calling  init_cleancache+0x0/0x8c @ 1
[   15.120407] initcall init_cleancache+0x0/0x8c returned 0 after 5 usecs
[   15.120407] calling  init_zbud+0x0/0x25 @ 1
[   15.120407] zbud: loaded
[   15.120407] initcall init_zbud+0x0/0x25 returned 0 after 2490 usecs
[   15.120407] calling  zs_init+0x0/0x77 @ 1
[   15.120407] initcall zs_init+0x0/0x77 returned 0 after 12 usecs
[   15.120407] calling  fcntl_init+0x0/0x2f @ 1
[   15.120407] initcall fcntl_init+0x0/0x2f returned 0 after 2 usecs
[   15.120407] calling  proc_filesystems_init+0x0/0x27 @ 1
[   15.120407] initcall proc_filesystems_init+0x0/0x27 returned 0 after 0 u=
secs
[   15.120407] calling  start_dirtytime_writeback+0x0/0x2f @ 1
[   15.120407] initcall start_dirtytime_writeback+0x0/0x2f returned 0 after=
 0 usecs
[   15.120407] calling  blkdev_init+0x0/0x26 @ 1
[   15.120407] initcall blkdev_init+0x0/0x26 returned 0 after 4 usecs
[   15.120407] calling  dio_init+0x0/0x32 @ 1
[   15.120407] initcall dio_init+0x0/0x32 returned 0 after 1 usecs
[   15.120407] calling  dnotify_init+0x0/0x7e @ 1
[   15.120407] initcall dnotify_init+0x0/0x7e returned 0 after 27 usecs
[   15.120407] calling  fanotify_user_setup+0x0/0xa1 @ 1
[   15.120407] initcall fanotify_user_setup+0x0/0xa1 returned 0 after 6 use=
cs
[   15.120407] calling  userfaultfd_init+0x0/0x33 @ 1
[   15.120407] initcall userfaultfd_init+0x0/0x33 returned 0 after 16 usecs
[   15.120407] calling  aio_setup+0x0/0x7e @ 1
[   15.120407] initcall aio_setup+0x0/0x7e returned 0 after 9 usecs
[   15.120407] calling  io_uring_init+0x0/0x32 @ 1
[   15.120407] initcall io_uring_init+0x0/0x32 returned 0 after 1 usecs
[   15.120407] calling  mbcache_init+0x0/0x36 @ 1
[   15.120407] initcall mbcache_init+0x0/0x36 returned 0 after 18 usecs
[   15.120407] calling  init_grace+0x0/0x17 @ 1
[   15.120407] initcall init_grace+0x0/0x17 returned 0 after 1 usecs
[   15.120407] calling  init_devpts_fs+0x0/0x2d @ 1
[   15.120407] initcall init_devpts_fs+0x0/0x2d returned 0 after 7 usecs
[   15.120407] calling  ext4_init_fs+0x0/0x1c3 @ 1
[   15.120407] initcall ext4_init_fs+0x0/0x1c3 returned 0 after 128 usecs
[   15.120407] calling  journal_init+0x0/0x12a @ 1
[   15.120407] initcall journal_init+0x0/0x12a returned 0 after 43 usecs
[   15.120407] calling  init_squashfs_fs+0x0/0x70 @ 1
[   15.120407] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   15.120407] initcall init_squashfs_fs+0x0/0x70 returned 0 after 5716 use=
cs
[   15.120407] calling  init_fat_fs+0x0/0x4f @ 1
[   15.120407] initcall init_fat_fs+0x0/0x4f returned 0 after 30 usecs
[   15.120407] calling  init_vfat_fs+0x0/0x17 @ 1
[   15.120407] initcall init_vfat_fs+0x0/0x17 returned 0 after 0 usecs
[   15.120407] calling  ecryptfs_init+0x0/0x1a6 @ 1
[   15.120407] initcall ecryptfs_init+0x0/0x1a6 returned 0 after 129 usecs
[   15.120407] calling  init_nfs_fs+0x0/0x16c @ 1
[   15.690850] initcall init_nfs_fs+0x0/0x16c returned 0 after 143 usecs
[   15.690850] calling  init_nfs_v2+0x0/0x19 @ 1
[   15.690850] initcall init_nfs_v2+0x0/0x19 returned 0 after 0 usecs
[   15.690850] calling  init_nfs_v3+0x0/0x19 @ 1
[   15.690850] initcall init_nfs_v3+0x0/0x19 returned 0 after 0 usecs
[   15.690850] calling  init_nfs_v4+0x0/0x38 @ 1
[   15.690850] NFS: Registering the id_resolver key type
[   15.690850] Key type id_resolver registered
[   15.690850] Key type id_legacy registered
[   15.690850] initcall init_nfs_v4+0x0/0x38 returned 0 after 12970 usecs
[   15.690850] calling  nfs4filelayout_init+0x0/0x2a @ 1
[   15.690850] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[   15.690850] initcall nfs4filelayout_init+0x0/0x2a returned 0 after 6548 =
usecs
[   15.690850] calling  nfs4blocklayout_init+0x0/0x6b @ 1
[   15.690850] initcall nfs4blocklayout_init+0x0/0x6b returned 0 after 1 us=
ecs
[   15.690850] calling  init_nlm+0x0/0x61 @ 1
[   15.690850] initcall init_nlm+0x0/0x61 returned 0 after 7 usecs
[   15.690850] calling  init_nls_cp437+0x0/0x19 @ 1
[   15.690850] initcall init_nls_cp437+0x0/0x19 returned 0 after 0 usecs
[   15.690850] calling  fuse_init+0x0/0x1ad @ 1
[   15.690850] fuse: init (API version 7.31)
[   15.690850] initcall fuse_init+0x0/0x1ad returned 0 after 3986 usecs
[   15.690850] calling  efivarfs_init+0x0/0x29 @ 1
[   15.690850] initcall efivarfs_init+0x0/0x29 returned -19 after 0 usecs
[   15.690850] calling  ipc_init+0x0/0x2a @ 1
[   15.690850] initcall ipc_init+0x0/0x2a returned 0 after 5 usecs
[   15.690850] calling  ipc_sysctl_init+0x0/0x19 @ 1
[   15.690850] initcall ipc_sysctl_init+0x0/0x19 returned 0 after 9 usecs
[   15.690850] calling  init_mqueue_fs+0x0/0xe2 @ 1
[   15.690850] initcall init_mqueue_fs+0x0/0xe2 returned 0 after 32 usecs
[   15.690850] calling  key_proc_init+0x0/0x69 @ 1
[   15.690850] initcall key_proc_init+0x0/0x69 returned 0 after 1 usecs
[   15.690850] calling  selinux_nf_ip_init+0x0/0x51 @ 1
[   15.690850] initcall selinux_nf_ip_init+0x0/0x51 returned 0 after 0 usec=
s
[   15.690850] calling  init_sel_fs+0x0/0x120 @ 1
[   15.690850] initcall init_sel_fs+0x0/0x120 returned 0 after 0 usecs
[   15.690850] calling  selnl_init+0x0/0x7c @ 1
[   15.690850] initcall selnl_init+0x0/0x7c returned 0 after 4 usecs
[   15.690850] calling  sel_netif_init+0x0/0x48 @ 1
[   15.690850] initcall sel_netif_init+0x0/0x48 returned 0 after 0 usecs
[   15.690850] calling  sel_netnode_init+0x0/0x43 @ 1
[   15.690850] initcall sel_netnode_init+0x0/0x43 returned 0 after 0 usecs
[   15.690850] calling  sel_netport_init+0x0/0x43 @ 1
[   15.690850] initcall sel_netport_init+0x0/0x43 returned 0 after 0 usecs
[   15.690850] calling  aurule_init+0x0/0x30 @ 1
[   15.690850] initcall aurule_init+0x0/0x30 returned 0 after 0 usecs
[   15.690850] calling  init_smk_fs+0x0/0x117 @ 1
[   15.690850] initcall init_smk_fs+0x0/0x117 returned 0 after 0 usecs
[   15.690850] calling  smack_nf_ip_init+0x0/0x2e @ 1
[   15.690850] initcall smack_nf_ip_init+0x0/0x2e returned 0 after 0 usecs
[   15.690850] calling  apparmor_nf_ip_init+0x0/0x37 @ 1
[   15.690850] initcall apparmor_nf_ip_init+0x0/0x37 returned 0 after 39 us=
ecs
[   15.690850] calling  platform_keyring_init+0x0/0x2b @ 1
[   15.690850] integrity: Platform Keyring initialized
[   15.690850] initcall platform_keyring_init+0x0/0x2b returned 0 after 477=
0 usecs
[   15.690850] calling  crypto_algapi_init+0x0/0x12 @ 1
[   15.690850] initcall crypto_algapi_init+0x0/0x12 returned 0 after 0 usec=
s
[   15.690850] calling  jent_mod_init+0x0/0x35 @ 1
[   15.690850] initcall jent_mod_init+0x0/0x35 returned 0 after 11912 usecs
[   15.690850] calling  asymmetric_key_init+0x0/0x17 @ 1
[   15.690850] Key type asymmetric registered
[   15.690850] initcall asymmetric_key_init+0x0/0x17 returned 0 after 4008 =
usecs
[   15.690850] calling  x509_key_init+0x0/0x17 @ 1
[   15.690850] Asymmetric key parser 'x509' registered
[   15.690850] initcall x509_key_init+0x0/0x17 returned 0 after 4770 usecs
[   15.690850] calling  proc_genhd_init+0x0/0x47 @ 1
[   15.690850] initcall proc_genhd_init+0x0/0x47 returned 0 after 1 usecs
[   15.690850] calling  bsg_init+0x0/0x14d @ 1
[   15.690850] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 243)
[   15.690850] initcall bsg_init+0x0/0x14d returned 0 after 7225 usecs
[   15.690850] calling  throtl_init+0x0/0x42 @ 1
[   16.094146] free_pid pid =3D 0xffff9d78d9f8c280
[   16.094146] ----------call_rcu 1---------
[   16.094146] ----------call_rcu 1---------
[   16.094146] initcall throtl_init+0x0/0x42 returned 0 after 12142 usecs
[   16.094146] calling  deadline_init+0x0/0x17 @ 1
[   16.094146] io scheduler mq-deadline registered
[   16.094146] initcall deadline_init+0x0/0x17 returned 0 after 4426 usecs
[   16.094146] calling  btree_module_init+0x0/0x2a @ 1
[   16.094146] initcall btree_module_init+0x0/0x2a returned 0 after 3 usecs
[   16.094146] calling  crc_t10dif_mod_init+0x0/0x4a @ 1
[   16.094146] initcall crc_t10dif_mod_init+0x0/0x4a returned 0 after 2 use=
cs
[   16.094146] calling  percpu_counter_startup+0x0/0x56 @ 1
[   16.157692] initcall percpu_counter_startup+0x0/0x56 returned 0 after 25=
 usecs
[   16.161689] calling  digsig_init+0x0/0x3b @ 1
[   16.161689] initcall digsig_init+0x0/0x3b returned 0 after 1 usecs
[   16.161689] calling  sg_pool_init+0x0/0xde @ 1
[   16.161689] initcall sg_pool_init+0x0/0xde returned 0 after 21 usecs
[   16.161689] calling  phy_core_init+0x0/0x50 @ 1
[   16.161689] initcall phy_core_init+0x0/0x50 returned 0 after 3 usecs
[   16.161689] calling  amd_gpio_driver_init+0x0/0x19 @ 1
[   16.161689] initcall amd_gpio_driver_init+0x0/0x19 returned 0 after 16 u=
secs
[   16.161689] calling  tps68470_gpio_driver_init+0x0/0x19 @ 1
[   16.161689] initcall tps68470_gpio_driver_init+0x0/0x19 returned 0 after=
 6 usecs
[   16.161689] calling  crystalcove_pwm_driver_init+0x0/0x19 @ 1
[   16.161689] initcall crystalcove_pwm_driver_init+0x0/0x19 returned 0 aft=
er 6 usecs
[   16.161689] calling  pwm_lpss_driver_pci_init+0x0/0x20 @ 1
[   16.161689] initcall pwm_lpss_driver_pci_init+0x0/0x20 returned 0 after =
14 usecs
[   16.161689] calling  pwm_lpss_driver_platform_init+0x0/0x19 @ 1
[   16.161689] initcall pwm_lpss_driver_platform_init+0x0/0x19 returned 0 a=
fter 6 usecs
[   16.161689] calling  pcie_portdrv_init+0x0/0x4f @ 1
[   16.161689] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[   16.161689] pcieport 0000:00:1c.4: PME: Signaling with IRQ 124
[   16.161689] pcieport 0000:00:1c.4: AER: enabled with IRQ 124
[   16.161689] pcieport 0000:00:1c.4: DPC: enabled with IRQ 124
[   16.161689] pcieport 0000:00:1c.4: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[   16.161689] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[   16.161689] pcieport 0000:00:1d.0: AER: enabled with IRQ 125
[   16.161689] pcieport 0000:00:1d.0: DPC: enabled with IRQ 125
[   16.161689] pcieport 0000:00:1d.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[   16.161689] pcieport 0000:00:1d.1: PME: Signaling with IRQ 126
[   16.161689] pcieport 0000:00:1d.1: AER: enabled with IRQ 126
[   16.161689] pcieport 0000:00:1d.1: DPC: enabled with IRQ 126
[   16.161689] pcieport 0000:00:1d.1: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[   16.161689] initcall pcie_portdrv_init+0x0/0x4f returned 0 after 94892 u=
secs
[   16.161689] calling  pci_proc_init+0x0/0x76 @ 1
[   16.161689] initcall pci_proc_init+0x0/0x76 returned 0 after 20 usecs
[   16.161689] calling  pci_hotplug_init+0x0/0x36 @ 1
[   16.161689] initcall pci_hotplug_init+0x0/0x36 returned 0 after 0 usecs
[   16.161689] calling  shpcd_init+0x0/0x5e @ 1
[   16.161689] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   16.161689] initcall shpcd_init+0x0/0x5e returned 0 after 6559 usecs
[   16.161689] calling  pci_ep_cfs_init+0x0/0xd3 @ 1
[   16.161689] initcall pci_ep_cfs_init+0x0/0xd3 returned 0 after 13 usecs
[   16.161689] calling  pci_epc_init+0x0/0x47 @ 1
[   16.161689] initcall pci_epc_init+0x0/0x47 returned 0 after 2 usecs
[   16.161689] calling  pci_epf_init+0x0/0x2f @ 1
[   16.161689] initcall pci_epf_init+0x0/0x2f returned 0 after 5 usecs
[   16.161689] calling  dw_plat_pcie_driver_init+0x0/0x19 @ 1
[   16.161689] initcall dw_plat_pcie_driver_init+0x0/0x19 returned 0 after =
7 usecs
[   16.161689] calling  meson_pcie_driver_init+0x0/0x19 @ 1
[   16.161689] initcall meson_pcie_driver_init+0x0/0x19 returned 0 after 5 =
usecs
[   16.161689] calling  imsttfb_init+0x0/0x110 @ 1
[   16.161689] initcall imsttfb_init+0x0/0x110 returned 0 after 9 usecs
[   16.161689] calling  asiliantfb_init+0x0/0x39 @ 1
[   16.161689] initcall asiliantfb_init+0x0/0x39 returned 0 after 9 usecs
[   16.161689] calling  vesafb_driver_init+0x0/0x19 @ 1
[   16.161689] initcall vesafb_driver_init+0x0/0x19 returned 0 after 5 usec=
s
[   16.161689] calling  efifb_driver_init+0x0/0x19 @ 1
[   16.161689] initcall efifb_driver_init+0x0/0x19 returned 0 after 5 usecs
[   16.161689] calling  intel_idle_init+0x0/0x721 @ 1
[   16.161689] initcall intel_idle_init+0x0/0x721 returned -19 after 0 usec=
s
[   16.161689] calling  ged_driver_init+0x0/0x19 @ 1
[   16.161689] initcall ged_driver_init+0x0/0x19 returned 0 after 8 usecs
[   16.161689] calling  acpi_ac_init+0x0/0x98 @ 1
[   16.161689] initcall acpi_ac_init+0x0/0x98 returned 0 after 158 usecs
[   16.161689] calling  acpi_button_driver_init+0x0/0x58 @ 1
[   16.161689] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input0
[   16.161689] ACPI: Sleep Button [SLPB]
[   16.161689] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[   16.161689] ACPI: Power Button [PWRB]
[   16.161689] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[   16.161689]  radix_tree_node_free node =3D 0xffff9d78daf16da0
[   16.161689] ----------call_rcu 1---------
[   16.161689] ACPI: Power Button [PWRF]
[   16.161689] initcall acpi_button_driver_init+0x0/0x58 returned 0 after 4=
3895 usecs
[   16.161689] calling  acpi_fan_driver_init+0x0/0x19 @ 1
[   16.161689] initcall acpi_fan_driver_init+0x0/0x19 returned 0 after 300 =
usecs
[   16.161689] calling  acpi_processor_driver_init+0x0/0xb5 @ 1
[   16.161689] initcall acpi_processor_driver_init+0x0/0xb5 returned 0 afte=
r 153 usecs
[   16.161689] calling  acpi_thermal_init+0x0/0x7f @ 1
[   16.637719] thermal LNXTHERM:00: registered as thermal_zone0
[   16.637719] ACPI: Thermal Zone [TZ00] (28 C)
[   16.637719] initcall acpi_thermal_init+0x0/0x7f returned 0 after 10524 u=
secs
[   16.637719] calling  hmat_init+0x0/0x2a8 @ 1
[   16.637719] initcall hmat_init+0x0/0x2a8 returned 0 after 1 usecs
[   16.637719] calling  acpi_battery_init+0x0/0x38 @ 1
[   16.637719] initcall acpi_battery_init+0x0/0x38 returned 0 after 2 usecs
[   16.637719] calling  acpi_hed_driver_init+0x0/0x17 @ 1
[   16.637719] initcall acpi_hed_driver_init+0x0/0x17 returned 0 after 126 =
usecs
[   16.637719] calling  bgrt_init+0x0/0xba @ 1
[   16.637719] initcall bgrt_init+0x0/0xba returned -19 after 0 usecs
[   16.637719] calling  acpi_aml_init+0x0/0xb5 @ 1
[   16.637719] initcall acpi_aml_init+0x0/0xb5 returned 0 after 3 usecs
[   16.637719] calling  erst_init+0x0/0x319 @ 1
[   16.637719] initcall erst_init+0x0/0x319 returned 0 after 0 usecs
[   16.637719] calling  ghes_init+0x0/0xe3 @ 1
[   16.637719] initcall ghes_init+0x0/0xe3 returned -19 after 0 usecs
[   16.637719] calling  tps68470_pmic_opregion_driver_init+0x0/0x19 @ 1
[   16.637719] initcall tps68470_pmic_opregion_driver_init+0x0/0x19 returne=
d 0 after 7 usecs
[   16.637719] calling  gpio_clk_driver_init+0x0/0x19 @ 1
[   16.637719] initcall gpio_clk_driver_init+0x0/0x19 returned 0 after 5 us=
ecs
[   16.637719] calling  plt_clk_driver_init+0x0/0x19 @ 1
[   16.637719] initcall plt_clk_driver_init+0x0/0x19 returned 0 after 5 use=
cs
[   16.637719] calling  st_clk_driver_init+0x0/0x19 @ 1
[   16.637719] initcall st_clk_driver_init+0x0/0x19 returned 0 after 4 usec=
s
[   16.637719] calling  virtio_mmio_init+0x0/0x19 @ 1
[   16.637719] initcall virtio_mmio_init+0x0/0x19 returned 0 after 6 usecs
[   16.637719] calling  virtio_pci_driver_init+0x0/0x20 @ 1
[   16.637719] initcall virtio_pci_driver_init+0x0/0x20 returned 0 after 12=
 usecs
[   16.637719] calling  virtio_balloon_driver_init+0x0/0x17 @ 1
[   16.637719] initcall virtio_balloon_driver_init+0x0/0x17 returned 0 afte=
r 3 usecs
[   16.637719] calling  n_null_init+0x0/0x24 @ 1
[   16.637719] initcall n_null_init+0x0/0x24 returned 0 after 0 usecs
[   16.637719] calling  pty_init+0x0/0x34f @ 1
[   16.637719] initcall pty_init+0x0/0x34f returned 0 after 25 usecs
[   16.637719] calling  sysrq_init+0x0/0x68 @ 1
[   16.637719] initcall sysrq_init+0x0/0x68 returned 0 after 2 usecs
[   16.637719] calling  serial8250_init+0x0/0x168 @ 1
[   16.637719] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   16.637719] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   16.637719] 00:06: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) =
is a 16550A
[   16.637719]  radix_tree_node_free node =3D 0xffff9d78daf15240
[   16.637719] ----------call_rcu 1---------
[   16.637719] 00:07: ttyS2 at I/O 0x3e8 (irq =3D 7, base_baud =3D 115200) =
is a 16550A
[   16.637719] 00:08: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D 115200) =
is a 16550A
[   16.637719] 00:09: ttyS4 at I/O 0x2f0 (irq =3D 7, base_baud =3D 115200) =
is a 16550A
[   16.637719] 00:0a: ttyS5 at I/O 0x2e0 (irq =3D 7, base_baud =3D 115200) =
is a 16550A
[   16.637719]  radix_tree_node_free node =3D 0xffff9d78daf18490
[   16.637719] ----------call_rcu 1---------
[   16.637719]  radix_tree_node_free node =3D 0xffff9d78daf1bd98
[   16.637719] ----------call_rcu 1---------
[   16.637719]  radix_tree_node_free node =3D 0xffff9d78daf1ada0
[   16.637719] ----------call_rcu 1---------
[   16.637719]  radix_tree_node_free node =3D 0xffff9d78daf18b68
[   16.637719] ----------call_rcu 1---------
[   16.637719] initcall serial8250_init+0x0/0x168 returned 0 after 113521 u=
secs
[   16.637719] calling  serial_pci_driver_init+0x0/0x20 @ 1
[   16.637719] initcall serial_pci_driver_init+0x0/0x20 returned 0 after 21=
 usecs
[   16.637719] calling  max310x_uart_init+0x0/0x34 @ 1
[   16.637719] initcall max310x_uart_init+0x0/0x34 returned 0 after 7 usecs
[   16.637719] calling  sccnxp_uart_driver_init+0x0/0x19 @ 1
[   16.637719] initcall sccnxp_uart_driver_init+0x0/0x19 returned 0 after 7=
 usecs
[   16.637719] calling  init_kgdboc+0x0/0x6b @ 1
[   16.637719] initcall init_kgdboc+0x0/0x6b returned 0 after 25 usecs
[   16.637719] calling  ttyprintk_init+0x0/0xf7 @ 1
[   16.637719] initcall ttyprintk_init+0x0/0xf7 returned 0 after 17 usecs
[   16.637719] calling  init+0x0/0x102 @ 1
[   16.637719] initcall init+0x0/0x102 returned 0 after 12 usecs
[   16.637719] calling  hpet_init+0x0/0x6a @ 1
[   16.637719] initcall hpet_init+0x0/0x6a returned 0 after 177 usecs
[   16.637719] calling  hwrng_modinit+0x0/0x82 @ 1
[   16.637719] initcall hwrng_modinit+0x0/0x82 returned 0 after 25 usecs
[   16.637719] calling  agp_init+0x0/0x2c @ 1
[   16.637719] Linux agpgart interface v0.103
[   16.637719] initcall agp_init+0x0/0x2c returned 0 after 4011 usecs
[   16.637719] calling  agp_amd64_mod_init+0x0/0x26 @ 1
[   16.637719] initcall agp_amd64_mod_init+0x0/0x26 returned -19 after 16 u=
secs
[   16.637719] calling  agp_intel_init+0x0/0x2f @ 1
[   16.637719] initcall agp_intel_init+0x0/0x2f returned 0 after 10 usecs
[   16.637719] calling  agp_via_init+0x0/0x2f @ 1
[   16.637719] initcall agp_via_init+0x0/0x2f returned 0 after 8 usecs
[   16.637719] calling  init_tis+0x0/0xd7 @ 1
[   16.637719] initcall init_tis+0x0/0xd7 returned 0 after 18 usecs
[   16.637719] calling  crb_acpi_driver_init+0x0/0x17 @ 1
[   16.637719] initcall crb_acpi_driver_init+0x0/0x17 returned 0 after 43 u=
secs
[   16.637719] calling  cn_proc_init+0x0/0x3b @ 1
[   16.637719] initcall cn_proc_init+0x0/0x3b returned 0 after 0 usecs
[   16.637719] calling  _nvm_misc_init+0x0/0x17 @ 1
[   16.637719] dentry =3D 0xffff9d78dae79d80
[   16.637719] ----------call_rcu 1---------
[   16.637719] initcall _nvm_misc_init+0x0/0x17 returned 0 after 7712 usecs
[   16.637719] calling  topology_sysfs_init+0x0/0x40 @ 1
[   16.637719] initcall topology_sysfs_init+0x0/0x40 returned 0 after 23 us=
ecs
[   16.637719] calling  cacheinfo_sysfs_init+0x0/0x32 @ 1
[   17.187067] initcall cacheinfo_sysfs_init+0x0/0x32 returned 0 after 388 =
usecs
[   17.191063] calling  devcoredump_init+0x0/0x1e @ 1
[   17.191063] initcall devcoredump_init+0x0/0x1e returned 0 after 3 usecs
[   17.191063] calling  loop_init+0x0/0x16a @ 1
[   17.211535] loop: module loaded
[   17.214615] initcall loop_init+0x0/0x16a returned 0 after 4665 usecs
[   17.214615] calling  htcpld_core_init+0x0/0x32 @ 1
[   17.214615] initcall htcpld_core_init+0x0/0x32 returned -19 after 22 use=
cs
[   17.214615] calling  tps65912_i2c_driver_init+0x0/0x19 @ 1
[   17.214615] initcall tps65912_i2c_driver_init+0x0/0x19 returned 0 after =
4 usecs
[   17.214615] calling  tps65912_spi_driver_init+0x0/0x19 @ 1
[   17.214615] initcall tps65912_spi_driver_init+0x0/0x19 returned 0 after =
4 usecs
[   17.214615] calling  tps68470_driver_init+0x0/0x19 @ 1
[   17.214615] initcall tps68470_driver_init+0x0/0x19 returned 0 after 3 us=
ecs
[   17.214615] calling  twl_driver_init+0x0/0x19 @ 1
[   17.214615] initcall twl_driver_init+0x0/0x19 returned 0 after 3 usecs
[   17.214615] calling  twl4030_audio_driver_init+0x0/0x19 @ 1
[   17.214615] initcall twl4030_audio_driver_init+0x0/0x19 returned 0 after=
 6 usecs
[   17.214615] calling  twl6040_driver_init+0x0/0x19 @ 1
[   17.214615] initcall twl6040_driver_init+0x0/0x19 returned 0 after 3 use=
cs
[   17.214615] calling  smsc_i2c_driver_init+0x0/0x19 @ 1
[   17.214615] initcall smsc_i2c_driver_init+0x0/0x19 returned 0 after 3 us=
ecs
[   17.214615] calling  da9063_i2c_driver_init+0x0/0x19 @ 1
[   17.214615] initcall da9063_i2c_driver_init+0x0/0x19 returned 0 after 3 =
usecs
[   17.214615] calling  max14577_i2c_init+0x0/0x19 @ 1
[   17.214615] initcall max14577_i2c_init+0x0/0x19 returned 0 after 3 usecs
[   17.214615] calling  max77693_i2c_driver_init+0x0/0x19 @ 1
[   17.214615] initcall max77693_i2c_driver_init+0x0/0x19 returned 0 after =
4 usecs
[   17.214615] calling  adp5520_driver_init+0x0/0x19 @ 1
[   17.214615] initcall adp5520_driver_init+0x0/0x19 returned 0 after 2 use=
cs
[   17.214615] calling  intel_soc_pmic_i2c_driver_init+0x0/0x19 @ 1
[   17.214615] initcall intel_soc_pmic_i2c_driver_init+0x0/0x19 returned 0 =
after 3 usecs
[   17.214615] calling  cht_wc_driver_init+0x0/0x19 @ 1
[   17.214615] initcall cht_wc_driver_init+0x0/0x19 returned 0 after 3 usec=
s
[   17.214615] calling  e820_pmem_driver_init+0x0/0x19 @ 1
[   17.214615] initcall e820_pmem_driver_init+0x0/0x19 returned 0 after 5 u=
secs
[   17.214615] calling  udmabuf_dev_init+0x0/0x17 @ 1
[   17.214615] initcall udmabuf_dev_init+0x0/0x17 returned 0 after 21 usecs
[   17.214615] calling  init_sd+0x0/0x1c0 @ 1
[   17.214615] initcall init_sd+0x0/0x1c0 returned 0 after 18 usecs
[   17.214615] calling  init_sr+0x0/0x48 @ 1
[   17.214615] initcall init_sr+0x0/0x48 returned 0 after 2 usecs
[   17.214615] calling  init_sg+0x0/0x1c7 @ 1
[   17.214615] initcall init_sg+0x0/0x1c7 returned 0 after 7 usecs
[   17.214615] calling  piix_init+0x0/0x2e @ 1
[   17.214615] initcall piix_init+0x0/0x2e returned 0 after 14 usecs
[   17.214615] calling  sis_pci_driver_init+0x0/0x20 @ 1
[   17.214615] initcall sis_pci_driver_init+0x0/0x20 returned 0 after 8 use=
cs
[   17.214615] calling  ata_generic_pci_driver_init+0x0/0x20 @ 1
[   17.214615] initcall ata_generic_pci_driver_init+0x0/0x20 returned 0 aft=
er 10 usecs
[   17.214615] calling  net_olddevs_init+0x0/0x67 @ 1
[   17.214615] initcall net_olddevs_init+0x0/0x67 returned 0 after 2 usecs
[   17.214615] calling  blackhole_netdev_init+0x0/0x7e @ 1
[   17.214615] initcall blackhole_netdev_init+0x0/0x7e returned 0 after 4 u=
secs
[   17.214615] calling  fixed_mdio_bus_init+0x0/0xf5 @ 1
[   17.214615] libphy: Fixed MDIO Bus: probed
[   17.214615] initcall fixed_mdio_bus_init+0x0/0xf5 returned 0 after 4110 =
usecs
[   17.214615] calling  tun_init+0x0/0xa4 @ 1
[   17.214615] tun: Universal TUN/TAP device driver, 1.6
[   17.214615] dentry =3D 0xffff9d78dae95a80
[   17.214615] ----------call_rcu 1---------
[   17.214615] initcall tun_init+0x0/0xa4 returned 0 after 12644 usecs
[   17.214615] calling  gvnic_driver_init+0x0/0x20 @ 1
[   17.214615] initcall gvnic_driver_init+0x0/0x20 returned 0 after 11 usec=
s
[   17.214615] calling  hinic_driver_init+0x0/0x20 @ 1
[   17.214615] initcall hinic_driver_init+0x0/0x20 returned 0 after 9 usecs
[   17.214615] calling  e100_init_module+0x0/0x5e @ 1
[   17.214615] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[   17.214615] e100: Copyright(c) 1999-2006 Intel Corporation
[   17.214615] initcall e100_init_module+0x0/0x5e returned 0 after 11337 us=
ecs
[   17.214615] calling  e1000_init_module+0x0/0x7f @ 1
[   17.214615] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-=
NAPI
[   17.214615] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   17.214615] initcall e1000_init_module+0x0/0x7f returned 0 after 12519 u=
secs
[   17.214615] calling  e1000_init_module+0x0/0x3f @ 1
[   17.214615] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   17.214615] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   17.214615] initcall e1000_init_module+0x0/0x3f returned 0 after 11500 u=
secs
[   17.214615] calling  igc_init_module+0x0/0x4d @ 1
[   17.214615] Intel(R) 2.5G Ethernet Linux Driver - version 0.0.1-k
[   17.214615] Copyright(c) 2018 Intel Corporation.
[   17.214615] initcall igc_init_module+0x0/0x4d returned 0 after 10484 use=
cs
[   17.214615] calling  igbvf_init_module+0x0/0x4d @ 1
[   17.214615] igbvf: Intel(R) Gigabit Virtual Function Network Driver - ve=
rsion 2.4.0-k
[   17.214615] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[   17.214615] initcall igbvf_init_module+0x0/0x4d returned 0 after 13441 u=
secs
[   17.214615] calling  ixgbe_init_module+0x0/0xb0 @ 1
[   17.214615] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - vers=
ion 5.1.0-k
[   17.214615] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   17.214615] initcall ixgbe_init_module+0x0/0xb0 returned 0 after 13148 u=
secs
[   17.214615] calling  ixgbevf_init_module+0x0/0x90 @ 1
[   17.214615] ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function Ne=
twork Driver - version 4.1.0-k
[   17.214615] ixgbevf: Copyright (c) 2009 - 2018 Intel Corporation.
[   17.214615] initcall ixgbevf_init_module+0x0/0x90 returned 0 after 15073=
 usecs
[   17.214615] calling  i40e_init_module+0x0/0xa0 @ 1
[   17.214615] i40e: Intel(R) Ethernet Connection XL710 Network Driver - ve=
rsion 2.8.20-k
[   17.214615] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[   17.761056] initcall i40e_init_module+0x0/0xa0 returned 0 after 13481 us=
ecs
[   17.761056] calling  ixgb_init_module+0x0/0x4d @ 1
[   17.761056] ixgb: Intel(R) PRO/10GbE Network Driver - version 1.0.135-k2=
-NAPI
[   17.761056] ixgb: Copyright (c) 1999-2008 Intel Corporation.
[   17.761056] initcall ixgb_init_module+0x0/0x4d returned 0 after 12518 us=
ecs
[   17.761056] calling  iavf_init_module+0x0/0x90 @ 1
[   17.761056] iavf: Intel(R) Ethernet Adaptive Virtual Function Network Dr=
iver - version 3.2.3-k
[   17.761056] Copyright (c) 2013 - 2018 Intel Corporation.
[   17.761056] initcall iavf_init_module+0x0/0x90 returned 0 after 13642 us=
ecs
[   17.761056] calling  fm10k_init_module+0x0/0x70 @ 1
[   17.761056] Intel(R) Ethernet Switch Host Interface Driver - version 0.2=
7.1-k
[   17.761056] Copyright(c) 2013 - 2019 Intel Corporation.
[   17.835657] initcall fm10k_init_module+0x0/0x70 returned 0 after 12123 u=
secs
[   17.835657] calling  ice_module_init+0x0/0xaa @ 1
[   17.835657] ice: Intel(R) Ethernet Connection E800 Series Linux Driver -=
 version 0.8.2-k
[   17.835657] ice: Copyright (c) 2018, Intel Corporation.
[   17.860802] initcall ice_module_init+0x0/0xaa returned 0 after 13055 use=
cs
[   17.860802] calling  jme_init_module+0x0/0x33 @ 1
[   17.860802] jme: JMicron JMC2XX ethernet driver version 1.0.8
[   17.860802] initcall jme_init_module+0x0/0x33 returned 0 after 5627 usec=
s
[   17.860802] calling  orion_mdio_driver_init+0x0/0x19 @ 1
[   17.860802] initcall orion_mdio_driver_init+0x0/0x19 returned 0 after 8 =
usecs
[   17.860802] calling  skge_init_module+0x0/0x3a @ 1
[   17.860802] initcall skge_init_module+0x0/0x3a returned 0 after 9 usecs
[   17.860802] calling  ppp_init+0x0/0x10c @ 1
[   17.860802] PPP generic driver version 2.4.2
[   17.860802] initcall ppp_init+0x0/0x10c returned 0 after 4209 usecs
[   17.860802] calling  cdrom_init+0x0/0x12 @ 1
[   17.860802] initcall cdrom_init+0x0/0x12 returned 0 after 5 usecs
[   17.860802] calling  dwc2_platform_driver_init+0x0/0x19 @ 1
[   17.860802] initcall dwc2_platform_driver_init+0x0/0x19 returned 0 after=
 9 usecs
[   17.860802] calling  ehci_hcd_init+0x0/0xb2 @ 1
[   17.860802] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   17.860802] initcall ehci_hcd_init+0x0/0xb2 returned 0 after 6384 usecs
[   17.860802] calling  ehci_pci_init+0x0/0x6c @ 1
[   17.860802] ehci-pci: EHCI PCI platform driver
[   17.860802] initcall ehci_pci_init+0x0/0x6c returned 0 after 4359 usecs
[   17.860802] calling  ehci_platform_init+0x0/0x4f @ 1
[   17.860802] ehci-platform: EHCI generic platform driver
[   17.860802] initcall ehci_platform_init+0x0/0x4f returned 0 after 5118 u=
secs
[   17.860802] calling  ohci_hcd_mod_init+0x0/0x80 @ 1
[   17.860802] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   17.860802] initcall ohci_hcd_mod_init+0x0/0x80 returned 0 after 6044 us=
ecs
[   17.860802] calling  ohci_pci_init+0x0/0x6c @ 1
[   17.860802] ohci-pci: OHCI PCI platform driver
[   17.860802] initcall ohci_pci_init+0x0/0x6c returned 0 after 4356 usecs
[   17.860802] calling  ohci_platform_init+0x0/0x4f @ 1
[   17.860802] ohci-platform: OHCI generic platform driver
[   17.860802] initcall ohci_platform_init+0x0/0x4f returned 0 after 5118 u=
secs
[   17.860802] calling  uhci_hcd_init+0x0/0x110 @ 1
[   17.860802] uhci_hcd: USB Universal Host Controller Interface driver
[   17.860802] initcall uhci_hcd_init+0x0/0x110 returned 0 after 6231 usecs
[   17.860802] calling  xhci_hcd_init+0x0/0x24 @ 1
[   17.860802] initcall xhci_hcd_init+0x0/0x24 returned 0 after 1 usecs
[   17.860802] calling  xhci_pci_init+0x0/0x54 @ 1
[   17.860802] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   17.860802] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[   17.860802] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[   17.860802] xhci_hcd 0000:00:14.0: cache line size of 64 is not supporte=
d
[   17.860802] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.08
[   17.860802] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   17.860802] usb usb1: Product: xHCI Host Controller
[   17.860802] usb usb1: Manufacturer: Linux 5.8.0+ xhci-hcd
[   17.860802] usb usb1: SerialNumber: 0000:00:14.0
[   17.860802] dentry =3D 0xffff9d78daf740c0
[   17.860802] ----------call_rcu 1---------
[   17.860802] hub 1-0:1.0: USB hub found
[   17.860802] hub 1-0:1.0: 12 ports detected
[   17.860802] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   17.860802] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[   17.860802] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed
[   17.860802] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.08
[   17.860802] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   17.860802] usb usb2: Product: xHCI Host Controller
[   17.860802] usb usb2: Manufacturer: Linux 5.8.0+ xhci-hcd
[   17.860802] usb usb2: SerialNumber: 0000:00:14.0
[   17.860802] dentry =3D 0xffff9d78daf749c0
[   17.860802] ----------call_rcu 1---------
[   17.860802] hub 2-0:1.0: USB hub found
[   17.860802] hub 2-0:1.0: 6 ports detected
[   17.860802] initcall xhci_pci_init+0x0/0x54 returned 0 after 141742 usec=
s
[   17.860802] calling  kgdbdbgp_start_thread+0x0/0x55 @ 1
[   17.860802] initcall kgdbdbgp_start_thread+0x0/0x55 returned 0 after 0 u=
secs
[   17.860802] calling  i8042_init+0x0/0x474 @ 1
[   17.860802] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0=
x60,0x64 irq 1,12
[   18.259581] serio: i8042 KBD port at 0x60,0x64 irq 1
[   18.263193] serio: i8042 AUX port at 0x60,0x64 irq 12
[   18.263193] initcall i8042_init+0x0/0x474 returned 0 after 18891 usecs
[   18.263193] calling  mousedev_init+0x0/0x86 @ 1
[   18.263193] dentry =3D 0xffff9d78daf74180
[   18.263193] ----------call_rcu 1---------
[   18.263193] mousedev: PS/2 mouse device common for all mice
[   18.263193] initcall mousedev_init+0x0/0x86 returned 0 after 13176 usecs
[   18.263193] calling  evdev_init+0x0/0x17 @ 1
[   18.263193] initcall evdev_init+0x0/0x17 returned 0 after 45 usecs
[   18.263193] calling  atkbd_init+0x0/0x2c @ 1
[   18.263193] initcall atkbd_init+0x0/0x2c returned 0 after 10 usecs
[   18.263193] calling  elants_i2c_driver_init+0x0/0x19 @ 1
[   18.263193] initcall elants_i2c_driver_init+0x0/0x19 returned 0 after 37=
 usecs
[   18.263193] calling  uinput_misc_init+0x0/0x17 @ 1
[   18.263193] initcall uinput_misc_init+0x0/0x17 returned 0 after 16 usecs
[   18.263193] calling  cmos_init+0x0/0x6e @ 1
[   18.263193] rtc_cmos rtc_cmos: RTC can wake from S4
[   18.263193] rtc_cmos rtc_cmos: registered as rtc0
[   18.263193] rtc_cmos rtc_cmos: setting system clock to 2020-11-13T09:42:=
05 UTC (1605260525)
[   18.263193] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram, hpet irqs
[   18.263193] initcall cmos_init+0x0/0x6e returned 0 after 26339 usecs
[   18.263193] calling  i2c_dev_init+0x0/0xbe @ 1
[   18.263193] i2c /dev entries driver
[   18.263193] initcall i2c_dev_init+0x0/0xbe returned 0 after 3441 usecs
[   18.263193] calling  restart_poweroff_driver_init+0x0/0x19 @ 1
[   18.263193] initcall restart_poweroff_driver_init+0x0/0x19 returned 0 af=
ter 7 usecs
[   18.263193] calling  watchdog_gov_noop_register+0x0/0x17 @ 1
[   18.263193] initcall watchdog_gov_noop_register+0x0/0x17 returned 0 afte=
r 0 usecs
[   18.263193] calling  dm_init+0x0/0x51 @ 1
[   18.263193] device-mapper: uevent: version 1.0.3
[   18.263193] dentry =3D 0xffff9d78daf75cc0
[   18.263193] ----------call_rcu 1---------
[   18.263193] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised:=
 dm-devel@redhat.com
[   18.263193] initcall dm_init+0x0/0x51 returned 0 after 20542 usecs
[   18.263193] calling  virtual_eisa_root_init+0x0/0x4d @ 1
[   18.263193] platform eisa.0: Probing EISA bus 0
[   18.263193] platform eisa.0: EISA: Cannot allocate resource for mainboar=
d
[   18.263193] platform eisa.0: Cannot allocate resource for EISA slot 1
[   18.263193] platform eisa.0: Cannot allocate resource for EISA slot 2
[   18.263193] platform eisa.0: Cannot allocate resource for EISA slot 3
[   18.263193] platform eisa.0: Cannot allocate resource for EISA slot 4
[   18.263193] platform eisa.0: Cannot allocate resource for EISA slot 5
[   18.263193] platform eisa.0: Cannot allocate resource for EISA slot 6
[   18.263193] platform eisa.0: Cannot allocate resource for EISA slot 7
[   18.263193] platform eisa.0: Cannot allocate resource for EISA slot 8
[   18.263193] platform eisa.0: EISA: Detected 0 cards
[   18.263193] initcall virtual_eisa_root_init+0x0/0x4d returned 0 after 66=
468 usecs
[   18.263193] calling  cpufreq_gov_powersave_init+0x0/0x17 @ 1
[   18.263193] initcall cpufreq_gov_powersave_init+0x0/0x17 returned 0 afte=
r 35 usecs
[   18.263193] calling  cpufreq_gov_userspace_init+0x0/0x17 @ 1
[   18.263193] initcall cpufreq_gov_userspace_init+0x0/0x17 returned 0 afte=
r 0 usecs
[   18.263193] calling  cpufreq_gov_dbs_init+0x0/0x17 @ 1
[   18.263193] initcall cpufreq_gov_dbs_init+0x0/0x17 returned 0 after 0 us=
ecs
[   18.263193] calling  cpufreq_gov_dbs_init+0x0/0x17 @ 1
[   18.263193] initcall cpufreq_gov_dbs_init+0x0/0x17 returned 0 after 34 u=
secs
[   18.263193] calling  intel_pstate_init+0x0/0x48f @ 1
[   18.263193] initcall intel_pstate_init+0x0/0x48f returned -19 after 0 us=
ecs
[   18.263193] calling  haltpoll_init+0x0/0xcf @ 1
[   18.263193] initcall haltpoll_init+0x0/0xcf returned -19 after 0 usecs
[   18.263193] calling  ledtrig_disk_init+0x0/0x59 @ 1
[   18.263193] initcall ledtrig_disk_init+0x0/0x59 returned 0 after 129 use=
cs
[   18.263193] calling  ledtrig_mtd_init+0x0/0x33 @ 1
[   18.263193] initcall ledtrig_mtd_init+0x0/0x33 returned 0 after 0 usecs
[   18.263193] calling  ledtrig_cpu_init+0x0/0xde @ 1
[   18.638950] ledtrig-cpu: registered to indicate activity on CPUs
[   18.642948] initcall ledtrig_cpu_init+0x0/0xde returned 0 after 5906 use=
cs
[   18.642948] calling  ledtrig_panic_init+0x0/0x3e @ 1
[   18.642948] initcall ledtrig_panic_init+0x0/0x3e returned 0 after 0 usec=
s
[   18.642948] calling  efivars_sysfs_init+0x0/0x200 @ 1
[   18.642948] initcall efivars_sysfs_init+0x0/0x200 returned 0 after 0 use=
cs
[   18.642948] calling  esrt_sysfs_init+0x0/0x2e8 @ 1
[   18.642948] initcall esrt_sysfs_init+0x0/0x2e8 returned -38 after 0 usec=
s
[   18.642948] calling  pmc_core_driver_init+0x0/0x19 @ 1
[   18.642948] intel_pmc_core INT33A1:00:  initialized
[   18.642948] initcall pmc_core_driver_init+0x0/0x19 returned 0 after 4835=
 usecs
[   18.642948] calling  pmc_core_platform_init+0x0/0x45 @ 1
[   18.642948] initcall pmc_core_platform_init+0x0/0x45 returned -19 after =
39 usecs
[   18.642948] calling  pmc_atom_init+0x0/0x285 @ 1
[   18.642948] initcall pmc_atom_init+0x0/0x285 returned -19 after 5 usecs
[   18.642948] calling  extcon_class_init+0x0/0x1d @ 1
[   18.642948] initcall extcon_class_init+0x0/0x1d returned 0 after 3 usecs
[   18.642948] calling  autotune_init+0x0/0x17 @ 1
[   18.642948] rtdm_dev_register secondary_mode_only
[   18.642948] rtdm_dev_register realtime_core_enabled
[   18.642948] rtdm_dev_register register_driver
[   18.642948] rtdm_dev_register xnregistry_enter
[   18.642948] rtdm_dev_register device_create
[   18.642948] rtdm_dev_register before return
[   18.642948] initcall autotune_init+0x0/0x17 returned 0 after 26211 usecs
[   18.642948] calling  sock_diag_init+0x0/0x35 @ 1
[   18.782824] initcall sock_diag_init+0x0/0x35 returned 0 after 12 usecs
[   18.782824] calling  init_net_drop_monitor+0x0/0xfc @ 1
[   18.782824] drop_monitor: Initializing network drop monitor service
[   18.782824] initcall init_net_drop_monitor+0x0/0xfc returned 0 after 613=
4 usecs
[   18.782824] calling  blackhole_init+0x0/0x17 @ 1
[   18.782824] initcall blackhole_init+0x0/0x17 returned 0 after 0 usecs
[   18.782824] calling  gre_offload_init+0x0/0x4e @ 1
[   18.782824] initcall gre_offload_init+0x0/0x4e returned 0 after 0 usecs
[   18.782824] calling  bpfilter_sockopt_init+0x0/0x44 @ 1
[   18.782824] initcall bpfilter_sockopt_init+0x0/0x44 returned 0 after 0 u=
secs
[   18.782824] calling  sysctl_ipv4_init+0x0/0x51 @ 1
[   18.782824] initcall sysctl_ipv4_init+0x0/0x51 returned 0 after 55 usecs
[   18.782824] calling  cubictcp_register+0x0/0x5f @ 1
[   18.782824] initcall cubictcp_register+0x0/0x5f returned 0 after 0 usecs
[   18.782824] calling  inet6_init+0x0/0x38d @ 1
[   18.782824] NET: Registered protocol family 10
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf75300
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bf680
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf75540
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bfe00
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf75900
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf750c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8be140
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bf900
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bfcc0
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf75f00
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bea00
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bf400
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bec80
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf75780
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8be640
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf753c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bf040
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76e40
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8be280
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf766c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bf7c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8be8c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8be000
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8be500
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8be780
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8beb40
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bedc0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bf2c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] free_pid pid =3D 0xffff9d78d9f8cb00
[   18.875203] ----------call_rcu 1---------
[   18.875203] ----------call_rcu 1---------
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76b40
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bfa40
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76240
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90957c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76000
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76480
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9095180
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90943c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9095a40
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76300
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9094f00
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9095540
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9095b80
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76540
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90948c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76900
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9094000
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf760c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9095680
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76f00
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9094500
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bf180
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8be3c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bef00
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bf540
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78da8bfb80
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9095040
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9094280
[   18.875203] ----------call_rcu 1---------
[   18.875203] free_pid pid =3D 0xffff9d78d9f8ce00
[   18.875203] ----------call_rcu 1---------
[   18.875203] ----------call_rcu 1---------
[   18.875203] free_pid pid =3D 0xffff9d78d9f8c180
[   18.875203] ----------call_rcu 1---------
[   18.875203] ----------call_rcu 1---------
[   18.875203] free_pid pid =3D 0xffff9d78d9f8c300
[   18.875203] ----------call_rcu 1---------
[   18.875203] ----------call_rcu 1---------
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76780
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9094dc0
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf763c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9094a00
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76a80
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf769c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9095400
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9094c80
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9094640
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76cc0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e5680
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e4500
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e4780
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76c00
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e4b40
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76180
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e4dc0
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76600
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e52c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76d80
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e5e00
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9094780
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9094b40
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90952c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9095e00
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9094140
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9095900
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d9095cc0
[   18.875203] ----------call_rcu 1---------
[   18.875203] free_pid pid =3D 0xffff9d78d9f8c100
[   18.875203] ----------call_rcu 1---------
[   18.875203] ----------call_rcu 1---------
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf76840
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e5cc0
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf77c00
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e4280
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf77180
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf77600
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e57c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e5180
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e43c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf77d80
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e5a40
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e4f00
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e5540
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf77840
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e5b80
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf77e40
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e48c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf776c0
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e4000
[   18.875203] ----------call_rcu 1---------
[   18.875203] dentry =3D 0xffff9d78daf77b40
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e6280
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e4140
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e5900
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e4a00
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e5400
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e4c80
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e4640
[   18.875203] ----------call_rcu 1---------
[   18.875203] file_free file =3D 0xffff9d78d90e5040
[   18.875203] ----------call_rcu 1---------
[   18.875203] free_pid pid =3D 0xffff9d78d9f8cf80
[   18.875203] ----------call_rcu 1---------
[   18.875203] ----------call_rcu 1---------
[   18.875203] Segment Routing with IPv6
[   18.875203] initcall inet6_init+0x0/0x38d returned 0 after 1014552 usecs
[   18.875203] calling  packet_init+0x0/0x7b @ 1
[   18.875203] NET: Registered protocol family 17
[   18.875203] initcall packet_init+0x0/0x7b returned 0 after 4352 usecs
[   18.875203] calling  init_rpcsec_gss+0x0/0x64 @ 1
[   18.875203] initcall init_rpcsec_gss+0x0/0x64 returned 0 after 7 usecs
[   18.875203] calling  strp_dev_init+0x0/0x38 @ 1
[   18.875203] free_pid pid =3D 0xffff9d78d9f8cf00
[   18.875203] ----------call_rcu 1---------
[   18.875203] ----------call_rcu 1---------
[   18.875203] free_pid pid =3D 0xffff9d78d9f8c780
[   18.875203] ----------call_rcu 1---------
[   18.875203] ----------call_rcu 1---------
[   18.875203] initcall strp_dev_init+0x0/0x38 returned 0 after 24264 usecs
[   18.875203] calling  dcbnl_init+0x0/0x52 @ 1
[   18.875203] initcall dcbnl_init+0x0/0x52 returned 0 after 0 usecs
[   18.875203] calling  init_dns_resolver+0x0/0xdb @ 1
[   18.875203] Key type dns_resolver registered
[   18.875203] initcall init_dns_resolver+0x0/0xdb returned 0 after 4187 us=
ecs
[   18.875203] calling  pm_check_save_msr+0x0/0x40 @ 1
[   18.875203] initcall pm_check_save_msr+0x0/0x40 returned 0 after 0 usecs
[   18.875203] calling  mcheck_init_device+0x0/0x14a @ 1
[   20.022312] initcall mcheck_init_device+0x0/0x14a returned 0 after 368 u=
secs
[   20.026308] calling  dev_mcelog_init_device+0x0/0xb9 @ 1
[   20.026308] initcall dev_mcelog_init_device+0x0/0xb9 returned 0 after 24=
 usecs
[   20.026308] calling  tboot_late_init+0x0/0x2c6 @ 1
[   20.026308] initcall tboot_late_init+0x0/0x2c6 returned 0 after 0 usecs
[   20.026308] calling  mcheck_late_init+0x0/0x83 @ 1
[   20.026308] initcall mcheck_late_init+0x0/0x83 returned 0 after 3 usecs
[   20.026308] calling  severities_debugfs_init+0x0/0x2f @ 1
[   20.026308] initcall severities_debugfs_init+0x0/0x2f returned 0 after 1=
 usecs
[   20.026308] calling  microcode_init+0x0/0x217 @ 1
[   20.026308] microcode: sig=3D0x806ec, pf=3D0x80, revision=3D0xb2
[   20.026308] dentry =3D 0xffff9d78daf77540
[   20.026308] ----------call_rcu 1---------
[   20.026308] microcode: Microcode Update Driver: v2.2.
[   20.026308] initcall microcode_init+0x0/0x217 returned 0 after 13117 use=
cs
[   20.026308] calling  resctrl_late_init+0x0/0x691 @ 1
[   20.026308] initcall resctrl_late_init+0x0/0x691 returned -19 after 0 us=
ecs
[   20.026308] calling  hpet_insert_resource+0x0/0x29 @ 1
[   20.026308] initcall hpet_insert_resource+0x0/0x29 returned 0 after 1 us=
ecs
[   20.026308] calling  update_mp_table+0x0/0x520 @ 1
[   20.026308] initcall update_mp_table+0x0/0x520 returned 0 after 0 usecs
[   20.026308] calling  lapic_insert_resource+0x0/0x45 @ 1
[   20.026308] initcall lapic_insert_resource+0x0/0x45 returned 0 after 0 u=
secs
[   20.026308] calling  print_ipi_mode+0x0/0x32 @ 1
[   20.026308] IPI shorthand broadcast: enabled
[   20.026308] initcall print_ipi_mode+0x0/0x32 returned 0 after 4177 usecs
[   20.026308] calling  print_ICs+0x0/0x1b6 @ 1
[   20.026308] initcall print_ICs+0x0/0x1b6 returned 0 after 0 usecs
[   20.026308] calling  create_tlb_single_page_flush_ceiling+0x0/0x2e @ 1
[   20.026308] initcall create_tlb_single_page_flush_ceiling+0x0/0x2e retur=
ned 0 after 1 usecs
[   20.026308] calling  pat_memtype_list_init+0x0/0x3a @ 1
[   20.026308] initcall pat_memtype_list_init+0x0/0x3a returned 0 after 1 u=
secs
[   20.026308] calling  create_init_pkru_value+0x0/0x2e @ 1
[   20.026308] initcall create_init_pkru_value+0x0/0x2e returned 0 after 1 =
usecs
[   20.026308] calling  init_oops_id+0x0/0x40 @ 1
[   20.026308] initcall init_oops_id+0x0/0x40 returned 0 after 0 usecs
[   20.026308] calling  sched_clock_init_late+0x0/0xab @ 1
[   20.026308] sched_clock: Marking stable (18564324353, 1457984575)->(2255=
2746543, -2530437615)
[   20.245622] initcall sched_clock_init_late+0x0/0xab returned 0 after 836=
2 usecs
[   20.252938] calling  sched_init_debug+0x0/0x43 @ 1
[   20.257741] initcall sched_init_debug+0x0/0x43 returned 0 after 2 usecs
[   20.264360] calling  cpu_latency_qos_init+0x0/0x3b @ 1
[   20.269529] initcall cpu_latency_qos_init+0x0/0x3b returned 0 after 20 u=
secs
[   20.276579] calling  pm_debugfs_init+0x0/0x29 @ 1
[   20.281297] initcall pm_debugfs_init+0x0/0x29 returned 0 after 2 usecs
[   20.287830] calling  printk_late_init+0x0/0x129 @ 1
[   20.292719] initcall printk_late_init+0x0/0x129 returned 0 after 0 usecs
[   20.299425] calling  init_srcu_module_notifier+0x0/0x2d @ 1
[   20.305010] initcall init_srcu_module_notifier+0x0/0x2d returned 0 after=
 0 usecs
[   20.312408] calling  swiotlb_create_debugfs+0x0/0x56 @ 1
[   20.317733] initcall swiotlb_create_debugfs+0x0/0x56 returned 0 after 2 =
usecs
[   20.324872] calling  tk_debug_sleep_time_init+0x0/0x29 @ 1
[   20.330369] initcall tk_debug_sleep_time_init+0x0/0x29 returned 0 after =
4 usecs
[   20.337681] calling  debugfs_kprobe_init+0x0/0xb6 @ 1
[   20.342743] initcall debugfs_kprobe_init+0x0/0xb6 returned 0 after 3 use=
cs
[   20.349623] calling  taskstats_init+0x0/0x3c @ 1
[   20.354253] registered taskstats version 1
[   20.358359] initcall taskstats_init+0x0/0x3c returned 0 after 4013 usecs
[   20.365067] calling  init_hwlat_tracer+0x0/0xb8 @ 1
[   20.369959] initcall init_hwlat_tracer+0x0/0xb8 returned 0 after 6 usecs
[   20.376669] calling  kdb_ftrace_register+0x0/0x32 @ 1
[   20.381734] initcall kdb_ftrace_register+0x0/0x32 returned 0 after 1 use=
cs
[   20.388613] calling  bpf_map_iter_init+0x0/0x17 @ 1
[   20.393500] initcall bpf_map_iter_init+0x0/0x17 returned 0 after 0 usecs
[   20.400209] calling  task_iter_init+0x0/0x27 @ 1
[   20.404836] initcall task_iter_init+0x0/0x27 returned 0 after 0 usecs
[   20.411284] calling  init_trampolines+0x0/0x26 @ 1
[   20.416085] initcall init_trampolines+0x0/0x26 returned 0 after 0 usecs
[   20.422708] calling  load_system_certificate_list+0x0/0xfa @ 1
[   20.428548] Loading compiled-in X.509 certificates
[   20.434235] ----------call_rcu 1---------
[   20.438254] Loaded X.509 cert 'Build time autogenerated kernel key: b985=
0493a5d6600c8960a378b5e0e0576565e4fc'
[   20.448170] initcall load_system_certificate_list+0x0/0xfa returned 0 af=
ter 19159 usecs
[   20.456178] calling  memcg_slabinfo_init+0x0/0x29 @ 1
[   20.461240] initcall memcg_slabinfo_init+0x0/0x29 returned 0 after 1 use=
cs
[   20.468120] calling  fault_around_debugfs+0x0/0x29 @ 1
[   20.473270] initcall fault_around_debugfs+0x0/0x29 returned 0 after 1 us=
ecs
[   20.480239] calling  max_swapfiles_check+0x0/0xd @ 1
[   20.485210] initcall max_swapfiles_check+0x0/0xd returned 0 after 0 usec=
s
[   20.492003] calling  init_zswap+0x0/0x465 @ 1
[   20.496396] zswap: loaded using pool lzo/zbud
[   20.500777] free_pid pid =3D 0xffff9d78d9f8c500
[   20.505142] ----------call_rcu 1---------
[   20.509167] ----------call_rcu 1---------
[   20.513186] free_pid pid =3D 0xffff9d78d9f8cc80
[   20.517552] ----------call_rcu 1---------
[   20.521573] ----------call_rcu 1---------
[   20.525646] initcall init_zswap+0x0/0x465 returned 0 after 28584 usecs
[   20.532181] calling  split_huge_pages_debugfs+0x0/0x29 @ 1
[   20.537677] initcall split_huge_pages_debugfs+0x0/0x29 returned 0 after =
1 usecs
[   20.544991] calling  check_early_ioremap_leak+0x0/0x3f @ 1
[   20.550485] initcall check_early_ioremap_leak+0x0/0x3f returned 0 after =
0 usecs
[   20.557802] calling  set_hardened_usercopy+0x0/0x2b @ 1
[   20.563035] initcall set_hardened_usercopy+0x0/0x2b returned 1 after 0 u=
secs
[   20.570089] calling  fscrypt_init+0x0/0x84 @ 1
[   20.574558] Key type ._fscrypt registered
[   20.578581] Key type .fscrypt registered
[   20.582516] Key type fscrypt-provisioning registered
[   20.587492] initcall fscrypt_init+0x0/0x84 returned 0 after 12644 usecs
[   20.594116] calling  pstore_init+0x0/0x5f @ 1
[   20.598488] initcall pstore_init+0x0/0x5f returned 0 after 4 usecs
[   20.604678] calling  init_root_keyring+0x0/0x14 @ 1
[   20.609569] ----------call_rcu 1---------
[   20.613593] ----------call_rcu 1---------
[   20.617610] ----------call_rcu 1---------
[   20.621632] initcall init_root_keyring+0x0/0x14 returned 0 after 11784 u=
secs
[   20.628685] calling  init_trusted+0x0/0x13f @ 1
[   20.633227] initcall init_trusted+0x0/0x13f returned 0 after 0 usecs
[   20.639588] calling  init_encrypted+0x0/0xd5 @ 1
[   20.644234] ----------call_rcu 1---------
[   20.648350] dentry =3D 0xffff9d78daf79840
[   20.652196] ----------call_rcu 1---------
[   20.657164] file_free file =3D 0xffff9d78d90e63c0
[   20.661702] ----------call_rcu 1---------
[   20.665864] dentry =3D 0xffff9d78daf79e40
[   20.669710] ----------call_rcu 1---------
[   20.673733] file_free file =3D 0xffff9d78d90e6000
[   20.678275] ----------call_rcu 1---------
[   20.682299] dentry =3D 0xffff9d78daf796c0
[   20.686144] ----------call_rcu 1---------
[   20.690175] dentry =3D 0xffff9d78daf79b40
[   20.694020] ----------call_rcu 1---------
[   20.698044] file_free file =3D 0xffff9d78d90e7680
[   20.702584] ----------call_rcu 1---------
[   20.706634] file_free file =3D 0xffff9d78d90e6500
[   20.711171] ----------call_rcu 1---------
[   20.715210] file_free file =3D 0xffff9d78d90e6780
[   20.719752] ----------call_rcu 1---------
[   20.723778] dentry =3D 0xffff9d78daf79240
[   20.727620] ----------call_rcu 1---------
[   20.731643] file_free file =3D 0xffff9d78d90e6b40
[   20.736184] ----------call_rcu 1---------
[   20.740213] file_free file =3D 0xffff9d78d90e6dc0
[   20.744753] ----------call_rcu 1---------
[   20.748782] file_free file =3D 0xffff9d78d90e72c0
[   20.753327] ----------call_rcu 1---------
[   20.757348] dentry =3D 0xffff9d78daf79000
[   20.761195] ----------call_rcu 1---------
[   20.765215] file_free file =3D 0xffff9d78d90e7e00
[   20.769757] ----------call_rcu 1---------
[   20.773783] dentry =3D 0xffff9d78daf79480
[   20.777625] ----------call_rcu 1---------
[   20.781638] file_free file =3D 0xffff9d78d90e6140
[   20.786180] ----------call_rcu 1---------
[   20.790209] dentry =3D 0xffff9d78daf79300
[   20.794048] ----------call_rcu 1---------
[   20.798072] file_free file =3D 0xffff9d78d90e7900
[   20.802613] ----------call_rcu 1---------
[   20.806638] dentry =3D 0xffff9d78daf79540
[   20.810480] ----------call_rcu 1---------
[   20.814505] file_free file =3D 0xffff9d78d90e7cc0
[   20.819044] ----------call_rcu 1---------
[   20.823171] file_free file =3D 0xffff9d78d90e77c0
[   20.827711] ----------call_rcu 1---------
[   20.831731] file_free file =3D 0xffff9d78d90e7180
[   20.836272] ----------call_rcu 1---------
[   20.840294] file_free file =3D 0xffff9d78d90e7a40
[   20.844835] ----------call_rcu 1---------
[   20.848857] file_free file =3D 0xffff9d78d90e6f00
[   20.853396] ----------call_rcu 1---------
[   20.857412] file_free file =3D 0xffff9d78d90e7540
[   20.861950] ----------call_rcu 1---------
[   20.865965] file_free file =3D 0xffff9d78d90e7b80
[   20.870506] ----------call_rcu 1---------
[   20.874528] file_free file =3D 0xffff9d78d90e68c0
[   20.879069] ----------call_rcu 1---------
[   20.883101] free_pid pid =3D 0xffff9d78d90b4680
[   20.887466] ----------call_rcu 1---------
[   20.891487] ----------call_rcu 1---------
[   20.895555] ----------call_rcu 1---------
[   20.899668] dentry =3D 0xffff9d78daf79900
[   20.903515] ----------call_rcu 1---------
[   20.908468] file_free file =3D 0xffff9d78d90e6c80
[   20.913005] ----------call_rcu 1---------
[   20.917163] dentry =3D 0xffff9d78daf790c0
[   20.921004] ----------call_rcu 1---------
[   20.925019] file_free file =3D 0xffff9d78d913cf00
[   20.929559] ----------call_rcu 1---------
[   20.933581] dentry =3D 0xffff9d78daf79f00
[   20.937427] ----------call_rcu 1---------
[   20.941463] dentry =3D 0xffff9d78daf79780
[   20.945305] ----------call_rcu 1---------
[   20.949330] file_free file =3D 0xffff9d78d913d540
[   20.953868] ----------call_rcu 1---------
[   20.957908] file_free file =3D 0xffff9d78d913db80
[   20.962448] ----------call_rcu 1---------
[   20.966488] file_free file =3D 0xffff9d78d913c8c0
[   20.971029] ----------call_rcu 1---------
[   20.975052] dentry =3D 0xffff9d78daf793c0
[   20.978899] ----------call_rcu 1---------
[   20.982919] file_free file =3D 0xffff9d78d913c000
[   20.987462] ----------call_rcu 1---------
[   20.991493] file_free file =3D 0xffff9d78d913d680
[   20.996032] ----------call_rcu 1---------
[   21.000059] file_free file =3D 0xffff9d78d913c500
[   21.004604] ----------call_rcu 1---------
[   21.008626] dentry =3D 0xffff9d78daf79a80
[   21.012470] ----------call_rcu 1---------
[   21.016484] file_free file =3D 0xffff9d78d913c780
[   21.021024] ----------call_rcu 1---------
[   21.025042] dentry =3D 0xffff9d78daf799c0
[   21.028888] ----------call_rcu 1---------
[   21.032907] file_free file =3D 0xffff9d78d913cb40
[   21.037447] ----------call_rcu 1---------
[   21.041469] dentry =3D 0xffff9d78daf7acc0
[   21.045318] ----------call_rcu 1---------
[   21.049340] file_free file =3D 0xffff9d78d913cdc0
[   21.053880] ----------call_rcu 1---------
[   21.057904] dentry =3D 0xffff9d78daf7ac00
[   21.061749] ----------call_rcu 1---------
[   21.065772] file_free file =3D 0xffff9d78d913d2c0
[   21.070314] ----------call_rcu 1---------
[   21.074440] file_free file =3D 0xffff9d78d90e6a00
[   21.078980] ----------call_rcu 1---------
[   21.083001] file_free file =3D 0xffff9d78d90e7400
[   21.087543] ----------call_rcu 1---------
[   21.091562] file_free file =3D 0xffff9d78d90e6640
[   21.096105] ----------call_rcu 1---------
[   21.100126] file_free file =3D 0xffff9d78d90e7040
[   21.104666] ----------call_rcu 1---------
[   21.108688] file_free file =3D 0xffff9d78d913d180
[   21.113228] ----------call_rcu 1---------
[   21.117250] file_free file =3D 0xffff9d78d913c3c0
[   21.121791] ----------call_rcu 1---------
[   21.125814] file_free file =3D 0xffff9d78d913da40
[   21.130354] ----------call_rcu 1---------
[   21.134386] free_pid pid =3D 0xffff9d78d90b4980
[   21.138750] ----------call_rcu 1---------
[   21.142765] ----------call_rcu 1---------
[   21.146840] Key type encrypted registered
[   21.150861] initcall init_encrypted+0x0/0xd5 returned 0 after 494768 use=
cs
[   21.157741] calling  init_profile_hash+0x0/0x88 @ 1
[   21.162629] AppArmor: AppArmor sha1 policy hashing enabled
[   21.168125] initcall init_profile_hash+0x0/0x88 returned 0 after 5367 us=
ecs
[   21.175094] calling  integrity_fs_init+0x0/0x4e @ 1
[   21.179982] initcall integrity_fs_init+0x0/0x4e returned 0 after 2 usecs
[   21.186687] calling  load_uefi_certs+0x0/0x2aa @ 1
[   21.191489] initcall load_uefi_certs+0x0/0x2aa returned 0 after 0 usecs
[   21.198112] calling  init_ima+0x0/0xb1 @ 1
[   21.202219] ima: No TPM chip found, activating TPM-bypass!
[   21.207714] ima: Allocated hash algorithm: sha1
[   21.212257] ima: No architecture policies found
[   21.216808] initcall init_ima+0x0/0xb1 returned 0 after 14248 usecs
[   21.223077] calling  init_evm+0x0/0x103 @ 1
[   21.227272] evm: Initialising EVM extended attributes:
[   21.232420] evm: security.selinux
[   21.235748] evm: security.SMACK64
[   21.239077] evm: security.SMACK64EXEC
[   21.242751] evm: security.SMACK64TRANSMUTE
[   21.246857] evm: security.SMACK64MMAP
[   21.250524] evm: security.apparmor
[   21.253937] evm: security.ima
[   21.256912] evm: security.capability
[   21.260498] evm: HMAC attrs: 0x1
[   21.263747] initcall init_evm+0x0/0x103 returned 0 after 35619 usecs
[   21.270103] calling  prandom_reseed+0x0/0x2f @ 1
[   21.274736] initcall prandom_reseed+0x0/0x2f returned 0 after 3 usecs
[   21.281179] calling  init_error_injection+0x0/0x6f @ 1
[   21.286473] initcall init_error_injection+0x0/0x6f returned 0 after 141 =
usecs
[   21.293616] calling  pci_resource_alignment_sysfs_init+0x0/0x1e @ 1
[   21.299892] initcall pci_resource_alignment_sysfs_init+0x0/0x1e returned=
 0 after 1 usecs
[   21.307983] calling  pci_sysfs_init+0x0/0x5a @ 1
[   21.313231] free_pid pid =3D 0xffff9d78d90b4080
[   21.317595] ----------call_rcu 1---------
[   21.321620] ----------call_rcu 1---------
[   21.325644] free_pid pid =3D 0xffff9d78d90b4700
[   21.330004] ----------call_rcu 1---------
[   21.334027] ----------call_rcu 1---------
[   21.340675] initcall pci_sysfs_init+0x0/0x5a returned 0 after 27403 usec=
s
[   21.347471] calling  bert_init+0x0/0x232 @ 1
[   21.351752] initcall bert_init+0x0/0x232 returned 0 after 0 usecs
[   21.357853] calling  clk_debug_init+0x0/0x11b @ 1
[   21.362572] initcall clk_debug_init+0x0/0x11b returned 0 after 6 usecs
[   21.369112] calling  dmar_free_unused_resources+0x0/0xc0 @ 1
[   21.374777] initcall dmar_free_unused_resources+0x0/0xc0 returned 0 afte=
r 0 usecs
[   21.382267] calling  sync_state_resume_initcall+0x0/0x20 @ 1
[   21.387934] initcall sync_state_resume_initcall+0x0/0x20 returned 0 afte=
r 0 usecs
[   21.395424] calling  deferred_probe_initcall+0x0/0xa0 @ 1
[   21.400841] initcall deferred_probe_initcall+0x0/0xa0 returned 0 after 1=
0 usecs
[   21.408153] calling  late_resume_init+0x0/0x118 @ 1
[   21.413041] PM:   Magic number: 12:94:677
[   21.417149] initcall late_resume_init+0x0/0x118 returned 0 after 4010 us=
ecs
[   21.424116] calling  genpd_power_off_unused+0x0/0x83 @ 1
[   21.429438] initcall genpd_power_off_unused+0x0/0x83 returned 0 after 0 =
usecs
[   21.436579] calling  genpd_debug_init+0x0/0x172 @ 1
[   21.441468] initcall genpd_debug_init+0x0/0x172 returned 0 after 2 usecs
[   21.448175] calling  sync_debugfs_init+0x0/0x60 @ 1
[   21.453067] initcall sync_debugfs_init+0x0/0x60 returned 0 after 2 usecs
[   21.459772] calling  charger_manager_init+0x0/0x95 @ 1
[   21.464958] initcall charger_manager_init+0x0/0x95 returned 0 after 38 u=
secs
[   21.472015] calling  dm_init_init+0x0/0x546 @ 1
[   21.476557] initcall dm_init_init+0x0/0x546 returned 0 after 0 usecs
[   21.482918] calling  acpi_cpufreq_init+0x0/0x2c7 @ 1
[   21.487945] initcall acpi_cpufreq_init+0x0/0x2c7 returned -19 after 51 u=
secs
[   21.494999] calling  powernowk8_init+0x0/0x1e0 @ 1
[   21.499799] initcall powernowk8_init+0x0/0x1e0 returned -19 after 0 usec=
s
[   21.506594] calling  pcc_cpufreq_init+0x0/0x4fd @ 1
[   21.511488] initcall pcc_cpufreq_init+0x0/0x4fd returned -19 after 6 use=
cs
[   21.518374] calling  centrino_init+0x0/0x30 @ 1
[   21.522914] initcall centrino_init+0x0/0x30 returned -19 after 0 usecs
[   21.529450] calling  edd_init+0x0/0x29c @ 1
[   21.533642] initcall edd_init+0x0/0x29c returned -19 after 0 usecs
[   21.539831] calling  firmware_memmap_init+0x0/0x38 @ 1
[   21.545021] initcall firmware_memmap_init+0x0/0x38 returned 0 after 40 u=
secs
[   21.552078] calling  register_update_efi_random_seed+0x0/0x24 @ 1
[   21.558178] initcall register_update_efi_random_seed+0x0/0x24 returned 0=
 after 0 usecs
[   21.566101] calling  efi_shutdown_init+0x0/0x42 @ 1
[   21.570989] initcall efi_shutdown_init+0x0/0x42 returned -19 after 0 use=
cs
[   21.577870] calling  efi_earlycon_unmap_fb+0x0/0x2e @ 1
[   21.583103] initcall efi_earlycon_unmap_fb+0x0/0x2e returned 0 after 0 u=
secs
[   21.590159] calling  itmt_legacy_init+0x0/0x50 @ 1
[   21.594958] initcall itmt_legacy_init+0x0/0x50 returned -19 after 0 usec=
s
[   21.601755] calling  cec_init+0x0/0x173 @ 1
[   21.605954] RAS: Correctable Errors collector initialized.
[   21.611443] initcall cec_init+0x0/0x173 returned 46 after 5364 usecs
[   21.617804] calling  tcp_congestion_default+0x0/0x1e @ 1
[   21.623126] initcall tcp_congestion_default+0x0/0x1e returned 0 after 0 =
usecs
[   21.630268] calling  ip_auto_config+0x0/0x100f @ 1
[   21.635072] initcall ip_auto_config+0x0/0x100f returned 0 after 5 usecs
[   21.641692] calling  pci_mmcfg_late_insert_resources+0x0/0x58 @ 1
[   21.647793] initcall pci_mmcfg_late_insert_resources+0x0/0x58 returned 0=
 after 0 usecs
[   21.655711] calling  software_resume+0x0/0x2b0 @ 1
[   21.660513] initcall software_resume+0x0/0x2b0 returned -2 after 0 usecs
[   21.667222] calling  latency_fsnotify_init+0x0/0x3a @ 1
[   21.672463] initcall latency_fsnotify_init+0x0/0x3a returned 0 after 8 u=
secs
[   21.679519] calling  clear_boot_tracer+0x0/0x2e @ 1
[   21.684407] initcall clear_boot_tracer+0x0/0x2e returned 0 after 0 usecs
[   21.691113] calling  tracing_set_default_clock+0x0/0x61 @ 1
[   21.696697] initcall tracing_set_default_clock+0x0/0x61 returned 0 after=
 0 usecs
[   21.704098] calling  acpi_gpio_handle_deferred_request_irqs+0x0/0x88 @ 1
[   21.710804] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0x88 ret=
urned 0 after 0 usecs
[   21.719333] calling  clk_disable_unused+0x0/0x107 @ 1
[   21.724395] initcall clk_disable_unused+0x0/0x107 returned 0 after 0 use=
cs
[   21.731274] calling  regulator_init_complete+0x0/0x2a @ 1
[   21.736682] initcall regulator_init_complete+0x0/0x2a returned 0 after 0=
 usecs
[   21.745150] Freeing unused decrypted memory: 2040K
[   21.750382] call  free_kernel_image_pages----
[   21.755639] Freeing unused kernel image (initmem) memory: 2784K
[   21.762107] out of free_init_pages----
[   21.766217] leaving free_initmem----
[   21.770125] rcu_barrier begine
[   21.773479] rcu_barrier begine barrier_cpu_count =3D 0x2
[   21.779107] rcu_barrier begine cpu num =3D 0x4
[   21.783767] rcu_barrier begine barrier_cpu_count =3D 0x1
[   21.789408] rcu_barrier begine done =3D 0x0

Regards

Hongzhan Chen


