Message-ID: <45DEFF7D.6080507@domain.hid>
Date: Fri, 23 Feb 2007 15:51:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] error after timeout on serial port
References: <AD78122AD7C05B4B936EBAD7F49738C0AB2BA0@domain.hid>
In-Reply-To: <AD78122AD7C05B4B936EBAD7F49738C0AB2BA0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig972DB727E1064D44298DDE62"
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
To: Lauener Nathan <Nathan.Lauener@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig972DB727E1064D44298DDE62
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Lauener Nathan wrote:
> Hi,
>=20
> I am polling on a serial port during an init sequence of a positioning
> device. Every once in a while I get a return code indicating that a
> timeout occured, code -110 (ETIMEDOUT). After a timeout occured I can't=

> read the port anymore. Whenever I call rt_dev_read() again the function=

> returns the error code -14 (EFAULT). Is there a flag I must clear to ge=
t
> the port operatioanl again?

I /tend/ to say it's an application bug, because we are using the driver
heavily, and our sluggish devices often cause timeouts during setup.
Some colleague should have already slapped me otherwise. :)

Are you sure that a valid buffer and a valid size is passed to
rt_dev_read after the timeout (because those should be the reason for
EFAULT)? If yes, maybe you can post a simple demo for the effect.

Jan


--------------enig972DB727E1064D44298DDE62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3v99niDOoMHTA+kRAjAWAJ4l6KNw7IgqUigtYc1q0rZ0Cg8RmwCeIJeu
YAQxgsYFq1ALC8ZNT+DKd1M=
=6QmT
-----END PGP SIGNATURE-----

--------------enig972DB727E1064D44298DDE62--

