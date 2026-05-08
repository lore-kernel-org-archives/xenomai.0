Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBDE35DA6F
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221385; cv=none; b=iK6MRQcrf9BfuHKI6cXsrD9yNw47FxN8/DskHJAroQmkqKohF+IhrestXZjda6nQBXuuzt5IOeDTrBnCbe7mFY5/IQgznVp3Ly01V4qFyrDDHyS0cplutYHOJA+lZh9xlYaDjjepd99vQHWeV/XR0cOF2zVPVH83LJ+szqRblhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221385; c=relaxed/simple;
	bh=+zC7xxK+lo+y7cRifz/t09RbPtHx//iPMAFjpaakxzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sR52R8ulM4k3z1tbN9HdPOWQHv+wqhwjA/5MEbuC2c6PcWbWc/cEm1kMJoi73xxDbWA8p/gK49ewdJORsqmYaJVkB/QFTHzT8T1vagEQlk1OtEKdkdVRYtfSiJoym5keK9cSuM9kch9scT7qSmD8KOMXfW3YGsK90HjrqtPl518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=kgjq4UvI; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="kgjq4UvI"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202605080622511455eb1e4800020752
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OZEEZKfXqnI0C3nO8WTcH5MdPlQrbcKC6GuehcNfd+Q=;
 b=kgjq4UvICa/kXURZBv/rjiwOMg2kEJBO+5pp0eA62SjXQ0twGwhnD0qf2YitBKN4VANynG
 h3Dbv6SEI1O0BbrMlvAyT5gdgavEWEoGXPAWFA/T6BlMA4wqfGtsAynpdF9lKFIEk6QUuoQO
 YN0aB9QfO8NKDYHt9QotXNsp+xGyGkQbpftaMVL4fIvEX9RMDNxrA6z87skcRdjG51y1V0h4
 T/UAj93yNYkuIqMWuf5FRIVwzG/elUXham/087g0Wdi9qPFIr2+msZeiwk5baBM8SImxq4tX
 tfFyIR0unaWDpIswA4rWJ7Mr2/AMK+eMMLw61JeiaZXPeT4KntPQsmlg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:38 +0200
Subject: [PATCH 05/32] lib/psos: Rearrange includes and harmonize license
 headers
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-5-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving from "local to global" should help us to keep headers
self-contained. Preparation for migrating lib/copperplate.

While at it: Harmonzie license headers. doxygen reported a warning
while generating the docs.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/psos/init.c      | 22 ++++++++++------------
 lib/psos/internal.h  |  3 ++-
 lib/psos/pt.c        | 11 +++++------
 lib/psos/pt.h        |  5 +----
 lib/psos/queue.c     | 14 +++++---------
 lib/psos/queue.h     |  5 +----
 lib/psos/reference.h |  2 +-
 lib/psos/rn.c        | 13 +++++++------
 lib/psos/rn.h        |  7 +++----
 lib/psos/sem.c       | 18 ++++++------------
 lib/psos/sem.h       |  5 ++---
 lib/psos/task.c      | 20 ++++++--------------
 lib/psos/task.h      |  7 +++----
 lib/psos/tm.c        |  9 ++++-----
 lib/psos/tm.h        |  3 ---
 15 files changed, 56 insertions(+), 88 deletions(-)

diff --git a/lib/psos/init.c b/lib/psos/init.c
index 0d8733436c810a11b59aff761aa8d7240f9a9938..6adfd019fef061189df1e17d626da14e1e1ce41f 100644
--- a/lib/psos/init.c
+++ b/lib/psos/init.c
@@ -10,25 +10,23 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+*
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <getopt.h>
-#include <xenomai/init.h>
-#include <copperplate/registry.h>
-#include <copperplate/clockobj.h>
-
-#include "tm.h"
-#include "task.h"
-#include "sem.h"
-#include "queue.h"
 #include "pt.h"
+#include "queue.h"
 #include "rn.h"
