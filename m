Message-ID: <46681CE8.7070206@domain.hid>
Date: Thu, 07 Jun 2007 16:57:44 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <466813BD.9030608@domain.hid> <4667FBD9.6050107@domain.hid>
	<4668219C.30908@domain.hid>
In-Reply-To: <4668219C.30908@domain.hid>
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
>=20
> Wolfgang Grandegger a =E9crit :
>> St=E9phane ANCELOT wrote:
>>> Hi,
>>>
>>> Enclosed, you will find xenomai rtdm drivers for  ADLINK PCI 7841   a=
nd
>>> ADVANTECH PCI 1680U pci boards.
>>>
>>>
>>> It can be easily ported to clones PCI boards that use 2 sja1000 and a
>>> PLX controler as pci interface.
>>>
>>> known to be running well against xeno 2.1.2
>>>
>>>
>>> To Jan Kiszka and Sebastian Smolorz : the support for advantech pci
>>> 1680u has been  completely rewritten in this version.
>> Nice, unfortunately this driver is obsolete. Are you aware that there =
is
>> RT-Socket-CAN integrated in Xenomai since a while (starting with versi=
on
>> 2.3.0)?
>=20
> Yes, I agree, but it was not available at  the moment of writing /
> testing our driver (March 2006)

Fair enough!

> This work is based on the release 0.9.8 of rt socket can driver  that
> you can find here :
> http://www.rts.uni-hannover.de/rtaddon/
> Since it served as a basis for the actual CAN socket driver, integratio=
n
> of adlink and advantech boards in the xenomai trunk should be trivial.

It should not be a big deal, indeed. Patches are welcome ;-).

Wolfgang.




