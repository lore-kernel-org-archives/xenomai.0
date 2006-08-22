Message-ID: <44EADC8B.4050604@domain.hid>
Date: Tue, 22 Aug 2006 12:29:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Socketcan-users] [Xenomai-help] Re: send	error:permission	denied
References: <DD39B5C3F4963040ADC9768BE7E430CBFFAEED@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CBFFAEED@is-hdq-exchange.marel.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig322737ED0732BABAE02E72CD"
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
To: Daniel Schnell <danielsch@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, socketcan-users@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig322737ED0732BABAE02E72CD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Schnell wrote:
> Hi,
>=20
> Thanks, this looks much better. Also thanks for pointing out the POSIX =
only solution. Althoug the final linkstage printout now has become _reall=
y_ longish.

That has been shortened recently in Xenomai's SVN, will come with 2.3.

>=20
> I have made the call to rt_timer_read() because strangely the gettimeof=
day() call gave me more jitter than the xenomai native call.
> Can this be confirmed by anybody ? So if I could replace this native ca=
ll with a POSIX conforming call that works as good then I could get rid o=
f -lnative from my makefile.
> I could of course add a inline assembler readtsc call and calculate it =
myself with consideration of the actual cpu clock. But I thought that the=
re is already something available.
> Does anybody have any opinion about that ?
>=20

gettimeofday is not provided as real-time service, use clock_gettime
instead.

Jan


--------------enig322737ED0732BABAE02E72CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE6tyLniDOoMHTA+kRAmp2AJ0Q4kBDfKk5mJePmk/Nhrhha0W02ACdFd+V
No2Rl0zX3KJYd8ETeCBOiDI=
=C+D/
-----END PGP SIGNATURE-----

--------------enig322737ED0732BABAE02E72CD--

