Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5250352C5B
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221385; cv=none; b=SEKVrVpZtFekrCRop51yqwJZwntIhmy8+9z1jTKUV0km4BVvn8vyXjUPdxwuQRctpfGrPyHHT3oL5TWdYS44F/YnKSUr8TD2z3gAHSh6PP6O6SduYnLtZvttdiEXprZZdsHDmxOzvf7s/oSzhYwIXBMc7JzhWAAO9SbV/MvxS+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221385; c=relaxed/simple;
	bh=+mkk0VU94O0ObAQuwunEKJFEaLg9PbiQQC6e/1ZHB5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cicFhemyxyujfW07gEk60i6gkxOjXTh+CRGC/vDgBfLRQKAOel0oebxbiM99ZNabADCGaIvQhPl1NcYjtxKCR3yMKrxv6lpicFxRPO14+/JErkuXeY3sS2oDsFDrPiStwKlQlZOgAy5cJP8BKaIsUaCbhtor3/odYdeINWc2TE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IGLFp+i2; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IGLFp+i2"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202605080622492a04943f6a000207e4
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=njlfT/Ap+gs1JusNI8x9Cg5THA258GcZZHcMak8uLy0=;
 b=IGLFp+i25DEzdnrNO5Kmo7rqSZrADNseQKdYkd9YDBHoKPAoWHNTMOLuoNtwhZx1DHv2RT
 n4yTy7C/gIAStk2TnKgLm90qBU3SuXx1NXlql7CIzXKads9PFDoPVFK867v6i8DVvB+vznBx
 vSfp3xNTQyDWDNSzYb0ePkACJZvCNyFt1hLjt3yItniZPSwkkkO0yepkJvtAS45kiwrJGMKY
 SVqxgGXArgjs1MjW9YSOW2nIA5sf8X0Sqh0VKnhciNbFQPJ0Dpd2VDrUk5v1DcL6Nu5m4X+H
 dapBTfbY3KPD1jjmxCzDt2QIn6DOPgc8PZsZ4r/zfJthO7GUIL0Y2JMw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:36 +0200
Subject: [PATCH 03/32] lib/boilerplate: Rearrange includes and harmonize
 license headers
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-3-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving from "local to global" should help us to keep headers
self-contained. Some parts of the codebase were already migrated,
lib/boilerplate was still missing.

While at it: Harmonzie license headers. doxygen reported a warning
while generating the docs.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/boilerplate/ancillaries.c          | 30 +++++++++++-------------------
 lib/boilerplate/debug.c                | 12 +++---------
 lib/boilerplate/hash.c                 |  5 +----
 lib/boilerplate/heapmem.c              |  9 ++-------
 lib/boilerplate/iniparser/dictionary.c |  2 --
 lib/boilerplate/iniparser/dictionary.h |  2 --
 lib/boilerplate/iniparser/iniparser.c  |  5 +++--
 lib/boilerplate/iniparser/iniparser.h  |  4 ----
 lib/boilerplate/init/bootstrap.c       |  7 +++----
 lib/boilerplate/obstack.c              |  9 ++-------
 lib/boilerplate/setup.c                | 19 +++++--------------
 lib/boilerplate/time.c                 |  2 +-
 lib/boilerplate/tlsf/target.h          |  3 ++-
 lib/boilerplate/tlsf/tlsf.h            |  2 --
 lib/boilerplate/version.c              |  9 ++++-----
 15 files changed, 37 insertions(+), 83 deletions(-)

diff --git a/lib/boilerplate/ancillaries.c b/lib/boilerplate/ancillaries.c
index 9ca55a6bc27ef1d448968565eb0dcc06adf20474..a6d35f8f16c593edbf7199b978d37ad0947adec2 100644
--- a/lib/boilerplate/ancillaries.c
+++ b/lib/boilerplate/ancillaries.c
@@ -10,33 +10,25 @@
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
-#include <sys/syscall.h>
-#include <stdio.h>
-#include <time.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <pthread.h>
-#include <sched.h>
-#include <unistd.h>
-#include <ctype.h>
-#include <string.h>
-#include <errno.h>
-#include <limits.h>
-#include <malloc.h>
-#include "boilerplate/atomic.h"
+#include "boilerplate/ancillaries.h"
 #include "boilerplate/lock.h"
-#include "boilerplate/time.h"
+#include "boilerplate/namegen.h"
 #include "boilerplate/setup.h"
-#include "boilerplate/ancillaries.h"
 #include "boilerplate/signal.h"
-#include "boilerplate/namegen.h"
+#include "boilerplate/time.h"
+
+#include <ctype.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <unistd.h>
 
 pthread_mutex_t __printlock;
 
