Date: Mon, 23 Apr 2018 09:24:28 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <608722743.1100357.1524464668912.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <CALLqZ8S1EP-_KEaAC4+4pnd=q_5ymFg8uEretz08-hia6tESmw@mail.gmail.com>
References: <1374825470.13406245.1523973370099.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8Rs-3ux4rCxmXkRbRjQ_5c2MhkXFSLMCr3nfdkNYJKHpg@mail.gmail.com>
 <440568911.1056302.1524311475119.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8S1EP-_KEaAC4+4pnd=q_5ymFg8uEretz08-hia6tESmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Unknown symbol in module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai <xenomai@xenomai.org>

yeti@yeti-UDOO-x86:~$ uname -r
4.9.90-xenomai

yeti@yeti-UDOO-x86:~$ dmesg|grep Xenomai
[   12.917420] [Xenomai] scheduling class idle registered.
[   12.917422] [Xenomai] scheduling class rt registered.
[   12.917480] [Xenomai] SMI-enabled chipset found, but SMI workaround disa=
bled
[   12.918467] I-pipe: head domain Xenomai registered.
[   12.920801] [Xenomai] Cobalt v3.0.6 (Stellar Parallax)=20



yeti@yeti-UDOO-x86:~$ dmesg
[    0.000000] Linux version 4.9.90-xenomai (root@yeti-UDOO-x86) (gcc versi=
on 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9) ) #2 SMP Thu Apr 5 11:18:=
52 EEST 2018
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-4.9.90-xenomai root=
=3DUUID=3Dca0244c5-d957-4ab6-8632-01fd821fcc06 ro quiet splash vt.handoff=
=3D7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'lazy' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007a4befff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000007a4bf000-0x000000007aebefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007aebf000-0x000000007bfbefff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007bfbf000-0x000000007bffefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007bfff000-0x000000007bffffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000007c400000-0x000000007fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e3ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000feafffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed03000-0x00000000fed03fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed09fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1cfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fedbffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff] usabl=
e
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: SECO UDOO x86/UDOO x86, BIOS 1.03 08/04/2017
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x280000 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFC00000 mask FFFC00000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 07E000000 mask FFE000000 uncachable
[    0.000000]   3 base 07D000000 mask FFF000000 uncachable
[    0.000000]   4 base 07C800000 mask FFF800000 uncachable
[    0.000000]   5 base 07C400000 mask FFFC00000 uncachable
[    0.000000]   6 base 100000000 mask F00000000 write-back
[    0.000000]   7 base 200000000 mask F80000000 write-back
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT=
 =20
