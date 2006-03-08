Message-ID: <440F340A.9040109@domain.hid>
Date: Wed, 08 Mar 2006 20:44:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai as module changing bzImage
References: <200603081433.02339.lbocseg@domain.hid>
In-Reply-To: <200603081433.02339.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig88759E022DD9BA15FF83A0FF"
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
--------------enig88759E022DD9BA15FF83A0FF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi Philippe,
>=20
> I disabled the kernel .config support, recompiled the kernel with lates=
t ipipe=20
> patch and rebooted my system (Xenomai configured as a module).
>=20
> Then I downloaded last svn Xenomai. Compiled it (after correcting drvli=
b.c of=20
> rtdm skin) and noted that it has changed the kernel bzImage too, beside=
s=20
> building the modules. Although I can use the new Xenomai modules withou=
t=20
> rebooting my system, I can not understand why should bzImage change. Ha=
ve you=20
> any idea?

Even if you turn on module support for all Xenomai components in the 2.1
series, there are still some bits (the HAL) being compiled directly into
kernel. So, any modification of headers etc. may trigger a recompilation
although the binary output will be the same.

Jan


--------------enig88759E022DD9BA15FF83A0FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEDzQKniDOoMHTA+kRAvPrAJ4lD2RIqGv6a+qQ2qlg5vcusG+9xgCfQoEj
6ObeG0S/gyojtnSeYTj7Hu4=
=3bSS
-----END PGP SIGNATURE-----

--------------enig88759E022DD9BA15FF83A0FF--

