Message-ID: <43BC430C.5080204@domain.hid>
Date: Wed, 04 Jan 2006 22:50:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig82AC67B6F18A747E4D6A60E9"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] enjoying the trace
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig82AC67B6F18A747E4D6A60E9
Content-Type: multipart/mixed; boundary="------------010906060700030503030809"

This is a multi-part message in MIME format.
--------------010906060700030503030809
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi all,

after a long day of experimenting with a new tracer revision (will get
posted later), I'm looking now for some external wisdom.

I changed the instrumentation for high-domain stall times such that I
now attach to local_irq_disable_hw & friends instead. In case the
hard-IRQ status doesn't change, only a ipipe_trace_special is issued, a
trace_begin/end otherwise. Additionally, I grab the entering and exiting
of __ipipe_handle_irq and suppress two IRQ on/off points in
arch/i386/kernel/ipipe-root.c. See attached patch (will likely become
part of the tracer).

Ok, this works significantly better than the previous approach. I just
tormented an Athlon 800 MHz box with Xenomai 2.1 revision 357 (old ipipe
IRQ layer) about 50 minutes with

	latency -p1000 -t1
	dd if=/dev/hda of=/dev/null
	ping -f -s 1400 [from external]
	cachebench [part of llcbench]

The result was a maximum latency of 38 us (in-kernel periodic task) and
some traces which correlate quite well. I attached two of them, showing
the similarity between the final and last but one outputs of
/proc/ipipe/trace/max. Note that the instrumentation and the trace
recording add some overhead, how much is just going to be measured.

So far so good. But I still have at least one virtual IRQ leakage in my
instrumenation, see the third trace. This is where the "external wisdom"
would be welcome. I know, I'm not tracing all IRQ offs and ons to make
life easier. This one is like an IRQ-reenable-on-iret when return to
userspace (the following IRQ hits a userspace address). Any ideas how to
catch this without rewriting entry.S - where modifications are real
*slowly* maturing?

Thanks,
Jan


PS: The removal of rthal_irq_trampoline() should not cause noticable
positive effects on such mid-range platforms, I'm afraid. But this will
get checked later. And there is a "nice" Pentium I 133 MHz sitting next
to me. I guess he will like this more. :)

PPS: "later" may not mean "soon".

--------------010906060700030503030809
Content-Type: text/plain;
 name="xeno-2.1-athlon800.trace"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-2.1-athlon800.trace"

I-pipe worst-case tracing service on 2.6.14.3/ipipe-1.1-00
------------------------------------------------------------
Begin: 1068123402870 cycles, Trace Points: 44 (-10/+5), Length: 36 us

  Type   User Val.   Time    Delay  Function (Parent)
  fn                   -3    0.381  losyscall_event+0xc (__ipipe_dispatch_event+0x88)
  begin  0x80000001    -3    0.252  __ipipe_dispatch_event+0xb0 (__ipipe_syscall_root+0x31)
  end    0x80000001    -3    0.399  __ipipe_dispatch_event+0x160 (__ipipe_syscall_root+0x31)
  fn                   -2    0.136  sys_write+0xd (syscall_call+0x7)
  fn                   -2    0.295  fget_light+0xb (sys_write+0x1d)
  fn                   -2    0.402  vfs_write+0xc (sys_write+0x41)
  fn                   -1    0.186  rw_verify_area+0xb (vfs_write+0x67)
  fn                   -1    0.160  write_null+0x8 (vfs_write+0x8a)
  fn                   -1    0.400  dnotify_parent+0xa (vfs_write+0xb5)
  fn                   -1    1.053  inotify_dentry_parent_queue_event+0xa (vfs_write+0xd5)
