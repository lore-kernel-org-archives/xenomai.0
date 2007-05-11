Message-ID: <46444745.3070902@domain.hid>
Date: Fri, 11 May 2007 12:36:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0pu1igVN.1178881055.0249710.dchabal@domain.hid>
In-Reply-To: <0pu1igVN.1178881055.0249710.dchabal@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig478EE1E39C21B21171C4A0FE"
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
--------------enig478EE1E39C21B21171C4A0FE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

CHABAL David wrote:
> Le 11/5/2007, "Jan Kiszka" <jan.kiszka@domain.hid> a =C3=A9crit:
>=20
>> Maksym Veremeyenko wrote:
>>> CHABAL David =C3=90=C2=BF=C3=90=C2=B8=C3=91=CB=86=C3=90=C2=B5=C3=91=E2=
=80=9A:
>>>
>>>> I met some trouble with the 16550A driver provided in Xenomai 2.3.1
>>>> and my Moxa cards (PCI / 8 * RS232 / 168U ).
>>>>
>>>> It was a problem of baudrate computation before setting the LCR_DLAB=

>>>> register.
>>>>
>>>> The formula implemented by the Xenomai driver is different from the =
one
>>>> provided by Moxa. So I copy/paste the formula from the mxser.c file
>>>> (present in the
>>>> kernel distro), and it seems to work fine.
>>>>
>>>> I think it's Moxa card dependant, may be caused by the high default =
baud
>>>> rate of this card.
>>> I have two Moxa boards with no problem, possible you need to specify =

>>> 'baud_base' param.
>>>
>>> I my case :
>>>
>>> # 8 ports board:
>>> /sbin/modprobe xeno_16550A \
>>> ioaddr=3D0x1000,0x1008,0x1010,0x1018,0x1020,0x1028,0x1030,0x1038 \
>>> irq=3D9,9,9,9,9,9,9,9 \
>>> baud_base=3D921600,921600,921600,921600,921600,921600,921600,921600
>>>
>>> # 2 ports board + onboards:
>>> /sbin/modprobe xeno_16550A ioaddr=3D0x3f8,0x2f8,0xdf00,0xdf08=20
>>> irq=3D4,3,11,11 baud_base=3D115200,115200,921600,921600
>>>
>> Interesting. That would leave us just with the generic fix to catch
>> baud_rate=3D=3D0. Far more attractive. :)
>>
>> David, can you confirm this? Weren't you just aware of the baud_base
>> parameter?
>=20
> I'm not totally convinced because if I compute by hand the DLAB registe=
r
> with the 19200 value (my config):
>=20
> With the moxa driver:
>   baud_div =3D 912.600 / 19.200 =3D 47
>=20
> With the Xeno driver:
>   baud_div =3D (912.600 - 9600) / 19.200 =3D 47
>=20
> Grrr, it's ok here because the rounded values are the same because the
> baud base is biggest than the speed requested, but I think a problem ca=
n
> occur with 115200 or more, example:
>=20
> moxa: 912.600/115.200 =3D 8
> xeno: =3D 7

Yeah, hard arguments. This really cries for a moxa tweak. (The
alternative would be to pass an artificially increased baud_base - but
that would be _really_ ugly and we could also ask the user for the
divider directly...)

Jan


--------------enig478EE1E39C21B21171C4A0FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGREdFniDOoMHTA+kRAiZLAJ0SeP2aR+Q/2h1fVGv0ZKY3RG763QCfTVcK
Efkgy8vgaWSbMnc7Z/z3UG4=
=dCL5
-----END PGP SIGNATURE-----

--------------enig478EE1E39C21B21171C4A0FE--

