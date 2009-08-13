Message-ID: <4A840387.9010700@domain.hid>
Date: Thu, 13 Aug 2009 14:13:59 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE20060EFA3F76@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE20060EFA3F76@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi John,

Charlton, John wrote:
> To follow up on this, I configured the parallel port for standard mode and the xeno_can_peak_dng driver works without error so the problem has to do with the EPP/ECP mode.  I would like to use EPP or ECP for performance.  And as indicated below, the xeno_can_peak_dng driver only recognizes the sja1000 when the bios is set to EPP mode.  Any ideas on how to get it to work in EPP or ECP?

I'm not really familiar with EPP and ECP and the differences. I just
know that this devcie is not really good for production purposes,
especially at 1 MB/s. Also real-time suffers, because device access is
quite slow. The driver is derived from PEAK's PCAN driver. PEAK might be
able to tell you more about the limitations and EPP/ECP problems with
that device.

Wolfgang.

> --John
> 
> -----Original Message-----
> From: Charlton, John 
> Sent: Wednesday, August 05, 2009 10:12 AM
> To: xenomai@xenomai.org
> Subject: Peak parallel port dongle rtcan driver
> 
> I am having some problems with the xeno_can_peak_dng driver with the Peak parallel port CAN dongle.  I am using linux-2.6.27.7 kernel and xenomai-2.4.6.1 on an embedded PC (NANO-7240, ULV Celeron 400 MHz CPU).
> 
> I have done extensive testing using both RAW CAN and CanOpen using CanFestival at 1Mbit baud with a TS-CAN1 PC-104 bus card with no errors.  When I use the Peak parallel port dongle at 1 Mbit or 125Kbit baud I loose packets and get errors.  It is worse receiving packets with rtcanrecv than transmitting with rtcansend.  I can transmit for longer intervals but eventually it fails with an error.  The last error reported is:
> Assertion failed! <linux kernel directory>/drivers/xenomai/can/rtcan_raw.c:rtcan_tx_push:171 dev->tx_socket == 0 This error occurred after 484 successful transmissions with 100msec delay at baudrate=1000000:
> rtcansend rtcan0 --verbose --identifier=0x123 0xde 0xad 3 4 5 6 7 8
> 
> After the transmission failed the I was unable to send any more packets until I reloaded the driver.  The /proc/rtcan/rtcan0/info state goes to warning in this case.
> Receiving using rtcanrecv rtcan0 --verbose --error=0xffff has more errors.  Receiving errors result in corrupt packets but don't cause the CAN bus to quit working or the state to go to warning.  Right after a receive failure
> 
> Device     rtcan0
> Controller SJA1000
> Board      PEAK-Dongle
> Clock-Hz   8000000
> Baudrate   1000000
> Bit-time   brp=1 prop_seg=0 phase_seg1=5 phase_seg2=2 sjw=1 sam=0
> Ctrl-Mode  
> State      active
> TX-Counter 0
> RX-Counter 0
> Errors     0
> Refcount   0
> 
> SJA1000 registers
> 00: 80 00 0c 00 ff 00 00 14 1a 00 00 00 a2 60 00 00
> 10: 60 de ad 03 04 05 06 80 08 08 24 60 de 00 23 80
> 
> I currently have the Peak parallel dongle set to io=0x378 irq=7 type=epp.  I set the parallel port bios to EPP mode and IRQ 7.  I tried ECP mode but the xeno_can_peak_dng driver doesn't find the sja1000 unless the bios setting is EPP.  This conflicts with the Peak documentation which states in the FAQ that ECP is the correct setting even though the driver type is EPP.  It looks to me like there may be a timing problem in the parallel port register read.
> 
> --John
> 
> John D. Charlton
> 	Sr. Development Engineer
>       GATD Electrical Controls
> 	Tyco Electronics Corporation 
> 	Mail Stop: 161-39
> 	(717) 810-2141 
> 	(717) 810-2443 FAX
> 	john.charlton@domain.hid
>  
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 
> 


