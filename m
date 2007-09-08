Message-ID: <46E30DE4.2060901@domain.hid>
Date: Sat, 08 Sep 2007 23:02:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709081159y62fbb73bwb16d2cae7a931774@domain.hid>
In-Reply-To: <1ce16a2c0709081159y62fbb73bwb16d2cae7a931774@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig193186DF3C9D00779E31509A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] serial module problems
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
--------------enig193186DF3C9D00779E31509A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Bachman Kharazmi wrote:
> Hi
> I'm a new xenomai user and would like to get the serial module working.=

>=20
> I've 'builtin' serial support in my kernel, and tried to add a new
> modified kernel line according to the docs which looks like:
>=20
> kernel          /boot/maikern2 8250.nr_uarts=3D0
> xeno_16550A.ioaddr=3D0x03f8,0xbc00,0xbc08,0xb800 xeno_16550A.irq=3D4,3,=
3,3
> xeno_16550A.baud_base=3D115200,115200,115200,115200 root=3D/dev/hda3 ro=

>=20
> But when I boot my dmesg sais:
> Kernel command line: 8250.nr_uarts=3D0
> xeno_16550A.ioaddr=3D0x03f8,0xbc00,0xbc08,0xb800 xeno_16550A.irq=3D4,3,=
3,3
> xeno_16550A.baud_base=3D115200,115200,115200,115200 root=3D/dev/hda3 ro=

> Unknown boot option `xeno_16550A.ioaddr=3D0x03f8,0xbc00,0xbc08,0xb800':=
 ignoring
>=20

The Wiki didn't reflect the upcoming version in Xenomai 2.4 yet. I
updated it, please see http://www.xenomai.org/index.php/16550A (the
essence: "ioaddr" is now called "io" for consistency reasons).

>=20
> the serial example gives:
> sandbox:/usr/src/xenomai/examples/rtdm/profiles/serial# ./cross-link
> main : can't open rtser0 (write), No such device
>=20
>=20
> I've tried to build the Serial support as a module instead, but it ends=
 up in:
> ERROR: "per_cpu__ipipe_percpu_daddr"
> [drivers/xenomai/serial/xeno_16550A.ko] undefined!
> when doing make bzImage modules.

What I-pipe patch are you using? I saw that Philippe uploaded new
revisions (see SVN) that may fix this issue. Please check independently
of the other issue so that we know if that problem was fixed.

Jan


--------------enig193186DF3C9D00779E31509A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG4w3pniDOoMHTA+kRAvs6AJ91z0W0SR/3zzagyhDu9OGQHZzISwCfRyLW
PWwv+M0gQWj3fazgooO1xMU=
=nCUf
-----END PGP SIGNATURE-----

--------------enig193186DF3C9D00779E31509A--

