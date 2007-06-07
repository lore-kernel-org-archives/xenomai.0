Message-ID: <46681F69.90802@domain.hid>
Date: Thu, 07 Jun 2007 17:08:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <466813BD.9030608@domain.hid>
	<4667FBD9.6050107@domain.hid>	<4668219C.30908@domain.hid>
	<46681CE8.7070206@domain.hid>
In-Reply-To: <46681CE8.7070206@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7EA3E7B95867E22E04846B2F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] CAN driver for adlink pci 7841 and
	ADVANTECH	1680U
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7EA3E7B95867E22E04846B2F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> St=E9phane ANCELOT wrote:
>> Wolfgang Grandegger a =E9crit :
>>> St=E9phane ANCELOT wrote:
>>>> Hi,
>>>>
>>>> Enclosed, you will find xenomai rtdm drivers for  ADLINK PCI 7841   =
and
>>>> ADVANTECH PCI 1680U pci boards.
>>>>
>>>>
>>>> It can be easily ported to clones PCI boards that use 2 sja1000 and =
a
>>>> PLX controler as pci interface.
>>>>
>>>> known to be running well against xeno 2.1.2
>>>>
>>>>
>>>> To Jan Kiszka and Sebastian Smolorz : the support for advantech pci
>>>> 1680u has been  completely rewritten in this version.
>>> Nice, unfortunately this driver is obsolete. Are you aware that there=
 is
>>> RT-Socket-CAN integrated in Xenomai since a while (starting with vers=
ion
>>> 2.3.0)?
>> Yes, I agree, but it was not available at  the moment of writing /
>> testing our driver (March 2006)
>=20
> Fair enough!
>=20
>> This work is based on the release 0.9.8 of rt socket can driver  that
>> you can find here :
>> http://www.rts.uni-hannover.de/rtaddon/
>> Since it served as a basis for the actual CAN socket driver, integrati=
on
>> of adlink and advantech boards in the xenomai trunk should be trivial.=

>=20
> It should not be a big deal, indeed. Patches are welcome ;-).

Please remember, St=E9phane: For now, only _you_ have the hardware. We ca=
n
only look at code. :->

Jan


--------------enig7EA3E7B95867E22E04846B2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGaB9qniDOoMHTA+kRAqSKAJ9G/Kz3BNOUnskgwI5RYGBenqvN3gCfQ/pk
cEEI/4Re3i1pWiQbt1vWJhM=
=YML7
-----END PGP SIGNATURE-----

--------------enig7EA3E7B95867E22E04846B2F--

