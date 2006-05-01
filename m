Message-ID: <445680AE.8080602@domain.hid>
Date: Mon, 01 May 2006 23:42:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [Xenomai-core] I-pipe latency tracer for ppc
References: <444FF092.2010002@domain.hid> <445656F0.2020800@domain.hid>
	<44565A5B.5010703@domain.hid> <44566283.20805@domain.hid>
In-Reply-To: <44566283.20805@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig91829EFFBCF205DBF868E38F"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91829EFFBCF205DBF868E38F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>> ...
>> This trace covers some long stall of the root domain, not the maximum
>> stall of the Xenomai domain that caused the 140 us above. See the
>> explanation for the stall bits above.
>=20
> Ah, some feed for the real experts.

Indeed :), comments below.

>=20
>>
>> Maybe the maximum irq latency tracing is broken, I haven't tested it
>> with latest ipipe patch revision yet. Well, that max path should not
>> trigger on root-domain stalls as long as there is some higher priority=

>> domain running - and it should have been reset on xenomai mounting. Hm=
m,
>> maybe only that reset does not work, please check by running "echo >
>> /proc/ipipe/trace/max" before the latency test.
>=20
> Yes, that changed something. I have attached the new output listing.
>=20
>> You could also test if the -f option of latency works for you. You wil=
l
>> find the result of the back-trace freezing on max latency under
>> /proc/ipipe/trace/frozen. The number of back-trace points can be tuned=

>> even after the event (only post-tracing required ahead-of-time tuning)=
=2E
>=20
> Seem to work. The output has been added to the attached file.
>=20
> Wolfgang.
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> bash-3.00# cat /proc/ipipe/trace/max
> I-pipe worst-case tracing service on 2.6.14/ipipe-1.3-00
> ------------------------------------------------------------
> Begin: 90358006525 cycles, Trace Points: 25 (-10/+4), Length: 69 us
> =20
>  +----- Hard IRQs ('|': locked)
>  |+---- <unused>
>  ||+--- <unused>
>  |||+-- Xenomai
>  ||||+- Linux ('*': domain stalled)
>  |||||                       +---------- Delay flag ('+': > 1 us, '!': =
> 10 us)
>  |||||                       |        +- NMI noise ('N')
>  |||||                       |        |
>       Type   User Val.   Time    Delay  Function (Parent)
>       fn                  -25    1.935  schedule+0x14 (syscall_exit_wor=
k+0x110)
>       fn                  -23    2.075  profile_hit+0x14 (schedule+0x68=
)
>       fn                  -21    2.390  sched_clock+0x14 (schedule+0xa0=
)
>       fn                  -19    4.400  __ipipe_stall_root+0x14 (schedu=
le+0x118)
>      *fn                  -14    2.040  __ipipe_dispatch_event+0x14 (sc=
hedule+0x300)
>  |   *begin  0x80000001   -12    3.190  __ipipe_dispatch_event+0x240 (s=
chedule+0x300)
>  |   *end    0x80000001    -9    1.990  __ipipe_dispatch_event+0x228 (s=
chedule+0x300)
>      *fn                   -7    4.115  schedule_event+0x14 (__ipipe_di=
spatch_event+0x160)
>  |   *begin  0x80000001    -3    1.835  __ipipe_dispatch_event+0x198 (s=
chedule+0x300)
>  |   *end    0x80000001    -1    1.815  __ipipe_dispatch_event+0x1b8 (s=
chedule+0x300)
>> |   *begin  0x80000000     0+   4.715  schedule+0x6ac (syscall_exit_wo=
rk+0x110)
> :|   *fn                    4+   1.225  __switch_to+0x14 (schedule+0x35=
8)
> :|   *fn                    5+   5.025  __ipipe_test_and_stall_root+0x1=
4 (__switch_to+0x30)
> :    *fn                   10+   1.445  schedule_tail+0x14 (ret_from_fo=
rk+0x60)
> :    *fn                   12+   3.450  __ipipe_unstall_root+0x14 (sche=
dule_tail+0x48)

Instrumentation of the maximum IRQs-off path seems to be broken. The two
functions above were entered with hard-IRQs on, so they should have
interrupted the trace path.

> :|   *fn                   15+   1.145  __ipipe_grab_timer+0x14 (__ipip=
e_ret_from_except+0x0)
> :|   *begin  0xc00466f4    16+   1.615  __ipipe_grab_timer+0x34 (__ipip=
e_ret_from_except+0x0)

Hmm, the User Value on x86 would contain the IRQ number here. Some
forgotten dereferencing? Looks like a pointer.

