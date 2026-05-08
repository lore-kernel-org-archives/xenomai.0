Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254663570C8
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221387; cv=none; b=f6XjWrwgSIgFPqCVOge9yx4bVLLB32X8Ku0o5M0cnQarn6lfG95iqOq11ngXYxiKAFSqQNu0jnsb8kH69aVxS7CLm/oxugOG2ia5Gsut+ZH+a9Bwovmq3+MEjrDt08elhp0BoTZX6jMvaYmpZDatnHUxzWi+yL6rzGH8JxQYmfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221387; c=relaxed/simple;
	bh=PQ6xXfhZjz8maXnLkIzCrbUPP0TSk43lQNw/gE1BQmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m9PzLbKrcxruaWm3HJIgQOjrAGQA0y5gpTSQ4xaCwT1iHqfaKkqSQ0z2CkcFiLw/5QuGz0tjz5ISr3XU13sN+QCM0lf3r19Zsn6AwLdmc4x3pG8+VPiWwr91KSQP6gfNAzhqNgwzu2tl2v1TnuW5m85ElB+AHFXVFBDCMT28Y7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=GW3mZ2Xd; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="GW3mZ2Xd"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202605080622495c101971e1000207b1
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3WeHSYwwHVZ5OhZOvr/SlAOmp8fnlCkLr3BJK9gCpVs=;
 b=GW3mZ2Xd8ttWry3cLNRoBVoAyThLIweAc79l2iScyF0MB1mJDKU68CFQuaewsUlin6hMzW
 KgzUGyxzeYmXuAD/r7dtz82paY9VlvqRhoQzpHqEpyE2j4jlM9KgdnCqPh/CUNR6OyLhIgFP
 JPK3asuuDiBrIZmMrGTlz7g2qkCpEPh4nIyqAQqFtOpyJtGbIxwFeMTfkvD162dy2/kunh4C
 MejTrwFGsrr4nj45J+KS7Q3d7k4BiyV8wEq9aH7p2NQzGJ04nO5EcXS+54bIUUvY4eeoA7i3
 thy8nhXoNJJZv3guS7xA5OaKXjJRZivMtU18Hw4NYe0z/+R4piPrrcwg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:34 +0200
Subject: [PATCH 01/32] lib/alchemy: Rearrange includes and harmonize
 license headers
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-1-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving to "from local to global" should help us to keep headers
self-contained. Some parts of the codebase were already migrated,
lib/alchemy was still missing.

While at it: Harmonzie license headers. doxygen reported a warning
while generating the docs.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/alchemy/Makefile.am |  3 +--
 lib/alchemy/alarm.c     | 14 +++++++-------
 lib/alchemy/alarm.h     |  5 ++---
 lib/alchemy/buffer.c    | 15 ++++++++-------
 lib/alchemy/buffer.h    |  6 ++----
 lib/alchemy/cond.c      | 12 ++++++------
 lib/alchemy/cond.h      |  5 ++---
 lib/alchemy/event.c     | 17 ++++++++---------
 lib/alchemy/event.h     |  6 +++---
 lib/alchemy/heap.c      | 14 +++++++-------
 lib/alchemy/heap.h      |  7 +++----
 lib/alchemy/init.c      | 25 +++++++++++--------------
 lib/alchemy/internal.c  |  8 ++++----
 lib/alchemy/internal.h  |  7 +++----
 lib/alchemy/mutex.c     |  8 +++-----
 lib/alchemy/mutex.h     |  5 ++---
 lib/alchemy/pipe.c      | 16 ++++++----------
 lib/alchemy/pipe.h      |  3 +--
 lib/alchemy/queue.c     | 14 +++++++-------
 lib/alchemy/queue.h     |  7 ++-----
 lib/alchemy/reference.h |  2 +-
 lib/alchemy/sem.c       | 15 +++++++--------
 lib/alchemy/sem.h       |  7 +++----
 lib/alchemy/task.c      | 17 ++++++-----------
 lib/alchemy/task.h      | 14 ++++++--------
 lib/alchemy/timer.c     |  4 ++--
 lib/alchemy/timer.h     | 25 -------------------------
 27 files changed, 113 insertions(+), 168 deletions(-)

