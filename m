Message-ID: <4630D596.4090704@domain.hid>
Date: Thu, 26 Apr 2007 18:38:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20070426162941.103500@domain.hid>
In-Reply-To: <20070426162941.103500@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5A0D76601DA833BC94E4D609"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Errors compiling kernel 2.6.20 with xenomai 2.3.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A0D76601DA833BC94E4D609
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Karl Reichert wrote:
> Hello,
>=20
> I'm trying to compile my kernel with xenomai 2.3.1 and I get lots of er=
rors.
> I'm using standard kernel (from kernel.org), version 2.6.20 and ubuntu =
7.04 and gcc 5.97

gcc-what? Please try "gcc --version". Should be something with 3.x or
4.x (+some Ubuntu/Debian sub-revision).

> I used the guide from http://www.captain.at/xenomai-2.1-installation.ph=
p and patching kernel sources works fine, but when I do a "make menuconfi=
g", I get a lot of errors (see below).

[looking...] Where? Please try again. :)

>=20
> Does anybody has an idea what's the problem here?
> Maybe I'm using wrong kernel or gcc version? I saw that xenomai 2.3.1 s=
upports kernel 2.6.20 so maybe gcc is in wrong version? Which one do I ha=
ve to use?

Any gcc that is fine with the kernel (4.1 is said to make troubles,
sometimes) should also work with Xenomai.

> Which system do you use out there running xenomai 2.3.1?

OpenSUSE and home-brewed, but Ubuntu must work as well.

Jan


--------------enig5A0D76601DA833BC94E4D609
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMNWWniDOoMHTA+kRArZkAJ9Jpo14fJFsgb3gcQIOQXU4lapCGwCfVWyf
cpIykCUI86EP6GkCpoLPD0s=
=ft5C
-----END PGP SIGNATURE-----

--------------enig5A0D76601DA833BC94E4D609--

