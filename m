Message-ID: <44A295ED.2080306@domain.hid>
Date: Wed, 28 Jun 2006 16:45:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Prio-inversion on cleanup?
References: <44A1608B.3090605@domain.hid>
In-Reply-To: <44A1608B.3090605@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5DDD43D7F6EE923205F1190B"
Sender: jan.kiszka@domain.hid
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
--------------enig5DDD43D7F6EE923205F1190B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> could someone give this scenario a try (requires my recent patch series=
)
> and tell me if you are also seeing excessive latencies:
>=20
> Start:
> irqloop (+xeno_irqbench) -P 99 -t 0
> latency -p 200 -P 50
>=20
> Terminate:
> irqloop
>=20
> The termination seems to cause high latencies to the (then highest-prio=
)
> periodic timer test. This does not happen with irqloop -t 1
> (kernel-based task), and I can reduce the effect by invoking
> pthread_setschedparam(SCHED_NORMAL) for the irqloop test thread right
> before termination. Also, running and terminating another latency
> instance with prio 99 does not have this effect.
>=20

I extended the tracer with support for the new service

	ipipe_trace_pid(pid, priority);

and recorded the following on irqloop cleanup:

> :     func               -11679+   2.661  sys_rtdm_close+0x8 (losyscall=
_event+0xa3)
> :     func               -11677+   4.045  _rtdm_close+0xe (sys_rtdm_clo=
se+0x11)
> :|  * func               -11673+   4.601  __ipipe_restore_pipeline_head=
+0x8 (_rtdm_close+0x8c)
> :     func               -11668+   1.323  rt_irqbench_close+0x9 [xeno_i=
rqbench] (_rtdm_close+0xd1)
> :     func               -11667+   2.345  rt_irqbench_stop+0x9 [xeno_ir=
qbench] (rt_irqbench_close+0x21 [xeno_irqbench])
> :     func               -11664+   3.383  _rtdm_synch_flush+0xa (rt_irq=
bench_close+0x2e [xeno_irqbench])
> :|  * func               -11661+   4.751  xnsynch_flush+0xe (_rtdm_sync=
h_flush+0x3b)
> :|  * func               -11656+   3.894  xnpod_resume_thread+0xe (xnsy=
nch_flush+0x76)
> :|  * func               -11652+   1.503  xnpod_schedule+0xe (_rtdm_syn=
ch_flush+0x45)
> :|  * func               -11651+   2.932  ipipe_trigger_irq+0xc (xnpod_=
schedule+0x29)
> :|  * func               -11648+   2.375  memcpy+0xe (ipipe_trigger_irq=
+0x4a)
> :|  * func               -11645+   3.270  __ipipe_handle_irq+0xe (ipipe=
_trigger_irq+0x4f)
> :|  * func               -11642+   3.436  __ipipe_dispatch_wired+0xe (_=
_ipipe_handle_irq+0x8a)
> :|  * func               -11639+   2.345  __ipipe_restore_pipeline_head=
+0x8 (_rtdm_synch_flush+0x5e)
> :|    func               -11636+   1.714  __ipipe_walk_pipeline+0xe (__=
ipipe_restore_pipeline_head+0x67)
> :|    func               -11635+   1.624  ipipe_suspend_domain+0xb (__i=
pipe_walk_pipeline+0x46)
> :|    func               -11633+   3.864  __ipipe_sync_stage+0xe (ipipe=
_suspend_domain+0x47)
> :|  * func               -11629+   1.864  xnpod_schedule_handler+0x8 (_=
_ipipe_sync_stage+0x115)
> :|  * func               -11627+   3.684  xnpod_schedule+0xe (xnpod_sch=
edule_handler+0x17)
> :|  * [  925] -<?>-    0 -11624+   6.496  xnpod_schedule+0x4f6 (xnpod_s=
chedule_handler+0x17)
> :|  * func               -11617+   7.157  __switch_to+0xe (xnpod_schedu=
le+0x612)
> :|  * [  926] -<?>-   99 -11610+   9.157  xnpod_schedule+0x6e6 (xnpod_s=
uspend_thread+0xed)
> :|  * func               -11601!  63.413  __ipipe_restore_pipeline_head=
+0x8 (rtdm_event_timedwait+0xea)
> :|    func               -11537+   2.586  __ipipe_handle_irq+0xe (commo=
n_interrupt+0x18)
> :|    func               -11535+   1.353  __ipipe_ack_common_irq+0xa (_=
_ipipe_handle_irq+0x80)
> :|    func               -11533+   2.165  ipipe_test_and_stall_pipeline=
_from+0x8 (__ipipe_ack_common_irq+0x16)
> :|  * func               -11531+   3.218  mask_and_ack_8259A+0xb (__ipi=
pe_ack_common_irq+0x3f)
> :|    func               -11528+   2.030  __ipipe_dispatch_wired+0xe (_=
_ipipe_handle_irq+0x8a)
> :|  * func               -11526+   2.225  xnintr_clock_handler+0x8 (__i=
pipe_dispatch_wired+0x7d)
> :|  * func               -11524+   2.030  xnintr_irq_handler+0xb (xnint=
r_clock_handler+0x17)
> :|  * func               -11522+   2.345  xnpod_announce_tick+0x8 (xnin=
tr_irq_handler+0x24)
> :|  * func               -11519+   2.624  xntimer_do_tick_aperiodic+0xe=
 (xnpod_announce_tick+0xf)
