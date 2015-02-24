Message-ID: <54ECE14D.9000403@xenomai.org>
Date: Tue, 24 Feb 2015 21:38:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <54ECCC8A.8000501@siemens.com>
In-Reply-To: <54ECCC8A.8000501@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe exception handling - a general model
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 02/24/2015 08:10 PM, Jan Kiszka wrote:
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
> 
> 	if (__ipipe_notify_trap(...))
> 		return;
> 
> 	local_save_flags(root_flags);
> 	// this adjusts irq mask in regs (like __fixup_if on x86)
> 	mask_irqs(regs, raw_irqs_disabled_flags(root_flags));
> 
> 	if (ipipe_root_p) {
> 		[if (hard_irqs_off)]
> 			local_irq_disable();
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
> 
> 	linux_fault_handler(...);
> 
> 	ipipe_restore_root_nosync(root_flags);
> 
> 	// never return with irqs masked to root - may already be done
> 	// by the return code in entry.S on some architectures?
> 	[mask_irqs(regs, false);]
> 
> 	// some architectures may require this?
> 	[hard_local_irq_disable()]
> }
> 
> This is almost like x86 after my patch. Well, almost...
> 
> One difference is that I reverted the change that Philippe did on the
> 3.16 merge regarding when to restore the root state: before 3.16 we
> called ipipe_restore_root_nosync() unconditionally, since 3.16 only if
> entered over root. This change was not documented, and it's also not in
> line with the discussion about how to handle this on ARM. So I dropped
> it here and will drop it from x86.

FWIW, I don't agree with much of the discussion on the ARM stuff,
although I could agree on changes making fault entry/exit more cautious.
I'm waiting for the dust to settle.

Besides, I find the idea of generalizing the fault handling practically
very difficult, since the arch-dependent assembly-written trampolines
may make different assumptions when dispatching faults. Check how ppc64
virtualizes interrupts, or how blackfin cannot reschedule directly on
behalf an interrupt or trap, and have fun.

I'm ok with any meaningful change, but to sum it up :

- I would definitely not use x86 as a reference, because there may be
assumptions from the ancient times when interrupts were virtualized in
entry.S, which disappeared a few years ago. If things are done only for
the sake of preserving the TRACE_IRQFLAGS feature, then fine, but in
such a case this should not alter the fast path. I always wondered why
things got so complicated with x86 over time, maybe they should be
considered again. To me, your patch related to the interrupt state when
calling __ipipe_notify_trap() definitely goes in the right direction.
Nice to see the x86 implementation shrink for once.

- the code invoking ipipe_restore_root_nosync() should better make sure
that 1) interrupts were never virtually masked with hw irqs on before
ipipe_restore_root_nosync() is invoked while handling the fault, OR 2)
the interrupt pipeline is synced before entry.S returns from the
exception trap. I'm unsure that any of these conditions is granted for
all archs (read: I'm pretty sure of the opposite).

Other than that, I'm fine with any simplification and obviously, fixes.
Please make sure to channel all ARM changes through Gilles's tree, so
that my favorite ARM maintainer is always happy, and stops saturating my
IRC buffer with the contents of his emacs buffers, sending me more code
in an hour than I could ever managed to write over the last twenty years.

TIA,

-- 
Philippe.

