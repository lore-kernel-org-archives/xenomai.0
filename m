Message-ID: <45293CC0.8040204@domain.hid>
Date: Sun, 08 Oct 2006 20:00:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Native API manual in PDF format?
References: <F75B1CC921BD8E43B7D0484C9AB4C490450F83@domain.hid>	<4512E4A3.9050303@domain.hid>
	<17705.13155.675021.10130@domain.hid>
In-Reply-To: <17705.13155.675021.10130@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1599DE0E358E444E5C9FC4FB"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, David Betz <david.betz@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1599DE0E358E444E5C9FC4FB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > David Betz wrote:
>  > > Is there a PDF version of the Native API manual available? I'd lik=
e to
>  > > be able to print a copy for reference.
>  >=20
>  > You can generate your own version: Set "GENERATE_LATEX =3D YES" in
>  > doc/doxygen/Doxygen.in, build the documentation (don't forget to ena=
ble
>  > it on configure), go to doc/doxygen/latex in your build directory an=
d
>  > run "make". The result is refman.pdf, a >500 pages monster (2.5M) th=
at
>  > looks rather unhandy to me. Maybe one can tune things and drop out
>  > parts, you may want to play a bit with doxygen.
>=20
> I split the 500 pages monster into four parts; nucleus, native skin,
> rtdm skin and posix skin. I temporarily put them at the address:
> http://download.gna.org/xenomai/doxygen/
>=20
> If nobody dislikes them, they could be commited in the repository.
>=20

That would also mean we are going to keep them in sync with new release,
i.e. you can generate them automatically? Then I'm all for it! I just
want to avoid the RTAI effect: documentation all over the place, but
mostly decades old, useless, and -even worse- confusing.

Hmm, and I wonder why you were able to compress a PDF that much. I
thought PDF can do this fairly well on its own.

Jan


--------------enig1599DE0E358E444E5C9FC4FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFKTzAniDOoMHTA+kRAuAyAJ9pmaDM+6Nl39jsBdHPY5wz0fcFTwCfXIvU
zeeZ3u6RGgul0ixGN10FebQ=
=Xl8O
-----END PGP SIGNATURE-----

--------------enig1599DE0E358E444E5C9FC4FB--

