From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/4] cobalt/registry: pipeline: convert to abstract synthetic
 IRQ API
Date: Sun, 17 Jan 2021 16:25:02 +0100
Message-Id: <20210117152503.478765-3-rpm@xenomai.org>
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
 kernel/cobalt/registry.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
index 7f7cb9eea..816102f7a 100644
--- a/kernel/cobalt/registry.c
+++ b/kernel/cobalt/registry.c
@@ -22,6 +22,7 @@
 #include <cobalt/kernel/registry.h>
 #include <cobalt/kernel/thread.h>
 #include <cobalt/kernel/assert.h>
+#include <pipeline/sirq.h>
 
 /**
  * @ingroup cobalt_core
@@ -61,7 +62,7 @@ static struct xnsynch register_synch;
 
 static void proc_callback(struct work_struct *work);
 
-static void registry_proc_schedule(unsigned int virq, void *arg);
+static irqreturn_t registry_proc_schedule(int virq, void *dev_id);
 
 static LIST_HEAD(proc_object_list);	/* Objects waiting for /proc handling. */
 
@@ -123,17 +124,12 @@ int xnregistry_init(void)
 		return ret;
 	}
 
-	proc_virq = ipipe_alloc_virq();
-	if (proc_virq == 0) {
+	proc_virq = pipeline_create_inband_sirq(registry_proc_schedule);
+	if (proc_virq < 0) {
 		xnvfile_destroy_regular(&usage_vfile);
 		xnvfile_destroy_dir(&registry_vfroot);
-		return -EBUSY;
+		return proc_virq;
 	}
-
-	ipipe_request_irq(ipipe_root_domain,
-			  proc_virq,
-			  registry_proc_schedule,
-			  NULL, NULL);
 #endif /* CONFIG_XENO_OPT_VFILE */
 
 	next_object_stamp = 0;
@@ -155,8 +151,7 @@ int xnregistry_init(void)
 #ifdef CONFIG_XENO_OPT_VFILE
 		xnvfile_destroy_regular(&usage_vfile);
 		xnvfile_destroy_dir(&registry_vfroot);
-		ipipe_free_irq(ipipe_root_domain, proc_virq);
-		ipipe_free_virq(proc_virq);
+		pipeline_delete_inband_sirq(proc_virq);
 #endif /* CONFIG_XENO_OPT_VFILE */
 		return -ENOMEM;
 	}
@@ -202,8 +197,7 @@ void xnregistry_cleanup(void)
 	xnsynch_destroy(&register_synch);
 
 #ifdef CONFIG_XENO_OPT_VFILE
-	ipipe_free_irq(ipipe_root_domain, proc_virq);
-	ipipe_free_virq(proc_virq);
+	pipeline_delete_inband_sirq(proc_virq);
 	flush_scheduled_work();
 	xnvfile_destroy_regular(&usage_vfile);
 	xnvfile_destroy_dir(&registry_vfroot);
@@ -332,13 +326,15 @@ static void proc_callback(struct work_struct *work)
 	up(&export_mutex);
 }
 
-static void registry_proc_schedule(unsigned int virq, void *arg)
+static irqreturn_t registry_proc_schedule(int virq, void *dev_id)
 {
 	/*
 	 * schedule_work() will check for us if the work has already
 	 * been scheduled, so just be lazy and submit blindly.
 	 */
 	schedule_work(&registry_proc_work);
+
+	return IRQ_HANDLED;
 }
 
 static int registry_export_vfsnap(struct xnobject *object,
@@ -473,7 +469,7 @@ static inline void registry_export_pnode(struct xnobject *object,
 	object->pnode = pnode;
 	list_del(&object->link);
 	list_add_tail(&object->link, &proc_object_list);
-	ipipe_post_irq_root(proc_virq);
+	pipeline_post_sirq(proc_virq);
 }
 
 static inline void registry_unexport_pnode(struct xnobject *object)
@@ -489,7 +485,7 @@ static inline void registry_unexport_pnode(struct xnobject *object)
 			object->pnode->ops->touch(object);
 		list_del(&object->link);
 		list_add_tail(&object->link, &proc_object_list);
-		ipipe_post_irq_root(proc_virq);
+		pipeline_post_sirq(proc_virq);
 	} else {
 		/*
 		 * Unexporting before the lower stage has had a chance
-- 
2.26.2


