From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH v2] cobalt/select: replace APC with irq_work
Date: Tue, 22 Sep 2020 00:17:46 -0400
Message-Id: <20200922041746.10691-1-hongzhan.chen@intel.com>
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

---
this patch is for wip/dovetail branch.

diff --git a/kernel/cobalt/select.c b/kernel/cobalt/select.c
index c3a3d34b7..a78d3220e 100644
--- a/kernel/cobalt/select.c
+++ b/kernel/cobalt/select.c
@@ -23,7 +23,38 @@
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/synch.h>
 #include <cobalt/kernel/select.h>
-#include <cobalt/kernel/apc.h>
+#include <linux/irq_work.h>
+
+static bool cobalt_select_isinit;
+
+typedef void (*cobalt_select_destroy_t)(void *cookie);
+
+struct cobalt_select_work {
+	cobalt_select_destroy_t handler;
+	void *arg;
+	struct irq_work irq_work;
+};
+
+typedef struct cobalt_select_work cobalt_select_work_t;
+
+static cobalt_select_work_t xndeletion_work;
+
+static void cobalt_select_execute(struct irq_work *work)
+{
+	cobalt_select_work_t *xnselect =
+		container_of(work, cobalt_select_work_t, irq_work);
+	xnselect->handler(xnselect->arg);
+}
+
+int cobalt_select_init(cobalt_select_work_t *xnselect,
+		cobalt_select_destroy_t handler, void *arg)
+{
+	xnselect->handler = handler;
+	xnselect->arg = arg;
+	init_irq_work(&xnselect->irq_work, cobalt_select_execute);
+	return 0;
+}
+
 
 /**
  * @ingroup cobalt_core
@@ -49,7 +80,6 @@
  */
 
 static LIST_HEAD(selector_list);
-static int deletion_apc;
 
 /**
  * Initialize a @a struct @a xnselect structure.
@@ -399,8 +429,8 @@ void xnselector_destroy(struct xnselector *selector)
 
 	xnlock_get_irqsave(&nklock, s);
 	list_add_tail(&selector->destroy_link, &selector_list);
-#warning TODO: irq_work
-	//__xnapc_schedule(deletion_apc);
+	if (cobalt_select_isinit == true)
+		irq_work_queue(&xndeletion_work.irq_work);
 	xnlock_put_irqrestore(&nklock, s);
 }
 EXPORT_SYMBOL_GPL(xnselector_destroy);
@@ -444,18 +474,20 @@ out:
 
 int xnselect_mount(void)
 {
-#warning TODO: use irq_work
-	/*deletion_apc = xnapc_alloc("selector_list_destroy",
-				   xnselector_destroy_loop, NULL);
-	if (deletion_apc < 0)
-		return deletion_apc;*/
+	int ret;
 
-	return 0;
+	cobalt_select_isinit = false;
+
+	ret = cobalt_select_init(&xndeletion_work, xnselector_destroy_loop, NULL);
+	if (!ret)
+		cobalt_select_isinit = true;
+	return ret;
 }
 
 int xnselect_umount(void)
 {
-	//xnapc_free(deletion_apc);
+	cobalt_select_isinit = false;
+
 	return 0;
 }
 
-- 
2.17.1


