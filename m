Message-ID: <45295098.8080201@domain.hid>
Date: Sun, 08 Oct 2006 21:25:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Native API manual in PDF format?
References: <F75B1CC921BD8E43B7D0484C9AB4C490450F83@domain.hid>	<4512E4A3.9050303@domain.hid>	<17705.13155.675021.10130@domain.hid>	<45293CC0.8040204@domain.hid>
	<17705.18863.212977.513626@domain.hid>
In-Reply-To: <17705.18863.212977.513626@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCB2E02023ADA553E2387556E"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB2E02023ADA553E2387556E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hmm, and I wonder why you were able to compress a PDF that much. I
>  > thought PDF can do this fairly well on its own.
>=20
> Only dvipdfm seems to support compression. Unfortunately, doxygen seem
> only to be able to allow using pdflatex or dvips and ps2pdf.
>=20

I just checked my own pdftex doc headers: \pdfcompresslevel=3D9 is set
there. \pdfcompresslevel=3D0 increases the output size, but a compressed
file can still be reduced further by bzip2. So, nothing to improve here.

Jan


--------------enigCB2E02023ADA553E2387556E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFKVCYniDOoMHTA+kRAlf8AJ45ceVKFkGm27aUzMlKIsll6kSd/gCZATlB
Y3kIP/GsGGqWAiu+B/I3Scw=
=teWP
-----END PGP SIGNATURE-----

--------------enigCB2E02023ADA553E2387556E--

