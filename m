Message-ID: <4667FBD9.6050107@domain.hid>
Date: Thu, 07 Jun 2007 14:36:41 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <466813BD.9030608@domain.hid>
In-Reply-To: <466813BD.9030608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] CAN driver for adlink pci 7841 and ADVANTECH
	1680U
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

St=E9phane ANCELOT wrote:
> Hi,
>=20
> Enclosed, you will find xenomai rtdm drivers for  ADLINK PCI 7841   and
> ADVANTECH PCI 1680U pci boards.
>=20
>=20
> It can be easily ported to clones PCI boards that use 2 sja1000 and a
> PLX controler as pci interface.
>=20
> known to be running well against xeno 2.1.2
>=20
>=20
> To Jan Kiszka and Sebastian Smolorz : the support for advantech pci
> 1680u has been  completely rewritten in this version.

Nice, unfortunately this driver is obsolete. Are you aware that there is=20
RT-Socket-CAN integrated in Xenomai since a while (starting with version=20
2.3.0)?

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/README
http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html

It would make much more sense to add drivers for the ADLINK PCI 7841=20
and ADVANTECH PCI 1680U to "ksrc/drivers/can/sja1000".

Wolfgang.

