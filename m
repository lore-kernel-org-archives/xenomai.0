From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 02/10] dovetail/clock: implement pipeline_read_cycle_counter
Date: Mon, 11 Jan 2021 01:43:10 -0500
Message-Id: <20210111064318.6154-2-hongzhan.chen@intel.com>
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
 include/cobalt/kernel/dovetail/pipeline/clock.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
index 19e3d8986..5176b1506 100644
--- a/include/cobalt/kernel/dovetail/pipeline/clock.h
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -13,9 +13,7 @@ struct timespec64;
 static inline u64 pipeline_read_cycle_counter(void)
 {
 	/* Read the raw cycle counter of the core clock. */
-	TODO();
-
-	return 0;
+	return  ktime_get_raw_fast_ns();
 }
 
 static inline void pipeline_set_timer_shot(unsigned long cycles)
-- 
2.17.1


