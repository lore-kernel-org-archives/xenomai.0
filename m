From: Alexander Frolov <frolov@nicevt.ru>
Subject: Stalled head domain on x86_64 platform
Message-ID: <4aadb535-828f-271b-4b93-233f1d06c5a1@nicevt.ru>
Date: Tue, 2 Jun 2020 10:37:54 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all!

I've encountered with the following ipipe error message. What can it be?
Thank you!

Best,
 =C2=A0=C2=A0=C2=A0 Alex


[ 2275.770959] I-pipe: Detected stalled head domain, probably caused by=20
a bug.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A critical s=
ection may have been left unterminated.
[ 2275.770965] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 O=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
4.19.84-xenomai-nicevt4.debug1 #1
[ 2275.770968] Hardware name: GIGABYTE MZ31-AR0-00/MZ31-AR0-00, BIOS F13=20
04/15/2019
[ 2275.770970] I-pipe domain: Linux
[ 2275.770973] Call Trace:
[ 2275.770984]=C2=A0 dump_stack+0x8c/0xc0
[ 2275.770990]=C2=A0 ipipe_root_only.cold+0x11/0x32
[ 2275.770994]=C2=A0 ipipe_stall_root+0xe/0x60
[ 2275.770999]=C2=A0 __ipipe_trap_prologue+0x11a/0x300
[ 2275.771005]=C2=A0 int3+0x45/0x70
[ 2275.771010] RIP: 0010:xntimer_start+0x37/0x220
[ 2275.771013] Code: 89 ce 41 55 49 89 d5 41 54 55 48 89 fd 53 48 83 ec=20
08 48 8b 47 68 4c 8b 25 16 52 2e 01 48 63 40 18 4c 03 24 c5 00 27 2b 98=20
cc <fc> 00 00 00 48 8b 4d 38 f6 c1 01 0f 84 43 01 00 00 0f 31 48 c1 e2
[ 2275.771016] RSP: 0018:ffffa81e4192bd48 EFLAGS: 00000086
[ 2275.771021] RAX: 0000000000000002 RBX: 0000000000025290 RCX:=20
0000000000000000
[ 2275.771024] RDX: 0000000000000000 RSI: 00000000000efc6c RDI:=20
ffff89691d537270
[ 2275.771026] RBP: ffff89691d537270 R08: 00000000000000b0 R09:=20
00000211deffb6c0
[ 2275.771029] R10: 00000211def07480 R11: 00000211def07480 R12:=20
ffff89691d542300
[ 2275.771031] R13: 0000000000000000 R14: 0000000000000000 R15:=20
00000000000efc6c
[ 2275.771038]=C2=A0 ? xntimer_start+0x37/0x220
[ 2275.771042]=C2=A0 program_htick_shot+0x8d/0x130
[ 2275.771047]=C2=A0 clockevents_program_event+0x8d/0xf0
[ 2275.771052]=C2=A0 hrtimer_interrupt+0x14b/0x250
[ 2275.771057]=C2=A0 smp_apic_timer_interrupt+0x4e/0x120
[ 2275.771060]=C2=A0 __ipipe_do_sync_stage+0x167/0x1d0
[ 2275.771065]=C2=A0 ipipe_unstall_root+0x55/0x60
[ 2275.771069]=C2=A0 cpuidle_enter_state+0xc9/0x360
[ 2275.771075]=C2=A0 do_idle+0x1ef/0x280
[ 2275.771080]=C2=A0 cpu_startup_entry+0x6f/0x80
[ 2275.771083]=C2=A0 start_secondary+0x178/0x1a0
[ 2275.771087]=C2=A0 secondary_startup_64+0xa4/0xb0
[ 2275.771094] I-pipe tracer log (100 points):
[ 2275.771096]=C2=A0 |*#func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=20
ipipe_trace_panic_freeze+0x0 (ipipe_root_only+0xcf)
[ 2275.771120]=C2=A0 |*#func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1 ipipe_=
root_only+0x0=20
(ipipe_stall_root+0xe)
[ 2275.771142]=C2=A0 |*#func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1 ipipe_=
stall_root+0x0=20
(__ipipe_trap_prologue+0x11a)
[ 2275.771164]=C2=A0 |*#func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -2 ipipe_=
test_root+0x0=20
(__ipipe_trap_prologue+0xc2)
[ 2275.771186]=C2=A0 |*#func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -2 __ipip=
e_trap_prologue+0x0=20
(int3+0x45)
[ 2275.771207]=C2=A0 |*#func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -2 xntime=
r_start+0x0=20
(program_htick_shot+0x8d)
[ 2275.771229]=C2=A0 | #begin=C2=A0=C2=A0 0x80000000=C2=A0=C2=A0=C2=A0=C2=
=A0 -2 program_htick_shot+0xdb=20
(<00000000>)
[ 2275.771251]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-2 program_htick_shot+0x0=20
(clockevents_program_event+0x8d)
[ 2275.771273]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-3 ktime_get+0x0=20
(clockevents_program_event+0x50)
[ 2275.771294]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-3=20
clockevents_program_event+0x0 (hrtimer_interrupt+0x14b)
[ 2275.771316]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-3 tick_program_event+0x0=20
(hrtimer_interrupt+0x14b)
[ 2275.771338]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0=C2=A0 -3 ipipe_stall_root+0x53=20
(<00000000>)
[ 2275.771360]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0=C2=
=A0 -3 ipipe_stall_root+0x47=20
(<00000000>)
[ 2275.771381]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0=C2=A0 -3 ipipe_root_only+0x74=20
(<00000000>)
[ 2275.771402]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0=C2=
=A0 -3 ipipe_root_only+0x68=20
(<00000000>)
[ 2275.771424]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-3 ipipe_root_only+0x0=20
(ipipe_stall_root+0xe)
[ 2275.771446]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-3 ipipe_stall_root+0x0=20
(_raw_spin_unlock_irqrestore+0x1e)
[ 2275.771469]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0=C2=A0 -3 ipipe_root_only+0x74=20
(<00000000>)
[ 2275.771490]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0=C2=
=A0 -4 ipipe_root_only+0x68=20
(<00000000>)
[ 2275.771511]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-4 ipipe_root_only+0x0=20
(ipipe_restore_root+0xe)
[ 2275.771533]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-4 ipipe_restore_root+0x0=20
(_raw_spin_unlock_irqrestore+0x1e)
[ 2275.771556]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-4=20
_raw_spin_unlock_irqrestore+0x0 (hrtimer_interrupt+0x13d)
[ 2275.771577]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-4=20
__ipipe_spin_unlock_debug+0x0 (hrtimer_interrupt+0x132)
[ 2275.771599]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-4=20
__hrtimer_next_event_base+0x0 (hrtimer_interrupt+0x11b)
[ 2275.771621]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-4=20
__hrtimer_next_event_base+0x0 (__hrtimer_get_next_event+0x6c)
[ 2275.771642]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-4=20
__hrtimer_get_next_event+0x0 (hrtimer_interrupt+0x11b)
[ 2275.771663]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-4 enqueue_hrtimer+0x0=20
(__hrtimer_run_queues+0x137)
[ 2275.771685]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0=C2=A0 -4 ipipe_stall_root+0x53=20
(<00000000>)
[ 2275.771706]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0=C2=
=A0 -5 ipipe_stall_root+0x47=20
(<00000000>)
[ 2275.771728]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0=C2=A0 -5 ipipe_root_only+0x74=20
(<00000000>)
[ 2275.771749]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0=C2=
=A0 -5 ipipe_root_only+0x68=20
(<00000000>)
[ 2275.771770]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-5 ipipe_root_only+0x0=20
(ipipe_stall_root+0xe)
[ 2275.771792]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-5 ipipe_stall_root+0x0=20
(_raw_spin_lock_irq+0xe)
[ 2275.771814]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-5 _raw_spin_lock_irq+0x0=20
(__hrtimer_run_queues+0x114)
[ 2275.771836]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-5 hrtimer_forward+0x0=20
(tick_sched_timer+0x50)
[ 2275.771858]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-5 profile_tick+0x0=20
(tick_sched_timer+0x38)
[ 2275.771880]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-6 run_posix_cpu_timers+0x0=20
(tick_sched_handle+0x34)
[ 2275.771902]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-6 trigger_load_balance+0x0=20
(update_process_times+0x69)
[ 2275.771924]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-6 calc_global_load_tick+0x0=20
(scheduler_tick+0x75)
[ 2275.771946]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-6 cpu_load_update+0x0=20
(scheduler_tick+0x6d)
[ 2275.771968]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-6 tick_nohz_tick_stopped+0x0=20
(cpu_load_update_active+0x2a)
[ 2275.771990]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-6 cpu_load_update_active+0x0=20
(scheduler_tick+0x6d)
[ 2275.772012]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-6 task_tick_idle+0x0=20
(scheduler_tick+0x65)
[ 2275.772033]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-7 update_rq_clock.part.0+0x0=20
(scheduler_tick+0x4d)
[ 2275.772055]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-7 _raw_spin_lock+0x0=20
(scheduler_tick+0x3c)
[ 2275.772077]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-7 scheduler_tick+0x0=20
(update_process_times+0x69)
[ 2275.772098]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0=C2=A0 -7 ipipe_test_root+0x55=20
(<00000000>)
[ 2275.772119]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0=C2=
=A0 -7 ipipe_test_root+0x40=20
(<00000000>)
[ 2275.772141]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-7 ipipe_test_root+0x0=20
(irq_work_run_list+0xe)
[ 2275.772163]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-7 rcu_segcblist_ready_cbs+0x0=20
(rcu_check_callbacks+0x167)
[ 2275.772185]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-8 rcu_segcblist_ready_cbs+0x0=20
(rcu_check_callbacks+0x167)
[ 2275.772206]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-8 rcu_all_qs+0x0=20
(rcu_check_callbacks+0x363)
[ 2275.772228]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-8 rcu_sched_qs+0x0=20
(rcu_check_callbacks+0x351)
[ 2275.772249]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-8 rcu_check_callbacks+0x0=20
(update_process_times+0x41)
[ 2275.772270]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0=C2=A0 -8 ipipe_stall_root+0x53=20
(<00000000>)
[ 2275.772291]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0=C2=
=A0 -8 ipipe_stall_root+0x47=20
(<00000000>)
[ 2275.772313]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0=C2=A0 -9 ipipe_root_only+0x74=20
(<00000000>)
[ 2275.772334]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0=C2=
=A0 -9 ipipe_root_only+0x68=20
(<00000000>)
[ 2275.772356]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-9 ipipe_root_only+0x0=20
(ipipe_stall_root+0xe)
[ 2275.772377]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-9 ipipe_stall_root+0x0=20
(update_process_times+0x3a)
[ 2275.772399]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0=C2=A0 -9 ipipe_root_only+0x74=20
(<00000000>)
[ 2275.772420]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0=C2=
=A0 -9 ipipe_root_only+0x68=20
(<00000000>)
[ 2275.772442]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-9 ipipe_root_only+0x0=20
(ipipe_restore_root+0xe)
[ 2275.772463]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-9 ipipe_restore_root+0x0=20
(update_process_times+0x3a)
[ 2275.772485]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0=C2=A0 -9 ipipe_stall_root+0x53=20
(<00000000>)
[ 2275.772506]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0=C2=
=A0 -9 ipipe_stall_root+0x47=20
(<00000000>)
[ 2275.772528]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0=C2=A0 -9 ipipe_root_only+0x74=20
(<00000000>)
[ 2275.772549]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0=C2=
=A0 -9 ipipe_root_only+0x68=20
(<00000000>)
[ 2275.772570]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -10 ip=
ipe_root_only+0x0=20
(ipipe_stall_root+0xe)
[ 2275.772592]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -10 ip=
ipe_stall_root+0x0=20
(raise_softirq+0x1f)
[ 2275.772615]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0 -10 ipipe_test_root+0x55=20
(<00000000>)
[ 2275.772636]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0 -1=
0 ipipe_test_root+0x40=20
(<00000000>)
[ 2275.772658]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -10 ip=
ipe_test_root+0x0=20
(raise_softirq+0x13)
[ 2275.772679]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -10 ra=
ise_softirq+0x0=20
(update_process_times+0x3a)
[ 2275.772701]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -10 hr=
timer_run_queues+0x0=20
(run_local_timers+0x1a)
[ 2275.772722]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -10 ru=
n_local_timers+0x0=20
(update_process_times+0x3a)
[ 2275.772744]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -10 ac=
count_process_tick+0x0=20
(update_process_times+0x35)
[ 2275.772765]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -11 up=
date_process_times+0x0=20
(tick_sched_handle+0x34)
[ 2275.772787]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -11 ti=
ck_sched_handle+0x0=20
(tick_sched_timer+0x38)
[ 2275.772809]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -11 ti=
ck_sched_do_timer+0x0=20
(tick_sched_timer+0x28)
[ 2275.772831]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -11 kt=
ime_get+0x0=20
(tick_sched_timer+0x1a)
[ 2275.772852]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -11 ti=
ck_sched_timer+0x0=20
(__hrtimer_run_queues+0x104)
[ 2275.772874]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0 -11 ipipe_stall_root+0x53=20
(<00000000>)
[ 2275.772895]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0 -1=
1 ipipe_stall_root+0x47=20
(<00000000>)
[ 2275.772917]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0 -11 ipipe_root_only+0x74=20
(<00000000>)
[ 2275.772938]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0 -1=
1 ipipe_root_only+0x68=20
(<00000000>)
[ 2275.772960]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -11 ip=
ipe_root_only+0x0=20
(ipipe_stall_root+0xe)
[ 2275.772981]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -12 ip=
ipe_stall_root+0x0=20
(_raw_spin_unlock_irqrestore+0x1e)
[ 2275.773004]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0 -12 ipipe_root_only+0x74=20
(<00000000>)
[ 2275.773025]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0 -1=
2 ipipe_root_only+0x68=20
(<00000000>)
[ 2275.773046]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -12 ip=
ipe_root_only+0x0=20
(ipipe_restore_root+0xe)
[ 2275.773068]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -12 ip=
ipe_restore_root+0x0=20
(_raw_spin_unlock_irqrestore+0x1e)
[ 2275.773090]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -12=20
_raw_spin_unlock_irqrestore+0x0 (__hrtimer_run_queues+0xf3)
[ 2275.773112]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -12=20
__ipipe_spin_unlock_debug+0x0 (__hrtimer_run_queues+0xe8)
[ 2275.773134]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -12 __=
remove_hrtimer+0x0=20
(__hrtimer_run_queues+0xd8)
[ 2275.773155]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -12 __=
hrtimer_run_queues+0x0=20
(hrtimer_interrupt+0x10e)
[ 2275.773176]=C2=A0=C2=A0=C2=A0 #func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -12=20
ktime_get_update_offsets_now+0x0 (hrtimer_interrupt+0x80)
[ 2275.773198]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0 -12 ipipe_stall_root+0x53=20
(<00000000>)
[ 2275.773220]=C2=A0 | #begin=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=C2=A0 -1=
3 ipipe_stall_root+0x47=20
(<00000000>)
[ 2275.773241]=C2=A0 | #end=C2=A0=C2=A0=C2=A0=C2=A0 0x80000001=C2=A0=C2=A0=
=C2=A0 -13 ipipe_root_only+0x74=20
(<00000000>)



