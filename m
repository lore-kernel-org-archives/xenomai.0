From: "Charlton, John" <john.charlton@domain.hid>
Date: Wed, 31 Dec 2008 15:49:55 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2003E4CC2AB2@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] CAN support for TS_CAN1 (Technologic Systems)
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

I am testing CAN using a TS_CAN1 PC-104 card on an x86 Nano-7240.  It appea=
rs that none of the existing SJA1000 drivers support this hardware so I cre=
ated a new driver module from rtcan_isa.c and modified it to work with the =
TS_CAN1 hardware.  I am working with linux-2.6.27.7  and xenomai-2.4.6.1 an=
d have added the new source module rtcan_tscan1.c to the ksrc/drivers/can/s=
ja1000 directory. When I rerun prepare-kernel.sh it creates the link for th=
e new module in the linux kernel source tree, but there is no checkbox in t=
he kernel configuration.

How do I add the new module to the kernel configuration options?

--John

