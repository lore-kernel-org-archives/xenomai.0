From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1190138931.15100.22.camel@domain.hid>
References: <353969d40709180729s54307285i983eb7cc24c90642@domain.hid>
	<1190138931.15100.22.camel@domain.hid>
Content-Type: multipart/mixed; boundary="=-MnMBVfsI/TJKRwGesx2S"
Date: Tue, 02 Oct 2007 18:18:38 +0200
Message-Id: <1191341918.6019.25.camel@domain.hid>
Mime-Version: 1.0
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Can't create more than one watchdog
	under	vxworks skin
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guillaume Gaudonville <guillaume.gaudonville@domain.hid>
Cc: xenomai@xenomai.org


--=-MnMBVfsI/TJKRwGesx2S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-09-18 at 20:08 +0200, Philippe Gerum wrote:
> On Tue, 2007-09-18 at 16:29 +0200, Guillaume Gaudonville wrote:
> > Hi,
> > 
> > I use Xenomai since a few time. I have to port an application
> > running under VxWorks on Linux. This application uses a lot of
> > watchdog
> > to delay job it has to do.
> > 
> > When I use the function wdCreate under the VxWorks skin (in User
> > Space), 
> > I am not able to create more than 1 watchdog. I watched to the
> > function implementation in 
> > user space and I saw that when I call wdCreate, a task is created with
> > the name: wdserver.
> > 
> > When I call wdCreate a second time, it returns me 0 because he can't
> > create 
> > another task with the same name (wdServer). But my watchdog seems to
> > be created in
> > kernel space because I can see it
> > in /proc/xenomai/registry/vxworks/watchdog.
> > 
> > Is it a mistake? If not, what is the reason for this behaviour? 
> > 
> 
> The current implementation is definitely silly. It should create one
> server for all outstanding watchdogs.

The attached patch against -rc3 does this.

-- 
Philippe.


--=-MnMBVfsI/TJKRwGesx2S
Content-Disposition: attachment; filename=concurrent-watchdog.patch
Content-Type: text/x-patch; name=concurrent-watchdog.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: include/vxworks/Makefile.am
===================================================================
--- include/vxworks/Makefile.am	(revision 3020)
+++ include/vxworks/Makefile.am	(working copy)
@@ -1,3 +1,3 @@
 includesubdir = $(includedir)/vxworks
 
