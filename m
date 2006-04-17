MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="di+EuMIYHQ"
Content-Transfer-Encoding: 7bit
Message-ID: <17475.52364.531989.131060@domain.hid>
Date: Mon, 17 Apr 2006 19:12:44 +0200
Subject: Re: [Xenomai-help] Problems running testsuite
In-Reply-To: <444289D4.3020700@domain.hid>
References: <200604131149.40706.tmarscha@domain.hid>
	<443E9FD2.6070807@domain.hid>
	<200604141342.40129.tmarscha@domain.hid>
	<17471.38482.617361.14216@domain.hid>
	<443FB0BA.5060404@domain.hid> <44427E26.6040608@domain.hid>
	<17474.34228.663482.766745@domain.hid>
	<444289D4.3020700@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--di+EuMIYHQ
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
 > Looks good. Additionally, we might end up moving common portions of the 
 > various library constructors into a single file in order to reduce code 
 > duplication.

The attached patch tries to do that. The single file is named
include/nucleus/skin_init.h. 

-- 


					    Gilles Chanteperdrix.

--di+EuMIYHQ
Content-Type: text/plain
Content-Disposition: inline;
	filename="skin-init.patch"
Content-Transfer-Encoding: 7bit

Index: include/asm-generic/syscall.h
===================================================================
--- include/asm-generic/syscall.h	(revision 940)
+++ include/asm-generic/syscall.h	(working copy)
@@ -112,7 +112,7 @@
 #include <sys/types.h>
 #include <asm/xenomai/features.h>
 
-#endif /* __KERNEL__ */
+#endif /* !__KERNEL__ */
 
 typedef struct xncompletion {
 
Index: include/asm-i386/features.h
===================================================================
--- include/asm-i386/features.h	(revision 940)
+++ include/asm-i386/features.h	(working copy)
@@ -76,4 +76,35 @@
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
+      char *buf = malloc(n);
+      int isnptl;
+      
+      confstr (_CS_GNU_LIBPTHREAD_VERSION, buf, n);
+      isnptl = strstr (buf, "NPTL");
+      free(buf);
+
+      if (isnptl)
+          return;
+      }
+
+  fprintf(stderr, "Xenomai: SEP instruction needs NPTL and NPTL was not detected"
+          "\nplease install NPTL or recompile Xenomai without enabling SEP.\n");
+  exit(1);
+#endif /* CONFIG_XENO_X86_SEP */
+}
+#define xeno_arch_features_check() xeno_x86_features_check()
+#endif /* __KERNEL__ */
+
 #endif /* !_XENO_ASM_I386_FEATURES_H */
Index: include/nucleus/Makefile.am
===================================================================
--- include/nucleus/Makefile.am	(revision 940)
+++ include/nucleus/Makefile.am	(working copy)
@@ -22,3 +22,5 @@
 	types.h \
 	version.h \
 	xenomai.h
+
+EXTRA_DIST = skin_init.h
Index: src/skins/rtai/init.c
===================================================================
--- src/skins/rtai/init.c	(revision 940)
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
--- src/skins/posix/init.c	(revision 940)
+++ src/skins/posix/init.c	(working copy)
@@ -23,6 +23,7 @@
 #include <limits.h>
 #include <unistd.h>
 #include <sys/types.h>
+#include <nucleus/skin_init.h>
 #include <posix/posix.h>
 #include <posix/syscall.h>
 #include <rtdm/syscall.h>
@@ -31,60 +32,14 @@
 int __rtdm_muxid  = -1;
 int __rtdm_fd_start = INT_MAX;
 
-void __handle_lock_alert (int sig)
-
-{
-    fprintf(stderr,"Xenomai: process memory not locked (missing mlockall?)\n");
-    fflush(stderr);
-    exit(4);
-}
-
 static __attribute__((constructor)) void __init_posix_interface(void)
 
 {
     struct sigaction sa;
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
@@ -96,11 +51,4 @@
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
Index: src/skins/vxworks/init.c
===================================================================
--- src/skins/vxworks/init.c	(revision 940)
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
--- src/skins/vrtx/init.c	(revision 940)
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
--- src/skins/native/init.c	(revision 940)
+++ src/skins/native/init.c	(working copy)
@@ -22,6 +22,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <pthread.h>
+#include <nucleus/skin_init.h>
 #include <native/syscall.h>
 #include <native/task.h>
 
@@ -29,14 +30,6 @@
 
 int __native_muxid = -1;
 
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
@@ -47,62 +40,13 @@
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
Index: src/skins/rtdm/init.c
===================================================================
--- src/skins/rtdm/init.c	(revision 940)
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
--- src/skins/uvm/init.c	(revision 940)
+++ src/skins/uvm/init.c	(working copy)
@@ -20,6 +20,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <nucleus/skin_init.h>
 #include <asm-uvm/syscall.h>
 
 int __uvm_muxid = -1;
@@ -32,43 +33,7 @@
     xnfeatinfo_t finfo;
     int muxid;
 
-    muxid = XENOMAI_SYSBIND(UVM_SKIN_MAGIC,
-			    XENOMAI_FEAT_DEP,
-			    XENOMAI_ABI_REV,
-			    &finfo);
-    switch (muxid)
-	{
-	case -EINVAL:
+    __uvm_muxid = xeno_user_skin_init(UVM_SKIN_MAGIC, "UVM", "xeno_uvm");
 
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
+    XENOMAI_SYSCALL2(__xn_sys_info,muxid,&__uvm_info);
 }
--- /dev/null	2006-04-16 14:39:13.372574250 +0200
+++ include/nucleus/skin_init.h	2006-04-17 19:05:58.000000000 +0200
@@ -0,0 +1,73 @@
+#ifndef _XENO_NUCLEUS_SKIN_INIT_H
+#define _XENO_NUCLEUS_SKIN_INIT_H
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <asm/xenomai/syscall.h>
+
+static void __handle_lock_alert (int sig)
+
+{
+    fprintf(stderr,"Xenomai: process memory not locked (missing mlockall?)\n");
+    fflush(stderr);
+    exit(4);
+}
+
+static int
+xeno_user_skin_init(unsigned skin_magic, const char *skin, const char *module)
+{
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
+    sa.sa_handler = &__handle_lock_alert;
+    sigemptyset(&sa.sa_mask);
+    sa.sa_flags = 0;
+    sigaction(SIGXCPU,&sa,NULL);
+
+    return muxid;
+}
+
+#endif /* _XENO_NUCLEUS_SKIN_INIT_H */

--di+EuMIYHQ--

