Subject: Re: [Adeos-main] Some notes on Adeos on ARM 920T (EP9301) with
	Linux 2.4.21-rmk1
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <1103556690.25404.73.camel@domain.hid>
References: <1102946562.17458.11.camel@domain.hid>
	 <1103374557.702.55.camel@domain.hid>
	 <1103556690.25404.73.camel@domain.hid>
Content-Type: text/plain
Message-Id: <1103755673.704.45.camel@domain.hid>
Mime-Version: 1.0
Date: Wed, 22 Dec 2004 23:47:55 +0100
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Michael Neuhauser <mike@domain.hid>
Cc: adeos-main@gna.org

On Mon, 2004-12-20 at 16:31, Michael Neuhauser wrote:
> Thank you for commenting on my notes.
> 
> On Sat, 2004-12-18 at 13:55, Philippe Gerum wrote:
> > On Mon, 2004-12-13 at 15:02, Michael Neuhauser wrote:
> > > [...]
> > > 1) idle loop (this may affect other architectures than ARM too)
> > > ---------------------------------------------------------------
> > > 
> > > If the CPU (like the EP9301) has a special HALT state and this feature
> > > is used in the idle loop (in arch/arm/kernel/process.c, via arch_idle())
> > > 
> > >     void default_idle(void)
> > >     {
> > > 	    local_irq_disable();
> > > 	    if (!current->need_resched)
> > > 		    arch_idle();
> > > 	    local_irq_enable();
> > >     }
> > > 
> > > then the following can happen when Adeos is used: local_irq_disable()
> > > stalls the pipeline - interrupts that happen after this call and before
> > > arch_idle() are handled by Adeos (put into pipe, mask in PIC) but
> > > nothing more. If, by chance, *all* active interrupts happen just in this
> > > time window, then the system is going to be locked-up because the HALT
> > > state can not be left again:
> > >   * only an interrupt could wake-up the CPU from the HALT state
> > >   * all interrupts are masked and will not be delivered to the CPU
> > > 
> > > This actually happened quite often on my system: everything
> > > froze until I sent a character to the otherwise idle 2nd UART (i.e.
> > > triggered an unmasked interrupt).
> > > 
> > > To fix this, disable the interrupts on the hardware level in
> > > default_idle(), not just stall the pipe (i.e. adeos_hw_cli() instead of
> > > local_irq_disable()) if Adeos is configured.
> > 
> > This has been overlooked in the Adeos patch for ARM. x86 properly
> > flushes the interrupt log when calling safe_halt(), but locking out hw
> > IRQs seems indeed the best way to prevent the CPU to enter the halted
> > mode whilst there is some IRQ-awaken task to schedule, specifically for
> > non-preemptible kernels.
> 
> As I understand it, the problem has nothing to do with flushing the
> interrupt log or tasks not being scheduled. There is a lock-up on the
> hardware level: all interrupts that could force the CPU from HALT are
> masked -> HALT state is never left again. It's not likely to happen but
> it does happen on my (slow) system (depends on interrupt load etc.).
> 

Indeed, this could happen with a particular optimization done in the
latest patches, which actually masks IRQs at hw level when stalling the
highest priority stage, since no other domain could preempt it anyway.
This saves a bunch of microseconds when the hi-priority domain runs in
interrupt-free sections, by avoiding further (useless) preemption to run
__adeos_handle_irq() (which among other things has to ack the interrupt
at hw level).

x86 solves this by calling safe_halt() which explicitely re-enables hw
IRQs before calling the 'hlt' insn. Maybe something alike is missing in
our case.

> > > Maybe using the HALT state should be avoided at all, when hard real-time
> > > performance is the goal. [...]
> > 
> > Power consumption?
> 
> I imagine some people will gladly accept increased power consumption if
> it shaves off some us from the latency (if this is really the case for
> some ARM hardware, it is not with mine). So this might not be a good
> idea for default behaviour.
> 

Maybe, since waking up a CPU from a halted state is likely to be
power-consuming too; I guess the right solution is a matter of finding
the right trade-off, as usual. This could be made optional at the
Adeos-level if the option to choose the idle mode is not already
provided by the kernel.

