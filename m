From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/2] ARM: irq_pipeline: preserve lockdep irq state across
 kernel entries
Date: Sun, 13 Jun 2021 17:55:22 +0200
Message-Id: <20210613155522.1851338-2-rpm@xenomai.org>
In-Reply-To: <20210613155522.1851338-1-rpm@xenomai.org>
References: <20210613155522.1851338-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

When lockdep is enabled, per_cpu(hardirqs_enabled) may not be in sync
with the in-band stall bit on kernel entry upon preemption by an
IRQ. This may happen since the relevant local_irq_* calls do not
manipulate the stall bit and the lockdep irq state atomically (for a
good reason). In addition, the raw_local_irq API may be used directly,
without lockdep tracking whatsoever (e.g. when manipulating raw
spinlocks).

As a result, the kernel may observe a stalled in-band stage, with
per_cpu(hardirqs_enabled) not mirroring the interrupt state, e.g.:

/* in-band, irqs_disabled=0, percpu(hardirqs_enabled)=1 */
raw_local_irq_irqsave /* e.g. raw_spin_lock */
/* irqs_disabled=1, percpu(hardirqs_enabled)=1 */
	<IRQ>
	trace_hardirqs_off_pipelined /* on entry */
		trace_hardirqs_off
		/* irqs_disabled=1, percpu(hardirqs_enabled)=0 */
		....
	trace_hardirqs_on_pipelined /* irqs_disabled on exit -> skips trace_hardirqs_on */
	</IRQ> /* percpu(hardirqs_enabled) still 0 */
raw_local_irq_restore
WARN_ON(lockdep_assert_irqs_enabled()); /* TRIGGERS! */

kentry_enter_pipelined and kentry_exit_pipelined are introduced to
preserve the full irq state for the in-band stage across a kernel
entry (IRQ and fault), which is comprised of the stall bit and the
lockdep irq state (per_cpu(hardirqs_enabled)) now tracked
independently.

These helpers are normally called from the kernel entry/exit code in
the asm section by architectures which do not use the generic kernel
entry code, in order to save the interrupt and lockdep states for the
in-band stage on entry, restoring them when leaving the kernel.

At this chance, the pipelined fault entry/exit routines are simplified
by relying on these helpers for preserving the virtual interrupt state
across the fault handling code.

This fixes random kernel splats with CONFIG_PROVE_LOCKING enabled such
as:

