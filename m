Message-ID: <472728EE.8090608@domain.hid>
Date: Tue, 30 Oct 2007 13:51:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] irq matter
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Sorry a slight elaboration is necessary here. I found that the conflict 
on IRQ 5 (diabling by xenomai) just occurs if a usbtouchscreen device 
which I am planning to use is plugged in. For the record, there is as 
yet no driver loaded for the touch screen.

But is still does not solve the mystery of why there should be a 
conflict with irq 5 is no usb socket has this irqline.

Roland


Hi,

I have found that if I have the rtnet device on IRQ5 sharing it only the
the SATA controller that all is fine until

lsusb -v

is called. In dmesg we then see:

xinitr-irq-handler: IRQ5 not handled Disabling IRQ line.

Firstly, why is this? None of the USB's are on IRQ line 5. Secondly is
the action "Disabling the IRQ line" not a bit harsh?

Regards,

Roland


