Message-ID: <54ECCC8A.8000501@siemens.com>
Date: Tue, 24 Feb 2015 20:10:02 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] I-pipe exception handling - a general model
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

let's try to express the steps in handling hardware exception under
I-pipe in a generic way:

ipipe_exception_handler(regs, ...)
{
	// ARM has this e.g.
	[if (early_handling(...))
		return;]

	// some architectures may only enter with irqs off
	[hard_irqs_off = hard_irqs_disabled();]

	if (__ipipe_notify_trap(...))
		return;

	local_save_flags(root_flags);
	// this adjusts irq mask in regs (like __fixup_if on x86)
	mask_irqs(regs, raw_irqs_disabled_flags(root_flags));

	if (ipipe_root_p) {
		[if (hard_irqs_off)]
			local_irq_disable();
	} else {
		hard_local_irq_disable()

		__ipipe_set_current_domain(ipipe_root_domain);

		[if (hard_irqs_off)]
			local_irq_disable();

		report_unhandled_fault(...);
	}

	linux_fault_handler(...);

	ipipe_restore_root_nosync(root_flags);

	// never return with irqs masked to root - may already be done
	// by the return code in entry.S on some architectures?
	[mask_irqs(regs, false);]

	// some architectures may require this?
	[hard_local_irq_disable()]
}

This is almost like x86 after my patch. Well, almost...

One difference is that I reverted the change that Philippe did on the
3.16 merge regarding when to restore the root state: before 3.16 we
called ipipe_restore_root_nosync() unconditionally, since 3.16 only if
entered over root. This change was not documented, and it's also not in
line with the discussion about how to handle this on ARM. So I dropped
it here and will drop it from x86.

What I changed furthermore is to unconditionally fix up the interrupt
mask as stored in the register set of the parent context before calling
Linux. And I added that explicit second fixup of regs. That is missing
on x86 right now, but it would only affect a BUG() scenario, I think.

Now let's run this through all scenarios that Gilles listed:

hardware irqs in parent context:
 - are reported unchanged to __ipipe_report_trap
 - will get overwritten with the current root state if
   __ipipe_report_trap doesn't consume the exception
 - will always get re-enabled if returning over root

entry over root:
 - save the current root state
 - transfer the current root state into regs so the Linux can pick up
   the parent root state from there
 - stall root if hw irqs are off, restore previous state after Linux
   handler ran

entry over non-root:
 - if __ipipe_report_trap consumes the exception, no state is changed in
   our handler
 - if the exception is forwarded and migration to root took place, we
   simply follow the path "entry over root"
 - "hard" migration just additionally ensures that hardware IRQs stay
   off during the handling and that reporting is done as needed

Please comment on this model, if it matches your ideas or if you think
there are corner cases still incorrectly handled.

Would be good to document it somewhere centrally and refer to it in the
implementations, suggestions welcome. Maybe we can even factor out some
code that can be shared between architectures. BTW, how does this map on
the other archs we support?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

