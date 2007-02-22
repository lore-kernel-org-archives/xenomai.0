Message-ID: <45DD7C42.9070407@domain.hid>
Date: Thu, 22 Feb 2007 12:19:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN driver
References: <45DC1D05.1000206@domain.hid> <45DC2478.2020602@domain.hid>	
	<45DC39DE.8050802@domain.hid> <45DC3E6C.8040905@domain.hid>	
	<45DD5DC0.6040402@domain.hid>
	<bc4264770702220214y697c57abv9d5170b64fad40eb@domain.hid>
In-Reply-To: <bc4264770702220214y697c57abv9d5170b64fad40eb@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF612BFAA48BE1BB9F4750AEE"
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
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF612BFAA48BE1BB9F4750AEE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi,
>=20
> The first thing I notice is that I do not seem to find the devices
> rtcan0, rtcan1 etc.
>=20
> They are mentioned in the documentation and I presume they must be node=
s in
> /dev or so. But I cannot find them. rt-can is statically built into my
> kernel so I don;t need to load any modules. I have selected the SJA
> chip and the PEAK CAN Dongle.
>=20
> I am reading the README in /src/can and the one in ksrc/drivers/can.
>=20
> /proc/rtcan is present but no devices rtcan0, rtcan1 etc under it.
>=20
> What have I missed?
>=20

rtcanX are networking devices, but only visible in the context of
RTDM/AF_CAN. To enable them, use rtcanconfig as explained in the README.

Jan


--------------enigF612BFAA48BE1BB9F4750AEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3XxCniDOoMHTA+kRAtEgAJ9r4gsQV7ZIXquwpDi73ymNur6kDACfeFhf
oECLVP0MFI7FzRhsex42Utc=
=XGrm
-----END PGP SIGNATURE-----

--------------enigF612BFAA48BE1BB9F4750AEE--

