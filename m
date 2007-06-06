Message-ID: <4666A7C2.5080206@domain.hid>
Date: Wed, 06 Jun 2007 14:25:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <000001c7a832$2f5b9230$0419dcc3@domain.hid>
In-Reply-To: <000001c7a832$2f5b9230$0419dcc3@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9273CD7C2D0FF35BDD5A4706"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] real time task disapears... memory problem ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: DESVAGES Arnaud <desvages@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9273CD7C2D0FF35BDD5A4706
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

DESVAGES Arnaud wrote:
> Hello,
>=20
> =20
>=20
> I'm currently working on feedback scheduling. I have a set of tasks : a=
n MPC
> controller, a feedback scheduler, and some disturbance tasks.
>=20
> =20
>=20
> To do feedback scheduling, I need to measure the execution time quite
> accurately, and xenomai can not measure the execution time spend in the=

> secondary mode.

What kind of statistics would you precisely need? And where would you
need it, means where is your scheduler located, what API does it use?

> So I'm trying to stay in the primary mode. I had some calloc
> and free in one function that made me leave primary mode (for the MPC t=
ask).
>=20
> =20
>=20
> I tried to replace this by a rt_heap, and doing rt_heap_alloc in place =
of
> calloc, and I also tried to have static allocation.
>=20
> =20
>=20
> =20
>=20
> In both cases, my MPC task disappears when executing it! (nothing in
> /proc/xenomai/stat after the first try to execute it, but present durin=
g
> initialisation. and the other tasks are still here).
>=20
> =20
>=20
> I'm working on it for a few days now, and I can't find out what is wron=
g. I
> have tested to increase the maximum locked-in-memory size (in
> /etc/security/limits.conf). If I debug it with ddd, all is ok, array ar=
e
> well allocated...
>=20
> =20
>=20
> The strangest thing is that if I put a printf (this make a switch to
> secondary mode) saying that heap allocation was successful, everything =
works
> fine. So there is a function call that kills my task if I am in primary=

> mode, and executes well if I am in secondary mode?
>=20
> =20
>=20
> =20
>=20
> Do you have any idea on where may be the mistake? Do you need some more=

> information?
>=20

Primarily code. We need your code that demonstrates the weird behaviour.
If you patched Xenomai in any way, that patch would be required as well
of course.

BTW, did you already try to attach gdb to your disappearing process?
Maybe it can catch what makes it terminate.

> =20
>=20
> =20
>=20
> My config: Linux 2.6.17-x320 preempt
>=20

=2Econfig, Xenomai version, and I-pipe version can be helpful too.

Jan


--------------enig9273CD7C2D0FF35BDD5A4706
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZqfCniDOoMHTA+kRAiZXAJ9Ac54yPGwc82Ig6tnIglMVowOhsACff1EN
nQZzdr0V7L5vmP/ijlLUmOo=
=gQ3V
-----END PGP SIGNATURE-----

--------------enig9273CD7C2D0FF35BDD5A4706--