[    0.000000] e820: last_pfn =3D 0x7c000 max_arch_pfn =3D 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff93fd40098000] 98000 size 2457=
6
[    0.000000] BRK [0x2295b4000, 0x2295b4fff] PGTABLE
[    0.000000] BRK [0x2295b5000, 0x2295b5fff] PGTABLE
[    0.000000] BRK [0x2295b6000, 0x2295b6fff] PGTABLE
[    0.000000] BRK [0x2295b7000, 0x2295b7fff] PGTABLE
[    0.000000] BRK [0x2295b8000, 0x2295b8fff] PGTABLE
[    0.000000] BRK [0x2295b9000, 0x2295b9fff] PGTABLE
[    0.000000] BRK [0x2295ba000, 0x2295bafff] PGTABLE
[    0.000000] BRK [0x2295bb000, 0x2295bbfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x10102000-0x24078fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FE020 000024 (v02 INSYDE)
[    0.000000] ACPI: XSDT 0x000000007BFFE120 00009C (v01 INSYDE INSYDE   00=
000003      01000013)
[    0.000000] ACPI: FACP 0x000000007BFF9000 00010C (v05 INSYDE INSYDE   00=
000003 ACPI 00040000)
[    0.000000] ACPI: DSDT 0x000000007BFEB000 008BA4 (v02 INSYDE INSYDE   00=
000003 ACPI 00040000)
[    0.000000] ACPI: FACS 0x000000007BFAB000 000040
[    0.000000] ACPI: UEFI 0x000000007BFFD000 000236 (v01 INSYDE INSYDE   00=
000001 ACPI 00040000)
[    0.000000] ACPI: TCPA 0x000000007BFFC000 000032 (v02 INSYDE INSYDE   00=
000000 ACPI 00040000)
[    0.000000] ACPI: UEFI 0x000000007BFFA000 000042 (v01 INSYDE INSYDE   00=
000000 ACPI 00040000)
[    0.000000] ACPI: APIC 0x000000007BFF8000 000084 (v03 INSYDE INSYDE   00=
000003 ACPI 00040000)
[    0.000000] ACPI: MCFG 0x000000007BFF7000 00003C (v01 INSYDE INSYDE   00=
000003 ACPI 00040000)
[    0.000000] ACPI: SLIC 0x000000007BFF6000 000176 (v01 INSYDE INSYDE   00=
000003 ACPI 00040000)
[    0.000000] ACPI: WDAT 0x000000007BFF5000 0001C4 (v01 INSYDE INSYDE   00=
000003 ACPI 00040000)
[    0.000000] ACPI: WDRT 0x000000007BFF4000 000047 (v01 INSYDE INSYDE   00=
000003 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x000000007BFEA000 0007A1 (v01 INSYDE CpuPm    00=
003000 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x000000007BFE9000 0002B5 (v01 INSYDE Cpu0Tst  00=
003000 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x000000007BFE8000 0001DE (v01 INSYDE ApTst    00=
003000 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x000000007BFE7000 000469 (v01 INSYDE Tpm2Tabl 00=
001000 ACPI 00040000)
[    0.000000] ACPI: TPM2 0x000000007BFE6000 000034 (v03 INSYDE INSYDE   00=
000000 ACPI 00040000)
[    0.000000] ACPI: FPDT 0x000000007BFE5000 000044 (v01 INSYDE INSYDE   00=
000002 ACPI 00040000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000027fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x27ffd9000-0x27fffafff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000027fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000007a4befff]
[    0.000000]   node   0: [mem 0x000000007bfff000-0x000000007bffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000027fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000027ffff=
fff]
[    0.000000] On node 0 totalpages: 2073693
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7763 pages used for memmap
[    0.000000]   DMA32 zone: 496832 pages, LIFO batch:31
[    0.000000]   Normal zone: 24576 pages used for memmap
[    0.000000]   Normal zone: 1572864 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics memory at 0x000000007cc00000-0x0000=
00007ebfffff
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-=
114
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a4bf000-0x7aebefff]
[    0.000000] PM: Registered nosave memory: [mem 0x7aebf000-0x7bfbefff]
[    0.000000] PM: Registered nosave memory: [mem 0x7bfbf000-0x7bffefff]
[    0.000000] PM: Registered nosave memory: [mem 0x7c000000-0x7c3fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x7c400000-0x7fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x80000000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xe3ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe4000000-0xfe9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfea00000-0xfeafffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeb00000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed01fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed02000-0xfed02fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed03000-0xfed03fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed04000-0xfed07fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed08000-0xfed09fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed0a000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1cfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1d000-0xfed7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfedbffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedc0000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffbfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffffffff]
[    0.000000] e820: [mem 0x80000000-0xdfffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 n=
r_node_ids:1
[    0.000000] percpu: Embedded 171 pages/cpu @ffff93ffb7200000 s659864 r81=
92 d32360 u1048576
[    0.000000] pcpu-alloc: s659864 r8192 d32360 u1048576 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 [0] 2 3=20
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Tota=
l pages: 2041269
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-4.9.90-xenom=
ai root=3DUUID=3Dca0244c5-d957-4ab6-8632-01fd821fcc06 ro quiet splash vt.ha=
ndoff=3D7
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing=
!
[    0.000000] Memory: 7741208K/8294772K available (8560K kernel code, 1458=
K rwdata, 3504K rodata, 2328K init, 8152K bss, 553564K reserved, 0K cma-res=
erved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] Hierarchical RCU implementation.
[    0.000000] =09Build-time adjustment of leaf fanout to 64.
[    0.000000] =09RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=3D4=
.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D64, nr_cpu_ids=
=3D4
[    0.000000] NR_IRQS:33024 nr_irqs:1024 16
[    0.000000] Interrupt pipeline (release #6)
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] tsc: Detected 1600.000 MHz processor
[    0.000046] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 3200.00 BogoMIPS (lpj=3D1600000)
[    0.000053] pid_max: default: 32768 minimum: 301
[    0.000084] ACPI: Core revision 20160831
[    0.016946] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.017040] Security Framework initialized
[    0.017044] Yama: becoming mindful.
[    0.017052] SELinux:  Disabled at boot.
[    0.017056] AppArmor: AppArmor disabled by boot time parameter
[    0.018321] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes)
[    0.022840] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.024863] Mount-cache hash table entries: 16384 (order: 5, 131072 byte=
s)
[    0.024886] Mountpoint-cache hash table entries: 16384 (order: 5, 131072=
 bytes)
[    0.025532] CPU: Physical Processor ID: 0
[    0.025535] CPU: Processor Core ID: 0
[    0.025542] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.025543] ENERGY_PERF_BIAS: View and update with x86_energy_perf_polic=
y(8)
[    0.025554] mce: CPU supports 6 MCE banks
[    0.025567] CPU0: Thermal monitoring enabled (TM1)
[    0.025576] process: using mwait in idle threads
[    0.025583] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.025585] Last level dTLB entries: 4KB 256, 2MB 16, 4MB 16, 1GB 0
[    0.025589] Spectre V2 : Mitigation: Full generic retpoline
[    0.026487] Freeing SMP alternatives memory: 32K
[    0.026872] smpboot: Max logical packages: 1
[    0.028942] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.038979] TSC deadline timer enabled
[    0.038985] smpboot: CPU0: Intel(R) Pentium(R) CPU  N3710  @ 1.60GHz (fa=
mily: 0x6, model: 0x4c, stepping: 0x4)
[    0.038996] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont event=
s, 8-deep LBR, full-width counters, Intel PMU driver.
[    0.039034] ... version:                3
[    0.039036] ... bit width:              40
[    0.039038] ... generic registers:      2
[    0.039040] ... value mask:             000000ffffffffff
[    0.039042] ... max period:             0000007fffffffff
[    0.039044] ... fixed-purpose events:   3
[    0.039046] ... event mask:             0000000700000003
[    0.040927] NMI watchdog: enabled on all CPUs, permanently consumes one =
hw-PMU counter.
[    0.041357] x86: Booting SMP configuration:
[    0.041361] .... node  #0, CPUs:      #1 #2 #3
[    0.048959] x86: Booted up 1 node, 4 CPUs
[    0.048964] smpboot: Total of 4 processors activated (12800.00 BogoMIPS)
[    0.051299] devtmpfs: initialized
[    0.051489] x86/mm: Memory block size: 128MB
[    0.061416] evm: security.selinux
[    0.061418] evm: security.SMACK64
[    0.061420] evm: security.SMACK64EXEC
[    0.061421] evm: security.SMACK64TRANSMUTE
[    0.061423] evm: security.SMACK64MMAP
[    0.061425] evm: security.ima
[    0.061426] evm: security.capability
[    0.061593] PM: Registering ACPI NVS region [mem 0x7aebf000-0x7bfbefff] =
(17825792 bytes)
[    0.062505] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.062529] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.062661] pinctrl core: initialized pinctrl subsystem
[    0.062967] RTC time:  6:19:44, date: 04/23/18
[    0.063196] NET: Registered protocol family 16
[    0.063894] PCCT header not found.
[    0.063997] ACPI: bus type PCI registered
[    0.064001] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.064189] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xe0000000=
-0xe3ffffff] (base 0xe0000000)
[    0.064194] PCI: MMCONFIG at [mem 0xe0000000-0xe3ffffff] reserved in E82=
0
[    0.064209] PCI: Using configuration type 1 for base access
[    0.072338] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.073030] ACPI: Added _OSI(Module Device)
[    0.073033] ACPI: Added _OSI(Processor Device)
[    0.073036] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.073038] ACPI: Added _OSI(Processor Aggregator Device)
[    0.073432] ACPI: Executed 5 blocks of module-level executable AML code
[    0.092668] ACPI: Dynamic OEM Table Load:
[    0.092688] ACPI: SSDT 0xFFFF93FFB597B800 0006FD (v01 PmRef  Cpu0Ist  00=
003000 INTL 20160527)
[    0.093012] ACPI: Executed 1 blocks of module-level executable AML code
[    0.093359] ACPI: Dynamic OEM Table Load:
[    0.093375] ACPI: SSDT 0xFFFF93FFB59BF800 0003CA (v01 PmRef  Cpu0Cst  00=
003001 INTL 20160527)
[    0.093851] ACPI: Executed 1 blocks of module-level executable AML code
[    0.094728] ACPI: Dynamic OEM Table Load:
[    0.094744] ACPI: SSDT 0xFFFF93FFB59FDE00 0001E0 (v01 PmRef  ApIst    00=
003000 INTL 20160527)
[    0.095061] ACPI: Executed 1 blocks of module-level executable AML code
[    0.095347] ACPI: Dynamic OEM Table Load:
[    0.095361] ACPI: SSDT 0xFFFF93FFB59ECE00 0000C9 (v01 PmRef  ApCst    00=
003000 INTL 20160527)
[    0.095570] ACPI: Executed 1 blocks of module-level executable AML code
[    0.098797] ACPI: Interpreter enabled
[    0.098866] ACPI: (supports S0 S3 S4 S5)
[    0.098869] ACPI: Using IOAPIC for interrupt routing
[    0.098973] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.099086] platform wdat_wdt: failed to claim resource 4
[    0.099101] ACPI: watchdog: Failed to create platform device
[    0.101997] ACPI: Power Resource [USBC] (on)
[    0.114858] ACPI: Power Resource [ID3C] (off)
[    0.124663] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.124676] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    0.124846] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.124878] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [=
bus 00-3f] only partially covers this bridge
[    0.125241] acpi PNP0A08:00: host bridge window expanded to [mem 0x80000=
000-0xdfffffff window]; [mem 0x80000000-0xdfffffff window] ignored
[    0.125905] PCI host bridge to bus 0000:00
[    0.125911] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
[    0.125915] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window=
]
[    0.125918] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window=
]
[    0.125922] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    0.125926] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.125930] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dfff=
f window]
[    0.125933] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000ffff=
f window]
[    0.125937] pci_bus 0000:00: root bus resource [mem 0x80000000-0xdffffff=
f window]
[    0.125941] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.125958] pci 0000:00:00.0: [8086:2280] type 00 class 0x060000
[    0.126371] pci 0000:00:02.0: [8086:22b1] type 00 class 0x030000
[    0.126411] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x90ffffff 64bit=
]
[    0.126435] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff 64bit=
 pref]
