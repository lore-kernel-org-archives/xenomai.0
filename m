Message-ID: <4943A2AF.1050007@domain.hid>
Date: Sat, 13 Dec 2008 12:55:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200812090832.43063.roberto.bucher@domain.hid>
	<200812091044.41645.roberto.bucher@domain.hid>
	<4940CF82.2070709@domain.hid>
	<200812111119.40464.roberto.bucher@domain.hid>
In-Reply-To: <200812111119.40464.roberto.bucher@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA178323FCAA175D6C747A2F8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] Problems with last adeos patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Roberto Bucher <roberto.bucher@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA178323FCAA175D6C747A2F8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roberto Bucher wrote:
> Some results:
>=20
> 1) I changed the nvidia driver from 177.80 to 177.82: problem still rem=
ains
> 2) I changed the driver to "vesa" in the xorg.conf file: X starts but t=
he=20
> problem remains!
> 3) I connect using ssh -X from another terminal to the RT linux machine=
=2E I=20
> can't reproduce the problem. When I start scilab on the RT machine the =
RT=20
> system freezes and the connection fails.
>=20
> I installed the kernel 2.6.25.20 with patch  derived from adeos-ipipe-2=
=2E6.25-
> x86-2.0-09.patch and the system seems to work fine.

Another question (before I actually start looking at code): Are all test
boxes using > 1 CPUs? Or is the issue also present when there is only a
single CPU?.

Jan


--------------enigA178323FCAA175D6C747A2F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklDorMACgkQniDOoMHTA+nubgCfcZWgTPJ/fGsLqUfgoLt8iKUb
qkUAnRNvMewmDUM53eouuYMFDsYbVrtE
=jUre
-----END PGP SIGNATURE-----

--------------enigA178323FCAA175D6C747A2F8--

