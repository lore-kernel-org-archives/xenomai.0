From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH v2] [wip/dovetail] cobalt/select: replace APC with irq_work
Date: Tue, 29 Sep 2020 23:00:43 -0400
Message-Id: <20200930030043.5882-1-hongzhan.chen@intel.com>
In-Reply-To: <146482da-10d2-f2cf-f87b-9e1dfa780e11@siemens.com>
References: <146482da-10d2-f2cf-f87b-9e1dfa780e11@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

schedule irq_work to execute xnselector_destroy_loop instead of
calling __xnapc_schedule, which is to replace APC

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/kernel/cobalt/select.c b/kernel/cobalt/select.c
index c3a3d34b7..3cde6e163 100644
--- a/kernel/cobalt/select.c
+++ b/kernel/cobalt/select.c
@@ -23,7 +23,12 @@
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/synch.h>
 #include <cobalt/kernel/select.h>
-#include <cobalt/kernel/apc.h>
+#include <linux/irq_work.h>
+
+
+static void cobalt_select_execute(struct irq_work *work);
+
+static DEFINE_IRQ_WORK(xnselect_irq_work, cobalt_select_execute);
 
 /**
  * @ingroup cobalt_core
@@ -49,7 +54,6 @@
  */
 
 static LIST_HEAD(selector_list);
-static int deletion_apc;
 
 /**
  * Initialize a @a struct @a xnselect structure.
@@ -399,9 +403,9 @@ void xnselector_destroy(struct xnselector *selector)
 
 	xnlock_get_irqsave(&nklock, s);
 	list_add_tail(&selector->destroy_link, &selector_list);
-#warning TODO: irq_work
-	//__xnapc_schedule(deletion_apc);
 	xnlock_put_irqrestore(&nklock, s);
+
+	irq_work_queue(&xnselect_irq_work);
 }
 EXPORT_SYMBOL_GPL(xnselector_destroy);
 
@@ -442,20 +446,19 @@ out:
 	xnlock_put_irqrestore(&nklock, s);
 }
 
-int xnselect_mount(void)
+static void cobalt_select_execute(struct irq_work *work)
 {
-#warning TODO: use irq_work
-	/*deletion_apc = xnapc_alloc("selector_list_destroy",
-				   xnselector_destroy_loop, NULL);
-	if (deletion_apc < 0)
-		return deletion_apc;*/
+	xnselector_destroy_loop(NULL);
+}
+
 
+int xnselect_mount(void)
+{
 	return 0;
 }
 
 int xnselect_umount(void)
 {
-	//xnapc_free(deletion_apc);
 	return 0;
 }
 
-- 
2.17.1


