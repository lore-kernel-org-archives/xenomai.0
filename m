MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gZBPKLq8pN"
Content-Transfer-Encoding: 7bit
Message-ID: <18457.62989.876794.339734@domain.hid>
Date: Thu, 1 May 2008 18:55:41 +0200
In-Reply-To: <2220D86D21B55040AB683933DBD97B5A263A38EC01@domain.hid>
References: <2220D86D21B55040AB683933DBD97B5A263A38E8E0@domain.hid>
	<2ff1a98a0804290518x59f92346mfdf32c84055a10fe@domain.hid>
	<2220D86D21B55040AB683933DBD97B5A263A38EC01@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Xenomai on AT91SAM9260
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


--gZBPKLq8pN
Content-Type: text/plain; charset="iso-8859-1"
Content-Description: message body and .signature
Content-Transfer-Encoding: quoted-printable

Hans S=F8ndergaard (HSO) wrote:
 >                  from ../../../../xenomai-2.4.3/src/skins/posix/init.c:2=
0:
 > ../../../src/include/asm/xenomai/syscall.h: In function 'xeno_arm_featur=
es_check
 > ':
 > ../../../src/include/asm/xenomai/syscall.h:295: error: 'stderr' undeclar=
ed (firs
 > t use in this function)
 > ../../../src/include/asm/xenomai/syscall.h:295: error: (Each undeclared =
identifi
 > er is reported only once
 > ../../../src/include/asm/xenomai/syscall.h:295: error: for each function=
 it appe
 > ars in.)
 >=20
 > Obviously there is something wrong with the include path used:
 > uClibc_mutex.h should not include 'pthread.h' in the Xenomai
 > distribution but rather the version in uClibc itself.
 >=20
 > Why this happens I'm trying to discover.
 >=20
 > The complete configure I'm using is:
 >=20
 > ../xenomai-2.4.3/configure --build=3Di686-pc-linux-gnu --host=3Darm-linu=
x-uclibc --enable-arm-mach=3Dat91sam926x --enable-arm-tsc

The way I see it, the problem is that posix/pthread.h includes
nucleus/thread.h and nucleus/intr.h to get a few constants
definitions. And since these include files include other include files,
we end up with the whole stack of xenomai includes. So, I propose the
following patch which basically stop including other include files in
nucleus/thread.h and nucleus/intr.h when included from user-space. The
only downside of this solution is that application like cyclictest who
want to use the I-pipe tracer now need to include explicitely
nucleus/trace.h.

--=20


					    Gilles.

--gZBPKLq8pN
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-fix-uclibc-includes.diff"
Content-Transfer-Encoding: 7bit

Index: include/nucleus/thread.h
===================================================================
--- include/nucleus/thread.h	(revision 3732)
+++ include/nucleus/thread.h	(working copy)
@@ -22,8 +22,6 @@
 #ifndef _XENO_NUCLEUS_THREAD_H
 #define _XENO_NUCLEUS_THREAD_H
 
-#include <nucleus/timer.h>
-
 /*! @ingroup nucleus 
   @defgroup nucleus_state_flags Thread state flags.
   @brief Bits reporting permanent or transient states of thread.
@@ -130,6 +128,7 @@
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
 #include <nucleus/stat.h>
+#include <nucleus/timer.h>
 
 #ifdef __XENO_SIM__
 /* Pseudo-status (must not conflict with other bits) */
Index: include/nucleus/intr.h
===================================================================
--- include/nucleus/intr.h	(revision 3732)
+++ include/nucleus/intr.h	(working copy)
@@ -22,8 +22,6 @@
 #ifndef _XENO_NUCLEUS_INTR_H
 #define _XENO_NUCLEUS_INTR_H
 
-#include <nucleus/types.h>
-
 /* Possible return values of ISR. */
 #define XN_ISR_NONE   	 0x1
 #define XN_ISR_HANDLED	 0x2
@@ -41,6 +39,7 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#include <nucleus/types.h>
 #include <nucleus/stat.h>
 
 typedef struct xnintr {
Index: src/skins/posix/rtdm.c
===================================================================
--- src/skins/posix/rtdm.c	(revision 3732)
+++ src/skins/posix/rtdm.c	(working copy)
@@ -18,6 +18,7 @@
  */
 
 #include <errno.h>
+#include <string.h>
 #include <stdarg.h>
 #include <pthread.h>
 #include <fcntl.h>
Index: src/skins/posix/thread.c
===================================================================
--- src/skins/posix/thread.c	(revision 3732)
+++ src/skins/posix/thread.c	(working copy)
@@ -17,6 +17,7 @@
  */
 
 #include <stddef.h>
+#include <string.h>
 #include <errno.h>
 #include <signal.h>
 #include <unistd.h>
Index: src/skins/posix/clock.c
===================================================================
--- src/skins/posix/clock.c	(revision 3732)
+++ src/skins/posix/clock.c	(working copy)
@@ -18,6 +18,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 #include <pthread.h>		/* For pthread_setcanceltype. */
 #include <posix/syscall.h>
Index: src/testsuite/cyclic/cyclictest.c
===================================================================
--- src/testsuite/cyclic/cyclictest.c	(revision 3732)
+++ src/testsuite/cyclic/cyclictest.c	(working copy)
@@ -35,6 +35,7 @@
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/mman.h>
+#include <nucleus/trace.h>
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 

--gZBPKLq8pN--

