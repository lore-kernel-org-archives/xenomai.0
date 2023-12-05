Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13654756
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="DVQHhj5A"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202312051241437007eb9734c747f100
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kiha5NF/CsToSSjFrUOnrsLsxKMVRJKkkzdwFovWiYA=;
 b=DVQHhj5AuoFOLpuvyvnQkNxIGp7/MrAxmg7prQClfRT2M+hQwEnZvwjR5fjMDjLR36DkBK
 +kFzVw/5x0TuxaAQQoK0tgMONzSSNjrVRCLaypqXcY+qBBEjUeAshx3VT2MLZ28mzKBh2g6A
 DhPN3ahpb/MuM5vQp0+Onk9BDdz58=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:45 +0100
Subject: [PATCH 08/13] lib/boilerplate: Cleanup includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-8-3e0abd7c68fa@siemens.com>
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
 lib/boilerplate/ancillaries.c          | 4 +---
 lib/boilerplate/avl.c                  | 1 +
 lib/boilerplate/debug.c                | 7 ++-----
 lib/boilerplate/hash.c                 | 2 +-
 lib/boilerplate/heapmem.c              | 5 ++---
 lib/boilerplate/iniparser/dictionary.c | 1 -
 lib/boilerplate/init/bootstrap.c       | 1 +
 lib/boilerplate/setup.c                | 5 ++---
 lib/boilerplate/time.c                 | 1 +
 lib/boilerplate/version.c              | 1 +
 10 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/lib/boilerplate/ancillaries.c b/lib/boilerplate/ancillaries.c
index 457ef0b7c..9ca55a6bc 100644
--- a/lib/boilerplate/ancillaries.c
+++ b/lib/boilerplate/ancillaries.c
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <sys/types.h>
 #include <sys/syscall.h>
 #include <stdio.h>
@@ -32,13 +33,10 @@
 #include "boilerplate/atomic.h"
 #include "boilerplate/lock.h"
 #include "boilerplate/time.h"
-#include "boilerplate/scope.h"
 #include "boilerplate/setup.h"
-#include "boilerplate/debug.h"
 #include "boilerplate/ancillaries.h"
 #include "boilerplate/signal.h"
 #include "boilerplate/namegen.h"
-#include "xenomai/init.h"
 
 pthread_mutex_t __printlock;
 
diff --git a/lib/boilerplate/avl.c b/lib/boilerplate/avl.c
index 3bf9bf134..c5cb253c0 100644
--- a/lib/boilerplate/avl.c
+++ b/lib/boilerplate/avl.c
@@ -20,6 +20,7 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
+
 #include <errno.h>
 #include <memory.h>
 
diff --git a/lib/boilerplate/debug.c b/lib/boilerplate/debug.c
index 42ea8e8ef..f6df6c612 100644
--- a/lib/boilerplate/debug.c
+++ b/lib/boilerplate/debug.c
@@ -15,21 +15,18 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <sys/types.h>
 #include <stdio.h>
 #include <stdarg.h>
-#include <stdlib.h>
 #include <unistd.h>
 #include <assert.h>
 #include <pthread.h>
 #include <malloc.h>
-#include <errno.h>
-#include <signal.h>
+
 #include "boilerplate/ancillaries.h"
-#include "boilerplate/wrappers.h"
 #include "boilerplate/lock.h"
 #include "boilerplate/signal.h"
-#include "boilerplate/debug.h"
 
 static pthread_key_t btkey;
 
diff --git a/lib/boilerplate/hash.c b/lib/boilerplate/hash.c
index 9ce1b7cb7..055332c7e 100644
--- a/lib/boilerplate/hash.c
+++ b/lib/boilerplate/hash.c
@@ -18,9 +18,9 @@
 
 #include <string.h>
 #include <errno.h>
+
 #include "boilerplate/lock.h"
 #include "boilerplate/hash.h"
-#include "boilerplate/debug.h"
 
 /*
  * Crunching routine borrowed from:
diff --git a/lib/boilerplate/heapmem.c b/lib/boilerplate/heapmem.c
index e6369c715..8050eb7ab 100644
--- a/lib/boilerplate/heapmem.c
+++ b/lib/boilerplate/heapmem.c
@@ -23,15 +23,14 @@
  * multi-page memory ranges, and pages holding bucketed memory have a
  * fast allocation bitmap to manage their blocks internally.
  */
+
 #include <sys/types.h>
 #include <assert.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdbool.h>
-#include <stdint.h>
-#include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
+
 #include <boilerplate/heapmem.h>
 
 enum heapmem_pgtype {
diff --git a/lib/boilerplate/iniparser/dictionary.c b/lib/boilerplate/iniparser/dictionary.c
index cb7ccd49e..7985ab3fc 100644
--- a/lib/boilerplate/iniparser/dictionary.c
+++ b/lib/boilerplate/iniparser/dictionary.c
@@ -18,7 +18,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
 
 /** Maximum value size for integers and doubles. */
 #define MAXVALSZ    1024
diff --git a/lib/boilerplate/init/bootstrap.c b/lib/boilerplate/init/bootstrap.c
index 64a11c2d2..d77f4eb5c 100644
--- a/lib/boilerplate/init/bootstrap.c
+++ b/lib/boilerplate/init/bootstrap.c
@@ -44,6 +44,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <sys/types.h>
 #include <unistd.h>
 #include <stdlib.h>
diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index a9138e96b..26c8c4cf5 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -15,8 +15,8 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <sys/types.h>
-#include <sys/mman.h>
 #include <sched.h>
 #include <getopt.h>
 #include <string.h>
@@ -24,14 +24,13 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <ctype.h>
-#include <memory.h>
 #include <malloc.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <assert.h>
+
 #include <xeno_config.h>
 #include <boilerplate/lock.h>
-#include <boilerplate/debug.h>
 #include <boilerplate/ancillaries.h>
 #include <xenomai/init.h>
 
diff --git a/lib/boilerplate/time.c b/lib/boilerplate/time.c
index d11259323..b9f5174c4 100644
--- a/lib/boilerplate/time.c
+++ b/lib/boilerplate/time.c
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include "boilerplate/time.h"
 
 void timespec_sub(struct timespec *__restrict r,
diff --git a/lib/boilerplate/version.c b/lib/boilerplate/version.c
index d28c4967e..03af13cad 100644
--- a/lib/boilerplate/version.c
+++ b/lib/boilerplate/version.c
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <xeno_config.h>
 #include "git-stamp.h"
 

-- 
2.39.2

