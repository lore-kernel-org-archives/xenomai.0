Message-ID: <43972D95.6090507@domain.hid>
Date: Wed, 07 Dec 2005 19:44:37 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] rt_task_join?
References: <439729A6.3010309@domain.hid>
In-Reply-To: <439729A6.3010309@domain.hid>
Content-Type: multipart/mixed; boundary="------------020006080403050200050502"
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

This is a multi-part message in MIME format.
--------------020006080403050200050502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Hi all,
> 
> we ran into some issue where we have to wait on the termination of a
> native real-time userspace thread during cleanup. This can be done in a
> custom way of course, either via some polling on a flag or by blocking
> on a standard posix semaphore that are signalled by the terminating
> real-time thread. But maybe it is more useful to have a generic function
> available with the native skin.
> 
> The problem is now that the pthreads underneath the real-time threads
> are created with PTHREAD_CREATE_DETACHED. Changing this also changes the
> semantic of other rt_task_xxx functions as posix then requires the
> creator to call pthread_join (i.e. a new rt_task_join) in any case. A
> better option might be to introduce a new mode bit T_JOINABLE to decide
> if the related pthread should be created detached or not. Default would
> remain PTHREAD_CREATE_DETACHED, if rt_task_join is to be used,
> T_JOINABLE could be passed to rt_task_create.
> 
> What do you think, worth the effort?
> 

Actually, the effort could be as simple as this (+ some docs) - as long
as I'm not overseeing some side effect right now.

Jan

--------------020006080403050200050502
Content-Type: text/plain;
 name="rt_task_join.rfc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt_task_join.rfc"

Index: include/native/task.h
===================================================================
--- include/native/task.h	(revision 245)
+++ include/native/task.h	(working copy)
@@ -35,18 +35,19 @@
 #define T_CPUMASK  0xff000000
 
 /* Status/mode flags. */
-#define T_BLOCKED XNPEND
-#define T_DELAYED XNDELAY
-#define T_READY   XNREADY
-#define T_DORMANT XNDORMANT
-#define T_STARTED XNSTARTED
-#define T_BOOST   XNBOOST
-#define T_LOCK    XNLOCK
-#define T_RRB     XNRRB
-#define T_NOSIG   XNASDI
-#define T_SHIELD  XNSHIELD
-#define T_WARNSW  XNTRAPSW
-#define T_PRIMARY XNTHREAD_SPARE0
+#define T_BLOCKED  XNPEND
+#define T_DELAYED  XNDELAY
+#define T_READY    XNREADY
+#define T_DORMANT  XNDORMANT
+#define T_STARTED  XNSTARTED
+#define T_BOOST    XNBOOST
+#define T_LOCK     XNLOCK
+#define T_RRB      XNRRB
+#define T_NOSIG    XNASDI
+#define T_SHIELD   XNSHIELD
+#define T_WARNSW   XNTRAPSW
+#define T_PRIMARY  XNTHREAD_SPARE0
+#define T_JOINABLE XNTHREAD_SPARE1
 
 /* Task hook types. */
 #define T_HOOK_START  XNHOOK_THREAD_START
@@ -268,6 +269,8 @@
 int rt_task_slice(RT_TASK *task,
 		  RTIME quantum);
 
+int rt_task_join(RT_TASK *task);
+
 #ifdef CONFIG_XENO_OPT_NATIVE_MPS
 
 ssize_t rt_task_send(RT_TASK *task,
Index: src/skins/native/task.c
===================================================================
--- src/skins/native/task.c	(revision 245)
+++ src/skins/native/task.c	(working copy)
@@ -127,7 +127,8 @@
 	stksize = PTHREAD_STACK_MIN;
 
     pthread_attr_setstacksize(&thattr,stksize);
-    pthread_attr_setdetachstate(&thattr,PTHREAD_CREATE_DETACHED);
+    if (!(mode & T_JOINABLE))
+	pthread_attr_setdetachstate(&thattr,PTHREAD_CREATE_DETACHED);
     pthread_attr_setschedpolicy(&thattr,SCHED_FIFO);
     param.sched_priority = sched_get_priority_max(SCHED_FIFO);
     pthread_attr_setschedparam(&thattr,&param);
@@ -331,6 +332,11 @@
 			     &quantum);
 }
 
+int rt_task_join (RT_TASK *task)
+{
+    return -pthread_join((pthread_t)task->opaque2, NULL);
+}
+
 #ifdef CONFIG_XENO_OPT_NATIVE_MPS
 
 ssize_t rt_task_send (RT_TASK *task,

--------------020006080403050200050502--

