Message-ID: <4509057F.2060606@domain.hid>
Date: Thu, 14 Sep 2006 09:32:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Add --quiet option to cyclictest
References: <200609132224.30762.niklaus.giger@domain.hid>
In-Reply-To: <200609132224.30762.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig18449FB262D193DC8A894809"
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
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig18449FB262D193DC8A894809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Hi
>=20
> cyclictest emits far too much output. The attached patched makes it hon=
our=20
> the '-q/--quiet' option like all the other tests.
>=20
> Could somebody please review the patch and possibly apply it?

I wasn't able to find any problems, so I merged it. Thanks.

>=20
> Later I really would like to propose a common schema how to pass the mo=
st=20
> common options to the various tests called by xeno-test.=20

Maybe the common part of handling those switches could be moved to a
generic test-tool library (which could later also contain the data
processing and printing of those tests - my old vision...)?

Jan


--------------enig18449FB262D193DC8A894809
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFCQV/niDOoMHTA+kRAjSRAJ9rs+agZlOJclhNWmE2srp8otR2AwCfRVpk
2IGwatxCoTlV8Ls3u/pbIs8=
=gHxS
-----END PGP SIGNATURE-----

--------------enig18449FB262D193DC8A894809--

