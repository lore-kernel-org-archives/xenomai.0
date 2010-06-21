From: "Charlton, John" <john.charlton@domain.hid>
Date: Mon, 21 Jun 2010 16:04:02 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE200935FF8983@domain.hid>
References: <CF7FB0793253794F9F45991443E5FE200935FF897B@us194mx002.tycoelectronics.net>
	<4C1F9CCC.1050806@domain.hid>
In-Reply-To: <4C1F9CCC.1050806@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_dev_send() does not timeout
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Wolfgang Grandegger' <wg@domain.hid>
Cc: "'xenomai@xenomai.org'" <xenomai@xenomai.org>

Thank you.  I overlooked that one.  That was the problem.=20

-----Original Message-----
From: Wolfgang Grandegger [mailto:wg@domain.hid
Sent: Monday, June 21, 2010 1:10 PM
To: Charlton, John
Cc: 'xenomai@xenomai.org'
Subject: Re: [Xenomai-help] rt_dev_send() does not timeout

On 06/21/2010 04:52 PM, Charlton, John wrote:
> We are experiencing a problem with the user mode CanFestival library when=
 it calls rt_dev_send() when the CAN bus is disconnected.  In that case the=
 rtcan driver info is:
>=20
> root@domain.hid:~# cat /proc/rtcan/rtcan0/info
> Device     rtcan0
> Controller SJA1000
> Board      PEAK-PCI
> Clock-Hz   8000000
> Baudrate   1000000
> Bit-time   brp=3D1 prop_seg=3D0 phase_seg1=3D5 phase_seg2=3D2 sjw=3D1 sam=
=3D0
> Ctrl-Mode
> State      passive
> TX-Counter 1
> RX-Counter 0
> Errors     2
> Refcount   3
> root@domain.hid:~#
>=20
> The rt_dev_send() function hangs and does not timeout or return an error =
and never returns. We are using Xenomai 2.5.2 with linux 2.6.32.7.

It's the normal behaviour if you have not set RTCAN_RTIOC_SND_TIMEOUT and d=
on't use non-blocking mode. Is that the case?

Wolfgang.

