Message-ID: <4727234A.2090409@domain.hid>
Date: Tue, 30 Oct 2007 13:27:54 +0100
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

