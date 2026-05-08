Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4336C9CC
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221990; cv=none; b=ks2xWmefQA0QvvNnIMvPVh+ZZOU9IVzhpOWf792fcn8OFQEwtUwgTGXhE2ZT/eHLGSbdv0QmjKo85xloTlaq14mf0VoWbVRU9FFQ3nk8ynvHbsOAg71ye8A4ay4AatAybsHo5ZXdtkE98Hklo5WzF5SYudHeF06hM64Z4BbM6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221990; c=relaxed/simple;
	bh=SVA9txWE4g7lPhplpHodWna/5xZplLsCkp7ORWujL74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m42wko5up/yLzm6BDr9JtfWRcTUCHToFQdgeRm9Km4M1COxny+bUjyf/5WpDUsA7SynAO0Ki5b0bOd2+fiw34WFjCB8TlfNMlpV5Bn1TiMVSDKmrRcBC6MUYZCo6tRlodelD0etkpeQEso17kHNUZVRaSQ6sw5mHzn6DDiveKsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=EtEiE//h; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="EtEiE//h"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260508062249457975da84000207e8
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=94auRuw9Ugs2L5f3PG15SFfil2QjTzKt7GaEgVC8t0w=;
 b=EtEiE//hWFdV/HqpqcWkISagIu680Lk0kwSR8ud1X2IlX2ftpVR1keqQ5obh8SluOANadW
 NTMUxET8kEG6K8fGXo6q9YCCE9i06HdzeuTY9ECgMqI9C2JWE7856qE91pUYHEsXYYcI3dJQ
 +qAZRtzsIl4QYvZKjI82O9FrrSHtU/ztDDYe9f4BplY7m5IDGJm5J/cAEdQ1B0iUid91P42U
 VqByNMh8D7EnnTLfXJe2IeBx3MoqxpmQBGqFSpiDuWXUqBq/v89Lt3zW0ryCFU2E4z5jKIru
 6Ecc4f6+JqA1nI7FTOxZFZQjdM1p1nesae9VwT/fiI+PmdBIZd2RZNCg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:35 +0200
Subject: [PATCH 02/32] lib/analogy: Rearrange includes and harmonize
 license headers
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-2-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving to "from local to global" should help us to keep headers
self-contained. Some parts of the codebase were already migrated,
lib/analogy was still missing.

While at it: Harmonzie license headers. doxygen reported a warning
while generating the docs.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/analogy/async.c       |  6 +++---
 lib/analogy/calibration.c | 18 ++++++++----------
 lib/analogy/calibration.h |  4 +++-
 lib/analogy/descriptor.c  |  7 ++++---
 lib/analogy/info.c        |  6 +++---
 lib/analogy/internal.h    |  3 ++-
 lib/analogy/math.c        | 10 +++-------
 lib/analogy/range.c       |  4 ++--
 lib/analogy/root_leaf.h   |  4 +---
 lib/analogy/sync.c        |  7 +++----
 lib/analogy/sys.c         |  5 +++--
 11 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/lib/analogy/async.c b/lib/analogy/async.c
index 39d2109ab49c546f16eb7f7bdb9fd527fc205002..2632a180010dc71469a79c18199fd440ab1e74ce 100644
--- a/lib/analogy/async.c
+++ b/lib/analogy/async.c
@@ -14,16 +14,16 @@
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
-#include <rtdm/analogy.h>
 #include "internal.h"
 
