Subject: UPDATE: This 20-line Xenomai program crashes our servers
References: <44426edd-947b-fcde-8b7d-fd08ae102f37@gmail.com>
 <87eees2qup.fsf@xenomai.org> <ff18702c-ac7c-0e84-ad0d-64f81ab8edd0@gmail.com>
 <8735uvrelu.fsf@xenomai.org>
From: Paul Janssen <paulus947@gmail.com>
Message-ID: <d9a77384-3841-b40e-9464-55231d85e9fc@gmail.com>
Date: Tue, 18 May 2021 10:12:48 -0500
MIME-Version: 1.0
In-Reply-To: <8735uvrelu.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai Community <xenomai@xenomai.org>

On 5/9/2021 12:39 PM, Philippe Gerum wrote:
> You message was queued in a couple of TODO lists already. We need time
> to investigate this, starting with reproducing the crash. No ETA, sorry.
>
> Paul Janssen via Xenomai <xenomai@xenomai.org> writes:
>
>> On 4/30/2021 2:06 AM, Philippe Gerum wrote:
>>> Paul Janssen via Xenomai <xenomai@xenomai.org> writes:
>>>
>>>> Hello everybody,
>>>>
>>>> Our group has been using Xenomai for many years. Version 3.1 for the last few years.
>>>> Recently we have run into a problem. Our main Xenomai program keeps crashing our servers.
>>>> The servers crash because of "unable to handle kernel paging request" (see details down below).
>>>>
>>>> We have researched the issue for many weeks, and have reduced the Xenomai program to a 20-line program (see below) that still crashes our servers.
>>>>
>>>> The servers run forever if we do not run the Xenomai program. When we do start the Xenomai program, the server will crash within 2 hours. But often after just 5 to 30 minutes. We have tested extensively on three-or-four different servers. All machines crash, consistently, with the exact same error in the kernel log. When the computer crashes, there are no warnings messages, or anything on the computer screen. We usually follow the run with "top" and see everything suddenly freeze. This is the exact same behavior on all machines.
>>>>
>>>> But, when we replace the single "clock_nanosleep()" with "__real_clock_nanosleep()" in our test program, and leave everything else unchanged, including the compilation process, then all servers run forever and never crash. We can repeat this consistently, always. As you all know, prepending __real_ will cause the original Linux function to be called instead of the Xenomai "__wrap".
>>>>
>>>> We have used "sem_timedwait()" instead of "clock_nanosleep()" and experienced the exact same crash behavior. And here too, replacing the "sem_timedwait()" with "__real_sem_timedwait()" makes the machines run forever and they never crash.
>>>>
>>>> All this has convinced us that the problem is directly related to something in Xenomai, probably with clock/time related calls.
>>>> We really hope that someone in the Xenomai community maybe knows about this problem, or can help us fix it.
>>>> Thank you very much for looking at this.
>>>>
>>>> --Paul Janssen
>>>>
>>>> Test program "drvr.c":
>>>>
>>>>       1 #include <stdio.h>
>>>>       2 #include <time.h>     // clock_nanosleep()
>>>>       3
>>>>       4 int main()
>>>>       5 {
>>>>       6     while( 1 )
>>>>       7     {
>>>>       8         // Sleep for 250,000 nsec
>>>>       9         struct timespec ts;
>>>>      10         ts.tv_nsec = 250000L;
>>>>      11         ts.tv_sec = 0;
>>>>      12
>>>>      13         int err = clock_nanosleep( CLOCK_REALTIME, 0, &ts, NULL );
>>>>      14         if( err != 0 )
>>>>      15         {
>>>>      16             printf( "clock_nanosleep failed\n" );
>>>>      17             break; // exit
>>>>      18         }
>>>>      19     }
>>>>      20
>>>>      21     return 0;
>>>>      22 }
>>>>
>>>> This single-file program has the following makefile:
>>>>
>>>>       1 .SUFFIXES: .c .h .o
>>>>       2
>>>>       3 drvr: drvr.o
>>>>       4         gcc drvr.o -o $@ -pthread $(shell xeno-config --skin=posix --ldflags)
>>>>       5         ls -al $@
>>>>       6
>>>>       7 drvr.o: drvr.c
>>>>       8         gcc -c drvr.c -o $@ -O2 -Wall -Wextra -march=native -pthread $(shell xeno-config --skin=posix --cflags)
>>>>       9
>>>>      10 .PHONY: clean
>>>>      11
>>>>      12 clean:
>>>>      13         rm -rf drvr drvr.o
>>>>
>>>>
>>>> The output from make (compilation) is as follows:
>>>>
>>>> $ make
>>>> gcc -c drvr.c -o drvr.o -O2 -Wall -Wextra -march=native -pthread -I/usr/include/xenomai/cobalt -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__ -D__COBALT_WRAP__
>>>> gcc drvr.o -o drvr -pthread -Wl,--no-as-needed -Wl,@/usr/lib/cobalt.wrappers -Wl,@/usr/lib/modechk.wrappers  /usr/lib/xenomai/bootstrap.o -Wl,--wrap=main -Wl,--dynamic-list=/usr/lib/dynlist.ld -L/usr/lib -lcobalt -lmodechk -lpthread -lrt
>>>>
>>>>
>>>> I have tried to include all information mentioned in the guidelines. The server crash log is at the bottom of this email. A full kernel log has been attached.
>>>> One more noteworthy thing. All crash logs (/var/crash/...) on all computers always show the same crash information:
>>>>
>>>>   * BUG: unable to handle kernel paging request
>>>>   * Oops: SMP PTI
>>>>   * Comm: kworker/u24
>>>>   * Workqueue: efi_rts_wq efi_call_rts
>>>>
>>>>
>>>> Server Simhost007 Information:
>>>>
>>>> This is an Intel x86-64 Linux Ubuntu 18.04 w/Xenomai 3.1 system
>>>> Processor is an Intel(R) Core(TM) i7-8700K CPU @ 3.70GHz
>>>> Motherboard is a Supermicro Super Server/X11SCA, BIOS 1.4 09/03/2020
>>>>
>>>>
>>>> $ uname -a
>>>> Linux simhost007 4.19.177-cip44-xenomai-3.1 #1 SMP Tue Apr 20 15:49:12 CDT 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>>
>>>>
>>>> $ cat /proc/cmdline
>>>> BOOT_IMAGE=/vmlinuz-4.19.177-cip44-xenomai-3.1 root=/dev/mapper/vg00-lv00 ro splash quiet drm_kms_helper.poll=0 nouveau.noaccel=1 pci=routeirq xenomai.allowed_group=997 crashkernel=384M-2G:64M,2G-:128M workqueue.power_efficient=0 crashkernel=512M-:192M vt.handoff=1
>>>>
>>>>
>>>> $ /usr/sbin/version
>>>> Xenomai/cobalt v3.1
>>>>
>>>>
>>>> $ xeno-config --info | grep -i build
>>>> Build args: --prefix=/usr --includedir=/usr/include/xenomai --mandir=/usr/share/man --with-testdir=/usr/lib/xenomai/testsuite --enable-smp --enable-lazy-setsched --enable-debug=symbols --enable-dlopen-libs --build x86_64-linux-gnu build_alias=x86_64-linux-gnu
>>>>
>>>>
>>>> $ cat /proc/ipipe/version
>>>> 17
>>>>
>>>>
>>>> $ gcc --version
>>>> gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>>>> Copyright (C) 2017 Free Software Foundation, Inc.
>>>> This is free software; see the source for copying conditions.  There is NO
>>>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>>>
>>>>
>>>> $ xeno-config --skin=posix --cflags
>>>> -I/usr/include/xenomai/cobalt -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__ -D__COBALT_WRAP__
>>>>
>>>>
>>>> $ xeno-config --skin=posix --ldflags
>>>> -Wl,--no-as-needed -Wl,@/usr/lib/cobalt.wrappers -Wl,@/usr/lib/modechk.wrappers  /usr/lib/xenomai/bootstrap.o -Wl,--wrap=main -Wl,--dynamic-list=/usr/lib/dynlist.ld -L/usr/lib -lcobalt -lmodechk -lpthread -lrt
>>>>
>>>>
>>>> -------------------------------------------------------------------------------------------------
>>>> From /proc/cpuinfo:
>>>> ...
>>>> processor       : 11
>>>> vendor_id       : GenuineIntel
>>>> cpu family      : 6
>>>> model           : 158
>>>> model name      : Intel(R) Core(TM) i7-8700K CPU @ 3.70GHz
>>>> stepping        : 10
>>>> microcode       : 0xde
>>>> cpu MHz         : 3698.671
>>>> cache size      : 12288 KB
>>>> physical id     : 0
>>>> siblings        : 12
>>>> core id         : 5
>>>> cpu cores       : 6
>>>> apicid          : 11
>>>> initial apicid  : 11
>>>> fpu             : yes
>>>> fpu_exception   : yes
>>>> cpuid level     : 22
>>>> wp              : yes
>>>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm arat pln pts md_clear flush_l1d
>>>> bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs taa itlb_multihit srbds
>>>> bogomips        : 7392.00
>>>> clflush size    : 64
>>>> cache_alignment : 64
>>>> address sizes   : 39 bits physical, 48 bits virtual
>>>> power management:
>>>>
>>>>
>>>> -------------------------------------------------------------------------------------------------
>>>> From the kernel crash log: /var/crash/<timestamp>/dmesg.<timestamp>
>>>> ...
>>>> [ 4826.941554] BUG: unable to handle kernel paging request at fffffffeee7e3960
>>>> [ 4826.941557] PGD 41940c067 P4D 41940c067 PUD 0
>>>> [ 4826.941560] Oops: 0010 [#1] SMP PTI
>>>> [ 4826.941562] CPU: 4 PID: 4619 Comm: kworker/u24:1 Kdump: loaded Not tainted 4.19.177-cip44-xenomai-3.1 #1
>>>> [ 4826.941564] Hardware name: Supermicro Super Server/X11SCA, BIOS 1.4 09/03/2020
>>>> [ 4826.941565] I-pipe domain: Linux
>>>> [ 4826.941568] Workqueue: efi_rts_wq efi_call_rts
>>>> [ 4826.941570] RIP: 0010:0xfffffffeee7e3960
>>>> [ 4826.941573] Code: Bad RIP value.
>>>> [ 4826.941574] RSP: 0018:ffffba3544ebfb98 EFLAGS: 00010286
>>>> [ 4826.941575] RAX: fffffffeee66c96c RBX: fffffffeee66c96c RCX: fffffffeee66c96c
>>>> [ 4826.941577] RDX: ffffa04b42cf7000 RSI: ffffba3544ebfc18 RDI: fffffffeee7eced0
>>>> [ 4826.941578] RBP: ffffa04b42cf7400 R08: ffffa04b42cf7400 R09: ffffba3544ebfc18
>>>> [ 4826.941579] R10: fffffffeee7eced0 R11: 0000000000000001 R12: ffffa04b42cf7000
>>>> [ 4826.941580] R13: ffffba3544ebfcc8 R14: ffffba3544ebfcc0 R15: ffffba3544ebfd08
>>>> [ 4826.941581] FS:  0000000000000000(0000) GS:ffffa04b4c100000(0000) knlGS:0000000000000000
>>>> [ 4826.941583] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [ 4826.941584] CR2: fffffffeee7e3936 CR3: 000000041940a005 CR4: 00000000003606e0
>>>> [ 4826.941585] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> [ 4826.941586] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> [ 4826.941587] Call Trace:
>>>> [ 4826.941594]  ? x2apic_send_IPI+0x2e/0x30
>>>> [ 4826.941597]  ? probe_sched_wakeup+0x35/0x40
>>>> [ 4826.941600]  ? __switch_to_asm+0x41/0x70
>>>> [ 4826.941602]  ? __switch_to_asm+0x41/0x70
>>>> [ 4826.941604]  ? __switch_to_asm+0x41/0x70
>>>> [ 4826.941606]  ? efi_call+0x58/0x90
>>>> [ 4826.941608]  ? __switch_to_asm+0x41/0x70
>>>> [ 4826.941611]  ? efi_call_rts+0x2ea/0x730
>>>> [ 4826.941614]  ? process_one_work+0x1de/0x410
>>>> [ 4826.941616]  ? worker_thread+0x34/0x400
>>>> [ 4826.941619]  ? kthread+0x121/0x140
>>>> [ 4826.941621]  ? set_worker_desc+0xb0/0xb0
>>>> [ 4826.941622]  ? kthread_create_worker_on_cpu+0x70/0x70
>>>> [ 4826.941624]  ? ret_from_fork+0x36/0x50
>>>>
>>>>
>>>>
>>>>  
>> After applying the patch from Philippe (see below) the computer still crashes. After 17 minutes this time (it varies, see previous email).
>> The kernel crash log indicated the exact same reason as described in the original email.
>>
>> Here is the related portion from the last kernel crash log file (the kernel with the patch):
>>
>> [ 1213.049371] BUG: unable to handle kernel paging request at fffffffeee7e52e0
>> [ 1213.049403] PGD 2ee60c067 P4D 2ee60c067 PUD 0
>> [ 1213.049422] Oops: 0010 [#1] SMP PTI
>> [ 1213.049438] CPU: 3 PID: 256 Comm: kworker/u24:3 Kdump: loaded Not tainted 4.19.177-cip44-xenomai-3.1-patch1 #1
>> [ 1213.049499] Hardware name: Supermicro Super Server/X11SCA, BIOS 1.4 09/03/2020
>> [ 1213.049542] I-pipe domain: Linux
>> [ 1213.049566] Workqueue: efi_rts_wq efi_call_rts
>> [ 1213.049597] RIP: 0010:0xfffffffeee7e52e0
>> [ 1213.049626] Code: Bad RIP value.
>> [ 1213.049643] RSP: 0018:ffffa13bc3f63d48 EFLAGS: 00010246
>> [ 1213.049664] RAX: 00000000000002ff RBX: 0000000000000000 RCX: fffffffeee7ea7c8
>> [ 1213.049689] RDX: 0000000000000021 RSI: ffff9050c28ce400 RDI: 0000000000000000
>> [ 1213.049724] RBP: ffff9050c28ce000 R08: fffffffeee7ea7c8 R09: ffffa13bc4a6fdd0
>> [ 1213.049750] R10: 0000000000000200 R11: 0000000000000002 R12: ffff9050c28ce400
>> [ 1213.049775] R13: 0000000000000000 R14: ffffa13bc4a6fdd0 R15: 0000000000000000
>> [ 1213.049801] FS:  0000000000000000(0000) GS:ffff9050cc0c0000(0000) knlGS:0000000000000000
>> [ 1213.049830] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1213.049852] CR2: fffffffeee7e52b6 CR3: 00000002ee60a006 CR4: 00000000003606e0
>> [ 1213.049893] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [ 1213.049934] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [ 1213.049970] Call Trace:
>> [ 1213.049984]  ? __switch_to_asm+0x35/0x70
>> [ 1213.050000]  ? __switch_to_asm+0x41/0x70
>> [ 1213.050016]  ? __switch_to_asm+0x35/0x70
>> [ 1213.050032]  ? __switch_to_asm+0x41/0x70
>> [ 1213.050049]  ? efi_call+0x58/0x90
>> [ 1213.050063]  ? __switch_to_asm+0x41/0x70
>> [ 1213.050081]  ? efi_call_rts+0x2ea/0x730
>> [ 1213.050099]  ? process_one_work+0x1de/0x410
>> [ 1213.050117]  ? worker_thread+0x34/0x400
>> [ 1213.050142]  ? kthread+0x121/0x140
>> [ 1213.050165]  ? set_worker_desc+0xb0/0xb0
>> [ 1213.050191]  ? kthread_create_worker_on_cpu+0x70/0x70
>> [ 1213.050227]  ? ret_from_fork+0x36/0x50
>>
>> Thanks,
>> --Paul Janssen
>
Hello everybody,

I have an update.
We discovered that the problem is related to the computer's UEFI configuration.
When we change the BIOS configuration, from UEFI to legacy BIOS, the little Xenomai test program does not crash the computer anymore.

--Paul Janssen


