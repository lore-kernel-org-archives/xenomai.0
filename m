Date: Fri, 24 Nov 2006 10:53:46 +0100
From: Benjamin Zores <benjamin.zores@domain.hid>
Message-Id: <20061124105346.e442448d.benjamin.zores@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Fri__24_Nov_2006_10_53_46_+0100_Nm28cBXAJpoxjaBr"
Subject: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

--Multipart=_Fri__24_Nov_2006_10_53_46_+0100_Nm28cBXAJpoxjaBr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi,

I've downloaded latest Adeos/Ipipe patch for PPC and unfortunately this
latest doesn't (yet) support the ARCH=powerpc architecture from kernel
but only the PPC one.

I've tried porting the changes to support the PPC_MERGE and be able to
still use Xenomai on 2.6.18 with ARCH=powerpc.

Attached is a patch that has to be applied after regular adeos-2.6.18-ppc
patch to extends supports for PowerPC.
Please consider it for review only right now as it might not yet compiles to the
end (i'm facing problems with includes inter-race which required me to change
the radix-tree.h header file which is something i don't want to).

I also have problems booting my latest kernel with this patch on
(but booting regular 2.6.18 in merged PowerPC architecture already is a hassle atm)
and I'd like you to help me know whether it cames from my patch's content or not.

FYI, I've tried to port all Adeos architecture dependant parts but i only focused
on PPC32 (PPC64 support might be in but i won't test on it). I'm also trying to boot an MPC8349 chip but i don't think I'll have to address anything with it as it used to work with Xenomai on 2.6.14.

Thanks for the review,

Ben

--Multipart=_Fri__24_Nov_2006_10_53_46_+0100_Nm28cBXAJpoxjaBr
Content-Type: text/plain;
 name="adeos-powerpc.diff"
Content-Disposition: attachment;
 filename="adeos-powerpc.diff"
Content-Transfer-Encoding: 7bit

diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/Kconfig linux.edit/arch/powerpc/Kconfig
--- linux.orig/arch/powerpc/Kconfig	2006-09-20 05:42:06.000000000 +0200
+++ linux.edit/arch/powerpc/Kconfig	2006-11-23 13:31:29.000000000 +0100
@@ -590,6 +590,8 @@
 
 menu "Kernel options"
 
+source kernel/ipipe/Kconfig
+
 config HIGHMEM
 	bool "High memory support"
 	depends on PPC32
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/kernel/entry_32.S linux.edit/arch/powerpc/kernel/entry_32.S
--- linux.orig/arch/powerpc/kernel/entry_32.S	2006-09-20 05:42:06.000000000 +0200
+++ linux.edit/arch/powerpc/kernel/entry_32.S	2006-11-23 13:39:27.000000000 +0100
@@ -132,8 +132,23 @@
          * check for stack overflow
          */
 	lwz	r9,THREAD_INFO-THREAD(r12)
+#ifdef CONFIG_IPIPE
+	/* Allow for private kernel-based stacks: those must not cause
+	the stack overflow detection to trigger when some activity has
+	been preempted over them. We just check if the kernel stack is
+	not treading on the memory area ranging from
+	&current->thread_info to &current->thread, which is coarser
+	than the vanilla implementation, but likely sensitive enough
+	to catch overflows soon enough though.*/
+	addi	r12,r9,THREAD
+	cmplw	0,r1,r9
+	cmplw	1,r1,r12
+	crand	1,1,4
+	bgt-	stack_ovf		/* if r9 < r1 < r9+THREAD */
+#else /* CONFIG_IPIPE */
 	cmplw	r1,r9			/* if r1 <= current->thread_info */
 	ble-	stack_ovf		/* then the kernel stack overflowed */
+#endif /* CONFIG_IPIPE */
 5:
 #ifdef CONFIG_6xx
 	tophys(r9,r9)			/* check local flags */
@@ -198,6 +213,21 @@
 	lwz	r11,_CCR(r1)	/* Clear SO bit in CR */
 	rlwinm	r11,r11,0,4,2
 	stw	r11,_CCR(r1)
+#ifdef CONFIG_IPIPE
+	addi	r3,r1,GPR0
+	bl	__ipipe_syscall_root
+	cmpwi	r3,0
+	lwz	r3,GPR3(r1)
+	lwz	r0,GPR0(r1)
+	lwz	r4,GPR4(r1)
+	lwz	r5,GPR5(r1)
+	lwz	r6,GPR6(r1)
+	lwz	r7,GPR7(r1)
+	lwz	r8,GPR8(r1)
+	lwz	r9,GPR9(r1)
+	bgt	.ipipe_end_syscall
+	blt	ret_from_syscall
+#endif /* CONFIG_IPIPE */       
 #ifdef SHOW_SYSCALLS
 	bl	do_show_syscall
 #endif /* SHOW_SYSCALLS */
@@ -260,11 +290,34 @@
 	SYNC
 	RFI
 
+#ifdef CONFIG_IPIPE
+.ipipe_end_syscall:
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
+	SYNC
+	MTMSRD(r10)
+	b syscall_exit_cont
+#endif /* CONFIG_IPIPE */
+        
 66:	li	r3,-ENOSYS
 	b	ret_from_syscall
 
 	.globl	ret_from_fork
 ret_from_fork:
+#ifdef CONFIG_IPIPE
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+	stwu	r1,-4(r1)
+	stw	r3,0(r1)
+	lis	r3,(0x80000000)@h
+	ori	r3,r3,(0x80000000)@l
+	bl	ipipe_trace_end
+	lwz	r3,0(r1)
+	addi	r1,r1,4
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
+	ori	r10,r10,MSR_EE
+	SYNC
+	MTMSRD(r10)
+#endif /* CONFIG_IPIPE */
 	REST_NVGPRS(r1)
 	bl	schedule_tail
 	li	r3,0
@@ -630,6 +683,12 @@
 	SYNC			/* Some chip revs have problems here... */
 	MTMSRD(r10)		/* disable interrupts */
 
+#ifdef CONFIG_IPIPE
+        bl __ipipe_check_root
+        cmpwi   r3, 0
+        beq- restore
+#endif /* CONFIG_IPIPE */
+
 	lwz	r3,_MSR(r1)	/* Returning to user mode? */
 	andi.	r0,r3,MSR_PR
 	beq	resume_kernel
@@ -665,11 +724,37 @@
 	beq+	restore
 	andi.	r0,r3,MSR_EE	/* interrupts off? */
 	beq	restore		/* don't schedule if so */
+#ifdef CONFIG_IPIPE	
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+	lis	r3,(0x80000000)@h
+	ori	r3,r3,(0x80000000)@l
+	bl	ipipe_trace_end
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
+	ori	r10,r10,MSR_EE
+	SYNC
+	MTMSRD(r10)
+	bl	__ipipe_fast_stall_root
+#endif /* CONFIG_IPIPE */
 1:	bl	preempt_schedule_irq
 	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r3,TI_FLAGS(r9)
 	andi.	r0,r3,_TIF_NEED_RESCHED
 	bne-	1b
+#ifdef CONFIG_IPIPE	
+	bl	__ipipe_fast_unstall_root
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
+	SYNC
+	MTMSRD(r10)
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+	lwz	r3,_MSR(r1)
+	andi.	r0,r3,MSR_EE
+	bne	restore
+	lis	r3,(0x80000000)@h
+	ori	r3,r3,(0x80000000)@l
+	bl	ipipe_trace_begin
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+#endif /* CONFIG_IPIPE */
 #else
 resume_kernel:
 #endif /* CONFIG_PREEMPT */
@@ -929,6 +1014,13 @@
 
 	.comm	ee_restarts,4
 
+#ifdef CONFIG_IPIPE
+_GLOBAL(__ipipe_ret_from_except)
+        cmpwi   r3, 0
+        bne+ ret_from_except
+        b restore
+#endif /* CONFIG_IPIPE */
+
 /*
  * PROM code for specific machines follows.  Put it
  * here so it's easy to add arch-specific sections later.
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/kernel/head_32.S linux.edit/arch/powerpc/kernel/head_32.S
--- linux.orig/arch/powerpc/kernel/head_32.S	2006-09-20 05:42:06.000000000 +0200
+++ linux.edit/arch/powerpc/kernel/head_32.S	2006-11-23 14:12:21.000000000 +0100
@@ -329,6 +329,12 @@
 	EXC_XFER_TEMPLATE(n, hdlr, n, NOCOPY, transfer_to_handler_full,	\
 			  ret_from_except_full)
 
+#ifdef CONFIG_IPIPE
+#define EXC_XFER_IPIPE(n, hdlr)		\
+	EXC_XFER_TEMPLATE(n, hdlr, n+1, NOCOPY, transfer_to_handler, \
+			  __ipipe_ret_from_except)
+#endif /* CONFIG_IPIPE */
+        
 #define EXC_XFER_LITE(n, hdlr)		\
 	EXC_XFER_TEMPLATE(n, hdlr, n+1, NOCOPY, transfer_to_handler, \
 			  ret_from_except)
@@ -418,7 +424,11 @@
 	EXC_XFER_EE_LITE(0x400, handle_page_fault)
 
 /* External interrupt */
+#ifdef CONFIG_IPIPE
+	EXCEPTION(0x500, HardwareInterrupt, __ipipe_grab_irq, EXC_XFER_IPIPE)
+#else /* !CONFIG_IPIPE */
 	EXCEPTION(0x500, HardwareInterrupt, do_IRQ, EXC_XFER_LITE)
+#endif /* CONFIG_IPIPE */
 
 /* Alignment exception */
 	. = 0x600
@@ -443,7 +453,11 @@
 	EXC_XFER_EE_LITE(0x800, kernel_fp_unavailable_exception)
 
 /* Decrementer */
+#ifdef CONFIG_IPIPE
+	EXCEPTION(0x900, Decrementer, __ipipe_grab_timer, EXC_XFER_IPIPE)
+#else /* !CONFIG_IPIPE */
 	EXCEPTION(0x900, Decrementer, timer_interrupt, EXC_XFER_LITE)
+#endif /* CONFIG_IPIPE */
 
 	EXCEPTION(0xa00, Trap_0a, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0xb00, Trap_0b, unknown_exception, EXC_XFER_EE)
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/kernel/head_44x.S linux.edit/arch/powerpc/kernel/head_44x.S
--- linux.orig/arch/powerpc/kernel/head_44x.S	2006-09-20 05:42:06.000000000 +0200
+++ linux.edit/arch/powerpc/kernel/head_44x.S	2006-11-23 13:48:22.000000000 +0100
@@ -427,7 +427,11 @@
 	INSTRUCTION_STORAGE_EXCEPTION
 
 	/* External Input Interrupt */
+#ifdef CONFIG_IPIPE
+	EXCEPTION(0x0500, ExternalInput, __ipipe_grab_irq, EXC_XFER_IPIPE)
+#else /* !CONFIG_IPIPE */
 	EXCEPTION(0x0500, ExternalInput, do_IRQ, EXC_XFER_LITE)
+#endif /* CONFIG_IPIPE */
 
 	/* Alignment Interrupt */
 	ALIGNMENT_EXCEPTION
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/kernel/head_4xx.S linux.edit/arch/powerpc/kernel/head_4xx.S
--- linux.orig/arch/powerpc/kernel/head_4xx.S	2006-09-20 05:42:06.000000000 +0200
+++ linux.edit/arch/powerpc/kernel/head_4xx.S	2006-11-23 14:05:33.000000000 +0100
@@ -228,6 +228,12 @@
 	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, NOCOPY, transfer_to_handler_full, \
 			  ret_from_except_full)
 
+#ifdef CONFIG_IPIPE
+#define EXC_XFER_IPIPE(n, hdlr)		\
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
+			  __ipipe_ret_from_except)
+#endif /* CONFIG_IPIPE */
+
 #define EXC_XFER_LITE(n, hdlr)		\
 	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
 			  ret_from_except)
