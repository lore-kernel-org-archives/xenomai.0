From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 11/17] lib/cobalt/arm64: dovetail: skip detection of KUSER_TSC
 support
Date: Fri, 11 Jun 2021 20:05:37 +0200
Message-Id: <ac499690174c3e574d1e72d45d957e1c5c7954bb.1623434743.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623434743.git.jan.kiszka@siemens.com>
References: <cover.1623434743.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

When Dovetail is enabled in the kernel, we get timestamps for common
clocks (CLOCK_REALTIME, CLOCK_MONOTONIC) from the vDSO-based gettime()
routine as usual.  Do not expect KUSER_TSC support to be there in such
a case, it is not.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/arch/arm64/features.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/cobalt/arch/arm64/features.c b/lib/cobalt/arch/arm64/features.c
index 8b85a27ea..5baabfb69 100644
--- a/lib/cobalt/arch/arm64/features.c
+++ b/lib/cobalt/arch/arm64/features.c
@@ -25,6 +25,7 @@
 #include <unistd.h>
 #include <limits.h>
 #include <cobalt/wrappers.h>
+#include <cobalt/ticks.h>
 #include <asm/xenomai/syscall.h>
 #include <asm/xenomai/tsc.h>
 #include <asm/xenomai/features.h>
@@ -44,6 +45,9 @@ void cobalt_arch_check_features(struct cobalt_featinfo *finfo)
 	int err, fd;
 	void *addr;
 
+	if (!cobalt_use_legacy_tsc())
+		return;
+
 	if (__xn_tscinfo.kinfo.counter != NULL)
 		return;
 
-- 
2.26.2


