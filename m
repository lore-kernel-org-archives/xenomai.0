Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68A3750C4
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221993; cv=none; b=egvahXmeEH6f/SBN2zPvH7WfCLF73cewEzlQbK6gR0GK/FOGV/dfArraocZ/QkAiJwkbr++I9JdEjYKf5X6neTDGvYUm4MJzR+yhM6XS5/0u25vzh/gxFkpw6WMl4USmo6RB/YIpFZ/Ao2BNTe4fd4EiKB3dFuVQTbhxcKKoCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221993; c=relaxed/simple;
	bh=cQBvqE83UnAIacHXRK+fn0Y6VmLN7m1Zd/EPHcQRGFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kbl84d8+bkN0dooLdUoXyBxqMXQ+6hL+UPcn0e0wZoSz9gt7IBdsL+x2ixKOvYKsgkiiXuRLksoecLGBXMECPR7bfxWvuZqChNG2mjCaMmRixq56sDx9dLtCIuoRCx1ZEAA4CswFrDWVn9Aatl+uMPlMiOJBpjpMjBSqmSB7WXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Xjo/2ZHx; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Xjo/2ZHx"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260508062252e6144fd6c7000207b4
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DFScEL5UVBGHaVdKkfLkZXbwXUg7xE/jOUd2h/m8WEM=;
 b=Xjo/2ZHxRsayfJrYa6riyBujrtSVm/q4/HZ6pQvwirHTNPqLyMB2+q2NNs5EihbCLKFxhL
 ynEBzFPRXG65U5i2P+9ENURpzMpCiwb03RNsPOPwLqlKKMJ/UGcX0I19M9a1/KqbBkhka/h7
 Gwtse6jmLE7wRxnypZa5HS8dc0GvrStnFOSng71m8ogOM101OBz++xsMTBX9xXRPZw+AQ/AQ
 L/InAZ+B/oKuQ5jgfH9MEYp0LsRKtKKfj79Vw6Xvn933FfzQR6qQJJ0n537brn+YSIMKxstM
 oAtDYgUA0mh+hv00oR0Vwbv0rRwENp1tyjJP3zXAlAF0G7pE49LljGyg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:40 +0200
Subject: [PATCH 07/32] lib/copperplate: Rearrange includes and harmonize
 license headers
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-7-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving from "local to global" should help us to keep headers
self-contained.

While at it: Harmonzie license headers. doxygen reported a warning
while generating the docs.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/copperplate/clockobj.c        | 15 ++++-------
 lib/copperplate/cluster.c         |  5 +---
 lib/copperplate/eventobj.c        |  6 ++---
 lib/copperplate/heapobj-heapmem.c |  5 +---
 lib/copperplate/heapobj-malloc.c  | 15 +++++------
 lib/copperplate/heapobj-pshared.c | 38 ++++++++++++++--------------
 lib/copperplate/heapobj-tlsf.c    | 15 +++++------
 lib/copperplate/init.c            | 24 ++++++++----------
 lib/copperplate/internal.c        | 19 ++++----------
 lib/copperplate/internal.h        | 12 +--------
 lib/copperplate/reference.c       | 10 ++++----
 lib/copperplate/regd/fs-cobalt.c  | 13 +++++-----
 lib/copperplate/regd/fs-common.c  | 21 ++++++++--------
 lib/copperplate/regd/fs-mercury.c | 16 ++++++------
 lib/copperplate/regd/regd.c       | 36 +++++++++++++-------------
 lib/copperplate/registry.c        | 53 ++++++++++++++++++++-------------------
 lib/copperplate/semobj.c          |  8 ++----
 lib/copperplate/syncobj.c         |  7 ++----
 lib/copperplate/threadobj.c       | 26 +++++--------------
 lib/copperplate/timerobj.c        | 17 +++----------
 lib/copperplate/traceobj.c        |  6 +----
 21 files changed, 150 insertions(+), 217 deletions(-)

