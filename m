From: Lange Norbert <norbert.lange@andritz.com>
Date: Tue, 6 Feb 2018 13:54:44 +0000
Message-ID: <99BAB48E90E86D42AD41F0BCE3225AEB019FBEC0B0@GRZSMS582.andritz.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Patched kernel headers - are they needed afterwards for
 gibc and more?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hello,

A script with patches together a kernel, ipipe and xenomai kernel drivers. =
Result is the packages to install the kernel image.

A buildroot configuration will build the rootfs, without
  * using the identical kernel version (different patch level)
  * using headers that were used for building the kernel.
  * using the kernel .config

Instead, buildroot DL a different Linux kernel version by itself and used t=
hose headers.
I don`t think they are needed outside of glibc, but I am not sure.

Further, buildroot will create a "staging" installation for building furthe=
r tools, including those using Xenomai APIs.

So, is this generally safe or something to avoid. I haven't ran into any is=
sues yet.

Differences in the basic include files (same kernel version) seem to be rat=
her trivial

diff -burN /tmp/header/include/asm-generic/mman-common.h /tmp/patched/usr/i=
nclude/asm-generic/mman-common.h
--- /tmp/header/include/asm-generic/mman-common.h       2018-02-06 14:26:43=
.657405976 +0100
+++ /tmp/patched/usr/include/asm-generic/mman-common.h  2018-02-06 13:43:26=
.000000000 +0100
@@ -19,6 +19,9 @@
 #define MAP_TYPE       0x0f            /* Mask for type of mapping */
 #define MAP_FIXED      0x10            /* Interpret addr exactly */
 #define MAP_ANONYMOUS  0x20            /* don't use a file */
+#ifndef MAP_BRK
+# define MAP_BRK       0
+#endif
 #ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
 # define MAP_UNINITIALIZED 0x4000000   /* For anonymous mmap, memory could=
 be uninitialized */
 #else
diff -burN /tmp/header/include/asm-generic/resource.h /tmp/patched/usr/incl=
ude/asm-generic/resource.h
--- /tmp/header/include/asm-generic/resource.h  2018-02-06 14:26:43.6894062=
77 +0100
+++ /tmp/patched/usr/include/asm-generic/resource.h     2018-02-06 13:43:26=
.000000000 +0100
@@ -57,5 +57,13 @@
 # define RLIM_INFINITY         (~0UL)
 #endif

+/*
+ * Limit the stack by to some sane default: root can always
+ * increase this limit if needed..  8MB seems reasonable.
+ */
+#ifndef _STK_LIM
+# define _STK_LIM              (8*1024*1024)
+#endif
+

 #endif /* _ASM_GENERIC_RESOURCE_H */
diff -burN /tmp/header/include/linux/resource.h /tmp/patched/usr/include/li=
nux/resource.h
--- /tmp/header/include/linux/resource.h        2018-02-06 14:26:46.4334321=
04 +0100
+++ /tmp/patched/usr/include/linux/resource.h   2018-02-06 13:43:28.0000000=
00 +0100
@@ -59,12 +59,6 @@
 #define        PRIO_USER       2

 /*
- * Limit the stack by to some sane default: root can always
- * increase this limit if needed..  8MB seems reasonable.
- */
-#define _STK_LIM       (8*1024*1024)
-
-/*
  * GPG2 wants 64kB of mlocked memory, to make sure pass phrases
  * and other sensitive information are never written to disk.
  */

Kind regards

Norbert Lange
AT-DES
ANDRITZ HYDRO GmbH
Eibesbrunnergasse 20
1120 Wien, Austria
APhone.: +43 50805 56684
. MailTo:norbert.lange@andritz.com
  <http://www.andritz.com>

________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung / Corporati=
on

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

