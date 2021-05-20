From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 12/25] cobalt/clock: dovetail: provide backend code to
 CLOCK_HOST_REALTIME
Date: Thu, 20 May 2021 23:44:22 +0200
Message-Id: <1ee3c70846c35bf37f004b530731d8381f8c4c35.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
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

From: Hongzhan Chen <hongzhan.chen@intel.com>

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/clock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
index 19e3d89865..1cd7530655 100644
--- a/include/cobalt/kernel/dovetail/pipeline/clock.h
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -7,6 +7,7 @@
 
 #include <cobalt/uapi/kernel/types.h>
 #include <cobalt/kernel/assert.h>
+#include <linux/ktime.h>
 
 struct timespec64;
 
@@ -52,7 +53,7 @@ static inline const char *pipeline_clock_name(void)
 static inline int pipeline_get_host_time(struct timespec64 *tp)
 {
 	/* Convert ktime_get_real_fast_ns() to timespec. */
-	TODO();
+	*tp = ktime_to_timespec64(ktime_get_real_fast_ns());
 
 	return 0;
 }
-- 
2.26.2


