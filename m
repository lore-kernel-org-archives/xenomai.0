Message-ID: <464434AD.2000705@domain.hid>
Date: Fri, 11 May 2007 11:17:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <XqI9Fhxa.1178875870.3777430.dchabal@domain.hid>
	<4644338D.5020405@domain.hid>
In-Reply-To: <4644338D.5020405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6D7137E3983D37FA4B7FA16E"
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
To: Maksym Veremeyenko <verem@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D7137E3983D37FA4B7FA16E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Maksym Veremeyenko wrote:
> CHABAL David =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>> I met some trouble with the 16550A driver provided in Xenomai 2.3.1
>> and my Moxa cards (PCI / 8 * RS232 / 168U ).
>>
>> It was a problem of baudrate computation before setting the LCR_DLAB
>> register.
>>
>> The formula implemented by the Xenomai driver is different from the on=
e
>> provided by Moxa. So I copy/paste the formula from the mxser.c file
>> (present in the
>> kernel distro), and it seems to work fine.
>>
>> I think it's Moxa card dependant, may be caused by the high default ba=
ud
>> rate of this card.
>=20
> I have two Moxa boards with no problem, possible you need to specify=20
> 'baud_base' param.
>=20
> I my case :
>=20
> # 8 ports board:
> /sbin/modprobe xeno_16550A \
> ioaddr=3D0x1000,0x1008,0x1010,0x1018,0x1020,0x1028,0x1030,0x1038 \
> irq=3D9,9,9,9,9,9,9,9 \
> baud_base=3D921600,921600,921600,921600,921600,921600,921600,921600
>=20
> # 2 ports board + onboards:
> /sbin/modprobe xeno_16550A ioaddr=3D0x3f8,0x2f8,0xdf00,0xdf08=20
> irq=3D4,3,11,11 baud_base=3D115200,115200,921600,921600
>=20

Interesting. That would leave us just with the generic fix to catch
baud_rate=3D=3D0. Far more attractive. :)

David, can you confirm this? Weren't you just aware of the baud_base
parameter?

Jan


--------------enig6D7137E3983D37FA4B7FA16E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGRDStniDOoMHTA+kRAuBPAJsFl6+SHrdTIfcsiUGXWQRcczSbnQCdFCvq
Xt6zJNZxEHyurw09J3wi2dI=
=PCLa
-----END PGP SIGNATURE-----

--------------enig6D7137E3983D37FA4B7FA16E--