-includesub_HEADERS = syscall.h vxworks.h
+includesub_HEADERS = syscall.h vxworks.h ppd.h
Index: include/vxworks/ppd.h
===================================================================
--- include/vxworks/ppd.h	(revision 0)
+++ include/vxworks/ppd.h	(revision 0)
@@ -0,0 +1,107 @@
+/**
+ * @file
+ * This file is part of the Xenomai project.
+ *
+ * @note Copyright (C) 2007 Philippe Gerum <rpm@xenomai.org> 
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef _VXWORKS_PPD_H
+#define _VXWORKS_PPD_H
+
+#include <nucleus/pod.h>
+#include <nucleus/ppd.h>
+
+#ifndef CONFIG_XENO_OPT_DEBUG_VXWORKS
+#define CONFIG_XENO_OPT_DEBUG_VXWORKS  0
+#endif
+
+typedef struct wind_resource_holder {
+
+	xnshadow_ppd_t ppd;
+
+#define ppd2rholder(a)	container_of(a, struct wind_resource_holder, ppd)
+
+	xnqueue_t wdq;		/* Watchdogs created by the process. */
+
+	int wdcount;		/* Number of watchdogs created */
+	xnsynch_t wdsynch;	/* Per-process synch for watchdog server task. */
+	xnqueue_t wdpending;	/* Elapsed watchdogs to notify to user-space. */
+
+} wind_rholder_t;
+
+extern wind_rholder_t __wind_global_rholder;
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+
+extern int __wind_muxid;
+
+static inline wind_rholder_t *wind_get_rholder(void)
+{
+	xnshadow_ppd_t *ppd = xnshadow_ppd_get(__wind_muxid);
+
+	if (ppd == NULL)
+		return &__wind_global_rholder;
+
+	return ppd2rholder(ppd);
+}
+
+#else /* !CONFIG_XENO_OPT_PERVASIVE */
+
+static inline wind_rholder_t *wind_get_rholder(void)
+{
+	return &__wind_global_rholder;
+}
+
+#endif /* !CONFIG_XENO_OPT_PERVASIVE */
+
+#if XENO_DEBUG(VXWORKS)
+#define __wind_trace_release(__name, __obj, __err)			\
+	xnprintf("VxWorks: cleaning up %s \"%s\" (ret=%d).\n",		\
+		 __name, (__obj)->name, __err)
+#else /* !XENO_DEBUG(VXWORKS) */
+#define __wind_trace_release(__name, __obj, __err)
+#endif /* !XENO_DEBUG(VXWORKS) */
+
+#define wind_flush_rq(__type, __rq, __name)				\
+	do {								\
+		STATUS __name##Delete(__natural_word_type id);		\
+		xnholder_t *holder, *nholder;				\
+		__type *obj;						\
+		STATUS err;						\
+		spl_t s;						\
+		xnlock_get_irqsave(&nklock, s);				\
+		nholder = getheadq(__rq);				\
+		while ((holder = nholder) != NULL) {			\
+			nholder = nextq((__rq), holder);		\
+			xnlock_put_irqrestore(&nklock, s);		\
+			obj = rlink2##__name(holder);			\
+			err = __name##Delete((__natural_word_type)obj);	\
+			__wind_trace_release(#__name, obj, err);	\
+			if (unlikely(err)) {				\
+				if ((__rq) != &__wind_global_rholder.__name##q) { \
+					xnlock_get_irqsave(&nklock, s);	\
+					nholder = popq((rq), holder);	\
+					appendq(&__wind_global_rholder.__name##q, holder); \
+					obj->rqueue = &__wind_global_rholder.__name##q; \
+				}					\
+			} else						\
+				xnlock_get_irqsave(&nklock, s);		\
+		}							\
+		xnlock_put_irqrestore(&nklock, s);			\
+	} while(0)
+
+#endif /* !_VXWORKS_PPD_H */
Index: src/skins/vxworks/wdLib.c
===================================================================
--- src/skins/vxworks/wdLib.c	(revision 3020)
+++ src/skins/vxworks/wdLib.c	(working copy)
@@ -22,18 +22,17 @@
 
 extern int __vxworks_muxid;
 
-static inline int __wdWait(WDOG_ID wdog_id, wind_wd_utarget_t *wdt)
+static inline int __wdWait(wind_wd_utarget_t *wdt)
 {
-	return XENOMAI_SKINCALL2(__vxworks_muxid, __vxworks_wd_wait, wdog_id,
-				 wdt);
+	return XENOMAI_SKINCALL1(__vxworks_muxid, __vxworks_wd_wait, wdt);
 }
 
-static void wdServer(WDOG_ID wdog_id)
+static void wdServer(void)
 {
 	wind_wd_utarget_t wdt;
 
 	for (;;) {
-		switch (__wdWait(wdog_id, &wdt)) {
+		switch (__wdWait(&wdt)) {
 		case 0:
 			wdt.handler(wdt.arg);
 		case -EINTR:
@@ -55,15 +54,6 @@
 		return 0;
 	}
 
-	/* Start a watchdog server in user-space which will fire the
-	   handler as needed. */
-
-	if (taskSpawn("wdserver", 0, 0, 0, (FUNCPTR) & wdServer,
-		      wdog_id, 0, 0, 0, 0, 0, 0, 0, 0, 0) == ERROR) {
-		wdCancel(wdog_id);
-		return 0;
-	}
-
 	return wdog_id;
 }
 
@@ -82,16 +72,26 @@
 
 STATUS wdStart(WDOG_ID wdog_id, int timeout, wind_timer_t handler, long arg)
 {
+	long start_server;
 	int err;
 
-	err = XENOMAI_SKINCALL4(__vxworks_muxid,
+	err = XENOMAI_SKINCALL5(__vxworks_muxid,
 				__vxworks_wd_start, wdog_id, timeout, handler,
-				arg);
+				arg, &start_server);
 	if (err) {
 		errno = abs(err);
 		return ERROR;
 	}
 
+	/* Upon creation of the first watchdog, start a server task
+	   which will fire the watchdog handlers as needed. */
+
+	if (start_server && taskSpawn("wdserver", 0, 0, 0, (FUNCPTR) & wdServer,
+				      wdog_id, 0, 0, 0, 0, 0, 0, 0, 0, 0) == ERROR) {
+		fprintf(stderr, "VxWorks: failed to start the watchdog server (err %d)\n", errno);
+		return ERROR;
+	}
+
 	return OK;
 }
 
Index: src/skins/vxworks/Makefile.am
===================================================================
--- src/skins/vxworks/Makefile.am	(revision 3020)
+++ src/skins/vxworks/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES = libvxworks.la
 
-libvxworks_la_LDFLAGS = -version-info 0:0:0 -lpthread
+libvxworks_la_LDFLAGS = -version-info 1:0:0 -lpthread
 
 libvxworks_la_SOURCES = \
 	errnoLib.c \
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 3020)
+++ ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2007-10-02  Philippe Gerum  <rpm@xenomai.org>
+
+	* ksrc/skins/vxworks/{syscall.c, wdLib.c}, src/skins/vxworks: Fix
+	implementation for concurrent watchdog support.
+
 2007-09-28  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* ksrc/drivers/testing/timerbench.c: Take care of overflows also in
Index: ksrc/skins/vxworks/Kconfig
===================================================================
--- ksrc/skins/vxworks/Kconfig	(revision 3020)
+++ ksrc/skins/vxworks/Kconfig	(working copy)
@@ -7,8 +7,9 @@
 
 	This API skin emulates WindRiver's VxWorks operating system.
 
+if XENO_SKIN_VXWORKS
+
 config XENO_OPT_VXWORKS_PERIOD
-	depends on XENO_SKIN_VXWORKS
 	int "Base period (us)"
 	default 1000
 	help
@@ -20,3 +21,14 @@
 
 	The base period can be overriden at runtime using the
 	"tick_arg" module parameter when loading the VxWorks skin.
+
+config XENO_OPT_DEBUG_VXWORKS
+	bool "Debugging support"
+	depends on XENO_OPT_DEBUG
+	default y
+	help
+
+	When enabled, this option makes the skin warn about
+	auto-clean operations executed upon process termination.
+
+endif
Index: ksrc/skins/vxworks/wdLib.c
===================================================================
--- ksrc/skins/vxworks/wdLib.c	(revision 3020)
+++ ksrc/skins/vxworks/wdLib.c	(working copy)
@@ -22,8 +22,6 @@
 
 #define WIND_WD_INITIALIZED XNTIMER_SPARE0
 
-static xnqueue_t wind_wd_q;
-
 static void wd_destroy_internal(wind_wd_t *wd);
 
 #ifdef CONFIG_XENO_EXPORT_REGISTRY
@@ -44,13 +42,13 @@
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	{
 		xnpholder_t *holder =
-		    getheadpq(xnsynch_wait_queue(&wd->synchbase));
+		    getheadpq(xnsynch_wait_queue(&wd->rh->wdsynch));
 
 		while (holder) {
 			xnthread_t *sleeper = link2thread(holder, plink);
 			p += sprintf(p, "+%s\n", xnthread_name(sleeper));
 			holder =
-			    nextpq(xnsynch_wait_queue(&wd->synchbase), holder);
+			    nextpq(xnsynch_wait_queue(&wd->rh->wdsynch), holder);
 		}
 	}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
@@ -99,15 +97,11 @@
 
 void wind_wd_init(void)
 {
-	initq(&wind_wd_q);
 }
 
 void wind_wd_cleanup(void)
 {
-	xnholder_t *holder;
-
-	while ((holder = getheadq(&wind_wd_q)) != NULL)
-		wd_destroy_internal(link2wind_wd(holder));
+	wind_wd_flush_rq(&__wind_global_rholder.wdq);
 }
 
 WDOG_ID wdCreate(void)
@@ -117,17 +111,19 @@
 
 	check_alloc(wind_wd_t, wd, return 0);
 
-	inith(&wd->link);
 	wd->magic = WIND_WD_MAGIC;
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-	xnsynch_init(&wd->synchbase, XNSYNCH_PRIO);
+	wd->rh = wind_get_rholder();
+	inith(&wd->plink);
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
 	xntimer_init(&wd->timerbase, wind_tbase, wind_wd_trampoline);
 
+	inith(&wd->rlink);
+	wd->rqueue = &wind_get_rholder()->wdq;
 	xnlock_get_irqsave(&nklock, s);
 	__setbits(wd->timerbase.status, WIND_WD_INITIALIZED);
-	appendq(&wind_wd_q, &wd->link);
+	appendq(wd->rqueue, &wd->rlink);
 	xnlock_put_irqrestore(&nklock, s);
 
 #ifdef CONFIG_XENO_OPT_REGISTRY
@@ -157,6 +153,7 @@
 	check_OBJ_ID_ERROR(wdog_id, wind_wd_t, wd, WIND_WD_MAGIC, goto error);
 	wd_destroy_internal(wd);
 	xnlock_put_irqrestore(&nklock, s);
+	xnfree(wd);
 	return OK;
 
       error:
@@ -211,21 +208,20 @@
 	return ERROR;
 }
 
+/* Called with nklock locked, interrupts off. */
 static void wd_destroy_internal(wind_wd_t *wd)
 {
-	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
+	removeq(wd->rqueue, &wd->rlink);
 	xntimer_destroy(&wd->timerbase);
 #ifdef CONFIG_XENO_OPT_REGISTRY
 	xnregistry_remove(wd->handle);
 #endif /* CONFIG_XENO_OPT_REGISTRY */
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-	xnsynch_destroy(&wd->synchbase);
+	if (wd->plink.last != wd->plink.next)
+		/* Deleted watchdog was pending for delivery to the
+		 * user-space server task: remove it from the
+		 * list of events to process. */
+		removeq(&wd->rh->wdpending, &wd->plink);
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
-	removeq(&wind_wd_q, &wd->link);
 	wind_mark_deleted(wd);
-	xnlock_put_irqrestore(&nklock, s);
-
-	xnfree(wd);
 }
Index: ksrc/skins/vxworks/syscall.c
===================================================================
--- ksrc/skins/vxworks/syscall.c	(revision 3020)
+++ ksrc/skins/vxworks/syscall.c	(working copy)
@@ -2,7 +2,7 @@
  * @file
  * This file is part of the Xenomai project.
  *
- * @note Copyright (C) 2006 Philippe Gerum <rpm@xenomai.org> 
+ * @note Copyright (C) 2006,2007 Philippe Gerum <rpm@xenomai.org> 
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -40,7 +40,7 @@
  * actually targeting a proper VxWorks object.
  */
 
-static int __muxid;
+int __wind_muxid;
 
 static WIND_TCB *__wind_task_current(struct task_struct *curr)
 {
@@ -1045,6 +1045,7 @@
 	if (!wd)
 		return wind_errnoget();
 
+	wd->rh = wind_get_rholder();
 	wdog_id = wd->handle;
 	__xn_copy_to_user(curr, (void __user *)__xn_reg_arg1(regs), &wdog_id,
 			  sizeof(wdog_id));
@@ -1073,26 +1074,36 @@
 }
 
 /*
- * int __wind_wd_start(WDOG_ID wdog_id)
+ * int __wind_wd_start(WDOG_ID wdog_id,
  *		       int timeout,
  *                     wind_timer_t timer,
- *                     long arg)
+ *                     long arg,
+ *                     *long start_serverp)
  */
 
 void __wind_wd_handler(void *cookie)
 {
 	wind_wd_t *wd = (wind_wd_t *)cookie;
-	/* Wake the server task waiting on the watchdog sync. */
-	xnsynch_flush(&wd->synchbase, 0);
+
+	if (wd->plink.last == wd->plink.next) {	/* Not linked? */
+		appendq(&wd->rh->wdpending, &wd->plink);
+		if (countq(&wd->rh->wdpending) == 1)
+			xnsynch_flush(&wd->rh->wdsynch, 0);
+	}
 }
 
 static int __wind_wd_start(struct task_struct *curr, struct pt_regs *regs)
 {
+	wind_rholder_t *rh;
+	long start_server;
 	xnhandle_t handle;
 	wind_wd_t *wd;
 	int timeout;
 	spl_t s;
 
+	if (!__xn_access_ok(curr, VERIFY_WRITE, __xn_reg_arg5(regs), sizeof(start_server)))
+		return -EFAULT;
+
 	handle = __xn_reg_arg1(regs);
 
 	wd = (wind_wd_t *)xnregistry_fetch(handle);
@@ -1100,6 +1111,15 @@
 	if (!wd)
 		return S_objLib_OBJ_ID_ERROR;
 
+	rh = wind_get_rholder();
+
+	if (wd->rh != rh)
+		/*
+		 * User may not fiddle with watchdogs created from
+		 * other processes.
+		 */
+		return S_objLib_OBJ_UNAVAILABLE;
+
 	timeout = __xn_reg_arg2(regs);
 
 	xnlock_get_irqsave(&nklock, s);
@@ -1113,9 +1133,13 @@
 
 	wd->wdt.handler = (wind_timer_t) __xn_reg_arg3(regs);
 	wd->wdt.arg = (long)__xn_reg_arg4(regs);
+	start_server = rh->wdcount++ == 0;
 
 	xnlock_put_irqrestore(&nklock, s);
 
+	__xn_copy_to_user(curr, (void __user *)__xn_reg_arg5(regs), &start_server,
+			  sizeof(start_server));
+
 	return 0;
 }
 
@@ -1140,47 +1164,62 @@
 }
 
 /*
- * int __wind_wd_wait(WDOG_ID wdog_id, wind_wd_utarget_t *pwdt)
+ * int __wind_wd_wait(wind_wd_utarget_t *pwdt)
  */
 
 static int __wind_wd_wait(struct task_struct *curr, struct pt_regs *regs)
 {
-	xnhandle_t handle = __xn_reg_arg1(regs);
+	xnholder_t *holder;
+	wind_rholder_t *rh;
 	WIND_TCB *pTcb;
 	wind_wd_t *wd;
 	int err = 0;
 	spl_t s;
 
 	if (!__xn_access_ok
-	    (curr, VERIFY_WRITE, __xn_reg_arg2(regs), sizeof(wd->wdt)))
+	    (curr, VERIFY_WRITE, __xn_reg_arg1(regs), sizeof(wd->wdt)))
 		return -EFAULT;
 
+	rh = wind_get_rholder();
+
 	xnlock_get_irqsave(&nklock, s);
 
-	wd = (wind_wd_t *)xnregistry_fetch(handle);
+	if (!emptyq_p(&rh->wdpending))
+		goto pull_event;
 
-	if (!wd) {
-		err = S_objLib_OBJ_ID_ERROR;
-		goto unlock_and_exit;
-	}
-
 	pTcb = __wind_task_current(curr);
 
 	if (xnthread_base_priority(&pTcb->threadbase) != XNCORE_IRQ_PRIO)
 		/* Renice the waiter above all regular tasks if needed. */
 		xnpod_renice_thread(&pTcb->threadbase, XNCORE_IRQ_PRIO);
 
-	xnsynch_sleep_on(&wd->synchbase, XN_INFINITE, XN_RELATIVE);
+	xnsynch_sleep_on(&rh->wdsynch, XN_INFINITE, XN_RELATIVE);
 
-	if (xnthread_test_info(&pTcb->threadbase, XNBREAK))
+	if (xnthread_test_info(&pTcb->threadbase, XNBREAK)) {
 		err = -EINTR;	/* Unblocked. */
-	else if (xnthread_test_info(&pTcb->threadbase, XNRMID))
+		goto unlock_and_exit;
+	}
+	
+	if (xnthread_test_info(&pTcb->threadbase, XNRMID)) {
 		err = -EIDRM;	/* Watchdog deleted while pending. */
-	else
-		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg2(regs),
+		goto unlock_and_exit;
+	}
+
+ pull_event:
+
+	holder = getq(&rh->wdpending);
+
+	if (holder) {
+		wd = link2wind_wd(holder);
+		/* We need the following to mark the watchdog as unqueued. */
+		inith(holder);
+		xnlock_put_irqrestore(&nklock, s);
+		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg1(regs),
 				  &wd->wdt, sizeof(wd->wdt));
+		return 0;
+	}
 