[    0.126452] pci 0000:00:02.0: reg 0x20: [io  0x2000-0x203f]
[    0.126834] pci 0000:00:13.0: [8086:22a3] type 00 class 0x010601
[    0.126916] pci 0000:00:13.0: reg 0x20: [io  0x2060-0x207f]
[    0.126933] pci 0000:00:13.0: reg 0x24: [mem 0x9141e000-0x9141e7ff]
[    0.127019] pci 0000:00:13.0: PME# supported from D3hot
[    0.127310] pci 0000:00:14.0: [8086:22b5] type 00 class 0x0c0330
[    0.127347] pci 0000:00:14.0: reg 0x10: [mem 0x91400000-0x9140ffff 64bit=
]
[    0.127480] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.127696] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.127827] pci 0000:00:1a.0: [8086:2298] type 00 class 0x108000
[    0.127856] pci 0000:00:1a.0: reg 0x10: [mem 0x91300000-0x913fffff]
[    0.127873] pci 0000:00:1a.0: reg 0x14: [mem 0x91200000-0x912fffff]
[    0.128003] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.128393] pci 0000:00:1b.0: [8086:2284] type 00 class 0x040300
[    0.128431] pci 0000:00:1b.0: reg 0x10: [mem 0x91410000-0x91413fff 64bit=
]
[    0.128562] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.128746] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.128865] pci 0000:00:1c.0: [8086:22c8] type 01 class 0x060400
[    0.129007] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.129196] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.129318] pci 0000:00:1c.2: [8086:22cc] type 01 class 0x060400
[    0.129462] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.129638] pci 0000:00:1c.2: System wakeup disabled by ACPI
[    0.129772] pci 0000:00:1f.0: [8086:229c] type 00 class 0x060100
[    0.130194] pci 0000:00:1f.3: [8086:2292] type 00 class 0x0c0500
[    0.130253] pci 0000:00:1f.3: reg 0x10: [mem 0x91418000-0x9141801f]
[    0.130380] pci 0000:00:1f.3: reg 0x20: [io  0x2040-0x205f]
[    0.130929] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.131120] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
[    0.131152] pci 0000:02:00.0: reg 0x10: [io  0x1000-0x10ff]
[    0.131198] pci 0000:02:00.0: reg 0x18: [mem 0x91100000-0x91100fff 64bit=
]
[    0.131226] pci 0000:02:00.0: reg 0x20: [mem 0x91000000-0x91003fff 64bit=
 pref]
