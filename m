Message-ID: <45E5A725.7060408@domain.hid>
Date: Wed, 28 Feb 2007 17:00:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [BUG] trunk: oops with Stephan's stress test
References: <45DEDED6.4070202@domain.hid>	<1172237401.26738.13.camel@domain.hid>		<45DEED50.4070007@domain.hid>	<1172238537.26738.15.camel@domain.hid>	<45DEF482.9030903@domain.hid>	<45E58CE3.20807@domain.hid>	<45E58FB4.6070603@domain.hid>	<45E59574.50808@domain.hid>
	<45E599F1.5020205@domain.hid>
	<45E5A5DF.2060609@domain.hid>
In-Reply-To: <45E5A5DF.2060609@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig52DDD5D8FE31188F92871DA8"
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig52DDD5D8FE31188F92871DA8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Maybe you find the attached .config + screenshot interesting, that
> happend on the Celeron M while running the app in a loop with reloading=

> xenomai modules. More information to come tomorrow.
>=20

That happens when you overload your box with the test so that Linux does
not totally starve, just a bit too much so that it thinks it ran into a
soft-lockup. I've seen this here as well.

Jan


--------------enig52DDD5D8FE31188F92871DA8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5aclniDOoMHTA+kRAoDGAJwJT/m+Jw1FtgDC3YOfqRwYzP5znACeOcPA
HbRFeMy94ULu0FUhxZOo/cc=
=bLWk
-----END PGP SIGNATURE-----

--------------enig52DDD5D8FE31188F92871DA8--

