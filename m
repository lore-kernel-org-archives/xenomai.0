Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <9bd00c3871dd96b26eaf.1385053376@devws164.be.alcatel-lucent.com>
Date: Thu, 21 Nov 2013 18:02:56 +0100
From: Kim De Mey <kim.demey@gmail.com>
Subject: [Xenomai] [PATCH] Xenomai-forge: pSOS add priority denormalize
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Add the psos_task_denormalize_priority() and psos_task_get_priority()
functions. Use psos_task_get_priority() to fill oldprio_r in t_setpri().

Signed-off-by: Kim De Mey <kim.demey@gmail.com>

---

It is necessary to denormalize the oldprio_r in t_setpri(). Else this
oldprio_r value can not be used if the user application overrides the
normalize function.

diff --git a/include/psos/psos.h b/include/psos/psos.h
--- a/include/psos/psos.h
+++ b/include/psos/psos.h
@@ -366,6 +366,7 @@ u_long tm_wkwhen(u_long date,
 		 u_long ticks);
 
 int psos_task_normalize_priority(unsigned long psos_prio);
+int psos_task_denormalize_priority(unsigned long core_prio);
 
 extern unsigned int psos_long_names;
 
diff --git a/lib/psos/task.c b/lib/psos/task.c
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -236,6 +236,21 @@ int psos_task_normalize_priority(unsigne
 	return psos_prio;
 }
 
+/*
+ * Although default pSOS priorities are mapped 1:1 to SCHED_RT,
+ * we do still have to use a denormalize function because these
+ * calls are weak and application code may be override the call
+ * and implement the mapping differently.
+ */
+
+__attribute__ ((weak))
+int psos_task_denormalize_priority(unsigned long core_prio)
+{
+	/* Map a SCHED_RT priority level to a pSOS one. */
+	return core_prio;
+}
+
+
 static int check_task_priority(u_long psos_prio, int *core_prio)
 {
 	if (psos_prio < 1 || psos_prio > 255) /* In theory. */
@@ -246,6 +261,12 @@ static int check_task_priority(u_long ps
 	return SUCCESS;
 }
 
+int psos_task_get_priority(struct psos_task *task)
+{
+	int prio = threadobj_get_priority(&task->thobj);
+	return psos_task_denormalize_priority(prio);
+}
+
 u_long t_create(const char *name, u_long prio,
 		u_long sstack, u_long ustack, u_long flags, u_long *tid_r)
 {
@@ -416,7 +437,7 @@ u_long t_setpri(u_long tid, u_long newpr
 	if (task == NULL)
 		return ret;
 
-	*oldprio_r = threadobj_get_priority(&task->thobj);
+	*oldprio_r = psos_task_get_priority(task);
 
 	if (newprio == 0) { /* Only inquires for the task priority. */
 		put_psos_task(task);
diff --git a/lib/psos/task.h b/lib/psos/task.h
--- a/lib/psos/task.h
+++ b/lib/psos/task.h
@@ -71,6 +71,8 @@ void put_psos_task(struct psos_task *tas
 
 int __ev_send(struct psos_task *task, unsigned long events);
 
+int psos_task_get_priority(struct psos_task *task);
+
 extern struct cluster psos_task_table;
 
 #endif /* _PSOS_TASK_H */

