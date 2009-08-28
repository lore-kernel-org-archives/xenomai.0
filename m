MIME-Version: 1.0
Date: Fri, 28 Aug 2009 14:50:55 -0300
Message-ID: <7a15153d0908281050l56343b26g45a8f66b87c839e9@domain.hid>
From: Felipe Castro <felipecpc1@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64c2a4874f8d10472375354
Subject: [Xenomai-core] [PXA + Xenomai] Latency program
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--0016e64c2a4874f8d10472375354
Content-Type: text/plain; charset=ISO-8859-1

Hi ,

I'm trying xenomai running on PXA270 Voipac module.
Acctually i have a problem when running the lantency test program.

The module loads OK , but when i run latency program:

[  110.874334] Xenomai: starting native API services.
[  282.865308] I-pipe: Detected illicit call from domain 'Xenomai'
[  282.865356]         into a service reserved for domain 'Linux' and below.
[  282.903226] [<c0023068>] (dump_stack+0x0/0x18) from [<c006cbcc>]
(ipipe_check_context+0xdc/0x100)
[  282.929809] [<c006caf0>] (ipipe_check_context+0x0/0x100) from
[<c0066168>] (module_address_lookup+0x34/0x108)
[  282.959374] [<c0066134>] (module_address_lookup+0x0/0x108) from
[<c00670e4>] (kallsyms_lookup+0x7c/0x80)
[  282.987650] [<c0067068>] (kallsyms_lookup+0x0/0x80) from [<c0067208>]
(sprint_symbol+0x38/0xb0)
[  283.013599] [<c00671d0>] (sprint_symbol+0x0/0xb0) from [<c00672a4>]
(__print_symbol+0x24/0x38)
[  283.039294]  r6:c03334f8 r5:c7035e24 r4:c02b5728
[  283.053066] [<c0067280>] (__print_symbol+0x0/0x38) from [<c007cfec>]
(xnpod_trap_fault+0xc8/0x258)
[  283.079818]  r5:c7040810 r4:c7035f40
[  283.090466] [<c007cf24>] (xnpod_trap_fault+0x0/0x258) from [<c0073b30>]
(xnarch_trap_fault+0x24/0x2c)
[  283.117967]  r6:c0330cc4 r5:c02f6c48 r4:c0332950
[  283.131742] [<c0073b0c>] (xnarch_trap_fault+0x0/0x2c) from [<c01dcd38>]
(exception_event+0x50/0x74)
[  283.158751] [<c01dcce8>] (exception_event+0x0/0x74) from [<c006bbac>]
(__ipipe_dispatch_event+0xdc/0x1e8)
[  283.187285]  r4:00000000
[  283.194805] [<c006bad0>] (__ipipe_dispatch_event+0x0/0x1e8) from
[<c001ee04>] (do_fpe+0x18/0x3c)
[  283.221016] I-pipe tracer log (100 points):
[  283.233469]  | +  func                    0 ipipe_trace_panic_freeze+0x10
(ipipe_check_context+0x5c)
[  283.260735]  | +  func                   -4 ipipe_check_context+0x10
(module_address_lookup+0x34)
[  283.287176]  | +  func                   -6 module_address_lookup+0x10
(kallsyms_lookup+0x7c)
[  283.312583]  | +  func                  -10 in_gate_area_no_task+0x10
(is_ksym_addr+0x34)
[  283.336956]  | +  func                  -13 is_ksym_addr+0x10
(kallsyms_lookup+0x38)
[  283.360036]  | +  func                  -15 kallsyms_lookup+0x14
(sprint_symbol+0x38)
[  283.383375]  | +  func                  -18 sprint_symbol+0x14
(__print_symbol+0x24)
[  283.406456]  | +  func                  -21 __print_symbol+0x14
(xnpod_trap_fault+0xc8)
[  283.430313]  | +  func                  -24 xnpod_trap_fault+0x14
(xnarch_trap_fault+0x24)
[  283.454943]  | +  func                  -27 xnarch_trap_fault+0x14
(exception_event+0x50)
[  283.479316]  | +  func                  -30 exception_event+0x10
(__ipipe_dispatch_event+0xdc)
[  283.504982]  | +  func                  -34 __ipipe_dispatch_event+0x14
(do_fpe+0x18)
[  283.528320]  | +  end     0x80000001    -45 __ipipe_dispatch_event+0x1c8
(__ipipe_syscall_root+0x80)
[  283.555562]  | +  begin   0x80000001    -48 __ipipe_dispatch_event+0x104
(__ipipe_syscall_root+0x80)
[  283.582778]  | +  end     0x80000000    -52
ipipe_unstall_pipeline_head+0x90 (xnshadow_harden+0x1a0)
[  283.610021]  | #  begin   0x80000000    -56
ipipe_unstall_pipeline_head+0x34 (xnshadow_harden+0x1a0)
[  283.637262]    #  func                  -58
ipipe_unstall_pipeline_head+0x10 (xnshadow_harden+0x1a0)
[  283.664477]    #  func                  -63 xnpod_switch_fpu+0x10
(xnshadow_harden+0x190)
[  283.688851]  | #  end     0x80000001    -66 __sched_text_start+0x6d0
(xnshadow_harden+0xa8)
[  283.713793]  | #  begin   0x80000001    -69 __sched_text_start+0x6b8
(xnshadow_harden+0xa8)
[  283.738707]  | #  end     0x80000000    -71 __sched_text_start+0x65c
(xnshadow_harden+0xa8)
[  283.763597]  | #  [  304] telnetd -1    -92 xnpod_schedule+0xb4
(xnpod_schedule_handler+0x54)
[  283.789056]  | #  func                  -95 xnpod_schedule+0x14
(xnpod_schedule_handler+0x54)
[  283.814463]  | #  func                  -98 xnpod_schedule_handler+0x10
(__ipipe_sync_stage+0x1b4)
[  283.841162]  | +  func                 -101 __ipipe_sync_stage+0x10
(ipipe_suspend_domain+0xa4)
[  283.867086]  | +  func                 -104 ipipe_suspend_domain+0x10
(__ipipe_walk_pipeline+0x74)
[  283.893783]  |   +func                 -108 __ipipe_walk_pipeline+0x10
(__ipipe_restore_pipeline_head+0xc4)
[  283.922809]  | * +func                 -111
__ipipe_restore_pipeline_head+0x10 (gatekeeper_thread+0x180)
[  283.951058]  | * +func                 -116 __ipipe_set_irq_pending+0x10
(__ipipe_dispatch_wired+0x7c)
[  283.978792]  | * +func                 -120 __ipipe_dispatch_wired+0x10
(__ipipe_handle_irq+0xa4)
[  284.005233]  | * +func                 -124 __ipipe_handle_irq+0x10
(ipipe_trigger_irq+0x7c)
[  284.030381]  | * +func                 -128 ipipe_trigger_irq+0x10
(xnpod_schedule+0x34)
[  284.054494]  | * +func                 -130 xnpod_schedule+0x14
(gatekeeper_thread+0x164)
[  284.078868]  | * +func                 -133 disengage_irq_shield+0x10
(gatekeeper_thread+0x160)
[  284.104792]  | * +[  342] display- 0   -142 xnpod_resume_thread+0x70
(gatekeeper_thread+0x15c)
[  284.130509]  | * +func                 -145 xnpod_resume_thread+0x14
(gatekeeper_thread+0x15c)
[  284.156173]  |   +begin   0x80000000   -147 gatekeeper_thread+0x140
(kthread+0x58)
[  284.178789]  |   +end     0x80000000   -150
__ipipe_restore_pipeline_head+0xd8 (rpi_pop+0x4cc)
[  284.204454]  | * +func                 -153
__ipipe_restore_pipeline_head+0x10 (rpi_pop+0x4cc)
[  284.230119]  |   +begin   0x80000000   -157 rpi_pop+0x38
(gatekeeper_thread+0x120)
[  284.252709]      +func                 -159 rpi_pop+0x14
(gatekeeper_thread+0x120)
[  284.275273]      +func                 -162 kthread_should_stop+0x10
(gatekeeper_thread+0xf8)
[  284.300680]      +func                 -165 ipipe_check_context+0x10
(__sched_text_start+0x750)
[  284.326603]      +func                 -168 finish_task_switch+0x10
(__sched_text_start+0x6e8)
[  284.352269]  |   +end     0x80000001   -170 __sched_text_start+0x6d0
(gatekeeper_thread+0xf4)
[  284.377701]  |   +begin   0x80000001   -173 __sched_text_start+0x6b8
(gatekeeper_thread+0xf4)
[  284.403133]  |   +end     0x80000000   -176 __sched_text_start+0x65c
(gatekeeper_thread+0xf4)
[  284.428565]  |   +func                 -180 ipipe_check_context+0x10
(__atomic_notifier_call_chain+0x68)
[  284.456841]  |   +func                 -182 iwmmxt_do+0x10
(notifier_call_chain+0x4c)
[  284.480180]  |   +func                 -185 nwfpe_notify+0x10
(notifier_call_chain+0x4c)
[  284.504321]  |   +func                 -188 notifier_call_chain+0x10
(__atomic_notifier_call_chain+0x5c)
[  284.532571]  |   +func                 -191 ipipe_check_context+0x10
(__atomic_notifier_call_chain+0x34)
[  284.560845]  |   +func                 -193
__atomic_notifier_call_chain+0x14 (atomic_notifier_call_chain+0x24)
[  284.590904]  |   +func                 -195
atomic_notifier_call_chain+0x14 (__switch_to+0x30)
[  284.616570]  |   +begin   0x80000000   -199 __sched_text_start+0x634
(xnshadow_harden+0xa8)
[  284.641486]  |   +end     0x80000001   -201 __sched_text_start+0x4a0
(xnshadow_harden+0xa8)
[  284.666375]  |   +begin   0x80000001   -204 __sched_text_start+0x484
(xnshadow_harden+0xa8)
[  284.691290]  |   +end     0x80000001   -206 __ipipe_dispatch_event+0x1c8
(__sched_text_start+0x44c)
[  284.718248]  |   +begin   0x80000001   -209 __ipipe_dispatch_event+0x104
(__sched_text_start+0x44c)
[  284.745206]  |   +end     0x80000000   -211
__ipipe_restore_pipeline_head+0xd8 (schedule_event+0xbb4)
[  284.772707]  | * +func                 -214
__ipipe_restore_pipeline_head+0x10 (schedule_event+0xbb4)
[  284.800180]  |   +begin   0x80000000   -216 schedule_event+0x6b0
(__ipipe_dispatch_event+0xdc)
[  284.825872]      +func                 -219 schedule_event+0x14
(__ipipe_dispatch_event+0xdc)
[  284.851278]  |   +end     0x80000001   -222 __ipipe_dispatch_event+0xc4
(__sched_text_start+0x44c)
[  284.878004]  |   +begin   0x80000001   -225 __ipipe_dispatch_event+0x40
(__sched_text_start+0x44c)
[  284.904727]      +func                 -227 __ipipe_dispatch_event+0x14
(__sched_text_start+0x44c)
[  284.931427]      +func                 -230 ipipe_check_context+0x10
(__sched_text_start+0x3c0)
[  284.957351]  |   +end     0x80000000   -232 __ipipe_unstall_root+0x64
(__sched_text_start+0x3b0)
[  284.983533]  |   #begin   0x80000000   -235 __ipipe_unstall_root+0x34
(__sched_text_start+0x3b0)
[  285.009741]      #func                 -237 __ipipe_unstall_root+0x10
(__sched_text_start+0x3b0)
[  285.035922]      #func                 -243 pick_next_task_rt+0x10
(__sched_text_start+0x250)
[  285.061329]      #func                 -247 check_spread+0x10
(put_prev_task_fair+0x3c)
[  285.085185]      #func                 -249 put_prev_task_fair+0x10
(__sched_text_start+0x214)
[  285.110850]      #func                 -254 calc_delta_mine+0x14
(update_curr+0xcc)
[  285.133672]      #func                 -257 update_curr+0x14
(dequeue_task_fair+0x2c)
[  285.157011]      #func                 -260 dequeue_task_fair+0x10
(dequeue_task+0x124)
[  285.180867]      #func                 -265 dequeue_task+0x14
(deactivate_task+0x2c)
[  285.203948]      #func                 -268 deactivate_task+0x10
(__sched_text_start+0x1f8)
[  285.228837]  |   #end     0x80000001   -271 __sched_text_start+0x18c
(xnshadow_harden+0xa8)
[  285.253753]  |   #begin   0x80000001   -273 __sched_text_start+0x174
(xnshadow_harden+0xa8)
[  285.278669]      #func                 -276 ipipe_check_context+0x10
(__sched_text_start+0x144)
[  285.304592]      #func                 -279 sched_clock+0x10
(sched_clock_cpu+0x30)
[  285.327415]      #func                 -281 sched_clock_cpu+0x10
(__sched_text_start+0x134)
[  285.352304]  |   #end     0x80000001   -283 __sched_text_start+0x128
(xnshadow_harden+0xa8)
[  285.377220]  |   +begin   0x80000001   -286 __sched_text_start+0x108
(xnshadow_harden+0xa8)
[  285.402135]      +func                 -288 ipipe_check_context+0x10
(__sched_text_start+0x94)
[  285.427801]      +func                 -290 preempt_schedule+0x10
(__sched_text_start+0x78)
[  285.452691]      +func                 -293 ipipe_check_context+0x10
(__sched_text_start+0x60)
[  285.478355]      +func                 -295 ipipe_check_context+0x10
(__sched_text_start+0x24)
[  285.504020]      +func                 -297 __sched_text_start+0x14
(xnshadow_harden+0xa8)
[  285.528653]      +func                 -300 preempt_schedule+0x10
(__wake_up_sync+0xdc)
[  285.552509]      +func                 -302 ipipe_check_context+0x10
(__wake_up_sync+0xc4)
[  285.577140]  |   +end     0x80000000   -304 __ipipe_unstall_root+0x64
(__ipipe_restore_root+0x64)
[  285.603580]  |   #begin   0x80000000   -306 __ipipe_unstall_root+0x34
(__ipipe_restore_root+0x64)
[  285.630021]      #func                 -308 __ipipe_unstall_root+0x10
(__ipipe_restore_root+0x64)
[  285.656461]      #func                 -311 __ipipe_restore_root+0x10
(__wake_up_sync+0xbc)
[  285.681351]      #func                 -313 preempt_schedule+0x10
(try_to_wake_up+0x138)
[  285.705466]      #func                 -315 ipipe_check_context+0x10
(try_to_wake_up+0x120)
[  285.730355]  |   #end     0x80000001   -318 __ipipe_restore_root+0x58
(try_to_wake_up+0x118)
[  285.755503]  |   #begin   0x80000001   -320 __ipipe_restore_root+0x38
(try_to_wake_up+0x118)
[  285.780689] invalid use of FPU in Xenomai context at 0x93e0
[  285.797290] Xenomai: Switching display-340 to secondary mode after
exception #5 from user-space at 0x93e0 (pid 342)
[  285.829719] Xenomai: registered exported object dispsem-342 (semaphores)

