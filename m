Message-ID: <48E9C418.6010800@domain.hid>
Date: Mon, 06 Oct 2008 09:54:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] Stall root domain during NMI execution
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

During to my work on KVM, specifically its NMI emulation support, I
happen to come across this ipipe issue: As we continue to call a lot of
Linux code from NMI context, and that code may fiddle with the
virtualized IRQ flags (printk does e.g.), we have to ensure that root's
pipeline state is maintained properly.

Otherwise "interesting" things can happen. When we incorrectly reenable
IRQs over the root domain, we also unconditionally call
local_irq_enable_hw() - hell may break loose (with my KVM environment,
we even end up with recursive NMIs on certain Intel CPUs). Granted,
calling printk from NMI context is generally already an error condition,
but we should not worsen the situation. Patch below fixes the effects I
observed.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kernel/ipipe.c      |    2 
 include/linux/ipipe.h        |  119 +++++++++++++++++++++++--------------------
 include/linux/ipipe_percpu.h |    2 
 3 files changed, 68 insertions(+), 55 deletions(-)

Index: b/include/linux/ipipe.h
===================================================================
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -31,6 +31,41 @@
 #include <linux/ipipe_compat.h>
 #include <asm/ipipe.h>
 
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+
+#include <linux/cpumask.h>
+#include <asm/system.h>
+
+static inline int ipipe_disable_context_check(int cpu)
+{
+	return xchg(&per_cpu(ipipe_percpu_context_check, cpu), 0);
+}
+
+static inline void ipipe_restore_context_check(int cpu, int old_state)
+{
+	per_cpu(ipipe_percpu_context_check, cpu) = old_state;
+}
+
+static inline void ipipe_context_check_off(void)
+{
+	int cpu;
+	for_each_online_cpu(cpu)
+		per_cpu(ipipe_percpu_context_check, cpu) = 0;
+}
+
+#else	/* !CONFIG_IPIPE_DEBUG_CONTEXT */
+
+static inline int ipipe_disable_context_check(int cpu)
+{
+	return 0;
+}
+
+static inline void ipipe_restore_context_check(int cpu, int old_state) { }
+
+static inline void ipipe_context_check_off(void) { }
+
+#endif	/* !CONFIG_IPIPE_DEBUG_CONTEXT */
+
 #ifdef CONFIG_IPIPE
 
 /*
@@ -512,6 +547,32 @@ static inline void local_irq_restore_nos
 
 #define ipipe_root_domain_p		(ipipe_current_domain == ipipe_root_domain)
 
+static inline void ipipe_nmi_enter(void)
+{
+	int cpu = ipipe_processor_id();
+
+	per_cpu(ipipe_nmi_saved_root, cpu) = ipipe_root_cpudom_var(status);
+	__set_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
+
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+	per_cpu(ipipe_saved_context_check_state, cpu) =
+		ipipe_disable_context_check(cpu);
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+}
+
+static inline void ipipe_nmi_exit(void)
+{
+	int cpu = ipipe_processor_id();
+
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+	ipipe_restore_context_check
+		(cpu, per_cpu(ipipe_saved_context_check_state, cpu));
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+
+	if (!test_bit(IPIPE_STALL_FLAG, &per_cpu(ipipe_nmi_saved_root, cpu)))
+		__clear_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
+}
+
 #else	/* !CONFIG_IPIPE */
 
 #define ipipe_init()			do { } while(0)
@@ -536,6 +597,9 @@ static inline void local_irq_restore_nos
 #define ipipe_root_domain_p		1
 #define ipipe_safe_current		current
 
+#define ipipe_nmi_enter()		do { } while ()
+#define ipipe_nmi_exit()		do { } while ()
+
 #define local_irq_disable_head()	local_irq_disable()
 
 #define local_irq_save_full(vflags, rflags)	do { (void)(vflags); local_irq_save(rflags); } while(0)
@@ -544,59 +608,4 @@ static inline void local_irq_restore_nos
 
 #endif	/* CONFIG_IPIPE */
 
-#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
-
-#include <linux/cpumask.h>
-#include <asm/system.h>
-
-static inline int ipipe_disable_context_check(int cpu)
-{
-	return xchg(&per_cpu(ipipe_percpu_context_check, cpu), 0);
-}
-
-static inline void ipipe_restore_context_check(int cpu, int old_state)
-{
-	per_cpu(ipipe_percpu_context_check, cpu) = old_state;
-}
-
-static inline void ipipe_context_check_off(void)
-{
-	int cpu;
-	for_each_online_cpu(cpu)
-		per_cpu(ipipe_percpu_context_check, cpu) = 0;
-}
-
-static inline void ipipe_nmi_enter(void)
-{
-	int cpu = ipipe_processor_id();
-
-	per_cpu(ipipe_saved_context_check_state, cpu) =
-		ipipe_disable_context_check(cpu);
-}
-
-static inline void ipipe_nmi_exit(void)
-{
-	int cpu = ipipe_processor_id();
-
-	ipipe_restore_context_check
-		(cpu, per_cpu(ipipe_saved_context_check_state, cpu));
-}
-
-#else	/* !CONFIG_IPIPE_DEBUG_CONTEXT */
-
-static inline int ipipe_disable_context_check(int cpu)
-{
-	return 0;
-}
-
-static inline void ipipe_restore_context_check(int cpu, int old_state) { }
-
-static inline void ipipe_context_check_off(void) { }
-
-static inline void ipipe_nmi_enter(void) { }
-
-static inline void ipipe_nmi_exit(void) { }
-
-#endif	/* !CONFIG_IPIPE_DEBUG_CONTEXT */
-
 #endif	/* !__LINUX_IPIPE_H */
Index: b/include/linux/ipipe_percpu.h
===================================================================
--- a/include/linux/ipipe_percpu.h
+++ b/include/linux/ipipe_percpu.h
@@ -56,6 +56,8 @@ DECLARE_PER_CPU(struct ipipe_percpu_doma
 
 DECLARE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain);
 
+DECLARE_PER_CPU(unsigned long, ipipe_nmi_saved_root);
+
 #ifdef CONFIG_IPIPE_DEBUG_CONTEXT
 DECLARE_PER_CPU(int, ipipe_percpu_context_check);
 DECLARE_PER_CPU(int, ipipe_saved_context_check_state);
Index: b/arch/x86/kernel/ipipe.c
===================================================================
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -52,6 +52,8 @@ int __ipipe_tick_irq = TIMER_IRQ;
 
 DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
 
+DEFINE_PER_CPU(unsigned long, ipipe_nmi_saved_root);
+
 #ifdef CONFIG_SMP
 
 static cpumask_t __ipipe_cpu_sync_map;

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

