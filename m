MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kvdVuWaJC4"
Content-Transfer-Encoding: 7bit
Message-ID: <17477.6782.665009.909109@domain.hid>
Date: Tue, 18 Apr 2006 18:57:34 +0200
Subject: Re: [Xenomai-core] [PATCH] Check for NPTL and factor user-space skins
	initialization.
In-Reply-To: <44450481.3070102@domain.hid>
References: <17476.64062.107556.216362@domain.hid>
	<4444FF94.7050209@domain.hid>
	<17477.247.209915.347304@domain.hid>
	<44450481.3070102@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


--kvdVuWaJC4
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > Philippe Gerum wrote:
 > >  > 
 > >  > -ENOPARSE here. Which code is expected to call xeno_mlock_alert_end()?
 > > 
 > > pthread_set_mode_np and rt_task_set_mode. Sorry.
 > 
 > The issue I see doing so, is that you are going to trigger a SIGXCPU 
 > right after setting the XNTRAPSW bit for the current thread, as a result 
 > of calling sigaction and friends. This is why I used a plain and dumb 
 > memory flag instead, the logic being:
 > 
 > - first, trap SIGXCPU in the library ctor to detect the lack of process 
 > memory locking when mapping a shadow thread, and emit an explanatory 
 > message when caught.
 > 
 > - as soon as a thread succeeds in setting modes (set_mode_np and 
 > friends), then we know that a previous shadow mapping for the current 
 > Linux task has succeeded, otherwise the nucleus would not have been able 
 > to carry out the set_mode request. In such a case, make sure to cause 
 > our internal SIGXCPU handler to switch to the default behaviour, in case 
 > we did set the WARNSW bit for the current thread successfully. In all 
 > other cases, either the user has set its own SIGXCPU handler overriding 
 > our internal one, and we have no part in the play, or she did not and we 
 > won't spuriously emit the "missing mlock" message.

Ok. Another try.

-- 


					    Gilles Chanteperdrix.

--kvdVuWaJC4
Content-Type: text/plain
Content-Disposition: inline;
	filename="skin-init.4.patch"
Content-Transfer-Encoding: 7bit

Index: include/asm-i386/features.h
===================================================================
--- include/asm-i386/features.h	(revision 941)
+++ include/asm-i386/features.h	(working copy)
@@ -76,4 +76,33 @@
     }
 }
 
+#ifndef __KERNEL__
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static inline void xeno_x86_features_check(void)
+{
+#ifdef CONFIG_XENO_X86_SEP
+  size_t n = confstr(_CS_GNU_LIBPTHREAD_VERSION, NULL, 0);
+  if (n > 0)
+      {
+      char buf[n];
+      
+      confstr (_CS_GNU_LIBPTHREAD_VERSION, buf, n);
+
+      if (strstr (buf, "NPTL"))
+          return;
+      }
+
+  fprintf(stderr, "Xenomai: SEP instruction needs NPTL and NPTL was not detected"
+          "\nplease install NPTL or rebuild the user-space support passing "
+          "--disable-x86-sep.\n"); 
+  exit(1);
+#endif /* CONFIG_XENO_X86_SEP */
+}
+#define xeno_arch_features_check() xeno_x86_features_check()
+#endif /* __KERNEL__ */
+
 #endif /* !_XENO_ASM_I386_FEATURES_H */
Index: include/nucleus/Makefile.am
===================================================================
--- include/nucleus/Makefile.am	(revision 941)
+++ include/nucleus/Makefile.am	(working copy)
@@ -22,3 +22,5 @@
 	types.h \
 	version.h \
 	xenomai.h
+
+EXTRA_DIST = skin_init.h
Index: src/skins/rtai/init.c
===================================================================
--- src/skins/rtai/init.c	(revision 941)
+++ src/skins/rtai/init.c	(working copy)
@@ -19,6 +19,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <nucleus/skin_init.h>
 #include <rtai/syscall.h>
 
 int __rtai_muxid = -1;
