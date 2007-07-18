Message-ID: <2ff1a98a0707180135q24ab6515kf573215edf0aaafa@domain.hid>
Date: Wed, 18 Jul 2007 10:35:34 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2862c2c80707180036t6e64ccban83924d445d80f9c0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707160301i786f94abn6ca72ac76b1b1631@domain.hid>
	<2862c2c80707160352n26db7ac2sddee9a6e6e7dd9c8@domain.hid>
	<2862c2c80707170210s437674f6ua7283d3e03e97a1b@domain.hid>
	<2ff1a98a0707170300o5d36e9f9i96b5a11fb4c7a87e@domain.hid>
	<2862c2c80707170336t45ad3266pc5b5f7769623a900@domain.hid>
	<2ff1a98a0707170609u5da092a1nf32d4789b579717@domain.hid>
	<2862c2c80707172257x5f41d8c4p5df5282be4ba98a2@domain.hid>
	<18077.48173.286511.400122@domain.hid>
	<2862c2c80707180036t6e64ccban83924d445d80f9c0@domain.hid>
Subject: Re: [Xenomai-help] Enable I-PIPE - kernel boot hangs in the
	AT91RM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

On 7/18/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> Dear Gilles,
>
> I think that the interrupt is shared for supporting up to 4 UARTs (ttyS0 --
> S3) available in the system.

No, from reading arch/arm/mach-at91rm9200/at92rm9200_devices.c
uart DBGU uses irq AT91_ID_SYS i.e. 1
uart 0 uses irq AT91RM9200_ID_US0 i.e. 6
uart 1 uses irq AT91RM9200_ID_US1 i.e. 7
uart 2 uses irq AT91RM9200_ID_US2 i.e. 8
uart 3 uses irq AT91RM9200_ID_US3 i.e. 9

>
> Whenever the request_irq for ttyS0 is invoked, the system will go to
> atmel_interrupt and loop. There is no change for other ports, such as ttyS1
> ... to even register their interrupts.
>
> Who else generates the interrupt? Any idea?

First, try to know which uart ttyS0 is using (for instance, by
printing port->irq before the request_irq which causes the problem).
Then read the AT91 datasheet to know who else generates the same
interrupt. Look in the kernel source if there is a driver for this
other peripheral, if yes, then enable it in kernel configuration, if
no, then write a small interrupt handler which acknowledges this other
interrupt. On the AT91, the way to acknowledge an interrupt is usually
to read a status register somewhere.

Note that if ttyS0 is using the DBGU uart, the interrupt is
AT91_ID_SYS, which is probably used by a lot of drivers.

P.S: please do not forget to cc the mailing list.

-- 
                                               Gilles Chanteperdrix

