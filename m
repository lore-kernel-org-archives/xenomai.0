Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9BB3783AC
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221991; cv=none; b=MkmBPc2wdHd9VbsFUhks7dXboeqwKNoKAtDy8LBaEuFumLORlTtI9XlHDLE0Qfz5nCCaG/kd7DFKvTP/qj8gHez/EbpxeizhXUWdrQt+UL97ZJQCKLX1xMBW0QMH4L7SOOIqBT8gSN1LBa0/cI4r9TjLAY8Q+qVEZbtfR6Ou7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221991; c=relaxed/simple;
	bh=X3bVsVmGdiz5EX5GsFlBv3NHI4B4IeJPMKkwsCd6/Vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aCJxrLdWyLjNksok7SRsRhbEgXnuvxmfP4huWSEcH6juaKit5GRmwEPFJy4QbMjurBDM9xDyf33BaKuanJzv08AVAolBQ0Qz+lhP3AGI25+PnKpHMy7sqMMd31ZapTfYkwsLfSRNu9kEacDiTOG8Mfsbya2dGictH6YF8nHkwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=GLEPztqS; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="GLEPztqS"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260508062252f4038d36880002071c
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=F3zW6qh6MNX8ltm7glR87Qpbuc6aeS4cTbR3mZWAh50=;
 b=GLEPztqSkYFPRjbw7lc+0Y5VUes2U8FAZSPnrPDg6eCbOY1W8QmQ1qrTpviUNE3Ru7uOJi
 Z/fpBFwoCkEYnUktdLf7+Fqi+pGC2r9O+CB61ucAE8qQaIySrJ0iJCrwjCUr0ldEwTjb+XIU
 LK9mG4j6zINKPJoB3GqgjtrDMHBzBwWUBQfve4ydrzM4ID55ukqWZh3rpK9g07l9sd4dpLjF
 R5AB3obLEv1N5NY0J6Yq9dw2RE6OrcBFthhGtFJ1ZTYQIyxzh1QBOHgV0wpqbldJ3afOieZ/
 +KPa4wP+ah8LRrk/y0YfHYfgH+XBOOOntXB36TrWQPzN7OWEQ0uX+36Q==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:39 +0200
Subject: [PATCH 06/32] lib/vxworks: Rearrange includes and harmonize
 license headers
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-6-e449f2bd4fc2@siemens.com>
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
 lib/vxworks/errnoLib.c    |  8 +++-----
 lib/vxworks/init.c        | 13 +++++--------
 lib/vxworks/intLib.c      |  2 +-
 lib/vxworks/kernLib.c     |  8 ++++----
 lib/vxworks/lstLib.c      |  2 +-
 lib/vxworks/memPartLib.c  | 13 +++----------
 lib/vxworks/memPartLib.h  |  2 +-
 lib/vxworks/msgQLib.c     | 16 ++++------------
 lib/vxworks/msgQLib.h     |  4 ++--
 lib/vxworks/reference.h   |  2 +-
 lib/vxworks/rngLib.c      | 41 ++++++++++++++++++++---------------------
 lib/vxworks/rngLib.h      |  4 +---
 lib/vxworks/semLib.c      | 15 +++++----------
 lib/vxworks/semLib.h      |  3 +--
 lib/vxworks/sysLib.c      |  6 +++---
 lib/vxworks/taskHookLib.c |  9 ++++-----
 lib/vxworks/taskHookLib.h |  3 ++-
 lib/vxworks/taskInfo.c    |  9 +++------
 lib/vxworks/taskLib.c     | 19 +++++++------------
 lib/vxworks/taskLib.h     |  6 +++---
 lib/vxworks/tickLib.c     |  7 +++----
 lib/vxworks/tickLib.h     |  2 +-
 lib/vxworks/wdLib.c       | 11 ++++-------
 lib/vxworks/wdLib.h       |  3 +--
 24 files changed, 83 insertions(+), 125 deletions(-)

