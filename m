From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt: Allow to enable per-IRQ handler statistics separately
Message-ID: <5fd460ec-c645-942a-b2ac-a8c51e20d04c@siemens.com>
Date: Fri, 13 Sep 2019 20:35:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to enable thread statistics without performing separate
per-IRQ handler accounting. Disabling the still default-on IRQ
statistics reduces the overhead under high interrupt load and was
also requested by a user who prefers to account IRQ runtime to the
interrupted context.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/intr.h | 22 +++++++++++++++++++---
 kernel/cobalt/Kconfig        | 10 ++++++++++
 kernel/cobalt/intr.c         | 35 +++++++++++++++++++++++------------
 kernel/cobalt/sched.c        |  6 +++++-
 kernel/cobalt/timer.c        |  8 ++++----
 5 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/include/cobalt/kernel/intr.h b/include/cobalt/kernel/intr.h
index af20ca1f92..2e8253895d 100644
--- a/include/cobalt/kernel/intr.h
+++ b/include/cobalt/kernel/intr.h
@@ -83,7 +83,7 @@ struct xnintr {
 	const char *name;
 	/** Descriptor maintenance lock. */
 	raw_spinlock_t lock;
-#ifdef CONFIG_XENO_OPT_STATS
+#ifdef CONFIG_XENO_OPT_STATS_IRQS
 	/** Statistics. */
 	struct xnirqstat *stats;
 #endif
@@ -99,8 +99,6 @@ struct xnintr_iterator {
     struct xnintr *prev;	/** Previously visited xnintr object (internal use). */
 };
 
-extern struct xnintr nktimer;
-
 int xnintr_mount(void);
 
 void xnintr_core_clock_handler(void);
@@ -134,6 +132,9 @@ void xnintr_disable(struct xnintr *intr);
 void xnintr_affinity(struct xnintr *intr,
 		     cpumask_t cpumask);
 
+#ifdef CONFIG_XENO_OPT_STATS_IRQS
+extern struct xnintr nktimer;
+
 int xnintr_query_init(struct xnintr_iterator *iterator);
 
 int xnintr_get_query_lock(void);
@@ -143,6 +144,21 @@ void xnintr_put_query_lock(void);
 int xnintr_query_next(int irq, struct xnintr_iterator *iterator,
 		      char *name_buf);
 
+#else /* !CONFIG_XENO_OPT_STATS_IRQS */
+
+static inline int xnintr_query_init(struct xnintr_iterator *iterator)
+{
+	return 0;
+}
+
+static inline int xnintr_get_query_lock(void)
+{
+	return 0;
+}
+
+static inline void xnintr_put_query_lock(void) {}
+#endif /* !CONFIG_XENO_OPT_STATS_IRQS */
+
 /** @} */
 
 #endif /* !_COBALT_KERNEL_INTR_H */
diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
index d099f873f8..0d96913bd9 100644
--- a/kernel/cobalt/Kconfig
+++ b/kernel/cobalt/Kconfig
@@ -135,6 +135,16 @@ config XENO_OPT_STATS
 	per-thread runtime statistics, which are accessible through
 	the /proc/xenomai/sched/stat interface.
 
+config XENO_OPT_STATS_IRQS
+	bool "Account IRQ handlers separatly"
+	depends on XENO_OPT_STATS
+	default y
+	help
+	When enabled, the runtime of interrupt handlers is accounted
+	separately from the threads they interrupt. Also, the
+	occurrence of shared interrupts is accounted on a per-handler
+	basis.
+
 config XENO_OPT_SHIRQ
 	bool "Shared interrupts"
 	help
diff --git a/kernel/cobalt/intr.c b/kernel/cobalt/intr.c
index 9c3f555088..d6fc0af6fa 100644
--- a/kernel/cobalt/intr.c
+++ b/kernel/cobalt/intr.c
@@ -37,7 +37,7 @@
 
 static DEFINE_MUTEX(intrlock);
 
-#ifdef CONFIG_XENO_OPT_STATS
+#ifdef CONFIG_XENO_OPT_STATS_IRQS
 struct xnintr nktimer;	     /* Only for statistics */
 static int xnintr_count = 1; /* Number of attached xnintr objects + nktimer */
 static int xnintr_list_rev;  /* Modification counter of xnintr list */
@@ -123,7 +123,8 @@ static void inc_irqstats(struct xnintr *intr, struct xnsched *sched, xnticks_t s
 	xnstat_exectime_lazy_switch(sched, &statp->account, start);
 }
 
-static inline void switch_irqstats(struct xnintr *intr, struct xnsched *sched)
+static inline void switch_to_irqstats(struct xnintr *intr,
+				      struct xnsched *sched)
 {
 	struct xnirqstat *statp;
 
@@ -131,6 +132,12 @@ static inline void switch_irqstats(struct xnintr *intr, struct xnsched *sched)
 	xnstat_exectime_switch(sched, &statp->account);
 }
 
+static inline void switch_from_irqstats(struct xnsched *sched,
+					xnstat_exectime_t *prev)
+{
+	xnstat_exectime_switch(sched, prev);
+}
+
 static inline xnstat_exectime_t *switch_core_irqstats(struct xnsched *sched)
 {
 	struct xnirqstat *statp;
@@ -143,7 +150,7 @@ static inline xnstat_exectime_t *switch_core_irqstats(struct xnsched *sched)
 	return prev;
 }
 
-#else  /* !CONFIG_XENO_OPT_STATS */
+#else  /* !CONFIG_XENO_OPT_STATS_IRQS */
 
 static inline void stat_counter_inc(void) {}
 
@@ -162,14 +169,18 @@ static inline void query_irqstats(struct xnintr *intr, int cpu,
 
 static inline void inc_irqstats(struct xnintr *intr, struct xnsched *sched, xnticks_t start) {}
 
-static inline void switch_irqstats(struct xnintr *intr, struct xnsched *sched) {}
+static inline void switch_to_irqstats(struct xnintr *intr,
+				      struct xnsched *sched) {}
+
+static inline void switch_from_irqstats(struct xnsched *sched,
+					xnstat_exectime_t *prev) {}
 
 static inline xnstat_exectime_t *switch_core_irqstats(struct xnsched *sched)
 {
 	return NULL;
 }
 
-#endif /* !CONFIG_XENO_OPT_STATS */
+#endif /* !CONFIG_XENO_OPT_STATS_IRQS */
 
 static void xnintr_irq_handler(unsigned int irq, void *cookie);
 
@@ -210,7 +221,7 @@ void xnintr_core_clock_handler(void)
 	xnlock_put(&nklock);
 
 	trace_cobalt_clock_exit(per_cpu(ipipe_percpu.hrtimer_irq, cpu));
-	xnstat_exectime_switch(sched, prev);
+	switch_from_irqstats(sched, prev);
 
 	if (--sched->inesting == 0) {
 		sched->lflags &= ~XNINIRQ;
@@ -353,7 +364,7 @@ static void xnintr_vec_handler(unsigned int irq, void *cookie)
 	else
 		ipipe_end_irq(irq);
 out:
-	xnstat_exectime_switch(sched, prev);
+	switch_from_irqstats(sched, prev);
 
 	trace_cobalt_irq_exit(irq);
 
@@ -393,7 +404,7 @@ static void xnintr_edge_vec_handler(unsigned int irq, void *cookie)
 	}
 
 	while (intr != end) {
-		switch_irqstats(intr, sched);
+		switch_to_irqstats(intr, sched);
 		/*
 		 * NOTE: We assume that no CPU migration will occur
 		 * while running the interrupt service routine.
@@ -439,7 +450,7 @@ static void xnintr_edge_vec_handler(unsigned int irq, void *cookie)
 	else
 		ipipe_end_irq(irq);
 out:
-	xnstat_exectime_switch(sched, prev);
+	switch_from_irqstats(sched, prev);
 
 	trace_cobalt_irq_exit(irq);
 
@@ -658,7 +669,7 @@ done:
 	else
 		ipipe_end_irq(irq);
 out:
-	xnstat_exectime_switch(sched, prev);
+	switch_from_irqstats(sched, prev);
 
 	if (--sched->inesting == 0) {
 		sched->lflags &= ~XNINIRQ;
@@ -1001,7 +1012,7 @@ static inline int xnintr_is_timer_irq(int irq)
 	return 0;
 }
 
-#ifdef CONFIG_XENO_OPT_STATS
+#ifdef CONFIG_XENO_OPT_STATS_IRQS
 
 int xnintr_get_query_lock(void)
 {
@@ -1072,7 +1083,7 @@ int xnintr_query_next(int irq, struct xnintr_iterator *iterator,
 	}
 }
 
-#endif /* CONFIG_XENO_OPT_STATS */
+#endif /* CONFIG_XENO_OPT_STATS_IRQS */
 
 #ifdef CONFIG_XENO_OPT_VFILE
 
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 9c7a729b83..74dc7a9619 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -1278,7 +1278,7 @@ static int vfile_schedstat_next(struct xnvfile_snapshot_iterator *it,
 	struct xnthread *thread;
 	struct xnsched *sched;
 	xnticks_t period;
-	int ret;
+	int __maybe_unused ret;
 
 	if (priv->curr == NULL)
 		/*
@@ -1324,6 +1324,7 @@ static int vfile_schedstat_next(struct xnvfile_snapshot_iterator *it,
 	return 1;
 
 scan_irqs:
+#ifdef CONFIG_XENO_OPT_STATS_IRQS
 	if (priv->irq >= IPIPE_NR_IRQS)
 		return 0;	/* All done. */
 
@@ -1353,6 +1354,9 @@ scan_irqs:
 	p->period = 0;
 
 	return 1;
+#else /* !CONFIG_XENO_OPT_STATS_IRQS */
+	return 0;
+#endif /* !CONFIG_XENO_OPT_STATS_IRQS */
 }
 
 static int vfile_schedstat_show(struct xnvfile_snapshot_iterator *it,
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index 1f7972deb8..ae3f2e5baa 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -840,14 +840,14 @@ int xntimer_grab_hardware(void)
 	int ret, cpu, _cpu;
 	spl_t s;
 
-#ifdef CONFIG_XENO_OPT_STATS
+#ifdef CONFIG_XENO_OPT_STATS_IRQS
 	/*
 	 * Only for statistical purpose, the timer interrupt is
 	 * attached by xntimer_grab_hardware().
 	 */
 	xnintr_init(&nktimer, "[timer]",
 		    per_cpu(ipipe_percpu.hrtimer_irq, 0), NULL, NULL, 0);
-#endif /* CONFIG_XENO_OPT_STATS */
+#endif /* CONFIG_XENO_OPT_STATS_IRQS */
 
 	nkclock.wallclock_offset =
 		xnclock_get_host_time() - xnclock_read_monotonic(&nkclock);
@@ -938,9 +938,9 @@ void xntimer_release_hardware(void)
 
 	xntimer_release_ipi();
 
-#ifdef CONFIG_XENO_OPT_STATS
+#ifdef CONFIG_XENO_OPT_STATS_IRQS
 	xnintr_destroy(&nktimer);
-#endif /* CONFIG_XENO_OPT_STATS */
+#endif /* CONFIG_XENO_OPT_STATS_IRQS */
 }
 EXPORT_SYMBOL_GPL(xntimer_release_hardware);
 
-- 
2.16.4

