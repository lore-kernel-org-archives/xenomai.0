Message-ID: <45203E31.6050707@domain.hid>
Date: Mon, 02 Oct 2006 00:16:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4546494d0609300059p2879d7bcwb9bc898f279df140@domain.hid>
In-Reply-To: <4546494d0609300059p2879d7bcwb9bc898f279df140@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7E1363219216A5E6516880D6"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Adeos-main] ipip tracer porting for blackfin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E1363219216A5E6516880D6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> Hi,
>=20
> Attached ipipe-tracer ported to blackfin. The patch is based on
> http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-bf53x-R=
06R1RC2-1.4-03.patch.

Great!

>=20
> But it requires a little hack to Blackfin GCC-R06R1 to  make the "-pg"
> option work.  The latest release of bfin-gcc (06r2) has supported this
> feature. And I will update the ipipe tracer patch to the latest kernel
> release (r06r2).
>=20
> Also attached the ipipe tracer log.

It looks like a few instrumentation issues are remaining, see comments
below.

> Hoping for your comments.
>=20
> Best Regards,
>=20
> -Yi
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> root:~> ./latency -t0 -p 300 -f
>=20
>=20
> root:~> cat /proc/ipipe/trace/max
> I-pipe worst-case tracing service on 2.6.16.11.ADI-2006R1blackfin/ipipe=
-1.4-03
> ------------------------------------------------------------
> Begin: 240373976502 cycles, Trace Points: 24 (-10/+1), Length: 270 us
>=20
>  +----- Hard IRQs ('|': locked)
>  |+---- <unused>
>  ||+--- <unused>
>  |||+-- Xenomai
>  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)=

>  |||||                        +---------- Delay flag ('+': > 1 us, '!':=
 > 10 us)
>  |||||                        |        +- NMI noise ('N')
>  |||||                        |        |
>       Type    User Val.   Time    Delay  Function (Parent)
>  |  + begin   0x80000001   -20    0.910  ___ipipe_dispatch_event+0xb4 (=
__start+0xfffff000)
>  |  + end     0x80000001   -19    6.360  ___ipipe_dispatch_event+0x11a =
(__start+0xfffff000)
>     + func                 -13    1.440  ___ipipe_syscall_root+0xe (sys=
tem_call+0x2e)
>     + func                 -11    0.890  ___ipipe_dispatch_event+0xa (_=
__ipipe_syscall_root+0x24)
>  |  + begin   0x80000001   -10    1.280  ___ipipe_dispatch_event+0x20 (=
__start+0xfffff000)
>  |  + end     0x80000001    -9    1.530  ___ipipe_dispatch_event+0x88 (=
__start+0xfffff000)
>     + func                  -7    2.730  _hisyscall_event+0x10 (___ipip=
e_dispatch_event+0xa0)
>     + func                  -5    1.440  ___rt_task_wait_period+0xc (_h=
isyscall_event+0x134)
>     + func                  -3    1.820  _rt_task_wait_period+0xc (___r=
t_task_wait_period+0x4c)
>     + func                  -1    0.950  _xnpod_wait_thread_period+0xa =
(_rt_task_wait_period+0x4c)
>> |  + begin   0x80000001     1+   1.900  _xnpod_wait_thread_period+0x30=
 (__start+0xfffff000)
> :|  # func                   2+   1.640  _xnpod_suspend_thread+0xa (_xn=
pod_wait_thread_period+0x78)
> :|  # func                   4    0.892  _xnpod_schedule+0xa (_xnpod_su=
spend_thread+0x168)
> :|  # [   50] -<?>-   99     5+   1.658  _xnpod_schedule+0x112 (__start=
+0xfffff000)
> :|  # [    1] init    -1     7+   2.350  _xnpod_schedule+0x270 (__start=
+0xfffff000)
> :    +func                   9! 235.540  ___ipipe_walk_pipeline+0x1e (_=
__ipipe_handle_irq+0x14c)

Looks like there are some inconsistencies in the IRQ state tracing: You
schedule from latency (PID 50, now of unknown name "-<?>-", priority 99)
to the init process under Linux (PID 1, "init", ROOT thread priority
-1). After that switch the IRQs are very likely earlier reenabled, e.g.
on interrupt return. Compare the instrumentation of x86 with your version=
=2E

Moreover, IRQ entry and exit should also be traced. This doesn't seem to
happen yet, otherwise we would see some "begin" entry with the IRQ
number as user value. Again, check the x86 code for
ipipe_trace_begin/end passages.

