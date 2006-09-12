Message-ID: <4506ECAA.9000609@domain.hid>
Date: Tue, 12 Sep 2006 19:21:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTCAN_USE_REFCOUNT issue in rtcan_dev.h
References: <200609121755.04559.mfuchs@domain.hid>
	<4506E11A.6030203@domain.hid>
In-Reply-To: <4506E11A.6030203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4BF8751DBB50B0E24A4A0E22"
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
--------------enig4BF8751DBB50B0E24A4A0E22
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Matthias Fuchs wrote:
>> Hi Jan,
>>
>> I think there's is little typo in rtcan_dev.h:
>>
>> Index: rtcan_dev.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- rtcan_dev.h (revision 1564)
>> +++ rtcan_dev.h (working copy)
>> @@ -45,7 +45,7 @@
>> =20
>>  /* Suppress handling of refcount if module support is not enabled
>>   * or modules cannot be unloaded */
>> -#if defined(CONFIG_MODULES) && !defined(CONFIG_MODULE_UNLOAD)
>> +#if defined(CONFIG_MODULES) && defined(CONFIG_MODULE_UNLOAD)
>>  #define RTCAN_USE_REFCOUNT
>>  #endif
>>
>>
>> This simple patch will allow unloading of modules.
>=20
> Argh, I interpreted the meaning of CONFIG_MODULE_UNLOAD the other way
> round. But your fix will not work for 2.4, as there is no
> CONFIG_MODULE_UNLOAD. The attached one should be OK.
>=20
> Thanks.
>=20
> Wolfgang.
>=20

Applied, thanks to both of you.

Jan



--------------enig4BF8751DBB50B0E24A4A0E22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFBuyqniDOoMHTA+kRAg/4AJ4/zHJGU125yg8wc+7K2/Ib4wv2FgCfT7Qz
fUpSIB6liF59muCdQ1OYSKE=
=Jo22
-----END PGP SIGNATURE-----

--------------enig4BF8751DBB50B0E24A4A0E22--

