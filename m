From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B5ACAD7.5070607@domain.hid>
References: <4B59D952.30202@domain.hid>
	<1264181859.2350.152.camel@domain.hid>
	<4B59E2D4.5040004@domain.hid>  <4B59E33E.1040203@domain.hid>
	<1264182738.2350.158.camel@domain.hid>
	<4B59E87F.80108@domain.hid>
	<1264183719.2350.159.camel@domain.hid>
	<1264240767.2350.164.camel@domain.hid>
	<4B5ACAD7.5070607@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 23 Jan 2010 11:12:21 +0100
Message-ID: <1264241541.2350.166.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Domain switch during page fault handling
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Sat, 2010-01-23 at 11:09 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Fri, 2010-01-22 at 19:08 +0100, Philippe Gerum wrote:
> >> On Fri, 2010-01-22 at 19:03 +0100, Jan Kiszka wrote:
> >>> Philippe Gerum wrote:
> >>>> On Fri, 2010-01-22 at 18:41 +0100, Jan Kiszka wrote:
> >>>>> Gilles Chanteperdrix wrote:
> >>>>>> Philippe Gerum wrote:
> >>>>>>> On Fri, 2010-01-22 at 17:58 +0100, Jan Kiszka wrote: 
> >>>>>>>> Hi guys,
> >>>>>>>>
> >>>>>>>> we are currently trying to catch an ugly Linux pipeline state corruption
> >>>>>>>> on x86-64.
> >>>>>>>>
> >>>>>>>> Conceptual question: If a Xenomai task causes a fault, we enter
> >>>>>>>> ipipe_trap_notify over the primary domain and leave it over the root
> >>>>>>>> domain, right? Now, if the root domain happened to be stalled when the
> >>>>>>>> exception happened, where should it normally be unstalled again,
> >>>>>>>> *for_that_task*? Our problem is that we generate a code path where this
> >>>>>>>> does not happen.
> >>>>>>> xnhadow_relax -> ipipe_reenter_root -> finish_task_switch ->
> >>>>>>> finish_lock_switch -> unstall
> >>>>>>>
> >>>>>>> Since xnshadow_relax is called on behalf the event dispatcher, we should
> >>>>>>> expect it to return with the root domain unstalled after a domain
> >>>>>>> downgrade, from primary to root.
> >>>>>> Ok, but what about local_irq_restore_nosync at the end of the function ?
> >>>>>>
> >>>>> That is, IMO, our problem: It replays the root state on fault entry, but
> >>>>> that one is totally unrelated to the (Xenomai) task that caused the fault.
> >>>> The code seems fishy. Try restoring only when the incoming domain was
> >>>> the root one. Indeed.
> >>>>
> >>> Something like this?
> >>>
> >>> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
> >>> index 4442d96..0558ea3 100644
> >>> --- a/arch/x86/kernel/ipipe.c
> >>> +++ b/arch/x86/kernel/ipipe.c
> >>> @@ -702,19 +702,21 @@ static int __ipipe_xlate_signo[] = {
> >>>  
> >>>  int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
> >>>  {
> >>> +	bool restore_flags = false;
> >>>  	unsigned long flags;
> >>>  
> >>> -	/* Pick up the root domain state of the interrupted context. */
> >>> -	local_save_flags(flags);
> >>> +	if (ipipe_root_domain_p && irqs_disabled_hw()) {
> >>> +		/* Pick up the root domain state of the interrupted context. */
> >>> +		local_save_flags(flags);
> >>>  
> >>> -	if (ipipe_root_domain_p) {
> >>>  		/*
> >>>  		 * Replicate hw interrupt state into the virtual mask before
> >>>  		 * calling the I-pipe event handler over the root domain. Also
> >>>  		 * required later when calling the Linux exception handler.
> >>>  		 */
> >>> -		if (irqs_disabled_hw())
> >>> -			local_irq_disable();
> >>> +		local_irq_disable();
> >>> +
> >>> +		restore_flags = true;
> >>>  	}
> >>>  #ifdef CONFIG_KGDB
> >>>  	/* catch exception KGDB is interested in over non-root domains */
> >>> @@ -725,7 +727,8 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
> >>>  #endif /* CONFIG_KGDB */
> >>>  
> >>>  	if (unlikely(ipipe_trap_notify(vector, regs))) {
> >>> -		local_irq_restore_nosync(flags);
> >>> +		if (restore_flags)
> >>> +			local_irq_restore_nosync(flags);
> >>>  		return 1;
> >>>  	}
> >>>  
> >>> @@ -770,7 +773,8 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
> >>>  	 * Relevant for 64-bit: Restore root domain state as the low-level
> >>>  	 * return code will not align it to regs.flags.
> >>>  	 */
> >>> -	local_irq_restore_nosync(flags);
> >>> +	if (restore_flags)
> >>> +		local_irq_restore_nosync(flags);
> >>>  
> >>>  	return 0;
> >>>  }
> >>>
> >>>
> >>> We are currently not able to test this on the system that triggers it,
> >>> but we'll do so tomorrow (yeah...).
> >>>
> >> Should work. Famous last words.
> >>
> > 
> > Strike that. This won't work, because the fixup code will use the saved
> > flags even when root is not the incoming domain and/or hw IRQs are on on
> > entry. In short, local_save_flags() must be done unconditionally, as
> > previously.
> 
> It will accidentally work for 64-bit where __fixup_if is empty. And for
> 32-bit, I would say we need to make it depend on restore_flags as well.
> 

AFAIK, Gilles is working on this. We just need to avoid stepping on
32bit toes to fix 64.

> Jan
> 


-- 
Philippe.



