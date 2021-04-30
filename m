References: <44426edd-947b-fcde-8b7d-fd08ae102f37@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: This 20-line Xenomai program crashes our servers
In-reply-to: <44426edd-947b-fcde-8b7d-fd08ae102f37@gmail.com>
Date: Fri, 30 Apr 2021 09:06:54 +0200
Message-ID: <87eees2qup.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Janssen <paulus947@gmail.com>
Cc: xenomai@xenomai.org


Paul Janssen via Xenomai <xenomai@xenomai.org> writes:

> Hello everybody,
>
> Our group has been using Xenomai for many years. Version 3.1 for the last few years.
> Recently we have run into a problem. Our main Xenomai program keeps crashing our servers.
> The servers crash because of "unable to handle kernel paging request" (see details down below).
>
> We have researched the issue for many weeks, and have reduced the Xenomai program to a 20-line program (see below) that still crashes our servers.
>
> The servers run forever if we do not run the Xenomai program. When we do start the Xenomai program, the server will crash within 2 hours. But often after just 5 to 30 minutes. We have tested extensively on three-or-four different servers. All machines crash, consistently, with the exact same error in the kernel log. When the computer crashes, there are no warnings messages, or anything on the computer screen. We usually follow the run with "top" and see everything suddenly freeze. This is the exact same behavior on all machines.
>
> But, when we replace the single "clock_nanosleep()" with "__real_clock_nanosleep()" in our test program, and leave everything else unchanged, including the compilation process, then all servers run forever and never crash. We can repeat this consistently, always. As you all know, prepending __real_ will cause the original Linux function to be called instead of the Xenomai "__wrap".
>
> We have used "sem_timedwait()" instead of "clock_nanosleep()" and experienced the exact same crash behavior. And here too, replacing the "sem_timedwait()" with "__real_sem_timedwait()" makes the machines run forever and they never crash.
>
> All this has convinced us that the problem is directly related to something in Xenomai, probably with clock/time related calls.
> We really hope that someone in the Xenomai community maybe knows about this problem, or can help us fix it.
> Thank you very much for looking at this.
>
> --Paul Janssen
>
> Test program "drvr.c":
>
>       1 #include <stdio.h>
>       2 #include <time.h>     // clock_nanosleep()
>       3
>       4 int main()
>       5 {
>       6     while( 1 )
>       7     {
>       8         // Sleep for 250,000 nsec
>       9         struct timespec ts;
>      10         ts.tv_nsec = 250000L;
>      11         ts.tv_sec = 0;
>      12
>      13         int err = clock_nanosleep( CLOCK_REALTIME, 0, &ts, NULL );
>      14         if( err != 0 )
>      15         {
>      16             printf( "clock_nanosleep failed\n" );
>      17             break; // exit
>      18         }
>      19     }
>      20
>      21     return 0;
>      22 }
>
> This single-file program has the following makefile:
>
>       1 .SUFFIXES: .c .h .o
>       2
>       3 drvr: drvr.o
>       4         gcc drvr.o -o $@ -pthread $(shell xeno-config --skin=posix --ldflags)
>       5         ls -al $@
>       6
>       7 drvr.o: drvr.c
>       8         gcc -c drvr.c -o $@ -O2 -Wall -Wextra -march=native -pthread $(shell xeno-config --skin=posix --cflags)
>       9
>      10 .PHONY: clean
>      11
>      12 clean:
>      13         rm -rf drvr drvr.o
>
>
> The output from make (compilation) is as follows:
>
> $ make
> gcc -c drvr.c -o drvr.o -O2 -Wall -Wextra -march=native -pthread -I/usr/include/xenomai/cobalt -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__ -D__COBALT_WRAP__
> gcc drvr.o -o drvr -pthread -Wl,--no-as-needed -Wl,@/usr/lib/cobalt.wrappers -Wl,@/usr/lib/modechk.wrappers  /usr/lib/xenomai/bootstrap.o -Wl,--wrap=main -Wl,--dynamic-list=/usr/lib/dynlist.ld -L/usr/lib -lcobalt -lmodechk -lpthread -lrt
>
>
> I have tried to include all information mentioned in the guidelines. The server crash log is at the bottom of this email. A full kernel log has been attached.
> One more noteworthy thing. All crash logs (/var/crash/...) on all computers always show the same crash information:
>
>   * BUG: unable to handle kernel paging request
>   * Oops: SMP PTI
>   * Comm: kworker/u24
>   * Workqueue: efi_rts_wq efi_call_rts
>
>
> Server Simhost007 Information:
>
> This is an Intel x86-64 Linux Ubuntu 18.04 w/Xenomai 3.1 system
> Processor is an Intel(R) Core(TM) i7-8700K CPU @ 3.70GHz
> Motherboard is a Supermicro Super Server/X11SCA, BIOS 1.4 09/03/2020
>
>
> $ uname -a
> Linux simhost007 4.19.177-cip44-xenomai-3.1 #1 SMP Tue Apr 20 15:49:12 CDT 2021 x86_64 x86_64 x86_64 GNU/Linux
>
>
> $ cat /proc/cmdline
> BOOT_IMAGE=/vmlinuz-4.19.177-cip44-xenomai-3.1 root=/dev/mapper/vg00-lv00 ro splash quiet drm_kms_helper.poll=0 nouveau.noaccel=1 pci=routeirq xenomai.allowed_group=997 crashkernel=384M-2G:64M,2G-:128M workqueue.power_efficient=0 crashkernel=512M-:192M vt.handoff=1
>
>
> $ /usr/sbin/version
> Xenomai/cobalt v3.1
>
>
> $ xeno-config --info | grep -i build
> Build args: --prefix=/usr --includedir=/usr/include/xenomai --mandir=/usr/share/man --with-testdir=/usr/lib/xenomai/testsuite --enable-smp --enable-lazy-setsched --enable-debug=symbols --enable-dlopen-libs --build x86_64-linux-gnu build_alias=x86_64-linux-gnu
>
>
> $ cat /proc/ipipe/version
> 17
>
>
> $ gcc --version
> gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
> Copyright (C) 2017 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
>
> $ xeno-config --skin=posix --cflags
> -I/usr/include/xenomai/cobalt -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__ -D__COBALT_WRAP__
>
>
> $ xeno-config --skin=posix --ldflags
> -Wl,--no-as-needed -Wl,@/usr/lib/cobalt.wrappers -Wl,@/usr/lib/modechk.wrappers  /usr/lib/xenomai/bootstrap.o -Wl,--wrap=main -Wl,--dynamic-list=/usr/lib/dynlist.ld -L/usr/lib -lcobalt -lmodechk -lpthread -lrt
>
>
> -------------------------------------------------------------------------------------------------
> From /proc/cpuinfo:
> ...
> processor       : 11
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 158
> model name      : Intel(R) Core(TM) i7-8700K CPU @ 3.70GHz
> stepping        : 10
> microcode       : 0xde
> cpu MHz         : 3698.671
> cache size      : 12288 KB
> physical id     : 0
> siblings        : 12
> core id         : 5
> cpu cores       : 6
> apicid          : 11
> initial apicid  : 11
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 22
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm arat pln pts md_clear flush_l1d
> bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs taa itlb_multihit srbds
> bogomips        : 7392.00
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 39 bits physical, 48 bits virtual
> power management:
>
>
> -------------------------------------------------------------------------------------------------
> From the kernel crash log: /var/crash/<timestamp>/dmesg.<timestamp>
> ...
> [ 4826.941554] BUG: unable to handle kernel paging request at fffffffeee7e3960
> [ 4826.941557] PGD 41940c067 P4D 41940c067 PUD 0
> [ 4826.941560] Oops: 0010 [#1] SMP PTI
> [ 4826.941562] CPU: 4 PID: 4619 Comm: kworker/u24:1 Kdump: loaded Not tainted 4.19.177-cip44-xenomai-3.1 #1
> [ 4826.941564] Hardware name: Supermicro Super Server/X11SCA, BIOS 1.4 09/03/2020
> [ 4826.941565] I-pipe domain: Linux
> [ 4826.941568] Workqueue: efi_rts_wq efi_call_rts
> [ 4826.941570] RIP: 0010:0xfffffffeee7e3960
> [ 4826.941573] Code: Bad RIP value.
> [ 4826.941574] RSP: 0018:ffffba3544ebfb98 EFLAGS: 00010286
> [ 4826.941575] RAX: fffffffeee66c96c RBX: fffffffeee66c96c RCX: fffffffeee66c96c
> [ 4826.941577] RDX: ffffa04b42cf7000 RSI: ffffba3544ebfc18 RDI: fffffffeee7eced0
> [ 4826.941578] RBP: ffffa04b42cf7400 R08: ffffa04b42cf7400 R09: ffffba3544ebfc18
> [ 4826.941579] R10: fffffffeee7eced0 R11: 0000000000000001 R12: ffffa04b42cf7000
> [ 4826.941580] R13: ffffba3544ebfcc8 R14: ffffba3544ebfcc0 R15: ffffba3544ebfd08
> [ 4826.941581] FS:  0000000000000000(0000) GS:ffffa04b4c100000(0000) knlGS:0000000000000000
> [ 4826.941583] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4826.941584] CR2: fffffffeee7e3936 CR3: 000000041940a005 CR4: 00000000003606e0
> [ 4826.941585] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4826.941586] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 4826.941587] Call Trace:
> [ 4826.941594]  ? x2apic_send_IPI+0x2e/0x30
> [ 4826.941597]  ? probe_sched_wakeup+0x35/0x40
> [ 4826.941600]  ? __switch_to_asm+0x41/0x70
> [ 4826.941602]  ? __switch_to_asm+0x41/0x70
> [ 4826.941604]  ? __switch_to_asm+0x41/0x70
> [ 4826.941606]  ? efi_call+0x58/0x90
> [ 4826.941608]  ? __switch_to_asm+0x41/0x70
> [ 4826.941611]  ? efi_call_rts+0x2ea/0x730
> [ 4826.941614]  ? process_one_work+0x1de/0x410
> [ 4826.941616]  ? worker_thread+0x34/0x400
> [ 4826.941619]  ? kthread+0x121/0x140
> [ 4826.941621]  ? set_worker_desc+0xb0/0xb0
> [ 4826.941622]  ? kthread_create_worker_on_cpu+0x70/0x70
> [ 4826.941624]  ? ret_from_fork+0x36/0x50
>
>
>
> -------------- next part --------------
> [    0.000000] microcode: microcode updated early to revision 0xde, date = 2020-05-25
> [    0.000000] Linux version 4.19.177-cip44-xenomai-3.1 (webb-ja@wd-webbja-lnx.ds.amrdec.army.mil) (gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)) #1 SMP Tue Apr 20 15:49:12 CDT 2021
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.19.177-cip44-xenomai-3.1 root=/dev/mapper/vg00-lv00 ro splash quiet drm_kms_helper.poll=0 nouveau.noaccel=1 pci=routeirq xenomai.allowed_group=997 crashkernel=384M-2G:64M,2G-:128M workqueue.power_efficient=0 crashkernel=512M-:192M vt.handoff=1
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Centaur CentaurHauls
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
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000005dfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000005e000-0x000000000005efff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000000005f000-0x000000000009ffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000872cafff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000872cb000-0x000000008aeccfff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000008aecd000-0x000000008b041fff] usable
> [    0.000000] BIOS-e820: [mem 0x000000008b042000-0x000000008b422fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000008b423000-0x000000008bc0efff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000008bc0f000-0x000000008bc0ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000008bc10000-0x000000008f7fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000086c7fffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] e820: update [mem 0x788fe018-0x7890e457] usable ==> usable
> [    0.000000] e820: update [mem 0x788fe018-0x7890e457] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000005dfff] usable
> [    0.000000] reserve setup_data: [mem 0x000000000005e000-0x000000000005efff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000000005f000-0x000000000009ffff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000788fe017] usable
> [    0.000000] reserve setup_data: [mem 0x00000000788fe018-0x000000007890e457] usable
> [    0.000000] reserve setup_data: [mem 0x000000007890e458-0x00000000872cafff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000872cb000-0x000000008aeccfff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000008aecd000-0x000000008b041fff] usable
> [    0.000000] reserve setup_data: [mem 0x000000008b042000-0x000000008b422fff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x000000008b423000-0x000000008bc0efff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000008bc0f000-0x000000008bc0ffff] usable
> [    0.000000] reserve setup_data: [mem 0x000000008bc10000-0x000000008f7fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000086c7fffff] usable
> [    0.000000] efi: EFI v2.70 by American Megatrends
> [    0.000000] efi:  ACPI 2.0=0x8b355000  ACPI=0x8b355000  SMBIOS=0x8b93a000  SMBIOS 3.0=0x8b939000  MEMATTR=0x832c2018  MPS=0xfcb80 
> [    0.000000] SMBIOS 3.2.0 present.
> [    0.000000] DMI: Supermicro Super Server/X11SCA, BIOS 1.4 09/03/2020
> [    0.000000] tsc: Detected 3700.000 MHz processor
> [    0.000007] tsc: Detected 3696.000 MHz TSC
> [    0.000007] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000008] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000013] last_pfn = 0x86c800 max_arch_pfn = 0x400000000
> [    0.000016] MTRR default type: write-back
> [    0.000017] MTRR fixed ranges enabled:
> [    0.000018]   00000-9FFFF write-back
> [    0.000018]   A0000-BFFFF uncachable
> [    0.000019]   C0000-FFFFF write-protect
> [    0.000020] MTRR variable ranges enabled:
> [    0.000021]   0 base 00C0000000 mask 7FC0000000 uncachable
> [    0.000022]   1 base 00A0000000 mask 7FE0000000 uncachable
> [    0.000023]   2 base 0090000000 mask 7FF0000000 uncachable
> [    0.000023]   3 base 008E000000 mask 7FFE000000 uncachable
> [    0.000024]   4 base 008D000000 mask 7FFF000000 uncachable
> [    0.000025]   5 base 2000000000 mask 6000000000 uncachable
> [    0.000025]   6 base 1000000000 mask 7000000000 uncachable
> [    0.000026]   7 base 4000000000 mask 4000000000 uncachable
> [    0.000026]   8 disabled
> [    0.000027]   9 disabled
> [    0.000834] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.000990] last_pfn = 0x8bc10 max_arch_pfn = 0x400000000
> [    0.006149] found SMP MP-table at [mem 0x000fce70-0x000fce7f]
> [    0.006161] Scanning 1 areas for low memory corruption
> [    0.006166] Using GB pages for direct mapping
> [    0.006488] Secure boot disabled
> [    0.006489] RAMDISK: [mem 0x3c4fb000-0x3fffdfff]
> [    0.006497] ACPI: Early table checksum verification disabled
> [    0.006499] ACPI: RSDP 0x000000008B355000 000024 (v02 SUPERM)
> [    0.006501] ACPI: XSDT 0x000000008B3550C0 000104 (v01 SUPERM SUPERM   01072009 AMI  00010013)
> [    0.006505] ACPI: FACP 0x000000008B393220 000114 (v06                 01072009 AMI  00010013)
> [    0.006508] ACPI: DSDT 0x000000008B355260 03DFBA (v02 SUPERM SMCI--MB 01072009 INTL 20160527)
> [    0.006511] ACPI: FACS 0x000000008B422F80 000040
> [    0.006512] ACPI: APIC 0x000000008B393338 0000F4 (v04                 01072009 AMI  00010013)
> [    0.006514] ACPI: FPDT 0x000000008B393430 000044 (v01                 01072009 AMI  00010013)
> [    0.006516] ACPI: FIDT 0x000000008B393478 00009C (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
> [    0.006518] ACPI: MCFG 0x000000008B393518 00003C (v01 SUPERM SMCI--MB 01072009 MSFT 00000097)
> [    0.006520] ACPI: SSDT 0x000000008B393558 001B26 (v02 CpuRef CpuSsdt  00003000 INTL 20160527)
> [    0.006522] ACPI: SSDT 0x000000008B395080 0031C6 (v02 SaSsdt SaSsdt   00003000 INTL 20160527)
> [    0.006524] ACPI: SSDT 0x000000008B398248 0026A5 (v02 PegSsd PegSsdt  00001000 INTL 20160527)
> [    0.006525] ACPI: HPET 0x000000008B39A8F0 000038 (v01 SUPERM SMCI--MB 00000002      01000013)
> [    0.006527] ACPI: SSDT 0x000000008B39A928 001CD5 (v02 SUPERM CflS_Rvp 00001000 INTL 20160527)
> [    0.006529] ACPI: SSDT 0x000000008B39C600 000FAE (v02 SUPERM Ther_Rvp 00001000 INTL 20160527)
> [    0.006531] ACPI: SSDT 0x000000008B39D5B0 002FCF (v02 INTEL  xh_cfsd4 00000000 INTL 20160527)
> [    0.006533] ACPI: UEFI 0x000000008B3A0580 000042 (v01 SUPERM SMCI--MB 00000002      01000013)
> [    0.006535] ACPI: LPIT 0x000000008B3A05C8 000094 (v01 SUPERM SMCI--MB 00000002      01000013)
> [    0.006537] ACPI: SSDT 0x000000008B3A0660 0027DE (v02 SUPERM PtidDevc 00001000 INTL 20160527)
> [    0.006539] ACPI: SSDT 0x000000008B3A2E40 0014E2 (v02 SUPERM TbtTypeC 00000000 INTL 20160527)
> [    0.006540] ACPI: DBGP 0x000000008B3A4328 000034 (v01 SUPERM SMCI--MB 00000002      01000013)
> [    0.006542] ACPI: DBG2 0x000000008B3A4360 000054 (v00 SUPERM SMCI--MB 00000002      01000013)
> [    0.006544] ACPI: SSDT 0x000000008B3A43B8 001B67 (v02 SUPERM UsbCTabl 00001000 INTL 20160527)
> [    0.006546] ACPI: SSDT 0x000000008B3A5F20 000144 (v02 Intel  ADebTabl 00001000 INTL 20160527)
> [    0.006548] ACPI: BGRT 0x000000008B3A6068 000038 (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
> [    0.006550] ACPI: ASF! 0x000000008B3A60A0 000074 (v32 SUPERM SMCI--MB 00000002      01000013)
> [    0.006551] ACPI: DMAR 0x000000008B3A6118 0000C8 (v01 INTEL  EDK2     00000002      01000013)
> [    0.006553] ACPI: WSMT 0x000000008B3A61E0 000028 (v01 \xfffffff7x              01072009 AMI  00010013)
> [    0.006555] ACPI: EINJ 0x000000008B3A6208 000130 (v01 AMI    AMI.EINJ 00000000 AMI. 00000000)
> [    0.006557] ACPI: ERST 0x000000008B3A6338 000230 (v01 AMIER  AMI.ERST 00000000 AMI. 00000000)
> [    0.006559] ACPI: BERT 0x000000008B3A6568 000030 (v01 AMI    AMI.BERT 00000000 AMI. 00000000)
> [    0.006561] ACPI: HEST 0x000000008B3A6598 00027C (v01 AMI    AMI.HEST 00000000 AMI. 00000000)
> [    0.006566] ACPI: Local APIC address 0xfee00000
> [    0.006885] No NUMA configuration found
> [    0.006886] Faking a node at [mem 0x0000000000000000-0x000000086c7fffff]
> [    0.006891] NODE_DATA(0) allocated [mem 0x86c7de000-0x86c7fffff]
> [    0.006901] Reserving 192MB of memory at 704MB for crashkernel (System RAM: 32571MB)
> [    0.006919] Zone ranges:
> [    0.006919]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.006920]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.006921]   Normal   [mem 0x0000000100000000-0x000000086c7fffff]
> [    0.006922] Movable zone start for each node
> [    0.006924] Early memory node ranges
> [    0.006925]   node   0: [mem 0x0000000000001000-0x000000000005dfff]
> [    0.006926]   node   0: [mem 0x000000000005f000-0x000000000009ffff]
> [    0.006926]   node   0: [mem 0x0000000000100000-0x00000000872cafff]
> [    0.006927]   node   0: [mem 0x000000008aecd000-0x000000008b041fff]
> [    0.006927]   node   0: [mem 0x000000008bc0f000-0x000000008bc0ffff]
> [    0.006928]   node   0: [mem 0x0000000100000000-0x000000086c7fffff]
> [    0.007493] Zeroed struct page in unavailable ranges: 50209 pages
> [    0.007494] Initmem setup node 0 [mem 0x0000000000001000-0x000000086c7fffff]
> [    0.007495] On node 0 totalpages: 8338399
> [    0.007496]   DMA zone: 64 pages used for memmap
> [    0.007496]   DMA zone: 24 pages reserved
> [    0.007497]   DMA zone: 3998 pages, LIFO batch:0
> [    0.007560]   DMA32 zone: 8594 pages used for memmap
> [    0.007560]   DMA32 zone: 549953 pages, LIFO batch:63
> [    0.017997]   Normal zone: 121632 pages used for memmap
> [    0.017998]   Normal zone: 7784448 pages, LIFO batch:63
> [    0.130744] Reserving Intel graphics memory at [mem 0x8d800000-0x8f7fffff]
> [    0.131605] ACPI: PM-Timer IO Port: 0x1808
> [    0.131606] ACPI: Local APIC address 0xfee00000
> [    0.131611] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.131612] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.131612] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.131613] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.131614] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
> [    0.131614] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
> [    0.131615] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
> [    0.131615] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
> [    0.131616] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
> [    0.131616] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
> [    0.131617] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
> [    0.131617] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
> [    0.131681] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> [    0.131682] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.131684] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.131684] ACPI: IRQ0 used by override.
> [    0.131685] ACPI: IRQ9 used by override.
> [    0.131687] Using ACPI (MADT) for SMP configuration information
> [    0.131688] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.131693] e820: update [mem 0x828c6000-0x82b06fff] usable ==> reserved
> [    0.131700] TSC deadline timer available
> [    0.131700] smpboot: Allowing 12 CPUs, 0 hotplug CPUs
> [    0.131711] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.131712] PM: Registered nosave memory: [mem 0x0005e000-0x0005efff]
> [    0.131713] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    0.131714] PM: Registered nosave memory: [mem 0x788fe000-0x788fefff]
> [    0.131715] PM: Registered nosave memory: [mem 0x7890e000-0x7890efff]
> [    0.131716] PM: Registered nosave memory: [mem 0x828c6000-0x82b06fff]
> [    0.131717] PM: Registered nosave memory: [mem 0x872cb000-0x8aeccfff]
> [    0.131718] PM: Registered nosave memory: [mem 0x8b042000-0x8b422fff]
> [    0.131719] PM: Registered nosave memory: [mem 0x8b423000-0x8bc0efff]
> [    0.131720] PM: Registered nosave memory: [mem 0x8bc10000-0x8f7fffff]
> [    0.131720] PM: Registered nosave memory: [mem 0x8f800000-0xdfffffff]
> [    0.131721] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
> [    0.131721] PM: Registered nosave memory: [mem 0xf0000000-0xfdffffff]
> [    0.131722] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
> [    0.131722] PM: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
> [    0.131722] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [    0.131723] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
> [    0.131723] PM: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
> [    0.131724] PM: Registered nosave memory: [mem 0xfed04000-0xfedfffff]
> [    0.131724] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.131725] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
> [    0.131725] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
> [    0.131727] [mem 0x8f800000-0xdfffffff] available for PCI devices
> [    0.131729] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.131738] random: get_random_bytes called from start_kernel+0x95/0x527 with crng_init=0
> [    0.131743] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:12 nr_node_ids:1
> [    0.131968] percpu: Embedded 64 pages/cpu s225280 r8192 d28672 u262144
> [    0.131972] pcpu-alloc: s225280 r8192 d28672 u262144 alloc=1*2097152
> [    0.131973] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- -- -- -- 
> [    0.131986] Built 1 zonelists, mobility grouping on.  Total pages: 8208085
> [    0.131987] Policy zone: Normal
> [    0.131988] Kernel command line: BOOT_IMAGE=/vmlinuz-4.19.177-cip44-xenomai-3.1 root=/dev/mapper/vg00-lv00 ro splash quiet drm_kms_helper.poll=0 nouveau.noaccel=1 pci=routeirq xenomai.allowed_group=997 crashkernel=384M-2G:64M,2G-:128M workqueue.power_efficient=0 crashkernel=512M-:192M vt.handoff=1
> [    0.134495] Calgary: detecting Calgary via BIOS EBDA area
> [    0.134496] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
> [    0.184895] Memory: 32461600K/33353596K available (12300K kernel code, 1445K rwdata, 3936K rodata, 1812K init, 2764K bss, 891996K reserved, 0K cma-reserved)
> [    0.184968] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
> [    0.184972] Kernel/User page tables isolation: enabled
> [    0.191516] rcu: Hierarchical RCU implementation.
> [    0.191516] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=12.
> [    0.191517] 	Tasks RCU enabled.
> [    0.191518] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=12
> [    0.193408] NR_IRQS: 4352, nr_irqs: 2152, preallocated irqs: 16
> [    0.194003] Interrupt pipeline (release #17)
> [    0.194027] Console: colour dummy device 80x25
> [    0.194030] console [tty0] enabled
> [    0.194039] ACPI: Core revision 20180810
> [    0.194481] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
> [    0.194552] hpet clockevent registered
> [    0.194595] APIC: Switch to symmetric I/O mode setup
> [    0.194596] DMAR: Host address width 39
> [    0.194597] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> [    0.194601] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
> [    0.194602] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> [    0.194604] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
> [    0.194605] DMAR: RMRR base: 0x0000008b6ac000 end: 0x0000008b8f5fff
> [    0.194606] DMAR: RMRR base: 0x0000008d000000 end: 0x0000008f7fffff
> [    0.194606] DMAR: RMRR base: 0x0000008ae4c000 end: 0x0000008aecbfff
> [    0.194608] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> [    0.194608] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> [    0.194609] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> [    0.197700] DMAR-IR: Enabled IRQ remapping in x2apic mode
> [    0.197701] x2apic enabled
> [    0.197731] Switched APIC routing to cluster x2apic.
> [    0.206960] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.226578] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6a8d280fdb9, max_idle_ns: 881591151302 ns
> [    0.226579] Calibrating delay loop (skipped), value calculated using timer frequency.. 7392.00 BogoMIPS (lpj=14784000)
> [    0.226581] pid_max: default: 32768 minimum: 301
> [    0.227884] Security Framework initialized
> [    0.227885] Yama: becoming mindful.
> [    0.227900] AppArmor: AppArmor initialized
> [    0.230717] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
> [    0.232127] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
> [    0.232178] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
> [    0.232222] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
> [    0.232367] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.232368] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
> [    0.232388] CPU0: Thermal monitoring enabled (TM1)
> [    0.232406] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [    0.232407] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> [    0.232408] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.232409] Spectre V2 : Mitigation: Full generic retpoline
> [    0.232410] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.232410] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [    0.232411] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.232412] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
> [    0.232413] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> [    0.232414] TAA: Mitigation: Clear CPU buffers
> [    0.232416] SRBDS: Mitigation: Microcode
> [    0.232417] MDS: Mitigation: Clear CPU buffers
> [    0.237252] Freeing SMP alternatives memory: 36K
> [    0.238867] smpboot: CPU0: Intel(R) Core(TM) i7-8700K CPU @ 3.70GHz (family: 0x6, model: 0x9e, stepping: 0xa)
> [    0.238922] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    0.238944] ... version:                4
> [    0.238945] ... bit width:              48
> [    0.238945] ... generic registers:      4
> [    0.238946] ... value mask:             0000ffffffffffff
> [    0.238946] ... max period:             00007fffffffffff
> [    0.238947] ... fixed-purpose events:   3
> [    0.238947] ... event mask:             000000070000000f
> [    0.238979] rcu: Hierarchical SRCU implementation.
> [    0.239971] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.240031] smp: Bringing up secondary CPUs ...
> [    0.240077] x86: Booting SMP configuration:
> [    0.240078] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6
> [    0.248233] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> [    0.248233] TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.
> [    0.248233]   #7  #8  #9 #10 #11
> [    0.251046] smp: Brought up 1 node, 12 CPUs
> [    0.251046] smpboot: Max logical packages: 1
> [    0.251046] smpboot: Total of 12 processors activated (88704.00 BogoMIPS)
> [    0.255418] devtmpfs: initialized
> [    0.255418] x86/mm: Memory block size: 128MB
> [    0.258888] PM: Registering ACPI NVS region [mem 0x8b042000-0x8b422fff] (4067328 bytes)
> [    0.258888] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.258888] futex hash table entries: 4096 (order: 6, 262144 bytes)
> [    0.258888] pinctrl core: initialized pinctrl subsystem
> [    0.258888] RTC time: 22:35:29, date: 04/27/21
> [    0.258955] NET: Registered protocol family 16
> [    0.259048] audit: initializing netlink subsys (disabled)
> [    0.259052] audit: type=2000 audit(1619562929.056:1): state=initialized audit_enabled=0 res=1
> [    0.259052] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.259052] ACPI: bus type PCI registered
> [    0.259052] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.259052] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> [    0.259052] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
> [    0.259052] PCI: Using configuration type 1 for base access
> [    0.259689] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.259689] ACPI: Added _OSI(Module Device)
> [    0.259689] ACPI: Added _OSI(Processor Device)
> [    0.259689] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.259689] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.259689] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.259689] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.345371] ACPI: 11 ACPI AML tables successfully acquired and loaded
> [    0.364011] ACPI: Interpreter enabled
> [    0.364043] ACPI: (supports S0 S3 S4 S5)
> [    0.364044] ACPI: Using IOAPIC for interrupt routing
> [    0.364078] HEST: Enabling Firmware First mode for corrected errors.
> [    0.364131] mce: [Firmware Bug]: Ignoring request to disable invalid MCA bank 12.
> [    0.364132] mce: [Firmware Bug]: Ignoring request to disable invalid MCA bank 13.
> [    0.364132] mce: [Firmware Bug]: Ignoring request to disable invalid MCA bank 14.
> [    0.364150] HEST: Table parsing has been initialized.
> [    0.364152] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.365763] ACPI: Enabled 9 GPEs in block 00 to 7F
> [    0.383688] ACPI: Power Resource [USBC] (on)
> [    0.383878] ACPI: Power Resource [PAUD] (on)
> [    0.387795] ACPI: Power Resource [SPR0] (off)
> [    0.388045] ACPI: Power Resource [SPR1] (off)
> [    0.388419] ACPI: Power Resource [ZPDR] (off)
> [    0.388705] ACPI: Power Resource [SPR3] (off)
> [    0.389077] ACPI: Power Resource [V0PR] (on)
> [    0.389531] ACPI: Power Resource [V1PR] (on)
> [    0.389984] ACPI: Power Resource [V2PR] (on)
> [    0.395606] ACPI: Power Resource [PXTC] (on)
> [    0.402063] ACPI: Power Resource [WRST] (on)
> [    0.408426] ACPI: Power Resource [FN00] (off)
> [    0.408540] ACPI: Power Resource [FN01] (off)
> [    0.408650] ACPI: Power Resource [FN02] (off)
> [    0.408757] ACPI: Power Resource [FN03] (off)
> [    0.408864] ACPI: Power Resource [FN04] (off)
> [    0.409840] ACPI: Power Resource [PIN] (off)
> [    0.410039] ACPI: Power Resource [SPR2] (off)
> [    0.410100] ACPI: Power Resource [SPR5] (off)
> [    0.410593] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> [    0.410599] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    0.412518] acpi PNP0A08:00: _OSC: platform does not support [AER]
> [    0.416095] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [    0.416095] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    0.417408] PCI host bridge to bus 0000:00
> [    0.417410] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.417411] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.417411] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.417412] pci_bus 0000:00: root bus resource [mem 0x8f800000-0xdfffffff window]
> [    0.417413] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
> [    0.417414] pci_bus 0000:00: root bus resource [bus 00-fe]
> [    0.417420] pci 0000:00:00.0: [8086:3ec2] type 00 class 0x060000
> [    0.417842] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
> [    0.417880] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> [    0.418083] pci 0000:00:01.1: [8086:1905] type 01 class 0x060400
> [    0.418119] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
> [    0.418385] pci 0000:00:02.0: [8086:3e92] type 00 class 0x030000
> [    0.418393] pci 0000:00:02.0: reg 0x10: [mem 0xa1000000-0xa1ffffff 64bit]
> [    0.418397] pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
> [    0.418400] pci 0000:00:02.0: reg 0x20: [io  0x4000-0x403f]
> [    0.418413] pci 0000:00:02.0: BAR 2: assigned to efifb
> [    0.418615] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
> [    0.418624] pci 0000:00:08.0: reg 0x10: [mem 0xa2341000-0xa2341fff 64bit]
> [    0.418881] pci 0000:00:12.0: [8086:a379] type 00 class 0x118000
> [    0.418930] pci 0000:00:12.0: reg 0x10: [mem 0xa2340000-0xa2340fff 64bit]
> [    0.419302] pci 0000:00:14.0: [8086:a36d] type 00 class 0x0c0330
> [    0.419352] pci 0000:00:14.0: reg 0x10: [mem 0xa2320000-0xa232ffff 64bit]
> [    0.419509] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.419972] pci 0000:00:14.2: [8086:a36f] type 00 class 0x050000
> [    0.420012] pci 0000:00:14.2: reg 0x10: [mem 0xa2336000-0xa2337fff 64bit]
> [    0.420033] pci 0000:00:14.2: reg 0x18: [mem 0xa233f000-0xa233ffff 64bit]
> [    0.420415] pci 0000:00:15.0: [8086:a368] type 00 class 0x0c8000
> [    0.421105] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> [    0.423153] pci 0000:00:15.1: [8086:a369] type 00 class 0x0c8000
> [    0.423698] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> [    0.425479] pci 0000:00:16.0: [8086:a360] type 00 class 0x078000
> [    0.425525] pci 0000:00:16.0: reg 0x10: [mem 0xa233c000-0xa233cfff 64bit]
> [    0.425673] pci 0000:00:16.0: PME# supported from D3hot
> [    0.425990] pci 0000:00:17.0: [8086:a352] type 00 class 0x010601
> [    0.426032] pci 0000:00:17.0: reg 0x10: [mem 0xa2334000-0xa2335fff]
> [    0.426048] pci 0000:00:17.0: reg 0x14: [mem 0xa233b000-0xa233b0ff]
> [    0.426065] pci 0000:00:17.0: reg 0x18: [io  0x4090-0x4097]
> [    0.426081] pci 0000:00:17.0: reg 0x1c: [io  0x4080-0x4083]
> [    0.426097] pci 0000:00:17.0: reg 0x20: [io  0x4060-0x407f]
> [    0.426114] pci 0000:00:17.0: reg 0x24: [mem 0xa233a000-0xa233a7ff]
> [    0.426220] pci 0000:00:17.0: PME# supported from D3hot
> [    0.426494] pci 0000:00:1c.0: [8086:a338] type 01 class 0x060400
> [    0.426719] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.426756] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
> [    0.427047] pci 0000:00:1c.5: [8086:a33d] type 01 class 0x060400
> [    0.427260] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
> [    0.427296] pci 0000:00:1c.5: PTM enabled (root), 4ns granularity
> [    0.427554] pci 0000:00:1c.7: [8086:a33f] type 01 class 0x060400
> [    0.427776] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
> [    0.427810] pci 0000:00:1c.7: PTM enabled (root), 4ns granularity
> [    0.428314] pci 0000:00:1e.0: [8086:a328] type 00 class 0x078000
> [    0.429043] pci 0000:00:1e.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> [    0.431591] pci 0000:00:1f.0: [8086:a309] type 00 class 0x060100
> [    0.432065] pci 0000:00:1f.3: [8086:a348] type 00 class 0x040300
> [    0.432154] pci 0000:00:1f.3: reg 0x10: [mem 0xa2330000-0xa2333fff 64bit]
> [    0.432254] pci 0000:00:1f.3: reg 0x20: [mem 0xa2000000-0xa20fffff 64bit]
> [    0.432431] pci 0000:00:1f.3: PME# supported from D3hot D3cold
> [    0.433218] pci 0000:00:1f.4: [8086:a323] type 00 class 0x0c0500
> [    0.433391] pci 0000:00:1f.4: reg 0x10: [mem 0xa2338000-0xa23380ff 64bit]
> [    0.433606] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
> [    0.434018] pci 0000:00:1f.5: [8086:a324] type 00 class 0x0c8000
> [    0.434048] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
> [    0.434329] pci 0000:00:1f.6: [8086:15bb] type 00 class 0x020000
> [    0.434393] pci 0000:00:1f.6: reg 0x10: [mem 0xa2300000-0xa231ffff]
> [    0.434658] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
> [    0.434861] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.434900] pci 0000:02:00.0: [12d8:e113] type 01 class 0x060400
> [    0.434983] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> [    0.435041] pci 0000:00:01.1: PCI bridge to [bus 02-03]
> [    0.435043] pci 0000:00:01.1:   bridge window [mem 0xa2200000-0xa22fffff]
> [    0.435066] pci_bus 0000:03: extended config space not accessible
> [    0.435080] pci 0000:03:00.0: [5744:474e] type 00 class 0x110000
> [    0.435095] pci 0000:03:00.0: reg 0x10: [mem 0xa2200000-0xa220ffff]
> [    0.435204] pci 0000:02:00.0: PCI bridge to [bus 03]
> [    0.435209] pci 0000:02:00.0:   bridge window [mem 0xa2200000-0xa22fffff]
> [    0.435341] pci 0000:00:1c.0: PCI bridge to [bus 04]
> [    0.435543] pci 0000:05:00.0: [8086:1533] type 00 class 0x020000
> [    0.435605] pci 0000:05:00.0: reg 0x10: [mem 0xa2100000-0xa217ffff]
> [    0.435646] pci 0000:05:00.0: reg 0x18: [io  0x3000-0x301f]
> [    0.435663] pci 0000:05:00.0: reg 0x1c: [mem 0xa2180000-0xa2183fff]
> [    0.435849] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> [    0.436018] pci 0000:00:1c.5: PCI bridge to [bus 05]
> [    0.436021] pci 0000:00:1c.5:   bridge window [io  0x3000-0x3fff]
> [    0.436025] pci 0000:00:1c.5:   bridge window [mem 0xa2100000-0xa21fffff]
> [    0.436157] pci 0000:06:00.0: [10e3:8113] type 01 class 0x060401
> [    0.436334] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.436393] pci 0000:00:1c.7: PCI bridge to [bus 06-07]
> [    0.436464] pci_bus 0000:07: extended config space not accessible
> [    0.436566] pci 0000:06:00.0: PCI bridge to [bus 07] (subtractive decode)
> [    0.438627] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    0.438718] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *1
> [    0.438806] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    0.438894] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    0.438981] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    0.439069] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    0.439156] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    0.439244] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0
> [    0.440606] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.440606] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    0.440606] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.440606] vgaarb: loaded
> [    0.440606] SCSI subsystem initialized
> [    0.440606] libata version 3.00 loaded.
> [    0.440606] ACPI: bus type USB registered
> [    0.440606] usbcore: registered new interface driver usbfs
> [    0.440606] usbcore: registered new interface driver hub
> [    0.440606] usbcore: registered new device driver usb
> [    0.440606] pps_core: LinuxPPS API ver. 1 registered
> [    0.440606] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.440606] PTP clock support registered
> [    0.440606] EDAC MC: Ver: 3.0.0
> [    0.440606] Registered efivars operations
> [    0.440606] PCI: Using ACPI for IRQ routing
> [    0.440606] PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
> [    0.524245] PCI: pci_cache_line_size set to 64 bytes
> [    0.524553] e820: reserve RAM buffer [mem 0x0005e000-0x0005ffff]
> [    0.524554] e820: reserve RAM buffer [mem 0x788fe018-0x7bffffff]
> [    0.524555] e820: reserve RAM buffer [mem 0x828c6000-0x83ffffff]
> [    0.524556] e820: reserve RAM buffer [mem 0x872cb000-0x87ffffff]
> [    0.524556] e820: reserve RAM buffer [mem 0x8b042000-0x8bffffff]
> [    0.524557] e820: reserve RAM buffer [mem 0x8bc10000-0x8bffffff]
> [    0.524558] e820: reserve RAM buffer [mem 0x86c800000-0x86fffffff]
> [    0.524618] NetLabel: Initializing
> [    0.524619] NetLabel:  domain hash size = 128
> [    0.524619] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.524631] NetLabel:  unlabeled traffic allowed by default
> [    0.524641] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [    0.524641] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
> [    0.527623] clocksource: Switched to clocksource tsc-early
> [    0.533540] VFS: Disk quotas dquot_6.6.0
> [    0.533540] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.533540] AppArmor: AppArmor Filesystem Enabled
> [    0.533540] pnp: PnP ACPI init
> [    0.534589] system 00:00: [mem 0x40000000-0x403fffff] could not be reserved
> [    0.534592] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.534714] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.535151] system 00:02: [io  0x0a00-0x0a1f] has been reserved
> [    0.535152] system 00:02: [io  0x0a20-0x0a2f] has been reserved
> [    0.535153] system 00:02: [io  0x0a30-0x0a3f] has been reserved
> [    0.535154] system 00:02: [io  0x0a40-0x0a4f] has been reserved
> [    0.535156] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.535667] pnp 00:03: [dma 0 disabled]
> [    0.535699] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
> [    0.535838] system 00:04: [io  0x0680-0x069f] has been reserved
> [    0.535839] system 00:04: [io  0x164e-0x164f] has been reserved
> [    0.535841] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.535962] system 00:05: [io  0x1854-0x1857] has been reserved
> [    0.535965] system 00:05: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
> [    0.536218] system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
> [    0.536219] system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
> [    0.536220] system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
> [    0.536221] system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
> [    0.536222] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.536223] system 00:06: [mem 0xfed90000-0xfed93fff] could not be reserved
> [    0.536224] system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
> [    0.536225] system 00:06: [mem 0xfee00000-0xfeefffff] could not be reserved
> [    0.536228] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.536455] system 00:07: [io  0x1800-0x18fe] could not be reserved
> [    0.536456] system 00:07: [mem 0xfd000000-0xfd69ffff] has been reserved
> [    0.536457] system 00:07: [mem 0xfd6c0000-0xfd6cffff] has been reserved
> [    0.536458] system 00:07: [mem 0xfd6f0000-0xfdffffff] has been reserved
> [    0.536459] system 00:07: [mem 0xfe000000-0xfe01ffff] could not be reserved
> [    0.536460] system 00:07: [mem 0xfe200000-0xfe7fffff] has been reserved
> [    0.536461] system 00:07: [mem 0xff000000-0xffffffff] has been reserved
> [    0.536464] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.536770] system 00:08: [io  0x2000-0x20fe] has been reserved
> [    0.536772] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.538101] system 00:09: [mem 0xfd6e0000-0xfd6effff] has been reserved
> [    0.538102] system 00:09: [mem 0xfd6d0000-0xfd6dffff] has been reserved
> [    0.538103] system 00:09: [mem 0xfd6b0000-0xfd6bffff] has been reserved
> [    0.538104] system 00:09: [mem 0xfd6a0000-0xfd6affff] has been reserved
> [    0.538107] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.539387] pnp: PnP ACPI: found 10 devices
> [    0.544805] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.544815] pci 0000:00:15.0: BAR 0: assigned [mem 0x8f800000-0x8f800fff 64bit]
> [    0.544975] pci 0000:00:15.1: BAR 0: assigned [mem 0x8f801000-0x8f801fff 64bit]
> [    0.545245] pci 0000:00:1e.0: BAR 0: assigned [mem 0x8f802000-0x8f802fff 64bit]
> [    0.545400] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.545405] pci 0000:02:00.0: PCI bridge to [bus 03]
> [    0.545408] pci 0000:02:00.0:   bridge window [mem 0xa2200000-0xa22fffff]
> [    0.545414] pci 0000:00:01.1: PCI bridge to [bus 02-03]
> [    0.545416] pci 0000:00:01.1:   bridge window [mem 0xa2200000-0xa22fffff]
> [    0.545419] pci 0000:00:1c.0: PCI bridge to [bus 04]
> [    0.545438] pci 0000:00:1c.5: PCI bridge to [bus 05]
> [    0.545439] pci 0000:00:1c.5:   bridge window [io  0x3000-0x3fff]
> [    0.545442] pci 0000:00:1c.5:   bridge window [mem 0xa2100000-0xa21fffff]
> [    0.545446] pci 0000:06:00.0: PCI bridge to [bus 07]
> [    0.545469] pci 0000:00:1c.7: PCI bridge to [bus 06-07]
> [    0.545491] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.545491] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.545492] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.545493] pci_bus 0000:00: resource 7 [mem 0x8f800000-0xdfffffff window]
> [    0.545494] pci_bus 0000:00: resource 8 [mem 0xfc800000-0xfe7fffff window]
> [    0.545495] pci_bus 0000:02: resource 1 [mem 0xa2200000-0xa22fffff]
> [    0.545496] pci_bus 0000:03: resource 1 [mem 0xa2200000-0xa22fffff]
> [    0.545497] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
> [    0.545497] pci_bus 0000:05: resource 1 [mem 0xa2100000-0xa21fffff]
> [    0.545689] NET: Registered protocol family 2
> [    0.545785] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes)
> [    0.545855] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
> [    0.546109] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> [    0.546183] TCP: Hash tables configured (established 262144 bind 65536)
> [    0.546214] UDP hash table entries: 16384 (order: 7, 524288 bytes)
> [    0.546266] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
> [    0.546347] NET: Registered protocol family 1
> [    0.546359] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.546717] PCI: CLS 64 bytes, default 64
> [    0.546739] Unpacking initramfs...
> [    1.142562] Freeing initrd memory: 60428K
> [    1.170600] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    1.170602] software IO TLB: mapped [mem 0x7e8c6000-0x828c6000] (64MB)
> [    1.170808] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6a8d280fdb9, max_idle_ns: 881591151302 ns
> [    1.170824] clocksource: Switched to clocksource tsc
> [    1.170848] platform rtc_cmos: registered platform RTC device (no PNP device found)
> [    1.170974] Scanning for low memory corruption every 60 seconds
> [    1.171463] [Xenomai] scheduling class idle registered.
> [    1.171464] [Xenomai] scheduling class rt registered.
> [    1.171482] [Xenomai] SMI-enabled chipset found, but SMI workaround disabled
>                          (see xenomai.smi parameter). You might encounter
>                          high latencies!
> [    1.171508] I-pipe: head domain Xenomai registered.
> [    1.172190] [Xenomai] allowing access to group 997
> [    1.172203] [Xenomai] Cobalt v3.1 
> [    1.172204] Initialise system trusted keyrings
> [    1.172213] Key type blacklist registered
> [    1.172236] workingset: timestamp_bits=36 max_order=23 bucket_order=0
> [    1.173101] zbud: loaded
> [    1.173444] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    1.173564] fuse init (API version 7.27)
> [    1.174427] Key type asymmetric registered
> [    1.174428] Asymmetric key parser 'x509' registered
> [    1.174437] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
> [    1.174453] io scheduler noop registered
> [    1.174453] io scheduler deadline registered
> [    1.174480] io scheduler cfq registered (default)
> [    1.174666] pcieport 0000:00:01.0: Signaling PME with IRQ 122
> [    1.174720] pcieport 0000:00:01.1: Signaling PME with IRQ 123
> [    1.174857] pcieport 0000:00:1c.0: Signaling PME with IRQ 124
> [    1.175062] pcieport 0000:00:1c.5: Signaling PME with IRQ 125
> [    1.175245] pcieport 0000:00:1c.7: Signaling PME with IRQ 126
> [    1.175379] efifb: probing for efifb
> [    1.175386] efifb: framebuffer at 0x90000000, using 3072k, total 3072k
> [    1.175386] efifb: mode is 1024x768x32, linelength=4096, pages=1
> [    1.175387] efifb: scrolling: redraw
> [    1.175388] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    1.176612] Console: switching to colour frame buffer device 128x48
> [    1.177778] fb0: EFI VGA frame buffer device
> [    1.177930] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
> [    1.177935] ACPI: Sleep Button [SLPB]
> [    1.177957] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
> [    1.177961] ACPI: Power Button [PWRB]
> [    1.177981] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> [    1.177992] ACPI: Power Button [PWRF]
> [    1.178324] ERST: Error Record Serialization Table (ERST) support is initialized.
> [    1.178325] pstore: Registered erst as persistent store backend
> [    1.178403] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
> [    1.178648] Linux agpgart interface v0.103
> [    1.180246] loop: module loaded
> [    1.180431] libphy: Fixed MDIO Bus: probed
> [    1.180431] tun: Universal TUN/TAP device driver, 1.6
> [    1.180458] PPP generic driver version 2.4.2
> [    1.180481] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.180483] ehci-pci: EHCI PCI platform driver
> [    1.180491] ehci-platform: EHCI generic platform driver
> [    1.180497] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    1.180498] ohci-pci: OHCI PCI platform driver
> [    1.180504] ohci-platform: OHCI generic platform driver
> [    1.180509] uhci_hcd: USB Universal Host Controller Interface driver
> [    1.180703] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    1.180708] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> [    1.181799] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000000009810
> [    1.181807] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
> [    1.181997] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
> [    1.181998] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.182000] usb usb1: Product: xHCI Host Controller
> [    1.182000] usb usb1: Manufacturer: Linux 4.19.177-cip44-xenomai-3.1 xhci-hcd
> [    1.182001] usb usb1: SerialNumber: 0000:00:14.0
> [    1.182062] hub 1-0:1.0: USB hub found
> [    1.182081] hub 1-0:1.0: 16 ports detected
> [    1.183955] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    1.183957] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> [    1.183958] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
> [    1.183988] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
> [    1.183989] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.183990] usb usb2: Product: xHCI Host Controller
> [    1.183990] usb usb2: Manufacturer: Linux 4.19.177-cip44-xenomai-3.1 xhci-hcd
> [    1.183991] usb usb2: SerialNumber: 0000:00:14.0
> [    1.184047] hub 2-0:1.0: USB hub found
> [    1.184065] hub 2-0:1.0: 10 ports detected
> [    1.185165] usb: port power management may be unreliable
> [    1.185302] i8042: PNP: No PS/2 controller found.
> [    1.185331] mousedev: PS/2 mouse device common for all mice
> [    1.185430] rtc_cmos rtc_cmos: RTC can wake from S4
> [    1.186468] rtc_cmos rtc_cmos: registered as rtc0
> [    1.186478] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [    1.186481] i2c /dev entries driver
> [    1.186511] device-mapper: uevent: version 1.0.3
> [    1.186542] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
> [    1.186607] ledtrig-cpu: registered to indicate activity on CPUs
> [    1.186609] EFI Variables Facility v0.08 2004-May-17
> [    1.195009] NET: Registered protocol family 10
> [    1.197605] Segment Routing with IPv6
> [    1.197617] NET: Registered protocol family 17
> [    1.197639] Key type dns_resolver registered
> [    1.198018] mce: Using 12 MCE banks
> [    1.198030] RAS: Correctable Errors collector initialized.
> [    1.198050] microcode: sig=0x906ea, pf=0x2, revision=0xde
> [    1.198095] microcode: Microcode Update Driver: v2.2.
> [    1.198102] sched_clock: Marking stable (1189414811, 8677732)->(1206634223, -8541680)
> [    1.198161] registered taskstats version 1
> [    1.198167] Loading compiled-in X.509 certificates
> [    1.198651] Loaded X.509 cert 'Build time autogenerated kernel key: 91aa3544193909156111300e8ea94c38e5c5ace9'
> [    1.198670] zswap: loaded using pool lzo/zbud
> [    1.198707] pstore: Using compression: deflate
> [    1.201051] Key type big_key registered
> [    1.201053] Key type trusted registered
> [    1.202211] Key type encrypted registered
> [    1.202213] AppArmor: AppArmor sha1 policy hashing enabled
> [    1.202221] ima: No TPM chip found, activating TPM-bypass!
> [    1.202225] ima: Allocated hash algorithm: sha1
> [    1.202233] evm: Initialising EVM extended attributes:
> [    1.202233] evm: security.selinux
> [    1.202234] evm: security.SMACK64
> [    1.202234] evm: security.SMACK64EXEC
> [    1.202235] evm: security.SMACK64TRANSMUTE
> [    1.202235] evm: security.SMACK64MMAP
> [    1.202236] evm: security.apparmor
> [    1.202236] evm: security.ima
> [    1.202237] evm: security.capability
> [    1.202237] evm: HMAC attrs: 0x1
> [    1.204315]   Magic number: 1:382:604
> [    1.204620] rtc_cmos rtc_cmos: setting system clock to 2021-04-27 22:35:30 UTC (1619562930)
> [    1.430391] Freeing unused kernel image memory: 1812K
> [    1.454590] Write protecting the kernel read-only data: 18432k
> [    1.455357] Freeing unused kernel image memory: 2000K
> [    1.455403] Freeing unused kernel image memory: 160K
> [    1.463173] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    1.463173] x86/mm: Checking user space page tables
> [    1.470717] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    1.470720] Run /init as init process
> [    1.526591] usb 1-3: new full-speed USB device number 2 using xhci_hcd
> [    1.543275] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
> [    1.545411] dca service started, version 1.12.1
> [    1.546779] ahci 0000:00:17.0: version 3.0
> [    1.546825] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    1.546826] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    1.546966] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [    1.547086] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
> [    1.547088] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slum part ems deso sadm sds apst 
> [    1.548276] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> [    1.548276] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    1.562188] VFIO - User Level meta-driver version: 0.3
> [    1.578525] pps pps0: new PPS source ptp0
> [    1.578549] igb 0000:05:00.0: added PHC on eth0
> [    1.578549] igb 0000:05:00.0: Intel(R) Gigabit Ethernet Network Connection
> [    1.578550] igb 0000:05:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 3c:ec:ef:28:f8:a1
> [    1.578657] igb 0000:05:00.0: eth0: PBA No: 010B00-000
> [    1.578658] igb 0000:05:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
> [    1.619370] igb 0000:05:00.0 eno2: renamed from eth0
> [    1.621379] checking generic (90000000 300000) vs hw (90000000 10000000)
> [    1.621379] fb: switching to inteldrmfb from EFI VGA
> [    1.621391] Console: switching to colour dummy device 80x25
> [    1.621440] [drm] Replacing VGA console driver
> [    1.622935] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    1.622935] [drm] Driver supports precise vblank timestamp query.
> [    1.623555] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [    1.623846] [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
> [    1.638836] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
> [    1.639245] scsi host0: ahci
> [    1.639324] scsi host1: ahci
> [    1.639373] scsi host2: ahci
> [    1.639425] scsi host3: ahci
> [    1.639475] scsi host4: ahci
> [    1.639523] scsi host5: ahci
> [    1.639567] scsi host6: ahci
> [    1.639615] scsi host7: ahci
> [    1.639643] ata1: SATA max UDMA/133 abar m2048@0xa233a000 port 0xa233a100 irq 128
> [    1.639646] ata2: SATA max UDMA/133 abar m2048@0xa233a000 port 0xa233a180 irq 128
> [    1.639649] ata3: SATA max UDMA/133 abar m2048@0xa233a000 port 0xa233a200 irq 128
> [    1.639652] ata4: SATA max UDMA/133 abar m2048@0xa233a000 port 0xa233a280 irq 128
> [    1.639654] ata5: SATA max UDMA/133 abar m2048@0xa233a000 port 0xa233a300 irq 128
> [    1.639657] ata6: SATA max UDMA/133 abar m2048@0xa233a000 port 0xa233a380 irq 128
> [    1.639660] ata7: SATA max UDMA/133 abar m2048@0xa233a000 port 0xa233a400 irq 128
> [    1.639662] ata8: SATA max UDMA/133 abar m2048@0xa233a000 port 0xa233a480 irq 128
> [    1.678728] usb 1-3: not running at top speed; connect to a high speed hub
> [    1.679051] usb 1-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
> [    1.679052] usb 1-3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [    1.679053] usb 1-3: Product: USB 2.0 Hub
> [    1.679733] hub 1-3:1.0: USB hub found
> [    1.679828] hub 1-3:1.0: 4 ports detected
> [    1.726482] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 3c:ec:ef:28:f8:a0
> [    1.726483] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
> [    1.726590] e1000e 0000:00:1f.6 eth0: MAC: 13, PHY: 12, PBA No: 010BFF-0FF
> [    1.743121] e1000e 0000:00:1f.6 eno1: renamed from eth0
> [    1.952867] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.952888] ata7: SATA link down (SStatus 0 SControl 300)
> [    1.952912] ata8: SATA link down (SStatus 0 SControl 300)
> [    1.952937] ata3: SATA link down (SStatus 0 SControl 300)
> [    1.952961] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.952980] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.953001] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.953021] ata6: SATA link down (SStatus 0 SControl 300)
> [    1.954837] ata5.00: supports DRM functions and may not be fully accessible
> [    1.954858] ata4.00: supports DRM functions and may not be fully accessible
> [    1.955054] ata1.00: supports DRM functions and may not be fully accessible
> [    1.955108] ata2.00: supports DRM functions and may not be fully accessible
> [    1.955500] ata1.00: ATA-11: Samsung SSD 860 EVO 500GB, RVT04B6Q, max UDMA/133
> [    1.955501] ata1.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [    1.955547] ata2.00: ATA-11: Samsung SSD 860 EVO 500GB, RVT04B6Q, max UDMA/133
> [    1.955548] ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [    1.955684] ata5.00: ATA-11: Samsung SSD 860 EVO 2TB, RVT04B6Q, max UDMA/133
> [    1.955685] ata5.00: 3907029168 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [    1.955696] ata4.00: ATA-11: Samsung SSD 860 EVO 2TB, RVT04B6Q, max UDMA/133
> [    1.955697] ata4.00: 3907029168 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [    1.957193] ata1.00: supports DRM functions and may not be fully accessible
> [    1.957243] ata2.00: supports DRM functions and may not be fully accessible
> [    1.958143] ata4.00: supports DRM functions and may not be fully accessible
> [    1.958145] ata5.00: supports DRM functions and may not be fully accessible
> [    1.959041] ata1.00: configured for UDMA/133
> [    1.959079] ata2.00: configured for UDMA/133
> [    1.959140] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 860  4B6Q PQ: 0 ANSI: 5
> [    1.959250] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    1.959258] ata1.00: Enabling discard_zeroes_data
> [    1.959282] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> [    1.959287] sd 0:0:0:0: [sda] Write Protect is off
> [    1.959288] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    1.959295] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.959357] scsi 1:0:0:0: Direct-Access     ATA      Samsung SSD 860  4B6Q PQ: 0 ANSI: 5
> [    1.959358] ata1.00: Enabling discard_zeroes_data
> [    1.959443] ata2.00: Enabling discard_zeroes_data
> [    1.959464] sd 1:0:0:0: Attached scsi generic sg1 type 0
> [    1.959510] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> [    1.959519] sd 1:0:0:0: [sdb] Write Protect is off
> [    1.959520] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    1.959537] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.959625] ata2.00: Enabling discard_zeroes_data
> [    1.959990] ata2.00: Enabling discard_zeroes_data
> [    1.960522]  sda: sda1 sda2 sda3
> [    1.960638] ata1.00: Enabling discard_zeroes_data
> [    1.960980] sd 1:0:0:0: [sdb] supports TCG Opal
> [    1.960981] sd 1:0:0:0: [sdb] Attached SCSI disk
> [    1.961070] ata4.00: configured for UDMA/133
> [    1.961075] ata5.00: configured for UDMA/133
> [    1.961138] scsi 3:0:0:0: Direct-Access     ATA      Samsung SSD 860  4B6Q PQ: 0 ANSI: 5
> [    1.961203] ata4.00: Enabling discard_zeroes_data
> [    1.961223] sd 3:0:0:0: Attached scsi generic sg2 type 0
> [    1.961249] sd 3:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
> [    1.961259] sd 3:0:0:0: [sdc] Write Protect is off
> [    1.961261] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [    1.961279] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.961324] scsi 4:0:0:0: Direct-Access     ATA      Samsung SSD 860  4B6Q PQ: 0 ANSI: 5
> [    1.961360] ata4.00: Enabling discard_zeroes_data
> [    1.961392] ata5.00: Enabling discard_zeroes_data
> [    1.961412] sd 4:0:0:0: Attached scsi generic sg3 type 0
> [    1.961425] sd 4:0:0:0: [sdd] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
> [    1.961432] sd 4:0:0:0: [sdd] Write Protect is off
> [    1.961433] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [    1.961445] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.961516] ata5.00: Enabling discard_zeroes_data
> [    1.961576] sd 0:0:0:0: [sda] supports TCG Opal
> [    1.961577] sd 0:0:0:0: [sda] Attached SCSI disk
> [    1.961823] ata5.00: Enabling discard_zeroes_data
> [    1.962667]  sdc: sdc1
> [    1.962747] ata4.00: Enabling discard_zeroes_data
> [    1.962900] sd 4:0:0:0: [sdd] supports TCG Opal
> [    1.962901] sd 4:0:0:0: [sdd] Attached SCSI disk
> [    1.963870] sd 3:0:0:0: [sdc] supports TCG Opal
> [    1.963871] sd 3:0:0:0: [sdc] Attached SCSI disk
> [    1.992382] random: fast init done
> [    1.996527] md/raid1:md1: active with 2 out of 2 mirrors
> [    1.997488] md1: detected capacity change from 0 to 2000262529024
> [    2.000062] md/raid1:md0: active with 2 out of 2 mirrors
> [    2.000921] md0: detected capacity change from 0 to 498972229632
> [    2.004603] random: lvm: uninitialized urandom read (4 bytes read)
> [    2.007561] random: lvm: uninitialized urandom read (4 bytes read)
> [    2.020415] random: lvm: uninitialized urandom read (2 bytes read)
> [    2.086593] usb 1-3.3: new full-speed USB device number 3 using xhci_hcd
> [    2.297389] usb 1-3.3: New USB device found, idVendor=413c, idProduct=2101, bcdDevice= 1.00
> [    2.297390] usb 1-3.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    2.297391] usb 1-3.3: Product: Dell Smart Card Reader Keyboard
> [    2.297392] usb 1-3.3: Manufacturer: Dell
> [    2.301046] hidraw: raw HID events driver (C) Jiri Kosina
> [    2.304801] usbcore: registered new interface driver usbhid
> [    2.304802] usbhid: USB HID core driver
> [    2.305792] input: Dell Dell Smart Card Reader Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.3/1-3.3:1.0/0003:413C:2101.0001/input/input3
> [    2.362629] hid-generic 0003:413C:2101.0001: input,hidraw0: USB HID v1.11 Keyboard [Dell Dell Smart Card Reader Keyboard] on usb-0000:00:14.0-3.3/input0
> [    2.498586] usb 1-3.4: new full-speed USB device number 4 using xhci_hcd
> [    2.718707] usb 1-3.4: not running at top speed; connect to a high speed hub
> [    2.719032] usb 1-3.4: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
> [    2.719033] usb 1-3.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [    2.719034] usb 1-3.4: Product: USB 2.0 Hub
> [    2.719841] hub 1-3.4:1.0: USB hub found
> [    2.719925] hub 1-3.4:1.0: 4 ports detected
> [    2.729478] [drm] failed to retrieve link info, disabling eDP
> [    2.735605] [drm] Initialized i915 1.6.0 20180719 for 0000:00:02.0 on minor 0
> [    2.737642] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [    2.738055] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
> [    3.044826] fbcon: inteldrmfb (fb0) is primary device
> [    3.064488] Console: switching to colour frame buffer device 240x67
> [    3.084168] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
> [    3.126588] usb 1-3.4.1: new low-speed USB device number 5 using xhci_hcd
> [    3.349430] usb 1-3.4.1: New USB device found, idVendor=0461, idProduct=4d22, bcdDevice= 2.00
> [    3.349431] usb 1-3.4.1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [    3.349432] usb 1-3.4.1: Product: USB Optical Mouse
> [    3.351876] input: USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4.1/1-3.4.1:1.0/0003:0461:4D22.0002/input/input5
> [    3.351929] hid-generic 0003:0461:4D22.0002: input,hidraw1: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-3.4.1/input0
> [    3.870586] raid6: sse2x1   gen() 13340 MB/s
> [    3.938585] raid6: sse2x1   xor()  9699 MB/s
> [    4.006585] raid6: sse2x2   gen() 16296 MB/s
> [    4.074586] raid6: sse2x2   xor() 10931 MB/s
> [    4.142587] raid6: sse2x4   gen() 18990 MB/s
> [    4.210588] raid6: sse2x4   xor() 11387 MB/s
> [    4.278585] raid6: avx2x1   gen() 26372 MB/s
> [    4.346585] raid6: avx2x1   xor() 18469 MB/s
> [    4.414585] raid6: avx2x2   gen() 30954 MB/s
> [    4.482584] raid6: avx2x2   xor() 19696 MB/s
> [    4.550587] raid6: avx2x4   gen() 36763 MB/s
> [    4.618583] raid6: avx2x4   xor() 21246 MB/s
> [    4.618584] raid6: using algorithm avx2x4 gen() 36763 MB/s
> [    4.618585] raid6: .... xor() 21246 MB/s, rmw enabled
> [    4.618586] raid6: using avx2x2 recovery algorithm
> [    4.619186] xor: automatically using best checksumming function   avx       
> [    4.619759] async_tx: api initialized (async)
> [    4.962767] urandom_read: 3 callbacks suppressed
> [    4.962767] random: plymouthd: uninitialized urandom read (8 bytes read)
> [    4.962847] random: plymouthd: uninitialized urandom read (8 bytes read)
> [    5.004257] random: lvm: uninitialized urandom read (4 bytes read)
> [    5.084588] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
> [    5.108265] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: discard
> [    5.266751] systemd[1]: systemd 237 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> [    5.286738] systemd[1]: Detected architecture x86-64.
> [    5.288679] systemd[1]: Set hostname to <t-mgx-simhost007.ds.amrdec.army.mil>.
> [    5.390835] systemd[1]: Unnecessary job for /dev/mapper/vg00-lv01 was removed.
> [    5.391175] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
> [    5.391232] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [    5.391351] systemd[1]: Created slice User and Session Slice.
> [    5.391443] systemd[1]: Created slice System Slice.
> [    5.391501] systemd[1]: Listening on udev Control Socket.
> [    5.391545] systemd[1]: Listening on Syslog Socket.
> [    5.399200] EXT4-fs (dm-1): re-mounted. Opts: discard,errors=remount-ro
> [    5.399201] EXT4-fs (dm-2): re-mounted. Opts: discard
> [    5.404557] RPC: Registered named UNIX socket transport module.
> [    5.404558] RPC: Registered udp transport module.
> [    5.404558] RPC: Registered tcp transport module.
> [    5.404559] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    5.411455] lp: driver loaded but no devices found
> [    5.414614] ppdev: user-space parallel port driver
> [    5.418436] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> [    5.497580] random: crng init done
> [    5.497581] random: 1 urandom warning(s) missed due to ratelimiting
> [    5.516854] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    5.538533] intel_pch_thermal 0000:00:12.0: enabling device (0000 -> 0002)
> [    5.539036] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    5.585223] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> [    5.586352] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
> [    5.589883] idma64 idma64.0: Found Intel integrated DMA 64-bit
> [    5.598128] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> [    5.598273] idma64 idma64.1: Found Intel integrated DMA 64-bit
> [    5.606791] intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)
> [    5.606983] idma64 idma64.2: Found Intel integrated DMA 64-bit
> [    5.667285] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
> [    5.667287] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [    5.667287] RAPL PMU: hw unit of domain package 2^-14 Joules
> [    5.667288] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [    5.667289] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [    5.667290] RAPL PMU: hw unit of domain psys 2^-14 Joules
> [    5.675192] cryptd: max_cpu_qlen set to 1000
> [    5.682685] AVX2 version of gcm_enc/dec engaged.
> [    5.682686] AES CTR mode by8 optimization enabled
> [    5.698894] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
> [    5.723331] IPv6: ADDRCONF(NETDEV_UP): eno2: link is not ready
> [    5.758418] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> [    5.813539] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: discard
> [    5.826618] Adding 15622140k swap on /dev/mapper/vg00-swap.  Priority:-2 extents:1 across:15622140k SSFS
> [    5.826973] dw-apb-uart.2: ttyS4 at MMIO 0x8f802000 (irq = 20, base_baud = 7500000) is a 16550A
> [    5.829996] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC888-VD: line_outs=3 (0x14/0x17/0x16/0x0/0x0) type:line
> [    5.829997] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [    5.829998] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> [    5.829999] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> [    5.829999] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x1e/0x0
> [    5.830000] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> [    5.830001] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
> [    5.830002] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
> [    5.830003] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
> [    5.839307] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: discard
> [    5.841462] intel_rapl: Found RAPL domain package
> [    5.841464] intel_rapl: Found RAPL domain core
> [    5.841465] intel_rapl: Found RAPL domain uncore
> [    5.841466] intel_rapl: Found RAPL domain dram
> [    5.852450] EXT4-fs (dm-4): mounted filesystem with ordered data mode. Opts: discard
> [    5.861094] systemd-journald[558]: Received request to flush runtime journal from PID 1
> [    5.861397] EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: discard
> [    5.861489] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: discard
> [    5.863855] EXT4-fs (dm-6): mounted filesystem with ordered data mode. Opts: discard
> [    5.863976] EXT4-fs (dm-7): mounted filesystem with ordered data mode. Opts: discard
> [    5.866190] systemd-journald[558]: File /var/log/journal/050aa2957bb349f08aa12cac623ed738/system.journal corrupted or uncleanly shut down, renaming and replacing.
> [    5.876404] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input6
> [    5.876476] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input7
> [    5.876555] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input8
> [    5.876627] input: HDA Intel PCH Line Out Front as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
> [    5.876698] input: HDA Intel PCH Line Out Surround as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
> [    5.876749] input: HDA Intel PCH Line Out CLFE as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
> [    5.876807] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
> [    5.876863] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
> [    5.876912] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
> [    5.876942] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
> [    5.876974] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
> [    5.877007] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
> [    5.927510] audit: type=1400 audit(1619562935.219:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=1282 comm="apparmor_parser"
> [    5.927521] audit: type=1400 audit(1619562935.219:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=1280 comm="apparmor_parser"
> [    5.927723] audit: type=1400 audit(1619562935.219:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oopslash" pid=1279 comm="apparmor_parser"
> [    5.928107] audit: type=1400 audit(1619562935.219:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=1278 comm="apparmor_parser"
> [    5.928109] audit: type=1400 audit(1619562935.219:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=1278 comm="apparmor_parser"
> [    5.928111] audit: type=1400 audit(1619562935.219:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=1278 comm="apparmor_parser"
> [    5.928659] audit: type=1400 audit(1619562935.219:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine" pid=1283 comm="apparmor_parser"
> [    5.928662] audit: type=1400 audit(1619562935.219:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=1283 comm="apparmor_parser"
> [    5.928963] audit: type=1400 audit(1619562935.219:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/ippusbxd" pid=1288 comm="apparmor_parser"
> [    5.929237] audit: type=1400 audit(1619562935.219:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/chronyd" pid=1284 comm="apparmor_parser"
> [    7.977940] NFSD: starting 90-second grace period (net f00000ab)
> [    9.125199] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> [    9.125285] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
> [ 4826.941554] BUG: unable to handle kernel paging request at fffffffeee7e3960
> [ 4826.941557] PGD 41940c067 P4D 41940c067 PUD 0 
> [ 4826.941560] Oops: 0010 [#1] SMP PTI
> [ 4826.941562] CPU: 4 PID: 4619 Comm: kworker/u24:1 Kdump: loaded Not tainted 4.19.177-cip44-xenomai-3.1 #1
> [ 4826.941564] Hardware name: Supermicro Super Server/X11SCA, BIOS 1.4 09/03/2020
> [ 4826.941565] I-pipe domain: Linux
> [ 4826.941568] Workqueue: efi_rts_wq efi_call_rts
> [ 4826.941570] RIP: 0010:0xfffffffeee7e3960
> [ 4826.941573] Code: Bad RIP value.
> [ 4826.941574] RSP: 0018:ffffba3544ebfb98 EFLAGS: 00010286
> [ 4826.941575] RAX: fffffffeee66c96c RBX: fffffffeee66c96c RCX: fffffffeee66c96c
> [ 4826.941577] RDX: ffffa04b42cf7000 RSI: ffffba3544ebfc18 RDI: fffffffeee7eced0
> [ 4826.941578] RBP: ffffa04b42cf7400 R08: ffffa04b42cf7400 R09: ffffba3544ebfc18
> [ 4826.941579] R10: fffffffeee7eced0 R11: 0000000000000001 R12: ffffa04b42cf7000
> [ 4826.941580] R13: ffffba3544ebfcc8 R14: ffffba3544ebfcc0 R15: ffffba3544ebfd08
> [ 4826.941581] FS:  0000000000000000(0000) GS:ffffa04b4c100000(0000) knlGS:0000000000000000
> [ 4826.941583] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4826.941584] CR2: fffffffeee7e3936 CR3: 000000041940a005 CR4: 00000000003606e0
> [ 4826.941585] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4826.941586] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 4826.941587] Call Trace:
> [ 4826.941594]  ? x2apic_send_IPI+0x2e/0x30
> [ 4826.941597]  ? probe_sched_wakeup+0x35/0x40
> [ 4826.941600]  ? __switch_to_asm+0x41/0x70
> [ 4826.941602]  ? __switch_to_asm+0x41/0x70
> [ 4826.941604]  ? __switch_to_asm+0x41/0x70
> [ 4826.941606]  ? efi_call+0x58/0x90
> [ 4826.941608]  ? __switch_to_asm+0x41/0x70
> [ 4826.941611]  ? efi_call_rts+0x2ea/0x730
> [ 4826.941614]  ? process_one_work+0x1de/0x410
> [ 4826.941616]  ? worker_thread+0x34/0x400
> [ 4826.941619]  ? kthread+0x121/0x140
> [ 4826.941621]  ? set_worker_desc+0xb0/0xb0
> [ 4826.941622]  ? kthread_create_worker_on_cpu+0x70/0x70
> [ 4826.941624]  ? ret_from_fork+0x36/0x50
> [ 4826.941627] Modules linked in: binfmt_misc snd_hda_codec_hdmi intel_rapl snd_hda_codec_realtek x86_pkg_temp_thermal 8250_dw snd_hda_codec_generic nls_iso8859_1 coretemp kvm_intel snd_hda_intel crct10dif_pclmul crc32_pclmul snd_hda_codec ghash_clmulni_intel snd_hda_core pcbc snd_hwdep snd_pcm aesni_intel aes_x86_64 crypto_simd cryptd glue_helper intel_cstate snd_seq_midi intel_rapl_perf snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device snd_timer snd idma64 virt_dma mei_me intel_lpss_pci wmi_bmof input_leds soundcore mei intel_lpss intel_pch_thermal 8250 8250_base mac_hid sch_fq_codel xeno_udd nfsd parport_pc ppdev nfs_acl lp lockd parport auth_rpcgss grace sunrpc ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 multipath
> [ 4826.941652]  linear hid_generic usbhid hid raid1 i915 kvmgt vfio_mdev mdev vfio_iommu_type1 vfio kvm irqbypass drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops igb drm e1000e ahci dca libahci i2c_algo_bit wmi video
> [ 4826.941662] CR2: fffffffeee7e3960

Let's start with this. We need the EFI mm switch to be protected against
preemption by the real-time core, at the very least. This would explain
the invalid mapping issue for a seemingly valid address. Please patch
your kernel with this snippet, and let us know of the outcome. TIA,

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index ee5d08f25ce4..aa705d5ed1fc 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -35,6 +35,7 @@
 #include <linux/ucs2_string.h>
 #include <linux/mem_encrypt.h>
 #include <linux/sched/task.h>
+#include <linux/ipipe.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
@@ -626,10 +627,14 @@ void __init efi_dump_pagetable(void)
  */
 void efi_switch_mm(struct mm_struct *mm)
 {
+	unsigned long flags;
+
 	task_lock(current);
+	ipipe_mm_switch_protect(flags);
 	efi_scratch.prev_mm = current->active_mm;
 	current->active_mm = mm;
 	switch_mm(efi_scratch.prev_mm, mm, NULL);
+	ipipe_mm_switch_unprotect(flags);
 	task_unlock(current);
 }
 
-- 
Philippe.

