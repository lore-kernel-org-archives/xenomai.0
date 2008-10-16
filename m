Message-ID: <48F7C9F8.5080405@domain.hid>
Date: Fri, 17 Oct 2008 01:10:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154621.960994053@domain.hid>
	<48F7A2A8.6020807@domain.hid>
In-Reply-To: <48F7A2A8.6020807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig537D592650143402BE06E591"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 10/12] Report current shadow thread mode
 to	user space
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
--------------enig537D592650143402BE06E591
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>=20
> Ok. I still liked the solution of using a piece of shared heap. This wa=
s
> more general and would have allowed us to use this piece of shared heap=

> for future purposes.

Shared heaps do not allow for the __thread optimization.

Jan


--------------enig537D592650143402BE06E591
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj3yfgACgkQniDOoMHTA+ks4ACeLZXmUc/ppdZd6CVfpBo6aTRL
ntwAnirsOb84zbUl+kbH99Ht16NIKEsf
=Du0f
-----END PGP SIGNATURE-----

--------------enig537D592650143402BE06E591--