>|begin  0x80000002     0    0.451  common_interrupt+0x21 (__ipipe_trace+0x160)
:|fn                    0    0.904  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|fn                    1    0.438  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0xf5)
:|fn                    1    0.392  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0xa4)
:|(0x11) 0x80000001     2!  13.393  mask_and_ack_8259A+0x9f (__ipipe_ack_common_irq+0xa4)
:|(0x22) 0x80000001    15    0.267  mask_and_ack_8259A+0x124 (__ipipe_ack_common_irq+0xa4)
:|fn                   15+   1.448  __ipipe_sync_stage+0xe (__ipipe_handle_irq+0x225)
:|begin  0x80000002    17    0.163  common_interrupt+0x21 (__ipipe_sync_stage+0xdd)
:|fn                   17    0.423  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|fn                   17    0.158  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0xf5)
:|fn                   18    0.178  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0xa4)
:|(0x11) 0x80000001    18+   1.712  mask_and_ack_8259A+0x9f (__ipipe_ack_common_irq+0xa4)
:|(0x22) 0x80000001    19    0.350  mask_and_ack_8259A+0x124 (__ipipe_ack_common_irq+0xa4)
:|fn                   20    0.198  ipipe_suspend_domain+0xc (__ipipe_handle_irq+0x1cc)
:|(0x11) 0x80000001    20    0.349  ipipe_suspend_domain+0xac (__ipipe_handle_irq+0x1cc)
:|fn                   20    0.285  __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x68)
:|fn                   21    0.311  rthal_irq_trampoline+0x8 (__ipipe_sync_stage+0xc1)
:|fn                   21    0.155  xnintr_clock_handler+0x8 (rthal_irq_trampoline+0x2c)
:|fn                   21    0.195  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:|fn                   21    0.454  xnpod_announce_tick+0xb (xnintr_irq_handler+0x28)
:|(0x11) 0x80000000    22    0.220  xnpod_announce_tick+0x214 (xnintr_irq_handler+0x28)
:|fn                   22    0.298  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xb8)
:|fn                   22    0.425  xnthread_timeout_handler+0x8 (xntimer_do_tick_aperiodic+0x273)
:|fn                   23    0.148  xnpod_resume_thread+0xc (xnthread_timeout_handler+0x22)
:|(0x11) 0x80000000    23    0.362  xnpod_resume_thread+0x350 (xnthread_timeout_handler+0x22)
:|(0x11) 0x80000000    23    0.319  xnpod_resume_thread+0x21b (xnthread_timeout_handler+0x22)
:|(0x11) 0x80000001    24+   2.933  xntimer_do_tick_aperiodic+0x20c (xnpod_announce_tick+0xb8)
:|(0x22) 0x80000001    26    0.320  xntimer_do_tick_aperiodic+0x233 (xnpod_announce_tick+0xb8)
:|(0x11) 0x80000000    27    0.202  xnpod_announce_tick+0x183 (xnintr_irq_handler+0x28)
:|fn                   27    0.159  xnpod_schedule+0xe (xnintr_irq_handler+0xa5)
:|(0x11) 0x80000000    27+   1.029  xnpod_schedule+0x68a (xnintr_irq_handler+0xa5)
:|(0x11) 0x80000000    28    0.214  xnpod_schedule+0x985 (xnpod_suspend_thread+0x2b7)
:|(0x11) 0x80000000    28    0.325  xnpod_suspend_thread+0x1ba (rtdm_task_sleep_until+0x99 [xeno_rtdm])
:|(0x11) 0x80000000    29    0.194  rtdm_task_sleep_until+0xe4 [xeno_rtdm] (timer_task_proc+0x12c [xeno_timerbench])
:|fn                   29    0.190  ipipe_unstall_pipeline_from+0xd (timer_task_proc+0x145 [xeno_timerbench])
:|(0x11) 0x80000001    29+   1.144  ipipe_unstall_pipeline_from+0x90 (timer_task_proc+0x145 [xeno_timerbench])
:|begin  0x80000002    30    0.162  common_interrupt+0x21 (ipipe_unstall_pipeline_from+0xff)
:|fn                   30    0.237  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|fn                   31    0.397  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0xf5)
:|(0x11) 0x80000000    31    0.176  __ipipe_ack_common_irq+0xd3 (__ipipe_handle_irq+0xf5)
:|fn                   31    0.315  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0x40)
:|(0x11) 0x80000001    32+   4.283  mask_and_ack_8259A+0x9f (__ipipe_ack_common_irq+0x40)
:|(0x22) 0x80000001    36    0.300  mask_and_ack_8259A+0x124 (__ipipe_ack_common_irq+0x40)
<|end    0x80000002    36    0.470  common_interrupt+0x34 (ipipe_unstall_pipeline_from+0xff)
  end    0x80000000    37    0.236  ipipe_unstall_pipeline_from+0x104 (timer_task_proc+0x145 [xeno_timerbench])
  fn                   37    0.186  xnpod_get_time+0x8 (timer_task_proc+0x8c [xeno_timerbench])
  fn                   37    0.575  xntimer_get_jiffies_aperiodic+0xe (xnpod_get_time+0x10)
  fn                   38    0.202  eval_inner_loop+0xb [xeno_timerbench] (timer_task_proc+0xb2 [xeno_timerbench])
  begin  0x80000000    38    0.000  timer_task_proc+0x166 [xeno_timerbench] (xnarch_thread_redirect+0x97)

