Content-Type: text/plain; charset="us-ascii"
Date: Fri, 16 Feb 2007 09:19:32 +0100
From: "Steffen Mehlfeld" <S.Mehlfeld@domain.hid>
Message-ID: <20070216081932.323430@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Sharing interrupts between several RT pci devices
	and non RT devices
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

Hi,

I'm trying to run several pci cards in rt mode. Therefore I call rtdm_irq_request() with the flags XN_ISR_SHARED | XN_ISR_EDGE. 

In the ISR I check the interrupt status register of the pci-card. If the irq was caused by that card, i handle it and return RTDM_IRQ_HANDLED. If not, I return XN_ISR_NONE, which I understand means 'not my interrupt, try the next registered ISR'.

This works fine as long as my pci-cards have their own interrupt line. But when the PCI-BIOS let them share the interrupt line with something like the ethernet-card (which runs in non-rt mode) the problems starts. Of course the ethernet-card gets no more interrupts and stops working.

To solve this I'd have to propagate the irq to the linux domain, when i figure out that the irq wasn't called by one of my cards (i can detect this with global flags in the kernel module).
But as soon as i start returning XN_ISR_PROPAGATE from the isr, i get the message "Xenomai: xnintr_edge_shirq_handler(): failed to get the IRQ9 line free.", which i think doesn't mean, that all is going well. 

The api documentation tells not to return XN_ISR_PROPAGATE if you share irqs amongst rt devices, which i think is reasonable if you don't know, wether all rt-devices already checked their ir-flags. 
But isn't there a way to propagate the irq to linux, if i'm sure that it belongs there?

Another solution would be not to share interrupts between rt and non-rt-devices, but i have no clue how to do this, as i'm new to the whole driver development thing. As far as i understand, the PCI-BIOS tells each device via config-space which irq it has to use. Therefore it's pointless to call rtdm_irq_request() with a irq-line other than that from config-space, as it uses the irq from config-space anyway. 
Is there a way to specify which irq a pci device should use?


Btw, I'm using kernel 2.6.19.1 on a x86 machine with xenomai 2.4-devel.

With kind regards,
Steffen Mehlfeld

