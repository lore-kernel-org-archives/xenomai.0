Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA8372EF1
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221992; cv=none; b=gqSiy/F3e5+foIZSRPgK/YwJ9dwowQcGnDK5H9LpOZ7IbXUX7+nBp6L/5qx/cctVI6QDw7MXUlSmgSfLRrVpBKFOwNMwCFxy04h1E1eCErwIwYdLTjTRWHbOS96557oyuehZ8yASGJdt0Az/zSJ+VRrWA66gVU+FyuGbJS2oRlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221992; c=relaxed/simple;
	bh=5+joBKompsV1RJPwwCTRj19mfNmG8cUgB2I2dazufYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwoErizVelFv+7LJgH5/2kLnrdHjAQBpGfGryphVWvgUjrS4/5HapySlwKVa4bvmdO1aygKCUrqhFDafK95enCbelDNtrjexgNbM0XNKz4As4fZIC87PLWlDS7LxGFyI3R+FB25zHo/9Z4Lm0RfeoCwNEn8ahxYw/ZyzJXE3TIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=OnECHgWi; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="OnECHgWi"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260508062250ca357d143b00020797
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7oBjbUI6xgI5Be7L74UrfjA/1g9y9rpgT0tZCWrxzCs=;
 b=OnECHgWim2Qs6a2OrUwHG3WPmFRNROqHWfK6RYKcbWAEblqQFR4smWXPL5fUuiP+ArN27S
 4Kz7eVe2/xXea350panJ+wO6y2QQ4nFJZ7vsvGWiXj1zclb9vNl5rcdk+kVwpeK6GjLl+WM1
 QNEauc8SsNOJmxzyqMWB247Bn7elD2RFTdpFrrHQCAN5z+lGyV/0QYV6+yl3lp9RReNIvh4u
 jujGSHox2wPp82HOUlZBrlUzF05vUbydI1Ctt95oNELZ5yIqQ+lm2NfgsP6FFKUq/NiSZjKt
 B4lKpwP2nNNniBncXLWfpzRZIPpPcKSyYr5w/orwRmyaTJk5e6vLTwFg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:37 +0200
Subject: [PATCH 04/32] lib/cobalt: Rearrange includes and harmonize license
 headers
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-4-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving from "local to global" should help us to keep headers
self-contained. Some parts of the lib/cobalt were already migrated,
the remaining parts have been migrated now.

While at it: Harmonzie license headers. doxygen reported a warning
while generating the docs.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/arch/arm/features.c                     |  5 +++--
 lib/cobalt/arch/arm/include/asm/xenomai/debug.h    |  3 ++-
 lib/cobalt/arch/arm/include/asm/xenomai/features.h |  1 +
 lib/cobalt/arch/arm/include/asm/xenomai/syscall.h  |  5 +++--
 lib/cobalt/arch/arm64/features.c                   |  5 +++--
 .../arch/arm64/include/asm/xenomai/features.h      |  1 +
 .../arch/arm64/include/asm/xenomai/syscall.h       |  4 ++--
 lib/cobalt/arch/x86/features.c                     | 13 +++++------
 lib/cobalt/arch/x86/include/asm/xenomai/features.h |  1 -
 lib/cobalt/attr.c                                  |  4 ++--
 lib/cobalt/clock.c                                 |  7 +-----
 lib/cobalt/cond.c                                  |  7 +-----
 lib/cobalt/cond.h                                  |  3 +--
 lib/cobalt/current.c                               | 10 ++++-----
 lib/cobalt/current.h                               |  4 +---
 lib/cobalt/init.c                                  | 24 +++++++--------------
 lib/cobalt/internal.c                              | 16 +++++---------
 lib/cobalt/internal.h                              |  8 +++----
 lib/cobalt/malloc-nowrap.c                         |  2 +-
 lib/cobalt/malloc.c                                |  4 ++--
 lib/cobalt/mmap.c                                  |  7 +++---
 lib/cobalt/mq.c                                    |  8 +------
 lib/cobalt/mutex.c                                 |  5 +----
 lib/cobalt/mutex.h                                 |  5 +----
 lib/cobalt/parse_vdso.c                            | 12 ++++-------
 lib/cobalt/printf.c                                | 17 +++------------
 lib/cobalt/rtdm.c                                  |  8 +------
 lib/cobalt/sched.c                                 |  9 +++-----
 lib/cobalt/semaphore.c                             | 10 +++------
 lib/cobalt/signal.c                                |  5 +----
 lib/cobalt/sigshadow.c                             |  7 +++---
 lib/cobalt/thread.c                                |  5 +----
 lib/cobalt/ticks.c                                 |  8 +++----
 lib/cobalt/timer.c                                 |  4 +---
 lib/cobalt/timerfd.c                               |  5 ++---
 lib/cobalt/trace.c                                 |  9 ++++----
 lib/cobalt/umm.c                                   | 18 ++++++----------
 lib/cobalt/umm.h                                   |  2 +-
 lib/cobalt/wrappers.c                              | 25 +++++++---------------
 lib/cobalt/wrappers_time64.c                       |  8 -------
 40 files changed, 104 insertions(+), 200 deletions(-)

