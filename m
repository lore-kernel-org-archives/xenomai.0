Message-ID: <4506FE59.5070107@domain.hid>
Date: Tue, 12 Sep 2006 20:37:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] rtcan_mem - CAN driver for memory mapped
	SJA1000 controllers
References: <200609121330.16250.matthias.fuchs@domain.hid>
	<4506A66F.5080801@domain.hid>
	<200609121807.49179.matthias.fuchs@domain.hid>
	<4506E45B.8090605@domain.hid>
In-Reply-To: <4506E45B.8090605@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4702A7A7892D99C0B38F0FC5"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4702A7A7892D99C0B38F0FC5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Matthias Fuchs wrote:
>> Hi,
>>
>> here's the 2nd try:
>> - updated external clock frequency handling
>> - use request_mem_region() before remapping memory
>> - renamed local variable mem to vmem in clean loop because it shadowed=

>> a   =20
>> module parameter
>=20
> I have one more comment, sorry. I think you should use:
>=20
>     volatile void __iomem *vmem;
>=20
> and the cleanup in case of error is not OK. See below.

Could someone post a new, full patch so that I don't mess anything up on
the way into SVN?

Thanks,
Jan


--------------enig4702A7A7892D99C0B38F0FC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFBv5ZniDOoMHTA+kRAsxGAJ41YNfBDVInx55GKl0z1JUv0BKdQACfarmz
U/R+H+l59cNoPZ4rs0ZlP48=
=U9Xc
-----END PGP SIGNATURE-----

--------------enig4702A7A7892D99C0B38F0FC5--

