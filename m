MIME-Version: 1.0
In-Reply-To: <20150402204139.GL31175@hermes.click-hack.org>
References: <54F56C9C.6080507@siemens.com>
 <CAPRPZsC9mPitPUmXXR6QQfAGN3UMa2u6hkVwjtO4Eoh-NzC7wA@mail.gmail.com>
 <54FDB495.3060303@triphase.com> <5501FC89.2040205@siemens.com>
 <20150313163431.GE1497@hermes.click-hack.org>
 <550319B3.1050902@siemens.com>
 <20150313171211.GH1497@hermes.click-hack.org>
 <CAPRPZsD4503Yc92d=e0jqR8HtLiV8rXo_vA2e5ea5V_gyCTOzA@mail.gmail.com>
 <20150402191555.GK31175@hermes.click-hack.org>
 <CAPRPZsCcAQCYNbVXzB5yW+hNzhLcrDLETDteFLgDLnuzz6RCsA@mail.gmail.com>
 <20150402204139.GL31175@hermes.click-hack.org>
Date: Wed, 8 Apr 2015 23:02:50 +0200
Message-ID: <CAPRPZsDr__xN4EX8hXn8Wn+j67ip+eAzEOB4so9crCuz8_E+sA@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] xeno3_rc3 - Watchdog detected hard LOCKUP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

It took a while, but a hard lockup occurred on Xenomai 3.0-rc4 with
Linux 3.16.7 running dohell. This time, I believe I have a trace of
the locked up CPU. It's listed below and for completeness, the first
part of the dmesg log is attached as well.

