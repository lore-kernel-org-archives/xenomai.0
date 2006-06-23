Message-ID: <449BCE59.4000806@domain.hid>
Date: Fri, 23 Jun 2006 13:19:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] provide ipipe_traceing
	via	nucleus	interface
References: <449A76D0.30800@domain.hid> <1151046221.4438.16.camel@domain.hid>	
	<449BB3EA.70807@domain.hid> <1151055890.4438.36.camel@domain.hid>
In-Reply-To: <1151055890.4438.36.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig38D68BEBC1642C44E582B1F1"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig38D68BEBC1642C44E582B1F1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2006-06-23 at 11:27 +0200, Jan Kiszka wrote:
>>>> Index: include/nucleus/ipipe_trace.h
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> This file should go to include/asm-generic/ since it depends on the
>>> underlying real-time enabler (i.e. I-pipe). This way, there would be
>>> no need to check for __XENO_SIM__.
>> Ok, but how is the user supposed to include the API then? Or can we dr=
ag
>> it in implicitly somehow? That would be even nicer I think.
>>
>=20
> asm-generic/trace.h would be dragged in by include/asm-<arch>/hal.h, so=

> that we get the proper double dependancy on both the architecture if it=

> does provide the tracing feature, and also on the HAL which in turn
> requires the I-pipe.

Err, asm-<arch>/hal.h are pure kernel space headers, aren't they? But we
need user space support as well.

>=20
>>>> --- include/nucleus/ipipe_trace.h	(Revision 0)
>>>> +++ include/nucleus/ipipe_trace.h	(Revision 0)
>>>> @@ -0,0 +1,82 @@
>>>> +/*
>>>> Index: src/testsuite/latency/latency.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- src/testsuite/latency/latency.c	(Revision 1252)
>>>> +++ src/testsuite/latency/latency.c	(Arbeitskopie)
>>>> @@ -12,6 +12,7 @@
>>>>  #include <native/timer.h>
>>>>  #include <native/sem.h>
>>>>  #include <rtdm/rttesting.h>
>>>> +#include <nucleus/ipipe_trace.h>
>>>> =20
>>>>  RT_TASK latency_task, display_task;
>>>> =20
>>>> @@ -130,8 +131,7 @@ void latency (void *cookie)
>>>> =20
>>>>              if (freeze_max && (dt > gmaxjitter) && !(finished ||
>>> warmup))
>>>>                  {
>>>> -                rt_dev_ioctl(benchdev, RTBNCH_RTIOC_REFREEZE_TRACE,=

>>>> -                             rt_timer_tsc2ns(dt));
>>>> +                ipipe_trace_refreeze(rt_timer_tsc2ns(dt));
>>> I don't like the idea of spreading ipipe-something symbols and
>>> dependancies all over the entire source code including the generic on=
e,
>>> especially when considering that at some point, we are going to have
>>> preempt-rt as the other possible real-time enabler, like
>>> Adeos is already used now. We should use something more generic.
>>> "tracer*" would be ok, I guess.
>>>
>> I'm going to rescan Ingo's API to define a common interface where
>> feasible (their own user space API seems to hide behind gettimeofday).=

>=20
> Thanks. We should definitely consider the underlying the real-time
> enabling technology Xenomai uses to run skins over as an interchangeabl=
e
> component.
>=20

Unfortunately, Ingo's semantics are still quite different, partly
incompatible (and unhandy as well - you can only trace one event, not
the worst of a series like with the ipipe tracer). So we may need
special user code to deal with these differences (like in cyclictest).

The most critical point is that Ingo's tracer nukes any timing
guarantees when it fires. In contrast, the ipipe variant is RT-safe.

Anyway, let's try to go for these names and semantics (implementation:
ipipe / Ingo):

xntrace_max_begin(unsigned long v):
	Mark the worst-case path beginning together with an arbitrary
	ulong. This path is separated from the user path below.

	ipipe_trace_begin(v); / -

xntrace_max_end(unsigned long v):
	Mark the worst-case path end together with an arbitrary ulong.
	The path with maximum length can be obtained from the logs.

	ipipe_trace_end(v); / -

xntrace_user_start(void):
	Start the user trace path.

	ipipe_trace_frozen_reset(); / user_trace_start();

xntrace_user_stop(unsigned long v):
	Record an arbitrary ulong and stop the user trace path. The
	result is kept until the next invocation of
	xntrace_user_start() or xntrace_user_freeze(..., 0).

	ipipe_trace_freeze(v); /
	trace_special(v, 0, 0); user_trace_stop();

xntrace_user_freeze(unsigned long v, int once):
	Record an arbitrary ulong and freeze the user trace path. If
	once is 0, the tracer keeps running after the freeze so that
	always the latest result can be obtained. Otherwise, this call
	is equivalent to xntrace_user_stop(v).

	if (once)
		xntrace_user_stop(v);
	else
		ipipe_trace_frozen_reset(); ipipe_trace_freeze(v) / -

xntrace_special(unsigned char id, unsigned long v):
	Record an arbitrary uchar + ulong.

	ipipe_trace_special(id, v); / trace_special(v, 0, id);

xntrace_special_u64(unsigned char id, unsigned long long v):
	Record an arbitrary uchar + u64.

	ipipe_trace_special(id, v >> 32);
	ipipe_trace_special(id, v & 0xFFFFFFFF); /
	trace_special_u64(v, id);

I choose xntrace as prefix because Xenomai is used here to provide an
abstraction layer. Do you agree with the naming? Then this API should be
made available symmetrically in both kernel and use space. Still, the
question is via which header file...

Jan


--------------enig38D68BEBC1642C44E582B1F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEm85ZniDOoMHTA+kRAl00AJ9bGFb10kIbNkegYi6tf8DVjZx3jwCfd8A3
qj8jptYPioUGgRYIvgxb85U=
=wrJ5
-----END PGP SIGNATURE-----

--------------enig38D68BEBC1642C44E582B1F1--

