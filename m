Subject: Re: Stalled head domain on x86_64 platform
References: <4aadb535-828f-271b-4b93-233f1d06c5a1@nicevt.ru>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <338c7546-a7e9-403c-0e1e-790e0959f629@siemens.com>
Date: Tue, 2 Jun 2020 09:43:47 +0200
MIME-Version: 1.0
In-Reply-To: <4aadb535-828f-271b-4b93-233f1d06c5a1@nicevt.ru>
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
To: Alexander Frolov <frolov@nicevt.ru>, xenomai@xenomai.org

On 02.06.20 09:37, Alexander Frolov via Xenomai wrote:
> Hi all!
> 
> I've encountered with the following ipipe error message. What can it be?
> Thank you!
> 
> Best,
>     Alex
> 
> 
> [ 2275.770959] I-pipe: Detected stalled head domain, probably caused by
> a bug.
>                        A critical section may have been left unterminated.
> [ 2275.770965] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W  O     
> 4.19.84-xenomai-nicevt4.debug1 #1
> [ 2275.770968] Hardware name: GIGABYTE MZ31-AR0-00/MZ31-AR0-00, BIOS F13
> 04/15/2019
> [ 2275.770970] I-pipe domain: Linux
> [ 2275.770973] Call Trace:
> [ 2275.770984]  dump_stack+0x8c/0xc0
> [ 2275.770990]  ipipe_root_only.cold+0x11/0x32
> [ 2275.770994]  ipipe_stall_root+0xe/0x60
> [ 2275.770999]  __ipipe_trap_prologue+0x11a/0x300
> [ 2275.771005]  int3+0x45/0x70

You likely have some feature on that uses jump labels. That was
prevented in ipipe-core-4.19.89-x86-9.

Jan

