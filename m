Message-ID: <496B7B34.9030405@domain.hid>
Date: Mon, 12 Jan 2009 18:17:40 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>	<200901071828.31323.Sebastian.Smolorz@domain.hid>	<CF7FB0793253794F9F45991443E5FE2003E4BAC0C0@domain.hid>	<4965D651.5010808@domain.hid>	<CF7FB0793253794F9F45991443E5FE2003E4EFB9BA@us194mx002.tycoelectronics.net>
	<CF7FB0793253794F9F45991443E5FE2004DF784062@domain.hid>
	<496B6B66.7070905@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2004DF7840E1@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2004DF7840E1@domain.hid>
Content-Type: text/plain; charset=us-ascii
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
> Wolfgang,
> 
> Thank you for the help.  I do have XENO_DRIVERS_CAN_DEBUG enabled and the registers are:
> 
> root@domain.hid:~$ cat /proc/rtcan/rtcan1/registers
> SJA1000 registers
> 00: 00 00 0c 02 ff 00 03 1c 1a 00 00 00 00 60 00 00
> 10: 08 00 20 01 02 03 04 05 06 07 08 ff 20 00 00 c8
> root@domain.hid:~$ cat /proc/rtcan/rtcan0/registers
> SJA1000 registers
> 00: 00 00 0d 01 ff 00 03 1c 1a 00 00 00 00 60 00 00
> 10: 08 00 20 01 02 03 04 05 06 07 08 bf 00 01 00 c8
> root@domain.hid:~$

Looks like the data have been received by the rtcan0 chip. Then most
likely there are problems with the interrupts.

> I will focus on the transmitter and try another CAN device or CAN analyzer as you suggest.

I see that the TSCAN1 Lincan driver also writes 0 to offset 4:

  outb(0x0, TSCAN1_BASE_ADDR + idx * 8 + 4);
  outb(0x60 + idx, TSCAN1_BASE_ADDR + idx * 8 + 5); // set base I/O address in
                                                    // control reg

Maybe it already makes a difference?

Wolfgang.

