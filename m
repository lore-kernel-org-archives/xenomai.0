Message-ID: <4426DD07.9040904@domain.hid>
Date: Sun, 26 Mar 2006 20:27:19 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Timer IRQ propagation
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210D6B@EINT11.einet.ad.eivd.ch>
	<FDBBB5CC70676540B3EF7CFE83FD94E004310B@EINT11.einet.ad.eivd.ch>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E004310B@EINT11.einet.ad.eivd.ch>
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
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
> 
> 
> 2-       When a timer IRQ is received, we understood that the IRQ is ack'd and masked by handle_irq()
and sent to the domains through walk_pipeline() including Linux; but we 
have some doubts about that since
  the timer ISR of Linux first acknowledges the interrupt, and it seems 
that it acknowledges physically (hw ack);
  we expected that the acknowledgement would be a virtual ack in the 
Linux domain since the ack has been made
  previously by handle_irq(). In our case (ARM arch), the ack actually 
corresponds to a mask and therefore the
  timer IRQ is masked by Linux once it gets,  and we then suspect some 
loss of timer interrupts.
> 
> have we understood correctly the mechanism? Any idea about this behaviour? Is it normal?
> 
>  
> 
>>Still unclear to me; the ack would be done in the timer ISR; however in the (ARM) patch we have,
ipipe performs a hardware ack; I've seen in the x86 patch that adeos 
makes nothing within __ipipe_ack_system_irq().

Yes, it does actually, it's even its role as a fast acknowledge Adeos 
handler for incoming hw IRQs. It acks the APIC when the APIC support is 
built-in (I should have made the entire routine conditionally compiled 
on CONFIG_X86_LOCAL_APIC actually). Since __ipipe_ack_system_irq() is 
only called for APIC-controlled IRQs, this routine always touches the hw.

  I guess the last behaviour is correct, isn't it?
> 

Looking at Stelian's code in arm/mach-integrator/core.c, I see that 
integrator_timer_interrupt does not acknowledge the timer IRQ, despite 
the misleading comment. It only makes some bookkeeping for TSC emulation 
when some higher domain in the pipeline has stolen the timer (e.g. 
Xenomai). Otherwise, when the Ipipe is compiled in, the regular timer 
tick handler does not touch the hw at all.

The logic is this one for all Adeos ports:

- some code intercepts the hw IRQs before they are passed to the regular 
Linux handlers, and feeds __ipipe_handle_irq() with those.
- __ipipe_handle_irq() calls the fast acknowledge handler for the 
incoming hw IRQ, which ends up being, e.g. __ipipe_ack_system_irq() for 
APIC-controlled IRQs on x86 systems, or __ipipe_ack_timerirq() for the 
timer IRQ in the ARM Integrator/CP port. Some IRQs might need different 
fast ack handlers depending on their respective type.
- IRQs are virtualized, which means that they are marked for delivery in 
the interrupt log, where they might linger for some time before the 
I-pipe is allowed to dispatch them to the proper handler eventually.
- At some point in time, Linux ends up being notified of the IRQ, when 
higher priority domains are done with it (e.g. Xenomai). This means that 
the regular handler gets called, but Adeos ports always disable the 
vanilla acknowledge code from such handlers, so that we always have one 
and only one ack cycle for any given IRQ (i.e. the fast ack one from 
__ipipe_handle_irq).

-- 

Philippe.

