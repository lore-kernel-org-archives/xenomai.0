Subject: Re: [Adeos-main] Some notes on Adeos on ARM 920T (EP9301) with
	Linux 2.4.21-rmk1
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <1102946562.17458.11.camel@domain.hid>
References: <1102946562.17458.11.camel@domain.hid>
Content-Type: text/plain
Message-Id: <1103374557.702.55.camel@domain.hid>
Mime-Version: 1.0
Date: Sat, 18 Dec 2004 13:55:57 +0100
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

On Mon, 2004-12-13 at 15:02, Michael Neuhauser wrote:
> First of all, sorry for the length of this - I've tried to be as brief
> as possible.
> 
> I'm working with the EDB9301, a development board from Cirrus with an
> ARM EP9301 CPU (ARM920T, 166 MHz). The board manufacturer supplies a
> Linux patch for the 2.4.21-rmk1 Kernel (giving 2.4.21-rmk1-crus1.4.2).
> The goal is to provide Adeos based RTAI on this system, supporting
> hard-realtime both in kernel and user-space (i.e. LXRT).
> 
> I have Adeos now running stable on the system and want to share some of
> the experiences I've gained and issues I've found in the porting
> process. I will touch general issues first, but if wanted, I can provide
> the architecture specific things later too (i.e. full source code, but
> that will take a little time to clean up).
> 
> I've based my work on the Adeos cvs and the ARM patches included in
> various RTAI versions.
> 
> 1) idle loop (this may affect other architectures than ARM too)
> ---------------------------------------------------------------
> 
> If the CPU (like the EP9301) has a special HALT state and this feature
> is used in the idle loop (in arch/arm/kernel/process.c, via arch_idle())
> 
>     void default_idle(void)
>     {
> 	    local_irq_disable();
> 	    if (!current->need_resched)
> 		    arch_idle();
> 	    local_irq_enable();
>     }
> 
> then the following can happen when Adeos is used: local_irq_disable()
> stalls the pipeline - interrupts that happen after this call and before
> arch_idle() are handled by Adeos (put into pipe, mask in PIC) but
> nothing more. If, by chance, *all* active interrupts happen just in this
> time window, then the system is going to be locked-up because the HALT
> state can not be left again:
>   * only an interrupt could wake-up the CPU from the HALT state
>   * all interrupts are masked and will not be delivered to the CPU
> 
> This actually happened quite often on my system: everything
> froze until I sent a character to the otherwise idle 2nd UART (i.e.
> triggered an unmasked interrupt).
> 
> To fix this, disable the interrupts on the hardware level in
> default_idle(), not just stall the pipe (i.e. adeos_hw_cli() instead of
> local_irq_disable()) if Adeos is configured.
> 

This has been overlooked in the Adeos patch for ARM. x86 properly
flushes the interrupt log when calling safe_halt(), but locking out hw
IRQs seems indeed the best way to prevent the CPU to enter the halted
mode whilst there is some IRQ-awaken task to schedule, specifically for
non-preemptible kernels.

> See attached patch-file linux-2.4.21-rmk1-crus1.4.2_idle-lock-up.patch
> 
> Maybe using the HALT state should be avoided at all, when hard real-time
> performance is the goal. Some RTAI patches for other ARM sub-archs have
> comments that indicate problems with long wake-up times. EP9301 is OK in
> this respect (comparing the latency on an idle system when HALT state is
> used to using a simple busy loop showed no clear winner).
> 

Power consumption?

> 2) call asm_do_IRQ() instead of do_IRQ()
> ----------------------------------------
> 
> >From a mailing-list contribution by Russel M. King (sorry can't find
> exact reference any more):
> 
>     More thoughts - if this is 2.4.19-rmk6, calling do_IRQ is out.
>     do_IRQ is not safe to be called from anywhere other than within
>     properly-locked IRQ context.  This means that all the locking which
>     is required would not be done, soft IRQs would not normally be run,
>     and things would go bang.
> 
>     [...]
> 
> 	vector_IRQ -> {__irq_usr,__irq_svc} -> asm_do_IRQ -> do_IRQ
>     not
> 	vector_IRQ -> {__irq_usr,__irq_svc} -> do_IRQ
> 
> This also holds for 2.4.21-rmk1 (especially the not called soft-irqs
> result in strange phenomena). This can be fixed by replacing do_IRQ()
> with asm_do_IRQ() in two places:
>     * in adeos/armv.c:__adeos_enable_pipeline()
>     * in arch/arm/kernel/adeos.c:__adeos_handle_irq()
> But this makes it necessary to skip the irq fix-up in
> arch/arm/kernel/irq.c:asm_do_IRQ() when the pipeline is active (because
> it was already done in __adeos_handle_irq()).
> 
> See attached patch-file linux-2.4.21-rmk1-crus1.4.2_asm_do_irq.patch
> 

