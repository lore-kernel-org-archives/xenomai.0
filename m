Message-ID: <44CD099F.9010507@domain.hid>
Date: Sun, 30 Jul 2006 21:33:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>	
	<200607221152.34298.bidsonux@domain.hid> <44C25DB0.50601@domain.hid>	
	<200607282317.34990.bidsonux@domain.hid>
	<44CB6EB3.5070707@domain.hid> <1154282619.4970.25.camel@domain.hid>
In-Reply-To: <1154282619.4970.25.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9AF4061CEA831EC74F5EAC06"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9AF4061CEA831EC74F5EAC06
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2006-07-29 at 16:20 +0200, Jan Kiszka wrote:
>>>> :|func        6   xnintr_clock_handler (__ipipe_dispatch_wired)
>>>> :|func        6   xnintr_irq_handler (xnintr_clock_handler)
>>>> :|func        7   xnpod_announce_tick (xnintr_irq_handler)
>>>> :|func        8+  xntimer_do_tick_aperiodic (xnpod_announce_tick)
>>>> :|func        9   xnthread_periodic_handler (xntimer_do_tick_aperiod=
ic)
>>>> :|func       10   xnpod_resume_thread (xnthread_periodic_handler)
>>>> :|[21559]    11+  xnpod_resume_thread (xnthread_periodic_handler)
>>>> :|func       13+  xnthread_periodic_handler (xntimer_do_tick_aperiod=
ic)
>> ...
>>
>>>> :|func      363+  xnthread_periodic_handler (xntimer_do_tick_aperiod=
ic)
>> That are a lot of overruns. Haven't counted, but it should be one
>> xnthread_periodic_handler per missed 100 us period (20000 / 100 =3D 20=
0!).
>> [BTW, I think we should handle even this failure scenario without
>> looping.
>=20
> We need to loop in the aperiodic handler in order to catch timers that
> could have elapsed while processing the current tick. However,

No, that was not what I meant. I know that we need the timer loop. But I
was thinking of something like this for the tick handler's error path:

if (unlikely((timer.date +=3D timer.interval) < now))
	timer.date =3D now + timer.interval -
		(now - timer.date) % timer.interval;

> xnpod_wait_thread_period() - over which rt_task_wait_period() is based =
-
> does not loop, but rather computes the actual count of overruns by
> substracting the current time from the deadline.

=2E..but by looping for some scenarios instead of dividing for all. Why
optimising the slow path here?

>=20
> Which brings us an interesting question: why does the aperiodic handler=

> loop frenetically in the first place? I would be pretty interested in
> checking the TSC values returned by xnarch_get_cpu_tsc() while spinning=

> inside this deadly loop...

You can already read those TSCs: each trace point got recorded with the
current TSC value, fresh from the hardware.

I rather think, also when looking at Julien's second trace, that we have
some issue with X in user-space here, probably in combination with weird
VIA hardware stalling IRQ delivery for a "few" microseconds. Let's see
if the irqbench gives similar results.

Jan


--------------enig9AF4061CEA831EC74F5EAC06
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEzQmfniDOoMHTA+kRAl/HAJ9ElhaJpVL3+XrRJyKHEmMS18IKeQCfZEbe
FwQ8JzbdcEHOMs80tBZlKxo=
=cm6D
-----END PGP SIGNATURE-----

--------------enig9AF4061CEA831EC74F5EAC06--

