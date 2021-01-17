From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail v2 2/5] cobalt/registry: drop dependency on APCs
Date: Sun, 17 Jan 2021 16:08:00 +0100
Message-Id: <20210117150803.477767-3-rpm@xenomai.org>
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

Directly use a virtual/synthetic IRQ for waking up the export/unexport
procedure, dropping the dependency on APCs.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/registry.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
index dc1edd01a..7f7cb9eea 100644
--- a/kernel/cobalt/registry.c
+++ b/kernel/cobalt/registry.c
@@ -21,7 +21,6 @@
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/registry.h>
 #include <cobalt/kernel/thread.h>
-#include <cobalt/kernel/apc.h>
 #include <cobalt/kernel/assert.h>
 
 /**
@@ -62,13 +61,13 @@ static struct xnsynch register_synch;
 
 static void proc_callback(struct work_struct *work);
 
-static void registry_proc_schedule(void *cookie);
+static void registry_proc_schedule(unsigned int virq, void *arg);
 
 static LIST_HEAD(proc_object_list);	/* Objects waiting for /proc handling. */
 
 static DECLARE_WORK(registry_proc_work, proc_callback);
 
-static int proc_apc;
+static int proc_virq;
 
 static struct xnvfile_directory registry_vfroot;
 
@@ -124,14 +123,17 @@ int xnregistry_init(void)
 		return ret;
 	}
 
-	proc_apc =
-	    xnapc_alloc("registry_export", &registry_proc_schedule, NULL);
-
-	if (proc_apc < 0) {
+	proc_virq = ipipe_alloc_virq();
+	if (proc_virq == 0) {
 		xnvfile_destroy_regular(&usage_vfile);
 		xnvfile_destroy_dir(&registry_vfroot);
-		return proc_apc;
+		return -EBUSY;
 	}
+
+	ipipe_request_irq(ipipe_root_domain,
+			  proc_virq,
+			  registry_proc_schedule,
+			  NULL, NULL);
 #endif /* CONFIG_XENO_OPT_VFILE */
 
 	next_object_stamp = 0;
@@ -153,7 +155,8 @@ int xnregistry_init(void)
 #ifdef CONFIG_XENO_OPT_VFILE
 		xnvfile_destroy_regular(&usage_vfile);
 		xnvfile_destroy_dir(&registry_vfroot);
-		xnapc_free(proc_apc);
+		ipipe_free_irq(ipipe_root_domain, proc_virq);
+		ipipe_free_virq(proc_virq);
 #endif /* CONFIG_XENO_OPT_VFILE */
 		return -ENOMEM;
 	}
@@ -199,7 +202,8 @@ void xnregistry_cleanup(void)
 	xnsynch_destroy(&register_synch);
 
 #ifdef CONFIG_XENO_OPT_VFILE
-	xnapc_free(proc_apc);
+	ipipe_free_irq(ipipe_root_domain, proc_virq);
+	ipipe_free_virq(proc_virq);
 	flush_scheduled_work();
 	xnvfile_destroy_regular(&usage_vfile);
 	xnvfile_destroy_dir(&registry_vfroot);
@@ -328,7 +332,7 @@ static void proc_callback(struct work_struct *work)
 	up(&export_mutex);
 }
 
-static void registry_proc_schedule(void *cookie)
+static void registry_proc_schedule(unsigned int virq, void *arg)
 {
 	/*
 	 * schedule_work() will check for us if the work has already
@@ -469,7 +473,7 @@ static inline void registry_export_pnode(struct xnobject *object,
 	object->pnode = pnode;
 	list_del(&object->link);
 	list_add_tail(&object->link, &proc_object_list);
-	__xnapc_schedule(proc_apc);
+	ipipe_post_irq_root(proc_virq);
 }
 
 static inline void registry_unexport_pnode(struct xnobject *object)
@@ -485,7 +489,7 @@ static inline void registry_unexport_pnode(struct xnobject *object)
 			object->pnode->ops->touch(object);
 		list_del(&object->link);
 		list_add_tail(&object->link, &proc_object_list);
-		__xnapc_schedule(proc_apc);
+		ipipe_post_irq_root(proc_virq);
 	} else {
 		/*
 		 * Unexporting before the lower stage has had a chance
-- 
2.26.2


