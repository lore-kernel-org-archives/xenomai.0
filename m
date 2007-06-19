Message-ID: <4677B151.1050401@domain.hid>
Date: Tue, 19 Jun 2007 12:34:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F5F9458924636AE1C459C93"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PREVIEW] adeos-ipipe-2.6.22-rc5-x86_64-1.0-08.patch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F5F9458924636AE1C459C93
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

For those who can't wait to update:

http://www.rts.uni-hannover.de/rtaddon/patches/ipipe-kernel/x64-playgroun=
d/adeos-ipipe-2.6.22-rc5-x86_64-1.0-08.patch

Boots and runs fine here under qemu (after applying those two recently
posted Xenomai fixes).

Steven Rostedt actually saved me quite some debugging time because he
happened to run on the same issue over -rt like I did yesterday evening
after porting ipipe, and he provided the fitting patch:
http://lkml.org/lkml/2007/6/18/528 8)

Jan


--------------enig6F5F9458924636AE1C459C93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGd7FRniDOoMHTA+kRAkciAJ0RXqVnDAwLk8c9qAxGFPt2+NREZQCfWAtg
nm49F4d5ooMUL8ULA3iGOSA=
=FPAB
-----END PGP SIGNATURE-----

--------------enig6F5F9458924636AE1C459C93--

