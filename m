From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] rtdm/nrtsig: Move inband work description off the stack
Message-ID: <6acafd3e-529a-ce84-3482-6dad79f5d65b@siemens.com>
Date: Fri, 11 Jun 2021 08:25:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Unlike the I-pipe, Dovetail does not copy the work descriptor but
merely hands over the request to the common irq_work() mechanism. We
must guarantee that such descriptor lives in a portion of memory which
won't go stale until the handler has run, which by design can only
happen once the calling out-of-band context unwinds.

Therefore, we have to move the non-rt signal descriptors off the
stack. When it comes to the basic non-RT signal, the rtdm_nrtsig_t
descriptor itself is a proper place to host the inband work descriptor
which carries out the work under the hood.

When a task work needs to be scheduled, we enqueue it into global,
lock-protected list, trigger a common lostage handler, and let that
transfer the item to schedule_work.

Based on original patch by Philippe Gerum, avoiding xnmalloc in RT code
paths.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/rtdm/driver.h |  9 +++-
 kernel/cobalt/rtdm/drvlib.c         | 74 ++++++++++++++++-------------
 2 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 0d3b5a5d0..1955254cc 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -33,6 +33,7 @@
 #include <linux/wait.h>
 #include <linux/notifier.h>
 #include <pipeline/lock.h>
+#include <pipeline/inband_work.h>
 #include <xenomai/version.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/sched.h>
@@ -896,6 +897,7 @@ typedef struct rtdm_nrtsig rtdm_nrtsig_t;
 typedef void (*rtdm_nrtsig_handler_t)(rtdm_nrtsig_t *nrt_sig, void *arg);
 
 struct rtdm_nrtsig {
+	struct pipeline_inband_work inband_work; /* Must be first */
 	rtdm_nrtsig_handler_t handler;
 	void *arg;
 };
@@ -904,9 +906,14 @@ void rtdm_schedule_nrt_work(struct work_struct *lostage_work);
 /** @} rtdm_nrtsignal */
 
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
+void __rtdm_nrtsig_execute(struct pipeline_inband_work *inband_work);
+
 static inline void rtdm_nrtsig_init(rtdm_nrtsig_t *nrt_sig,
-				rtdm_nrtsig_handler_t handler, void *arg)
+				    rtdm_nrtsig_handler_t handler, void *arg)
 {
+	nrt_sig->inband_work = (struct pipeline_inband_work)
+		PIPELINE_INBAND_WORK_INITIALIZER(*nrt_sig,
+						 __rtdm_nrtsig_execute);
 	nrt_sig->handler = handler;
 	nrt_sig->arg = arg;
 }
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index dc3acf2fd..239421284 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1568,20 +1568,14 @@ int rtdm_nrtsig_init(rtdm_nrtsig_t *nrt_sig, rtdm_nrtsig_handler_t handler,
 void rtdm_nrtsig_destroy(rtdm_nrtsig_t *nrt_sig);
 #endif /* DOXYGEN_CPP */
 
-struct nrtsig_work {
-	struct pipeline_inband_work inband_work; /* Must be first. */
-	struct rtdm_nrtsig *nrtsig;
-};
-
-static void nrtsig_execute(struct pipeline_inband_work *inband_work)
+void __rtdm_nrtsig_execute(struct pipeline_inband_work *inband_work)
 {
-	struct rtdm_nrtsig *nrtsig;
-	struct nrtsig_work *w;
+	struct rtdm_nrtsig *nrt_sig;
 
-	w = container_of(inband_work, typeof(*w), inband_work);
-	nrtsig = w->nrtsig;
-	nrtsig->handler(nrtsig, nrtsig->arg);
+	nrt_sig = container_of(inband_work, typeof(*nrt_sig), inband_work);
+	nrt_sig->handler(nrt_sig, nrt_sig->arg);
 }
+EXPORT_SYMBOL_GPL(__rtdm_nrtsig_execute);
 
 /**
  * Trigger non-real-time signal
@@ -1592,28 +1586,42 @@ static void nrtsig_execute(struct pipeline_inband_work *inband_work)
  */
 void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig)
 {
-	struct nrtsig_work nrtsig_work = {
-		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(nrtsig_work,
-					nrtsig_execute),
-		.nrtsig = nrt_sig,
-	};
-	pipeline_post_inband_work(&nrtsig_work);
+	pipeline_post_inband_work(nrt_sig);
 }
 EXPORT_SYMBOL_GPL(rtdm_nrtsig_pend);
 
-struct lostage_schedule_work {
-	struct pipeline_inband_work inband_work; /* Must be first. */
-	struct work_struct *lostage_work;
-};
+static LIST_HEAD(nrt_work_list);
+DEFINE_PRIVATE_XNLOCK(nrt_work_lock);
 
 static void lostage_schedule_work(struct pipeline_inband_work *inband_work)
 {
-	struct lostage_schedule_work *w;
+	struct work_struct *lostage_work;
+	spl_t s;
+
+	xnlock_get_irqsave(&nrt_work_lock, s);
+
+	while (!list_empty(&nrt_work_list)) {
+		lostage_work = list_first_entry(&nrt_work_list,
+						struct work_struct, entry);
+		list_del_init(&lostage_work->entry);
+
+		xnlock_put_irqrestore(&nrt_work_lock, s);
+
+		schedule_work(lostage_work);
+
+		xnlock_get_irqsave(&nrt_work_lock, s);
+	}
 
-	w = container_of(inband_work, typeof(*w), inband_work);
-	schedule_work(w->lostage_work);
+	xnlock_put_irqrestore(&nrt_work_lock, s);
 }
 
+static struct lostage_trigger_work {
+	struct pipeline_inband_work inband_work; /* Must be first. */
+} nrt_work =  {
+	.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(nrt_work,
+							lostage_schedule_work),
+};
+
 /**
  * Put a work task in Linux non real-time global workqueue from primary mode.
  *
@@ -1621,17 +1629,19 @@ static void lostage_schedule_work(struct pipeline_inband_work *inband_work)
  */
 void rtdm_schedule_nrt_work(struct work_struct *lostage_work)
 {
-	struct lostage_schedule_work sched_work = {
-		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(sched_work,
-					lostage_schedule_work),
-		.lostage_work = lostage_work,
-	};
+	spl_t s;
 
-	if (is_secondary_domain())
+	if (is_secondary_domain()) {
 		schedule_work(lostage_work);
-	else
-		pipeline_post_inband_work(&sched_work);
+		return;
+	}
+
+	xnlock_get_irqsave(&nrt_work_lock, s);
+
+	list_add_tail(&lostage_work->entry, &nrt_work_list);
+	pipeline_post_inband_work(&nrt_work);
 
+	xnlock_put_irqrestore(&nrt_work_lock, s);
 }
 EXPORT_SYMBOL_GPL(rtdm_schedule_nrt_work);
 
-- 
2.26.2

