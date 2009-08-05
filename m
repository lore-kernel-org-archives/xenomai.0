From: "Charlton, John" <john.charlton@domain.hid>
Date: Wed, 5 Aug 2009 10:12:10 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE20060EEFC612@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Peak parallel port dongle rtcan driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I am having some problems with the xeno_can_peak_dng driver with the Peak p=
arallel port CAN dongle.  I am using linux-2.6.27.7 kernel and xenomai-2.4.=
6.1 on an embedded PC (NANO-7240, ULV Celeron 400 MHz CPU).

I have done extensive testing using both RAW CAN and CanOpen using CanFesti=
val at 1Mbit baud with a TS-CAN1 PC-104 bus card with no errors.  When I us=
e the Peak parallel port dongle at 1 Mbit or 125Kbit baud I loose packets a=
nd get errors.  It is worse receiving packets with rtcanrecv than transmitt=
ing with rtcansend.  I can transmit for longer intervals but eventually it =
fails with an error.  The last error reported is:
Assertion failed! <linux kernel directory>/drivers/xenomai/can/rtcan_raw.c:=
rtcan_tx_push:171 dev->tx_socket =3D=3D 0
This error occurred after 484 successful transmissions with 100msec delay a=
t baudrate=3D1000000:
rtcansend rtcan0 --verbose --identifier=3D0x123 0xde 0xad 3 4 5 6 7 8

After the transmission failed the I was unable to send any more packets unt=
il I reloaded the driver.  The /proc/rtcan/rtcan0/info state goes to warnin=
g in this case.
Receiving using rtcanrecv rtcan0 --verbose --error=3D0xffff has more errors=
.  Receiving errors result in corrupt packets but don't cause the CAN bus t=
o quit working or the state to go to warning.  Right after a receive failur=
e

Device     rtcan0
Controller SJA1000
Board      PEAK-Dongle
Clock-Hz   8000000
Baudrate   1000000
Bit-time   brp=3D1 prop_seg=3D0 phase_seg1=3D5 phase_seg2=3D2 sjw=3D1 sam=
=3D0
Ctrl-Mode =20
State      active
TX-Counter 0
RX-Counter 0
Errors     0
Refcount   0

SJA1000 registers
00: 80 00 0c 00 ff 00 00 14 1a 00 00 00 a2 60 00 00
10: 60 de ad 03 04 05 06 80 08 08 24 60 de 00 23 80

I currently have the Peak parallel dongle set to io=3D0x378 irq=3D7 type=3D=
epp.  I set the parallel port bios to EPP mode and IRQ 7.  I tried ECP mode=
 but the xeno_can_peak_dng driver doesn't find the sja1000 unless the bios =
setting is EPP.  This conflicts with the Peak documentation which states in=
 the FAQ that ECP is the correct setting even though the driver type is EPP=
.  It looks to me like there may be a timing problem in the parallel port r=
egister read.

--John

John D. Charlton
	Sr. Development Engineer
      GATD Electrical Controls
	Tyco Electronics Corporation=20
	Mail Stop: 161-39
	(717) 810-2141=20
	(717) 810-2443 FAX
	john.charlton@domain.hid
 =

