Message-ID: <43FB546E.5090802@domain.hid>
Date: Tue, 21 Feb 2006 18:57:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] no-brainer issue found, but not solved
References: <C020900D.24A8%steve@domain.hid>
In-Reply-To: <C020900D.24A8%steve@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5C318C980832B8C6A618FD4F"
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
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C318C980832B8C6A618FD4F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> I have found what seems to cause my problem.
>=20
> I have two threads, t1 and t2.
>=20
> t1 has a priority level of 30, and t2 has a priority level of 5. I am u=
sing
> the native skin, so t1 has the higher priority.
>=20
> t2 is flashing an LED on my board every 40 ms, and t1 does nothing unti=
l I
> hit a key on the keyboard. When t1 activates, it does for(i=3D0; i<1000=
00000;
> i++) which locks up my board for about 3 seconds. During this time, I e=
xpect
> my LED to stop flashing. However, the LED will flash a few times just o=
nce,
> at a rate of about 1 second. (Coincidentally, 1 second is the timing of=

> another unrelated thread in the system.)
>=20
> At the start of my t1 thread, I use syslog (a system call) to log that =
the
> thread is created. This call is made once before the thread goes into i=
ts
> loop, waiting for a global variable to be set otherwise just calling
> rt_task_wait_period(). If I comment out my call to syslog, which again =
I
> state is NOT in the thread loop, this behavior goes away. It seems that=
 once
> a syscall is made in a shadow thread, xenomai fails to have it behave i=
n a
> true hard realtime fashion. It's as if the thread stays relaxed.

It does stay relaxed until the next blocking RT function is invoked.
When unsure if this happens (I am from your description, maybe you
should rather post a code snippet), try rt_task_set_mode(0, T_PRIMARY,
NULL) before entering the loop.

>=20
> Does this shed any light on the issue I have?
>=20
> Steven
>=20
>=20

Jan


--------------enig5C318C980832B8C6A618FD4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD+1RuniDOoMHTA+kRAtN5AJ9lNphaHEU945U7sh9sCuRRcqpxbgCfR+t3
aI/p/kUt3B4RTSIKR2liL3I=
=qyNG
-----END PGP SIGNATURE-----

--------------enig5C318C980832B8C6A618FD4F--

