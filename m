From: Michael Neuhauser <mike@domain.hid>
Content-Type: multipart/mixed; boundary="=-a8LCniELzAjUQPAYVPTW"
Message-Id: <1102946562.17458.11.camel@domain.hid>
Mime-Version: 1.0
Date: Mon, 13 Dec 2004 15:02:42 +0100
Subject: [Adeos-main] Some notes on Adeos on ARM 920T (EP9301) with Linux 2.4.21-rmk1
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
To: adeos-main@gna.org

--=-a8LCniELzAjUQPAYVPTW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

First of all, sorry for the length of this - I've tried to be as brief
as possible.

I'm working with the EDB9301, a development board from Cirrus with an
ARM EP9301 CPU (ARM920T, 166 MHz). The board manufacturer supplies a
Linux patch for the 2.4.21-rmk1 Kernel (giving 2.4.21-rmk1-crus1.4.2).
The goal is to provide Adeos based RTAI on this system, supporting
hard-realtime both in kernel and user-space (i.e. LXRT).

I have Adeos now running stable on the system and want to share some of
the experiences I've gained and issues I've found in the porting
process. I will touch general issues first, but if wanted, I can provide
the architecture specific things later too (i.e. full source code, but
that will take a little time to clean up).

I've based my work on the Adeos cvs and the ARM patches included in
various RTAI versions.

1) idle loop (this may affect other architectures than ARM too)
---------------------------------------------------------------

If the CPU (like the EP9301) has a special HALT state and this feature
is used in the idle loop (in arch/arm/kernel/process.c, via arch_idle())

    void default_idle(void)
    {
	    local_irq_disable();
	    if (!current->need_resched)
		    arch_idle();
	    local_irq_enable();
    }

then the following can happen when Adeos is used: local_irq_disable()
stalls the pipeline - interrupts that happen after this call and before
arch_idle() are handled by Adeos (put into pipe, mask in PIC) but
nothing more. If, by chance, *all* active interrupts happen just in this
time window, then the system is going to be locked-up because the HALT
state can not be left again:
  * only an interrupt could wake-up the CPU from the HALT state
  * all interrupts are masked and will not be delivered to the CPU

This actually happened quite often on my system: everything
froze until I sent a character to the otherwise idle 2nd UART (i.e.
triggered an unmasked interrupt).

To fix this, disable the interrupts on the hardware level in
default_idle(), not just stall the pipe (i.e. adeos_hw_cli() instead of
local_irq_disable()) if Adeos is configured.

See attached patch-file linux-2.4.21-rmk1-crus1.4.2_idle-lock-up.patch

Maybe using the HALT state should be avoided at all, when hard real-time
performance is the goal. Some RTAI patches for other ARM sub-archs have
comments that indicate problems with long wake-up times. EP9301 is OK in
this respect (comparing the latency on an idle system when HALT state is
used to using a simple busy loop showed no clear winner).

2) call asm_do_IRQ() instead of do_IRQ()
----------------------------------------

>From a mailing-list contribution by Russel M. King (sorry can't find
exact reference any more):

    More thoughts - if this is 2.4.19-rmk6, calling do_IRQ is out.
    do_IRQ is not safe to be called from anywhere other than within
    properly-locked IRQ context.  This means that all the locking which
    is required would not be done, soft IRQs would not normally be run,
    and things would go bang.

    [...]

	vector_IRQ -> {__irq_usr,__irq_svc} -> asm_do_IRQ -> do_IRQ
    not
	vector_IRQ -> {__irq_usr,__irq_svc} -> do_IRQ

This also holds for 2.4.21-rmk1 (especially the not called soft-irqs
result in strange phenomena). This can be fixed by replacing do_IRQ()
with asm_do_IRQ() in two places:
    * in adeos/armv.c:__adeos_enable_pipeline()
    * in arch/arm/kernel/adeos.c:__adeos_handle_irq()
But this makes it necessary to skip the irq fix-up in
arch/arm/kernel/irq.c:asm_do_IRQ() when the pipeline is active (because
it was already done in __adeos_handle_irq()).

See attached patch-file linux-2.4.21-rmk1-crus1.4.2_asm_do_irq.patch

I still haven't figured out if the further comments of RMK apply also:

    Please note that asm_do_IRQ is intended to be called only once while
    handling each interrupt, so:

	asm_do_IRQ -> do_IRQ -> somewhere else -> asm_do_IRQ

    isn't legal, but:

	asm_do_IRQ -> do_IRQ -> somewhere else -> do_IRQ
    or:
	asm_do_IRQ -> do_IRQ -> somewhere else -> (cpu interrupt) ->
		vector_IRQ -> __irq_svc -> asm_do_IRQ -> do_IRQ

    are both legal.

