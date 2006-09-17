Subject: Re: [Xenomai-core] Odd behaviour of vxworks
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <eeevrh$rns$1@domain.hid>
References: <eeevrh$rns$1@domain.hid>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 19:06:27 +0200
Message-Id: <1158512788.4979.38.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Niklaus.Giger@domain.hid
Cc: 0@domain.hid, xenomai@xenomai.org

On Fri, 2006-09-15 at 21:44 +0200, Niklaus Giger wrote:
> Hi
> 
> First I was surprised that a lot of vxworks return -1 unless
> running inside a thread created by taskSpawn, e.g. taskIdSelf
> or taskMCreate return -1.

You likely have obtained those results on top of the direct syscall
interface (i.e. your application being linked against libvxworks.so, and
the latter sending real VxWorks syscalls to the kernel module
xeno_vxworks.ko). This kind of interface is about to replace the UVM
support (available from libvxworks_uvm.so) for all skins in next
releases. In that case, the VxWorks services in question bail out
because the main() context is NOT a real-time one, and thus return ERROR
(-1), and since VxWorks has no conventional return code for "wrong
calling context", the VxWorks skin simply sets errnoOfTask to -EPERM
(-1), which is consistent with all other Xenomai APIs.

When running over the UVM or the simulator, root_thread_init() is
actually a real-time context, and the calls succeed.

Maybe the example is misleading in that respect; the patch below makes
the behaviour constant among all environments:

--- satch.c	(revision 1634)
+++ satch.c	(working copy)
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
  *
- * pSOS and pSOS+ are registered trademarks of Wind River Systems, Inc.
+ * VxWorks is a registered trademark of Wind River Systems, Inc.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -20,6 +20,9 @@
 
 #include <vxworks/vxworks.h>
 
+#define ROOT_TASK_PRI        100
+#define ROOT_STACK_SIZE      16*1024
+
 #define CONSUMER_TASK_PRI    115
 #define CONSUMER_STACK_SIZE  24*1024
 
@@ -45,17 +48,22 @@
 
 int main (int argc, char *argv[])
 {
-    int err;
+    int tid;
 
     mlockall(MCL_CURRENT|MCL_FUTURE);
 
     atexit(&root_thread_exit);
-    err = root_thread_init();
 
-    if (!err)
+    tid = taskSpawn("RootTask",
+		    ROOT_TASK_PRI,
+		    0,
+		    ROOT_STACK_SIZE,
+		    (FUNCPTR)&root_thread_init,
+		    0,0,0,0,0,0,0,0,0,0);
+    if (tid)
 	pause();
 
-    return err;
+    return 1;
 }
 
 #endif /* Native, user-space execution */

-- 
Philippe.



