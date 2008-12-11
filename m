Message-ID: <4940CFB7.5060701@domain.hid>
Date: Thu, 11 Dec 2008 09:30:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200812090832.43063.roberto.bucher@domain.hid>
	<493E20BE.4070600@domain.hid>
	<842971F5-4763-4765-835F-2E72AF407455@domain.hid>
In-Reply-To: <842971F5-4763-4765-835F-2E72AF407455@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig24FEBD074525E8E9BCACCFFD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] Problems with last adeos patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Parashkev Penev <parashkev.penev@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig24FEBD074525E8E9BCACCFFD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Parashkev Penev wrote:
> Hi,
>=20
> I also have this issue. I am using the 2.6.26 kernel + adeos. The
> .config file is the default from the CentOS 5.2/Redhat 5.2 with ACPI,
> CPU frequency scaling, and APM turned off. The video card is an Nvidia,=

> using the nv module on one of the machines. the other one has an ATI
> using the ati-glfrx. I haven't tried with vesa yet.

Cross-checking with an open source driver would be good, though seeing
the issue with two likely quite different binary blobs suggest that they
are likely not to blame here.

>=20
> Let me know if you ned something else. (Those are laptops, thus no
> serial console).

netconsole? Also here: Getting hold of an oops is very important,
specifically if the problem turns out to be not easily reproducible for u=
s.

Jan

PS: Please keep the list in CC.


--------------enig24FEBD074525E8E9BCACCFFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklAz7cACgkQniDOoMHTA+ka6QCeL0cqRZBjtiBUzUJq0subE+jj
+yYAn27lee1YKZmG1B1f3UC+WXZNw/Kz
=bQFg
-----END PGP SIGNATURE-----

--------------enig24FEBD074525E8E9BCACCFFD--