I.e. the "somewhere else" would be __adeos_sync_stage(). But I haven't
noticed any troubles under heavy interrupt and general system load so it
seems to be OK the way it is now.

3) crash when Adeos is compiled into kernel (i.e. not module)
-------------------------------------------------------------

In the adeos-cvs __adeos_takeover() is called from
2.4.19-arm-rmk7-pxa2/init/main.c:do_basic_setup() when Adeos is not
compiled as a module. This crashes under 2.4.21-rmk1-crus1.4.2, while
calling it at the end of kernel/adeos.c:__adoes_init() does work. (I've
got this fix from the RTAI-list message "Preliminary ARM patch for
Stromboli/newLXRT" by Humberto Luiz Valdivia de Matos.)

I don't have PXA hardware so I can't check if it works there as it is.

4) __adeos_enter_syscall() gets called with wrong "regs" argument
-----------------------------------------------------------------

__adeos_enter_syscall() is called from
arch/arm/kernel/entry-common.S:vector_swi to monitor system-call events.
The syscall-number and a pointer to the pt_regs structure is passed. In
code:

ENTRY(vector_swi)
	save_user_regs
	[...]
	str	r4, [sp, #-S_OFF]!		@ push fifth arg
	[...]
#ifdef CONFIG_ADEOS_CORE
	stmfd	sp!, {r0-r3}
	add	r0, sp, #S_OFF
	mov	r1, scno
	bl	__adeos_enter_syscall
	cmp     r0,#0
	ldmfd	sp!, {r0-r3}
	bne	__adeos_fast_ret
#endif /* CONFIG_ADEOS_CORE */
	ldr	ip, [tsk, #TSK_PTRACE]		@ check for syscall tracing
	[...]

Register r0 should point to the stack where the registers were pushed
onto it with "save_user_regs", S_OFF is added to correct for the "str
r4, [sp, #-S_OFF]!" instruction. But the saving of the registers just
before the add is not accounted for. So the line

	add	r0, sp, #S_OFF

has to be replaced with

	add	r0, sp, #(4*4 + S_OFF)		@ let r0 point to user regs

4*4: registers r0-r3 are saved, 4 bytes each.

Please note, that I've also moved the "ldr ip, [tsk, #TSK_PTRACE]" after
the ifdef so that ip hasn't to be saved on the stack.

Performance Enhancements
========================

P1) don't use write-back caching (all architectures that use virtual
    addresses to access the cache, not really Adeos specific)
-------------------------------------------------------------------

Don't configure the d-cache to use write-back - it increases the worst
case irq latency by ~ 40 us on the EP9301:

* cache is dirty (i.e. contains modified data not written to RAM yet)
* a (Linux process) context switch happens (with irqs hard disabled of
  course)
* cache has to be invalidated (because cache uses virtual addresses and
  next process might use same address range)
* dirty words have to be written back to RAM, RAM is slow

-> 40 us of hard locked irqs.

So always use write-through caching when you need fast reaction to
interrupts. To be able to select this option in 2.4.21-rmk1, one has to
fix arch/arm/config.in (replace CONFIG_CPU_DISABLE_DCACHE with
CONFIG_CPU_DCACHE_DISABLE) and never use "make xconfig" it silently
resets the option (menuconfig, oldconfig and config is OK).

P2) optimize away adp_pipelined flag if not compiled as module
--------------------------------------------------------------
 
A little optimization "Preliminary ARM patch for Stromboli/newLXRT" by
Humberto Luiz Valdivia de Matos: the flag "adp_pipelined" is replaced by
a define to 1 if Adeos is directly compiled into the Kernel.
Conditionals on adp_pipelined can than be resolved during compile-time
(performance gain might not be much, but at my low end system everything
counts).

See attached patch-file linux-2.4.21-rmk1-crus1.4.2_pipelined_flag.patch

P3) return value of __adeos_handle_irq() is not used, don't compute it
----------------------------------------------------------------------

On the i386 architecture, the return value of __adeos_handle_irq() is
used to decide which return path to take when returning from an
interrupt.
* the slow path (may do reschedule, signal_return) if the current domain
  is the root-domain and its pipeline is not stalled
* the fast path (just restore-registers and do "iret") otherwise

On the ARMv architecture, things are handled differently (see
arch/arm/kernel/entry-armv.S): the same return path through ret_to_user
will be taken, no matter what __adeos_handle_irq() returns.

