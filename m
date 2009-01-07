From: "Charlton, John" <john.charlton@domain.hid>
Date: Wed, 7 Jan 2009 11:17:14 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] rtcanconfig rtcansend rtcanrecv
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "socketcan-users@domain.hid" <socketcan-users@domain.hid>

I added a kernel module to the xenomai ksrc/drivers/xenomai/can/sja1000.  I=
t builds and installs with make modules_install for linux-2.6.27.7 and xeno=
mai-2.4.6.1.  I am using OpenEmbedded on an i686 NANO-7240 single board com=
puter.  I load the kernal modules and start for two TS_CAN1 CAN boards with=
 the following commands:

insmod xeno_can_sja1000.ko
insmod xeno_can_tscan1.ko io=3D0x100,0x120 irq=3D5,7
rtcanconfig rtcan0 --baudrate=3D125000 start
rtcanconfig rtcan1 --baudrate=3D125000 start

/proc/rtcan/rtcan0/info:
Device     rtcan0
Controller SJA1000
Board      TSCAN1-Board
Clock-Hz   8000000
Baudrate   125000
Bit-time   brp=3D4 prop_seg=3D0 phase_seg1=3D13 phase_seg2=3D2 sjw=3D1 sam=
=3D0
Ctrl-Mode
State      active
TX-Counter 0
RX-Counter 0
Errors     0
Refcount   0

/proc/rtcan/rtcan1/info:
Device     rtcan1
Controller SJA1000
Board      TSCAN1-Board
Clock-Hz   8000000
Baudrate   125000
Bit-time   brp=3D4 prop_seg=3D0 phase_seg1=3D13 phase_seg2=3D2 sjw=3D1 sam=
=3D0
Ctrl-Mode
State      active
TX-Counter 0
RX-Counter 0
Errors     0
Refcount   0

In one terminal I receive from rtcan0 as follows:
rtcanrecv rtcan0 --verbose
interface rtcan0
s=3D0, ifr_name=3Drtcan0

In a second terminal I send to rtcan1 as follows:
rtcansend rtcan1 --verbose --identifier=3D0x123 0xde 0xad
interface rtcan1
s=3D1, ifr_name=3Drtcan1
<0x123> [2] de ad
Cleaning up...

Nothing happens on the rtcanrecv side--it remains blocked.  If I send a sec=
ond time the rtcansend side blocks after the s=3D1, ifr_name=3Drtcan1 is di=
splayed.

I am new to CAN interfaces so I don't know if the Bit-time and Clock-Hz par=
ameters are correct.  I appreciate any advice.  I am proceeding to get more=
 output from the xeno_can_tscan1 kernel module.  I have the two TS_CAN1 int=
erfaces output/input connected directly together with a short (3 inch) stra=
ight 10 conductor ribbon cable.  Both boards have the 120 ohm termination.

--John