[419215.683857] Kernel panic - not syncing: Watchdog detected hard
LOCKUP on cpu 3
[419215.683886] CPU: 3 PID: 18835 Comm: dohell Not tainted 3.16.7-cobalt #1
[419215.683903] Hardware name: Supermicro X10SAE/X10SAE, BIOS 2.0a 05/09/2014
[419215.683920]  0000000000000000 ffff88021fb86c38 ffffffff8175761d
ffffffff81a8a1e8
[419215.683945]  ffff88021fb86cb0 ffffffff81752c0e 0000000000000010
ffff88021fb86cc0
[419215.683968]  ffff88021fb86c60 0000000000000000 0000000000000003
000000000001999e
[419215.684095] Call Trace:
[419215.684103]  <NMI>  [<ffffffff8175761d>] dump_stack+0x45/0x56
[419215.684125]  [<ffffffff81752c0e>] panic+0xd8/0x20a
[419215.684141]  [<ffffffff81103f02>] watchdog_overflow_callback+0xc2/0xd0
[419215.684158]  [<ffffffff8114257d>] __perf_event_overflow+0x8d/0x230
[419215.684174]  [<ffffffff81143024>] perf_event_overflow+0x14/0x20
[419215.684190]  [<ffffffff81020326>] intel_pmu_handle_irq+0x1e6/0x400
[419215.684259]  [<ffffffff811cb501>] ? unmap_kernel_range_noflush+0x11/0x20
[419215.684277]  [<ffffffff81017f2b>] perf_event_nmi_handler+0x2b/0x50
[419215.684293]  [<ffffffff81006f68>] nmi_handle+0x88/0x120
[419215.684308]  [<ffffffff8100755e>] default_do_nmi+0xce/0x130
[419215.684373]  [<ffffffff81007690>] do_nmi+0xd0/0xf0
[419215.684387]  [<ffffffff8176175a>] end_repeat_nmi+0x1e/0x2e
[419215.684402]  [<ffffffff8175ea4a>] ? _raw_spin_lock+0x2a/0x40
[419215.684417]  [<ffffffff8175ea4a>] ? _raw_spin_lock+0x2a/0x40
[419215.684431]  [<ffffffff8175ea4a>] ? _raw_spin_lock+0x2a/0x40
[419215.684445]  <<EOE>>  [<ffffffff81046bac>]
__ipipe_pin_range_globally+0x7c/0x2b0
[419215.684468]  [<ffffffff8139efe6>] ioremap_page_range+0x226/0x300
[419215.684485]  [<ffffffff8114e90a>] ? xnintr_core_clock_handler+0x2ea/0x310
[419215.684553]  [<ffffffff81093eb0>] ? update_curr+0x80/0x180
[419215.684568]  [<ffffffff81455e09>] ghes_copy_tofrom_phys+0x1e9/0x200
[419215.684584]  [<ffffffff81456b70>] ? ghes_irq_func+0x20/0x20
[419215.684599]  [<ffffffff81455ea0>] ghes_read_estatus+0x80/0x160
[419215.684614]  [<ffffffff81456a64>] ghes_proc+0x14/0x80
[419215.684628]  [<ffffffff81456b82>] ghes_poll_func+0x12/0x30
[419215.684643]  [<ffffffff81064f16>] call_timer_fn+0x36/0x100
[419215.684708]  [<ffffffff81456b70>] ? ghes_irq_func+0x20/0x20
[419215.684723]  [<ffffffff810652d8>] run_timer_softirq+0x208/0x2f0
[419215.684738]  [<ffffffff8105dc45>] __do_softirq+0xe5/0x290
[419215.684752]  [<ffffffff817623b0>] ? do_IRQ+0x100/0x100
[419215.684766]  [<ffffffff8105e0bd>] irq_exit+0xbd/0xd0
[419215.684779]  [<ffffffff817623e5>] smp_apic_timer_interrupt+0x35/0x50
[419215.684795]  [<ffffffff81032e39>] __ipipe_do_IRQ+0x79/0x90
[419215.684810]  [<ffffffff817623b0>] ? do_IRQ+0x100/0x100
[419215.684823]  [<ffffffff81032e3f>] ? __ipipe_do_IRQ+0x7f/0x90
[419215.684839]  [<ffffffff811076d9>] __ipipe_do_sync_stage+0x169/0x170
[419215.684855]  [<ffffffff811077fd>] __ipipe_do_sync_pipeline+0x9d/0xa0
[419215.684871]  [<ffffffff81107bb8>] __ipipe_dispatch_irq+0x188/0x2a0
[419215.684938]  [<ffffffff81033415>] __ipipe_handle_irq+0x65/0x180
[419215.684954]  [<ffffffff81760020>] apic_timer_interrupt+0x60/0x90
[419215.684970]  [<ffffffff8104b710>] ? pgd_alloc+0x70/0x1c0
[419215.684984]  [<ffffffff8105550a>] mm_init+0xfa/0x150
[419215.684998]  [<ffffffff810571d7>] copy_process.part.30+0x12a7/0x1be0
[419215.685015]  [<ffffffff8115cabd>] ? xnthread_switch_fpu+0x2d/0x40
[419215.685030]  [<ffffffff8115577f>] ? __xnsched_run+0x16f/0x490
[419215.685046]  [<ffffffff81057ce5>] do_fork+0xd5/0x340
[419215.685059]  [<ffffffff81057fd6>] SyS_clone+0x16/0x20
[419215.685072]  [<ffffffff8175f389>] stub_clone+0x69/0x90
[419215.685086]  [<ffffffff8175ef8c>] ? system_call_fastpath+0x1a/0x1f
[419215.685104] Kernel Offset: 0x0 from 0xffffffff81000000 (relocation
range: 0xffffffff80000000-0xffffffff9fffffff)
[419215.685179] drm_kms_helper: panic occurred, switching back to text console
[419215.762331] ---[ end Kernel panic - not syncing: Watchdog detected
hard LOCKUP on cpu 3

Head of dmesg:

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.16.7-cobalt (vdkeybus@x10sae) (gcc
version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #1 SMP Fri Apr 3 00:47:00
CEST 2015
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.16.7-cobalt
root=UUID=4cc8572b-8982-4cfe-9887-070196bd6827 ro
netconsole=6665@192.168.16.130/eth0,6666@192.168.16.11/54:04:a6:62:0a:a5
debug loglevel=7 systemd.log_level=debug systemd.log_target=kmsg
softlockup_all_cpu_backtrace=1
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c91f9fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c91fa000-0x00000000c9200fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000c9201000-0x00000000c9b12fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c9b13000-0x00000000c9f0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c9f10000-0x00000000d97c3fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d97c4000-0x00000000d988dfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d988e000-0x00000000d98d5fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d98d6000-0x00000000d9a06fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000d9a07000-0x00000000d9ffefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d9fff000-0x00000000d9ffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dc000000-0x00000000de1fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021fdfffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x21fe00 max_arch_pfn = 0x400000000
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] total RAM covered: 8126M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K  chunk_size: 128M        num_reg: 7
 lose cover RAM: 0G
[    0.000000] e820: last_pfn = 0xda000 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fd800-0x000fd80f]
mapped at [ffff8800000fd800]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000] init_memory_mapping: [mem 0x21fc00000-0x21fdfffff]
[    0.000000] init_memory_mapping: [mem 0x21c000000-0x21fbfffff]
[    0.000000] init_memory_mapping: [mem 0x200000000-0x21bffffff]
[    0.000000] init_memory_mapping: [mem 0x00100000-0xc91f9fff]
[    0.000000] init_memory_mapping: [mem 0xc9201000-0xc9b12fff]
[    0.000000] init_memory_mapping: [mem 0xc9f10000-0xd97c3fff]
[    0.000000] init_memory_mapping: [mem 0xd988e000-0xd98d5fff]
[    0.000000] init_memory_mapping: [mem 0xd9fff000-0xd9ffffff]
[    0.000000] init_memory_mapping: [mem 0x100000000-0x1ffffffff]
[    0.000000] RAMDISK: [mem 0x1dfbe000-0x2afd6fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0490 000024 (v02 SUPERM)
[    0.000000] ACPI: XSDT 0x00000000D99DA098 0000B4 (v01 SUPERM
SMCI--MB 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000D99E6FC8 00010C (v05 SUPERM
SMCI--MB 01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000D99DA1E8 00CDDA (v02 SUPERM
SMCI--MB 00000000 INTL 20120711)
[    0.000000] ACPI: FACS 0x00000000D9A06F80 000040
[    0.000000] ACPI: APIC 0x00000000D99E70D8 000072 (v03 SUPERM
SMCI--MB 01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000D99E7150 000044 (v01 SUPERM
SMCI--MB 01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000D99E7198 000BEE (v01 Ther_R
Ther_Rvp 00001000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000D99E7D88 000539 (v01 PmRef
Cpu0Ist  00003000 INTL 20051117)
[    0.000000] ACPI: SSDT 0x00000000D99E82C8 000B74 (v01 CpuRef
CpuSsdt  00003000 INTL 20051117)
[    0.000000] ACPI: SSDT 0x00000000D99E8E40 0002DE (v01 PmRef
Cpu0Tst  00003000 INTL 20051117)
[    0.000000] ACPI: SSDT 0x00000000D99E9120 000348 (v01 PmRef  ApTst
  00003000 INTL 20051117)
[    0.000000] ACPI: MCFG 0x00000000D99E9468 00003C (v01 SUPERM
SMCI--MB 01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000D99E94A8 000038 (v01 SUPERM
SMCI--MB 01072009 AMI. 00000005)
[    0.000000] ACPI: SSDT 0x00000000D99E94E0 000397 (v01 SataRe
SataTabl 00001000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000D99E9878 005B5E (v01 SaSsdt SaSsdt
  00003000 INTL 20120711)
[    0.000000] ACPI: ASF! 0x00000000D99EF3D8 0000A5 (v32 INTEL   HCG
  00000001 TFSM 000F4240)
[    0.000000] ACPI: DMAR 0x00000000D99EF480 0000B8 (v01 INTEL  BDW
  00000001 INTL 00000001)
[    0.000000] ACPI: EINJ 0x00000000D99EF538 000130 (v01 AMI    AMI
EINJ 00000000      00000000)
[    0.000000] ACPI: ERST 0x00000000D99EF668 000230 (v01 AMIER  AMI
ERST 00000000      00000000)
[    0.000000] ACPI: HEST 0x00000000D99EF898 0000A8 (v01 AMI    AMI
HEST 00000000      00000000)
[    0.000000] ACPI: BERT 0x00000000D99EF940 000030 (v01 AMI    AMI
BERT 00000000      00000000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000021fdfffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x21fdfffff]
[    0.000000]   NODE_DATA [mem 0x21fdf5000-0x21fdf9fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x21fdfffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009cfff]
[    0.000000]   node   0: [mem 0x00100000-0xc91f9fff]
[    0.000000]   node   0: [mem 0xc9201000-0xc9b12fff]
[    0.000000]   node   0: [mem 0xc9f10000-0xd97c3fff]
[    0.000000]   node   0: [mem 0xd988e000-0xd98d5fff]
[    0.000000]   node   0: [mem 0xd9fff000-0xd9ffffff]
[    0.000000]   node   0: [mem 0x100000000-0x21fdfffff]
[    0.000000] Reserving Intel graphics stolen memory at 0xdc200000-0xde1fffff
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc91fa000-0xc9200fff]
[    0.000000] PM: Registered nosave memory: [mem 0xc9b13000-0xc9f0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd97c4000-0xd988dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xd98d6000-0xd9a06fff]
[    0.000000] PM: Registered nosave memory: [mem 0xd9a07000-0xd9ffefff]
[    0.000000] PM: Registered nosave memory: [mem 0xda000000-0xdbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdc000000-0xde1fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xde200000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xde200000-0xf7ffffff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256
nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 96 pages/cpu @ffff88021fa00000 s363520
r8192 d21504 u524288
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 2036551
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-3.16.7-cobalt
root=UUID=4cc8572b-8982-4cfe-9887-070196bd6827 ro
netconsole=6665@192.168.16.130/eth0,6666@192.168.16.11/54:04:a6:62:0a:a5
debug loglevel=7 systemd.log_level=debug systemd.log_target=kmsg
softlockup_all_cpu_backtrace=1
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Memory: 7843664K/8275604K available (7571K kernel code,
1103K rwdata, 3592K rodata, 1664K init, 4688K bss, 431940K reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000]  RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.000000]  Offload RCU callbacks from all CPUs
[    0.000000]  Offload RCU callbacks from CPUs: 0-3.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS:16640 nr_irqs:712 16
[    0.000000] Interrupt pipeline (release #3)
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 33554432 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't
want memory cgroups
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] tsc: PIT calibration matches HPET. 1 loops
[    0.000000] tsc: Detected 3400.170 MHz processor
[    0.000020] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6800.34 BogoMIPS (lpj=13600680)
[    0.000024] pid_max: default: 32768 minimum: 301
[    0.000028] ACPI: Core revision 20140424
[    0.012011] ACPI: All ACPI Tables successfully acquired
[    0.013491] Security Framework initialized
[    0.013500] AppArmor: AppArmor initialized
[    0.013501] Yama: becoming mindful.
[    0.013859] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes)
[    0.014893] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.015328] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.015336] Mountpoint-cache hash table entries: 16384 (order: 5,
131072 bytes)
[    0.015488] Initializing cgroup subsys memory
[    0.015504] Initializing cgroup subsys devices
[    0.015509] Initializing cgroup subsys freezer
[    0.015512] Initializing cgroup subsys net_cls
[    0.015515] Initializing cgroup subsys blkio
[    0.015518] Initializing cgroup subsys perf_event
[    0.015520] Initializing cgroup subsys net_prio
[    0.015525] Initializing cgroup subsys hugetlb
[    0.015541] CPU: Physical Processor ID: 0
[    0.015542] CPU: Processor Core ID: 0
[    0.015545] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.015545] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.016287] mce: CPU supports 9 MCE banks
[    0.016298] CPU0: Thermal monitoring enabled (TM1)
[    0.016307] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.016307] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.016307] tlb_flushall_shift: 6
[    0.016402] Freeing SMP alternatives memory: 28K (ffffffff81eb5000
- ffffffff81ebc000)
[    0.016404] ftrace: allocating 28786 entries in 113 pages
[    0.024995] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.064658] smpboot: CPU0: Intel(R) Core(TM) i5-4670 CPU @ 3.40GHz
(fam: 06, model: 3c, stepping: 03)
[    0.064686] Performance Events: PEBS fmt2+, 16-deep LBR, Haswell
events, full-width counters, Intel PMU driver.
[    0.064701] ... version:                3
[    0.064702] ... bit width:              48
[    0.064703] ... generic registers:      8
[    0.064704] ... value mask:             0000ffffffffffff
[    0.064705] ... max period:             0000ffffffffffff
[    0.064706] ... fixed-purpose events:   3
[    0.064708] ... event mask:             00000007000000ff
[    0.065676] x86: Booting SMP configuration:
[    0.065678] .... node  #0, CPUs:      #1
[    0.079535] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
[    0.079587]  #2 #3
[    0.107400] x86: Booted up 1 node, 4 CPUs
[    0.107404] smpboot: Total of 4 processors activated (27201.36 BogoMIPS)
[    0.109685] devtmpfs: initialized
[    0.111362] evm: security.selinux
[    0.111364] evm: security.SMACK64
[    0.111365] evm: security.ima
[    0.111366] evm: security.capability
[    0.111408] PM: Registering ACPI NVS region [mem
0xc91fa000-0xc9200fff] (28672 bytes)
[    0.111410] PM: Registering ACPI NVS region [mem
0xd98d6000-0xd9a06fff] (1249280 bytes)
[    0.111933] pinctrl core: initialized pinctrl subsystem
[    0.111979] regulator-dummy: no parameters
[    0.112014] RTC time: 22:56:16, date: 04/02/15
[    0.112044] NET: Registered protocol family 16
[    0.112150] cpuidle: using governor ladder
[    0.112152] cpuidle: using governor menu
[    0.112192] ACPI: bus type PCI registered
[    0.112194] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.112243] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.112246] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.112283] PCI: Using configuration type 1 for base access
[    0.117824] ACPI: Added _OSI(Module Device)
[    0.117827] ACPI: Added _OSI(Processor Device)
[    0.117828] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.117830] ACPI: Added _OSI(Processor Aggregator Device)
[    0.121885] ACPI: Executed 5 blocks of module-level executable AML code
[    0.137613] ACPI: Dynamic OEM Table Load:
[    0.137618] ACPI: SSDT 0xFFFF88021432DC00 0003D3 (v01 PmRef
Cpu0Cst  00003001 INTL 20051117)
[    0.141698] ACPI: Dynamic OEM Table Load:
[    0.141703] ACPI: SSDT 0xFFFF880213D29000 0005AA (v01 PmRef  ApIst
  00003000 INTL 20051117)