-      unlock_and_exit:
+ unlock_and_exit:
 
 	xnlock_put_irqrestore(&nklock, s);
 
@@ -1198,6 +1237,42 @@
 	    && xnthread_base_priority(&pTcb->threadbase) == XNCORE_IRQ_PRIO;
 }
 
+static void *__wind_shadow_eventcb(int event, void *data)
+{
+	struct wind_resource_holder *rh;
+	switch(event) {
+
+	case XNSHADOW_CLIENT_ATTACH:
+
+		rh = (struct wind_resource_holder *) xnarch_alloc_host_mem(sizeof(*rh));
+		if (!rh)
+			return ERR_PTR(-ENOMEM);
+
+		initq(&rh->wdq);
+
+		/* A single server thread pends on this. */
+		xnsynch_init(&rh->wdsynch, XNSYNCH_FIFO);
+		initq(&rh->wdpending);
+		rh->wdcount = 0;
+
+		return &rh->ppd;
+
+	case XNSHADOW_CLIENT_DETACH:
+
+		rh = ppd2rholder((xnshadow_ppd_t *) data);
+		wind_wd_flush_rq(&rh->wdq);
+
+		xnsynch_destroy(&rh->wdsynch);
+		/* No need to reschedule: all our threads have been zapped. */
+
+		xnarch_free_host_mem(rh, sizeof(*rh));
+
+		return NULL;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
 static xnsysent_t __systab[] = {
 	[__vxworks_task_init] = {&__wind_task_init, __xn_exec_init},
 	[__vxworks_task_activate] = {&__wind_task_activate, __xn_exec_any},
@@ -1258,7 +1333,7 @@
 	.magic = VXWORKS_SKIN_MAGIC,
 	.nrcalls = sizeof(__systab) / sizeof(__systab[0]),
 	.systab = __systab,
-	.eventcb = NULL,
+	.eventcb = __wind_shadow_eventcb,
 	.timebasep = &wind_tbase,
 	.module = THIS_MODULE
 };
@@ -1272,9 +1347,9 @@
 
 int wind_syscall_init(void)
 {
-	__muxid = xnshadow_register_interface(&__props);
+	__wind_muxid = xnshadow_register_interface(&__props);
 
-	if (__muxid < 0)
+	if (__wind_muxid < 0)
 		return -ENOSYS;
 
 	xnpod_add_hook(XNHOOK_THREAD_DELETE, &__shadow_delete_hook);
@@ -1285,5 +1360,5 @@
 void wind_syscall_cleanup(void)
 {
 	xnpod_remove_hook(XNHOOK_THREAD_DELETE, &__shadow_delete_hook);
-	xnshadow_unregister_interface(__muxid);
+	xnshadow_unregister_interface(__wind_muxid);
 }
Index: ksrc/skins/vxworks/module.c
===================================================================
--- ksrc/skins/vxworks/module.c	(revision 3020)
+++ ksrc/skins/vxworks/module.c	(working copy)
@@ -37,6 +37,8 @@
 
 xntbase_t *wind_tbase;
 
+wind_rholder_t __wind_global_rholder;
+
 #ifdef CONFIG_XENO_EXPORT_REGISTRY
 xnptree_t __vxworks_ptree = {
 
@@ -50,6 +52,15 @@
 {
 	int err;
 
+	initq(&__wind_global_rholder.wdq);
+
+	/* The following fields are unused in the global holder;
+	   still, we initialize them not to leave such data in an
+	   invalid state. */
+	xnsynch_init(&__wind_global_rholder.wdsynch, XNSYNCH_FIFO);
+	initq(&__wind_global_rholder.wdpending);
+	__wind_global_rholder.wdcount = 0;
+
 	err = xnpod_init();
 
 	if (err != 0)
Index: ksrc/skins/vxworks/defs.h
===================================================================
--- ksrc/skins/vxworks/defs.h	(revision 3020)
+++ ksrc/skins/vxworks/defs.h	(working copy)
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2001,2002 IDEALX (http://www.idealx.com/).
  * Written by Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
- * Copyright (C) 2003 Philippe Gerum <rpm@xenomai.org>.
+ * Copyright (C) 2003,2007 Philippe Gerum <rpm@xenomai.org>.
  *
  * Xenomai is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by
@@ -24,6 +24,7 @@
 #include <nucleus/xenomai.h>
 #include <nucleus/registry.h>
 #include <vxworks/vxworks.h>
+#include <vxworks/ppd.h>
 
 #define WIND_MAGIC(n) (0x8383##n##n)
 #define WIND_TASK_MAGIC WIND_MAGIC(01)
@@ -126,12 +127,8 @@
 
 typedef struct wind_wd {
 
-    unsigned magic;   /* Magic code - must be first */
+    unsigned magic;		/* Magic code - must be first */
 
-    xnholder_t link;
-
-#define link2wind_wd(ln) container_of(ln, wind_wd_t, link)
-
     xntimer_t timerbase;
 
     wind_timer_t handler;
@@ -143,12 +140,24 @@
 #endif /* CONFIG_XENO_OPT_REGISTRY */
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-    xnsynch_t synchbase;
-    wind_wd_utarget_t wdt;
+    wind_rholder_t *rh;		/* !< Resource holder of owner. */
+    wind_wd_utarget_t wdt;	/* !< User-space handler and arg. */
+    xnholder_t plink;		/* !< Link in owner's pending queue. */
+#define link2wind_wd(ln) container_of(ln, wind_wd_t, plink)
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
+    xnholder_t rlink;		/* !< Link in resource queue. */
+#define rlink2wd(ln)		container_of(ln, wind_wd_t, rlink)
+
+    xnqueue_t *rqueue;		/* !< Backpointer to resource queue. */
+
 } wind_wd_t;
 
+static inline void wind_wd_flush_rq(xnqueue_t *rq)
+{
+	wind_flush_rq(wind_wd_t, rq, wd);
+}
+
 /* Internal flag marking a user-space task. */
 #define VX_SHADOW 0x8000
 
Index: doc/txt/vxworks-skin.txt
===================================================================
--- doc/txt/vxworks-skin.txt	(revision 3020)
+++ doc/txt/vxworks-skin.txt	(working copy)
@@ -94,6 +94,9 @@
   sleep. This is for instance the case whenever the caller is not a
   VxWorks task, or the scheduler is locked.
 
+- wdStart() returns S_objLib_OBJ_UNAVAILABLE when a userland caller
+  attempts to start a watchdog created from a different process.
+
 - In case the documented VxWorks API does not explicitly handle the
   case, calling blocking services outside of any VxWorks task context or
   under scheduler lock, might return the POSIX error value "EPERM".

--=-MnMBVfsI/TJKRwGesx2S--


