From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 05/17] cobalt/thread: Make sure relax inband work is on a
 stack outliving the wakeup
Date: Fri, 11 Jun 2021 20:05:31 +0200
Message-Id: <6cacd089663d187d6f0ab1203b8def11148fa89b.1623434743.git.jan.kiszka@siemens.com>
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
wakeup takes. Therefore, fold post_wakeup into the only caller so that
the stack frame of xnthread_relax is guaranteed to be used which
fulfills this requirement.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/thread.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 27f51bd58..bc2eebc92 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1993,19 +1993,6 @@ static void lostage_task_wakeup(struct pipeline_inband_work *inband_work)
 	wake_up_process(p);
 }
 
-static void post_wakeup(struct task_struct *p)
-{
-	struct lostage_wakeup wakework = {
-		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(wakework,
-					lostage_task_wakeup),
-		.task = p,
-	};
-
-	trace_cobalt_lostage_request("wakeup", wakework.task);
-
-	pipeline_post_inband_work(&wakework);
-}
-
 void __xnthread_propagate_schedparam(struct xnthread *curr)
 {
 	int kpolicy = SCHED_FIFO, kprio = curr->bprio, ret;
@@ -2065,9 +2052,14 @@ void __xnthread_propagate_schedparam(struct xnthread *curr)
  */
 void xnthread_relax(int notify, int reason)
 {
+	struct task_struct *p = current;
+	struct lostage_wakeup wakework = {
+		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(wakework,
+					lostage_task_wakeup),
+		.task = p,
+	};
 	struct xnthread *thread = xnthread_current();
 	int cpu __maybe_unused, suspension;
-	struct task_struct *p = current;
 	kernel_siginfo_t si;
 
 	primary_mode_only();
@@ -2090,7 +2082,8 @@ void xnthread_relax(int notify, int reason)
 	 * xnthread_suspend() has an interrupts-on section built in.
 	 */
 	splmax();
-	post_wakeup(p);
+	trace_cobalt_lostage_request("wakeup", p);
+	pipeline_post_inband_work(&wakework);
 	/*
 	 * Grab the nklock to synchronize the Linux task state
 	 * manipulation with handle_sigwake_event. This lock will be
-- 
2.26.2