[    0.145599] ACPI: Dynamic OEM Table Load:
[    0.145603] ACPI: SSDT 0xFFFF880213D11800 000119 (v01 PmRef  ApCst
  00003000 INTL 20051117)
[    0.149951] ACPI: Interpreter enabled
[    0.149960] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep
State [\_S2_] (20140424/hwxface-580)
[    0.149966] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep
State [\_S3_] (20140424/hwxface-580)
[    0.149975] ACPI: (supports S0 S1 S4 S5)
[    0.149977] ACPI: Using IOAPIC for interrupt routing
[    0.150013] HEST: Table parsing has been initialized.
[    0.150016] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.150339] ACPI: Power Resource [PG00] (on)
[    0.153732] ACPI: Power Resource [PG01] (on)
[    0.157726] ACPI: Power Resource [PG02] (on)
[    0.167196] ACPI: Power Resource [FN00] (off)
[    0.167246] ACPI: Power Resource [FN01] (off)
[    0.167295] ACPI: Power Resource [FN02] (off)
[    0.167342] ACPI: Power Resource [FN03] (off)
[    0.167390] ACPI: Power Resource [FN04] (off)
[    0.168031] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.168035] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.168473] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
AER PCIeCapability]
[    0.168891] PCI host bridge to bus 0000:00
[    0.168894] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.168896] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.168897] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.168899] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.168900] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff]
[    0.168902] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
[    0.168903] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
[    0.168904] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff]
[    0.168906] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff]
[    0.168907] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff]
[    0.168909] pci_bus 0000:00: root bus resource [mem 0xde200000-0xfeafffff]
[    0.169263] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.169692] pci 0000:00:19.0: System wakeup disabled by ACPI
[    0.169870] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.170015] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.170147] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.170280] pci 0000:00:1c.3: System wakeup disabled by ACPI
[    0.170403] pci 0000:00:1c.5: System wakeup disabled by ACPI
[    0.170526] pci 0000:00:1c.6: System wakeup disabled by ACPI
[    0.170648] pci 0000:00:1c.7: System wakeup disabled by ACPI
[    0.170824] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.171415] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.171798] pci 0000:02:00.0: System wakeup disabled by ACPI
[    0.181570] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    0.181823] pci 0000:03:00.0: System wakeup disabled by ACPI
[    0.181850] pci 0000:00:1c.5: PCI bridge to [bus 03-04]
[    0.182265] pci 0000:03:00.0: PCI bridge to [bus 04] (subtractive decode)
[    0.182650] pci 0000:05:00.0: System wakeup disabled by ACPI
[    0.189614] pci 0000:00:1c.6: PCI bridge to [bus 05]
[    0.189842] pci 0000:06:00.0: System wakeup disabled by ACPI
[    0.197565] pci 0000:00:1c.7: PCI bridge to [bus 06]
[    6.727463] console [netcon0] enabled
[    6.751470] netconsole: network logging started
[    6.775516] rtc_cmos 00:02: setting system clock to 2015-04-02
22:56:23 UTC (1428015383)
[    6.800149] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    6.824635] EDD information not available.
[    6.849722] Freeing unused kernel memory: 1664K (ffffffff81d15000 -
ffffffff81eb5000)
[    6.874590] Write protecting the kernel read-only data: 12288k
[    6.900374] Freeing unused kernel memory: 608K (ffff880001768000 -
ffff880001800000)
[    6.926382] Freeing unused kernel memory: 504K (ffff880001b82000 -
ffff880001c00000)
[    6.983504] systemd-udevd[120]: starting version 204
[    7.022242] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6
Gbps 0x3f impl SATA mode
[    7.048213] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum
part ems apst
[    7.074037] hidraw: raw HID events driver (C) Jiri Kosina
[    7.099823] usb-storage 3-13:1.0: USB Mass Storage device detected
[    7.116063] scsi0 : ahci
[    7.116138] scsi1 : ahci
[    7.116197] scsi2 : ahci
[    7.116251] scsi3 : ahci
[    7.116304] scsi4 : ahci
[    7.116357] scsi5 : ahci
[    7.116391] ata1: SATA max UDMA/133 abar m2048@0xf7c3a000 port
0xf7c3a100 irq 56
[    7.116393] ata2: SATA max UDMA/133 abar m2048@0xf7c3a000 port
0xf7c3a180 irq 56
[    7.116394] ata3: SATA max UDMA/133 abar m2048@0xf7c3a000 port
0xf7c3a200 irq 56
[    7.116396] ata4: SATA max UDMA/133 abar m2048@0xf7c3a000 port
0xf7c3a280 irq 56
[    7.116398] ata5: SATA max UDMA/133 abar m2048@0xf7c3a000 port
0xf7c3a300 irq 56
[    7.116400] ata6: SATA max UDMA/133 abar m2048@0xf7c3a000 port
0xf7c3a380 irq 56
[    7.116539] ahci 0000:06:00.0: SSS flag set, parallel bus scan disabled
[    7.116572] ahci 0000:06:00.0: AHCI 0001.0200 32 slots 2 ports 6
Gbps 0x3 impl SATA mode
[    7.116574] ahci 0000:06:00.0: flags: 64bit ncq sntf stag led clo
pmp pio slum part ccc sxs
[    7.116794] scsi6 : ahci
[    7.116857] scsi7 : ahci
[    7.116893] ata7: SATA max UDMA/133 abar m512@0xf7800000 port
0xf7800100 irq 57
[    7.116895] ata8: SATA max UDMA/133 abar m512@0xf7800000 port
0xf7800180 irq 57
[    7.434416] ata6: SATA link down (SStatus 0 SControl 300)
[    7.434431] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    7.434442] ata4: SATA link down (SStatus 0 SControl 300)
[    7.434453] ata3: SATA link down (SStatus 0 SControl 300)
[    7.434466] ata5: SATA link down (SStatus 0 SControl 300)
[    7.434477] ata2: SATA link down (SStatus 0 SControl 300)
[    7.436305] ata1.00: supports DRM functions and may not be fully accessible
[    7.436342] ata1.00: ATA-9: Samsung SSD 840 EVO 120GB, EXT0BB6Q, max UDMA/133
[    7.436343] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    7.436515] ata1.00: supports DRM functions and may not be fully accessible
[    7.436553] ata1.00: configured for UDMA/133
[    7.436609] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD
840  BB6Q PQ: 0 ANSI: 5
[    7.436713] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks:
(120 GB/111 GiB)
[    7.436732] sd 0:0:0:0: [sda] Write Protect is off
[    7.436738] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    7.436803] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.438060]  sda: sda1
[    7.438154] sd 0:0:0:0: [sda] Attached SCSI disk
[    7.438423] ata7: SATA link down (SStatus 0 SControl 300)
[    7.758234] ata8: SATA link down (SStatus 0 SControl 300)
[    8.011629] scsi8 : usb-storage 3-13:1.0
[    8.033291] usbcore: registered new interface driver usb-storage
[    8.055406] [drm] Initialized drm 1.1.0 20060810
[    8.077580] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[    8.099695] e1000e: Copyright(c) 1999 - 2014 Intel Corporation.
[    8.122103] firewire_ohci 0000:04:03.0: added OHCI v1.10 device as
card 0, 4 IR + 8 IT contexts, quirks 0x2
[    8.122124] e1000e 0000:00:19.0: Interrupt Throttling Rate
(ints/sec) set to dynamic conservative mode
[    8.124481] usbcore: registered new interface driver usbhid
[    8.124481] usbhid: USB HID core driver
[    8.214851] input: Logitech USB-PS/2 Optical Mouse as
/devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.0/0003:046D:C03F.0001/input/input4
[    8.238883] hid-generic 0003:046D:C03F.0001: input,hidraw0: USB HID
v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on
usb-0000:00:14.0-1/input0
[    8.300457] e1000e 0000:00:19.0 eth1: registered PHC clock
[    8.324591] e1000e 0000:00:19.0 eth1: (PCI Express:2.5GT/s:Width
x1) 0c:c4:7a:30:b4:a4
[    8.348732] e1000e 0000:00:19.0 eth1: Intel(R) PRO/1000 Network Connection
[    8.372816] e1000e 0000:00:19.0 eth1: MAC: 11, PHY: 12, PBA No: 0100FF-0FF
[    8.396908] [drm] Memory usable by graphics device = 2048M
[    8.420529] [drm] Replacing VGA console driver
[    8.443819] fb: switching to inteldrmfb from VESA VGA
[    8.467416] Console: switching to colour dummy device 80x25
[    8.489831] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    8.489833] [drm] Driver supports precise vblank timestamp query.
[    8.489848] vgaarb: device changed decodes:
PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    8.527351] fbcon: inteldrmfb (fb0) is primary device
[    8.566867] Console: switching to colour frame buffer device 160x64
[    8.568961] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    8.568977] i915 0000:00:02.0: registered panic notifier
[    8.574565] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    8.574865] acpi device:16: registered as cooling_device5
[    8.574931] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input5
[    8.574999] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    8.709709] firewire_core 0000:04:03.0: created device fw0: GUID
003048000010d639, S400
[    8.733639] raid6: sse2x1   10845 MB/s
[    8.801602] raid6: sse2x2   13420 MB/s
[    8.869560] raid6: sse2x4   15734 MB/s
[    8.937521] raid6: avx2x1   20783 MB/s
[    9.005480] raid6: avx2x2   23831 MB/s
[    9.073439] raid6: avx2x4   27758 MB/s
[    9.073448] raid6: using algorithm avx2x4 (27758 MB/s)
[    9.073461] raid6: using avx2x2 recovery algorithm
[    9.073671] scsi 8:0:0:0: Direct-Access     General  USB Flash Disk
  1.0  PQ: 0 ANSI: 2
