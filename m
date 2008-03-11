Message-ID: <47D65A87.3020004@domain.hid>
Date: Tue, 11 Mar 2008 11:10:15 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040001030903080601090101"
Subject: [Xenomai-core] Problems with satch.c under Linux 2.4
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
--------------040001030903080601090101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

I tried to test the POSIX example program satch.c under Linux 2.4.25 for
PPC. I was able to fix a few issues but the module does still not load.
I have attached a patch for Xenomai 2.4.2 fixing:

- User-space satch: It was necessary to move time.h and signal.h to the
  end of the include block to get it compiled (otherwise clockid_t is
  defined, etc.)

- User-space satch: It was necessary to move "#define xnprintf printf"
  behind the include block, otherwise the linker complains about missing
  symbols. I wonder how this can work with 2.6. And what is the status
  of xnprintf?

- Makefile: to avoid a mixup of CFLAG definitions for compiling the
  user-space and kernel-space part, I renamed CFLAGS to UCFLAGS etc.
  (see patch). Note sure if this is an issue for 2.6 as well.

- Makefile: I added -DPRODUCER to the module build with Linux 2.4.

- I got the module build, but insmod fails with:

  bash-2.05b# insmod satch.o
  satch.o: unresolved symbol shm_unlink
  satch.o: unresolved symbol ftruncate
  satch.o: unresolved symbol shm_open
  satch.o: unresolved symbol munmap
  satch.o: unresolved symbol mmap
  satch.o: unresolved symbol pse51_shm_close

  Any idea why?

Thanks,

Wolfgang.



--------------040001030903080601090101
Content-Type: text/x-patch;
 name="xenomai-satch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-satch.patch"

+ diff -u xenomai-2.4.2/examples/posix/Makefile.ORIG xenomai-2.4.2/examples/posix/Makefile
--- xenomai-2.4.2/examples/posix/Makefile.ORIG	2007-12-09 11:47:24.000000000 +0100
+++ xenomai-2.4.2/examples/posix/Makefile	2008-03-11 10:51:19.000000000 +0100
@@ -35,16 +35,19 @@
 
 CC=$(shell $(XENOCONFIG) --cc)
 
-CFLAGS=-DCONSUMER $(shell $(XENOCONFIG) --posix-cflags)
+UCFLAGS=-DCONSUMER $(shell $(XENOCONFIG) --posix-cflags)
 
-LDFLAGS=$(shell $(XENOCONFIG) --posix-ldflags)
+ULDFLAGS=$(shell $(XENOCONFIG) --posix-ldflags)
 
 # This includes the library path of given Xenomai into the binary to make live
 # easier for beginners if Xenomai's libs are not in any default search path.
-LDFLAGS+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)
+ULDFLAGS+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)
 
 all:: $(APPLICATIONS)
 
+$(APPLICATIONS): % : %.c
+	$(CC) $(UCFLAGS) -o $@ $< $(ULDFLAGS)
+
 clean::
 	$(RM) $(APPLICATIONS) *.o
 
@@ -56,6 +59,8 @@
 ###### KERNEL MODULE BUILD (no change required normally) ######
 ifneq ($(MODULES),)
 
+CC=$(CROSS_COMPILE)gcc
+
 ### Default to sources of currently running kernel
 KSRC ?= /lib/modules/$(shell uname -r)/build
 
@@ -77,7 +82,7 @@
 else
 
 ARCH    ?= $(shell uname -i)
-INCLUDE := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$(KSRC)/include/xenomai/posix
+INCLUDE := -DPRODUCER -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$(KSRC)/include/xenomai/posix
 CFLAGS  += $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH) SUBDIRS=$(PWD) modules) $(INCLUDE)
 
 all:: $(OBJS)
+ diff -u xenomai-2.4.2/examples/posix/satch.c.ORIG xenomai-2.4.2/examples/posix/satch.c
--- xenomai-2.4.2/examples/posix/satch.c.ORIG	2007-12-09 11:47:24.000000000 +0100
+++ xenomai-2.4.2/examples/posix/satch.c	2008-03-11 10:04:54.000000000 +0100
@@ -1,16 +1,18 @@
 #ifndef __XENO_SIM__
 #ifndef __KERNEL__
 #include <stdio.h>
-#define xnprintf printf
 #endif
-
-#include <time.h>
 #include <errno.h>
 #include <unistd.h>
-#include <signal.h>
 #include <sys/mman.h>
 #include <pthread.h>
 #include <mqueue.h>
+#include <signal.h>
+#include <time.h>
+#ifndef __KERNEL__
+#undef xnprintf
+#define xnprintf printf
+#endif
 #else /* __XENO_SIM */
 #include <posix/posix.h>
 #endif /* __XENO_SIM */

--------------040001030903080601090101--