[    0.131384] pci 0000:02:00.0: supports D1 D2
[    0.131388] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.131493] pci 0000:02:00.0: System wakeup disabled by ACPI
[    0.135119] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    0.135127] pci 0000:00:1c.2:   bridge window [io  0x1000-0x1fff]
[    0.135134] pci 0000:00:1c.2:   bridge window [mem 0x91100000-0x911fffff=
]
[    0.135145] pci 0000:00:1c.2:   bridge window [mem 0x91000000-0x910fffff=
 64bit pref]
[    1.198132] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15=
) *7
[    1.198345] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    1.198558] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 1=
5)
[    1.198768] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 12 14 1=
5)
[    1.198977] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    1.199198] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    1.199408] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15=
) *7
[    1.199618] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    1.211378] ACPI: Enabled 6 GPEs in block 00 to 3F
[    1.211669] vgaarb: setting as boot device: PCI:0000:00:02.0
[    1.211673] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    1.211680] vgaarb: loaded
[    1.211683] vgaarb: bridge control possible 0000:00:02.0
[    1.212268] SCSI subsystem initialized
[    1.212406] libata version 3.00 loaded.
[    1.212463] ACPI: bus type USB registered
[    1.212520] usbcore: registered new interface driver usbfs
[    1.212552] usbcore: registered new interface driver hub
[    1.212601] usbcore: registered new device driver usb
[    1.212995] PCI: Using ACPI for IRQ routing
[    1.215881] PCI: pci_cache_line_size set to 64 bytes
[    1.215958] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    1.215963] e820: reserve RAM buffer [mem 0x7a4bf000-0x7bffffff]
[    1.216262] NetLabel: Initializing
[    1.216265] NetLabel:  domain hash size =3D 128
[    1.216267] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    1.216294] NetLabel:  unlabeled traffic allowed by default
[    1.216510] clocksource: Switched to clocksource refined-jiffies
[    1.239625] VFS: Disk quotas dquot_6.6.0
[    1.239675] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    1.239929] pnp: PnP ACPI init
[    1.240177] system 00:00: [io  0x0680-0x069f] has been reserved
[    1.240182] system 00:00: [io  0x0400-0x047f] has been reserved
[    1.240187] system 00:00: [io  0x0500-0x05fe] has been reserved
[    1.240197] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    1.243759] system 00:01: [mem 0x91421000-0x91421fff] has been reserved
[    1.243764] system 00:01: [mem 0x9141f000-0x9141ffff] has been reserved
[    1.243769] system 00:01: [mem 0x9141d000-0x9141dfff] has been reserved
[    1.243773] system 00:01: [mem 0x9141b000-0x9141bfff] has been reserved
[    1.243778] system 00:01: [mem 0x91419000-0x91419fff] has been reserved
[    1.243787] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    1.244070] system 00:02: [mem 0xe0000000-0xefffffff] could not be reser=
ved
[    1.244075] system 00:02: [mem 0xfea00000-0xfeafffff] has been reserved
[    1.244080] system 00:02: [mem 0xfed01000-0xfed01fff] has been reserved
[    1.244084] system 00:02: [mem 0xfed03000-0xfed03fff] has been reserved
[    1.244088] system 00:02: [mem 0xfed06000-0xfed06fff] has been reserved
[    1.244092] system 00:02: [mem 0xfed08000-0xfed09fff] has been reserved
[    1.244097] system 00:02: [mem 0xfed80000-0xfedbffff] could not be reser=
ved
[    1.244101] system 00:02: [mem 0xfed1c000-0xfed1cfff] has been reserved
[    1.244106] system 00:02: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    1.244114] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    1.244557] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.245059] pnp: PnP ACPI: found 4 devices
[    1.255463] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    1.255495] clocksource: Switched to clocksource acpi_pm
[    1.255527] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus =
01] add_size 1000
[    1.255534] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 01] add_size 200000 add_align 100000
[    1.255540] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] =
to [bus 01] add_size 200000 add_align 100000
[    1.255563] pci 0000:00:1c.0: res[14]=3D[mem 0x00100000-0x000fffff] res_=
to_dev_res add_size 200000 min_align 100000
[    1.255567] pci 0000:00:1c.0: res[14]=3D[mem 0x00100000-0x002fffff] res_=
to_dev_res add_size 200000 min_align 100000
[    1.255572] pci 0000:00:1c.0: res[15]=3D[mem 0x00100000-0x000fffff 64bit=
 pref] res_to_dev_res add_size 200000 min_align 100000
[    1.255577] pci 0000:00:1c.0: res[15]=3D[mem 0x00100000-0x002fffff 64bit=
 pref] res_to_dev_res add_size 200000 min_align 100000
