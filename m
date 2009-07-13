Message-ID: <4A5B2551.1030905@domain.hid>
Date: Mon, 13 Jul 2009 14:15:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 2/3] 2.6.30-noarch: Introduce
	CONFIG_IPIPE_DEBUG_INTERNAL
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Add a switch to control if internal I-pipe debug checks like per-cpu
access validation should be enabled. There is no need to force this on
if the user, e.g., just wants to enable tracing or context check
validation.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/asm-generic/percpu.h |    2 +-
 kernel/ipipe/Kconfig.debug   |    9 +++++++++
 kernel/ipipe/core.c          |   10 +++++-----
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 98ccc17..5d5b6ba 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -57,7 +57,7 @@ extern unsigned long __per_cpu_offset[NR_CPUS];
 	(*SHIFT_PERCPU_PTR(&per_cpu_var(var), __my_cpu_offset))
 
 #ifdef CONFIG_IPIPE
-#if defined(CONFIG_IPIPE_DEBUG) && defined(CONFIG_SMP)
+#if defined(CONFIG_IPIPE_DEBUG_INTERNAL) && defined(CONFIG_SMP)
 extern int __ipipe_check_percpu_access(void);
 #define __ipipe_local_cpu_offset				\
 	({							\
diff --git a/kernel/ipipe/Kconfig.debug b/kernel/ipipe/Kconfig.debug
index 6717b51..c9b8abc 100644
--- a/kernel/ipipe/Kconfig.debug
+++ b/kernel/ipipe/Kconfig.debug
@@ -12,6 +12,15 @@ config IPIPE_DEBUG_CONTEXT
 	  Linux services a warning is issued if the caller is not
 	  running over the root domain.
 
+config IPIPE_DEBUG_INTERNAL
+	bool "Enable internal debug checks"
+	depends on IPIPE_DEBUG
+	default y
+	---help---
+	  When this feature is enabled, I-pipe will perform internal
+	  consistency checks of its subsystems, e.g. on per-cpu variable
+	  access.
+
 config IPIPE_TRACE
 	bool "Latency tracing"
 	depends on IPIPE_DEBUG
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index eeaee66..ffaceaa 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -310,7 +310,7 @@ void __ipipe_unstall_root(void)
 
         local_irq_disable_hw();
 
-#ifdef CONFIG_IPIPE_DEBUG
+#ifdef CONFIG_IPIPE_DEBUG_INTERNAL
 	/* This helps catching bad usage from assembly call sites. */
 	BUG_ON(!__ipipe_root_domain_p);
 #endif
@@ -327,7 +327,7 @@ void __ipipe_unstall_root(void)
 
 void __ipipe_restore_root(unsigned long x)
 {
-#ifdef CONFIG_IPIPE_DEBUG
+#ifdef CONFIG_IPIPE_DEBUG_INTERNAL
 	BUG_ON(!ipipe_root_domain_p);
 #endif
 
@@ -1697,7 +1697,7 @@ EXPORT_SYMBOL(ipipe_check_context);
 
 #endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
 
-#if defined(CONFIG_IPIPE_DEBUG) && defined(CONFIG_SMP)
+#if defined(CONFIG_IPIPE_DEBUG_INTERNAL) && defined(CONFIG_SMP)
 
 int notrace __ipipe_check_percpu_access(void)
 {
@@ -1743,7 +1743,7 @@ out:
 	return ret;
 }
 
-#endif /* CONFIG_IPIPE_DEBUG && CONFIG_SMP */
+#endif /* CONFIG_IPIPE_DEBUG_INTERNAL && CONFIG_SMP */
 
 EXPORT_SYMBOL(ipipe_virtualize_irq);
 EXPORT_SYMBOL(ipipe_control_irq);
@@ -1780,7 +1780,7 @@ EXPORT_SYMBOL(ipipe_set_irq_affinity);
 EXPORT_SYMBOL(ipipe_send_ipi);
 EXPORT_SYMBOL(__ipipe_pend_irq);
 EXPORT_SYMBOL(__ipipe_set_irq_pending);
-#if defined(CONFIG_IPIPE_DEBUG) && defined(CONFIG_SMP)
+#if defined(CONFIG_IPIPE_DEBUG_INTERNAL) && defined(CONFIG_SMP)
 EXPORT_SYMBOL(__ipipe_check_percpu_access);
 #endif
 #ifdef CONFIG_GENERIC_CLOCKEVENTS

