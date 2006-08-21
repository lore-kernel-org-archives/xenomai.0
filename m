Message-ID: <44EA106C.6050302@domain.hid>
Date: Mon, 21 Aug 2006 21:58:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problem with testsuite/latency
References: <200608212144.51485.nicola17@domain.hid>
In-Reply-To: <200608212144.51485.nicola17@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF6EAD81FC25F295FAFD5527D"
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
To: Nicola Pezzotti <nicola17@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6EAD81FC25F295FAFD5527D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nicola Pezzotti wrote:
> Hi.
>=20
> 	I also have some problem with Xenomai.
>=20
> I solve the kernel's compilation problem and I compile Xenomai
>=20
> (Kernel 2.6.16 Xenomai 2.2.0)
>=20
> Now I trying to launch the testsuite's latency program but I have this =

> problem:
>=20
>=20
> Xenomai: incompatible feature set
> (required=3D"sep tsc", present=3D"sep", missing=3D"tsc").
>=20
>=20
> Someone can give my an hint?

Your kernel is lacking TSC support. Either enable it there (check if you
picked the right CPU type) or switch it off for user-space (configure
--disable-x86-tsc).

[We should make that message above a bit more expressive: Missing...
where? Also, could someone write an entry for TROUBLESHOOTING?]

Jan


--------------enigF6EAD81FC25F295FAFD5527D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE6hBsniDOoMHTA+kRAt55AJ98wfgPkqYFKNLS84KN8mlXmb/GLgCeL9eC
TxF+5CAEao1jd4bduhUAgU0=
=7Cf3
-----END PGP SIGNATURE-----

--------------enigF6EAD81FC25F295FAFD5527D--

