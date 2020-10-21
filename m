From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH] cobalt/intr: post proxy tick irq instead of host tick irq
Date: Tue, 20 Oct 2020 22:18:05 -0400
Message-Id: <20201021021805.10010-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

make use of dovetail proxy tick infastructure in place of host
tick

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/kernel/cobalt/intr.c b/kernel/cobalt/intr.c
index 8ffe7f2b6..67c0915ff 100644
--- a/kernel/cobalt/intr.c
+++ b/kernel/cobalt/intr.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 /*#include <linux/ipipe.h>
 #include <linux/ipipe_tickdev.h>*/
+#include <linux/clockchips.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/intr.h>
 #include <cobalt/kernel/stat.h>
@@ -190,6 +191,8 @@ void xnintr_host_tick(struct xnsched *sched) /* Interrupts off. */
 #ifdef XNARCH_HOST_TICK_IRQ
 	//ipipe_post_irq_root(XNARCH_HOST_TICK_IRQ);
 #warning TODO
+	/* use proxy tick to replace host tick */
+	tick_notify_proxy();
 #endif
 }
 
@@ -207,6 +210,7 @@ void xnintr_core_clock_handler(void)
 #ifdef XNARCH_HOST_TICK_IRQ
 		//ipipe_post_irq_root(XNARCH_HOST_TICK_IRQ);
 #warning TODO
+		tick_notify_proxy();
 #endif
 		return;
 	}
@@ -245,7 +249,7 @@ void xnintr_core_clock_handler(void)
 #warning TODO
 #if 0
 struct irqdisable_work {
-	struct ipipe_work_header work; /* Must be first. */
+struct ipipe_work_header work; /* Must be first. */
 	int irq;
 };
 
-- 
2.17.1