@@ -396,7 +402,11 @@
 	EXC_XFER_EE_LITE(0x400, handle_page_fault)
 
 /* 0x0500 - External Interrupt Exception */
+#ifdef CONFIG_IPIPE
+	EXCEPTION(0x0500, HardwareInterrupt, __ipipe_grab_irq, EXC_XFER_IPIPE)
+#else /* !CONFIG_IPIPE */
 	EXCEPTION(0x0500, HardwareInterrupt, do_IRQ, EXC_XFER_LITE)
+#endif /* CONFIG_IPIPE */
 
 /* 0x0600 - Alignment Exception */
 	START_EXCEPTION(0x0600, Alignment)
@@ -434,7 +444,11 @@
 	lis	r0,TSR_PIS@h
 	mtspr	SPRN_TSR,r0		/* Clear the PIT exception */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
+#ifdef CONFIG_IPIPE
+	EXC_XFER_IPIPE(0x1000, __ipipe_grab_timer)
+#else /* !CONFIG_IPIPE */
 	EXC_XFER_LITE(0x1000, timer_interrupt)
+#endif /* CONFIG_IPIPE */
 
 #if 0
 /* NOTE:
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/kernel/head_8xx.S linux.edit/arch/powerpc/kernel/head_8xx.S
--- linux.orig/arch/powerpc/kernel/head_8xx.S	2006-09-20 05:42:06.000000000 +0200
+++ linux.edit/arch/powerpc/kernel/head_8xx.S	2006-11-23 14:07:15.000000000 +0100
@@ -187,6 +187,12 @@
 	EXC_XFER_TEMPLATE(n, hdlr, n, NOCOPY, transfer_to_handler_full,	\
 			  ret_from_except_full)
 
+#ifdef CONFIG_IPIPE
+#define EXC_XFER_IPIPE(n, hdlr)		\
+	EXC_XFER_TEMPLATE(n, hdlr, n+1, NOCOPY, transfer_to_handler, \
+			  __ipipe_ret_from_except)
+#endif /* CONFIG_IPIPE */
+        
 #define EXC_XFER_LITE(n, hdlr)		\
 	EXC_XFER_TEMPLATE(n, hdlr, n+1, NOCOPY, transfer_to_handler, \
 			  ret_from_except)
@@ -238,7 +244,11 @@
 	EXC_XFER_EE_LITE(0x400, handle_page_fault)
 
 /* External interrupt */
+#ifdef CONFIG_IPIPE
+	EXCEPTION(0x500, HardwareInterrupt, __ipipe_grab_irq, EXC_XFER_IPIPE)
+#else /* !CONFIG_IPIPE */
 	EXCEPTION(0x500, HardwareInterrupt, do_IRQ, EXC_XFER_LITE)
+#endif /* CONFIG_IPIPE */
 
 /* Alignment exception */
 	. = 0x600
@@ -259,7 +269,11 @@
 	EXCEPTION(0x800, FPUnavailable, unknown_exception, EXC_XFER_STD)
 
 /* Decrementer */
+#ifdef CONFIG_IPIPE
+	EXCEPTION(0x900, Decrementer, __ipipe_grab_timer, EXC_XFER_IPIPE)
+#else /* !CONFIG_IPIPE */
 	EXCEPTION(0x900, Decrementer, timer_interrupt, EXC_XFER_LITE)
