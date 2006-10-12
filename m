Message-ID: <452E9AE2.3000104@domain.hid>
Date: Thu, 12 Oct 2006 21:43:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060105030300000400020305"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 3/3] Extend and refine IRQ runtime accounting
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------060105030300000400020305
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

This is my personally favoured accounting model for xnintr runtimes:
 - include scheduler path in the xnintr accounting
 - account only to those xnintr entity that reported XN_ISR_HANDLED on
   ISR return

Slight unfairness remains:
 - I-pipe prologue and epilogue cannot be considered (but it's fairly
   short)
 - always the last xnintr on a shared IRQ line that reported HANDLED
   pays for the potential scheduler path, even if it didn't caused it
   (bean counting...)
 - the preempted thread still pays for spurious IRQs (but those are bugs
   anyway)

As a side effect, this patch refactores the xnstat API to provide new
lazy switching services and drops unused functions again. Net binary
size increase on x86 is ~60 bytes, mostly for shared IRQs, but the
average runtime impact on those paths should be lower.

Jan

--------------060105030300000400020305
Content-Type: text/plain;
 name="irq_stats_2nd_model.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq_stats_2nd_model.patch"

---
 include/nucleus/stat.h |   33 +++++++++++++++++++++++----------
 ksrc/nucleus/intr.c    |   39 +++++++++++++++++++++++++--------------
 2 files changed, 48 insertions(+), 24 deletions(-)