diff --git a/lib/alchemy/Makefile.am b/lib/alchemy/Makefile.am
index 12f8fab5366cb11bee21b45af3b971ddacd2c5d5..767aaba298d314be036bcbe9175cede669fd71e8 100644
--- a/lib/alchemy/Makefile.am
+++ b/lib/alchemy/Makefile.am
@@ -29,8 +29,7 @@ libalchemy@CORE@_la_SOURCES =	\
 	task.h		\
 	sem.c		\
 	sem.h		\
-	timer.c		\
-	timer.h
+	timer.c
 
 if XENO_COBALT
 libalchemy@CORE@_la_SOURCES +=	\
diff --git a/lib/alchemy/alarm.c b/lib/alchemy/alarm.c
index 14cb4e248de0a233a46beee31b5b65495740ede1..e98468547609875e335b414b9d747623eeab4b73 100644
--- a/lib/alchemy/alarm.c
+++ b/lib/alchemy/alarm.c
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
 
-#include <errno.h>
-#include <string.h>
-#include <copperplate/threadobj.h>
-#include "reference.h"
-#include "internal.h"
 #include "alarm.h"
-#include "timer.h"
+#include "boilerplate/ancillaries.h"
+#include "boilerplate/namegen.h"
+#include "internal.h"
+
+#include <alchemy/alarm.h>
+#include <copperplate/threadobj.h>
 
 /**
  * @ingroup alchemy
diff --git a/lib/alchemy/alarm.h b/lib/alchemy/alarm.h
index 3fa4296e5ea1cffb445f52225ed604bdfcbbe6a7..8a03e29b234216861414f1e3a11e4fe7fae4a680 100644
--- a/lib/alchemy/alarm.h
+++ b/lib/alchemy/alarm.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,10 +19,9 @@
 #ifndef _ALCHEMY_ALARM_H
 #define _ALCHEMY_ALARM_H
 
+#include <copperplate/cluster.h>
 #include <copperplate/registry-obstack.h>
 #include <copperplate/timerobj.h>
-#include <copperplate/cluster.h>
-#include <alchemy/alarm.h>
 
 #define alarm_magic	0x8888ebeb
 
diff --git a/lib/alchemy/buffer.c b/lib/alchemy/buffer.c
index b9526304de78a247a4b53a633b28c038049e3050..ebfa1faa4bbba875319e7fc2136148ac00f1ba52 100644
--- a/lib/alchemy/buffer.c
+++ b/lib/alchemy/buffer.c
@@ -10,19 +10,20 @@
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
-#include <string.h>
-#include <copperplate/threadobj.h>
-#include "reference.h"
-#include "internal.h"
 #include "buffer.h"
-#include "timer.h"
+#include "boilerplate/ancillaries.h"
+#include "boilerplate/namegen.h"
+#include "internal.h"
+
+#include <alchemy/buffer.h>
+#include <alchemy/timer.h>
+#include <copperplate/threadobj.h>
 
 /**
  * @ingroup alchemy
diff --git a/lib/alchemy/buffer.h b/lib/alchemy/buffer.h
index 3c99d0ce7a54ded99733e3a91ac12685253ce54e..b81218a8ced365149752f3fd0106d06fe89382df 100644
--- a/lib/alchemy/buffer.h
+++ b/lib/alchemy/buffer.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,10 +19,8 @@
 #ifndef _ALCHEMY_BUFFER_H
 #define _ALCHEMY_BUFFER_H
 
-#include <copperplate/registry-obstack.h>
-#include <copperplate/syncobj.h>
 #include <copperplate/cluster.h>
-#include <alchemy/buffer.h>
+#include <copperplate/registry-obstack.h>
 
 struct alchemy_buffer {
 	unsigned int magic;	/* Must be first. */
