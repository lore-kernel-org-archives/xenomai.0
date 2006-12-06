From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <457686F3.1080008@domain.hid>
References: <457686F3.1080008@domain.hid>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 12:40:38 +0100
Message-Id: <1165405238.7218.102.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: How to hook genirq best
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

On Wed, 2006-12-06 at 10:01 +0100, Jan Kiszka wrote:
> Hi all,

> I had a look at the related part in 2.6.19-i386-1.6-01 meanwhile, and
> there seems to be a concise pattern for the irq_chip changes:
> 
> .ipipe_ack = (.mask_ack) ? .mask_ack : .ack;
> .ipipe_eoi = .eoi;
> 

The complete pattern is:

.ipipe_ack = .mask_ack | .ack
.ipipe_eoi = .eoi
.mask_ack | .ack = nop

Then, target routines from the addressed IRQ chip controllers have to be
ironed with hw interrupt masking for spinlock control.

> I agree with Wolfgang, these changes indeed require a lot of patching
> already on x86 because often two versions of the irq_chip definition
> have to be provided (and there is the risk to miss one as it currently
> seems to be the case in visws_apic.c).

The Colbalt PIIx4 has not been patched on purpose: it deals with a
master multiplexed interrupt which feeds a number of virtual IRQs
downward. Problem is that this scheme requires a specific I-pipe
handling (like we added for ARM) to act as the demux, and which is not
available yet for x86. So better not patch than patching erroneously or
incompletely; it's the principle of least surprise: Cobalt+PIIx4 is not
usable yet with the I-pipe, and one would know it immediately.

Finding the appropriate spots for patching the descriptors is basically
a matter of grepping 'struct irq_chip' in the arch-dep section. It's
manageable.

> 
> I must confess that I do not see the advantage of the approach to patch
> the irq_chip definitions directly. Rather, one of the following ways
> should scale better over a large number of irq_chips:
> 
> A) Perform patching during runtime when I-pipe is taking over the IRQs.
> Should be a trivial loop over all IRQ descriptors. Either overwrite the
> existing irq_chips (i.e. like sketched above) or provide new pseudo
> irq_chip structures to Linux.

This approach - which used to be the one followed with legacy Adeos
patches - was the source of major dysfunctioning at boot time on x86,
particularly with PCI irq routing on APIC-enabled systems. Same with MSI
stuff. It still works fine on ppc (and likely ARM) though. This said, at
that time, we used to shuffle the IDT contents too, so maybe it's time
to have a second look.

> 
> B) Patch the users of chip->ack/eoi/mask_ack or whatever. Given that
> this should basically be confined to kernel/irq/chip.c,

This was the implementation of the draft patch I sent. It's ok, as soon
as you can rely on the above assumption. That's the whole point.

>  it looks
> manageable too and would also avoid any useless runtime checks for NULL
> handlers
>  or even calling void functions.
> 

AFAIC, this is something which is perfectly acceptable for platforms
that require/need it. This is the purpose of decoupling Adeos ports:
allow each arch to implement the best approach. Blackfin, x86, ia64 have
few PICs, so patching the irq_chip descriptor is more elegant than
fiddling with the generic IRQ flow control (/me think), basically
because this is a per-arch, per-PIC logic. ARM, and ppc's would likely
prefer the other approach due to the huge number of PIC variants.

The other important issue is that patching the call sites does not
preclude from analysing each and every PIC control routine, for ironing
them. When the number of PICs is small enough, it's clearly safer to
have all changes at one location (i.e. the PIC management file). At
least, you know what has been adapted; but it's (only) a matter of
(maintainer's) taste.

> 
> Another topic is how to deal with pending IRQs. I haven't looked through
> all cases yet, but already the fasteoi one seems to differ in I-pipe
> when comparing to a similar situation in -rt: threaded IRQs. -rt ends
> (eoi) and masks such IRQs that are about to be deferred to thread
> context, I-pipe only ends them.

--- arch/i386/kernel/ipipe.c~	2006-12-03 18:12:59.000000000 +0100
+++ arch/i386/kernel/ipipe.c	2006-12-06 12:36:21.000000000 +0100
@@ -167,10 +167,12 @@
 static int __ipipe_ack_irq(unsigned irq)
 {
 	irq_desc_t *desc = irq_desc + irq;
+
+	desc->chip->ipipe_ack(irq);
+
 	if (desc->handle_irq == &handle_fasteoi_irq)
 		desc->chip->ipipe_eoi(irq);
-	else
-		desc->chip->ipipe_ack(irq);
+
 	return 1;
 }
 
This is not relevant to the way we hook genirq though; we need to handle
this in the primary I-pipe handler anyway.

>  Generally, the question remains for me
> if at least IRQs arriving to a stalled I-pipe domain should always be
> masked on ack and unmask when being replayed.

What particular (problematic) case do you have in mind regarding this?

> 
> Jan
> 
-- 
Philippe.



