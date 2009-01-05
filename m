From: "Charlton, John" <john.charlton@domain.hid>
Date: Mon, 5 Jan 2009 10:53:24 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2003E4BAB509@domain.hid>
References: <CF7FB0793253794F9F45991443E5FE2003E4CC2AB2@domain.hid>
	<495C81A9.400@domain.hid>
In-Reply-To: <495C81A9.400@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN support for TS_CAN1 (Technologic Systems)
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

Thank you.  That got it into the linux kernel config. I also had to edit th=
e xenomai Makefile in ksrc/drivers/can/sja1000 to get the new module to bui=
ld and install.

--John

-----Original Message-----
From: Wolfgang Grandegger [mailto:wg@domain.hid]
Sent: Thursday, January 01, 2009 3:41 AM
To: Charlton, John
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] CAN support for TS_CAN1 (Technologic Systems)

Charlton, John wrote:
> I am testing CAN using a TS_CAN1 PC-104 card on an x86 Nano-7240.  It app=
ears that none of the existing SJA1000 drivers support this hardware so I c=
reated a new driver module from rtcan_isa.c and modified it to work with th=
e TS_CAN1 hardware.  I am working with linux-2.6.27.7  and xenomai-2.4.6.1 =
and have added the new source module rtcan_tscan1.c to the ksrc/drivers/can=
/sja1000 directory. When I rerun prepare-kernel.sh it creates the link for =
the new module in the linux kernel source tree, but there is no checkbox in=
 the kernel configuration.
>
> How do I add the new module to the kernel configuration options?

You need to add Kconfig options to

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/sja1000/=
Kconfig

Wolfgang,

