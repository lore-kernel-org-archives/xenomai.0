From: "Charlton, John" <john.charlton@domain.hid>
Date: Fri, 14 Aug 2009 08:38:15 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE20060F03FD6C@us194mx002.tycoelectronics.net>
References: <CF7FB0793253794F9F45991443E5FE20060EFA3F76@domain.hid>
	<4A840387.9010700@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060F03FA93@domain.hid>
	<4A8518FE.7070103@domain.hid>
In-Reply-To: <4A8518FE.7070103@domain.hid>
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

This question is getting off the initial thread topic, but we are looking f=
or another hardware route to a xenomai compatible CAN interface.  We have a=
n LPC bus.  Do you know of any MSCAN or SJA1000 or other xenomai supported =
devices that have LPC bus interface? We currently don't have any other devi=
ces that require a PCI or ISA bus so if we can do it through the LPC bus th=
at would be the best hardware option instead of using the slower super-I/O =
parallel port dongle interface.  We also don't have an SPI interface.  I wa=
s looking at the MCP2515 but without SPI that seems to be out.

--
John

-----Original Message-----
From: Wolfgang Grandegger [mailto:wg@domain.hid
Sent: Friday, August 14, 2009 3:58 AM
To: Charlton, John
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] FW: Peak parallel port dongle rtcan driver

Charlton, John wrote:
> Wolfgang,
>=20
> Thank you for the information and advice.  We are currently considering t=
his interface in a custom embedded controller design but based on your reco=
mmendations we probably need to reassess that decision. We were intending t=
o use the parallel port through a super io chip on a custom designed board =
but it sounds like we should go with an ISA or PCI bus interface to get rea=
l-time performance at 1mbit baud rate.  Our application requires the full 1=
mbit baudrate continuous for 100msec to 200msec intervals.

FYI, I remember discussions about real-time problems with the PCAN dongle:

  https://mail.gna.org/public/xenomai-help/2007-03/msg00185.html

See also:

  https://mail.gna.org/public/xenomai-help/2007-03/msg00183.html

Can't remember where I got that information from, maybe from PEAK PCAN supp=
ort.

But that user did not have the problems you reported. Maybe it's hardware r=
elated.

Wolfgang.

