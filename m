Message-ID: <4C0F9704.4010407@domain.hid>
Date: Wed, 09 Jun 2010 15:28:36 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C0D3EED.5080302@domain.hid>	<4C0D42F9.9090306@domain.hid>	<AANLkTilAzvuYqA_0wQnnM9EES407fqb2kCzSdzoQRejg@domain.hid>	<4C0E7A5B.7040603@domain.hid>	<4C0E8CB9.1090208@domain.hid>	<4C0E8D41.4010006@domain.hid>	<AANLkTimxN8fv5IbXu4v8m106U-rUucvv9Ipjf5E9aMr1@domain.hid>	<4C0F8574.80101@domain.hid>
	<4C0F8755.8010503@domain.hid>
In-Reply-To: <4C0F8755.8010503@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEAA2800878C200239756B9E0"
Subject: Re: [Xenomai-help] installing xenomai in a debian distribution
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, ramoncostacastello@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEAA2800878C200239756B9E0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ramon,

Am 09.06.2010 14:21, schrieb Ramon:
> On 09/06/2010 14:13, Gilles Chanteperdrix wrote:
>> ramon costa wrote:
>>   =20
>>> Hi
>>>
>>> In
>>>
>>> http://www.xenomai.org/index.php/Building_Debian_packages
>>>
>>> It is said that "This howto was written for Linux 2.6.32.11 and Xenom=
ai
>>> 2.5.3,"
>>>
>>> I'm I doing something wrong or there's a problem in howto page ?
>>>     =20
>> Maybe instead of asking the same question again and again, you could
>> answer the question I asked? What version are you trying to install?
>>
>> Also,  please CC the mailing list.
>>
>>   =20
>=20
> Hi
>=20
> At this moment I don't care which is the concrete version a get=20
> installed (this is why I didn't
> reply to this point). My only interest is obtaining a Xenomai system=20
> installed in order to learn how in works.
>=20
> As I'm following the steps  in
>=20
> http://www.xenomai.org/index.php/Building_Debian_packages
>=20
> I assumed that I was trying to install Linux 2.6.32.11 and Xenomai 2.5.=
3

If you follow all steps in the howto, you'll have these versions installe=
d.
I have tested the howto using debian lenny and ubuntu lucid.

There are two different ways to get the xenomai source:
 1. using git -> section 2.2
 2. tar.bz2 download -> section 2.3

Try the section 2.3 "Building Xenomai packages from a tar.bz2 archive" va=
riant and skip section 2.2.

If you did all steps from the section 2 (except 2.2), then list the insta=
lled kernel-patches
using "ls -1 /usr/src/kernel-patches/diffs/xenomai".

If there is no 2.6.32.11 patch something went wrong.
If there is a patch for 2.6.32.11 go on with section 3 "Building a Xenoma=
i patched Linux kernel package".

I guess you started directly with section 3 after installing xenomai 2.4.=
8 from the debian archive,
or you simply missed the section 2.5 "installation" after building 2.5.3.=


Stefan

> Ramon
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20



--------------enigEAA2800878C200239756B9E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFMD5cJIPTw9rIdn6oRAgS4AJ4uN5E4G/GmOvgQaFsogwELjb7zxgCfWdS7
H3Z/5isekyxrR6k/BaFOgDo=
=TK6o
-----END PGP SIGNATURE-----

--------------enigEAA2800878C200239756B9E0--

