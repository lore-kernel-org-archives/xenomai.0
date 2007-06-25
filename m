From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Mon, 25 Jun 2007 21:11:39 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706252111.40219.dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>


Hello Jan,

well, take it with 2 huge grains of salt.. it's even not compile-tested :-)

I don't think I've got it really nicer than your first patch.. the only additional point is that
'prev = xnstat_get_current()' reference is also tracked as reference accounting becomes
a part of the xnstat interface (not sure we do need it though).

Well (#2), I have to say that the whole intr subsystem looks not that nice (maybe partly due
to being overloaded with xnstat details).. so I think, it'd require a closer look.

Anyway, here is what I've got out of your patch so far.. the main issue is whether we go this way
or it just makes things even more uglier.

(a side effect : I transformed xnstat_* macroses into 'static inline' function.. I guess, this way it's a bit nicer)

----------

diff -upr xenomai-orig/include/nucleus/stat.h xenomai-intr/include/nucleus/stat.h
--- xenomai-orig/include/nucleus/stat.h	2007-06-23 14:03:58.000000000 +0200
+++ xenomai-intr/include/nucleus/stat.h	2007-06-24 15:25:37.000000000 +0200
@@ -31,46 +31,72 @@ typedef struct xnstat_runtime {
 
 	xnticks_t total; /* Accumulated execution time */
 
+	atomic_counter_t refs;
+
 } xnstat_runtime_t;
 
 /* Return current date which can be passed to other xnstat services for
    immediate or lazy accounting. */
-#define xnstat_runtime_now() xnarch_get_cpu_tsc()
+static inline xnticks_t xnstat_runtime_now(void)
+{
+	return xnarch_get_cpu_tsc();
+}
 
 /* Accumulate runtime of the current account until the given date. */
-#define xnstat_runtime_update(sched, start) \
-do { \
-	(sched)->current_account->total += \
-		start - (sched)->last_account_switch; \
-	(sched)->last_account_switch = start; \
-} while (0)
+static inline void xnstat_runtime_update(xnsched_t *sched, xnticks_t start)
+{
+	sched->current_account->total += start - sched->last_account_switch;
+	sched->last_account_switch = start;
+}
 
 /* Update the current account reference, returning the previous one. */
-#define xnstat_runtime_set_current(sched, new_account) \
-({ \
-	xnstat_runtime_t *__prev; \
-	__prev = xnarch_atomic_xchg(&(sched)->current_account, (new_account)); \
-	__prev; \
-})
+static inline void xnstat_runtime_set_current(xnsched_t *sched, xnstat_runtime_t *new_account)
+{
+	xnstat_runtime_t *prev;
+
+	if (likely(new_account))
+		xnarch_atomic_inc(&new_account->refs);
+	prev = xnarch_atomic_xchg(&sched->current_account, new_account);
+	if (likely(prev))
+		xnarch_atomic_dec(&prev->refs);
+}
 
 /* Return the currently active accounting entity. */
-#define xnstat_runtime_get_current(sched) ((sched)->current_account)
+static inline xnstat_runtime_t * xnstat_runtime_get_current(xnsched_t *sched)
+{
+	xnstat_runtime_t *curr = sched->current_account;
+
+	if (likely(curr))
+		xnarch_atomic_inc(&curr->refs);
+}
+
+static inline void xnstat_runtime_put(xnstat_runtime_t *stat)
+{
+	if (likely(stat))
+		xnarch_atomic_dec(&stat->refs);
+}
 
 /* Finalize an account (no need to accumulate the runtime, just mark the
    switch date and set the new account). */
-#define xnstat_runtime_finalize(sched, new_account) \
-do { \
-	(sched)->last_account_switch = xnarch_get_cpu_tsc(); \
-	(sched)->current_account = (new_account); \
-} while (0)
+static inline void xnstat_runtime_finalize(xnsched_t *sched, xnstat_runtime_t *new_account)
+{
+	sched->last_account_switch = xnarch_get_cpu_tsc();
+	xnstat_runtime_set_current(sched, new_account);
+}
 
 /* Reset statistics from inside the accounted entity (e.g. after CPU
    migration). */
-#define xnstat_runtime_reset_stats(stat) \
-do { \
-	(stat)->total = 0; \
-	(stat)->start = xnarch_get_cpu_tsc(); \
-} while (0)
+static inline void xnstat_runtime_reset_stats(xnstat_runtime_t *stat)
+{
+	stat->total = 0;
+	stat->start = xnarch_get_cpu_tsc();
+}
+
+static void xnstat_runtime_sync(xnstat_runtime_t *stat)
+{
+	while (xnarch_atomic_get(&stat->refs))
+		cpu_relax();
+}
 
 
 typedef struct xnstat_counter {
@@ -101,10 +127,12 @@ typedef struct xnstat_runtime {
 
 #define xnstat_runtime_now()					({ 0; })
 #define xnstat_runtime_update(sched, start)			do { } while (0)
-#define xnstat_runtime_set_current(sched, new_account)	({ (void)sched; NULL; })
+#define xnstat_runtime_set_current(sched, new_account)		do { } while (0)
 #define xnstat_runtime_get_current(sched)			({ (void)sched; NULL; })
+#define xnstat_runtime_put(stat)				do { } while (0)
 #define xnstat_runtime_finalize(sched, new_account)		do { } while (0)
 #define xnstat_runtime_reset_stats(account)			do { } while (0)
+#define xnstat_runtime_sync(account)				do { } while (0)
 
 typedef struct xnstat_counter {
 #ifdef __XENO_SIM__
@@ -119,18 +147,20 @@ typedef struct xnstat_counter {
 
 /* Account the runtime of the current account until now, switch to
    new_account, and return the previous one. */
-#define xnstat_runtime_switch(sched, new_account) \
-({ \
-	xnstat_runtime_update(sched, xnstat_runtime_now()); \
-	xnstat_runtime_set_current(sched, new_account); \
-})
+static inline void
+xnstat_runtime_switch(xnsched_t *sched, xnstat_runtime_t *new_account)
+{
+	xnstat_runtime_update(sched, xnstat_runtime_now());
+	xnstat_runtime_set_current(sched, new_account);
+}
 
 /* Account the runtime of the current account until given start time, switch
    to new_account, and return the previous one. */
-#define xnstat_runtime_lazy_switch(sched, new_account, start) \
-({ \
-	xnstat_runtime_update(sched, start); \
-	xnstat_runtime_set_current(sched, new_account); \
-})
+static inline void
+xnstat_runtime_lazy_switch(xnsched_t *sched, xnstat_runtime_t *new_account, xnticks_t start)
+{
+	xnstat_runtime_update(sched, start);
+	xnstat_runtime_set_current(sched, new_account);
+}
 
 #endif /* !_XENO_NUCLEUS_STAT_H */
diff -upr xenomai-orig/ksrc/nucleus/intr.c xenomai-intr/ksrc/nucleus/intr.c
--- xenomai-orig/ksrc/nucleus/intr.c	2007-06-23 15:13:43.000000000 +0200
+++ xenomai-intr/ksrc/nucleus/intr.c	2007-06-24 15:47:58.000000000 +0200
@@ -41,6 +41,18 @@
 
 DEFINE_PRIVATE_XNLOCK(intrlock);
 
+typedef struct xnintr_irq {
+
+	DECLARE_XNLOCK(lock);
+
+#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
+	xnintr_t *handlers;
+	int unhandled;
+#endif
+} ____cacheline_aligned_in_smp xnintr_irq_t;
+
+static xnintr_irq_t xnirqs[RTHAL_NR_IRQS];
+
 #ifdef CONFIG_XENO_OPT_STATS
 xnintr_t nkclock;	/* Only for statistics */
 int xnintr_count = 1;	/* Number of attached xnintr objects + nkclock */
@@ -63,9 +75,18 @@ static inline void xnintr_stat_counter_d
 	xnarch_memory_barrier();
 	xnintr_list_rev++;
 }
+
+static inline void xnintr_sync_stat_refs(xnintr_t *intr)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		xnstat_runtime_sync(&intr->stat[cpu].account);
+}
 #else
 static inline void xnintr_stat_counter_inc(void) {}
 static inline void xnintr_stat_counter_dec(void) {}
+static inline void xnintr_sync_stat_refs(xnintr_t *intr) {}
 #endif /* CONFIG_XENO_OPT_STATS */
 
 /*
@@ -76,31 +97,44 @@ static inline void xnintr_stat_counter_d
 static void xnintr_irq_handler(unsigned irq, void *cookie)
 {
 	xnsched_t *sched = xnpod_current_sched();
-	xnintr_t *intr = (xnintr_t *)cookie;
+	xnintr_t *intr;
 	xnstat_runtime_t *prev;
 	xnticks_t start;
-	int s;
+	int s = 0;
 
 	prev  = xnstat_runtime_get_current(sched);
 	start = xnstat_runtime_now();
 	xnltt_log_event(xeno_ev_ienter, irq);
 
 	++sched->inesting;
-	s = intr->isr(intr);
 
-	if (unlikely(s == XN_ISR_NONE)) {
-		if (++intr->unhandled == XNINTR_MAX_UNHANDLED) {
-			xnlogerr("%s: IRQ%d not handled. Disabling IRQ "
-				 "line.\n", __FUNCTION__, irq);
-			s |= XN_ISR_NOENABLE;
+	xnlock_get(&xnirqs[irq].lock);
+
+#ifdef CONFIG_SMP
+	/* In SMP case, we have to reload the cookie under the per-IRQ lock
+	   to avoid racing with xnintr_detach. */
+	intr = rthal_irq_cookie(&rthal_domain, irq);
+#else
+	intr = cookie;
+#endif
+	if (likely(intr)) {
+		s = intr->isr(intr);
+
+		if (unlikely(s == XN_ISR_NONE)) {
+			if (++intr->unhandled == XNINTR_MAX_UNHANDLED) {
+				xnlogerr("%s: IRQ%d not handled. Disabling IRQ "
+					 "line.\n", __FUNCTION__, irq);
+				s |= XN_ISR_NOENABLE;
+			}
+		} else {
+			xnstat_counter_inc(&intr->stat[xnsched_cpu(sched)].hits);
+			xnstat_runtime_lazy_switch(sched,
+				&intr->stat[xnsched_cpu(sched)].account,
+				start);
+			intr->unhandled = 0;
 		}
-	} else {
-		xnstat_counter_inc(&intr->stat[xnsched_cpu(sched)].hits);
-		xnstat_runtime_lazy_switch(sched,
-			&intr->stat[xnsched_cpu(sched)].account,
-			start);
-		intr->unhandled = 0;
 	}
+	xnlock_put(&xnirqs[irq].lock);
 
 	if (s & XN_ISR_PROPAGATE)
 		xnarch_chain_irq(irq);
@@ -112,6 +146,7 @@ static void xnintr_irq_handler(unsigned 
 
 	xnltt_log_event(xeno_ev_iexit, irq);
 	xnstat_runtime_switch(sched, prev);
+	xnstat_runtime_put(prev);
 }
 
 /* Low-level clock irq handler. */
@@ -155,24 +190,13 @@ void xnintr_clock_handler(void)
 
 	xnltt_log_event(xeno_ev_iexit, XNARCH_TIMER_IRQ);
 	xnstat_runtime_switch(sched, prev);
+	xnstat_runtime_put(prev);
 }
 
 /* Optional support for shared interrupts. */
 
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
 
-typedef struct xnintr_shirq {
-
-	xnintr_t *handlers;
-	int unhandled;
-#ifdef CONFIG_SMP
-	xnlock_t lock;
-#endif
-
-} xnintr_shirq_t;
-
-static xnintr_shirq_t xnshirqs[RTHAL_NR_IRQS];
-
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL)
 /*
  * Low-level interrupt handler dispatching the user-defined ISRs for
@@ -184,7 +208,7 @@ static void xnintr_shirq_handler(unsigne
 	xnsched_t *sched = xnpod_current_sched();
 	xnstat_runtime_t *prev;
 	xnticks_t start;
-	xnintr_shirq_t *shirq = &xnshirqs[irq];
+	xnintr_irq_t *shirq = &xnirqs[irq];
 	xnintr_t *intr;
 	int s = 0;
 
@@ -236,6 +260,7 @@ static void xnintr_shirq_handler(unsigne
 
 	xnltt_log_event(xeno_ev_iexit, irq);
 	xnstat_runtime_switch(sched, prev);
+	xnstat_runtime_put(prev);
 }
 
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL */
@@ -253,7 +278,7 @@ static void xnintr_edge_shirq_handler(un
 	xnsched_t *sched = xnpod_current_sched();
 	xnstat_runtime_t *prev;
 	xnticks_t start;
-	xnintr_shirq_t *shirq = &xnshirqs[irq];
+	xnintr_irq_t *shirq = &xnirqs[irq];
 	xnintr_t *intr, *end = NULL;
 	int s = 0, counter = 0;
 
@@ -277,15 +302,15 @@ static void xnintr_edge_shirq_handler(un
 		s |= ret;
 
 		if (code == XN_ISR_HANDLED) {
-			end = NULL;
+			if (!(end = (intr->next)))
+				end = shirq->handlers;
 			xnstat_counter_inc(
 				&intr->stat[xnsched_cpu(sched)].hits);
 			xnstat_runtime_lazy_switch(sched,
 				&intr->stat[xnsched_cpu(sched)].account,
 				start);
 			start = xnstat_runtime_now();
-		} else if (code == XN_ISR_NONE && end == NULL)
-			end = intr;
+		}
 
 		if (counter++ > MAX_EDGEIRQ_COUNTER)
 			break;
@@ -320,13 +345,14 @@ static void xnintr_edge_shirq_handler(un
 
 	xnltt_log_event(xeno_ev_iexit, irq);
 	xnstat_runtime_switch(sched, prev);
+	xnstat_runtime_put(prev);
 }
 
 #endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
 
 static inline int xnintr_irq_attach(xnintr_t *intr)
 {
-	xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
+	xnintr_irq_t *shirq = &xnirqs[intr->irq];
 	xnintr_t *prev, **p = &shirq->handlers;
 	int err;
 
@@ -379,17 +405,16 @@ static inline int xnintr_irq_attach(xnin
 
 	intr->next = NULL;
 
-	/* Add a given interrupt object. */
-	xnlock_get(&shirq->lock);
+	/* Add the given interrupt object. No need to synchronise with the IRQ
+	   handler, we are only extending the chain. */
 	*p = intr;
-	xnlock_put(&shirq->lock);
 
 	return 0;
 }
 
 static inline int xnintr_irq_detach(xnintr_t *intr)
 {
-	xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
+	xnintr_irq_t *shirq = &xnirqs[intr->irq];
 	xnintr_t *e, **p = &shirq->handlers;
 	int err = 0;
 
@@ -408,6 +433,8 @@ static inline int xnintr_irq_detach(xnin
 			*p = e->next;
 			xnlock_put(&shirq->lock);
 
+			xnintr_sync_stat_references(intr);
+
 			/* Release the IRQ line if this was the last user */
 			if (shirq->handlers == NULL)
 				err = xnarch_release_irq(intr->irq);
@@ -422,14 +449,6 @@ static inline int xnintr_irq_detach(xnin
 	return err;
 }
 
-int xnintr_mount(void)
-{
-	int i;
-	for (i = 0; i < RTHAL_NR_IRQS; ++i)
-		xnlock_init(&xnshirqs[i].lock);
-	return 0;
-}
-
 #else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
 
 static inline int xnintr_irq_attach(xnintr_t *intr)
@@ -439,13 +458,30 @@ static inline int xnintr_irq_attach(xnin
 
 static inline int xnintr_irq_detach(xnintr_t *intr)
 {
-	return xnarch_release_irq(intr->irq);
-}
+	int irq = intr->irq;
+	int err;
+
+	xnlock_get(&xnirqs[irq].lock);
+
+	err = xnarch_release_irq(intr->irq);
 
-int xnintr_mount(void) { return 0; }
+	xnlock_put(&xnirqs[irq].lock);
+
+	xnintr_sync_stat_references(intr);
+
+	return err;
+}
 
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
 
+int xnintr_mount(void)
+{
+	int i;
+	for (i = 0; i < RTHAL_NR_IRQS; ++i)
+		xnlock_init(&xnirqs[i].lock);
+	return 0;
+}
+
 /*!
  * \fn int xnintr_init (xnintr_t *intr,const char *name,unsigned irq,xnisr_t isr,xniack_t iack,xnflags_t flags)
  * \brief Initialize an interrupt object.
@@ -809,7 +845,7 @@ int xnintr_irq_proc(unsigned int irq, ch
 	xnlock_get_irqsave(&intrlock, s);
 
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
-	intr = xnshirqs[irq].handlers;
+	intr = xnirqs[irq].handlers;
 	if (intr) {
 		strcpy(p, "        "); p += 8;
 
@@ -862,7 +898,7 @@ int xnintr_query(int irq, int *cpu, xnin
 	else if (irq == XNARCH_TIMER_IRQ)
 		intr = &nkclock;
 	else
-		intr = xnshirqs[irq].handlers;
+		intr = xnirqs[irq].handlers;
 #else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
 	if (*prev)
 		intr = NULL;

