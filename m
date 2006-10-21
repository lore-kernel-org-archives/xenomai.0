Message-ID: <453A4C42.9080103@domain.hid>
Date: Sat, 21 Oct 2006 18:35:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Suggestions for the vxWorks skins
References: <200610202221.49664.niklaus.giger@domain.hid>
	<1161381649.4988.141.camel@domain.hid>
In-Reply-To: <1161381649.4988.141.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5D279D1A316C74D824F8B2F8"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5D279D1A316C74D824F8B2F8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2006-10-20 at 22:21 +0200, Niklaus Giger wrote:
>> Would it be difficult/desirable to include the name of the vxworks sem=
aphores=20
>> a vx task is holding? Together with point a) one could easyly detect l=
ock=20
>> ups.
>=20
> Mm, depends on the overhead tracking them safely.

This sounds like robust locks, rather a generic feature interesting for
all skins. As an optional feature of the nucleus, I would say this is
quite desirable.

I pushed it to our new to-do list [1] to save it for now. If anyone has
ideas about how to design this, he could create a new wiki page and
write the concept down - our write the patch directly...

Jan

[1] http://www.xenomai.org/wiki/index.php/TaskMarket


--------------enig5D279D1A316C74D824F8B2F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFOkxCniDOoMHTA+kRAh/8AKCBpoAU56f1z6URdsAA+FUxi3xF3gCfbD2k
ozKLpnhW4b4hkCQSXlkIF20=
=OMwN
-----END PGP SIGNATURE-----

--------------enig5D279D1A316C74D824F8B2F8--

