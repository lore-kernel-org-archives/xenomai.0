From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 18/25] cobalt/timer: pipeline: abstract handling of
 ONESHOT_STOPPED mode
Date: Thu, 20 May 2021 23:44:28 +0200
Message-Id: <93e7b3481e764d6581fc58270ef3afa4490abf8a.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
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
To: xenomai@xenomai.org

From: Hongzhan Chen <hongzhan.chen@intel.com>

It adds a way to force the timer management code to reprogram the
hardware on option, to make the real device controlled by the proxy
tick again as it leaves the ONESHOT_STOPPED mode. The I-pipe does not
require any further action in this case, leading to a nop.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/ipipe/pipeline/tick.h | 6 ++++++
 include/cobalt/kernel/sched.h               | 5 +++++
 kernel/cobalt/clock.c                       | 2 +-
 kernel/cobalt/timer.c                       | 5 ++++-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/kernel/ipipe/pipeline/tick.h b/include/cobalt/kernel/ipipe/pipeline/tick.h
index 409581a3cb..41347f7b18 100644
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
index c13f46ff7d..aa24d54420 100644
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
index bf24e16938..2115b15ef8 100644
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
index 9297cca186..1ec7617915 100644
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
2.26.2


