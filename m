Message-ID: <45DA3445.8080207@domain.hid>
Date: Tue, 20 Feb 2007 00:35:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] tracer from user space
References: <45D6C540.9020707@domain.hid> <200702191654.32541.jweber@domain.hid>
In-Reply-To: <200702191654.32541.jweber@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB91E26581359D665D693DE69"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB91E26581359D665D693DE69
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Weber wrote:
> Ok,  here's the trace I captured from user space code when rt_task_wait=
_next_period() overran by 10s of milliseconds, which
> should "never happen" , and is the latency I'm hunting down.
>=20
>  |||+-- Xenomai
>  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)=

>  |||||                        +---------- Delay flag ('+': > 1 us, '!':=
 > 10 us)
                                                               ^^^^^
See, you are hunting milliseconds, but this trace is first of all about
micros. :)

You can extent its scope with /proc/ipipe/trace/back_trace_point.

>  |||||                        |        +- NMI noise ('N')
>  |||||                        |        |
>       Type    User Val.   Time    Delay  Function (Parent)
> :|  # func                 -61    0.573  xnpod_schedule+0xe [xeno_nucle=
us] (xnpod_suspend_thread+0x118 [xeno_nucleus])
> :|  # [   -1] -<?>-   90   -60    0.833  xnpod_schedule+0x97 [xeno_nucl=
eus] (xnpod_suspend_thread+0x118 [xeno_nucleus])
         1)       2)    3)
This 1) marks an xntrace_pid, a special trace point which are used in
the Xenomai nucleus to indicate some scheduling related event. Here we
have a "schedule out", below followed by a "schedule in". So out goes
some process with pid -1, that marks a Xenomai kernel thread. Next comes
the process name 2), here unknown to the trace, then the priority 3).
That should typically be enough to track down who was involved.

> :|  # func                 -59+   1.624  __switch_to+0xe (xnpod_schedul=
e+0x646 [xeno_nucleus])
> :|  # [12906] -<?>-   35   -58+   1.110  xnpod_schedule+0x6c0 [xeno_nuc=
leus] (xnintr_irq_handler+0x9a [xeno_nucleus])
> :|  + func                 -56    0.565  __ipipe_walk_pipeline+0xe (__i=
pipe_handle_irq+0x88)
> :|  + end     0xffffff05   -56!  38.026  common_interrupt+0x34 (<080fb1=
a7>)
         1)             2)                  3)                      4)

This is the end 1) of some interrupt 3) handler invocation. The involved
IRQ was number #5 2). The handler returns to user space as the low
address 4) indicates. So the following ~40 us are spent there until you
issue the syscall below - the manually triggered tracer freeze in this ca=
se.

> :   + func                 -18    0.543  __ipipe_syscall_root+0x11 (sys=
enter_past_esp+0x3b)
> :   + func                 -17    0.456  __ipipe_dispatch_event+0xe (__=
ipipe_syscall_root+0x59)
> :|  + begin   0x80000001   -17    0.706  __ipipe_dispatch_event+0x1e1 (=
__ipipe_syscall_root+0x59)
> :|  + end     0x80000001   -16    0.539  __ipipe_dispatch_event+0x1cf (=
__ipipe_syscall_root+0x59)
> :   + func                 -16+   1.446  hisyscall_event+0xe [xeno_nucl=
eus] (__ipipe_dispatch_event+0xd3)
> :   + func                 -14    0.454  __rt_task_set_mode+0x11 [xeno_=
native] (hisyscall_event+0x162 [xeno_nucleus])
> :   + func                 -14    0.535  rt_task_set_mode+0xe [xeno_nat=
ive] (__rt_task_set_mode+0x5b [xeno_native])
> :   + func                 -13    0.458  xnpod_set_thread_mode+0xe [xen=
o_nucleus] (rt_task_set_mode+0x9b [xeno_native])
> :|  + begin   0x80000001   -13    0.936  xnpod_set_thread_mode+0x18d [x=
eno_nucleus] (rt_task_set_mode+0x9b [xeno_native])
> :|  # func                 -12    0.556  __ipipe_restore_pipeline_head+=
0x11 (xnpod_set_thread_mode+0xca [xeno_nucleus])
> :|  + end     0x80000000   -11    0.800  __ipipe_restore_pipeline_head+=
0x53 (xnpod_set_thread_mode+0xca [xeno_nucleus])
> :|  + begin   0x80000001   -10    0.628  __ipipe_dispatch_event+0x1be (=
__ipipe_syscall_root+0x59)
> :|  + end     0x80000001   -10+   3.944  __ipipe_dispatch_event+0x18f (=
__ipipe_syscall_root+0x59)
> :   + func                  -6    0.443  __ipipe_syscall_root+0x11 (sys=
enter_past_esp+0x3b)
> :   + func                  -5    0.434  __ipipe_dispatch_event+0xe (__=
ipipe_syscall_root+0x59)
> :|  + begin   0x80000001    -5    0.722  __ipipe_dispatch_event+0x1e1 (=
__ipipe_syscall_root+0x59)
> :|  + end     0x80000001    -4    0.553  __ipipe_dispatch_event+0x1cf (=
__ipipe_syscall_root+0x59)
> :   + func                  -4    0.609  hisyscall_event+0xe [xeno_nucl=
eus] (__ipipe_dispatch_event+0xd3)
> :   + func                  -3    0.887  xnshadow_sys_trace+0x14 [xeno_=
nucleus] (hisyscall_event+0x162 [xeno_nucleus])
> :   + func                  -2    0.597  ipipe_trace_frozen_reset+0xe (=
xnshadow_sys_trace+0x94 [xeno_nucleus])
> :   + func                  -2    0.467  __ipipe_global_path_lock+0xe (=
ipipe_trace_frozen_reset+0x13)
> :|  + begin   0x80000001    -1+   1.084  __ipipe_global_path_lock+0x4d =
(ipipe_trace_frozen_reset+0x13)
> :|  + end     0x80000001     0    0.581  __ipipe_global_path_unlock+0x5=
c (ipipe_trace_frozen_reset+0x3b)
> <   + freeze  0x0000001f     0    0.617  xnshadow_sys_trace+0x8b [xeno_=
nucleus] (hisyscall_event+0x162 [xeno_nucleus])
>  |  + begin   0x80000001     0    0.559  __ipipe_dispatch_event+0x1be (=
__ipipe_syscall_root+0x59)
>  |  + end     0x80000001     1    1.956  __ipipe_dispatch_event+0x18f (=
__ipipe_syscall_root+0x59)
>=20
> I'm new to interpreting the trace output, and haven't yet been able to =
understand the line by line output.  However, I'm curious
> about the timing "lump" at time -56  (common_interrupt+0x34 ).. What is=
 going on there?

To understand what is really happening, you need to extend the trace as
I explained above. Then you should look for process switches ("[...]")
or for the IRQ or timer event that should have triggered the context
switch you are now finally seeing here. Given that prio-90 kernel thread
you have before the expected prio-35 process (pid 12906), the former one
might already be a candidate for analysing its activities.

HTH,
Jan


--------------enigB91E26581359D665D693DE69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF2jRFniDOoMHTA+kRAmGcAJ9kISjnOHzxUizYdXZnOGO5dmgjWwCfa/P3
9wwhK8hq8WA7QWLBZh0edik=
=hzok
-----END PGP SIGNATURE-----

--------------enigB91E26581359D665D693DE69--

