Message-ID: <452BD151.20200@domain.hid>
Date: Tue, 10 Oct 2006 18:58:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Status of device profiles
References: <452BCD77.9080909@domain.hid>
In-Reply-To: <452BCD77.9080909@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA8A07F40CFD9064D00839538"
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
To: Marcelo Coelho <mjcoelho@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8A07F40CFD9064D00839538
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marcelo Coelho wrote:
> Greetings!
>=20
>=20
> What is the status of the the serial device profiles?
>=20

Given that no one yet came up with complaints on the profile though it
is heavily used, given that we were in theory able to implement a
conforming USB-to-RS232 driver for it (practice is suffering from nasty
bugs), I would say its stable.

>=20
> Just to make sure if i have the right idea, this profile is meant for a=
n
> higher standardization of a serial device internal functioning, right? =
I
> just have to fill the functions body, compile and i get a wonderfull RT=

> driver, right?

That's the idea. And you will be able to reuse existing software for
RTDM serial ports over that new driver.

Jan


--------------enigA8A07F40CFD9064D00839538
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFK9FRniDOoMHTA+kRAkC/AJ9bJFkfdPTVyKNJn2FqhrbjHr9mSACcDbCF
yXBdnnTFnS21yft9CuzJLfQ=
=mHc4
-----END PGP SIGNATURE-----

--------------enigA8A07F40CFD9064D00839538--

