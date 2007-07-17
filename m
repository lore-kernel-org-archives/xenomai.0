Message-ID: <469CDD4B.7080402@domain.hid>
Date: Tue, 17 Jul 2007 17:16:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200707171235.29106.karl-trampe@domain.hid>
In-Reply-To: <200707171235.29106.karl-trampe@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig54DA8AA30B268B2E01C3812B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] xeno-test: code -25
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <karl-trampe@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig54DA8AA30B268B2E01C3812B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Karl Reichert wrote:
> I tried an AMD Athlon XP, Single Core, Xenomai 2.3.1, adeos 1.8_05, lin=
ux=20
> 2.6.20.15 with a networking card RTL8139 and run into problems.
>=20
> I made a fresh installation of Xenomai and xeno-test runs a while, then=
 tells=20
> me the following:
> latency: failed to start in-kernel timer benchmark, code -25
>=20
> Any ideas?

Try to issue "rmmod xeno_irqbench" before starting the test.

That driver gets automatically loaded as it needlessly advertises PnP
support for UARTs. I think I fixed this somewhere, at least in upcoming
2.4. Another fix would be to make the latency tool cleverer in picking
the right testing device. Yet undone...

Jan


--------------enig54DA8AA30B268B2E01C3812B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGnN1LniDOoMHTA+kRAqA4AJ9FRzxmuboCfW2PzjLmQ93PolLD+ACghUQx
YuZirdSMkKG3H8ShPvII6DM=
=w4xs
-----END PGP SIGNATURE-----

--------------enig54DA8AA30B268B2E01C3812B--

