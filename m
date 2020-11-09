From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 13/15] cobalt/thread: wake up current with raising irq_work
Date: Mon,  9 Nov 2020 02:50:25 -0500
Message-Id: <20201109075027.14760-13-hongzhan.chen@intel.com>
In-Reply-To: <20201109075027.14760-1-hongzhan.chen@intel.com>
References: <20201109075027.14760-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com, xenomai@xenomai.org

wake up current with raising irq_work instead of calling ipipe
interface

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 include/cobalt/kernel/thread.h |  2 ++
 kernel/cobalt/thread.c         | 30 +++++++++++++-----------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index 88fd6e3c7..3283400be 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -205,6 +205,8 @@ struct xnthread {
 	struct completion *done;
 
 	struct irq_work irq_work;
+
+	struct irq_work inband_work;
 };
 
 static inline int xnthread_get_state(const struct xnthread *thread)
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 5943d3b94..f3168d75f 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -137,6 +137,16 @@ static inline int spawn_kthread(struct xnthread *thread)
 	return 0;
 }
 
+static void inband_task_wakeup(struct irq_work *work)
+{
+	struct xnthread *thread;
+	struct task_struct *p;
+
+	thread = container_of(work, struct xnthread, inband_work);
+	p = thread->altsched.task;
+	wake_up_process(p);
+}
+
 int __xnthread_init(struct xnthread *thread,
 		    const struct xnthread_init_attr *attr,
 		    struct xnsched *sched,
@@ -187,6 +197,7 @@ int __xnthread_init(struct xnthread *thread,
 	thread->selector = NULL;
 	INIT_LIST_HEAD(&thread->glink);
 	INIT_LIST_HEAD(&thread->boosters);
+	init_irq_work(&thread->inband_work, inband_task_wakeup);
 	/* These will be filled by xnthread_start() */
 	thread->entry = NULL;
 	thread->cookie = NULL;
@@ -1998,22 +2009,6 @@ static void lostage_task_wakeup(struct ipipe_work_header *work)
 }
 #endif
 
-static void post_wakeup(struct task_struct *p)
-{
-#warning TODO
-/*	struct lostage_wakeup wakework = {
-		.work = {
-			.size = sizeof(wakework),
-			.handler = lostage_task_wakeup,
-		},
-		.task = p,
-	};
-
-	trace_cobalt_lostage_request("wakeup", wakework.task);
-
-	ipipe_post_work_root(&wakework, work);*/
-}
-
 void __xnthread_propagate_schedparam(struct xnthread *curr)
 {
 	int kpolicy = SCHED_FIFO, kprio = curr->bprio, ret;
@@ -2099,7 +2094,8 @@ void xnthread_relax(int notify, int reason)
 	 * xnthread_suspend() has an interrupts-on section built in.
 	 */
 	splmax();
-	post_wakeup(p);
+	/*please refer to evl_switch_inband */
+	irq_work_queue(&thread->inband_work);
 	/*
 	 * Grab the nklock to synchronize the Linux task state
 	 * manipulation with handle_sigwake_event. This lock will be
-- 
2.17.1


