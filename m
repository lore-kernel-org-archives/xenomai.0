From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Thu, 29 Oct 2015 08:46:01 +0100
Message-Id: <1446104761-20722-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 1/2] arm64/ipipe: trace kernel entry/exit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

---
 arch/arm64/kernel/entry.S | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index fa76ad1..4ae6cf3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -126,6 +126,17 @@
 	str	x21, [sp, #S_SYSCALLNO]
 	.endif
 
+#ifdef CONFIG_IPIPE_TRACE
+	mov     x0, #1
+	mov     x3, #0x90000000
+	ldr     x2, [sp, #S_PC]
+	mov     x1, #0
+	bl      ipipe_trace_asm
+	ldp     x0, x1, [sp]
+	ldp     x2, x3, [sp, #S_X2]
+	ldp     x4, x5, [sp, #S_X4]
+	ldp     x6, x7, [sp, #S_X6]
+#endif
 	/*
 	 * Registers that may be useful after this macro is invoked:
 	 *
@@ -136,6 +147,21 @@
 	.endm
 
 	.macro	kernel_exit, el, ret = 0
+
+#ifdef CONFIG_IPIPE_TRACE
+	.if	\ret
+	mov	x19, x0
+	.endif
+	mov     x0, #2
+	mov     x3, #0x90000000
+	ldr     x2, [sp, #S_PC]
+	mov     x1, #0
+	bl      ipipe_trace_asm
+	.if	\ret
+	mov	x0, x19
+	.endif
+#endif
+
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
 	.if	\el == 0
 	ct_user_enter
-- 
1.8.4


