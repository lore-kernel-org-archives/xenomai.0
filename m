Message-ID: <46E59235.2060506@domain.hid>
Date: Mon, 10 Sep 2007 20:51:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>	
	<46E58BE4.9090109@domain.hid>
	<1ce16a2c0709101142r6cf2d624oe443807575eadcfa@domain.hid>
In-Reply-To: <1ce16a2c0709101142r6cf2d624oe443807575eadcfa@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9C53AA2371CBA356B991B531"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] adding PCI support to 16550A.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bachman Kharazmi <bahkha@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C53AA2371CBA356B991B531
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Bachman Kharazmi wrote:
> A guy recommended me to try to get things going with the working
> mobo-serialport first before playing with linux drivers and serial
> controllers.. probabily a good point to start at.

For sure. You may also test against a different PC running Linux or a
Windoz box with terminal programs installed, BTW.

>=20
> Anyhow I tried to used your cross-link.c to write ASCII to serialport
> rtser0. I connected the cable to the dc motor drive which accepts
> ASCII commands with CR(\r\n) at the end of every command line.
> The light version of your code that I was testing with looks like:
> http://pastebin.ca/690561

<Quick glance mode> You write strings of different length in lines 152
and 153, but you pass the same size (sz =3D sizeof(RTIME), ie. 8).

>=20
> I'm trying to write two simple commands in the example, but I couldn't
> get it working. Don't know why :/
>=20
> First when I got that working it would be even nicer to be able to
> give a argument to the binary which is a ASCII command(string) written
> to rtser0.

Go wild and write such a trivial, command line driver tool to test
serial ports! Would be highly appreciated, and quickly accepted into the
tree (if it's clean).

Jan


--------------enig9C53AA2371CBA356B991B531
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFG5ZI1niDOoMHTA+kRAtr4AJdIDZGcYvYUjMELfw2UJ1GkqX/7AJ9cKENn
4+PojHe5U/SvMABP6vfkpA==
=Fb6O
-----END PGP SIGNATURE-----

--------------enig9C53AA2371CBA356B991B531--

