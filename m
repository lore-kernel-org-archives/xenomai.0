Message-ID: <442A9348.4060105@domain.hid>
Date: Wed, 29 Mar 2006 16:01:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Run-time problem with xenomai
References: <7C4B97D3898FED44BC087D25490A44A1B6BB67@domain.hid>
	<442A8F84.8060506@domain.hid>
In-Reply-To: <442A8F84.8060506@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE368600FAA91A73497FF0276"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, =?windows-1252?Q?Hans_J=F8rgen_Olsen?= <HansJoergen.Olsen@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE368600FAA91A73497FF0276
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Hans J=F8rgen Olsen wrote:
>> Hi.
>>
>> =20
>>
>> First: I=92m new to Xenomai and slowly becoming a not_so_new linux use=
r.
>>
>> =20
>>
>> I have successfully installed Xenomai 2.1 following Hannes Mayer=92s
>> excellent guide.
>>
>> =20
>>
>> Everything looks fine until testing using the programs in testsuite.
>> Then the process stops with the message:
>>
>> Xenomai: incompatible feature set
>>
>> (required=3D=94sep tsc=94, present=3D=94sep=94, missing=3D=94tsc=94).
>>
>=20
> Everything is explained in the README.INSTALL file.
>=20

Hmm, I was lacking (or overread?) something like this:

(required=3D"x", present=3D"y", missing=3D"z") means

required: "x" is what the userspace part expects
present:  "y" is what the kernel supports
missing:  "z" is what the kernel is lacking

Jan


--------------enigE368600FAA91A73497FF0276
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEKpNIniDOoMHTA+kRAl2UAJ9iMlQNnBwL2l8HGT74azNsc8znNwCfXfhU
KHuAVuPmiiAX8tNePIgzoc4=
=ciQh
-----END PGP SIGNATURE-----

--------------enigE368600FAA91A73497FF0276--