+#endif /* CONFIG_IPIPE */
 
 	EXCEPTION(0xa00, Trap_0a, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0xb00, Trap_0b, unknown_exception, EXC_XFER_EE)
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/kernel/head_booke.h linux.edit/arch/powerpc/kernel/head_booke.h
--- linux.orig/arch/powerpc/kernel/head_booke.h	2006-09-20 05:42:06.000000000 +0200
+++ linux.edit/arch/powerpc/kernel/head_booke.h	2006-11-23 14:09:46.000000000 +0100
@@ -187,6 +187,12 @@
 	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, NOCOPY, transfer_to_handler_full, \
 			  ret_from_except_full)
 
+#ifdef CONFIG_IPIPE
+#define EXC_XFER_IPIPE(n, hdlr)		\
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
+			  __ipipe_ret_from_except)
+#endif /* CONFIG_IPIPE */
+
 #define EXC_XFER_LITE(n, hdlr)		\
 	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
 			  ret_from_except)
@@ -345,6 +351,15 @@
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
 	EXC_XFER_STD(0x0700, program_check_exception)
 
+#ifdef CONFIG_IPIPE
+#define DECREMENTER_EXCEPTION						      \
+	START_EXCEPTION(Decrementer)					      \
+	NORMAL_EXCEPTION_PROLOG;					      \
+	lis     r0,TSR_DIS@h;           /* Setup the DEC interrupt mask */    \
+	mtspr   SPRN_TSR,r0;		/* Clear the DEC interrupt */	      \
+	addi    r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_IPIPE(0x0900, __ipipe_grab_timer)
+#else /* !CONFIG_IPIPE */
 #define DECREMENTER_EXCEPTION						      \
 	START_EXCEPTION(Decrementer)					      \
 	NORMAL_EXCEPTION_PROLOG;					      \
@@ -352,6 +367,7 @@
 	mtspr   SPRN_TSR,r0;		/* Clear the DEC interrupt */	      \
 	addi    r3,r1,STACK_FRAME_OVERHEAD;				      \
 	EXC_XFER_LITE(0x0900, timer_interrupt)
+#endif /* CONFIG_IPIPE */
 
 #define FP_UNAVAILABLE_EXCEPTION					      \
 	START_EXCEPTION(FloatingPointUnavailable)			      \
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/kernel/head_fsl_booke.S linux.edit/arch/powerpc/kernel/head_fsl_booke.S
--- linux.orig/arch/powerpc/kernel/head_fsl_booke.S	2006-09-20 05:42:06.000000000 +0200
+++ linux.edit/arch/powerpc/kernel/head_fsl_booke.S	2006-11-23 14:10:27.000000000 +0100
@@ -526,7 +526,11 @@
 	INSTRUCTION_STORAGE_EXCEPTION
 
 	/* External Input Interrupt */
+#ifdef CONFIG_IPIPE
+	EXCEPTION(0x0500, ExternalInput, __ipipe_grab_irq, EXC_XFER_IPIPE)
+#else /* !CONFIG_IPIPE */
 	EXCEPTION(0x0500, ExternalInput, do_IRQ, EXC_XFER_LITE)
