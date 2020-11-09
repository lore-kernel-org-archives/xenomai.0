From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 07/15] cobalt/timer: implement xnproxy_timer_set to substitute
 ipipe
Date: Mon,  9 Nov 2020 02:50:19 -0500
Message-Id: <20201109075027.14760-7-hongzhan.chen@intel.com>
In-Reply-To: <20201109075027.14760-1-hongzhan.chen@intel.com>
References: <20201109075027.14760-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com, xenomai@xenomai.org

implement xnproxy_timer_set to substitute ipipe_timer_set to set
next timer event via real_dev

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 include/cobalt/kernel/timer.h |  2 ++
 kernel/cobalt/clock.c         |  3 ++-
 kernel/cobalt/timer.c         | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/timer.h b/include/cobalt/kernel/timer.h
index 711388188..f00c490a9 100644
--- a/include/cobalt/kernel/timer.h
+++ b/include/cobalt/kernel/timer.h
@@ -370,6 +370,8 @@ void __xntimer_init(struct xntimer *timer,
 		    struct xnsched *sched,
 		    int flags);
 
+void xnproxy_timer_set(unsigned long delta, ktime_t tdata);
+
 void xntimer_set_gravity(struct xntimer *timer,
 			 int gravity);
 
diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index ab9fa394d..94db7a6fa 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -18,6 +18,7 @@
  */
 #include <linux/percpu.h>
 #include <linux/errno.h>
+#include <linux/irq_pipeline.h>
 //#include <linux/ipipe_tickdev.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/timer.h>
@@ -225,7 +226,7 @@ void xnclock_core_local_shot(struct xnsched *sched)
 #ifdef CONFIG_IPIPE
 	ipipe_timer_set(delay);
 #else
-#warning TODO
+	xnproxy_timer_set(delay, xntimerh_date(&timer->aplink));
 #endif
 }
 
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index 646166b87..03425e581 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -373,6 +373,34 @@ void __xntimer_init(struct xntimer *timer,
 }
 EXPORT_SYMBOL_GPL(__xntimer_init);
 
+void xnproxy_timer_set(unsigned long delta, ktime_t tdata)
+{
+	struct clock_proxy_device *dev = __this_cpu_read(proxy_device);
+	struct clock_event_device *real_dev = dev->real_device;
+	int ret;
+	u64 cycles;
+	/* these code are ported from evl_program_proxy_tick */
+	if (real_dev->features & CLOCK_EVT_FEAT_KTIME) {
+		real_dev->set_next_ktime(tdata, real_dev);
+	} else {
+		if (delta <= 0)
+			delta = real_dev->min_delta_ns;
+		else {
+			delta = min_t(int64_t, delta,
+					(int64_t)real_dev->max_delta_ns);
+			delta = max_t(int64_t, delta,
+					(int64_t)real_dev->min_delta_ns);
+		}
+		cycles = ((u64)delta * real_dev->mult) >> real_dev->shift;
+		ret = real_dev->set_next_event(cycles, real_dev);
+		if (ret) {
+			real_dev->set_next_event(real_dev->min_delta_ticks,
+					real_dev);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(xnproxy_timer_set);
+
 void xntimer_set_gravity(struct xntimer *timer, int gravity)
 {
 	spl_t s;
-- 
2.17.1


