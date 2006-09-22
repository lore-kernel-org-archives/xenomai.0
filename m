Message-ID: <4513854D.5050500@domain.hid>
Date: Fri, 22 Sep 2006 08:40:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai port on CRIS architecture
References: <1158905195.24605.7.camel@domain.hid>
In-Reply-To: <1158905195.24605.7.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAD291EB480A21AC96D9C2FC4"
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
To: OB <obconseil@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAD291EB480A21AC96D9C2FC4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

OB wrote:
> Hello,=20
>=20
> I could not find any reference to a port of Xenomai (Adeos) on the
> Etrax/CRIS architecture.=20
> There are reference to an RTAI port, without any activity at the moment=
=2E

Supporting an architecture is not "just" about writing a patch once, it
is also takes someone to keep an eye on it so that it evolves with the
projects, Linux kernel and RT-extension. The absolute minimum
requirement are active users/testers reporting any brokenness, even
better a maintainer providing fixes/updates. Obviously, this didn't work
for the RTAI port.

>=20
> If nobody is working on it, I'm ok to try !

You are welcome!

>=20
> My reference plateform is a FOX board, which include several GPIO and
> even a parallel port-like interface.
> http://www.acmesystems.it/?id=3D4
>=20
> Also, please let me know if anybody has any interest in this projet
> (beside me!)=20
>=20

Maybe there are not already dozens of people waiting for CRIS support,
but once we have a clean and working port, I guess there will be people
showing up. Doing a bit advertising later in CRIS-related forums or to
board vendors can accelerate this even further.

Jan


--------------enigAD291EB480A21AC96D9C2FC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFE4VNniDOoMHTA+kRAjwAAJ9cd0ATFf4te4YyZxfB7Dk5722ZcgCcDqZe
CNQ5ICFpSH+ijwygvyCQ2Cg=
=dvgN
-----END PGP SIGNATURE-----

--------------enigAD291EB480A21AC96D9C2FC4--