--------------010906060700030503030809
Content-Type: text/plain;
 name="xeno-2.1-athlon800.trace2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-2.1-athlon800.trace2"

I-pipe worst-case tracing service on 2.6.14.3/ipipe-1.1-00
------------------------------------------------------------
Begin: 1625655337641 cycles, Trace Points: 44 (-10/+5), Length: 38 us

  Type   User Val.   Time    Delay  Function (Parent)
  fn                   -5    0.126  __ipipe_unstall_root+0x8 (find_get_page+0x3b)
  begin  0x80000000    -5    0.368  __ipipe_unstall_root+0x19 (find_get_page+0x3b)
  end    0x80000000    -5    0.225  __ipipe_unstall_root+0x43 (find_get_page+0x3b)
  fn                   -5    0.387  file_read_actor+0xd (do_generic_mapping_read+0x3c8)
  fn                   -4    2.175  __copy_to_user_ll+0xa (file_read_actor+0x77)
  fn                   -2    0.311  update_atime+0xc (do_generic_mapping_read+0x41b)
  fn                   -2    0.394  current_fs_time+0xe (update_atime+0x51)
  fn                   -1    0.215  timespec_trunc+0xb (current_fs_time+0x65)
  fn                   -1    0.206  dnotify_parent+0xa (vfs_read+0xb5)
  fn                   -1    1.337  inotify_dentry_parent_queue_event+0xa (vfs_read+0xd5)
