Date: Fri, 11 May 2007 10:57:35 +0000
Message-ID: <0pu1igVN.1178881055.0249710.dchabal@domain.hid>
In-Reply-To: <464434AD.2000705@domain.hid>
From: "CHABAL David" <david.chabal@domain.hid>
Errors-To: "CHABAL David" <david.chabal@domain.hid>
MIME-Version: 1.0 
Content-Type: text/plain; charset=ISO-8859-1
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
To: Jan Kiszka <jan.kiszka@domain.hid>, Maksym Veremeyenko <verem@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 11/5/2007, "Jan Kiszka" <jan.kiszka@domain.hid> a =E9crit:

>Maksym Veremeyenko wrote:
>> CHABAL David =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>=20
>>> I met some trouble with the 16550A driver provided in Xenomai 2.3.1
>>> and my Moxa cards (PCI / 8 * RS232 / 168U ).
>>>
>>> It was a problem of baudrate computation before setting the LCR_DLAB
>>> register.
>>>
>>> The formula implemented by the Xenomai driver is different from the one
>>> provided by Moxa. So I copy/paste the formula from the mxser.c file
>>> (present in the
>>> kernel distro), and it seems to work fine.
>>>
>>> I think it's Moxa card dependant, may be caused by the high default baud
>>> rate of this card.
>>=20
>> I have two Moxa boards with no problem, possible you need to specify=20
>> 'baud_base' param.
>>=20
>> I my case :
>>=20
>> # 8 ports board:
>> /sbin/modprobe xeno_16550A \
>> ioaddr=3D0x1000,0x1008,0x1010,0x1018,0x1020,0x1028,0x1030,0x1038 \
>> irq=3D9,9,9,9,9,9,9,9 \
>> baud_base=3D921600,921600,921600,921600,921600,921600,921600,921600
>>=20
>> # 2 ports board + onboards:
>> /sbin/modprobe xeno_16550A ioaddr=3D0x3f8,0x2f8,0xdf00,0xdf08=20
>> irq=3D4,3,11,11 baud_base=3D115200,115200,921600,921600
>>=20
>
>Interesting. That would leave us just with the generic fix to catch
>baud_rate=3D=3D0. Far more attractive. :)
>
>David, can you confirm this? Weren't you just aware of the baud_base
>parameter?

I'm not totally convinced because if I compute by hand the DLAB register
with the 19200 value (my config):

With the moxa driver:
  baud_div =3D 912.600 / 19.200 =3D 47

With the Xeno driver:
  baud_div =3D (912.600 - 9600) / 19.200 =3D 47

Grrr, it's ok here because the rounded values are the same because the
baud base is biggest than the speed requested, but I think a problem can
occur with 115200 or more, example:

moxa: 912.600/115.200 =3D 8
xeno: =3D 7

Maksym, what is the kind of yours connections ? (PC <-> PC with the same
moxa cards inside the 2 boxes, or PC <-> other device ) ? (In the 1st
the case the both clocks are configured with the same value.)

I find the pb by seeing the signals with an oscilloscope

David

>
>Jan
>

