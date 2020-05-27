Subject: Re: tested cpu/hardware for ipipe-x86-4.19.y-cip
References: <BN6PR11MB1620092660A6607B68195DE5EEB10@BN6PR11MB1620.namprd11.prod.outlook.com>
 <ad54c435-1333-944f-c102-1bf0530fc5cb@siemens.com>
 <BN6PR11MB16204DF900B4C34E29288E23EEB10@BN6PR11MB1620.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f4dca287-cb3e-501a-76dd-327766362f73@siemens.com>
Date: Wed, 27 May 2020 18:25:35 +0200
MIME-Version: 1.0
In-Reply-To: <BN6PR11MB16204DF900B4C34E29288E23EEB10@BN6PR11MB1620.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
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
To: "Meng, Fino" <fino.meng@intel.com>, xenomai <xenomai@xenomai.org>
Cc: "Pirou, Florent" <florent.pirou@intel.com>

On 27.05.20 16:40, Meng, Fino wrote:
> 
>> Sent: Wednesday, May 27, 2020 10:00 PM
>>
>> On 27.05.20 14:07, Meng, Fino via Xenomai wrote:
>>> hi Jan&Quirin:
>>>
>>> with the x86-64_defconfig in  gitlab.denx.de/Xenomai/xenomai-images,
>>> the built image cannot boot on our test device (CPU is WHL8665U) after
>>> changed to another defconfig, finally we make it boot OK.
>>
>> If you have both pieces (configs), I supposed you can figure out which switches we might be missing. Is there no output at all
>> on the UART?
> 
> Pasted in below, Seems failed to mount rootfs.
> with kernel parameter: rootwait rw rootwait console=tty1 console=ttyS0,115200 earlyprintk init_debugcall no_console_suspend
> 
>>
>>> To print boot msg we add kernel cmdline: console=tty1 console=ttyS0,
>>> 115200n8 So I am curious on which cpu that you are testing ipipe-x86-4.19.y-cip?
>>
>> Currently on a Celeron E3845 ET and some other Atom which I do not know by heart. I think we had the image running
>> against an i5 as well. Of course, there can always be some switch missing, and we would be glad to extend the range to
>> make the image bootable on more devices.
>>
>>> Why console is missing in the kernel cmdline?
>>
>> It's shouldn't:
>> https://gitlab.denx.de/Xenomai/xenomai-images/-/blob/master/wic/x86-64-efi.wks
>>
>> Or are you referring to a screen console (ttyN)? We operate headless in the testlab.
> 
> Sorry my mistake. We originally use a board with debug port on /dev/ttyS2; then we change another board use ttyS0,
> Serial console works good.
> 
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Center Embedded Linux
> 
> 
> [    0.000000] Linux version 4.19.94-cip18+ (builder@eba4bb92b8e7) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP PREEMPT Tue May 19 04:13:21 UTC 2020
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz root=PARTUUID=dc44d947-26f6-44ce-90f1-22895a427bd1 rootwait rw rootwait console=tty1 console=ttyS0,115200 earlyprintk init_debugcall no_console_suspend
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> [    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> [    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000005efff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000005f000-0x000000000005ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000060000-0x000000000009ffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003fffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000403fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000040400000-0x0000000086c04fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000086c05000-0x0000000086c05fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000086c06000-0x0000000086c06fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000086c07000-0x000000008bf88fff] usable
> [    0.000000] BIOS-e820: [mem 0x000000008bf89000-0x000000008c3f8fff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000008c3f9000-0x000000008c475fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000008c476000-0x000000008c8aafff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000008c8ab000-0x000000008ce66fff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000008ce67000-0x000000008cefefff] type 20
> [    0.000000] BIOS-e820: [mem 0x000000008ceff000-0x000000008cefffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000008cf00000-0x000000008fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000046dffffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] efi: EFI v2.70 by American Megatrends
> [    0.000000] efi:  ACPI 2.0=0x8c412000  ACPI=0x8c412000  SMBIOS=0x8cce1000  SMBIOS 3.0=0x8cce0000  MEMATTR=0x888af018  MPS=0xfcb50
> [    0.000000] SMBIOS 3.2.0 present.
> [    0.000000] DMI: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
> [    0.000000] tsc: Detected 2100.000 MHz processor
> [    0.002070] tsc: Detected 2112.000 MHz TSC
> [    0.002128] last_pfn = 0x46e000 max_arch_pfn = 0x400000000
> [    0.004779] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> [    0.014842] last_pfn = 0x8cf00 max_arch_pfn = 0x400000000
> [    0.024812] found SMP MP-table at [mem 0x000fcdf0-0x000fcdff]
> [    0.024849] Scanning 1 areas for low memory corruption
> [    0.033157] Secure boot could not be determined
> [    0.033171] RAMDISK: [mem 0x375cd000-0x37addfff]
> [    0.033192] ACPI: Early table checksum verification disabled
> [    0.033208] ACPI: RSDP 0x000000008C412000 000024 (v02 ALASKA)
> [    0.033228] ACPI: XSDT 0x000000008C4120A0 0000C4 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.033250] ACPI: FACP 0x000000008C44E9D0 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
> [    0.033272] ACPI: DSDT 0x000000008C4121F8 03C7D4 (v02 ALASKA A M I    01072009 INTL 20160527)
> [    0.033291] ACPI: FACS 0x000000008C8AA080 000040
> [    0.033310] ACPI: APIC 0x000000008C44EAE8 0000BC (v04 ALASKA A M I    01072009 AMI  00010013)
> [    0.033328] ACPI: FPDT 0x000000008C44EBA8 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.033347] ACPI: FIDT 0x000000008C44EBF0 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.033366] ACPI: MCFG 0x000000008C44EC90 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
> [    0.033385] ACPI: SSDT 0x000000008C44ECD0 001B5F (v02 CpuRef CpuSsdt  00003000 INTL 20160527)
> [    0.033404] ACPI: SSDT 0x000000008C450830 0031C6 (v02 SaSsdt SaSsdt   00003000 INTL 20160527)
> [    0.033423] ACPI: HPET 0x000000008C4539F8 000038 (v01 ALASKA A M I    00000002      01000013)
> [    0.033442] ACPI: SSDT 0x000000008C453A30 000FAE (v02 ALASKA Ther_Rvp 00001000 INTL 20160527)
> [    0.033461] ACPI: SSDT 0x000000008C4549E0 00304A (v02 INTEL  xh_whld4 00000000 INTL 20160527)
> [    0.033480] ACPI: UEFI 0x000000008C457A30 000042 (v01 ALASKA A M I    00000002      01000013)
> [    0.033498] ACPI: LPIT 0x000000008C457A78 000094 (v01 ALASKA A M I    00000002      01000013)
> [    0.033517] ACPI: SSDT 0x000000008C457B10 0027DE (v02 ALASKA PtidDevc 00001000 INTL 20160527)
> [    0.033536] ACPI: SSDT 0x000000008C45A2F0 0014E2 (v02 ALASKA TbtTypeC 00000000 INTL 20160527)
> [    0.033554] ACPI: DBGP 0x000000008C45B7D8 000034 (v01 ALASKA A M I    00000002      01000013)
> [    0.033573] ACPI: DBG2 0x000000008C45B810 000054 (v00 ALASKA A M I    00000002      01000013)
> [    0.033592] ACPI: SSDT 0x000000008C45B868 001B67 (v02 ALASKA UsbCTabl 00001000 INTL 20160527)
> [    0.033611] ACPI: DMAR 0x000000008C45D3D0 0000A8 (v01 INTEL  EDK2     00000002      01000013)
> [    0.033629] ACPI: SSDT 0x000000008C45D478 000144 (v02 Intel  ADebTabl 00001000 INTL 20160527)
> [    0.033648] ACPI: WSMT 0x000000008C45D5C0 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.034090] No NUMA configuration found
> [    0.034103] Faking a node at [mem 0x0000000000000000-0x000000046dffffff]
> [    0.034120] NODE_DATA(0) allocated [mem 0x46dfec000-0x46dfeffff]
> [    0.052351] Zone ranges:
> [    0.052368]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.052384]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.052399]   Normal   [mem 0x0000000100000000-0x000000046dffffff]
> [    0.052415] Movable zone start for each node
> [    0.052428] Early memory node ranges
> [    0.052442]   node   0: [mem 0x0000000000001000-0x000000000005efff]
> [    0.052455]   node   0: [mem 0x0000000000060000-0x000000000009ffff]
> [    0.052469]   node   0: [mem 0x0000000000100000-0x000000003fffffff]
> [    0.052482]   node   0: [mem 0x0000000040400000-0x0000000086c04fff]
> [    0.052495]   node   0: [mem 0x0000000086c07000-0x000000008bf88fff]
> [    0.052509]   node   0: [mem 0x000000008ceff000-0x000000008cefffff]
> [    0.052522]   node   0: [mem 0x0000000100000000-0x000000046dffffff]
> [    0.052539] Reserved but unavailable: 97 pages
> [    0.052542] Initmem setup node 0 [mem 0x0000000000001000-0x000000046dffffff]
> [    0.184677] Reserving Intel graphics memory at [mem 0x8e000000-0x8fffffff]
> [    0.184994] ACPI: PM-Timer IO Port: 0x1808
> [    0.185025] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.185039] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.185052] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.185065] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.185079] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
> [    0.185092] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
> [    0.185105] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
> [    0.185119] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
> [    0.185184] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> [    0.185206] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.185227] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.185262] Using ACPI (MADT) for SMP configuration information
> [    0.185276] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.185294] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
> [    0.185369] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.185384] PM: Registered nosave memory: [mem 0x0005f000-0x0005ffff]
> [    0.185398] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    0.185413] PM: Registered nosave memory: [mem 0x40000000-0x403fffff]
> [    0.185427] PM: Registered nosave memory: [mem 0x86c05000-0x86c05fff]
> [    0.185441] PM: Registered nosave memory: [mem 0x86c06000-0x86c06fff]
> [    0.185455] PM: Registered nosave memory: [mem 0x8bf89000-0x8c3f8fff]
> [    0.185469] PM: Registered nosave memory: [mem 0x8c3f9000-0x8c475fff]
> [    0.185482] PM: Registered nosave memory: [mem 0x8c476000-0x8c8aafff]
> [    0.185495] PM: Registered nosave memory: [mem 0x8c8ab000-0x8ce66fff]
> [    0.185509] PM: Registered nosave memory: [mem 0x8ce67000-0x8cefefff]
> [    0.185523] PM: Registered nosave memory: [mem 0x8cf00000-0x8fffffff]
> [    0.185536] PM: Registered nosave memory: [mem 0x90000000-0xdfffffff]
> [    0.185550] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
> [    0.185563] PM: Registered nosave memory: [mem 0xf0000000-0xfdffffff]
> [    0.185576] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
> [    0.185590] PM: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
> [    0.185603] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [    0.185616] PM: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
> [    0.185629] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.185643] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
> [    0.185656] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
> [    0.185680] [mem 0x90000000-0xdfffffff] available for PCI devices
> [    0.185696] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.393424] random: get_random_bytes called from start_kernel+0xa1/0x4f5 with crng_init=0
> [    0.393450] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:8 nr_node_ids:1
> [    0.398657] percpu: Embedded 711 pages/cpu s2874824 r8192 d29240 u4194304
> [    0.398766] Built 1 zonelists, mobility grouping on.  Total pages: 4103325
> [    0.398780] Policy zone: Normal
> [    0.398806] Kernel command line: BOOT_IMAGE=/vmlinuz root=PARTUUID=dc44d947-26f6-44ce-90f1-22895a427bd1 rootwait rw rootwait console=tty1 console=ttyS0,115200 earlyprintk init_debugcall no_console_suspend
> [    0.461240] Memory: 16254052K/16673944K available (12316K kernel code, 1722K rwdata, 3520K rodata, 3944K init, 14984K bss, 419892K reserved, 0K cma-reserved)
> [    0.461911] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> [    0.463145] rcu: Preemptible hierarchical RCU implementation.
> [    0.463159] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
> [    0.463173]  Tasks RCU enabled.
> [    0.463187] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
> [    0.481146] NR_IRQS: 4352, nr_irqs: 2048, preallocated irqs: 16
> [    0.482655] Interrupt pipeline (release #10)
> [    0.482915] Console: colour dummy device 80x25
> [    0.496144] console [tty1] enabled
> [    1.510474] console [ttyS0] enabled
> [    1.672704] ACPI: Core revision 20180810
> [    1.678922] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
> [    1.688322] APIC: Switch to symmetric I/O mode setup
> [    1.695282] x2apic: IRQ remapping doesn't support X2APIC mode
> [    1.708165] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    1.758218] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e71785e5dd, max_idle_ns: 440795244814 ns
> [    1.768930] Calibrating delay loop (skipped), value calculated using timer frequency.. 4224.00 BogoMIPS (lpj=21120000)
> [    1.778944] pid_max: default: 32768 minimum: 301
> [    1.786334] Security Framework initialized
> [    1.788953] SELinux:  Disabled at boot.
> [    1.815720] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
> [    1.833193] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> [    1.839329] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
> [    1.846646] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
> [    1.851438] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    1.858945] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
> [    1.869030] CPU0: Thermal monitoring enabled (TM1)
> [    1.873948] process: using mwait in idle threads
> [    1.878946] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [    1.884440] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> [    1.888945] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    1.898944] Spectre V2 : Mitigation: Enhanced IBRS
> [    1.903823] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    1.908944] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    1.918944] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> [    1.928944] TAA: Vulnerable: Clear CPU buffers attempted, no microcode
> [    1.941173] Freeing SMP alternatives memory: 36K
> [    1.967737] smpboot: CPU0: Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz (family: 0x6, model: 0x8e, stepping: 0xc)
> [    2.029038] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    2.039027] ... version:                4
> [    2.043117] ... bit width:              48
> [    2.047292] ... generic registers:      4
> [    2.048947] ... value mask:             0000ffffffffffff
> [    2.054357] ... max period:             00007fffffffffff
> [    2.058946] ... fixed-purpose events:   3
> [    2.063041] ... event mask:             000000070000000f
> [    2.088970] rcu: Hierarchical SRCU implementation.
> [    2.128972] smp: Bringing up secondary CPUs ...
> [    2.189220] x86: Booting SMP configuration:
> [    2.193510] .... node  #0, CPUs:      #1 #2 #3 #4
> [    2.430041] TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.
> [    2.679907] smp: Brought up 1 node, 8 CPUs
> [    2.683129] smpboot: Max logical packages: 1
> [    2.687480] smpboot: Total of 8 processors activated (33792.00 BogoMIPS)
> [    2.702852] devtmpfs: initialized
> [    2.709341] x86/mm: Memory block size: 128MB
> [    2.757873] PM: Registering ACPI NVS region [mem 0x86c05000-0x86c05fff] (4096 bytes)
> [    2.758995] PM: Registering ACPI NVS region [mem 0x8c476000-0x8c8aafff] (4411392 bytes)
> [    2.777496] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    2.779294] futex hash table entries: 2048 (order: 6, 262144 bytes)
> [    2.789578] RTC time: 22:30:24, date: 05/27/20
> [    2.796221] NET: Registered protocol family 16
> [    2.803280] audit: initializing netlink subsys (disabled)
> [    2.809039] audit: type=2000 audit(1590618622.120:1): state=initialized audit_enabled=0 res=1
> [    2.817619] cpuidle: using governor ladder
> [    2.819117] cpuidle: using governor menu
> [    2.823164] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    2.828968] ACPI: bus type PCI registered
> [    2.833061] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    2.840025] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> [    2.848955] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
> [    2.855907] PCI: Using configuration type 1 for base access
> [    2.935116] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    2.939426] cryptd: max_cpu_qlen set to 1000
> [    2.943581] ACPI: Added _OSI(Module Device)
> [    2.949207] ACPI: Added _OSI(Processor Device)
> [    2.953748] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    2.958550] ACPI: Added _OSI(Processor Aggregator Device)
> [    2.958991] ACPI: Added _OSI(Linux-Dell-Video)
> [    2.963541] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    5.892572] ACPI: 9 ACPI AML tables successfully acquired and loaded
> [    6.237808] ACPI: Dynamic OEM Table Load:
> [    6.239008] ACPI: SSDT 0xFFFF8884594BE758 0000F4 (v02 PmRef  Cpu0Psd  00003000 INTL 20160527)
> [    6.256092] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
> [    6.356273] ACPI: Dynamic OEM Table Load:
> [    6.359009] ACPI: SSDT 0xFFFF8884594ABFC8 000400 (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
> [    6.377098] ACPI: Dynamic OEM Table Load:
> [    6.379009] ACPI: SSDT 0xFFFF8884595053D8 000560 (v02 PmRef  Cpu0Ist  00003000 INTL 20160527)
> [    6.404903] ACPI: Dynamic OEM Table Load:
> [    6.409008] ACPI: SSDT 0xFFFF888459BCBBA8 000149 (v02 PmRef  Cpu0Hwp  00003000 INTL 20160527)
> [    6.422135] ACPI: Dynamic OEM Table Load:
> [    6.426312] ACPI: SSDT 0xFFFF888459502548 000724 (v02 PmRef  HwpLvt   00003000 INTL 20160527)
> [    6.446564] ACPI: Dynamic OEM Table Load:
> [    6.449017] ACPI: SSDT 0xFFFF888459504A88 0005FC (v02 PmRef  ApIst    00003000 INTL 20160527)
> [    6.476213] ACPI: Dynamic OEM Table Load:
> [    6.479009] ACPI: SSDT 0xFFFF888458E27A38 000317 (v02 PmRef  ApHwp    00003000 INTL 20160527)
> [    6.498492] ACPI: Dynamic OEM Table Load:
> [    6.499031] ACPI: SSDT 0xFFFF88845946A2A8 000AB0 (v02 PmRef  ApPsd    00003000 INTL 20160527)
> [    6.563950] ACPI: Dynamic OEM Table Load:
> [    6.568129] ACPI: SSDT 0xFFFF888458E20558 00030A (v02 PmRef  ApCst    00003000 INTL 20160527)
> [    6.838167] ACPI: Interpreter enabled
> [    6.839451] ACPI: (supports S0 S3 S4 S5)
> [    6.843459] ACPI: Using IOAPIC for interrupt routing
> [    6.849386] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    6.940027] ACPI: Enabled 8 GPEs in block 00 to 7F
> [    7.608289] ACPI: Power Resource [USBC] (on)
> [    7.967910] ACPI: Power Resource [V0PR] (on)
> [    7.985583] ACPI: Power Resource [V1PR] (on)
> [    8.005406] ACPI: Power Resource [V2PR] (on)
> [    8.464126] ACPI: Power Resource [WRST] (on)
> [    8.727277] ACPI: Power Resource [FN00] (off)
> [    8.734425] ACPI: Power Resource [FN01] (off)
> [    8.744286] ACPI: Power Resource [FN02] (off)
> [    8.754109] ACPI: Power Resource [FN03] (off)
> [    8.763897] ACPI: Power Resource [FN04] (off)
> [    8.800416] ACPI: Power Resource [PIN] (off)
> [    8.830178] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> [    8.836516] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    8.881639] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]
> [    8.888948] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    8.937321] PCI host bridge to bus 0000:00
> [    8.938961] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    8.945867] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    8.948958] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    8.956571] pci_bus 0000:00: root bus resource [mem 0x90000000-0xdfffffff window]
> [    8.958958] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
> [    8.966571] pci_bus 0000:00: root bus resource [bus 00-fe]
> [    8.982810] pci 0000:00:02.0: BAR 2: assigned to efifb
> [    9.131765] acpiphp: Slot [1] registered
> [    9.135796] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    9.142804] pci 0000:00:1c.4: PCI bridge to [bus 02]
> [    9.151823] pci 0000:00:1d.0: PCI bridge to [bus 03]
> [    9.160841] pci 0000:00:1d.1: PCI bridge to [bus 04]
> [    9.248725] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    9.251751] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *1
> [    9.261730] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    9.271708] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    9.281683] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    9.291671] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    9.301660] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    9.311638] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    9.343116] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    9.345188] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    9.349000] pci 0000:00:02.0: vgaarb: bridge control possible
> [    9.354843] vgaarb: loaded
> [    9.359963] SCSI subsystem initialized
> [    9.363997] ACPI: bus type USB registered
> [    9.369405] usbcore: registered new interface driver usbfs
> [    9.375224] usbcore: registered new interface driver hub
> [    9.379324] usbcore: registered new device driver usb
> [    9.384995] pps_core: LinuxPPS API ver. 1 registered
> [    9.388948] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    9.398292] PTP clock support registered
> [    9.399329] EDAC MC: Ver: 3.0.0
> [    9.403361] Registered efivars operations
> [    9.410323] PCI: Using ACPI for IRQ routing
> [    9.503421] NetLabel: Initializing
> [    9.506902] NetLabel:  domain hash size = 128
> [    9.508948] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    9.515072] NetLabel:  unlabeled traffic allowed by default
> [    9.521741] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
> [    9.529638] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [    9.535939] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
> [    9.542263] clocksource: Switched to clocksource tsc-early
> [   10.003360] VFS: Disk quotas dquot_6.6.0
> [   10.007499] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [   10.015374] FS-Cache: Loaded
> [   10.018862] pnp: PnP ACPI init
> [   10.024756] system 00:00: [mem 0x40000000-0x403fffff] has been reserved
> [   10.039863] system 00:01: [io  0x0a00-0x0a2f] has been reserved
> [   10.045906] system 00:01: [io  0x0a30-0x0a3f] has been reserved
> [   10.051986] system 00:01: [io  0x0a40-0x0a4f] has been reserved
> [   10.114384] ACPI: IRQ 7 override to edge, high
> [   10.129779] ACPI: IRQ 7 override to edge, high
> [   10.145040] ACPI: IRQ 7 override to edge, high
> [   10.160413] ACPI: IRQ 7 override to edge, high
> [   10.168565] system 00:0b: [io  0x0680-0x069f] has been reserved
> [   10.174636] system 00:0b: [io  0x164e-0x164f] has been reserved
> [   10.184229] system 00:0c: [io  0x1854-0x1857] has been reserved
> [   10.199394] system 00:0d: [mem 0xfed10000-0xfed17fff] has been reserved
> [   10.206140] system 00:0d: [mem 0xfed18000-0xfed18fff] has been reserved
> [   10.212912] system 00:0d: [mem 0xfed19000-0xfed19fff] has been reserved
> [   10.219685] system 00:0d: [mem 0xe0000000-0xefffffff] has been reserved
> [   10.226436] system 00:0d: [mem 0xfed20000-0xfed3ffff] has been reserved
> [   10.233209] system 00:0d: [mem 0xfed90000-0xfed93fff] has been reserved
> [   10.239977] system 00:0d: [mem 0xfed45000-0xfed8ffff] has been reserved
> [   10.246729] system 00:0d: [mem 0xfee00000-0xfeefffff] could not be reserved
> [   10.259412] system 00:0e: [io  0x1800-0x18fe] could not be reserved
> [   10.265806] system 00:0e: [mem 0xfd000000-0xfd69ffff] has been reserved
> [   10.272601] system 00:0e: [mem 0xfd6b0000-0xfd6cffff] has been reserved
> [   10.279375] system 00:0e: [mem 0xfd6f0000-0xfdffffff] has been reserved
> [   10.286128] system 00:0e: [mem 0xfe000000-0xfe01ffff] could not be reserved
> [   10.293253] system 00:0e: [mem 0xfe200000-0xfe7fffff] has been reserved
> [   10.300027] system 00:0e: [mem 0xff000000-0xffffffff] has been reserved
> [   10.314904] system 00:0f: [io  0x2000-0x20fe] has been reserved
> [   10.364048] system 00:10: [mem 0xfd6e0000-0xfd6effff] has been reserved
> [   10.370829] system 00:10: [mem 0xfd6d0000-0xfd6dffff] has been reserved
> [   10.377573] system 00:10: [mem 0xfd6a0000-0xfd6affff] has been reserved
> [   10.421339] pnp: PnP ACPI: found 17 devices
> [   10.468074] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [   10.477201] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [   10.482312] pci 0000:00:1c.4: PCI bridge to [bus 02]
> [   10.487377] pci 0000:00:1c.4:   bridge window [mem 0xa1300000-0xa13fffff]
> [   10.494318] pci 0000:00:1d.0: PCI bridge to [bus 03]
> [   10.499405] pci 0000:00:1d.0:   bridge window [io  0x4000-0x4fff]
> [   10.505610] pci 0000:00:1d.0:   bridge window [mem 0xa1200000-0xa12fffff]
> [   10.512551] pci 0000:00:1d.1: PCI bridge to [bus 04]
> [   10.517608] pci 0000:00:1d.1:   bridge window [io  0x3000-0x3fff]
> [   10.523836] pci 0000:00:1d.1:   bridge window [mem 0xa1100000-0xa11fffff]
> [   10.536377] NET: Registered protocol family 2
> [   10.543132] tcp_listen_portaddr_hash hash table entries: 8192 (order: 7, 589824 bytes)
> [   10.555798] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
> [   10.568332] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
> [   10.602138] TCP: Hash tables configured (established 131072 bind 65536)
> [   10.610869] UDP hash table entries: 8192 (order: 8, 1310720 bytes)
> [   10.625413] UDP-Lite hash table entries: 8192 (order: 8, 1310720 bytes)
> [   10.639843] NET: Registered protocol family 1
> [   10.646456] RPC: Registered named UNIX socket transport module.
> [   10.652544] RPC: Registered udp transport module.
> [   10.657336] RPC: Registered tcp transport module.
> [   10.662156] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [   10.668724] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [   10.690086] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x69f took 12532 usecs
> [   10.698668] Trying to unpack rootfs image as initramfs...
> [   10.881692] Freeing initrd memory: 5188K
> [   10.885701] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [   10.892294] software IO TLB: mapped [mem 0x81c26000-0x85c26000] (64MB)
> [   10.899750] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
> [   10.907787] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [   10.913678] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   10.919908] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [   10.925397] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [   10.931193] RAPL PMU: hw unit of domain psys 2^-14 Joules
> [   10.942062] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1e71785e5dd, max_idle_ns: 440795244814 ns
> [   10.952420] clocksource: Switched to clocksource tsc
> [   10.957764] platform rtc_cmos: registered platform RTC device (no PNP device found)
> [   10.966914] Scanning for low memory corruption every 60 seconds
> [   10.990859] [Xenomai] scheduling class idle registered.
> [   10.996175] [Xenomai] scheduling class weak registered.
> [   11.001521] [Xenomai] scheduling class tp registered.
> [   11.006659] [Xenomai] scheduling class pss registered.
> [   11.011931] [Xenomai] scheduling class quota registered.
> [   11.017330] [Xenomai] scheduling class rt registered.
> [   11.022931] [Xenomai] SMI-enabled chipset found, but SMI workaround disabled
> [   11.022931]           (see xenomai.smi parameter). You might encounter
> [   11.022931]           high latencies!
> [   11.040458] I-pipe: head domain Xenomai registered.
> [   11.065459] [Xenomai] Cobalt v3.1 [DEBUG][LTRACE]
> [   11.070618] workingset: timestamp_bits=56 max_order=22 bucket_order=0
> [   11.159947] NFS: Registering the id_resolver key type
> [   11.165204] Key type id_resolver registered
> [   11.169531] Key type id_legacy registered
> [   11.173652] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> [   11.181059] fuse init (API version 7.27)
> [   11.186681] 9p: Installing v9fs 9p2000 file system support
> [   11.192893] FS-Cache: Netfs '9p' registered for caching
> [   11.203524] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
> [   11.211104] io scheduler noop registered
> [   11.215104] io scheduler deadline registered (default)
> [   11.221536] io scheduler cfq registered
> [   11.225452] io scheduler mq-deadline registered (default)
> [   11.230985] io scheduler kyber registered
> [   11.240692] pcieport 0000:00:1c.0: Signaling PME with IRQ 120
> [   11.254638] pcieport 0000:00:1c.4: Signaling PME with IRQ 121
> [   11.261063] pcieport 0000:00:1c.4: AER enabled with IRQ 121
> [   11.274397] pcieport 0000:00:1d.0: Signaling PME with IRQ 122
> [   11.280830] pcieport 0000:00:1d.0: AER enabled with IRQ 122
> [   11.294326] pcieport 0000:00:1d.1: Signaling PME with IRQ 123
> [   11.300787] pcieport 0000:00:1d.1: AER enabled with IRQ 123
> [   11.307465] efifb: probing for efifb
> [   11.311242] efifb: framebuffer at 0x90000000, using 1216k, total 1216k
> [   11.317876] efifb: mode is 640x480x32, linelength=2560, pages=1
> [   11.323929] efifb: scrolling: redraw
> [   11.327582] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [   11.336141] Console: switching to colour frame buffer device 80x30
> [   11.343296] fb0: EFI VGA frame buffer device
> [   11.350838] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
> [   11.359606] ACPI: Sleep Button [SLPB]
> [   11.364142] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
> [   11.373799] ACPI: Power Button [PWRB]
> [   11.378813] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> [   11.387714] ACPI: Power Button [PWRF]
> [   11.403630] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> ▒[   11.432587] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [   11.463827] 00:06: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [   11.494990] 00:07: ttyS2 at I/O 0x3e8 (irq = 7, base_baud = 115200) is a 16550A
> [   11.526144] 00:08: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
> [   11.540390] Linux agpgart interface v0.103
> [   11.598090] brd: module loaded
> [   11.649907] loop: module loaded
> [   11.673924] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 3 ports 6 Gbps 0x7 impl SATA mode
> [   11.683358] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slum part deso sadm sds apst
> [   11.706329] scsi host0: ahci
> [   11.712403] scsi host1: ahci
> [   11.717769] scsi host2: ahci
> [   11.722302] ata1: SATA max UDMA/133 abar m2048@0xa141a000 port 0xa141a100 irq 124
> [   11.731093] ata2: SATA max UDMA/133 abar m2048@0xa141a000 port 0xa141a180 irq 124
> [   11.739896] ata3: SATA max UDMA/133 abar m2048@0xa141a000 port 0xa141a200 irq 124
> [   11.753965] libphy: Fixed MDIO Bus: probed
> [   11.764597] tun: Universal TUN/TAP device driver, 1.6
> [   11.771278] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [   11.779085] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [   11.785821] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [   11.792379] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   11.799316] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> [   11.806968] igb: Copyright (c) 2007-2014 Intel Corporation.
> [   11.850703] pps pps0: new PPS source ptp0
> [   11.856175] igb 0000:03:00.0: added PHC on eth0
> [   11.861399] igb 0000:03:00.0: Intel(R) Gigabit Ethernet Network Connection
> [   11.868986] igb 0000:03:00.0: eth0: (PCIe:2.5Gb/s:Width x1) b0:41:6f:05:61:8e
> [   11.876778] igb 0000:03:00.0: eth0: PBA No: FFFFFF-0FF
> [   11.882578] igb 0000:03:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
> [   11.928299] pps pps1: new PPS source ptp1
> [   11.933780] igb 0000:04:00.0: added PHC on eth1
> [   11.938988] igb 0000:04:00.0: Intel(R) Gigabit Ethernet Network Connection
> [   11.946507] igb 0000:04:00.0: eth1: (PCIe:2.5Gb/s:Width x1) b0:41:6f:05:61:8f
> [   11.954331] igb 0000:04:00.0: eth1: PBA No: FFFFFF-0FF
> [   11.960154] igb 0000:04:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
> [   11.969216] PPP generic driver version 2.4.2
> [   11.975472] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [   11.982723] ehci-pci: EHCI PCI platform driver
> [   11.988001] uhci_hcd: USB Universal Host Controller Interface driver
> [   11.996344] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
> [   12.007649] serio: i8042 KBD port at 0x60,0x64 irq 1
> [   12.014078] serio: i8042 AUX port at 0x60,0x64 irq 12
> [   12.021800] mousedev: PS/2 mouse device common for all mice
> [   12.031485] input: PC Speaker as /devices/platform/pcspkr/input/input4
> [   12.040140] rtc_cmos rtc_cmos: RTC can wake from S4
> [   12.047368] rtc_cmos rtc_cmos: registered as rtc0
> [   12.053133] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [   12.068836] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> [   12.075462] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [   12.081186] ata1: SATA link down (SStatus 4 SControl 300)
> [   12.088035] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [   12.095090] ata3: SATA link down (SStatus 4 SControl 300)
> [   12.103024] ata2.00: ATA-10: KINGSTON RBUSNS8180S3128GJ, SBFK61D1, max UDMA/133
> [   12.111528] ata2.00: 250069680 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [   12.121143] ata2.00: configured for UDMA/133
> [   12.127483] scsi 1:0:0:0: Direct-Access     ATA      KINGSTON RBUSNS8 61D1 PQ: 0 ANSI: 5
> [   12.140882] sd 1:0:0:0: Attached scsi generic sg0 type 0
> [   12.141107] sd 1:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
> [   12.155950] sd 1:0:0:0: [sda] Write Protect is off
> [   12.161740] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   12.180797] sd 1:0:0:0: [sda] Attached SCSI disk
> [   12.188652] IR NEC protocol handler initialized
> [   12.193871] IR RC5(x/sz) protocol handler initialized
> [   12.199593] IR RC6 protocol handler initialized
> [   12.204811] IR JVC protocol handler initialized
> [   12.209989] IR Sony protocol handler initialized
> [   12.215211] IR SANYO protocol handler initialized
> [   12.220566] IR Sharp protocol handler initialized
> [   12.225848] IR MCE Keyboard/mouse protocol handler initialized
> [   12.232329] IR XMP protocol handler initialized
> [   12.239280] device-mapper: uevent: version 1.0.3
> [   12.246374] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
> [   12.257393] device-mapper: multipath round-robin: version 1.2.0 loaded
> [   12.266259] EFI Variables Facility v0.08 2004-May-17
> [   12.296535] pstore: Registered efi as persistent store backend
> [   12.313270] NET: Registered protocol family 10
> [   12.323823] Segment Routing with IPv6
> [   12.329837] NET: Registered protocol family 17
> [   12.335657] 9pnet: Installing 9P2000 support
> [   12.340736] Key type dns_resolver registered
> [   12.353760] mce: Using 10 MCE banks
> [   12.358393] microcode: sig=0x806ec, pf=0x80, revision=0xb2
> [   12.365519] microcode: Microcode Update Driver: v2.2.
> [   12.365659] AVX2 version of gcm_enc/dec engaged.
> [   12.376472] AES CTR mode by8 optimization enabled
> [   12.387005] sched_clock: Marking stable (11180018202, 1206948484)->(12602924476, -215957790)
> [   12.398843] registered taskstats version 1
> [   12.404109] pstore: Using compression: deflate
> [   12.482278]   Magic number: 4:835:553
> [   12.486531] clockevents clockevent4: hash matches
> [   12.491920] wmi A6FEA33E-DABF-46F5-BFC8-460D961BEC9F: hash matches
> [   12.498681] acpi PNP0C0F:04: hash matches
> [   12.503562] rtc_cmos rtc_cmos: setting system clock to 2020-05-27 22:30:34 UTC (1590618634)
> [   12.522821] Freeing unused kernel image memory: 3944K
> [   12.529051] Write protecting the kernel read-only data: 18432k
> [   12.541853] Freeing unused kernel image memory: 1980K
> [   12.548832] Freeing unused kernel image memory: 576K
> [   12.555190] rodata_test: all tests were successful
> [   12.561043] Run /init as init process
> Loading, please wait...
> Starting version 241
> [   14.497033] igb 0000:03:00.0 enp3s0: renamed from eth0
> [   14.601139] igb 0000:04:00.0 enp4s0: renamed from eth1
> Begin: Loading essential drivers ... done.
> Begin: Running /scripts/init-premount ... done.
> Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
> Begin: Running /scripts/local-premount ... done.
> Begin: Waiting for root file system ... Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> [   17.405396] random: fast init done
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> done.
> Gave up waiting for root file system device.  Common problems:
>  - Boot args (cat /proc/cmdline)
>    - Check rootdelay= (did the system wait long enough?)
>  - Missing modules (cat /proc/modules; ls /dev)
> ALERT!  PARTUUID=dc44d947-26f6-44ce-90f1-22895a427bd1 does not exist.  Dropping to a shell!
> (initramfs)
> 
> BR/fino
> 

Must be something hardware-specific, storage driver related. The x86-efi
image produced by xenomai-images boots fine in qemu, e.g. like this:

qemu-system-x86_64 -enable-kvm -M q35 -m 1G -snapshot -bios
/usr/share/qemu/ovmf-x86_64.bin
build/tmp/deploy/images/x86-64-efi/demo-image-xenomai-demo-x86-64-efi.wic.img

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