Any idea about ?

Thanks

Felipe

--0016e64c2a4874f8d10472375354
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi , <br><br>I&#39;m trying xenomai running on PXA270 Voipac module.<br>Acc=
tually i have a problem when running the lantency test program.<br><br>The =
module loads OK , but when i run latency program:<br><br>[=A0 110.874334] X=
enomai: starting native API services.<br>
[=A0 282.865308] I-pipe: Detected illicit call from domain &#39;Xenomai&#39=
;<br>[=A0 282.865356]=A0=A0=A0=A0=A0=A0=A0=A0 into a service reserved for d=
omain &#39;Linux&#39; and below.<br>[=A0 282.903226] [&lt;c0023068&gt;] (du=
mp_stack+0x0/0x18) from [&lt;c006cbcc&gt;] (ipipe_check_context+0xdc/0x100)=
<br>
[=A0 282.929809] [&lt;c006caf0&gt;] (ipipe_check_context+0x0/0x100) from [&=
lt;c0066168&gt;] (module_address_lookup+0x34/0x108)<br>[=A0 282.959374] [&l=
t;c0066134&gt;] (module_address_lookup+0x0/0x108) from [&lt;c00670e4&gt;] (=
kallsyms_lookup+0x7c/0x80)<br>
[=A0 282.987650] [&lt;c0067068&gt;] (kallsyms_lookup+0x0/0x80) from [&lt;c0=
067208&gt;] (sprint_symbol+0x38/0xb0)<br>[=A0 283.013599] [&lt;c00671d0&gt;=
] (sprint_symbol+0x0/0xb0) from [&lt;c00672a4&gt;] (__print_symbol+0x24/0x3=
8)<br>
[=A0 283.039294]=A0 r6:c03334f8 r5:c7035e24 r4:c02b5728<br>[=A0 283.053066]=
 [&lt;c0067280&gt;] (__print_symbol+0x0/0x38) from [&lt;c007cfec&gt;] (xnpo=
d_trap_fault+0xc8/0x258)<br>[=A0 283.079818]=A0 r5:c7040810 r4:c7035f40<br>=
[=A0 283.090466] [&lt;c007cf24&gt;] (xnpod_trap_fault+0x0/0x258) from [&lt;=
c0073b30&gt;] (xnarch_trap_fault+0x24/0x2c)<br>
[=A0 283.117967]=A0 r6:c0330cc4 r5:c02f6c48 r4:c0332950<br>[=A0 283.131742]=
 [&lt;c0073b0c&gt;] (xnarch_trap_fault+0x0/0x2c) from [&lt;c01dcd38&gt;] (e=
xception_event+0x50/0x74)<br>[=A0 283.158751] [&lt;c01dcce8&gt;] (exception=
_event+0x0/0x74) from [&lt;c006bbac&gt;] (__ipipe_dispatch_event+0xdc/0x1e8=
)<br>
[=A0 283.187285]=A0 r4:00000000<br>[=A0 283.194805] [&lt;c006bad0&gt;] (__i=
pipe_dispatch_event+0x0/0x1e8) from [&lt;c001ee04&gt;] (do_fpe+0x18/0x3c)<b=
r>[=A0 283.221016] I-pipe tracer log (100 points):<br>[=A0 283.233469]=A0 |=
 +=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 ipipe=