>|begin  0x80000002     0    0.226  common_interrupt+0x21 (mcount+0x29)
:|fn                    0    0.907  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|fn                    1    0.417  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0xf5)
:|fn                    1    0.136  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0xa4)
:|(0x11) 0x80000001     1!  12.181  mask_and_ack_8259A+0x9f (__ipipe_ack_common_irq+0xa4)
:|(0x22) 0x80000001    13    0.283  mask_and_ack_8259A+0x124 (__ipipe_ack_common_irq+0xa4)
:|fn                   14+   1.431  __ipipe_sync_stage+0xe (__ipipe_handle_irq+0x225)
:|begin  0x80000002    15    0.371  common_interrupt+0x21 (__ipipe_sync_stage+0xdd)
:|fn                   15    0.219  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|fn                   16    0.313  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0xf5)
:|fn                   16    0.176  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0xa4)
:|(0x11) 0x80000001    16+   3.290  mask_and_ack_8259A+0x9f (__ipipe_ack_common_irq+0xa4)
:|(0x22) 0x80000001    19    0.577  mask_and_ack_8259A+0x124 (__ipipe_ack_common_irq+0xa4)
:|fn                   20    0.201  ipipe_suspend_domain+0xc (__ipipe_handle_irq+0x1cc)
:|(0x11) 0x80000001    20    0.200  ipipe_suspend_domain+0xac (__ipipe_handle_irq+0x1cc)
:|fn                   20    0.529  __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x68)
:|fn                   21    0.217  rthal_irq_trampoline+0x8 (__ipipe_sync_stage+0xc1)
:|fn                   21    0.358  xnintr_clock_handler+0x8 (rthal_irq_trampoline+0x2c)
:|fn                   22    0.199  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:|fn                   22    0.220  xnpod_announce_tick+0xb (xnintr_irq_handler+0x28)
:|(0x11) 0x80000000    22    0.585  xnpod_announce_tick+0x214 (xnintr_irq_handler+0x28)
:|fn                   23    0.311  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xb8)
:|fn                   23    0.205  xnthread_timeout_handler+0x8 (xntimer_do_tick_aperiodic+0x273)
:|fn                   23    0.475  xnpod_resume_thread+0xc (xnthread_timeout_handler+0x22)
:|(0x11) 0x80000000    24    0.361  xnpod_resume_thread+0x350 (xnthread_timeout_handler+0x22)
:|(0x11) 0x80000000    24    0.373  xnpod_resume_thread+0x21b (xnthread_timeout_handler+0x22)
:|(0x11) 0x80000001    24+   2.892  xntimer_do_tick_aperiodic+0x20c (xnpod_announce_tick+0xb8)
:|(0x22) 0x80000001    27    0.209  xntimer_do_tick_aperiodic+0x233 (xnpod_announce_tick+0xb8)
:|(0x11) 0x80000000    27    0.474  xnpod_announce_tick+0x183 (xnintr_irq_handler+0x28)
:|fn                   28    0.363  xnpod_schedule+0xe (xnintr_irq_handler+0xa5)
:|(0x11) 0x80000000    28    0.936  xnpod_schedule+0x68a (xnintr_irq_handler+0xa5)
:|(0x11) 0x80000000    29    0.550  xnpod_schedule+0x985 (xnpod_suspend_thread+0x2b7)
:|(0x11) 0x80000000    30    0.288  xnpod_suspend_thread+0x1ba (rtdm_task_sleep_until+0x99 [xeno_rtdm])
:|(0x11) 0x80000000    30    0.334  rtdm_task_sleep_until+0xe4 [xeno_rtdm] (timer_task_proc+0x12c [xeno_timerbench])
:|fn                   30    0.186  ipipe_unstall_pipeline_from+0xd (timer_task_proc+0x145 [xeno_timerbench])
:|(0x11) 0x80000001    31    0.912  ipipe_unstall_pipeline_from+0x90 (timer_task_proc+0x145 [xeno_timerbench])
:|begin  0x80000002    31    0.303  common_interrupt+0x21 (ipipe_unstall_pipeline_from+0xff)
:|fn                   32    0.226  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|fn                   32    0.191  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0xf5)
:|(0x11) 0x80000000    32    0.417  __ipipe_ack_common_irq+0xd3 (__ipipe_handle_irq+0xf5)
:|fn                   33    0.136  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0x40)
:|(0x11) 0x80000001    33+   4.519  mask_and_ack_8259A+0x9f (__ipipe_ack_common_irq+0x40)
:|(0x22) 0x80000001    37    0.290  mask_and_ack_8259A+0x124 (__ipipe_ack_common_irq+0x40)
<|end    0x80000002    38    0.306  common_interrupt+0x34 (ipipe_unstall_pipeline_from+0xff)
  end    0x80000000    38    0.397  ipipe_unstall_pipeline_from+0x104 (timer_task_proc+0x145 [xeno_timerbench])
  fn                   38    0.165  xnpod_get_time+0x8 (timer_task_proc+0x8c [xeno_timerbench])
  fn                   38    0.313  xntimer_get_jiffies_aperiodic+0xe (xnpod_get_time+0x10)
  fn                   39    0.638  eval_inner_loop+0xb [xeno_timerbench] (timer_task_proc+0xb2 [xeno_timerbench])
  begin  0x80000000    39    0.000  timer_task_proc+0x166 [xeno_timerbench] (xnarch_thread_redirect+0x97)

--------------010906060700030503030809
Content-Type: text/plain;
 name="leaking-irq.trace"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="leaking-irq.trace"

  Type   User Val.   Time    Delay  Function (Parent)
  fn                   -9    0.149  activate_task+0xb (try_to_wake_up+0x100)
  fn                   -9    0.836  sched_clock+0xd (activate_task+0x13)
  fn                   -8    1.616  recalc_task_prio+0xe (activate_task+0x1f)
  fn                   -6    0.250  effective_prio+0x8 (recalc_task_prio+0x17d)
  fn                   -6    0.825  enqueue_task+0xa (activate_task+0x59)
  fn                   -5    0.136  __ipipe_restore_root+0x8 (try_to_wake_up+0x4d)
  fn                   -5    0.309  __ipipe_stall_root+0x8 (__ipipe_restore_root+0x11)
  fn                   -5    0.527  preempt_schedule+0xb (try_to_wake_up+0x8b)
  fn                   -4    0.175  xnpod_schedule+0xe (lostage_handler+0x115)
  fn                   -4    0.720  ipipe_trigger_irq+0xe (xnpod_schedule+0x660)
  begin  0x80000001    -3    0.430  ipipe_trigger_irq+0xac (xnpod_schedule+0x660)
 |fn                   -3    0.566  __ipipe_handle_irq+0xe (ipipe_trigger_irq+0x55)
 |fn                   -2    0.315  ipipe_suspend_domain+0xc (__ipipe_handle_irq+0x1cc)
 |fn                   -2    0.455  __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x59)
 |fn                   -2    0.165  xnpod_schedule_handler+0x8 (__ipipe_sync_stage+0xca)
 |fn                   -1    0.694  xnpod_schedule+0xe (xnpod_schedule_handler+0x17)
  end    0x80000001    -1    0.332  ipipe_trigger_irq+0x7a (xnpod_schedule+0x660)
  fn                    0    0.228  __ipipe_stall_root+0x8 (resume_kernel+0x5)
  fn                    0    0.518  __ipipe_unstall_iret_root+0x8 (restore_raw+0x0)
  fn                    0    0.189  irq_exit+0x8 (__ipipe_sync_stage+0x177)
