From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 12/15] cobalt/thread: call dovetail_leave_oob to allow to be
 waked up
Date: Mon,  9 Nov 2020 02:50:24 -0500
Message-Id: <20201109075027.14760-12-hongzhan.chen@intel.com>
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

call dovetail_leave_oob to allow current to be waked up and
dovetail_leave_oob would clean TIF_MAYDAY

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/cobalt/thread.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 6ac949e99..5943d3b94 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2119,8 +2119,15 @@ void xnthread_relax(int notify, int reason)
 		suspension |= XNDBGSTOP;
 	}
 #endif
-#warning TODO
-	//set_current_state(p->state & ~TASK_NOWAKEUP);
+	/*
+	 * CAVEAT: dovetail_leave_oob() must run _before_ the in-band
+	 * kernel is allowed to take interrupts again, so that
+	 * try_to_wake_up() does not block the wake up request for the
+	 * switching thread as a result of testing
+	 * task_is_off_stage().
+	 */
+	dovetail_leave_oob();
+
 	xnthread_run_handler_stack(thread, relax_thread);
 	xnthread_suspend(thread, suspension, XN_INFINITE, XN_RELATIVE, NULL);
 	splnone();
@@ -2186,9 +2193,6 @@ void xnthread_relax(int notify, int reason)
 	 */
 	xnthread_clear_localinfo(thread, XNSYSRST);
 
-#warning TODO: nothing to do here?
-//	ipipe_clear_thread_flag(TIP_MAYDAY);
-
 	trace_cobalt_shadow_relaxed(thread);
 }
 EXPORT_SYMBOL_GPL(xnthread_relax);
-- 
2.17.1


