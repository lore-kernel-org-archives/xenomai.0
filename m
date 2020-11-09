From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 10/15] cobalt/thread: add new member done and irq_work to do
 wakeup parent
Date: Mon,  9 Nov 2020 02:50:22 -0500
Message-Id: <20201109075027.14760-10-hongzhan.chen@intel.com>
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

add new member done and irq_work in struct xnthread and make use
of them to do wakeup and wait

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 include/cobalt/kernel/thread.h |  8 ++++--
 kernel/cobalt/thread.c         | 52 ++++++++++++++--------------------
 2 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index 2ab5ac28e..88fd6e3c7 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -33,6 +33,7 @@
 #include <cobalt/uapi/signal.h>
 #include <asm/xenomai/machine.h>
 #include <asm/xenomai/thread.h>
+#include <linux/irq_work.h>
 
 /**
  * @addtogroup cobalt_core_thread
@@ -200,6 +201,10 @@ struct xnthread {
 #endif
 
 	struct dovetail_altsched_context altsched;
+
+	struct completion *done;
+
+	struct irq_work irq_work;
 };
 
 static inline int xnthread_get_state(const struct xnthread *thread)
@@ -502,8 +507,7 @@ void xnthread_signal(struct xnthread *thread,
 
 void xnthread_pin_initial(struct xnthread *thread);
 
-int xnthread_map(struct xnthread *thread,
-		 struct completion *done);
+int xnthread_map(struct xnthread *thread);
 
 void xnthread_call_mayday(struct xnthread *thread, int reason);
 
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index fc29cc521..944840d4d 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -81,15 +81,9 @@ static inline void enlist_new_thread(struct xnthread *thread)
 	xnvfile_touch_tag(&nkthreadlist_tag);
 }
 
-struct kthread_arg {
-	struct xnthread *thread;
-	struct completion *done;
-};
-
 static int kthread_trampoline(void *arg)
 {
-	struct kthread_arg *ka = arg;
-	struct xnthread *thread = ka->thread;
+	struct xnthread *thread = arg;
 	struct sched_param param;
 	int ret, policy, prio;
 
@@ -110,7 +104,7 @@ static int kthread_trampoline(void *arg)
 	param.sched_priority = prio;
 	sched_setscheduler(current, policy, &param);
 
-	ret = xnthread_map(thread, ka->done);
+	ret = xnthread_map(thread);
 	if (ret) {
 		printk(XENO_WARNING "failed to create kernel shadow %s\n",
 		       thread->name);
@@ -129,17 +123,16 @@ static int kthread_trampoline(void *arg)
 static inline int spawn_kthread(struct xnthread *thread)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
-	struct kthread_arg ka = {
-		.thread = thread,
-		.done = &done
-	};
 	struct task_struct *p;
 
-	p = kthread_run(kthread_trampoline, &ka, "%s", thread->name);
+	thread->done = &done;
+
+	p = kthread_run(kthread_trampoline, thread, "%s", thread->name);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
-	wait_for_completion(&done);
+	wait_for_completion(thread->done);
+	thread->done = NULL;
 
 	return 0;
 }
@@ -2471,20 +2464,21 @@ static void do_parent_wakeup(struct ipipe_work_header *work)
 }
 #endif
 
-static inline void wakeup_parent(struct completion *done)
+static void wakeup_kthread_parent(struct irq_work *irq_work)
 {
-#warning TODO
-/*	struct parent_wakeup_request wakework = {
-		.work = {
-			.size = sizeof(wakework),
-			.handler = do_parent_wakeup,
-		},
-		.done = done,
-	};*/
+	struct xnthread *kthread;
+
+	kthread = container_of(irq_work, struct xnthread, irq_work);
+	complete(kthread->done);
+}
+
+static inline void wakeup_parent(struct xnthread *thread)
+{
+	init_irq_work(&thread->irq_work, wakeup_kthread_parent);
 
 	trace_cobalt_lostage_request("wakeup", current);
 
-	//ipipe_post_work_root(&wakework, work);
+	irq_work_queue(&thread->irq_work);
 }
 
 static inline void init_kthread_info(struct xnthread *thread)
@@ -2497,7 +2491,7 @@ static inline void init_kthread_info(struct xnthread *thread)
 }
 
 /**
- * @fn int xnthread_map(struct xnthread *thread, struct completion *done)
+ * @fn int xnthread_map(struct xnthread *thread)
  * @internal
  * @brief Create a shadow thread context over a kernel task.
  *
@@ -2514,10 +2508,6 @@ static inline void init_kthread_info(struct xnthread *thread)
  * mapped to "current". This descriptor must have been previously
  * initialized by a call to xnthread_init().
  *
- * @param done A completion object to be signaled when @a thread is
- * fully mapped over the current Linux context, waiting for
- * xnthread_start().
- *
  * @return 0 is returned on success. Otherwise:
  *
  * - -ERESTARTSYS is returned if the current Linux task has received a
@@ -2538,7 +2528,7 @@ static inline void init_kthread_info(struct xnthread *thread)
  *
  * @coretags{secondary-only, might-switch}
  */
-int xnthread_map(struct xnthread *thread, struct completion *done)
+int xnthread_map(struct xnthread *thread)
 {
 //	struct task_struct *p = current;
 	int ret;
@@ -2579,7 +2569,7 @@ int xnthread_map(struct xnthread *thread, struct completion *done)
 	 */
 	xnthread_resume(thread, XNDORMANT);
 	ret = xnthread_harden();
-	wakeup_parent(done);
+	wakeup_parent(thread);
 
 	xnlock_get_irqsave(&nklock, s);
 
-- 
2.17.1


