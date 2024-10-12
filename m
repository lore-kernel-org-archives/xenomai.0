Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7115443F
	for <xenomai@lists.linux.dev>; Sat, 12 Oct 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728816; cv=none; b=RCC+uRkVqdaBd7dTaKaVU5k5qbm/PDBtAZbYudj4OTOe2FBvF/toR1QNxgqO0k1bySR+SNy1/rRJ6+wx/tws7eM3Y/uEMOGA4duG9uB5h98ji4oBE+r5A4waSSHVC1lwXtMR9cJV5jArmpD9+BTW5YiX6yUQHtFmCS5wIFfYs7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728816; c=relaxed/simple;
	bh=fRrYOhBLT4uTd2Zgh5dezjyLpjv9AZe6WxcQQ2fZFJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eyFcDIL6bgy7RWrrcl59/Fvgq7oDps0CU+W9Z5x5TpOct+61nRaEN2/pH3L7srotuh33K5Ys2yT8ZfxcAtLA43b70SGyIA2b+zuzvCuYsdcTdVhY6m9dlDB6CzKmzPUAs0dRywrBelcWw38EY/S6ehLujGyoBGiXCpJURb7D+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=jUsgUNwV; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="jUsgUNwV"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2024101210264307c865d957180265da
        for <xenomai@lists.linux.dev>;
        Sat, 12 Oct 2024 12:26:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KlO7c6eKOv3D8aZRywrFHFE5qyittzuTh1NgeV8hcuE=;
 b=jUsgUNwVmwQenPbv+TYZUSao6C3eLIaXXh6yoFrBcxaQnHCHeIWOQdFxm6mlNT/prO5gCE
 HEouErJbZhzCFLs3muQIPeOfmcVAy1l1ryhJfDiEQojpQ/IN4oK7/5yFCrRhHH46ravzf0Sj
 OhN/lEyNuUhspFQDs8wQouRgK4X4fH9/qNBmq9bb2YBd77B9ZF1oK8p3SGEYWZekthJR+R2S
 8nf8p4nL6DFvx+pIIMM2y84VEkQtwzSMQHbdKuO7pA0a6Jqwfj7+WW9oLeFJqBDxCyvno5R5
 j03LRP1k/rCPRuoS28iQnGom1W2+ffxnXFqaIob9/WvDc75zKYF845ww==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Sat, 12 Oct 2024 12:26:40 +0200
Subject: [PATCH 1/7] testsuite/smokey: Cleanup of unused includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-flo-cleanup-before-release-v1-1-df05bfa0ac80@siemens.com>
References: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
In-Reply-To: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Clara Kowalsky <clara.kowalsky@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

No functional change intended. Helps to speed up the build a bit.

