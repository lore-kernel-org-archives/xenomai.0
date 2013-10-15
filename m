Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <56a6d056c14acd5ef663.1381827037@devws164.be.alcatel-lucent.com>
In-Reply-To: <patchbomb.1381827036@devws164.be.alcatel-lucent.com>
References: <patchbomb.1381827036@devws164.be.alcatel-lucent.com>
Date: Tue, 15 Oct 2013 10:50:37 +0200
From: Kim De Mey <kim.demey@gmail.com>
Subject: [Xenomai] [PATCH 1 of 3] Initial implementation registry pSOS task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Initial implementation of the registry functionality
for pSOS tasks.

Signed-off-by: Kim De Mey <kim.demey@gmail.com>

---

diff --git a/include/psos/psos.h b/include/psos/psos.h
--- a/include/psos/psos.h
+++ b/include/psos/psos.h
@@ -367,6 +367,8 @@ u_long tm_wkwhen(u_long date,
 
 int psos_task_normalize_priority(unsigned long psos_prio);
 
+int psos_task_denormalize_priority(unsigned long core_prio);
+
 extern unsigned int psos_long_names;
 
 #ifdef __cplusplus
diff --git a/lib/psos/task.c b/lib/psos/task.c
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -24,6 +24,7 @@
 #include <unistd.h>
 #include <pthread.h>
 #include <sched.h>
+#include <fcntl.h>
 #include "copperplate/init.h"
 #include "copperplate/heapobj.h"
 #include "copperplate/threadobj.h"
@@ -167,8 +168,99 @@ static void task_finalizer(struct thread
 	/* We have to hold a lock on a syncobj to destroy it. */
 	syncobj_lock(&task->sobj, &syns);
 	syncobj_destroy(&task->sobj, &syns);
+
+	registry_destroy_file(&task->fsobj);
 }
 
+#ifdef CONFIG_XENO_REGISTRY
+
+static inline char *task_decode_status(struct psos_task *task, char *buf)
+{
+	int status;
+
+	*buf = '\0';
+	if (threadobj_get_lockdepth(&task->thobj) > 0)
+		strcat(buf, "+sched_lock");
+	status = threadobj_get_status(&task->thobj);
+	if (status & __THREAD_S_RR)
+		strcat(buf, "+sched_rr");
+	if (status & __THREAD_S_SUSPENDED)
+		strcat(buf, "+suspended");
+	if (status & (__THREAD_S_WAIT|__THREAD_S_TIMEDWAIT))
+		strcat(buf, "+pending");
+	else if (status & __THREAD_S_DELAYED)
+		strcat(buf, "+delayed");
+	else
+		strcat(buf, "+ready");
+
+	return buf + 1;
+}
+
+static ssize_t task_registry_read(struct fsobj *fsobj,
+				 char *buf, size_t size, off_t offset)
+{
+	struct psos_task *task;
+	char sbuf[64];
+	size_t len;
+	int i;
+	struct psos_tm *tm, *tmp;
+	
+	task = container_of(fsobj, struct psos_task, fsobj);
+	len =  sprintf(buf,       "%-11s= %11s\n", "name", task->name);
+	len += sprintf(buf + len, "%-11s= %11d\n", "errno", 
+						threadobj_get_errno(&task->thobj));
+	len += sprintf(buf + len, "%-11s= %11s\n", "status", 
+						task_decode_status(task, sbuf));
+	len += sprintf(buf + len, "%-11s= %11d\n", "priority", 
+						psos_task_get_priority(task));
+	len += sprintf(buf + len, "%-11s= %11d\n", "lock_depth", 
+						threadobj_get_lockdepth(&task->thobj));
+	len += sprintf(buf + len, "%-11s= %11d\n", "mode", task->mode);
+	len += sprintf(buf + len, "%-11s= %#011lx\n", "task_id", 
+						mainheap_ref(task, u_long));
+	len += sprintf(buf + len, "%-11s= %11d\n", "process_id", 
+						threadobj_get_pid(&task->thobj));
+	len += sprintf(buf + len, "%-11s= %11lu\n", "events", task->events);	
+	
+	len += sprintf(buf + len, "\n%-11s= \n", "notepad");	
+	len += sprintf(buf + len, "%-11s %-11s\n", "register", "value");
+	for (i=0;i<PSOSTASK_NR_REGS;i++) {
+		len += sprintf(buf + len, "%-11i %-11lu\n", i, task->notepad[i]);
+	}
+
+	len += sprintf(buf + len, "\n%-11s= \n", "timer_list");	
+	if (!pvlist_empty(&task->timer_list)) {
+		len += sprintf(buf + len, "%-11s %-11s %-11s %-11s %-11s %-11s %-11s\n", 
+				"tmid", "tid", "tm_events",
+				"interval_s","interval_ns", "value_s", "value_ns");	
+		pvlist_for_each_entry_safe(tm, tmp, &task->timer_list, link) {
+			len += sprintf(buf + len, 
+				"%-11lu %#011lx %-11lu %-11ld %-11ld %-11ld %-11ld\n",
+				mainheap_ref(tm, u_long), tm->tid, tm->events,
+				(long) tm->tmobj.itspec.it_interval.tv_sec, 
+				tm->tmobj.itspec.it_interval.tv_nsec,
+				(long) tm->tmobj.itspec.it_value.tv_sec, 
+				tm->tmobj.itspec.it_value.tv_nsec);	
+		}
+	}
+
+	if(len < offset)
+		return (ssize_t)0;
+	else
+		return (ssize_t)len;
+}
+
+static struct registry_operations registry_ops = {
+	.read	= task_registry_read
+};
+
+#else
+
+static struct registry_operations registry_ops;
+
+#endif /* CONFIG_XENO_REGISTRY */
+
+
 static void *task_trampoline(void *arg)
 {
 	struct psos_task *task = arg;
@@ -182,6 +274,12 @@ static void *task_trampoline(void *arg)
 
 	CANCEL_DEFER(svc);
 
+	ret = __bt(registry_add_file(&task->fsobj, O_RDONLY,
+				     "/psos/tasks/%s", task->name));
+	if (ret)
+		warning("failed to export task %s to registry",
+			task->name);
+
 	threadobj_wait_start();
 
 	threadobj_lock(&task->thobj);
@@ -234,6 +332,13 @@ int psos_task_normalize_priority(unsigne
 	return psos_prio;
 }
 
+__attribute__ ((weak))
+int psos_task_denormalize_priority(unsigned long core_prio)
+{
+	/* Map a SCHED_RT priority level to a pSOS one. */
+	return core_prio;
+}
+
 static int check_task_priority(u_long psos_prio, int *core_prio)
 {
 	if (psos_prio < 1 || psos_prio > 255) /* In theory. */
@@ -244,6 +349,13 @@ static int check_task_priority(u_long ps
 	return SUCCESS;
 }
 
+int psos_task_get_priority(struct psos_task *task)
+{
+	/* Can't fail if we hold the task lock as we should. */
+	int prio = threadobj_get_priority(&task->thobj);
+	return psos_task_denormalize_priority(prio);
+}
+
 u_long t_create(const char *name, u_long prio,
 		u_long sstack, u_long ustack, u_long flags, u_long *tid_r)
 {
@@ -309,6 +421,8 @@ u_long t_create(const char *name, u_long
 	idata.priority = cprio;
 	threadobj_init(&task->thobj, &idata);
 
+	registry_init_file(&task->fsobj, &registry_ops);
+
 	cta.prio = cprio;
 	cta.start = task_trampoline;
 	cta.arg = task;
@@ -317,6 +431,7 @@ u_long t_create(const char *name, u_long
 
 	ret = __bt(copperplate_create_thread(&cta, &task->thobj.tid));
 	if (ret) {
+		registry_destroy_file(&task->fsobj);
 		cluster_delobj(&psos_task_table, &task->cobj);
 		threadobj_destroy(&task->thobj);
 		ret = ERR_NOTCB;
diff --git a/lib/psos/task.h b/lib/psos/task.h
--- a/lib/psos/task.h
+++ b/lib/psos/task.h
@@ -23,6 +23,7 @@
 #include <copperplate/threadobj.h>
 #include <copperplate/syncobj.h>
 #include <copperplate/cluster.h>
+#include <copperplate/registry.h>
 
 struct psos_task_args {
 	void (*entry)(u_long a0, u_long a1, u_long a2, u_long a3);
@@ -46,10 +47,13 @@ struct psos_task {
 	struct psos_task_args args;
 
 	struct threadobj thobj;
+	struct fsobj fsobj;
 	struct syncobj sobj;	/* For events. */
 	struct clusterobj cobj;
 };
 
+int psos_task_get_priority(struct psos_task *task);
+
 #define task_magic	0x8181fafa
 
 static inline struct psos_task *psos_task_current(void)

