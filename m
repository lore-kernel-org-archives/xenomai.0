From: "Charlton, John" <john.charlton@domain.hid>
Date: Thu, 13 Aug 2009 08:23:22 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE20060F03FA93@domain.hid>
References: <CF7FB0793253794F9F45991443E5FE20060EFA3F76@domain.hid>
	<4A840387.9010700@domain.hid>
In-Reply-To: <4A840387.9010700@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] FW: Peak parallel port dongle rtcan driver
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Wolfgang,

Thank you for the information and advice.  We are currently considering thi=
s interface in a custom embedded controller design but based on your recomm=
endations we probably need to reassess that decision. We were intending to =
use the parallel port through a super io chip on a custom designed board bu=
t it sounds like we should go with an ISA or PCI bus interface to get real-=
time performance at 1mbit baud rate.  Our application requires the full 1mb=
it baudrate continuous for 100msec to 200msec intervals.

--John

-----Original Message-----
From: Wolfgang Grandegger [mailto:wg@domain.hid
Sent: Thursday, August 13, 2009 8:14 AM
To: Charlton, John
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] FW: Peak parallel port dongle rtcan driver

Hi John,

Charlton, John wrote:
> To follow up on this, I configured the parallel port for standard mode an=
d the xeno_can_peak_dng driver works without error so the problem has to do=
 with the EPP/ECP mode.  I would like to use EPP or ECP for performance.  A=
nd as indicated below, the xeno_can_peak_dng driver only recognizes the sja=
1000 when the bios is set to EPP mode.  Any ideas on how to get it to work =
in EPP or ECP?

I'm not really familiar with EPP and ECP and the differences. I just know t=
hat this devcie is not really good for production purposes, especially at 1=
 MB/s. Also real-time suffers, because device access is quite slow. The dri=
ver is derived from PEAK's PCAN driver. PEAK might be able to tell you more=
 about the limitations and EPP/ECP problems with that device.

Wolfgang.

> --John
>=20
> -----Original Message-----
> From: Charlton, John
> Sent: Wednesday, August 05, 2009 10:12 AM
> To: xenomai@xenomai.org
> Subject: Peak parallel port dongle rtcan driver
>=20
> I am having some problems with the xeno_can_peak_dng driver with the Peak=
 parallel port CAN dongle.  I am using linux-2.6.27.7 kernel and xenomai-2.=
4.6.1 on an embedded PC (NANO-7240, ULV Celeron 400 MHz CPU).
>=20
> I have done extensive testing using both RAW CAN and CanOpen using CanFes=
tival at 1Mbit baud with a TS-CAN1 PC-104 bus card with no errors.  When I =
use the Peak parallel port dongle at 1 Mbit or 125Kbit baud I loose packets=
 and get errors.  It is worse receiving packets with rtcanrecv than transmi=
tting with rtcansend.  I can transmit for longer intervals but eventually i=
t fails with an error.  The last error reported is:
> Assertion failed! <linux kernel directory>/drivers/xenomai/can/rtcan_raw.=
c:rtcan_tx_push:171 dev->tx_socket =3D=3D 0 This error occurred after 484 s=
uccessful transmissions with 100msec delay at baudrate=3D1000000:
> rtcansend rtcan0 --verbose --identifier=3D0x123 0xde 0xad 3 4 5 6 7 8
>=20
> After the transmission failed the I was unable to send any more packets u=
ntil I reloaded the driver.  The /proc/rtcan/rtcan0/info state goes to warn=
ing in this case.
> Receiving using rtcanrecv rtcan0 --verbose --error=3D0xffff has more=20
> errors.  Receiving errors result in corrupt packets but don't cause=20
> the CAN bus to quit working or the state to go to warning.  Right=20
> after a receive failure
>=20
> Device     rtcan0
> Controller SJA1000
> Board      PEAK-Dongle
> Clock-Hz   8000000
> Baudrate   1000000
> Bit-time   brp=3D1 prop_seg=3D0 phase_seg1=3D5 phase_seg2=3D2 sjw=3D1 sam=
=3D0
> Ctrl-Mode =20
> State      active
> TX-Counter 0
> RX-Counter 0
> Errors     0
> Refcount   0
>=20
> SJA1000 registers
> 00: 80 00 0c 00 ff 00 00 14 1a 00 00 00 a2 60 00 00
> 10: 60 de ad 03 04 05 06 80 08 08 24 60 de 00 23 80
>=20
> I currently have the Peak parallel dongle set to io=3D0x378 irq=3D7 type=
=3Depp.  I set the parallel port bios to EPP mode and IRQ 7.  I tried ECP m=
ode but the xeno_can_peak_dng driver doesn't find the sja1000 unless the bi=
os setting is EPP.  This conflicts with the Peak documentation which states=
 in the FAQ that ECP is the correct setting even though the driver type is =
EPP.  It looks to me like there may be a timing problem in the parallel por=
t register read.
>=20
> --John
>=20
> John D. Charlton
> 	Sr. Development Engineer
>       GATD Electrical Controls
> 	Tyco Electronics Corporation=20
> 	Mail Stop: 161-39
> 	(717) 810-2141=20
> 	(717) 810-2443 FAX
> 	john.charlton@domain.hid
> =20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20
>=20