[    9.073887] sd 8:0:0:0: Attached scsi generic sg1 type 0
[    9.074075] sd 8:0:0:0: [sdb] 7831552 512-byte logical blocks:
(4.00 GB/3.73 GiB)
[    9.074323] sd 8:0:0:0: [sdb] Write Protect is off
[    9.074567] sd 8:0:0:0: [sdb] No Caching mode page found
[    9.074581] sd 8:0:0:0: [sdb] Assuming drive cache: write through
[    9.074797] xor: automatically using best checksumming function:
[    9.076135]  sdb: sdb1
[    9.076954] sd 8:0:0:0: [sdb] Attached SCSI removable disk
[    9.113415]    avx       : 23116.000 MB/sec
[    9.171125] Btrfs loaded
[    9.210329] EXT4-fs (sda1): mounted filesystem with ordered data
mode. Opts: (null)
[    9.413117] random: init urandom read with 105 bits of entropy available
[    9.505325] init: ureadahead main process (283) terminated with status 5
[    9.718932] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    9.763373] random: nonblocking pool is initialized
[    9.785134] [drm] Enabling RC6 states: RC6 on, RC6p off, RC6pp off
[    9.795324] systemd-udevd[411]: starting version 204
[    9.894325] lp: driver loaded but no devices found
[    9.915885] nct6775: Found NCT6776D/F or compatible chip at 0x4e:0xa30
[    9.929780] ppdev: user-space parallel port driver
[   10.437306] AVX2 version of gcm_enc/dec engaged.
[   10.441386] init: cups main process (538) killed by HUP signal
[   10.441390] init: cups main process ended, respawning
[   10.462987] device-mapper: multipath: version 1.7.0 loaded
[   10.495867] Bluetooth: Core ver 2.19
[   10.496499] NET: Registered protocol family 31
[   10.497097] Bluetooth: HCI device and connection manager initialized
[   10.497757] Bluetooth: HCI socket layer initialized
[   10.498363] Bluetooth: L2CAP socket layer initialized
[   10.498951] Bluetooth: SCO socket layer initialized
[   10.532129] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.532729] Bluetooth: BNEP filters: protocol multicast
[   10.532736] Bluetooth: BNEP socket layer initialized
[   10.543808] Bluetooth: RFCOMM TTY layer initialized
[   10.544406] Bluetooth: RFCOMM socket layer initialized
[   10.544996] Bluetooth: RFCOMM ver 1.11
[   10.609521] init: failsafe main process (672) killed by TERM signal
[   10.681031] input: HDA Intel HDMI HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input6
[   10.682217] input: HDA Intel HDMI HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input7
[   10.682855] input: HDA Intel HDMI HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input8
[   10.698711] sound hdaudioC1D0: ALC1150: SKU not ready 0x00000000
[   10.699679] sound hdaudioC1D0: autoconfig: line_outs=3
(0x14/0x15/0x16/0x0/0x0) type:line
[   10.700257] sound hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   10.700838] sound hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   10.701410] sound hdaudioC1D0:    mono: mono_out=0x0
[   10.701979] sound hdaudioC1D0:    dig-out=0x11/0x1e
[   10.702547] sound hdaudioC1D0:    inputs:
[   10.703112] sound hdaudioC1D0:      Front Mic=0x19
[   10.703673] sound hdaudioC1D0:      Rear Mic=0x18
[   10.704228] sound hdaudioC1D0:      Line=0x1a
[   10.716265] input: HDA Intel PCH Front Mic as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input9
[   10.717155] input: HDA Intel PCH Rear Mic as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input10
[   10.717795] input: HDA Intel PCH Line as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input11
[   10.718410] input: HDA Intel PCH Line Out Front as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input12
[   10.719022] input: HDA Intel PCH Line Out Surround as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input13
[   10.719629] input: HDA Intel PCH Line Out CLFE as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input14
[   10.720241] input: HDA Intel PCH Front Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input15
[   11.933988] init: samba-ad-dc main process (855) terminated with status 1
[   11.983872] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   13.144113] init: plymouth-upstart-bridge main process ended, respawning
[   13.146326] init: plymouth-upstart-bridge main process (1503)
terminated with status 1
[   13.146353] init: plymouth-upstart-bridge main process ended, respawning
[   17.784989] init: plymouth-stop pre-start process (1899) terminated
with status 1
[  423.672433] FAT-fs (sdb1): Volume was not properly unmounted. Some
data may be corrupt. Please run fsck.
[419215.683857] Kernel panic - not syncing: Watchdog detected hard
LOCKUP on cpu 3
...
[see log above]


