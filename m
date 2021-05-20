From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 16/25] cobalt/tick: dovetail: implement
 pipeline_set_timer_shot()
Date: Thu, 20 May 2021 23:44:26 +0200
Message-Id: <9f27d0341e36b617582ae63849a27b0e3c673dd9.1621547075.git.jan.kiszka@siemens.com>
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
[Philippe: clarify some variable names]
Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../cobalt/kernel/dovetail/pipeline/clock.h   | 12 +-------
 kernel/cobalt/dovetail/tick.c                 | 28 +++++++++++++++++++
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
index 1cd7530655..d5443a4fd6 100644
--- a/include/cobalt/kernel/dovetail/pipeline/clock.h
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -19,17 +19,7 @@ static inline u64 pipeline_read_cycle_counter(void)
 	return 0;
 }
 
-static inline void pipeline_set_timer_shot(unsigned long cycles)
-{
-	/*
-	 * N/A. Revisit: xnclock_core_local_shot() should go to the
-	 * I-pipe section, we do things differently on Dovetail via
-	 * the proxy tick device. As a consequence,
-	 * pipeline_set_timer_shot() should not be part of the
-	 * pipeline interface.
-	 */
-	TODO();
-}
+void pipeline_set_timer_shot(unsigned long cycles);
 
 static inline const char *pipeline_timer_name(void)
 {
diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index fba9f78d00..a6633348b1 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -14,6 +14,34 @@
 
 static DEFINE_PER_CPU(struct clock_proxy_device *, proxy_device);
 
+void pipeline_set_timer_shot(unsigned long delay) /* ns */
+{
+	struct clock_proxy_device *dev = __this_cpu_read(proxy_device);
+	struct clock_event_device *real_dev = dev->real_device;
+	u64 cycles;
+	ktime_t t;
+	int ret;
+
+	if (real_dev->features & CLOCK_EVT_FEAT_KTIME) {
+		t = ktime_add(delay, xnclock_core_read_raw());
+		real_dev->set_next_ktime(t, real_dev);
+	} else {
+		if (delay <= 0) {
+			delay = real_dev->min_delta_ns;
+		} else {
+			delay = min_t(int64_t, delay,
+				real_dev->max_delta_ns);
+			delay = max_t(int64_t, delay,
+				real_dev->min_delta_ns);
+		}
+		cycles = ((u64)delay * real_dev->mult) >> real_dev->shift;
+		ret = real_dev->set_next_event(cycles, real_dev);
+		if (ret)
+			real_dev->set_next_event(real_dev->min_delta_ticks,
+						real_dev);
+	}
+}
+
 static int proxy_set_next_ktime(ktime_t expires,
 				struct clock_event_device *proxy_dev)
 {
-- 
2.26.2