> :|   *fn                   18+   3.665  __ipipe_handle_irq+0x14 (__ipip=
e_grab_timer+0x4c)
> :|   *fn                   22+   1.980  __ipipe_walk_pipeline+0x14 (__i=
pipe_handle_irq+0x174)
> :|   *fn                   24+   2.540  ipipe_suspend_domain+0x14 (__ip=
ipe_walk_pipeline+0xe4)
> :|   *fn                   26+   3.600  __ipipe_sync_stage+0x14 (ipipe_=
suspend_domain+0xa8)
> :|  **fn                   30+   1.650  xnintr_clock_handler+0x14 (__ip=
ipe_sync_stage+0x1ac)
> :|  **fn                   31+   2.150  xnintr_irq_handler+0x14 (xnintr=
_clock_handler+0x38)
> :|  **fn                   34+   1.980  xnpod_announce_tick+0x14 (xnint=
r_irq_handler+0x58)
> :|  **fn                   36+   3.395  xntimer_do_tick_aperiodic+0x14 =
(xnpod_announce_tick+0x3c)
> :|  **fn                   39+   1.645  xnthread_periodic_handler+0x14 =
(xntimer_do_tick_aperiodic+0x2b4)
> :|  **fn                   41+   1.420  xnpod_resume_thread+0x14 (xnthr=
ead_periodic_handler+0x3c)
> :|  **fn                   42+   4.010  ipipe_test_and_stall_pipeline_h=
ead+0x14 (xnpod_resume_thread+0x34)
> :|  **fn                   46+   4.910  ipipe_restore_pipeline_head+0x1=
4 (xnpod_resume_thread+0x120)
> :|  **fn                   51+   1.870  xnpod_schedule+0x14 (xnintr_irq=
_handler+0xf0)
> :|  **fn                   53+   9.430  ipipe_test_and_stall_pipeline_h=
ead+0x14 (xnpod_schedule+0x80)
> :|  **fn                   62+   2.215  ipipe_restore_pipeline_head+0x1=
4 (xnpod_schedule+0x46c)
> :|  **fn                   64+   2.865  ipipe_restore_pipeline_head+0x1=
4 (xnpod_suspend_thread+0x94)
> :|  **fn                   67+   1.945  ipipe_restore_pipeline_head+0x1=
4 (xnpod_wait_thread_period+0x11c)
> <|   *end    0x80000000    69    7.185  ipipe_restore_pipeline_head+0xb=
c (xnpod_wait_thread_period+0x11c)
>      *end    0x80000001    76   10.310  __ipipe_dispatch_event+0x1b8 (_=
_ipipe_syscall_root+0x4c)
>      *fn                   86    1.495  __ipipe_syscall_root+0x14 (DoSy=
scall+0x24)
>      *fn                   88    1.660  __ipipe_dispatch_event+0x14 (__=
ipipe_syscall_root+0x4c)
>  |   *begin  0x80000001    90    0.000  __ipipe_dispatch_event+0x240 (_=
_ipipe_syscall_root+0x4c)
>=20
>=20
>=20
> bash-3.00# cat /proc/ipipe/trace/frozen
> I-pipe frozen back-tracing service on 2.6.14/ipipe-1.3-00
> ------------------------------------------------------------
> Freeze: 155250522464 cycles, Trace Points: 30 (+10)
> =20
>  +----- Hard IRQs ('|': locked)
>  |+---- <unused>
>  ||+--- <unused>
>  |||+-- Xenomai
>  ||||+- Linux ('*': domain stalled)
>  |||||                       +---------- Delay flag ('+': > 1 us, '!': =
> 10 us)
>  |||||                       |        +- NMI noise ('N')
>  |||||                       |        |
>       Type   User Val.   Time    Delay  Function (Parent)
> :|   *fn                  -80+   1.485  __ipipe_ack_irq+0x14 (__ipipe_h=
andle_irq+0x158)
> :|   *fn                  -78+   1.515  ipipe_test_and_stall_pipeline_f=
rom+0x14 (__ipipe_ack_irq+0x54)
> :|  **fn                  -77+   1.730  ppc4xx_uic0_ack+0x14 (__ipipe_a=
ck_irq+0x6c)
> :|   *fn                  -75+   1.390  __ipipe_walk_pipeline+0x14 (__i=
pipe_handle_irq+0x174)
> :|   *end    0xc0043f18   -74+   9.065  __ipipe_grab_irq+0x64 (__ipipe_=
ret_from_except+0x0)
> :    *end    0x80000001   -65!  10.695  __ipipe_dispatch_event+0x1b8 (_=
_ipipe_syscall_root+0x4c)
> :    *fn                  -54+   1.650  __ipipe_syscall_root+0x14 (DoSy=
scall+0x24)
> :    *fn                  -53+   1.710  __ipipe_dispatch_event+0x14 (__=
ipipe_syscall_root+0x4c)
> :|   *begin  0x80000001   -51+   2.660  __ipipe_dispatch_event+0x240 (_=
_ipipe_syscall_root+0x4c)
> :|   *fn                  -48+   4.420  hisyscall_event+0x14 (__ipipe_d=
ispatch_event+0xa4)
> :|   *fn                  -44+   2.540  __rt_timer_tsc2ns+0x14 (hisysca=
ll_event+0x224)
> :|   *fn                  -41+   5.630  rt_timer_tsc2ns+0x14 (__rt_time=
r_tsc2ns+0x48)
> :|   *end    0x80000001   -36+   4.420  __ipipe_dispatch_event+0x1b8 (_=
_ipipe_syscall_root+0x4c)
> :    *fn                  -31+   1.475  __ipipe_syscall_root+0x14 (DoSy=
scall+0x24)
> :    *fn                  -30+   1.715  __ipipe_dispatch_event+0x14 (__=
ipipe_syscall_root+0x4c)
> :|   *begin  0x80000001   -28+   1.960  __ipipe_dispatch_event+0x240 (_=
_ipipe_syscall_root+0x4c)
> :|   *fn                  -26+   2.880  hisyscall_event+0x14 (__ipipe_d=
ispatch_event+0xa4)
> :|   *fn                  -23+   1.610  sys_rtdm_ioctl+0x14 (hisyscall_=
event+0x224)
> :|   *fn                  -22+   2.145  _rtdm_ioctl+0x14 (sys_rtdm_ioct=
l+0x3c)
> :|   *fn                  -20+   1.325  rtdm_context_get+0x14 (_rtdm_io=
ctl+0x70)
> :|   *fn                  -18+   2.205  ipipe_test_and_stall_pipeline_h=
ead+0x14 (rtdm_context_get+0x58)
> :|  **fn                  -16+   1.630  ipipe_restore_pipeline_head+0x1=
4 (rtdm_context_get+0xcc)
> :|   *end    0x80000000   -14+   2.525  ipipe_restore_pipeline_head+0xb=
c (rtdm_context_get+0xcc)
> :    *fn                  -12+   1.410  rt_tmbench_ioctl_rt+0x14 (_rtdm=
_ioctl+0xb0)
> :    *fn                  -10+   1.940  tracer_ioctl+0x14 (rt_tmbench_i=
octl_rt+0x44)
> :    *fn                   -9+   1.550  ipipe_trace_frozen_reset+0x14 (=
tracer_ioctl+0x148)
> :    *fn                   -7+   1.600  __ipipe_global_path_lock+0x14 (=
ipipe_trace_frozen_reset+0x2c)
> :|   *begin  0x80000001    -5+   3.920  __ipipe_global_path_lock+0x98 (=
ipipe_trace_frozen_reset+0x2c)
> :|   *end    0x80000001    -2+   2.020  __ipipe_global_path_unlock+0x84=
 (ipipe_trace_frozen_reset+0x8c)
