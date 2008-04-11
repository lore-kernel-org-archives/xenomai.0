Message-ID: <47FF5EB9.9070605@domain.hid>
Date: Fri, 11 Apr 2008 14:51:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Fix tiny memory leaks around rt_task_self()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Nothing critical, but when using rt_task_self != NULL as a hint if the
caller is Xenomai-mapped or not, this stall malloc can become at least
unpleasant. This is also material for stable.

Jan

---

Index: xenomai/ChangeLog
===================================================================
--- xenomai/ChangeLog	(Revision 3698)
+++ xenomai/ChangeLog	(Arbeitskopie)
@@ -1,3 +1,8 @@
+2008-04-11  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* src/skins/native/task.c: Fix tiny memory leaks of the task's
+	self-reference key.
+
 2008-04-10  Philippe Gerum  <rpm@xenomai.org>
 
 	* src/skins/*: Force minimum stack size to 32k, in order to work
Index: xenomai/src/skins/native/task.c
===================================================================
--- xenomai/src/skins/native/task.c	(Revision 3698)
+++ xenomai/src/skins/native/task.c	(Arbeitskopie)
@@ -52,6 +52,11 @@ static void rt_task_sigharden(int sig)
 	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
 }
 
+static void rt_task_cleanup_tskey(void *arg)
+{
+	free(pthread_getspecific(__native_tskey));
+}
+
 static void *rt_task_trampoline(void *cookie)
 {
 	struct rt_task_iargs *iargs = (struct rt_task_iargs *)cookie;
@@ -92,8 +97,11 @@ static void *rt_task_trampoline(void *co
 		err = XENOMAI_SYSCALL2(__xn_sys_barrier, &entry, &cookie);
 	while (err == -EINTR);
 
-	if (!err)
+	if (!err) {
+		pthread_cleanup_push(rt_task_cleanup_tskey, NULL);
 		entry(cookie);
+		pthread_cleanup_pop(1);
+	}
 
       fail:
 
@@ -294,8 +302,10 @@ RT_TASK *rt_task_self(void)
 	self = (RT_TASK *)malloc(sizeof(*self));
 
 	if (!self ||
-	    XENOMAI_SKINCALL1(__native_muxid, __native_task_self, self) != 0)
+	    XENOMAI_SKINCALL1(__native_muxid, __native_task_self, self) != 0) {
+		free(self);
 		return NULL;
+	}
 
 	pthread_setspecific(__native_tskey, self);
 

