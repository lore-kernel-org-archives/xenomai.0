Message-ID: <44453197.5070609@domain.hid>
Date: Tue, 18 Apr 2006 20:36:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <444530EA.4020005@domain.hid>
In-Reply-To: <444530EA.4020005@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA82531F4A596E9E9AD05461A"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] Re: ipipe-2.6.15-i386-1.2-04 is lacking notrace
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA82531F4A596E9E9AD05461A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi Philippe,
>=20
> your generation script for the 2.6.15 patch seems to lack the
> include/linux/compiler.h patch for notrace - doesn't build with the
> tracer switched on.

I meant include/linux/linkage.h

Jan


--------------enigA82531F4A596E9E9AD05461A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERTGXniDOoMHTA+kRAv2TAJ4lp0XPe6eytx80rZW90e/ZsTV+5QCfVFTQ
jEj+zkCMvnkZqpgwMOi45Ik=
=CJ4N
-----END PGP SIGNATURE-----

--------------enigA82531F4A596E9E9AD05461A--