_trace_panic_freeze+0x10 (ipipe_check_context+0x5c)<br>
[=A0 283.260735]=A0 | +=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -4 ipipe_check_context+0x10 (module_address_lookup+0x34)<br>[=
=A0 283.287176]=A0 | +=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 -6 module_address_lookup+0x10 (kallsyms_lookup+0x7c)<br>[=A0 283.=
312583]=A0 | +=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=
10 in_gate_area_no_task+0x10 (is_ksym_addr+0x34)<br>
[=A0 283.336956]=A0 | +=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 -13 is_ksym_addr+0x10 (kallsyms_lookup+0x38)<br>[=A0 283.360036]=
=A0 | +=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -15 kall=
syms_lookup+0x14 (sprint_symbol+0x38)<br>[=A0 283.383375]=A0 | +=A0 func=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -18 sprint_symbol+0x14 (__=
print_symbol+0x24)<br>
[=A0 283.406456]=A0 | +=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 -21 __print_symbol+0x14 (xnpod_trap_fault+0xc8)<br>[=A0 283.43031=
3]=A0 | +=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -24 xn=
pod_trap_fault+0x14 (xnarch_trap_fault+0x24)<br>[=A0 283.454943]=A0 | +=A0 =
func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -27 xnarch_trap_fau=
lt+0x14 (exception_event+0x50)<br>
[=A0 283.479316]=A0 | +=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 -30 exception_event+0x10 (__ipipe_dispatch_event+0xdc)<br>[=A0 28=
3.504982]=A0 | +=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 -34 __ipipe_dispatch_event+0x14 (do_fpe+0x18)<br>[=A0 283.528320]=A0 | +=
=A0 end=A0=A0=A0=A0 0x80000001=A0=A0=A0 -45 __ipipe_dispatch_event+0x1c8 (_=
_ipipe_syscall_root+0x80)<br>
[=A0 283.555562]=A0 | +=A0 begin=A0=A0 0x80000001=A0=A0=A0 -48 __ipipe_disp=
atch_event+0x104 (__ipipe_syscall_root+0x80)<br>[=A0 283.582778]=A0 | +=A0 =
end=A0=A0=A0=A0 0x80000000=A0=A0=A0 -52 ipipe_unstall_pipeline_head+0x90 (x=
nshadow_harden+0x1a0)<br>[=A0 283.610021]=A0 | #=A0 begin=A0=A0 0x80000000=
=A0=A0=A0 -56 ipipe_unstall_pipeline_head+0x34 (xnshadow_harden+0x1a0)<br>
[=A0 283.637262]=A0=A0=A0 #=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -58 ipipe_unstall_pipeline_head+0x10 (xnshadow_harden+0x1a0)<b=
r>[=A0 283.664477]=A0=A0=A0 #=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 -63 xnpod_switch_fpu+0x10 (xnshadow_harden+0x190)<br>[=A0 2=
83.688851]=A0 | #=A0 end=A0=A0=A0=A0 0x80000001=A0=A0=A0 -66 __sched_text_s=
tart+0x6d0 (xnshadow_harden+0xa8)<br>
[=A0 283.713793]=A0 | #=A0 begin=A0=A0 0x80000001=A0=A0=A0 -69 __sched_text=
_start+0x6b8 (xnshadow_harden+0xa8)<br>[=A0 283.738707]=A0 | #=A0 end=A0=A0=
=A0=A0 0x80000000=A0=A0=A0 -71 __sched_text_start+0x65c (xnshadow_harden+0x=
a8)<br>[=A0 283.763597]=A0 | #=A0 [=A0 304] telnetd -1=A0=A0=A0 -92 xnpod_s=
chedule+0xb4 (xnpod_schedule_handler+0x54)<br>
[=A0 283.789056]=A0 | #=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 -95 xnpod_schedule+0x14 (xnpod_schedule_handler+0x54)<br>[=A0 283=
.814463]=A0 | #=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
-98 xnpod_schedule_handler+0x10 (__ipipe_sync_stage+0x1b4)<br>[=A0 283.8411=
62]=A0 | +=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -101 __i=
pipe_sync_stage+0x10 (ipipe_suspend_domain+0xa4)<br>
[=A0 283.867086]=A0 | +=A0 func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 -104 ipipe_suspend_domain+0x10 (__ipipe_walk_pipeline+0x74)<br>[=A0 =
283.893783]=A0 |=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 -108 __ipipe_walk_pipeline+0x10 (__ipipe_restore_pipeline_head+0xc4)<br=
>[=A0 283.922809]=A0 | * +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 -111 __ipipe_restore_pipeline_head+0x10 (gatekeeper_thread+0x180)<br>
[=A0 283.951058]=A0 | * +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 -116 __ipipe_set_irq_pending+0x10 (__ipipe_dispatch_wired+0x7c)<br>[=A0=
 283.978792]=A0 | * +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=
