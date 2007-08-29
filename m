Message-ID: <46D5A704.5010509@domain.hid>
Date: Wed, 29 Aug 2007 19:04:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46D5A071.7060905@domain.hid>
In-Reply-To: <46D5A071.7060905@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig621E320B75C7D1A38F15550C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] problem compiling for user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ravid Baruch Naali <ravidbn@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig621E320B75C7D1A38F15550C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ravid Baruch Naali wrote:
> hello Rodolfo,
>=20
>=20
> I've just encountered the same problem:
>=20
>=20
> collect2: ld terminated with signal 11 [Segmentation fault]
>=20
>=20
> I have the exact same configuration as I can understand you have=20
> (i386-linux-uclibc)
>=20
>=20
> So I was wondering if you ever found a way to overcome this problem

Update your toolchain. For the background of this bug (and a patch in
case you build the chain on your own):

http://cygwin.com/ml/binutils/2006-12/msg00309.html

Jan


--------------enig621E320B75C7D1A38F15550C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFG1acFniDOoMHTA+kRAnRPAJY9FT+facA9utNUm9EK4zfrblFmAJ4sRrJF
gOoeN4UNcPHsRj28bKw42g==
=Lr6k
-----END PGP SIGNATURE-----

--------------enig621E320B75C7D1A38F15550C--