So to save a few cycles (and cache space), __adeos_handle_irq()
should be made void so no return value needs to be computed (it would
also reflect more clearly what is really going on).

See attached patch-file linux-2.4.21-rmk1-crus1.4.2_handle_irq_noretval.patch

P4) IPIPE_SYNC_FLAG only needed for SMP
---------------------------------------

* arch/arm/kernel/adeos.c:__adeos_sync_stage() is the only place where
  the IPIPE_SYNC_FLAG of a pipeline is modified.
* the flag is only modified when adeos_lock_cpu() or adeos_hw_cli() was
  called before
* the flag is cleared before interrupts are hard enabled and the handler
  is called
-> test_and_set_bit() on the sync-flag can never be true on an UP system
-> IPIPE_SYNC_FLAG is only needed for SMP

To save a few cycles (test_and_set_bit() is rather costly on ARM as the
MSR has to be read/modified), use "#ifdef CONFIG_SMP" around all uses of
IPIPE_SYNC_FLAG in arch/arm/kernel/adeos.c:__adeos_sync_stage().

See attached patch-file linux-2.4.21-rmk1-crus1.4.2_ipipe_sync_flag_smp.patch

Kind regards,
	Mike
-- 
Dr. Michael Neuhauser                phone: +43 1 789 08 49 - 30
Firmix Software GmbH                   fax: +43 1 789 08 49 - 55
Vienna/Austria/Europe                      email: mike@domain.hid
Embedded Linux Development and Services    http://www.firmix.at/

--=-a8LCniELzAjUQPAYVPTW
Content-Disposition: attachment; filename=linux-2.4.21-rmk1-crus1.4.2_asm_do_irq.patch
Content-Type: text/x-patch; name=linux-2.4.21-rmk1-crus1.4.2_asm_do_irq.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -d -u -r1.1.1.1 irq.c
--- arch/arm/kernel/irq.c	18 Oct 2004 10:00:17 -0000	1.1.1.1
+++ arch/arm/kernel/irq.c	13 Dec 2004 11:04:48 -0000
@@ -310,6 +318,11 @@
  */
 asmlinkage void asm_do_IRQ(int irq, struct pt_regs *regs)
 {
+#ifdef CONFIG_ADEOS_CORE
+    /* Only fix-up irq if pipline is not active (then it was already done
+     * in __adeos_handle_irq(). <mike@domain.hid> */
+    if (!adp_pipelined)
+#endif /* CONFIG_ADEOS_CORE */
 	irq = fixup_irq(irq);
 
 	/*
diff -u adeos-cvs/v2.4/adeos-core/adeos/armv.c adeos/armv.c
--- adeos-cvs/v2.4/adeos-core/adeos/armv.c	2004-10-03 16:18:50.000000000 +0200
+++ adeos/armv.c	2004-12-13 12:08:46.000000000 +0100
@@ -38,8 +42,8 @@
 
 extern struct pt_regs __adeos_irq_regs;
 
-asmlinkage void do_IRQ(int irq,
-		       struct pt_regs *regs);
+asmlinkage void asm_do_IRQ(int irq,
+			   struct pt_regs *regs);
 
 static struct irqdesc __adeos_std_irq_desc[NR_IRQS];
 
@@ -126,8 +130,11 @@
     /* First, virtualize all interrupts from the root domain. */
 
     for (irq = 0; irq < NR_IRQS; irq++)
+	/* Note that according to Russel King asm_do_IRQ() has to used as the
+	 * handler, not do_IRQ() (at least for 2.4.21-rmk7) as the original
+	 * ADEOS code had here. <mike@domain.hid> */
 	adeos_virtualize_irq(irq,
-			     (void (*)(unsigned))&do_IRQ,
+			     (void (*)(unsigned))&asm_do_IRQ,
 			     &__adeos_ack_irq,
 			     IPIPE_HANDLE_MASK|IPIPE_PASS_MASK);

diff -u adeos-cvs/v2.4/adeos-core/arch/arm/kernel/adeos.c adeos/armv.c
--- adeos-cvs/v2.4/adeos-core/arch/arm/kernel/adeos.c	2004-10-16 20:37:39.000000000 +0200
+++ arch/arm/kernel/adeos.c	2004-12-13 12:11:17.000000000 +0100
@@ -33,8 +33,8 @@
 #include <asm/io.h>
 #include <asm/arch/irq.h>
 
-asmlinkage void do_IRQ(int irq,
-		       struct pt_regs *regs);
+asmlinkage void asm_do_IRQ(int irq,
+			   struct pt_regs *regs);
 
 /* A global flag telling whether Adeos pipelining is engaged. */
 int adp_pipelined;
@@ -236,8 +236,11 @@
 
     if (!adp_pipelined)
 	{
-	do_IRQ(irq,regs);
+	/* Note that according to Russel King asm_do_IRQ() has to be called (at
+	 * least for 2.4.21-rmk7), not do_IRQ() as the original ADEOS code had
+	 * here. <mike@domain.hid> */
+	asm_do_IRQ(irq,regs);
	return 1;
 	}
 
     if (!adeos_virtual_irq_p(irq))

--=-a8LCniELzAjUQPAYVPTW
Content-Disposition: attachment; filename=linux-2.4.21-rmk1-crus1.4.2_handle_irq_noretval.patch
Content-Type: text/plain; name=linux-2.4.21-rmk1-crus1.4.2_handle_irq_noretval.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- adeos-core/include/asm-arm/adeos.h	2004-11-09 09:02:14.000000000 +0100
+++ include/asm-arm/adeos.h	2004-12-09 23:35:49.000000000 +0100
@@ -279,8 +281,8 @@
 
 void __adeos_tune_timer(unsigned long hz);
 
-asmlinkage int __adeos_handle_irq(int irq,
-				  struct pt_regs *regs);
+asmlinkage void __adeos_handle_irq(int irq,
+				   struct pt_regs *regs);
 
 asmlinkage int __adeos_switch_domain(adomain_t *adp,
 				     adomain_t **currentp);
--- adeos-core/arch/arm/kernel/adeos.c	2004-12-13 12:30:35.000000000 +0100
+++ arch/arm/kernel/adeos.c	2004-12-13 12:30:46.000000000 +0100
@@ -224,7 +236,7 @@
    interrupt protection log is maintained here for each
    domain. Interrupts are off on entry. */
 
-asmlinkage int __adeos_handle_irq (int irq, struct pt_regs *regs)
+asmlinkage void __adeos_handle_irq (int irq, struct pt_regs *regs)
 
 {
     struct list_head *head, *pos;
@@ -240,7 +252,7 @@
 	 * least for 2.4.21-rmk7), not do_IRQ() as the original ADEOS code had
 	 * here. <mike@domain.hid> */
 	asm_do_IRQ(irq,regs);
-	return 1;
+	return;
 	}
 
     if (!adeos_virtual_irq_p(irq))
