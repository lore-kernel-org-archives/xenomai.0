Message-ID: <45E7E31B.1090102@domain.hid>
Date: Fri, 02 Mar 2007 09:40:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>
In-Reply-To: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1D8B6EB4C4D802C75AEB9007"
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1D8B6EB4C4D802C75AEB9007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi,
>=20
> My dongle has arrived and seems to be OK under windows.
>=20
> I am now trying to install it under linux but things not looking good s=
o
> far.
>=20
> from
>=20
> /lib/modules/2.6.16-xen-3/kernel/drivers/xenomai/can/sja1000
>=20
> I ran
>=20
> $>depmod xeno_can_peak_dng.ko
> $>modprobe xeno_can_peak_dng type=3Depp io=3D0x378 irq=3D7
>=20
> but the result is:
>=20
> FATAL: Error inserting xeno_can_peak_dng (xeno_can_peak_dng.ko): No suc=
h
> device
>=20
> The little led is glowing. And the dongle is even plugged in to the
> only parallel port my machine has :)
> Nothing is connected to the output of the dongle at this stage.
>=20
> Am I missing something fundamental here?
>=20

Maybe a conflict with parport_pc.

Wolfgang, do we always have to remove that module, or is there a chance
to cooperate with it without loosing real-time? When removing the Linux
parport layer, there is the risk that the port is powered off (see
irqbench), and xeno_can_peak_dng does not account for this yet.

Jan


--------------enig1D8B6EB4C4D802C75AEB9007
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5+MdniDOoMHTA+kRApv3AJ46dh0JYqSG+h4LJEh8I8w7a7WP9wCfaZfZ
pZ0tDCuShv6c2JtDtvU4Mkc=
=Tr0J
-----END PGP SIGNATURE-----

--------------enig1D8B6EB4C4D802C75AEB9007--

