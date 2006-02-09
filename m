Message-ID: <43EB63D7.2080507@domain.hid>
Date: Thu, 09 Feb 2006 16:46:31 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0602070104s63275903q@domain.hid>	
	<43E86F4D.4050400@domain.hid>	
	<43E8DFC4.4010805@domain.hid>
	<43E9CE95.3070806@domain.hid>	 <43EAFD8B.7020400@domain.hid>
	<43EB1279.3040902@domain.hid>	 <43EB1741.9080809@domain.hid>
	<b647ffbd0602090311x56dbc765x@domain.hid>
In-Reply-To: <b647ffbd0602090311x56dbc765x@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] More on Shared interrupts
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

For the last few days, I have tried to figure out a good way to share interrupts 
between RT and non-RT domains. This has included looking through Dmitry's patch, 
correcting bugs and testing what is possible in my specific case. I'll therefore 
try to summarize at least a few of my thoughts.

1. When looking through Dmitry's patch I get the impression that the iack 
handler has very little to do with each interrupt (the test 'prev->iack != 
intr->iack' is a dead giveaway), but is more of a domain-specific function (or 
perhaps even just a placeholder for the hijacked Linux ack-function).


2. Somewhat inspired by the figure in "Life with Adeos", I have identified the 
following cases:

   irq K  | ----------- | ---o    |   // Linux only
   ...
   irq L  | ---o        |         |   // RT-only
   ...
   irq M  | ---o------- | ---o    |   // Shared between domains
   ...
   irq N  | ---o---o--- |         |   // Shared inside single domain
   ...
   irq O  | ---o---o--- | ---o    |   // Shared between and inside single domain

Xenomai currently handles the K & L cases, Dmitrys patch addresses the N case, 
with edge triggered interrupts the M (and O after Dmitry's patch) case(s) might 
be handled by returning RT_INTR_CHAINED | RT_INTR_ENABLE from the interrupt 
handler, for level triggered interrupt the M and O cases can't be handled.

If one looks more closely at the K case (Linux only interrupt), it works by when 
an interrupt occurs, the call to irq_end is postponed until the Linux interrupt 
handler has run, i.e. further interrupts are disabled. This can be seen as a 
lazy version of Philippe's idea of disabling all non-RT interrupts until the 
RT-domain is idle, i.e. the interrupt is disabled only if it indeed occurs.

If this idea should be generalized to the M (and O) case(s), one can't rely on 
postponing the irq_end call (since the interrupt is still needed in the 
RT-domain), but has to rely on some function that disables all non-RT hardware 
that generates interrupts on that irq-line; such a function naturally has to 
have intimate knowledge of all hardware that can generate interrupts in order to 
be able to disable those interrupt sources that are non-RT.

If we then take Jan's observation about the many (Linux-only) interrupts present 
in an ordinary PC and add it to Philippe's idea of disabling all non-RT 
interrupts while executing in the RT-domain, I think that the following is a 
workable (and fairly efficient) way of handling this:

Add hardware dependent enable/disable functions, where the enable is called just 
before normal execution in a domain starts (i.e. when playing back interrupts, 
the disable is still in effect), and disable is called when normal domain 
execution end. This does effectively handle the K case above, with the added 
benefit that NO non-RT interrupts will occur during RT execution.

In the 8259 case, the disable function could look something like:

   domain_irq_disable(uint irqmask) {
     if (irqmask & 0xff00 != 0xff00) {
       irqmask &= ~0x0004; // Cascaded interrupt is still needed
       outb(irqmask >> 8, PIC_SLAVE_IMR);
     }
     outb(irqmask, PIC_MASTER_IMR);
   }

If we should extend this to handle the M (and O) case(s), the disable function 
could look like:

   domain_irq_disable(uint irqmask, shared_irq_t *shared[]) {
     int i;

     for (i = 0 ; i < MAX_IRQ ; i++) {
       if (shared[i]) {
         shared_irq_t *next = shared[i];
         irqmask &= ~(1<<i);
         while (next) {
           next->disable();
	  next = next->next;
         }
       }
     }
     if (irqmask & 0xff00 != 0xff00) {
       irqmask &= ~0x0004; // Cascaded interrupt is still needed
       outb(irqmask >> 8, PIC_SLAVE_IMR);
     }
     outb(irqmask, PIC_MASTER_IMR);
   }

An obvious optimization of the above scheme, is to never call the disable (or 
enable) function for the RT-domain, since there all interrupt processing is 
protected by the hardware.

Comments, anyone?

-- 

Anders


