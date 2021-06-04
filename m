From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 09/12] cobalt/clock: dovetail: use refined monotonic source
Date: Fri,  4 Jun 2021 12:05:19 +0200
Message-Id: <fbb332b90d6cfd8e682ee8ee9c9adaafdcdd350c.1622801122.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1622801122.git.jan.kiszka@siemens.com>
References: <cover.1622801122.git.jan.kiszka@siemens.com>
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

In order to have applications calling clock_gettime(CLOCK_MONOTONIC)
and Cobalt share the same monotonic source, we need Cobalt to get
timestamps from ktime_get_mono_fast_ns().

Although pipeline_read_cycle_counter() does seem to hint to a raw
source, with Dovetail, our idea of time is directly based on a refined
count of nanoseconds since the epoch, the hardware time counter is
transparent to us. This naming discrepancy comes from the legacy
I-pipe support where we do manipulate hardware ticks internally; this
issue should go when such support is discontinued eventually.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/clock.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
index 6761ed70d..388367e6e 100644
--- a/include/cobalt/kernel/dovetail/pipeline/clock.h
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -13,8 +13,14 @@ struct timespec64;
 
 static inline u64 pipeline_read_cycle_counter(void)
 {
-	/* Read the raw cycle counter of the core clock. */
-	return  ktime_get_raw_fast_ns();
+	/*
+	 * With Dovetail, our idea of time is directly based on a
+	 * refined count of nanoseconds since the epoch, the hardware
+	 * time counter is transparent to us. For this reason,
+	 * xnclock_ticks_to_ns() and xnclock_ns_to_ticks() are
+	 * idempotent when building for Dovetail.
+	 */
+	return ktime_get_mono_fast_ns();
 }
 
 void pipeline_set_timer_shot(unsigned long cycles);
-- 
2.26.2


