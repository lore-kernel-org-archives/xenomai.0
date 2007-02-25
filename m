Message-ID: <45E19067.1@domain.hid>
Date: Sun, 25 Feb 2007 14:34:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_timer_start()
References: <bc4264770702250528u1f7a4736s919eb998d064289b@domain.hid>
In-Reply-To: <bc4264770702250528u1f7a4736s919eb998d064289b@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4CF9C32339085861C5CF0595"
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
--------------enig4CF9C32339085861C5CF0595
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi,
>=20
> The Native API tour dictates that rt_timer_start() MUST be called in
> all userspace applications that access the rt_timer.
>=20
> It displays and example very similar to the example trivial_periodic.c
>=20
> howeve trivial_periodic.c does not call the rt_timer_start() even
> though it does have calls such as rt_timer_read.
>=20
> and it seems to work.
>=20
> Why is that?

That tour was written before rt_timer_start() got deprecated.

Always check the latest API documentation when something appears
contradictory.

Jan


--------------enig4CF9C32339085861C5CF0595
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF4ZBnniDOoMHTA+kRApCwAJ4ky+ALypkxomFbCIUM6qzmINNlbACdFNyY
kgyncvU14SQvfRextARijfQ=
=1KLc
-----END PGP SIGNATURE-----

--------------enig4CF9C32339085861C5CF0595--

