Message-ID: <4644758B.8080201@domain.hid>
Date: Fri, 11 May 2007 15:54:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <8bdn5x94.1178893992.8746080.dchabal@domain.hid>
In-Reply-To: <8bdn5x94.1178893992.8746080.dchabal@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBF3C9973C4262EFC90CD585F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] 16550A driver and Moxa card / solved
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: CHABAL David <david.chabal@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF3C9973C4262EFC90CD585F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

CHABAL David wrote:
> Le 11/5/2007, "Jan Kiszka" <jan.kiszka@domain.hid> a =E9crit:
>=20
>> CHABAL David wrote:
>>>>> In additional:
>>>>> 1. You should use 921600 value instead of 912.600.
>>> The "." was here for reading facility only, I consider it as an integ=
er
>>> in my computations.
>> The point was not the point, but the flipped digits.
>>
>>>> (921600 + (115200 div 2)) div 115200 =3D 8
>>>>
>>>> So back to square #1: misconfiguration? David, please check with the=

>>>> correct baud base again if you still see relevant divider variations=
=2E
>>>>
>>> moxa:  921600/115200 =3D 8 (not 7, I apologize for this mistake but w=
e
>>> guess here that the baud base is always 921600 and according to the
>>> mxser file it can be 230400 for some cards)
>> (230400+57600)/115200=3D2,5 =3D> 2
>>
>> 230400/115200=3D2
>>
>> ???
>=20
> Oupsss, I'm beaten :-(
>=20
> The only case  with a different value that I found is for 1200:
> (230400+1200)/1200 =3D 193
> 230400/1200 =3D 192
>=20
> I think it's not relevant for this speed.
>=20

Fine - issue solved without adding tweaks, and everybody is happy. :)

Jan


--------------enigBF3C9973C4262EFC90CD585F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGRHWLniDOoMHTA+kRAuUZAJ0ek/K2Q72FCYxbI8gecXnbX24d6QCdEu/V
Lx1C/RcJJBHLazjexaQ6czA=
=oQhL
-----END PGP SIGNATURE-----

--------------enigBF3C9973C4262EFC90CD585F--

