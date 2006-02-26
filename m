Message-ID: <44020379.1060906@domain.hid>
Date: Sun, 26 Feb 2006 20:37:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Problems
	accessing	svn://svn.gna.org/svn/xenomai/trunk
References: <200602252131.05088.niklaus.giger@domain.hid>
In-Reply-To: <200602252131.05088.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigABC4987AEF6A2039475B0CA5"
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
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigABC4987AEF6A2039475B0CA5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Hi
>=20
> Calling svn update complained always with "Malformed network data".
>=20
> After switching from using svn: to using http: to access the xenomai=20
> repository (called svn switch --relocate \=20
> svn://svn.gna.org/svn/xenomai/trunk \
> http://svn.gna.org/svn/xenomai/trunk) svn update worked fine.=20
>=20
> Can anybody confirm this? Or is the svn server down?=20
>=20

Seems to have been a temporary problem. Just tested "svn ls
svn://svn.gna.org/svn/xenomai/trunk", and it worked for me.

Still, we are lucky with gna.org. Hosting a project at sourceforge e.g.
is much more stressing (we once had several months downtime for the old
RTnet repos...).

Jan


--------------enigABC4987AEF6A2039475B0CA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEAgN5niDOoMHTA+kRAo3jAJwLMwY0Wg566zOknV16bEL3tugWpQCfWr3j
PZ7o89rVB4c65f6XjXsXtV4=
=vG0T
-----END PGP SIGNATURE-----

--------------enigABC4987AEF6A2039475B0CA5--

