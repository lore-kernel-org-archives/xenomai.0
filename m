Message-ID: <468132DC.6010705@domain.hid>
Date: Tue, 26 Jun 2007 17:38:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4680F263020000010018F152@domain.hid>
In-Reply-To: <4680F263020000010018F152@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEB9D83511435C89A322B32BC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] patch version
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hubert Talbot <Hubert.Talbot@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEB9D83511435C89A322B32BC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hubert Talbot wrote:
> Hi,
>=20
> Is it safe to apply patch like adeos-ipipe-2.6.20-i386-1.8-04.patch (27=
-May-2007 14:33)=20
> to a newer kernel like linux-2.6.20.14.tar.gz (11-Jun-2007 19:03) or li=
nux-2.6.21.5.tar.gz (11-Jun-2007 19:03)?

i386-1.8-04 is know to work fine over recent 2.6.20.x kernels.
Currently, we have no ipipe support for i386 2.6.21.x or 2.6.22-rcX
kernels, but that's work in progress. Alternatively, if you have an
x86_64 system, you could already try

http://www.rts.uni-hannover.de/rtaddon/patches/ipipe-kernel/x64-playgroun=
d/adeos-ipipe-2.6.22-rc5-x86_64-1.0-08.patch
(should fit on -rc6 as well, not yet tested though)

Jan


--------------enigEB9D83511435C89A322B32BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgTLcniDOoMHTA+kRAiq+AJwI0Dm/jIC3Pctk0mZlzTKma9dGFgCeL9Hq
qMAPjIzTxV2vB1jpBN6Jjso=
=7ri3
-----END PGP SIGNATURE-----

--------------enigEB9D83511435C89A322B32BC--

