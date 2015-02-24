Date: Tue, 24 Feb 2015 20:27:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150224192718.GH14148@hermes.click-hack.org>
References: <54ECCC8A.8000501@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54ECCC8A.8000501@siemens.com>
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

On Tue, Feb 24, 2015 at 08:10:02PM +0100, Jan Kiszka wrote:
> Hi,
> 
> let's try to express the steps in handling hardware exception under
> I-pipe in a generic way:
> 
> ipipe_exception_handler(regs, ...)
> {
> 	// ARM has this e.g.
> 	[if (early_handling(...))
> 		return;]
> 
> 	// some architectures may only enter with irqs off
> 	[hard_irqs_off = hard_irqs_disabled();]

Not OK. Here what you will get is:
- hard_irqs_off is true if the exception is taken on root
- hard_irqs_off is false if the exception is taken on head (as a
result of the relax). So, what would make sense is to put it on the
exception entry, but why bother, it will always be true on arm and I
guess x86, since ARM stopped handling exceptions with irqs on to
imitate x86.

> 
> 	if (__ipipe_notify_trap(...))
> 		return;
> 



> 	local_save_flags(root_flags);
> 	// this adjusts irq mask in regs (like __fixup_if on x86)
> 	mask_irqs(regs, raw_irqs_disabled_flags(root_flags));

Please provide the code of this function.

> 
> 	if (ipipe_root_p) {
> 		[if (hard_irqs_off)]
> 			local_irq_disable();

Also this is uselessly complicated. Calling local_irq_save is much
simpler. This works because hard_irqs_off is always true on ARM
(provided that you put it in the right place, that is before the
early_handling).


> 	} else {


> 		hard_local_irq_disable()
> 




> 		__ipipe_set_current_domain(ipipe_root_domain);
> 
> 		[if (hard_irqs_off)]
> 			local_irq_disable();
> 
> 		report_unhandled_fault(...);
> 	}

Ok, why not. We currently do not have this, but adding it make
sense. I hope that we can make it more readable though.

> 
> 	linux_fault_handler(...);
> 
> 	ipipe_restore_root_nosync(root_flags);
> 
> 	// never return with irqs masked to root - may already be done
> 	// by the return code in entry.S on some architectures?
> 	[mask_irqs(regs, false);]

Wrong: as I said yesterday, the regs should be restored to the value
they had on entry. If the irqs were masked when the exception was
taken, then we can return to the caller with irq masked:
- it will unmask them sooner or later
- this is what the mainline kernel does when irqs are not
virtualized.

Possibly, if some handler fiddles with the PSR_I_BIT in regs->psr,
this should be reflected on the stall bit, but I am not sure this
case even exists.

> 
> 	// some architectures may require this?
> 	[hard_local_irq_disable()]

If you want to do this, you should put it before
ipipe_restore_root_nosync, otherwise you create a window where Linux
irqs can be taken which does not exist in the mainline kernel.

But after discussion with Philippe, I think we want to always return
with irqs on to entry.S 

Again, I propose:

static inline unsigned long ipipe_fault_entry(void)
{
	unsigned long flags;
	int s;

	local_irq_save(flags);
	hard_local_irq_enable();

	return flags;
}

static inline void ipipe_fault_exit(unsigned long flags)
{
	ipipe_restore_root_nosync(flags);
}


Which is simple and readable.

-- 
					    Gilles.

