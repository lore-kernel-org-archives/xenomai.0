Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B655775
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fePozu6e"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20231205124144304074b098f4297554
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BRDoFGvms6pM2g6dwbYmy7tAuf80BqnQ6pNHpW9VfOw=;
 b=fePozu6e94eFvrjhgbKCpCfUEyxdahRghkOqRctLKZ5htOBSamO+y32sljv6Vqkct1d+QT
 PNLjNnepbyi6KUOnApnKdAkA/hxNr0vcwkzCd46/giKkOIkoX3HKeilGjm5+eYZb/4Zhi94V
 0NU6C5/1R51CCWSqS09uEk1vaCEPQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:47 +0100
Subject: [PATCH 10/13] lib/psos: Cleanup includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-10-3e0abd7c68fa@siemens.com>
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
 lib/psos/init.c  | 8 ++------
 lib/psos/pt.c    | 5 +----
 lib/psos/queue.c | 7 +------
 lib/psos/rn.c    | 5 +----
 lib/psos/sem.c   | 4 +---
 lib/psos/task.c  | 5 +----
 lib/psos/tm.c    | 3 ---
 7 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/lib/psos/init.c b/lib/psos/init.c
index 307594edb..0d8733436 100644
--- a/lib/psos/init.c
+++ b/lib/psos/init.c
@@ -15,18 +15,14 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <stdio.h>
-#include <string.h>
-#include <time.h>
 #include <stdlib.h>
-#include <unistd.h>
 #include <getopt.h>
 #include <xenomai/init.h>
 #include <copperplate/registry.h>
 #include <copperplate/clockobj.h>
-#include <copperplate/debug.h>
-#include <psos/psos.h>
-#include "internal.h"
+
 #include "tm.h"
 #include "task.h"
 #include "sem.h"
diff --git a/lib/psos/pt.c b/lib/psos/pt.c
index 0fc7d9bb6..244d341a4 100644
--- a/lib/psos/pt.c
+++ b/lib/psos/pt.c
@@ -17,14 +17,11 @@
  */
 
 #include <stdio.h>
-#include <stdint.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <memory.h>
 #include <boilerplate/ancillaries.h>
 #include <boilerplate/lock.h>
 #include <copperplate/cluster.h>
 #include <psos/psos.h>
+
 #include "internal.h"
 #include "pt.h"
 
diff --git a/lib/psos/queue.c b/lib/psos/queue.c
index 325335a3c..a88d64be1 100644
--- a/lib/psos/queue.c
+++ b/lib/psos/queue.c
@@ -17,19 +17,14 @@
  */
 
 #include <stdio.h>
-#include <stdint.h>
 #include <errno.h>
-#include <stdlib.h>
-#include <memory.h>
 #include <boilerplate/ancillaries.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/heapobj.h>
-#include <copperplate/clockobj.h>
 #include <copperplate/cluster.h>
 #include <psos/psos.h>
+
 #include "internal.h"
 #include "reference.h"
-#include "task.h"
 #include "queue.h"
 #include "tm.h"
 
diff --git a/lib/psos/rn.c b/lib/psos/rn.c
index fa5bb5707..4a09faebd 100644
--- a/lib/psos/rn.c
+++ b/lib/psos/rn.c
@@ -17,14 +17,11 @@
  */
 
 #include <stdio.h>
-#include <stdint.h>
 #include <errno.h>
-#include <stdlib.h>
-#include <memory.h>
 #include <boilerplate/ancillaries.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/clockobj.h>
 #include <psos/psos.h>
+
 #include "internal.h"
 #include "tm.h"
 #include "rn.h"
diff --git a/lib/psos/sem.c b/lib/psos/sem.c
index 6f6610124..2e3376a5d 100644
--- a/lib/psos/sem.c
+++ b/lib/psos/sem.c
@@ -17,17 +17,15 @@
  */
 
 #include <stdio.h>
-#include <stdint.h>
 #include <errno.h>
-#include <stdlib.h>
 #include <string.h>
 #include <boilerplate/ancillaries.h>
 #include <copperplate/heapobj.h>
 #include <copperplate/cluster.h>
 #include <copperplate/clockobj.h>
 #include <copperplate/semobj.h>
+
 #include "reference.h"
-#include "task.h"
 #include "sem.h"
 #include "tm.h"
 #include "internal.h"
diff --git a/lib/psos/task.c b/lib/psos/task.c
index f678be61d..75965f007 100644
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -17,18 +17,15 @@
  */
 
 #include <stdio.h>
-#include <memory.h>
 #include <errno.h>
 #include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
 #include <pthread.h>
 #include <sched.h>
+
 #include "boilerplate/namegen.h"
 #include "copperplate/heapobj.h"
 #include "copperplate/threadobj.h"
 #include "copperplate/syncobj.h"
-#include "copperplate/clockobj.h"
 #include "copperplate/cluster.h"
 #include "copperplate/internal.h"
 #include "psos/psos.h"
diff --git a/lib/psos/tm.c b/lib/psos/tm.c
index de7d56d1e..09cb47f6e 100644
--- a/lib/psos/tm.c
+++ b/lib/psos/tm.c
@@ -16,11 +16,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <errno.h>
 #include <memory.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/heapobj.h>
-#include <copperplate/clockobj.h>
 #include <psos/psos.h>
 #include "task.h"
 #include "tm.h"

-- 
2.39.2

