From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Fri, 20 Oct 2006 22:21:49 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_d/SOFpFOGmxnRxg"
Message-Id: <200610202221.49664.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Suggestions for the vxWorks skins
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_d/SOFpFOGmxnRxg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

As I am trying to debug startup failures of a thirs party C++-library, I 
stumbled about the fact that the /proc/xenomai/registry/ only listed 
semaphores and not tasks.

My co-workers would appreciate to have some equivalents to vxWorks "i" 
or "semShow" routines, as they come often very handy to debug problems, I was 
thinking about how to improve the situation.

One approach could be:
a) Instead of calling semShow for each semaphore 
do "cat /proc/xenomai/registry/semaphores/*". The information therein is 
already useful. The attached patch only modifies the output to include the 
name of the semaphore. In the future it would be nice to show also the owner 
of a mutex. 

b) The "i" procedure of vxworks could be replaced 
by "cat /proc/xenomai/registry/tasks/*". 

With the attached patch I just show the name of the task. 

If nobody opposes I would like to extend the interface to provide at least the 
same information as under vxWorks (entrypoint, priority, status, program 
counter, errno, delay).

Would it be difficult/desirable to include the amount of free stack space?
Would it be difficult/desirable to include the name of the vxworks semaphores 
a vx task is holding? Together with point a) one could easyly detect lock 
ups.

Best regards

-- 
Niklaus Giger

--Boundary-00=_d/SOFpFOGmxnRxg
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="vx.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vx.diff"

Index: ksrc/skins/vxworks/semLib.c
===================================================================
--- ksrc/skins/vxworks/semLib.c	(Revision 1738)
+++ ksrc/skins/vxworks/semLib.c	(Arbeitskopie)
@@ -49,7 +49,7 @@
 
 	xnlock_get_irqsave(&nklock, s);
 
-	p += sprintf(p, "type=%s:value=%u\n", sem->vtbl->type, sem->count);
+	p += sprintf(p, "%s:type=%s:value=%u\n", sem->name, sem->vtbl->type, sem->count);
 
 	if (xnsynch_nsleepers(&sem->synchbase) == 0) {
 		xnpholder_t *holder;
Index: ksrc/skins/vxworks/taskLib.c
===================================================================
--- ksrc/skins/vxworks/taskLib.c	(Revision 1738)
+++ ksrc/skins/vxworks/taskLib.c	(Arbeitskopie)
@@ -30,6 +30,56 @@
 static void wind_task_delete_hook(xnthread_t *xnthread);
 static void wind_task_trampoline(void *cookie);
 
+#ifdef CONFIG_XENO_EXPORT_REGISTRY
+
+static int task_read_proc(char *page,
+			 char **start,
+			 off_t off, int count, int *eof, void *data)
+{
+	wind_task_t *task = (wind_task_t *)data;
+	char *p = page;
+	int len;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);  /* TODO is this necessary ?? */
+
+	p += sprintf(p, "%s:\n", task->name);
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	len = (p - page) - off;
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+
+extern xnptree_t __vxworks_ptree;
+
+static xnpnode_t task_pnode = {
+
+	.dir = NULL,
+	.type = "tasks",
+	.entries = 0,
+	.read_proc = &task_read_proc,
+	.write_proc = NULL,
+	.root = &__vxworks_ptree,
+};
+
+#elif defined(CONFIG_XENO_OPT_REGISTRY)
+
+static xnpnode_t task_pnode = {
+
+	.type = "tasks"
+};
+
+#endif /* CONFIG_XENO_EXPORT_REGISTRY */
+
 void wind_task_init(void)
 {
 	initq(&wind_tasks_q);
@@ -152,7 +202,7 @@
 
 #ifdef CONFIG_XENO_OPT_REGISTRY
 	if (xnregistry_enter(pTcb->name,
-			     pTcb, &xnthread_handle(&pTcb->threadbase), NULL)) {
+			     pTcb, &xnthread_handle(&pTcb->threadbase), &task_pnode)) {
 		wind_errnoset(S_objLib_OBJ_ID_ERROR);
 		taskDeleteForce((TASK_ID) pTcb);
 		return ERROR;

--Boundary-00=_d/SOFpFOGmxnRxg--