[   25.735750] WARNING: CPU: 0 PID: 65 at kernel/softirq.c:175 __local_bh_enable_ip+0x1e4/0x264
[   25.747380] Modules linked in:
[   25.750529] CPU: 0 PID: 65 Comm: kworker/u3:1 Not tainted 5.10.42-00593-g5753d0a33341-dirty #5
[   25.759307] Hardware name: Generic AM33XX (Flattened Device Tree)
[   25.765463] IRQ stage: Linux
[   25.768473] Workqueue: xprtiod xs_stream_data_receive_workfn
[   25.774237] [<c030fe14>] (unwind_backtrace) from [<c030c3f8>] (show_stack+0x10/0x14)
[   25.782129] [<c030c3f8>] (show_stack) from [<c033cf30>] (__warn+0x118/0x11c)
[   25.789317] [<c033cf30>] (__warn) from [<c033cfe4>] (warn_slowpath_fmt+0xb0/0xb8)
[   25.796944] [<c033cfe4>] (warn_slowpath_fmt) from [<c0342cc0>] (__local_bh_enable_ip+0x1e4/0x264)
[   25.805904] [<c0342cc0>] (__local_bh_enable_ip) from [<c0f778b0>] (tcp_recvmsg+0x31c/0xa54)
[   25.814402] [<c0f778b0>] (tcp_recvmsg) from [<c0fb17a8>] (inet_recvmsg+0x48/0x70)
[   25.822024] [<c0fb17a8>] (inet_recvmsg) from [<c1072b90>] (xs_sock_recvmsg.constprop.9+0x24/0x40)
[   25.831042] [<c1072b90>] (xs_sock_recvmsg.constprop.9) from [<c1073e34>] (xs_stream_data_receive_workfn+0xe0/0x630)
[   25.841652] [<c1073e34>] (xs_stream_data_receive_workfn) from [<c035b008>] (process_one_work+0x2f8/0x7b4)
[   25.851367] [<c035b008>] (process_one_work) from [<c035b508>] (worker_thread+0x44/0x594)
[   25.859605] [<c035b508>] (worker_thread) from [<c0361c6c>] (kthread+0x16c/0x184)
[   25.867142] [<c0361c6c>] (kthread) from [<c0300184>] (ret_from_fork+0x14/0x30)
[   25.874431] Exception stack(0xc406ffb0 to 0xc406fff8)
[   25.879610] ffa0:                                     00000000 00000000 00000000 00000000
[   25.887946] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   25.896197] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   25.902936] irq event stamp: 81142
[   25.906460] hardirqs last  enabled at (81152): [<c0394420>] console_unlock+0x374/0x5cc
[   25.914451] hardirqs last disabled at (81159): [<c03943f0>] console_unlock+0x344/0x5cc
[   25.922516] softirqs last  enabled at (80912): [<c0ec18a4>] lock_sock_nested+0x30/0x84
[   25.930572] softirqs last disabled at (80915): [<c0ec494c>] release_sock+0x18/0x98

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/arm/include/asm/irq_pipeline.h   | 10 ++++
 arch/arm/include/asm/ptrace.h         |  3 ++
 arch/arm/kernel/entry-armv.S          |  7 ++-
 arch/arm/kernel/entry-header.S        | 16 +++++--
 arch/arm/mm/fault.c                   | 59 +++++++----------------
 arch/arm64/include/asm/irq_pipeline.h | 11 +++++
 kernel/irq/pipeline.c                 | 67 +++++++++++++++++++++++++++
 7 files changed, 125 insertions(+), 48 deletions(-)

diff --git a/arch/arm/include/asm/irq_pipeline.h b/arch/arm/include/asm/irq_pipeline.h
index f7db0a7dd89045a..5970c6d86ddafb7 100644
--- a/arch/arm/include/asm/irq_pipeline.h
+++ b/arch/arm/include/asm/irq_pipeline.h
@@ -88,6 +88,16 @@ static inline int arch_enable_oob_stage(void)
 	return 0;
 }
 
+#define arch_kentry_get_irqstate(__regs)		\
+	({						\
+		to_svc_pt_regs(__regs)->irqstate;	\
+	})
+
+#define arch_kentry_set_irqstate(__regs, __irqstate)		\
+	do {							\
+		to_svc_pt_regs(__regs)->irqstate = __irqstate;	\
+	} while (0)
+
 #else /* !CONFIG_IRQ_PIPELINE */
 
 static inline unsigned long arch_local_irq_save(void)
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 91d6b7856be4bde..514c9085105a9b0 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -20,6 +20,9 @@ struct svc_pt_regs {
 	struct pt_regs regs;
 	u32 dacr;
 	u32 addr_limit;
+#ifdef CONFIG_IRQ_PIPELINE
+	long irqstate;
+#endif
 };
 
 #define to_svc_pt_regs(r) container_of(r, struct svc_pt_regs, regs)
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index d427498dc3ed4c6..bfdcf05de733e19 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -192,8 +192,11 @@ ENDPROC(__und_invalid)
 	uaccess_entry tsk, r0, r1, r2, \uaccess
 
 	.if \trace
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off_pipelined
+#ifdef CONFIG_IRQ_PIPELINE
+	mov	r0, sp
+	bl	kentry_enter_pipelined
+#elif defined(CONFIG_TRACE_IRQFLAGS)
+	bl	trace_hardirqs_off
 #endif
 	.endif
 	.endm
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index e130f7c2ca188d1..efeaae7c180a61a 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -203,19 +203,25 @@
 	.macro	svc_exit, rpsr, irq = 0
 	.if	\irq != 0
 	@ IRQs already off
-#ifdef CONFIG_TRACE_IRQFLAGS
 	@ The parent context IRQs must have been enabled to get here in
 	@ the first place, so there's no point checking the PSR I bit.
