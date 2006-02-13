Message-ID: <43F03A1F.3040206@domain.hid>
Date: Mon, 13 Feb 2006 08:49:51 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0602070104s63275903q@domain.hid>	
	<43E86F4D.4050400@domain.hid>	
	<43E8DFC4.4010805@domain.hid>
	<43E9CE95.3070806@domain.hid>	 <43EAFD8B.7020400@domain.hid>
	<43EB1279.3040902@domain.hid>	 <43EB1741.9080809@domain.hid>	
	<b647ffbd0602090311x56dbc765x@domain.hid>	
	<43EB63D7.2080507@domain.hid> <43EC9C5B.4030501@domain.hid>
	<b647ffbd0602110335u58e2d4cek@domain.hid>
In-Reply-To: <b647ffbd0602110335u58e2d4cek@domain.hid>
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
>  > >
>  > >   irq K  | ----------- | ---o    |   // Linux only
>  > >   ...
>  > >   irq L  | ---o        |         |   // RT-only
>  > >   ...
>  > >   irq M  | ---o------- | ---o    |   // Shared between domains
>  > >   ...
>  > >   irq N  | ---o---o--- |         |   // Shared inside single domain
>  > >   ...
>  > >   irq O  | ---o---o--- | ---o    |   // Shared between and inside 
> single
>  > > domain
>  > >
>  > > Xenomai currently handles the K & L cases, Dmitrys patch addresses 
> the N
>  > > case, with edge triggered interrupts the M (and O after Dmitry's patch)
>  > > case(s) might be handled by returning RT_INTR_CHAINED | RT_INTR_ENABLE
>  > >
>  >
>  > As you pointed out recently, using this combo for M (and thus O) 
> might also be
>  > unsafe, e.g. causing some implementation to send eoi twice or more 
> (and the second
>  > time while hw IRQs are off and the second IRQ is still pending) if 
> more than a
>  > single domain ends the current interrupt. This said, I've never tried 
> that
>  > actually, but this does seem a bit optimistic to always expect a 
> proper behaviour
>  > in this case (basically, it all depends on what "ending" the 
> interrupt means hw-wise).
> 
> 
> Just to be sure I've got the things more or less clear. I feel there are 
> some holes in my understanding of the irq handling stuff, mainly hw-wise.
> 
> x86 + i8259A.
> 
> In this case, .end handler does nothing more than enabling the IRQ line.
> The "eoi" is sent in .ack right after disabling the IRQ line.
> 
> Let's suppose we have the "M" case ("O" makes no difference here).
> 
> When the ISR handler in Linux domain gets control :
> 
> - the IRQ line is ON (it was already .end-ed in the primary domain in case
>   of XN_ISR_ENABLE | XN_ISR_CHAINED ).
> 
> ===
>   Actually, it's possible to set IPIPE_PASS flag for
>   the primary_domain.irqs[THIS_IRQ].control
>   when THIS_IRQ is shared across domains. This way, there is no need
>   to call propagate_irq() in xnintr_irq_handler(). Ok, it's not
>   that important so far.
> ===
> 
>   This is not how it happens when the IRQ is only handled in the
>   Linux domain. But the ISR is still serialized (need not to be
>   reentrant) because do_IRQ() takes care of it (by means
>   of RUNNING and PENDING flags).
> 
> So, I suppose, it's possible to use XN_ISR_ENABLE | XN_ISR_CHAINED in that
> case?
Yes, but only if you disable interrupts from the Linux device (i.e. via its 
control registers, not via the APIC), otherwise the RT-handler will spin since 
the interrupt will never get deasserted. Then you are faced with finding some 
place to reenble those interrupts right after the Linux interrupts-handler has run.

> 
> In case of a pure Linux :
> 
> SMP : I/O APIC + local APICs. As I know, enabling/disabling
> the IRQ line occurs (normally?) on per-local APIC basis. This said, when
> the ISR is running on CPU_0 with the IRQ line disabled, nothing prevents
> (probably, if the IRQ also was .ack-ed by that time?) the same IRQ from
> being signaled on another CPU (even on a few).
> In that case, it gets marked as PENDING and do_IRQ() on CPU_0 will run
> handler_IRQ_events() - ISR handlers - once more.
> 
> Since PENDING is only a flag (not a counter), the fact that the IRQ was 
> signaled
> is not lost but Linux can't know how much time it was signaled.
> I guess, it's not true for devices that e.g. do not rise a new interrupt 
> until
> the ISR handler does some special acknowledgement device-wise.
Since my knowledge of interrupts in SMPs is essentially nil, I'll have to pass 
on this one...


-- 
Best regards

Anders Blomdell

