Message-ID: <45D5F9CA.9060605@domain.hid>
Date: Fri, 16 Feb 2007 19:36:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] heap allocation in xenomai
References: <528bc2040702160148j5c63209fi40face4810613bfd@domain.hid>	
	<45D58770.6030201@domain.hid>
	<528bc2040702160328o5d35d085s3cbe0953ac29163e@domain.hid>
In-Reply-To: <528bc2040702160328o5d35d085s3cbe0953ac29163e@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6006F5F15221148DD8C0E165"
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
To: manoj kumar <manojkpanghal@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6006F5F15221148DD8C0E165
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[please keep the CC]

manoj kumar wrote:
> thanks jan
>=20
> What is the limitation of size for heap creation? Is it 2Gb as given by=

> XNHEAP_MAXEXTSZ (1 << 32)?b

Yes, given that you have enough (kernel) memory...

>=20
> What is the limitation of size of data that can be read or write on the=

> pipe?

Basically the same as above. Pipes are built on top of heaps.

Jan


--------------enig6006F5F15221148DD8C0E165
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1fnKniDOoMHTA+kRAlQtAJ9/OGE5SyoImreT+HAJtCSxY4f73QCePmlV
ovalhs3S/+Q0XE0pQtWNWxo=
=JH49
-----END PGP SIGNATURE-----

--------------enig6006F5F15221148DD8C0E165--

