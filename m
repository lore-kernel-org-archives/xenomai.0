From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 03/17] cobalt/thread: Privatize xnthread_map to map_kthread
Date: Fri, 11 Jun 2021 20:05:29 +0200
Message-Id: <2d91aa1b719e834b33630693b96489e2dc4fe6e4.1623434743.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623434743.git.jan.kiszka@siemens.com>
References: <cover.1623434743.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

No user outside of the core, no need to export it. Move the code around
so that we can easily use it without forward declarations.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/thread.h |   3 -
 kernel/cobalt/thread.c         | 239 ++++++++++++++-------------------
 2 files changed, 98 insertions(+), 144 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index 2d6ce9053..b79cb8429 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -514,9 +514,6 @@ void xnthread_signal(struct xnthread *thread, int sig, int arg);
 
 void xnthread_pin_initial(struct xnthread *thread);
 
-int xnthread_map(struct xnthread *thread,
-		 struct completion *done);
-
 void xnthread_call_mayday(struct xnthread *thread, int reason);
 
 static inline void xnthread_get_resource(struct xnthread *curr)
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 1f8e1119a..db68833c6 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -84,6 +84,103 @@ static inline void enlist_new_thread(struct xnthread *thread)
 	xnvfile_touch_tag(&nkthreadlist_tag);
 }
 
