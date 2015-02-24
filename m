Date: Tue, 24 Feb 2015 21:48:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150224204801.GJ14148@hermes.click-hack.org>
References: <54ECCC8A.8000501@siemens.com>
 <20150224192718.GH14148@hermes.click-hack.org>
 <54ECDF37.3050706@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54ECDF37.3050706@siemens.com>
Subject: Re: [Xenomai] I-pipe exception handling - a general model
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, Feb 24, 2015 at 09:29:43PM +0100, Jan Kiszka wrote:
> On 2015-02-24 20:27, Gilles Chanteperdrix wrote:
> > On Tue, Feb 24, 2015 at 08:10:02PM +0100, Jan Kiszka wrote:
> >> Hi,
> >>
> >> let's try to express the steps in handling hardware exception under
> >> I-pipe in a generic way:
> >>
> >> ipipe_exception_handler(regs, ...)
> >> {
> >> 	// ARM has this e.g.
> >> 	[if (early_handling(...))
> >> 		return;]
> >>
> >> 	// some architectures may only enter with irqs off
> >> 	[hard_irqs_off = hard_irqs_disabled();]
> > 
> > Not OK. Here what you will get is:
> > - hard_irqs_off is true if the exception is taken on root
> > - hard_irqs_off is false if the exception is taken on head (as a
> 
> No, this is invariant of the context. The hardware(-configuration)
> decides if we enter the handler with hard irqs off or not. See x86, this
> is known to work code.

No. Relaxing re-enables hw irqs. So, if you took the exception over
head, you relaxed, and hw irqs are on here. The information you get
this way is irrelevant.

> 
> > result of the relax). So, what would make sense is to put it on the
> > exception entry, but why bother, it will always be true on arm and I
> > guess x86, since ARM stopped handling exceptions with irqs on to
> > imitate x86.
> > 
> >>
> >> 	if (__ipipe_notify_trap(...))
> >> 		return;
> >>
> > 
> > 
> > 
> >> 	local_save_flags(root_flags);
> >> 	// this adjusts irq mask in regs (like __fixup_if on x86)
> >> 	mask_irqs(regs, raw_irqs_disabled_flags(root_flags));
> > 
> > Please provide the code of this function.
> 
> -> __fixup_if (same semantic, just clearer naming)
> 
> > 
> >>
> >> 	if (ipipe_root_p) {
> >> 		[if (hard_irqs_off)]
> >> 			local_irq_disable();
> > 
> > Also this is uselessly complicated. Calling local_irq_save is much
> > simpler. This works because hard_irqs_off is always true on ARM
> > (provided that you put it in the right place, that is before the
> > early_handling).
> 
> No, this would be wrong if hard_irqs_off is false, thus the trap is
> taken without disabling hardware interrupts. On ARM, hard_irqs_off would
> be always true, correct, but this is a generic model.

Ok, sorry, I am not interested in the discussion about the
generic model. The only thing I am interested in is the ARM
implementation, because this is what I maintain. I just want to
discuss what will land in the I-pipe tree before it happens.

So, following your suggestions, I propose the following
implementation: 

static inline unsigned long ipipe_fault_entry(struct pt_regs *regs)
{
	unsigned long flags;
	int s;

	hard_local_irq_disable();
	s = __test_and_set_bit(IPIPE_STALL_FLAG, &__ipipe_root_status);
	hard_local_irq_enable();

	flags = regs->ARM_cpsr;
	regs->ARM_cpsr = flags & ~PSR_I_BIT | (s ? PSR_I_BIT : 0);

	if (ipipe_root_p)
		return flags;

	local_irq_enable();
	BUG();
	return ~0UL;
}

static inline void ipipe_fault_exit(struct pt_regs *regs, unsigned long flags)
{
	if (interrupts_enabled(regs))
		local_irq_enable();
	reg->ARM_cpsr = flags;
}

By saving the stall bit in the saved regs CPSR, it will cope
automatically with the case where the exception handler fiddles with
the PSR_I_BIT. If this is found to be bad taste, I can use
arch_mangle_bits instead.

-- 
					    Gilles.

