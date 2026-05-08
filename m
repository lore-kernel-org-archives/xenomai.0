Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2703356A12
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221398; cv=none; b=gGSuc5Od0oP3bCAzOIrHAucQAgpd27KT0ocmuMtKN6o/DXnyQOYmC+3lhuYKxWNOgxJ8hZTXnS3j9fD5qmW3QtHRbdQUMyZOKGo3obgR+UJCEn3lxrN0h1JKSND4bMTo0cNKhBkg3s8SoVY1zilvbQY/uT+1XIzadRxdtthO6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221398; c=relaxed/simple;
	bh=Fhp0fltHBAN4eKrDDSCFqp69k1jM1Y3MUeyw69DJ8z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qo6wj75MUlF13/8W1RxgXErla2L1//RxF7rhpEAeSDihD/a4w6K+BbLU0VZYh3n6fq8i+K9KZmyIg+YrC092/VHuDpq9D1NJplGbIMwLbgLeRM8Z0aHRDNV0xnvyGCU2IE8o7ZPbolsSdfRrKkdc3QmhcTCO7o7/1R57Y5cMlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=VArHtvm/; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="VArHtvm/"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260508062301e8f528c8c70002072b
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tQVSBOEhA6sv+FNU0ZWVP9aLH/x4247/Yf/Zys/JmMo=;
 b=VArHtvm/p8g8EckuyrzCsKlq7QtIt38d8aUGnjZ+dO6Kw7qqWXpC/nENohUWY302flOfbG
 aCWoTVGClUt3OmNmBr21VrxSp5baUT9YMQ9X8GFdm7yaBkLEpXzCNGIXkl6xrRvvsjlgi9av
 0/1boZy6t3RET4rxShY+AGofjKHYRDwy0bX73D31Jg6RDDOaKMVc88tHoIr7fFUOem/p1p9v
 D/fHPJtWLKZQTbKMaxsidaslumz8Qpzp1mt8mmtIerYMkwuQQRhFqt/kgvoPLj1XghCS9UE4
 JfisSng6+qqRs3TYHD7uTnxkFf3oQi0TrwtA6PRtSUJkCBPvKclnAIDw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:54 +0200
Subject: [PATCH 21/32] testsuite/smokey: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-21-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving from "local to global" should help us to keep headers
self-contained. This patch holds the cleanup of all testsuite/smokey
subdirectories where a single file was modified.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/clocktest/clocktest.c                  |  1 +
 testsuite/smokey/bufp/bufp.c                     |  9 ++-------
 testsuite/smokey/can/can.c                       |  8 ++------
 testsuite/smokey/cpu-affinity/cpu-affinity.c     |  4 ----
 testsuite/smokey/fpu-stress/fpu-stress.c         |  4 +---
 testsuite/smokey/gdb/gdb.c                       | 15 ++++++---------
 testsuite/smokey/iddp/iddp.c                     |  9 ++-------
 testsuite/smokey/leaks/leaks.c                   | 21 ++++++---------------
 testsuite/smokey/main.c                          |  3 ---
 testsuite/smokey/memcheck/memcheck.c             |  8 ++------
 testsuite/smokey/memory-coreheap/coreheap.c      |  9 ++++-----
 testsuite/smokey/memory-heapmem/heapmem.c        |  3 ++-
 testsuite/smokey/memory-pshared/pshared.c        |  5 +++--
 testsuite/smokey/memory-tlsf/tlsf.c              |  6 +++---
 testsuite/smokey/net_packet_dgram/packet_dgram.c |  7 -------
 testsuite/smokey/net_packet_raw/packet_raw.c     |  9 ++-------
 testsuite/smokey/net_udp/udp.c                   |  4 ----
 testsuite/smokey/posix-clock/posix-clock.c       |  6 ++----
 testsuite/smokey/posix-cond/posix-cond.c         |  9 ++-------
 testsuite/smokey/posix-fork/posix-fork.c         |  1 -
 testsuite/smokey/posix-mutex/posix-mutex.c       | 10 ++--------
 testsuite/smokey/posix-select/posix-select.c     | 12 +++---------
 testsuite/smokey/rtdm/rtdm.c                     |  7 ++-----
 testsuite/smokey/sched-quota/sched-quota.c       | 15 ++++-----------
 testsuite/smokey/sched-tp/sched-tp.c             | 12 +++---------
 testsuite/smokey/setsched/setsched.c             |  9 +++------
 testsuite/smokey/sigdebug/sigdebug.c             | 15 ++++-----------
 testsuite/smokey/timerfd/timerfd.c               |  8 +++-----
 testsuite/smokey/tsc/tsc.c                       |  7 ++-----
 testsuite/smokey/x86io/x86io.c                   |  5 +----
 testsuite/smokey/xddp/xddp.c                     | 10 ++--------
 testsuite/smokey/y2038/syscall-tests.c           |  4 ++--
 32 files changed, 71 insertions(+), 184 deletions(-)

