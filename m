From: Lange Norbert <norbert.lange@andritz.com>
Subject: RE: stalled head domain with 3.1rc4
Date: Fri, 13 Dec 2019 12:25:31 +0000
Message-ID: <VI1PR05MB5917FB6355396C28F99B79EDF6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
References: <VI1PR05MB5917452476FF30146D701888F6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <VI1PR05MB591740A31653FE8542171311F6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR05MB591740A31653FE8542171311F6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Same thing with panic trace enabled (another, longer trace with 4000 sample=
s attached)

[  292.743618] I-pipe: Detected stalled head domain, probably caused by a b=
ug.
[  292.743618]         A critical section may have been left unterminated.
[  292.757195] CPU: 0 PID: 1159 Comm: trace-cmd Tainted: G        W        =
 4.19.84-xeno8-static #1
[  292.765986] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.20 08/05/2019
[  292.775304] I-pipe domain: Linux
[  292.778546] Call Trace:
[  292.781005]  <IRQ>
[  292.783034]  dump_stack+0x8c/0xc0
[  292.786363]  ipipe_root_only.cold+0x11/0x32
[  292.790560]  ipipe_stall_root+0xe/0x60
[  292.794322]  __ipipe_trap_prologue+0x11d/0x2f0
[  292.798782]  int3+0x45/0x70
[  292.801592] RIP: 0010:xntimer_start+0x3a/0x330
[  292.806050] Code: 55 49 89 d5 41 54 55 48 89 fd 53 48 83 ec 10 48 8b 47 =
70 4c 8b 37 48 63 40 18 4d 8b a6 90 00 00 00 4c 03 24 c5 00 e3f
[  292.824832] RSP: 0018:ffff97d43ac03e78 EFLAGS: 00000082
[  292.830075] RAX: 0000000000000000 RBX: 0000000000025090 RCX: 00000000000=
00000
[  292.837219] RDX: 0000000000000000 RSI: 00000000000c6130 RDI: ffff97d43ae=
b0708
[  292.844367] RBP: ffff97d43aeb0708 R08: 0000000000000000 R09: 00000000002=
7e6d0
[  292.851514] R10: 00000043f5344961 R11: 00000043f5344961 R12: ffff97d43ae=
bb020
[  292.858658] R13: 0000000000000000 R14: ffffffff9e03bca0 R15: 00000000000=
c6130
[  292.865804]  ? xntimer_start+0x3a/0x330
[  292.869653]  program_htick_shot+0x8d/0x130
[  292.873761]  clockevents_program_event+0x88/0xe0
[  292.878392]  hrtimer_interrupt+0x140/0x230
[  292.882502]  smp_apic_timer_interrupt+0x46/0x110
[  292.887132]  __ipipe_do_sync_stage+0x15d/0x1c0
[  292.891592]  __ipipe_handle_irq+0xa0/0x220
[  292.895699]  ipipe_reschedule_interrupt+0x12/0x40
[  292.900412]  </IRQ>
[  292.902525] RIP: 0010:smp_call_function_many+0x1b6/0x250
[  292.907848] Code: e8 4f 23 6c 00 3b 05 5d 5f 01 01 89 c7 0f 83 c4 fe ff =
ff 48 63 c7 48 8b 0b 48 03 0c c5 00 e3 f1 9d 8b 41 18 a8 01 745
[  292.926626] RSP: 0018:ffffab24c0c9bb40 EFLAGS: 00000202 ORIG_RAX: ffffff=
ffffffff15
[  292.934210] RAX: 0000000000000003 RBX: ffff97d43aeb4c00 RCX: ffff97d43b2=
b7ac0
[  292.941357] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000000=
00001
[  292.948500] RBP: ffffffff9d017b70 R08: ffff97d43aeb4c08 R09: 00000000000=
2e248
[  292.955644] R10: ffff97d43aeb7780 R11: ffff97d43a003800 R12: 00000000000=
00000
[  292.962789] R13: ffff97d43aeb4c08 R14: 0000000000000004 R15: 00000000000=
00001
[  292.969936]  ? optimize_nops.isra.0+0x90/0x90
[  292.974306]  ? optimize_nops.isra.0+0x90/0x90
[  292.978673]  ? xntimer_start+0x39/0x330
[  292.982519]  ? xntimer_start+0x3a/0x330
[  292.986368]  on_each_cpu+0x28/0x50
[  292.989782]  ? xntimer_start+0x39/0x330
[  292.993630]  text_poke_bp+0x68/0xde
[  292.997128]  ? trace_event_raw_event_cobalt_thread_suspend+0xe0/0xe0
[  293.003495]  __jump_label_transform.isra.0+0x102/0x150
[  293.008645]  arch_jump_label_transform+0x2e/0x40
[  293.013276]  __jump_label_update+0x67/0xa0
[  293.017382]  static_key_slow_inc_cpuslocked+0x75/0x80
[  293.022445]  static_key_slow_inc+0x16/0x20
[  293.026555]  tracepoint_probe_register_prio+0x1f3/0x2a0
[  293.031790]  ? trace_event_raw_event_cobalt_thread_suspend+0xe0/0xe0
[  293.038155]  __ftrace_event_enable_disable+0x6f/0x230
[  293.043217]  __ftrace_set_clr_event_nolock+0xe6/0x130
[  293.048280]  system_enable_write+0xaa/0xe0
[  293.052392]  do_iter_write+0x140/0x180
[  293.056151]  vfs_writev+0xa6/0xf0
[  293.059484]  do_writev+0x5f/0x100
[  293.062813]  do_syscall_64+0x82/0x4e0
[  293.066489]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  293.071554] RIP: 0033:0x45874c
[  293.074619] Code: ed 01 48 29 d0 49 83 c5 10 49 8b 55 08 48 63 dd 48 29 =
c2 49 01 45 00 49 89 55 08 49 63 7f 78 4c 89 e0 4c 89 ee 48 898
[  293.093397] RSP: 002b:00007ffc91a57a00 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000014
[  293.100983] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00000000004=
5874c
[  293.108129] RDX: 0000000000000002 RSI: 00007ffc91a57a10 RDI: 00000000000=
00005
[  293.115275] RBP: 0000000000000002 R08: 0000000000b7d4e0 R09: 80808080808=
08080
[  293.122422] R10: 0000000000000005 R11: 0000000000000202 R12: 00000000000=
00014
[  293.129569] R13: 00007ffc91a57a10 R14: 0000000000000001 R15: 0000000000b=
7d4e0
[  293.136722] I-pipe tracer log (100 points):
[  293.140917]  |*#func                    0 ipipe_trace_panic_freeze+0x0 (=
ipipe_root_only+0xcf)
[  293.149511]  |*#func                    0 ipipe_root_only+0x0 (ipipe_sta=
ll_root+0xe)
[  293.157323]  |*#func                   -1 ipipe_stall_root+0x0 (__ipipe_=
trap_prologue+0x11d)
[  293.165833]  |*#func                   -1 ipipe_test_root+0x0 (__ipipe_t=
rap_prologue+0xbf)
[  293.174165]  |*#func                   -2 __ipipe_trap_prologue+0x0 (int=
3+0x45)
[  293.181541]  |*#func                   -2 xntimer_start+0x0 (program_hti=
ck_shot+0x8d)
[  293.189440]  | #begin   0x80000000     -3 program_htick_shot+0xdb (<0000=
0000>)
[  293.196726]    #func                   -3 program_htick_shot+0x0 (clocke=
vents_program_event+0x88)
[  293.205665]    #func                   -4 ktime_get+0x0 (clockevents_pro=
gram_event+0x4d)
[  293.213823]    #func                   -4 clockevents_program_event+0x0 =
(hrtimer_interrupt+0x140)
[  293.222759]    #func                   -5 tick_program_event+0x0 (hrtime=
r_interrupt+0x140)
[  293.231092]  | #end     0x80000001     -5 ipipe_stall_root+0x53 (<000000=
00>)
[  293.238207]  | #begin   0x80000001     -5 ipipe_stall_root+0x47 (<000000=
00>)
[  293.245323]  | #end     0x80000001     -6 ipipe_root_only+0x74 (<0000000=
0>)
[  293.252354]  | #begin   0x80000001     -6 ipipe_root_only+0x68 (<0000000=
0>)
[  293.259382]    #func                   -6 ipipe_root_only+0x0 (ipipe_sta=
ll_root+0xe)
[  293.267193]    #func                   -7 ipipe_stall_root+0x0 (_raw_spi=
n_unlock_irqrestore+0x1e)
[  293.276135]  | #end     0x80000001     -7 ipipe_root_only+0x74 (<0000000=
0>)
[  293.283167]  | #begin   0x80000001     -8 ipipe_root_only+0x68 (<0000000=
0>)
[  293.290198]    #func                   -8 ipipe_root_only+0x0 (ipipe_res=
tore_root+0xe)
[  293.298185]    #func                   -8 ipipe_restore_root+0x0 (_raw_s=
pin_unlock_irqrestore+0x1e)
[  293.307302]    #func                   -9 _raw_spin_unlock_irqrestore+0x=
0 (hrtimer_interrupt+0x132)
[  293.316416]    #func                   -9 __ipipe_spin_unlock_debug+0x0 =
(hrtimer_interrupt+0x127)
[  293.325358]    #func                   -9 __hrtimer_next_event_base+0x0 =
(hrtimer_interrupt+0x113)
[  293.334300]    #func                  -10 __hrtimer_next_event_base+0x0 =
(__hrtimer_get_next_event+0x6c)
[  293.343762]    #func                  -10 __hrtimer_get_next_event+0x0 (=
hrtimer_interrupt+0x113)
[  293.352615]    #func                  -11 enqueue_hrtimer+0x0 (__hrtimer=
_run_queues+0x12f)
[  293.360946]  | #end     0x80000001    -11 ipipe_stall_root+0x53 (<000000=
00>)
[  293.368061]  | #begin   0x80000001    -12 ipipe_stall_root+0x47 (<000000=
00>)
[  293.375177]  | #end     0x80000001    -12 ipipe_root_only+0x74 (<0000000=
0>)
[  293.382204]  | #begin   0x80000001    -13 ipipe_root_only+0x68 (<0000000=
0>)
[  293.389233]    #func                  -13 ipipe_root_only+0x0 (ipipe_sta=
ll_root+0xe)
[  293.397045]    #func                  -13 ipipe_stall_root+0x0 (_raw_spi=
n_lock_irq+0xe)
[  293.405119]    #func                  -14 _raw_spin_lock_irq+0x0 (__hrti=
mer_run_queues+0x10d)
[  293.413712]    #func                  -14 hrtimer_forward+0x0 (tick_sche=
d_timer+0x50)
[  293.421610]    #func                  -14 profile_tick+0x0 (tick_sched_t=
imer+0x38)
[  293.429252]    #func                  -15 run_posix_cpu_timers+0x0 (tick=
_sched_handle+0x34)
[  293.437675]    #func                  -15 nohz_balance_exit_idle+0x0 (tr=
igger_load_balance+0x55)
[  293.446530]    #func                  -15 trigger_load_balance+0x0 (upda=
te_process_times+0x69)
[  293.455207]    #func                  -16 calc_global_load_tick+0x0 (sch=
eduler_tick+0x6d)
[  293.463456]    #func                  -16 cpu_load_update+0x0 (scheduler=
_tick+0x65)
[  293.471184]    #func                  -17 tick_nohz_tick_stopped+0x0 (cp=
u_load_update_active+0x2a)
[  293.480207]    #func                  -17 cpu_load_update_active+0x0 (sc=
heduler_tick+0x65)
[  293.488539]    #func                  -17 hrtimer_active+0x0 (task_tick_=
fair+0x72)
[  293.496176]    #func                  -18 account_entity_enqueue+0x0 (re=
weight_entity+0x15b)
[  293.504682]    #func                  -18 account_entity_dequeue+0x0 (re=
weight_entity+0x33)
[  293.513099]    #func                  -19 update_curr+0x0 (reweight_enti=
ty+0x194)
[  293.520651]    #func                  -19 reweight_entity+0x0 (task_tick=
_fair+0x55)
[  293.528373]    #func                  -19 update_cfs_group+0x0 (task_tic=
k_fair+0x55)
[  293.536186]    #func                  -20 __accumulate_pelt_segments+0x0=
 (__update_load_avg_cfs_rq+0x1d5)