> begin  0x80000000     0! 874.819  __ipipe_sync_stage+0x120 (__ipipe_unstall_iret_root+0x42)
:|begin  0x80000002   874    0.157  common_interrupt+0x21 (<b7f2a1e3>)
:|fn                  874    0.356  __ipipe_handle_irq+0xe (common_interrupt+0x29)
:|fn                  875    0.888  __ipipe_ack_common_irq+0xb (__ipipe_handle_irq+0xf5)
:|fn                  876+   1.780  mask_and_ack_8259A+0xc (__ipipe_ack_common_irq+0xa4)
:|fn                  878    0.152  ipipe_suspend_domain+0xc (__ipipe_handle_irq+0x1cc)
:|fn                  878    0.502  __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x59)
:|fn                  878    0.181  rthal_irq_trampoline+0x8 (__ipipe_sync_stage+0xca)
:|fn                  878    0.315  xnintr_clock_handler+0x8 (rthal_irq_trampoline+0x2c)
:|fn                  879    0.179  xnintr_irq_handler+0xb (xnintr_clock_handler+0x18)
:|fn                  879    0.290  xnpod_announce_tick+0xb (xnintr_irq_handler+0x28)
:|fn                  879    0.597  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xb8)
:|fn                  880    0.139  xnthread_timeout_handler+0x8 (xntimer_do_tick_aperiodic+0x240)
:|fn                  880+   3.327  xnpod_resume_thread+0xc (xnthread_timeout_handler+0x22)
:|fn                  883+   1.346  xnpod_schedule+0xe (xnintr_irq_handler+0xa5)
:|fn                  885    0.188  ipipe_unstall_pipeline_from+0xd (timer_task_proc+0x145 [xeno_timerbench])
< end    0x80000000   885    0.375  ipipe_unstall_pipeline_from+0xd3 (timer_task_proc+0x145 [xeno_timerbench])
  fn                  885    0.137  xnpod_get_time+0x8 (timer_task_proc+0x8c [xeno_timerbench])
  fn                  885    0.293  xntimer_get_jiffies_aperiodic+0xe (xnpod_get_time+0x10)
  fn                  886    0.516  eval_inner_loop+0xb [xeno_timerbench] (timer_task_proc+0xb2 [xeno_timerbench])
  begin  0x80000000   886    0.000  timer_task_proc+0x166 [xeno_timerbench] (xnarch_thread_redirect+0x97)

--------------010906060700030503030809
Content-Type: text/plain;
 name="ipipe_trace.instr2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe_trace.instr2"

--- linux-2.6.14.3//arch/i386/kernel/ipipe-root.c.orig	2006-01-02 20:42:58.000000000 +0100
+++ linux-2.6.14.3//arch/i386/kernel/ipipe-root.c	2006-01-04 01:26:16.000000000 +0100
@@ -283,7 +283,7 @@ asmlinkage int __ipipe_kpreempt_root(str
 	}
 
 	__ipipe_stall_root();
-	local_irq_enable_hw();
+	local_irq_enable_hw_notrace();
 
 	return 1;		/* Ok, may reschedule now. */
 }
@@ -294,7 +294,7 @@ asmlinkage void __ipipe_unstall_iret_roo
 
 	/* Emulate IRET's handling of the interrupt flag. */
 
-	local_irq_disable_hw();
+	local_irq_disable_hw_notrace();
 
 	ipipe_load_cpuid();
 