@@ -26,45 +27,5 @@
 static __attribute__((constructor)) void __init_rtai_interface(void)
 
 {
-    xnfeatinfo_t finfo;
-    int muxid;
-
-    muxid = XENOMAI_SYSBIND(RTAI_SKIN_MAGIC,
-			    XENOMAI_FEAT_DEP,
-			    XENOMAI_ABI_REV,
-			    &finfo);
-    switch (muxid)
-	{
-	case -EINVAL:
-
-	    fprintf(stderr,"Xenomai: incompatible feature set\n");
-	    fprintf(stderr,"(required=\"%s\", present=\"%s\", missing=\"%s\").\n",
-		    finfo.feat_man_s,finfo.feat_all_s,finfo.feat_mis_s);
-	    exit(1);
-
-	case -ENOEXEC:
-
-	    fprintf(stderr,"Xenomai: incompatible ABI revision level\n");
-	    fprintf(stderr,"(needed=%lu, current=%lu).\n",
-		    XENOMAI_ABI_REV,finfo.abirev);
-	    exit(1);
-
-	case -ENOSYS:
-	case -ESRCH:
-
-	    fprintf(stderr,"Xenomai: RTAI skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
-	    fprintf(stderr,"(modprobe xeno_rtai?)\n");
-	    exit(1);
-
-	default:
-
-	    if (muxid < 0)
-		{
-		fprintf(stderr,"Xenomai: binding failed: %s.\n",strerror(-muxid));
-		exit(1);
-		}
-
-	    __rtai_muxid = muxid;
-	    break;
-	}
+    __rtai_muxid = xeno_user_skin_init(RTAI_SKIN_MAGIC, "RTAI", "xeno_rtai");
 }
Index: src/skins/posix/init.c
===================================================================
--- src/skins/posix/init.c	(revision 941)
+++ src/skins/posix/init.c	(working copy)
@@ -23,85 +23,22 @@
 #include <limits.h>
 #include <unistd.h>
 #include <sys/types.h>
+#include <nucleus/skin_init.h>
 #include <posix/posix.h>
 #include <posix/syscall.h>
 #include <rtdm/syscall.h>
 
 int __pse51_muxid = -1;
-int __pse51_sigxcpu_no_mlock = 1;
 int __rtdm_muxid  = -1;
 int __rtdm_fd_start = INT_MAX;
 
-void __handle_lock_alert (int sig)
-
-{
-    struct sigaction sa;
-
-    if (__pse51_sigxcpu_no_mlock)
-	{
-	fprintf(stderr,"Xenomai: process memory not locked (missing mlockall?)\n");
-	fflush(stderr);
-	exit(4);
-	}
-    else
-	{
-	/* PTHREAD_WARNSW was set for the thread but no user-defined
-	   handler has been set to override our internal handler, so
-	   let's invoke the default signal action. */
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = 0;
-	sigaction(SIGXCPU,&sa,NULL);
-	pthread_kill(pthread_self(),SIGXCPU);
-	}
-}
-
 static __attribute__((constructor)) void __init_posix_interface(void)
 
 {
-    struct sigaction sa;
-    xnfeatinfo_t finfo;
     int muxid;
+    
+    __pse51_muxid = xeno_user_skin_init(PSE51_SKIN_MAGIC, "POSIX", "xeno_posix");
 
-    muxid = XENOMAI_SYSBIND(PSE51_SKIN_MAGIC,
-			    XENOMAI_FEAT_DEP,
-			    XENOMAI_ABI_REV,
-			    &finfo);
-    switch (muxid)
-	{
-	case -EINVAL:
-
-	    fprintf(stderr,"Xenomai: incompatible feature set\n");
-	    fprintf(stderr,"(required=\"%s\", present=\"%s\", missing=\"%s\").\n",
-		    finfo.feat_man_s,finfo.feat_all_s,finfo.feat_mis_s);
-	    exit(1);
-
-	case -ENOEXEC:
-
-	    fprintf(stderr,"Xenomai: incompatible ABI revision level\n");
-	    fprintf(stderr,"(needed=%lu, current=%lu).\n",
-		    XENOMAI_ABI_REV,finfo.abirev);
-	    exit(1);
-
-	case -ENOSYS:
-	case -ESRCH:
-
-	    fprintf(stderr,"Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
-	    fprintf(stderr,"(modprobe xeno_posix?)\n");
-	    exit(1);
-
-	default:
-
-	    if (muxid < 0)
-		{
-		fprintf(stderr,"Xenomai: binding failed: %s.\n",strerror(-muxid));
-		exit(1);
-		}
-
-	    __pse51_muxid = muxid;
-	    break;
-	}
-
     muxid = XENOMAI_SYSBIND(RTDM_SKIN_MAGIC,
 			    XENOMAI_FEAT_DEP,
 			    XENOMAI_ABI_REV,
@@ -113,11 +50,4 @@
                                                          __rtdm_fdcount);
         }
 
-    /* Install a SIGXCPU handler to intercept alerts about unlocked
-       process memory. */
-
-    sa.sa_handler = &__handle_lock_alert;
-    sigemptyset(&sa.sa_mask);
-    sa.sa_flags = 0;
-    sigaction(SIGXCPU,&sa,NULL);
 }
Index: src/skins/posix/thread.c
===================================================================
--- src/skins/posix/thread.c	(revision 941)
+++ src/skins/posix/thread.c	(working copy)
@@ -19,10 +19,10 @@
 #include <stddef.h>
 #include <errno.h>
 #include <signal.h>
-#include <posix/syscall.h>
 #include <pthread.h>
 #include <semaphore.h>
 #include <nucleus/thread.h>
+#include <posix/syscall.h>
 
 extern int __pse51_muxid;
 
@@ -202,7 +202,7 @@
 int pthread_set_mode_np (int clrmask,
 			 int setmask)
 {
-    extern int __pse51_sigxcpu_no_mlock;
+    extern int xeno_sigxcpu_no_mlock;
     pthread_t tid = pthread_self();
     int err;
 
@@ -217,8 +217,8 @@
        locked, otherwise we would have caught the latter signal upon
        thread creation. */
 
-    if (!err && __pse51_sigxcpu_no_mlock)
-	__pse51_sigxcpu_no_mlock = !(setmask & PTHREAD_WARNSW);
+    if (!err && xeno_sigxcpu_no_mlock)
+	xeno_sigxcpu_no_mlock = !(setmask & PTHREAD_WARNSW);
 
     return err;
 }
Index: src/skins/vxworks/init.c
===================================================================
--- src/skins/vxworks/init.c	(revision 941)
+++ src/skins/vxworks/init.c	(working copy)
@@ -22,20 +22,13 @@
 #include <string.h>
 #include <stdlib.h>
 #include <pthread.h>
+#include <nucleus/skin_init.h>
 #include <vxworks/vxworks.h>
 
 pthread_key_t __vxworks_tskey;
 
 int __vxworks_muxid = -1;
 
-void __handle_lock_alert (int sig)
-
-{
-    fprintf(stderr,"Xenomai: process memory not locked (missing mlockall?)\n");
-    fflush(stderr);
-    exit(4);
-}
-
 static void __flush_tsd (void *tsd)
 
 {
@@ -46,62 +39,15 @@
 static __attribute__((constructor)) void __init_xeno_interface(void)
 
 {
-    struct sigaction sa;
-    xnfeatinfo_t finfo;
-    int muxid;
-
-    muxid = XENOMAI_SYSBIND(VXWORKS_SKIN_MAGIC,
-			    XENOMAI_FEAT_DEP,
-			    XENOMAI_ABI_REV,
-			    &finfo);
-    switch (muxid)
-	{
-	case -EINVAL:
-
-	    fprintf(stderr,"Xenomai: incompatible feature set\n");
-	    fprintf(stderr,"(required=\"%s\", present=\"%s\", missing=\"%s\").\n",
-		    finfo.feat_man_s,finfo.feat_all_s,finfo.feat_mis_s);
-	    exit(1);
-
-	case -ENOEXEC:
-
-	    fprintf(stderr,"Xenomai: incompatible ABI revision level\n");
-	    fprintf(stderr,"(needed=%lu, current=%lu).\n",
-		    XENOMAI_ABI_REV,finfo.abirev);
-	    exit(1);
-
-	case -ENOSYS:
-	case -ESRCH:
-
-	    fprintf(stderr,"Xenomai: VxWorks skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
-	    fprintf(stderr,"(modprobe xeno_vxworks?)\n");
-	    exit(1);
-
-	default:
-
-	    if (muxid < 0)
-		{
-		fprintf(stderr,"Xenomai: binding failed: %s.\n",strerror(-muxid));
-		exit(1);
-		}
-
-	    /* Allocate a TSD key for indexing self task pointers. */
-
-	    if (pthread_key_create(&__vxworks_tskey,&__flush_tsd) != 0)
-		{
-		fprintf(stderr,"Xenomai: failed to allocate new TSD key?!\n");
-		exit(1);
-		}
-
-	    __vxworks_muxid = muxid;
-	    break;
-	}
-
-    /* Install a SIGXCPU handler to intercept alerts about unlocked
-       process memory. */
-
-    sa.sa_handler = &__handle_lock_alert;
-    sigemptyset(&sa.sa_mask);
-    sa.sa_flags = 0;
-    sigaction(SIGXCPU,&sa,NULL);
+    __vxworks_muxid = xeno_user_skin_init(VXWORKS_SKIN_MAGIC,
+                                          "VxWorks",
+                                          "xeno_vxworks");
+    
+    /* Allocate a TSD key for indexing self task pointers. */
+    
+    if (pthread_key_create(&__vxworks_tskey,&__flush_tsd) != 0)
+        {
+        fprintf(stderr,"Xenomai: failed to allocate new TSD key?!\n");
+        exit(1);
+        }
 }
Index: src/skins/vrtx/init.c
===================================================================
--- src/skins/vrtx/init.c	(revision 941)
+++ src/skins/vrtx/init.c	(working copy)
@@ -22,20 +22,13 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <pthread.h>
+#include <nucleus/skin_init.h>
 #include <vrtx/vrtx.h>
 
 pthread_key_t __vrtx_tskey;
 
 int __vrtx_muxid = -1;
 
-void __handle_lock_alert (int sig)
-
-{
-    fprintf(stderr,"Xenomai: process memory not locked (missing mlockall?)\n");
-    fflush(stderr);
-    exit(4);
-}
-
 static void __flush_tsd (void *tsd)
 
 {
@@ -46,69 +39,25 @@
 static __attribute__((constructor)) void __init_xeno_interface(void)
 
 {
-    struct sigaction sa;
-    xnfeatinfo_t finfo;
-    int muxid;
     TCB *tcb;
 
-    muxid = XENOMAI_SYSBIND(VRTX_SKIN_MAGIC,
-			    XENOMAI_FEAT_DEP,
-			    XENOMAI_ABI_REV,
-			    &finfo);
-    switch (muxid)
-	{
-	case -EINVAL:
+    __vrtx_muxid = xeno_user_skin_init(VRTX_SKIN_MAGIC, "VRTX", "xeno_vrtx");
+    
+    /* Allocate a TSD key for indexing self task pointers. */
 
-	    fprintf(stderr,"Xenomai: incompatible feature set\n");
-	    fprintf(stderr,"(required=\"%s\", present=\"%s\", missing=\"%s\").\n",
-		    finfo.feat_man_s,finfo.feat_all_s,finfo.feat_mis_s);
-	    exit(1);
+    if (pthread_key_create(&__vrtx_tskey,&__flush_tsd) != 0)
+        {
+        fprintf(stderr,"Xenomai: failed to allocate new TSD key?!\n");
+        exit(1);
+        }
 
-	case -ENOEXEC:
-
-	    fprintf(stderr,"Xenomai: incompatible ABI revision level\n");
-	    fprintf(stderr,"(needed=%lu, current=%lu).\n",
-		    XENOMAI_ABI_REV,finfo.abirev);
-	    exit(1);
-
-	case -ENOSYS:
-	case -ESRCH:
-
-	    fprintf(stderr,"Xenomai: VRTX skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
-	    fprintf(stderr,"(modprobe xeno_vrtx?)\n");
-	    exit(1);
-
-	default:
-
-	    if (muxid < 0)
-		{
-		fprintf(stderr,"Xenomai: binding failed: %s.\n",strerror(-muxid));
-		exit(1);
-		}
-
-	    /* Allocate a TSD key for indexing self task pointers. */
-
-	    if (pthread_key_create(&__vrtx_tskey,&__flush_tsd) != 0)
-		{
-		fprintf(stderr,"Xenomai: failed to allocate new TSD key?!\n");
-		exit(1);
-		}
-
-	    tcb = (TCB *)malloc(sizeof(*tcb));
-
-	    if (!tcb)
-		{
-		fprintf(stderr,"Xenomai: failed to allocate local TCB?!\n");
-		exit(1);
-		}
-
-	    pthread_setspecific(__vrtx_tskey,tcb);
-	    __vrtx_muxid = muxid;
-	    break;
-	}
-
-    sa.sa_handler = &__handle_lock_alert;
-    sigemptyset(&sa.sa_mask);
-    sa.sa_flags = 0;
-    sigaction(SIGXCPU,&sa,NULL);
+    tcb = (TCB *)malloc(sizeof(*tcb));
+    
+    if (!tcb)
+        {
+        fprintf(stderr,"Xenomai: failed to allocate local TCB?!\n");
+        exit(1);
+        }
+    
+    pthread_setspecific(__vrtx_tskey,tcb);
 }
Index: src/skins/native/init.c
===================================================================
--- src/skins/native/init.c	(revision 941)
+++ src/skins/native/init.c	(working copy)
@@ -22,6 +22,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <pthread.h>
+#include <nucleus/skin_init.h>
 #include <native/syscall.h>
 #include <native/task.h>
 
@@ -29,32 +30,6 @@
 
 int __native_muxid = -1;
 
-int __native_sigxcpu_no_mlock = 1;
-
-void __handle_lock_alert (int sig)
-
-{
-    struct sigaction sa;
-
-    if (__native_sigxcpu_no_mlock)
-	{
-	fprintf(stderr,"Xenomai: process memory not locked (missing mlockall?)\n");
-	fflush(stderr);
-	exit(4);
-	}
-    else
-	{
-	/* T_WARNSW was set for the task but no user-defined handler
-	   has been set to override our internal handler, so let's
-	   invoke the default signal action. */
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = 0;
-	sigaction(SIGXCPU,&sa,NULL);
-	pthread_kill(pthread_self(),SIGXCPU);
-	}
-}
-
 static void __flush_tsd (void *tsd)
 
 {
@@ -65,62 +40,13 @@
 static __attribute__((constructor)) void __init_xeno_interface(void)
 
 {
-    struct sigaction sa;
-    xnfeatinfo_t finfo;
-    int muxid;
+    __native_muxid = xeno_user_skin_init(XENO_SKIN_MAGIC,"native","xeno_native");
+    
+    /* Allocate a TSD key for indexing self task pointers. */
 
-    muxid = XENOMAI_SYSBIND(XENO_SKIN_MAGIC,
-			    XENOMAI_FEAT_DEP,
-			    XENOMAI_ABI_REV,
-			    &finfo);
-    switch (muxid)
-	{
-	case -EINVAL:
-
-	    fprintf(stderr,"Xenomai: incompatible feature set\n");
-	    fprintf(stderr,"(required=\"%s\", present=\"%s\", missing=\"%s\").\n",
-		    finfo.feat_man_s,finfo.feat_all_s,finfo.feat_mis_s);
-	    exit(1);
-
-	case -ENOEXEC:
-
-	    fprintf(stderr,"Xenomai: incompatible ABI revision level\n");
-	    fprintf(stderr,"(needed=%lu, current=%lu).\n",
-		    XENOMAI_ABI_REV,finfo.abirev);
-	    exit(1);
-
-	case -ENOSYS:
-	case -ESRCH:
-
-	    fprintf(stderr,"Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
-	    fprintf(stderr,"(modprobe xeno_native?)\n");
-	    exit(1);
-
-	default:
-
-	    if (muxid < 0)
-		{
-		fprintf(stderr,"Xenomai: binding failed: %s.\n",strerror(-muxid));
-		exit(1);
-		}
-
-	    /* Allocate a TSD key for indexing self task pointers. */
-
-	    if (pthread_key_create(&__native_tskey,&__flush_tsd) != 0)
-		{
-		fprintf(stderr,"Xenomai: failed to allocate new TSD key?!\n");
-		exit(1);
-		}
-
-	    __native_muxid = muxid;
-	    break;
-	}
-
-    /* Install a SIGXCPU handler to intercept alerts about unlocked
-       process memory. */
-
-    sa.sa_handler = &__handle_lock_alert;
-    sigemptyset(&sa.sa_mask);
-    sa.sa_flags = 0;
-    sigaction(SIGXCPU,&sa,NULL);
+    if (pthread_key_create(&__native_tskey,&__flush_tsd) != 0)
+        {
+        fprintf(stderr,"Xenomai: failed to allocate new TSD key?!\n");
+        exit(1);
+        }    
 }
Index: src/skins/native/task.c
===================================================================
--- src/skins/native/task.c	(revision 941)
+++ src/skins/native/task.c	(working copy)
@@ -311,7 +311,7 @@
 		      int setmask,
 		      int *oldmode)
 {
-    extern int __native_sigxcpu_no_mlock;
+    extern int xeno_sigxcpu_no_mlock;
     int err;
 
     err = XENOMAI_SKINCALL3(__native_muxid,
@@ -325,8 +325,8 @@
        locked, otherwise we would have caught the latter signal upon
        thread creation. */
 
-    if (!err && __native_sigxcpu_no_mlock)
-	__native_sigxcpu_no_mlock = !(setmask & T_WARNSW);
+    if (!err && xeno_sigxcpu_no_mlock)
+	xeno_sigxcpu_no_mlock = !(setmask & T_WARNSW);
 
     return err;
 }
Index: src/skins/rtdm/init.c
===================================================================
--- src/skins/rtdm/init.c	(revision 941)
+++ src/skins/rtdm/init.c	(working copy)
@@ -30,6 +30,10 @@
     xnfeatinfo_t finfo;
     int muxid;
 
+#ifdef xeno_arch_features_check
+    xeno_arch_features_check();
+#endif /* xeno_arch_features_check */
+
     muxid = XENOMAI_SYSBIND(RTDM_SKIN_MAGIC,
 			    XENOMAI_FEAT_DEP,
 			    XENOMAI_ABI_REV,
Index: src/skins/uvm/init.c
===================================================================
--- src/skins/uvm/init.c	(revision 941)
+++ src/skins/uvm/init.c	(working copy)
@@ -20,6 +20,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <nucleus/skin_init.h>
 #include <asm-uvm/syscall.h>
 
 int __uvm_muxid = -1;
@@ -29,46 +30,7 @@
 static __attribute__((constructor)) void __init_uvm_interface(void)
 
 {
-    xnfeatinfo_t finfo;
-    int muxid;
+    __uvm_muxid = xeno_user_skin_init(UVM_SKIN_MAGIC, "UVM", "xeno_uvm");
 
-    muxid = XENOMAI_SYSBIND(UVM_SKIN_MAGIC,
-			    XENOMAI_FEAT_DEP,
-			    XENOMAI_ABI_REV,
-			    &finfo);
-    switch (muxid)
-	{
-	case -EINVAL:
-
-	    fprintf(stderr,"Xenomai: incompatible feature set\n");
-	    fprintf(stderr,"(required=\"%s\", present=\"%s\", missing=\"%s\").\n",
-		    finfo.feat_man_s,finfo.feat_all_s,finfo.feat_mis_s);
-	    exit(1);
-
-	case -ENOEXEC:
-
-	    fprintf(stderr,"Xenomai: incompatible ABI revision level\n");
-	    fprintf(stderr,"(needed=%lu, current=%lu).\n",
-		    XENOMAI_ABI_REV,finfo.abirev);
-	    exit(1);
-
-	case -ENOSYS:
-	case -ESRCH:
-
-	    fprintf(stderr,"Xenomai: UVM skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
-	    fprintf(stderr,"(modprobe xeno_uvm?)\n");
-	    exit(1);
-
-	default:
-
-	    if (muxid < 0)
-		{
-		fprintf(stderr,"Xenomai: binding failed: %s.\n",strerror(-muxid));
-		exit(1);
-		}
-
-	    XENOMAI_SYSCALL2(__xn_sys_info,muxid,&__uvm_info);
-	    __uvm_muxid = muxid;
-	    break;
-	}
+    XENOMAI_SYSCALL2(__xn_sys_info,__uvm_muxid,&__uvm_info);
 }
--- /dev/null	2006-04-16 14:39:13.372574250 +0200
+++ include/nucleus/skin_init.h	2006-04-18 18:43:46.000000000 +0200
@@ -0,0 +1,94 @@
+#ifndef _XENO_NUCLEUS_SKIN_INIT_H
+#define _XENO_NUCLEUS_SKIN_INIT_H
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <pthread.h>
+#include <asm/xenomai/syscall.h>
+
+__attribute__((weak)) int xeno_sigxcpu_no_mlock = 1;
+
+static void  xeno_handle_mlock_alert (int sig)
+
+{
+    if (xeno_sigxcpu_no_mlock)
+        {
+        fprintf(stderr,"Xenomai: process memory not locked (missing mlockall?)\n");
+        fflush(stderr);
+        exit(4);
+        }
+    else
+	{
+	/* XNTRAPSW was set for the thread but no user-defined
+	   handler has been set to override our internal handler, so
+	   let's invoke the default signal action. */
+        struct sigaction sa;
+
+	sa.sa_handler = SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = 0;
+	sigaction(SIGXCPU,&sa,NULL);
+	pthread_kill(pthread_self(),SIGXCPU);
+	}
+}
+
+static inline int
+xeno_user_skin_init(unsigned skin_magic, const char *skin, const char *module)
+{
+    struct sigaction sa;
+    xnfeatinfo_t finfo;
+    int muxid;
+
+#ifdef xeno_arch_features_check
+    xeno_arch_features_check();
+#endif /* xeno_arch_features_check */
+    
+    muxid = XENOMAI_SYSBIND(skin_magic,
+			    XENOMAI_FEAT_DEP,
+			    XENOMAI_ABI_REV,
+			    &finfo);
+    switch (muxid)
+	{
+	case -EINVAL:
+
+	    fprintf(stderr,"Xenomai: incompatible feature set\n");
+	    fprintf(stderr,"(required=\"%s\", present=\"%s\", missing=\"%s\").\n",
+		    finfo.feat_man_s,finfo.feat_all_s,finfo.feat_mis_s);
+	    exit(1);
+
+	case -ENOEXEC:
+
+	    fprintf(stderr,"Xenomai: incompatible ABI revision level\n");
+	    fprintf(stderr,"(needed=%lu, current=%lu).\n",
+		    XENOMAI_ABI_REV,finfo.abirev);
+	    exit(1);
+
+	case -ENOSYS:
+	case -ESRCH:
+
+	    fprintf(stderr,"Xenomai: %s skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n"
+                    "(modprobe %s?)\n", skin, module);
+	    exit(1);
+        }
+    
+    if (muxid < 0)
+        {
+        fprintf(stderr,"Xenomai: binding failed: %s.\n",strerror(-muxid));
+        exit(1);
+        }
+
+    /* Install a SIGXCPU handler to intercept alerts about unlocked
+       process memory. */
+
+    sa.sa_handler = &xeno_handle_mlock_alert;
+    sigemptyset(&sa.sa_mask);
+    sa.sa_flags = 0;
+    sigaction(SIGXCPU,&sa,NULL);
+
+    return muxid;
+}
+
+#endif /* _XENO_NUCLEUS_SKIN_INIT_H */

--kvdVuWaJC4--