diff --git a/lib/cobalt/arch/arm/features.c b/lib/cobalt/arch/arm/features.c
index 4db1e6f9fbf4090c81ee5dc1e30c69d20baad270..32361a7407d6396ba3d10931fd5bf53fb8b9ab2b 100644
--- a/lib/cobalt/arch/arm/features.c
+++ b/lib/cobalt/arch/arm/features.c
@@ -15,13 +15,14 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include "internal.h"
+
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/uapi/fptest.h>
+
 #include <stdio.h>
 #include <string.h>
 
-#include "internal.h"
-
 void cobalt_arch_check_features(struct cobalt_featinfo *finfo)
 {
 }
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/debug.h b/lib/cobalt/arch/arm/include/asm/xenomai/debug.h
index e49b928516ffeb42259bff18b44573471b004175..ffee1366cb1af316a443aed6adbdca5ca863ccd9 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/debug.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/debug.h
@@ -10,9 +10,10 @@
 #ifndef _LIB_COBALT_ARM_DEBUG_H
 #define _LIB_COBALT_ARM_DEBUG_H
 
-#include <signal.h>
 #include "current.h"
 
+#include <signal.h>
+
 static inline int cobalt_avoid_backtrace(int reason)
 {
 	if (reason == SIGDEBUG_MIGRATE_SIGNAL)
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/features.h b/lib/cobalt/arch/arm/include/asm/xenomai/features.h
index e84b80994b645eb157d6d0d8146ab7d55b7ce29d..7819c9b28ad81fb25445296acb976b298f78174e 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/features.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/features.h
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #ifndef _LIB_COBALT_ARM_FEATURES_H
 #define _LIB_COBALT_ARM_FEATURES_H
 
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 1fc605b1ba6f9766f8fe060e16ca767118f906d1..1ac193a00b207edd0c4cceb2930b61cf287db3e2 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -18,12 +18,13 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #ifndef _LIB_COBALT_ARM_SYSCALL_H
 #define _LIB_COBALT_ARM_SYSCALL_H
 
-#include <xeno_config.h>
-#include <errno.h>
 #include <cobalt/uapi/syscall.h>
+#include <errno.h>
+#include <xeno_config.h>
 
 #ifndef __ARM_EABI__
 #error "ARM OABI support has been removed with Xenomai 3.3.x"
diff --git a/lib/cobalt/arch/arm64/features.c b/lib/cobalt/arch/arm64/features.c
index e164865317001674269bd1d2be0d70d02daf64da..347b4aa6f2842c1eea269d488b70cd4f4f9f6602 100644
--- a/lib/cobalt/arch/arm64/features.c
+++ b/lib/cobalt/arch/arm64/features.c
@@ -15,13 +15,14 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include "internal.h"
+
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/uapi/fptest.h>
+
 #include <stdio.h>
 #include <string.h>
 
-#include "internal.h"
-
 void cobalt_arch_check_features(struct cobalt_featinfo *finfo)
 {
 }
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/features.h b/lib/cobalt/arch/arm64/include/asm/xenomai/features.h
index 6dfe64cc4bc8e302f038bcbd179c40d530c6001a..4e65706e3acefeed1fa30d695ea09d388554e955 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/features.h
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/features.h
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #ifndef _LIB_COBALT_ARM64_FEATURES_H
 #define _LIB_COBALT_ARM64_FEATURES_H
 
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
index 5ed9eb252a55b4eb1807472ec7447ae733a1de51..1e5594a404b389f3ba1008550d9667c69e8e7ab7 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
@@ -16,12 +16,12 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #ifndef _LIB_COBALT_ARM64_SYSCALL_H
 #define _LIB_COBALT_ARM64_SYSCALL_H
 
-#include <xeno_config.h>
-#include <errno.h>
 #include <cobalt/uapi/syscall.h>
+#include <xeno_config.h>
 
 #define __xn_syscall_args0
 #define __xn_syscall_args1 , unsigned long __a1
diff --git a/lib/cobalt/arch/x86/features.c b/lib/cobalt/arch/x86/features.c
index 8c5332b9e4d72bafcafda69756c3360066103cd3..826b295a9025c03ec434e5263e24ecbaae436954 100644
--- a/lib/cobalt/arch/x86/features.c
+++ b/lib/cobalt/arch/x86/features.c
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
 
-#include <stdio.h>
-#include <unistd.h>
-#include <string.h>
-#include <boilerplate/atomic.h>
+#include "internal.h"
+
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/uapi/fptest.h>
-#include "internal.h"
+
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
 
 void cobalt_arch_check_features(struct cobalt_featinfo *finfo)
 {
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/features.h b/lib/cobalt/arch/x86/include/asm/xenomai/features.h
index 9a543393268de260195d2082e8679a137dd5322c..344d4a18742645445381e30924cff0acbe938cb5 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/features.h
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/features.h
@@ -19,7 +19,6 @@
 #define _LIB_COBALT_X86_FEATURES_H
 
 #include_next <features.h>
-#include <xeno_config.h>
 #include <asm/xenomai/uapi/features.h>
 
 int cobalt_fp_detect(void);
diff --git a/lib/cobalt/attr.c b/lib/cobalt/attr.c
index 5de2363f78f81d4718f194a155551d72a7df84f9..c4f47b4c39aba16b6516a4a412becaf89c292b43 100644
--- a/lib/cobalt/attr.c
+++ b/lib/cobalt/attr.c
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
 
-#include <pthread.h>
 #include <memory.h>
+#include <pthread.h>
 
 COBALT_IMPL(int, pthread_attr_init, (pthread_attr_t *attr))
 {
diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 9551bd5f1a5be21eaec1f5c611396f545eb84eb2..997bad37d0c2d3c8607ac53e697e4530dcf6f901 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -10,17 +10,12 @@
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
-#include <errno.h>
-#include <pthread.h>
-#include <unistd.h>
-
 #include "internal.h"
 
 /**
diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index fb700f4500a6f1e7a0331954f7a5f5a8a3bf1052..180199c8a030d7ca52f8b275893e21b1a1885fb8 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -10,17 +10,12 @@
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
-#include <pthread.h>
-#include <asm/xenomai/syscall.h>
-
 #include "cond.h"
 #include "current.h"
 #include "internal.h"
diff --git a/lib/cobalt/cond.h b/lib/cobalt/cond.h
index 88b252cb72590b514f95a31c8d8849b3e4f3856f..82bb1bd61f337b5694468378a11aeaeb52e3f11a 100644
--- a/lib/cobalt/cond.h
+++ b/lib/cobalt/cond.h
@@ -13,9 +13,8 @@
 
 #include <asm/xenomai/syscall.h>
 #include <cobalt/uapi/cond.h>
-
-#include <string.h>
 #include <pthread.h>
+#include <string.h>
 
 struct cobalt_cond_cleanup_t {
 	struct cobalt_cond_shadow *cond;
diff --git a/lib/cobalt/current.c b/lib/cobalt/current.c
index 1e1535004b1913dd29b623575c41553e1c928d7e..d5c57681ee5c1eec5c706dac8312c2c39c7014ae 100644
--- a/lib/cobalt/current.c
+++ b/lib/cobalt/current.c
@@ -10,19 +10,17 @@
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
-#include <pthread.h>
-#include <asm/xenomai/syscall.h>
-#include <boilerplate/list.h>
-#include "current.h"
 #include "internal.h"
 
+#include <asm/xenomai/syscall.h>
+#include <string.h>
+
 static DEFINE_PRIVATE_LIST(tsd_hooks);
 
 #ifdef HAVE_TLS
diff --git a/lib/cobalt/current.h b/lib/cobalt/current.h
index 069ee1cc24d7c0b9bf097b83a9e347392847045a..35ccf6301a0d636c957adf00fb002c7c4c4740f3 100644
--- a/lib/cobalt/current.h
+++ b/lib/cobalt/current.h
@@ -18,10 +18,8 @@
 #ifndef _LIB_COBALT_CURRENT_H
 #define _LIB_COBALT_CURRENT_H
 
-#include <stdint.h>
 #include <pthread.h>
-#include <cobalt/uapi/thread.h>
-#include <xeno_config.h>
+#include <stdint.h>
 
 extern pthread_key_t cobalt_current_window_key;
 
diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 84f37999d9f59eddb242b3804c46a29bb711addf..f948b3cabe4a508a0a6df2b655d8cf69000871db 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
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
 
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <stdio.h>
+#include "internal.h"
+#include "umm.h"
+
+#include <asm/xenomai/syscall.h>
+#include <cobalt/tunables.h>
+#include <getopt.h>
 #include <stdlib.h>
 #include <string.h>
-#include <errno.h>
-#include <signal.h>
-#include <getopt.h>
-#include <limits.h>
+#include <sys/mman.h>
 #include <unistd.h>
-#include <stdint.h>
-#include <semaphore.h>
-#include <boilerplate/setup.h>
-#include <cobalt/tunables.h>
-#include <asm/xenomai/syscall.h>
-#include <xenomai/init.h>
-#include "umm.h"
-#include "internal.h"
 
 /**
  * @ingroup cobalt
diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index dd3da08558fc490cebab6954cd72ee7ed8d2b65c..b8380156dcb35aee6f5ddef08f27762968187a4c 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -11,7 +11,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -21,18 +21,12 @@
  * respect to object validity, callers have to take care of this.
  */
 
-#include <sys/types.h>
-#include <stddef.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <signal.h>
-#include <errno.h>
-#include <stdarg.h>
-#include <pthread.h>
-#include <asm/xenomai/syscall.h>
-#include <cobalt/sys/cobalt.h>
 #include "internal.h"
 
+#include <asm/xenomai/syscall.h>
+#include <string.h>
+#include <unistd.h>
+
 int cobalt_extend(unsigned int magic)
 {
 	return XENOMAI_SYSCALL1(sc_cobalt_extend, magic);
diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
index 0703c721758fdc778708cae70a0e9d53c6fb8eef..ad53db400555ca3edfc48457a7542d10823174b6 100644
--- a/lib/cobalt/internal.h
+++ b/lib/cobalt/internal.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -18,12 +18,10 @@
 #ifndef _LIB_COBALT_INTERNAL_H
 #define _LIB_COBALT_INTERNAL_H
 
-#include <limits.h>
-#include <stdbool.h>
-#include <time.h>
+#include "current.h"
+
 #include <boilerplate/ancillaries.h>
 #include <cobalt/sys/cobalt.h>
-#include "current.h"
 
 extern void *cobalt_umm_private;
 
diff --git a/lib/cobalt/malloc-nowrap.c b/lib/cobalt/malloc-nowrap.c
index 6dda7667d5686b821aa52f06c3fd440ac1f46a37..11638bd2dfe929027a972924cb0c507ba38d7dce 100644
--- a/lib/cobalt/malloc-nowrap.c
+++ b/lib/cobalt/malloc-nowrap.c
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
diff --git a/lib/cobalt/malloc.c b/lib/cobalt/malloc.c
index c1585586ef8bd66e1e727bf145c16cc75cf77d10..abdd9bffce42763005db52bd55593a025fa669f6 100644
--- a/lib/cobalt/malloc.c
+++ b/lib/cobalt/malloc.c
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
 
-#include <stdlib.h>
 #include <cobalt/sys/cobalt.h>
+#include <stdlib.h>
 
 /* Memory allocation services */
 COBALT_IMPL(void *, malloc, (size_t size))
diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
index 069163a855348cffafcc610ee0ad866b72c48df4..7be8db1b1eca29d2c78758cb86b9a4c614a786e0 100644
--- a/lib/cobalt/mmap.c
+++ b/lib/cobalt/mmap.c
@@ -11,17 +11,16 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
   USA.
  */
 
-#include <sys/mman.h>
-#include <rtdm/rtdm.h>
-#include <cobalt/uapi/syscall.h>
 #include <asm/xenomai/syscall.h>
+#include <rtdm/rtdm.h>
+#include <sys/mman.h>
 
 COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int flags,
 			     int fd, off64_t offset))
diff --git a/lib/cobalt/mq.c b/lib/cobalt/mq.c
index 0997d396d06e08407741f4b5d6b373284f219f97..e26d4e5d3784cc05d9477403432b83676153ae4e 100644
--- a/lib/cobalt/mq.c
+++ b/lib/cobalt/mq.c
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -18,14 +18,8 @@
 
 #include "mq.h"
 
-#include <asm/xenomai/syscall.h>
-
-#include <errno.h>
 #include <stdarg.h>
-#include <unistd.h>
-#include <fcntl.h>
 #include <pthread.h>
-#include <mqueue.h>
 
 /**
  * @ingroup cobalt_api
diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index edc4e46c065d2dd3695b74923f6758c512ce6909..ff01310f364c4c2860146d055375af94f3ac669e 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -10,20 +10,17 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include "current.h"
 #include "internal.h"
 #include "mutex.h"
 
 #include <asm/xenomai/syscall.h>
 
-#include <pthread.h>
-
 /**
  * @ingroup cobalt_api
  * @defgroup cobalt_api_mutex Mutual exclusion
diff --git a/lib/cobalt/mutex.h b/lib/cobalt/mutex.h
index 728088bf57cf665bcc0fb4aae44561fc131f6790..55d3f843635cecf6e55cdb009838226c75bb3eae 100644
--- a/lib/cobalt/mutex.h
+++ b/lib/cobalt/mutex.h
@@ -8,10 +8,7 @@
 #ifndef _LIB_COBALT_MUTEX_H
 #define _LIB_COBALT_MUTEX_H
 
-#include <boilerplate/ancillaries.h>
-#include <cobalt/uapi/mutex.h>
-
-#include <pthread.h>
+#include <string.h>
 
 extern pthread_mutex_t *const cobalt_autoinit_mutex;
 
diff --git a/lib/cobalt/parse_vdso.c b/lib/cobalt/parse_vdso.c
index 37b997b78f05713abda080df8efc8e6203182833..15328fd5e5bff3d491c336a42c8d6e32fcb76a63 100644
--- a/lib/cobalt/parse_vdso.c
+++ b/lib/cobalt/parse_vdso.c
@@ -15,16 +15,12 @@
  * architecture that has a vDSO.
  */
 
-#include <sys/auxv.h>
-#include <stdbool.h>
-#include <string.h>
-#include <limits.h>
-#include <pthread.h>
-#include <error.h>
-#include <errno.h>
-#include <elf.h>
 #include "internal.h"
 
+#include <error.h>
+#include <string.h>
+#include <sys/auxv.h>
+
 #ifndef ELF_BITS
 # if ULONG_MAX > 0xffffffffUL
 #  define ELF_BITS 64
diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
index bd2d7de56b35def5a5cb7594646f064d6fde12a7..012409ece7a1025647f90bc7f49cf253be7329c8 100644
--- a/lib/cobalt/printf.c
+++ b/lib/cobalt/printf.c
@@ -10,28 +10,17 @@
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
-#include <inttypes.h>
-#include <limits.h>
-#include <pthread.h>
-#include <signal.h>
-#include <stdarg.h>
-#include <stdio.h>
+#include "internal.h"
+
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
 #include <syslog.h>
-#include <boilerplate/atomic.h>
-#include <boilerplate/compiler.h>
-#include <cobalt/tunables.h>
-#include <cobalt/sys/cobalt.h>
-#include "internal.h"
 
 #define RT_PRINT_DEFAULT_BUFFER		16*1024
 #define RT_PRINT_DEFAULT_SYNCDELAY	100 /* ms */
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index df7aa7eb69904f0953be2d324f29d60913916a4a..a62ad89d141ef5b70ca031cc3749239b8087841a 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
@@ -19,17 +19,11 @@
 
 #include "rtdm.h"
 
-#include <asm/xenomai/syscall.h>
-#include <cobalt/uapi/syscall.h>
 #include <rtdm/rtdm.h>
 
 #include <string.h>
 #include <stdarg.h>
-#include <pthread.h>
-#include <fcntl.h>
 #include <stdlib.h>
-#include <sys/socket.h>
-#include <sys/mman.h>
 
 /* support for very old c libraries not supporting O_TMPFILE */
 #ifndef O_TMPFILE
diff --git a/lib/cobalt/sched.c b/lib/cobalt/sched.c
index 6e61ee407f3b385b330adb10865da0de34a48b88..e515ab15d2d38ad70b95b72fbec51bc3fa892d5b 100644
--- a/lib/cobalt/sched.c
+++ b/lib/cobalt/sched.c
@@ -10,19 +10,16 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stddef.h>
-#include <errno.h>
-#include <unistd.h>
-#include <pthread.h>
-#include <asm/xenomai/syscall.h>
 #include "internal.h"
 
+#include <asm/xenomai/syscall.h>
+
 /**
  * @ingroup cobalt_api
  * @defgroup cobalt_api_scheduler Process scheduling
diff --git a/lib/cobalt/semaphore.c b/lib/cobalt/semaphore.c
index 1fe3581df1cb30748ed780e57cd212827dd0f4c9..8ba4fbf349913c184ea894613722e2d77bfa3b26 100644
--- a/lib/cobalt/semaphore.c
+++ b/lib/cobalt/semaphore.c
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -20,12 +20,8 @@
 
 #include <asm/xenomai/syscall.h>
 
-#include <stdlib.h>		/* For malloc & free. */
-#include <stdarg.h>
-#include <errno.h>
-#include <fcntl.h>		/* For O_CREAT. */
-#include <pthread.h>		/* For pthread_setcanceltype. */
-#include <semaphore.h>
+#include <fcntl.h>	/* For O_CREAT. */
+#include <stdlib.h>	/* For malloc & free. */
 
 /**
  * @ingroup cobalt_api
diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
index b5c0865e95eb571f3bbf67ce29ffc73b9ddf11ef..3efba964dddea815942aacb31756e572df07f5b1 100644
--- a/lib/cobalt/signal.c
+++ b/lib/cobalt/signal.c
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -18,9 +18,6 @@
 
 #include <asm/xenomai/syscall.h>
 
-#include <stdlib.h>
-#include <errno.h>
-#include <fcntl.h>
 #include <pthread.h>
 #include <signal.h>
 
diff --git a/lib/cobalt/sigshadow.c b/lib/cobalt/sigshadow.c
index b98e4a1d5549f2eb9cb76822dc55080bafb21861..1204d7c075331ccfc04c3585acfb62918023c36e 100644
--- a/lib/cobalt/sigshadow.c
+++ b/lib/cobalt/sigshadow.c
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
 
-#include <pthread.h>
-#include <signal.h>
+#include "internal.h"
+
 #include <asm/xenomai/debug.h>
 #include <asm/xenomai/syscall.h>
-#include "internal.h"
 
 #if !HAVE_BACKTRACE
 static inline int backtrace(void **buffer, int size)
diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
index 264fd6dda90e9afb82f5d6b7a7294928db6e598e..efc74ebfe60feec777cac704a29999bc8d53c7c3 100644
--- a/lib/cobalt/thread.c
+++ b/lib/cobalt/thread.c
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -21,10 +21,7 @@
 #include <asm/xenomai/syscall.h>
 
 #include <string.h>
-#include <errno.h>
 #include <unistd.h>
-#include <pthread.h>
-#include <semaphore.h>
 
 /**
  * @ingroup cobalt_api
diff --git a/lib/cobalt/ticks.c b/lib/cobalt/ticks.c
index 214f2a1a841a0588df2a485d37e1ba3554e51301..8faafd93ed7e880c5abe04a703cd4ab256506963 100644
--- a/lib/cobalt/ticks.c
+++ b/lib/cobalt/ticks.c
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
 
-#include <cobalt/arith.h>
-#include <cobalt/ticks.h>
-#include <asm/xenomai/time.h>
 #include "internal.h"
 
+#include <asm/xenomai/time.h>
+#include <cobalt/arith.h>
+
 /*
  * If we have no fast path via the vDSO for reading timestamps, ask
  * the Cobalt core.
diff --git a/lib/cobalt/timer.c b/lib/cobalt/timer.c
index 0294953f8e69b63e55fe06fe4f7bbbd2b72a1e8d..87dd77d5bf3e7bc58518d9a5a59aed0e68d52c8c 100644
--- a/lib/cobalt/timer.c
+++ b/lib/cobalt/timer.c
@@ -10,14 +10,12 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include "internal.h"
-
 #include <asm/xenomai/syscall.h>
 
 #include <errno.h>
diff --git a/lib/cobalt/timerfd.c b/lib/cobalt/timerfd.c
index 5fa1f1eaa3902293c81600431fb2d97557c671d2..f1da64fa08158dab77eb7238896d7c5450fb9ea8 100644
--- a/lib/cobalt/timerfd.c
+++ b/lib/cobalt/timerfd.c
@@ -10,16 +10,15 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <asm/xenomai/syscall.h>
 #include <errno.h>
 #include <sys/timerfd.h>
-#include <asm/xenomai/syscall.h>
-#include "internal.h"
 
 COBALT_IMPL(int, timerfd_create, (int clockid, int flags))
 {
diff --git a/lib/cobalt/trace.c b/lib/cobalt/trace.c
index 8d9c1890253d2b6233d9f3472f5ac366ad8b2ba8..f59c0e02250dfb84ea6fb3bed3549b58228b9443 100644
--- a/lib/cobalt/trace.c
+++ b/lib/cobalt/trace.c
@@ -10,17 +10,18 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <asm/xenomai/syscall.h>
+#include <cobalt/trace.h>
+#include <cobalt/uapi/kernel/trace.h>
+
 #include <errno.h>
 #include <stdio.h>
-#include <cobalt/uapi/kernel/trace.h>
-#include <cobalt/trace.h>
-#include <asm/xenomai/syscall.h>
 
 int xntrace_max_begin(unsigned long v)
 {
diff --git a/lib/cobalt/umm.c b/lib/cobalt/umm.c
index 6b4303b7270f7cdc12a2b1b09930876ad615d7ed..78d8c4153f1f23b40b200ca345a884b2177a564a 100644
--- a/lib/cobalt/umm.c
+++ b/lib/cobalt/umm.c
@@ -10,25 +10,21 @@
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
-#include <sys/ioctl.h>
-#include <sys/mman.h>
-#include <errno.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <pthread.h>
-#include <rtdm/rtdm.h>
-#include <cobalt/uapi/kernel/heap.h>
 #include "umm.h"
 #include "internal.h"
 
+#include <cobalt/uapi/kernel/heap.h>
+#include <rtdm/rtdm.h>
+
+#include <string.h>
+#include <sys/mman.h>
+
 void *cobalt_umm_private = NULL;
 
 void *cobalt_umm_shared = NULL;
diff --git a/lib/cobalt/umm.h b/lib/cobalt/umm.h
index a298e83695d2ba0c2b7190700a0a3798db880c11..d5769524d0688f687bd06a646552e574ad2f975a 100644
--- a/lib/cobalt/umm.h
+++ b/lib/cobalt/umm.h
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index 3a0063f0515a79908d899eaa55f324ce5f73e9d9..16ced2260175c70f47579fd9c6b1e659954466fe 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -21,27 +21,18 @@
  * wrapped. These are fallback functions for __real* functions used by
  * the library itself.
  */
-#include <xeno_config.h>
-#include <sys/types.h>
-#include <sys/stat.h>
+
+#include <fcntl.h>
+#include <malloc.h>
+#include <pthread.h>
+#include <semaphore.h>
+#include <signal.h>
+#include <stdio.h>
 #include <sys/ioctl.h>
-#include <sys/select.h>
 #include <sys/socket.h>
 #include <sys/time.h>
-#include <stdio.h>
-#include <stdarg.h>
-#include <stdlib.h>
-#include <signal.h>
 #include <syslog.h>
-#include <pthread.h>
-#include <semaphore.h>
-#include <limits.h>
-#include <fcntl.h>
-#include <sched.h>
-#include <memory.h>
 #include <unistd.h>
-#include <malloc.h>
-#include <boilerplate/compiler.h>
 
 /* support for very old c libraries not supporting O_TMPFILE */
 #ifndef O_TMPFILE
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index 024d227046833ca8be6b8941ef99e8442c20e009..ebbb36af4d0da7265fee5b7a9df78ec4ef9aa51d 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -14,21 +14,13 @@
  */
 
 #include "cond.h"
-#include "internal.h"
 #include "mq.h"
 #include "mutex.h"
 #include "rtdm.h"
 
-#include <asm/xenomai/syscall.h>
-#include <cobalt/uapi/syscall.h>
 #include <rtdm/rtdm.h>
 
-#include <errno.h>
-#include <mqueue.h>
-#include <pthread.h>
-#include <sys/socket.h>
 #include <sys/time.h>
-#include <time.h>
 
 #if defined(__USE_TIME_BITS64) || __WORDSIZE == 64 ||                          \
 	(defined(__SYSCALL_WORDSIZE) && __SYSCALL_WORDSIZE == 64)

-- 
2.54.0

