From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail v2 3/5] cobalt/select: drop dependency on APCs
Date: Sun, 17 Jan 2021 16:08:01 +0100
Message-Id: <20210117150803.477767-4-rpm@xenomai.org>
In-Reply-To: <20210117150803.477767-1-rpm@xenomai.org>
References: <20210117150803.477767-1-rpm@xenomai.org>
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

Directly use a virtual/synthetic IRQ for kicking the deletion
procedure for RTDM file descriptors, dropping the dependency on APCs.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/select.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/cobalt/select.c b/kernel/cobalt/select.c
index df3d960db..f45905112 100644
--- a/kernel/cobalt/select.c
+++ b/kernel/cobalt/select.c
@@ -23,7 +23,6 @@
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/synch.h>
 #include <cobalt/kernel/select.h>
-#include <cobalt/kernel/apc.h>
 
 /**
  * @ingroup cobalt_core
@@ -49,7 +48,7 @@
  */
 
 static LIST_HEAD(selector_list);
-static int deletion_apc;
+static int deletion_virq;
 
 /**
  * Initialize a @a struct @a xnselect structure.
@@ -399,12 +398,12 @@ void xnselector_destroy(struct xnselector *selector)
 
 	xnlock_get_irqsave(&nklock, s);
 	list_add_tail(&selector->destroy_link, &selector_list);
-	__xnapc_schedule(deletion_apc);
+	ipipe_post_irq_root(deletion_virq);
 	xnlock_put_irqrestore(&nklock, s);
 }
 EXPORT_SYMBOL_GPL(xnselector_destroy);
 
-static void xnselector_destroy_loop(void *cookie)
+static void xnselector_destroy_loop(unsigned int virq, void *arg)
 {
 	struct xnselect_binding *binding, *tmpb;
 	struct xnselector *selector, *tmps;
@@ -443,17 +442,21 @@ out:
 
 int xnselect_mount(void)
 {
-	deletion_apc = xnapc_alloc("selector_list_destroy",
-				   xnselector_destroy_loop, NULL);
-	if (deletion_apc < 0)
-		return deletion_apc;
-
+	deletion_virq = ipipe_alloc_virq();
+	if (deletion_virq == 0)
+		return -EBUSY;
+
+	ipipe_request_irq(ipipe_root_domain,
+			deletion_virq,
+			xnselector_destroy_loop,
+			NULL, NULL);
 	return 0;
 }
 
 int xnselect_umount(void)
 {
-	xnapc_free(deletion_apc);
+	ipipe_free_irq(ipipe_root_domain, deletion_virq);
+	ipipe_free_virq(deletion_virq);
 	return 0;
 }
 
-- 
2.26.2