> :|   +func                 244+   1.330  ___ipipe_grab_irq+0x10 (_evt_t=
imer+0x7c)
> :|   +func                 246+   1.560  ___ipipe_handle_irq+0x10 (___i=
pipe_grab_irq+0x32)
> :|   +func                 247+   2.120  _rthal_timer_ack+0x8 (___ipipe=
_handle_irq+0x174)
> :|   +func                 249+   1.680  ___ipipe_dispatch_wired+0x14 (=
___ipipe_handle_irq+0x74)
> :|  # func                 251+   1.270  _xnintr_clock_handler+0x10 (__=
_ipipe_dispatch_wired+0xa6)
> :|  # func                 252+   1.090  _xnintr_irq_handler+0x18 (_xni=
ntr_clock_handler+0x18)
> :|  # func                 254+   1.380  _xnpod_announce_tick+0xc (_xni=
ntr_irq_handler+0x2e)
> :|  # func                 255+   1.470  _xntimer_do_tick_aperiodic+0x1=
4 (_xnpod_announce_tick+0x16)
> :|  # func                 256+   1.400  _xnthread_periodic_handler+0xa=
 (_xntimer_do_tick_aperiodic+0x1d6)
> :|  # func                 258    0.790  _xnpod_resume_thread+0xa (_xnt=
hread_periodic_handler+0x1e)
> :|  # [   50] -<?>-   99   259+   2.510  _xnpod_resume_thread+0x4a (__s=
tart+0xfffff000)
> :|  # func                 261+   1.890  _xnpod_schedule+0xa (_xnintr_i=
rq_handler+0x82)
> :|  # func                 263+   1.380  _xnpod_schedule_deferred+0xc (=
___ipipe_call_irqtail+0x1e)
> :|  # func                 264    0.970  _xnpod_schedule+0xa (_xnpod_sc=
hedule_deferred+0x28)
> :|  # [    1] init    -1   265+   1.950  _xnpod_schedule+0x112 (__start=
+0xfffff000)
> :|  # [   50] -<?>-   99   267+   1.560  _xnpod_schedule+0x270 (__start=
+0xfffff000)
> :|  # func                 269    0.690  ___ipipe_restore_pipeline_head=
+0xa (_xnpod_wait_thread_period+0xfa)
> <|  + end     0x80000000   270    2.340  ___ipipe_restore_pipeline_head=
+0x90 (__start+0xfffff000)
>  |  + begin   0x80000001   272    0.000  ___ipipe_dispatch_event+0xb4 (=
__start+0xfffff000)
>=20
>=20
> root:~> cat /proc/ipipe/trace/frozen
> I-pipe frozen back-tracing service on 2.6.16.11.ADI-2006R1blackfin/ipip=
e-1.4-03
> ------------------------------------------------------------
> Freeze: 234204981352 cycles, Trace Points: 30 (+10)
>=20
>  +----- Hard IRQs ('|': locked)
>  |+---- <unused>
>  ||+--- <unused>
>  |||+-- Xenomai
>  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)=

>  |||||                        +---------- Delay flag ('+': > 1 us, '!':=
 > 10 us)
