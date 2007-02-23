Message-ID: <45DEEF73.6080608@domain.hid>
Date: Fri, 23 Feb 2007 14:43:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN driver
References: <45DC1D05.1000206@domain.hid>
	<45DEC91C.7040702@domain.hid>	<bc4264770702230404w42cc72c2ke9d6f3affe2e7244@domain.hid>	<200702231231.08664.paul_c@domain.hid>
	<bc4264770702230525j202f68a7r4b8d143790a9b398@domain.hid>
In-Reply-To: <bc4264770702230525j202f68a7r4b8d143790a9b398@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig78998E9401B4581FE4BB776B"
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig78998E9401B4581FE4BB776B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> hi Paul,
>=20
> Thanks for the urls. They are very helpful.
>=20
> Does anyone know what the future of the parallel port is going to be?
> Will it be disappearing from the PC,s in the near future or will it
> still be around on new machines for a while?

Already vanished from laptops, will probably disappear from commodity
desktop hardware in the next years as well. But I guess industrial
boards will stick to it a bit longer.

USB has reached up, at least for lab scenarios (and your CAN dongle it
surely intended for such a use case). RT and USB is still an engineering
task to be finished. First approaches are there for Xenomai, but they
need stabilisation and interface standardisation.

Jan


--------------enig78998E9401B4581FE4BB776B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3u9zniDOoMHTA+kRAqR0AJ9BZ6H+QNiR0YhM+PFFKHg8Ue9YIwCfawpu
Zek9LEcqbsJ27EZAL1KZ/lI=
=bvI3
-----END PGP SIGNATURE-----

--------------enig78998E9401B4581FE4BB776B--