diff --git a/lib/alchemy/cond.c b/lib/alchemy/cond.c
index 4409e3f5bf302f669ed1e05e1cce174bffefba54..3b99a5f3b81dc6f86eaea5ef6d7a9baa05cb1452 100644
--- a/lib/alchemy/cond.c
+++ b/lib/alchemy/cond.c
@@ -10,20 +10,20 @@
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
-#include <string.h>
-#include <copperplate/threadobj.h>
-#include "internal.h"
 #include "cond.h"
-#include "timer.h"
+#include "boilerplate/ancillaries.h"
+#include "boilerplate/namegen.h"
+#include "internal.h"
 #include "mutex.h"
 
+#include <alchemy/cond.h>
+
 /**
  * @ingroup alchemy
  * @defgroup alchemy_cond Condition variable services
diff --git a/lib/alchemy/cond.h b/lib/alchemy/cond.h
index a807636ccf8194aa6b91c006d8f69a3269fe0b36..fc6fa1d3d4bc957c056f1c4a7184d8bdba7a699f 100644
--- a/lib/alchemy/cond.h
+++ b/lib/alchemy/cond.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,9 +19,8 @@
 #ifndef _ALCHEMY_COND_H
 #define _ALCHEMY_COND_H
 
-#include <copperplate/registry.h>
 #include <copperplate/cluster.h>
-#include <alchemy/cond.h>
+#include <copperplate/registry.h>
 
 struct threadobj;
 
diff --git a/lib/alchemy/event.c b/lib/alchemy/event.c
index 8ba76f333c12abb7ff86129e468f6df5014c39fc..ac05f4fdd6da10e96e18e3abf5afb1ae2b0cf067 100644
--- a/lib/alchemy/event.c
+++ b/lib/alchemy/event.c
@@ -10,21 +10,20 @@
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
-#include <string.h>
-#include <stdlib.h>
-#include <copperplate/threadobj.h>
-#include <copperplate/registry-obstack.h>
-#include "reference.h"
-#include "internal.h"
 #include "event.h"
-#include "timer.h"
+#include "boilerplate/ancillaries.h"
+#include "boilerplate/namegen.h"
+#include "internal.h"
+
+#include <alchemy/event.h>
+#include <copperplate/registry-obstack.h>
+#include <copperplate/threadobj.h>
 
 /**
  * @ingroup alchemy
diff --git a/lib/alchemy/event.h b/lib/alchemy/event.h
index 7ea53c3cf5187bfd95c1d91e13775258b544f6d4..87cf9676dcf2c9d53b6d8dc449ea2762f9cac5ca 100644
--- a/lib/alchemy/event.h
+++ b/lib/alchemy/event.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,10 +19,10 @@
 #ifndef _ALCHEMY_EVENT_H
 #define _ALCHEMY_EVENT_H
 
+//#include <alchemy/event.h>
+#include <copperplate/cluster.h>
 #include <copperplate/eventobj.h>
 #include <copperplate/registry.h>
-#include <copperplate/cluster.h>
-#include <alchemy/event.h>
 
 struct alchemy_event {
 	unsigned int magic;	/* Must be first. */
diff --git a/lib/alchemy/heap.c b/lib/alchemy/heap.c
index 140fdc656d745d3a72dbbd071048c4a1bcf1045b..464a5325eedeb947ed9b89b86649cefebc2eeac8 100644
--- a/lib/alchemy/heap.c
+++ b/lib/alchemy/heap.c
@@ -16,14 +16,14 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <errno.h>
-#include <string.h>
-#include <copperplate/threadobj.h>
-#include <copperplate/registry-obstack.h>
-#include "reference.h"
-#include "internal.h"
 #include "heap.h"
-#include "timer.h"
+#include "boilerplate/ancillaries.h"
+#include "boilerplate/namegen.h"
+#include "internal.h"
+
+#include <alchemy/heap.h>
+#include <copperplate/registry-obstack.h>
+#include <copperplate/threadobj.h>
 
 /**
  * @ingroup alchemy
diff --git a/lib/alchemy/heap.h b/lib/alchemy/heap.h
index e76e36f38047a86965be66c82f67264d153396fa..ed0734251655dd5ec3d58dc1a1d5bf6f1bd5ef67 100644
--- a/lib/alchemy/heap.h
+++ b/lib/alchemy/heap.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,11 +19,10 @@
 #ifndef _ALCHEMY_HEAP_H
 #define _ALCHEMY_HEAP_H
 
-#include <copperplate/syncobj.h>
-#include <copperplate/registry.h>
 #include <copperplate/cluster.h>
 #include <copperplate/heapobj.h>
-#include <alchemy/heap.h>
+#include <copperplate/registry.h>
+#include <copperplate/syncobj.h>
 
 struct alchemy_heap {
 	unsigned int magic;	/* Must be first. */
