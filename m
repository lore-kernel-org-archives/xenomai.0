From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 08/10] dovetail/clock: implement pipeline_set_timer_shot to
 trigger tick shot
Date: Mon, 11 Jan 2021 01:43:16 -0500
Message-Id: <20210111064318.6154-8-hongzhan.chen@intel.com>
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
 .../cobalt/kernel/dovetail/pipeline/clock.h   |  4 +++-
 kernel/cobalt/dovetail/tick.c                 | 24 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
index 28d89b44b..ce9a5c867 100644
--- a/include/cobalt/kernel/dovetail/pipeline/clock.h
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -11,6 +11,8 @@
 
 struct timespec64;
 
+extern inline void xnproxy_timer_set(unsigned long delta);
+
 static inline u64 pipeline_read_cycle_counter(void)
 {
 	/* Read the raw cycle counter of the core clock. */
@@ -26,7 +28,7 @@ static inline void pipeline_set_timer_shot(unsigned long cycles)
 	 * pipeline_set_timer_shot() should not be part of the
 	 * pipeline interface.
 	 */
-	TODO();
+	xnproxy_timer_set(cycles);
 }
 
 static inline const char *pipeline_timer_name(void)
diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index 6a196496c..58662e94e 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -16,6 +16,30 @@ extern struct xnintr nktimer;
 
 static DEFINE_PER_CPU(struct clock_proxy_device *, proxy_device);
 
+inline void xnproxy_timer_set(unsigned long delta)
+{
+	struct clock_proxy_device *dev = __this_cpu_read(proxy_device);
+	struct clock_event_device *real_dev = dev->real_device;
+	int ret;
+	u64 cycles;
+
+	if (delta <= 0)
+		delta = real_dev->min_delta_ns;
+	else {
+		delta = min_t(int64_t, delta,
+				(int64_t)real_dev->max_delta_ns);
+		delta = max_t(int64_t, delta,
+					(int64_t)real_dev->min_delta_ns);
+	}
+	cycles = ((u64)delta * real_dev->mult) >> real_dev->shift;
+
+	ret = real_dev->set_next_event(cycles, real_dev);
+	if (ret) {
+		ret = real_dev->set_next_event(real_dev->min_delta_ticks,
+					real_dev);
+	}
+}
+
 static int proxy_set_next_ktime(ktime_t expires,
 				struct clock_event_device *proxy_dev)
 {
-- 
2.17.1