+#endif /* CONFIG_IPIPE */
 
 	/* Alignment Interrupt */
 	ALIGNMENT_EXCEPTION
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/kernel/ipipe-core.c linux.edit/arch/powerpc/kernel/ipipe-core.c
--- linux.orig/arch/powerpc/kernel/ipipe-core.c	1970-01-01 01:00:00.000000000 +0100
+++ linux.edit/arch/powerpc/kernel/ipipe-core.c	2006-11-23 14:14:28.000000000 +0100
@@ -0,0 +1,265 @@
+/* -*- linux-c -*-
+ * linux/arch/powerpc/kernel/ipipe-core.c
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
+ * Copyright (C) 2004 Wolfgang Grandegger (Adeos/ppc port over 2.4).
+ * Copyright (C) 2005 Heikki Lindholm (PowerPC 970 fixes).
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Architecture-dependent I-PIPE core support for PowerPC.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/hardirq.h>
+#include <asm/io.h>
+#include <asm/time.h>
+
+/* Current reload value for the decrementer. */
+unsigned long __ipipe_decr_ticks;
+
+/* Next tick date (timebase value). */
+unsigned long long __ipipe_decr_next[IPIPE_NR_CPUS];
+
+struct pt_regs __ipipe_tick_regs[IPIPE_NR_CPUS];
+
+#ifdef CONFIG_POWER4
+extern struct irqaction k2u3_cascade_action;
+extern int openpic2_get_irq(struct pt_regs *regs);
+#endif
+
+#ifdef CONFIG_SMP
+
+static cpumask_t __ipipe_cpu_sync_map;
+
+static cpumask_t __ipipe_cpu_lock_map;
+
+static ipipe_spinlock_t __ipipe_cpu_barrier = IPIPE_SPIN_LOCK_UNLOCKED;
+
+static atomic_t __ipipe_critical_count = ATOMIC_INIT(0);
+
+static void (*__ipipe_cpu_sync) (void);
+
+/* Always called with hw interrupts off. */
+
+void __ipipe_do_critical_sync(unsigned irq)
+{
+	ipipe_declare_cpuid;
+
+	ipipe_load_cpuid();
+
+	cpu_set(cpuid, __ipipe_cpu_sync_map);
+
+	/*
+	 * Now we are in sync with the lock requestor running on another
+	 * CPU. Enter a spinning wait until he releases the global
+	 * lock.
+	 */
+	spin_lock_hw(&__ipipe_cpu_barrier);
+
+	/* Got it. Now get out. */
+
+	if (__ipipe_cpu_sync)
+		/* Call the sync routine if any. */
+		__ipipe_cpu_sync();
+
+	spin_unlock_hw(&__ipipe_cpu_barrier);
+
+	cpu_clear(cpuid, __ipipe_cpu_sync_map);
+}
+
+#endif	/* CONFIG_SMP */
+
+/*
+ * ipipe_critical_enter() -- Grab the superlock excluding all CPUs
+ * but the current one from a critical section. This lock is used when
+ * we must enforce a global critical section for a single CPU in a
+ * possibly SMP system whichever context the CPUs are running.
+ */
+unsigned long ipipe_critical_enter(void (*syncfn) (void))
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+
+#ifdef CONFIG_SMP
+	if (num_online_cpus() > 1) {	/* We might be running a SMP-kernel on a UP box... */
+		ipipe_declare_cpuid;
+		cpumask_t lock_map;
+
+		ipipe_load_cpuid();
+
+		if (!cpu_test_and_set(cpuid, __ipipe_cpu_lock_map)) {
+			while (cpu_test_and_set(BITS_PER_LONG - 1,
+						__ipipe_cpu_lock_map)) {
+				int n = 0;
+				do {
+					cpu_relax();
+				} while (++n < cpuid);
+			}
+
+			spin_lock_hw(&__ipipe_cpu_barrier);
+
+			__ipipe_cpu_sync = syncfn;
+
+			/* Send the sync IPI to all processors but the current one. */
+			send_IPI_allbutself(IPIPE_CRITICAL_VECTOR);
+
+			cpus_andnot(lock_map, cpu_online_map,
+				    __ipipe_cpu_lock_map);
+
+			while (!cpus_equal(__ipipe_cpu_sync_map, lock_map))
+				cpu_relax();
+		}
+
+		atomic_inc(&__ipipe_critical_count);
+	}
+#endif	/* CONFIG_SMP */
+
+	return flags;
+}
+
+/* ipipe_critical_exit() -- Release the superlock. */
+
+void ipipe_critical_exit(unsigned long flags)
+{
+#ifdef CONFIG_SMP
+	if (num_online_cpus() > 1) {	/* We might be running a SMP-kernel on a UP box... */
+		ipipe_declare_cpuid;
+
+		ipipe_load_cpuid();
+
+		if (atomic_dec_and_test(&__ipipe_critical_count)) {
+			spin_unlock_hw(&__ipipe_cpu_barrier);
+
+			while (!cpus_empty(__ipipe_cpu_sync_map))
+				cpu_relax();
+
+			cpu_clear(cpuid, __ipipe_cpu_lock_map);
+			cpu_clear(BITS_PER_LONG - 1, __ipipe_cpu_lock_map);
+		}
+	}
+#endif	/* CONFIG_SMP */
+
+	local_irq_restore_hw(flags);
+}
+
+void __ipipe_init_platform(void)
+{
+	unsigned timer_virq;
+
+	/*
+	 * Allocate a virtual IRQ for the decrementer trap early to
+	 * get it mapped to IPIPE_VIRQ_BASE
+	 */
+
+	timer_virq = ipipe_alloc_virq();
+
+	if (timer_virq != IPIPE_TIMER_VIRQ)
+		panic("I-pipe: cannot reserve timer virq #%d (got #%d)",
+		      IPIPE_TIMER_VIRQ, timer_virq);
+
+	__ipipe_decr_ticks = tb_ticks_per_jiffy;
+}
+
+int ipipe_get_sysinfo(struct ipipe_sysinfo *info)
+{
+	info->ncpus = num_online_cpus();
+	info->cpufreq = ipipe_cpu_freq();
+	info->archdep.tmirq = IPIPE_TIMER_VIRQ;
+	info->archdep.tmfreq = info->cpufreq;
+
+	return 0;
+}
+
+/*
+ * ipipe_trigger_irq() -- Push the interrupt at front of the pipeline
+ * just like if it has been actually received from a hw source. Also
+ * works for virtual interrupts.
+ */
+int ipipe_trigger_irq(unsigned irq)
+{
+	unsigned long flags;
+
+	if (irq >= IPIPE_NR_IRQS ||
+	    (ipipe_virtual_irq_p(irq)
+	     && !test_bit(irq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map)))
+		return -EINVAL;
+
+	local_irq_save_hw(flags);
+
+	__ipipe_handle_irq(irq, NULL);
+
+	local_irq_restore_hw(flags);
+
+	return 1;
+}
+
+static void __ipipe_set_decr(void)
+{
+	ipipe_declare_cpuid;
+
+	ipipe_load_cpuid();
+
+	disarm_decr[cpuid] = (__ipipe_decr_ticks != tb_ticks_per_jiffy);
+#ifdef CONFIG_40x
+	/* Enable and set auto-reload. */
+	mtspr(SPRN_TCR, mfspr(SPRN_TCR) | TCR_ARE);
+	mtspr(SPRN_PIT, __ipipe_decr_ticks);
+#else	/* !CONFIG_40x */
+	__ipipe_decr_next[cpuid] = __ipipe_read_timebase() + __ipipe_decr_ticks;
+	set_dec(__ipipe_decr_ticks);
+#endif	/* CONFIG_40x */
+}
+
+int ipipe_tune_timer(unsigned long ns, int flags)
+{
+	unsigned long x, ticks;
+
+	if (flags & IPIPE_RESET_TIMER)
+		ticks = tb_ticks_per_jiffy;
+	else {
+		ticks = ns * tb_ticks_per_jiffy / (1000000000 / HZ);
+
+		if (ticks > tb_ticks_per_jiffy)
+			return -EINVAL;
+	}
+
+	x = ipipe_critical_enter(&__ipipe_set_decr);	/* Sync with all CPUs */
+	__ipipe_decr_ticks = ticks;
+	__ipipe_set_decr();
+	ipipe_critical_exit(x);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(__ipipe_decr_ticks);
+EXPORT_SYMBOL(__ipipe_decr_next);
+EXPORT_SYMBOL(ipipe_critical_enter);
+EXPORT_SYMBOL(ipipe_critical_exit);
+EXPORT_SYMBOL(ipipe_trigger_irq);
+EXPORT_SYMBOL(ipipe_get_sysinfo);
+EXPORT_SYMBOL(ipipe_tune_timer);
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/kernel/ipipe-root.c linux.edit/arch/powerpc/kernel/ipipe-root.c
--- linux.orig/arch/powerpc/kernel/ipipe-root.c	1970-01-01 01:00:00.000000000 +0100
+++ linux.edit/arch/powerpc/kernel/ipipe-root.c	2006-11-23 14:14:28.000000000 +0100
@@ -0,0 +1,498 @@
+/* -*- linux-c -*-
+ * linux/arch/powerpc/kernel/ipipe-root.c
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum (Adeos/ppc port over 2.6).
+ * Copyright (C) 2004 Wolfgang Grandegger (Adeos/ppc port over 2.4).
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Architecture-dependent I-pipe support for PowerPC.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/errno.h>
+#include <asm/unistd.h>
+#include <asm/system.h>
+#include <asm/hardirq.h>
+#include <asm/machdep.h>
+#include <asm/atomic.h>
+#include <asm/io.h>
+#include <asm/time.h>
+#include <asm/mmu_context.h>
+
+extern irq_desc_t irq_desc[];
+
+static struct hw_interrupt_type __ipipe_std_irq_dtype[NR_IRQS];
+
+static void __ipipe_override_irq_enable(unsigned irq)
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+	ipipe_irq_unlock(irq);
+	__ipipe_std_irq_dtype[irq].enable(irq);
+	local_irq_restore_hw(flags);
+}
+
+static void __ipipe_override_irq_disable(unsigned irq)
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+	ipipe_irq_lock(irq);
+	__ipipe_std_irq_dtype[irq].disable(irq);
+	local_irq_restore_hw(flags);
+}
+
+static void __ipipe_override_irq_end(unsigned irq)
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		ipipe_irq_unlock(irq);
+
+	__ipipe_std_irq_dtype[irq].end(irq);
+
+	local_irq_restore_hw(flags);
+}
+
+static void __ipipe_override_irq_affinity(unsigned irq, cpumask_t mask)
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+	__ipipe_std_irq_dtype[irq].set_affinity(irq, mask);
+	local_irq_restore_hw(flags);
+}
+
+static void __ipipe_enable_sync(void)
+{
+	__ipipe_decr_next[ipipe_processor_id()] =
+		__ipipe_read_timebase() + get_dec();
+}
+
+void __ipipe_enable_irqdesc(unsigned irq)
+{
+	irq_desc[irq].status &= ~IRQ_DISABLED;
+}
+
+/*
+ * __ipipe_enable_pipeline() -- We are running on the boot CPU, hw
+ * interrupts are off, and secondary CPUs are still lost in space.
+ */
+void __ipipe_enable_pipeline(void)
+{
+	unsigned long flags;
+	unsigned irq;
+
+	flags = ipipe_critical_enter(&__ipipe_enable_sync);
+
+	/* First, virtualize all interrupts from the root domain. */
+
+	for (irq = 0; irq < NR_IRQS; irq++)
+		ipipe_virtualize_irq(ipipe_root_domain,
+				     irq,
+				     (ipipe_irq_handler_t)&__ipipe_do_IRQ, NULL,
+				     &__ipipe_ack_irq,
+				     IPIPE_HANDLE_MASK | IPIPE_PASS_MASK);
+
+	/*
+	 * We use a virtual IRQ to handle the timer irq (decrementer trap)
+	 * which has been allocated early in __ipipe_init_platform().
+	 */
+
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     IPIPE_TIMER_VIRQ,
+			     (ipipe_irq_handler_t)&__ipipe_do_timer, NULL,
+			     NULL, IPIPE_HANDLE_MASK | IPIPE_PASS_MASK);
+
+	/*
+	 * Interpose on the IRQ control routines so we can make them
+	 * atomic using hw masking and prevent the interrupt log from
+	 * being untimely flushed.
+	 */
+
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		if (irq_desc[irq].chip != NULL)
+			__ipipe_std_irq_dtype[irq] = *irq_desc[irq].chip;
+	}
+
+	/*
+	 * The original controller structs are often shared, so we first
+	 * save them all before changing any of them. Notice that we don't
+	 * override the ack() handler since we will enforce the necessary
+	 * setup in __ipipe_ack_irq().
+	 */
+
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		struct hw_interrupt_type *handler = irq_desc[irq].chip;
+
+		if (handler == NULL)
+			continue;
+
+		if (handler->enable != NULL)
+			handler->enable = &__ipipe_override_irq_enable;
+
+		if (handler->disable != NULL)
+			handler->disable = &__ipipe_override_irq_disable;
+
+		if (handler->end != NULL)
+			handler->end = &__ipipe_override_irq_end;
+
+		if (handler->set_affinity != NULL)
+			handler->set_affinity = &__ipipe_override_irq_affinity;
+	}
+
+	__ipipe_decr_next[ipipe_processor_id()] =
+		__ipipe_read_timebase() + get_dec();
+
+	ipipe_critical_exit(flags);
+}
+
+int __ipipe_ack_irq(unsigned irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	unsigned long flags;
+	ipipe_declare_cpuid;
+
+	if (desc->chip->ack == NULL)
+		return 1;
+
+	/*
+	 * No need to mask IRQs at hw level: we are always called from
+	 * __ipipe_handle_irq(), so interrupts are already off. We
+	 * stall the pipeline so that spin_lock_irq*() ops won't
+	 * unintentionally flush it, since this could cause infinite
+	 * recursion.
+	 */
+
+	ipipe_load_cpuid();
+	flags = ipipe_test_and_stall_pipeline();
+	preempt_disable();
+	desc->chip->ack(irq);
+#ifdef CONFIG_POWER4
+	/* if it is a k2u3 cascaded irq, acknowledge it, also */
+	if (desc->action == &k2u3_cascade_action) {
+		struct pt_regs regs;
+		int irq2 = openpic2_get_irq(&regs);
+		if (irq2 != -1) {
+			irq_desc_t *desc2 = irq_desc + irq2;
+			if (desc2->chip->ack)
+				desc2->chip->ack(irq2);
+		}
+	}
+#endif
+	preempt_enable_no_resched();
+	ipipe_restore_pipeline_nosync(ipipe_percpu_domain[cpuid], flags, cpuid);
+
+	return 1;
+}
+
+/*
+ * __ipipe_handle_irq() -- IPIPE's generic IRQ handler. An optimistic
+ * interrupt protection log is maintained here for each domain. Hw
+ * interrupts are off on entry.
+ */
+void __ipipe_handle_irq(int irq, struct pt_regs *regs)
+{
+	struct ipipe_domain *this_domain, *next_domain;
+	struct list_head *head, *pos;
+	ipipe_declare_cpuid;
+	int m_ack, s_ack;
+
+	m_ack = (regs == NULL);	/* Software-triggered IRQs do not need
+				 * any ack. */
+	if (irq >= IPIPE_NR_IRQS) {
+		printk(KERN_ERR "I-pipe: spurious interrupt %d\n", irq);
+		return;
+	}
+
+	ipipe_load_cpuid();
+
+	this_domain = ipipe_percpu_domain[cpuid];
+
+	if (unlikely(test_bit(IPIPE_STICKY_FLAG, &this_domain->irqs[irq].control)))
+		head = &this_domain->p_link;
+	else {
+		head = __ipipe_pipeline.next;
+		next_domain = list_entry(head, struct ipipe_domain, p_link);
+		if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control))) {
+			if (!m_ack && next_domain->irqs[irq].acknowledge != NULL)
+				next_domain->irqs[irq].acknowledge(irq);
+			if (likely(__ipipe_dispatch_wired(next_domain, irq)))
+			    goto finalize;
+			return;
+		}
+	}
+
+	/* Ack the interrupt. */
+
+	s_ack = m_ack;
+	pos = head;
+
+	while (pos != &__ipipe_pipeline) {
+		next_domain = list_entry(pos, struct ipipe_domain, p_link);
+		/*
+		 * For each domain handling the incoming IRQ, mark it as
+		 * pending in its log.
+		 */
+		if (test_bit(IPIPE_HANDLE_FLAG,
+			     &next_domain->irqs[irq].control)) {
+			/*
+			 * Domains that handle this IRQ are polled for
+			 * acknowledging it by decreasing priority order. The
+			 * interrupt must be made pending _first_ in the
+			 * domain's status flags before the PIC is unlocked.
+			 */
+
+			next_domain->cpudata[cpuid].irq_counters[irq].total_hits++;
+			next_domain->cpudata[cpuid].irq_counters[irq].pending_hits++;
+			__ipipe_set_irq_bit(next_domain, cpuid, irq);
+
+			/*
+			 * Always get the first master acknowledge available.
+			 * Once we've got it, allow slave acknowledge
+			 * handlers to run (until one of them stops us).
+			 */
+			if (next_domain->irqs[irq].acknowledge != NULL) {
+				if (!m_ack)
+					m_ack = next_domain->irqs[irq].acknowledge(irq);
+				else if (test_bit
+					 (IPIPE_SHARED_FLAG,
+					  &next_domain->irqs[irq].control) && !s_ack)
+					s_ack = next_domain->irqs[irq].acknowledge(irq);
+			}
+		}
+
+		/*
+		 * If the domain does not want the IRQ to be passed down the
+		 * interrupt pipe, exit the loop now.
+		 */
+
+		if (!test_bit(IPIPE_PASS_FLAG, &next_domain->irqs[irq].control))
+			break;
+
+		pos = next_domain->p_link.next;
+	}
+
+finalize:
+	/*
+	 * Now walk the pipeline, yielding control to the highest
+	 * priority domain that has pending interrupt(s) or
+	 * immediately to the current domain if the interrupt has been
+	 * marked as 'sticky'. This search does not go beyond the
+	 * current domain in the pipeline.
+	 */
+
+	__ipipe_walk_pipeline(head, cpuid);
+}
+
+int __ipipe_grab_irq(struct pt_regs *regs)
+{
+	extern int ppc_spurious_interrupts;
+	ipipe_declare_cpuid;
+	int irq;
+
+	if ((irq = ppc_md.get_irq(regs)) >= 0) {
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+		ipipe_trace_begin(irq);
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+		__ipipe_handle_irq(irq, regs);
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+		ipipe_trace_end(irq);
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+	}
+	else if (irq != -2)
+		ppc_spurious_interrupts++;
+
+	ipipe_load_cpuid();
+
+	return (ipipe_percpu_domain[cpuid] == ipipe_root_domain &&
+		!test_bit(IPIPE_STALL_FLAG,
+			  &ipipe_root_domain->cpudata[cpuid].status));
+}
+
+void __ipipe_do_IRQ(int irq, struct pt_regs *regs)
+{
+	irq_enter();
+	__do_IRQ(irq, regs);
+	irq_exit();
+}
+
+int __ipipe_grab_timer(struct pt_regs *regs)
+{
+	ipipe_declare_cpuid;
+
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+	ipipe_trace_begin(IPIPE_TIMER_VIRQ);
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+
+#ifdef CONFIG_POWER4
+	/* On 970 CPUs DEC cannot be disabled, and without setting DEC
+	 * here, DEC interrupt would be triggered as soon as interrupts
+	 * are enabled in __ipipe_sync_stage
+	 */
+	set_dec(0x7fffffff);
+#endif
+
+	__ipipe_tick_regs[cpuid].msr = regs->msr; /* for do_timer() */
+
+#ifndef CONFIG_40x
+	if (__ipipe_decr_ticks != tb_ticks_per_jiffy) {
+		unsigned long long next_date, now;
+
+		next_date = __ipipe_decr_next[cpuid];
+
+		while ((now = __ipipe_read_timebase()) >= next_date)
+			next_date += __ipipe_decr_ticks;
+
+		set_dec(next_date - now);
+
+		__ipipe_decr_next[cpuid] = next_date;
+	}
+#endif	/* !CONFIG_40x */
+
+	__ipipe_handle_irq(IPIPE_TIMER_VIRQ, regs);
+
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+	ipipe_trace_end(IPIPE_TIMER_VIRQ);
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+
+	ipipe_load_cpuid();
+
+	return (ipipe_percpu_domain[cpuid] == ipipe_root_domain &&
+		!test_bit(IPIPE_STALL_FLAG,
+			  &ipipe_root_domain->cpudata[cpuid].status));
+}
+
+void __ipipe_do_timer(int irq, struct pt_regs *regs)
+{
+	timer_interrupt(regs);
+}
+
+int __ipipe_check_root(struct pt_regs *regs)
+{
+	ipipe_declare_cpuid;
+	/*
+	 * This routine is called with hw interrupts off, so no migration
+	 * can occur while checking the identity of the current domain.
+	 */
+	ipipe_load_cpuid();
+	return ipipe_percpu_domain[cpuid] == ipipe_root_domain;
+}
+
+void __ipipe_fast_stall_root(void)
+{
+	ipipe_declare_cpuid;
+	unsigned long flags;
+
+	ipipe_get_cpu(flags); /* Care for migration. */
+
+	set_bit(IPIPE_STALL_FLAG,
+		&ipipe_root_domain->cpudata[cpuid].status);
+
+	ipipe_put_cpu(flags);
+}
+
+void __ipipe_fast_unstall_root(void)
+{
+	ipipe_declare_cpuid;
+	unsigned long flags;
+
+	ipipe_get_cpu(flags); /* Care for migration. */
+
+	clear_bit(IPIPE_STALL_FLAG,
+		  &ipipe_root_domain->cpudata[cpuid].status);
+
+	ipipe_put_cpu(flags);
+}
+
+int __ipipe_syscall_root(struct pt_regs *regs)
+{
+	ipipe_declare_cpuid;
+	unsigned long flags;
+
+	/*
+	 * This routine either returns:
+	 * 0 -- if the syscall is to be passed to Linux;
+	 * >0 -- if the syscall should not be passed to Linux, and no
+	 * tail work should be performed;
+	 * <0 -- if the syscall should not be passed to Linux but the
+	 * tail work has to be performed (for handling signals etc).
+	 */
+
+	if (__ipipe_syscall_watched_p(current, regs->gpr[0]) &&
+	    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL) &&
+	    __ipipe_dispatch_event(IPIPE_EVENT_SYSCALL,regs) > 0) {
+		/*
+		 * We might enter here over a non-root domain and exit
+		 * over the root one as a result of the syscall
+		 * (i.e. by recycling the register set of the current
+		 * context across the migration), so we need to fixup
+		 * the interrupt flag upon return too, so that
+		 * __ipipe_unstall_iret_root() resets the correct
+		 * stall bit on exit.
+		 */
+		if (ipipe_current_domain == ipipe_root_domain && !in_atomic()) {
+			/*
+			 * Sync pending VIRQs before _TIF_NEED_RESCHED
+			 * is tested.
+			 */
+			ipipe_lock_cpu(flags);
+			if ((ipipe_root_domain->cpudata[cpuid].irq_pending_hi & IPIPE_IRQMASK_VIRT) != 0)
+				__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
+			ipipe_unlock_cpu(flags);
+			return -1;
+		}
+		return 1;
+	}
+
+	return 0;
+}
+
+void atomic_set_mask(unsigned long mask,
+		     unsigned long *ptr);
+
+void atomic_clear_mask(unsigned long mask,
+		       unsigned long *ptr);
+
+extern unsigned long context_map[];
+
+EXPORT_SYMBOL_GPL(__switch_to);
+EXPORT_SYMBOL_GPL(show_stack);
+EXPORT_SYMBOL_GPL(atomic_set_mask);
+EXPORT_SYMBOL_GPL(atomic_clear_mask);
+EXPORT_SYMBOL_GPL(context_map);
+EXPORT_SYMBOL_GPL(_switch);
+EXPORT_SYMBOL_GPL(last_task_used_math);
+#ifdef FEW_CONTEXTS
+EXPORT_SYMBOL_GPL(nr_free_contexts);
+EXPORT_SYMBOL_GPL(context_mm);
+EXPORT_SYMBOL_GPL(steal_context);
+#endif
+
+#ifdef CONFIG_IPIPE_TRACE
+void notrace _mcount(void);
+EXPORT_SYMBOL(_mcount);
+#endif /* CONFIG_IPIPE_TRACE */
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/kernel/Makefile linux.edit/arch/powerpc/kernel/Makefile
--- linux.orig/arch/powerpc/kernel/Makefile	2006-11-23 13:25:13.000000000 +0100
+++ linux.edit/arch/powerpc/kernel/Makefile	2006-11-23 14:15:46.000000000 +0100
@@ -58,6 +58,8 @@
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o
+obj-$(CONFIG_IPIPE)		+= ipipe-core.o ipipe-root.o
+obj-$(CONFIG_IPIPE_TRACE)	+= ipipe-mcount.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/kernel/traps.c linux.edit/arch/powerpc/kernel/traps.c
--- linux.orig/arch/powerpc/kernel/traps.c	2006-11-23 13:25:13.000000000 +0100
+++ linux.edit/arch/powerpc/kernel/traps.c	2006-11-23 14:31:04.000000000 +0100
@@ -326,6 +326,9 @@
 	int recover = 0;
 	unsigned long reason = get_mc_reason(regs);
 
