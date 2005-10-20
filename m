Message-ID: <4357C9F7.2060808@domain.hid>
Date: Thu, 20 Oct 2005 18:46:47 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] timeout in native API calls (cond, sem, mutex,
	etc).
References: <4357C3E1.1040701@domain.hid>
In-Reply-To: <4357C3E1.1040701@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD4696C0D58613DB16E59E354"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD4696C0D58613DB16E59E354
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ignacio Garc=EDa P=E9rez wrote:
> Hi,
>=20
> While porting my application, I noticed that all synchronization
> primitives locking calls take a relative timeout as a parameter, right?=

>=20
> Of course, I can get the current time, calculate the timeout interval b=
y
> substracting the current time from the desired timeout moment, and call=

> the function. But wouldn't something like this be possible?:
>=20
> Suppose I want to wait on a semaphore until t=3D1000, and now=3D900.
>=20
> 1- I get current time (900).
> 2- I calculate the relative timeout as 1000-900 =3D 100
> 3- I call rt_sem_p(&mysem, 100);
>=20
> In the best case, no preemption will occur between steps 1 and 3, but m=
y
> thread will still be sleeping not until t=3D1000, but until some time
> later, t=3D1000+d, where d is the time used by the code in steps 1-3 an=
d
> into the native skin/nucleus.
>=20
> In the worst case, in addition to that, the thread will be preempted
> between steps 1 and 3. If it is preempted by another higher priority
> thread for, say, 50 ticks, and the call in step 3 is actually executed
> at t=3D950, the thread will be sleeping until t=3D1050+d, which may not=
 be
> acceptable.
>=20
> What do you think?

That's true, having to convert between absolute and relative time (and
vice versa) in interruptible contexts can cause problems if the
application is not prepared for it.

The question is: do you really need that precise timeouts for
synchronisation primitives? Typically, timeouts are used here to detect
errors (someone else failed to signal), and you don't have to detect
them that precisely - typically.

An exception is when you want to maintain a single timeout across
multiple blocking calls. Then you could create a timer instead that
unblocks your infinitely waiting task when being triggered. Just as
timing out, unblocking also gives you an error when returning from the
blocking call.

Jan


--------------enigD4696C0D58613DB16E59E354
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDV8n3ncNeS9Q0k+IRAiuqAKCx9mXjTaq+99uXGNsOKAhWI3HoBgCg6G0j
ognhN/Do5dqRYQpo4Flnpyc=
=2t4q
-----END PGP SIGNATURE-----

--------------enigD4696C0D58613DB16E59E354--

