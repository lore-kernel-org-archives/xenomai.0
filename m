Message-ID: <4ED38714.2000207@domain.hid>
Date: Mon, 28 Nov 2011 14:05:24 +0100
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Fasteoi unmasking issue
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, Philippe Gerum <rpm@xenomai.org>, "Hillier, Gernot" <gernot.hillier@domain.hid>

Dear all,

we are facing some difficulties with GSI interrupt storms
originating from a PCI card that seem to be caused by
ipipe: The card is passed through to qemu-kvm (the setup
is based on the patches sent by Jan some time ago). Once
the card becomes active, we are hit by a tremendous amount
of interrupts (> 100000/s) that keep ipipe fully occupied.
The observed pattern is (excerpt from the ipipe tracer)

:| common_interrupt+0x20 (__ipipe_spin_unlock_irqrestore+0x62)
:| __ipipe_handle_irq+0x11 (common_interrupt+0x27)
(...)
:  handle_irq+0x9 (do_IRQ+0x66)
:  irq_to_desc+0x4 (handle_irq+0x15)
:  handle_fasteoi_irq+0x14 (handle_irq+0x22)
(...)
:  unmask_ioapic_irq+0x4 (handle_fasteoi_irq+0x94)
:  unmask_ioapic+0xd (unmask_ioapic_irq+0x14)
:  __ipipe_spin_lock_irqsave+0x7 (unmask_ioapic+0x23)
:| __ipipe_spin_lock_irqsave+0x93 (unmask_ioapic+0x23)
:| __io_apic_modify_irq+0x4 (unmask_ioapic+0x41)
:| __ipipe_unlock_irq+0x11 (unmask_ioapic+0x66)
:| __ipipe_spin_unlock_irqrestore+0x9 (unmask_ioapic+0x75)
:| __ipipe_spin_unlock_irqrestore+0x60 (unmask_ioapic+0x75)
:| common_interrupt+0x20 (__ipipe_spin_unlock_irqrestore+0x62)

That is, as soon as the IRQ in question is unmasked, the
next one is immediately received, and the interrupt handler
in non-RT context never gets a chance to actually service
the interrupt.

The problem seems to be caused by unmasking the IRQ in
handle_fasteoi_irq(), and with a hack along the lines of

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -586,7 +586,8 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc
*desc)
        raw_spin_lock(&desc->lock);
        desc->status &= ~IRQ_INPROGRESS;
 #ifdef CONFIG_IPIPE
-       desc->irq_data.chip->irq_unmask(&desc->irq_data);
+       if (irq != WHICHEVER_IRQ_CAUSES_THE_STORM)
+               desc->irq_data.chip->irq_unmask(&desc->irq_data);
 out:
 #else
 out:

the issue is solved.

So the question is: Why is it okay to unconditionally unmask
all interrupts in the fasteoi handler? All cards that re-send
interrupts at high frequencies unless they are properly handled
by their device driver should cause the same problem.
I take the early unmasking is an optimisation, or are there any
further reasons for the unconditional unmasking in
handle_fasteoi_irq()?

Thanks & best regards, Wolfgang

--
Siemens AG, Open Source Platforms,
Corporate Competence Centre Embedded Linux


