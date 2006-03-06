Message-ID: <440C1C41.5090304@domain.hid>
Date: Mon, 06 Mar 2006 12:25:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC, Experimental Patch] nested irq disable calls
References: <b647ffbd0603030252h5f54c436l@domain.hid>
In-Reply-To: <b647ffbd0603030252h5f54c436l@domain.hid>
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
> Hi there,
> 
> the following patches illustrate _experimental_ implementation of nested 
> irq disable calls.
> This new feature would allow us to have scalar return values of ISR and 
> avoid the need
> for NOENABLE bit.
> 
> [ Ok, repeating myself one more time... we would have NONE, HANDLED, 
> PROPAGATE and it would be possible
> to call xnintr_disable_nosync()/even xnintr_disable() from the ISR to 
> defer the IRQ line
> enabling. ]
> 
> The pre-requirement : implement as much code as possible on the Xeno 
> layer with zero or
> minimal changes on the ipipe layer (at least, they should not be 
> intrusive and difficult to maintain for
> different archs).
> 
> 
> 2 main issues which are quite arguable when it comes to possible 
> implementations :
> 
> 1) we need to store the "depth" counter and IRQ_DISABLED bit somewhere 
> (actually, this bit is not that necessary
> as the non-zero "depth" counter indicates the same).
> 
> So where? There is a sole per-IRQ table that's available for all 
> possible configs - ipipe_domain::irqs[NR_IRQS].
> 
> So the minor changes below don't make any structure bigger. Read the 
> comment about the 3-d byte.
> 
> 
> ----------------------------- IPIPE changes 
> -------------------------------------------
> 
> --- ipipe.h    2006-02-27 15:10:41.000000000 +0100
> +++ ipipe-exp.h    2006-03-02 12:08:27.000000000 +0100
> @@ -62,6 +62,15 @@
>  #define IPIPE_SHARED_FLAG    6
>  #define IPIPE_EXCLUSIVE_FLAG    31    /* ipipe_catch_event() is the 
> reason why. */
>  
> +/*
> + * The 3-d byte of ipipe_domain::irqs[IRQ]::control is reserved for use
> + * by upper layers and must not be changed on the ipipe layer.
> + * 
> +

<snip>

> 2) We need somehow to force the .end handler of the PIC (only PPC arch 
> make uses of it at the moment;
> other archs - use .enable instead as .ending for those is just 
> .enabling) to _not_ re-enable the IRQ line
> when the ISR has disabled the IRQ explicitly.
> 
> So there are 2 possible ways (at least, I can see only 2 now) :
> 
>     2.1) make changes for all PIC handlers supported for a given arch if 
> their .end handler is about re-enabling the IRQ line :
>    
>     BEFORE
>    
>     static void openpic_end_irq(unsigned int irq_nr)
>     {
>     if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
>         && irq_desc[irq_nr].action)
>         openpic_enable_irq(irq_nr);
>     }
> 
>    
>     AFTER
>    
>     static void openpic_end_irq(unsigned int irq_nr)
>     {
>     if (!ipipe_root_domain_p()
>         && 
> !test_bit(IPIPE_DISABLED_FLAG,&ipipe_current_domain->irqs[irq_nr].control))
>         return;
>     

- !test_bit(IPIPE_DISABLED_FLAG,&ipipe_current_domain->irqs[irq_nr].control))
+ test_bit(IPIPE_DISABLED_FLAG,&ipipe_current_domain->irqs[irq_nr].control))

?

Additionally, there is another issue we discussed once with Anders, which is 
related to not sending EOI twice after the shared IRQ already ended by a RT domain 
has been fully propagated down the pipeline to Linux; some kind of 
test_and_clear_temporary_disable flag, would do, I guess. The other way would be 
to test_and_set some "ended" flag for the outstanding IRQ when the ->end() routine 
is entered, clearing this flag before pipelining the IRQ in __ipipe_walk_pipeline().

Actually, I'm now starting to wonder why we would want to permanently disable an 
IRQ line from a RT domain, which is known to be used by Linux. Is this what 
IPIPE_DISABLED_FLAG is expected to be used for, or is it only there to handle the 
transient disabled state discussed above?

>    
>     if (!ipipe_root_domain_p() || !(irq_desc[irq_nr].status & 
> (IRQ_DISABLED|IRQ_INPROGRESS))
>         && irq_desc[irq_nr].action)
>         openpic_enable_irq(irq_nr);
>     }
>    

There is another way for most archs, which is to add such code to the ->end() 
routine override in ipipe-root.c; this would be simpler and safer than fixing such 
routine for each and every kind of interrupt controller. x86 directly pokes into 
the PIC code and does not overrides IRQ control routines, though.

> 
>     2.2) do some trick.
>    
>     That's how this patch does. But, well, I do _not_ like this way.
>    

Same feeling here; this blurs the line between Adeos and Xenomai, which is bad.

>     Look at the xnarch_end_irq()'s implementation below.
>    
> ---
> p.s.
> 
> So I tend to think that 2.2 is, at the very least, ugly if even it seems 
> to be safe at the first glance.
> 
> 2.1 would be better probably. But then the ipipe layer must know at 
> least the DISABLED bit. What concerns me is that the logic is 
> implemented mostly in Xeno but the bits of this interface (check for 
> DISABLED bit in the .end handlers) is visible for ipipe. Bad 
> localization, I mean.
> Maybe something different from ipipe_set/get_reserved_area() should be 
> introduced to make DISABLED bit and "depth" counter invisible for the 
> Xeno. Smth like ipipe_irq_depth_inc/dec() and
> ipipe_irq_set/clear_disabled() .. I'm not sure yet.

IRQ sharing is an exception case for dealing with legacy hw; let's not introduce 
old new legacy code into Adeos which is only a minimalistic virtualization layer, 
just for the purpose of it; especially since we can implement this support at a 
higher level, the one that actually wants to provide the full semantics of IRQ 
sharing. Adeos is better at providing simple mechanisms, policies are Xenomai's 
business there.

However, there must be a mean to deal with the particular ->end() issue at Adeos 
level, but this should be decoupled from the disable nesting count issue.

> 
>  >From another point of view, this new feature seems not to be too 
> intrusive and not something really affecting the "fast path" so it could 
> be used by default, I guess. Or maybe we don't need it at all?
> 

The disable nesting count at Xenomai level is needed to let ISRs act independently 
from each others wrt interrupt masking - or at the very least, to let them think 
they do. This is strictly a Xenomai issue, not an Adeos one. If we keep it at this 
level, then using the xnintr struct to store the nesting counter becomes an 
option, I guess.

-- 

Philippe.