diff --git a/lib/alchemy/init.c b/lib/alchemy/init.c
index c3da26eb8c69fa03f0e79f9cddc758d93e48d99b..47aff22edb5f4ab5660f9ad07580c844fd4cc0e3 100644
--- a/lib/alchemy/init.c
+++ b/lib/alchemy/init.c
@@ -10,28 +10,25 @@
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
-#include <getopt.h>
-#include <xenomai/init.h>
-
-#include "timer.h"
-#include "task.h"
-#include "sem.h"
-#include "event.h"
-#include "cond.h"
-#include "mutex.h"
-#include "queue.h"
+#include "alarm.h"
 #include "buffer.h"
+#include "cond.h"
+#include "event.h"
 #include "heap.h"
-#include "alarm.h"
+#include "mutex.h"
 #include "pipe.h"
+#include "queue.h"
+#include "sem.h"
+#include "task.h"
+
+#include <getopt.h>
+#include <xenomai/init.h>
 
 /**
  * @defgroup alchemy Alchemy API
diff --git a/lib/alchemy/internal.c b/lib/alchemy/internal.c
index 8258154ea99d6a8c0270d76127bc5da1ca6dc815..318a8f8b0e41578da3c1d002d431f926ca272bc3 100644
--- a/lib/alchemy/internal.c
+++ b/lib/alchemy/internal.c
@@ -10,17 +10,17 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <string.h>
-#include <boilerplate/lock.h>
+#include "internal.h"
+#include "boilerplate/ancillaries.h"
+
 #include <copperplate/cluster.h>
 #include <copperplate/heapobj.h>
-#include "internal.h"
 
 int alchemy_bind_object(const char *name, struct syncluster *sc,
 			RTIME timeout,
diff --git a/lib/alchemy/internal.h b/lib/alchemy/internal.h
index b867604bf99ec2a092bd94bb454719f27333f39d..8d22520ed5d1b82c64d8428b64120adb140d1270 100644
--- a/lib/alchemy/internal.h
+++ b/lib/alchemy/internal.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,9 +19,8 @@
 #ifndef _ALCHEMY_INTERNAL_H
 #define _ALCHEMY_INTERNAL_H
 
-#include "boilerplate/ancillaries.h"
-#include "boilerplate/namegen.h"
-#include "timer.h"
+#include <alchemy/timer.h>
+#include <copperplate/clockobj.h>
 
 #define DEFINE_SYNC_LOOKUP(__name, __dsctype)				\
 static inline struct alchemy_ ## __name *				\
diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 6bec2d9bb6ab32fd7e6c9bd76dcf94139960b99c..067c55f6c32cbd8169428d4aa88808bc03f15acd 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -16,12 +16,10 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <errno.h>
-#include <string.h>
-#include <copperplate/threadobj.h>
-#include "internal.h"
 #include "mutex.h"
-#include "timer.h"
+#include "boilerplate/ancillaries.h"
+#include "boilerplate/namegen.h"
+#include "internal.h"
 #include "task.h"
 
 /**
diff --git a/lib/alchemy/mutex.h b/lib/alchemy/mutex.h
index 998074ca4ac936a9455e334ea7b9a538d3524086..137badfb64887cecb72032e7e1447b09026f259f 100644
--- a/lib/alchemy/mutex.h
+++ b/lib/alchemy/mutex.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,10 +19,9 @@
 #ifndef _ALCHEMY_MUTEX_H
 #define _ALCHEMY_MUTEX_H
 
+#include <alchemy/mutex.h>
 #include <copperplate/cluster.h>
 #include <copperplate/registry.h>
-#include <alchemy/mutex.h>
-#include <alchemy/task.h>
 
 struct alchemy_mutex {
 	unsigned int magic;	/* Must be first. */
