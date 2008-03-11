MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rEwcacmX9s"
Content-Transfer-Encoding: 7bit
Message-ID: <18391.3778.511531.87742@domain.hid>
Date: Tue, 11 Mar 2008 23:59:14 +0100
In-Reply-To: <47D65A87.3020004@domain.hid>
References: <47D65A87.3020004@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Problems with satch.c under Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>


--rEwcacmX9s
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Wolfgang Grandegger wrote:
 > Hello,
 > 
 > I tried to test the POSIX example program satch.c under Linux 2.4.25 for
 > PPC. I was able to fix a few issues but the module does still not load.
 > I have attached a patch for Xenomai 2.4.2 fixing:
 > 
 > - User-space satch: It was necessary to move time.h and signal.h to the
 >   end of the include block to get it compiled (otherwise clockid_t is
 >   defined, etc.)
 > 
 > - User-space satch: It was necessary to move "#define xnprintf printf"
 >   behind the include block, otherwise the linker complains about missing
 >   symbols. I wonder how this can work with 2.6. And what is the status
 >   of xnprintf?
 > 
 > - Makefile: to avoid a mixup of CFLAG definitions for compiling the
 >   user-space and kernel-space part, I renamed CFLAGS to UCFLAGS etc.
 >   (see patch). Note sure if this is an issue for 2.6 as well.
 > 
 > - Makefile: I added -DPRODUCER to the module build with Linux 2.4.
 > 
 > - I got the module build, but insmod fails with:
 > 
 >   bash-2.05b# insmod satch.o
 >   satch.o: unresolved symbol shm_unlink
 >   satch.o: unresolved symbol ftruncate
 >   satch.o: unresolved symbol shm_open
 >   satch.o: unresolved symbol munmap
 >   satch.o: unresolved symbol mmap
 >   satch.o: unresolved symbol pse51_shm_close
 > 
 >   Any idea why?
 > 
 > Thanks,

Does the following patch improve anything ?

-- 


					    Gilles Chanteperdrix.

--rEwcacmX9s
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-posix-fix-example.diff"
Content-Transfer-Encoding: 7bit

Index: include/posix/sys/mman.h
===================================================================
--- include/posix/sys/mman.h	(revision 3561)
+++ include/posix/sys/mman.h	(working copy)
@@ -21,6 +21,8 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#include <nucleus/xenomai.h>
+
 #ifdef __KERNEL__
 #include <asm/mman.h>
 #endif /* __KERNEL__ */
Index: include/posix/signal.h
===================================================================
--- include/posix/signal.h	(revision 3561)
+++ include/posix/signal.h	(working copy)
@@ -21,6 +21,8 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#include <nucleus/xenomai.h>
+
 #ifdef __KERNEL__
 #include <linux/signal.h>
 
Index: include/posix/time.h
===================================================================
--- include/posix/time.h	(revision 3561)
+++ include/posix/time.h	(working copy)
@@ -21,6 +21,8 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#include <nucleus/xenomai.h>
+
 #ifdef __KERNEL__
 #include <linux/time.h>
 #define DELAYTIMER_MAX UINT_MAX
Index: include/posix/mqueue.h
===================================================================
--- include/posix/mqueue.h	(revision 3561)
+++ include/posix/mqueue.h	(working copy)
@@ -21,6 +21,8 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#include <nucleus/xenomai.h>
+
 #ifdef __KERNEL__
 #include <linux/types.h>
 #include <linux/signal.h>
Index: include/posix/semaphore.h
===================================================================
--- include/posix/semaphore.h	(revision 3561)
+++ include/posix/semaphore.h	(working copy)
@@ -21,6 +21,8 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#include <nucleus/xenomai.h>
+
 #ifdef __KERNEL__
 #include <linux/kernel.h>
 #include <linux/fcntl.h>
Index: include/posix/errno.h
===================================================================
--- include/posix/errno.h	(revision 3561)
+++ include/posix/errno.h	(working copy)
@@ -21,6 +21,8 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#include <nucleus/xenomai.h>
+
 #ifdef __KERNEL__
 #include <linux/errno.h>
 #include <linux/unistd.h>         /* conflicting declaration of errno. */
Index: include/posix/fcntl.h
===================================================================
--- include/posix/fcntl.h	(revision 3561)
+++ include/posix/fcntl.h	(working copy)
@@ -21,6 +21,8 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#include <nucleus/xenomai.h>
+
 #ifdef __KERNEL__
 #include <linux/fcntl.h>
 #endif /* __KERNEL__ */
Index: include/posix/sched.h
===================================================================
--- include/posix/sched.h	(revision 3561)
+++ include/posix/sched.h	(working copy)
@@ -21,6 +21,8 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#include <nucleus/xenomai.h>
+
 #ifdef __KERNEL__
 #include <linux/sched.h>
 #endif /* __KERNEL__ */
Index: include/posix/unistd.h
===================================================================
--- include/posix/unistd.h	(revision 3561)
+++ include/posix/unistd.h	(working copy)
@@ -21,6 +21,8 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#include <nucleus/xenomai.h>
+
 #ifdef __KERNEL__
 #include <linux/types.h>
 #endif /* __KERNEL__ */
Index: examples/posix/Makefile
===================================================================
--- examples/posix/Makefile	(revision 3561)
+++ examples/posix/Makefile	(working copy)
@@ -79,7 +79,7 @@ else
 
 ARCH    ?= $(shell uname -i)
 INCLUDE := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$(KSRC)/include/xenomai/posix
-CFLAGS  += $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH) SUBDIRS=$(PWD) modules) $(INCLUDE)
+CFLAGS  := $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH) SUBDIRS=$(PWD) modules) $(INCLUDE)
 
 all:: $(OBJS)
 

--rEwcacmX9s--

