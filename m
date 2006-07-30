Message-ID: <44CD2C0C.3@domain.hid>
Date: Mon, 31 Jul 2006 00:00:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>	
	<200607221152.34298.bidsonux@domain.hid> <44C25DB0.50601@domain.hid>	
	<200607282317.34990.bidsonux@domain.hid>
	<44CB6EB3.5070707@domain.hid>	 <1154282619.4970.25.camel@domain.hid>
	<44CD099F.9010507@domain.hid> <1154294584.4970.49.camel@domain.hid>
In-Reply-To: <1154294584.4970.49.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2C1DEC4FA2636440FE02AD36"
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
--------------enig2C1DEC4FA2636440FE02AD36
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2006-07-30 at 21:33 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Sat, 2006-07-29 at 16:20 +0200, Jan Kiszka wrote:
>>>>>> :|func        6   xnintr_clock_handler (__ipipe_dispatch_wired)
>>>>>> :|func        6   xnintr_irq_handler (xnintr_clock_handler)
>>>>>> :|func        7   xnpod_announce_tick (xnintr_irq_handler)
>>>>>> :|func        8+  xntimer_do_tick_aperiodic (xnpod_announce_tick)
>>>>>> :|func        9   xnthread_periodic_handler (xntimer_do_tick_aperi=
odic)
>>>>>> :|func       10   xnpod_resume_thread (xnthread_periodic_handler)
>>>>>> :|[21559]    11+  xnpod_resume_thread (xnthread_periodic_handler)
>>>>>> :|func       13+  xnthread_periodic_handler (xntimer_do_tick_aperi=
odic)
>>>> ...
>>>>
>>>>>> :|func      363+  xnthread_periodic_handler (xntimer_do_tick_aperi=
odic)
>>>> That are a lot of overruns. Haven't counted, but it should be one
>>>> xnthread_periodic_handler per missed 100 us period (20000 / 100 =3D =
200!).
>>>> [BTW, I think we should handle even this failure scenario without
>>>> looping.
>>> We need to loop in the aperiodic handler in order to catch timers tha=
t
>>> could have elapsed while processing the current tick. However,
>> No, that was not what I meant. I know that we need the timer loop. But=
 I
>> was thinking of something like this for the tick handler's error path:=

>>
>> if (unlikely((timer.date +=3D timer.interval) < now))
>> 	timer.date =3D now + timer.interval -
>> 		(now - timer.date) % timer.interval;
>>
>>> xnpod_wait_thread_period() - over which rt_task_wait_period() is base=
d -
>>> does not loop, but rather computes the actual count of overruns by
>>> substracting the current time from the deadline.
>> ...but by looping for some scenarios instead of dividing for all. Why
>> optimising the slow path here?
>=20
> Division is utterly expensive and having a jitter that would not fit
> in 32bit is seldom (and the definitive sign of serious brokenness anywa=
y),
> so this is actually the fast error path which gets optimized.
>=20
>>> Which brings us an interesting question: why does the aperiodic handl=
er
>>> loop frenetically in the first place? I would be pretty interested in=

>>> checking the TSC values returned by xnarch_get_cpu_tsc() while spinni=
ng
>>> inside this deadly loop...
>> You can already read those TSCs: each trace point got recorded with th=
e
>> current TSC value, fresh from the hardware.
>>
>=20
> I'd like to explain why we don't we see any other routines than
> xnthread_aperiodic_handler called from xntimer_do_tick_aperiodic in the=

> call frame? Even in case of massive jittery (e.g. > 300 us late) in one=

> shot, we should not spin in this code, due to the resync done in
> xnpod_wait_thread_timeout - assuming we only have a single outstanding
> timer (+ the host tick, but this should not be an issue).

xnpod_wait_thread_timeout? Do you mean xnpod_wait_thread_period? How
should it help us as long as we are in the tick handler?

>=20
>> I rather think, also when looking at Julien's second trace, that we ha=
ve
>> some issue with X in user-space here, probably in combination with wei=
rd
>> VIA hardware stalling IRQ delivery for a "few" microseconds. Let's see=

>> if the irqbench gives similar results.
>>
>=20
> The problem is that I can reproduce X-related jittery (> 2 ms in a row)=

> on one of my test boxen when dragging windows over the screen, without
> triggering the NMI watchdog set to 100 us (and guess what, the chipset
> in question is from VIA).

Does NMI management happen in the CPU or has the chipset any influence
as well? If yes, I could imagine what VIA does here... Have you already
checked what irqbench records?

Jan


--------------enig2C1DEC4FA2636440FE02AD36
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEzSwMniDOoMHTA+kRAm0MAJ9qJZfXuib+MX35TciPC5szr2YTlgCdEQbC
G5Tqgzh63VRTIyOG7PmrNR8=
=4wle
-----END PGP SIGNATURE-----

--------------enig2C1DEC4FA2636440FE02AD36--

