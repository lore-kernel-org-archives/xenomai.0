From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH v2 2/3] cobalt/process: exit_thread handlers should reschedule
 as needed
Date: Wed, 27 Nov 2019 21:08:09 +0100
Message-Id: <20191127200810.19869-2-rpm@xenomai.org>
In-Reply-To: <20191127200810.19869-1-rpm@xenomai.org>
References: <20191127200810.19869-1-rpm@xenomai.org>
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

An exit_handler wants to be called from the root domain, with
preemption enabled and hard irqs on in order to keep all options open,
such as using regular sleeping locks.

If such a handler updates the Cobalt scheduler state, it has to
trigger the rescheduling procedure (xnsched_run()) internally as well,
grouping the changes and the rescheduling call into the same
interrupt-free section, in order to guard against CPU migration.

Relying on the core to kick such procedure in order to commit pending
changes later on is unreliable.
---
 kernel/cobalt/posix/process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 90949e519..8351d28fb 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -1144,10 +1144,11 @@ static void __handle_taskexit_event(struct task_struct *p)
 	if (xnthread_test_state(thread, XNSSTEP))
 		cobalt_unregister_debugged_thread(thread);
 
+	xnsched_run();
+
 	xnlock_put_irqrestore(&nklock, s);
 
 	xnthread_run_handler_stack(thread, exit_thread);
-	xnsched_run();
 
 	if (xnthread_test_state(thread, XNUSER)) {
 		cobalt_umm_free(&cobalt_kernel_ppd.umm, thread->u_window);
-- 
2.21.0