120 __ipipe_dispatch_wired+0x10 (__ipipe_handle_irq+0xa4)<br>[=A0 284.00523=
3]=A0 | * +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -124 __ipip=
e_handle_irq+0x10 (ipipe_trigger_irq+0x7c)<br>
[=A0 284.030381]=A0 | * +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 -128 ipipe_trigger_irq+0x10 (xnpod_schedule+0x34)<br>[=A0 284.054494]=
=A0 | * +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -130 xnpod_sc=
hedule+0x14 (gatekeeper_thread+0x164)<br>[=A0 284.078868]=A0 | * +func=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -133 disengage_irq_shield+0x1=
0 (gatekeeper_thread+0x160)<br>
[=A0 284.104792]=A0 | * +[=A0 342] display- 0=A0=A0 -142 xnpod_resume_threa=
d+0x70 (gatekeeper_thread+0x15c)<br>[=A0 284.130509]=A0 | * +func=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -145 xnpod_resume_thread+0x14 (gate=
keeper_thread+0x15c)<br>[=A0 284.156173]=A0 |=A0=A0 +begin=A0=A0 0x80000000=
=A0=A0 -147 gatekeeper_thread+0x140 (kthread+0x58)<br>
[=A0 284.178789]=A0 |=A0=A0 +end=A0=A0=A0=A0 0x80000000=A0=A0 -150 __ipipe_=
restore_pipeline_head+0xd8 (rpi_pop+0x4cc)<br>[=A0 284.204454]=A0 | * +func=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -153 __ipipe_restore_pipel=
ine_head+0x10 (rpi_pop+0x4cc)<br>[=A0 284.230119]=A0 |=A0=A0 +begin=A0=A0 0=
x80000000=A0=A0 -157 rpi_pop+0x38 (gatekeeper_thread+0x120)<br>
[=A0 284.252709]=A0=A0=A0=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -159 rpi_pop+0x14 (gatekeeper_thread+0x120)<br>[=A0 284.275273=
]=A0=A0=A0=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -162=
 kthread_should_stop+0x10 (gatekeeper_thread+0xf8)<br>[=A0 284.300680]=A0=
