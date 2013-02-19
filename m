Message-ID: <51236088.1030402@gmail.com>
Date: Tue, 19 Feb 2013 12:22:48 +0100
From: Manuel Huber <manuel.h87@gmail.com>
MIME-Version: 1.0
References: <511CD2FB.7010502@gmail.com> <511DDBD5.4060505@web.de>
In-Reply-To: <511DDBD5.4060505@web.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: Re: [Xenomai] (Boot)-problems with (current) ipipe patch on AMD FX
 61000 - 2.6.38.8 & 3.5.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

Thanks for your reply and sorry for the delay ;)
I have tried disabling the options and attached the logs. It still fails :(

I hope it's okay to attach so many files... I can also add the config =

files for
every build if that helps.

I don't want to waste anybodies time; It would be nice to use the 3.5.7
kernel but it's not required. However, if anybody has got some more
suggestions, I will test it and give some feedback!

Best regards, Manuel

On 2013-02-15 07:55, Jan Kiszka wrote:
> On 2013-02-14 13:05, Manuel Huber wrote:
>> Hello!
>>
>> We use an AMD FX-61000 CPU and we are having trouble using kernel versio=
ns
>> 2.6.38.8 and 3.5.7 (newest) and some more... The only version that
>> worked is 2.6.35.9 (so far). But let's focus on 3.5.7:
>>
>> I finally managed to get error messages from the 3.5.7 kernel (Thanks to
>> Philippe Gerum, who was so kind to direct me to the mailing list and also
>> gave me some hints about debugging,... ). I've seen that there is a
>> kernel BUG on line 139 and 170. Maybe thats the reason for the problem?
>> I included the kernel config and the full log from startup. Of course it
>> can
>> very well be a wrong configuration...
>>
>> However, it seems like I could avoid the problemes with the 2.6.35.9
>> kernel (It was related to RTnet + rt8169 sometimes getting stuck;
>> it doesn't happen on the 3.5.7 kernel, as far as I can tell
>> [tested on an AMD Athlon 64 X2]; now I'm using the rt8139C card which
>> works like a charm), so I just wanted to submit the problem,
>> maybe it helps to further improve this project...
>>
>> Of coure I would love to use the current version and I can test
>> configurations and boot the system with different options if that
>> helps with finding the error...
>>
>> Best regards, Manuel
>> -------------- next part --------------
>> [    0.000000] Initializing cgroup subsys cpuset
>> [    0.000000] Initializing cgroup subsys cpu
>> [    0.000000] Linux version 3.5.7-xeno262-netcon (root@kuka) (gcc
>> version 4.4.3 (Ubuntu 4.4.3-4ubuntu5.1) ) #4 SMP PREEMPT Mon Feb 11
>> 17:54:35 CET 2013
>> [    0.000000] e820: BIOS-provided physical RAM map:
>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff]
>> usable
>> [    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cfd9ffff]
>> usable
>> [    0.000000] BIOS-e820: [mem 0x00000000cfda0000-0x00000000cfdd0fff]
>> ACPI NVS
>> [    0.000000] BIOS-e820: [mem 0x00000000cfdd1000-0x00000000cfdfffff]
>> ACPI data
>> [    0.000000] BIOS-e820: [mem 0x00000000cfe00000-0x00000000cfefffff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000042fffffff]
>> usable
>> [    0.000000] NX (Execute Disable) protection: active
>> [    0.000000] DMI 2.4 present.
>> [    0.000000] e820: last_pfn =3D 0x430000 max_arch_pfn =3D 0x1000000
>> [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new
>> 0x7010600070106
>> [    0.000000] found SMP MP-table at [mem 0x000f4bf0-0x000f4bff] mapped
>> at [c00f4bf0]
>> [    0.000000] init_memory_mapping: [mem 0x00000000-0x37bfdfff]
>> [    0.000000] RAMDISK: [mem 0x377cf000-0x37feffff]
>> [    0.000000] Allocated new RAMDISK: [mem 0x36fae000-0x377ce991]
>> [    0.000000] Move RAMDISK from [mem 0x377cf000-0x37fef991] to [mem
>> 0x36fae000-0x377ce991]
>> [    0.000000] No NUMA configuration found
>> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000042fffff=
ff]
>> [    0.000000] Initmem setup node 0 [mem 0x00000000-0x42fffffff]
>> [    0.000000]   NODE_DATA [mem 0x2e600000-0x2e601fff] (remapped)
>> [    0.000000] 16260MB HIGHMEM available.
>> [    0.000000] 891MB LOWMEM available.
>> [    0.000000]   mapped low ram: 0 - 37bfe000
>> [    0.000000]   low ram: 0 - 37bfe000
>> [    0.000000] Node: 0, start_pfn: 10, end_pfn: 9f
>> [    0.000000] Node: 0, start_pfn: 100, end_pfn: cfda0
>> [    0.000000] Node: 0, start_pfn: 100000, end_pfn: 430000
>> 334000 338000 33c000 340000 344000 348000 34c000 350000 354000 358000
>> 35c000 360000 364000 368000 36c000 370000 374000 378000 37c000 380000
>> 384000 388000 38c000 390000 394000 398000 39c000 3a0000 3a4000 3a8000
>> 3ac000 3b0000 3b4000 3b8000 3bc000 3c0000 3c4000 3c8000 3cc000 3d0000
>> 3d4000 3d8000 3dc000 3e0000 3e4000 3e8000 3ec000 3f0000 3f4000 3f8000
>> 3fc000 400000 404000 408000 40c000 410000 414000 418000 41c000 420000
>> 424000 428000 42c000 [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x00010000-0x00ffffff]
>> [    0.000000]   Normal   [mem 0x01000000-0x37bfdfff]
>> [    0.000000]   HighMem  [mem 0x37bfe000-0x2fffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x00010000-0x0009efff]
>> [    0.000000]   node   0: [mem 0x00100000-0xcfd9ffff]
>> [    0.000000]   node   0: [mem 0x00000000-0x2fffffff]
>> [    0.000000] Using APIC driver default
>> [    0.000000] SFI: Simple Firmware Interface v0.81
>> http://simplefirmware.org
>> [    0.000000] Intel MultiProcessor Specification v1.4
>> [    0.000000]     Virtual Wire compatibility mode.
>> [    0.000000] MPTABLE: OEM ID: OEM00000
>> [    0.000000] MPTABLE: Product ID: PROD00000000
>> [    0.000000] MPTABLE: APIC at: 0xFEE00000
>> [    0.000000] Processor #0 (Bootup-CPU)
>> [    0.000000] Processor #1
>> [    0.000000] Processor #2
>> [    0.000000] Processor #3
>> [    0.000000] Processor #4
>> [    0.000000] Processor #5
>> [    0.000000] IOAPIC[0]: apic_id 8, version 33, address 0xfec00000, GSI
>> 0-23
>> [    0.000000] Processors: 6
>> [    0.000000] SMP: Allowing 6 CPUs, 0 hotplug CPUs
>> [    0.000000] PM: Registered nosave memory: 000000000009f000 -
>> 00000000000a0000
>> [    0.000000] PM: Registered nosave memory: 00000000000a0000 -
>> 00000000000f0000
>> [    0.000000] PM: Registered nosave memory: 00000000000f0000 -
>> 0000000000100000
>> [    0.000000] e820: [mem 0xcff00000-0xdfffffff] available for PCI devic=
es
>> [    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:6
>> nr_node_ids:1
>> [    0.000000] PERCPU: Embedded 403 pages/cpu @edc8e000 s1627200 r0
>> d23488 u1650688
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
>> Total pages: 4159278
>> [    0.000000] Policy zone: HighMem
>> [    0.000000] Kernel command line:
>> BOOT_IMAGE=3D/boot/vmlinuz-3.5.7-xeno262-netcon
>> root=3DUUID=3De722c833-7422-4a40-9602-8d589eacd32c ro console=3Dtty0
>> console=3DttyS0,19200n8
>> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
>> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
>> bytes)
>> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
>> bytes)
>> [    0.000000] __ex_table already sorted, skipping sort
>> [    0.000000] Xenomai: forcing noxsave
>> [    0.000000] Initializing CPU#0
>> [    0.000000] allocated 35127168 bytes of page_cgroup
>> [    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't
>> want memory cgroups
>> [    0.000000] Initializing HighMem for node 0 (00037bfe:00430000)
>> [    0.000000] Memory: 16426864k/17563648k available (5833k kernel code,
>> 208204k reserved, 2413k data, 2084k init, 15722120k highmem)
>> [    0.000000] virtual kernel memory layout:
>> [    0.000000]     fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
>> [    0.000000]     pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
>> [    0.000000]     vmalloc : 0xf83fe000 - 0xffbfe000   ( 120 MB)
>> [    0.000000]     lowmem  : 0xc0000000 - 0xf7bfe000   ( 891 MB)
>> [    0.000000]       .init : 0xc090e000 - 0xc0b17000   (2084 kB)
>> [    0.000000]       .data : 0xc06b2643 - 0xc090ddc0   (2413 kB)
>> [    0.000000]       .text : 0xc0100000 - 0xc06b2643   (5833 kB)
>> [    0.000000] Checking if this processor honours the WP bit even in
>> supervisor mode...Ok.
>> [    0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Order=3D0-3, MinObject=
s=3D0,
>> CPUs=3D6, Nodes=3D1
>> [    0.000000] Preemptible hierarchical RCU implementation.
>> [    0.000000]     Additional per-CPU info printed with stalls.
>> [    0.000000] NR_IRQS:2304 nr_irqs:728 16
>> [    0.000000] Interrupt pipeline (release #3)
>> [    0.000000] Console: colour VGA+ 80x25
>> [    0.000000] console [tty0] enabled
>> [    0.000000] console [ttyS0] enabled
>> [    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,
>> Inc., Ingo Molnar
>> [    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
>> [    0.000000] ... MAX_LOCK_DEPTH:          48
>> [    0.000000] ... MAX_LOCKDEP_KEYS:        8191
>> [    0.000000] ... CLASSHASH_SIZE:          4096
>> [    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
>> [    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
>> [    0.000000] ... CHAINHASH_SIZE:          16384
>> [    0.000000]  memory used by lock dependency info: 3551 kB
>> [    0.000000]  per task-struct memory footprint: 1152 bytes
>> [    0.004000] Fast TSC calibration using PIT
>> [    0.008000] Detected 3322.112 MHz processor.
>> [    0.000003] Calibrating delay loop (skipped), value calculated using
>> timer frequency.. 6644.22 BogoMIPS (lpj=3D13288448)
>> [    0.064225] pid_max: default: 32768 minimum: 301
>> [    0.091963] Security Framework initialized
>> [    0.116501] SELinux:  Disabled at boot.
>> [    0.139542] Mount-cache hash table entries: 512
>> [    0.167393] Initializing cgroup subsys cpuacct
>> [    0.194030] Initializing cgroup subsys memory
>> [    0.220198] Initializing cgroup subsys devices
>> [    0.246825] Initializing cgroup subsys freezer
>> [    0.273482] Initializing cgroup subsys net_cls
>> [    0.300190] CPU: Physical Processor ID: 0
>> [    0.324248] CPU: Processor Core ID: 0
>> [    0.346229] mce: CPU supports 7 MCE banks
>> [    0.370292] LVT offset 1 assigned for vector 0xf9
>> [    0.399318] Enabling APIC mode:  Flat.  Using 1 I/O APICs
>> [    0.431704] ExtINT not setup in hardware but reported by MP table
>> [    0.468506] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D0 pin2=
=3D0
>> [    0.543132] CPU0: AMD FX(tm)-6100 Six-Core Processor
>> stepping 02
>> [    0.800897] Performance Events: AMD Family 15h PMU driver.
>> [    0.833852] ... version:                0
>> [    0.857908] ... bit width:              48
>> [    0.882484] ... generic registers:      6
>> [    0.906544] ... value mask:             0000ffffffffffff
>> [    0.938398] ... max period:             00007fffffffffff
>> [    0.970251] ... fixed-purpose events:   0
>> [    0.994308] ... event mask:             000000000000003f
>> [    1.037024] NMI watchdog: enabled on all CPUs, permanently consumes
>> one hw-PMU counter.
>> [    1.092771] lockdep: fixing up alternatives.
>> [    1.118352] Booting Node   0, Processors  #1[    1.153774]
>> Initializing CPU#1
>> [    1.174085] ------------[ cut here ]------------
>> [    1.201759] kernel BUG at arch/x86/kernel/ipipe.c:589!
>>
>> [    1.232558] invalid opcode: 0000 [#1] [    1.255145] PREEMPT SMP [
>> 1.270535] Modules linked in:
>>
>> [    1.290073] Pid: 0, comm: swapper/1 Not tainted 3.5.7-xeno262-netcon
>> #4 Gigabyte Technology Co., Ltd. GA-990FXA-UD5/GA-990FXA-UD5
>> [    1.360172] EIP: 0060:[<c011f727>] EFLAGS: 00010286 CPU: 1
>> [    1.393024] EIP is at __ipipe_handle_irq+0x1c7/0x230
>> [    1.422795] EAX: 2d498000 EBX: eb465f58 ECX: ffffffff EDX: 00000000
>> [    1.460364] ESI: c098c400 EDI: 00000001 EBP: eb465f50 ESP: eb465f38
>> [    1.497935]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
>> [    1.530307] CR0: 8005003b CR2: 00000000 CR3: 00b20000 CR4: 000007f0
>> [    1.567875] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
>> [    1.605446] DR6: ffff0ff0 DR7: 00000400
>> [    1.628462] Process swapper/1 (pid: 0, ti=3Deb464000 task=3Deb468000
>> task.ti=3Deb464000)
>> [    1.673844] I-pipe domain Linux
>> [    1.692684] Stack:
>> [    1.704737]  00000046 00000000 00000001 c098b814 00000001 00000001
>> eb465f84 c06b143d
>> [    1.751918]  c098b814 00000000 00000000 00000001 00000001 eb465f94
>> 80000000 0000007b
>> [    1.799100]  0000007b 000000d8 00000000 ffffffc8 c01c08a5 00000060
>> 00000246 eb465fb4
>> [    1.846281] Call Trace:
>> [    1.860948]  [<c06b143d>] common_interrupt+0x3d/0x5c
>> [    1.890728]  [<c01c08a5>] ipipe_unstall_root+0x55/0x90
>> [    1.921537]  [<c06a960a>] ? start_secondary+0x1cd/0x1e4
>> [    1.952871] Code: fe ff ff 80 3d f8 78 90 c0 01 0f 84 76 fe ff ff ba
>> 47 02 00 00 b8 fc f6 7f c0 e8 15 61 01 00 c6 05 f8 78 90 c0 01 e9 5b fe
>> ff ff <0f> 0b eb fe c7 45 f0 01 00 00 00 e9 75 fe ff ff 80 3d fa 78 90
>> [    2.072527] EIP: [<c011f727>] __ipipe_handle_irq+0x1c7/0x230 SS:ESP
>> 0068:eb465f38
>> [    2.117580] ---[ end trace 657a5a3916f87b8b ]---
>> [    2.124001] lockdep: fixing up alternatives.
>> [    2.124014] CPU 2 irqstacks, hard=3Deb49a000 soft=3Deb49c000
>> [    2.134745] Initializing CPU#2
>> [    2.137061] ------------[ cut here ]------------
>> [    2.137063] kernel BUG at arch/x86/kernel/ipipe.c:589!
>> [    2.137065] invalid opcode: 0000 [#2] PREEMPT SMP [    2.137069]
>> Modules linked in:
>> [    2.137072] [    2.137074] Pid: 0, comm: swapper/2 Tainted: G
>> D      3.5.7-xeno262-netcon #4 Gigabyte Technology Co., Ltd.
>> GA-990FXA-UD5/GA-990FXA-UD5
>> [    2.137079] EIP: 0060:[<c011f727>] EFLAGS: 00010286 CPU: 2
>> [    2.137085] EIP is at __ipipe_handle_irq+0x1c7/0x230
>> [    2.137087] EAX: 2d62b000 EBX: eb467f58 ECX: ffffffff EDX: 00000000
>> [    2.137088] ESI: c098c400 EDI: 00000001 EBP: eb467f50 ESP: eb467f38
>> [    2.137090]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
>> [    2.137091] CR0: 8005003b CR2: 00000000 CR3: 00b20000 CR4: 000007f0
>> [    2.137093] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
>> [    2.137094] DR6: ffff0ff0 DR7: 00000400
>> [    2.137095] Process swapper/2 (pid: 0, ti=3Deb466000 task=3Deb469180
>> task.ti=3Deb466000)
>> [    2.137097] I-pipe domain Linux
>> [    2.137097] Stack:
>> [    2.137099]  00000046 00000000 00000001 c098b814 00000002 00000001
>> eb467f84 c06b143d
>> [    2.137106]  c098b814 00000000 00000000 00000002 00000001 eb467f94
>> 80000000 0000007b
>> [    2.137115]  0000007b 000000d8 00000000 ffffffc8 c01c08a5 00000060
>> 00000246 eb467fb4
>> [    2.137122] Call Trace:
>> [    2.137125]  [<c06b143d>] common_interrupt+0x3d/0x5c
>> [    2.137130]  [<c01c08a5>] ipipe_unstall_root+0x55/0x90
>> [    2.137134]  [<c06a960a>] ? start_secondary+0x1cd/0x1e4
>> [    2.137139] Code: fe ff ff 80 3d f8 78 90 c0 01 0f 84 76 fe ff ff ba
>> 47 02 00 00 b8 fc f6 7f c0 e8 15 61 01 00 c6 05 f8 78 90 c0 01 e9 5b fe
>> ff ff <0f> 0b eb fe c7 45 f0 01 00 00 00 e9 75 fe ff ff 80 3d fa 78 90
>> [    2.137196] EIP: [<c011f727>] __ipipe_handle_irq+0x1c7/0x230 SS:ESP
>> 0068:eb467f38
>> [    2.137210] ---[ end trace 657a5a3916f87b8c ]---
>> [    2.137213] Kernel panic - not syncing: Attempted to kill the idle ta=
sk!
>> [    2.124017]  #2
>> -------------- next part --------------
>> #
>> # Automatically generated file; DO NOT EDIT.
>> # Linux/i386 3.5.7-xeno262-netcon Kernel Configuration
>> #
>> # CONFIG_64BIT is not set
>> CONFIG_X86_32=3Dy
> You likely do not want to torture your 16-GB box with an i386 kernel -
> 64-bit highly recommended. Nevertheless, it must not crash.
>
> ...
>> #
>> # Kernel hacking
>> #
>> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
>> CONFIG_PRINTK_TIME=3Dy
>> CONFIG_DEFAULT_MESSAGE_LOGLEVEL=3D4
>> # CONFIG_ENABLE_WARN_DEPRECATED is not set
>> # CONFIG_ENABLE_MUST_CHECK is not set
>> CONFIG_FRAME_WARN=3D1024
>> CONFIG_MAGIC_SYSRQ=3Dy
>> # CONFIG_STRIP_ASM_SYMS is not set
>> # CONFIG_READABLE_ASM is not set
>> CONFIG_UNUSED_SYMBOLS=3Dy
>> CONFIG_DEBUG_FS=3Dy
>> # CONFIG_HEADERS_CHECK is not set
>> # CONFIG_DEBUG_SECTION_MISMATCH is not set
>> CONFIG_IPIPE_DEBUG=3Dy
>> CONFIG_IPIPE_DEBUG_CONTEXT=3Dy
>> CONFIG_IPIPE_DEBUG_INTERNAL=3Dy
>> CONFIG_IPIPE_TRACE=3Dy
>> CONFIG_IPIPE_TRACE_ENABLE=3Dy
>> CONFIG_IPIPE_TRACE_MCOUNT=3Dy
>> CONFIG_IPIPE_TRACE_IRQSOFF=3Dy
>> CONFIG_IPIPE_TRACE_SHIFT=3D14
>> # CONFIG_IPIPE_TRACE_VMALLOC is not set
>> CONFIG_IPIPE_TRACE_PANIC=3Dy
>> CONFIG_DEBUG_KERNEL=3Dy
>> CONFIG_DEBUG_SHIRQ=3Dy
>> CONFIG_LOCKUP_DETECTOR=3Dy
>> CONFIG_HARDLOCKUP_DETECTOR=3Dy
>> # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
>> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D0
>> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
>> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
>> # CONFIG_PANIC_ON_OOPS is not set
>> CONFIG_PANIC_ON_OOPS_VALUE=3D0
>> CONFIG_DETECT_HUNG_TASK=3Dy
>> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
>> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
>> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
>> CONFIG_SCHED_DEBUG=3Dy
>> CONFIG_SCHEDSTATS=3Dy
>> CONFIG_TIMER_STATS=3Dy
>> # CONFIG_DEBUG_OBJECTS is not set
>> # CONFIG_SLUB_DEBUG_ON is not set
>> # CONFIG_SLUB_STATS is not set
>> # CONFIG_DEBUG_KMEMLEAK is not set
>> CONFIG_DEBUG_PREEMPT=3Dy
>> CONFIG_DEBUG_RT_MUTEXES=3Dy
>> CONFIG_DEBUG_PI_LIST=3Dy
>> # CONFIG_RT_MUTEX_TESTER is not set
>> CONFIG_DEBUG_SPINLOCK=3Dy
>> CONFIG_DEBUG_MUTEXES=3Dy
>> CONFIG_DEBUG_LOCK_ALLOC=3Dy
>> # CONFIG_PROVE_LOCKING is not set
>> # CONFIG_SPARSE_RCU_POINTER is not set
>> CONFIG_LOCKDEP=3Dy
>> # CONFIG_LOCK_STAT is not set
>> # CONFIG_DEBUG_LOCKDEP is not set
>> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
>> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
>> CONFIG_STACKTRACE=3Dy
>> # CONFIG_DEBUG_STACK_USAGE is not set
>> # CONFIG_DEBUG_KOBJECT is not set
>> # CONFIG_DEBUG_HIGHMEM is not set
>> CONFIG_DEBUG_BUGVERBOSE=3Dy
>> CONFIG_DEBUG_INFO=3Dy
>> # CONFIG_DEBUG_INFO_REDUCED is not set
>> # CONFIG_DEBUG_VM is not set
>> # CONFIG_DEBUG_VIRTUAL is not set
>> # CONFIG_DEBUG_WRITECOUNT is not set
>> CONFIG_DEBUG_MEMORY_INIT=3Dy
>> # CONFIG_DEBUG_LIST is not set
>> # CONFIG_TEST_LIST_SORT is not set
>> # CONFIG_DEBUG_SG is not set
>> # CONFIG_DEBUG_NOTIFIERS is not set
>> # CONFIG_DEBUG_CREDENTIALS is not set
>> CONFIG_ARCH_WANT_FRAME_POINTERS=3Dy
>> CONFIG_FRAME_POINTER=3Dy
>> CONFIG_BOOT_PRINTK_DELAY=3Dy
>> # CONFIG_RCU_TORTURE_TEST is not set
>> CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
>> CONFIG_RCU_CPU_STALL_VERBOSE=3Dy
>> CONFIG_RCU_CPU_STALL_INFO=3Dy
>> # CONFIG_RCU_TRACE is not set
>> # CONFIG_BACKTRACE_SELF_TEST is not set
>> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
>> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
>> # CONFIG_DEBUG_PER_CPU_MAPS is not set
>> # CONFIG_LKDTM is not set
>> # CONFIG_CPU_NOTIFIER_ERROR_INJECT is not set
>> # CONFIG_FAULT_INJECTION is not set
>> CONFIG_LATENCYTOP=3Dy
>> # CONFIG_DEBUG_PAGEALLOC is not set
>> CONFIG_USER_STACKTRACE_SUPPORT=3Dy
>> CONFIG_NOP_TRACER=3Dy
>> CONFIG_HAVE_FUNCTION_TRACER=3Dy
>> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
>> CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=3Dy
>> CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=3Dy
>> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
>> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
>> CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
>> CONFIG_HAVE_C_RECORDMCOUNT=3Dy
>> CONFIG_RING_BUFFER=3Dy
>> CONFIG_EVENT_TRACING=3Dy
>> CONFIG_EVENT_POWER_TRACING_DEPRECATED=3Dy
>> CONFIG_CONTEXT_SWITCH_TRACER=3Dy
>> CONFIG_TRACING=3Dy
>> CONFIG_GENERIC_TRACER=3Dy
>> CONFIG_TRACING_SUPPORT=3Dy
>> CONFIG_FTRACE=3Dy
>> CONFIG_FUNCTION_TRACER=3Dy
>> CONFIG_FUNCTION_GRAPH_TRACER=3Dy
>> # CONFIG_IRQSOFF_TRACER is not set
>> # CONFIG_PREEMPT_TRACER is not set
>> # CONFIG_SCHED_TRACER is not set
>> # CONFIG_FTRACE_SYSCALLS is not set
>> CONFIG_BRANCH_PROFILE_NONE=3Dy
>> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
>> # CONFIG_PROFILE_ALL_BRANCHES is not set
>> # CONFIG_STACK_TRACER is not set
>> CONFIG_BLK_DEV_IO_TRACE=3Dy
>> # CONFIG_UPROBE_EVENT is not set
>> # CONFIG_PROBE_EVENTS is not set
>> CONFIG_FUNCTION_PROFILER=3Dy
>> # CONFIG_FTRACE_STARTUP_TEST is not set
>> CONFIG_MMIOTRACE=3Dy
>> # CONFIG_MMIOTRACE_TEST is not set
>> # CONFIG_RING_BUFFER_BENCHMARK is not set
>> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
>> # CONFIG_FIREWIRE_OHCI_REMOTE_DMA is not set
>> # CONFIG_DYNAMIC_DEBUG is not set
>> # CONFIG_DMA_API_DEBUG is not set
>> # CONFIG_ATOMIC64_SELFTEST is not set
>> CONFIG_ASYNC_RAID6_TEST=3Dm
>> # CONFIG_SAMPLES is not set
>> CONFIG_HAVE_ARCH_KGDB=3Dy
>> CONFIG_KGDB=3Dy
> Please disable KGDB. Official releases do not support it, rather contain
> buggy code that can break your box. Hope this is the reason already.
>
> If not, next things to switch off (please keep ordering to allow the
> identification of the reason) are CONFIG_IPIPE_TRACE and CONFIG_FTRACE.
>
> Jan
>
>

-------------- next part --------------
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.5.7-xeno2621-patch2 (root@kuka) (gcc version=
 4.4.3 (Ubuntu 4.4.3-4ubuntu5.1) ) #1 SMP PREEMPT Mon Feb 18 14:43:46 CET 2=
013
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cfd9ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cfda0000-0x00000000cfdd0fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000cfdd1000-0x00000000cfdfffff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000cfe00000-0x00000000cfefffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000042fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.4 present.
[    0.000000] e820: last_pfn =3D 0x430000 max_arch_pfn =3D 0x1000000
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] found SMP MP-table at [mem 0x000f4bf0-0x000f4bff] mapped at =
[c00f4bf0]
[    0.000000] init_memory_mapping: [mem 0x00000000-0x37bfdfff]
[    0.000000] RAMDISK: [mem 0x377cf000-0x37feffff]
[    0.000000] Allocated new RAMDISK: [mem 0x36fae000-0x377ceb4e]
[    0.000000] Move RAMDISK from [mem 0x377cf000-0x37fefb4e] to [mem 0x36fa=
e000-0x377ceb4e]
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000042fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x42fffffff]
[    0.000000]   NODE_DATA [mem 0x2e600000-0x2e601fff] (remapped)
[    0.000000] 16260MB HIGHMEM available.
[    0.000000] 891MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 37bfe000
[    0.000000]   low ram: 0 - 37bfe000
[    0.000000] Node: 0, start_pfn: 10, end_pfn: 9f
[    0.000000] Node: 0, start_pfn: 100, end_pfn: cfda0
[    0.000000] Node: 0, start_pfn: 100000, end_pfn: 430000
334000 338000 33c000 340000 344000 348000 34c000 350000 354000 358000 35c00=
0 360000 364000 368000 36c000 370000 374000 378000 37c000 380000 384000 388=
000 38c000 390000 394000 398000 39c000 3a0000 3a4000 3a8000 3ac000 3b0000 3=
b4000 3b8000 3bc000 3c0000 3c4000 3c8000 3cc000 3d0000 3d4000 3d8000 3dc000=
 3e0000 3e4000 3e8000 3ec000 3f0000 3f4000 3f8000 3fc000 400000 404000 4080=
00 40c000 410000 414000 418000 41c000 420000 424000 428000 42c000 =

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00010000-0x00ffffff]
[    0.000000]   Normal   [mem 0x01000000-0x37bfdfff]
[    0.000000]   HighMem  [mem 0x37bfe000-0x2fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00010000-0x0009efff]
[    0.000000]   node   0: [mem 0x00100000-0xcfd9ffff]
[    0.000000]   node   0: [mem 0x00000000-0x2fffffff]
[    0.000000] Using APIC driver default
[    0.000000] SFI: Simple Firmware Interface v0.81 http://simplefirmware.o=
rg
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] MPTABLE: OEM ID: OEM00000
[    0.000000] MPTABLE: Product ID: PROD00000000
[    0.000000] MPTABLE: APIC at: 0xFEE00000
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] Processor #1
[    0.000000] Processor #2
[    0.000000] Processor #3
[    0.000000] Processor #4
[    0.000000] Processor #5
[    0.000000] IOAPIC[0]: apic_id 8, version 33, address 0xfec00000, GSI 0-=
23
[    0.000000] Processors: 6
[    0.000000] SMP: Allowing 6 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 - 00000000001=
00000
[    0.000000] e820: [mem 0xcff00000-0xdfffffff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:6 nr_no=
de_ids:1
[    0.000000] PERCPU: Embedded 403 pages/cpu @edc8e000 s1627200 r0 d23488 =
u1650688
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 4159278
[    0.000000] Policy zone: HighMem
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.5.7-xeno26=
21-patch2 root=3DUUID=3De722c833-7422-4a40-9602-8d589eacd32c ro console=3Dt=
ty0 console=3DttyS0,19200n8
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Xenomai: forcing noxsave
[    0.000000] Initializing CPU#0
[    0.000000] allocated 35127168 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t memory cgroups
[    0.000000] Initializing HighMem for node 0 (00037bfe:00430000)
[    0.000000] Memory: 16426904k/17563648k available (5818k kernel code, 20=
8164k reserved, 2411k data, 2080k init, 15722120k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
[    0.000000]     pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xf83fe000 - 0xffbfe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf7bfe000   ( 891 MB)
[    0.000000]       .init : 0xc090a000 - 0xc0b12000   (2080 kB)
[    0.000000]       .data : 0xc06aeb83 - 0xc0909b00   (2411 kB)
[    0.000000]       .text : 0xc0100000 - 0xc06aeb83   (5818 kB)
[    0.000000] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D6, Nodes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Additional per-CPU info printed with stalls.
[    0.000000] NR_IRQS:2304 nr_irqs:728 16
[    0.000000] Interrupt pipeline (release #3)
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3551 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.004000] Fast TSC calibration using PIT
[    0.008000] Detected 3322.210 MHz processor.
[    0.000003] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6644.42 BogoMIPS (lpj=3D13288840)
[    0.064224] pid_max: default: 32768 minimum: 301
[    0.091962] Security Framework initialized
[    0.116502] SELinux:  Disabled at boot.
[    0.139542] Mount-cache hash table entries: 512
[    0.167396] Initializing cgroup subsys cpuacct
[    0.194031] Initializing cgroup subsys memory
[    0.220198] Initializing cgroup subsys devices
[    0.246825] Initializing cgroup subsys freezer
[    0.273482] Initializing cgroup subsys net_cls
[    0.300191] CPU: Physical Processor ID: 0
[    0.324248] CPU: Processor Core ID: 0
[    0.346228] mce: CPU supports 7 MCE banks
[    0.370292] LVT offset 1 assigned for vector 0xf9
[    0.399313] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.431703] ExtINT not setup in hardware but reported by MP table
[    0.468507] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D0 pin2=3D0
[    0.543133] CPU0: AMD FX(tm)-6100 Six-Core Processor              steppi=
ng 02
[    0.800899] Performance Events: AMD Family 15h PMU driver.
[    0.833854] ... version:                0
[    0.857908] ... bit width:              48
[    0.882484] ... generic registers:      6
[    0.906542] ... value mask:             0000ffffffffffff
[    0.938399] ... max period:             00007fffffffffff
[    0.970253] ... fixed-purpose events:   0
[    0.994309] ... event mask:             000000000000003f
[    1.037026] NMI watchdog: enabled on all CPUs, permanently consumes one =
hw-PMU counter.
[    1.092774] lockdep: fixing up alternatives.
[    1.118404] Booting Node   0, Processors  #1[    1.153825] Initializing =
CPU#1
[    1.174181] ------------[ cut here ]------------
[    1.201864] kernel BUG at arch/x86/kernel/ipipe.c:589!

[    1.232662] invalid opcode: 0000 [#1] [    1.255248] PREEMPT SMP =

[    1.270640] Modules linked in:

[    1.290177] Pid: 0, comm: swapper/1 Not tainted 3.5.7-xeno2621-patch2 #1=
 Gigabyte Technology Co., Ltd. GA-990FXA-UD5/GA-990FXA-UD5
[    1.360742] EIP: 0060:[<c011f6a7>] EFLAGS: 00010286 CPU: 1
[    1.393595] EIP is at __ipipe_handle_irq+0x1c7/0x230
[    1.423365] EAX: 2d49d000 EBX: eb465f58 ECX: ffffffff EDX: 00000000
[    1.460937] ESI: c0987400 EDI: 00000001 EBP: eb465f50 ESP: eb465f38
[    1.498505]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[    1.530878] CR0: 8005003b CR2: 00000000 CR3: 00b1b000 CR4: 000007f0
[    1.568447] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    1.606017] DR6: ffff0ff0 DR7: 00000400
[    1.629034] Process swapper/1 (pid: 0, ti=3Deb464000 task=3Deb468000 tas=
k.ti=3Deb464000)
[    1.674417] I-pipe domain Linux
[    1.693255] Stack:
[    1.705311]  00000046 00000000 00000001 c0986814 00000001 00000001 eb465=
f84 c06ad97d
[    1.752488]  c0986814 00000000 00000000 00000001 00000001 eb465f94 80000=
000 0000007b
[    1.799670]  0000007b 000000d8 00000000 ffffffc8 c01bd5f5 00000060 00000=
246 eb465fb4
[    1.846852] Call Trace:
[    1.861520]  [<c06ad97d>] common_interrupt+0x3d/0x5c
[    1.891297]  [<c01bd5f5>] ipipe_unstall_root+0x55/0x90
[    1.922112]  [<c06a5b66>] ? start_secondary+0x1cd/0x1e4
[    1.953443] Code: fe ff ff 80 3d 38 36 90 c0 01 0f 84 76 fe ff ff ba 47 =
02 00 00 b8 54 b8 7f c0 e8 b5 51 01 00 c6 05 38 36 90 c0 01 e9 5b fe ff ff =
<0f> 0b eb fe c7 45 f0 01 00 00 00 e9 75 fe ff ff 80 3d 3a 36 90 =

[    2.073099] EIP: [<c011f6a7>] __ipipe_handle_irq+0x1c7/0x230 SS:ESP 0068=
:eb465f38
[    2.118152] ---[ end trace 99fae4ae10a632f7 ]---
[    2.124002] lockdep: fixing up alternatives.
[    2.124015] CPU 2 irqstacks, hard=3Deb49a000 soft=3Deb49c000
[    2.134748] Initializing CPU#2
[    2.137060] ------------[ cut here ]------------
[    2.137062] kernel BUG at arch/x86/kernel/ipipe.c:589!
[    2.137064] invalid opcode: 0000 [#2] PREEMPT SMP =

[    2.137068] Modules linked in:
[    2.137071] =

[    2.137073] Pid: 0, comm: swapper/2 Tainted: G      D      3.5.7-xeno262=
1-patch2 #1 Gigabyte Technology Co., Ltd. GA-990FXA-UD5/GA-990FXA-UD5
[    2.137079] EIP: 0060:[<c011f6a7>] EFLAGS: 00010286 CPU: 2
[    2.137084] EIP is at __ipipe_handle_irq+0x1c7/0x230
[    2.137086] EAX: 2d630000 EBX: eb467f58 ECX: ffffffff EDX: 00000000
[    2.137087] ESI: c0987400 EDI: 00000001 EBP: eb467f50 ESP: eb467f38
[    2.137088]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[    2.137090] CR0: 8005003b CR2: 00000000 CR3: 00b1b000 CR4: 000007f0
[    2.137091] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    2.137092] DR6: ffff0ff0 DR7: 00000400
[    2.137094] Process swapper/2 (pid: 0, ti=3Deb466000 task=3Deb469180 tas=
k.ti=3Deb466000)
[    2.137095] I-pipe domain Linux
[    2.137096] Stack:
[    2.137097]  00000046 00000000 00000001 c0986814 00000002 00000001 eb467=
f84 c06ad97d
[    2.137105]  c0986814 00000000 00000000 00000002 00000001 eb467f94 80000=
000 0000007b
[    2.137113]  0000007b 000000d8 00000000 ffffffc8 c01bd5f5 00000060 00000=
246 eb467fb4
[    2.137121] Call Trace:
[    2.137123]  [<c06ad97d>] common_interrupt+0x3d/0x5c
[    2.137129]  [<c01bd5f5>] ipipe_unstall_root+0x55/0x90
[    2.137133]  [<c06a5b66>] ? start_secondary+0x1cd/0x1e4
[    2.137138] Code: fe ff ff 80 3d 38 36 90 c0 01 0f 84 76 fe ff ff ba 47 =
02 00 00 b8 54 b8 7f c0 e8 b5 51 01 00 c6 05 38 36 90 c0 01 e9 5b fe ff ff =
<0f> 0b eb fe c7 45 f0 01 00 00 00 e9 75 fe ff ff 80 3d 3a 36 90 =

[    2.137195] EIP: [<c011f6a7>] __ipipe_handle_irq+0x1c7/0x230 SS:ESP 0068=
:eb467f38
[    2.137209] ---[ end trace 99fae4ae10a632f8 ]---
[    2.137212] Kernel panic - not syncing: Attempted to kill the idle task!
[    2.124018]  #2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: boot-error_AMD-FX-6core_linux-3.5.7-ipipe-patch3
Type: application/octet-stream
Size: 12780 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130219/936ba6a=
4/attachment.obj>
-------------- next part --------------
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.5.7-xeno2621-patch4 (root@kuka) (gcc version=
 4.4.3 (Ubuntu 4.4.3-4ubuntu5.1) ) #3 SMP PREEMPT Tue Feb 19 10:23:36 CET 2=
013
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cfd9ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cfda0000-0x00000000cfdd0fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000cfdd1000-0x00000000cfdfffff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000cfe00000-0x00000000cfefffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000042fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.4 present.
[    0.000000] e820: last_pfn =3D 0x430000 max_arch_pfn =3D 0x1000000
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] found SMP MP-table at [mem 0x000f4bf0-0x000f4bff] mapped at =
[c00f4bf0]
[    0.000000] init_memory_mapping: [mem 0x00000000-0x37bfdfff]
[    0.000000] RAMDISK: [mem 0x377ef000-0x37feffff]
[    0.000000] Allocated new RAMDISK: [mem 0x36fee000-0x377ee4f0]
[    0.000000] Move RAMDISK from [mem 0x377ef000-0x37fef4f0] to [mem 0x36fe=
e000-0x377ee4f0]
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000042fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x42fffffff]
[    0.000000]   NODE_DATA [mem 0x2e600000-0x2e601fff] (remapped)
[    0.000000] 16260MB HIGHMEM available.
[    0.000000] 891MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 37bfe000
[    0.000000]   low ram: 0 - 37bfe000
[    0.000000] Node: 0, start_pfn: 10, end_pfn: 9f
[    0.000000] Node: 0, start_pfn: 100, end_pfn: cfda0
[    0.000000] Node: 0, start_pfn: 100000, end_pfn: 430000
334000 338000 33c000 340000 344000 348000 34c000 350000 354000 358000 35c00=
0 360000 364000 368000 36c000 370000 374000 378000 37c000 380000 384000 388=
000 38c000 390000 394000 398000 39c000 3a0000 3a4000 3a8000 3ac000 3b0000 3=
b4000 3b8000 3bc000 3c0000 3c4000 3c8000 3cc000 3d0000 3d4000 3d8000 3dc000=
 3e0000 3e4000 3e8000 3ec000 3f0000 3f4000 3f8000 3fc000 400000 404000 4080=
00 40c000 410000 414000 418000 41c000 420000 424000 428000 42c000 =

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00010000-0x00ffffff]
[    0.000000]   Normal   [mem 0x01000000-0x37bfdfff]
[    0.000000]   HighMem  [mem 0x37bfe000-0x2fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00010000-0x0009efff]
[    0.000000]   node   0: [mem 0x00100000-0xcfd9ffff]
[    0.000000]   node   0: [mem 0x00000000-0x2fffffff]
[    0.000000] Using APIC driver default
[    0.000000] SFI: Simple Firmware Interface v0.81 http://simplefirmware.o=
rg
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] MPTABLE: OEM ID: OEM00000
[    0.000000] MPTABLE: Product ID: PROD00000000
[    0.000000] MPTABLE: APIC at: 0xFEE00000
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] Processor #1
[    0.000000] Processor #2
[    0.000000] Processor #3
[    0.000000] Processor #4
[    0.000000] Processor #5
[    0.000000] IOAPIC[0]: apic_id 8, version 33, address 0xfec00000, GSI 0-=
23
[    0.000000] Processors: 6
[    0.000000] SMP: Allowing 6 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 - 00000000001=
00000
[    0.000000] e820: [mem 0xcff00000-0xdfffffff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:6 nr_no=
de_ids:1
[    0.000000] PERCPU: Embedded 18 pages/cpu @f7b5b000 s49536 r0 d24192 u73=
728
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 4159278
[    0.000000] Policy zone: HighMem
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.5.7-xeno26=
21-patch4 root=3DUUID=3De722c833-7422-4a40-9602-8d589eacd32c ro console=3Dt=
ty0 console=3DttyS0,19200n8
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Xenomai: forcing noxsave
[    0.000000] Initializing CPU#0
[    0.000000] allocated 35127168 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t memory cgroups
[    0.000000] Initializing HighMem for node 0 (00037bfe:00430000)
[    0.000000] Memory: 16438748k/17563648k available (5317k kernel code, 19=
6320k reserved, 2133k data, 536k init, 15722120k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
[    0.000000]     pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xf83fe000 - 0xffbfe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf7bfe000   ( 891 MB)
[    0.000000]       .init : 0xc0847000 - 0xc08cd000   ( 536 kB)
[    0.000000]       .data : 0xc06315fd - 0xc0846a80   (2133 kB)
[    0.000000]       .text : 0xc0100000 - 0xc06315fd   (5317 kB)
[    0.000000] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D6, Nodes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Additional per-CPU info printed with stalls.
[    0.000000] NR_IRQS:2304 nr_irqs:728 16
[    0.000000] Interrupt pipeline (release #3)
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3551 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.004000] Fast TSC calibration using PIT
[    0.008000] Detected 3322.050 MHz processor.
[    0.000003] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6644.10 BogoMIPS (lpj=3D13288200)
[    0.064225] pid_max: default: 32768 minimum: 301
[    0.091906] Security Framework initialized
[    0.116450] SELinux:  Disabled at boot.
[    0.139488] Mount-cache hash table entries: 512
[    0.167229] Initializing cgroup subsys cpuacct
[    0.193875] Initializing cgroup subsys memory
[    0.220038] Initializing cgroup subsys devices
[    0.246669] Initializing cgroup subsys freezer
[    0.273328] Initializing cgroup subsys net_cls
[    0.300029] CPU: Physical Processor ID: 0
[    0.324040] CPU: Processor Core ID: 0
[    0.346021] mce: CPU supports 7 MCE banks
[    0.370084] LVT offset 1 assigned for vector 0xf9
[    0.399076] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.431495] ExtINT not setup in hardware but reported by MP table
[    0.468288] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D0 pin2=3D0
[    0.542921] CPU0: AMD FX(tm)-6100 Six-Core Processor              steppi=
ng 02
[    0.800942] Performance Events: AMD Family 15h PMU driver.
[    0.833905] ... version:                0
[    0.857960] ... bit width:              48
[    0.882537] ... generic registers:      6
[    0.906596] ... value mask:             0000ffffffffffff
[    0.938450] ... max period:             00007fffffffffff
[    0.970305] ... fixed-purpose events:   0
[    0.994361] ... event mask:             000000000000003f
[    1.036943] NMI watchdog: enabled on all CPUs, permanently consumes one =
hw-PMU counter.
[    1.092799] lockdep: fixing up alternatives.
[    1.118403] Booting Node   0, Processors  #1[    1.153826] Initializing =
CPU#1
[    1.174178] ------------[ cut here ]------------
[    1.201862] kernel BUG at arch/x86/kernel/ipipe.c:589!

[    1.232661] invalid opcode: 0000 [#1] [    1.255250] PREEMPT SMP =

[    1.270641] Modules linked in:

[    1.290177] Pid: 0, comm: swapper/1 Not tainted 3.5.7-xeno2621-patch4 #3=
 Gigabyte Technology Co., Ltd. GA-990FXA-UD5/GA-990FXA-UD5
[    1.360797] EIP: 0060:[<c011d2ef>] EFLAGS: 00010286 CPU: 1
[    1.393648] EIP is at __ipipe_handle_irq+0x1bf/0x230
[    1.423418] EAX: 372ad000 EBX: ec065f58 ECX: ffffffff EDX: 000000d8
[    1.460989] ESI: c08c3400 EDI: 00000001 EBP: ec065f50 ESP: ec065f38
[    1.498559]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[    1.530929] CR0: 8005003b CR2: 00000000 CR3: 008d6000 CR4: 000007f0
[    1.568501] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    1.606071] DR6: ffff0ff0 DR7: 00000400
[    1.629085] Process swapper/1 (pid: 0, ti=3Dec064000 task=3Dec068000 tas=
k.ti=3Dec064000)
[    1.674467] I-pipe domain Linux
[    1.693310] Stack:
[    1.705362]  c0d136c0 ec065f58 00000086 c08c2814 00000001 00000001 ec065=
f94 c06305e9
[    1.752541]  c08c2814 00000001 00000000 00000001 00000001 ec065f94 372ad=
000 0000007b
[    1.799725]  0000007b 000000d8 00000000 ffffffc8 c01a9dfe 00000060 00000=
246 ec065fb4
[    1.846907] Call Trace:
[    1.861573]  [<c06305e9>] common_interrupt+0x29/0x38
[    1.891350]  [<c01a9dfe>] ? ipipe_unstall_root+0x2e/0x60
[    1.923203]  [<c0628f9e>] start_secondary+0x1cd/0x1e4
[    1.953493] Code: fe ff ff 80 3d 75 24 84 c0 01 0f 84 79 fe ff ff ba 47 =
02 00 00 b8 0a 41 75 c0 e8 0d 21 01 00 c6 05 75 24 84 c0 01 e9 5e fe ff ff =
<0f> 0b eb fe c7 45 f0 01 00 00 00 e9 78 fe ff ff 80 3d 77 24 84 =

[    2.073151] EIP: [<c011d2ef>] __ipipe_handle_irq+0x1bf/0x230 SS:ESP 0068=
:ec065f38
[    2.118205] ---[ end trace ee74ff1ae9a0eca8 ]---
[    2.124037] lockdep: fixing up alternatives.
[    2.124049] CPU 2 irqstacks, hard=3Dec09a000 soft=3Dec09c000
[    2.134774] Initializing CPU#2
[    2.137104] ------------[ cut here ]------------
[    2.137106] kernel BUG at arch/x86/kernel/ipipe.c:589!
[    2.137108] invalid opcode: 0000 [#2] PREEMPT SMP =

[    2.137112] Modules linked in:
[    2.137113] =

[    2.137116] Pid: 0, comm: swapper/2 Tainted: G      D      3.5.7-xeno262=
1-patch4 #3 Gigabyte Technology Co., Ltd. GA-990FXA-UD5/GA-990FXA-UD5
[    2.137120] EIP: 0060:[<c011d2ef>] EFLAGS: 00010286 CPU: 2
[    2.137126] EIP is at __ipipe_handle_irq+0x1bf/0x230
[    2.137127] EAX: 372bf000 EBX: ec067f58 ECX: ffffffff EDX: 000000d8
[    2.137129] ESI: c08c3400 EDI: 00000001 EBP: ec067f50 ESP: ec067f38
[    2.137130]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[    2.137131] CR0: 8005003b CR2: 00000000 CR3: 008d6000 CR4: 000007f0
[    2.137133] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    2.137134] DR6: ffff0ff0 DR7: 00000400
[    2.137136] Process swapper/2 (pid: 0, ti=3Dec066000 task=3Dec069160 tas=
k.ti=3Dec066000)
[    2.137137] I-pipe domain Linux
[    2.137137] Stack:
[    2.137138]  c0d136c0 ec067f58 00000086 c08c2814 00000002 00000001 ec067=
f94 c06305e9
[    2.137145]  c08c2814 00000001 00000000 00000002 00000001 ec067f94 372bf=
000 0000007b
[    2.137153]  0000007b 000000d8 00000000 ffffffc8 c01a9dfe 00000060 00000=
246 ec067fb4
[    2.137160] Call Trace:
[    2.137162]  [<c06305e9>] common_interrupt+0x29/0x38
[    2.137167]  [<c01a9dfe>] ? ipipe_unstall_root+0x2e/0x60
[    2.137171]  [<c0628f9e>] start_secondary+0x1cd/0x1e4
[    2.137175] Code: fe ff ff 80 3d 75 24 84 c0 01 0f 84 79 fe ff ff ba 47 =
02 00 00 b8 0a 41 75 c0 e8 0d 21 01 00 c6 05 75 24 84 c0 01 e9 5e fe ff ff =
<0f> 0b eb fe c7 45 f0 01 00 00 00 e9 78 fe ff ff 80 3d 77 24 84 =

[    2.137224] EIP: [<c011d2ef>] __ipipe_handle_irq+0x1bf/0x230 SS:ESP 0068=
:ec067f38
[    2.137237] ---[ end trace ee74ff1ae9a0eca9 ]---
[    2.137240] Kernel panic - not syncing: Attempted to kill the idle task!
[    2.124052]  #2