diff --git a/testsuite/clocktest/clocktest.c b/testsuite/clocktest/clocktest.c
index ae50dd9690235cf11c2326d6171d9ab333ae8605..36f72f64389da8d2f42f5cbf42b43321c7cc8465 100644
--- a/testsuite/clocktest/clocktest.c
+++ b/testsuite/clocktest/clocktest.c
@@ -26,6 +26,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/syscall.h>
+#include <unistd.h>
 
 /*
  * We can't really trust POSIX headers to check for features, since
diff --git a/testsuite/smokey/bufp/bufp.c b/testsuite/smokey/bufp/bufp.c
index 8fbd152a7212d74bb69775bbb4743b4c7e681777..0607d21461ea97c813698ef0a92e5b9facff3f1b 100644
--- a/testsuite/smokey/bufp/bufp.c
+++ b/testsuite/smokey/bufp/bufp.c
@@ -6,16 +6,11 @@
  * Released under the terms of GPLv2.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <pthread.h>
-#include <fcntl.h>
-#include <errno.h>
 #include <smokey/smokey.h>
 #include <rtdm/ipc.h>
 
+#include <stdlib.h>
+
 smokey_test_plugin(bufp,
 		   SMOKEY_NOARGS,
 		   "Check RTIPC/BUFP protocol."
diff --git a/testsuite/smokey/can/can.c b/testsuite/smokey/can/can.c
index 8b6c0ee614581cf2444f79b9f66ef1227e387ae3..05173fcbf2652bcb9b3f89a9a2d1be1af3d713f1 100644
--- a/testsuite/smokey/can/can.c
+++ b/testsuite/smokey/can/can.c
@@ -7,13 +7,9 @@
  * SPDX-License-Identifier: MIT
  */
 
-#include <pthread.h>
-#include <rtdm/can.h>
-#include <sys/cobalt.h>
-#include <sys/ioctl.h>
-#include <sys/socket.h>
 #include <smokey/smokey.h>
-#include <stdbool.h>
+
+#include <rtdm/can.h>
 
 #define CAN_MOD                        "xeno_can"
 #define CAN_VIRT_MOD                   "xeno_can_virt"
diff --git a/testsuite/smokey/cpu-affinity/cpu-affinity.c b/testsuite/smokey/cpu-affinity/cpu-affinity.c
index d21e664cb4de55a9530757ea85d2bdc4a951b11a..4cbb2e9403edfbb73b7b3bb4627f8fa27ec0bbf0 100644
--- a/testsuite/smokey/cpu-affinity/cpu-affinity.c
+++ b/testsuite/smokey/cpu-affinity/cpu-affinity.c
@@ -6,10 +6,6 @@
  * Released under the terms of GPLv2.
  */
 
-#include <pthread.h>
-#include <sched.h>
-#include <unistd.h>
-#include <semaphore.h>
 #include <rtdm/testing.h>
 #include <smokey/smokey.h>
 
