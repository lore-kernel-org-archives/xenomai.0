From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 03/10] dovetail/clock: implement pipeline_get_host_time
Date: Mon, 11 Jan 2021 01:43:11 -0500
Message-Id: <20210111064318.6154-3-hongzhan.chen@intel.com>
In-Reply-To: <20210111064318.6154-1-hongzhan.chen@intel.com>
References: <20210111064318.6154-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 include/cobalt/kernel/dovetail/pipeline/clock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
index 5176b1506..28d89b44b 100644
--- a/include/cobalt/kernel/dovetail/pipeline/clock.h
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -7,6 +7,7 @@
 
 #include <cobalt/uapi/kernel/types.h>
 #include <cobalt/kernel/assert.h>
+#include <linux/ktime.h>
 
 struct timespec64;
 
@@ -50,7 +51,7 @@ static inline const char *pipeline_clock_name(void)
 static inline int pipeline_get_host_time(struct timespec64 *tp)
 {
 	/* Convert ktime_get_real_fast_ns() to timespec. */
-	TODO();
+	*tp = ktime_to_timespec64(ktime_get_real_fast_ns());
 
 	return 0;
 }
-- 
2.17.1