[    1.255581] pci 0000:00:1c.0: res[13]=3D[io  0x1000-0x0fff] res_to_dev_r=
es add_size 1000 min_align 1000
[    1.255586] pci 0000:00:1c.0: res[13]=3D[io  0x1000-0x1fff] res_to_dev_r=
es add_size 1000 min_align 1000
[    1.255600] pci 0000:00:1c.0: BAR 14: assigned [mem 0x91500000-0x916ffff=
f]
[    1.255612] pci 0000:00:1c.0: BAR 15: assigned [mem 0x91700000-0x918ffff=
f 64bit pref]
[    1.255620] pci 0000:00:1c.0: BAR 13: assigned [io  0x3000-0x3fff]
[    1.255626] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.255632] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    1.255642] pci 0000:00:1c.0:   bridge window [mem 0x91500000-0x916fffff=
]
[    1.255650] pci 0000:00:1c.0:   bridge window [mem 0x91700000-0x918fffff=
 64bit pref]
[    1.255662] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    1.255667] pci 0000:00:1c.2:   bridge window [io  0x1000-0x1fff]
[    1.255676] pci 0000:00:1c.2:   bridge window [mem 0x91100000-0x911fffff=
]
[    1.255684] pci 0000:00:1c.2:   bridge window [mem 0x91000000-0x910fffff=
 64bit pref]
[    1.255696] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
[    1.255701] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
[    1.255724] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
[    1.255728] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    1.255732] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff windo=
w]
[    1.255735] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff windo=
w]
[    1.255739] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff wind=
ow]
[    1.255743] pci_bus 0000:00: resource 11 [mem 0x80000000-0xdfffffff wind=
ow]
[    1.255747] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[    1.255751] pci_bus 0000:01: resource 1 [mem 0x91500000-0x916fffff]
[    1.255755] pci_bus 0000:01: resource 2 [mem 0x91700000-0x918fffff 64bit=
 pref]
[    1.255759] pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
[    1.255763] pci_bus 0000:02: resource 1 [mem 0x91100000-0x911fffff]
[    1.255767] pci_bus 0000:02: resource 2 [mem 0x91000000-0x910fffff 64bit=
 pref]
[    1.256066] NET: Registered protocol family 2
[    1.256531] TCP established hash table entries: 65536 (order: 7, 524288 =
bytes)
[    1.256901] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.257295] TCP: Hash tables configured (established 65536 bind 65536)
[    1.257403] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.257542] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.257758] NET: Registered protocol family 1
[    1.257798] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    1.259838] PCI: CLS 64 bytes, default 64
[    1.259984] Unpacking initramfs...
[   12.915288] Freeing initrd memory: 327132K
[   12.915297] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   12.915304] software IO TLB [mem 0x764bf000-0x7a4bf000] (64MB) mapped at=
 [ffff93fdb64bf000-ffff93fdba4befff]
[   12.915594] Scanning for low memory corruption every 60 seconds
[   12.916679] audit: initializing netlink subsys (disabled)
[   12.916729] audit: type=3D2000 audit(1524464396.904:1): initialized
[   12.917420] [Xenomai] scheduling class idle registered.
[   12.917422] [Xenomai] scheduling class rt registered.
[   12.917480] [Xenomai] SMI-enabled chipset found, but SMI workaround disa=
bled
                         (see xenomai.smi parameter). You might encounter
                         high latencies!
[   12.918467] I-pipe: head domain Xenomai registered.
[   12.920801] [Xenomai] Cobalt v3.0.6 (Stellar Parallax)=20
[   12.920805] Initialise system trusted keyrings
[   12.921039] workingset: timestamp_bits=3D36 max_order=3D21 bucket_order=
=3D0
[   12.926710] zbud: loaded
[   12.928280] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   12.928809] fuse init (API version 7.26)
[   12.932995] Key type asymmetric registered
[   12.932998] Asymmetric key parser 'x509' registered
[   12.933141] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[   12.933237] io scheduler noop registered
[   12.933240] io scheduler deadline registered
[   12.933338] io scheduler cfq registered (default)
[   12.934073] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   12.934088] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[   12.934212] efifb: probing for efifb
[   12.934218] efifb: framebuffer at 0xa0000, using 64k, total 64k
[   12.934221] efifb: mode is 640x480x1, linelength=3D80, pages=3D1
[   12.934222] efifb: scrolling: redraw
[   12.934226] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[   12.937678] Console: switching to colour frame buffer device 80x30
[   12.940872] fb0: EFI VGA frame buffer device
[   12.941098] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:01/input/input0
[   12.941104] ACPI: Power Button [PWR2]
[   12.941244] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input1
[   12.941250] ACPI: Sleep Button [SLPB]
[   12.941368] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[   12.941374] ACPI: Power Button [PWRF]
[   12.941496] GHES: HEST is not enabled!
[   12.941696] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   12.946589] Linux agpgart interface v0.103
[   12.951755] loop: module loaded
[   12.952318] libphy: Fixed MDIO Bus: probed
[   12.952321] tun: Universal TUN/TAP device driver, 1.6
[   12.952323] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   12.952427] PPP generic driver version 2.4.2
[   12.952563] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   12.952572] ehci-pci: EHCI PCI platform driver
[   12.952604] ehci-platform: EHCI generic platform driver
[   12.952639] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   12.952645] ohci-pci: OHCI PCI platform driver
[   12.952668] ohci-platform: OHCI generic platform driver
[   12.952688] uhci_hcd: USB Universal Host Controller Interface driver
[   12.953162] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   12.953177] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[   12.954354] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x01509810
[   12.954368] xhci_hcd 0000:00:14.0: cache line size of 64 is not supporte=
d
[   12.954619] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[   12.954623] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   12.954627] usb usb1: Product: xHCI Host Controller
[   12.954630] usb usb1: Manufacturer: Linux 4.9.90-xenomai xhci-hcd
[   12.954633] usb usb1: SerialNumber: 0000:00:14.0
[   12.954981] hub 1-0:1.0: USB hub found
[   12.955016] hub 1-0:1.0: 7 ports detected
[   12.956601] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   12.956614] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[   12.956731] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[   12.956735] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   12.956739] usb usb2: Product: xHCI Host Controller
[   12.956742] usb usb2: Manufacturer: Linux 4.9.90-xenomai xhci-hcd
[   12.956745] usb usb2: SerialNumber: 0000:00:14.0
[   12.957068] hub 2-0:1.0: USB hub found
[   12.957097] hub 2-0:1.0: 6 ports detected
[   12.958783] i8042: PNP: No PS/2 controller found. Probing ports directly=
.
[   13.930145] tsc: Refined TSC clocksource calibration: 1599.948 MHz
[   13.930162] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x170=
ff3c37d3, max_idle_ns: 440795211487 ns
[   14.022145] i8042: No controller found
[   14.022413] mousedev: PS/2 mouse device common for all mice
[   14.022940] rtc_cmos 00:03: RTC can wake from S4
[   14.023281] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[   14.023331] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram
[   14.023348] i2c /dev entries driver
[   14.023535] device-mapper: uevent: version 1.0.3
[   14.023761] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised:=
 dm-devel@redhat.com
