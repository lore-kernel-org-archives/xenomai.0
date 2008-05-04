From: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Date: Sun, 4 May 2008 17:16:58 +0200
Message-ID: <2220D86D21B55040AB683933DBD97B5A263A38ECEC@FND-MAILB03.VIA.DK>
References: <2220D86D21B55040AB683933DBD97B5A263A38E8E0@domain.hid>
	<2ff1a98a0804290518x59f92346mfdf32c84055a10fe@domain.hid>
	<2220D86D21B55040AB683933DBD97B5A263A38EC01@domain.hid>
	<18457.59929.12465.572294@domain.hid>	<4819F7A6.1010809@domain.hid>
	<2220D86D21B55040AB683933DBD97B5A263A38ECAA@FND-MAILB03.VIA.DK>
	<18460.29528.322066.882640@domain.hid>
In-Reply-To: <18460.29528.322066.882640@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I used yours - this one (we didn't try the other):

Index: include/nucleus/thread.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/thread.h    (revision 3732)
+++ include/nucleus/thread.h    (working copy)
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/intr.h      (revision 3732)
+++ include/nucleus/intr.h      (working copy)
@@ -22,8 +22,6 @@
 #ifndef _XENO_NUCLEUS_INTR_H
 #define _XENO_NUCLEUS_INTR_H

-#include <nucleus/types.h>
-
 /* Possible return values of ISR. */
 #define XN_ISR_NONE     0x1
 #define XN_ISR_HANDLED  0x2
@@ -41,6 +39,7 @@

 #if defined(__KERNEL__) || defined(__XENO_SIM__)

+#include <nucleus/types.h>
 #include <nucleus/stat.h>

 typedef struct xnintr {
Index: src/skins/posix/rtdm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/posix/rtdm.c      (revision 3732)
+++ src/skins/posix/rtdm.c      (working copy)
@@ -18,6 +18,7 @@
  */

 #include <errno.h>
+#include <string.h>
 #include <stdarg.h>
 #include <pthread.h>
 #include <fcntl.h>
Index: src/skins/posix/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/posix/thread.c    (revision 3732)
+++ src/skins/posix/thread.c    (working copy)
@@ -17,6 +17,7 @@
  */

 #include <stddef.h>
+#include <string.h>
 #include <errno.h>
 #include <signal.h>
 #include <unistd.h>
Index: src/skins/posix/clock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/posix/clock.c     (revision 3732)
+++ src/skins/posix/clock.c     (working copy)
@@ -18,6 +18,7 @@

 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 #include <pthread.h>           /* For pthread_setcanceltype. */
 #include <posix/syscall.h>
Index: src/testsuite/cyclic/cyclictest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/cyclic/cyclictest.c   (revision 3732)
+++ src/testsuite/cyclic/cyclictest.c   (working copy)
@@ -35,6 +35,7 @@
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/mman.h>
+#include <nucleus/trace.h>

 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))


Kind regards,
Hans S=F8 and Stephan Korsholm

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: 3. maj 2008 16:15
To: Hans S=F8ndergaard (HSO)
Cc: rpm@xenomai.org; xenomai@xenomai.org
Subject: RE: [Xenomai-help] Xenomai on AT91SAM9260

Hans S=F8ndergaard (HSO) wrote:
 > Hi,
 >
 > The patch worked, and we are now able to compile the userspace libraries=
 as well as the kernel.
 >
 > Thank you very much!

Which patch, the one I sent, or the one Philippe sent ?

--


                                            Gilles.


