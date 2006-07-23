Message-ID: <44C3AEB9.5070905@domain.hid>
Date: Sun, 23 Jul 2006 19:15:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai v2.2
References: <1153227929.5029.25.camel@domain.hid>	<44BE8ECF.2050608@domain.hid>	<44BE943E.80302@domain.hid>	<44BEA974.40708@domain.hid>
	<44BFC5FA.6080608@domain.hid> <44BFFC62.8030601@domain.hid>
	<44C21AF8.3000906@domain.hid> <44C25DA7.6020302@domain.hid>
	<44C287C4.30209@domain.hid>
In-Reply-To: <44C287C4.30209@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2871B6F264CF5BE4536189A7"
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2871B6F264CF5BE4536189A7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hannes Mayer wrote:
> Hi Jan!
>=20
> Jan Kiszka wrote:
>> What about addr2line -e vmlinux -f c01d68b2?
>=20
> # addr2line -e vmlinux -f c01d68b2
> xnshadow_ppd_insert
> shadow.c:0
>=20
>> Ok, will keep you posted!
>=20
> Tante grazie e buon fine settimana,
> Hannes.
>=20

Please try "make clean" before rebuilding your 2.4 kernel with a
different timer support. For me this fixed the issue (2.4 build system
seems to fail catching all dependencies, thus some struct sizes don't
get updated consistently).

The only thing that still puzzles me is that my crash happened at a
different code line. Anyway, might be due to other .config differences.

This digging in 2.4 over x86 was "worthwhile": Two further corner-case
bugs found, though not all fixed yet.

Jan


--------------enig2871B6F264CF5BE4536189A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEw665niDOoMHTA+kRAmqRAJ9MKTWWDIbTOrml6NlhNaHNwOFdRQCfS9HF
wfV5M3kIvBDG0Q2P1IN4P2g=
=6NIo
-----END PGP SIGNATURE-----

--------------enig2871B6F264CF5BE4536189A7--

