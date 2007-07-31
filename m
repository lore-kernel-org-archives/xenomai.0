Message-ID: <46AF5F1E.7030009@domain.hid>
Date: Tue, 31 Jul 2007 18:11:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7AF356B43458B148CBE07621"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] 2.4-rc1: modular nucleus cannot be unloaded
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
--------------enig7AF356B43458B148CBE07621
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Already a plain command sequence causes this problem:

# modprobe xeno_nucleus
# rmmod xeno_nucleus
rmmod: xeno_nucleus: Resource temporarily unavailable

Can anyone confirm? This is unfortunately only a secondary issue that I
came across while hunting more severe problems of my colleagues, ie. I
don't have the time to look into detail ATM.

Jan


--------------enig7AF356B43458B148CBE07621
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGr18fniDOoMHTA+kRAjugAJ9vvacsKRNpE7G3OKfPPuY1xufWQACfaCvz
mOCcATGQMkz48lKPczzhNxE=
=1WUd
-----END PGP SIGNATURE-----

--------------enig7AF356B43458B148CBE07621--

