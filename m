Message-ID: <487E1BE8.1000306@domain.hid>
Date: Wed, 16 Jul 2008 18:03:52 +0200
From: Benjamin ZORES <benjamin.zores@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Error propagating ISR to Linux domain
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

I've encountered a little problem when trying to propagate an ISR from 
Xenomai to Linux context.

To sum up clearly, I'm writing an RT kernel module that drives a PCI card.
I've registered a nucleus ISR handler on the IRQ attributed to this card.

On some systems, this IRQ is dedicated to this PCI card only.
Though, on others, it is shared with other peripherals.
Hence, I need to forward/propagate this IRQ to Linux domain for other 
drivers to handle it
when the IRQ has not been initiated by my PCI card.

My RT ISR code looks like the following:

int my_isr_handler (xnintr_t *irq)
{
    ... /* handling */
   return XN_ISR_HANDLED | XN_ISR_PROPAGATE;
}

While this code works perfectly when the IRQ number is really shared 
among peripherals,
when I use it on system where this IRQ is dedicated to RT only (i.e. not 
used by Linux),
then, the IRQ is never acknowledged.

In other words, I see a bug when returning XN_ISR_PROPAGATE on a system 
where
no Linux driver has registered a handler for this IRQ.
Is this something known and is there some workaround (I'm using 2.6.23 + 
lastest Adeos + Xenomai 2.4.4 on x86_32) ???

A quick and dirty workaround is to create a dummy Linux IRQ handler 
(doing so acknowledge my propagated IRQ) but:
 - if it returns IRQ_NONE, then Linux discard the IRQ line after having 
missed 100000 of them (on system where the IRQ is dedicated)
 - if it returns IRQ_HANDLED, then I have no guarantee that this dumym 
handler won't get called before the legacy drivers that need it.

Or maybe there is a way in Xenomai to know that any subdomain (like 
Linux) has registered a handler for this given IRQ ??

Any help would be appreciated,

Ben