[  293.545822]    #func                  -20 __update_load_avg_cfs_rq+0x0 (=
update_load_avg+0x81)
[  293.554415]    #func                  -20 __accumulate_pelt_segments+0x0=
 (__update_load_avg_se+0x231)
[  293.563703]    #func                  -21 __update_load_avg_se+0x0 (upda=
te_load_avg+0x341)
[  293.572034]    #func                  -21 update_min_vruntime+0x0 (updat=
e_curr+0x73)
[  293.579846]    #func                  -22 update_curr+0x0 (task_tick_fai=
r+0x3d)
[  293.587227]    #func                  -22 hrtimer_active+0x0 (task_tick_=
fair+0x72)
[  293.594863]    #func                  -22 update_cfs_group+0x0 (task_tic=
k_fair+0x55)
[  293.602675]    #func                  -23 __accumulate_pelt_segments+0x0=
 (__update_load_avg_cfs_rq+0x1d5)
[  293.612310]    #func                  -23 __update_load_avg_cfs_rq+0x0 (=
update_load_avg+0x81)
[  293.620902]    #func                  -24 __accumulate_pelt_segments+0x0=
 (__update_load_avg_se+0x231)
[  293.630194]    #func                  -24 __update_load_avg_se+0x0 (upda=
te_load_avg+0x341)
[  293.638525]    #func                  -25 cgroup_rstat_updated+0x0 (__cg=
roup_account_cputime+0x24)
[  293.647558]    #func                  -25 __cgroup_account_cputime+0x0 (=
update_curr+0x101)
[  293.655891]    #func                  -26 cpuacct_charge+0x0 (update_cur=
r+0xe4)
[  293.663270]    #func                  -26 update_min_vruntime+0x0 (updat=
e_curr+0x73)
[  293.671087]    #func                  -26 update_curr+0x0 (task_tick_fai=
r+0x3d)
[  293.678468]    #func                  -27 task_tick_fair+0x0 (scheduler_=
tick+0x5d)
[  293.686107]    #func                  -27 __accumulate_pelt_segments+0x0=
 (update_irq_load_avg+0x22c)
