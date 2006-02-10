Message-ID: <43EC9C5B.4030501@domain.hid>
Date: Fri, 10 Feb 2006 14:59:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0602070104s63275903q@domain.hid>	
	<43E86F4D.4050400@domain.hid>	
	<43E8DFC4.4010805@domain.hid>
	<43E9CE95.3070806@domain.hid>	 <43EAFD8B.7020400@domain.hid>
	<43EB1279.3040902@domain.hid>	 <43EB1741.9080809@domain.hid>
	<b647ffbd0602090311x56dbc765x@domain.hid>
	<43EB63D7.2080507@domain.hid>
In-Reply-To: <43EB63D7.2080507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: More on Shared interrupts
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Anders Blomdell wrote:
> For the last few days, I have tried to figure out a good way to share 
> interrupts between RT and non-RT domains. This has included looking 
> through Dmitry's patch, correcting bugs and testing what is possible in 
> my specific case. I'll therefore try to summarize at least a few of my 
> thoughts.
> 
> 1. When looking through Dmitry's patch I get the impression that the 
> iack handler has very little to do with each interrupt (the test 
> 'prev->iack != intr->iack' is a dead giveaway), but is more of a 
> domain-specific function (or perhaps even just a placeholder for the 
> hijacked Linux ack-function).
> 
> 
> 2. Somewhat inspired by the figure in "Life with Adeos", I have 
> identified the following cases:
> 
>   irq K  | ----------- | ---o    |   // Linux only
>   ...
>   irq L  | ---o        |         |   // RT-only
>   ...
>   irq M  | ---o------- | ---o    |   // Shared between domains
>   ...
>   irq N  | ---o---o--- |         |   // Shared inside single domain
>   ...
>   irq O  | ---o---o--- | ---o    |   // Shared between and inside single 
> domain
> 
> Xenomai currently handles the K & L cases, Dmitrys patch addresses the N 
> case, with edge triggered interrupts the M (and O after Dmitry's patch) 
> case(s) might be handled by returning RT_INTR_CHAINED | RT_INTR_ENABLE 
> 

As you pointed out recently, using this combo for M (and thus O) might also be
unsafe, e.g. causing some implementation to send eoi twice or more (and the second
time while hw IRQs are off and the second IRQ is still pending) if more than a
single domain ends the current interrupt. This said, I've never tried that
actually, but this does seem a bit optimistic to always expect a proper behaviour
in this case (basically, it all depends on what "ending" the interrupt means hw-wise).

 > from the interrupt handler, for level triggered interrupt the M and O
> cases can't be handled.
> 
> If one looks more closely at the K case (Linux only interrupt), it works 
> by when an interrupt occurs, the call to irq_end is postponed until the 
> Linux interrupt handler has run, i.e. further interrupts are disabled. 
> This can be seen as a lazy version of Philippe's idea of disabling all 
> non-RT interrupts until the RT-domain is idle, i.e. the interrupt is 
> disabled only if it indeed occurs.
> 
> If this idea should be generalized to the M (and O) case(s), one can't 
> rely on postponing the irq_end call (since the interrupt is still needed 
> in the RT-domain), but has to rely on some function that disables all 
> non-RT hardware that generates interrupts on that irq-line; such a 
> function naturally has to have intimate knowledge of all hardware that 
> can generate interrupts in order to be able to disable those interrupt 
> sources that are non-RT.
> 
> If we then take Jan's observation about the many (Linux-only) interrupts 
> present in an ordinary PC and add it to Philippe's idea of disabling all 
> non-RT interrupts while executing in the RT-domain, I think that the 
> following is a workable (and fairly efficient) way of handling this:
> 
> Add hardware dependent enable/disable functions, where the enable is 
> called just before normal execution in a domain starts (i.e. when 
> playing back interrupts, the disable is still in effect), and disable is 
> called when normal domain execution end. This does effectively handle 
> the K case above, with the added benefit that NO non-RT interrupts will 
> occur during RT execution.

To do that, I'd suggest that we reuse the xnarch_enter_root/xnarch_leave_root 
hooks the nucleus calls when entering or leaving the Linux domain (i.e. to restart 
the RT activity). Sharing RT and non-RT interrupts are not that much an Adeos 
issue, but rather a Xenomai one, since only the latter knows that it must handle 
real-time constraints, and also knows about the xnintr abstraction we would have 
to use in order to handle the intra-domain shared IRQs.

> 
> In the 8259 case, the disable function could look something like:
> 
>   domain_irq_disable(uint irqmask) {
>     if (irqmask & 0xff00 != 0xff00) {
>       irqmask &= ~0x0004; // Cascaded interrupt is still needed
>       outb(irqmask >> 8, PIC_SLAVE_IMR);
>     }
>     outb(irqmask, PIC_MASTER_IMR);
>   }
> 
> If we should extend this to handle the M (and O) case(s), the disable 
> function could look like:
> 
>   domain_irq_disable(uint irqmask, shared_irq_t *shared[]) {
>     int i;
> 
>     for (i = 0 ; i < MAX_IRQ ; i++) {
>       if (shared[i]) {
>         shared_irq_t *next = shared[i];
>         irqmask &= ~(1<<i);
>         while (next) {
>           next->disable();
>       next = next->next;
>         }
>       }
>     }
>     if (irqmask & 0xff00 != 0xff00) {
>       irqmask &= ~0x0004; // Cascaded interrupt is still needed
>       outb(irqmask >> 8, PIC_SLAVE_IMR);
>     }
>     outb(irqmask, PIC_MASTER_IMR);
>   }
> 
> An obvious optimization of the above scheme, is to never call the 
> disable (or enable) function for the RT-domain, since there all 
> interrupt processing is protected by the hardware.
> 

I'm concerned by the fact that it would cost up to 3-5 us doing so on x86 just for
handling the cascaded PIC + the cost of each per-IRQ disable call fiddling with
the HW once again (maybe also through sluggish i/o port accesses), even more 
during bus saturation, and this intrinsic latency would be added to the fast path, 
before rescheduling a RT task pending for the incoming interrupt, e.g. after some 
idle time in the Linux domain. In the later case, which is the most frequent 
situation, we would not be able to save the disable call for Linux interrupts 
either since we would be switching domains to Xeno's.

I think that we should decouple the hw shield optimization from the RT/non-RT
sharing issue; if the latter one could be solved by the former, the former also
requires to have the appropriate IC hw in order to be efficient. However, we
should be able to deal even with a 8259 for handling the RT/non-RT sharing case.

Sticking with the inter-domain sharing issue and in the light of the process you 
described, I would rather go for using the shared acknowledge handling Adeos 
already provides, for which Xenomai's xnintr abstraction already provides support 
(i.e. xniack_t parameter). In short, both the Xenomai and Linux domains can 
already have their own IRQ acknowledge routine defined for any given interrupt, 
and have them called by priority order over the primary Adeos's handler that 
collects all raw/hw IRQs before loggin them (see the IPIPE_SHARED mode bit).

This way, every domain would have the opportunity to be polled for identifying the 
source of the interrupt and possibly tell the hw to stop spamming in case of 
level-triggered IRQs. This would require the per-domain ack handler to understand 
the logic of the attached devices wrt interrupt handling - maybe by incorporating 
the ack portion of Linux driver's ISR for the initiating device -, but I see no 
difference wrt calling disable routines as you described: those would also have to 
know how to deal with such hw anyway. The problem I see with level-triggered IRQs 
is that by definition, there is no common/generic way of clearing their cause.

This said, what we need for sure is Adeos preventing the regular Linux IRQ 
dispatcher (i.e. __do_IRQS) to end domain-shared IRQs, since we would rightfully 
assume that someone should have already done that early on.

> Comments, anyone?
> 

To sum up, interrupt handling is one of the worst PITA of the Known Universe, 
likely because or as a consequence of which it's one of least well-defined area in 
OS design. As such, I would preferably go for some minimalistic generic support of 
the IRQ sharing corner case (RT/RT and RT/non-RT, including the polarity issue), 
so that we don't adversely affect the regular fast path. For that to happen, we 
might first want to list more precisely the use cases we'd want to support, so 
that we could somewhat simplify the whole equation.

-- 

Philippe.


