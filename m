Message-ID: <495C81A9.400@domain.hid>
Date: Thu, 01 Jan 2009 09:41:13 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2003E4CC2AB2@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2003E4CC2AB2@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Charlton, John wrote:
> I am testing CAN using a TS_CAN1 PC-104 card on an x86 Nano-7240.  It appears that none of the existing SJA1000 drivers support this hardware so I created a new driver module from rtcan_isa.c and modified it to work with the TS_CAN1 hardware.  I am working with linux-2.6.27.7  and xenomai-2.4.6.1 and have added the new source module rtcan_tscan1.c to the ksrc/drivers/can/sja1000 directory. When I rerun prepare-kernel.sh it creates the link for the new module in the linux kernel source tree, but there is no checkbox in the kernel configuration.
> 
> How do I add the new module to the kernel configuration options?

You need to add Kconfig options to

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/sja1000/Kconfig

Wolfgang,

