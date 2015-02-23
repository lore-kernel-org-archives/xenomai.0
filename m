Date: Mon, 23 Feb 2015 19:04:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150223180425.GJ22377@hermes.click-hack.org>
References: <54EB5638.3050805@xenomai.org>
 <20150223163743.GA22377@hermes.click-hack.org>
 <54EB5A45.9000002@siemens.com>
 <20150223165549.GC22377@hermes.click-hack.org>
 <54EB5D02.8080105@xenomai.org>
 <20150223171250.GE22377@hermes.click-hack.org>
 <20150223172146.GG22377@hermes.click-hack.org>
 <54EB66BB.2060703@siemens.com>
 <20150223175110.GI22377@hermes.click-hack.org>
 <54EB695C.4000909@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54EB695C.4000909@siemens.com>
Subject: Re: [Xenomai] ipipe: issues with ARM exception handling
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

On Mon, Feb 23, 2015 at 06:54:36PM +0100, Jan Kiszka wrote:
> On 2015-02-23 18:51, Gilles Chanteperdrix wrote:
> > On Mon, Feb 23, 2015 at 06:43:23PM +0100, Jan Kiszka wrote:
> >> On 2015-02-23 18:21, Gilles Chanteperdrix wrote:
> >>> On Mon, Feb 23, 2015 at 06:12:50PM +0100, Gilles Chanteperdrix wrote:
> >>>> On Mon, Feb 23, 2015 at 06:01:54PM +0100, Philippe Gerum wrote:
> >>>>> On 02/23/2015 05:55 PM, Gilles Chanteperdrix wrote:
> >>>>>> On Mon, Feb 23, 2015 at 05:50:13PM +0100, Jan Kiszka wrote:
> >>>>>>> On 2015-02-23 17:37, Gilles Chanteperdrix wrote:
> >>>>>>>> On Mon, Feb 23, 2015 at 05:32:56PM +0100, Philippe Gerum wrote:
> >>>>>>>>> On 02/23/2015 05:06 PM, Jan Kiszka wrote:
> >>>>>>>>>> On 2015-02-20 20:52, Philippe Gerum wrote:
> >>>>>>>>>>> On 02/20/2015 08:47 PM, Philippe Gerum wrote:
> >>>>>>>>>>>> On 02/20/2015 08:44 PM, Philippe Gerum wrote:
> >>>>>>>>>>>>> On 02/20/2015 07:17 PM, Jan Kiszka wrote:
> >>>>>>>>>>>>>> On 2015-02-20 19:03, Jan Kiszka wrote:
> >>>>>>>>>>>>>>> Hi Gilles,
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> analyzing a lockdep warning on 3.16 with I-pipe enabled, I dug deeper
> >>>>>>>>>>>>>>> into the hard and virtual interrupt state management during exception
> >>>>>>>>>>>>>>> handling on ARM. I think there are several issues:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> - ipipe_fault_entry should not fiddle with the root irq state if run
> >>>>>>>>>>>>>>>   over head, only when invoked over root.
> >>>>>>>>>>>>>>> - ipipe_fault_exit must not change the root state unless we entered over
> >>>>>>>>>>>>>>>   head and are about to leave over root - see x86. The current code may
> >>>>>>>>>>>>>>>   keep root incorrectly stalled after an exception, though this will
> >>>>>>>>>>>>>>>   probably be fixed up again in practice quickly.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> And the adjustment of the root irq state after migration has to happen
> >>>>>>>>>>>>>> before Linux starts to handle the event. It would basically be a late
> >>>>>>>>>>>>>> ipipe_fault_entry.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> - do_sect_fault is only called by do_DataAbort and do_PrefetchAbort,
> >>>>>>>>>>>>>>>   in both cases already wrapped in ipipe_fault_entry/exit, thus it
> >>>>>>>>>>>>>>>   shouldn't invoke them once again.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Sorry, this was a misinterpretation - do_sect_fault is invoked before
> >>>>>>>>>>>>>> ipipe_fault_entry.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> What I need to add, though:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> - do_DataAbort and do_PrefetchAbort call __ipipe_report_trap after
> >>>>>>>>>>>>>>   ipipe_fault_entry, thus with hard IRQs on.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> This would break LPAE with the Xenomai nucleus as a module on 2.6.x, by
> >>>>>>>>>>>>> treading over a non-linear kernel mapping before the page table could be
> >>>>>>>>>>>>> fixed up. do_translation_fault() must run via the fsr handler
> >>>>>>>>>>>>> indirection before any non-linear access.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Sorry, if you do that _after_ the fault entry notification, then it's ok
> >>>>>>>>>>>> in theory. However, I don't understand why we would need to notify when
> >>>>>>>>>>>> only a minor fixup is required, that does not entail a mode migration.
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> To be clearer, do you intend to report the minor fault upon
> >>>>>>>>>>> do_translation_fault() returning zero, or are you referring to a
> >>>>>>>>>>> different context?
> >>>>>>>>>>
> >>>>>>>>>> No, I'm just talking about this potential change:
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> >>>>>>>>>> index 38834c6..b42632a 100644
> >>>>>>>>>> --- a/arch/arm/mm/fault.c
> >>>>>>>>>> +++ b/arch/arm/mm/fault.c
> >>>>>>>>>> @@ -629,10 +629,10 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> >>>>>>>>>>  	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
> >>>>>>>>>>  		return;
> >>>>>>>>>>  
> >>>>>>>>>> -	irqflags = ipipe_fault_entry();
> >>>>>>>>>> -
> >>>>>>>>>>  	if (__ipipe_report_trap(IPIPE_TRAP_UNKNOWN, regs))
> >>>>>>>>>> -		goto out;
> >>>>>>>>>> +		return;
> >>>>>>>>>> +
> >>>>>>>>>> +	irqflags = ipipe_fault_entry();
> >>>>>>>>>>  
> >>>>>>>>>>  	printk(KERN_ALERT "Unhandled fault: %s (0x%03x) at 0x%08lx\n",
> >>>>>>>>>>  		inf->name, fsr, addr);
> >>>>>>>>>> @@ -642,7 +642,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> >>>>>>>>>>  	info.si_code  = inf->code;
> >>>>>>>>>>  	info.si_addr  = (void __user *)addr;
> >>>>>>>>>>  	arm_notify_die("", regs, &info, fsr, 0);
> >>>>>>>>>> -out:
> >>>>>>>>>> +
> >>>>>>>>>>  	ipipe_fault_exit(irqflags);
> >>>>>>>>>>  }
> >>>>>>>>>>  
> >>>>>>>>>> @@ -669,10 +669,10 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
> >>>>>>>>>>  	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
> >>>>>>>>>>  		return;
> >>>>>>>>>>  
> >>>>>>>>>> -	irqflags = ipipe_fault_entry();
> >>>>>>>>>> -
> >>>>>>>>>>  	if (__ipipe_report_trap(IPIPE_TRAP_UNKNOWN, regs))
> >>>>>>>>>> -		goto out;
> >>>>>>>>>> +		return;
> >>>>>>>>>> +
> >>>>>>>>>> +	irqflags = ipipe_fault_entry();
> >>>>>>>>>>  
> >>>>>>>>>>  	printk(KERN_ALERT "Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
> >>>>>>>>>>  		inf->name, ifsr, addr);
> >>>>>>>>>> @@ -682,7 +682,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
> >>>>>>>>>>  	info.si_code  = inf->code;
> >>>>>>>>>>  	info.si_addr  = (void __user *)addr;
> >>>>>>>>>>  	arm_notify_die("", regs, &info, ifsr, 0);
> >>>>>>>>>> -out:
> >>>>>>>>>> +
> >>>>>>>>>>  	ipipe_fault_exit(irqflags);
> >>>>>>>>>>  }
> >>>>>>>>>>  
> >>>>>>>>>>
> >>>>>>>>>> This seems more consistent - if not more correct - as it now does the
> >>>>>>>>>> reporting with hard irqs off, like in the other cases.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Ack, definitely. The pattern is to cause any migration first if need be,
> >>>>>>>>> _then_ flip the virtual IRQ state, so that ipipe_fault_restore() always
> >>>>>>>>> reinstates the interrupt state in effect after the caller has migrated
> >>>>>>>>> to the root domain.
> >>>>>>>>
> >>>>>>>> Is it even useful ? After a relax, the state of the root thread
> >>>>>>>> stall bit and irq flags are well known...
> >>>>>>>
> >>>>>>> We still need to disable IRQs for root. HW IRQs are likely already on,
> >>>>>>> right?
> >>>>>>>
> >>>>>>> And, again, we should refrain from restoring any root irq state on
> >>>>>>> return - it belongs to Linux (once we migrated and synchronized the state).
> >>>>>>
> >>>>>> The ipipe_fault_exit in my tree is:
> >>>>>>
> >>>>>> static inline void ipipe_fault_exit(unsigned long x)
> >>>>>> {
> >>>>>> 	if (!arch_demangle_irq_bits(&x))
> >>>>>> 		local_irq_enable();
> >>>>>> 	else
> >>>>>> 		hard_local_irq_restore(x);
> >>>>>> }
> >>>>>>
> >>>>>> And I must say I am not sure I understand how it works. To me it
> >>>>>> seems:
> >>>>>
> >>>>> It mangles both the real and virtual states in one word.
> >>>>>
> >>>>>> hard_local_irq_disable() should always be called in case entry.S
> >>>>>> expects us to return as we entered: with hw irqs off
> >>>>>
> >>>>> Which is what ipipe_fault_exit() does by testing the mangled state. If
> >>>>> the fault entered with virtual IRQs on, then you must exit with both the
> >>>>> stall bit and CPSR_I bit cleared.
> >>>>
> >>>> Absolutely not. Imagine a Linux task, with root unstalled
> >>>> experiencing a fault. entry.S is entered root is still unstalled,
> >>>> with hardware irqs off. On fault entry, we must reflect this
> >>>> hardware irq state on the stall bit and enable hw irqs. Then when
> >>>> the fault is handled, undo that, unstall the root stage, disable hw
> >>>> irqs and return to entry.S, so that it may resume the execution of
> >>>> the Linux task. If it returns quickly to user-space, a stalled root
> >>>> at this point would be a disaster, because nothing, certainly not
> >>>> entry.S will unstall the root stage.
> >>>>
> >>>> Then there is the case where Linux re-enables irqs in the course of
> >>>> the handler, in that case, we should not return to entry.S with hw
> >>>> irqs off.
> >>>
> >>> To summarize:
> >>>
> >>> when the fault is entered over head domain. The root stage can be
> >>> left unstalled on fault exit. The hw irqs state should reflect the
> >>> root stage stall bit state at exit.
> >>
> >> On x86, we pick up the desired state of hw and root after migration to
> >> root completed.
> >>
> >>>
> >>> when the fault is entered over root domain. The root stage stall bit
> >>> must be restorer as it was on entry, and the hw irqs state should
> >>> reflect the root stage stall bit state at exit.
> >>
> >> Right. Actually, it should be restored to the state in the register set
> >> on return from the Linux handler.
> > 
> > No, the fault return path will take care of that by restoring the
> > saved cpsr. What is important is that if an irq return path assumes
> > that hw irqs are disabled to start pulling registers and playing
> > with sp, we must have disabled the hw irqs before returning to it,
> > to avoid register corruption if an irq happens at the bad time. On
> > the other hand, if Linux called local_irq_enable(), then entry.S
> > will not assume that hw irqs are off, and we can avoid the
> > hard_local_irq_disable() before returning from the fault, so as to
> > avoid creating a useless masking section (which is probably the
> > reason why Linux calls local_irq_enable()).
> > 
> >> But as Linux does not seem to
> >> manipulate that state, we are fine with restoring to the entry state.
> > 
> > Well, Linux seems to call local_irq_enable() in one of the fault
> > handlers. 
> 
> I was referring to manipulating regs->ARM_cpsr, i.e. the state of the
> context were we will return to. We don't consider this on x86 as well.

So, finally, I propose:

static inline unsigned long ipipe_fault_entry(void)
{
	unsigned long flags;

	local_irq_save(flags);      /* Re-enables hw irqs */

	return flags;
}

static inline void ipipe_fault_exit(unsigned long x)
{
	if (irqs_disabled()) {
		__ipipe_restore_root_nosync(x);
		hard_local_irq_disable();
	}
}

-- 
					    Gilles.

