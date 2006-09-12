Message-ID: <4506E7AC.5090508@domain.hid>
Date: Tue, 12 Sep 2006 19:00:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] fix xeno-test for busybox
References: <4506E6CD.5050302@domain.hid>
In-Reply-To: <4506E6CD.5050302@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1A5114443CEC7F92E66EBCCD"
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
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1A5114443CEC7F92E66EBCCD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> I just tried to fire up xeno-test on a busybox system - without success=
=2E
> Reason: missing getopts. But busybox initial test checks for something
> else, namely getopt. The attached patch should fix this it, also taking=

> into account that getopts in a shell built-in, not an applet.
>=20

Another quirk: switchtest runs with hard-wired -T 120...

Jan


--------------enig1A5114443CEC7F92E66EBCCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFBuesniDOoMHTA+kRAmuJAJ4nKpOYwUCNd3JocDlHbwxlVWhzhQCcCZl6
dLPetkF8i7zPcwTqXWVqUxo=
=uX1N
-----END PGP SIGNATURE-----

--------------enig1A5114443CEC7F92E66EBCCD--

