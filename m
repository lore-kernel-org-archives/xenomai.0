Message-ID: <451D338A.1050407@domain.hid>
Date: Fri, 29 Sep 2006 16:54:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050003080808040003090407"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 2/2] detect domain violations
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050003080808040003090407
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Small patch, fairly useful effect (IMHO): This introduces
ipipe_check_context(border_ipd), a test if the caller is running in
domain border_ipd or below. If not, a warning + stack trace is issued on
the kernel console.

The background is that functions of lower-priority domains that are not
protected against preemptions by higher domains must not be invoked by
the latter. Example: wakeup of a Linux process from a Xenomai interrupt
handler (fairly tempting for RTDM driver developers, I know).

As an application of this generic check, preempt_disable() and
might_resched() of the Linux kernel are instrumented with
ipipe_check_context(&ipipe_root). This catches all spin_lock invocations
as well as mutexes, (rw-)semaphores and other sleeping Linux services.

Example:

#include <linux/module.h>
#include <linux/wait.h>
#include <rtdm/rtdm_driver.h>

rtdm_task_t task;
static DECLARE_WAIT_QUEUE_HEAD(waitqueue);

void task_fnc(void *arg)
{
    rtdm_printk("about to do something illegal...\n");
    wake_up(&waitqueue);
    rtdm_printk("done\n");
}

int ipipe_debug_test(void)
{
    rtdm_task_init(&task, "ipipe_debug_test", task_fnc, NULL, 20, 0);

    rtdm_task_join_nrt(&task, 100);

    return -ENOANO;
}

module_init(ipipe_debug_test);


Loading this module will give

> I-pipe: Detected illicit call from domain 'Xenomai'
>         into a service reserved for domain 'Linux' and below.
>        c499f390 00000000 00000000 00000003 c499f3b4 c0102bc9 c0271903 ffffffff 
>        00000001 c499f3c8 c012b5e3 c0275577 c0275c4c c02800bd c499f3e0 c010bf98 
>        c49953fc c04e9d60 c4995680 c499588c c499f3f0 c4995078 00000000 c4995099 
> Call Trace:
>  <c0102b9e> show_stack_log_lvl+0x85/0x8f  <c0102bc9> show_stack+0x21/0x29
>  <c012b5e3> ipipe_check_context+0x58/0x5d  <c010bf98> __wake_up+0x24/0x52
>  <c4995078> task_fnc+0x23/0x33 [rtdm_buggy_linux_call]  <c01313d5> xnarch_thread_redirect+0x1d/0x27
>  <00000000> _stext+0x3feffdc0/0x3c 


This patch is an RFC as the following issues need to be resolved:

 o The might be parts of I-pipe remaining that make use of
   preemp_disable even over non-root contexts. Philippe indicated the
   PPC PIC code would be one example.

 o We need a common header with only elementary dependencies to avoid
   duplications like in preempt.h and kernel.h. This would also address
   the problem of my earlier posted inline-root-stalling patch.

 o It has to be decided if this patch shall be part of the base patch or
   the tracer add-on (maybe renamed as ipipe-debugging).

Jan

--------------050003080808040003090407
Content-Type: text/plain;
 name="ipipe-dbg-dom-violation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe-dbg-dom-violation.patch"

---
 arch/i386/kernel/ipipe-root.c |    9 ++++++---
 include/linux/ipipe.h         |    6 ++++++
 include/linux/kernel.h        |   16 ++++++++++++++--
 include/linux/preempt.h       |   11 ++++++++++-
 kernel/ipipe/Kconfig.debug    |    9 +++++++++
 kernel/ipipe/generic.c        |   31 +++++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 6 deletions(-)

