From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 06/15] cobalt/intr: post proxy tick irq instead of host tick
 irq
Date: Mon,  9 Nov 2020 02:50:18 -0500
Message-Id: <20201109075027.14760-6-hongzhan.chen@intel.com>
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

make use of dovetail proxy tick infastructure in place of host
tick

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/cobalt/intr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/intr.c b/kernel/cobalt/intr.c
index 8ffe7f2b6..36eb6c93c 100644
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
@@ -188,8 +189,8 @@ void xnintr_host_tick(struct xnsched *sched) /* Interrupts off. */
 {
 	sched->lflags &= ~XNHTICK;
 #ifdef XNARCH_HOST_TICK_IRQ
-	//ipipe_post_irq_root(XNARCH_HOST_TICK_IRQ);
-#warning TODO
+	/* use proxy tick to replace host tick */
+	tick_notify_proxy();
 #endif
 }
 
@@ -205,8 +206,7 @@ void xnintr_core_clock_handler(void)
 
 	if (!xnsched_supported_cpu(cpu)) {
 #ifdef XNARCH_HOST_TICK_IRQ
-		//ipipe_post_irq_root(XNARCH_HOST_TICK_IRQ);
-#warning TODO
+		tick_notify_proxy();
 #endif
 		return;
 	}
-- 
2.17.1


