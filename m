Message-ID: <478B8249.90303@domain.hid>
Date: Mon, 14 Jan 2008 16:39:53 +0100
From: "Bernhard Michael" <michael.bernhard@domain.hid>
MIME-Version: 1.0
References: <47891672.4050409@domain.hid>
	<2ff1a98a0801140525y2bc4a198o97967585f6de0f7c@domain.hid>
In-Reply-To: <2ff1a98a0801140525y2bc4a198o97967585f6de0f7c@domain.hid>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai problems on pxa
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> On Jan 12, 2008 8:35 PM, Bernhard Michael <michael.bernhard@domain.hid> wrote:
>> Hello,
>>
>> I've been successfully using xenomai on a PXA270 board (Colibri from
>> Toradex) with a custom 2.6.15 kernel and a gcc-3.3.2 toolchain. The
>> xenomai version was 2.3.1 with adeos arm patch 1.5-08.
>>
>> Now I try to upgrade the system to a 2.6.20 kernel compiled with a
>> gcc-4.2.1 toolchain (from CodeSourcery). I want to use xenomai 2.4.1
>> with adeos arm patch 1.8-03.
>>
>> Unfortunately xenomai fails partially to run. As I do not know where to
>> start debugging, I'm going to describe the current behavior. For testing
>> purpose I use xenomai-trunk (svn 3409). Xenomai is compiled as a module.
> 
> I have not yet tried to compile Xenomai for ARM in the same conditions
> as you, however I see an option that could be the source of problems:
> it's the "optimize for size" option. Could you try disabling it ?
> 
I tested with the "optimize for size" configuration disabled (otherwise
identical config). Unfortunately the behavior is exactly the same. The kernel
modes of 'latency' are working and the user-space mode is failing.

However, if I set a shorter period (latency -p 300 -t 1), the whole system  
crashes after a couple of seconds and following message is displayed:

Xenomai: fatal: xnshadow_relax() failed for thread display-781[782]
 CPU  PID    PRI      TIMEOUT  STAT      NAME
   0  0       -1      0        00400088  ROOT
>  0  782      0      0        00300380  display-781
   0  0       99      1        00000084  timerbench
Master time base: clock=2640545631

[<c002734c>] (show_stack+0x0/0x5c) from [<bf00bf44>] (xnshadow_relax+0x148/0x244 [xeno_nucleus])
[<bf00bdfc>] (xnshadow_relax+0x0/0x244 [xeno_nucleus]) from [<bf005e14>] (xnpod_trap_fault+0xdc/0x1d0 [xeno_nucleus])
[<bf005d38>] (xnpod_trap_fault+0x0/0x1d0 [xeno_nucleus]) from [<bf002278>] (xnarch_trap_fault+0x20/0x28 [xeno_nucleus])
 r6 = C01EFE70  r5 = 00000000  r4 = 58454E4F
[<bf002258>] (xnarch_trap_fault+0x0/0x28 [xeno_nucleus]) from [<c01efec8>] (exception_event+0x58/0x70)
[<c01efe70>] (exception_event+0x0/0x70) from [<c005aa94>] (__ipipe_dispatch_event+0x124/0x1ec)
 r5 = 00000000  r4 = 00000100
[<c005a970>] (__ipipe_dispatch_event+0x0/0x1ec) from [<c002b914>] (do_alignment+0x1a4/0x410)
[<c002b770>] (do_alignment+0x0/0x410) from [<c0029a98>] (do_DataAbort+0x3c/0x13c)
[<c0029a5c>] (do_DataAbort+0x0/0x13c) from [<c00229ac>] (__dabt_svc+0x4c/0x60)
[<bf009ea0>] (xntimer_tick_aperiodic+0x0/0x25c [xeno_nucleus]) from [<bf001da4>] (xnintr_clock_handler+0x30/0x10c [xeno_nucleus])
[<bf001d74>] (xnintr_clock_handler+0x0/0x10c [xeno_nucleus]) from [<c0059d40>] (__ipipe_sync_stage+0x1fc/0x2d8)
[<c0059b44>] (__ipipe_sync_stage+0x0/0x2d8) from [<c005a51c>] (ipipe_unstall_pipeline_head+0x70/0x80)
[<c005a4ac>] (ipipe_unstall_pipeline_head+0x0/0x80) from [<bf00c264>] (xnshadow_harden+0x104/0x1c0 [xeno_nucleus])
[<bf00c160>] (xnshadow_harden+0x0/0x1c0 [xeno_nucleus]) from [<bf00c3c4>] (losyscall_event+0xa4/0x1ac [xeno_nucleus])
[<bf00c320>] (losyscall_event+0x0/0x1ac [xeno_nucleus]) from [<c005aa94>] (__ipipe_dispatch_event+0x124/0x1ec)
[<c005a970>] (__ipipe_dispatch_event+0x0/0x1ec) from [<c0028270>] (__ipipe_syscall_root+0x5c/0x108)
[<c0028214>] (__ipipe_syscall_root+0x0/0x108) from [<c0022f7c>] (vector_swi+0x5c/0x98)