diff --git a/testsuite/smokey/fpu-stress/fpu-stress.c b/testsuite/smokey/fpu-stress/fpu-stress.c
index 59383c96c27173336e056a7ab6aa557e47f0db58..d92bc1e24302814e6ab0153962a896dcc96b4ce0 100644
--- a/testsuite/smokey/fpu-stress/fpu-stress.c
+++ b/testsuite/smokey/fpu-stress/fpu-stress.c
@@ -1,8 +1,6 @@
-#include <stdio.h>
-#include <pthread.h>
-#include <smokey/smokey.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/uapi/fptest.h>
+#include <smokey/smokey.h>
 
 smokey_test_plugin(fpu_stress,
 		   SMOKEY_ARGLIST(
diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index d5b4e9383f6c9711ce9eb5ea03d61a6d5be2711f..885ba3143fab00133c624ab42917c96746d7238f 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -9,17 +9,14 @@
  * Released under the terms of GPLv2.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
+#include "lib/cobalt/current.h"
+
+#include <smokey/smokey.h>
+
 #include <error.h>
-#include <fcntl.h>
-#include <pthread.h>
-#include <semaphore.h>
+#include <stdlib.h>
 #include <sys/wait.h>
-#include <smokey/smokey.h>
-#include "lib/cobalt/current.h"
+#include <unistd.h>
 
 static void send_command(const char *string, int wait_for_prompt);
 
diff --git a/testsuite/smokey/iddp/iddp.c b/testsuite/smokey/iddp/iddp.c
index 86930efa83470e003acf404e0a0a9b404340140f..5637f9cadefa8dae2e64a6361d84426b2eda3348 100644
--- a/testsuite/smokey/iddp/iddp.c
+++ b/testsuite/smokey/iddp/iddp.c
@@ -6,16 +6,11 @@
  * Released under the terms of GPLv2.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <pthread.h>
-#include <fcntl.h>
-#include <errno.h>
 #include <smokey/smokey.h>
 #include <rtdm/ipc.h>
 
+#include <stdlib.h>
+
 smokey_test_plugin(iddp,
 		   SMOKEY_NOARGS,
 		   "Check RTIPC/IDDP protocol."
diff --git a/testsuite/smokey/leaks/leaks.c b/testsuite/smokey/leaks/leaks.c
index 064d83e12257c1600d7795da24700367ee74a895..01581e302c54201d2d88e830cea2dd54ed545eed 100644
--- a/testsuite/smokey/leaks/leaks.c
+++ b/testsuite/smokey/leaks/leaks.c
@@ -21,24 +21,15 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <stdio.h>
+#include <cobalt/uapi/kernel/heap.h>
+#include <rtdm/rtdm.h>
+#include <smokey/smokey.h>
+
+#include <linux/unistd.h>
+#include <mqueue.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <signal.h>
-#include <unistd.h>
-#include <pthread.h>
-#include <fcntl.h>
 #include <sys/stat.h>
-#include <semaphore.h>
-#include <mqueue.h>
-#include <sys/types.h>
 #include <sys/wait.h>
-#include <sys/ioctl.h>
-#include <linux/unistd.h>
-#include <rtdm/rtdm.h>
-#include <cobalt/uapi/kernel/heap.h>
-#include <xeno_config.h>
-#include <smokey/smokey.h>
 
 smokey_test_plugin(leaks,
 		   SMOKEY_NOARGS,
diff --git a/testsuite/smokey/main.c b/testsuite/smokey/main.c
index 7a50e627ba8e4893b8f6dea9fea5bbf08e41461f..b77c13be039b5f5c9769ed973f90c85ed4d4470b 100644
--- a/testsuite/smokey/main.c
+++ b/testsuite/smokey/main.c
@@ -16,9 +16,6 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdio.h>
-
-#include <errno.h>
 #include <smokey/smokey.h>
 
 int main(int argc, char *const argv[])
diff --git a/testsuite/smokey/memcheck/memcheck.c b/testsuite/smokey/memcheck/memcheck.c
index 56288b5099976dbf18488b45be60ea345c78cfa2..e8108a284cb85c4b2268433d680e816fb76b7bbb 100644
--- a/testsuite/smokey/memcheck/memcheck.c
+++ b/testsuite/smokey/memcheck/memcheck.c
@@ -4,14 +4,10 @@
  * SPDX-License-Identifier: MIT
  */
 
-#include <time.h>
+#include "memcheck.h"
+
 #include <stdlib.h>
-#include <stdbool.h>
 #include <unistd.h>
-#include <memory.h>
-#include <sched.h>
-#include <pthread.h>
-#include "memcheck.h"
 
 enum pattern {
 	alphabet_series,
diff --git a/testsuite/smokey/memory-coreheap/coreheap.c b/testsuite/smokey/memory-coreheap/coreheap.c
index cc2ff9f9cf95d68d677c3d87620c9e382d5033e8..48a63f0bfa508c537af02b0c866f5d21035c7a10 100644
--- a/testsuite/smokey/memory-coreheap/coreheap.c
+++ b/testsuite/smokey/memory-coreheap/coreheap.c
@@ -4,13 +4,12 @@
  * SPDX-License-Identifier: MIT
  */
 
-#include <unistd.h>
-#include <stdlib.h>
-#include <fcntl.h>
-#include <pthread.h>
-#include <rtdm/testing.h>
 #include "memcheck/memcheck.h"
 
+#include <rtdm/testing.h>
+
+#include <stdlib.h>
+
 smokey_test_plugin(memory_coreheap,
 		   MEMCHECK_ARGS,
 		   "Check for the Cobalt core allocator sanity.\n"
diff --git a/testsuite/smokey/memory-heapmem/heapmem.c b/testsuite/smokey/memory-heapmem/heapmem.c
index 0eb2afa031dfff9b35f4db182028d9e6769aeb2a..ecb585679909742f85d487ee1ceb4e8f82c883ae 100644
--- a/testsuite/smokey/memory-heapmem/heapmem.c
+++ b/testsuite/smokey/memory-heapmem/heapmem.c
@@ -4,9 +4,10 @@
  * SPDX-License-Identifier: MIT
  */
 
-#include <boilerplate/heapmem.h>
 #include "memcheck/memcheck.h"
 
+#include <boilerplate/heapmem.h>
+
 smokey_test_plugin(memory_heapmem,
 		   MEMCHECK_ARGS,
 		   "Check for the heapmem allocator sanity.\n"
diff --git a/testsuite/smokey/memory-pshared/pshared.c b/testsuite/smokey/memory-pshared/pshared.c
index 189fc299844f054a6c4c7969bb3833b3d43ae7cf..b04aace007e5f08b431964f7dcf861e192327750 100644
--- a/testsuite/smokey/memory-pshared/pshared.c
+++ b/testsuite/smokey/memory-pshared/pshared.c
@@ -4,10 +4,11 @@
  * SPDX-License-Identifier: MIT
  */
 
+#include "memcheck/memcheck.h"
+
+#include <copperplate/heapobj.h>
 #include <xenomai/init.h>
 #include <xenomai/tunables.h>
-#include <copperplate/heapobj.h>
-#include "memcheck/memcheck.h"
 
 smokey_test_plugin(memory_pshared,
 		   MEMCHECK_ARGS,
diff --git a/testsuite/smokey/memory-tlsf/tlsf.c b/testsuite/smokey/memory-tlsf/tlsf.c
index 6b5049c59e91ec60e27087e608d48e9ce079e987..1c96336034f0cbf659a210bed17fadb780fa1bec 100644
--- a/testsuite/smokey/memory-tlsf/tlsf.c
+++ b/testsuite/smokey/memory-tlsf/tlsf.c
@@ -4,11 +4,11 @@
  * SPDX-License-Identifier: MIT
  */
 
-#include <tlsf/tlsf.h>
-#include <stdlib.h>
-#include <pthread.h>
 #include "memcheck/memcheck.h"
 
+#include <stdlib.h>
+#include <tlsf/tlsf.h>
+
 smokey_test_plugin(memory_tlsf,
 		   MEMCHECK_ARGS,
 		   "Check for the TLSF allocator sanity.\n"
diff --git a/testsuite/smokey/net_packet_dgram/packet_dgram.c b/testsuite/smokey/net_packet_dgram/packet_dgram.c
index 0e270ed388f7c3d5a49f62396aa636b3504d8307..a122cf0df8230deabf83e5ee9af0200352b2e78f 100644
--- a/testsuite/smokey/net_packet_dgram/packet_dgram.c
+++ b/testsuite/smokey/net_packet_dgram/packet_dgram.c
@@ -6,13 +6,6 @@
  * SPDX-License-Identifier: MIT
  */
 
-#include <unistd.h>
-#include <arpa/inet.h>
-#include <net/ethernet.h>
-#include <sys/socket.h>
-
-#include <sys/cobalt.h>
-#include <smokey/smokey.h>
 #include "smokey_net.h"
 
 smokey_test_plugin(net_packet_dgram,
diff --git a/testsuite/smokey/net_packet_raw/packet_raw.c b/testsuite/smokey/net_packet_raw/packet_raw.c
index 58cd037cc638253ace8feb489e17553a7f7d0079..5cea140e0e173d9aa8e1e555292216a715f94495 100644
--- a/testsuite/smokey/net_packet_raw/packet_raw.c
+++ b/testsuite/smokey/net_packet_raw/packet_raw.c
@@ -6,16 +6,11 @@
  * SPDX-License-Identifier: MIT
  */
 
-#include <unistd.h>
+#include "smokey_net.h"
+
 #include <net/if.h>
-#include <arpa/inet.h>
 #include <net/ethernet.h>
 #include <sys/ioctl.h>
-#include <sys/socket.h>
-
-#include <sys/cobalt.h>
-#include <smokey/smokey.h>
-#include "smokey_net.h"
 
 smokey_test_plugin(net_packet_raw,
 	SMOKEY_ARGLIST(
diff --git a/testsuite/smokey/net_udp/udp.c b/testsuite/smokey/net_udp/udp.c
index 8ba89c441a3b2f7ffbb82298b9aee68797c65f95..44e55d091088ee6d666d61f8154985c71f62f513 100644
--- a/testsuite/smokey/net_udp/udp.c
+++ b/testsuite/smokey/net_udp/udp.c
@@ -6,10 +6,6 @@
  * SPDX-License-Identifier: MIT
  */
 
-#include <netinet/in.h>
-
-#include <sys/cobalt.h>
-#include <smokey/smokey.h>
 #include "smokey_net.h"
 
 smokey_test_plugin(net_udp,
diff --git a/testsuite/smokey/posix-clock/posix-clock.c b/testsuite/smokey/posix-clock/posix-clock.c
index fd90e8ef3d4441a1149cd9d6cddbf10da3ff6d70..7cb52c561d7c8f6c971f30d8fba89bea6dc29195 100644
--- a/testsuite/smokey/posix-clock/posix-clock.c
+++ b/testsuite/smokey/posix-clock/posix-clock.c
@@ -21,12 +21,10 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <string.h>
-#include <errno.h>
-#include <unistd.h>
-#include <time.h>
 #include <smokey/smokey.h>
+
 #include <sys/timerfd.h>
+#include <unistd.h>
 
 smokey_test_plugin(posix_clock,
 		   SMOKEY_NOARGS,
diff --git a/testsuite/smokey/posix-cond/posix-cond.c b/testsuite/smokey/posix-cond/posix-cond.c
index 14275027d41ac60694bee3c6666efa66627823e2..27901cc128c1b2a0256e6a2ce468c10aa8e84def 100644
--- a/testsuite/smokey/posix-cond/posix-cond.c
+++ b/testsuite/smokey/posix-cond/posix-cond.c
@@ -6,15 +6,10 @@
  * Released under the terms of GPLv2.
  */
 
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <errno.h>
-#include <pthread.h>
-#include <semaphore.h>
 #include <smokey/smokey.h>
 
+#include <stdlib.h>
+
 smokey_test_plugin(posix_cond,
 		   SMOKEY_NOARGS,
 		   "Check POSIX condition variable services"
diff --git a/testsuite/smokey/posix-fork/posix-fork.c b/testsuite/smokey/posix-fork/posix-fork.c
index c23bfeba2a68eec5a1f361f7078f6d40d51ce779..3512b00d896b56eb8d7bab66adde884baf4f0a30 100644
--- a/testsuite/smokey/posix-fork/posix-fork.c
+++ b/testsuite/smokey/posix-fork/posix-fork.c
@@ -6,7 +6,6 @@
  * Released under the terms of GPLv2.
  */
 
-#include <stdio.h>
 #include <smokey/smokey.h>
 
 smokey_test_plugin(posix_fork,
diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
index 50f894062a2805ede6165e526b46934e2d46d36c..57b7e14db61c70fde759ed9156ba9df7fd8f97f5 100644
--- a/testsuite/smokey/posix-mutex/posix-mutex.c
+++ b/testsuite/smokey/posix-mutex/posix-mutex.c
@@ -9,16 +9,10 @@
  * Released under the terms of GPLv2.
  */
 
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <unistd.h>
-#include <signal.h>
-#include <pthread.h>
-#include <cobalt/sys/cobalt.h>
 #include <smokey/smokey.h>
 
+#include <unistd.h>
+
 smokey_test_plugin(posix_mutex,
 		   SMOKEY_NOARGS,
 		   "Check POSIX mutex services"
diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/smokey/posix-select/posix-select.c
index 620b677da779f9a5742437b02e664c59c9164e38..ecdcabcd11834d81615a1a159febc9889161935d 100644
--- a/testsuite/smokey/posix-select/posix-select.c
+++ b/testsuite/smokey/posix-select/posix-select.c
@@ -21,17 +21,11 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <string.h>
-#include <errno.h>
-#include <unistd.h>
-#include <mqueue.h>
-#include <pthread.h>
-#include <boilerplate/atomic.h>
-#include <sys/select.h>
-#include <sys/types.h>
-#include <fcntl.h>
 #include <smokey/smokey.h>
 
+#include <mqueue.h>
+#include <unistd.h>
+
 smokey_test_plugin(posix_select,
 		   SMOKEY_NOARGS,
 		   "Check POSIX select service"
diff --git a/testsuite/smokey/rtdm/rtdm.c b/testsuite/smokey/rtdm/rtdm.c
index 2abbd6ceaf1e5ba3796def0353e426f81cc856fa..0fcb1874e84b871e7fa53063bcde88a151301b4d 100644
--- a/testsuite/smokey/rtdm/rtdm.c
+++ b/testsuite/smokey/rtdm/rtdm.c
@@ -6,14 +6,11 @@
  * Released under the terms of GPLv2.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <unistd.h>
 #include <rtdm/testing.h>
 #include <smokey/smokey.h>
 
+#include <stdlib.h>
+
 smokey_test_plugin(rtdm,
 		   SMOKEY_NOARGS,
 		   "Check core interface to RTDM services."
diff --git a/testsuite/smokey/sched-quota/sched-quota.c b/testsuite/smokey/sched-quota/sched-quota.c
index f9e64e37f12a88efcb0d11513fa68749bdb99f0b..d67bda6bcc76d25b9bd7aed90fed2eacd8dd3714 100644
--- a/testsuite/smokey/sched-quota/sched-quota.c
+++ b/testsuite/smokey/sched-quota/sched-quota.c
@@ -6,20 +6,13 @@
  * Released under the terms of GPLv2.
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <math.h>
-#include <pthread.h>
-#include <semaphore.h>
-#include <sched.h>
-#include <errno.h>
-#include <error.h>
-#include <sys/cobalt.h>
-#include <boilerplate/time.h>
-#include <boilerplate/ancillaries.h>
 #include <copperplate/threadobj.h>
 #include <smokey/smokey.h>
 
+#include <error.h>
+#include <math.h>
+#include <unistd.h>
+
 smokey_test_plugin(sched_quota,
 		   SMOKEY_ARGLIST(
 			   SMOKEY_INT(quota),
diff --git a/testsuite/smokey/sched-tp/sched-tp.c b/testsuite/smokey/sched-tp/sched-tp.c
index c2c3e41edff266ff9aec9a09f884ffaf3e2a9308..3c8f269d7f1a33706556a9e49419803a0979ef05 100644
--- a/testsuite/smokey/sched-tp/sched-tp.c
+++ b/testsuite/smokey/sched-tp/sched-tp.c
@@ -6,17 +6,11 @@
  * Released under the terms of GPLv2.
  */
 
-#include <time.h>
+#include <smokey/smokey.h>
+
+#include <error.h>
 #include <malloc.h>
 #include <unistd.h>
-#include <string.h>
-#include <pthread.h>
-#include <semaphore.h>
-#include <sched.h>
-#include <errno.h>
-#include <error.h>
-#include <sys/cobalt.h>
-#include <smokey/smokey.h>
 
 smokey_test_plugin(sched_tp,
 		   SMOKEY_NOARGS,
diff --git a/testsuite/smokey/setsched/setsched.c b/testsuite/smokey/setsched/setsched.c
index 01c1af9c3925bc1cbad42b928d58827f239bc9ab..f2a562ec31a2d2b4225cc06ffb7bbcee2267b251 100644
--- a/testsuite/smokey/setsched/setsched.c
+++ b/testsuite/smokey/setsched/setsched.c
@@ -9,14 +9,11 @@
  * Released under the terms of GPLv2.
  */
 
-#include <stdio.h>
-#include <pthread.h>
+#include <smokey/smokey.h>
+
 #include <error.h>
-#include <semaphore.h>
-#include <unistd.h>
 #include <sys/syscall.h>
-#include <smokey/smokey.h>
-#include <sys/cobalt.h>
+#include <unistd.h>
 
 smokey_test_plugin(setsched, SMOKEY_NOARGS,
    "Validate correct application of scheduling parameters to running threads."
diff --git a/testsuite/smokey/sigdebug/sigdebug.c b/testsuite/smokey/sigdebug/sigdebug.c
index 9cb5162c14fcdde13fa1b8ba74ca3bef9951eeff..4bbf33cfb72ee124ef77596327736a0a8360f261 100644
--- a/testsuite/smokey/sigdebug/sigdebug.c
+++ b/testsuite/smokey/sigdebug/sigdebug.c
@@ -9,19 +9,12 @@
  * Released under the terms of GPLv2.
  */
 
-#include <unistd.h>
+#include <smokey/smokey.h>
+
+#include <asm/unistd.h>
 #include <stdlib.h>
-#include <stdio.h>
-#include <stdbool.h>
-#include <string.h>
-#include <signal.h>
-#include <fcntl.h>
 #include <sys/mman.h>
-#include <pthread.h>
-#include <semaphore.h>
-#include <asm/unistd.h>
-#include <sys/cobalt.h>
-#include <smokey/smokey.h>
+#include <unistd.h>
 
 smokey_test_plugin(sigdebug,
 		   SMOKEY_ARGLIST(
diff --git a/testsuite/smokey/timerfd/timerfd.c b/testsuite/smokey/timerfd/timerfd.c
index 6bda0721e1c6292888ccb2c77603cd18634ef0d2..2ac99300aefb0a7f16a64cc3f9f858686922740a 100644
--- a/testsuite/smokey/timerfd/timerfd.c
+++ b/testsuite/smokey/timerfd/timerfd.c
@@ -21,13 +21,11 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <sys/timerfd.h>
 #include <smokey/smokey.h>
 
+#include <sys/timerfd.h>
+#include <unistd.h>
+
 smokey_test_plugin(timerfd,
 		   SMOKEY_NOARGS,
 		   "Check timerfd support."
diff --git a/testsuite/smokey/tsc/tsc.c b/testsuite/smokey/tsc/tsc.c
index e4b28b3789b3630ed7b2e46e54a101ead347c20c..77fad13e58e08e75c26e748f77d1eb7aae0b42e2 100644
--- a/testsuite/smokey/tsc/tsc.c
+++ b/testsuite/smokey/tsc/tsc.c
@@ -21,13 +21,10 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
+#include <smokey/smokey.h>
 
+#include <stdlib.h>
 #include <unistd.h>
-#include <sched.h>
-
-#include <smokey/smokey.h>
 
 #if CONFIG_SMP
 #define smp_sched_setaffinity(pid,len,mask) sched_setaffinity(pid,len,mask)
diff --git a/testsuite/smokey/x86io/x86io.c b/testsuite/smokey/x86io/x86io.c
index 9cfc092d007a42107c438df052115c0d540d12cc..cdfd2be8e3d349a4a1cd4685365de63109a142f3 100644
--- a/testsuite/smokey/x86io/x86io.c
+++ b/testsuite/smokey/x86io/x86io.c
@@ -8,11 +8,8 @@
  * Released under the terms of GPLv2.
  */
 
-#include <pthread.h>
-#include <sched.h>
-#include <signal.h>
 #include <smokey/smokey.h>
-#include <string.h>
+
 #include <sys/io.h>
 
 #define PORT (0x378)
diff --git a/testsuite/smokey/xddp/xddp.c b/testsuite/smokey/xddp/xddp.c
index 1d903f28e5b1e3c2810c303cfc8583c63e370665..e17e155cd061edbd1ace27735f4786ecc8db645a 100644
--- a/testsuite/smokey/xddp/xddp.c
+++ b/testsuite/smokey/xddp/xddp.c
@@ -6,17 +6,11 @@
  * Released under the terms of GPLv2.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <semaphore.h>
-#include <pthread.h>
-#include <fcntl.h>
-#include <errno.h>
 #include <smokey/smokey.h>
 #include <rtdm/ipc.h>
 
+#include <stdlib.h>
+
 smokey_test_plugin(xddp,
 		   SMOKEY_NOARGS,
 		   "Check RTIPC/XDDP protocol."
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 4318712cc45d2c04d8d6ac6482a210d12689345b..315c1b817ca341ea97b16dcc55da59239e9eb927 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -9,13 +9,13 @@
  */
 
 #include <asm/xenomai/syscall.h>
+#include <rtdm/ipc.h>
 #include <smokey/smokey.h>
+
 #include <sys/timerfd.h>
 #include <sys/utsname.h>
 #include <sys/syscall.h> /* For __NR_gettid definitions */
 #include <mqueue.h>
-#include <sched.h>
-#include <rtdm/ipc.h>
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 

-- 
2.54.0

