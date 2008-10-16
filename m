Message-ID: <48F7B88C.10104@domain.hid>
Date: Thu, 16 Oct 2008 23:56:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154621.488387180@domain.hid>
	<48F79E94.7070404@domain.hid>
In-Reply-To: <48F79E94.7070404@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4A54216A33DA0A80BF0B40C7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 07/12] Convert POSIX skin to fast xnsynch
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
--------------enig4A54216A33DA0A80BF0B40C7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>=20
> This patch contains too many #ifdefs.
>=20
> Things like
>=20
> #ifdef CONFIG_XENO_FASTSYNCH
> if (xnsynch_fast_owner_check(...))
> #else
> if (xnsynch_owner(...) =3D=3D ...)
> #endif
>=20
> could be replaced with only one macro xnsynch_check_owner in synch.h
> that would be defined with some #ifdefs, and used everywhere without
> #ifdefs.

Yes, that looks like a good idea. Will go through the patch again,
checking for more cleanup possibilities like that.

Jan


--------------enig4A54216A33DA0A80BF0B40C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj3uIwACgkQniDOoMHTA+mSkQCeLNK5t71fZ6rGhrmmv1avIkoL
wC8An3AnA1iu3wkTo6heaJyFCXwlzCii
=2Lxo
-----END PGP SIGNATURE-----

--------------enig4A54216A33DA0A80BF0B40C7--