Index: xenomai/ksrc/nucleus/intr.c
===================================================================
--- xenomai.orig/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -60,19 +60,18 @@ static void xnintr_irq_handler(unsigned 
 	xnsched_t *sched = xnpod_current_sched();
 	xnintr_t *intr = (xnintr_t *)cookie;
 	xnstat_runtime_t *prev;
+	xnticks_t start;
 	int s;
 
 	xnarch_memory_barrier();
 
+	prev  = xnstat_runtime_get_current(sched);
+	start = xnstat_runtime_now();
 	xnltt_log_event(xeno_ev_ienter, irq);
-	prev = xnstat_runtime_switch(sched,
-				     &intr->stat[xnsched_cpu(sched)].account);
 
 	++sched->inesting;
 	s = intr->isr(intr);
 
-	xnstat_runtime_switch(sched, prev);
-
 	if (unlikely(s == XN_ISR_NONE)) {
 		if (++intr->unhandled == XNINTR_MAX_UNHANDLED) {
 			xnlogerr("%s: IRQ%d not handled. Disabling IRQ "
@@ -81,6 +80,9 @@ static void xnintr_irq_handler(unsigned 
 		}
 	} else {
 		xnstat_counter_inc(&intr->stat[xnsched_cpu(sched)].hits);
+		xnstat_runtime_lazy_switch(sched,
+			&intr->stat[xnsched_cpu(sched)].account,
+			start);
 		intr->unhandled = 0;
 	}
 
@@ -102,6 +104,7 @@ static void xnintr_irq_handler(unsigned 
 	}
 
 	xnltt_log_event(xeno_ev_iexit, irq);
+	xnstat_runtime_switch(sched, prev);
 }
 
 /* Low-level clock irq handler. */
@@ -162,13 +165,15 @@ static void xnintr_shirq_handler(unsigne
 {
 	xnsched_t *sched = xnpod_current_sched();
 	xnstat_runtime_t *prev;
+	xnticks_t start;
 	xnintr_shirq_t *shirq = &xnshirqs[irq];
 	xnintr_t *intr;
 	int s = 0;
 
 	xnarch_memory_barrier();
 
-	prev = xnstat_runtime_get_current(sched);
+	prev  = xnstat_runtime_get_current(sched);
+	start = xnstat_runtime_now();
 	xnltt_log_event(xeno_ev_ienter, irq);
 
 	++sched->inesting;
@@ -179,21 +184,21 @@ static void xnintr_shirq_handler(unsigne
 	while (intr) {
 		int ret;
 
-		xnstat_runtime_switch(sched,
-			&intr->stat[xnsched_cpu(sched)].account);
-
 		ret = intr->isr(intr);
 		s |= ret;
 
-		if (ret & XN_ISR_HANDLED)
+		if (ret & XN_ISR_HANDLED) {
 			xnstat_counter_inc(
 				&intr->stat[xnsched_cpu(sched)].hits);
+			xnstat_runtime_lazy_switch(sched,
+				&intr->stat[xnsched_cpu(sched)].account,
+				start);
+			start = xnstat_runtime_now();
+		}
 
 		intr = intr->next;
 	}
 
-	xnstat_runtime_switch(sched, prev);
-
 	xnintr_shirq_unlock(shirq);
 
 	if (unlikely(s == XN_ISR_NONE)) {
@@ -214,6 +219,7 @@ static void xnintr_shirq_handler(unsigne
 		xnpod_schedule();
 
 	xnltt_log_event(xeno_ev_iexit, irq);
+	xnstat_runtime_switch(sched, prev);
 }
 
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL */
@@ -230,13 +236,15 @@ static void xnintr_edge_shirq_handler(un
 
 	xnsched_t *sched = xnpod_current_sched();
 	xnstat_runtime_t *prev;
+	xnticks_t start;
 	xnintr_shirq_t *shirq = &xnshirqs[irq];
 	xnintr_t *intr, *end = NULL;
 	int s = 0, counter = 0;
 
 	xnarch_memory_barrier();
 
-	prev = xnstat_runtime_get_current(sched);
+	prev  = xnstat_runtime_get_current(sched);
+	start = xnstat_runtime_now();
 	xnltt_log_event(xeno_ev_ienter, irq);
 
 	++sched->inesting;
@@ -258,6 +266,10 @@ static void xnintr_edge_shirq_handler(un
 			end = NULL;
 			xnstat_counter_inc(
 				&intr->stat[xnsched_cpu(sched)].hits);
+			xnstat_runtime_lazy_switch(sched,
+				&intr->stat[xnsched_cpu(sched)].account,
+				start);
+			start = xnstat_runtime_now();
 		} else if (code == XN_ISR_NONE && end == NULL)
 			end = intr;
 
@@ -268,8 +280,6 @@ static void xnintr_edge_shirq_handler(un
 			intr = shirq->handlers;
 	}
 
-	xnstat_runtime_switch(sched, prev);
-
 	xnintr_shirq_unlock(shirq);
 
 	if (counter > MAX_EDGEIRQ_COUNTER)
@@ -295,6 +305,7 @@ static void xnintr_edge_shirq_handler(un
 		xnpod_schedule();
 
 	xnltt_log_event(xeno_ev_iexit, irq);
+	xnstat_runtime_switch(sched, prev);
 }
 
 #endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
Index: xenomai/include/nucleus/stat.h
===================================================================
--- xenomai.orig/include/nucleus/stat.h
+++ xenomai/include/nucleus/stat.h
@@ -23,6 +23,8 @@
 
 #ifdef CONFIG_XENO_OPT_STATS
 
+#include <nucleus/types.h>
+
 typedef struct xnstat_runtime {
 
 	xnticks_t start;   /* Start of execution time accumulation */
@@ -31,14 +33,16 @@ typedef struct xnstat_runtime {
 
 } xnstat_runtime_t;
 
-/* Account runtime of current account up to now, but don't set a new
-   account yet. */
-#define xnstat_runtime_update(sched) \
+/* Return current date which can be passed to other xnstat services for
+   immediate or lazy accounting. */
+#define xnstat_runtime_now() xnarch_get_cpu_tsc()
+
+/* Accumulate runtime of the current account until the given date. */
+#define xnstat_runtime_update(sched, start) \
 do { \
-	xnticks_t now = xnarch_get_cpu_tsc(); \
 	(sched)->current_account->total += \
-		now - (sched)->last_account_switch; \
-	(sched)->last_account_switch = now; \
+		start - (sched)->last_account_switch; \
+	(sched)->last_account_switch = start; \
 } while (0)
 
 /* Update the current account reference, returning the previous one. */
@@ -82,7 +86,8 @@ static inline int xnstat_counter_get(xns
 typedef struct xnstat_runtime {
 } xnstat_runtime_t;
 
-#define xnstat_runtime_update(sched)                         do { } while (0)
+#define xnstat_runtime_now()                                 0
+#define xnstat_runtime_update(sched, start)                  do { } while (0)
 #define xnstat_runtime_set_current(sched, new_account)       ({ NULL; })
 #define xnstat_runtime_get_current(sched)                    ({ NULL; })
 #define xnstat_runtime_finalize(sched)                       do { } while (0)
@@ -95,11 +100,19 @@ static inline int xnstat_counter_inc(xns
 static inline int xnstat_counter_get(xnstat_counter_t *c) { return 0; }
 #endif /* CONFIG_XENO_OPT_STATS */
 
-/* Switch to new_account, accounting the runtime of the current one until now
-   and returning the previous account. */
+/* Account the runtime of the current account until now, switch to
+   new_account, and return the previous one. */
 #define xnstat_runtime_switch(sched, new_account) \
 ({ \
-	xnstat_runtime_update(sched); \
+	xnstat_runtime_update(sched, xnstat_runtime_now()); \
+	xnstat_runtime_set_current(sched, new_account); \
+})
+
+/* Account the runtime of the current account until given start time, switch
+   to new_account, and return the previous one. */
+#define xnstat_runtime_lazy_switch(sched, new_account, start) \
+({ \
+	xnstat_runtime_update(sched, start); \
 	xnstat_runtime_set_current(sched, new_account); \
 })
 

--------------060105030300000400020305--