[   14.023862] ledtrig-cpu: registered to indicate activity on CPUs
[   14.024761] NET: Registered protocol family 17
[   14.024794] Key type dns_resolver registered
[   14.025501] microcode: sig=3D0x406c4, pf=3D0x1, revision=3D0x40a
[   14.025643] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.f=
snet.co.uk>, Peter Oruba
[   14.026151] registered taskstats version 1
[   14.026174] Loading compiled-in X.509 certificates
[   14.035654] Loaded X.509 cert 'Build time autogenerated kernel key: c492=
96fd12ce3f0ef222c034ec5e95a3df70daee'
[   14.035712] zswap: loaded using pool lzo/zbud
[   14.049683] Key type big_key registered
[   14.056572] Key type trusted registered
[   14.070181] Key type encrypted registered
[   14.070190] ima: No TPM chip found, activating TPM-bypass!
[   14.070271] evm: HMAC attrs: 0x1
[   14.071285]   Magic number: 14:620:317
[   14.071368] tty tty42: hash matches
[   14.071447] reg-dummy reg-dummy: hash matches
[   14.071571] rtc_cmos 00:03: setting system clock to 2018-04-23 06:19:58 =
UTC (1524464398)
[   14.071720] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[   14.071722] EDD information not available.
[   14.071961] PM: Hibernation image not present or could not be loaded.
[   14.078053] Freeing unused kernel memory: 2328K
[   14.078117] Write protecting the kernel read-only data: 14336k
[   14.079515] Freeing unused kernel memory: 1660K
[   14.083520] Freeing unused kernel memory: 592K
[   14.115312] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   14.153109] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[   14.153429] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[   14.153492] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[   14.155238] random: udevadm: uninitialized urandom read (16 bytes read)
[   14.155320] random: udevadm: uninitialized urandom read (16 bytes read)
[   14.178119] usb 1-2: new low-speed USB device number 2 using xhci_hcd
[   14.191967] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[   14.192091] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[   14.192124] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[   14.192889] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[   14.192959] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[   14.361336] sdhci: Secure Digital Host Controller Interface driver
[   14.361339] sdhci: Copyright(c) Pierre Ossman
[   14.372529] usb 1-2: New USB device found, idVendor=3D1a2c, idProduct=3D=
0c21
[   14.372535] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[   14.372538] usb 1-2: Product: USB Keyboard
[   14.372541] usb 1-2: Manufacturer: USB
[   14.390355] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[   14.399502] FUJITSU Extended Socket Network Device Driver - version 1.1 =
- Copyright (c) 2015 FUJITSU LIMITED
[   14.484761] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   14.484788] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[   14.489404] r8169 0000:02:00.0 eth0: RTL8168g/8111g at 0xffffa18c40d0500=
0, 00:c0:08:92:44:62, XID 0c000800 IRQ 310
[   14.489409] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200 bytes,=
 tx checksumming: ko]