+#include "sem.h"
+#include "task.h"
+#include "tm.h"
+
+#include <copperplate/registry.h>
+#include <xenomai/init.h>
+
+#include <getopt.h>
 
 /**
  * @defgroup psos pSOS&reg; emulator
diff --git a/lib/psos/internal.h b/lib/psos/internal.h
index 0e5f108797bc4b1e133e6b8cbc75ca24c1cf58e9..0b223685284563eed6038be919bff5d6621a9676 100644
--- a/lib/psos/internal.h
+++ b/lib/psos/internal.h
@@ -10,11 +10,12 @@
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
 #ifndef _PSOS_INTERNAL_H
 #define _PSOS_INTERNAL_H
 
diff --git a/lib/psos/pt.c b/lib/psos/pt.c
index 244d341a458955ca789eb92f735872d2b56896fe..82900199a86f9e4c3750bf8d26bdea8247734b2d 100644
--- a/lib/psos/pt.c
+++ b/lib/psos/pt.c
@@ -10,20 +10,19 @@
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
+#include "pt.h"
+#include "internal.h"
+
 #include <boilerplate/ancillaries.h>
-#include <boilerplate/lock.h>
-#include <copperplate/cluster.h>
 #include <psos/psos.h>
 
-#include "internal.h"
-#include "pt.h"
+#include <stdio.h>
 
 #define pt_magic	0x8181fefe
 
diff --git a/lib/psos/pt.h b/lib/psos/pt.h
index e61899d89b90538ec8ddbc782f4a82c5c0d7af85..bc58beda96b2306c524669b3f73039731d8ffb6d 100644
--- a/lib/psos/pt.h
+++ b/lib/psos/pt.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,9 +19,6 @@
 #ifndef _PSOS_PT_H
 #define _PSOS_PT_H
 
-#include <sys/types.h>
-#include <pthread.h>
-#include <boilerplate/hash.h>
 #include <copperplate/cluster.h>
 
 struct psos_pt {
diff --git a/lib/psos/queue.c b/lib/psos/queue.c
index a88d64be1acf40c35edcb8a3630e8f311d379977..f4835002fad8dcec1b2251b391e5bfefcd5350dd 100644
--- a/lib/psos/queue.c
+++ b/lib/psos/queue.c
@@ -10,24 +10,20 @@
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
-#include <errno.h>
+#include "queue.h"
+#include "internal.h"
+#include "tm.h"
+
 #include <boilerplate/ancillaries.h>
 #include <copperplate/threadobj.h>
-#include <copperplate/cluster.h>
 #include <psos/psos.h>
 
-#include "internal.h"
-#include "reference.h"
-#include "queue.h"
-#include "tm.h"
-
 #define queue_magic	0x8181fdfd
 
 struct cluster psos_queue_table;
diff --git a/lib/psos/queue.h b/lib/psos/queue.h
index 8a364b1acf0aa2f8eff6155cd4ede52ad116f771..bf6823588d159f076d5d4f6d2620a25404f656b8 100644
--- a/lib/psos/queue.h
+++ b/lib/psos/queue.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,9 +19,6 @@
 #ifndef _PSOS_QUEUE_H
 #define _PSOS_QUEUE_H
 
-#include <sys/types.h>
-#include <boilerplate/hash.h>
-#include <copperplate/syncobj.h>
 #include <copperplate/cluster.h>
 
 #define Q_VARIABLE  0x40000000
diff --git a/lib/psos/reference.h b/lib/psos/reference.h
index eed4a6641264dc08194cc00c747cc3d2767e616a..71dfefdff1ceae67da9454c607b438bcc3433456 100644
--- a/lib/psos/reference.h
+++ b/lib/psos/reference.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
diff --git a/lib/psos/rn.c b/lib/psos/rn.c
index 4a09faebddfb28220129285a9550034cd8906b2b..49ce920cd41b70fb7fefaf9f2aa76bb3b6bce547 100644
--- a/lib/psos/rn.c
+++ b/lib/psos/rn.c
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
 
-#include <stdio.h>
-#include <errno.h>
+#include "internal.h"
+#include "tm.h"
+#include "rn.h"
+
 #include <boilerplate/ancillaries.h>
 #include <copperplate/threadobj.h>
 #include <psos/psos.h>
 
-#include "internal.h"
-#include "tm.h"
-#include "rn.h"
+#include <stdio.h>
+#include <errno.h>
 
 #define rn_magic	0x8181efef
 
diff --git a/lib/psos/rn.h b/lib/psos/rn.h
index 1a026a0db48430eef935a82047ee1cfb05d0f386..cf8f40d19d4af61e5348797b4297f94f0533fd85 100644
--- a/lib/psos/rn.h
+++ b/lib/psos/rn.h
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
 #ifndef _PSOS_RN_H
 #define _PSOS_RN_H
 
-#include <boilerplate/hash.h>
-#include <copperplate/syncobj.h>
-#include <copperplate/heapobj.h>
 #include <copperplate/cluster.h>
+#include <copperplate/heapobj.h>
+#include <copperplate/syncobj.h>
 
 struct psos_rn {
 	unsigned int magic;		/* Must be first. */
