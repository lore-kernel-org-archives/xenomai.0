Message-ID: <dfc28eb3-d9ff-79bc-6a14-89c21d26470f@siemens.com>
Date: Mon, 24 Jan 2022 18:16:40 +0100
MIME-Version: 1.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/thread: Keep IRQs off longer during in-band migration
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This restores the pattern used before 98288382bd46: We must prevent any
interruption between queuing the inband work and suspending the current
RT thread. Otherwise, we risk that the former is consumed prior to the
thread consumption if the thread should undergo temporary remote
suspension/resumption, allowing Linux to run first. This is also in line
with the EVL core.

Fixes: 98288382bd46 ("cobalt/thread: dovetail: keep hard irqs off on transition to in-band")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
  kernel/cobalt/thread.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 7adc7f7897..dfaef75640 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2074,6 +2074,7 @@ void xnthread_relax(int notify, int reason)
  	 * We disable interrupts during the migration sequence, but
  	 * xnthread_suspend() has an interrupts-on section built in.
  	 */
+	splmax();
  	trace_cobalt_lostage_request("wakeup", p);
  	pipeline_post_inband_work(&wakework);
  	/*
@@ -2081,7 +2082,6 @@ void xnthread_relax(int notify, int reason)
  	 * manipulation with handle_sigwake_event. This lock will be
  	 * dropped by xnthread_suspend().
  	 */
-	splmax();
  	xnlock_get(&nklock);
  	xnthread_run_handler_stack(thread, relax_thread);
  	suspension = pipeline_leave_oob_prepare();
-- 
2.31.1