[  293.695310]    #func                  -28 update_irq_load_avg+0x0 (sched=
uler_tick+0x4b)
[  293.703381]    #func                  -28 update_rq_clock+0x0 (scheduler=
_tick+0x4b)
[  293.711104]    #func                  -28 _raw_spin_lock+0x0 (scheduler_=
tick+0x3c)
[  293.718744]    #func                  -29 scheduler_tick+0x0 (update_pro=
cess_times+0x69)
[  293.726901]  | #end     0x80000001    -29 ipipe_test_root+0x55 (<0000000=
0>)
[  293.733930]  | #begin   0x80000001    -30 ipipe_test_root+0x40 (<0000000=
0>)
[  293.740959]    #func                  -30 ipipe_test_root+0x0 (irq_work_=
run_list+0xe)
[  293.748862]    #func                  -30 rcu_segcblist_ready_cbs+0x0 (r=
cu_check_callbacks+0x16d)
[  293.757803]    #func                  -31 rcu_segcblist_ready_cbs+0x0 (r=
cu_check_callbacks+0x16d)
[  293.766742]    #func                  -31 rcu_check_callbacks+0x0 (updat=
e_process_times+0x41)
[  293.775335]  | #end     0x80000001    -32 ipipe_stall_root+0x53 (<000000=
00>)
[  293.782451]  | #begin   0x80000001    -32 ipipe_stall_root+0x47 (<000000=
00>)
[  293.789569]  | #end     0x80000001    -32 ipipe_root_only+0x74 (<0000000=
0>)
[  293.796601]  | #begin   0x80000001    -33 ipipe_root_only+0x68 (<0000000=
0>)
[  293.803633]    #func                  -33 ipipe_root_only+0x0 (ipipe_sta=
ll_root+0xe)
[  293.811445]    #func                  -33 ipipe_stall_root+0x0 (update_p=
rocess_times+0x3a)
[  293.819778]  | #end     0x80000001    -34 ipipe_root_only+0x74 (<0000000=
0>)
[  293.826809]  | #begin   0x80000001    -34 ipipe_root_only+0x68 (<0000000=
0>)
[  293.833837]    #func                  -35 ipipe_root_only+0x0 (ipipe_res=
tore_root+0xe)
[  293.841821]    #func                  -35 ipipe_restore_root+0x0 (update=
_process_times+0x3a)
[  293.850327]  | #end     0x80000001    -35 ipipe_stall_root+0x53 (<000000=
00>)
[  293.857444]  | #begin   0x80000001    -36 ipipe_stall_root+0x47 (<000000=
00>)
[  293.864560]  | #end     0x80000001    -36 ipipe_root_only+0x74 (<0000000=
0>)
[  293.871590]  | #begin   0x80000001    -37 ipipe_root_only+0x68 (<0000000=
0>)
[  293.878622]    #func                  -37 ipipe_root_only+0x0 (ipipe_sta=
ll_root+0xe)
[  293.886434]    #func                  -37 ipipe_stall_root+0x0 (raise_so=
ftirq+0x1f)
[  293.894163]  | #end     0x80000001    -38 ipipe_test_root+0x55 (<0000000=
0>)
[  293.901192]  | #begin   0x80000001    -38 ipipe_test_root+0x40 (<0000000=
0>)
[  293.908221]    #func                  -38 ipipe_test_root+0x0 (raise_sof=
tirq+0x13)
[  293.915861]    #func                  -39 raise_softirq+0x0 (update_proc=
ess_times+0x3a)
[  293.923933]    #func                  -39 hrtimer_run_queues+0x0 (run_lo=
cal_timers+0x1a)
[  293.932092]    #func                  -39 run_local_timers+0x0 (update_p=
rocess_times+0x3a)
[  293.960301] Scheduler tracepoints stat_sleep, stat_iowait, stat_blocked =
and stat_runtime require the kernel parameter schedstats=3Denabl1

