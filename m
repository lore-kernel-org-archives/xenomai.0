Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3C31A9B
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 14:31:03 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230927135044dcb6f983ee59076919
        for <xenomai@lists.linux.dev>;
        Wed, 27 Sep 2023 15:50:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZgnAVToezuotWcg5vSjrfO69BxaTkz5+eTcZ1hVhN+M=;
 b=R6SCbIzONlmvlaedVTurRHsfhalijbrycwtGBQ42TBIhObXB4x7iudtjdnoNGK0ziLMw1S
 NxE06sSS2AbVe7G5ZYXvOdtpDP129wGy+OF1VgotBb6KMRInIqhcPqswQ18tei3R44oAve1b
 5Etluo9HzTdzl+v8ivj9n5hfcGgzw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 27 Sep 2023 15:50:21 +0200
Subject: [PATCH v2 8/9] lib/cobalt: Cleanup includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-florian-y2038-2-v2-8-05f710464d83@siemens.com>
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

- Add an empty line between license information and first include,
  that is what most files already did

- Cleanup unused / unnecessary includes where possible

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/arch/x86/features.c | 1 -
 lib/cobalt/attr.c              | 4 ----
 lib/cobalt/clock.c             | 7 -------
 lib/cobalt/cond.c              | 1 +
 lib/cobalt/current.c           | 3 +--
 lib/cobalt/init.c              | 2 --
 lib/cobalt/internal.c          | 4 +---
 lib/cobalt/malloc-nowrap.c     | 1 +
 lib/cobalt/malloc.c            | 1 +
 lib/cobalt/mq.c                | 1 -
 lib/cobalt/mutex.c             | 2 +-
 lib/cobalt/parse_vdso.c        | 2 --
 lib/cobalt/rtdm.c              | 1 -
 lib/cobalt/sched.c             | 5 -----
 lib/cobalt/semaphore.c         | 1 -
 lib/cobalt/signal.c            | 4 +---
 lib/cobalt/sigshadow.c         | 1 +
 lib/cobalt/thread.c            | 2 --
 lib/cobalt/ticks.c             | 1 +
 lib/cobalt/timer.c             | 1 +
 lib/cobalt/timerfd.c           | 2 +-
 lib/cobalt/umm.c               | 7 +------
 lib/cobalt/umm.h               | 2 --
 23 files changed, 12 insertions(+), 44 deletions(-)

diff --git a/lib/cobalt/arch/x86/features.c b/lib/cobalt/arch/x86/features.c
index e7e62da39..8c5332b9e 100644
--- a/lib/cobalt/arch/x86/features.c
+++ b/lib/cobalt/arch/x86/features.c
@@ -18,7 +18,6 @@
 
 #include <stdio.h>
 #include <unistd.h>
-#include <stdlib.h>
 #include <string.h>
 #include <boilerplate/atomic.h>
 #include <asm/xenomai/features.h>
diff --git a/lib/cobalt/attr.c b/lib/cobalt/attr.c
index 586de928b..5de2363f7 100644
--- a/lib/cobalt/attr.c
+++ b/lib/cobalt/attr.c
@@ -16,12 +16,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stddef.h>
-#include <errno.h>
 #include <pthread.h>
 #include <memory.h>
