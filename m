Message-ID: <4668219C.30908@domain.hid>
Date: Thu, 07 Jun 2007 15:17:48 +0000
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
References: <466813BD.9030608@domain.hid> <4667FBD9.6050107@domain.hid>
In-Reply-To: <4667FBD9.6050107@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>



Wolfgang Grandegger a =E9crit :
> St=E9phane ANCELOT wrote:
>> Hi,
>>
>> Enclosed, you will find xenomai rtdm drivers for  ADLINK PCI 7841   and
>> ADVANTECH PCI 1680U pci boards.
>>
>>
>> It can be easily ported to clones PCI boards that use 2 sja1000 and a
>> PLX controler as pci interface.
>>
>> known to be running well against xeno 2.1.2
>>
>>
>> To Jan Kiszka and Sebastian Smolorz : the support for advantech pci
>> 1680u has been  completely rewritten in this version.
>=20
> Nice, unfortunately this driver is obsolete. Are you aware that there is
> RT-Socket-CAN integrated in Xenomai since a while (starting with version
> 2.3.0)?

Yes, I agree, but it was not available at  the moment of writing /
testing our driver (March 2006)

This work is based on the release 0.9.8 of rt socket can driver  that
you can find here :
http://www.rts.uni-hannover.de/rtaddon/
Since it served as a basis for the actual CAN socket driver, integration
of adlink and advantech boards in the xenomai trunk should be trivial.


Best Regards
S.Ancelot


>=20
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/README
> http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html
>=20
> It would make much more sense to add drivers for the ADLINK PCI 7841 and
> ADVANTECH PCI 1680U to "ksrc/drivers/can/sja1000".
>=20
> Wolfgang.
>=20
>=20