+        if (ipipe_trap_notify(IPIPE_TRAP_MCE,regs))
+                return;
+        
 	/* See if any machine dependent calls */
 	if (ppc_md.machine_check_exception)
 		recover = ppc_md.machine_check_exception(regs);
@@ -492,6 +495,8 @@
 
 void unknown_exception(struct pt_regs *regs)
 {
+        if (ipipe_trap_notify(IPIPE_TRAP_UNKNOWN,regs))
+	    	return;
 	printk("Bad trap at PC: %lx, SR: %lx, vector=%lx\n",
 	       regs->nip, regs->msr, regs->trap);
 
@@ -500,6 +505,8 @@
 
 void instruction_breakpoint_exception(struct pt_regs *regs)
 {
+        if (ipipe_trap_notify(IPIPE_TRAP_IABR,regs))
+	    	return;
 	if (notify_die(DIE_IABR_MATCH, "iabr_match", regs, 5,
 					5, SIGTRAP) == NOTIFY_STOP)
 		return;
@@ -510,12 +517,16 @@
 
 void RunModeException(struct pt_regs *regs)
 {
+        if (ipipe_trap_notify(IPIPE_TRAP_RM,regs))
+	    	return;
 	_exception(SIGTRAP, regs, 0, 0);
 }
 
 void __kprobes single_step_exception(struct pt_regs *regs)
 {
 	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
+        if (ipipe_trap_notify(IPIPE_TRAP_SSTEP,regs))
+	    	return;
 
 	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
 					5, SIGTRAP) == NOTIFY_STOP)
@@ -763,6 +774,9 @@
 	unsigned int reason = get_reason(regs);
 	extern int do_mathemu(struct pt_regs *regs);
 
+        if (ipipe_trap_notify(IPIPE_TRAP_PCE,regs))
+	    	return;
+
 #ifdef CONFIG_MATH_EMULATION
 	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
 	 * but there seems to be a hardware bug on the 405GP (RevD)
@@ -832,6 +846,9 @@
 		return;
 	}
 