As most files had a blank line between the license header and the
first include this pattern has been applied where necessary.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/alchemytests/sem-2.c            | 1 +
 testsuite/smokey/alchemytests/task-11.c          | 1 -
 testsuite/smokey/arith/arith-noinline.c          | 2 --
 testsuite/smokey/bufp/bufp.c                     | 2 +-
 testsuite/smokey/cpu-affinity/cpu-affinity.c     | 3 +--
 testsuite/smokey/dlopen/dlopen.c                 | 6 +-----
 testsuite/smokey/dlopen/dlopentest.c             | 3 +--
 testsuite/smokey/dlopen/libalchemy-test.c        | 3 +--
 testsuite/smokey/dlopen/libposix-test.c          | 2 +-
 testsuite/smokey/gdb/gdb.c                       | 2 +-
 testsuite/smokey/iddp/iddp.c                     | 2 +-
 testsuite/smokey/leaks/leaks.c                   | 4 +---
 testsuite/smokey/main.c                          | 3 ++-
 testsuite/smokey/memcheck/memcheck.c             | 2 +-
 testsuite/smokey/memory-coreheap/coreheap.c      | 1 +
 testsuite/smokey/memory-heapmem/heapmem.c        | 1 +
 testsuite/smokey/memory-pshared/pshared.c        | 1 +
 testsuite/smokey/memory-tlsf/tlsf.c              | 1 +
 testsuite/smokey/net_common/server.c             | 4 ----
 testsuite/smokey/net_common/smokey_net_server.c  | 3 ---
 testsuite/smokey/net_packet_dgram/packet_dgram.c | 3 ---
 testsuite/smokey/net_packet_raw/packet_raw.c     | 1 -
 testsuite/smokey/posix-clock/posix-clock.c       | 4 +---
 testsuite/smokey/posix-cond/posix-cond.c         | 4 +---
 testsuite/smokey/posix-fork/posix-fork.c         | 4 +---
 testsuite/smokey/posix-mutex/posix-mutex.c       | 3 +--
 testsuite/smokey/posix-select/posix-select.c     | 5 +----
 testsuite/smokey/psostests/pt-1.c                | 1 -
 testsuite/smokey/psostests/rn-1.c                | 1 -
 testsuite/smokey/rtdm/rtdm.c                     | 1 +
 testsuite/smokey/sched-quota/sched-quota.c       | 3 +--
 testsuite/smokey/sched-tp/sched-tp.c             | 6 +-----
 testsuite/smokey/setsched/setsched.c             | 2 +-
 testsuite/smokey/sigdebug/Makefile.am            | 2 +-
 testsuite/smokey/timerfd/timerfd.c               | 2 +-
 testsuite/smokey/tsc/tsc.c                       | 5 -----
 testsuite/smokey/vxworkstests/lst-1.c            | 1 -
 testsuite/smokey/vxworkstests/msgQ-1.c           | 1 -
 testsuite/smokey/vxworkstests/msgQ-2.c           | 1 -
 testsuite/smokey/vxworkstests/msgQ-3.c           | 1 -
 testsuite/smokey/vxworkstests/rng-1.c            | 2 --
 testsuite/smokey/vxworkstests/sem-1.c            | 1 -
 testsuite/smokey/vxworkstests/sem-2.c            | 1 -
 testsuite/smokey/vxworkstests/sem-3.c            | 1 -
 testsuite/smokey/vxworkstests/task-1.c           | 1 -
 testsuite/smokey/vxworkstests/task-2.c           | 2 --
 testsuite/smokey/vxworkstests/wd-1.c             | 1 -
 testsuite/smokey/x86io/x86io.c                   | 2 +-
 testsuite/smokey/xddp/xddp.c                     | 2 +-
 testsuite/smokey/y2038/syscall-tests.c           | 1 +
 50 files changed, 31 insertions(+), 81 deletions(-)

diff --git a/testsuite/smokey/alchemytests/sem-2.c b/testsuite/smokey/alchemytests/sem-2.c
index 74cce2b7d..b6ecc07e9 100644
--- a/testsuite/smokey/alchemytests/sem-2.c
+++ b/testsuite/smokey/alchemytests/sem-2.c
@@ -4,6 +4,7 @@
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
 #include <alchemy/sem.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/alchemytests/task-11.c b/testsuite/smokey/alchemytests/task-11.c
index 5ed8b3419..819eca715 100644
--- a/testsuite/smokey/alchemytests/task-11.c
+++ b/testsuite/smokey/alchemytests/task-11.c
@@ -3,7 +3,6 @@
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
-#include <alchemy/timer.h>
 
 #define TEST_ITERATIONS (10)
 #define PERIOD_SWITCH_ITERATION (5)
diff --git a/testsuite/smokey/arith/arith-noinline.c b/testsuite/smokey/arith/arith-noinline.c
index ece02e737..cb10e6445 100644
--- a/testsuite/smokey/arith/arith-noinline.c
+++ b/testsuite/smokey/arith/arith-noinline.c
@@ -1,5 +1,3 @@
-#include <stdio.h>
-#include <stdlib.h>
 #include <cobalt/arith.h>
 #include "arith-noinline.h"
 
diff --git a/testsuite/smokey/bufp/bufp.c b/testsuite/smokey/bufp/bufp.c
index 4705ee192..8fbd152a7 100644
--- a/testsuite/smokey/bufp/bufp.c
+++ b/testsuite/smokey/bufp/bufp.c
@@ -5,10 +5,10 @@
  *
  * Released under the terms of GPLv2.
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include <signal.h>
 #include <string.h>
 #include <pthread.h>
 #include <fcntl.h>
