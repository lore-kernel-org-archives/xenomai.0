Message-ID: <4666D8D3.9090901@domain.hid>
Date: Wed, 06 Jun 2007 17:54:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4666D538.8050004@domain.hid>
In-Reply-To: <4666D538.8050004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4A10AFAA259FE2B556580D6F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Bug when closing a busy file descriptor.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A10AFAA259FE2B556580D6F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> there is a bug when closing a busy file descriptor: the close function
> keeps incrementing the file descriptor reference count making it
> impossible to really close the file descriptor.=09
>=20
> The attached patch fixes this.
>=20

Yep. Applied, thanks.

Jan


--------------enig4A10AFAA259FE2B556580D6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZtjTniDOoMHTA+kRAiO5AJ91a4+z/D8OUTBeaoNvKPbktLMftQCdE4ic
Qyo44sJ9wC366hicuV6ONAE=
=tp7b
-----END PGP SIGNATURE-----

--------------enig4A10AFAA259FE2B556580D6F--