+        if (ipipe_trap_notify(IPIPE_TRAP_ALIGNMENT,regs))
+	    	return;
+        
 	/* Operand address was bad */
 	if (fixed == -EFAULT) {
 		if (user_mode(regs))
@@ -855,6 +872,8 @@
 
 void nonrecoverable_exception(struct pt_regs *regs)
 {
+        if (ipipe_trap_notify(IPIPE_TRAP_NREC,regs))
+	    	return;
 	printk(KERN_ERR "Non-recoverable exception at PC=%lx MSR=%lx\n",
 	       regs->nip, regs->msr);
 	debugger(regs);
@@ -877,6 +896,8 @@
 
 void altivec_unavailable_exception(struct pt_regs *regs)
 {
+        if (ipipe_trap_notify(IPIPE_TRAP_ALTUNAVAIL,regs))
+	    	return;
 #if !defined(CONFIG_ALTIVEC)
 	if (user_mode(regs)) {
 		/* A user program has executed an altivec instruction,
@@ -902,6 +923,9 @@
 	extern int Soft_emulate_8xx(struct pt_regs *);
 	int errcode;
 
+        if (ipipe_trap_notify(IPIPE_TRAP_SOFTEMU,regs))
+	    	return;
+        
 	CHECK_FULL_REGS(regs);
 
 	if (!user_mode(regs)) {
@@ -930,6 +954,8 @@
 
 void DebugException(struct pt_regs *regs, unsigned long debug_status)
 {
+        if (ipipe_trap_notify(IPIPE_TRAP_DEBUG,regs))
+	    	return;
 	if (debug_status & DBSR_IC) {	/* instruction completion */
 		regs->msr &= ~MSR_DE;
 		if (user_mode(regs)) {
@@ -960,6 +986,9 @@
 {
 	int err;
 
+        if (ipipe_trap_notify(IPIPE_TRAP_ALTASSIST,regs))
+	    	return;
+        
 	if (!user_mode(regs)) {
 		printk(KERN_EMERG "VMX/Altivec assist exception in kernel mode"
 		       " at %lx\n", regs->nip);
@@ -1010,6 +1039,9 @@
 	int fpexc_mode;
 	int code = 0;
 
+        if (ipipe_trap_notify(IPIPE_TRAP_SPE,regs))
+	    	return;
+
 	spefscr = current->thread.spefscr;
 	fpexc_mode = current->thread.fpexc_mode;
 
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/arch/powerpc/mm/mmu_context_64.c linux.edit/arch/powerpc/mm/mmu_context_64.c
--- linux.orig/arch/powerpc/mm/mmu_context_64.c	2006-09-20 05:42:06.000000000 +0200
+++ linux.edit/arch/powerpc/mm/mmu_context_64.c	2006-11-23 16:04:04.000000000 +0100
@@ -59,9 +59,12 @@
 
 void destroy_context(struct mm_struct *mm)
 {
+        unsigned long flags;
+        local_irq_save_hw_cond(flags);
 	spin_lock(&mmu_context_lock);
 	idr_remove(&mmu_context_idr, mm->context.id);
 	spin_unlock(&mmu_context_lock);
 
 	mm->context.id = NO_CONTEXT;
+        local_irq_restore_hw_cond(flags);
 }
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/include/asm-powerpc/ipipe.h linux.edit/include/asm-powerpc/ipipe.h
--- linux.orig/include/asm-powerpc/ipipe.h	1970-01-01 01:00:00.000000000 +0100
+++ linux.edit/include/asm-powerpc/ipipe.h	2006-11-23 16:30:20.000000000 +0100
@@ -0,0 +1,218 @@
+/* -*- linux-c -*-
+ * include/asm-powerpc/ipipe.h
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __POWERPC_IPIPE_H
+#define __POWERPC_IPIPE_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_IPIPE
+
+#ifdef FIXME
+#include <asm/ptrace.h>
+#include <asm/irq.h>
+#include <asm/bitops.h>
+#include <asm/time.h>
+#include <linux/list.h>
+#include <linux/cpumask.h>
+#include <linux/threads.h>
+#else
+#include <asm/irq.h>
+#include <linux/cpumask.h>
+#endif
+
+#define IPIPE_ARCH_STRING	"1.4-01"
+#define IPIPE_MAJOR_NUMBER	1
+#define IPIPE_MINOR_NUMBER	4
+#define IPIPE_PATCH_NUMBER	1
+
+#define IPIPE_NR_XIRQS		NR_IRQS
+#define IPIPE_IRQ_ISHIFT	5	/* 25 for 32bits arch. */
+
+/*
+ * The first virtual interrupt is reserved for the timer (see
+ * __ipipe_init_platform).
+ */
+#define IPIPE_TIMER_VIRQ	IPIPE_VIRQ_BASE
+
+#ifdef CONFIG_SMP
+#error "I-pipe/ppc: SMP not yet implemented"
+#define ipipe_processor_id()	(current_thread_info()->cpu)
+#else /* !CONFIG_SMP */
+#define ipipe_processor_id()	0
+#endif	/* CONFIG_SMP */
+
+#define prepare_arch_switch(next)				\
+do {								\
+	ipipe_schedule_notify(current, next);			\
+	local_irq_disable_hw();					\
+} while(0)
+
+#define task_hijacked(p)					\
+	( {							\
+	int x = ipipe_current_domain != ipipe_root_domain;	\
+	__clear_bit(IPIPE_SYNC_FLAG,				\
+		    &ipipe_root_domain->cpudata[task_cpu(p)].status); \
+	local_irq_enable_hw(); x;				\
+	} )
+
+ /* PPC traps */
+#define IPIPE_TRAP_ACCESS	 0	/* Data or instruction access exception */
+#define IPIPE_TRAP_ALIGNMENT	 1	/* Alignment exception */
+#define IPIPE_TRAP_ALTUNAVAIL	 2	/* Altivec unavailable */
+#define IPIPE_TRAP_PCE		 3	/* Program check exception */
+#define IPIPE_TRAP_MCE		 4	/* Machine check exception */
+#define IPIPE_TRAP_UNKNOWN	 5	/* Unknown exception */
+#define IPIPE_TRAP_IABR		 6	/* Instruction breakpoint */
+#define IPIPE_TRAP_RM		 7	/* Run mode exception */
+#define IPIPE_TRAP_SSTEP	 8	/* Single-step exception */
+#define IPIPE_TRAP_NREC		 9	/* Non-recoverable exception */
+#define IPIPE_TRAP_SOFTEMU	10	/* Software emulation */
+#define IPIPE_TRAP_DEBUG	11	/* Debug exception */
+#define IPIPE_TRAP_SPE		12	/* SPE exception */
+#define IPIPE_TRAP_ALTASSIST	13	/* Altivec assist exception */
+#define IPIPE_NR_FAULTS		14
+/* Pseudo-vectors used for kernel events */
+#define IPIPE_FIRST_EVENT	IPIPE_NR_FAULTS
+#define IPIPE_EVENT_SYSCALL	(IPIPE_FIRST_EVENT)
+#define IPIPE_EVENT_SCHEDULE	(IPIPE_FIRST_EVENT + 1)
+#define IPIPE_EVENT_SIGWAKE	(IPIPE_FIRST_EVENT + 2)
+#define IPIPE_EVENT_SETSCHED	(IPIPE_FIRST_EVENT + 3)
+#define IPIPE_EVENT_INIT	(IPIPE_FIRST_EVENT + 4)
+#define IPIPE_EVENT_EXIT	(IPIPE_FIRST_EVENT + 5)
+#define IPIPE_EVENT_CLEANUP	(IPIPE_FIRST_EVENT + 6)
+#define IPIPE_LAST_EVENT	IPIPE_EVENT_CLEANUP
+#define IPIPE_NR_EVENTS		(IPIPE_LAST_EVENT + 1)
+
+struct ipipe_domain;
+
+struct ipipe_sysinfo {
+
+	int ncpus;		/* Number of CPUs on board */
+	u64 cpufreq;		/* CPU frequency (in Hz) */
+
+	/* Arch-dependent block */
+
+	struct {
+		unsigned tmirq;	/* Timer tick IRQ */
+		u64 tmfreq;	/* Timer frequency */
+	} archdep;
+};
+
+#define ipipe_read_tsc(t)					\
+	({							\
+	unsigned long __tbu;					\
+	__asm__ __volatile__ ("1: mftbu %0\n"			\
+			      "mftb %1\n"			\
+			      "mftbu %2\n"			\
+			      "cmpw %2,%0\n"			\
+			      "bne- 1b\n"			\
+			      :"=r" (((unsigned long *)&t)[0]),	\
+			      "=r" (((unsigned long *)&t)[1]),	\
+			      "=r" (__tbu));			\
+	t;							\
+	})
+
+#define __ipipe_read_timebase()					\
+	({							\
+	unsigned long long t;					\
+	ipipe_read_tsc(t);					\
+	t;							\
+	})
+
+#define ipipe_cpu_freq()	(HZ * tb_ticks_per_jiffy)
+#define ipipe_tsc2ns(t)		((((unsigned long)(t)) * 1000) / (ipipe_cpu_freq() / 1000000))
+
+#define ipipe_tsc2us(t) \
+({ \
+    unsigned long long delta = (t); \
+    do_div(delta, ipipe_cpu_freq()/1000000+1);	\
+    (unsigned long)delta; \
+})
+
+/* Private interface -- Internal use only */
+
+#define __ipipe_check_platform()	do { } while(0)
+
+#define __ipipe_enable_irq(irq)	enable_irq(irq)
+
+#define __ipipe_disable_irq(irq)	disable_irq(irq)
+
+void __ipipe_enable_irqdesc(unsigned irq);
+
+void __ipipe_init_platform(void);
+
+void __ipipe_enable_pipeline(void);
+
+int __ipipe_ack_irq(unsigned irq);
+
+void __ipipe_do_IRQ(int irq,
+		    struct pt_regs *regs);
+
+void __ipipe_do_timer(int irq,
+		      struct pt_regs *regs);
+
+void __ipipe_do_critical_sync(unsigned irq);
+
+extern unsigned long __ipipe_decr_ticks;
+
+extern unsigned long long __ipipe_decr_next[];
+
+extern struct pt_regs __ipipe_tick_regs[];
+
+void __ipipe_handle_irq(int irq,
+			struct pt_regs *regs);
+
+#define __ipipe_tick_irq	IPIPE_TIMER_VIRQ
+
+static inline unsigned long __ipipe_ffnz(unsigned long ul)
+{
+	__asm__ __volatile__("cntlzw %0, %1":"=r"(ul):"r"(ul & (-ul)));
+	return 31 - ul;
+}
+
+/* When running handlers, enable hw interrupts for all domains but the
+ * one heading the pipeline, so that IRQs can never be significantly
+ * deferred for the latter. */
+#define __ipipe_run_isr(ipd, irq, cpuid) 	\
+do {					 	\
+	local_irq_enable_nohead(ipd);		\
+	if (ipd == ipipe_root_domain) {		\
+		((void (*)(unsigned, struct pt_regs *))			\
+		 ipd->irqs[irq].handler) (irq, __ipipe_tick_regs + cpuid); \
+	} else {							\
+		__clear_bit(IPIPE_SYNC_FLAG, &cpudata->status);		\
+		ipd->irqs[irq].handler(irq,ipd->irqs[irq].cookie);	\
+		__set_bit(IPIPE_SYNC_FLAG, &cpudata->status);		\
+	}								\
+	local_irq_disable_nohead(ipd);					\
+} while(0)
+
+#define __ipipe_syscall_watched_p(p, sc)	\
+	(((p)->flags & PF_EVNOTIFY) || (unsigned long)sc >= NR_syscalls)
+
+#else /* !CONFIG_IPIPE */
+
+#define task_hijacked(p)	0
+
+#endif /* CONFIG_IPIPE */
+
+#endif	/* !__POWERPC_IPIPE_H */
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/include/asm-powerpc/mmu_context.h linux.edit/include/asm-powerpc/mmu_context.h
--- linux.orig/include/asm-powerpc/mmu_context.h	2006-09-20 05:42:06.000000000 +0200
+++ linux.edit/include/asm-powerpc/mmu_context.h	2006-11-23 16:06:11.000000000 +0100
@@ -74,9 +74,9 @@
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+        local_irq_save_hw_cond(flags);
 	switch_mm(prev, next, current);
-	local_irq_restore(flags);
+        local_irq_restore_hw_cond(flags);
 }
 
 #endif /* CONFIG_PPC64 */
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/include/asm-powerpc/pgalloc.h linux.edit/include/asm-powerpc/pgalloc.h
--- linux.orig/include/asm-powerpc/pgalloc.h	2006-09-20 05:42:06.000000000 +0200
+++ linux.edit/include/asm-powerpc/pgalloc.h	2006-11-23 16:06:53.000000000 +0100
@@ -155,6 +155,11 @@
 
 #define check_pgt_cache()	do { } while (0)
 
+static inline void set_pgdir(unsigned long address, pgd_t entry)
+{
+    /* nop */
+}
+
 #endif /* CONFIG_PPC64 */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_PGALLOC_H */
diff -NEwabur -x '*~' -x linux.orig -x '*.rej' linux.orig/include/linux/radix-tree.h linux.edit/include/linux/radix-tree.h
--- linux.orig/include/linux/radix-tree.h	2006-09-20 05:42:06.000000000 +0200
+++ linux.edit/include/linux/radix-tree.h	2006-11-23 16:39:57.000000000 +0100
@@ -19,7 +19,6 @@
 #ifndef _LINUX_RADIX_TREE_H
 #define _LINUX_RADIX_TREE_H
 
-#include <linux/sched.h>
 #include <linux/preempt.h>
 #include <linux/types.h>
 
@@ -32,6 +31,8 @@
 	struct radix_tree_node	*rnode;
 };
 
+#include <linux/sched.h>
+
 #define RADIX_TREE_INIT(mask)	{					\
 	.height = 0,							\
 	.gfp_mask = (mask),						\

--Multipart=_Fri__24_Nov_2006_10_53_46_+0100_Nm28cBXAJpoxjaBr--

