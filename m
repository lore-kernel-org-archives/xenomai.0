Message-ID: <4415FAC5.7050608@domain.hid>
Date: Tue, 14 Mar 2006 00:05:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid>
	<200603131431.35216.lbocseg@domain.hid> <4415BB0D.8070808@domain.hid>
	<200603131631.26195.lbocseg@domain.hid>
In-Reply-To: <200603131631.26195.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig689DE805F8EEE79E9AAB260A"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig689DE805F8EEE79E9AAB260A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Segunda 13 Mar=E7o 2006 15:33, Jan Kiszka escreveu:
>=20
>> Rodrigo Rosenfeld Rosas wrote:
>>> Em Segunda 13 Mar=E7o 2006 14:25, Gilles Chanteperdrix escreveu:
>>>> Jan Kiszka wrote:
>>>>>> Sometimes the result is "Should be near 84000: 100000", that is ki=
nd of
>>>>>> correct, since the tickval is 100000, although I think that those
>>>>>> functions in the RTDM driver context should be independent of the =
tick
>>>>>> value set by the user program... Maybe using oneshot in the driver=

>>>>>> calls and periodic in the application... I really don't know what =
would
>>>>>> be the best approach here...
>>>>> rtdm_clock_read always uses the nucleus clock. Using something diff=
erent
>>>>> (e.g. always TSC) would break applications specifying absolute time=
s
>>>>> derived from the return values of other skins' functions.
>>>> Maybe adding a service to RTDM would allow users to measure short ti=
me
>>>> intervals with RTDM using the TSC ?
>>>>
>>>> The native (rt_timer_tsc()) and posix (clock_gettime(CLOCK_MONOTONIC=
))
>>>> skins have a way to do this.
>>> This would fit great for my needs (and most developers I think)!
>> Will think about it. Actually, I'm not a big fan of this. It creates t=
he
>> risk that someone feeds the output of this service into (incompatible)=

>> timed RTDM services.
>=20
> Sorry, I couldn't see a practical usage of this. Could you give an exam=
ple?
>=20
>> Even worse, this would work for aperiodic mode but fail for periodic.
>=20
> Actually it is only necessary on periodic modes as it already works for=
=20
> aperiodic mode.
>=20
>> We would definitely need a good name for it,
>> rtdm_clock_read_ex(<clock-id>), rtdm_clock_read_tsc(),
>> rtdm_clock_read_monotonic()? I'm not going to break rtdm_clock_read() =
by
>> adding an argument (otherwise, I would have to fix too many drivers on=

>> my own... :-/).
>=20
> That is the idea, I think. I agree that rtdm_clock_read() should be kep=
t as it=20
> is (the API/definition). No body is asking you to change it. Adding=20
> rtdm_clock_read_tsc() would be sufficient in my opinion whilst it maint=
ain=20
> coherency with other skins.

Thinking about this more thoroughly, a few questions popped up for me:

o When we call it rtdm_clock_read_tsc(), we should actually return the
  raw TSC values, shouln't we? But then we also need conversion
  functions (rtdm_clock_tsc2ns, rtdm_clock_ns2tsc). Or should we always
  convert to nanoseconds on return? POSIX and Native are different in
  this regard.

o What would be the core rationale behind it, having a high-resolution
  time stamp? What are the primary use cases? I'm asking for this so
  that I can clearly differentiate between this new service and the
  existing one in the docs. Also, giving an abstract description would
  leave more options to the actual implementation on other archs or
  platforms.

Jan


--------------enig689DE805F8EEE79E9AAB260A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFfrFniDOoMHTA+kRAoy6AJ0aTUlHgxx1AaGX/x4rSapNRZlfxwCdF6Ly
YvWxwX+3AHWyyrDj3lFIeuU=
=TDQq
-----END PGP SIGNATURE-----

--------------enig689DE805F8EEE79E9AAB260A--

