Message-ID: <46BAF956.5090401@domain.hid>
Date: Thu, 09 Aug 2007 13:24:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
	<2ff1a98a0708090242k70178437y716b502ce338e0a6@domain.hid>
In-Reply-To: <2ff1a98a0708090242k70178437y716b502ce338e0a6@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig65EBCAC926730DAFA699EB65"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] hard lock-up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: andy motten <andy.motten@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig65EBCAC926730DAFA699EB65
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> On 8/9/07, andy motten <andy.motten@domain.hid> wrote:
>> There seems to be a difference between the 2 versions (Xenomai: POSIX:=

>> destroyed thread), Is this normal or part of the problem ?
>=20
> No, this is normal, this message is harmless, it only appears if you
> select posix skin debugging.
>=20
>> Is there a possibility that this is a bug in Xenomai or in the ipipe p=
atch?
>> Using the Xenomai 2.2.x branch is not an option since we need the RT c=
an
>> drivers provided in the Xenomai 2.3.x branch.
>=20
> There is certainly a bug somewhere. Could you enable Linux debugs, its
> NMI watchdog (by adding nmi_watchdog=3D1 on the kernel command line), a=
s
> well as Xenomai debugs ? In order to find where the lock-up occurs.
>=20

And have a look at linux/Documentation/serial-console.txt to capture the
"last words" (without having to take pictures of your monitor) in case
the lock-up remains hard even with debugging switches on.

Jan


--------------enig65EBCAC926730DAFA699EB65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuvlWniDOoMHTA+kRAiyFAJ9HYLk31Uov/QBSUmToc7HCVNgCNwCdHHKS
Fb5WYxvNSWazTRxXOaeLl0M=
=6FVC
-----END PGP SIGNATURE-----

--------------enig65EBCAC926730DAFA699EB65--

