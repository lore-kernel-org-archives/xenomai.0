Message-ID: <44736EE4.2060807@domain.hid>
Date: Tue, 23 May 2006 22:21:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7200C366298A5850B6492FCE"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] nervous nmi-watchdog
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
--------------enig7200C366298A5850B6492FCE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I'm getting nmi alarms about latency being > 100 us on a dual P-III 1GHz
(with and without CONFIG_SMP) once I start the latency test tool. But
the must be false positive. Can someone comment on this trace:

> :    *fn                 -109!  91.810  __ipipe_unstall_root+0x8 (defau=
lt_idle+0x3f)
> :|    fn                  -18    0.220  __ipipe_handle_irq+0xe (common_=
interrupt+0x18)
> :|    fn                  -17    0.228  __ipipe_ack_system_irq+0x8 (__i=
pipe_handle_irq+0x7f)
> :|    fn                  -17    0.191  __ipipe_dispatch_wired+0xb (__i=
pipe_handle_irq+0x8a)
> :|  * fn                  -17    0.219  xnintr_clock_handler+0x8 (__ipi=
pe_dispatch_wired+0x77)
> :|  * fn                  -17    0.198  rthal_nmi_disarm+0x8 (xnintr_cl=
ock_handler+0xd)
> :|  * fn                  -17    0.202  xnintr_irq_handler+0xb (xnintr_=
clock_handler+0x1d)
> :|  * fn                  -16    0.197  xnpod_announce_tick+0x8 (xnintr=
_irq_handler+0x24)
> :|  * fn                  -16    0.256  xntimer_do_tick_aperiodic+0xe (=
xnpod_announce_tick+0xf)
> :|  * fn                  -16    0.203  xnthread_periodic_handler+0x8 (=
xntimer_do_tick_aperiodic+0x7c)
> :|  * fn                  -16    0.590  xnpod_resume_thread+0xe (xnthre=
ad_periodic_handler+0x1c)
> :|  * fn                  -15    0.315  rthal_nmi_arm+0xe (xntimer_do_t=
ick_aperiodic+0x1ed)
> :|  * (0x00) 0x000305fb   -15    0.223  rthal_nmi_arm+0xb5 (xntimer_do_=
tick_aperiodic+0x1ed)

[This is an ipipe_trace_special, reporting the delay (~200 us =3D 100 us
period + 100 us nmi-trigger).]

> :|  * fn                  -15    0.370  xnpod_schedule+0xe (xnintr_irq_=
handler+0x5f)
> :|  * fn                  -14    0.694  __switch_to+0xe (xnpod_schedule=
+0x557)
> :|  * fn                  -13    0.826  __ipipe_restore_pipeline_head+0=
x8 (xnpod_wait_thread_period+0x1a1)
> :     fn                  -13    0.222  __ipipe_syscall_root+0x9 (syste=
m_call+0x20)
> :     fn                  -12    0.235  __ipipe_dispatch_event+0xe (__i=
pipe_syscall_root+0x55)
> :     fn                  -12    0.223  hisyscall_event+0xe (__ipipe_di=
spatch_event+0x5e)
> :     fn                  -12    0.188  __rt_task_wait_period+0xd (hisy=
scall_event+0x220)
> :     fn                  -12    0.192  rt_task_wait_period+0x8 (__rt_t=
ask_wait_period+0x39)
> :     fn                  -12    0.250  xnpod_wait_thread_period+0xe (r=
t_task_wait_period+0x32)
> :|  * fn                  -11    0.270  xnpod_suspend_thread+0xb (xnpod=
_wait_thread_period+0x6b)
> :|  * fn                  -11    0.342  xnpod_schedule+0xe (xnpod_suspe=
nd_thread+0xeb)
> :|  * fn                  -11    0.584  __switch_to+0xe (xnpod_schedule=
+0x557)
> :|    fn                  -10    0.264  __ipipe_walk_pipeline+0xe (__ip=
ipe_handle_irq+0x178)
> :|    fn                  -10    0.302  __ipipe_unstall_iret_root+0x8 (=
restore_raw+0x0)
> :     fn                  -10    0.191  __ipipe_stall_root+0x8 (default=
_idle+0x33)
> :    *fn                   -9+   6.641  __ipipe_unstall_root+0x8 (defau=
lt_idle+0x3f)
> :|    fn                   -3    0.530  do_nmi+0xd (nmi_stack_correct+0=
x1d)
> :|    fn                   -2+   1.315  dummy_nmi_callback+0x8 (do_nmi+=
0x39)
> :|    fn                   -1    0.384  notifier_call_chain+0xb (do_nmi=
+0x7b)
> :|    fn                    0    0.612  rthal_nmi_watchdog_tick+0xe (do=
_nmi+0x99)
> :|    fn                    0    0.373  rthal_latency_above_max+0x8 (rt=
hal_nmi_watchdog_tick+0x21)
> <|    freeze 0x00000064     0    1.060  rthal_latency_above_max+0x13 (r=
thal_nmi_watchdog_tick+0x21)

[And this happens less than 15 us after the arming.]

>  |    fn                    1    0.628  __ipipe_handle_irq+0xe (common_=
interrupt+0x18)
>  |    fn                    1    0.199  __ipipe_ack_common_irq+0xa (__i=
pipe_handle_irq+0xeb)
>  |    fn                    1    0.242  ipipe_test_and_stall_pipeline_f=
rom+0x8 (__ipipe_ack_common_irq+0x17)

Is there something like spurious nmi? No real nmi-related problem is
reported otherwise by the kernel.

Jan


--------------enig7200C366298A5850B6492FCE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEc27kniDOoMHTA+kRAhI2AJ9rBFtlMdqBlpvGBwLT6/fG/geEkQCfawPt
RIe9jrxSFeTxHIQbs2eTbd0=
=vBeb
-----END PGP SIGNATURE-----

--------------enig7200C366298A5850B6492FCE--