> :|  * func               -11517+   1.390  xnthread_periodic_handler+0x8=
 (xntimer_do_tick_aperiodic+0x7c)
> :|  * func               -11515+   6.977  xnpod_resume_thread+0xe (xnth=
read_periodic_handler+0x1b)
> :|  * func               -11508+   3.383  xnpod_schedule+0xe (xnintr_ir=
q_handler+0x5f)
> :|    func               -11505! 261.413  __ipipe_walk_pipeline+0xe (__=
ipipe_handle_irq+0x179)
> :     func               -11244+   6.150  __ipipe_syscall_root+0x9 (sys=
tem_call+0x20)
> :|    func               -11237+   2.030  __ipipe_handle_irq+0xe (commo=
n_interrupt+0x18)
> :|    func               -11235+   1.458  __ipipe_ack_common_irq+0xa (_=
_ipipe_handle_irq+0x80)
> :|    func               -11234+   1.909  ipipe_test_and_stall_pipeline=
_from+0x8 (__ipipe_ack_common_irq+0x16)
> :|  * func               -11232+   3.172  mask_and_ack_8259A+0xb (__ipi=
pe_ack_common_irq+0x3f)
> :|    func               -11229+   2.436  __ipipe_dispatch_wired+0xe (_=
_ipipe_handle_irq+0x8a)
> :|  * func               -11226+   1.984  xnintr_clock_handler+0x8 (__i=
pipe_dispatch_wired+0x7d)
> :|  * func               -11224+   2.248  xnintr_irq_handler+0xb (xnint=
r_clock_handler+0x17)
> :|  * func               -11222+   2.248  xnpod_announce_tick+0x8 (xnin=
tr_irq_handler+0x24)
> :|  * func               -11220+   3.969  xntimer_do_tick_aperiodic+0xe=
 (xnpod_announce_tick+0xf)
> :|  * func               -11216+   6.736  xnthread_periodic_handler+0x8=
 (xntimer_do_tick_aperiodic+0x7c)
> :|    func               -11209+   2.421  __ipipe_walk_pipeline+0xe (__=
ipipe_handle_irq+0x179)
> :     func               -11207+   1.939  __ipipe_dispatch_event+0xe (_=
_ipipe_syscall_root+0x55)
> :     func               -11205+   2.977  hisyscall_event+0xe (__ipipe_=
dispatch_event+0x5e)
> :     func               -11202+   4.015  xnshadow_relax+0xe (hisyscall=
_event+0x1ed)
> :     func               -11198+   3.218  schedule_linux_call+0xb (xnsh=
adow_relax+0x40)
> :|  * func               -11195+   3.984  __ipipe_restore_pipeline_head=
+0x8 (schedule_linux_call+0x5e)
> :     func               -11191+   2.105  rthal_apc_schedule+0x8 (sched=
ule_linux_call+0x68)
> :     func               -11189+   5.263  __ipipe_schedule_irq+0xa (rth=
al_apc_schedule+0x31)
> :|  * func               -11183+   6.586  xnpod_schedule_runnable+0xe (=
xnshadow_relax+0x87)
> :|  * func               -11177+   3.473  xnpod_suspend_thread+0xe (xns=
hadow_relax+0xb2)
> :|  * func               -11173+   3.819  xnpod_schedule+0xe (xnpod_sus=
pend_thread+0xed)
> :|  * [  926] -<?>-   99 -11169+   4.812  xnpod_schedule+0x4f6 (xnpod_s=
uspend_thread+0xed)
> :|  * func               -11165+   6.060  __switch_to+0xe (xnpod_schedu=
le+0x612)
> :|  * [  925] -<?>-   99 -11159+   3.714  xnpod_schedule+0x6e6 (xnpod_s=
chedule_handler+0x17)
> :|    func               -11155+   5.263  __ipipe_sync_stage+0xe (ipipe=
_suspend_domain+0x47)
> :    *func               -11150+   3.383  rthal_apc_handler+0x8 (__ipip=
e_sync_stage+0xf2)
> :    *func               -11146+   6.338  lostage_handler+0xa (rthal_ap=
c_handler+0x2b)
> :    *func               -11140+   1.466  wake_up_process+0x8 (lostage_=
handler+0xac)
> :    *func               -11138+   1.849  try_to_wake_up+0xe (wake_up_p=
rocess+0x14)
> :    *func               -11137+   3.518  __ipipe_test_and_stall_root+0=
x8 (try_to_wake_up+0x1a)
> :    *func               -11133+   3.954  sched_clock+0xa (try_to_wake_=
up+0x74)
> :    *func               -11129+   2.481  enqueue_task+0xa (try_to_wake=
_up+0xc7)
> :    *func               -11127+   2.015  __ipipe_restore_root+0x8 (try=
_to_wake_up+0x106)
> :    *func               -11125+   3.729  preempt_schedule+0xb (try_to_=
wake_up+0x13d)
> :|   *func               -11121+   2.751  __ipipe_unstall_iret_root+0x8=
 (restore_raw+0x0)
