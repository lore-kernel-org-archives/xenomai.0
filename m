Message-ID: <4965D651.5010808@domain.hid>
Date: Thu, 08 Jan 2009 11:32:49 +0100
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>	<200901071828.31323.Sebastian.Smolorz@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2003E4BAC0C0@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2003E4BAC0C0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtcanconfig rtcansend rtcanrecv
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
> I am attaching rtcan_tscan1.zip (and the ts-can1-manual.pdf) which
> contains the added rtcan_tscan1.c and Kconfig and Makefile modifications
> I made. It is possible that there is something in my kernel module that
> is causing the problem.  I copied the rtcan_isa.c module and changed the
> names for the tscan1 device.  The TS-CAN1 PC-104 has jumper selectable
> configuration registers and IRQ.  The first TS-CAN1 is at the default
> open jumper setting which is IO address 0x150 to 0x157 and IRQ5 (both
> JP4 and JP5).  The second TS-CAN1 is at 0x158 to 0x15F and IRQ7 (only JP5).

Without digging too deep into the special properties of your CAN 
hardware and your source code modifications: It seems to me that your 
CAN controller has two distinct IO regions whereas rtcan_isa assumes 
that there is one IO region of 32 bytes which belongs to the SJA1000. 
What are the two regions of your hardware for especially, the one with 
only 8 bytes? You should check whether you access those SJA1000 
registers correctly. A look into rtcan_sja1000_regs.h may help you.

However, as Wolfgang already suggested, there is at least one driver 
available for plain Linux which should work with your CAN controller. If 
you tested this driver successfully you could take a look into its 
source to get further hints for your Xenomai driver.

-- 
Sebastian

