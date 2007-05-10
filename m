Message-ID: <46433E26.8040307@domain.hid>
Date: Thu, 10 May 2007 17:45:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>	
	<4641CD8B.8050309@domain.hid>	
	<7289437c0705090643gc9f0ddax6fa6cff44895c9ed@domain.hid>	
	<7289437c0705090735n58b4a0fbm7e31c8571efb7514@domain.hid>	
	<17986.12574.488256.997900@domain.hid>	
	<17986.15326.243315.427529@domain.hid>	
	<1178748178.11688.45.camel@domain.hid>	
	<17986.20728.617772.991566@domain.hid>	
	<1178784303.11688.108.camel@domain.hid> <4642D901.9050304@domain.hid>	
	<1178789171.11688.142.camel@domain.hid> <4642E706.7000500@domain.hid>	
	<1178808027.11688.150.camel@domain.hid> <464331CF.3090505@domain.hid>
	<1178810494.11688.188.camel@domain.hid>
In-Reply-To: <1178810494.11688.188.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------060302060502040906020201"
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060302060502040906020201
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7Bit

Philippe Gerum wrote:
> On Thu, 2007-05-10 at 16:53 +0200, Gilles Chanteperdrix wrote:
> 
>>Philippe Gerum wrote:
>>
>>>On Thu, 2007-05-10 at 11:33 +0200, Gilles Chanteperdrix wrote:
>>>
>>>
>>>>Philippe Gerum wrote:
>>>>
>>>>>xnfreesafe was meant to prevent the caller from releasing some memory it
>>>>>could still rely on, e.g. stack space, by postponing the actual release
>>>>>until the idle thread is resumed. In your case, the problem is that it
>>>>>does not account for the primary/secondary mode of a shadow thread.
>>>>
>>>>I am not so sure. I mean, even if the thread was deleted from the
>>>>context of another thread, the two hooks would be invoked and we would
>>>>need the free operation to be deferred until after the execution of the
>>>>second hook.
>>>>
>>>
>>>
>>>The point is that deletion hooks are always called on behalf of the
>>>exiting thread in secondary mode, so if xnfreesafe properly identifies
>>>the caller as the current thread - regardless of its exec mode - then
>>>the deferral should always take place. But I agree on the fact that we
>>>should always end up running the deferred call in this context anyway,
>>>so we would be better off calling xnheap_schedule_free() directly.
>>
>>That is why, since xnfreesafe was only called in this precise context, I
>>redefined it to call xnheap_schedule_free directly.
>>
> 
> 
> Well, ok. But we may need the xnfreesafe() interface in the future, the
> way it was designed initially, I mean. So let's call
> xnheap_schedule_free directly when needed.
> 

Hence the final patch:

-- 
                                                 Gilles Chanteperdrix

--------------060302060502040906020201
Content-Type: text/x-patch;
 name="xeno-use-xnheap_schedule_free.diff"
Content-Disposition: inline;
 filename="xeno-use-xnheap_schedule_free.diff"
Content-Transfer-Encoding: Quoted-Printable