-	bl	trace_hardirqs_on_pipelined
+#ifdef CONFIG_IRQ_PIPELINE
+	mov	r0, sp
+	bl	kentry_exit_pipelined
+#elif defined(CONFIG_TRACE_IRQFLAGS)
+	bl	trace_hardirqs_on
 #endif
 	.else
 	@ IRQs off again before pulling preserved data off the stack
 	disable_irq_notrace
-#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_IRQ_PIPELINE
+	mov	r0, sp
+	bl	kentry_exit_pipelined
+#elif defined(CONFIG_TRACE_IRQFLAGS)
 	tst	\rpsr, #PSR_I_BIT
-	bleq	trace_hardirqs_on_pipelined
+	bleq	trace_hardirqs_on
 	tst	\rpsr, #PSR_I_BIT
-	blne	trace_hardirqs_off_pipelined
+	blne	trace_hardirqs_off
 #endif
 	.endif
 	uaccess_exit tsk, r0, r1
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 064eac261932430..96e48d7a371d58f 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -36,70 +36,47 @@
  * interrupt state we received on entry, then turn hardirqs back on to
  * allow code which does not require strict serialization to be
  * preempted by an out-of-band activity.
- *
- * TRACING: the entry code already told lockdep and tracers about the
- * hard interrupt state on entry to fault handlers, so no need to
- * reflect changes to that state via calls to trace_hardirqs_*
- * helpers. From the main kernel's point of view, there is no change.
  */
 static inline
 unsigned long fault_entry(int exception, struct pt_regs *regs)
 {
 	unsigned long flags;
-	int nosync = 1;
 
 	trace_ARM_trap_entry(exception, regs);
 
-	/*
-	 * CAUTION: The co-kernel might demote the current context to
-	 * the in-band stage as a result of handling this trap,
-	 * returning with hard irqs on.
-	 */
-	oob_trap_notify(exception, regs);
+	flags = hard_local_save_flags();
 
-	flags = hard_local_irq_save();
+	oob_trap_notify(exception, regs);
 
-	if (hard_irqs_disabled_flags(flags))
-		nosync = test_and_stall_inband();
+	/*
+	 * CAUTION: The co-kernel might have to demote the current
+	 * context to the in-band stage as a result of handling this
+	 * trap, returning with hard irqs on. We expect stall_inband()
+	 * to complain loudly if we are still running oob afterwards.
+	 */
+	if (raw_irqs_disabled_flags(flags)) {
+		stall_inband();
+		trace_hardirqs_off();
+	}
 
 	hard_local_irq_enable();
 
-	return irqs_merge_flags(flags, nosync);
+	return flags;
 }
 
 static inline
 void fault_exit(int exception, struct pt_regs *regs,
-		unsigned long combo)
+		unsigned long flags)
 {
-	unsigned long flags;
-	int nosync;
-
 	WARN_ON_ONCE(irq_pipeline_debug() && hard_irqs_disabled());
 
-	oob_trap_unwind(exception, regs);
-
 	/*
-	 * '!nosync' here means that we had to turn on the stall bit
-	 * in fault_entry() to mirror the hard interrupt state,
-	 * because hard irqs were off but the stall bit was
-	 * clear. Conversely, nosync in fault_exit() means that the
-	 * stall bit state currently reflects the hard interrupt state
-	 * we received on fault_entry().
-	 *
-	 * No hard_local_irq_restore() below, ever, but
-	 * hard_local_irq_{enable|disable}() exclusively. See
-	 * unlock_stage() for an explanation.
+	 * We expect kentry_exit_pipelined() to clear the stall bit if
+	 * kentry_enter_pipelined() observed it that way.
 	 */
-	flags = irqs_split_flags(combo, &nosync);
-	if (!nosync) {
-		hard_local_irq_disable();
-		unstall_inband();
-		if (!hard_irqs_disabled_flags(flags))
-			hard_local_irq_enable();
-	} else if (hard_irqs_disabled_flags(flags))
-		hard_local_irq_disable();
-
+	oob_trap_unwind(exception, regs);
 	trace_ARM_trap_exit(exception, regs);
+	hard_local_irq_restore(flags);
 }
 
 #else	/* !CONFIG_IRQ_PIPELINE */