> > >[...]
> > > 3) crash when Adeos is compiled into kernel (i.e. not module)
> > >[...]
> > 
> > The location in the boot sequence where the pipeline should be enabled
> > looks like much more arch-dependent than I had first expected (e.g.
> > Adeos 2.6/ia64 required some changes there). This said, the crash might
> > be related to the change making adp_pipelined a constant. In any case,
> > this is what happened to the Adeos 2.6/PPC port.
> 
> I'll try it without making adp_pipelined a constant.
> 
> > > [...]
> > > [return value of __adeos_handle_irq() is not used, don't compute it]
> > > [...]
> >
> > Whoops, no. The real problem is the IRQ return path not caring from the
> > return value of __adeos_handle_irq(), not the other way around. The
> > current patch has a serious flaw, it should check this return value, and
> > branch out of any Linux epilogue code if it is non-zero.
> >
> > The reason is that if this value is non-zero, then the current IRQ has
> > either preempted a non-Linux domain, or has preempted Linux (e.g. to
> > serve more prioritary domains, or at least to log the interrupt event)
> > while the Linux pipeline stage was stalled, i.e. while Linux thought it
> > was running in an interrupt-free section.
> > If you do not prevent the Linux epilogue code to run upon IRQ exit in
> > the latter case, then you are likely to execute it in a spurious
> > context. This issue is even more important with preemptible kernels,
> > because the epilogue code does even more complex things. 
> 
> After spending a weekend buried in the entry-*.S stuff it is quite
> obvious to me too. I have a preliminary patch (but it needs more
> testing).
> 
> I think there are more problems with the exception handling stuff: the
> stall-state of the root domain's ipipe is not preserved across the
> exception. On i386 this is done by __adeos_if_fixup_root() and
> __adeos_unstall_iret_root() but nothing the like exists for ARM.
> 
> Do you know if this was omitted accidentally or intentionally (i.e.
> because it is not necessary on ARM, but I don't see how this could be
> the case)?
> 

__adeos_fixup_root() is a rather recent fix I've made for x86. I've
struggled for weeks against random and infrequent bugs induced by the
wrong software interrupt bit being spuriously inverted by an exception
return before seing the light... Its absence for ARM is only due to the
fact that I did not analyse the situation of this arch wrt to this
issue.

> > > P4) IPIPE_SYNC_FLAG only needed for SMP
> > > ---------------------------------------
> > > 
> > > * arch/arm/kernel/adeos.c:__adeos_sync_stage() is the only place where
> > >   the IPIPE_SYNC_FLAG of a pipeline is modified.
> > > * the flag is only modified when adeos_lock_cpu() or adeos_hw_cli() was
> > >   called before
> > > * the flag is cleared before interrupts are hard enabled and the handler
> > >   is called
> > > -> test_and_set_bit() on the sync-flag can never be true on an UP system
> > > -> IPIPE_SYNC_FLAG is only needed for SMP
> > 
> > In fact, the need for this flag originates from x86, where some drivers
> > (e.g. PC keyboard one) do sit in a busy loop over an ISR waiting or the
> > next interrupt to come from the device they dialog with (yes, it's
> > ugly), instead of using some kind of automaton to deal with this
> > asynchronously from the kernel execution POV. For this to work, then you
> > need to be able to re-enter __adeos_sync_stage(). So it's actually
> > needed on UP too for some hw.
> > 
> > I cannot tell for ARM, but since __adeos_sync_stage() is arch-dependent,
> > I guess it's ok to remove it if there is no driver problem such as the
> > one plaguing x86.
> 
> I think the difference between ARM & i386 is not the driver's behaviour
> but the fact that ARM __adeos_sync_stage() does an adeos_lock_cpu()
> (i386 doesn't) before setting the sync-flag and the sync-flag is cleared

In any case, recent Adeos patches for 2.6 must enter
__adeos_sync_stage() with hw IRQs off (i.e. adeos_lock_cpu()) regardless
of the target arch; it's a prerequisite. This is why adeos_lock_cpu() is
no more called by __adeos_sync_stage() in the latest patches, but the
caller must provide for this protection in the first place.

> before hw-interrupts are enabled again. So it is impossible (on UP) that
> __adeos_sync_stage() is entered with sync-flag set (as long as nobody
> else is modifying the flag, which doesn't seem to be the case).

Not on UP, you are right. IIRC, on SMP, there used to be another issue
aside of the recursion one: cpu migration of IRQ handler contexts
started by a high-priority (non-Linux) domain. But I'm not even sure
that the latter still applies after the various rewrites I've made of
__adeos_sync_stage() over time. /me needs to check.

> Regards
> Mike
-- 

Philippe.


