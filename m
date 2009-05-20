Message-ID: <4A13E8BF.3030703@domain.hid>
Date: Wed, 20 May 2009 13:25:51 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4A008DC9.1000603@domain.hid> <1242812539.31033.12.camel@domain.hid>
	<4A13D9F6.30602@domain.hid>
In-Reply-To: <4A13D9F6.30602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEFB6C12B395A89F2C459ECF0"
Subject: Re: [Xenomai-help] IXXAT-PCI-CAN driver hijacks my pci board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEFB6C12B395A89F2C459ECF0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

Wolfgang Grandegger schrieb:
> [...]
>>> dmesg output, there is no IXXAT-PCI-CAN board installed:
>>>> RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
>>>> RTCAN SJA1000 driver initialized
>>>> PCI: setting IRQ 12 as level-triggered
>>>> IXXAT-PCI-CAN 0000:00:11.0: found PCI INT A -> IRQ 12
>>>> IXXAT-PCI-CAN: Initializing device 10b5:9050:2503
>=20
> OK, it finding a variant of the PLX9050, but it will not use the device=
 =20
> because of the following lines after the above printout:
>=20
>     if (sub_sys_id !=3D IXXAT_PCI_SUB_SYS_ID)
>              return -ENODEV;
>                =20
> But ...
>=20
>>> The following patch fixed it for me (my own driver loads again).
>=20
> ... obviously it does  not probe again.

it probes again, but pci_request_regions() failed in my driver.

In the -ENODEV case, the function pci_release_regions() is not
called in the ixxat driver, so access is blocked for other drivers.

Stefan




--------------enigEFB6C12B395A89F2C459ECF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKE+i/IPTw9rIdn6oRAu7RAJ93qNEjENfgy5l3Gz8O6RiFmj4sXgCdFW0g
V7B2qfKX67pbJhFhmeZbTq4=
=lE/6
-----END PGP SIGNATURE-----

--------------enigEFB6C12B395A89F2C459ECF0--