diff --git a/lib/boilerplate/debug.c b/lib/boilerplate/debug.c
index f6df6c61261b29f8255589cb89706c17abbcebbd..21b0b32e67f775d9421cf628fb408d81d0f1922e 100644
--- a/lib/boilerplate/debug.c
+++ b/lib/boilerplate/debug.c
@@ -10,24 +10,18 @@
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
-#include <stdio.h>
-#include <stdarg.h>
-#include <unistd.h>
-#include <assert.h>
-#include <pthread.h>
-#include <malloc.h>
-
 #include "boilerplate/ancillaries.h"
 #include "boilerplate/lock.h"
 #include "boilerplate/signal.h"
 
+#include <malloc.h>
+
 static pthread_key_t btkey;
 
 static struct backtrace_data main_btd = {
diff --git a/lib/boilerplate/hash.c b/lib/boilerplate/hash.c
index 055332c7e906f6b4cb7cb4ce9722a123262ff343..f967d3b950e36206bec420daa5c8d97b74f60055 100644
--- a/lib/boilerplate/hash.c
+++ b/lib/boilerplate/hash.c
@@ -10,15 +10,12 @@
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
-
 #include "boilerplate/lock.h"
 #include "boilerplate/hash.h"
 
diff --git a/lib/boilerplate/heapmem.c b/lib/boilerplate/heapmem.c
index 8050eb7abd33b4208634237ac1fc6626b882208e..b606155021f79b7cd3b62bc7abe62bd683f1c606 100644
--- a/lib/boilerplate/heapmem.c
+++ b/lib/boilerplate/heapmem.c
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
@@ -24,15 +24,10 @@
  * fast allocation bitmap to manage their blocks internally.
  */
 
-#include <sys/types.h>
-#include <assert.h>
-#include <errno.h>
-#include <stdio.h>
+#include <boilerplate/heapmem.h>
 #include <stdbool.h>
 #include <string.h>
 
-#include <boilerplate/heapmem.h>
-
 enum heapmem_pgtype {
 	page_free =0,
 	page_cont =1,
diff --git a/lib/boilerplate/iniparser/dictionary.c b/lib/boilerplate/iniparser/dictionary.c
index 7985ab3fcda95325e7208d0967d8c9f6e8e882fe..ef418db7e763e23cdf3656bb32dc6c249e4af2e1 100644
--- a/lib/boilerplate/iniparser/dictionary.c
+++ b/lib/boilerplate/iniparser/dictionary.c
@@ -15,8 +15,6 @@
  ---------------------------------------------------------------------------*/
 #include "dictionary.h"
 
-#include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 
 /** Maximum value size for integers and doubles. */
diff --git a/lib/boilerplate/iniparser/dictionary.h b/lib/boilerplate/iniparser/dictionary.h
index d04b6ce715d91efc2fd0f57b2f5e962ed4ac49c9..4b8ec9f85ae3182abdaff4dbc6151216dd19e3fa 100644
--- a/lib/boilerplate/iniparser/dictionary.h
+++ b/lib/boilerplate/iniparser/dictionary.h
@@ -20,8 +20,6 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
 
 #ifdef __cplusplus
 extern "C" {
diff --git a/lib/boilerplate/iniparser/iniparser.c b/lib/boilerplate/iniparser/iniparser.c
index f1d1658962275a00d22ba37de7c0cf5cb7df2dd6..be012181a105a3c3311d225c72d306f1f2b3c7cf 100644
--- a/lib/boilerplate/iniparser/iniparser.c
+++ b/lib/boilerplate/iniparser/iniparser.c
@@ -7,10 +7,11 @@
 */
 /*--------------------------------------------------------------------------*/
 /*---------------------------- Includes ------------------------------------*/
-#include <ctype.h>
-#include <stdarg.h>
 #include "iniparser.h"
 
+#include <ctype.h>
+#include <string.h>
+
 /*---------------------------- Defines -------------------------------------*/
 #define ASCIILINESZ         (1024)
 #define INI_INVALID_KEY     ((char*)-1)
diff --git a/lib/boilerplate/iniparser/iniparser.h b/lib/boilerplate/iniparser/iniparser.h
index 37ff7b71b209db797539f94bc1b968678c0c83f0..a87737b2598fd561370324b317a6756615b77266 100644
--- a/lib/boilerplate/iniparser/iniparser.h
+++ b/lib/boilerplate/iniparser/iniparser.h
@@ -14,10 +14,6 @@
                                 Includes
  ---------------------------------------------------------------------------*/
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-
 /*
  * The following #include is necessary on many Unixes but not Linux.
  * It is not needed for Windows platforms.
diff --git a/lib/boilerplate/init/bootstrap.c b/lib/boilerplate/init/bootstrap.c
index d77f4eb5cf5323fce9ac3f56b3ea244e4f5c176a..95bc19d2798eba98463fbae7be3ca0665a02efbe 100644
--- a/lib/boilerplate/init/bootstrap.c
+++ b/lib/boilerplate/init/bootstrap.c
@@ -39,17 +39,16 @@
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
-#include <unistd.h>
+#include <fcntl.h>
 #include <stdlib.h>
 #include <string.h>
-#include <fcntl.h>
+#include <unistd.h>
 #include <xenomai/init.h>
 
 static int early_argc;
diff --git a/lib/boilerplate/obstack.c b/lib/boilerplate/obstack.c
index fab62ce5b6fa8a5f39d3471ed43d1f0d9338685d..701c8262c412671e19343938e082a32221e925eb 100644
--- a/lib/boilerplate/obstack.c
+++ b/lib/boilerplate/obstack.c
@@ -18,15 +18,10 @@
    Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.  */
 
-
-#include <xeno_config.h>
 #include <boilerplate/obstack.h>
-
-/* Use this obstack implementation unconditionally.  */
-
-#include <stdio.h>
-#include <stddef.h>
 #include <stdint.h>
+#include <stdio.h>
+#include <xeno_config.h>
 
 /* Determine default alignment.  */
 union fooround
diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 7bb24f6f4a17851feb34e0c7f9a9bfbee52622f7..95e495510cfdd7aaae8ec53d289d30bce23b061e 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -10,28 +10,19 @@
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
-#include <sched.h>
+#include <boilerplate/lock.h>
+#include <ctype.h>
 #include <getopt.h>
-#include <string.h>
-#include <errno.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
-#include <ctype.h>
-#include <malloc.h>
-#include <stdarg.h>
-#include <stdio.h>
-#include <assert.h>
-
-#include <xeno_config.h>
-#include <boilerplate/lock.h>
-#include <boilerplate/ancillaries.h>
 #include <xenomai/init.h>
 
 struct base_setup_data __base_setup_data = {
diff --git a/lib/boilerplate/time.c b/lib/boilerplate/time.c
index b9f5174c42c9337bf192d567f3089604b885453d..a1ba0995f286ab621072af6eec2482a4f8d953ec 100644
--- a/lib/boilerplate/time.c
+++ b/lib/boilerplate/time.c
@@ -10,7 +10,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
diff --git a/lib/boilerplate/tlsf/target.h b/lib/boilerplate/tlsf/target.h
index 27fdd2de782d44d105c9f46e976bb2ad3900804c..e85c26de876292ec53c34f786039b0cccbe5695a 100644
--- a/lib/boilerplate/tlsf/target.h
+++ b/lib/boilerplate/tlsf/target.h
@@ -18,9 +18,10 @@
 #ifndef _TARGET_H_
 #define _TARGET_H_
 
-#include <pthread.h>
 #include "boilerplate/wrappers.h"
 
+#include <pthread.h>
+
 #define TLSF_MLOCK_T            pthread_mutex_t
 #define TLSF_CREATE_LOCK(l)     __RT(pthread_mutex_init (l, NULL))
 #define TLSF_DESTROY_LOCK(l)    __RT(pthread_mutex_destroy(l))
diff --git a/lib/boilerplate/tlsf/tlsf.h b/lib/boilerplate/tlsf/tlsf.h
index aac4769c88abe9ef736b23251d85b8a36a126f59..d7c7275a96505fc60082b3d78b26a51b623f5ee7 100644
--- a/lib/boilerplate/tlsf/tlsf.h
+++ b/lib/boilerplate/tlsf/tlsf.h
@@ -19,8 +19,6 @@
 #ifndef _TLSF_H_
 #define _TLSF_H_
 
-#include <sys/types.h>
-
 /* A basic heap size which won't be rejected by init_memory_pool(). */
 #define MIN_TLSF_HEAPSZ 65536
 
diff --git a/lib/boilerplate/version.c b/lib/boilerplate/version.c
index 03af13cadec2df881bf1c25bf2beef539145ed8d..965cfa1308ee2f5b06f00380df776a44cd8bf7cc 100644
--- a/lib/boilerplate/version.c
+++ b/lib/boilerplate/version.c
@@ -10,15 +10,17 @@
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
 #include "git-stamp.h"
 
+#include <stdio.h>
+#include <string.h>
+
 #ifndef GIT_STAMP
 #define devel_suffix  ""
 #else
@@ -36,9 +38,6 @@ const char *xenomai_version_string = PACKAGE_NAME \
 
 #ifdef __PROGRAM__
 
-#include <stdio.h>
-#include <string.h>
-
 int main(int argc, char *const argv[])
 {
 	int ret = puts(xenomai_version_string) == EOF;

-- 
2.54.0