> -----Original Message-----
> From: Lange Norbert <norbert.lange@andritz.com>
> Sent: Freitag, 13. Dezember 2019 11:54
> To: Lange Norbert <norbert.lange@andritz.com>
> Cc: Philippe Gerum (rpm@xenomai.org) <rpm@xenomai.org>
> Subject: RE: stalled head domain with 3.1rc4
>
> I now removed calls to recv/send_mmsg and instead call the single *msg
> variant in a loop. This makes the bug appear less, but it now triggered o=
nce
> when stopping the trace, so there might be goods in there for you.
> (the last sendmsg/recvmsg pair at 1842.622889 -> 1842.622956  is the IDDP
> socket to wakeup the other process)
>
> [ 1842.420470] I-pipe: Detected stalled head domain, probably caused by a
> bug.
> [ 1842.420470]         A critical section may have been left unterminated.
> [ 1842.434053] CPU: 0 PID: 1353 Comm: trace-cmd Not tainted 4.19.84-xeno8-
> static #1 [ 1842.441456] Hardware name: TQ-Group TQMxE39M/Type2 -
> Board Product Name, BIOS 5.12.30.21.20 08/05/2019 [ 1842.450773] I-pipe
> domain: Linux [ 1842.454014] Call Trace:
> [ 1842.456472]  <IRQ>
> [ 1842.458502]  dump_stack+0x8c/0xc0
> [ 1842.461829]  ipipe_stall_root+0xc/0x30 [ 1842.465591]
> __ipipe_trap_prologue+0x100/0x210 [ 1842.470045]  int3+0x45/0x70 [
> 1842.472854] RIP: 0010:xntimer_start+0x3a/0x330 [ 1842.477308] Code: 55 49
> 89 d5 41 54 55 48 89 fd 53 48 83 ec 10 48 8b 47 70 4c 8b 37 48 63 40 18 4=
d 8b a6
> 90 00 00 00 4c 03 24 c5 00 d3f [ 1842.496083] RSP: 0018:ffff8fe9fba03e80
> EFLAGS: 00000082 [ 1842.501324] RAX: 0000000000000000 RBX:
> 0000000000025090 RCX: 0000000000000000 [ 1842.508468] RDX:
> 0000000000000000 RSI: 000000000003b55f RDI: ffff8fe9fba305c8 [
> 1842.515609] RBP: ffff8fe9fba305c8 R08: 0000000000000000 R09:
> 000001acc52f873d [ 1842.522754] R10: 000001acc52b974d R11:
> 000001acc52b974d R12: ffff8fe9fba3aee0 [ 1842.529898] R13:
> 0000000000000000 R14: ffffffffb223bbe0 R15: 000000000003b55f [
> 1842.537044]  ? xntimer_start+0x3a/0x330 [ 1842.540889]  ?
> enqueue_hrtimer+0x36/0x90 [ 1842.544823]
> program_htick_shot+0x83/0x100 [ 1842.548931]
> clockevents_program_event+0x88/0xe0
> [ 1842.553561]  hrtimer_interrupt+0x140/0x230 [ 1842.557669]
> smp_apic_timer_interrupt+0x46/0x110
> [ 1842.562296]  __ipipe_do_sync_stage+0x130/0x180 [ 1842.566751]
> __ipipe_handle_irq+0x94/0x200 [ 1842.570860]
> apic_timer_interrupt+0x12/0x40 [ 1842.575054]  </IRQ> [ 1842.577163] RIP:
> 0010:smp_call_function_many+0x1b6/0x250
> [ 1842.582485] Code: e8 6f a0 6b 00 3b 05 dd 60 01 01 89 c7 0f 83 c4 fe f=
f ff 48
> 63 c7 48 8b 0b 48 03 0c c5 00 d3 11 b2 8b 41 18 a8 01 745 [ 1842.601264] =
RSP:
> 0018:ffff957380bbfba8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13 [
> 1842.608846] RAX: 0000000000000003 RBX: ffff8fe9fba34ac0 RCX:
> ffff8fe9fbbb8680 [ 1842.615989] RDX: 0000000000000001 RSI:
> 0000000000000000 RDI: 0000000000000003 [ 1842.623133] RBP:
> ffffffffb12179a0 R08: ffff8fe9fba34ac8 R09: 0000000000000000 [ 1842.63027=
6]
> R10: 000000000000000a R11: f000000000000000 R12: 0000000000000000 [
> 1842.637417] R13: ffff8fe9fba34ac8 R14: 0000000000000004 R15:
> 0000000000000001 [ 1842.644565]  ? optimize_nops.isra.0+0x90/0x90 [
> 1842.648934]  ? smp_call_function_many+0x191/0x250
> [ 1842.653650]  ? optimize_nops.isra.0+0x90/0x90 [ 1842.658015]  ?
> xntimer_start+0x39/0x330 [ 1842.661859]  ? xntimer_start+0x3a/0x330 [
> 1842.665705]  on_each_cpu+0x28/0x50 [ 1842.669116]  ?
> xntimer_start+0x39/0x330 [ 1842.672959]  text_poke_bp+0x91/0xde [
> 1842.676460]  __jump_label_transform.isra.0+0x102/0x150
> [ 1842.681610]  arch_jump_label_transform+0x2e/0x40
> [ 1842.686239]  __jump_label_update+0x67/0xa0 [ 1842.690348]
> __static_key_slow_dec_cpuslocked+0x30/0x80
> [ 1842.695583]  static_key_slow_dec+0x23/0x50 [ 1842.699689]
> tracepoint_probe_unregister+0x176/0x1b0
> [ 1842.704661]  trace_event_reg+0x31/0xa0 [ 1842.708421]  ?
> mutex_lock+0x13/0x30 [ 1842.711921]
> __ftrace_event_enable_disable+0x120/0x230
> [ 1842.717072]  __ftrace_set_clr_event_nolock+0xe6/0x130
> [ 1842.722133]  system_enable_write+0xaa/0xe0 [ 1842.726240]
> __vfs_write+0x34/0x190 [ 1842.729739]  ? __check_heap_object+0x5/0x120
> [ 1842.734021]  ? __check_object_size+0x136/0x147 [ 1842.738474]  ?
> rcu_all_qs+0x5/0x80 [ 1842.741884]  vfs_write+0xb6/0x190 [ 1842.745210]
> ksys_write+0x57/0xd0 [ 1842.748537]  do_syscall_64+0x78/0x3c0 [
> 1842.752212]  ? __do_page_fault+0x207/0x400 [ 1842.756319]
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1842.761381] RIP: 0033:0x45f5d9
> [ 1842.764444] Code: 89 d6 0f 05 c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 4=
8 89 f8
> 4d 89 c2 48 89 f7 4d 89 c8 48 89 d6 4c 8b 4c 24 08 48 890 [ 1842.783220] =
RSP:
> 002b:00007fff22863618 EFLAGS: 00000246 ORIG_RAX: 0000000000000001 [
> 1842.790801] RAX: ffffffffffffffda RBX: 00000000004013b0 RCX:
> 000000000045f5d9 [ 1842.797944] RDX: 0000000000000001 RSI:
> 00007fff2286365f RDI: 0000000000000005 [ 1842.805086] RBP:
> 00007fff228636c0 R08: 0000000000000000 R09: 0000000000000000 [
> 1842.812230] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00007fff22863848 [ 1842.819372] R13: 00007fff22863870 R14:
> 0000000000000000 R15: 0000000000000000
>
>
> > -----Original Message-----
> > From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Lange
> Norbert
> > via Xenomai
> > Sent: Freitag, 13. Dezember 2019 11:16
> > To: Xenomai (xenomai@xenomai.org) <xenomai@xenomai.org>
> > Subject: stalled head domain with 3.1rc4
> >
> > NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
> ATTACHMENTS.
> >
> >
> > Just had a bug msg pop up. Its triggered by enabling tracing, while we
> > have 2 processes running, using IDDP, XDDP and RTNet (just packet
> > sockets, no ip stack).
> > Some points:
> >
> > -       trace-cmd stores in tmp, so shouldn't touch other filesystems t=
han
> > tmpfs, sysfs
> >
> > -       upon starting this, our process complains about a 150ms hole in=
 CPU
