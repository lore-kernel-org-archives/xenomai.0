Message-ID: <496BA87C.2020306@domain.hid>
Date: Mon, 12 Jan 2009 21:30:52 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>
	<496B6B66.7070905@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2004DF7840E1@domain.hid>
	<200901121810.42126.Sebastian.Smolorz@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2004DF7841B2@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2004DF7841B2@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "socketcan-users@domain.hid" <socketcan-users@domain.hid>

Charlton, John wrote:
> I agree that rtcan1 transmit interrupt request is set as is rtcan0 receive request in sja1000 base + 3, but I notice that neither interrupt is enabled in the control register (offset 0).  I think the command register should be 0x06 so that TIE and RIE interrupt enable bits are set.  I am relying on the xeno_can_sja1000 module to set the interrupt enable bits since the xeno_can_tscan1 module should just provide access to the sja1000 registers.  I don't think the xeno_can_tscan1 should program any of the sja1000 registers itself--is that assumption correct?  I am specifying the correct interrupts which are jumper selected to be 5 and 7 for rtcan0 and rtcan1 respectively.  The jumper settings can be checked using the TS-CAN1 base + 6 to but the driver doesn't do that yet.

The interrupt enable register (IER) is at offset 0x4 and they are all
enabled (see below). The transfer from rtcan1 to rtcan0 went fine. Just
no interrupts are triggered. And yes, the SJA100 does all relevant
accesses to the SJA1000 chips. Some more questions:

- What do your read at offset 0x6 (JMP)?
- What does /proc/interrupts return?
- Do you see any RTCAN related messages with "$ dmesg".

Wolfgang



