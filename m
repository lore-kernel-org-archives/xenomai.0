From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Tue, 3 May 2011 14:36:31 +0200
References: <4DBD4DA6.2070101@domain.hid>
In-Reply-To: <4DBD4DA6.2070101@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2038175.HSUBsEnhQ3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201105031436.37688.kisda@domain.hid>
Subject: Re: [Xenomai-help] Building Xenomai for Ubuntu 10.10 32 bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Uwe Fechner <u.fechner@domain.hid>
Cc: xenomai@xenomai.org

--nextPart2038175.HSUBsEnhQ3
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Am Sonntag 01 Mai 2011, 14.10:14 schrieb Uwe Fechner:
>  Hello,
>=20
> I am trying to compile Xenomai for Ubuntu 10.10 32 bit for
> a Dell Latitude E6400 Laptop.
>=20
> First I tried to follow the following explanations:
> http://www.xenomai.org/index.php/Building_Debian_packages

ok
=20
> I had the following problems:
> - the Xenomai version, that comes with Ubuntu 10.10 is
>   very old, so I tried to compile my own packages

ok

> - using git didn't work, because I needed a user name and
>   password, that I don't have (the following command failed:)
>   git clone git://xenomai.org/xenomai-2.5.git

There is no password to access the git repository. Are you behind a proxy?

> - then I tried to compile packages from a tar.bz2 archive
>   I was able to compile the packages, but they did not work

What did not work?

>  I suppose, that I have some wrong .config options.
>=20
> I then tried to compile a Linux kernel in the way, that is
> suggested for Ubuntu, using this tutorial:
> [...]
> Now my questions:
> I would like to use kernel 2.6.38 or 2.6.39-RC5 with
> xenomai 2.5.6.
>=20
> 1) Is this a good choice, or is an older kernel or an older
>    version of Xenomai more likely to work?

There is no adeos-ipipe-patch for 2.6.38 or .39-RC5.

> 2) Do I need to run scripts/prepare-kernel.sh, or not?
>    This is mentioned at:
>    http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL
>    but not mentioned at:
>    http://www.xenomai.org/index.php/Building_Debian_packages

If you follow "Building_Debian_packages" you dont need it.

If you are able to copy&paste the commands from "Building_Debian_packages"=
=20
into your local console, it should work. If not, please tell which step fai=
led=20
and why (exact error message).

Stefan

--nextPart2038175.HSUBsEnhQ3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk2/9s8ACgkQIPTw9rIdn6oUWACeJ9RfUuKbDRVAoxU+mNgtbq/w
yUQAnAlh2NakZlSYWKg0MpnC6fVJGQhz
=qDAq
-----END PGP SIGNATURE-----

--nextPart2038175.HSUBsEnhQ3--