If I switch the 'Soft Lockup Detecten' in the kernel config on again, loading
xenomai modules result in a soft lockup with following message:

BUG: soft lockup detected on CPU#0!
[<c002729c>] (dump_stack+0x0/0x14) from [<c0056c60>] (softlockup_tick+0x8c/0xbc)
[<c0056bd4>] (softlockup_tick+0x0/0xbc) from [<c003ec18>] (run_local_timers+0x18/0x1c)
 r7 = 00000000  r6 = 0000001A  r5 = 00000000  r4 = C3D7C960
[<c003ec00>] (run_local_timers+0x0/0x1c) from [<c003ec50>] (update_process_times+0x34/0x74)
[<c003ec1c>] (update_process_times+0x0/0x74) from [<c00269b4>] (timer_tick+0xd8/0xf0)
 r5 = C033D560  r4 = C0333DC8
[<c00268dc>] (timer_tick+0x0/0xf0) from [<c002df24>] (pxa_timer_interrupt+0x2c/0xa8)
 r5 = C033D560  r4 = C0333DC8
[<c002def8>] (pxa_timer_interrupt+0x0/0xa8) from [<c0056fb4>] (handle_IRQ_event+0x38/0x98)
 r5 = 00000000  r4 = C03199A8
[<c0056f7c>] (handle_IRQ_event+0x0/0x98) from [<c0058708>] (handle_level_irq+0x78/0xf0)
 r7 = C031B428  r6 = 0000001A  r5 = C03199A8  r4 = C0314680
[<c0058690>] (handle_level_irq+0x0/0xf0) from [<c00238ec>] (asm_do_IRQ+0x4c/0x64)
 r7 = C031B428  r6 = 00000000  r5 = 00000000  r4 = C034409C
[<c00238a0>] (asm_do_IRQ+0x0/0x64) from [<c0059f34>] (__ipipe_sync_stage+0x294/0x2d8)
 r5 = C031B428  r4 = 00000000
[<c0059ca0>] (__ipipe_sync_stage+0x0/0x2d8) from [<c005a328>] (__ipipe_unstall_root+0x4c/0x54)
[<c005a2dc>] (__ipipe_unstall_root+0x0/0x54) from [<c005a36c>] (__ipipe_restore_root+0x3c/0x44)
[<c005a330>] (__ipipe_restore_root+0x0/0x44) from [<c0034424>] (vprintk+0x210/0x384)
[<c0034214>] (vprintk+0x0/0x384) from [<c0034610>] (printk+0x78/0x148)
[<c0034598>] (printk+0x0/0x148) from [<bf027430>] (init_module+0x294/0x2f4 [xeno_native])
 r3 = 60000013  r2 = 00000001  r1 = 00000000  r0 = BF034F30
 r7 = BF03BE70  r6 = BF03BE64  r5 = BF03BE58  r4 = BF03BE4C
[<bf02719c>] (init_module+0x0/0x2f4 [xeno_native]) from [<c0054310>] (sys_init_module+0x134/0x15e8)
[<c00541dc>] (sys_init_module+0x0/0x15e8) from [<c0022e44>] (ret_fast_syscall+0x0/0x10)

The system remains usable however. The lockup detection triggers after about
one second only (kernel help states that it should be after 10s). However, if I
measure the time with 'time', I get following result:

