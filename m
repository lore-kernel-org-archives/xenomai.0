Message-ID: <48F3B4D7.7070109@domain.hid>
Date: Mon, 13 Oct 2008 22:51:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2060F3302209602DFAD7F532"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] xnpipe: what's up with xnpipe_setup?
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
--------------enig2060F3302209602DFAD7F532
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

xnpipe_setup and the callbacks it sets is dead code for in-tree Xenomai
users. Going back to, well, fusion-0.6.9 (the oldest version we have in
LXR), it used to be dead meat already at that time. Can we remove it?

Jan


--------------enig2060F3302209602DFAD7F532
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjztOEACgkQniDOoMHTA+ni2wCfZiG+mIchCwHA+d5yFydZZJic
TpkAn3t6PSZm7E0vExaZQS0LsRBso+Ow
=xp99
-----END PGP SIGNATURE-----

--------------enig2060F3302209602DFAD7F532--