>  |||||                        |        +- NMI noise ('N')
>  |||||                        |        |
>       Type    User Val.   Time    Delay  Function (Parent)
> :|  #*func                 -58    0.990  _xnpod_schedule+0xa (_xnpod_sc=
hedule_deferred+0x28)
> :|  #*[    1] init    -1   -57+   2.210  _xnpod_schedule+0x112 (__start=
+0xfffff000)
> :|  #*[   50] -<?>-   99   -55+   2.380  _xnpod_schedule+0x270 (__start=
+0xfffff000)
> :|  #*func                 -52    0.710  ___ipipe_restore_pipeline_head=
+0xa (_xnpod_wait_thread_period+0xfa)
> :|  +*end     0x80000000   -52+   3.020  ___ipipe_restore_pipeline_head=
+0x90 (__start+0xfffff000)
> :|  +*begin   0x80000001   -49+   1.610  ___ipipe_dispatch_event+0xb4 (=
__start+0xfffff000)
> :|  +*end     0x80000001   -47+   6.900  ___ipipe_dispatch_event+0x11a =
(__start+0xfffff000)
> :   +*func                 -40+   1.330  ___ipipe_syscall_root+0xe (sys=
tem_call+0x2e)
> :   +*func                 -39    0.700  ___ipipe_dispatch_event+0xa (_=
__ipipe_syscall_root+0x24)
> :|  +*begin   0x80000001   -38+   1.340  ___ipipe_dispatch_event+0x20 (=
__start+0xfffff000)
> :|  +*end     0x80000001   -37+   1.360  ___ipipe_dispatch_event+0x88 (=
__start+0xfffff000)
> :   +*func                 -36+   2.080  _hisyscall_event+0x10 (___ipip=
e_dispatch_event+0xa0)
> :   +*func                 -33+   2.530  ___rt_timer_tsc2ns+0x14 (_hisy=
scall_event+0x134)
> :   +*func                 -31+   1.490  _rt_timer_tsc2ns+0xa (___rt_ti=
mer_tsc2ns+0x5e)
> :   +*func                 -29+   1.370  ___muldi3+0x14 (_rt_timer_tsc2=
ns+0x58)
> :   +*func                 -28+   2.330  ___muldi3+0x14 (_rt_timer_tsc2=
ns+0x6a)
> :   +*func                 -26+   4.460  ___div64_32+0xe (_rt_timer_tsc=
2ns+0x1d8)
> :|  +*begin   0x80000001   -21+   1.320  ___ipipe_dispatch_event+0xb4 (=
__start+0xfffff000)
> :|  +*end     0x80000001   -20+   3.380  ___ipipe_dispatch_event+0x11a =
(__start+0xfffff000)
> :   +*func                 -17+   1.330  ___ipipe_syscall_root+0xe (sys=
tem_call+0x2e)
> :   +*func                 -15    0.700  ___ipipe_dispatch_event+0xa (_=
__ipipe_syscall_root+0x24)
> :|  +*begin   0x80000001   -15+   1.340  ___ipipe_dispatch_event+0x20 (=
__start+0xfffff000)
> :|  +*end     0x80000001   -13+   1.360  ___ipipe_dispatch_event+0x88 (=
__start+0xfffff000)
> :   +*func                 -12+   2.100  _hisyscall_event+0x10 (___ipip=
e_dispatch_event+0xa0)
> :   +*func                 -10+   2.230  _xnshadow_sys_trace+0xc (_hisy=
scall_event+0x134)
> :   +*func                  -8+   1.470  _ipipe_trace_frozen_reset+0xa =
(_xnshadow_sys_trace+0xb2)
> :   +*func                  -6+   1.110  ___ipipe_global_path_lock+0xa =
(_ipipe_trace_frozen_reset+0xe)
> :|  +*begin   0x80000001    -5+   3.260  ___ipipe_global_path_lock+0x1a=
 (__start+0xfffff000)
> :|  +*end     0x80000001    -2+   1.160  ___ipipe_global_path_unlock+0x=
44 (__start+0xfffff000)
> <   +*freeze  0x0001ecf6     1    1.180  _xnshadow_sys_trace+0x9c (__st=
art+0xfffff000)

126 us (the user value of "freeze"), that looks ok given the overhead of
the tracer. If you extend your backtrace in this case to cover that
whole period, you can analyse what blocked the timer IRQ from waking up
earlier.

>  |  +*begin   0x80000001     2    0.930  ___ipipe_dispatch_event+0xb4 (=
__start+0xfffff000)
>  |  +*end     0x80000001     3    4.320  ___ipipe_dispatch_event+0x11a =
(__start+0xfffff000)
>     +*func                   7    1.160  ___ipipe_syscall_root+0xe (sys=
tem_call+0x2e)
>     +*func                   8    0.910  ___ipipe_dispatch_event+0xa (_=
__ipipe_syscall_root+0x24)
>  |  +*begin   0x80000001     9    0.950  ___ipipe_dispatch_event+0x20 (=
__start+0xfffff000)
>  |  +*end     0x80000001    10    1.350  ___ipipe_dispatch_event+0x88 (=
__start+0xfffff000)
>     +*func                  11    1.910  _hisyscall_event+0x10 (___ipip=
e_dispatch_event+0xa0)
>     +*func                  13    1.310  ___rt_task_wait_period+0xc (_h=
isyscall_event+0x134)
>     +*func                  15    1.930  _rt_task_wait_period+0xc (___r=
t_task_wait_period+0x4c)
>     +*func                  16    0.000  _xnpod_wait_thread_period+0xa =
(_rt_task_wait_period+0x4c)
>=20

Jan


--------------enig7E1363219216A5E6516880D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFID4xniDOoMHTA+kRAiK1AJ0Znw0+LNdq8yz1DGuc2/63qrUB+gCaAkOd
SA7IhnL7U6PkUnwApKEsq+U=
=CANI
-----END PGP SIGNATURE-----

--------------enig7E1363219216A5E6516880D6--