+struct parent_wakeup_request {
+	struct pipeline_inband_work inband_work; /* Must be first. */
+	struct completion *done;
+};
+
+static void do_parent_wakeup(struct pipeline_inband_work *inband_work)
+{
+	struct parent_wakeup_request *rq;
+
+	rq = container_of(inband_work, struct parent_wakeup_request, inband_work);
+	complete(rq->done);
+}
+
+static inline void wakeup_parent(struct completion *done)
+{
+	struct parent_wakeup_request wakework = {
+		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(wakework,
+					do_parent_wakeup),
+		.done = done,
+	};
+
+	trace_cobalt_lostage_request("wakeup", current);
+
+	pipeline_post_inband_work(&wakework);
+}
+
+static inline void init_kthread_info(struct xnthread *thread)
+{
+	struct cobalt_threadinfo *p;
+
+	p = pipeline_current();
+	p->thread = thread;
+	p->process = NULL;
+}
+
+static int map_kthread(struct xnthread *thread, struct completion *done)
+{
+	int ret;
+	spl_t s;
+
+	if (xnthread_test_state(thread, XNUSER))
+		return -EINVAL;
+
+	if (xnthread_current() || xnthread_test_state(thread, XNMAPPED))
+		return -EBUSY;
+
+	thread->u_window = NULL;
+	xnthread_pin_initial(thread);
+
+	pipeline_init_shadow_tcb(thread);
+	xnthread_suspend(thread, XNRELAX, XN_INFINITE, XN_RELATIVE, NULL);
+	init_kthread_info(thread);
+	xnthread_set_state(thread, XNMAPPED);
+	xndebug_shadow_init(thread);
+	xnthread_run_handler(thread, map_thread);
+	pipeline_enable_kevents();
+
+	/*
+	 * CAUTION: Soon after xnthread_init() has returned,
+	 * xnthread_start() is commonly invoked from the root domain,
+	 * therefore the call site may expect the started kernel
+	 * shadow to preempt immediately. As a result of such
+	 * assumption, start attributes (struct xnthread_start_attr)
+	 * are often laid on the caller's stack.
+	 *
+	 * For this reason, we raise the completion signal to wake up
+	 * the xnthread_init() caller only once the emerging thread is
+	 * hardened, and __never__ before that point. Since we run
+	 * over the Xenomai domain upon return from xnthread_harden(),
+	 * we schedule a virtual interrupt handler in the root domain
+	 * to signal the completion object.
+	 */
+	xnthread_resume(thread, XNDORMANT);
+	ret = xnthread_harden();
+	wakeup_parent(done);
+
+	xnlock_get_irqsave(&nklock, s);
+
+	enlist_new_thread(thread);
+	/*
+	 * Make sure xnthread_start() did not slip in from another CPU
+	 * while we were back from wakeup_parent().
+	 */
+	if (thread->entry == NULL)
+		xnthread_suspend(thread, XNDORMANT,
+				 XN_INFINITE, XN_RELATIVE, NULL);
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	xnthread_test_cancel();
+
+	xntrace_pid(xnthread_host_pid(thread),
+		    xnthread_current_priority(thread));
+
+	return ret;
+}
+
 struct kthread_arg {
 	struct xnthread *thread;
 	struct completion *done;
@@ -113,7 +210,7 @@ static int kthread_trampoline(void *arg)
 	param.sched_priority = prio;
 	sched_setscheduler(current, policy, &param);
 
-	ret = xnthread_map(thread, ka->done);
+	ret = map_kthread(thread, ka->done);
 	if (ret) {
 		printk(XENO_WARNING "failed to create kernel shadow %s\n",
 		       thread->name);
@@ -2374,146 +2471,6 @@ void xnthread_pin_initial(struct xnthread *thread)
 	xnlock_put_irqrestore(&nklock, s);
 }
 
-struct parent_wakeup_request {
-	struct pipeline_inband_work inband_work; /* Must be first. */
-	struct completion *done;
-};
-
-static void do_parent_wakeup(struct pipeline_inband_work *inband_work)
-{
-	struct parent_wakeup_request *rq;
-
-	rq = container_of(inband_work, struct parent_wakeup_request, inband_work);
-	complete(rq->done);
-}
-
-static inline void wakeup_parent(struct completion *done)
-{
-	struct parent_wakeup_request wakework = {
-		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(wakework,
-					do_parent_wakeup),
-		.done = done,
-	};
-
-	trace_cobalt_lostage_request("wakeup", current);
-
-	pipeline_post_inband_work(&wakework);
-}
-
-static inline void init_kthread_info(struct xnthread *thread)
-{
-	struct cobalt_threadinfo *p;
-
-	p = pipeline_current();
-	p->thread = thread;
-	p->process = NULL;
-}
-
-/**
- * @fn int xnthread_map(struct xnthread *thread, struct completion *done)
- * @internal
- * @brief Create a shadow thread context over a kernel task.
- *
- * This call maps a Cobalt core thread to the "current" Linux task
- * running in kernel space.  The priority and scheduling class of the
- * underlying Linux task are not affected; it is assumed that the
- * caller did set them appropriately before issuing the shadow mapping
- * request.
- *
- * This call immediately moves the calling kernel thread to the
- * Xenomai domain.
- *
- * @param thread The descriptor address of the new shadow thread to be
- * mapped to "current". This descriptor must have been previously
- * initialized by a call to xnthread_init().
- *
- * @param done A completion object to be signaled when @a thread is
- * fully mapped over the current Linux context, waiting for
- * xnthread_start().
- *
- * @return 0 is returned on success. Otherwise:
- *
- * - -ERESTARTSYS is returned if the current Linux task has received a
- * signal, thus preventing the final migration to the Xenomai domain
- * (i.e. in order to process the signal in the Linux domain). This
- * error should not be considered as fatal.
- *
- * - -EPERM is returned if the shadow thread has been killed before
- * the current task had a chance to return to the caller. In such a
- * case, the real-time mapping operation has failed globally, and no
- * Xenomai resource remains attached to it.
- *
- * - -EINVAL is returned if the thread control block bears the XNUSER
- * bit.
- *
- * - -EBUSY is returned if either the current Linux task or the
- * associated shadow thread is already involved in a shadow mapping.
- *
- * @coretags{secondary-only, might-switch}
- */
-int xnthread_map(struct xnthread *thread, struct completion *done)
-{
-	int ret;
-	spl_t s;
-
-	if (xnthread_test_state(thread, XNUSER))
-		return -EINVAL;
-
-	if (xnthread_current() || xnthread_test_state(thread, XNMAPPED))
-		return -EBUSY;
-
-	thread->u_window = NULL;
-	xnthread_pin_initial(thread);
-
-	pipeline_init_shadow_tcb(thread);
-	xnthread_suspend(thread, XNRELAX, XN_INFINITE, XN_RELATIVE, NULL);
-	init_kthread_info(thread);
-	xnthread_set_state(thread, XNMAPPED);
-	xndebug_shadow_init(thread);
-	xnthread_run_handler(thread, map_thread);
-	pipeline_enable_kevents();
-
-	/*
-	 * CAUTION: Soon after xnthread_init() has returned,
-	 * xnthread_start() is commonly invoked from the root domain,
-	 * therefore the call site may expect the started kernel
-	 * shadow to preempt immediately. As a result of such
-	 * assumption, start attributes (struct xnthread_start_attr)
-	 * are often laid on the caller's stack.
-	 *
-	 * For this reason, we raise the completion signal to wake up
-	 * the xnthread_init() caller only once the emerging thread is
-	 * hardened, and __never__ before that point. Since we run
-	 * over the Xenomai domain upon return from xnthread_harden(),
-	 * we schedule a virtual interrupt handler in the root domain
-	 * to signal the completion object.
-	 */
-	xnthread_resume(thread, XNDORMANT);
-	ret = xnthread_harden();
-	wakeup_parent(done);
-
-	xnlock_get_irqsave(&nklock, s);
-
-	enlist_new_thread(thread);
-	/*
-	 * Make sure xnthread_start() did not slip in from another CPU
-	 * while we were back from wakeup_parent().
-	 */
-	if (thread->entry == NULL)
-		xnthread_suspend(thread, XNDORMANT,
-				 XN_INFINITE, XN_RELATIVE, NULL);
-
-	xnlock_put_irqrestore(&nklock, s);
-
-	xnthread_test_cancel();
-
-	xntrace_pid(xnthread_host_pid(thread),
-		    xnthread_current_priority(thread));
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(xnthread_map);
-
 /* nklock locked, irqs off */
 void xnthread_call_mayday(struct xnthread *thread, int reason)
 {
-- 
2.26.2


