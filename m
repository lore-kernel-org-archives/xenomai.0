From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/8] cobalt/tick: use the underlying pipeline timer API
 directly
Date: Sat, 20 Feb 2021 13:45:20 +0100
Message-Id: <20210220124527.401015-1-rpm@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Philippe Gerum <rpm@xenomai.org>

Since the low-level tick management code is pipeline specific, we may
flatten the call stack by using the underlying pipeline API directly.

At this chance, fix a uniprocessor build issue with IPIs.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 .../kernel/dovetail/pipeline/pipeline.h       | 23 ++++++++++++++++++-
 .../cobalt/kernel/ipipe/pipeline/pipeline.h   | 20 ++++++++--------
 include/cobalt/kernel/timer.h                 | 11 ---------
 kernel/cobalt/ipipe/tick.c                    | 11 ++++++---
 kernel/cobalt/sched.c                         |  4 ----
 kernel/cobalt/timer.c                         | 10 --------
 6 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
index 4b8f6b259..a2e025e35 100644
--- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
+++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
@@ -74,7 +74,28 @@ static inline void pipeline_send_timer_ipi(const struct cpumask *dest)
 	TODO();
 }
 
-#endif
+#else  /* !CONFIG_SMP */
+
+static inline int pipeline_request_resched_ipi(void (*handler)(void))
+{
+	return 0;
+}
+
+
+static inline void pipeline_free_resched_ipi(void)
+{
+}
+
+static inline int pipeline_request_timer_ipi(void (*handler)(void))
+{
+	return 0;
+}
+
+static inline void pipeline_free_timer_ipi(void)
+{
+}
+
+#endif	/* CONFIG_SMP */
 
 static inline void pipeline_prepare_panic(void)
 {
diff --git a/include/cobalt/kernel/ipipe/pipeline/pipeline.h b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
index fb0465fb2..ceba7e3b0 100644
--- a/include/cobalt/kernel/ipipe/pipeline/pipeline.h
+++ b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
@@ -51,26 +51,24 @@ static inline void pipeline_send_resched_ipi(const struct cpumask *dest)
 	ipipe_send_ipi(IPIPE_RESCHEDULE_IPI, *dest);
 }
 
-static inline int pipeline_request_timer_ipi(void (*handler)(void))
+static inline void pipeline_send_timer_ipi(const struct cpumask *dest)
 {
-	return ipipe_request_irq(&cobalt_pipeline.domain,
-				IPIPE_HRTIMER_IPI,
-				(ipipe_irq_handler_t)handler,
-				NULL, NULL);
+	ipipe_send_ipi(IPIPE_HRTIMER_IPI, *dest);
 }
 
-static inline void pipeline_free_timer_ipi(void)
+#else  /* !CONFIG_SMP */
+
+static inline int pipeline_request_resched_ipi(void (*handler)(void))
 {
-	return ipipe_free_irq(&cobalt_pipeline.domain,
-			IPIPE_HRTIMER_IPI);
+	return 0;
 }
 
-static inline void pipeline_send_timer_ipi(const struct cpumask *dest)
+
+static inline void pipeline_free_resched_ipi(void)
 {
-	ipipe_send_ipi(IPIPE_HRTIMER_IPI, *dest);
 }
 
-#endif
+#endif	/* CONFIG_SMP */
 
 static inline void pipeline_prepare_panic(void)
 {
diff --git a/include/cobalt/kernel/timer.h b/include/cobalt/kernel/timer.h
index 691be7a3b..703a13506 100644
--- a/include/cobalt/kernel/timer.h
+++ b/include/cobalt/kernel/timer.h
@@ -517,10 +517,6 @@ void xntimer_migrate(struct xntimer *timer, struct xnsched *sched)
 		__xntimer_migrate(timer, sched);
 }
 
-int xntimer_setup_ipi(void);
-
-void xntimer_release_ipi(void);
-
 void __xntimer_set_affinity(struct xntimer *timer,
 			    struct xnsched *sched);
 
@@ -539,13 +535,6 @@ static inline void xntimer_migrate(struct xntimer *timer,
 	timer->sched = sched;
 }
 
-static inline int xntimer_setup_ipi(void)
-{
-	return 0;
-}
-
-static inline void xntimer_release_ipi(void) { }
-
 static inline void xntimer_set_affinity(struct xntimer *timer,
 					struct xnsched *sched)
 {
diff --git a/kernel/cobalt/ipipe/tick.c b/kernel/cobalt/ipipe/tick.c
index da1563a66..b80e56dc7 100644
--- a/kernel/cobalt/ipipe/tick.c
+++ b/kernel/cobalt/ipipe/tick.c
@@ -187,7 +187,10 @@ int pipeline_install_tick_proxy(void)
 	nkclock.wallclock_offset =
 		ktime_to_ns(ktime_get_real()) - xnclock_read_monotonic(&nkclock);
 
-	ret = xntimer_setup_ipi();
+	ret = ipipe_request_irq(&cobalt_pipeline.domain,
+				IPIPE_HRTIMER_IPI,
+				(ipipe_irq_handler_t)xnintr_core_clock_handler,
+				NULL, NULL);
 	if (ret)
 		return ret;
 
@@ -244,7 +247,8 @@ fail:
 		ipipe_timer_stop(_cpu);
 	}
 
-	xntimer_release_ipi();
+	ipipe_free_irq(&cobalt_pipeline.domain,
+		       IPIPE_HRTIMER_IPI);
 
 	return ret;
 }
@@ -270,7 +274,8 @@ void pipeline_uninstall_tick_proxy(void)
 	for_each_realtime_cpu(cpu)
 		ipipe_timer_stop(cpu);
 
-	xntimer_release_ipi();
+	ipipe_free_irq(&cobalt_pipeline.domain,
+		       IPIPE_HRTIMER_IPI);
 
 #ifdef CONFIG_XENO_OPT_STATS_IRQS
 	xnintr_destroy(&nktimer);
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 8a5621642..7873fd652 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -235,9 +235,7 @@ void xnsched_init_all(void)
 		xnsched_init(sched, cpu);
 	}
 
-#ifdef CONFIG_SMP
 	pipeline_request_resched_ipi(__xnsched_run_handler);
-#endif
 }
 
 static void xnsched_destroy(struct xnsched *sched)
@@ -258,9 +256,7 @@ void xnsched_destroy_all(void)
 	int cpu;
 	spl_t s;
 
-#ifdef CONFIG_SMP
 	pipeline_free_resched_ipi();
-#endif
 
 	xnlock_get_irqsave(&nklock, s);
 
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index 7f5033c87..f9aa457ce 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -574,16 +574,6 @@ void __xntimer_set_affinity(struct xntimer *timer, struct xnsched *sched)
 }
 EXPORT_SYMBOL_GPL(__xntimer_set_affinity);
 
-int xntimer_setup_ipi(void)
-{
-	return pipeline_request_timer_ipi(xnintr_core_clock_handler);
-}
-
-void xntimer_release_ipi(void)
-{
-	pipeline_free_timer_ipi();
-}
-
 #endif /* CONFIG_SMP */
 
 /**
-- 
2.26.2


