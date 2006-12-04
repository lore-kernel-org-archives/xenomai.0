Message-ID: <4574268C.7000705@domain.hid>
Date: Mon, 04 Dec 2006 14:45:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai install problems
References: <20061204133717.GA20186@domain.hid>
In-Reply-To: <20061204133717.GA20186@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig63144652F6A016C33E3B2630"
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
To: Anthony Sharobaiko <anthony@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig63144652F6A016C33E3B2630
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Anthony Sharobaiko wrote:
> Hi!
>=20
> I try to get Xenomai running on arm (PXA board). Currently everything c=
ompiles perfectly, but testsuite examples simply segfault:
> =3D=3D=3D cut here =3D=3D=3D
> root@domain.hid# ./run=20
> *
> *
> * Type ^C to stop this application.
> *
> *
> /usr/xenomai/bin/xeno-load: line 247:  1139 Segmentation fault
> $suflag $* $cmdargs
> =3D=3D=3D cut here =3D=3D=3D
>=20
> I use 2.6.16.29 kernel with ipipe-2.6.15-1.5-03. Some hunks were applie=
d by hand,=20
> but I'm sure that IPIPE works (I've used: http://www.mail-archive.com/a=
deos-main@domain.hid to check).
>=20
> Also, Xenomai (built into kernel) successfully registers domain:
> =3D=3D=3D cut here =3D=3D=3D
> root@domain.hid# cat Xenomai=20
> Invariant head, Id=3D0x58454e4f
> irq0-25: passed
> irq26: wired
> irq27-191: passed
> irq192-193: passed, virtual
> irq194: wired, virtual
> =3D=3D=3D cut here =3D=3D=3D
>=20
> Where should I dig to get a working testsuite? =3D)

Is it a pure user-space crash, or do you also see some oops in the
kernel logs? If it's user-space, place attach gdb to find out where it
crashes.

Jan


--------------enig63144652F6A016C33E3B2630
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdCaMniDOoMHTA+kRAswfAJ0frsN33HgPQ7KxsvfOuyOotvPeiwCfTisy
+QMzYjB0cxAI2UYG4mi+tT4=
=PKw8
-----END PGP SIGNATURE-----

--------------enig63144652F6A016C33E3B2630--

