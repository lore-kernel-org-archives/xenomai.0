Message-ID: <45D45AEA.50404@domain.hid>
Date: Thu, 15 Feb 2007 14:06:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig951E072AD68496810E68851D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] I-pipe 1.7 breaks mlockall safety check
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig951E072AD68496810E68851D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all,

I think I found another unwanted side-effect of the no-cow changes:

With the I-pipe 1.7 patch series the test for missing mlockall no longer
works. I just - once again - wrote a test program that was lacking this
call, but only with I-pipe 1.6-06 (same Xenomai version: latest trunk) I
get the usual error message on startup.

Jan


--------------enig951E072AD68496810E68851D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1FrqniDOoMHTA+kRAmT6AJ4/FXbLOzGFMnjVRBP5zyVCy4COwQCfcfxi
lEUiT3+ngIEXlRRBXJbxn/w=
=DPNX
-----END PGP SIGNATURE-----

--------------enig951E072AD68496810E68851D--

