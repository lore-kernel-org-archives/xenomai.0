From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 5/8] cobalt/registry: fix export/unexport race on object
 deletion
Date: Fri, 31 Jan 2020 16:27:10 +0100
Message-Id: <20200131152713.1811748-6-rpm@xenomai.org>
In-Reply-To: <20200131152713.1811748-1-rpm@xenomai.org>
References: <20200131152713.1811748-1-rpm@xenomai.org>
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

Running xnregistry_enter() then xnregistry_remove() in quick
succession for the same object might cause the latter to NULLify the
objaddr field while proc_callback() is busy calling the vfile export
handler for the object, which is going to use that same value,
certainly leading to a crash.

This bug is due to the asynchronous nature of the vfile
export/unexport process which is deferred to a regular workqueue on
the root stage when kicked from the head stage.

Fix this by adding a third logic state describing an aborted vfile
export procedure, due to handling an object removal request while the
workqueue is concurrently running for the same object. In addition,
since an exported object might be stale before it is considered for
export, do not anticipate on the next object to process in
proc_callback() as list_for_each_entry_safe() would do, but always
pick the list head under lock.

At this chance, clarify the naming of the magic vfile values
enumerating those states (i.e. XNOBJECT_EXPORT_xxx).

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/registry.h |  5 ++--
 kernel/cobalt/registry.c         | 40 ++++++++++++++++++++------------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/cobalt/kernel/registry.h b/include/cobalt/kernel/registry.h
index 25c8f48d3..624db5a78 100644
--- a/include/cobalt/kernel/registry.h
+++ b/include/cobalt/kernel/registry.h
@@ -55,8 +55,9 @@ void xnregistry_cleanup(void);
 
 #ifdef CONFIG_XENO_OPT_VFILE
 
-#define XNOBJECT_PNODE_RESERVED1 ((struct xnvfile *)1)
-#define XNOBJECT_PNODE_RESERVED2 ((struct xnvfile *)2)
+#define XNOBJECT_EXPORT_SCHEDULED  ((struct xnvfile *)1L)
+#define XNOBJECT_EXPORT_INPROGRESS ((struct xnvfile *)2L)
+#define XNOBJECT_EXPORT_ABORTED    ((struct xnvfile *)3L)
 
 struct xnptree {
 	const char *dirname;
diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
index dde359ea4..9dfd66b06 100644
--- a/kernel/cobalt/registry.c
+++ b/kernel/cobalt/registry.c
@@ -227,8 +227,8 @@ static DEFINE_SEMAPHORE(export_mutex);
 static void proc_callback(struct work_struct *work)
 {
 	struct xnvfile_directory *rdir, *dir;
-	struct xnobject *object, *tmp;
 	const char *rname, *type;
+	struct xnobject *object;
 	struct xnpnode *pnode;
 	int ret;
 	spl_t s;
@@ -237,21 +237,19 @@ static void proc_callback(struct work_struct *work)
 
 	xnlock_get_irqsave(&nklock, s);
 
-	if (list_empty(&proc_object_list))
-		goto out;
-
-	list_for_each_entry_safe(object, tmp, &proc_object_list, link) {
-		list_del(&object->link);
+	while (!list_empty(&proc_object_list)) {
+		object = list_get_entry(&proc_object_list,
+					struct xnobject, link);
 		pnode = object->pnode;
 		type = pnode->dirname;
 		dir = &pnode->vdir;
 		rdir = &pnode->root->vdir;
 		rname = pnode->root->dirname;
 
-		if (object->vfilp != XNOBJECT_PNODE_RESERVED1)
+		if (object->vfilp != XNOBJECT_EXPORT_SCHEDULED)
 			goto unexport;
 
-		object->vfilp = XNOBJECT_PNODE_RESERVED2;
+		object->vfilp = XNOBJECT_EXPORT_INPROGRESS;
 		list_add_tail(&object->link, &busy_object_list);
 
 		xnlock_put_irqrestore(&nklock, s);
@@ -298,6 +296,9 @@ static void proc_callback(struct work_struct *work)
 		object->vfilp = NULL;
 		object->pnode = NULL;
 
+		if (object->vfilp == XNOBJECT_EXPORT_ABORTED)
+			object->objaddr = NULL;
+
 		if (object->objaddr)
 			list_add_tail(&object->link, &busy_object_list);
 		else {
@@ -321,7 +322,7 @@ static void proc_callback(struct work_struct *work)
 
 		xnlock_get_irqsave(&nklock, s);
 	}
-out:
+
 	xnlock_put_irqrestore(&nklock, s);
 
 	up(&export_mutex);
@@ -464,7 +465,7 @@ EXPORT_SYMBOL_GPL(xnregistry_vlink_ops);
 static inline void registry_export_pnode(struct xnobject *object,
 					 struct xnpnode *pnode)
 {
-	object->vfilp = XNOBJECT_PNODE_RESERVED1;
+	object->vfilp = XNOBJECT_EXPORT_SCHEDULED;
 	object->pnode = pnode;
 	list_del(&object->link);
 	list_add_tail(&object->link, &proc_object_list);
@@ -473,7 +474,7 @@ static inline void registry_export_pnode(struct xnobject *object,
 
 static inline void registry_unexport_pnode(struct xnobject *object)
 {
-	if (object->vfilp != XNOBJECT_PNODE_RESERVED1) {
+	if (object->vfilp != XNOBJECT_EXPORT_SCHEDULED) {
 		/*
 		 * We might have preempted a v-file read op, so bump
 		 * the object's revtag to make sure the data
@@ -818,6 +819,7 @@ EXPORT_SYMBOL_GPL(xnregistry_bind);
 int xnregistry_remove(xnhandle_t handle)
 {
 	struct xnobject *object;
+	void *objaddr;
 	int ret = 0;
 	spl_t s;
 
@@ -829,6 +831,7 @@ int xnregistry_remove(xnhandle_t handle)
 		goto unlock_and_exit;
 	}
 
+	objaddr = object->objaddr;
 	object->objaddr = NULL;
 	object->cstamp = 0;
 
@@ -837,6 +840,11 @@ int xnregistry_remove(xnhandle_t handle)
 
 #ifdef CONFIG_XENO_OPT_VFILE
 		if (object->pnode) {
+			if (object->vfilp == XNOBJECT_EXPORT_INPROGRESS) {
+				object->vfilp = XNOBJECT_EXPORT_ABORTED;
+				object->objaddr = objaddr;
+			}
+
 			registry_unexport_pnode(object);
 			/*
 			 * Leave the update of the object queues to
@@ -850,8 +858,10 @@ int xnregistry_remove(xnhandle_t handle)
 		list_del(&object->link);
 	}
 
-	list_add_tail(&object->link, &free_object_list);
-	nr_active_objects--;
+	if (!IS_ENABLED(CONFIG_XENO_OPT_VFILE) || !object->objaddr) {
+		list_add_tail(&object->link, &free_object_list);
+		nr_active_objects--;
+	}
 
 unlock_and_exit:
 
@@ -882,7 +892,7 @@ int xnregistry_unlink(const char *key)
 		ret = -ESRCH;
 		goto unlock_and_exit;
 	}
-		
+
 	ret = registry_hash_remove(object);
 	if (ret < 0)
 		goto unlock_and_exit;
@@ -900,7 +910,7 @@ int xnregistry_unlink(const char *key)
 #endif /* CONFIG_XENO_OPT_VFILE */
 
 	list_del(&object->link);
-		
+
 	object->key = NULL;
 
 unlock_and_exit:
-- 
2.24.1


