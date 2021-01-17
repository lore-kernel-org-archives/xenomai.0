From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/4] cobalt/rtdm: pipeline: convert to abstract root work API
Date: Sun, 17 Jan 2021 16:11:33 +0100
Message-Id: <20210117151133.478069-4-rpm@xenomai.org>
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
 kernel/cobalt/rtdm/drvlib.c | 32 +++++++++++++++-----------------
 kernel/cobalt/rtdm/fd.c     | 13 ++++++-------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 40d2e401b..dc3acf2fd 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -31,6 +31,7 @@
 #include <linux/anon_inodes.h>
 #include <rtdm/driver.h>
 #include <rtdm/compat.h>
+#include <pipeline/inband_work.h>
 #include "internal.h"
 #include <trace/events/cobalt-rtdm.h>
 
@@ -1568,16 +1569,16 @@ void rtdm_nrtsig_destroy(rtdm_nrtsig_t *nrt_sig);
 #endif /* DOXYGEN_CPP */
 
 struct nrtsig_work {
-	struct ipipe_work_header work;
+	struct pipeline_inband_work inband_work; /* Must be first. */
 	struct rtdm_nrtsig *nrtsig;
 };
 
-static void nrtsig_execute(struct ipipe_work_header *work)
+static void nrtsig_execute(struct pipeline_inband_work *inband_work)
 {
 	struct rtdm_nrtsig *nrtsig;
 	struct nrtsig_work *w;
 
-	w = container_of(work, typeof(*w), work);
+	w = container_of(inband_work, typeof(*w), inband_work);
 	nrtsig = w->nrtsig;
 	nrtsig->handler(nrtsig, nrtsig->arg);
 }
@@ -1592,26 +1593,24 @@ static void nrtsig_execute(struct ipipe_work_header *work)
 void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig)
 {
 	struct nrtsig_work nrtsig_work = {
-		.work = {
-			.size = sizeof(nrtsig_work),
-			.handler = nrtsig_execute,
-		},
+		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(nrtsig_work,
+					nrtsig_execute),
 		.nrtsig = nrt_sig,
 	};
-	ipipe_post_work_root(&nrtsig_work, work);
+	pipeline_post_inband_work(&nrtsig_work);
 }
 EXPORT_SYMBOL_GPL(rtdm_nrtsig_pend);
 
 struct lostage_schedule_work {
-	struct ipipe_work_header work;
+	struct pipeline_inband_work inband_work; /* Must be first. */
 	struct work_struct *lostage_work;
 };
 
-static void lostage_schedule_work(struct ipipe_work_header *work)
+static void lostage_schedule_work(struct pipeline_inband_work *inband_work)
 {
 	struct lostage_schedule_work *w;
 
-	w = container_of(work, typeof(*w), work);
+	w = container_of(inband_work, typeof(*w), inband_work);
 	schedule_work(w->lostage_work);
 }
 
@@ -1622,18 +1621,17 @@ static void lostage_schedule_work(struct ipipe_work_header *work)
  */
 void rtdm_schedule_nrt_work(struct work_struct *lostage_work)
 {
-	struct lostage_schedule_work ipipe_work = {
-		.work = {
-			.size = sizeof(ipipe_work),
-			.handler = lostage_schedule_work,
-		},
+	struct lostage_schedule_work sched_work = {
+		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(sched_work,
+					lostage_schedule_work),
 		.lostage_work = lostage_work,
 	};
 
 	if (is_secondary_domain())
 		schedule_work(lostage_work);
 	else
-		ipipe_post_work_root(&ipipe_work, work);
+		pipeline_post_inband_work(&sched_work);
+
 }
 EXPORT_SYMBOL_GPL(rtdm_schedule_nrt_work);
 
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index afb9ca5c5..7956a8800 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -28,6 +28,7 @@
 #include <cobalt/kernel/registry.h>
 #include <cobalt/kernel/lock.h>
 #include <cobalt/kernel/ppd.h>
+#include <pipeline/inband_work.h>
 #include <trace/events/cobalt-rtdm.h>
 #include <rtdm/fd.h>
 #include "internal.h"
@@ -257,7 +258,7 @@ out:
 EXPORT_SYMBOL_GPL(rtdm_fd_get);
 
 struct lostage_trigger_close {
-	struct ipipe_work_header work; /* Must be first */
+	struct pipeline_inband_work inband_work; /* Must be first. */
 };
 
 static int fd_cleanup_thread(void *data)
@@ -287,7 +288,7 @@ static int fd_cleanup_thread(void *data)
 	return 0;
 }
 
-static void lostage_trigger_close(struct ipipe_work_header *work)
+static void lostage_trigger_close(struct pipeline_inband_work *inband_work)
 {
 	up(&rtdm_fd_cleanup_sem);
 }
@@ -310,17 +311,15 @@ static void __put_fd(struct rtdm_fd *fd, spl_t s)
 		fd->ops->close(fd);
 	else {
 		struct lostage_trigger_close closework = {
-			.work = {
-				.size = sizeof(closework),
-				.handler = lostage_trigger_close,
-			},
+			.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(closework,
+					lostage_trigger_close),
 		};
 
 		xnlock_get_irqsave(&fdtree_lock, s);
 		list_add_tail(&fd->cleanup, &rtdm_fd_cleanup_queue);
 		xnlock_put_irqrestore(&fdtree_lock, s);
 
-		ipipe_post_work_root(&closework, work);
+		pipeline_post_inband_work(&closework);
 	}
 }
 
-- 
2.26.2


