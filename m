Message-ID: <43C0F792.3000300@domain.hid>
Date: Sun, 08 Jan 2006 12:29:22 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0512310437x6e92487es@domain.hid>	
	<43B69CEC.1040606@domain.hid>
	<b647ffbd0601071105p746bf2ebx@domain.hid>
In-Reply-To: <b647ffbd0601071105p746bf2ebx@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH,
	RFC] nucleus:shared irq and possible ipipe problem
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
> 
> On 31/12/05, *Philippe Gerum* <rpm@xenomai.org <mailto:rpm@xenomai.org>> 
> wrote:
> 
>  > ...
> 
>      > 2) xnintr_irq_handler() gets a cookie which is == xnshared_irq_t*
>     (see
>      > xnintr_attach) that may already be invalid at that time or, and
>     that's a
>      > problem, become invalid during the execution of xnintr_irq_handler().
>      > To prevent that, we could add a flag like IRQ_INPROGRESS but
>      >
>      > either we have to set/remove it on the adeos layer before the
>     control is
>      > passed to the xnintr_irq_handler() (to be sure that cookie is not
>      > xnfree()'d. xnintr_detach() will do busy waiting)
>      >
> 
>     Synchronizing the pending IRQs in ipipe_virtualize_irq() should be done
>     by polling the proper irq_pending count (and _not_ the hi/lo bits which
>     get cleared before the handler is run). 
> 
> 
> But irq_pending counter (pending_hits in the recent adeos patch) gets 
> cleared before running the isr handler too.
>

I was referring to __ipipe_lock_irq() which clears the pending bits but 
keeps the irq count intact to emulate a PIC masking for a given interrupt.

> In ipipe_sync_stage() :
> ...
>             if (--cpudata->irq_pending_hits[irq] == 0) {
>                  __clear_bit(rank,
>                          &cpudata->irq_pending_lo[level]);
>                  ipipe_mark_irq_delivery(ipd,irq,cpuid);
>             }
> (*)
> 
> // run the corresponding isr handler
> 
> This code drops the irq_pending_hits to 0 before running the handler.
>

> Doesn't it make the following code wrong ?
> 
>     for (_cpuid = 0; _cpuid < nr_cpus; _cpuid++)
>             while (ipd->cpudata[_cpuid].irq_pending_hits[irq] > 0)
>                     cpu_relax();
> 
> 
> as the handler still can be running / or even about to be run when 
> ipd->cpudata[_cpuid].irq_pending_hits[irq] is already 0.
> 
> We can remove the (*) code at the end of ipipe_sync_stage() so that 
> irq_pending_hits[irq] may become 0 only after the corresponding isr 
> handler has completed.
> 

I don't like the idea of having the interrupt bookkeeping stuff 
incompletely updated while calling a handler that might sleep and/or 
migrate to another CPU.

Another option would be to check for SYNC flag; the syncer sets it 
before entering the dispatch loop.

> At the same time, the irq_pending counter can't be increased anymore 
> since we clear the IPIPE_HANDLE_FLAG before doing the busy waiting in 
> ipipe_unregister_domain() or ipipe_virtualize_irq().
>  
> 
>     --
> 
>     Philippe.
> 
> 
> -- 
> Best regards,
> Dmitry Adamushko
> 


-- 

Philippe.

