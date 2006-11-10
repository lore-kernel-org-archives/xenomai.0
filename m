Message-ID: <4554A4A7.2050203@domain.hid>
Date: Fri, 10 Nov 2006 17:11:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem with multiport serial board
References: <BAY101-F3323C9AB4F084CE48E3BCEE2F70@domain.hid>
In-Reply-To: <BAY101-F3323C9AB4F084CE48E3BCEE2F70@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8FBD05229BB4099AE8EB4C5F"
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
To: Marco Rossi <cicciobombo123@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8FBD05229BB4099AE8EB4C5F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Marco Rossi wrote:
>=20
>=20
>=20
> Hi every body. I'm testing my multiport serial board (2 extra serial
> port) with shared interrupt using the program found at
> http://www.rts.uni-hannover.de/rtaddon/rt_serial_uprog.tar.bz2 .
>=20
> I insert the module xeno_16550A.ko in the follow way:
> insmod /.../xeno_16550A.ko ioaddr=3D0x3f8, 0x2f8, 0xd800, 0xdc00
> irq=3D4,3,5,5 start_index=3D0
>=20
> When I use only a extra port the program works, but when I try to write=

> in the first extra port and to read in the second extraport I got an
> error opening the second extraport.
>=20
> For example if I write in ttS0 and I read from ttyS2 all work; if   I
> write in ttS2 and I read from ttyS3 i get :
> can't open rtser3 (the rt_dev_open return a negative file descriptor).

The negative number is the error code (see documentation). It likely
says -EBUSY, meaning here that the IRQ line is already in use. Check
your Xenomai kernel configuration, I guess you haven't switched on
shared edge-triggered IRQ support yet, have you?

Jan


--------------enig8FBD05229BB4099AE8EB4C5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFVKSoniDOoMHTA+kRAoOJAJ4oZ0B2CGQre8joqRoHwJNVj729mACffQ8p
aywgquPQXmTslZq0kVsb6T4=
=2pFO
-----END PGP SIGNATURE-----

--------------enig8FBD05229BB4099AE8EB4C5F--

