Message-ID: <4738D9D1.5090802@domain.hid>
Date: Mon, 12 Nov 2007 23:55:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8CE08391DD0AFD77A3452BC7"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 0/5] Xenomai patch queue
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8CE08391DD0AFD77A3452BC7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

while the syscall tracing thing still puzzles me, I was now at least
able to check that my patches do what they are supposed to. So here
comes a flush of (most of) the stuff that piled up on my side, fixing or
enhancing the following aspects:

 - x86 hal refactoring (-v2) - I decided to base my work on this because
   it shakes the code anyway and also happens to touch hal stuff, thus
   benefits from the unified version.

 - get timer frequency from ipipe (thus Linux) instead of relying on
   home-brewed estimations (fixes inaccurate APIC frequency)

 - report configured timer and clock device via /proc/xenomai/timer

 - cleanup tickdev emulation (related to I-pipe refactorings)

 - provide for __must_check attribute for __xn_copy_*_user services
   (developer tool - not for merge yet!)

I-pipe changes for i386 and x86_64 will be sent separately.

Jan


--------------enig8CE08391DD0AFD77A3452BC7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHONnVniDOoMHTA+kRAjRIAJ9hUrHj6mRjdp535uxmD+Wm817QOQCeN8tx
ffkZZRiNfMrj23wg3gTvtEU=
=NQNF
-----END PGP SIGNATURE-----

--------------enig8CE08391DD0AFD77A3452BC7--

