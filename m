From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 2/8] cobalt/arm: fix context switching code for 4.19+
Date: Sat,  1 Jun 2019 17:14:56 +0200
Message-Id: <20190601151502.27216-3-rpm@xenomai.org>
In-Reply-To: <20190601151502.27216-1-rpm@xenomai.org>
References: <20190601151502.27216-1-rpm@xenomai.org>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/arch/arm/switch.S | 54 ++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/arm/switch.S b/kernel/cobalt/arch/arm/switch.S
index 505fd5af2..9fc847ab0 100644
--- a/kernel/cobalt/arch/arm/switch.S
+++ b/kernel/cobalt/arch/arm/switch.S
@@ -110,7 +110,6 @@ ENDPROC(__asm_vfp_load)
 	.endm
 #endif
 
-/*
 /*
  * Switch context routine.
  *
@@ -134,8 +133,15 @@ ENDPROC(__asm_vfp_load)
  *
  *  Calling args:
  * r0 = previous thread_info, r1 = next thread_info
+ *
+ * FIXME: this is ugly, at some point we should stop duplicating
+ * what __switch_to() does, dropping specific fpu management from
+ * Cobalt in the same move; this will have to wait until Dovetail
+ * is substituted to the I-pipe though, since the former already
+ * provides the support we need for this. --rpm
  */
 ENTRY(__asm_thread_switch)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 19, 0)
 	add     ip, r0, #TI_CPU_SAVE
  ARM(	stmia	ip!, {r4 - sl, fp, sp, lr} )	@ Store most regs on stack
  THUMB(	stmia	ip!, {r4 - sl, fp}	   )	@ Store most regs on stack
@@ -165,3 +171,49 @@ ENTRY(__asm_thread_switch)
  THUMB(	ldr	sp, [ip], #4		   )
  THUMB(	ldr	pc, [ip]		   )
 ENDPROC(__asm_thread_switch)
+
+#else /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 19, 0) */
+
+#include <asm/unwind.h>
+
+ UNWIND(.fnstart	)
+ UNWIND(.cantunwind	)
+	add	ip, r0, #TI_CPU_SAVE
+ ARM(	stmia	ip!, {r4 - sl, fp, sp, lr} )	@ Store most regs on stack
+ THUMB(	stmia	ip!, {r4 - sl, fp}	   )	@ Store most regs on stack
+ THUMB(	str	sp, [ip], #4		   )
+ THUMB(	str	lr, [ip], #4		   )
+	ldr	r4, [r1, #TI_TP_VALUE]
+	ldr	r5, [r1, #TI_TP_VALUE + 4]
+#ifdef CONFIG_CPU_USE_DOMAINS
+	mrc	p15, 0, r6, c3, c0, 0		@ Get domain register
+	str	r6, [r0, #TI_CPU_DOMAIN]	@ Save old domain register
+	ldr	r6, [r1, #TI_CPU_DOMAIN]
+#endif
+	switch_tls r0, r4, r5, r3, r7
+#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
+	ldr	r7, [r1, #TI_TASK]
+	ldr	r8, =__stack_chk_guard
+	.if (TSK_STACK_CANARY > IMM12_MASK)
+	add	r7, r7, #TSK_STACK_CANARY & ~IMM12_MASK
+	.endif
+	ldr	r7, [r7, #TSK_STACK_CANARY & IMM12_MASK]
+#endif
+#ifdef CONFIG_CPU_USE_DOMAINS
+	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
+#endif
+	mov	r5, r0
+	fpu_switch r4
+	add	r4, r1, #TI_CPU_SAVE
+#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
+	str	r7, [r8]
+#endif
+ THUMB(	mov	ip, r4			   )
+	mov	r0, r5
+ ARM(	ldmia	r4, {r4 - sl, fp, sp, pc}  )	@ Load all regs saved previously
+ THUMB(	ldmia	ip!, {r4 - sl, fp}	   )	@ Load all regs saved previously
+ THUMB(	ldr	sp, [ip], #4		   )
+ THUMB(	ldr	pc, [ip]		   )
+ UNWIND(.fnend		)
+
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 19, 0) */
-- 
2.20.1