@@ -249,7 +261,7 @@
     if (irq >= IPIPE_NR_IRQS)
 	{
 	printk(KERN_ERR "ADEOS: spurious interrupt %d\n",irq);
-	return 1;
+	return;
 	}
 
     adeos_load_cpuid();
@@ -328,8 +340,24 @@
 
     __adeos_walk_pipeline(head,cpuid);
 
+#if 0
+    /* @TODO@
+     * The return value of this function is only used on i386 but not on ARM or
+     * PPC! On i386 the following is done in x86.c: 
+     * r = __adeos_handle_irq()
+     * if (r)			// current domain is root-domain && ipipe is not stalled?
+     * 	   asm("cld")		// slow path (may do reschedule, signal_return)
+     * 	   jmp ret_from_intr
+     * else			// current domain is not root-domain || ipipe is stalled
+     * 	   restore regs		// fast path
+     * 	   asm("iret")
+     *				--<mike@domain.hid>
+     */
     return (adp_cpu_current[cpuid] == adp_root &&
 	    !test_bit(IPIPE_STALL_FLAG,&adp_root->cpudata[cpuid].status));
+#endif
+
+    return;
 }
 
 /* adeos_trigger_irq() -- Push the interrupt to the pipeline entry

--=-a8LCniELzAjUQPAYVPTW
Content-Disposition: attachment; filename=linux-2.4.21-rmk1-crus1.4.2_idle-lock-up.patch
Content-Type: text/x-patch; name=linux-2.4.21-rmk1-crus1.4.2_idle-lock-up.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -d -u -r1.1.1.1 process.c
--- arch/arm/kernel/process.c	18 Oct 2004 10:00:17 -0000	1.1.1.1
+++ arch/arm/kernel/process.c	13 Dec 2004 10:21:41 -0000
@@ -66,17 +66,30 @@
 void (*pm_idle)(void);
 void (*pm_power_off)(void);
 
+#ifndef CONFIG_ADEOS_CORE
 /*
  * This is our default idle handler.  We need to disable
  * interrupts here to ensure we don't miss a wakeup call.
  */
 void default_idle(void)
 {
+#ifdef CONFIG_ADEOS_CORE
+	/* if we don't do a hard cli, we might miss an interrupt and
+	 * sleep for an indefinite time (system lock-up or increased
+	 * interrupt latency) --<mike@domain.hid> */
+	adeos_hw_cli();
+#else
 	local_irq_disable();
+#endif
 	if (!current->need_resched && !hlt_counter)
 		arch_idle();
+#ifdef CONFIG_ADEOS_CORE
+	adeos_hw_sti();
+#else
 	local_irq_enable();
+#endif
 }