> [ 2275.771010] RIP: 0010:xntimer_start+0x37/0x220
> [ 2275.771013] Code: 89 ce 41 55 49 89 d5 41 54 55 48 89 fd 53 48 83 ec
> 08 48 8b 47 68 4c 8b 25 16 52 2e 01 48 63 40 18 4c 03 24 c5 00 27 2b 98
> cc <fc> 00 00 00 48 8b 4d 38 f6 c1 01 0f 84 43 01 00 00 0f 31 48 c1 e2
> [ 2275.771016] RSP: 0018:ffffa81e4192bd48 EFLAGS: 00000086
> [ 2275.771021] RAX: 0000000000000002 RBX: 0000000000025290 RCX:
> 0000000000000000
> [ 2275.771024] RDX: 0000000000000000 RSI: 00000000000efc6c RDI:
> ffff89691d537270
> [ 2275.771026] RBP: ffff89691d537270 R08: 00000000000000b0 R09:
> 00000211deffb6c0
> [ 2275.771029] R10: 00000211def07480 R11: 00000211def07480 R12:
> ffff89691d542300
> [ 2275.771031] R13: 0000000000000000 R14: 0000000000000000 R15:
> 00000000000efc6c
> [ 2275.771038]  ? xntimer_start+0x37/0x220
> [ 2275.771042]  program_htick_shot+0x8d/0x130
> [ 2275.771047]  clockevents_program_event+0x8d/0xf0
> [ 2275.771052]  hrtimer_interrupt+0x14b/0x250
> [ 2275.771057]  smp_apic_timer_interrupt+0x4e/0x120
> [ 2275.771060]  __ipipe_do_sync_stage+0x167/0x1d0
> [ 2275.771065]  ipipe_unstall_root+0x55/0x60
> [ 2275.771069]  cpuidle_enter_state+0xc9/0x360
> [ 2275.771075]  do_idle+0x1ef/0x280
> [ 2275.771080]  cpu_startup_entry+0x6f/0x80
> [ 2275.771083]  start_secondary+0x178/0x1a0
> [ 2275.771087]  secondary_startup_64+0xa4/0xb0
> [ 2275.771094] I-pipe tracer log (100 points):
> [ 2275.771096]  |*#func                    0
> ipipe_trace_panic_freeze+0x0 (ipipe_root_only+0xcf)
> [ 2275.771120]  |*#func                   -1 ipipe_root_only+0x0
> (ipipe_stall_root+0xe)
> [ 2275.771142]  |*#func                   -1 ipipe_stall_root+0x0
> (__ipipe_trap_prologue+0x11a)
> [ 2275.771164]  |*#func                   -2 ipipe_test_root+0x0
> (__ipipe_trap_prologue+0xc2)
> [ 2275.771186]  |*#func                   -2 __ipipe_trap_prologue+0x0
> (int3+0x45)
> [ 2275.771207]  |*#func                   -2 xntimer_start+0x0
> (program_htick_shot+0x8d)
> [ 2275.771229]  | #begin   0x80000000     -2 program_htick_shot+0xdb
> (<00000000>)
> [ 2275.771251]    #func                   -2 program_htick_shot+0x0
> (clockevents_program_event+0x8d)
> [ 2275.771273]    #func                   -3 ktime_get+0x0
> (clockevents_program_event+0x50)
> [ 2275.771294]    #func                   -3
> clockevents_program_event+0x0 (hrtimer_interrupt+0x14b)
> [ 2275.771316]    #func                   -3 tick_program_event+0x0
> (hrtimer_interrupt+0x14b)
> [ 2275.771338]  | #end     0x80000001     -3 ipipe_stall_root+0x53
> (<00000000>)
> [ 2275.771360]  | #begin   0x80000001     -3 ipipe_stall_root+0x47
> (<00000000>)
> [ 2275.771381]  | #end     0x80000001     -3 ipipe_root_only+0x74
> (<00000000>)
> [ 2275.771402]  | #begin   0x80000001     -3 ipipe_root_only+0x68
> (<00000000>)
> [ 2275.771424]    #func                   -3 ipipe_root_only+0x0
> (ipipe_stall_root+0xe)
> [ 2275.771446]    #func                   -3 ipipe_stall_root+0x0
> (_raw_spin_unlock_irqrestore+0x1e)
> [ 2275.771469]  | #end     0x80000001     -3 ipipe_root_only+0x74
> (<00000000>)
> [ 2275.771490]  | #begin   0x80000001     -4 ipipe_root_only+0x68
> (<00000000>)
> [ 2275.771511]    #func                   -4 ipipe_root_only+0x0
> (ipipe_restore_root+0xe)
> [ 2275.771533]    #func                   -4 ipipe_restore_root+0x0
> (_raw_spin_unlock_irqrestore+0x1e)
> [ 2275.771556]    #func                   -4
> _raw_spin_unlock_irqrestore+0x0 (hrtimer_interrupt+0x13d)
> [ 2275.771577]    #func                   -4
> __ipipe_spin_unlock_debug+0x0 (hrtimer_interrupt+0x132)
> [ 2275.771599]    #func                   -4
> __hrtimer_next_event_base+0x0 (hrtimer_interrupt+0x11b)
> [ 2275.771621]    #func                   -4
> __hrtimer_next_event_base+0x0 (__hrtimer_get_next_event+0x6c)
> [ 2275.771642]    #func                   -4
> __hrtimer_get_next_event+0x0 (hrtimer_interrupt+0x11b)
> [ 2275.771663]    #func                   -4 enqueue_hrtimer+0x0
> (__hrtimer_run_queues+0x137)
> [ 2275.771685]  | #end     0x80000001     -4 ipipe_stall_root+0x53
> (<00000000>)
> [ 2275.771706]  | #begin   0x80000001     -5 ipipe_stall_root+0x47
> (<00000000>)
> [ 2275.771728]  | #end     0x80000001     -5 ipipe_root_only+0x74
> (<00000000>)
> [ 2275.771749]  | #begin   0x80000001     -5 ipipe_root_only+0x68
> (<00000000>)
> [ 2275.771770]    #func                   -5 ipipe_root_only+0x0
> (ipipe_stall_root+0xe)
> [ 2275.771792]    #func                   -5 ipipe_stall_root+0x0
> (_raw_spin_lock_irq+0xe)
> [ 2275.771814]    #func                   -5 _raw_spin_lock_irq+0x0
> (__hrtimer_run_queues+0x114)
> [ 2275.771836]    #func                   -5 hrtimer_forward+0x0
> (tick_sched_timer+0x50)
> [ 2275.771858]    #func                   -5 profile_tick+0x0
> (tick_sched_timer+0x38)
> [ 2275.771880]    #func                   -6 run_posix_cpu_timers+0x0
> (tick_sched_handle+0x34)
> [ 2275.771902]    #func                   -6 trigger_load_balance+0x0
> (update_process_times+0x69)
> [ 2275.771924]    #func                   -6 calc_global_load_tick+0x0
> (scheduler_tick+0x75)
> [ 2275.771946]    #func                   -6 cpu_load_update+0x0
> (scheduler_tick+0x6d)
> [ 2275.771968]    #func                   -6 tick_nohz_tick_stopped+0x0
> (cpu_load_update_active+0x2a)
> [ 2275.771990]    #func                   -6 cpu_load_update_active+0x0
> (scheduler_tick+0x6d)
> [ 2275.772012]    #func                   -6 task_tick_idle+0x0
> (scheduler_tick+0x65)
> [ 2275.772033]    #func                   -7 update_rq_clock.part.0+0x0
> (scheduler_tick+0x4d)
> [ 2275.772055]    #func                   -7 _raw_spin_lock+0x0
> (scheduler_tick+0x3c)
> [ 2275.772077]    #func                   -7 scheduler_tick+0x0
> (update_process_times+0x69)
> [ 2275.772098]  | #end     0x80000001     -7 ipipe_test_root+0x55
> (<00000000>)
> [ 2275.772119]  | #begin   0x80000001     -7 ipipe_test_root+0x40
> (<00000000>)
> [ 2275.772141]    #func                   -7 ipipe_test_root+0x0
> (irq_work_run_list+0xe)
> [ 2275.772163]    #func                   -7 rcu_segcblist_ready_cbs+0x0
> (rcu_check_callbacks+0x167)
> [ 2275.772185]    #func                   -8 rcu_segcblist_ready_cbs+0x0
> (rcu_check_callbacks+0x167)
> [ 2275.772206]    #func                   -8 rcu_all_qs+0x0
> (rcu_check_callbacks+0x363)
> [ 2275.772228]    #func                   -8 rcu_sched_qs+0x0
> (rcu_check_callbacks+0x351)
> [ 2275.772249]    #func                   -8 rcu_check_callbacks+0x0
> (update_process_times+0x41)
> [ 2275.772270]  | #end     0x80000001     -8 ipipe_stall_root+0x53
> (<00000000>)
> [ 2275.772291]  | #begin   0x80000001     -8 ipipe_stall_root+0x47
> (<00000000>)
> [ 2275.772313]  | #end     0x80000001     -9 ipipe_root_only+0x74
> (<00000000>)
> [ 2275.772334]  | #begin   0x80000001     -9 ipipe_root_only+0x68
> (<00000000>)
> [ 2275.772356]    #func                   -9 ipipe_root_only+0x0
> (ipipe_stall_root+0xe)
> [ 2275.772377]    #func                   -9 ipipe_stall_root+0x0
> (update_process_times+0x3a)
> [ 2275.772399]  | #end     0x80000001     -9 ipipe_root_only+0x74
> (<00000000>)
> [ 2275.772420]  | #begin   0x80000001     -9 ipipe_root_only+0x68
> (<00000000>)
> [ 2275.772442]    #func                   -9 ipipe_root_only+0x0
> (ipipe_restore_root+0xe)
> [ 2275.772463]    #func                   -9 ipipe_restore_root+0x0
> (update_process_times+0x3a)
> [ 2275.772485]  | #end     0x80000001     -9 ipipe_stall_root+0x53
> (<00000000>)
> [ 2275.772506]  | #begin   0x80000001     -9 ipipe_stall_root+0x47
> (<00000000>)
> [ 2275.772528]  | #end     0x80000001     -9 ipipe_root_only+0x74
> (<00000000>)
> [ 2275.772549]  | #begin   0x80000001     -9 ipipe_root_only+0x68
> (<00000000>)
> [ 2275.772570]    #func                  -10 ipipe_root_only+0x0
> (ipipe_stall_root+0xe)
> [ 2275.772592]    #func                  -10 ipipe_stall_root+0x0
> (raise_softirq+0x1f)
> [ 2275.772615]  | #end     0x80000001    -10 ipipe_test_root+0x55
> (<00000000>)
> [ 2275.772636]  | #begin   0x80000001    -10 ipipe_test_root+0x40
> (<00000000>)
> [ 2275.772658]    #func                  -10 ipipe_test_root+0x0
> (raise_softirq+0x13)
> [ 2275.772679]    #func                  -10 raise_softirq+0x0
> (update_process_times+0x3a)
> [ 2275.772701]    #func                  -10 hrtimer_run_queues+0x0
> (run_local_timers+0x1a)
> [ 2275.772722]    #func                  -10 run_local_timers+0x0
> (update_process_times+0x3a)
> [ 2275.772744]    #func                  -10 account_process_tick+0x0
> (update_process_times+0x35)
> [ 2275.772765]    #func                  -11 update_process_times+0x0
> (tick_sched_handle+0x34)
> [ 2275.772787]    #func                  -11 tick_sched_handle+0x0
> (tick_sched_timer+0x38)
> [ 2275.772809]    #func                  -11 tick_sched_do_timer+0x0
> (tick_sched_timer+0x28)
> [ 2275.772831]    #func                  -11 ktime_get+0x0
> (tick_sched_timer+0x1a)
> [ 2275.772852]    #func                  -11 tick_sched_timer+0x0
> (__hrtimer_run_queues+0x104)
> [ 2275.772874]  | #end     0x80000001    -11 ipipe_stall_root+0x53
> (<00000000>)
> [ 2275.772895]  | #begin   0x80000001    -11 ipipe_stall_root+0x47
> (<00000000>)
> [ 2275.772917]  | #end     0x80000001    -11 ipipe_root_only+0x74
> (<00000000>)
> [ 2275.772938]  | #begin   0x80000001    -11 ipipe_root_only+0x68
> (<00000000>)
> [ 2275.772960]    #func                  -11 ipipe_root_only+0x0
> (ipipe_stall_root+0xe)
> [ 2275.772981]    #func                  -12 ipipe_stall_root+0x0
> (_raw_spin_unlock_irqrestore+0x1e)
> [ 2275.773004]  | #end     0x80000001    -12 ipipe_root_only+0x74
> (<00000000>)
> [ 2275.773025]  | #begin   0x80000001    -12 ipipe_root_only+0x68
> (<00000000>)
> [ 2275.773046]    #func                  -12 ipipe_root_only+0x0
> (ipipe_restore_root+0xe)
> [ 2275.773068]    #func                  -12 ipipe_restore_root+0x0
> (_raw_spin_unlock_irqrestore+0x1e)
> [ 2275.773090]    #func                  -12
> _raw_spin_unlock_irqrestore+0x0 (__hrtimer_run_queues+0xf3)
> [ 2275.773112]    #func                  -12
> __ipipe_spin_unlock_debug+0x0 (__hrtimer_run_queues+0xe8)
> [ 2275.773134]    #func                  -12 __remove_hrtimer+0x0
> (__hrtimer_run_queues+0xd8)
> [ 2275.773155]    #func                  -12 __hrtimer_run_queues+0x0
> (hrtimer_interrupt+0x10e)
> [ 2275.773176]    #func                  -12
> ktime_get_update_offsets_now+0x0 (hrtimer_interrupt+0x80)
> [ 2275.773198]  | #end     0x80000001    -12 ipipe_stall_root+0x53
> (<00000000>)
> [ 2275.773220]  | #begin   0x80000001    -13 ipipe_stall_root+0x47
> (<00000000>)
> [ 2275.773241]  | #end     0x80000001    -13 ipipe_root_only+0x74
> (<00000000>)
> 
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