diff --git a/lib/copperplate/clockobj.c b/lib/copperplate/clockobj.c
index e605e73b95ca053cf68257b8e43157991412d8c1..85518c5ba42c744bda6080fd4e15af2fcd77ec6c 100644
--- a/lib/copperplate/clockobj.c
+++ b/lib/copperplate/clockobj.c
@@ -10,22 +10,17 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <errno.h>
-#include <stdlib.h>
-#include <fcntl.h>
-#include <assert.h>
-#include <time.h>
-#include <string.h>
-#include "boilerplate/lock.h"
-#include "boilerplate/time.h"
 #include "copperplate/clockobj.h"
-#include "internal.h"
+
+#include <boilerplate/ancillaries.h>
+
+#include <string.h>
 
 #ifdef CONFIG_XENO_LORES_CLOCK_DISABLED
 
diff --git a/lib/copperplate/cluster.c b/lib/copperplate/cluster.c
index 15ea4d36bd8ee18be580258e63688a9298ea6da0..1bcee8e64ac27fd4e8a0817a1e1059f2746d2d8b 100644
--- a/lib/copperplate/cluster.c
+++ b/lib/copperplate/cluster.c
@@ -88,12 +88,9 @@
  * to appear in the dictionary.
  */
 
-#include <errno.h>
-#include <string.h>
-#include "copperplate/heapobj.h"
 #include "copperplate/cluster.h"
+#include "copperplate/heapobj.h"
 #include "copperplate/threadobj.h"
-#include "internal.h"
 
 const static struct hash_operations hash_operations;
 
diff --git a/lib/copperplate/eventobj.c b/lib/copperplate/eventobj.c
index 28b7c167f7a4f7bd21a4a57ba15149bdebb4f58e..d61289e9fa2bcdd087d1b77d86249626aa58bec6 100644
--- a/lib/copperplate/eventobj.c
+++ b/lib/copperplate/eventobj.c
@@ -10,16 +10,14 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <assert.h>
-#include <errno.h>
-#include "copperplate/threadobj.h"
 #include "copperplate/eventobj.h"
+#include "copperplate/threadobj.h"
 
 #ifdef CONFIG_XENO_COBALT
 
diff --git a/lib/copperplate/heapobj-heapmem.c b/lib/copperplate/heapobj-heapmem.c
index 85b83e12f7f45a97f983bf8dbdc5b6d7e8b6dee4..66b8c781e54b6a06e48b2ee9ca8e0cfbcc6ce937 100644
--- a/lib/copperplate/heapobj-heapmem.c
+++ b/lib/copperplate/heapobj-heapmem.c
@@ -10,16 +10,13 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stdlib.h>
-#include "boilerplate/heapmem.h"
 #include "copperplate/heapobj.h"
-#include "xenomai/init.h"
 
 #ifndef CONFIG_XENO_PSHARED
 #include "copperplate/tunables.h"
diff --git a/lib/copperplate/heapobj-malloc.c b/lib/copperplate/heapobj-malloc.c
index cde5672f51c119783e3f8bba5172ebfd2842b353..781d03f6b848858ff2c3ef803adff139cb38db7f 100644
--- a/lib/copperplate/heapobj-malloc.c
+++ b/lib/copperplate/heapobj-malloc.c
@@ -10,21 +10,22 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include "boilerplate/lock.h"
+#include "copperplate/debug.h"
+#include "copperplate/heapobj.h"
+
+#include <assert.h>
 #include <errno.h>
-#include <stdio.h>
-#include <string.h>
 #include <malloc.h>
-#include <assert.h>
 #include <pthread.h>
-#include "boilerplate/lock.h"
-#include "copperplate/heapobj.h"
-#include "copperplate/debug.h"
+#include <stdio.h>
+#include <string.h>
 
 #define MALLOC_MAGIC 0xabbfcddc
 
