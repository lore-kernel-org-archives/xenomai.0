From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/4] cobalt/select: pipeline: convert to abstract synthetic
 IRQ API
Date: Sun, 17 Jan 2021 16:25:03 +0100
Message-Id: <20210117152503.478765-4-rpm@xenomai.org>
In-Reply-To: <20210117152503.478765-1-rpm@xenomai.org>
References: <20210117152503.478765-1-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/select.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/cobalt/select.c b/kernel/cobalt/select.c
index f45905112..bd790affe 100644
--- a/kernel/cobalt/select.c
+++ b/kernel/cobalt/select.c
@@ -23,6 +23,7 @@
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/synch.h>
 #include <cobalt/kernel/select.h>
+#include <pipeline/sirq.h>
 
 /**
  * @ingroup cobalt_core
@@ -398,12 +399,12 @@ void xnselector_destroy(struct xnselector *selector)
 
 	xnlock_get_irqsave(&nklock, s);
 	list_add_tail(&selector->destroy_link, &selector_list);
-	ipipe_post_irq_root(deletion_virq);
+	pipeline_post_sirq(deletion_virq);
 	xnlock_put_irqrestore(&nklock, s);
 }
 EXPORT_SYMBOL_GPL(xnselector_destroy);
 
-static void xnselector_destroy_loop(unsigned int virq, void *arg)
+static irqreturn_t xnselector_destroy_loop(int virq, void *dev_id)
 {
 	struct xnselect_binding *binding, *tmpb;
 	struct xnselector *selector, *tmps;
@@ -438,25 +439,22 @@ static void xnselector_destroy_loop(unsigned int virq, void *arg)
 	}
 out:
 	xnlock_put_irqrestore(&nklock, s);
+
+	return IRQ_HANDLED;
 }
 
 int xnselect_mount(void)
 {
-	deletion_virq = ipipe_alloc_virq();
-	if (deletion_virq == 0)
-		return -EBUSY;
-
-	ipipe_request_irq(ipipe_root_domain,
-			deletion_virq,
-			xnselector_destroy_loop,
-			NULL, NULL);
+	deletion_virq = pipeline_create_inband_sirq(xnselector_destroy_loop);
+	if (deletion_virq < 0)
+		return deletion_virq;
+
 	return 0;
 }
 
 int xnselect_umount(void)
 {
-	ipipe_free_irq(ipipe_root_domain, deletion_virq);
-	ipipe_free_virq(deletion_virq);
+	pipeline_delete_inband_sirq(deletion_virq);
 	return 0;
 }
 
-- 
2.26.2


