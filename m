Content-Type: text/plain; charset="us-ascii"
Date: Fri, 16 Feb 2007 14:08:34 +0100
From: "Steffen Mehlfeld" <S.Mehlfeld@domain.hid>
Message-ID: <20070216130834.323430@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sharing interrupts between several RT pci devices
	and non RT devices
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:

> For the sake of cleanness: XN_xxx flags are for internal use only (skins
> like RTDM do so), you are expected to work with RTDM_IRQTYPE_xxx here.

done so.

> > Another solution would be not to share interrupts between rt and
> non-rt-devices, but i have no clue how to do this, as i'm new to the whole driver
> development thing. As far as i understand, the PCI-BIOS tells each device
> via config-space which irq it has to use. Therefore it's pointless to call
> rtdm_irq_request() with a irq-line other than that from config-space, as it
> uses the irq from config-space anyway. 
> > Is there a way to specify which irq a pci device should use?
> 
> If the physical IRQs end up on the same line physical line, you have
> lost. Then you can only write a special stub driver for your non-RT
> device, that works over RTDM, detects if the event is for that device,
> shuts the IRQ up inside the hardware (there is always some kind of mask
> register), and signals the arrival e.g. via rtdm_nrtsig to the Linux
> handler. When Linux is able to execute its driver, it can analyse the
> IRQ reason and take the measures to finally re-enable IRQs on that
> device again.
> 
> That's of course still slower than an unshared IRQ design, but it is
> deterministic even when you face an unpredictable non-RT IRQ load.

That won't work for me, because the cards are supposed to run on lots of different machines, with lots of different devices and therefore device-drivers that may share the irq-line with this rt-device.

On my development machine, the cards irq-line depends on the presence of other pci-cards, on the used pci-slot and some other parameters i can't figure out (sometimes it's on 9, 10, 11, ...). 

Is there no known way how to influence this (maybe via config-space)?

Anyway, thanks a lot for the useful information (thanks to Dmitry Adamushko also),

Steffen