Ok, I'll apply this too.

> I still haven't figured out if the further comments of RMK apply also:
> 
>     Please note that asm_do_IRQ is intended to be called only once while
>     handling each interrupt, so:
> 
> 	asm_do_IRQ -> do_IRQ -> somewhere else -> asm_do_IRQ
> 
>     isn't legal, but:
> 
> 	asm_do_IRQ -> do_IRQ -> somewhere else -> do_IRQ
>     or:
> 	asm_do_IRQ -> do_IRQ -> somewhere else -> (cpu interrupt) ->
> 		vector_IRQ -> __irq_svc -> asm_do_IRQ -> do_IRQ
> 
>     are both legal.
> 
> I.e. the "somewhere else" would be __adeos_sync_stage(). But I haven't
> noticed any troubles under heavy interrupt and general system load so it
> seems to be OK the way it is now.
> 
> 3) crash when Adeos is compiled into kernel (i.e. not module)
> -------------------------------------------------------------
> 
> In the adeos-cvs __adeos_takeover() is called from
> 2.4.19-arm-rmk7-pxa2/init/main.c:do_basic_setup() when Adeos is not
> compiled as a module. This crashes under 2.4.21-rmk1-crus1.4.2, while
> calling it at the end of kernel/adeos.c:__adoes_init() does work. (I've
> got this fix from the RTAI-list message "Preliminary ARM patch for
> Stromboli/newLXRT" by Humberto Luiz Valdivia de Matos.)
> 

The location in the boot sequence where the pipeline should be enabled
looks like much more arch-dependent than I had first expected (e.g.
Adeos 2.6/ia64 required some changes there). This said, the crash might
be related to the change making adp_pipelined a constant. In any case,
this is what happened to the Adeos 2.6/PPC port.

> I don't have PXA hardware so I can't check if it works there as it is.
> 
> 4) __adeos_enter_syscall() gets called with wrong "regs" argument
> -----------------------------------------------------------------
> 
> __adeos_enter_syscall() is called from
> arch/arm/kernel/entry-common.S:vector_swi to monitor system-call events.
> The syscall-number and a pointer to the pt_regs structure is passed. In
> code:
> 
> ENTRY(vector_swi)
> 	save_user_regs
> 	[...]
> 	str	r4, [sp, #-S_OFF]!		@ push fifth arg
> 	[...]
> #ifdef CONFIG_ADEOS_CORE
> 	stmfd	sp!, {r0-r3}
> 	add	r0, sp, #S_OFF
> 	mov	r1, scno
> 	bl	__adeos_enter_syscall
> 	cmp     r0,#0
> 	ldmfd	sp!, {r0-r3}
> 	bne	__adeos_fast_ret
> #endif /* CONFIG_ADEOS_CORE */
> 	ldr	ip, [tsk, #TSK_PTRACE]		@ check for syscall tracing
> 	[...]
> 
> Register r0 should point to the stack where the registers were pushed
> onto it with "save_user_regs", S_OFF is added to correct for the "str
> r4, [sp, #-S_OFF]!" instruction. But the saving of the registers just
> before the add is not accounted for. So the line
> 
> 	add	r0, sp, #S_OFF
> 
> has to be replaced with
> 
> 	add	r0, sp, #(4*4 + S_OFF)		@ let r0 point to user regs
> 
> 4*4: registers r0-r3 are saved, 4 bytes each.
> 
> Please note, that I've also moved the "ldr ip, [tsk, #TSK_PTRACE]" after
> the ifdef so that ip hasn't to be saved on the stack.
> 

Ok, internal syscall of mine returning -ENOBRAIN. The Adeos 2.4/ARM
patch against 2.4.19 is in fact a merge between a contributed patch for
sa1100 and a previous patch of mine against uclinux for mmuless AT91
platforms. Whilst the latter has been reasonably tested, the merged
stuff has not.

> Performance Enhancements
> ========================
> 
> P1) don't use write-back caching (all architectures that use virtual
>     addresses to access the cache, not really Adeos specific)
> -------------------------------------------------------------------
> 
> Don't configure the d-cache to use write-back - it increases the worst
> case irq latency by ~ 40 us on the EP9301:
> 
> * cache is dirty (i.e. contains modified data not written to RAM yet)
> * a (Linux process) context switch happens (with irqs hard disabled of
>   course)
> * cache has to be invalidated (because cache uses virtual addresses and
>   next process might use same address range)
> * dirty words have to be written back to RAM, RAM is slow
> 
> -> 40 us of hard locked irqs.
> 
> So always use write-through caching when you need fast reaction to
> interrupts. To be able to select this option in 2.4.21-rmk1, one has to
> fix arch/arm/config.in (replace CONFIG_CPU_DISABLE_DCACHE with
> CONFIG_CPU_DCACHE_DISABLE) and never use "make xconfig" it silently
> resets the option (menuconfig, oldconfig and config is OK).
> 

Ok.

> P2) optimize away adp_pipelined flag if not compiled as module
> --------------------------------------------------------------
>  
> A little optimization "Preliminary ARM patch for Stromboli/newLXRT" by
> Humberto Luiz Valdivia de Matos: the flag "adp_pipelined" is replaced by
> a define to 1 if Adeos is directly compiled into the Kernel.
> Conditionals on adp_pipelined can than be resolved during compile-time
> (performance gain might not be much, but at my low end system everything
> counts).
> 

