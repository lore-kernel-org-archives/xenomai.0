Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D1370D61
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221397; cv=none; b=bekL+VMptf6QsiwlUIhXyVwwFtPewBC561pBXjLaxUdi9av1REI1oEnK39z2LlWsKwaHl+XfeNMCDzqw49MSh31nmqa5v6ngdgqBfb20o1DIrR+dKfZy2M4HCyPbRsSjfEOpyJ91fFHDz8ShowdJX+2JvkQU8LHKECmpL/Vd6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221397; c=relaxed/simple;
	bh=rU+z6XuEaUajfE1kUKZUZfCmEcno+ZuzVgesmYaHMxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMunU+SnGEzFmD9zsQuKi5SALd/LiNPPaniW6iPMCq2OQeG0c0B17chFwRJAeScMuErFa+tlM89kDBUcBUkHrBhoyPM6wDgIR8Y5rFhZMTyRQrbEIE1nC4DiiOXYV/juisNAgYp4DSB82sc4WZkn0tPZGsZ4FWgqRKsjzzOWf9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=O37Op1B0; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="O37Op1B0"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260508062254f5dd9c9ea9000207c6
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BeRFlUwpZGxBeqCWAQg/MFFYSogFjztUQW3rGGYVLFk=;
 b=O37Op1B0a5wbU1OnBoPE5IXwCo8RY3Eb72v6EtmlABWUFug9MiIglGDb2Sn/1WCdS+zb2k
 2166u97W+oXCrvXtbEBK0MlHI7DXjoRf4hiJNsFHuO8E44jBenh1HesbCw3mtwMQWDTVnnRB
 qh2PfzDHI39K50O+Z9AA/elWnfSU7c9oqMQgOFinthSgVwKP32CRMRIyI6FRRiaEYS7GbZ8d
 8OOfxqPAoI6JmOerylB9qBYtGsHTNirRYYZBkdoo6i4zFMipX8IOiBViZ3wejBPt0r3MpOKd
 SP8qlrL8ZHKQtX+bV3HU3cpn1ToRSVL3023TuBa3XWyJQvhfZ0RZRoCQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:43 +0200
Subject: [PATCH 10/32] lib/trank: Rearrange includes and harmonize license
 headers
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-10-e449f2bd4fc2@siemens.com>
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
 lib/trank/init.c     |  5 +++--
 lib/trank/internal.c | 12 +++++-------
 lib/trank/internal.h |  8 ++++----
 lib/trank/native.c   | 12 +++++++-----
 lib/trank/posix.c    | 16 +++++++---------
 5 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/lib/trank/init.c b/lib/trank/init.c
index cbd034e03ecfe07f0fbfd84cbb48430d97d10909..0df0f50ee235d09aabc2b6f0af5dc0f837600160 100644
--- a/lib/trank/init.c
+++ b/lib/trank/init.c
@@ -10,15 +10,16 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <xenomai/init.h>
 #include "internal.h"
 
+#include <xenomai/init.h>
+
 /**
  * @defgroup trank Transition Kit
  *
diff --git a/lib/trank/internal.c b/lib/trank/internal.c
index 391fd9a06ea2fa7c32808def587fe5d0204a06a1..bbe70c289d840c572c9fc3881f00f39e9b8bb211 100644
--- a/lib/trank/internal.c
+++ b/lib/trank/internal.c
@@ -10,21 +10,19 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <xeno_config.h>
-#include <signal.h>
-#include <stdlib.h>
-#include <string.h>
-#include <boilerplate/signal.h>
-
 #include "cobalt/internal.h"
 #include "internal.h"
 
+#include <boilerplate/signal.h>
+
+#include <string.h>
+
 sigset_t trank_sigperiod_set;
 
 #ifdef HAVE_TLS
diff --git a/lib/trank/internal.h b/lib/trank/internal.h
index 5fd9d7ea6c6b218e6a842ad4337e5294e7fcc48d..618f7784168e17e08380b87ea9e65f285358988f 100644
--- a/lib/trank/internal.h
+++ b/lib/trank/internal.h
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
+
 #ifndef _TRANK_INTERNAL_H
 #define _TRANK_INTERNAL_H
 
-#include <pthread.h>
-#include <time.h>
-#include <signal.h>
 #include <xeno_config.h>
 
+#include <pthread.h>
+
 struct trank_context {
 	timer_t periodic_timer;
 };
diff --git a/lib/trank/native.c b/lib/trank/native.c
index cacc261c7c3b3ac92b70d83e4f2f27c16da9167c..a89edd6ba9d15877833bef1efa00384b2d49ff65 100644
--- a/lib/trank/native.c
+++ b/lib/trank/native.c
@@ -10,18 +10,20 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
-#include <copperplate/threadobj.h>
-#include <copperplate/heapobj.h>
-#include <trank/native/task.h>
+
+#include "../alchemy/alarm.h"
+
+//#include <copperplate/heapobj.h>
+//#include <copperplate/threadobj.h>
 #include <trank/native/alarm.h>
 #include <trank/native/event.h>
 #include <trank/native/pipe.h>
-#include "../alchemy/alarm.h"
+#include <trank/native/task.h>
 
 #ifdef DOXYGEN_CPP
 
diff --git a/lib/trank/posix.c b/lib/trank/posix.c
index ddada56770f77cff00c2e2136eb99fce6f78e381..f572d7c9c4cd7d28fd3bdb1aa76840bb31e06b59 100644
--- a/lib/trank/posix.c
+++ b/lib/trank/posix.c
@@ -10,22 +10,20 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
-#include <xeno_config.h>
-#include <errno.h>
-#include <signal.h>
-#include <time.h>
-#include <memory.h>
-#include <boilerplate/ancillaries.h>
-#include <boilerplate/signal.h>
-#include <trank/posix/pthread.h>
+
 #include "cobalt/internal.h"
 #include "internal.h"
 
+#include <boilerplate/signal.h>
+#include <trank/posix/pthread.h>
+
+#include <memory.h>
+
 /**
  * @ingroup trank
  * @{

-- 
2.54.0

