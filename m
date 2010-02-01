From: Sinisa Denic <sinisa.denic@domain.hid>
Date: Mon, 1 Feb 2010 15:32:30 +0100
References: <fd55ced7db48fe30f8139df895fb9d4c.squirrel@domain.hid>
	<201002011232.30431.sinisa.denic@domain.hid>
	<4B66D203.7000309@domain.hid>
In-Reply-To: <4B66D203.7000309@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/XuZLPhpy/NUgMc"
Message-Id: <201002011532.31310.sinisa.denic@domain.hid>
Subject: Re: [Xenomai-help] xenomai 2.5.0 uclibc 0.30 compatibility?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org.

--Boundary-00=_/XuZLPhpy/NUgMc
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 01 February 2010 14:07:15 Gilles Chanteperdrix wrote:
> Sinisa Denic wrote:
> > On Sunday 31 January 2010 11:31:28 Gilles Chanteperdrix wrote:
> >> This is bad news, the problem is that uclibc's stdio.h needs pthread.h,
> >> which because of the -I flags we pass is xenomai's pthread.h, which
> >> includes asm/syscall.h, which needs stdio.h.
> >
> > Same thing,
> > I can't figure out which file to include in pthread.h
> > posix/init.c - same error
> > include/asm-arm/xenomai/syscall.h - produce error from start building
> > rtdm ...
>
> In every .c file where you get the error, you should try and include
> pthread.h before anything else.


Ok, now I've got it built. In attach there is a patch, maybe usefull to 
someone.

Thank you Gilles, greetings from Belgrade.

--Boundary-00=_/XuZLPhpy/NUgMc
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="uclibc-0.30_xenomai-2.5.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uclibc-0.30_xenomai-2.5.0.patch"

diff --git a/src/skins/posix/clock.c b/src/skins/posix/clock.c
index 98595d4..5c06671 100644
--- a/src/skins/posix/clock.c
+++ b/src/skins/posix/clock.c
@@ -15,12 +15,11 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
-
+#include <pthread.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
-#include <pthread.h>		/* For pthread_setcanceltype. */
 #include <posix/syscall.h>
 #include <time.h>
 #include <asm-generic/xenomai/bits/timeconv.h>
diff --git a/src/skins/posix/init.c b/src/skins/posix/init.c
index 6028dd9..8301495 100644
--- a/src/skins/posix/init.c
+++ b/src/skins/posix/init.c
@@ -15,7 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
-
+#include <pthread.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/testsuite/irqbench/irqloop.c b/src/testsuite/irqbench/irqloop.c
index e97123f..6999e9e 100644
--- a/src/testsuite/irqbench/irqloop.c
+++ b/src/testsuite/irqbench/irqloop.c
@@ -16,11 +16,11 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#include <pthread.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
 #include <string.h>
-#include <pthread.h>
 #include <unistd.h>
 #include <limits.h>
 #include <sys/mman.h>
diff --git a/src/testsuite/sigtest/sigtest.c b/src/testsuite/sigtest/sigtest.c
index 628d573..5b24379 100644
--- a/src/testsuite/sigtest/sigtest.c
+++ b/src/testsuite/sigtest/sigtest.c
@@ -1,3 +1,4 @@
+#include <pthread.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
diff --git a/src/testsuite/switchtest/switchtest.c b/src/testsuite/switchtest/switchtest.c
index 66d0eab..20d8979 100644
--- a/src/testsuite/switchtest/switchtest.c
+++ b/src/testsuite/switchtest/switchtest.c
@@ -1,4 +1,5 @@
 #include <ctype.h>
+#include <pthread.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -8,7 +9,6 @@
 #include <sched.h>
 #include <signal.h>
 #include <unistd.h>
-#include <pthread.h>
 #include <sys/mman.h>
 #include <semaphore.h>
 #include <setjmp.h>
diff --git a/src/testsuite/unit/mutex-torture.c b/src/testsuite/unit/mutex-torture.c
index 70bda14..671b2dd 100644
--- a/src/testsuite/unit/mutex-torture.c
+++ b/src/testsuite/unit/mutex-torture.c
@@ -8,6 +8,7 @@
  * Released under the terms of GPLv2.
  */
 
+#include <pthread.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
@@ -15,7 +16,6 @@
 #include <errno.h>
 #include <stdarg.h>
 #include <sys/mman.h>
-#include <pthread.h>
 #include <native/timer.h>
 
 #ifndef XENO_POSIX

--Boundary-00=_/XuZLPhpy/NUgMc--

