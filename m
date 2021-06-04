From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 12/12] drivers/udd: move inband work description off the stack
Date: Fri,  4 Jun 2021 12:05:22 +0200
Message-Id: <58ade07144c5ff97a1eece255d926058eaf376dd.1622801122.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1622801122.git.jan.kiszka@siemens.com>
References: <cover.1622801122.git.jan.kiszka@siemens.com>
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

Unlike the I-pipe, Dovetail does not copy the work descriptor but
merely hands over the request to the common irq_work() mechanism. We
must guarantee that such descriptor lives in a portion of memory which
won't go stale until the handler has run, which by design can only
happen once the calling out-of-band context unwinds.

Therefore, we have to allocate a request descriptor from the core heap
when issuing a request to enable/disable a particular IRQ channel from
the in-band stage.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/udd/udd.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/drivers/udd/udd.c b/kernel/drivers/udd/udd.c
index e1a2bc3b0..d263afc72 100644
--- a/kernel/drivers/udd/udd.c
+++ b/kernel/drivers/udd/udd.c
@@ -520,6 +520,7 @@ struct irqswitch_work {
 	rtdm_irq_t *irqh;
 	int enabled;
 	rtdm_event_t *done;
+	struct irqswitch_work *self; /* Revisit: I-pipe requirement */
 };
 
 static void lostage_irqswitch_line(struct pipeline_inband_work *inband_work)
@@ -538,24 +539,32 @@ static void lostage_irqswitch_line(struct pipeline_inband_work *inband_work)
 
 	if (rq->done)
 		rtdm_event_signal(rq->done);
+
+	xnfree(rq->self);
 }
 
 static void switch_irq_line(rtdm_irq_t *irqh, int enable, rtdm_event_t *done)
 {
-	struct irqswitch_work switchwork = {
-		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(switchwork,
-					lostage_irqswitch_line),
-		.irqh = irqh,
-		.enabled = enable,
-		.done = done,
-	};
+	struct irqswitch_work *rq;
+
+	rq = xnmalloc(sizeof(*rq));
+	if (WARN_ON(rq == NULL))
+		return;
+
+	rq->inband_work = (struct pipeline_inband_work)
+		PIPELINE_INBAND_WORK_INITIALIZER(*rq,
+					lostage_irqswitch_line);
+	rq->irqh = irqh;
+	rq->enabled = enable;
+	rq->done = done;
+	rq->self = rq;	/* Revisit: I-pipe requirement */
 
 	/*
 	 * Not pretty, but we may not traverse the kernel code for
 	 * enabling/disabling IRQ lines from primary mode. Defer this
 	 * to the root context.
 	 */
-	pipeline_post_inband_work(&switchwork);
+	pipeline_post_inband_work(rq);
 }
 
 /**
-- 
2.26.2


