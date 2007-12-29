Message-ID: <4776D43F.5040406@domain.hid>
Date: Sun, 30 Dec 2007 00:11:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCEAA585027A41FADDA3D8838"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 0/5] x86 cleanups
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCEAA585027A41FADDA3D8838
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This series addresses the new unified x86 patch for 2.6.24. It includes
some of the minor polishings that got dropped while merging my last
series, kills some legacy stuff, and finally merges common 32/64 bit code=
=2E

Be warned! The series is so far only compile-tested, and this with a
limited set of .configs. The higher patches may contain nice regressions.=


Jan


--------------enigCEAA585027A41FADDA3D8838
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHdtRCniDOoMHTA+kRAsKKAJ0WeiZCi+SerpW1ixM3hHqikkH2fQCeIw04
VOSMOZoLtlDDcGpBIFoSNHw=
=1Dl1
-----END PGP SIGNATURE-----

--------------enigCEAA585027A41FADDA3D8838--