diff --git a/lib/vxworks/errnoLib.c b/lib/vxworks/errnoLib.c
index 66c91e2dd1d7ac93711026eab08b776c5fa7ea7e..276c91d4638900260e1f0b4255c672afb8124e24 100644
--- a/lib/vxworks/errnoLib.c
+++ b/lib/vxworks/errnoLib.c
@@ -10,18 +10,16 @@
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
-#include <string.h>
-#include <vxworks/errnoLib.h>
-
 #include "taskLib.h"
 
+#include <vxworks/errnoLib.h>
+
 void printErrno(int status)
 {
 	const char *msg;
diff --git a/lib/vxworks/init.c b/lib/vxworks/init.c
index 4a68c9d7f7af780a226c501fd6351f11cb0f2422..f63d94e93c0de95a51e2b0649ec329b74bd9212a 100644
--- a/lib/vxworks/init.c
+++ b/lib/vxworks/init.c
@@ -10,22 +10,19 @@
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
-#include <getopt.h>
-#include <xenomai/init.h>
-#include <vxworks/errnoLib.h>
-
 #include "tickLib.h"
 #include "taskLib.h"
 
+#include <xenomai/init.h>
+
+#include <getopt.h>
+
 /**
  * @defgroup vxworks VxWorks&reg; emulator
  *
diff --git a/lib/vxworks/intLib.c b/lib/vxworks/intLib.c
index cf07b221dcaa5ac66dfabedb337d277a9a01e6dc..cf2801a855ca1b2792ee088967e810bf5c265465 100644
--- a/lib/vxworks/intLib.c
+++ b/lib/vxworks/intLib.c
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
diff --git a/lib/vxworks/kernLib.c b/lib/vxworks/kernLib.c
index 112f2d2eb1a11d8dc92ceb55e698ec75ee10ff03..3c94732285985b075bbbd59bdbcdc705cb017336 100644
--- a/lib/vxworks/kernLib.c
+++ b/lib/vxworks/kernLib.c
@@ -10,18 +10,18 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <vxworks/kernLib.h>
-#include <vxworks/errnoLib.h>
-
 #include "tickLib.h"
 #include "taskLib.h"
 
+#include <vxworks/kernLib.h>
+#include <vxworks/errnoLib.h>
+
 static int switch_slicing(struct threadobj *thobj, struct timespec *quantum)
 {
 	struct sched_param_ex param_ex;
diff --git a/lib/vxworks/lstLib.c b/lib/vxworks/lstLib.c
index 0daa86444ca547bdedfb6e812b6a281e18835bec..2f602b8eee883fd81a892010a890dc8d6b06b6cd 100644
--- a/lib/vxworks/lstLib.c
+++ b/lib/vxworks/lstLib.c
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
diff --git a/lib/vxworks/memPartLib.c b/lib/vxworks/memPartLib.c
index f3efb0d3653a02dfa744d9eb9cf6aba3911c3b2a..4067e5121613c0387c59496efa92ba503a28a008 100644
--- a/lib/vxworks/memPartLib.c
+++ b/lib/vxworks/memPartLib.c
@@ -10,23 +10,16 @@
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
-#include <stdlib.h>
-#include <memory.h>
-#include <boilerplate/lock.h>
+#include "memPartLib.h"
+
 #include <boilerplate/ancillaries.h>
-#include <copperplate/heapobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/memPartLib.h>
-
-#include "memPartLib.h"
 
 #define mempart_magic	0x5a6b7c8d
 
diff --git a/lib/vxworks/memPartLib.h b/lib/vxworks/memPartLib.h
index f2cd00ac2f4f4ba27ac69c60976b2f2c7d3bddc6..c907f930cf4e4972786deaa47161d2f23b7b5ddb 100644
--- a/lib/vxworks/memPartLib.h
+++ b/lib/vxworks/memPartLib.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
diff --git a/lib/vxworks/msgQLib.c b/lib/vxworks/msgQLib.c
index 7b3d59afed3fa587a8fba5572d40cf27dd379ac9..281ff4f817b1ad847a94ddf20ec3a546e48b034b 100644
--- a/lib/vxworks/msgQLib.c
+++ b/lib/vxworks/msgQLib.c
@@ -10,26 +10,18 @@
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
-#include <stdlib.h>
-#include <assert.h>
-#include <memory.h>
-#include <copperplate/heapobj.h>
-#include <copperplate/threadobj.h>
-#include <vxworks/errnoLib.h>
-
-#include "reference.h"
-#include "taskLib.h"
 #include "msgQLib.h"
 #include "tickLib.h"
 
+#include <copperplate/threadobj.h>
+#include <vxworks/errnoLib.h>
+
 /*
  * XXX: In order to keep the following services callable from
  * non-VxWorks tasks (but still Xenomai ones, though), make sure
diff --git a/lib/vxworks/msgQLib.h b/lib/vxworks/msgQLib.h
index 817e90d9cc319f8ad5ebf47b28360ad650ffb7e7..61f1be7fbd0af224d9d77499ec890d819b3df5bc 100644
--- a/lib/vxworks/msgQLib.h
+++ b/lib/vxworks/msgQLib.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,8 +19,8 @@
 #ifndef _VXWORKS_MSGQLIB_H
 #define _VXWORKS_MSGQLIB_H
 
-#include <copperplate/syncobj.h>
 #include <copperplate/heapobj.h>
+#include <copperplate/syncobj.h>
 #include <vxworks/msgQLib.h>
 
 struct wind_mq {
diff --git a/lib/vxworks/reference.h b/lib/vxworks/reference.h
index 94456fa73bcabc0ed8ef15d926e06585aa27606d..43088c6aa5e53079567743f5b0e0172c6c806898 100644
--- a/lib/vxworks/reference.h
+++ b/lib/vxworks/reference.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
diff --git a/lib/vxworks/rngLib.c b/lib/vxworks/rngLib.c
index 343d71baa4865537d9dc1bf4133627789bd7d90e..c06096d3e2052d20e56c8affea8ac53464613c2b 100644
--- a/lib/vxworks/rngLib.c
+++ b/lib/vxworks/rngLib.c
@@ -1,28 +1,27 @@
 /*
-* Copyright (C) 2008 Niklaus Giger <niklaus.giger@member.fsf.org>.
-*
-* This library is free software; you can redistribute it and/or
-* modify it under the terms of the GNU Lesser General Public
-* License as published by the Free Software Foundation; either
-* version 2 of the License, or (at your option) any later version.
-*
-* This library is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-* Lesser General Public License for more details.
-
-* You should have received a copy of the GNU Lesser General Public
-* License along with this library; if not, write to the Free Software
-* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
-*/
-
-#include <stdlib.h>
-#include <boilerplate/lock.h>
-#include <copperplate/heapobj.h>
-#include <vxworks/errnoLib.h>
+ * Copyright (C) 2008 Niklaus Giger <niklaus.giger@member.fsf.org>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
 
 #include "rngLib.h"
 
+#include <copperplate/heapobj.h>
+#include <vxworks/errnoLib.h>
+#include <vxworks/rngLib.h>
+
 #define ring_magic 0x5432affe
 
 static struct wind_ring *find_ring_from_id(RING_ID rid)
diff --git a/lib/vxworks/rngLib.h b/lib/vxworks/rngLib.h
index 947c5eaf71098678a78375e843c00e8ae1a5f82a..bae642438e7d2da47568b5c0ae493ce6758cef1e 100644
--- a/lib/vxworks/rngLib.h
+++ b/lib/vxworks/rngLib.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,8 +19,6 @@
 #ifndef _VXWORKS_RNGLIB_H
 #define _VXWORKS_RNGLIB_H
 
-#include <vxworks/rngLib.h>
-
 struct wind_ring {
 	unsigned int magic;
 	unsigned int bufSize;
diff --git a/lib/vxworks/semLib.c b/lib/vxworks/semLib.c
index f2abf0f839ec115d2387bab182587fe173c93f67..0cbb5096eee07a08e6a058277891a854472a31ba 100644
--- a/lib/vxworks/semLib.c
+++ b/lib/vxworks/semLib.c
@@ -10,24 +10,19 @@
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
-#include <stdlib.h>
-#include <limits.h>
+#include "semLib.h"
+#include "taskLib.h"
+#include "tickLib.h"
+
 #include <boilerplate/ancillaries.h>
-#include <copperplate/heapobj.h>
 #include <vxworks/errnoLib.h>
 
-#include "reference.h"
-#include "taskLib.h"
-#include "semLib.h"
-#include "tickLib.h"
 
 /*
  * XXX: In order to keep the following services callable from
diff --git a/lib/vxworks/semLib.h b/lib/vxworks/semLib.h
index f863bf0194f87b95504147cf7710e2ef528bf229..6e4863436e66d847bb90c5c8bba8cdc39d869516 100644
--- a/lib/vxworks/semLib.h
+++ b/lib/vxworks/semLib.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,7 +19,6 @@
 #ifndef _VXWORKS_SEMLIB_H
 #define _VXWORKS_SEMLIB_H
 
-#include <pthread.h>
 #include <copperplate/syncobj.h>
 #include <vxworks/semLib.h>
 
diff --git a/lib/vxworks/sysLib.c b/lib/vxworks/sysLib.c
index 57999db66ffb15921321ac792c0715c5d5003511..b495fa67ea9deb44e47e802c14462329eba79113 100644
--- a/lib/vxworks/sysLib.c
+++ b/lib/vxworks/sysLib.c
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
 
+#include "tickLib.h"
+
 #include <vxworks/errnoLib.h>
 #include <vxworks/sysLib.h>
 
-#include "tickLib.h"
-
 int sysClkRateGet(void)
 {
 	unsigned int resolution;
diff --git a/lib/vxworks/taskHookLib.c b/lib/vxworks/taskHookLib.c
index 8953063d320610450b34028524739d387cb6ec6f..06bba7161c2b09b9253f74a41e5c408f3b6ff0b2 100644
--- a/lib/vxworks/taskHookLib.c
+++ b/lib/vxworks/taskHookLib.c
@@ -10,19 +10,18 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <copperplate/heapobj.h>
-#include <vxworks/taskHookLib.h>
-#include <vxworks/errnoLib.h>
-
 #include "taskLib.h"
 #include "taskHookLib.h"
 
+#include <vxworks/errnoLib.h>
+#include <vxworks/taskHookLib.h>
+
 DEFINE_PRIVATE_LIST(wind_create_hooks);
 
 DEFINE_PRIVATE_LIST(wind_delete_hooks);
diff --git a/lib/vxworks/taskHookLib.h b/lib/vxworks/taskHookLib.h
index c3f9c8d1b0d3f19c3593344c785e154930105b04..cb0f81aa80b61cc235452d0370f50e96ad678135 100644
--- a/lib/vxworks/taskHookLib.h
+++ b/lib/vxworks/taskHookLib.h
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
 #ifndef _VXWORKS_TASKHOOKLIB_H
 #define _VXWORKS_TASKHOOKLIB_H
 
diff --git a/lib/vxworks/taskInfo.c b/lib/vxworks/taskInfo.c
index c10bf27bf45ced0d0df322f6f8adbd04c67ce6b6..0cfb7bf25a5de4f2106face65380a9e87b1cb3f0 100644
--- a/lib/vxworks/taskInfo.c
+++ b/lib/vxworks/taskInfo.c
@@ -10,21 +10,18 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <pthread.h>
-#include <string.h>
+#include "taskLib.h"
+
 #include <boilerplate/ancillaries.h>
-#include <copperplate/threadobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/taskInfo.h>
 
-#include "taskLib.h"
-
 const char *taskName(TASK_ID task_id)
 {
 	struct wind_task *task;
diff --git a/lib/vxworks/taskLib.c b/lib/vxworks/taskLib.c
index ffef7c832289f853bd763d2000caa05d69ea9d56..2c42c371b614803f827b19d375a400fdde4110fb 100644
--- a/lib/vxworks/taskLib.c
+++ b/lib/vxworks/taskLib.c
@@ -10,28 +10,23 @@
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
-#include <stdlib.h>
-#include <pthread.h>
-#include <fcntl.h>
-#include <sched.h>
-#include "taskLib.h"
-#include "tickLib.h"
-#include "msgQLib.h"
-#include "taskHookLib.h"
 #include "boilerplate/namegen.h"
 #include "copperplate/internal.h"
 #include "copperplate/registry-obstack.h"
+#include "msgQLib.h"
+#include "taskHookLib.h"
+#include "taskLib.h"
+#include "tickLib.h"
 #include "vxworks/errnoLib.h"
 
+#include <boilerplate/ancillaries.h>
+
 union wind_wait_union {
 	struct wind_queue_wait queue_wait;
 };
diff --git a/lib/vxworks/taskLib.h b/lib/vxworks/taskLib.h
index c8d15dd58ba6877e180c7661727b4fca9ddabd4b..f7fa19519df4e44012f649f492a845e9f6a116c5 100644
--- a/lib/vxworks/taskLib.h
+++ b/lib/vxworks/taskLib.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -19,9 +19,9 @@
 #ifndef _VXWORKS_TASKLIB_H
 #define _VXWORKS_TASKLIB_H
 
-#include <copperplate/threadobj.h>
-#include <copperplate/registry.h>
 #include <copperplate/cluster.h>
+#include <copperplate/registry.h>
+#include <copperplate/threadobj.h>
 #include <vxworks/taskLib.h>
 
 struct wind_task_args {
diff --git a/lib/vxworks/tickLib.c b/lib/vxworks/tickLib.c
index ac8dcda2cd443f234e8de409a87cac788902154f..c44bd4c012fb9239183c6fb2f65a1043cf639f20 100644
--- a/lib/vxworks/tickLib.c
+++ b/lib/vxworks/tickLib.c
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
 
-#include <boilerplate/lock.h>
-#include <vxworks/tickLib.h>
-
 #include "tickLib.h"
 
+#include <vxworks/tickLib.h>
+
 struct clockobj wind_clock;
 
 ULONG tickGet(void)
diff --git a/lib/vxworks/tickLib.h b/lib/vxworks/tickLib.h
index 2ddbf42abaa0c49b4f0411a5fda1675694fdeefd..04804d29fc63c980ed6c9e5ed0c071bbf0ce0f00 100644
--- a/lib/vxworks/tickLib.h
+++ b/lib/vxworks/tickLib.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
diff --git a/lib/vxworks/wdLib.c b/lib/vxworks/wdLib.c
index 55a83084552ddb8a28d72e97d44fcb96d39c60d5..63b5bd60baf2127ec514068c03834377e4fdeb13 100644
--- a/lib/vxworks/wdLib.c
+++ b/lib/vxworks/wdLib.c
@@ -21,16 +21,13 @@
  * available in all processes).
  */
 
-#include <errno.h>
-#include <stdlib.h>
-#include <memory.h>
-#include <copperplate/heapobj.h>
-#include <copperplate/threadobj.h>
-#include <vxworks/errnoLib.h>
-
 #include "wdLib.h"
 #include "tickLib.h"
 
+#include <copperplate/threadobj.h>
+#include <vxworks/errnoLib.h>
+#include <vxworks/wdLib.h>
+
 #define wd_magic	0x3a4b5c6d
 
 static struct wind_wd *get_wd(WDOG_ID wdog_id)
diff --git a/lib/vxworks/wdLib.h b/lib/vxworks/wdLib.h
index 4bc16a20e15780a357da8ccbceb9d3df3e23a1ef..c59ec7882ec36f03513278861abbbd9502d35b9e 100644
--- a/lib/vxworks/wdLib.h
+++ b/lib/vxworks/wdLib.h
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
 #define _VXWORKS_WDLIB_H
 
 #include <copperplate/timerobj.h>
-#include <vxworks/wdLib.h>
 
 struct wind_wd {
 

-- 
2.54.0

