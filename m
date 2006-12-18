Message-ID: <458689FD.6050508@domain.hid>
Date: Mon, 18 Dec 2006 13:30:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] consolidate testsuite installation
References: <457BDF99.1020405@domain.hid>
	<1165778549.8255.17.camel@domain.hid>		<457CA36C.5060805@domain.hid>
	<1165828053.5025.8.camel@domain.hid> <457D23CA.0@domain.hid>
	<457E6A01.4090500@domain.hid> <457EA179.5070606@domain.hid>
	<457EAACF.3060307@domain.hid> <457EAD7F.2040902@domain.hid>
	<457EC0CE.5040307@domain.hid> <4580312F.1000907@domain.hid>
	<458662A1.1010703@domain.hid>
In-Reply-To: <458662A1.1010703@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEC2A7E89C5A63426F06191AC"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEC2A7E89C5A63426F06191AC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Gilles Chanteperdrix wrote:
>>>>
>>>>> At some point in time:
>>>>> https://mail.gna.org/public/xenomai-help/2006-09/msg00181.html
>>>>>
>>>>> I started to use exec_prefix and prefix for separating the binaries=
,
>>>>> libraries and script that need to be installed on the target from t=
he
>>>>> include files, documentation and xeno-config script that need to be=

>>>>> installed on the host.
>>>>>
>>>> OK, appears reasonable, though I cannot asses if it's a standard usa=
ge.
>>> Do not know either if it is standard, but it may be useful to some us=
ers.
>>>
>>>
>>>> What do you suggest as a replacement for $(pkgdatadir) then?
>>>> $(exec_prefix)/share/xenomai? Or where to put the testsuite start sc=
ripts?
>>> I am Ok with anything under $(exec_prefix)...
>>>
>>
>> Then you should like -v3: now exec_prefix-based.
>=20
> It is Ok for me.
>=20

I would apply now, but all my autotool versions I have around seem to be
different from yours. Should I just check-in the source part and leave
the bootstrap run pending until anyone of you can kick it?


--------------enigEC2A7E89C5A63426F06191AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFhon9niDOoMHTA+kRAn3XAJ9iN63HJeMmYc+YmSe/Ntc/UBI4IwCfQuM/
gMw7/ACNw1Nz9AD9NXFsgCw=
=wtKz
-----END PGP SIGNATURE-----

--------------enigEC2A7E89C5A63426F06191AC--