-#include <cobalt/uapi/thread.h>
-#include "internal.h"
 
 COBALT_IMPL(int, pthread_attr_init, (pthread_attr_t *attr))
 {
diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 9289d8787..65abf5eac 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -16,20 +16,13 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <sys/types.h>
-#include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 #include <errno.h>
-#include <stdint.h>
 #include <pthread.h>
 #include <unistd.h>
 #include <time.h>
 #include <sys/time.h>
-#include <cobalt/uapi/time.h>
-#include <cobalt/ticks.h>
 #include <asm/xenomai/syscall.h>
-#include "umm.h"
 #include "internal.h"
 
 /**
diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index 7f1906bf9..301dabdca 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <errno.h>
 #include <string.h>
 #include <pthread.h>
diff --git a/lib/cobalt/current.c b/lib/cobalt/current.c
index 7d6ee9fd8..1e1535004 100644
--- a/lib/cobalt/current.c
+++ b/lib/cobalt/current.c
@@ -15,8 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
-#include <stdlib.h>
-#include <stdio.h>
+
 #include <string.h>
 #include <pthread.h>
 #include <asm/xenomai/syscall.h>
diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 7aa7c48de..84f37999d 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -29,8 +29,6 @@
 #include <stdint.h>
 #include <semaphore.h>
 #include <boilerplate/setup.h>
-#include <cobalt/uapi/kernel/heap.h>
-#include <cobalt/ticks.h>
 #include <cobalt/tunables.h>
 #include <asm/xenomai/syscall.h>
 #include <xenomai/init.h>
diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index b9f518ed1..d721e7ec6 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -20,10 +20,9 @@
  * Internal Cobalt services. No sanity check will be done with
  * respect to object validity, callers have to take care of this.
  */
+
 #include <sys/types.h>
 #include <stddef.h>
-#include <stdlib.h>
-#include <limits.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <signal.h>
@@ -31,7 +30,6 @@
 #include <stdarg.h>
 #include <pthread.h>
 #include <asm/xenomai/syscall.h>
-#include <cobalt/ticks.h>
 #include <cobalt/sys/cobalt.h>
 #include "internal.h"
 
diff --git a/lib/cobalt/malloc-nowrap.c b/lib/cobalt/malloc-nowrap.c
index 416fbad73..6dda7667d 100644
--- a/lib/cobalt/malloc-nowrap.c
+++ b/lib/cobalt/malloc-nowrap.c
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <stdlib.h>
 
 __weak
diff --git a/lib/cobalt/malloc.c b/lib/cobalt/malloc.c
index 82f89fd13..c1585586e 100644
--- a/lib/cobalt/malloc.c
+++ b/lib/cobalt/malloc.c
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <stdlib.h>
 #include <cobalt/sys/cobalt.h>
 
diff --git a/lib/cobalt/mq.c b/lib/cobalt/mq.c
index 117f05d3f..88e6e9fbf 100644
--- a/lib/cobalt/mq.c
+++ b/lib/cobalt/mq.c
@@ -23,7 +23,6 @@
 #include <pthread.h>
 #include <mqueue.h>
 #include <asm/xenomai/syscall.h>
-#include "internal.h"
 
 /**
  * @ingroup cobalt_api
diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index a578675f3..54f6b8461 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -15,9 +15,9 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <errno.h>
 #include <string.h>
-#include <limits.h>
 #include <pthread.h>
 #include <asm/xenomai/syscall.h>
 #include "current.h"
diff --git a/lib/cobalt/parse_vdso.c b/lib/cobalt/parse_vdso.c
index 339e4d564..766f90fad 100644
--- a/lib/cobalt/parse_vdso.c
+++ b/lib/cobalt/parse_vdso.c
@@ -15,10 +15,8 @@
  * architecture that has a vDSO.
  */
 
-#include <sys/types.h>
 #include <sys/auxv.h>
 #include <stdbool.h>
-#include <stdint.h>
 #include <string.h>
 #include <limits.h>
 #include <pthread.h>
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 98c8c679a..00c1aaf4b 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -29,7 +29,6 @@
 #include <rtdm/rtdm.h>
 #include <cobalt/uapi/syscall.h>
 #include <asm/xenomai/syscall.h>
-#include "internal.h"
 
 /* support for very old c libraries not supporting O_TMPFILE */
 #ifndef O_TMPFILE
diff --git a/lib/cobalt/sched.c b/lib/cobalt/sched.c
index bdb8603da..6e61ee407 100644
--- a/lib/cobalt/sched.c
+++ b/lib/cobalt/sched.c
@@ -17,14 +17,9 @@
  */
 
 #include <stddef.h>
-#include <stdlib.h>
-#include <string.h>
 #include <errno.h>
-#include <signal.h>
 #include <unistd.h>
 #include <pthread.h>
-#include <sys/types.h>
-#include <semaphore.h>
 #include <asm/xenomai/syscall.h>
 #include "internal.h"
 
diff --git a/lib/cobalt/semaphore.c b/lib/cobalt/semaphore.c
index b6652b763..0c1a245cd 100644
--- a/lib/cobalt/semaphore.c
+++ b/lib/cobalt/semaphore.c
@@ -23,7 +23,6 @@
 #include <pthread.h>		/* For pthread_setcanceltype. */
 #include <semaphore.h>
 #include <asm/xenomai/syscall.h>
-#include <cobalt/uapi/sem.h>
 #include "internal.h"
 
 /**
diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
index d4bc2463d..6e40a3680 100644
--- a/lib/cobalt/signal.c
+++ b/lib/cobalt/signal.c
@@ -15,15 +15,13 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <stdlib.h>
-#include <stdarg.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <pthread.h>
 #include <signal.h>
-#include <cobalt/uapi/signal.h>
 #include <asm/xenomai/syscall.h>
-#include "internal.h"
 
 COBALT_IMPL(int, sigwait, (const sigset_t *set, int *sig))
 {
diff --git a/lib/cobalt/sigshadow.c b/lib/cobalt/sigshadow.c
index 68d3e6276..b03703526 100644
--- a/lib/cobalt/sigshadow.c
+++ b/lib/cobalt/sigshadow.c
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <pthread.h>
 #include <signal.h>
 #include <asm/xenomai/syscall.h>
diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
index bb23cdcb9..dee39a8d4 100644
--- a/lib/cobalt/thread.c
+++ b/lib/cobalt/thread.c
@@ -17,10 +17,8 @@
  */
 
 #include <stddef.h>
-#include <stdlib.h>
 #include <string.h>
 #include <errno.h>
-#include <signal.h>
 #include <unistd.h>
 #include <pthread.h>
 #include <sys/types.h>
diff --git a/lib/cobalt/ticks.c b/lib/cobalt/ticks.c
index a6792389c..214f2a1a8 100644
--- a/lib/cobalt/ticks.c
+++ b/lib/cobalt/ticks.c
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <cobalt/arith.h>
 #include <cobalt/ticks.h>
 #include <asm/xenomai/time.h>
diff --git a/lib/cobalt/timer.c b/lib/cobalt/timer.c
index e20d30e83..a9f91dfc9 100644
--- a/lib/cobalt/timer.c
+++ b/lib/cobalt/timer.c
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <errno.h>
 #include <time.h>
 #include <asm/xenomai/syscall.h>
diff --git a/lib/cobalt/timerfd.c b/lib/cobalt/timerfd.c
index 11e0b04e3..70e9a4e07 100644
--- a/lib/cobalt/timerfd.c
+++ b/lib/cobalt/timerfd.c
@@ -15,9 +15,9 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <errno.h>
 #include <unistd.h>
-#include <fcntl.h>
 #include <sys/timerfd.h>
 #include <asm/xenomai/syscall.h>
 #include "internal.h"
diff --git a/lib/cobalt/umm.c b/lib/cobalt/umm.c
index 555bee847..c0d4489d3 100644
--- a/lib/cobalt/umm.c
+++ b/lib/cobalt/umm.c
@@ -15,22 +15,17 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <sys/types.h>
-#include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <stdio.h>
 #include <errno.h>
-#include <stdlib.h>
-#include <stdint.h>
 #include <string.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <pthread.h>
 #include <rtdm/rtdm.h>
 #include <cobalt/uapi/kernel/heap.h>
-#include <asm/xenomai/syscall.h>
-#include "current.h"
 #include "umm.h"
 #include "internal.h"
 
diff --git a/lib/cobalt/umm.h b/lib/cobalt/umm.h
index 7705f9cf9..a298e8369 100644
--- a/lib/cobalt/umm.h
+++ b/lib/cobalt/umm.h
@@ -18,8 +18,6 @@
 #ifndef _LIB_COBALT_UMM_H
 #define _LIB_COBALT_UMM_H
 
-#include <linux/types.h>
-
 void cobalt_init_umm(void);
 
 void cobalt_unmap_umm(void);

-- 
2.39.2

