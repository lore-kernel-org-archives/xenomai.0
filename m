Message-ID: <464D7993.6010008@domain.hid>
Date: Fri, 18 May 2007 12:01:55 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020605070900010909060009"
Subject: [Xenomai-core] [PATCH] fix some src compile problems
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
--------------020605070900010909060009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I needed the attached patch to get the user space stuff of Xenomai 
trunk, head of SVN cross compiled for PPC. Please apply. Thanks.

Wolfgang.

--------------020605070900010909060009
Content-Type: text/x-patch;
 name="xenomai-src.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-src.patch"

Index: src/skins/posix/clock.c
===================================================================
--- src/skins/posix/clock.c	(revision 2455)
+++ src/skins/posix/clock.c	(working copy)
@@ -16,6 +16,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <stdio.h>
+#include <stdlib.h>
 #include <errno.h>
 #include <pthread.h>		/* For pthread_setcanceltype. */
 #include <posix/syscall.h>
Index: src/skins/native/timer.c
===================================================================
--- src/skins/native/timer.c	(revision 2455)
+++ src/skins/native/timer.c	(working copy)
@@ -16,6 +16,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <stdio.h>
+#include <stdlib.h>
 #include <native/syscall.h>
 #include <native/timer.h>
 #include <asm/xenomai/arith.h>
Index: src/testsuite/clocktest/clocktest.c
===================================================================
--- src/testsuite/clocktest/clocktest.c	(revision 2455)
+++ src/testsuite/clocktest/clocktest.c	(working copy)
@@ -160,7 +160,7 @@ int main(int argc, char *argv[])
 {
     int cpus = sysconf(_SC_NPROCESSORS_ONLN);
     int i;
-    char c;
+    int c;
 
     while ((c = getopt(argc,argv,"C:T:")) != EOF)
         switch (c) {

--------------020605070900010909060009--

