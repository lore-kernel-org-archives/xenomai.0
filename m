Message-ID: <466A9D60.3010304@domain.hid>
Date: Sat, 09 Jun 2007 14:30:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3E633957CBF5144D90F27E32"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH-STACK] LTTng update
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
--------------enig3E633957CBF5144D90F27E32
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Before I forget it: I uploaded a rebased version of my patch stack this
morning, see

	http://www.rts.uni-hannover.de/rtaddon/patches

This series also includes a new version of the LTTng patch for Xenomai.
The patch moves the probe arming into a separate module,
ltt-probe-xeno.ko, allowing the nucleus to be built into kernel again
when LTTng is enabled. For now it is only one module, i.e. facility, so
that it still matches with the lttv patch.

Jan


--------------enig3E633957CBF5144D90F27E32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGap1kniDOoMHTA+kRAmFrAJ0fGu5njIoo0lb3GbkXWNmS00S/1QCdE5pS
fn2OWz3gYRG4U2tWuGlzacs=
=nlIn
-----END PGP SIGNATURE-----

--------------enig3E633957CBF5144D90F27E32--

