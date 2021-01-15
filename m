From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 6/8] cobalt/timer: pipeline: abstract signal test of XNTSTOP
Date: Thu, 14 Jan 2021 20:16:36 -0500
Message-Id: <20210115011639.15390-6-hongzhan.chen@intel.com>
In-Reply-To: <20210115011639.15390-1-hongzhan.chen@intel.com>
References: <20210115011639.15390-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The I-pipe kind of internally "emulates" a shutdown+restart sequence
automatically upon resuming a timer after the ONESHOT_STOPPED state, so
we actually do not need XNTSTOP in this case. We should
specifically abstract the single test of XNTSTOP when arming a
timer, so that the Dovetail version does the right thing.
We can leave XNTSTOP in the set/clear mask bits operations in either
the I-pipe and Dovetail cases, this has zero overhead since other bits
are being set/cleared in these operations anyway.

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/include/cobalt/kernel/ipipe/pipeline/tick.h b/include/cobalt/kernel/ipipe/pipeline/tick.h
index 409581a3c..41347f7b1 100644
--- a/include/cobalt/kernel/ipipe/pipeline/tick.h
+++ b/include/cobalt/kernel/ipipe/pipeline/tick.h
@@ -9,4 +9,10 @@ int pipeline_install_tick_proxy(void);
 
 void pipeline_uninstall_tick_proxy(void);
 
+struct xnsched;
+static inline bool pipeline_must_force_program_tick(struct xnsched *sched)
+{
+	return false;
+}
+
 #endif /* !_COBALT_KERNEL_IPIPE_TICK_H */
diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index c13f46ff7..aa24d5442 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -48,6 +48,11 @@
 #define XNINIRQ		0x00004000	/* In IRQ handling context */
 #define XNHDEFER	0x00002000	/* Host tick deferred */
 
+/*
+ * Hardware timer is stopped.
+ */
+#define XNTSTOP		0x00000800
+
 struct xnsched_rt {
 	xnsched_queue_t runnable;	/*!< Runnable thread queue. */
 };
diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index bf24e1693..2115b15ef 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -147,7 +147,7 @@ void xnclock_core_local_shot(struct xnsched *sched)
 	 * or a timer with an earlier timeout date is scheduled,
 	 * whichever comes first.
 	 */
-	sched->lflags &= ~(XNHDEFER|XNIDLE);
+	sched->lflags &= ~(XNHDEFER|XNIDLE|XNTSTOP);
 	timer = container_of(h, struct xntimer, aplink);
 	if (unlikely(timer == &sched->htimer)) {
 		if (xnsched_resched_p(sched) ||
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index f9aa457ce..f667a3878 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -18,6 +18,7 @@
  * 02111-1307, USA.
  */
 #include <linux/sched.h>
+#include <pipeline/tick.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/thread.h>
 #include <cobalt/kernel/timer.h>
@@ -63,8 +64,10 @@ int xntimer_heading_p(struct xntimer *timer)
 
 void xntimer_enqueue_and_program(struct xntimer *timer, xntimerq_t *q)
 {
+	struct xnsched *sched = xntimer_sched(timer);
+
 	xntimer_enqueue(timer, q);
-	if (xntimer_heading_p(timer)) {
+	if (pipeline_must_force_program_tick(sched) || xntimer_heading_p(timer)) {
 		struct xnsched *sched = xntimer_sched(timer);
 		struct xnclock *clock = xntimer_clock(timer);
 		if (sched != xnsched_current())
-- 
2.17.1


