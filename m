Message-ID: <47272BD3.7020008@domain.hid>
Date: Tue, 30 Oct 2007 14:04:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <472728EE.8090608@domain.hid>
In-Reply-To: <472728EE.8090608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] irq matter
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

Roland Tollenaar wrote:
> Sorry a slight elaboration is necessary here. I found that the conflict 
> on IRQ 5 (diabling by xenomai) just occurs if a usbtouchscreen device 
> which I am planning to use is plugged in. For the record, there is as 
> yet no driver loaded for the touch screen.
> 
> But is still does not solve the mystery of why there should be a 
> conflict with irq 5 is no usb socket has this irqline.

Please provide your full kernel log from boot-up until the problem occurs.

> 
> Roland
> 
> 
> Hi,
> 
> I have found that if I have the rtnet device on IRQ5 sharing it only the
> the SATA controller that all is fine until
> 
> lsusb -v
> 
> is called. In dmesg we then see:
> 
> xinitr-irq-handler: IRQ5 not handled Disabling IRQ line.
> 
> Firstly, why is this? None of the USB's are on IRQ line 5. Secondly is
> the action "Disabling the IRQ line" not a bit harsh?

The alternative to disabling the line is "bricking" your box, as older
Xenomai used to do. What do you prefer? :)

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