> :     func               -11118+   7.488  irq_exit+0x8 (__ipipe_sync_st=
age+0xff)
> :|  * func               -11111+   3.278  cleanup_instance+0xa (_rtdm_c=
lose+0x134)
> :|  * func               -11107+   3.503  __ipipe_restore_pipeline_head=
+0x8 (cleanup_instance+0x4a)
> :     func               -11104+   1.248  kfree+0xe (cleanup_instance+0=
x6d)
> :     func               -11103+   1.924  __ipipe_test_and_stall_root+0=
x8 (kfree+0x1a)
> :    *func               -11101+   4.060  kfree_debugcheck+0xa (kfree+0=
x27)
> :    *func               -11097+   1.849  check_irq_off+0x8 (kfree+0x4c=
)
> :    *func               -11095+   2.180  __ipipe_test_root+0x8 (check_=
irq_off+0xd)
> :    *func               -11093+   1.533  cache_free_debugcheck+0xe (kf=
ree+0x59)
> :    *func               -11091+   2.541  kfree_debugcheck+0xa (cache_f=
ree_debugcheck+0x28)
> :    *func               -11089+   2.165  dbg_redzone1+0x8 (cache_free_=
debugcheck+0x9f)
> :    *func               -11086+   2.473  dbg_redzone2+0x8 (cache_free_=
debugcheck+0xb0)
> :    *func               -11084+   1.406  dbg_redzone1+0x8 (cache_free_=
debugcheck+0xf7)
> :    *func               -11082+   2.105  dbg_redzone2+0x8 (cache_free_=
debugcheck+0x106)
> :    *func               -11080+   3.924  dbg_userword+0x8 (cache_free_=
debugcheck+0x11b)
> :    *func               -11076!  56.819  poison_obj+0xd (cache_free_de=
bugcheck+0x197)
> :    *func               -11020+   1.496  __ipipe_restore_root+0x8 (kfr=
ee+0x93)
> :    *func               -11018+   6.631  __ipipe_unstall_root+0x8 (__i=
pipe_restore_root+0x2b)
> :     func               -11012+   2.060  __ipipe_stall_root+0x8 (sysca=
ll_exit+0x5)
> :    *func               -11009+   2.458  schedule+0xe (work_resched+0x=
6)
> :    *func               -11007+   2.699  profile_hit+0x9 (schedule+0x6=
c)
> :    *func               -11004+   3.518  sched_clock+0xa (schedule+0x1=
13)
> :    *func               -11001+   7.353  __ipipe_stall_root+0x8 (sched=
ule+0x191)
> :    *func               -10993+   2.834  __ipipe_dispatch_event+0xe (s=
chedule+0x42f)
> :    *func               -10991+   5.075  schedule_event+0xb (__ipipe_d=
ispatch_event+0x5e)
> :|   *func               -10986+   5.413  __switch_to+0xe (xnpod_schedu=
le+0x612)
> :|   *[  925] -<?>-   99 -10980+   4.120  xnpod_schedule+0x6e6 (xnpod_s=
uspend_thread+0xed)
> :|  **func               -10976+   3.947  __ipipe_restore_pipeline_head=
+0x8 (xnshadow_relax+0xd0)
> :    *func               -10972+   1.330  ipipe_reenter_root+0xe (xnsha=
dow_relax+0xf1)
> :    *func               -10971+   6.796  __ipipe_unstall_root+0x8 (ipi=
pe_reenter_root+0x2e)
> :     func               -10964+   4.240  losyscall_event+0xe (__ipipe_=
dispatch_event+0x5e)
> :     func               -10960+   3.443  sys_open+0x8 (syscall_call+0x=
7)

Explanation of the recorded pid entries before and after __switch_to():

[<pid>] <task name> <priority>

Here 925 is the main thread of irqloop, 926 the irq user-mode pthread.
The pids are resolved on trace printing. And as the process terminated,
we do not see their names anymore.

Regarding the trace:

The pthread is blocked on the irqbench device ioctl. On hitting ^C,
close() is invoked from the main thread for that device. The pthread is
woken up and obviously relaxed on some linux syscall (after being
interrupted twice by the periodic timer event of a "latency -p 300 -P
50" instance). This passes the control over to the main thread while
keeping the pthread prio of 99. And this prio seems to survive for the
following 11 ms (full trace available on request).

Any ideas what's going on?

Jan


PS: ipipe-tracer and xenomai-core patch for pid/context tracing will
follow later.


--------------enig5DDD43D7F6EE923205F1190B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEopXtniDOoMHTA+kRAkqgAJ0TWC8LQqGoMH+LBF2qvZ7ZrbmoIwCdEodT
DyPxxRJwGEEqUcmjAcuzXOA=
=Sm8C
-----END PGP SIGNATURE-----

--------------enig5DDD43D7F6EE923205F1190B--

