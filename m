From: "Charlton, John" <john.charlton@domain.hid>
Date: Mon, 12 Jan 2009 13:47:29 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2004DF7841B2@domain.hid>
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>
	<496B6B66.7070905@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2004DF7840E1@domain.hid>
	<200901121810.42126.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200901121810.42126.Sebastian.Smolorz@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [Socketcan-users] rtcanconfig rtcansend rtcanrecv
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "socketcan-users@domain.hid" <socketcan-users@domain.hid>

I agree that rtcan1 transmit interrupt request is set as is rtcan0 receive =
request in sja1000 base + 3, but I notice that neither interrupt is enabled=
 in the control register (offset 0).  I think the command register should b=
e 0x06 so that TIE and RIE interrupt enable bits are set.  I am relying on =
the xeno_can_sja1000 module to set the interrupt enable bits since the xeno=
_can_tscan1 module should just provide access to the sja1000 registers.  I =
don't think the xeno_can_tscan1 should program any of the sja1000 registers=
 itself--is that assumption correct?  I am specifying the correct interrupt=
s which are jumper selected to be 5 and 7 for rtcan0 and rtcan1 respectivel=
y.  The jumper settings can be checked using the TS-CAN1 base + 6 to but th=
e driver doesn't do that yet.

Wolfgang mentioned that the rtcan_tscan1.c driver doesn't set the offset + =
4 register to zero as does the lincan driver.  I will correct that just in =
case but it is supposed to default to zero according to the TS-CAN1 documen=
tation.

--John

-----Original Message-----
From: Sebastian Smolorz [mailto:Sebastian.Smolorz@domain.hid
Sent: Monday, January 12, 2009 12:11 PM
To: Charlton, John
Cc: Wolfgang Grandegger; xenomai@xenomai.org; socketcan-users@domain.hid=
s.de
Subject: Re: [Xenomai-help] [Socketcan-users] rtcanconfig rtcansend rtcanre=
cv

Charlton, John wrote:
> root@domain.hid:~$ cat /proc/rtcan/rtcan1/registers SJA1000=20
> registers
> 00: 00 00 0c 02 ff 00 03 1c 1a 00 00 00 00 60 00 00
> 10: 08 00 20 01 02 03 04 05 06 07 08 ff 20 00 00 c8=20
> root@domain.hid:~$ cat /proc/rtcan/rtcan0/registers SJA1000=20
> registers
> 00: 00 00 0d 01 ff 00 03 1c 1a 00 00 00 00 60 00 00
> 10: 08 00 20 01 02 03 04 05 06 07 08 bf 00 01 00 c8

Register 0x03 reflects the exact interrupt bits. They mean that a RX interr=
upt occured on rtcan0 (0x01) and a TX interrupt on rtcan1 (0x02). Now this =
is interesting as it seems that your system does not get those interrrupts =
the SJA1000s generate. Are you sure your IRQs that you specify on insmod ar=
e really the correct ones?

--=20
Sebastian

