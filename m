Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5215C8E1
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PaUR2LNV"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20231205124144682906e95e8f79662f
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rXCh3Y/WFXRemLKloMRnGoof/M4KGoVuAhrOv8Moi9U=;
 b=PaUR2LNVAQYB7a3RTBIyQDe9GSPVZH3qUWjvBs7o19wiZ2+mJbxB+0CHQFTVIoqlY5QEhc
 3aSD8VyDi3y9q5VVm7XBqVorzelGgRbkP3ksK31B4Dz5AzLlYLXAJUlt4FGg6NUC6fjvoW9P
 jUitGNkzdion8pai3QikeQUIHVRCY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:46 +0100
Subject: [PATCH 09/13] lib/copperplate: Cleanup includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-9-3e0abd7c68fa@siemens.com>
References: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
In-Reply-To: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

- Add an empty line between license information and first include,
  that is what most files already did

- Cleanup unused / unnecessary includes where possible

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/copperplate/clockobj.c        | 4 ----
 lib/copperplate/cluster.c         | 3 ---
 lib/copperplate/eventobj.c        | 2 --
 lib/copperplate/heapobj-heapmem.c | 7 +++++--
 lib/copperplate/init.c            | 4 +---
 lib/copperplate/internal.c        | 4 ++--
 lib/copperplate/syncobj.c         | 2 --
 lib/copperplate/threadobj.c       | 1 +
 lib/copperplate/traceobj.c        | 1 +
 9 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/lib/copperplate/clockobj.c b/lib/copperplate/clockobj.c
index 3a771e474..e605e73b9 100644
--- a/lib/copperplate/clockobj.c
+++ b/lib/copperplate/clockobj.c
@@ -18,16 +18,13 @@
 
 #include <errno.h>
 #include <stdlib.h>
-#include <unistd.h>
 #include <fcntl.h>
 #include <assert.h>
-#include <limits.h>
 #include <time.h>
 #include <string.h>
 #include "boilerplate/lock.h"
 #include "boilerplate/time.h"
 #include "copperplate/clockobj.h"
-#include "copperplate/debug.h"
 #include "internal.h"
 
 #ifdef CONFIG_XENO_LORES_CLOCK_DISABLED
@@ -229,7 +226,6 @@ int clockobj_set_resolution(struct clockobj *clkobj, unsigned int resolution_ns)
 #ifdef CONFIG_XENO_COBALT
 
 #include <cobalt/arith.h>
-#include <cobalt/sys/cobalt.h>
 
 #ifdef CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED
 #error "restricted CLOCK_COPPERPLATE not available"
diff --git a/lib/copperplate/cluster.c b/lib/copperplate/cluster.c
index 754027858..76ef5d4ce 100644
--- a/lib/copperplate/cluster.c
+++ b/lib/copperplate/cluster.c
@@ -90,12 +90,9 @@
 
 #include <errno.h>
 #include <string.h>
-#include <memory.h>
 #include "copperplate/heapobj.h"
 #include "copperplate/cluster.h"
-#include "copperplate/syncobj.h"
 #include "copperplate/threadobj.h"
-#include "copperplate/debug.h"
 #include "internal.h"
 
 const static struct hash_operations hash_operations;
diff --git a/lib/copperplate/eventobj.c b/lib/copperplate/eventobj.c
index dce5bd242..28b7c167f 100644
--- a/lib/copperplate/eventobj.c
+++ b/lib/copperplate/eventobj.c
@@ -20,8 +20,6 @@
 #include <errno.h>
 #include "copperplate/threadobj.h"
 #include "copperplate/eventobj.h"
-#include "copperplate/heapobj.h"
-#include "copperplate/debug.h"
 
 #ifdef CONFIG_XENO_COBALT
 
diff --git a/lib/copperplate/heapobj-heapmem.c b/lib/copperplate/heapobj-heapmem.c
index cc3eb0aa1..85b83e12f 100644
--- a/lib/copperplate/heapobj-heapmem.c
+++ b/lib/copperplate/heapobj-heapmem.c
@@ -15,13 +15,16 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <stdlib.h>
 #include "boilerplate/heapmem.h"
 #include "copperplate/heapobj.h"
-#include "copperplate/debug.h"
-#include "copperplate/tunables.h"
 #include "xenomai/init.h"
 
+#ifndef CONFIG_XENO_PSHARED
+#include "copperplate/tunables.h"
+#endif
+
 #define MIN_HEAPMEM_HEAPSZ  (64 * 1024)
 
 struct heap_memory heapmem_main;
diff --git a/lib/copperplate/init.c b/lib/copperplate/init.c
index 5bfccf606..16fc59f7a 100644
--- a/lib/copperplate/init.c
+++ b/lib/copperplate/init.c
@@ -16,7 +16,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <sys/types.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -26,9 +25,8 @@
 #include <errno.h>
 #include <getopt.h>
 #include <grp.h>
+
 #include "copperplate/threadobj.h"
-#include "copperplate/heapobj.h"
-#include "copperplate/clockobj.h"
 #include "copperplate/registry.h"
 #include "copperplate/timerobj.h"
 #include "xenomai/init.h"
diff --git a/lib/copperplate/internal.c b/lib/copperplate/internal.c
index 1d965266b..ed3f2e4fa 100644
--- a/lib/copperplate/internal.c
+++ b/lib/copperplate/internal.c
@@ -15,17 +15,17 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <sys/types.h>
 #include <sys/prctl.h>
-#include <sys/syscall.h>
 #include <stdio.h>
-#include <stdlib.h>
 #include <stdarg.h>
 #include <pthread.h>
 #include <unistd.h>
 #include <signal.h>
 #include <errno.h>
 #include <limits.h>
+
 #include <boilerplate/ancillaries.h>
 #include <copperplate/clockobj.h>
 #include <copperplate/threadobj.h>
diff --git a/lib/copperplate/syncobj.c b/lib/copperplate/syncobj.c
index 85b29c4ba..9e8252c8c 100644
--- a/lib/copperplate/syncobj.c
+++ b/lib/copperplate/syncobj.c
@@ -21,8 +21,6 @@
 #include "boilerplate/lock.h"
 #include "copperplate/threadobj.h"
 #include "copperplate/syncobj.h"
-#include "copperplate/debug.h"
-#include "internal.h"
 
 /*
  * XXX: The POSIX spec states that "Synchronization primitives that
diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index b97807c8a..0782ffb11 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -17,6 +17,7 @@
  *
  * Thread object abstraction.
  */
+
 #include <signal.h>
 #include <memory.h>
 #include <errno.h>
diff --git a/lib/copperplate/traceobj.c b/lib/copperplate/traceobj.c
index 3c4d69bf8..864815bf5 100644
--- a/lib/copperplate/traceobj.c
+++ b/lib/copperplate/traceobj.c
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include "boilerplate/lock.h"

-- 
2.39.2

