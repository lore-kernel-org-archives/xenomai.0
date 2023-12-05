Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062304B5DE
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Ejwxl6yy"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231205124142d76de71012a2c8eaea
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OdnZ3q4ydRVHm87Qjl8EISeip69hT3kO1LAWb+mn8K0=;
 b=Ejwxl6yyjcImj9MyN3w8htF1DacE4cIbY3ipJpcwwWmAsOqEDdBEXJyhLXyhHvF76GZbJk
 e3hwS/BtyIgAxzcqnqe9h+7WJ0VbTnhvPgHePKeVORLnUuEObs8L9RznogqD/KjfeDRPThMX
 +z1DQn6pvlZX+ZVhmJc6zHMChyECo=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:43 +0100
Subject: [PATCH 06/13] lib/alchemy: Cleanup includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-6-3e0abd7c68fa@siemens.com>
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
 lib/alchemy/alarm.c    | 2 +-
 lib/alchemy/buffer.c   | 2 +-
 lib/alchemy/cond.c     | 2 +-
 lib/alchemy/event.c    | 2 +-
 lib/alchemy/heap.c     | 1 -
 lib/alchemy/init.c     | 3 +--
 lib/alchemy/internal.c | 2 --
 lib/alchemy/mutex.c    | 2 +-
 lib/alchemy/pipe.c     | 3 ++-
 lib/alchemy/queue.c    | 2 +-
 lib/alchemy/sem.c      | 1 -
 lib/alchemy/task.c     | 2 +-
 12 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/lib/alchemy/alarm.c b/lib/alchemy/alarm.c
index 2298114d2..14cb4e248 100644
--- a/lib/alchemy/alarm.c
+++ b/lib/alchemy/alarm.c
@@ -15,10 +15,10 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <errno.h>
 #include <string.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/heapobj.h>
 #include "reference.h"
 #include "internal.h"
 #include "alarm.h"
diff --git a/lib/alchemy/buffer.c b/lib/alchemy/buffer.c
index 1fa281f3a..b9526304d 100644
--- a/lib/alchemy/buffer.c
+++ b/lib/alchemy/buffer.c
@@ -15,10 +15,10 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <errno.h>
 #include <string.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/heapobj.h>
 #include "reference.h"
 #include "internal.h"
 #include "buffer.h"
diff --git a/lib/alchemy/cond.c b/lib/alchemy/cond.c
index e4ad71454..4409e3f5b 100644
--- a/lib/alchemy/cond.c
+++ b/lib/alchemy/cond.c
@@ -15,10 +15,10 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <errno.h>
 #include <string.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/heapobj.h>
 #include "internal.h"
 #include "cond.h"
 #include "timer.h"
diff --git a/lib/alchemy/event.c b/lib/alchemy/event.c
index 8ccd99b86..8ba76f333 100644
--- a/lib/alchemy/event.c
+++ b/lib/alchemy/event.c
@@ -15,11 +15,11 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <errno.h>
 #include <string.h>
 #include <stdlib.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/heapobj.h>
 #include <copperplate/registry-obstack.h>
 #include "reference.h"
 #include "internal.h"
diff --git a/lib/alchemy/heap.c b/lib/alchemy/heap.c
index c658c46b2..140fdc656 100644
--- a/lib/alchemy/heap.c
+++ b/lib/alchemy/heap.c
@@ -19,7 +19,6 @@
 #include <errno.h>
 #include <string.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/heapobj.h>
 #include <copperplate/registry-obstack.h>
 #include "reference.h"
 #include "internal.h"
diff --git a/lib/alchemy/init.c b/lib/alchemy/init.c
index 2efd13899..c3da26eb8 100644
--- a/lib/alchemy/init.c
+++ b/lib/alchemy/init.c
@@ -17,11 +17,10 @@
  */
 
 #include <stdio.h>
-#include <time.h>
 #include <stdlib.h>
-#include <unistd.h>
 #include <getopt.h>
 #include <xenomai/init.h>
+
 #include "timer.h"
 #include "task.h"
 #include "sem.h"
diff --git a/lib/alchemy/internal.c b/lib/alchemy/internal.c
index 7e998ff13..8258154ea 100644
--- a/lib/alchemy/internal.c
+++ b/lib/alchemy/internal.c
@@ -17,8 +17,6 @@
  */
 
 #include <string.h>
-#include <stdio.h>
-#include <errno.h>
 #include <boilerplate/lock.h>
 #include <copperplate/cluster.h>
 #include <copperplate/heapobj.h>
diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 5836af59f..9681e124e 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -15,10 +15,10 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <errno.h>
 #include <string.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/heapobj.h>
 #include "internal.h"
 #include "mutex.h"
 #include "timer.h"
diff --git a/lib/alchemy/pipe.c b/lib/alchemy/pipe.c
index c334349aa..a266a380f 100644
--- a/lib/alchemy/pipe.c
+++ b/lib/alchemy/pipe.c
@@ -15,13 +15,14 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
 #include <fcntl.h>
+
 #include "rtdm/ipc.h"
 #include "copperplate/threadobj.h"
-#include "copperplate/heapobj.h"
 #include "copperplate/cluster.h"
 #include "reference.h"
 #include "internal.h"
diff --git a/lib/alchemy/queue.c b/lib/alchemy/queue.c
index c45e42454..0dba63f2b 100644
--- a/lib/alchemy/queue.c
+++ b/lib/alchemy/queue.c
@@ -15,10 +15,10 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <errno.h>
 #include <string.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/heapobj.h>
 #include <copperplate/registry-obstack.h>
 #include "reference.h"
 #include "internal.h"
diff --git a/lib/alchemy/sem.c b/lib/alchemy/sem.c
index 497756ebd..e88c6e4d6 100644
--- a/lib/alchemy/sem.c
+++ b/lib/alchemy/sem.c
@@ -20,7 +20,6 @@
 #include <string.h>
 #include <stdlib.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/heapobj.h>
 #include <copperplate/registry-obstack.h>
 #include "reference.h"
 #include "internal.h"
diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
index 9e6101df5..ed5f2f804 100644
--- a/lib/alchemy/task.c
+++ b/lib/alchemy/task.c
@@ -19,8 +19,8 @@
 #include <sched.h>
 #include <pthread.h>
 #include <errno.h>
-#include <stdio.h>
 #include <string.h>
+
 #include "copperplate/heapobj.h"
 #include "copperplate/internal.h"
 #include "internal.h"

-- 
2.39.2