=A0=A0=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -165 ipi=
pe_check_context+0x10 (__sched_text_start+0x750)<br>
[=A0 284.326603]=A0=A0=A0=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -168 finish_task_switch+0x10 (__sched_text_start+0x6e8)<br>[=
=A0 284.352269]=A0 |=A0=A0 +end=A0=A0=A0=A0 0x80000001=A0=A0 -170 __sched_t=
ext_start+0x6d0 (gatekeeper_thread+0xf4)<br>[=A0 284.377701]=A0 |=A0=A0 +be=
gin=A0=A0 0x80000001=A0=A0 -173 __sched_text_start+0x6b8 (gatekeeper_thread=
+0xf4)<br>
[=A0 284.403133]=A0 |=A0=A0 +end=A0=A0=A0=A0 0x80000000=A0=A0 -176 __sched_=
text_start+0x65c (gatekeeper_thread+0xf4)<br>[=A0 284.428565]=A0 |=A0=A0 +f=
unc=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -180 ipipe_check_contex=
t+0x10 (__atomic_notifier_call_chain+0x68)<br>[=A0 284.456841]=A0 |=A0=A0 +=
func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -182 iwmmxt_do+0x10 (n=
otifier_call_chain+0x4c)<br>
[=A0 284.480180]=A0 |=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 -185 nwfpe_notify+0x10 (notifier_call_chain+0x4c)<br>[=A0 284.504321=
]=A0 |=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -188 not=
ifier_call_chain+0x10 (__atomic_notifier_call_chain+0x5c)<br>[=A0 284.53257=
1]=A0 |=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -191 ip=
ipe_check_context+0x10 (__atomic_notifier_call_chain+0x34)<br>
[=A0 284.560845]=A0 |=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 -193 __atomic_notifier_call_chain+0x14 (atomic_notifier_call_chain+0=
x24)<br>[=A0 284.590904]=A0 |=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 -195 atomic_notifier_call_chain+0x14 (__switch_to+0x30)<br>=
[=A0 284.616570]=A0 |=A0=A0 +begin=A0=A0 0x80000000=A0=A0 -199 __sched_text=
_start+0x634 (xnshadow_harden+0xa8)<br>
[=A0 284.641486]=A0 |=A0=A0 +end=A0=A0=A0=A0 0x80000001=A0=A0 -201 __sched_=
text_start+0x4a0 (xnshadow_harden+0xa8)<br>[=A0 284.666375]=A0 |=A0=A0 +beg=
in=A0=A0 0x80000001=A0=A0 -204 __sched_text_start+0x484 (xnshadow_harden+0x=
a8)<br>[=A0 284.691290]=A0 |=A0=A0 +end=A0=A0=A0=A0 0x80000001=A0=A0 -206 _=
_ipipe_dispatch_event+0x1c8 (__sched_text_start+0x44c)<br>
[=A0 284.718248]=A0 |=A0=A0 +begin=A0=A0 0x80000001=A0=A0 -209 __ipipe_disp=
atch_event+0x104 (__sched_text_start+0x44c)<br>[=A0 284.745206]=A0 |=A0=A0 =
+end=A0=A0=A0=A0 0x80000000=A0=A0 -211 __ipipe_restore_pipeline_head+0xd8 (=
schedule_event+0xbb4)<br>[=A0 284.772707]=A0 | * +func=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 -214 __ipipe_restore_pipeline_head+0x10 (schedu=
le_event+0xbb4)<br>
[=A0 284.800180]=A0 |=A0=A0 +begin=A0=A0 0x80000000=A0=A0 -216 schedule_eve=
nt+0x6b0 (__ipipe_dispatch_event+0xdc)<br>[=A0 284.825872]=A0=A0=A0=A0=A0 +=
func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -219 schedule_event+0x=
14 (__ipipe_dispatch_event+0xdc)<br>[=A0 284.851278]=A0 |=A0=A0 +end=A0=A0=
=A0=A0 0x80000001=A0=A0 -222 __ipipe_dispatch_event+0xc4 (__sched_text_star=
t+0x44c)<br>
[=A0 284.878004]=A0 |=A0=A0 +begin=A0=A0 0x80000001=A0=A0 -225 __ipipe_disp=
atch_event+0x40 (__sched_text_start+0x44c)<br>[=A0 284.904727]=A0=A0=A0=A0=
=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -227 __ipipe_disp=
atch_event+0x14 (__sched_text_start+0x44c)<br>[=A0 284.931427]=A0=A0=A0=A0=
=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -230 ipipe_check_=
context+0x10 (__sched_text_start+0x3c0)<br>
[=A0 284.957351]=A0 |=A0=A0 +end=A0=A0=A0=A0 0x80000000=A0=A0 -232 __ipipe_=
unstall_root+0x64 (__sched_text_start+0x3b0)<br>[=A0 284.983533]=A0 |=A0=A0=
 #begin=A0=A0 0x80000000=A0=A0 -235 __ipipe_unstall_root+0x34 (__sched_text=
