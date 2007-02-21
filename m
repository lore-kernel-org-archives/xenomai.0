Message-ID: <45DC4E6A.6090708@domain.hid>
Date: Wed, 21 Feb 2007 14:51:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] latency results for ppc and x86
References: <725115.56324.qm@domain.hid>
	<Pine.LNX.4.60.0702211019590.2291@domain.hid>
	<45DC23D4.5090000@domain.hid>
	<Pine.LNX.4.60.0702211116020.2526@domain.hid>
	<45DC3B13.5090200@domain.hid>
	<Pine.LNX.4.60.0702211302290.2780@domain.hid>
In-Reply-To: <Pine.LNX.4.60.0702211302290.2780@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE895EEB51932CA4B1B234DFE"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Nicholas Mc Guire <der.herr@domain.hid>
Cc: adeos-main@gna.org, Wolfgang Grandegger <wg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE895EEB51932CA4B1B234DFE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nicholas Mc Guire wrote:
>>> I know that people want to move to user-space - but what is the
>>> advantage
>>> over RT-preempt then if you use the dynamic tick patch (scheduled to =
go
>>> mainline in 2.6.21 BTW) ?
>=20
>> So far, determinism (both /wrt mainline and latest -rt).
>=20
>> BTW, kernel space real time is specifically no longer recommendable fo=
r
>> commercial projects that have to worry about the (likely non-GPL)
>> license of their application code. And then there are those countless
>> technical advantages that speed up the development process of user spa=
ce
>> apps.
>=20
>=20
> well I don't see that advantage at this point - determinism seems to be=

> in the same range as you get on ADEOS based systems. That there is a
> move towards user-space is clear.

Yeah, it /seems/...

>=20
>>>
>>>>> my suspicion is that there is too much work being done on fast-hot
>>>>> CPUs
>>>>> and the low-end is being neglected - which is bad as the numbers yo=
u
>>>>> post here for ADEOS are numbers reachable with mainstream preemptiv=
e
>>>>> kernel by now as well (off course not on the low end systems though=
).
>>>
>>>> That's scenario-dependent. Simple setups like a plain timed task can=

>>>> reach the dimension of I-pipe-based Xenomai, but more complex scenar=
ios
>>>> suffer from the exploding complexity in mainstream Linux, even with
>>>> -rt.
>>>> Just think of "simple" mutexes realised via futexes.
>>>
>>>
>>> do you have some code samples with numbers ? I would be very
>>> interested in
>>> a demo that shows this problem - I was not able to really find a smok=
ing
>>> gun with RT-preempt and dynamic ticks (2.6.17.2).
>=20
>> I can't help with demo code, but I can name a few conceptual issues:
>=20
>> o Futexes may require to allocate memory when suspending on a contente=
d
>>   lock (refill_pi_state_cache)
>> o Futexes depend on mmap_sem
>=20
> ok - thats a nice one
>=20
>> o Preemptible RCU read-sides can either lead to OOM or require
>>   intrusive read-side priority boosting (see Paul McKenney's LWN
>>   article)
>> o Excessive lock nesting depths in critical code paths makes it hard t=
o
>>   predict worst-case behaviour (or to verify that measurements actuall=
y
>>   already triggered them)
>=20
> well thats true for ADEOS/RTAI/RTLinux as well - we are also only
> black-box testing the RT-kernel - there currently is absolutley NO
> prof for worst-case timing in any of the flavours of RT-Linux.

Nope, it isn't. There are neither sleeping not spinning lock nesting
depths of that kind in Xenomai or Adeos/I-pipe (or older RT extensions,
AFAIK) - ok, except for one spot in a driver we have scheduled for
re-design already.

>=20
>> o Any nanosleep&friends-using Linux process can schedule hrtimers at
>>   arbitrary dates, requiring to have a pretty close look at the
>>   (worst-case) timer usage pattern of the _whole_ system, not only the=

>>   SCHED_FIFO/RR part
>=20
> true - but resource overload hits all flavours - and the splitt of
> timers and timeouts in 2.6.18++ does reduce the risk clearly.

Compared to making all Linux timers hrtimers? Yes, for sure. But that
would be an insane idea anyway, just considering all the network-related
timers.

>=20
>> That's what I can tell from the heart. But one would have to analyse t=
he
>> code more thoroughly I guess.
>=20
> thanks for the imput - at the embedded world Thomas Gleixner
> demonstrated a simple control system that could sustain sub 10us
> scheduling jitter under load based on the latest rt-preempt + a bit
> of tuning I guess (actually don't know).

Without knowing the test (Wolfgang, did you see it?), I would guess the
setup as follows: dual-core GHz Pentium, isolated core for the timed
task, no peripheral interaction, no synchronisation means, likely even
no further syscalls except for the sleep service. Surely a progress over
plain Linux, but that one's only useful for very specific scenarios.

No one claims -rt is not useful or too limited. Each approach has its
preferred application domain. Knowing strength and weaknesses of both is
required here. And providing the user the choice (like Xenomai 3 will).

> The essence for me is that with
> the work in 2.6.X I don't see the big performance jump provided by teh
> hard-RT variants around - especially with respect to guaranteed worst
> case (and not only "black-box" results).

Could it be a bit too enthusiastic to base such an assessment on a
corner-case demonstration?

Jan


--------------enigE895EEB51932CA4B1B234DFE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3E5qniDOoMHTA+kRAnf4AJ0XnHRmKG4cyqkuTx6lomOOEOLahQCZAQPp
f+qBGXGiXCc771rRje1lY1U=
=mfvz
-----END PGP SIGNATURE-----

--------------enigE895EEB51932CA4B1B234DFE--

