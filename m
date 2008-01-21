Message-ID: <4794703D.1000700@domain.hid>
Date: Mon, 21 Jan 2008 11:13:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] refactor generic EXPORT_SYMBOLs
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

The exported symbols below are not specific to x86 or any other arch,
just their implementation is. So let's move them into generic ipipe.c.

Jan

---
 arch/x86/kernel/ipipe.c |    9 ---------
 kernel/ipipe/core.c     |   10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

Index: linux-2.6.24-rc8-xeno_64/arch/x86/kernel/ipipe.c
===================================================================
--- linux-2.6.24-rc8-xeno_64.orig/arch/x86/kernel/ipipe.c
+++ linux-2.6.24-rc8-xeno_64/arch/x86/kernel/ipipe.c
@@ -975,10 +975,6 @@ int __ipipe_check_tickdev(const char *de
 }

 EXPORT_SYMBOL(__ipipe_tick_irq);
-EXPORT_SYMBOL(ipipe_critical_enter);
-EXPORT_SYMBOL(ipipe_critical_exit);
-EXPORT_SYMBOL(ipipe_trigger_irq);
-EXPORT_SYMBOL(ipipe_get_sysinfo);

 EXPORT_SYMBOL_GPL(irq_desc);
 struct task_struct *__switch_to(struct task_struct *prev_p,
@@ -998,8 +994,3 @@ EXPORT_SYMBOL_GPL(cpu_gdt_descr);
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 EXPORT_SYMBOL(tasklist_lock);
 #endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
-
-#ifdef CONFIG_IPIPE_TRACE_MCOUNT
-void notrace mcount(void);
-EXPORT_SYMBOL(mcount);
-#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
Index: linux-2.6.24-rc8-xeno_64/kernel/ipipe/core.c
===================================================================
--- linux-2.6.24-rc8-xeno_64.orig/kernel/ipipe/core.c
+++ linux-2.6.24-rc8-xeno_64/kernel/ipipe/core.c
@@ -1624,3 +1624,13 @@ EXPORT_SYMBOL(__ipipe_schedule_irq);
 EXPORT_SYMBOL(ipipe_request_tickdev);
 EXPORT_SYMBOL(ipipe_release_tickdev);
 #endif
+
+EXPORT_SYMBOL(ipipe_critical_enter);
+EXPORT_SYMBOL(ipipe_critical_exit);
+EXPORT_SYMBOL(ipipe_trigger_irq);
+EXPORT_SYMBOL(ipipe_get_sysinfo);
+
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+void notrace mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */


-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

