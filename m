Message-ID: <4528F0AD.4000602@domain.hid>
Date: Sun, 08 Oct 2006 14:35:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] USB to serial converter using in Xenomai
References: <4527B6C6.7000208@domain.hid>
In-Reply-To: <4527B6C6.7000208@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig977DB9FB3ABCCF4E3D57B583"
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
To: Pavel Pirkl <pavelpirkl@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig977DB9FB3ABCCF4E3D57B583
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Pavel Pirkl wrote:
> Hello,
> 1.
> I am using USB to serial convertes with FTDI chip. But I don=B4t know
> which paramaters of irq and ioaddr I must to set for xeno_16550A.ko .
> Can you help me where I found this parameters?
>=20
> 2.
> Now I am using two serial link defined us
> #!/bin/sh
> setserial /dev/ttyS1 uart none        #COM2
> setserial /dev/ttyS2 uart none        #COM3
> insmod    ./xeno_nucleus.ko
> insmod    ./xeno_native.ko
> insmod    ./xeno_rtdm.ko
> insmod    ./xeno_16550A.ko ioaddr=3D0x2f8,0x3e8 irq=3D3,5 tx_fifo=3D10,=
10
> start_index=3D0    #COM2, COM3
>=20
> This two serial link works very good.
> But if I am set for example this
> #!/bin/sh
> setserial /dev/ttyS2 uart none        #COM3
> setserial /dev/ttyS3 uart none        #COM4 - not function ??
> insmod    ./xeno_nucleus.ko
> insmod    ./xeno_native.ko
> insmod    ./xeno_rtdm.ko
> insmod    ./xeno_16550A.ko ioaddr=3D0x3e8,0x3f8 irq=3D5,10 tx_fifo=3D10=
,10
> start_index=3D0    #COM3, COM4
>=20
> The COM3 works but COM4 doesn=B4t work. Where is problem?

The FTDI can only be used via an USB stack + a FTDI device drivers,
there is no such thing as 16550A emulation via USB devices.

I have such a FTDI driver for the USB4RT stack here, but it is in an
"experimental" (means unusable :-/) state. I still hope we can resolve
this one day, but I cannot promise when.

Jan


--------------enig977DB9FB3ABCCF4E3D57B583
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFKPCtniDOoMHTA+kRAs4aAJwOSTZfEYLOLuusylmqYGIfoteCFgCfXe/q
avdndLcEkqCEUPm5E0nuAdk=
=Kt/q
-----END PGP SIGNATURE-----

--------------enig977DB9FB3ABCCF4E3D57B583--

