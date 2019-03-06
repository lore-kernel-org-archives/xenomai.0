Subject: Re: x86_64 kernel does not start under qemu
References: <CAFLxGvyyMEJ3t4K3dShxXMZccXCkuLN=bkTaTKLDugMieFD8ZA@mail.gmail.com>
 <98c4df341a61497c9921dfaeceb1af83@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d2d0dff8-bfb6-6df2-6d0c-2fa0b4127d5f@siemens.com>
Date: Wed, 6 Mar 2019 14:10:50 +0100
MIME-Version: 1.0
In-Reply-To: <98c4df341a61497c9921dfaeceb1af83@andritz.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, Richard Weinberger <richard.weinberger@gmail.com>, "henning.schild@siemens.com" <henning.schild@siemens.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 06.03.19 12:28, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I have a similar issue on real hardware (cc Philippe). Can you try booting with notscdeadline?
> 

I would be surprised if it's that: QEMU does not emulate this APIC feature, only 
KVM does.

I need to reproduce. Which QEMU version?

Jan

> 
> 
>> -----Original Message-----
>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Richard
>> Weinberger via Xenomai
>> Sent: Mittwoch, 6. März 2019 11:17
>> To: xenomai@xenomai.org; henning.schild@siemens.com
>> Subject: x86_64 kernel does not start under qemu
>>
>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>> ATTACHMENTS.
>>
>>
>> Hi!
>>
>> When I try to run ipipe-core-4.14.89-x86-2.patch under qemu, the kernel
>> does not start.
>> I does always start when only one core is used.
>> It starts 9 out of 10 times when I enable KVM.
>>
>> The kernel seems to wait forever for an IPI in ipipe_critical_enter().
>> Please find the gdb backtraces and full dmesg below.
>>
>> qemu command line is:
>> qemu-system-x86_64 -hda disk.ext4 -nographic -kernel bzImage -append
>> "root=/dev/sda panic=1 rw console=ttyS0 init=/bin/bash" -no-reboot -usb -
>> m 2G -s -smp 2
>>
>> (gdb) thread apply all bt
>>
>> Thread 2 (Thread 2):
>> #0  __ipipe_halt_root (use_mwait=0) at arch/x86/kernel/ipipe.c:317
>> #1  0xffffffff819be70d in arch_safe_halt () at
>> ./arch/x86/include/asm/irqflags.h:120
>> #2  default_idle () at arch/x86/kernel/process.c:572
>> #3  0xffffffff81024500 in arch_cpu_idle () at arch/x86/kernel/process.c:563
>> #4  0xffffffff819beb82 in default_idle_call () at kernel/sched/idle.c:103
>> #5  0xffffffff81097e1b in cpuidle_idle_call () at kernel/sched/idle.c:163
>> #6  do_idle () at kernel/sched/idle.c:262
>> #7  0xffffffff81097fd8 in cpu_startup_entry
>> (state=CPUHP_AP_ONLINE_IDLE) at kernel/sched/idle.c:371
>> #8  0xffffffff8103cf10 in start_secondary (unused=<optimized out>) at
>> arch/x86/kernel/smpboot.c:272
>> #9  0xffffffff810000d5 in secondary_startup_64 () at
>> arch/x86/kernel/head_64.S:240
>> #10 0x0000000000000000 in ?? ()
>>
>> Thread 1 (Thread 1):
>> #0  ipipe_critical_enter (syncfn=0x0 <irq_stack_union>) at
>> kernel/ipipe/core.c:1701
>> #1  0xffffffff81102867 in ipipe_set_hooks (ipd=0xffffffff8257af80
>> <ipipe_root>, enables=5) at kernel/ipipe/core.c:959
>> #2  0xffffffff823d1daa in cobalt_init () at
>> kernel/xenomai/posix/process.c:1546
>> #3  0xffffffff823d08ba in xenomai_init () at kernel/xenomai/init.c:385
>> #4  0xffffffff8100049e in do_one_initcall (fn=0xffffffff823d0506
>> <xenomai_init>) at init/main.c:833
>> #5  0xffffffff823abffa in do_initcall_level (level=<optimized out>) at
>> init/main.c:899
>> #6  do_initcalls () at init/main.c:907
>> #7  do_basic_setup () at init/main.c:926
>> #8  kernel_init_freeable () at init/main.c:1081
>> #9  0xffffffff819b8939 in kernel_init (unused=<optimized out>) at
>> init/main.c:1008
>> #10 0xffffffff81a001e6 in ret_from_fork () at arch/x86/entry/entry_64.S:405
>> #11 0x0000000000000000 in ?? ()
>>
>>
>> [    0.000000] Linux version 4.14.89+ (rw@spankyham) (gcc version
>> 7.3.1 20180323 [gcc-7-branch revision 258812] (SUSE Linux)) #83 SMP Tue Mar
>> 5 15:12:14 CET 2019
>> [    0.000000] Command line: root=/dev/sda panic=1 rw console=ttyS0
>> init=/bin/bash
>> [    0.000000] x86/fpu: x87 FPU will use FXSAVE
>> [    0.000000] e820: BIOS-provided physical RAM map:
>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff]
>> usable
>> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff]
>> usable
>> [    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff]
>> reserved
>> [    0.000000] NX (Execute Disable) protection: active
>> [    0.000000] SMBIOS 2.8 present.
>> [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> rel-1.11.0-0-g63451fc-prebuilt.qemu-project.org 04/01/2014
>> [    0.000000] tsc: Fast TSC calibration using PIT
>> [    0.000000] e820: last_pfn = 0x7ffe0 max_arch_pfn = 0x400000000
>> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
>> [    0.000000] found SMP MP-table at [mem 0x000f5d40-0x000f5d4f]
>> mapped at [ffffffffff200d40]
>> [    0.000000] Scanning 1 areas for low memory corruption
>> [    0.000000] ACPI: Early table checksum verification disabled
>> [    0.000000] ACPI: RSDP 0x00000000000F5B00 000014 (v00 BOCHS )
>> [    0.000000] ACPI: RSDT 0x000000007FFE1656 000030 (v01 BOCHS
>> BXPCRSDT 00000001 BXPC 00000001)
>> [    0.000000] ACPI: FACP 0x000000007FFE14AA 000074 (v01 BOCHS
>> BXPCFACP 00000001 BXPC 00000001)
>> [    0.000000] ACPI: DSDT 0x000000007FFE0040 00146A (v01 BOCHS
>> BXPCDSDT 00000001 BXPC 00000001)
>> [    0.000000] ACPI: FACS 0x000000007FFE0000 000040
>> [    0.000000] ACPI: APIC 0x000000007FFE159E 000080 (v01 BOCHS
>> BXPCAPIC 00000001 BXPC 00000001)
>> [    0.000000] ACPI: HPET 0x000000007FFE161E 000038 (v01 BOCHS
>> BXPCHPET 00000001 BXPC 00000001)
>> [    0.000000] No NUMA configuration found
>> [    0.000000] Faking a node at [mem 0x0000000000000000-
>> 0x000000007ffdffff]
>> [    0.000000] NODE_DATA(0) allocated [mem 0x7ffdc000-0x7ffdffff]
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>> [    0.000000]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]
>> [    0.000000]   Normal   empty
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
>> [    0.000000]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]
>> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-
>> 0x000000007ffdffff]
>> [    0.000000] ACPI: PM-Timer IO Port: 0x608
>> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
>> [    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
>> [    0.000000] Using ACPI (MADT) for SMP configuration information
>> [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
>> [    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
>> [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
>> [    0.000000] e820: [mem 0x80000000-0xfffbffff] available for PCI devices
>> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
>> max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
>> [    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64
>> nr_cpu_ids:2 nr_node_ids:1
>> [    0.000000] percpu: Embedded 63 pages/cpu @ffff88807fc00000 s220824
>> r8192 d29032 u1048576
>> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 515945
>> [    0.000000] Policy zone: DMA32
>> [    0.000000] Kernel command line: root=/dev/sda panic=1 rw
>> console=ttyS0 init=/bin/bash
>> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
>> [    0.000000] Memory: 2040080K/2096632K available (12300K kernel
>> code, 1399K rwdata, 3100K rodata, 1376K init, 1720K bss, 56552K reserved, 0K
>> cma-reserved)
>> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
>> [    0.000000] Hierarchical RCU implementation.
>> [    0.000000]  RCU event tracing is enabled.
>> [    0.000000]  RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
>> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
>> [    0.000000] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
>> [    0.000000] Interrupt pipeline (release #2)
>> [    0.000000] Console: colour VGA+ 80x25
>> [    0.000000] console [ttyS0] enabled
>> [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 19112604467 ns
>> [    0.002000] tsc: Fast TSC calibration using PIT
>> [    0.004000] tsc: Detected 3400.235 MHz processor
>> [    0.005560] tsc: Marking TSC unstable due to TSCs unsynchronized
>> [    0.006112] Calibrating delay loop (skipped), value calculated
>> using timer frequency.. 6800.47 BogoMIPS (lpj=3400235)
>> [    0.006545] pid_max: default: 32768 minimum: 301
>> [    0.007114] ACPI: Core revision 20170728
>> [    0.029789] ACPI: 1 ACPI AML tables successfully acquired and loaded
>> [    0.030560] Security Framework initialized
>> [    0.030822] SELinux:  Initializing.
>> [    0.033431] Dentry cache hash table entries: 262144 (order: 9, 2097152
>> bytes)
>> [    0.034439] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
>> [    0.034817] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
>> [    0.035070] Mountpoint-cache hash table entries: 4096 (order: 3, 32768
>> bytes)
>> [    0.047021] mce: CPU supports 10 MCE banks
>> [    0.048070] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
>> [    0.048295] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
>> [    0.048594] Spectre V2 : Spectre mitigation: LFENCE not
>> serializing, switching to generic retpoline
>> [    0.048889] Spectre V2 : Mitigation: Full generic retpoline
>> [    0.049042] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
>> Filling RSB on context switch
>> [    0.049387] Speculative Store Bypass: Vulnerable
>> [    0.053380] Freeing SMP alternatives memory: 40K
>> [    0.063725] smpboot: Max logical packages: 2
>> [    0.068000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>> [    0.078000] smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+
>> (family: 0x6, model: 0x6, stepping: 0x3)
>> [    0.081842] Performance Events: PMU not available due to
>> virtualization, using software events only.
>> [    0.083781] Hierarchical SRCU implementation.
>> [    0.087309] Huh? What family is it: 0x6?!
>> [    0.088475] smp: Bringing up secondary CPUs ...
>> [    0.091222] x86: Booting SMP configuration:
>> [    0.091426] .... node  #0, CPUs:      #1
>> [    0.169296] smp: Brought up 1 node, 2 CPUs
>> [    0.169803] smpboot: Total of 2 processors activated (20816.53 BogoMIPS)
>> [    0.187048] devtmpfs: initialized
>> [    0.192898] random: get_random_u32 called from
>> bucket_table_alloc+0x192/0x240 with crng_init=0
>> [    0.198127] clocksource: jiffies: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 1911260446275000 ns
>> [    0.199072] futex hash table entries: 512 (order: 3, 32768 bytes)
>> [    0.202307] RTC time: 10:05:18, date: 03/06/19
>> [    0.209263] NET: Registered protocol family 16
>> [    0.209174] kworker/u4:0 (20) used greatest stack depth: 14728 bytes left
>> [    0.223854] cpuidle: using governor menu
>> [    0.225253] ACPI: bus type PCI registered
>> [    0.228395] PCI: Using configuration type 1 for base access
>> [    0.233131] mtrr: your CPUs had inconsistent fixed MTRR settings
>> [    0.233342] mtrr: your CPUs had inconsistent variable MTRR settings
>> [    0.233684] mtrr: your CPUs had inconsistent MTRRdefType settings
>> [    0.233888] mtrr: probably your BIOS does not setup all CPUs.
>> [    0.234055] mtrr: corrected configuration.
>> [    0.240514] kworker/u4:1 (47) used greatest stack depth: 14168 bytes left
>> [    0.412485] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
>> [    0.417223] ACPI: Added _OSI(Module Device)
>> [    0.417415] ACPI: Added _OSI(Processor Device)
>> [    0.417762] ACPI: Added _OSI(3.0 _SCP Extensions)
>> [    0.418042] ACPI: Added _OSI(Processor Aggregator Device)
>> [    0.439713] ACPI: Interpreter enabled
>> [    0.440749] ACPI: (supports S0 S3 S4 S5)
>> [    0.440953] ACPI: Using IOAPIC for interrupt routing
>> [    0.442090] PCI: Using host bridge windows from ACPI; if necessary,
>> use "pci=nocrs" and report a bug
>> [    0.444642] ACPI: Enabled 2 GPEs in block 00 to 0F
>> [    0.485438] kworker/u4:1 (481) used greatest stack depth: 14112 bytes left
>> [    0.516653] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>> [    0.517512] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments
>> MSI]
>> [    0.518218] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling
>> ASPM
>> [    0.519101] acpi PNP0A03:00: fail to add MMCONFIG information,
>> can't access extended PCI configuration space under this bridge.
>> [    0.521503] PCI host bridge to bus 0000:00
>> [    0.522159] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>> [    0.522394] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>> [    0.522726] pci_bus 0000:00: root bus resource [mem
>> 0x000a0000-0x000bffff window]
>> [    0.523029] pci_bus 0000:00: root bus resource [mem
>> 0x80000000-0xfebfffff window]
>> [    0.523265] pci_bus 0000:00: root bus resource [mem
>> 0x100000000-0x17fffffff window]
>> [    0.523678] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    0.535700] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
>> [    0.536064] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
>> [    0.536286] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
>> [    0.536570] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
>> [    0.545450] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by
>> PIIX4 ACPI
>> [    0.545927] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
>> [    0.572834] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
>> [    0.574292] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
>> [    0.575434] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
>> [    0.576666] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
>> [    0.577324] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
>> [    0.585383] pci 0000:00:02.0: vgaarb: setting as boot VGA device
>> [    0.586000] pci 0000:00:02.0: vgaarb: VGA device added:
>> decodes=io+mem,owns=io+mem,locks=none
>> [    0.586406] pci 0000:00:02.0: vgaarb: bridge control possible
>> [    0.587048] vgaarb: loaded
>> [    0.589194] SCSI subsystem initialized
>> [    0.592269] ACPI: bus type USB registered
>> [    0.594147] usbcore: registered new interface driver usbfs
>> [    0.595135] usbcore: registered new interface driver hub
>> [    0.596451] usbcore: registered new device driver usb
>> [    0.598295] pps_core: LinuxPPS API ver. 1 registered
>> [    0.598469] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
>> Rodolfo Giometti <giometti@linux.it>
>> [    0.599107] PTP clock support registered
>> [    0.601400] EDAC MC: Ver: 3.0.0
>> [    0.606055] Advanced Linux Sound Architecture Driver Initialized.
>> [    0.607086] PCI: Using ACPI for IRQ routing
>> [    0.619022] NetLabel: Initializing
>> [    0.619043] NetLabel:  domain hash size = 128
>> [    0.619185] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
>> [    0.620321] NetLabel:  unlabeled traffic allowed by default
>> [    0.622555] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
>> [    0.623242] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
>> [    0.623584] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
>> [    0.630550] clocksource: Switched to clocksource hpet
>> [    0.776657] VFS: Disk quotas dquot_6.6.0
>> [    0.777151] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
>> [    0.779679] pnp: PnP ACPI init
>> [    0.791696] pnp: PnP ACPI: found 6 devices
>> [    0.864651] clocksource: acpi_pm: mask: 0xffffff max_cycles:
>> 0xffffff, max_idle_ns: 2085701024 ns
>> [    0.866741] NET: Registered protocol family 2
>> [    0.872227] TCP established hash table entries: 16384 (order: 5,
>> 131072 bytes)
>> [    0.872758] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
>> [    0.873357] TCP: Hash tables configured (established 16384 bind 16384)
>> [    0.874511] UDP hash table entries: 1024 (order: 3, 32768 bytes)
>> [    0.874888] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
>> [    0.876770] NET: Registered protocol family 1
>> [    0.880228] RPC: Registered named UNIX socket transport module.
>> [    0.880436] RPC: Registered udp transport module.
>> [    0.880589] RPC: Registered tcp transport module.
>> [    0.880733] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> [    0.881009] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
>> [    0.881472] pci 0000:00:01.0: PIIX3: Enabling Passive Release
>> [    0.881748] pci 0000:00:01.0: Activating ISA DMA hang workarounds
>> [    1.192379] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
>> [    1.499771] pci 0000:00:02.0: Video device with shadowed ROM at
>> [mem 0x000c0000-0x000dffff]
>> [    1.504449] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
>> 0x31032d032e2, max_idle_ns: 440795335962 ns
>> [    1.511612] Scanning for low memory corruption every 60 seconds
>> [    1.521389] audit: initializing netlink subsys (disabled)
>> [    1.524350] audit: type=2000 audit(1551866718.522:1):
>> state=initialized audit_enabled=0 res=1
>> [    1.527921] [Xenomai] scheduling class idle registered.
>> [    1.528574] [Xenomai] scheduling class rt registered.
>> [    1.530800] I-pipe: head domain Xenomai registered.
>>
>> --
>> Thanks,
>> //richard
> 
> ________________________________
> 
> This message and any attachments are solely for the use of the intended recipients. They may contain privileged and/or confidential information or other information protected from disclosure. If you are not an intended recipient, you are hereby notified that you received this email in error and that any review, dissemination, distribution or copying of this email and any attachment is strictly prohibited. If you have received this email in error, please contact the sender and delete the message and any attachment from your system.
> 
> ANDRITZ HYDRO GmbH
> 
> 
> Rechtsform/ Legal form: Gesellschaft mit beschränkter Haftung / Corporation
> 
> Firmensitz/ Registered seat: Wien
> 
> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
> 
> Firmenbuchnummer/ Company registration: FN 61833 g
> 
> DVR: 0605077
> 
> UID-Nr.: ATU14756806
> 
> 
> Thank You
> ________________________________
> 

