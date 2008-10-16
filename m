Message-ID: <48F7B85C.9050809@domain.hid>
Date: Thu, 16 Oct 2008 23:55:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154620.523981771@domain.hid>
	<48F7957A.3070506@domain.hid>
In-Reply-To: <48F7957A.3070506@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6CC54F60CD9D1A4978A61D20"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 01/12] Generic thread registration
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6CC54F60CD9D1A4978A61D20
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>=20
> Why the funky last parameter added to __rt_bind_helper ?

As __rt_bind_helper can now be called with an xnthread object address,
thus we take its offset inside RT_TASK into account. It is not a nice
interface, I know, but I didn't find a better one.

Jan


--------------enig6CC54F60CD9D1A4978A61D20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj3uFwACgkQniDOoMHTA+laZwCdGp3ZtLw18ZXAn3E+ZM/ECgkO
t5gAnRBXIu/6nxgu5tlb71UICC25zsBm
=hb9S
-----END PGP SIGNATURE-----

--------------enig6CC54F60CD9D1A4978A61D20--

