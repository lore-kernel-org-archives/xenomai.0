Message-ID: <455D787D.9010407@domain.hid>
Date: Fri, 17 Nov 2006 09:53:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>	
	<455C8B8A.80105@domain.hid> <455CBC4A.5010108@domain.hid>	
	<54b161f50611161200u7a32f87etdad89178ddc1a195@domain.hid>	
	<455CC9DE.6030601@domain.hid>	
	<54b161f50611162357o71b7f689v1bf68072861c753e@domain.hid>	
	<455D6D3B.9000009@domain.hid>
	<54b161f50611170041t2b8d2da1p177e9addade6a0e3@domain.hid>
In-Reply-To: <54b161f50611170041t2b8d2da1p177e9addade6a0e3@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD7ABF3009749BFEC29D8896B"
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
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD7ABF3009749BFEC29D8896B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Frits de Klark wrote:
> So,
>=20
> On 11/17/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>>
>> You could try handing region 2 or 3 to the rtcan_isa driver or region =
0
>> to rtcan_mem. Maybe your adapter actually does 1:1 mapping of the
>> SJA1000 address space (it looks like). I just wonder what region 4 is
>> doing. Maybe it controls the content of region 0, which may either hol=
d
>> the first or the second CAN controller. Just a theory...
>>
>> Jan
>=20
>=20
>=20
> I entered the following command:
>=20
> modprobe  xeno_rtcan_isa io=3D55296,56320 irq=3D11

Try "modprobe xeno_rtcan_isa io=3D55296,56320 irq=3D11,11" instead to ass=
ign
the irq of the second port as well.

Jan


--------------enigD7ABF3009749BFEC29D8896B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXXh9niDOoMHTA+kRAhdIAJ9CQIAuMXxAnvk813haw2b3CK2dsgCfZVe7
HXhwkHIyaHXXZLfat/Kzkk8=
=FFpw
-----END PGP SIGNATURE-----

--------------enigD7ABF3009749BFEC29D8896B--

