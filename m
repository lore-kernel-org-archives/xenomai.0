Message-ID: <4644338D.5020405@domain.hid>
Date: Fri, 11 May 2007 12:12:45 +0300
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
References: <XqI9Fhxa.1178875870.3777430.dchabal@domain.hid>
In-Reply-To: <XqI9Fhxa.1178875870.3777430.dchabal@domain.hid>
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
To: CHABAL David <david.chabal@domain.hid>
Cc: xenomai@xenomai.org

CHABAL David =D0=C9=DB=C5=D4:

> I met some trouble with the 16550A driver provided in Xenomai 2.3.1
> and my Moxa cards (PCI / 8 * RS232 / 168U ).
>=20
> It was a problem of baudrate computation before setting the LCR_DLAB
> register.
>=20
> The formula implemented by the Xenomai driver is different from the one
> provided by Moxa. So I copy/paste the formula from the mxser.c file
> (present in the
> kernel distro), and it seems to work fine.
>=20
> I think it's Moxa card dependant, may be caused by the high default bau=
d
> rate of this card.

I have two Moxa boards with no problem, possible you need to specify=20
'baud_base' param.

I my case :

# 8 ports board:
/sbin/modprobe xeno_16550A \
ioaddr=3D0x1000,0x1008,0x1010,0x1018,0x1020,0x1028,0x1030,0x1038 \
irq=3D9,9,9,9,9,9,9,9 \
baud_base=3D921600,921600,921600,921600,921600,921600,921600,921600

# 2 ports board + onboards:
/sbin/modprobe xeno_16550A ioaddr=3D0x3f8,0x2f8,0xdf00,0xdf08=20
irq=3D4,3,11,11 baud_base=3D115200,115200,921600,921600


--=20
________________________________________
Maksym Veremeyenko