diff --git a/lib/psos/sem.c b/lib/psos/sem.c
index 2e3376a5d81e705b20b4f545988ad05f2436e0fc..c4a388ab44a8981d661a70d7591d1cf2bf9a65cc 100644
--- a/lib/psos/sem.c
+++ b/lib/psos/sem.c
@@ -10,25 +10,19 @@
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
-#include <errno.h>
-#include <string.h>
-#include <boilerplate/ancillaries.h>
-#include <copperplate/heapobj.h>
-#include <copperplate/cluster.h>
-#include <copperplate/clockobj.h>
-#include <copperplate/semobj.h>
-
-#include "reference.h"
 #include "sem.h"
-#include "tm.h"
 #include "internal.h"
+#include "tm.h"
+
+#include <boilerplate/ancillaries.h>
+#include <copperplate/clockobj.h>
+#include <copperplate/heapobj.h>
 #include <psos/psos.h>
 
 #define sem_magic	0x8181fbfb
diff --git a/lib/psos/sem.h b/lib/psos/sem.h
index e572e22b5c3ea1c096ecb206432d4bf13e4a9222..31aa5b64da171631b504416ebef0f24324cd1266 100644
--- a/lib/psos/sem.h
+++ b/lib/psos/sem.h
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
 #ifndef _PSOS_SEM_H
 #define _PSOS_SEM_H
 
-#include <boilerplate/hash.h>
-#include <copperplate/semobj.h>
 #include <copperplate/cluster.h>
+#include <copperplate/semobj.h>
 
 struct psos_sem {
 	unsigned int magic;		/* Must be first. */
diff --git a/lib/psos/task.c b/lib/psos/task.c
index 6415dd035b2b00578ef4a062c53161e5a67b444f..880f178ca3a309d4fd54d645e93c6a8ca9a19aa4 100644
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -10,30 +10,22 @@
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
-#include <errno.h>
-#include <string.h>
-#include <pthread.h>
-#include <sched.h>
-
+#include "task.h"
 #include "boilerplate/namegen.h"
-#include "copperplate/heapobj.h"
-#include "copperplate/threadobj.h"
-#include "copperplate/syncobj.h"
-#include "copperplate/cluster.h"
 #include "copperplate/internal.h"
-#include "psos/psos.h"
 #include "internal.h"
-#include "task.h"
-#include "tm.h"
+#include "psos/psos.h"
 #include "queue.h"
 #include "rn.h"
+#include "tm.h"
+
+#include <boilerplate/ancillaries.h>
 
 union psos_wait_union {
 	struct psos_queue_wait queue_wait;
diff --git a/lib/psos/task.h b/lib/psos/task.h
index 43173a6b84ed2d304a9ad2a0c19eab704f010f3a..789e2f65a0033f402d96fcb9fa60df9ce9363275 100644
--- a/lib/psos/task.h
+++ b/lib/psos/task.h
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
 #ifndef _PSOS_TASK_H
 #define _PSOS_TASK_H
 
-#include <boilerplate/hash.h>
-#include <copperplate/threadobj.h>
-#include <copperplate/syncobj.h>
 #include <copperplate/cluster.h>
+#include <copperplate/syncobj.h>
+#include <copperplate/threadobj.h>
 
 struct psos_task_args {
 	void (*entry)(u_long a0, u_long a1, u_long a2, u_long a3);
diff --git a/lib/psos/tm.c b/lib/psos/tm.c
index 09cb47f6e6f48f4b68039541f23fbdb8c7d05ecb..2c9c076dd4ec8b88a8d3b42f61768ac8a83fabcf 100644
--- a/lib/psos/tm.c
+++ b/lib/psos/tm.c
@@ -10,17 +10,16 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <memory.h>
-#include <copperplate/threadobj.h>
-#include <psos/psos.h>
-#include "task.h"
 #include "tm.h"
+#include "task.h"
+
+#include <psos/psos.h>
 
 struct clockobj psos_clock;
 
diff --git a/lib/psos/tm.h b/lib/psos/tm.h
index 49e9793f676e53611426227ec40c002699e03bf8..7b2baede8fdff186d19401e41d0a7544f7f4fbdb 100644
--- a/lib/psos/tm.h
+++ b/lib/psos/tm.h
@@ -19,9 +19,6 @@
 #ifndef _PSOS_TM_H
 #define _PSOS_TM_H
 
-#include <sys/types.h>
-#include <time.h>
-#include <boilerplate/list.h>
 #include <copperplate/timerobj.h>
 
 struct psos_tm {

-- 
2.54.0