--- linux-2.6.14.3//include/asm-i386/system.h.orig	2006-01-03 19:05:32.000000000 +0100
+++ linux-2.6.14.3//include/asm-i386/system.h	2006-01-04 22:15:53.000000000 +0100
@@ -481,18 +481,82 @@ void fastcall __ipipe_restore_root(unsig
 
 #define irqs_disabled()		__ipipe_test_root()
 
+#define halt()	__asm__ __volatile__("hlt": : :"memory")
+
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+
+#include <linux/ipipe_trace.h>
+
 #define safe_halt() do { \
-    __ipipe_unstall_root(); \
-    __asm__ __volatile__("sti; hlt": : :"memory"); \
+	__ipipe_unstall_root(); \
+	__asm__ __volatile__("sti": : :"memory"); \
+	ipipe_trace_end(0x8000000E); \
+	__asm__ __volatile__("hlt": : :"memory"); \
 } while(0)
 
-#define halt()	__asm__ __volatile__("hlt": : :"memory")
+#define ipipe_hw_save_flags_and_sti(x) do { \
+	__asm__ __volatile__("pushfl ; popl %0 ; sti":"=g" (x): /* no input */ :"memory"); \
+	ipipe_trace_end(0x8000000F); \
+} while (0)
+#define local_irq_disable_hw() do { \
+	if (!irqs_disabled_hw()) { \
+		ipipe_trace_begin(0x80000000); \
+		__asm__ __volatile__("cli": : :"memory"); \
+	} else \
+		ipipe_trace_special(0x11, 0x80000000); \
+} while (0)
+#define local_irq_enable_hw() do { \
+	if (irqs_disabled_hw()) { \
+		__asm__ __volatile__("sti": : :"memory"); \
+		ipipe_trace_end(0x80000000); \
+	} else \
+		ipipe_trace_special(0x22, 0x80000000); \
+} while (0)
+#define local_irq_save_hw(x) do { \
+	local_save_flags_hw(x); \
+	if (local_test_iflag_hw(x)) { \
+		ipipe_trace_begin(0x80000001); \
+		__asm__ __volatile__("cli": : :"memory"); \
+	} else \
+		ipipe_trace_special(0x11, 0x80000001); \
+} while (0)
+#define local_irq_restore_hw(x) do { \
+	__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); \
+	if (local_test_iflag_hw(x)) \
+		ipipe_trace_end(0x80000001); \
+	else \
+		ipipe_trace_special(0x22, 0x80000001); \
+} while (0)
+
+#define local_irq_disable_hw_notrace() \
+	__asm__ __volatile__("cli": : :"memory")
+#define local_irq_enable_hw_notrace() \
+	__asm__ __volatile__("sti": : :"memory")
+#define local_irq_save_hw_notrace(x) \
+	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+#define local_irq_restore_hw_notrace(x) \
+	__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc")
+
+#else /* !CONFIG_IPIPE_TRACE_IRQSOFF */
+
+#define safe_halt() do { \
+	__ipipe_unstall_root(); \
+	__asm__ __volatile__("sti; hlt": : :"memory"); \
+} while(0)
 
 #define ipipe_hw_save_flags_and_sti(x)	__asm__ __volatile__("pushfl ; popl %0 ; sti":"=g" (x): /* no input */ :"memory")
 #define local_irq_disable_hw() 			__asm__ __volatile__("cli": : :"memory")
 #define local_irq_enable_hw()			__asm__ __volatile__("sti": : :"memory")
 #define local_irq_save_hw(x)    __asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
 #define local_irq_restore_hw(x) __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc")
+
+#define local_irq_disable_hw_notrace    local_irq_disable_hw
+#define local_irq_enable_hw_notrace     local_irq_enable_hw
+#define local_irq_save_hw_notrace       local_irq_save_hw
+#define local_irq_restore_hw_notrace    local_irq_restore_hw
+
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+
 #define local_save_flags_hw(x)   __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */)
 #define local_test_iflag_hw(x)   ((x) & (1<<9))
 #define irqs_disabled_hw()	\

--------------010906060700030503030809--

--------------enig82AC67B6F18A747E4D6A60E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDvEMPniDOoMHTA+kRAkToAJ0YGFPPPKV7NztRAaA43gRpJYJP6wCeOe7C
z8rut9tMi+n+b8P/gQz46Yc=
=ftXk
-----END PGP SIGNATURE-----

--------------enig82AC67B6F18A747E4D6A60E9--