_start+0x3b0)<br>[=A0 285.009741]=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 -237 __ipipe_unstall_root+0x10 (__sched_text_st=
art+0x3b0)<br>
[=A0 285.035922]=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -243 pick_next_task_rt+0x10 (__sched_text_start+0x250)<br>[=A0=
 285.061329]=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 -247 check_spread+0x10 (put_prev_task_fair+0x3c)<br>[=A0 285.085185]=
=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -249 =
put_prev_task_fair+0x10 (__sched_text_start+0x214)<br>
[=A0 285.110850]=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -254 calc_delta_mine+0x14 (update_curr+0xcc)<br>[=A0 285.13367=
2]=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -25=
7 update_curr+0x14 (dequeue_task_fair+0x2c)<br>[=A0 285.157011]=A0=A0=A0=A0=
=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -260 dequeue_task=
_fair+0x10 (dequeue_task+0x124)<br>
[=A0 285.180867]=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -265 dequeue_task+0x14 (deactivate_task+0x2c)<br>[=A0 285.2039=
48]=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -2=
68 deactivate_task+0x10 (__sched_text_start+0x1f8)<br>[=A0 285.228837]=A0 |=
=A0=A0 #end=A0=A0=A0=A0 0x80000001=A0=A0 -271 __sched_text_start+0x18c (xns=
hadow_harden+0xa8)<br>
[=A0 285.253753]=A0 |=A0=A0 #begin=A0=A0 0x80000001=A0=A0 -273 __sched_text=
_start+0x174 (xnshadow_harden+0xa8)<br>[=A0 285.278669]=A0=A0=A0=A0=A0 #fun=
c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -276 ipipe_check_context+=
0x10 (__sched_text_start+0x144)<br>[=A0 285.304592]=A0=A0=A0=A0=A0 #func=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -279 sched_clock+0x10 (sched_=
clock_cpu+0x30)<br>
[=A0 285.327415]=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -281 sched_clock_cpu+0x10 (__sched_text_start+0x134)<br>[=A0 2=
85.352304]=A0 |=A0=A0 #end=A0=A0=A0=A0 0x80000001=A0=A0 -283 __sched_text_s=
tart+0x128 (xnshadow_harden+0xa8)<br>[=A0 285.377220]=A0 |=A0=A0 +begin=A0=
=A0 0x80000001=A0=A0 -286 __sched_text_start+0x108 (xnshadow_harden+0xa8)<b=
r>
[=A0 285.402135]=A0=A0=A0=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -288 ipipe_check_context+0x10 (__sched_text_start+0x94)<br>[=
=A0 285.427801]=A0=A0=A0=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 -290 preempt_schedule+0x10 (__sched_text_start+0x78)<br>[=A0 285.=
452691]=A0=A0=A0=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 -293 ipipe_check_context+0x10 (__sched_text_start+0x60)<br>
[=A0 285.478355]=A0=A0=A0=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -295 ipipe_check_context+0x10 (__sched_text_start+0x24)<br>[=
=A0 285.504020]=A0=A0=A0=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 -297 __sched_text_start+0x14 (xnshadow_harden+0xa8)<br>[=A0 285.5=
28653]=A0=A0=A0=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 -300 preempt_schedule+0x10 (__wake_up_sync+0xdc)<br>
[=A0 285.552509]=A0=A0=A0=A0=A0 +func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -302 ipipe_check_context+0x10 (__wake_up_sync+0xc4)<br>[=A0 28=
5.577140]=A0 |=A0=A0 +end=A0=A0=A0=A0 0x80000000=A0=A0 -304 __ipipe_unstall=
_root+0x64 (__ipipe_restore_root+0x64)<br>[=A0 285.603580]=A0 |=A0=A0 #begi=
n=A0=A0 0x80000000=A0=A0 -306 __ipipe_unstall_root+0x34 (__ipipe_restore_ro=
ot+0x64)<br>
[=A0 285.630021]=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -308 __ipipe_unstall_root+0x10 (__ipipe_restore_root+0x64)<br>=
[=A0 285.656461]=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -311 __ipipe_restore_root+0x10 (__wake_up_sync+0xbc)<br>[=A0 2=
85.681351]=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 -313 preempt_schedule+0x10 (try_to_wake_up+0x138)<br>
[=A0 285.705466]=A0=A0=A0=A0=A0 #func=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 -315 ipipe_check_context+0x10 (try_to_wake_up+0x120)<br>[=A0 2=
85.730355]=A0 |=A0=A0 #end=A0=A0=A0=A0 0x80000001=A0=A0 -318 __ipipe_restor=
e_root+0x58 (try_to_wake_up+0x118)<br>[=A0 285.755503]=A0 |=A0=A0 #begin=A0=
=A0 0x80000001=A0=A0 -320 __ipipe_restore_root+0x38 (try_to_wake_up+0x118)<=
br>
[=A0 285.780689] invalid use of FPU in Xenomai context at 0x93e0<br>[=A0 28=
5.797290] Xenomai: Switching display-340 to secondary mode after exception =
#5 from user-space at 0x93e0 (pid 342)<br>[=A0 285.829719] Xenomai: registe=
red exported object dispsem-342 (semaphores)<br>
<br>Any idea about ?<br><br>Thanks <br><br>Felipe<br>

--0016e64c2a4874f8d10472375354--