diff --git a/arch/arm64/include/asm/irq_pipeline.h b/arch/arm64/include/asm/irq_pipeline.h
index b40dc5307c2aefc..5861ab38653aa46 100644
--- a/arch/arm64/include/asm/irq_pipeline.h
+++ b/arch/arm64/include/asm/irq_pipeline.h
@@ -88,6 +88,17 @@ static inline int arch_enable_oob_stage(void)
 	return 0;
 }
 
+/*
+ * We use neither the generic entry code nor
+ * kentry_enter/exit_pipelined yet. We still build a no-op version of
+ * the latter for now, until we enventually switch to using whichever
+ * of them is available first.
+ */
+#define arch_kentry_get_irqstate(__regs)	0
+
+#define arch_kentry_set_irqstate(__regs, __irqstate)	\
+	do { (void)__irqstate; } while (0)
+
 #else  /* !CONFIG_IRQ_PIPELINE */
 
 static inline unsigned long arch_local_irq_save(void)
diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index 7addeab41fc79b8..5a9f660dc9538b6 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -1296,6 +1296,73 @@ void sync_current_irq_stage(void) /* hard irqs off */
 	}
 }
 
+#ifndef CONFIG_GENERIC_ENTRY
+
+/*
+ * These helpers are normally called from the kernel entry/exit code
+ * in the asm section by architectures which do not use the generic
+ * kernel entry code, in order to save the interrupt and lockdep
+ * states for the in-band stage on entry, restoring them when leaving
+ * the kernel.  The per-architecture arch_kentry_set/get_irqstate()
+ * calls determine where this information should be kept while running
+ * in kernel context, indexed on the current register frame.
+ */
+
+#define KENTRY_STALL_BIT      BIT(0) /* Tracks INBAND_STALL_BIT */
+#define KENTRY_LOCKDEP_BIT    BIT(1) /* Tracks hardirqs_enabled */
+
+asmlinkage __visible noinstr void kentry_enter_pipelined(struct pt_regs *regs)
+{
+	long irqstate = 0;
+
+	WARN_ON(irq_pipeline_debug() && !hard_irqs_disabled());
+
+	if (!running_inband())
+		return;
+
+	if (lockdep_read_irqs_state())
+		irqstate |= KENTRY_LOCKDEP_BIT;
+
+	if (irqs_disabled())
+		irqstate |= KENTRY_STALL_BIT;
+	else
+		trace_hardirqs_off();
+
+	arch_kentry_set_irqstate(regs, irqstate);
+}
+
+asmlinkage void __visible noinstr kentry_exit_pipelined(struct pt_regs *regs)
+{
+	long irqstate;
+
+	WARN_ON(irq_pipeline_debug() && !hard_irqs_disabled());
+
+	if (!running_inband())
+		return;
+
+	/*
+	 * If the in-band stage of the kernel is current but the IRQ
+	 * is not going to be delivered because the latter is stalled,
+	 * keep the tracing logic unaware of the receipt, so that no
+	 * false positive is triggered in lockdep (e.g. IN-HARDIRQ-W
+	 * -> HARDIRQ-ON-W). In this case, we still have to restore
+	 * the lockdep irq state independently, since it might not be
+	 * in sync with the stall bit (e.g. raw_local_irq_disable/save
+	 * do flip the stall bit, but are not tracked by lockdep).
+	 */
+
+	irqstate = arch_kentry_get_irqstate(regs);
+	if (!(irqstate & KENTRY_STALL_BIT)) {
+		stall_inband_nocheck();
+		trace_hardirqs_on();
+		unstall_inband_nocheck();
+	} else {
+		lockdep_write_irqs_state(!!(irqstate & KENTRY_LOCKDEP_BIT));
+	}
+}
+
+#endif /* !CONFIG_GENERIC_ENTRY */
+
 /**
  *      run_oob_call - escalate function call to the oob stage
  *      @fn:    address of routine
-- 
2.31.1


