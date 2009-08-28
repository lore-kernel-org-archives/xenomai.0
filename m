Message-ID: <4A981B54.4020908@domain.hid>
Date: Fri, 28 Aug 2009 20:00:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7a15153d0908281050l56343b26g45a8f66b87c839e9@domain.hid>
In-Reply-To: <7a15153d0908281050l56343b26g45a8f66b87c839e9@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PXA + Xenomai] Latency program
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Felipe Castro <felipecpc1@domain.hid>
Cc: xenomai@xenomai.org

Felipe Castro wrote:
> Hi ,
> 
> I'm trying xenomai running on PXA270 Voipac module.
> Acctually i have a problem when running the lantency test program.
> 
> The module loads OK , but when i run latency program:
> 
> [  110.874334] Xenomai: starting native API services.
> [  282.865308] I-pipe: Detected illicit call from domain 'Xenomai'
> [  282.865356]         into a service reserved for domain 'Linux' and below.
> [  282.903226] [<c0023068>] (dump_stack+0x0/0x18) from [<c006cbcc>]
> (ipipe_check_context+0xdc/0x100)
> [  282.929809] [<c006caf0>] (ipipe_check_context+0x0/0x100) from
> [<c0066168>] (module_address_lookup+0x34/0x108)
> [  282.959374] [<c0066134>] (module_address_lookup+0x0/0x108) from
> [<c00670e4>] (kallsyms_lookup+0x7c/0x80)
> [  282.987650] [<c0067068>] (kallsyms_lookup+0x0/0x80) from [<c0067208>]
> (sprint_symbol+0x38/0xb0)
> [  283.013599] [<c00671d0>] (sprint_symbol+0x0/0xb0) from [<c00672a4>]
> (__print_symbol+0x24/0x38)
> [  283.039294]  r6:c03334f8 r5:c7035e24 r4:c02b5728
> [  283.053066] [<c0067280>] (__print_symbol+0x0/0x38) from [<c007cfec>]
> (xnpod_trap_fault+0xc8/0x258)
> [  283.079818]  r5:c7040810 r4:c7035f40
> [  283.090466] [<c007cf24>] (xnpod_trap_fault+0x0/0x258) from [<c0073b30>]
> (xnarch_trap_fault+0x24/0x2c)
> [  283.117967]  r6:c0330cc4 r5:c02f6c48 r4:c0332950
> [  283.131742] [<c0073b0c>] (xnarch_trap_fault+0x0/0x2c) from [<c01dcd38>]
> (exception_event+0x50/0x74)
> [  283.158751] [<c01dcce8>] (exception_event+0x0/0x74) from [<c006bbac>]
> (__ipipe_dispatch_event+0xdc/0x1e8)
> [  283.187285]  r4:00000000
> [  283.194805] [<c006bad0>] (__ipipe_dispatch_event+0x0/0x1e8) from
> [<c001ee04>] (do_fpe+0x18/0x3c)
> [  283.221016] I-pipe tracer log (100 points):
> [  283.233469]  | +  func                    0 ipipe_trace_panic_freeze+0x10
> (ipipe_check_context+0x5c)
> [  283.260735]  | +  func                   -4 ipipe_check_context+0x10
> (module_address_lookup+0x34)
> [  283.287176]  | +  func                   -6 module_address_lookup+0x10
> (kallsyms_lookup+0x7c)
> [  283.312583]  | +  func                  -10 in_gate_area_no_task+0x10
> (is_ksym_addr+0x34)
> [  283.336956]  | +  func                  -13 is_ksym_addr+0x10
> (kallsyms_lookup+0x38)
> [  283.360036]  | +  func                  -15 kallsyms_lookup+0x14
> (sprint_symbol+0x38)
> [  283.383375]  | +  func                  -18 sprint_symbol+0x14
> (__print_symbol+0x24)
> [  283.406456]  | +  func                  -21 __print_symbol+0x14
> (xnpod_trap_fault+0xc8)
> [  283.430313]  | +  func                  -24 xnpod_trap_fault+0x14
> (xnarch_trap_fault+0x24)
> [  283.454943]  | +  func                  -27 xnarch_trap_fault+0x14
> (exception_event+0x50)
> [  283.479316]  | +  func                  -30 exception_event+0x10
> (__ipipe_dispatch_event+0xdc)
> [  283.504982]  | +  func                  -34 __ipipe_dispatch_event+0x14
> (do_fpe+0x18)
> [  283.528320]  | +  end     0x80000001    -45 __ipipe_dispatch_event+0x1c8
> (__ipipe_syscall_root+0x80)
> [  283.555562]  | +  begin   0x80000001    -48 __ipipe_dispatch_event+0x104
> (__ipipe_syscall_root+0x80)
> [  283.582778]  | +  end     0x80000000    -52
> ipipe_unstall_pipeline_head+0x90 (xnshadow_harden+0x1a0)
> [  283.610021]  | #  begin   0x80000000    -56
> ipipe_unstall_pipeline_head+0x34 (xnshadow_harden+0x1a0)
> [  283.637262]    #  func                  -58
> ipipe_unstall_pipeline_head+0x10 (xnshadow_harden+0x1a0)
> [  283.664477]    #  func                  -63 xnpod_switch_fpu+0x10
> (xnshadow_harden+0x190)
> [  283.688851]  | #  end     0x80000001    -66 __sched_text_start+0x6d0
> (xnshadow_harden+0xa8)
> [  283.713793]  | #  begin   0x80000001    -69 __sched_text_start+0x6b8
> (xnshadow_harden+0xa8)
> [  283.738707]  | #  end     0x80000000    -71 __sched_text_start+0x65c
> (xnshadow_harden+0xa8)
> [  283.763597]  | #  [  304] telnetd -1    -92 xnpod_schedule+0xb4
> (xnpod_schedule_handler+0x54)
> [  283.789056]  | #  func                  -95 xnpod_schedule+0x14
> (xnpod_schedule_handler+0x54)
> [  283.814463]  | #  func                  -98 xnpod_schedule_handler+0x10
> (__ipipe_sync_stage+0x1b4)
> [  283.841162]  | +  func                 -101 __ipipe_sync_stage+0x10
> (ipipe_suspend_domain+0xa4)
> [  283.867086]  | +  func                 -104 ipipe_suspend_domain+0x10
> (__ipipe_walk_pipeline+0x74)
> [  283.893783]  |   +func                 -108 __ipipe_walk_pipeline+0x10
> (__ipipe_restore_pipeline_head+0xc4)
> [  283.922809]  | * +func                 -111
> __ipipe_restore_pipeline_head+0x10 (gatekeeper_thread+0x180)
> [  283.951058]  | * +func                 -116 __ipipe_set_irq_pending+0x10
> (__ipipe_dispatch_wired+0x7c)
> [  283.978792]  | * +func                 -120 __ipipe_dispatch_wired+0x10
> (__ipipe_handle_irq+0xa4)
> [  284.005233]  | * +func                 -124 __ipipe_handle_irq+0x10
> (ipipe_trigger_irq+0x7c)
> [  284.030381]  | * +func                 -128 ipipe_trigger_irq+0x10
> (xnpod_schedule+0x34)
> [  284.054494]  | * +func                 -130 xnpod_schedule+0x14
> (gatekeeper_thread+0x164)
> [  284.078868]  | * +func                 -133 disengage_irq_shield+0x10
> (gatekeeper_thread+0x160)
> [  284.104792]  | * +[  342] display- 0   -142 xnpod_resume_thread+0x70
> (gatekeeper_thread+0x15c)
> [  284.130509]  | * +func                 -145 xnpod_resume_thread+0x14
> (gatekeeper_thread+0x15c)
> [  284.156173]  |   +begin   0x80000000   -147 gatekeeper_thread+0x140
> (kthread+0x58)
> [  284.178789]  |   +end     0x80000000   -150
> __ipipe_restore_pipeline_head+0xd8 (rpi_pop+0x4cc)
> [  284.204454]  | * +func                 -153
> __ipipe_restore_pipeline_head+0x10 (rpi_pop+0x4cc)
> [  284.230119]  |   +begin   0x80000000   -157 rpi_pop+0x38
> (gatekeeper_thread+0x120)
> [  284.252709]      +func                 -159 rpi_pop+0x14
> (gatekeeper_thread+0x120)
> [  284.275273]      +func                 -162 kthread_should_stop+0x10
> (gatekeeper_thread+0xf8)
> [  284.300680]      +func                 -165 ipipe_check_context+0x10
> (__sched_text_start+0x750)
> [  284.326603]      +func                 -168 finish_task_switch+0x10
> (__sched_text_start+0x6e8)
> [  284.352269]  |   +end     0x80000001   -170 __sched_text_start+0x6d0
> (gatekeeper_thread+0xf4)
> [  284.377701]  |   +begin   0x80000001   -173 __sched_text_start+0x6b8
> (gatekeeper_thread+0xf4)
> [  284.403133]  |   +end     0x80000000   -176 __sched_text_start+0x65c
> (gatekeeper_thread+0xf4)
> [  284.428565]  |   +func                 -180 ipipe_check_context+0x10
> (__atomic_notifier_call_chain+0x68)
> [  284.456841]  |   +func                 -182 iwmmxt_do+0x10
> (notifier_call_chain+0x4c)
> [  284.480180]  |   +func                 -185 nwfpe_notify+0x10
> (notifier_call_chain+0x4c)
> [  284.504321]  |   +func                 -188 notifier_call_chain+0x10
> (__atomic_notifier_call_chain+0x5c)
> [  284.532571]  |   +func                 -191 ipipe_check_context+0x10
> (__atomic_notifier_call_chain+0x34)
> [  284.560845]  |   +func                 -193
> __atomic_notifier_call_chain+0x14 (atomic_notifier_call_chain+0x24)
> [  284.590904]  |   +func                 -195
> atomic_notifier_call_chain+0x14 (__switch_to+0x30)
> [  284.616570]  |   +begin   0x80000000   -199 __sched_text_start+0x634
> (xnshadow_harden+0xa8)
> [  284.641486]  |   +end     0x80000001   -201 __sched_text_start+0x4a0
> (xnshadow_harden+0xa8)
> [  284.666375]  |   +begin   0x80000001   -204 __sched_text_start+0x484
> (xnshadow_harden+0xa8)
> [  284.691290]  |   +end     0x80000001   -206 __ipipe_dispatch_event+0x1c8
> (__sched_text_start+0x44c)
> [  284.718248]  |   +begin   0x80000001   -209 __ipipe_dispatch_event+0x104
> (__sched_text_start+0x44c)
> [  284.745206]  |   +end     0x80000000   -211
> __ipipe_restore_pipeline_head+0xd8 (schedule_event+0xbb4)
> [  284.772707]  | * +func                 -214
> __ipipe_restore_pipeline_head+0x10 (schedule_event+0xbb4)
> [  284.800180]  |   +begin   0x80000000   -216 schedule_event+0x6b0
> (__ipipe_dispatch_event+0xdc)
> [  284.825872]      +func                 -219 schedule_event+0x14
> (__ipipe_dispatch_event+0xdc)
> [  284.851278]  |   +end     0x80000001   -222 __ipipe_dispatch_event+0xc4
> (__sched_text_start+0x44c)
> [  284.878004]  |   +begin   0x80000001   -225 __ipipe_dispatch_event+0x40
> (__sched_text_start+0x44c)
> [  284.904727]      +func                 -227 __ipipe_dispatch_event+0x14
> (__sched_text_start+0x44c)
> [  284.931427]      +func                 -230 ipipe_check_context+0x10
> (__sched_text_start+0x3c0)
> [  284.957351]  |   +end     0x80000000   -232 __ipipe_unstall_root+0x64
> (__sched_text_start+0x3b0)
> [  284.983533]  |   #begin   0x80000000   -235 __ipipe_unstall_root+0x34
> (__sched_text_start+0x3b0)
> [  285.009741]      #func                 -237 __ipipe_unstall_root+0x10
> (__sched_text_start+0x3b0)
> [  285.035922]      #func                 -243 pick_next_task_rt+0x10
> (__sched_text_start+0x250)
> [  285.061329]      #func                 -247 check_spread+0x10
> (put_prev_task_fair+0x3c)
> [  285.085185]      #func                 -249 put_prev_task_fair+0x10
> (__sched_text_start+0x214)
> [  285.110850]      #func                 -254 calc_delta_mine+0x14
> (update_curr+0xcc)
> [  285.133672]      #func                 -257 update_curr+0x14
> (dequeue_task_fair+0x2c)
> [  285.157011]      #func                 -260 dequeue_task_fair+0x10
> (dequeue_task+0x124)
> [  285.180867]      #func                 -265 dequeue_task+0x14
> (deactivate_task+0x2c)
> [  285.203948]      #func                 -268 deactivate_task+0x10
> (__sched_text_start+0x1f8)
> [  285.228837]  |   #end     0x80000001   -271 __sched_text_start+0x18c
> (xnshadow_harden+0xa8)
> [  285.253753]  |   #begin   0x80000001   -273 __sched_text_start+0x174
> (xnshadow_harden+0xa8)
> [  285.278669]      #func                 -276 ipipe_check_context+0x10
> (__sched_text_start+0x144)
> [  285.304592]      #func                 -279 sched_clock+0x10
> (sched_clock_cpu+0x30)
> [  285.327415]      #func                 -281 sched_clock_cpu+0x10
> (__sched_text_start+0x134)
> [  285.352304]  |   #end     0x80000001   -283 __sched_text_start+0x128
> (xnshadow_harden+0xa8)
> [  285.377220]  |   +begin   0x80000001   -286 __sched_text_start+0x108
> (xnshadow_harden+0xa8)
> [  285.402135]      +func                 -288 ipipe_check_context+0x10
> (__sched_text_start+0x94)
> [  285.427801]      +func                 -290 preempt_schedule+0x10
> (__sched_text_start+0x78)
> [  285.452691]      +func                 -293 ipipe_check_context+0x10
> (__sched_text_start+0x60)
> [  285.478355]      +func                 -295 ipipe_check_context+0x10
> (__sched_text_start+0x24)
> [  285.504020]      +func                 -297 __sched_text_start+0x14
> (xnshadow_harden+0xa8)
> [  285.528653]      +func                 -300 preempt_schedule+0x10
> (__wake_up_sync+0xdc)
> [  285.552509]      +func                 -302 ipipe_check_context+0x10
> (__wake_up_sync+0xc4)
> [  285.577140]  |   +end     0x80000000   -304 __ipipe_unstall_root+0x64
> (__ipipe_restore_root+0x64)
> [  285.603580]  |   #begin   0x80000000   -306 __ipipe_unstall_root+0x34
> (__ipipe_restore_root+0x64)
> [  285.630021]      #func                 -308 __ipipe_unstall_root+0x10
> (__ipipe_restore_root+0x64)
> [  285.656461]      #func                 -311 __ipipe_restore_root+0x10
> (__wake_up_sync+0xbc)
> [  285.681351]      #func                 -313 preempt_schedule+0x10
> (try_to_wake_up+0x138)
> [  285.705466]      #func                 -315 ipipe_check_context+0x10
> (try_to_wake_up+0x120)
> [  285.730355]  |   #end     0x80000001   -318 __ipipe_restore_root+0x58
> (try_to_wake_up+0x118)
> [  285.755503]  |   #begin   0x80000001   -320 __ipipe_restore_root+0x38
> (try_to_wake_up+0x118)
> [  285.780689] invalid use of FPU in Xenomai context at 0x93e0
> [  285.797290] Xenomai: Switching display-340 to secondary mode after
> exception #5 from user-space at 0x93e0 (pid 342)
> [  285.829719] Xenomai: registered exported object dispsem-342 (semaphores)
> 
> Any idea about ?

Yes, it is the same problem as was posted a few days ago: the FPU
support for PXA is not implemented. So, you should apply the patch that
was posted a few days ago. The backtrace is due to the fact that we use
print_symbol, which is verboten in real-time context, this needs to be
fixed.

BUT, and that is a capital "but", be aware that when latency or any
other user-space real-time application will use FPU will in primary
mode, it will switch to secondary mode, which will induce big latencies.

So, if you do not want the high latencies, you are probably better off
compiling real-time applications with -msoft-float.


-- 
					    Gilles.

