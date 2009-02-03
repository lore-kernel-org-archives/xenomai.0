Message-ID: <49885254.9070007@domain.hid>
Date: Tue, 03 Feb 2009 15:19:00 +0100
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>	<200901071828.31323.Sebastian.Smolorz@domain.hid>	<CF7FB0793253794F9F45991443E5FE2003E4BAC0C0@domain.hid>	<4965D651.5010808@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2003E4EFB9BA@us194mx002.tycoelectronics.net>
	<496605F2.1080306@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2004E3E954FF@us194mx002.tycoelectronics.net>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2004E3E954FF@us194mx002.tycoelectronics.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Cc: Oliver Hartkopp <socketcan@domain.hid>, "socketcan-users@domain.hid" <socketcan-users@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Charlton, John wrote:
> Thank you for the tip.  I need to add the socketcan drivers to my linux kernel.
> I have linux-2.6.27.7 currently patched for xenomai-2.4.6.1 to which I added a
> rtcan_tscan1.c module to support the TS_CAN1 interface I am using.
> It looks like the rtcan modules only support CAN_RAW frames and I would like
> to use your IP point to point tunnel and other utils so I can send IP packets
> over the CAN interface for performance testing.

The isotp tools Oliver mentioned are for SocketCAN. They do not work for 
RT-Socket-CAN shipped with Xenomai. So either you have to switch to 
SocketCAN or someone has to port ISO-TP over RT-Socket-CAN.

-- 
Sebastian