> <    *freeze 0x00000000     0    3.980  tracer_ioctl+0x150 (rt_tmbench_=
ioctl_rt+0x44)

Here we should see the observed latency in User Value, reported with the
ioctl down to the driver, then to ipipe_trace_freeze. 0 indicates some
remaining minor issue here as well.

>      *end    0x80000001     3    4.270  __ipipe_dispatch_event+0x1b8 (_=
_ipipe_syscall_root+0x4c)
>      *fn                    8    1.310  __ipipe_syscall_root+0x14 (DoSy=
scall+0x24)
>      *fn                    9    1.740  __ipipe_dispatch_event+0x14 (__=
ipipe_syscall_root+0x4c)
>  |   *begin  0x80000001    11    1.690  __ipipe_dispatch_event+0x240 (_=
_ipipe_syscall_root+0x4c)
>  |   *fn                   12    3.020  hisyscall_event+0x14 (__ipipe_d=
ispatch_event+0xa4)
>  |   *fn                   15    1.750  __rt_task_wait_period+0x14 (his=
yscall_event+0x224)
>  |   *fn                   17    1.760  rt_task_wait_period+0x14 (__rt_=
task_wait_period+0x44)
>  |   *fn                   19    1.385  xnpod_wait_thread_period+0x14 (=
rt_task_wait_period+0x88)
>  |   *fn                   20    2.465  ipipe_test_and_stall_pipeline_h=
ead+0x14 (xnpod_wait_thread_period+0x3c)
>  |  **fn                   23    0.000  xnpod_suspend_thread+0x14 (xnpo=
d_wait_thread_period+0x9c)
> bash-3.00#
>=20

Jan


--------------enig91829EFFBCF205DBF868E38F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEVoCuniDOoMHTA+kRAnI7AJ4mq0c0D3jkp2Wvn/lGQfbgCXfFyACfRxoT
/q9KEtsdMm/lGm7dfZQ2hbU=
=nPD2
-----END PGP SIGNATURE-----

--------------enig91829EFFBCF205DBF868E38F--

