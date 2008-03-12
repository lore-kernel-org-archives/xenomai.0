Message-ID: <47D7AEDD.90605@domain.hid>
Date: Wed, 12 Mar 2008 11:22:21 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <47D65A87.3020004@domain.hid>
	<18391.3778.511531.87742@domain.hid>
In-Reply-To: <18391.3778.511531.87742@domain.hid>
Content-Type: multipart/mixed; boundary="------------080406070207010500000205"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------080406070207010500000205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>  > Hello,
>  > 
>  > I tried to test the POSIX example program satch.c under Linux 2.4.25 for
>  > PPC. I was able to fix a few issues but the module does still not load.
>  > I have attached a patch for Xenomai 2.4.2 fixing:
>  > 
>  > - User-space satch: It was necessary to move time.h and signal.h to the
>  >   end of the include block to get it compiled (otherwise clockid_t is
>  >   defined, etc.)
>  > 
>  > - User-space satch: It was necessary to move "#define xnprintf printf"
>  >   behind the include block, otherwise the linker complains about missing
>  >   symbols. I wonder how this can work with 2.6. And what is the status
>  >   of xnprintf?
>  > 
>  > - Makefile: to avoid a mixup of CFLAG definitions for compiling the
>  >   user-space and kernel-space part, I renamed CFLAGS to UCFLAGS etc.
>  >   (see patch). Note sure if this is an issue for 2.6 as well.
>  > 
>  > - Makefile: I added -DPRODUCER to the module build with Linux 2.4.
>  > 
>  > - I got the module build, but insmod fails with:
>  > 
>  >   bash-2.05b# insmod satch.o
>  >   satch.o: unresolved symbol shm_unlink
>  >   satch.o: unresolved symbol ftruncate
>  >   satch.o: unresolved symbol shm_open
>  >   satch.o: unresolved symbol munmap
>  >   satch.o: unresolved symbol mmap
>  >   satch.o: unresolved symbol pse51_shm_close
>  > 
>  >   Any idea why?
>  > 
>  > Thanks,
> 
> Does the following patch improve anything ?

Yes, the order of the include files does not make trouble any more.
Nevertheless, I need the attached patch to fix the remaining problems
with CFLAGS mangling and missing -DPRODUCER.

Thanks,

Wolfgang.

--------------080406070207010500000205
Content-Type: text/x-patch;
 name="xeno-posix-example-make.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-posix-example-make.diff"

Index: xenomai-2.4.2/examples/posix/Makefile
===================================================================
--- xenomai-2.4.2.orig/examples/posix/Makefile
+++ xenomai-2.4.2/examples/posix/Makefile
@@ -35,16 +35,19 @@ endif
 
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
 
@@ -78,7 +81,7 @@ else
 
 ARCH    ?= $(shell uname -i)
 INCLUDE := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$(KSRC)/include/xenomai/posix
-CFLAGS  := $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH) SUBDIRS=$(PWD) modules) $(INCLUDE)
+CFLAGS  := $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH) SUBDIRS=$(PWD) modules) $(INCLUDE) -DPRODUCER
 
 all:: $(OBJS)
 

--------------080406070207010500000205--