Warning: this optimization was there in the early Adeos days, but I've
discarded it because it broke the PPC port. Basically, some archs need
to perform part of their init chores with interrupts enabled, thus
requesting the pipeline to be up and running. Thus, the grey area of
code between the hw mask enable and the pipeline init does cause
problems. On PPC, this is clearly the case. On x86, things are a bit
more complex: unless the IO-APIC support is enabled, adp_pipelined can
be constant because the whole boot process preceeding the pipeline init
is done IRQs off. If IO-APIC is enabled, we have to wait for the IRQ
routing and other init chores to be performed before the pipeline is
finally initialized, so we must have a variable adp_pipelined state.

This said, the best approach is likely to make this optimization on an
arch-dependent basis if nothing prevents it.

> See attached patch-file linux-2.4.21-rmk1-crus1.4.2_pipelined_flag.patch
> 
> P3) return value of __adeos_handle_irq() is not used, don't compute it
> ----------------------------------------------------------------------
> 
> On the i386 architecture, the return value of __adeos_handle_irq() is
> used to decide which return path to take when returning from an
> interrupt.
> * the slow path (may do reschedule, signal_return) if the current domain
>   is the root-domain and its pipeline is not stalled
> * the fast path (just restore-registers and do "iret") otherwise
> 
> On the ARMv architecture, things are handled differently (see
> arch/arm/kernel/entry-armv.S): the same return path through ret_to_user
> will be taken, no matter what __adeos_handle_irq() returns.
> 
> So to save a few cycles (and cache space), __adeos_handle_irq()
> should be made void so no return value needs to be computed (it would
> also reflect more clearly what is really going on).
> 
> See attached patch-file linux-2.4.21-rmk1-crus1.4.2_handle_irq_noretval.patch
> 

Whoops, no. The real problem is the IRQ return path not caring from the
return value of __adeos_handle_irq(), not the other way around. The
current patch has a serious flaw, it should check this return value, and
branch out of any Linux epilogue code if it is non-zero.

The reason is that if this value is non-zero, then the current IRQ has
either preempted a non-Linux domain, or has preempted Linux (e.g. to
serve more prioritary domains, or at least to log the interrupt event)
while the Linux pipeline stage was stalled, i.e. while Linux thought it
was running in an interrupt-free section.
If you do not prevent the Linux epilogue code to run upon IRQ exit in
the latter case, then you are likely to execute it in a spurious
context. This issue is even more important with preemptible kernels,
because the epilogue code does even more complex things. 

> P4) IPIPE_SYNC_FLAG only needed for SMP
> ---------------------------------------
> 
> * arch/arm/kernel/adeos.c:__adeos_sync_stage() is the only place where
>   the IPIPE_SYNC_FLAG of a pipeline is modified.
> * the flag is only modified when adeos_lock_cpu() or adeos_hw_cli() was
>   called before
> * the flag is cleared before interrupts are hard enabled and the handler
>   is called
> -> test_and_set_bit() on the sync-flag can never be true on an UP system
> -> IPIPE_SYNC_FLAG is only needed for SMP
> 

In fact, the need for this flag originates from x86, where some drivers
(e.g. PC keyboard one) do sit in a busy loop over an ISR waiting or the
next interrupt to come from the device they dialog with (yes, it's
ugly), instead of using some kind of automaton to deal with this
asynchronously from the kernel execution POV. For this to work, then you
need to be able to re-enter __adeos_sync_stage(). So it's actually
needed on UP too for some hw.

I cannot tell for ARM, but since __adeos_sync_stage() is arch-dependent,
I guess it's ok to remove it if there is no driver problem such as the
one plaguing x86.

> To save a few cycles (test_and_set_bit() is rather costly on ARM as the
> MSR has to be read/modified), use "#ifdef CONFIG_SMP" around all uses of
> IPIPE_SYNC_FLAG in arch/arm/kernel/adeos.c:__adeos_sync_stage().
> 
> See attached patch-file linux-2.4.21-rmk1-crus1.4.2_ipipe_sync_flag_smp.patch

> Kind regards,
> 	Mike
-- 

Philippe.