diff --git a/lib/copperplate/heapobj-pshared.c b/lib/copperplate/heapobj-pshared.c
index 5952d9f9ca6dd4939fb6a8b75f79c39617b13bb7..49021ee8ebfc788c366f1f3307ba838d48285544 100644
--- a/lib/copperplate/heapobj-pshared.c
+++ b/lib/copperplate/heapobj-pshared.c
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -21,30 +21,30 @@
  * multiple processes in user-space.
  */
 
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/file.h>
-#include <sys/stat.h>
-#include <stdbool.h>
+#include "boilerplate/hash.h"
+#include "boilerplate/list.h"
+#include "boilerplate/lock.h"
+#include "copperplate/debug.h"
+#include "copperplate/heapobj.h"
+#include "internal.h"
+#include "xenomai/init.h"
+
 #include <assert.h>
 #include <errno.h>
-#include <stdio.h>
+#include <fcntl.h>
+#include <malloc.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdbool.h>
 #include <stdint.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <pthread.h>
-#include <unistd.h>
-#include <signal.h>
-#include <fcntl.h>
-#include <malloc.h>
+#include <sys/file.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
 #include <unistd.h>
-#include "boilerplate/list.h"
-#include "boilerplate/hash.h"
-#include "boilerplate/lock.h"
-#include "copperplate/heapobj.h"
-#include "copperplate/debug.h"
-#include "xenomai/init.h"
-#include "internal.h"
 
 enum sheapmem_pgtype {
 	page_free =0,
diff --git a/lib/copperplate/heapobj-tlsf.c b/lib/copperplate/heapobj-tlsf.c
index 2d57e3c05e8d51bcac2876bc4df4539ee15b8a7d..1ea3890b7ffd411c6fa9b69e63d35bf96d6fbcc9 100644
--- a/lib/copperplate/heapobj-tlsf.c
+++ b/lib/copperplate/heapobj-tlsf.c
@@ -10,22 +10,23 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <errno.h>
-#include <stdio.h>
-#include <stdint.h>
-#include <unistd.h>
 #include "boilerplate/tlsf/tlsf.h"
-#include "copperplate/heapobj.h"
 #include "copperplate/debug.h"
+#include "copperplate/heapobj.h"
 #include "copperplate/threadobj.h"
-#include "xenomai/init.h"
 #include "internal.h"
+#include "xenomai/init.h"
+
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <unistd.h>
 
 #if LONG_BIT == 32
 #define TLSF_BLOCK_ALIGN  (8 * 2)
diff --git a/lib/copperplate/init.c b/lib/copperplate/init.c
index 01969cfea42bc7d4658367397e3967798399fcc5..72a6afe836005fefca7eb192d09bac462429fcb5 100644
--- a/lib/copperplate/init.c
+++ b/lib/copperplate/init.c
@@ -10,27 +10,25 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <ctype.h>
-#include <pwd.h>
-#include <errno.h>
-#include <getopt.h>
-#include <grp.h>
-
-#include "copperplate/threadobj.h"
 #include "copperplate/registry.h"
+#include "copperplate/threadobj.h"
 #include "copperplate/timerobj.h"
-#include "xenomai/init.h"
 #include "internal.h"
+#include "xenomai/init.h"
+
+#include <copperplate/tunables.h>
+
+#include <ctype.h>
+#include <getopt.h>
+#include <grp.h>
+#include <pwd.h>
+#include <unistd.h>
 
 struct copperplate_setup_data __copperplate_setup_data = {
 	.mem_pool = 1024 * 1024, /* Default, 1Mb. */
diff --git a/lib/copperplate/internal.c b/lib/copperplate/internal.c
index ed3f2e4faefa3fecce66721322472263224b80a0..b248a08289de71fa035b32a17d4a57dd9cecf624 100644
--- a/lib/copperplate/internal.c
+++ b/lib/copperplate/internal.c
@@ -10,27 +10,18 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <sys/types.h>
-#include <sys/prctl.h>
-#include <stdio.h>
-#include <stdarg.h>
-#include <pthread.h>
-#include <unistd.h>
-#include <signal.h>
-#include <errno.h>
-#include <limits.h>
-
-#include <boilerplate/ancillaries.h>
-#include <copperplate/clockobj.h>
-#include <copperplate/threadobj.h>
 #include "internal.h"
 
+#include <copperplate/threadobj.h>
+
+#include <sys/prctl.h>
+
 static int thread_spawn_prologue(struct corethread_attributes *cta);
 
 static int thread_spawn_epilogue(struct corethread_attributes *cta);
diff --git a/lib/copperplate/internal.h b/lib/copperplate/internal.h
index bfd46918086a894c4b71e579d0d28d342d08ff0e..742e893585ebd2ec3407d3c31adf594236262100 100644
--- a/lib/copperplate/internal.h
+++ b/lib/copperplate/internal.h
@@ -15,22 +15,12 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #ifndef _COPPERPLATE_INTERNAL_H
 #define _COPPERPLATE_INTERNAL_H
 
-#include <sys/types.h>
-#include <stdarg.h>
-#include <time.h>
 #include <pthread.h>
 #include <semaphore.h>
-#include <xeno_config.h>
-#include <boilerplate/list.h>
-#include <boilerplate/ancillaries.h>
-#include <boilerplate/limits.h>
-#include <boilerplate/sched.h>
-#include <boilerplate/setup.h>
-#include <copperplate/heapobj.h>
-#include <copperplate/tunables.h>
 
 #ifdef CONFIG_XENO_PSHARED
 
diff --git a/lib/copperplate/reference.c b/lib/copperplate/reference.c
index 09b845e49a0b244fb44e92cc3e1d2f7ea211602f..201347e319b5a2b2520a7b79ca95f5062346fc81 100644
--- a/lib/copperplate/reference.c
+++ b/lib/copperplate/reference.c
@@ -10,19 +10,19 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <assert.h>
-#include <stdio.h>
-#include <string.h>
-#include "boilerplate/hash.h"
 #include "copperplate/reference.h"
+#include "boilerplate/hash.h"
 #include "internal.h"
 
+#include <assert.h>
+#include <string.h>
+
 static int nrefs[MAX_FNLIBS];
 
 struct __fnref __fnrefs[MAX_FNLIBS][MAX_FNREFS] = {
diff --git a/lib/copperplate/regd/fs-cobalt.c b/lib/copperplate/regd/fs-cobalt.c
index b7c10342bfd62fb67a860c63e2626521dc52f6e6..e230d8956c1ae72422bba3fd27a25a4f32eabcea 100644
--- a/lib/copperplate/regd/fs-cobalt.c
+++ b/lib/copperplate/regd/fs-cobalt.c
@@ -16,14 +16,15 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <sys/types.h>
+#include "sysregfs.h"
+
+#include <cobalt/uapi/thread.h>
+
+#include <errno.h>
 #include <fcntl.h>
-#include <unistd.h>
-#include <stdlib.h>
 #include <stdio.h>
-#include <errno.h>
-#include <cobalt/uapi/thread.h>
-#include "sysregfs.h"
+#include <sys/types.h>
+#include <unistd.h>
 
 #ifdef CONFIG_XENO_PSHARED
 /*
diff --git a/lib/copperplate/regd/fs-common.c b/lib/copperplate/regd/fs-common.c
index e0bdd3d042feb7546f7f0a66334f4aec35e2302a..d3d96165480675e983d48086fcb206577b6482c5 100644
--- a/lib/copperplate/regd/fs-common.c
+++ b/lib/copperplate/regd/fs-common.c
@@ -16,20 +16,19 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <sys/types.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <signal.h>
-#include <malloc.h>
-#include <sched.h>
+#include "../internal.h"
+#include "sysregfs.h"
+
+#include <copperplate/clockobj.h>
 #include <copperplate/heapobj.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/clockobj.h>
+
+#include <fcntl.h>
+#include <malloc.h>
+#include <signal.h>
+#include <stdio.h>
+#include <unistd.h>
 #include <xenomai/version.h>
-#include "sysregfs.h"
-#include "../internal.h"
 
 #ifdef CONFIG_XENO_PSHARED
 
diff --git a/lib/copperplate/regd/fs-mercury.c b/lib/copperplate/regd/fs-mercury.c
index 9a17f83f48aac845742e50b3c68be72cdebd4fc1..5a9b6b1c1c92e404d48eb9d11b703c698a071e1c 100644
--- a/lib/copperplate/regd/fs-mercury.c
+++ b/lib/copperplate/regd/fs-mercury.c
@@ -16,16 +16,16 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <sys/types.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <limits.h>
+#include "../internal.h"
+#include "sysregfs.h"
+
 #include <copperplate/heapobj.h>
 #include <copperplate/threadobj.h>
-#include "sysregfs.h"
-#include "../internal.h"
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <unistd.h>
 
 #ifdef CONFIG_XENO_PSHARED
 
diff --git a/lib/copperplate/regd/regd.c b/lib/copperplate/regd/regd.c
index 87520708743979c7b88cb20fedfe980a4518f925..2ac539437b02e2dfda540c8625ac2fbf987e254b 100644
--- a/lib/copperplate/regd/regd.c
+++ b/lib/copperplate/regd/regd.c
@@ -16,28 +16,28 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/socket.h>
-#include <sys/select.h>
-#include <sys/timerfd.h>
-#include <sys/un.h>
+#include "../internal.h"
+#include "sysregfs.h"
+
+#include <boilerplate/hash.h>
+#include <boilerplate/list.h>
+
+#include <errno.h>
+#include <error.h>
+#include <getopt.h>
+#include <malloc.h>
+#include <pwd.h>
 #include <signal.h>
 #include <stdio.h>
-#include <limits.h>
-#include <memory.h>
-#include <malloc.h>
-#include <getopt.h>
-#include <string.h>
-#include <error.h>
-#include <errno.h>
 #include <stdlib.h>
+#include <string.h>
+#include <sys/select.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/timerfd.h>
+#include <sys/types.h>
+#include <sys/un.h>
 #include <unistd.h>
-#include <pwd.h>
-#include <boilerplate/list.h>
-#include <boilerplate/hash.h>
-#include "../internal.h"
-#include "sysregfs.h"
 
 #define note(fmt, args...)					\
 	do {							\
diff --git a/lib/copperplate/registry.c b/lib/copperplate/registry.c
index 1a08998986d8ea869b512bd5097759d02538c46c..6797e4e2a317884fe2bff6c8c27a08a52c79193e 100644
--- a/lib/copperplate/registry.c
+++ b/lib/copperplate/registry.c
@@ -16,38 +16,39 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <limits.h>
-#include <stdarg.h>
-#include <stdio.h>
-#include <stdlib.h>
+#include "copperplate/registry.h"
+#include "boilerplate/atomic.h"
+#include "boilerplate/hash.h"
+#include "boilerplate/lock.h"
+#include "copperplate/clockobj.h"
+#include "copperplate/debug.h"
+#include "copperplate/heapobj.h"
+#include "copperplate/registry-obstack.h"
+#include "copperplate/syncobj.h"
+#include "copperplate/threadobj.h"
+#include "internal.h"
+#include "xenomai/init.h"
+
+#include <xeno_config.h>
+
 #include <assert.h>
-#include <string.h>
-#include <memory.h>
-#include <signal.h>
-#include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <fuse.h>
+#include <limits.h>
 #include <malloc.h>
 #include <pthread.h>
 #include <semaphore.h>
-#include <fuse.h>
-#include <xeno_config.h>
-#include "boilerplate/atomic.h"
-#include "boilerplate/hash.h"
-#include "copperplate/heapobj.h"
-#include "copperplate/threadobj.h"
-#include "copperplate/syncobj.h"
-#include "copperplate/registry.h"
-#include "copperplate/registry-obstack.h"
-#include "copperplate/clockobj.h"
-#include "boilerplate/lock.h"
-#include "copperplate/debug.h"
-#include "xenomai/init.h"
-#include "internal.h"
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <unistd.h>
 
 /*
  * CAUTION: this code shall NOT refer to the shared heap in any way,
diff --git a/lib/copperplate/semobj.c b/lib/copperplate/semobj.c
index a61567878cd08982d2f2ff57916a3e03763b9d3d..42cd2fa1a6b9c5d256b763c59689c8f78fc1a689 100644
--- a/lib/copperplate/semobj.c
+++ b/lib/copperplate/semobj.c
@@ -10,18 +10,14 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <assert.h>
-#include <errno.h>
-#include "copperplate/threadobj.h"
 #include "copperplate/semobj.h"
-#include "copperplate/heapobj.h"
-#include "copperplate/debug.h"
+#include "copperplate/threadobj.h"
 
 #ifdef CONFIG_XENO_COBALT
 
diff --git a/lib/copperplate/syncobj.c b/lib/copperplate/syncobj.c
index 9e8252c8cc4eaf00ddddeacf4b6055afd70c247b..e458fa81a74fe58a77adb7c6576ae3fc40f3a4ed 100644
--- a/lib/copperplate/syncobj.c
+++ b/lib/copperplate/syncobj.c
@@ -10,17 +10,14 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <assert.h>
-#include <errno.h>
-#include "boilerplate/lock.h"
-#include "copperplate/threadobj.h"
 #include "copperplate/syncobj.h"
+#include "copperplate/threadobj.h"
 
 /*
  * XXX: The POSIX spec states that "Synchronization primitives that
diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index 91b7c41fbc20b97802cab7a5cf1466bba8159c89..dad9d27d823b28c2e32d972f698b32dbd2a3c3ba 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -18,31 +18,17 @@
  * Thread object abstraction.
  */
 
-#include <signal.h>
-#include <memory.h>
-#include <errno.h>
-#include <string.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <time.h>
-#include <fcntl.h>
-#include <assert.h>
-#include <limits.h>
-#include <sched.h>
-#include "boilerplate/signal.h"
-#include "boilerplate/atomic.h"
-#include "boilerplate/lock.h"
-#include "copperplate/traceobj.h"
 #include "copperplate/threadobj.h"
-#include "copperplate/syncobj.h"
+#include "boilerplate/signal.h"
 #include "copperplate/cluster.h"
-#include "copperplate/clockobj.h"
 #include "copperplate/eventobj.h"
-#include "copperplate/heapobj.h"
+#include "copperplate/traceobj.h"
 #include "internal.h"
 
+#include <boilerplate/ancillaries.h>
+
+#include <unistd.h>
+
 union copperplate_wait_union {
 	struct syncluster_wait_struct syncluster_wait;
 	struct eventobj_wait_struct eventobj_wait;
diff --git a/lib/copperplate/timerobj.c b/lib/copperplate/timerobj.c
index ca8b82e1cbf3d9b62813c5a6aa39817dd105f806..b4f79ce6895f5b7e5bbe9f1df85f2a4861c3c6f3 100644
--- a/lib/copperplate/timerobj.c
+++ b/lib/copperplate/timerobj.c
@@ -18,23 +18,12 @@
  * Timer object abstraction.
  */
 
-#include <signal.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <memory.h>
-#include <limits.h>
-#include <pthread.h>
-#include <semaphore.h>
-#include "boilerplate/list.h"
-#include "boilerplate/signal.h"
-#include "boilerplate/lock.h"
-#include "copperplate/threadobj.h"
 #include "copperplate/timerobj.h"
-#include "copperplate/clockobj.h"
-#include "copperplate/debug.h"
+#include "copperplate/threadobj.h"
 #include "internal.h"
 
+#include <boilerplate/ancillaries.h>
+
 static pthread_mutex_t svlock;
 
 static pthread_t svthread;
diff --git a/lib/copperplate/traceobj.c b/lib/copperplate/traceobj.c
index 864815bf5e834815ca15067771256eed2f586b5b..50bdafc543d5e04a3316141a5efbb3a5b9b4e4a2 100644
--- a/lib/copperplate/traceobj.c
+++ b/lib/copperplate/traceobj.c
@@ -16,14 +16,10 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include "boilerplate/lock.h"
 #include "copperplate/traceobj.h"
 #include "copperplate/threadobj.h"
-#include "copperplate/heapobj.h"
 #include "xenomai/init.h"
-#include "internal.h"
+
 #ifdef CONFIG_XENO_VALGRIND_API
 #include <valgrind/valgrind.h>
 static inline int valgrind_detected(void)

-- 
2.54.0