[   14.533108] usb 1-3: new low-speed USB device number 3 using xhci_hcd
[   14.662195] [drm] Initialized
[   14.706523] usb 1-3: New USB device found, idVendor=3D046d, idProduct=3D=
c05a
[   14.706529] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[   14.706532] usb 1-3: Product: USB Optical Mouse
[   14.706536] usb 1-3: Manufacturer: Logitech
[   14.712467] mmc0: new HS200 MMC card at address 0001
[   14.821163] hidraw: raw HID events driver (C) Jiri Kosina
[   14.853592] usbcore: registered new interface driver usbhid
[   14.853595] usbhid: USB HID core driver
[   14.857654] r8169 0000:02:00.0 enp2s0: renamed from eth0
[   14.871624] input: USB USB Keyboard as /devices/pci0000:00/0000:00:14.0/=
usb1/1-2/1-2:1.0/0003:1A2C:0C21.0001/input/input3
[   14.923377] hid-generic 0003:1A2C:0C21.0001: input,hidraw0: USB HID v1.1=
0 Keyboard [USB USB Keyboard] on usb-0000:00:14.0-2/input0
[   14.923922] input: USB USB Keyboard as /devices/pci0000:00/0000:00:14.0/=
usb1/1-2/1-2:1.1/0003:1A2C:0C21.0002/input/input4
[   15.567083] clocksource: Switched to clocksource tsc
[   15.567654] hid-generic 0003:1A2C:0C21.0002: input,hidraw1: USB HID v1.1=
0 Mouse [USB USB Keyboard] on usb-0000:00:14.0-2/input1
[   15.568251] input: Logitech USB Optical Mouse as /devices/pci0000:00/000=
0:00:14.0/usb1/1-3/1-3:1.0/0003:046D:C05A.0003/input/input5
[   15.568550] hid-generic 0003:046D:C05A.0003: input,hidraw2: USB HID v1.1=
1 Mouse [Logitech USB Optical Mouse] on usb-0000:00:14.0-3/input0
[   15.574224] mmc1: SDHCI controller on ACPI [80860F14:01] using ADMA
[   15.574609] ahci 0000:00:13.0: version 3.0
[   15.575226] ahci 0000:00:13.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x=
3 impl SATA mode
[   15.575234] ahci 0000:00:13.0: flags: 64bit ncq led clo only pio slum pa=
rt deso sadm sds apst=20
[   15.576264] scsi host0: ahci
[   15.576622] scsi host1: ahci
[   15.576809] ata1: SATA max UDMA/133 abar m2048@0x9141e000 port 0x9141e10=
0 irq 311
[   15.576815] ata2: SATA max UDMA/133 abar m2048@0x9141e000 port 0x9141e18=
0 irq 311
[   15.581813] [drm] Memory usable by graphics device =3D 2048M
[   15.581819] checking generic (a0000 10000) vs hw (80000000 10000000)
[   15.581822] fb: switching to inteldrmfb from EFI VGA
[   15.581893] Console: switching to colour dummy device 80x25
[   15.582107] [drm] Replacing VGA console driver
[   15.582375] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   15.582377] [drm] Driver supports precise vblank timestamp query.
[   15.595253] mmcblk0: mmc0:0001 DF4032 29.1 GiB=20
[   15.595532] mmcblk0boot0: mmc0:0001 DF4032 partition 1 4.00 MiB
[   15.595798] mmcblk0boot1: mmc0:0001 DF4032 partition 2 4.00 MiB
[   15.596175] mmcblk0rpmb: mmc0:0001 DF4032 partition 3 4.00 MiB
[   15.597963] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[   15.616792]  mmcblk0: p1
[   15.630617] random: fast init done
[   15.716852] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[   15.718657] acpi device:2b: registered as cooling_device0
[   15.718877] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input6
[   15.719193] [drm] Initialized i915 1.6.0 20160919 for 0000:00:02.0 on mi=
nor 0
[   15.822557] fbcon: inteldrmfb (fb0) is primary device
[   15.891359] ata1: SATA link down (SStatus 0 SControl 300)
[   15.891398] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   15.957074] Console: switching to colour frame buffer device 210x65
[   15.983112] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[   20.969889] ata2.00: qc timeout (cmd 0x47)
[   20.970918] ata2.00: READ LOG DMA EXT failed, trying unqueued
[   20.970923] ata2.00: failed to get Log Directory Emask 0x40
[   20.970926] ata2.00: ATA-10: GOODRAM, V3.3, max UDMA/133
[   20.970930] ata2.00: 468862128 sectors, multi 0: LBA48 NCQ (depth 31/32)=
, AA
[   20.970941] ata2.00: failed to set xfermode (err_mask=3D0x40)
[   21.283167] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   21.283496] ata2.00: NCQ Send/Recv Log not supported
[   21.283866] ata2.00: NCQ Send/Recv Log not supported
[   21.283875] ata2.00: configured for UDMA/133
[   21.284332] scsi 1:0:0:0: Direct-Access     ATA      GOODRAM          V3=
.3 PQ: 0 ANSI: 5
[   21.310310] sd 1:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB=
/224 GiB)
[   21.310395] sd 1:0:0:0: Attached scsi generic sg0 type 0
[   21.310516] sd 1:0:0:0: [sda] Write Protect is off
[   21.310528] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   21.310596] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   21.311686]  sda: sda1
[   21.312563] sd 1:0:0:0: [sda] Attached SCSI disk
[   21.460968] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mo=
de. Opts: (null)
[   22.078969] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT=
 +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNU=
TLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[   22.079457] systemd[1]: Detected architecture x86-64.
[   22.079993] systemd[1]: Set hostname to <yeti-UDOO-x86>.
[   22.264970] systemd[1]: Created slice System Slice.
[   22.265126] systemd[1]: Reached target User and Group Name Lookups.
[   22.265160] systemd[1]: Reached target Remote File Systems (Pre).
[   22.265202] systemd[1]: Reached target Encrypted Volumes.
[   22.265429] systemd[1]: Created slice User and Session Slice.
[   22.265559] systemd[1]: Listening on Syslog Socket.
[   22.265652] systemd[1]: Listening on fsck to fsckd communication Socket.
[   22.420503] lp: driver loaded but no devices found
[   22.439570] ppdev: user-space parallel port driver
[   22.648902] EXT4-fs (mmcblk0p1): re-mounted. Opts: errors=3Dremount-ro
[   22.728593] systemd-journald[265]: Received request to flush runtime jou=
rnal from PID 1
[   23.425581] 8086228A:00: ttyS4 at MMIO 0x9141c000 (irq =3D 39, base_baud=
 =3D 2764800) is a 16550A
