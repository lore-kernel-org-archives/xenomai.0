Message-ID: <4964F242.3020908@domain.hid>
Date: Wed, 07 Jan 2009 19:19:46 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
> I added a kernel module to the xenomai ksrc/drivers/xenomai/can/sja1000.  It builds and installs with make modules_install for linux-2.6.27.7 and xenomai-2.4.6.1.  I am using OpenEmbedded on an i686 NANO-7240 single board computer.  I load the kernal modules and start for two TS_CAN1 CAN boards with the following commands:
> 
> insmod xeno_can_sja1000.ko
> insmod xeno_can_tscan1.ko io=0x100,0x120 irq=5,7
> rtcanconfig rtcan0 --baudrate=125000 start
> rtcanconfig rtcan1 --baudrate=125000 start
> 
> /proc/rtcan/rtcan0/info:
> Device     rtcan0
> Controller SJA1000
> Board      TSCAN1-Board
> Clock-Hz   8000000
> Baudrate   125000
> Bit-time   brp=4 prop_seg=0 phase_seg1=13 phase_seg2=2 sjw=1 sam=0
> Ctrl-Mode
> State      active
> TX-Counter 0
> RX-Counter 0
> Errors     0
> Refcount   0
> 
> /proc/rtcan/rtcan1/info:
> Device     rtcan1
> Controller SJA1000
> Board      TSCAN1-Board
> Clock-Hz   8000000
> Baudrate   125000
> Bit-time   brp=4 prop_seg=0 phase_seg1=13 phase_seg2=2 sjw=1 sam=0
> Ctrl-Mode
> State      active
> TX-Counter 0
> RX-Counter 0
> Errors     0
> Refcount   0
> 
> In one terminal I receive from rtcan0 as follows:
> rtcanrecv rtcan0 --verbose
> interface rtcan0
> s=0, ifr_name=rtcan0
> 
> In a second terminal I send to rtcan1 as follows:
> rtcansend rtcan1 --verbose --identifier=0x123 0xde 0xad
> interface rtcan1
> s=1, ifr_name=rtcan1
> <0x123> [2] de ad
> Cleaning up...
> 
> Nothing happens on the rtcanrecv side--it remains blocked.  If I send a second time the rtcansend side blocks after the s=1, ifr_name=rtcan1 is displayed.

This is a clear indication that the message did not get out to the wire.
What does "/proc/rtcan/rtcan[01}/info" display after you sent the
message? Also check "/proc/xenomai/irq" and use "rtcanrecv -e 0xffff" to
receive error messages as well.

Wolfgang.

