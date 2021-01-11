From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 09/10] dovetail/clock: implement pipeline_timer_name to get
 name of real device
Date: Mon, 11 Jan 2021 01:43:17 -0500
Message-Id: <20210111064318.6154-9-hongzhan.chen@intel.com>
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
 include/cobalt/kernel/dovetail/pipeline/clock.h | 5 ++---
 kernel/cobalt/dovetail/tick.c                   | 8 ++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
index ce9a5c867..771104ab4 100644
--- a/include/cobalt/kernel/dovetail/pipeline/clock.h
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -12,6 +12,7 @@
 struct timespec64;
 
 extern inline void xnproxy_timer_set(unsigned long delta);
+inline const char *xn_get_timer_name(void);
 
 static inline u64 pipeline_read_cycle_counter(void)
 {
@@ -37,9 +38,7 @@ static inline const char *pipeline_timer_name(void)
 	 * Return the name of the current clock event chip, which is
 	 * the real device controlled by the proxy tick device.
 	 */
-	TODO();
-
-	return "?";
+	return xn_get_timer_name();
 }
 
 static inline const char *pipeline_clock_name(void)
diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index 58662e94e..e40ec06cb 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -16,6 +16,14 @@ extern struct xnintr nktimer;
 
 static DEFINE_PER_CPU(struct clock_proxy_device *, proxy_device);
 
+inline const char *xn_get_timer_name(void)
+{
+	struct clock_proxy_device *dev = __this_cpu_read(proxy_device);
+	struct clock_event_device *real_dev = dev->real_device;
+
+	return real_dev->name;
+}
+
 inline void xnproxy_timer_set(unsigned long delta)
 {
 	struct clock_proxy_device *dev = __this_cpu_read(proxy_device);
-- 
2.17.1


