Message-ID: <45071BBD.30908@domain.hid>
Date: Tue, 12 Sep 2006 22:42:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] rtcan_mem - CAN driver for memory mapped
	SJA1000 controllers
References: <200609121330.16250.matthias.fuchs@domain.hid>
	<200609121807.49179.matthias.fuchs@domain.hid>
	<4506E45B.8090605@domain.hid>
	<200609122105.48598.matthias.fuchs@domain.hid>
In-Reply-To: <200609122105.48598.matthias.fuchs@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDBD14E6CB9B8D98EF2DEB0E7"
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
To: Matthias Fuchs <matthias.fuchs@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDBD14E6CB9B8D98EF2DEB0E7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Matthias Fuchs wrote:
> On Tuesday 12 September 2006 18:46, Wolfgang Grandegger wrote:
>> Matthias Fuchs wrote:
>>> Hi,
>>>
>>> here's the 2nd try:
>>> - updated external clock frequency handling
>>> - use request_mem_region() before remapping memory
>>> - renamed local variable mem to vmem in clean loop because it shadowe=
d a
>>> module parameter
>> I have one more comment, sorry. I think you should use:
>>
>>      volatile void __iomem *vmem;
> __iomem is available since kernel version 2.4.28 and it is defined for =

> documentation only.

I guess it's for sparse (haven't used it yet).

> But the xenomai readme names the Denx 2.4.25'based tree=20
> as the 2.4 refererence. And that tree also defines __iomem.
> So, objection allowed.
>=20
>> and the cleanup in case of error is not OK. See below.
> Fixed.
>=20
> New patch attached.=20

Ok, thanks again. I just pushed it in with rev. 1598. I reformatted the
code to kernel style and fixed another inherited bug of the error
roll-back during init. The same happened to rtcan_isa.

Wolfgang, I added the Peak dongle to 2.4 config. Compiles fine, so I
assume you simply forgot that one. Also building-in of all CAN driver
should work now.

If I broke anything, please complain (I only compile-tested so far).

Uff.

Jan


--------------enigDBD14E6CB9B8D98EF2DEB0E7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFBxu9niDOoMHTA+kRAiiAAJ4gtT0KvXWmwy6haVvTFwQ/XfJ4VgCfQFHA
6rC2P8P7NGDl4YyTADsbpOU=
=Zel/
-----END PGP SIGNATURE-----

--------------enigDBD14E6CB9B8D98EF2DEB0E7--

