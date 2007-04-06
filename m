Message-ID: <46165943.3050706@domain.hid>
Date: Fri, 06 Apr 2007 16:29:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Getting the clock model right
References: <46163817.3060007@domain.hid> <46164F5D.4080301@domain.hid>
In-Reply-To: <46164F5D.4080301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig98E86068F1A803212A12BD46"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig98E86068F1A803212A12BD46
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> recent announcement of some new TSC synchronisation feature in RTAI ma=
de
>> me stick my nose into this and think about the whole issue of clock
>> synchronisation again. Well, let's not talk about RTAI details here, b=
ut
>> they got one thing right: as long as we cannot handle unsynch'ed TSC o=
n
>> SMP, we need some detection and alarming as the bare minimum.
>>
>> Why can't we handle such cases yet? First, there seems to be still som=
e
>> bugs hidden in the core (one example: xntimer_start_aperiodic() uses t=
he
>> local time stamp to start a remote timer).
>=20
> Reading the code, there seem to be only two places where the local tsc
> is used to set a remote timer, it is xntimer_start_aperiodic, and
> xntimer_move_aperiodic, which is used by xntimer_migrate. So we are lef=
t
> with only one bug: starting a timer on the remote CPU, this could easil=
y
> be implemented with a queue which would be handled by the timer IPI.
>=20

As I said: fixable based on thorough review - but only a minor part of
the problem.

>=20
>> (...)
>> for smoothly adjusting clocks during runtime would be great. I'm
>> thinking about a generic infrastructure to synchronise the Xenomai tim=
e
>> on external sources (=3D>distributed clocks).
>=20
> What do you want, NTP ? Or calling xnpod_settime periodically ?
>=20

More like NTP: monotonic clocks that can be derived from custom
synchronisation signals, maybe optimised/simplified with fact in mind
that those signals should have bounded worst-case jitters (on a hard
real-time system like Xenomai).

We just implemented such synchronisation based on CAN and serial
null-modem signals. RTnet comes with a high-quality distributed clock as
well. We have not yet implemented a smart clock adjustment (specifically
because our application only needs about 1 millisecond accuracy).

Jan


--------------enig98E86068F1A803212A12BD46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGFllDniDOoMHTA+kRAr8bAJ9NIJz6bWGAzLmGgYLC8qLvvSkPOQCfQIe9
GI3Y4kf5ZCcX59mnIIJX2to=
=Qyw7
-----END PGP SIGNATURE-----

--------------enig98E86068F1A803212A12BD46--

