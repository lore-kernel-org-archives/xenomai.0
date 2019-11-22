From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 5/7] cobalt/thread: fix scheduler breakage on thread suspension
Date: Fri, 22 Nov 2019 18:19:47 +0100
Message-Id: <20191122171949.18021-6-rpm@xenomai.org>
In-Reply-To: <20191122171949.18021-1-rpm@xenomai.org>
References: <20191122171949.18021-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

In the event that xnthread_suspend() adds blocking bit(s) to a thread
which is running in primary mode on a remote CPU at the time of the
call, a spurious rescheduling call is performed, causing the local CPU
to pick its next thread from the remote CPU's runqueue.

CPU0                              CPU1
----                              ----
                                  t2: ...
t1: suspend(t2)                       ...
       |
       |
       +------> t2->sched == t2->sched->curr (i.e. running primary)
                           |
                           |
                           +----> __xnsched_run(t2->sched);
                                        |
                                        |
                                        v
                          CPU0: ___xnsched__run(CPU1.sched);

IOW, CPU0 would pick the next thread from CPU1's runqueue. Conditions
for observing this bug:

- t1 is running in primary mode on the local CPU (such as
  CPU0:sched->curr == t1) , so that the rescheduling request needs no
  prior escalation to the head stage, allowing ___xnsched_run() to
  execute immediately using the sched slot pointer received from
  __xnsched_run().

- t2 is running in primary mode on a remote CPU (such as
  CPU1:sched->curr == t2) when t1 attempts to suspend it via a call to
  xnthread_suspend().

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/thread.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index a95396a0d..3b44feabb 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -962,26 +962,29 @@ void xnthread_suspend(struct xnthread *thread, int mask,
 	 * opportunity for interrupt delivery right before switching
 	 * context, which shortens the uninterruptible code path.
 	 *
-	 * We have to shut irqs off before __xnsched_run() though: if
-	 * an interrupt could preempt us in ___xnsched_run() right
-	 * after the call to xnarch_escalate() but before we grab the
-	 * nklock, we would enter the critical section in
-	 * xnsched_run() while running in secondary mode, which would
-	 * defeat the purpose of xnarch_escalate().
+	 * We have to shut irqs off before calling __xnsched_run()
+	 * though: if an interrupt could preempt us right after
+	 * xnarch_escalate() is passed but before the nklock is
+	 * grabbed, we would enter the critical section in
+	 * ___xnsched_run() from the root domain, which would defeat
+	 * the purpose of escalating the request.
+	 *
+	 * NOTE: using __xnsched_run() for rescheduling allows us to
+	 * break the scheduler lock temporarily.
 	 */
 	if (likely(thread == sched->curr)) {
 		xnsched_set_resched(sched);
 		if (unlikely(mask & XNRELAX)) {
 			xnlock_clear_irqon(&nklock);
 			splmax();
-			__xnsched_run(sched);
+			__xnsched_run(xnsched_current());
 			return;
 		}
 		/*
 		 * If the thread is runnning on another CPU,
 		 * xnsched_run will trigger the IPI as required.
 		 */
-		__xnsched_run(sched);
+		__xnsched_run(xnsched_current());
 		goto out;
 	}
 
-- 
2.21.0