[   23.433308] 8086228A:01: ttyS5 at MMIO 0x9141a000 (irq =3D 40, base_baud=
 =3D 2764800) is a 16550A
[   23.465013] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[   23.571008] lpc_ich 0000:00:1f.0: No MFD cells added
[   23.655258] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   24.098428] r8169 0000:02:00.0 enp2s0: link down
[   24.100825] r8169 0000:02:00.0 enp2s0: link down
[   24.196362] SSE version of gcm_enc/dec engaged.
[   24.920491] intel_rapl: Found RAPL domain package
[   24.920498] intel_rapl: Found RAPL domain core
[   25.034743] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops i915_aud=
io_component_bind_ops [i915])
[   25.143032] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC283: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   25.143039] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[   25.143043] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[   25.143046] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[   25.143049] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   25.143053] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x19
[   25.326332] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0=
/sound/card0/input7
[   25.326800] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:0=
0:1b.0/sound/card0/input8
[   25.327118] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:00/=
0000:00:1b.0/sound/card0/input9
[   25.327423] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000:00/=
0000:00:1b.0/sound/card0/input10
[   25.327789] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000:00/=
0000:00:1b.0/sound/card0/input11
[   26.683024] r8169 0000:02:00.0 enp2s0: link up
[   27.157079] random: crng init done
[   54.701688] mm/pgtable-generic.c:21: bad pgd ffff93ffb26f8140(0276da6067=
000000)



=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- Original Message -----
From: "Greg Gallagher" <greg@embeddedgreg.com>
To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
Cc: "xenomai" <xenomai@xenomai.org>
Sent: =C2=EE=F1=EA=F0=E5=F1=E5=ED=FC=E5, 22 =C0=EF=F0=E5=EB=FC 2018 =E3 4:1=
9:30
Subject: Re: Unknown symbol in module

Can you show the output of uname -r and possibly show your boot messages.

On Sat, Apr 21, 2018 at 7:51 AM, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =
=C3=F0=E8=E3=EE=F0=FC=E5=E2=E8=F7
<shevchenko.taras@triolcorp.com.ua> wrote:
> Hi, Greg
> I try to compile modified RTnet driver , and include "rtnet_port.h"
> I succesfully get module  r8169_2015_1.ko file but if i try to load it in=
 a system by sudo insmod r8169_2015_1.ko
>
> I get following errors
>
> yeti@yeti-UDOO-x86:~/eth$ sudo insmod r8169_2015_1.ko
> insmod: ERROR: could not insert module r8169_2015_1.ko: Unknown symbol in=
 module
>
>
> logs  dmesg
>
> [101391.334742] r8169_2015: Unknown symbol __rt_alloc_etherdev (err 0)
> [101391.334791] r8169_2015: Unknown symbol rtnetdev_alloc_rtskb (err 0)
> [101391.334858] r8169_2015: Unknown symbol kfree_rtskb (err 0)
> [101391.334918] r8169_2015: Unknown symbol rtdev_free (err 0)
> [101391.334982] r8169_2015: Unknown symbol rt_register_rtnetdev (err 0)
> [101391.335028] r8169_2015: Unknown symbol STACK_manager (err 0)
> [101391.335528] r8169_2015: Unknown symbol RTDEV_manager (err 0)
> [101391.335566] r8169_2015: Unknown symbol rt_stack_connect (err 0)
> [101391.335609] r8169_2015: Unknown symbol rt_stack_disconnect (err 0)
> [101391.335651] r8169_2015: Unknown symbol rt_rtdev_connect (err 0)
> [101391.335683] r8169_2015: Unknown symbol rtskb_pool_release (err 0)
> [101391.335720] r8169_2015: Unknown symbol rtnetif_rx (err 0)
> [101391.335766] r8169_2015: Unknown symbol rt_eth_type_trans (err 0)
> [101391.335802] r8169_2015: Unknown symbol rt_unregister_rtnetdev (err 0)
> [101391.335849] r8169_2015: Unknown symbol rtdev_alloc_name (err 0)
> [101391.335882] r8169_2015: Unknown symbol rt_rtdev_disconnect (err 0)
>
> How i can fix this ?
>
> =D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=
=EE=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
> =D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.
>
> ----- =C8=F1=F5=EE=E4=ED=EE=E5 =F1=EE=EE=E1=F9=E5=ED=E8=E5 -----
> =CE=F2: "Greg Gallagher" <greg@embeddedgreg.com>
> =CA=EE=EC=F3: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=
=F0=FC=E5=E2=E8=F7" <shevchenko.taras@triolcorp.com.ua>
> =CA=EE=EF=E8=FF: "xenomai" <xenomai@xenomai.org>
> =CE=F2=EF=F0=E0=E2=EB=E5=ED=ED=FB=E5: =C2=F2=EE=F0=ED=E8=EA, 17 =C0=EF=F0=
=E5=EB=FC 2018 =E3 19:40:47
> =D2=E5=EC=E0: Re: [Xenomai] PCIe driver to communicate
>
> There no official documentation for doing this but if you google
> 'Xenomai PCI driver', you should find some third party example on how
> to do this.
>
> -Greg
>
> On Tue, Apr 17, 2018 at 9:56 AM, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1=
 =C3=F0=E8=E3=EE=F0=FC=E5=E2=E8=F7
> <shevchenko.taras@triolcorp.com.ua> wrote:
>> Hi!
>> I have to write PCIe driver to interchange with FPGA
>> Posiible someone do it before ? pls share with me or point me where to s=
tart ?
>> Thanks
>>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai

