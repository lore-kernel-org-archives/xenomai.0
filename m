From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 04/17] cobalt/thread: Pull kthread inband work onto creator
 stack
Date: Fri, 11 Jun 2021 20:05:30 +0200
Message-Id: <795887cdccef4dab6c7cbecb9081b5b471f2e29a.1623434743.git.jan.kiszka@siemens.com>
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

As dovetail does not copy the work passed to pipeline_post_inband_work,
we must ensure that the one used in xnthread_relax lives as long as the
wakeup takes. Therefore, embed the pipeline_inband_work struct needed
for signaling the kthread creator into kthread_arg struct. This lives on
the creator stack, as long as it takes to signal completion to it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/thread.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index db68833c6..27f51bd58 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -84,30 +84,18 @@ static inline void enlist_new_thread(struct xnthread *thread)
 	xnvfile_touch_tag(&nkthreadlist_tag);
 }
 
-struct parent_wakeup_request {
+struct kthread_arg {
 	struct pipeline_inband_work inband_work; /* Must be first. */
+	struct xnthread *thread;
 	struct completion *done;
 };
 
 static void do_parent_wakeup(struct pipeline_inband_work *inband_work)
 {
-	struct parent_wakeup_request *rq;
+	struct kthread_arg *ka;
 
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
+	ka = container_of(inband_work, struct kthread_arg, inband_work);
+	complete(ka->done);
 }
 
 static inline void init_kthread_info(struct xnthread *thread)
@@ -119,7 +107,7 @@ static inline void init_kthread_info(struct xnthread *thread)
 	p->process = NULL;
 }
 
-static int map_kthread(struct xnthread *thread, struct completion *done)
+static int map_kthread(struct xnthread *thread, struct kthread_arg *ka)
 {
 	int ret;
 	spl_t s;
@@ -158,7 +146,12 @@ static int map_kthread(struct xnthread *thread, struct completion *done)
 	 */
 	xnthread_resume(thread, XNDORMANT);
 	ret = xnthread_harden();
-	wakeup_parent(done);
+
+	trace_cobalt_lostage_request("wakeup", current);
+
+	ka->inband_work = (struct pipeline_inband_work)
+		PIPELINE_INBAND_WORK_INITIALIZER(*ka, do_parent_wakeup);
+	pipeline_post_inband_work(ka);
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -181,11 +174,6 @@ static int map_kthread(struct xnthread *thread, struct completion *done)
 	return ret;
 }
 
-struct kthread_arg {
-	struct xnthread *thread;
-	struct completion *done;
-};
-
 static int kthread_trampoline(void *arg)
 {
 	struct kthread_arg *ka = arg;
@@ -210,7 +198,7 @@ static int kthread_trampoline(void *arg)
 	param.sched_priority = prio;
 	sched_setscheduler(current, policy, &param);
 
-	ret = map_kthread(thread, ka->done);
+	ret = map_kthread(thread, ka);
 	if (ret) {
 		printk(XENO_WARNING "failed to create kernel shadow %s\n",
 		       thread->name);
-- 
2.26.2