+#include <rtdm/analogy.h>
+
 /**
  * @ingroup analogy_lib_level1
  * @defgroup analogy_lib_async1 Asynchronous acquisition API
diff --git a/lib/analogy/calibration.c b/lib/analogy/calibration.c
index 7ae5ef61c7b8706bd17c11b59392ded13ab9c0e0..9876e3f73d15a311a90866beba1e0978fb6bf7a1 100644
--- a/lib/analogy/calibration.c
+++ b/lib/analogy/calibration.c
@@ -14,22 +14,20 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <math.h>
-#include <rtdm/analogy.h>
-#include <stdio.h>
-#include <errno.h>
-#include "iniparser/iniparser.h"
-#include "boilerplate/ancillaries.h"
 #include "calibration.h"
+#include "boilerplate/ancillaries.h"
+#include "iniparser/iniparser.h"
+
+#include <math.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <unistd.h>
 
 #define CHK(func, ...)								\
 do {										\
diff --git a/lib/analogy/calibration.h b/lib/analogy/calibration.h
index 5d881b51c65af9b373f2a08ae5d1ef0dd50924e1..8bd7210b411f780add1f5e7953af69fda7629687 100644
--- a/lib/analogy/calibration.h
+++ b/lib/analogy/calibration.h
@@ -13,7 +13,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -22,6 +22,8 @@
 #ifndef __ANALOGY_CALIBRATION_H__
 #define __ANALOGY_CALIBRATION_H__
 
+#include <rtdm/analogy.h>
+
 /*
  * internal definitions between the xenomai utils and the library.
  * no need to expose them to the USER
diff --git a/lib/analogy/descriptor.c b/lib/analogy/descriptor.c
index de3ef9e99bdd12cd2ecaeb3a72d7c1398d5ca099..a4be8ea9468bc57e2df580672972d932187e4c96 100644
--- a/lib/analogy/descriptor.c
+++ b/lib/analogy/descriptor.c
@@ -14,17 +14,18 @@
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
-#include <rtdm/analogy.h>
 #include "internal.h"
 #include "root_leaf.h"
 
+#include <rtdm/analogy.h>
+#include <string.h>
+
 #ifndef DOXYGEN_CPP
 
 static void a4l_root_setup(a4l_root_t * rt,
diff --git a/lib/analogy/info.c b/lib/analogy/info.c
index a68e4a33f89d12b894c2301b60a6e8a6045dca93..a2602a18e45e62897a9a0d850d1a0f83d3cf2052 100644
--- a/lib/analogy/info.c
+++ b/lib/analogy/info.c
@@ -13,16 +13,16 @@
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
-#include <rtdm/analogy.h>
 #include "internal.h"
 
+#include <rtdm/analogy.h>
+
 #ifndef DOXYGEN_CPP
 
 int a4l_sys_devinfo(int fd, a4l_dvinfo_t * info)
diff --git a/lib/analogy/internal.h b/lib/analogy/internal.h
index da8b6585bf3384fa1cd0d2f215e53328990952ad..9d0584022a1caeab71fdaa32fef11437749e09b2 100644
--- a/lib/analogy/internal.h
+++ b/lib/analogy/internal.h
@@ -13,11 +13,12 @@
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
 #ifndef __ANALOGY_LIB_INTERNAL__
 #define __ANALOGY_LIB_INTERNAL__
 
diff --git a/lib/analogy/math.c b/lib/analogy/math.c
index 8a26d2e1deedb4732afd802afddd9c6c5674e272..8c1ea5ded491c4581e157f04407edb78f0c2d0e4 100644
--- a/lib/analogy/math.c
+++ b/lib/analogy/math.c
@@ -1,5 +1,3 @@
-#include <math.h>
-
 /*
  * Copyright (C) 2014 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
  *
@@ -12,18 +10,16 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stdlib.h>
 #include <errno.h>
-#include <string.h>
-#include <assert.h>
-
+#include <math.h>
 #include <rtdm/analogy.h>
+#include <stdlib.h>
 
 struct vec {
 	unsigned dim;
diff --git a/lib/analogy/range.c b/lib/analogy/range.c
index 573bde32768dc382b4eb817508c3bd616247a7e0..1ccfc955345a0f4dc8db9003b6b1347d7221bf1d 100644
--- a/lib/analogy/range.c
+++ b/lib/analogy/range.c
@@ -14,14 +14,14 @@
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
 #include "internal.h"
+
 #include <rtdm/analogy.h>
 
 #ifndef DOXYGEN_CPP
diff --git a/lib/analogy/root_leaf.h b/lib/analogy/root_leaf.h
index 6c58001855932ae01d7f27049fc0281373f91a15..3690b5ff69522afb6e7a65c52ec87aed5fc854c0 100644
--- a/lib/analogy/root_leaf.h
+++ b/lib/analogy/root_leaf.h
@@ -14,7 +14,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -25,8 +25,6 @@
 
 #ifndef DOXYGEN_CPP
 
-#include <errno.h>
-
 struct a4l_leaf {
 	unsigned int id;
 	unsigned int nb_leaf;
diff --git a/lib/analogy/sync.c b/lib/analogy/sync.c
index fee5fc9e20636a7e5923c802fa1563a7fdbc5038..95bc2c75b892f4d30a41cf20f073b421320a5c10 100644
--- a/lib/analogy/sync.c
+++ b/lib/analogy/sync.c
@@ -14,17 +14,16 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stdarg.h>
-#include <errno.h>
-#include <rtdm/analogy.h>
 #include "internal.h"
 
+#include <rtdm/analogy.h>
+
 /*!
  * @ingroup analogy_lib
  * @defgroup analogy_lib_level1 Level 1 API
diff --git a/lib/analogy/sys.c b/lib/analogy/sys.c
index 165c41d7907d4276eeab98e6445995937a19e2b4..710b2d2ffbbe5afb12dcbe195679e94884129dd2 100644
--- a/lib/analogy/sys.c
+++ b/lib/analogy/sys.c
@@ -14,7 +14,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -37,9 +37,10 @@
  * This interface should not be used directly by applications.
  */
 
-#include <rtdm/analogy.h>
 #include "internal.h"
 
+#include <rtdm/analogy.h>
+
 /*!
  * @ingroup analogy_lib_syscall
  * @defgroup analogy_lib_core Basic Syscall API

-- 
2.54.0

