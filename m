Message-ID: <43F4A2C5.8080909@domain.hid>
Date: Thu, 16 Feb 2006 17:05:25 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] More on Shared interrupts
References: <b647ffbd0602070104s63275903q@domain.hid>		<43E86F4D.4050400@domain.hid>		<43E8DFC4.4010805@domain.hid>	<43E9CE95.3070806@domain.hid>	
	<43EAFD8B.7020400@domain.hid>	<43EB1279.3040902@domain.hid>	
	<43EB1741.9080809@domain.hid>	<b647ffbd0602090311x56dbc765x@domain.hid>
	<43EB63D7.2080507@domain.hid>
In-Reply-To: <43EB63D7.2080507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

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
> Comments, anyone?

OK, I have finally got around to do some interrupt timing tests on a PrPMC800 
(450 MHz PowerPC/G4)  with the following interrupt sources:

   3: 10 Khz watchdog interrupt (Linux)
  10: 100 Mbit/s ethernet (Linux)
  16: mailbox interrupt (RT) + UART (Linux)

I have measured interrupt latency, task latency (time from interrupt until a 
task signalled from interrupt handler has started) and the semaphore latency 
(time from task semaphore is signalled until task has started).

I have tested 4 different ways of handling shared Linux/RT interrupts:

   1. When UART interrupt occurs, disable further UART interrupts, signal low
      priority UART reenable task, return XN_ISR_ENABLE | XN_ISR_CHAINED.
      In low priority UART reenable task, reenable UART when Linux has handled
      the interrupt.

   2. Disable UART interrupts, and poll them at 1kHz from low priority RT task,
      and rthal_irq_host_pend them as they occur.

   3. Modified Xenomai, where non-RT interrupts are disabled when entering
      the RT domain, and enabled when entering the Linux domain.

   4. Modified Xenomai, where non-RT interrupts are disabled when interrupt
      occurs, and enabled when entering the Linux domain.

In case 3 & 4 interrupts are enabled/disabled with code like:

       if (enable) {
         // Enable Linux interrupts
         SET_HARRIER_XCSR_REG_16(FEMA, 0xc900); // UART
         rthal_irq_enable(3);
         rthal_irq_enable(10);
       } else {
         // Disable Linux interrupts
         SET_HARRIER_XCSR_REG_16(FEMA, 0xcf00); // UART
         rthal_irq_disable(3);
         rthal_irq_disable(10);
       }


The tests has been run with 5 different loads (measuring a 1 kHz mailbox interrupt):

   A. Idle
   B. 10 KHz watchdog
   C. UART @9600 baud (approx 1kHz)
   D. ping -f -l20
   E. compound load (watchdog + UART + ping)

The plots at http://www.control.lth.se/user/andersb/orca/timing_plots.html makes 
me draw the following conclusions (worst case task latency <= worst case 
interrupt latency + worst case semaphore latency, since their simultaneous 
probablity is lower):

   a. On an unloaded system (A), 3 & 4 are slightly worse (2 us), the main
      difference between the two being if the disabling is done before or
      after the mailbox IRQ handler is run.
   b. In all the single load cases (B, C, D) the modified kernels (3, 4) has
      comparable task latency as the unmodified kernels (1, 2), and lower
      interrupt latency and lower semaphore latency.
   c. In the compound load case, the modified kernels shows distinctly improved
      worst case interrupt latencies (15 us instead of 20 us), and the one with
      early disabled interrupts (4) has distinctly better semaphore latency.

Based on the above, I conclude that by disabling all non-RT interrupts early (4) 
timing is improved since the RT domain is hit by a maximum of one non-RT 
interrupt at a time, and on standard PC's with lots of non-RT interrupts the 
benefit would be even bigger. I also believe that the enable/disable code could 
be (somewhat) improved by only taking one write posting delay instead of two 
(these are in code called by rthal_irq_*able).

-- 

Regards

Anders Blomdell


