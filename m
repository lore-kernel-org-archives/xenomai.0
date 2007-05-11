Message-ID: <4644577F.1090703@domain.hid>
Date: Fri, 11 May 2007 14:46:07 +0300
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
References: <0pu1igVN.1178881055.0249710.dchabal@domain.hid>
	<46444745.3070902@domain.hid>
In-Reply-To: <46444745.3070902@domain.hid>
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka =D0=C9=DB=C5=D4:
>> moxa: 912.600/115.200 =3D 8
>> xeno: =3D 7
>=20
> Yeah, hard arguments. This really cries for a moxa tweak. (The
> alternative would be to pass an artificially increased baud_base - but
> that would be _really_ ugly and we could also ask the user for the
> divider directly...)

As i correctly understand mxser use formula:
       +-
       | base/baud, baud <> 134
div =3D |
       | 2*base/(2*base + 1), baud =3D=3D 134
       +-

Jan's driver use:

div =3D (base + baud/2)/baud

What is actual

div =3D base/baud + 0.5

That seems more correct for rounding....


In additional:
1. You should use 921600 value instead of 912.600.
2. Interface is asynchronous and (IMHO) data could be transfered in a=20
range of frequencies (BAUD +/- RANGE%)



--=20
________________________________________
Maksym Veremeyenko

