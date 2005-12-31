Message-ID: <43B69CEC.1040606@domain.hid>
Date: Sat, 31 Dec 2005 15:59:56 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0512310437x6e92487es@domain.hid>
In-Reply-To: <b647ffbd0512310437x6e92487es@domain.hid>
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
> Hi everybody,
> 
> I have got a few synch-related problems while adding the code for 
> supporting the rt shared irqs to
> the nucleus layer. But at first let's take a look at some adeos code 
> that, well, possibly has the
> same problem.
> 
> let's say the primary domain is interested in irq = TEST_IRQ.
> 
> CPU 0:
> 
> -  TEST_IRQ occurs.
> 
> -  ipipe_handle_irq()    The local interrupts are off on entry.
> 
>     testbit(IPIPE_HANDLE_FLAG, ipd->irqs[irq].control) shows whether a 
> given domain is interested in handling the irq.
> 
>     Then cpu-local data is mainly used, e.g. cpudata->irq_hits[irq]++ 
> and proper changes of pending_lo/hi
>    
>     ...
>    
> CPU 1:
> 
> -  ... -> rthal_irq_release() ->  ipipe_virtualize_irq(TEST_IRQ, ... 
> handler = NULL, ...)
> 
> -  Here, __ipipe_pipe_lock + interrupts off.
> 
>     o  ipipe_virtualize_irq() drops the IPIPE_HANDLE_FLAG and sets up 
> ipd->irqs[irq].handler to NULL.
>    
>     First observations, at the same time the TEST_IRQ still can be 
> marked as pending
>     (i.e. some_cpudata->irq_pending_lo/hi and irq_hits)!
> 
> CPU 0:
> 
> -  actually, ipipe_handle_irq() now (if not yet done before) may be 
> calling __ipipe_set_irq_bit(ipd,cpuid,irq)
>     but noone is interested in this irq == TEST_IRQ already. But no matter,
>     the fact is that cpudata->irq_* of a given cpu denotes a pending 
> irq, let's go further.
> 
> -  later on, ipipe_sync_stage() is called for a given domain and cpu.
> 
>     It handles all irqs which are marked for the domain and cpu. So it's 
> based only on the check of
>     cpudata->irq_(pending_(hi,lo), hits) fields.
>     Let's recall that TEST_IRQ is marked here as well...
>    
>     In some way (ipipe_call_root_*irq_handler() or directly 
> ipd->irqs[irq].handler()) the isr handler is called
>     and boom! it's NULL.
>    
> 
> Have I missed something that prevents this?
> 

Nope, good spot, that could indeed happen in SMP configs. The code is 
expected to shut the given interrupt source _before_ calling 
rthal_irq_release(). But, the root of the problem is that 
rthal_irq_release() doesn't make sure that all _pending_ IRQs from the 
given kind are synchronized before processing. We need the equivalent of 
Linux's synchronize_irq() here, and I would tend to implement this in 
the Adeos layer directly, in ipipe_virtualize_irq() for the NULL handler 
case, since it's a matter of general consistency.

> -----
> 
> In a sense, the synch. problem I have mentioned at the beginning of this 
> mail reminds this scenario.
> 
> The draft patch is enclosed just to elustrate an idea.
> 
> There are 2 problems:
> 
> 1) we probably don't want to hold any lock while processing the handlers 
> list (xnintr_intr_handler(): for all shirq->handlers).
> 
> Here we may use the approach used by linux in manage.c::free_irq() vs. 
> handle.c::__do_IRQ() that calls handle_IRQ_event() without the 
> desc->lock being locked.
> The magic is in free_irq() : it removes the "action" item from the list 
> but then falls into busy waiting until the IRQ_INPROGRESS flag is 
> removed. And only then it deletes the "action" item.
> At that time, the "action" item is already not on the list but still 
> points to the valid tail of the list so the iteration may be proceeded 
> even if the current item == "deleted" one.
> Blah, just I guess the presupposition here is that the operation of 
> deletion (free_irq():: *pp = action->next) is atomic.
> 
> 2) xnintr_irq_handler() gets a cookie which is == xnshared_irq_t* (see 
> xnintr_attach) that may already be invalid at that time or, and that's a 
> problem, become invalid during the execution of xnintr_irq_handler().
> To prevent that, we could add a flag like IRQ_INPROGRESS but
> 
> either we have to set/remove it on the adeos layer before the control is 
> passed to the xnintr_irq_handler() (to be sure that cookie is not 
> xnfree()'d. xnintr_detach() will do busy waiting)
>

Synchronizing the pending IRQs in ipipe_virtualize_irq() should be done 
by polling the proper irq_pending count (and _not_ the hi/lo bits which 
get cleared before the handler is run). The prerequisite is to call 
ipipe_virtualize_irq() for an unstalled domain, or at least forcibly 
unstalling it there. I would see something along these lines, which is 
already used to drain the pending IRQs before unlinking a domain from 
the pipeline:

spin_unlock_irqrestore_hw(&__ipipe_pipelock, flags);

ipipe_unstall_pipeline_from(ipd);

clear_bit(IPIPE_HANDLE_FLAG, &ipd->irqs[irq].control);
clear_bit(IPIPE_STICKY_FLAG, &ipd->irqs[irq].control);
set_bit(IPIPE_PASS_FLAG, &ipd->irqs[irq].control);
/* or tweak the modemask directly */

for (_cpuid = 0; _cpuid < nr_cpus; _cpuid++)
	while (ipd->cpudata[_cpuid].irq_hits[irq] > 0)
		cpu_relax();

spin_lock_irqsave_hw(&__ipipe_pipelock, flags);

> or we may set/remove the flag in the xnintr_irq_handler() but have to 
> ignore the passed "cookie" and
> get it as cookie =  rthal_irq_cookie(ipd,irq). Mmm, not very gracefully 
> I'd say.

Eeek...

> 
> Ok, it's enough for the New Year's Eve.
> 
> Happy New Year to everybody! I wish you all the best for the New Year :o)
>

Best wishes too!

Cheers,

> 
> -- 
> Best regards,
> Dmitry Adamushko
> 
> 


-- 

Philippe.

