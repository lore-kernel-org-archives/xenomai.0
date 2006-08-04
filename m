Message-ID: <44D35885.2000706@domain.hid>
Date: Fri, 04 Aug 2006 16:24:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] building xenomai integrated drivers
References: <e325d110608040715v5c200f04l4632837bca7a15a4@domain.hid>
In-Reply-To: <e325d110608040715v5c200f04l4632837bca7a15a4@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6D2AC95B84DC0CC5F2D2A7B4"
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
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D2AC95B84DC0CC5F2D2A7B4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kim Chuan Lim wrote:
> Hi ya,
>=20
> The following is my .config..
>=20
> #
> # Drivers
> #
> CONFIG_XENO_DRIVERS_16550A=3Dy
> CONFIG_XENO_DRIVERS_TIMERBENCH=3Dy
> CONFIG_XENO_DRIVERS_IRQBENCH=3Dy
> CONFIG_XENO_DRIVERS_SWITCHTEST=3Dy
>=20
>=20
> I try to look for xeno_16550A.ko in my computer but i cannot get it.
> There is nothing such folder namely "xenomai "in my
> /lib/modules/2.6.17-default/kernel/drivers/
>=20
> May i know how could i build it manually?

You compiled them into the kernel ("=3Dy" instead of "=3Dm" for modular
build). Nothing special here.

>=20
> Regards,
> Kim Chuan.

Jan


--------------enig6D2AC95B84DC0CC5F2D2A7B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE01iFniDOoMHTA+kRAmcEAJ9UtpJJGr2ido8eFh1bCeYtsZDHiQCfbUKV
ta7Z6+T5PeRcBqOecBlzmpo=
=jk7p
-----END PGP SIGNATURE-----

--------------enig6D2AC95B84DC0CC5F2D2A7B4--

