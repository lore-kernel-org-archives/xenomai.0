Message-ID: <47014BED.1090005@domain.hid>
Date: Mon, 01 Oct 2007 21:35:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAA6D55E6373EEEDF33BC30BD"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] posix skin thread doesn't respect
	/proc/xenomai/affinity
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA6D55E6373EEEDF33BC30BD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

almost forgot to report this, didn't find time to dig into it. You can
easily check this with cyclictest: affinity mask set to 2, the test will
still schedule on CPU0.

Jan


--------------enigAA6D55E6373EEEDF33BC30BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHAUvtniDOoMHTA+kRAn/MAJ49R2oIr6W9G2SJdeCDBxpkvc5U/QCcDxDC
GqpRbvuLNyst4e4auclHwxg=
=PLbF
-----END PGP SIGNATURE-----

--------------enigAA6D55E6373EEEDF33BC30BD--