diff --git a/lib/alchemy/pipe.c b/lib/alchemy/pipe.c
index a266a380f3991509e0ff5a3b6a4cc9cb4a055268..fdeac9127ece99319aa8ad047cc902c44d973332 100644
--- a/lib/alchemy/pipe.c
+++ b/lib/alchemy/pipe.c
@@ -16,18 +16,14 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <fcntl.h>
-
-#include "rtdm/ipc.h"
+#include "pipe.h"
+#include "boilerplate/ancillaries.h"
+#include "boilerplate/namegen.h"
 #include "copperplate/threadobj.h"
-#include "copperplate/cluster.h"
-#include "reference.h"
 #include "internal.h"
-#include "pipe.h"
-#include "timer.h"
+#include "rtdm/ipc.h"
+
+#include <alchemy/pipe.h>
 
 /**
  * @ingroup alchemy
diff --git a/lib/alchemy/pipe.h b/lib/alchemy/pipe.h
index 48843aff15260b0302c2634074152a6e606ec2a6..ecdbbf96f03d8603f1c9dd61fd83c9928cf0e848 100644
--- a/lib/alchemy/pipe.h
+++ b/lib/alchemy/pipe.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -20,7 +20,6 @@
 #define _ALCHEMY_PIPE_H
 
 #include <copperplate/cluster.h>
-#include <alchemy/pipe.h>
 
 /* Fixed default for MSG_MORE accumulation. */
 #define ALCHEMY_PIPE_STREAMSZ  16384
diff --git a/lib/alchemy/queue.c b/lib/alchemy/queue.c
index 0dba63f2b1146ac049a38d20b70f0fd9c0a3e0cd..1908154778546ecbe046a1adc7a71cb8a1d48e27 100644
--- a/lib/alchemy/queue.c
+++ b/lib/alchemy/queue.c
@@ -16,14 +16,14 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <errno.h>
-#include <string.h>
-#include <copperplate/threadobj.h>
-#include <copperplate/registry-obstack.h>
-#include "reference.h"
-#include "internal.h"
 #include "queue.h"
-#include "timer.h"
+#include "boilerplate/ancillaries.h"
+#include "boilerplate/namegen.h"
+#include "internal.h"
+
+#include <alchemy/queue.h>
+#include <copperplate/registry-obstack.h>
+#include <copperplate/threadobj.h>
 
 /**
  * @ingroup alchemy
diff --git a/lib/alchemy/queue.h b/lib/alchemy/queue.h
index 196a6f1382f2bb76320b1a1c20cf5a39ca0c3d73..d2bd66e7fc5501ac9d7d90ad6b8321dc977e0bc3 100644
--- a/lib/alchemy/queue.h
+++ b/lib/alchemy/queue.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,12 +19,9 @@
 #ifndef _ALCHEMY_QUEUE_H
 #define _ALCHEMY_QUEUE_H
 
-#include <boilerplate/list.h>
-#include <copperplate/syncobj.h>
-#include <copperplate/registry.h>
 #include <copperplate/cluster.h>
 #include <copperplate/heapobj.h>
-#include <alchemy/queue.h>
+#include <copperplate/registry.h>
 
 struct alchemy_queue {
 	unsigned int magic;	/* Must be first. */
diff --git a/lib/alchemy/reference.h b/lib/alchemy/reference.h
index 948aa606d08943348f2d690c06afc965973edd2f..cee5ea6b4fb6b1aa75c43b5150ad30a94c424f4d 100644
--- a/lib/alchemy/reference.h
+++ b/lib/alchemy/reference.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
diff --git a/lib/alchemy/sem.c b/lib/alchemy/sem.c
index e88c6e4d69516d93d67dded76fd9e50230cf5701..86de4a5640806845c1f37c36082306271b6988b8 100644
--- a/lib/alchemy/sem.c
+++ b/lib/alchemy/sem.c
@@ -16,15 +16,14 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <errno.h>
-#include <string.h>
-#include <stdlib.h>
-#include <copperplate/threadobj.h>
-#include <copperplate/registry-obstack.h>
-#include "reference.h"
-#include "internal.h"
 #include "sem.h"
