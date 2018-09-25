From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:38 +0200
Message-Id: <20180925103809.4932-2-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 01/32] x86: lockdep: ipipe: make the logic aware
 of interrupt pipelining
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Call trace_hardirqs_on_virt() on kernel exit path to userland. This
makes sure that the interrupt state is only tracked for the root
domain (i.e. by testing the virtual interrupt disable flag when
applicable).
---
 arch/x86/entry/entry_64.S       | 2 +-
 arch/x86/entry/thunk_32.S       | 1 +
 arch/x86/entry/thunk_64.S       | 1 +
 arch/x86/include/asm/irqflags.h | 6 ++++++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0fae7096ae23..92a7471a5e7b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -57,7 +57,7 @@ END(native_usergs_sysret64)
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bt	$9, EFLAGS(%rsp)		/* interrupts off? */
 	jnc	1f
-	TRACE_IRQS_ON
+	TRACE_IRQS_ON_VIRT
 1:
 #endif
 .endm
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index fee6bc79b987..d331e7f30e53 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -31,6 +31,7 @@
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller,1
+	THUNK trace_hardirqs_on_virt_thunk,trace_hardirqs_on_virt_caller,1
 	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
 #endif
 
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index be36bf4e0957..5a0bb83eeff0 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -40,6 +40,7 @@
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller,1
+	THUNK trace_hardirqs_on_virt_thunk,trace_hardirqs_on_virt_caller,1
 	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
 #endif
 
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 15450a675031..63d29a6eabce 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -175,9 +175,15 @@ static inline int arch_irqs_disabled(void)
 #ifdef __ASSEMBLY__
 #ifdef CONFIG_TRACE_IRQFLAGS
 #  define TRACE_IRQS_ON		call trace_hardirqs_on_thunk;
+#ifdef CONFIG_IPIPE
+#  define TRACE_IRQS_ON_VIRT	call trace_hardirqs_on_virt_thunk;
+#else
+#  define TRACE_IRQS_ON_VIRT	TRACE_IRQS_ON
+#endif
 #  define TRACE_IRQS_OFF	call trace_hardirqs_off_thunk;
 #else
 #  define TRACE_IRQS_ON
+#  define TRACE_IRQS_ON_VIRT
 #  define TRACE_IRQS_OFF
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.14.4


