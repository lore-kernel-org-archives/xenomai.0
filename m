Message-ID: <48FCE40C.1080100@domain.hid>
Date: Mon, 20 Oct 2008 22:03:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48FCDC52.1070507@domain.hid>
In-Reply-To: <48FCDC52.1070507@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC644689300E2EF2032F7EDB0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Warning when compiling trunk.
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
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC644689300E2EF2032F7EDB0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> I get this warning when compiling trunk:
>=20
> checking for __thread... rm: cannot remove `conftest1.dir': Is a direct=
ory
> yes
>=20

That simple, it's a typo in this line:

http://www.rts.uni-hannover.de/xenomai/lxr/source/configure.in?v=3DSVN-tr=
unk#394

Also, that rm should be done outside the if block to play safe.

Jan


--------------enigC644689300E2EF2032F7EDB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj85A0ACgkQniDOoMHTA+mNEQCfUhgNedwzWBZ+vFPRK/WNP/T/
U84An0MOL7e7A4JhifPnpqxRnrkwPKyo
=Xf8D
-----END PGP SIGNATURE-----

--------------enigC644689300E2EF2032F7EDB0--

