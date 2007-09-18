Message-ID: <46F04DF0.60500@domain.hid>
Date: Wed, 19 Sep 2007 00:15:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <fcjrji$dk1$1@domain.hid>
In-Reply-To: <fcjrji$dk1$1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9724CCEFB3CFDD169C53E199"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] simple example for rtdm
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: trem <tremyfr@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9724CCEFB3CFDD169C53E199
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

trem wrote:
> Hi
>=20
> I've written a little exemple for rtdm. It uses open, close, read, writ=
e
> ioctl and 3 kind of buffer (local, device, global). This is an alpha
> release, so I'll be pleased to get some feedback.
>=20
> you can find it here :
> http://zarb.org/~trem/tut03-skeleton-drv.c
> http://zarb.org/~trem/tut03-skeleton-app.c
> http://zarb.org/~trem/Makefile

Thanks once again for your effort. I'm sorry that I cannot go into
details soon, so just a minor comment from the first glance: please fix
the coding style to kernel style.

Jan

PS: Didn't you also once post a patch for the existing tut02? That's
probably still hanging around in no-man's land, right?


--------------enig9724CCEFB3CFDD169C53E199
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG8E3wniDOoMHTA+kRAsTQAJ9wvLETFd6sd7C3DoFsnawIpRIm/ACeJmu8
tiFAOc0kWDjFn1uaTW8F3b4=
=+l4p
-----END PGP SIGNATURE-----

--------------enig9724CCEFB3CFDD169C53E199--

