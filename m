From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/4] drivers/udd: pipeline: convert to abstract root work API
Date: Sun, 17 Jan 2021 16:11:31 +0100
Message-Id: <20210117151133.478069-2-rpm@xenomai.org>
In-Reply-To: <20210117151133.478069-1-rpm@xenomai.org>
References: <20210117151133.478069-1-rpm@xenomai.org>
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

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/udd/udd.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/drivers/udd/udd.c b/kernel/drivers/udd/udd.c
index e32d40f66..e1a2bc3b0 100644
--- a/kernel/drivers/udd/udd.c
+++ b/kernel/drivers/udd/udd.c
@@ -24,6 +24,7 @@
 #include <rtdm/cobalt.h>
 #include <rtdm/driver.h>
 #include <rtdm/udd.h>
+#include <pipeline/inband_work.h>
 
 struct udd_context {
 	u32 event_count;
@@ -515,13 +516,13 @@ void udd_notify_event(struct udd_device *udd)
 EXPORT_SYMBOL_GPL(udd_notify_event);
 
 struct irqswitch_work {
-	struct ipipe_work_header work; /* Must be first. */
+	struct pipeline_inband_work inband_work;
 	rtdm_irq_t *irqh;
 	int enabled;
 	rtdm_event_t *done;
 };
 
-static void lostage_irqswitch_line(struct ipipe_work_header *work)
+static void lostage_irqswitch_line(struct pipeline_inband_work *inband_work)
 {
 	struct irqswitch_work *rq;
 
@@ -529,7 +530,7 @@ static void lostage_irqswitch_line(struct ipipe_work_header *work)
 	 * This runs from secondary mode, we may flip the IRQ state
 	 * now.
 	 */
-	rq = container_of(work, struct irqswitch_work, work);
+	rq = container_of(inband_work, struct irqswitch_work, inband_work);
 	if (rq->enabled)
 		rtdm_irq_enable(rq->irqh);
 	else
@@ -542,10 +543,8 @@ static void lostage_irqswitch_line(struct ipipe_work_header *work)
 static void switch_irq_line(rtdm_irq_t *irqh, int enable, rtdm_event_t *done)
 {
 	struct irqswitch_work switchwork = {
-		.work = {
-			.size = sizeof(switchwork),
-			.handler = lostage_irqswitch_line,
-		},
+		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(switchwork,
+					lostage_irqswitch_line),
 		.irqh = irqh,
 		.enabled = enable,
 		.done = done,
@@ -553,11 +552,10 @@ static void switch_irq_line(rtdm_irq_t *irqh, int enable, rtdm_event_t *done)
 
 	/*
 	 * Not pretty, but we may not traverse the kernel code for
-	 * enabling/disabling IRQ lines from primary mode. So we have
-	 * to send a deferrable root request (i.e. low-level APC) to
-	 * be callable from real-time context.
+	 * enabling/disabling IRQ lines from primary mode. Defer this
+	 * to the root context.
 	 */
-	ipipe_post_work_root(&switchwork, work);
+	pipeline_post_inband_work(&switchwork);
 }
 
 /**
-- 
2.26.2


