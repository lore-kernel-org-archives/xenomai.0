Message-ID: <43E1D0D6.2020003@domain.hid>
Date: Thu, 02 Feb 2006 10:28:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Three questions about RTDM
References: <1138870064.8753.19.camel@domain.hid>
In-Reply-To: <1138870064.8753.19.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig62D9ECBBEB78A510AB31CDE0"
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
To: Alessio Igor Bogani <abogani@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig62D9ECBBEB78A510AB31CDE0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Alessio Igor Bogani wrote:
> Hi all, Hi Jan,
>=20
> I apologize for my (very) bad english.
>=20
> I have three simple questions about RTDM:
>=20
> 1) Where may I find a more detailed documentation about RTDM?=20

More detailed than what? Have you already discovered the online docs on
www.xenomai.org?

>=20
> 2) Now I'm attempting to write a simple device driver with RTDM: Can
> someone show me a standard GNUMakefile/Makefile to compile it?

Take a look at the heartbeat example on

www.rts.uni-hannover.de/mitarbeiter/kiszka/rtaddon

This works for 2.6 kernels and Xenomai 2.0.x. I still need to update it
for Xenomai 2.1, where compilation melts down to simple out-of-tree
kernel module generation. Does anyone else here have a generic Makefile
for all kernel and Xenomai versions at hand?

>=20
> 3) Device driver written with RTDM must be released under GPL?
> Or, as like Xenomai, the developer is free to choose the license that
> prefer for his/her sw based on it?
>=20

For me, an RTDM driver using the official RTDM API would be no derived
work, thus would not necessarily have to be GPL. But I cannot speak for
all other developers involved in the APIs you may have to use in your
driver (moreover, RTDM is also not only my own work). Actually, this
does not solely depend on RTDM, this is a linux kernel issue as you put
your module inside this GPL'ed system. As long as there are no urging
needs (non-extractable IP inside the driver core that must be kept
closed), I would recommend no one theses days to develop binary-only
kernel modules anymore (this is also one reason why you shouldn't write
closed-source RT kernel application modules, BTW).

If you just prefer another open source license, release your driver
under both GPL and that other license. But if you plan to keep it
closed, I can only recommend to ask a lawyer about legal pros and cons
of this approach.

Jan


--------------enig62D9ECBBEB78A510AB31CDE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4dDWniDOoMHTA+kRAlMdAKCAqfzzowz99lMxLJWtB3SacWlSEgCfYueJ
gFZtgoRbra8YeVCvug/dRug=
=F6UH
-----END PGP SIGNATURE-----

--------------enig62D9ECBBEB78A510AB31CDE0--

