From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 4 Sep 2018 12:54:53 +0200
Message-Id: <E1fxEE3-0004CF-DU@xenomai.org>
Subject: [Xenomai] [PATCH] cobalt/sched: group high-level init/cleanup code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Move scheduler init/cleanup bits to dedicated routines.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/sched.h |  4 ++--
 kernel/cobalt/init.c          | 41 +++-------------------------------
 kernel/cobalt/sched.c         | 51 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 54 insertions(+), 42 deletions(-)

diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index d525fb2cb..03436ee82 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -381,9 +381,9 @@ void xnsched_cleanup_proc(void);
 
 void xnsched_register_classes(void);
 
-void xnsched_init(struct xnsched *sched, int cpu);
+void xnsched_init_all(void);
 
-void xnsched_destroy(struct xnsched *sched);
+void xnsched_destroy_all(void);
 
 struct xnthread *xnsched_pick_next(struct xnsched *sched);
 
diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
index bdd9f351b..22066953b 100644
--- a/kernel/cobalt/init.c
+++ b/kernel/cobalt/init.c
@@ -124,34 +124,10 @@ EXPORT_SYMBOL_GPL(cobalt_call_state_chain);
 
 static void sys_shutdown(void)
 {
-	struct xnthread *thread, *tmp;
-	struct xnsched *sched;
 	void *membase;
-	int cpu;
-	spl_t s;
 
 	xntimer_release_hardware();
-#ifdef CONFIG_SMP
-	ipipe_free_irq(&xnsched_realtime_domain, IPIPE_RESCHEDULE_IPI);
-#endif
-
-	xnlock_get_irqsave(&nklock, s);
-
-	/* NOTE: &nkthreadq can't be empty (root thread(s)). */
-	list_for_each_entry_safe(thread, tmp, &nkthreadq, glink) {
-		if (!xnthread_test_state(thread, XNROOT))
-			xnthread_cancel(thread);
-	}
-
-	xnsched_run();
-
-	for_each_online_cpu(cpu) {
-		sched = xnsched_struct(cpu);
-		xnsched_destroy(sched);
-	}
-
-	xnlock_put_irqrestore(&nklock, s);
-
+	xnsched_destroy_all();
 	xnregistry_cleanup();
 	membase = xnheap_get_membase(&cobalt_heap);
 	xnheap_destroy(&cobalt_heap);
@@ -281,9 +257,8 @@ static void __init setup_init_state(void)
 
 static __init int sys_init(void)
 {
-	struct xnsched *sched;
 	void *heapaddr;
-	int ret, cpu;
+	int ret;
 
 	if (sysheap_size_arg == 0)
 		sysheap_size_arg = CONFIG_XENO_OPT_SYS_HEAPSZ;
@@ -295,17 +270,7 @@ static __init int sys_init(void)
 	}
 	xnheap_set_name(&cobalt_heap, "system heap");
 
-	for_each_online_cpu(cpu) {
-		sched = &per_cpu(nksched, cpu);
-		xnsched_init(sched, cpu);
-	}
-
-#ifdef CONFIG_SMP
-	ipipe_request_irq(&xnsched_realtime_domain,
-			  IPIPE_RESCHEDULE_IPI,
-			  (ipipe_irq_handler_t)__xnsched_run_handler,
-			  NULL, NULL);
-#endif
+	xnsched_init_all();
 
 	xnregistry_init();
 
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index db7bb11f1..76e3bc5d7 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -149,7 +149,7 @@ static void roundrobin_handler(struct xntimer *timer)
 	xnsched_tick(sched);
 }
 
-void xnsched_init(struct xnsched *sched, int cpu)
+static void xnsched_init(struct xnsched *sched, int cpu)
 {
 	char rrbtimer_name[XNOBJECT_NAME_LEN];
 	char htimer_name[XNOBJECT_NAME_LEN];
@@ -219,7 +219,25 @@ void xnsched_init(struct xnsched *sched, int cpu)
 #endif /* CONFIG_XENO_OPT_WATCHDOG */
 }
 
-void xnsched_destroy(struct xnsched *sched)
+void xnsched_init_all(void)
+{
+	struct xnsched *sched;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		sched = &per_cpu(nksched, cpu);
+		xnsched_init(sched, cpu);
+	}
+
+#ifdef CONFIG_SMP
+	ipipe_request_irq(&xnsched_realtime_domain,
+			  IPIPE_RESCHEDULE_IPI,
+			  (ipipe_irq_handler_t)__xnsched_run_handler,
+			  NULL, NULL);
+#endif
+}
+
+static void xnsched_destroy(struct xnsched *sched)
 {
 	xntimer_destroy(&sched->htimer);
 	xntimer_destroy(&sched->rrbtimer);
@@ -230,6 +248,35 @@ void xnsched_destroy(struct xnsched *sched)
 #endif /* CONFIG_XENO_OPT_WATCHDOG */
 }
 
+void xnsched_destroy_all(void)
+{
+	struct xnthread *thread, *tmp;
+	struct xnsched *sched;
+	int cpu;
+	spl_t s;
+
+#ifdef CONFIG_SMP
+	ipipe_free_irq(&xnsched_realtime_domain, IPIPE_RESCHEDULE_IPI);
+#endif
+
+	xnlock_get_irqsave(&nklock, s);
+
+	/* NOTE: &nkthreadq can't be empty (root thread(s)). */
+	list_for_each_entry_safe(thread, tmp, &nkthreadq, glink) {
+		if (!xnthread_test_state(thread, XNROOT))
+			xnthread_cancel(thread);
+	}
+
+	xnsched_run();
+
+	for_each_online_cpu(cpu) {
+		sched = xnsched_struct(cpu);
+		xnsched_destroy(sched);
+	}
+
+	xnlock_put_irqrestore(&nklock, s);
+}
+
 static inline void set_thread_running(struct xnsched *sched,
 				      struct xnthread *thread)
 {
-- 
2.14.4