+#endif /* !CONFIG_ADEOS_CORE */
 
 /*
  * The idle thread.  We try to conserve power, while trying to keep

--=-a8LCniELzAjUQPAYVPTW
Content-Disposition: attachment; filename=linux-2.4.21-rmk1-crus1.4.2_ipipe_sync_flag_smp.patch
Content-Type: text/plain; name=linux-2.4.21-rmk1-crus1.4.2_ipipe_sync_flag_smp.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- adeos-core/arch/arm/kernel/adeos.c	2004-12-13 12:30:35.000000000 +0100
+++ arch/arm/kernel/adeos.c	2004-12-13 12:30:46.000000000 +0100
@@ -114,8 +116,10 @@
 
     do
 	{
+#ifdef CONFIG_SMP
 	if (unlikely(test_and_set_bit(IPIPE_SYNC_FLAG,&cpudata->status)))
 	    goto release_cpu_and_exit;
+#endif
 
 	/* The policy here is to keep the dispatching code
 	   interrupt-free by stalling the current stage. If the upper
@@ -155,7 +159,9 @@
 
 		set_bit(IPIPE_STALL_FLAG,&cpudata->status);
 
+#ifdef CONFIG_SMP
 		clear_bit(IPIPE_SYNC_FLAG,&cpudata->status);
+#endif
 
 #ifdef CONFIG_ADEOS_PROFILING
 		__adeos_profile_data[cpuid].irqs[irq].n_synced++;
@@ -174,16 +180,22 @@
 
 		clear_bit(IPIPE_STALL_FLAG,&cpudata->status);
 
+#ifdef CONFIG_SMP
 		if (test_and_set_bit(IPIPE_SYNC_FLAG,&cpudata->status))
 		    goto release_cpu_and_exit;
+#endif
 		}
 	    }
 
+#ifdef CONFIG_SMP
 	clear_bit(IPIPE_SYNC_FLAG,&cpudata->status);
+#endif
 	}
     while ((cpudata->irq_pending_hi & syncmask) != 0);
 
+#ifdef CONFIG_SMP
 release_cpu_and_exit:
+#endif
 
     adeos_unlock_cpu(flags);
 }

--=-a8LCniELzAjUQPAYVPTW
Content-Disposition: attachment; filename=linux-2.4.21-rmk1-crus1.4.2_pipelined_flag.patch
Content-Type: text/plain; name=linux-2.4.21-rmk1-crus1.4.2_pipelined_flag.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- adeos-core/include/asm-arm/adeos.h	2004-11-09 09:02:14.000000000 +0100
+++ include/asm-arm/adeos.h	2004-12-13 14:29:27.000000000 +0100
@@ -42,7 +42,11 @@
 #error "Adeos: unsupported ARM architecture, sorry..."
 #endif /* CONFIG_ARCH_SA1100 */
 
+#ifdef CONFIG_ADEOS_MODULE
 extern int adp_pipelined;
+#else  /* !CONFIG_ADEOS_MODULE */
+#define adp_pipelined           (1)     /* optimize away flag tests if not compiled as module */
+#endif /* CONFIG_ADEOS_MODULE */
 
 typedef unsigned long cpumask_t;
 
--- adeos-core/arch/arm/kernel/adeos.c	2004-12-13 14:04:55.000000000 +0100
+++ arch/arm/kernel/adeos.c	2004-12-13 12:30:46.000000000 +0100
@@ -36,8 +36,10 @@
 asmlinkage void asm_do_IRQ(int irq,
 			   struct pt_regs *regs);
 
+#ifdef CONFIG_ADEOS_MODULE
 /* A global flag telling whether Adeos pipelining is engaged. */
 int adp_pipelined;
+#endif /* CONFIG_ADEOS_MODULE */
 
 struct pt_regs __adeos_irq_regs;
 

--=-a8LCniELzAjUQPAYVPTW--


