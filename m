Message-ID: <455CC9DE.6030601@domain.hid>
Date: Thu, 16 Nov 2006 21:28:14 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>	
	<455C8B8A.80105@domain.hid> <455CBC4A.5010108@domain.hid>
	<54b161f50611161200u7a32f87etdad89178ddc1a195@domain.hid>
In-Reply-To: <54b161f50611161200u7a32f87etdad89178ddc1a195@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Frits de Klark wrote:
> Hi,
>=20
> there is indeed a driver for the 2.4.x kernel series (including source)=
,=20
> but onfortunately also a BIG FAT copyright statement at the heading of=20
> the sources. Something like:
> #######################################################################=
######=20
>=20
> //=20
> ***********************************************************************=
******=20
>=20
> //                  Copyright ( c ) 2003, Advantech Automation Corp.
> //      THIS IS AN UNPUBLISHED WORK CONTAINING CONFIDENTIAL AND PROPRIE=
TARY
> //               INFORMATION WHICH IS THE PROPERTY OF ADVANTECH=20
> AUTOMATION CORP.
> //
> //    ANY DISCLOSURE, USE, OR REPRODUCTION, WITHOUT WRITTEN=20
> AUTHORIZATION FROM
> //               ADVANTECH AUTOMATION CORP., IS STRICTLY PROHIBITED.
> //=20
> ***********************************************************************=
******=20
>=20
> //=20
> #######################################################################=
######
>=20
> So, I'll have to inquire them first before I (and the company I work=20
> for) take the risk of disclosure.
> I'll get back on this as soon as I can. If I can be of any help in the=20
> meantime, I'll be glad to hear from you.

Well, it might be simpler to buy an already supported CAN PCI card.

> Thank for your time and interest so far.

Good luck.

Wolfgang.

> Frits
>=20
> On 11/16/06, *Wolfgang Grandegger* <wg@domain.hid
> <mailto:wg@domain.hid>> wrote:
>=20
>     Jan Kiszka wrote:
>      > Frits de Klark wrote:
>      >> Hello everyone,
>      >>
>      >> I finally got my PCI CAN card today. It's an Advantech 1680 and
>      >> provides, as
>      >> far as I'm informed, a memory mapped SJA1000 controller.
>      >> I=B4m trying to load the xeno_rtcan_mem module now, but I'm not
>     sure what
>      >> parameters I should pass. More specific: What value(s) should I
>     give to the
>      >> 'mem' parameter? Is this an I/O address I found in /proc/pci
>     under the 1680
>      >> device?
>      >
>      > I'm not sure that this will work, but you can give it a try in
>     any case.
>      > Do you have a reference driver for that board? Or some manual
>     describing
>      > the mapping of the SJA1000 into the PCI address space?
>=20
>     It was not working for the IXXAT PCI card, at least (but I have not=
 yet
>     understodd why). Check with "$ lspci -vv" how the device is mapped =
and
>     what IRQ number is used. The right thing is to implement a PCI driv=
er.
>=20
>      > AFAIK, Wolfgang is working on a generic SJA1000 PCI driver. So f=
ar we
>      > only have a driver for the PEAK PCI adapter, but that one is
>     going to be
>      > generalised. So you could become a first-grade test candidate fo=
r
>      > another piece of hardware supported by that driver. :)
>      >
>      > Wolfgang, what the status?
>=20
>     As already mention, I'm currently working on a driver for the IXXAT=
 PCI
>     card. As I see it, a generic driver is not feasible as the mapping,=
 the
>     recognition of the second channel and the IRQ handling is quite
>     different.
>=20
>     Is there a Linux driver on the CRROM your got with your Advantech 1=
680
>     PCI card? That would help a lot.
>=20
>     Wolfgang.
>=20
>     Wolfgang.
>=20
>=20