2015-04-02 22:41 GMT+02:00 Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org>:
> On Thu, Apr 02, 2015 at 09:29:29PM +0200, Jeroen Van den Keybus wrote:
>> 2015-04-02 21:15 GMT+02:00 Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org>:
>> > On Thu, Apr 02, 2015 at 08:47:30PM +0200, Jeroen Van den Keybus wrote:
>> >> I've been testing for two weeks now and the system has crashed three
>> >> more times under dohell load. Two with 3.14.28, the other with 3.16.0.
>> >> Time to crash varied between 3 hours and 90 hours.
>> >>
>> >> The scenario is always the same: one CPU (has already been any of the
>> >> 4) gets stuck and the others start reporting soft lockups. The trouble
>> >> is: I've been unable to get hold of a stack trace of the hardlocked
>> >> CPU. SysRq L does not work and the CPU does not respond to the NMIs it
>> >> is given from the softlocked CPUs. I also enabled hardlockup_panic to
>> >> make sure I get all stack traces but to no avail.
>> >>
>> >> Does anyone know another trick to possibly get the backtrace from this CPU ?
>> >
>>
>> > You can modify ipipe_trace_freeze to get the trace of a different
>> > CPU.
>>
>> Ah yes, I forgot. It is probably locked outside the Linux domain. That
>> would explain why the regular panic won't work. Is that correct ?
>
> You will probably know that when you know why you get a lockup.
>
>>
>> > But if I were you I would test the latest stable release
>> > first.
>>
>> Ok. I'll do that. I would have liked to know the cause of the lockups
>> though, And above all, we wanted to test Xenomai 3 from the start of a
>> new project.
>
> I am talking about Linux stable releases. Something more recent than
> 3.14.28 or 3.16.0.
>
> --
>                                             Gilles.