$time modprobe xeno_native
$real    0m 32.87s
$user    0m 0.03s
$sys     0m 32.59s

I suppose, something get messed up during module registration.

--------------

In the meantime I compiled xenomai and the 2.6.20 kernel with the toolchain
from ELDK (version 4.1), which does not use EABI. 'latency' is working in all
three modes!

During boot-up I get the same message as before:

I-pipe 1.8-03: pipeline enabled.
start_kernel(): bug: interrupts were enabled early

I'm not sure if this poses a problem however.

Also the soft lockup remains the same:

BUG: soft lockup detected on CPU#0!
[<c0026cfc>] (dump_stack+0x0/0x14) from [<c0058bf4>] (softlockup_tick+0x98/0xb8)
[<c0058b5c>] (softlockup_tick+0x0/0xb8) from [<c0042010>] (run_local_timers+0x18/0x1c)
 r7 = 0000001A  r6 = 00000000  r5 = 00000000  r4 = C02F35F0
[<c0041ff8>] (run_local_timers+0x0/0x1c) from [<c0042410>] (update_process_times+0x44/0x70)
[<c00423cc>] (update_process_times+0x0/0x70) from [<c0026b90>] (timer_tick+0xc8/0xe8)
 r5 = 00000000  r4 = C02F5BB4
[<c0026ac8>] (timer_tick+0x0/0xe8) from [<c002da38>] (pxa_timer_interrupt+0x20/0xa0)
 r5 = 00000000  r4 = C02F5BB4
[<c002da18>] (pxa_timer_interrupt+0x0/0xa0) from [<c0058d08>] (handle_IRQ_event+0x3c/0x94)
[<c0058ccc>] (handle_IRQ_event+0x0/0x94) from [<c005a60c>] (handle_level_irq+0x80/0xd8)
 r7 = 00000340  r6 = 00000000  r5 = 0000001A  r4 = C02F0680
[<c005a58c>] (handle_level_irq+0x0/0xd8) from [<c0023868>] (asm_do_IRQ+0x48/0x60)
 r5 = 00000000  r4 = C0325894
[<c0023820>] (asm_do_IRQ+0x0/0x60) from [<c005bf64>] (__ipipe_sync_stage+0x1fc/0x330)
 r5 = C0321220  r4 = 0000001A
[<c005bd68>] (__ipipe_sync_stage+0x0/0x330) from [<c005c65c>] (__ipipe_walk_pipeline+0x9c/0xcc)
[<c005c5c0>] (__ipipe_walk_pipeline+0x0/0xcc) from [<c0028000>] (__ipipe_handle_irq+0x114/0x158)
 r7 = C0322B04  r6 = 0000001A  r5 = 0000001A  r4 = C0322B00
[<c0027eec>] (__ipipe_handle_irq+0x0/0x158) from [<c0028124>] (__ipipe_grab_irq+0xe0/0x10c)
 r8 = A001EE8C  r7 = C02EFF5C  r6 = 0000001A  r5 = C02EFF90
 r4 = FFFFFFFF
[<c0028044>] (__ipipe_grab_irq+0x0/0x10c) from [<c00229a8>] (__irq_svc+0x28/0x68)
 r7 = C0333C48  r6 = 04000000  r5 = C02EFF90  r4 = FFFFFFFF
[<c0023db8>] (default_idle+0x0/0x6c) from [<c0023cb8>] (cpu_idle+0x38/0x54)
[<c0023c80>] (cpu_idle+0x0/0x54) from [<c0022050>] (rest_init+0x24/0x2c)
 r5 = C0314E2C  r4 = C0324720
[<c002202c>] (rest_init+0x0/0x2c) from [<c0008a64>] (start_kernel+0x1e8/0x240)
[<c000887c>] (start_kernel+0x0/0x240) from [<a0008030>] (0xa0008030)

The time measurement gives more realistic values:

$time modprobe xeno_native
$real    0m1.030s
$user    0m0.020s
$sys     0m0.820s

Running 'latency' with a shorter period doesn't seem to crash.

----------

Well, this is all information I can provide at the moment.

--
Michael