-#include "timer.h"
+#include "boilerplate/ancillaries.h"
+#include "boilerplate/namegen.h"
+#include "internal.h"
+
+#include <alchemy/sem.h>
+#include <copperplate/registry-obstack.h>
+#include <copperplate/threadobj.h>
 
 /**
  * @ingroup alchemy
diff --git a/lib/alchemy/sem.h b/lib/alchemy/sem.h
index ee2ff2fd890375795f4fe751af219c2ceb7b0a2e..a1fab404a78d0689207fea3fdb7da478ca480362 100644
--- a/lib/alchemy/sem.h
+++ b/lib/alchemy/sem.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,10 +19,9 @@
 #ifndef _ALCHEMY_SEM_H
 #define _ALCHEMY_SEM_H
 
-#include <copperplate/semobj.h>
-#include <copperplate/registry.h>
 #include <copperplate/cluster.h>
-#include <alchemy/sem.h>
+#include <copperplate/registry.h>
+#include <copperplate/semobj.h>
 
 struct alchemy_sem {
 	unsigned int magic;	/* Must be first. */
diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
index df5a6da76ad71423200c0d5196355d17df70c70a..2c391a4025dffeeec82824dac775247c8871e197 100644
--- a/lib/alchemy/task.c
+++ b/lib/alchemy/task.c
@@ -10,25 +10,20 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <sched.h>
-#include <pthread.h>
-#include <errno.h>
-#include <string.h>
-
-#include "copperplate/heapobj.h"
-#include "copperplate/internal.h"
-#include "internal.h"
 #include "task.h"
+#include "boilerplate/ancillaries.h"
+#include "boilerplate/namegen.h"
 #include "buffer.h"
-#include "queue.h"
-#include "timer.h"
+#include "copperplate/internal.h"
 #include "heap.h"
+#include "internal.h"
+#include "queue.h"
 
 /**
  * @ingroup alchemy
diff --git a/lib/alchemy/task.h b/lib/alchemy/task.h
index e2e0b60d2ca7be5432906d796ede2640d452fefb..d1c6daab2679cb6c18061fba6ed207daf433d544 100644
--- a/lib/alchemy/task.h
+++ b/lib/alchemy/task.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,15 +19,13 @@
 #ifndef _ALCHEMY_TASK_H
 #define _ALCHEMY_TASK_H
 
-#include <sched.h>
-#include <semaphore.h>
-#include <errno.h>
-#include <boilerplate/list.h>
+#include <alchemy/task.h>
+#include <copperplate/cluster.h>
+#include <copperplate/registry.h>
 #include <copperplate/syncobj.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/registry.h>
-#include <copperplate/cluster.h>
-#include <alchemy/task.h>
+
+#include <sched.h>
 
 struct alchemy_task {
 	char name[XNOBJECT_NAME_LEN];
diff --git a/lib/alchemy/timer.c b/lib/alchemy/timer.c
index 7c08233ed1e7f47ab96ddf91b3389a92f894660e..e44f77fd2199b2a02a32a0f6f94bb67395256a3a 100644
--- a/lib/alchemy/timer.c
+++ b/lib/alchemy/timer.c
@@ -10,14 +10,14 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <alchemy/timer.h>
 #include <copperplate/threadobj.h>
-#include "timer.h"
 
 /**
  * @ingroup alchemy
diff --git a/lib/alchemy/timer.h b/lib/alchemy/timer.h
deleted file mode 100644
index cb0285febbc80af5700d03cf737ebf310fe5d090..0000000000000000000000000000000000000000
--- a/lib/alchemy/timer.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Copyright (C) 2011 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
-
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-
-#ifndef _ALCHEMY_TIMER_H
-#define _ALCHEMY_TIMER_H
-
-#include <copperplate/clockobj.h>
-#include <alchemy/timer.h>
-
-#endif /* _ALCHEMY_TIMER_H */

-- 
2.54.0

