Message-ID: <49ED9792.8010304@domain.hid>
Date: Tue, 21 Apr 2009 11:53:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <d6c8ef150904101628r60c02baal3568b2ece287ce1f@domain.hid>	
	<49E0F949.5040900@domain.hid>	
	<d6c8ef150904151613j39f43928xd1a25f37184ad30b@domain.hid>	
	<d6c8ef150904151626r5c36df10yb9f8e93ea59640df@domain.hid>	
	<49E67198.3080801@domain.hid>	
	<d6c8ef150904200424g5691b220l1cea34d9268f747d@domain.hid>	
	<49ECBC46.3020601@domain.hid>
	<d6c8ef150904201621md0fd3dcq329207f0d235aac8@domain.hid>
In-Reply-To: <d6c8ef150904201621md0fd3dcq329207f0d235aac8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Intel EP80579 support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Bosko Radivojevic wrote:
> Hi Gilles,
> 
> thank you for your answers. I'm doing pretty much the same thing as I
> did on ARM platform - I'm using one of GPIO pins as Interrupt source.
> On ARM platform I was using one of the GPIO pins as IRQ 110, also
> without having it in /proc/interrupts.
> 
> Intel provides API (accessible through ioctl()) which I use to set
> GPIO pin (#25 in my case) in input mode and, as manual says, it can be
> used as Interrupt source (for #25 it says IRQ 38).
> 
> Sincerely,
> Bosko

The difference between ARM and x86 is that on ARM, all irqs are created
when the board support is initialized. From what I understand, on x86,
irqs are created when requested. Which is why for instance, you see that
PCI irqs are only routed when the PCI device is requested by a driver.
So, for the IRQ 38 to exist, you probably need to request it as if you
were going to use it on Linux side, then you may request it on Xenomai side.

-- 
                                                 Gilles.