> time
> > (likely the time of the bug)
> >
> > -       it seems to happen only the first time after a boot
> >
> > -       running trace-cmd "dry" (without our processes) doesn't trigger=
 the
> bug.
> > Neither when disabling active communication on our project (per
> > millisecond up to 15 eth packets in both directions via packet socket,
> > using the new send/recv_mmsg calls).
> >
> > -       system seems to continue stable afterwards
> >
> > -       a trace is attached, not after triggering the bug (then it woul=
d just
> > contain our project in error state) but showing or project with active
> > communication  (ie. trace-cmd started a second time after a bug)
> >
> >
> > # trace-cmd record -e 'cobalt*'
> > [  160.443596] I-pipe: Detected stalled head domain, probably caused
> > by a bug.
> > [  160.443596]         A critical section may have been left unterminat=
ed.
> > [  160.457178] CPU: 1 PID: 0 Comm: swapper/1 Not tainted
> > 4.19.84-xeno8- static #1 [  160.464323] Hardware name: TQ-Group
> > TQMxE39M/Type2 - Board Product Name, BIOS 5.12.30.21.20 08/05/2019 [
> > 160.473640] I-pipe domain: Linux [  160.476877] Call Trace:
> > [  160.479345]  dump_stack+0x8c/0xc0
> > [  160.482672]  ipipe_stall_root+0xc/0x30 [  160.486436]
> > __ipipe_trap_prologue+0x100/0x210 [  160.490894]  int3+0x45/0x70 [
> > 160.493702] RIP: 0010:xnthread_resume+0x75/0x3a0 [  160.498329] Code:
> > 0f eb 00 74 21 31 c0 ba 01 00 00 00 f0 0f b1 15 c5 0f eb 00
> > 85 c0 0f 85 db 02 00 00 4c 8b 2c 24 89 1d af 0f eb 00 4d0 [
> > 160.517108] RSP: 0018:ffff9934400a7dd8 EFLAGS: 00000046 [  160.522349]
> > RAX: 0000000000000001 RBX: 0000000000000001 RCX:
> > 00007f37aa603700
> > [  160.529490] RDX: 0000000000000001 RSI: 0000000000000080 RDI:
> > ffff9934405dc240
> > [  160.536631] RBP: ffff9934405dc240 R08: 00000000000f7df7 R09:
> > ffff9140f8cb2800
> > [  160.543774] R10: 00000000000003b3 R11: 00000000000b8c4a R12:
> > 0000000000025090
> > [  160.550918] R13: 0000000000000003 R14: 0000000000000080 R15:
> > 0000000000000080
> > [  160.558064]  ? xnthread_resume+0x75/0x3a0 [  160.562083]  ?
> > xnthread_resume+0x1f/0x3a0 [  160.566104]
> > ipipe_migration_hook+0xda/0x1d0 [  160.570385]
> > complete_domain_migration+0x79/0xe0
> > [  160.575011]  __ipipe_switch_tail+0x39/0x50 [  160.579118]
> > __schedule+0x2d0/0x890 [  160.582615]  schedule_idle+0x28/0x40 [
> > 160.586203]  do_idle+0x101/0x130 [  160.589440]
> > cpu_startup_entry+0x6f/0x80 [  160.593373]
> > start_secondary+0x169/0x1b0 [  160.597312]
> > secondary_startup_64+0xa4/0xb0
> >
> >
> >
> > Mit besten Gr=FC=DFen / Kind regards
> >
> > NORBERT LANGE
> >
> > AT-RD3
> >
> > ANDRITZ HYDRO GmbH
> > Eibesbrunnergasse 20
> > 1120 Vienna / AUSTRIA
> > p: +43 50805 56684
> > norbert.lange@andritz.com<mailto:norbert.lange@andritz.com>
> > andritz.com<http://www.andritz.com/>
> >
> > ________________________________
> >
> > This message and any attachments are solely for the use of the
> > intended recipients. They may contain privileged and/or confidential
> > information or other information protected from disclosure. If you are
> > not an intended recipient, you are hereby notified that you received
> > this email in error and that any review, dissemination, distribution
> > or copying of this email and any attachment is strictly prohibited. If
> > you have received this email in error, please contact the sender and
> > delete the message and any attachment from your system.
> >
> > ANDRITZ HYDRO GmbH
> >
> >
> > Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung /
> > Corporation
> >
> > Firmensitz/ Registered seat: Wien
> >
> > Firmenbuchgericht/ Court of registry: Handelsgericht Wien
> >
> > Firmenbuchnummer/ Company registration: FN 61833 g
> >
> > DVR: 0605077
> >
> > UID-Nr.: ATU14756806
> >
> >
> > Thank You
> > ________________________________
> > -------------- next part -------------- A non-text attachment was
> > scrubbed...
> > Name: trace.dat.xz
> > Type: application/octet-stream
> > Size: 2775472 bytes
> > Desc: trace.dat.xz
> > URL:
> >
> <http://xenomai.org/pipermail/xenomai/attachments/20191213/0e1c8638/a
> > ttachment.obj>
________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung / Corporati=
on

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: panictrace.txt
URL: <http://xenomai.org/pipermail/xenomai/attachments/20191213/37c78c84/at=
tachment.txt>