Index: linux-2.6.17.13/include/linux/ipipe.h
===================================================================
--- linux-2.6.17.13.orig/include/linux/ipipe.h
+++ linux-2.6.17.13/include/linux/ipipe.h
@@ -694,6 +694,12 @@ int fastcall ipipe_set_ptd(int key,
 
 void fastcall *ipipe_get_ptd(int key);
 
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void fastcall ipipe_check_context(struct ipipe_domain *border_ipd);
+#else /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+#define ipipe_check_context(border_ipd) do { } while (0)
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+
 #define local_irq_enable_hw_cond()		local_irq_enable_hw()
 #define local_irq_disable_hw_cond()		local_irq_disable_hw()
 #define local_irq_save_hw_cond(flags)	local_irq_save_hw(flags)
Index: linux-2.6.17.13/kernel/ipipe/Kconfig.debug
===================================================================
--- linux-2.6.17.13.orig/kernel/ipipe/Kconfig.debug
+++ linux-2.6.17.13/kernel/ipipe/Kconfig.debug
@@ -2,6 +2,15 @@ config IPIPE_DEBUG
 	bool "I-pipe debugging"
 	depends on IPIPE
 
+config IPIPE_DEBUG_CONTEXT
+	bool "Check for illicit cross-domain calls"
+	depends on IPIPE_DEBUG
+	---help---
+	  Enable this feature to arm checkpoints in the kernel that
+	  verify the correct invocation context. On entry of critical
+	  Linux services a warning is issued if the caller is not
+	  running over the root domain.
+
 config IPIPE_TRACE
 	bool "Latency tracing"
 	depends on IPIPE_DEBUG
Index: linux-2.6.17.13/kernel/ipipe/generic.c
===================================================================
--- linux-2.6.17.13.orig/kernel/ipipe/generic.c
+++ linux-2.6.17.13/kernel/ipipe/generic.c
@@ -29,6 +29,9 @@
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #endif	/* CONFIG_PROC_FS */
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+#include <linux/ipipe_trace.h>
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
 
 MODULE_DESCRIPTION("I-pipe");
 MODULE_LICENSE("GPL");
@@ -410,6 +413,34 @@ void fastcall *ipipe_get_ptd (int key)
 	return current->ptd[key];
 }
 
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void fastcall ipipe_check_context(struct ipipe_domain *border_ipd)
+{
+	static int check_hit;
+
+	if (likely(ipipe_current_domain->priority <= border_ipd->priority) ||
+	    check_hit)
+		return;
+
+	check_hit = 1;
+
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+	ipipe_trace_panic_freeze();
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
+	ipipe_set_printk_sync(ipipe_current_domain);
+	printk(KERN_ERR "I-pipe: Detected illicit call from domain '%s'\n"
+	       "        into a service reserved for domain '%s' and below.\n",
+	       ipipe_current_domain->name, border_ipd->name);
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+	ipipe_trace_panic_dump();
+#else /* !CONFIG_IPIPE_TRACE_MCOUNT */
+	show_stack(NULL, NULL);
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
+}
+
+EXPORT_SYMBOL(ipipe_check_context);
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+
 EXPORT_SYMBOL(ipipe_register_domain);
 EXPORT_SYMBOL(ipipe_unregister_domain);
 EXPORT_SYMBOL(ipipe_free_virq);
Index: linux-2.6.17.13/include/linux/kernel.h
===================================================================
--- linux-2.6.17.13.orig/include/linux/kernel.h
+++ linux-2.6.17.13/include/linux/kernel.h
@@ -60,11 +60,23 @@ struct user;
  * be biten later when the calling function happens to sleep when it is not
  * supposed to.
  */
+
+/* FIXME: This is ugly... */
+extern struct ipipe_domain ipipe_root;
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void fastcall ipipe_check_context(struct ipipe_domain *border_ipd);
+#else /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+#define ipipe_check_context(border_ipd) do { } while (0)
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 extern int cond_resched(void);
-# define might_resched() cond_resched()
+# define might_resched() do { \
+		ipipe_check_context(&ipipe_root); \
+		cond_resched(); \
+	} while (0)
 #else
-# define might_resched() do { } while (0)
+# define might_resched() ipipe_check_context(&ipipe_root)
 #endif
 
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
Index: linux-2.6.17.13/include/linux/preempt.h
===================================================================
--- linux-2.6.17.13.orig/include/linux/preempt.h
+++ linux-2.6.17.13/include/linux/preempt.h
@@ -23,6 +23,14 @@
 
 #define preempt_count()	(current_thread_info()->preempt_count)
 
+/* FIXME: This is ugly... */
+extern struct ipipe_domain ipipe_root;
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void fastcall ipipe_check_context(struct ipipe_domain *border_ipd);
+#else /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+#define ipipe_check_context(border_ipd) do { } while (0)
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+
 #ifdef CONFIG_PREEMPT
 
 asmlinkage void preempt_schedule(void);
@@ -38,6 +46,7 @@ extern struct ipipe_domain ipipe_root;
 
 #define preempt_disable()						\
 do {									\
+	ipipe_check_context(&ipipe_root);				\
 	if (ipipe_preempt_guard()) {					\
 		inc_preempt_count();					\
 		barrier();						\
@@ -69,7 +78,7 @@ do {									\
 
 #else
 
-#define preempt_disable()		do { } while (0)
+#define preempt_disable()		ipipe_check_context(&ipipe_root)
 #define preempt_enable_no_resched()	do { } while (0)
 #define preempt_enable()		do { } while (0)
 #define preempt_check_resched()		do { } while (0)
Index: linux-2.6.17.13/arch/i386/kernel/ipipe-root.c
===================================================================
--- linux-2.6.17.13.orig/arch/i386/kernel/ipipe-root.c
+++ linux-2.6.17.13/arch/i386/kernel/ipipe-root.c
@@ -70,9 +70,12 @@ static int __ipipe_ack_common_irq(unsign
 
 	ipipe_load_cpuid();	/* hw interrupts are off. */
 	flags = ipipe_test_and_stall_pipeline();
-	preempt_disable();
-	desc->handler->ack(irq);
-	preempt_enable_no_resched();
+	if (ipipe_percpu_domain[cpuid] == ipipe_root_domain) {
+		preempt_disable();
+		desc->handler->ack(irq);
+		preempt_enable_no_resched();
+	} else
+		desc->handler->ack(irq);
 	ipipe_restore_pipeline_nosync(ipipe_percpu_domain[cpuid], flags, cpuid);
 
 	return 1;

--------------050003080808040003090407--

