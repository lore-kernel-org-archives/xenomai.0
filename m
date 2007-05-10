Message-ID: <4643442B.8080600@domain.hid>
Date: Thu, 10 May 2007 18:11:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <000b01c79302$3cf11a40$c67ba8c0@domain.hid>
In-Reply-To: <000b01c79302$3cf11a40$c67ba8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFB619E0B0549155C3494EDDF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Serial Port Driver (rtser): No
	RTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonas Witt <Jonas@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFB619E0B0549155C3494EDDF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jonas Witt wrote:
> Hi everybody,
>=20
> =20
>=20
> i am having a problem with the serial port driver in xenomai for a whil=
e
> now..
>=20
> =20
>=20
> I have tried different programs like
> http://www.captain.at/xenomai-serial-port-example.php
>=20
> =20
>=20
> I have also changed the code of cross-link.c to use the same port for
> writing and reading (as i only have one serial port in my computer). Op=
ening
> a port and writing the configuration seems to work form e.. also writin=
g.
> The Problem stems from the call to:
>=20
> =20
>=20
> rt_dev_ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event);
>=20
> =20
>=20
> which keeps waiting forever and never receives an interrupt. I tried a
> self-made loopback-adapter and a sensor with a serial interface (so at =
least
> _something_ should come back). Nothing worked. The serial port is worki=
ng
> fine with the linux-driver, though. I already figured that the calls to=

> rt_dev_write do not work from non-xenomai-tasks (which should really be=

> emphasized in the documentation..)
>=20

Some suggestions:

 o check the hardware configuration (ie. the module parameters of
   xeno_16550A) twice, you can easily get them wrong

 o check /proc/xenomai/irq for any progress on transmission as well as
   on reception. If there is nothing happen on tx, the IRQ number may be
   wrong, if there is nothing on rx, your port configuration might be
   broken.

 o try the driver from trunk, it can handle PnP-related issues (hardware
   gets powered off when Linux driver is removed)

Jan


--------------enigFB619E0B0549155C3494EDDF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGQ0QrniDOoMHTA+kRArNCAJ9drp0XAzYJHl57qvQMZvh4r8AGCACcDdh/
GcDfFJI+TTc6fZgZCV54/og=
=d/FO
-----END PGP SIGNATURE-----

--------------enigFB619E0B0549155C3494EDDF--

