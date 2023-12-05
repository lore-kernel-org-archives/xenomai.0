Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C284D118
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WTa8aYer"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20231205124146a9ace784652c7c97c0
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=29oexcI4f4ADaoHFsU9VGBzt5B89KSAddL9xhUoD22A=;
 b=WTa8aYer9x7q5KsIZqeYHxxA3sKX7f6JXTy7mS8wXCTW4h6hoZ+AXcIKY7TeSWn7HtC5ii
 1u4yANgMSY44sSC2zUrc0C6o15Ny80MUCq+zA96iYNXumUgWs+JQnkJdgurXiWIYLukFaskC
 4rMc7zs7bCHaEl4QDngERoeGFAckM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:50 +0100
Subject: [PATCH 13/13] lib/vxworks: Cleanup includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-13-3e0abd7c68fa@siemens.com>
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
 lib/vxworks/errnoLib.c    | 1 +
 lib/vxworks/init.c        | 3 ++-
 lib/vxworks/kernLib.c     | 1 +
 lib/vxworks/memPartLib.c  | 1 +
 lib/vxworks/msgQLib.c     | 1 +
 lib/vxworks/rngLib.c      | 1 +
 lib/vxworks/semLib.c      | 1 +
 lib/vxworks/sysLib.c      | 4 ++--
 lib/vxworks/taskHookLib.c | 2 ++
 lib/vxworks/taskInfo.c    | 1 +
 lib/vxworks/taskLib.c     | 6 ------
 lib/vxworks/tickLib.c     | 6 +-----
 lib/vxworks/wdLib.c       | 1 +
 13 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/lib/vxworks/errnoLib.c b/lib/vxworks/errnoLib.c
index cfb73f27c..66c91e2dd 100644
--- a/lib/vxworks/errnoLib.c
+++ b/lib/vxworks/errnoLib.c
@@ -19,6 +19,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <vxworks/errnoLib.h>
+
 #include "taskLib.h"
 
 void printErrno(int status)
diff --git a/lib/vxworks/init.c b/lib/vxworks/init.c
index 9a3dcc4ab..4a68c9d7f 100644
--- a/lib/vxworks/init.c
+++ b/lib/vxworks/init.c
@@ -15,13 +15,14 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <stdio.h>
-#include <time.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <getopt.h>
 #include <xenomai/init.h>
 #include <vxworks/errnoLib.h>
+
 #include "tickLib.h"
 #include "taskLib.h"
 
diff --git a/lib/vxworks/kernLib.c b/lib/vxworks/kernLib.c
index d67502730..112f2d2eb 100644
--- a/lib/vxworks/kernLib.c
+++ b/lib/vxworks/kernLib.c
@@ -18,6 +18,7 @@
 
 #include <vxworks/kernLib.h>
 #include <vxworks/errnoLib.h>
+
 #include "tickLib.h"
 #include "taskLib.h"
 
diff --git a/lib/vxworks/memPartLib.c b/lib/vxworks/memPartLib.c
index c8eeb3617..f3efb0d36 100644
--- a/lib/vxworks/memPartLib.c
+++ b/lib/vxworks/memPartLib.c
@@ -25,6 +25,7 @@
 #include <copperplate/heapobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/memPartLib.h>
+
 #include "memPartLib.h"
 
 #define mempart_magic	0x5a6b7c8d
diff --git a/lib/vxworks/msgQLib.c b/lib/vxworks/msgQLib.c
index aa0b71c68..7b3d59afe 100644
--- a/lib/vxworks/msgQLib.c
+++ b/lib/vxworks/msgQLib.c
@@ -24,6 +24,7 @@
 #include <copperplate/heapobj.h>
 #include <copperplate/threadobj.h>
 #include <vxworks/errnoLib.h>
+
 #include "reference.h"
 #include "taskLib.h"
 #include "msgQLib.h"
diff --git a/lib/vxworks/rngLib.c b/lib/vxworks/rngLib.c
index b11b89519..343d71baa 100644
--- a/lib/vxworks/rngLib.c
+++ b/lib/vxworks/rngLib.c
@@ -20,6 +20,7 @@
 #include <boilerplate/lock.h>
 #include <copperplate/heapobj.h>
 #include <vxworks/errnoLib.h>