Index: v2.3.x/include/nucleus/heap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- v2.3.x/include/nucleus/heap.h	(r=C3=A9vision 2429)
+++ v2.3.x/include/nucleus/heap.h	(copie de travail)
@@ -120,7 +120,7 @@
 #define xnfreesync()       xnheap_finalize_free(&kheap)
 #define xnfreesafe(thread,ptr,ln) \
 do { \
-    if (xnpod_current_thread() =3D=3D thread) \
+    if (xnpod_current_p(thread))	     \
 	xnheap_schedule_free(&kheap,ptr,ln); \
     else \
 	xnheap_free(&kheap,ptr); \
Index: v2.3.x/include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- v2.3.x/include/nucleus/pod.h	(r=C3=A9vision 2429)
+++ v2.3.x/include/nucleus/pod.h	(copie de travail)
@@ -297,8 +297,16 @@
 #define xnpod_current_root() \
     (&xnpod_current_sched()->rootcb)
=20
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+#define xnpod_current_p(thread)					\
+    ({ int __shadow_p =3D xnthread_test_state(thread, XNSHADOW);		\
+       int __curr_p =3D __shadow_p ? xnshadow_thread(current) =3D=3D thr=
ead	\
+	   : thread =3D=3D xnpod_current_thread();				\
+       __curr_p;})
+#else
 #define xnpod_current_p(thread) \
     (xnpod_current_thread() =3D=3D (thread))
+#endif
=20
 #define xnpod_locked_p() \
     (!!xnthread_test_state(xnpod_current_thread(),XNLOCK))
Index: v2.3.x/ksrc/skins/psos+/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- v2.3.x/ksrc/skins/psos+/task.c	(r=C3=A9vision 2429)
+++ v2.3.x/ksrc/skins/psos+/task.c	(copie de travail)
@@ -52,7 +52,7 @@
 	xnarch_delete_display(&task->threadbase);
 	psos_mark_deleted(task);
=20
-	xnfreesafe(&task->threadbase, task, &task->link);
+	xnheap_schedule_free(&kheap, task, &task->link);
 }
=20
 void psostask_init(u_long rrperiod)
Index: v2.3.x/ksrc/skins/rtai/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- v2.3.x/ksrc/skins/rtai/task.c	(r=C3=A9vision 2429)
+++ v2.3.x/ksrc/skins/rtai/task.c	(copie de travail)
@@ -40,7 +40,7 @@
 	rtai_mark_deleted(task);
=20
 	if (xnthread_test_state(&task->thread_base, XNSHADOW))
-		xnfreesafe(&task->thread_base, task, &task->link);
+		xnheap_schedule_free(&kheap, task, &task->link);
 }
=20
 static void __task_switch_hook(xnthread_t *thread)
Index: v2.3.x/ksrc/skins/posix/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- v2.3.x/ksrc/skins/posix/thread.c	(r=C3=A9vision 2429)
+++ v2.3.x/ksrc/skins/posix/thread.c	(copie de travail)
@@ -45,7 +45,7 @@
 	   called from pse51_thread_pkg_cleanup, hence the absence of
 	   xnpod_schedule(). */
 	xnsynch_destroy(&thread->join_synch);
-	xnfree(thread);
+	xnheap_schedule_free(&kheap, thread, &thread->link);
 }
=20
 static void thread_trampoline(void *cookie)
Index: v2.3.x/ksrc/skins/vrtx/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- v2.3.x/ksrc/skins/vrtx/task.c	(r=C3=A9vision 2429)
+++ v2.3.x/ksrc/skins/vrtx/task.c	(copie de travail)
@@ -46,7 +46,7 @@
=20
 	vrtx_mark_deleted(task);
=20
-	xnfreesafe(&task->threadbase, task, &task->link);
+	xnheap_schedule_free(&kheap, task, &task->link);
 }
=20
 int vrtxtask_init(u_long stacksize)
Index: v2.3.x/ksrc/skins/vxworks/taskLib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- v2.3.x/ksrc/skins/vxworks/taskLib.c	(r=C3=A9vision 2429)
+++ v2.3.x/ksrc/skins/vxworks/taskLib.c	(copie de travail)
@@ -605,7 +605,7 @@
 	wind_mark_deleted(task);
=20
 	if (task->auto_delete)
-		xnfreesafe(&task->threadbase, task, &task->link);
+		xnheap_schedule_free(&kheap, task, &task->link);
 }
=20
 static void wind_task_trampoline(void *cookie)
Index: v2.3.x/ksrc/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- v2.3.x/ksrc/skins/native/task.c	(r=C3=A9vision 2429)
+++ v2.3.x/ksrc/skins/native/task.c	(copie de travail)
@@ -76,7 +76,7 @@
 	xeno_mark_deleted(task);
=20
 	if (xnthread_test_state(&task->thread_base, XNSHADOW))
-		xnfreesafe(&task->thread_base, task, &task->link);
+		xnheap_schedule_free(&kheap, task, &task->link);
 }
=20
 void __native_task_safe(RT_TASK *task)

--------------060302060502040906020201--