diff --git a/testsuite/smokey/cpu-affinity/cpu-affinity.c b/testsuite/smokey/cpu-affinity/cpu-affinity.c
index cbc877182..d21e664cb 100644
--- a/testsuite/smokey/cpu-affinity/cpu-affinity.c
+++ b/testsuite/smokey/cpu-affinity/cpu-affinity.c
@@ -5,10 +5,9 @@
  *
  * Released under the terms of GPLv2.
  */
+
 #include <pthread.h>
 #include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
 #include <unistd.h>
 #include <semaphore.h>
 #include <rtdm/testing.h>
diff --git a/testsuite/smokey/dlopen/dlopen.c b/testsuite/smokey/dlopen/dlopen.c
index 282dbbe20..5259f067e 100644
--- a/testsuite/smokey/dlopen/dlopen.c
+++ b/testsuite/smokey/dlopen/dlopen.c
@@ -20,12 +20,8 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
-#include <error.h>
-#include <stdio.h>
+
 #include <string.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/wait.h>
 #include <smokey/smokey.h>
 
 smokey_test_plugin(dlopen,
diff --git a/testsuite/smokey/dlopen/dlopentest.c b/testsuite/smokey/dlopen/dlopentest.c
index cbf9b74d8..c124701ea 100644
--- a/testsuite/smokey/dlopen/dlopentest.c
+++ b/testsuite/smokey/dlopen/dlopentest.c
@@ -20,12 +20,11 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
-#include <assert.h>
+
 #include <errno.h>
 #include <dlfcn.h>
 #include <error.h>
 #include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 #include <limits.h>
 
diff --git a/testsuite/smokey/dlopen/libalchemy-test.c b/testsuite/smokey/dlopen/libalchemy-test.c
index 3e1eb23ea..c433ee305 100644
--- a/testsuite/smokey/dlopen/libalchemy-test.c
+++ b/testsuite/smokey/dlopen/libalchemy-test.c
@@ -20,10 +20,9 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
+
 #include <alchemy/queue.h>
 #include <string.h>
-#include <stdio.h>
-#include <stdlib.h>
 
 #include <xenomai/init.h>
 #include <xenomai/tunables.h>
diff --git a/testsuite/smokey/dlopen/libposix-test.c b/testsuite/smokey/dlopen/libposix-test.c
index fda01a533..4735feed3 100644
--- a/testsuite/smokey/dlopen/libposix-test.c
+++ b/testsuite/smokey/dlopen/libposix-test.c
@@ -20,8 +20,8 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
+
 #include <time.h>
-#include <stdio.h>
 
 int libposix_func(void);
 
diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index 1daa7ee4c..3dbf87ab0 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -8,6 +8,7 @@
  *
  * Released under the terms of GPLv2.
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -18,7 +19,6 @@
 #include <semaphore.h>
 #include <sys/wait.h>
 #include <xeno_config.h>
-#include <boilerplate/libc.h>
 #include <smokey/smokey.h>
 #include "lib/cobalt/current.h"
 
diff --git a/testsuite/smokey/iddp/iddp.c b/testsuite/smokey/iddp/iddp.c
index 2117e316c..86930efa8 100644
--- a/testsuite/smokey/iddp/iddp.c
+++ b/testsuite/smokey/iddp/iddp.c
@@ -5,10 +5,10 @@
  *
  * Released under the terms of GPLv2.
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include <signal.h>
 #include <string.h>
 #include <pthread.h>
 #include <fcntl.h>
diff --git a/testsuite/smokey/leaks/leaks.c b/testsuite/smokey/leaks/leaks.c
index 7eb5b677c..064d83e12 100644
--- a/testsuite/smokey/leaks/leaks.c
+++ b/testsuite/smokey/leaks/leaks.c
@@ -20,6 +20,7 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
@@ -27,16 +28,13 @@
 #include <unistd.h>
 #include <pthread.h>
 #include <fcntl.h>
-#include <sys/mman.h>
 #include <sys/stat.h>
 #include <semaphore.h>
 #include <mqueue.h>
-#include <signal.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/ioctl.h>
 #include <linux/unistd.h>
-#include <boilerplate/compiler.h>
 #include <rtdm/rtdm.h>
 #include <cobalt/uapi/kernel/heap.h>
 #include <xeno_config.h>
diff --git a/testsuite/smokey/main.c b/testsuite/smokey/main.c
index 11a359ade..7a50e627b 100644
--- a/testsuite/smokey/main.c
+++ b/testsuite/smokey/main.c
@@ -15,8 +15,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
+
 #include <stdio.h>
-#include <error.h>
+
 #include <errno.h>
 #include <smokey/smokey.h>
 
diff --git a/testsuite/smokey/memcheck/memcheck.c b/testsuite/smokey/memcheck/memcheck.c
index b11d2babd..56288b509 100644
--- a/testsuite/smokey/memcheck/memcheck.c
+++ b/testsuite/smokey/memcheck/memcheck.c
@@ -3,6 +3,7 @@
  *
  * SPDX-License-Identifier: MIT
  */
+
 #include <time.h>
 #include <stdlib.h>
 #include <stdbool.h>
@@ -10,7 +11,6 @@
 #include <memory.h>
 #include <sched.h>
 #include <pthread.h>
-#include <boilerplate/time.h>
 #include "memcheck.h"
 
 enum pattern {
diff --git a/testsuite/smokey/memory-coreheap/coreheap.c b/testsuite/smokey/memory-coreheap/coreheap.c
index 56e84ed88..cc2ff9f9c 100644
--- a/testsuite/smokey/memory-coreheap/coreheap.c
+++ b/testsuite/smokey/memory-coreheap/coreheap.c
@@ -3,6 +3,7 @@
  *
  * SPDX-License-Identifier: MIT
  */
+
 #include <unistd.h>
 #include <stdlib.h>
 #include <fcntl.h>
diff --git a/testsuite/smokey/memory-heapmem/heapmem.c b/testsuite/smokey/memory-heapmem/heapmem.c
index 1ce7b4eae..0eb2afa03 100644
--- a/testsuite/smokey/memory-heapmem/heapmem.c
+++ b/testsuite/smokey/memory-heapmem/heapmem.c
@@ -3,6 +3,7 @@
  *
  * SPDX-License-Identifier: MIT
  */
+
 #include <boilerplate/heapmem.h>
 #include "memcheck/memcheck.h"
 
diff --git a/testsuite/smokey/memory-pshared/pshared.c b/testsuite/smokey/memory-pshared/pshared.c
index f94b1098b..189fc2998 100644
--- a/testsuite/smokey/memory-pshared/pshared.c
+++ b/testsuite/smokey/memory-pshared/pshared.c
@@ -3,6 +3,7 @@
  *
  * SPDX-License-Identifier: MIT
  */
+
 #include <xenomai/init.h>
 #include <xenomai/tunables.h>
 #include <copperplate/heapobj.h>
diff --git a/testsuite/smokey/memory-tlsf/tlsf.c b/testsuite/smokey/memory-tlsf/tlsf.c
index 5de900782..6b5049c59 100644
--- a/testsuite/smokey/memory-tlsf/tlsf.c
+++ b/testsuite/smokey/memory-tlsf/tlsf.c
@@ -3,6 +3,7 @@
  *
  * SPDX-License-Identifier: MIT
  */
+
 #include <tlsf/tlsf.h>
 #include <stdlib.h>
 #include <pthread.h>
diff --git a/testsuite/smokey/net_common/server.c b/testsuite/smokey/net_common/server.c
index cade79fa6..42edb0f42 100644
--- a/testsuite/smokey/net_common/server.c
+++ b/testsuite/smokey/net_common/server.c
@@ -8,16 +8,12 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <stdint.h>
-#include <limits.h>
 #include <errno.h>
 #include <string.h>
 
 #include <unistd.h>
-#include <signal.h>
 #include <pthread.h>
 #include <sched.h>
-#include <fcntl.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <netpacket/packet.h>
diff --git a/testsuite/smokey/net_common/smokey_net_server.c b/testsuite/smokey/net_common/smokey_net_server.c
index 2e19208e7..5a9412603 100644
--- a/testsuite/smokey/net_common/smokey_net_server.c
+++ b/testsuite/smokey/net_common/smokey_net_server.c
@@ -13,7 +13,6 @@
 #include <getopt.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
-#include <sys/socket.h>
 #include <netinet/ether.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
@@ -21,8 +20,6 @@
 #include <rtcfg_chrdev.h>
 #include <sys/cobalt.h>
 #include <smokey/smokey.h>
-#include <xenomai/init.h>
-#include "smokey_net.h"
 #include "smokey_net_server.h"
 
 static const char *intf = "rteth0";
diff --git a/testsuite/smokey/net_packet_dgram/packet_dgram.c b/testsuite/smokey/net_packet_dgram/packet_dgram.c
index dc716a471..0e270ed38 100644
--- a/testsuite/smokey/net_packet_dgram/packet_dgram.c
+++ b/testsuite/smokey/net_packet_dgram/packet_dgram.c
@@ -7,12 +7,9 @@
  */
 
 #include <unistd.h>
-#include <net/if.h>
 #include <arpa/inet.h>
 #include <net/ethernet.h>
-#include <sys/ioctl.h>
 #include <sys/socket.h>
-#include <netpacket/packet.h>
 
 #include <sys/cobalt.h>
 #include <smokey/smokey.h>
diff --git a/testsuite/smokey/net_packet_raw/packet_raw.c b/testsuite/smokey/net_packet_raw/packet_raw.c
index a7302ca4e..58cd037cc 100644
--- a/testsuite/smokey/net_packet_raw/packet_raw.c
+++ b/testsuite/smokey/net_packet_raw/packet_raw.c
@@ -12,7 +12,6 @@
 #include <net/ethernet.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
-#include <netpacket/packet.h>
 
 #include <sys/cobalt.h>
 #include <smokey/smokey.h>
diff --git a/testsuite/smokey/posix-clock/posix-clock.c b/testsuite/smokey/posix-clock/posix-clock.c
index 3a638d41f..fd90e8ef3 100644
--- a/testsuite/smokey/posix-clock/posix-clock.c
+++ b/testsuite/smokey/posix-clock/posix-clock.c
@@ -20,11 +20,9 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
-#include <stdio.h>
-#include <stdlib.h>
+
 #include <string.h>
 #include <errno.h>
-#include <assert.h>
 #include <unistd.h>
 #include <time.h>
 #include <smokey/smokey.h>
diff --git a/testsuite/smokey/posix-cond/posix-cond.c b/testsuite/smokey/posix-cond/posix-cond.c
index a664aab1b..14275027d 100644
--- a/testsuite/smokey/posix-cond/posix-cond.c
+++ b/testsuite/smokey/posix-cond/posix-cond.c
@@ -5,14 +5,12 @@
  *
  * Released under the terms of GPLv2.
  */
+
 #include <stdio.h>
 #include <string.h>
-#include <limits.h>
 #include <stdlib.h>
 #include <signal.h>
-#include <unistd.h>
 #include <errno.h>
-#include <stdarg.h>
 #include <pthread.h>
 #include <semaphore.h>
 #include <smokey/smokey.h>
diff --git a/testsuite/smokey/posix-fork/posix-fork.c b/testsuite/smokey/posix-fork/posix-fork.c
index 3541a8a9f..c23bfeba2 100644
--- a/testsuite/smokey/posix-fork/posix-fork.c
+++ b/testsuite/smokey/posix-fork/posix-fork.c
@@ -5,10 +5,8 @@
  *
  * Released under the terms of GPLv2.
  */
+
 #include <stdio.h>
-#include <stdlib.h>
-#include <xeno_config.h>
-#include <boilerplate/libc.h>
 #include <smokey/smokey.h>
 
 smokey_test_plugin(posix_fork,
diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
index 249fc6c06..50f894062 100644
--- a/testsuite/smokey/posix-mutex/posix-mutex.c
+++ b/testsuite/smokey/posix-mutex/posix-mutex.c
@@ -8,12 +8,11 @@
  *
  * Released under the terms of GPLv2.
  */
+
 #include <stdio.h>
-#include <limits.h>
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <stdarg.h>
 #include <unistd.h>
 #include <signal.h>
 #include <pthread.h>
diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/smokey/posix-select/posix-select.c
index e9f8c70d0..713efa7b0 100644
--- a/testsuite/smokey/posix-select/posix-select.c
+++ b/testsuite/smokey/posix-select/posix-select.c
@@ -20,10 +20,8 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
-#include <stdio.h>
-#include <stdlib.h>
+
 #include <string.h>
-#include <time.h>
 #include <errno.h>
 #include <unistd.h>
 #include <mqueue.h>
@@ -31,7 +29,6 @@
 #include <boilerplate/atomic.h>
 #include <sys/select.h>
 #include <sys/types.h>
-#include <sys/stat.h>
 #include <fcntl.h>
 #include <smokey/smokey.h>
 
diff --git a/testsuite/smokey/psostests/pt-1.c b/testsuite/smokey/psostests/pt-1.c
index 48f9799f7..496f1d070 100644
--- a/testsuite/smokey/psostests/pt-1.c
+++ b/testsuite/smokey/psostests/pt-1.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
 #include <stdlib.h>
 #include <memory.h>
 #include <copperplate/traceobj.h>
diff --git a/testsuite/smokey/psostests/rn-1.c b/testsuite/smokey/psostests/rn-1.c
index 42f86a7ea..5e82d1506 100644
--- a/testsuite/smokey/psostests/rn-1.c
+++ b/testsuite/smokey/psostests/rn-1.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
 #include <stdlib.h>
 #include <memory.h>
 #include <copperplate/traceobj.h>
diff --git a/testsuite/smokey/rtdm/rtdm.c b/testsuite/smokey/rtdm/rtdm.c
index 785132a14..2abbd6cea 100644
--- a/testsuite/smokey/rtdm/rtdm.c
+++ b/testsuite/smokey/rtdm/rtdm.c
@@ -5,6 +5,7 @@
  *
  * Released under the terms of GPLv2.
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
diff --git a/testsuite/smokey/sched-quota/sched-quota.c b/testsuite/smokey/sched-quota/sched-quota.c
index 26bc15e72..5abe75d27 100644
--- a/testsuite/smokey/sched-quota/sched-quota.c
+++ b/testsuite/smokey/sched-quota/sched-quota.c
@@ -5,9 +5,8 @@
  *
  * Released under the terms of GPLv2.
  */
+
 #include <stdio.h>
-#include <stdlib.h>
-#include <limits.h>
 #include <unistd.h>
 #include <math.h>
 #include <pthread.h>
diff --git a/testsuite/smokey/sched-tp/sched-tp.c b/testsuite/smokey/sched-tp/sched-tp.c
index 434ac3cf6..c2c3e41ed 100644
--- a/testsuite/smokey/sched-tp/sched-tp.c
+++ b/testsuite/smokey/sched-tp/sched-tp.c
@@ -5,15 +5,11 @@
  *
  * Released under the terms of GPLv2.
  */
-#include <stdio.h>
-#include <stdlib.h>
-#include <limits.h>
-#include <memory.h>
+
 #include <time.h>
 #include <malloc.h>
 #include <unistd.h>
 #include <string.h>
-#include <signal.h>
 #include <pthread.h>
 #include <semaphore.h>
 #include <sched.h>
diff --git a/testsuite/smokey/setsched/setsched.c b/testsuite/smokey/setsched/setsched.c
index fc348a86e..01c1af9c3 100644
--- a/testsuite/smokey/setsched/setsched.c
+++ b/testsuite/smokey/setsched/setsched.c
@@ -8,8 +8,8 @@
  *
  * Released under the terms of GPLv2.
  */
+
 #include <stdio.h>
-#include <stdbool.h>
 #include <pthread.h>
 #include <error.h>
 #include <semaphore.h>
diff --git a/testsuite/smokey/sigdebug/Makefile.am b/testsuite/smokey/sigdebug/Makefile.am
index 06b976d3e..79a7962aa 100644
--- a/testsuite/smokey/sigdebug/Makefile.am
+++ b/testsuite/smokey/sigdebug/Makefile.am
@@ -3,7 +3,7 @@ noinst_LIBRARIES = libsigdebug.a
 
 libsigdebug_a_SOURCES = sigdebug.c
 
-CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+#CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
 
 libsigdebug_a_CPPFLAGS = 		\
 	@XENO_USER_CFLAGS@	\
diff --git a/testsuite/smokey/timerfd/timerfd.c b/testsuite/smokey/timerfd/timerfd.c
index 1d5813341..6bda0721e 100644
--- a/testsuite/smokey/timerfd/timerfd.c
+++ b/testsuite/smokey/timerfd/timerfd.c
@@ -20,10 +20,10 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
+
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
-#include <assert.h>
 #include <fcntl.h>
 #include <sys/timerfd.h>
 #include <smokey/smokey.h>
diff --git a/testsuite/smokey/tsc/tsc.c b/testsuite/smokey/tsc/tsc.c
index 5cc674976..e4b28b378 100644
--- a/testsuite/smokey/tsc/tsc.c
+++ b/testsuite/smokey/tsc/tsc.c
@@ -26,14 +26,9 @@
 
 #include <unistd.h>
 #include <sched.h>
-#include <sys/mman.h>
 
 #include <smokey/smokey.h>
 
-#include <cobalt/sys/cobalt.h>
-
-#define DURATION 10000000
-
 #if CONFIG_SMP
 #define smp_sched_setaffinity(pid,len,mask) sched_setaffinity(pid,len,mask)
 #define smp_sched_getaffinity(pid,len,mask) sched_getaffinity(pid,len,mask)
diff --git a/testsuite/smokey/vxworkstests/lst-1.c b/testsuite/smokey/vxworkstests/lst-1.c
index 878f32c90..691d66fcf 100644
--- a/testsuite/smokey/vxworkstests/lst-1.c
+++ b/testsuite/smokey/vxworkstests/lst-1.c
@@ -3,7 +3,6 @@
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskLib.h>
 #include <vxworks/lstLib.h>
 
 static struct traceobj trobj;
diff --git a/testsuite/smokey/vxworkstests/msgQ-1.c b/testsuite/smokey/vxworkstests/msgQ-1.c
index 4050388a2..87415e167 100644
--- a/testsuite/smokey/vxworkstests/msgQ-1.c
+++ b/testsuite/smokey/vxworkstests/msgQ-1.c
@@ -4,7 +4,6 @@
 #include <boilerplate/ancillaries.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskLib.h>
 #include <vxworks/msgQLib.h>
 
 static struct traceobj trobj;
diff --git a/testsuite/smokey/vxworkstests/msgQ-2.c b/testsuite/smokey/vxworkstests/msgQ-2.c
index 008078047..669c064e2 100644
--- a/testsuite/smokey/vxworkstests/msgQ-2.c
+++ b/testsuite/smokey/vxworkstests/msgQ-2.c
@@ -4,7 +4,6 @@
 #include <boilerplate/ancillaries.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskLib.h>
 #include <vxworks/msgQLib.h>
 
 static struct traceobj trobj;
diff --git a/testsuite/smokey/vxworkstests/msgQ-3.c b/testsuite/smokey/vxworkstests/msgQ-3.c
index a23d5c3d0..4aba719a7 100644
--- a/testsuite/smokey/vxworkstests/msgQ-3.c
+++ b/testsuite/smokey/vxworkstests/msgQ-3.c
@@ -3,7 +3,6 @@
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskLib.h>
 #include <vxworks/msgQLib.h>
 
 #define NMESSAGES  10
diff --git a/testsuite/smokey/vxworkstests/rng-1.c b/testsuite/smokey/vxworkstests/rng-1.c
index 1e179c6f6..7e847dc7e 100644
--- a/testsuite/smokey/vxworkstests/rng-1.c
+++ b/testsuite/smokey/vxworkstests/rng-1.c
@@ -1,10 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
 #include <string.h>
-#include <stdio.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskLib.h>
 #include <vxworks/rngLib.h>
 
 static struct traceobj trobj;
diff --git a/testsuite/smokey/vxworkstests/sem-1.c b/testsuite/smokey/vxworkstests/sem-1.c
index b64aba3b8..33270c38b 100644
--- a/testsuite/smokey/vxworkstests/sem-1.c
+++ b/testsuite/smokey/vxworkstests/sem-1.c
@@ -3,7 +3,6 @@
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskLib.h>
 #include <vxworks/taskInfo.h>
 #include <vxworks/semLib.h>
 
diff --git a/testsuite/smokey/vxworkstests/sem-2.c b/testsuite/smokey/vxworkstests/sem-2.c
index 67caf2924..1fb008be9 100644
--- a/testsuite/smokey/vxworkstests/sem-2.c
+++ b/testsuite/smokey/vxworkstests/sem-2.c
@@ -3,7 +3,6 @@
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskLib.h>
 #include <vxworks/taskInfo.h>
 #include <vxworks/semLib.h>
 
diff --git a/testsuite/smokey/vxworkstests/sem-3.c b/testsuite/smokey/vxworkstests/sem-3.c
index 1f4252e3d..921fa25cd 100644
--- a/testsuite/smokey/vxworkstests/sem-3.c
+++ b/testsuite/smokey/vxworkstests/sem-3.c
@@ -3,7 +3,6 @@
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskLib.h>
 #include <vxworks/semLib.h>
 
 static struct traceobj trobj;
diff --git a/testsuite/smokey/vxworkstests/task-1.c b/testsuite/smokey/vxworkstests/task-1.c
index a07d643c3..c5aeae1fb 100644
--- a/testsuite/smokey/vxworkstests/task-1.c
+++ b/testsuite/smokey/vxworkstests/task-1.c
@@ -3,7 +3,6 @@
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskLib.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
index 0c816bd79..0cbb9e18a 100644
--- a/testsuite/smokey/vxworkstests/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -1,10 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskLib.h>
 #include <vxworks/semLib.h>
 
 static inline void safe_pause(void)
diff --git a/testsuite/smokey/vxworkstests/wd-1.c b/testsuite/smokey/vxworkstests/wd-1.c
index 7da5d4dcb..e67089520 100644
--- a/testsuite/smokey/vxworkstests/wd-1.c
+++ b/testsuite/smokey/vxworkstests/wd-1.c
@@ -3,7 +3,6 @@
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskLib.h>
 #include <vxworks/wdLib.h>
 #include <vxworks/intLib.h>
 
diff --git a/testsuite/smokey/x86io/x86io.c b/testsuite/smokey/x86io/x86io.c
index 4db228660..9cfc092d0 100644
--- a/testsuite/smokey/x86io/x86io.c
+++ b/testsuite/smokey/x86io/x86io.c
@@ -7,13 +7,13 @@
  *
  * Released under the terms of GPLv2.
  */
+
 #include <pthread.h>
 #include <sched.h>
 #include <signal.h>
 #include <smokey/smokey.h>
 #include <string.h>
 #include <sys/io.h>
-#include <unistd.h>
 
 #define PORT (0x378)
 
diff --git a/testsuite/smokey/xddp/xddp.c b/testsuite/smokey/xddp/xddp.c
index a311854c7..1d903f28e 100644
--- a/testsuite/smokey/xddp/xddp.c
+++ b/testsuite/smokey/xddp/xddp.c
@@ -5,10 +5,10 @@
  *
  * Released under the terms of GPLv2.
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include <signal.h>
 #include <string.h>
 #include <semaphore.h>
 #include <pthread.h>
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 0817d2004..b452b642b 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -7,6 +7,7 @@
  * Authors:
  *  Florian Bezdeka <florian.bezdeka@siemens.com>
  */
+
 #include <asm/xenomai/syscall.h>
 #include <smokey/smokey.h>
 #include <sys/timerfd.h>

-- 
2.39.5