+
 #include "rngLib.h"
 
 #define ring_magic 0x5432affe
diff --git a/lib/vxworks/semLib.c b/lib/vxworks/semLib.c
index 180ed2000..f2abf0f83 100644
--- a/lib/vxworks/semLib.c
+++ b/lib/vxworks/semLib.c
@@ -23,6 +23,7 @@
 #include <boilerplate/ancillaries.h>
 #include <copperplate/heapobj.h>
 #include <vxworks/errnoLib.h>
+
 #include "reference.h"
 #include "taskLib.h"
 #include "semLib.h"
diff --git a/lib/vxworks/sysLib.c b/lib/vxworks/sysLib.c
index 449cc64fb..57999db66 100644
--- a/lib/vxworks/sysLib.c
+++ b/lib/vxworks/sysLib.c
@@ -16,11 +16,11 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include "tickLib.h"
-#include <boilerplate/lock.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/sysLib.h>
 
+#include "tickLib.h"
+
 int sysClkRateGet(void)
 {
 	unsigned int resolution;
diff --git a/lib/vxworks/taskHookLib.c b/lib/vxworks/taskHookLib.c
index 296bc72e6..8953063d3 100644
--- a/lib/vxworks/taskHookLib.c
+++ b/lib/vxworks/taskHookLib.c
@@ -15,9 +15,11 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <copperplate/heapobj.h>
 #include <vxworks/taskHookLib.h>
 #include <vxworks/errnoLib.h>
+
 #include "taskLib.h"
 #include "taskHookLib.h"
 
diff --git a/lib/vxworks/taskInfo.c b/lib/vxworks/taskInfo.c
index ec423d24e..c10bf27bf 100644
--- a/lib/vxworks/taskInfo.c
+++ b/lib/vxworks/taskInfo.c
@@ -22,6 +22,7 @@
 #include <copperplate/threadobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/taskInfo.h>
+
 #include "taskLib.h"
 
 const char *taskName(TASK_ID task_id)
diff --git a/lib/vxworks/taskLib.c b/lib/vxworks/taskLib.c
index c8723c6be..ffef7c832 100644
--- a/lib/vxworks/taskLib.c
+++ b/lib/vxworks/taskLib.c
@@ -17,11 +17,9 @@
  */
 
 #include <stdio.h>
-#include <memory.h>
 #include <errno.h>
 #include <string.h>
 #include <stdlib.h>
-#include <unistd.h>
 #include <pthread.h>
 #include <fcntl.h>
 #include <sched.h>
@@ -30,10 +28,6 @@
 #include "msgQLib.h"
 #include "taskHookLib.h"
 #include "boilerplate/namegen.h"
-#include "copperplate/heapobj.h"
-#include "copperplate/threadobj.h"
-#include "copperplate/syncobj.h"
-#include "copperplate/cluster.h"
 #include "copperplate/internal.h"
 #include "copperplate/registry-obstack.h"
 #include "vxworks/errnoLib.h"
diff --git a/lib/vxworks/tickLib.c b/lib/vxworks/tickLib.c
index 9f7ec5aed..ac8dcda2c 100644
--- a/lib/vxworks/tickLib.c
+++ b/lib/vxworks/tickLib.c
@@ -16,13 +16,9 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stdio.h>
-#include <errno.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
 #include <boilerplate/lock.h>
 #include <vxworks/tickLib.h>
+
 #include "tickLib.h"
 
 struct clockobj wind_clock;
diff --git a/lib/vxworks/wdLib.c b/lib/vxworks/wdLib.c
index beb70d567..55a830845 100644
--- a/lib/vxworks/wdLib.c
+++ b/lib/vxworks/wdLib.c
@@ -27,6 +27,7 @@
 #include <copperplate/heapobj.h>
 #include <copperplate/threadobj.h>
 #include <vxworks/errnoLib.h>
+
 #include "wdLib.h"
 #include "tickLib.h"
 

-- 
2.39.2

