From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 15/25] cobalt/tick: dovetail: install/uninstall proxy tick
 device
Date: Thu, 20 May 2021 23:44:25 +0200
Message-Id: <4cbe75587bdbcc8bb83540ab25f52bdb8aa15d21.1621547075.git.jan.kiszka@siemens.com>
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
[Philippe: protect xntimer_start with nklock]
Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/tick.c | 83 ++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index 01927f7089..fba9f78d00 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -6,8 +6,87 @@
  */
 
 #include <linux/tick.h>
+#include <linux/clockchips.h>
 #include <cobalt/kernel/intr.h>
 #include <pipeline/tick.h>
+#include <cobalt/kernel/sched.h>
+#include <cobalt/kernel/timer.h>
+
+static DEFINE_PER_CPU(struct clock_proxy_device *, proxy_device);
+
+static int proxy_set_next_ktime(ktime_t expires,
+				struct clock_event_device *proxy_dev)
+{
+	struct xnsched *sched;
+	ktime_t delta;
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * When Negative delta have been observed, we set delta zero.
+	 * Or else exntimer_start() will return -ETIMEDOUT and do not
+	 * trigger shot
+	 */
+	delta = ktime_sub(expires, ktime_get_mono_fast_ns());
+	if (delta < 0)
+		delta = 0;
+
+	xnlock_get_irqsave(&nklock, flags);
+	sched = xnsched_current();
+	ret = xntimer_start(&sched->htimer, delta, XN_INFINITE, XN_RELATIVE);
+	xnlock_put_irqrestore(&nklock, flags);
+
+	return ret ? -ETIME : 0;
+}
+
+void xn_core_tick(struct clock_event_device *dummy) /* hard irqs off */
+{
+	xnintr_core_clock_handler();
+}
+
+static int proxy_set_oneshot_stopped(struct clock_event_device *proxy_dev)
+{
+	struct clock_event_device *real_dev;
+	struct clock_proxy_device *dev;
+	struct xnsched *sched;
+	spl_t s;
+
+	dev = container_of(proxy_dev, struct clock_proxy_device, proxy_device);
+
+	/*
+	 * In-band wants to disable the clock hardware on entering a
+	 * tickless state, so we have to stop our in-band tick
+	 * emulation. Propagate the request for shutting down the
+	 * hardware to the real device only if we have no outstanding
+	 * OOB timers. CAUTION: the in-band timer is counted when
+	 * assessing the RQ_IDLE condition, so we need to stop it
+	 * prior to testing the latter.
+	 */
+	xnlock_get_irqsave(&nklock, s);
+	sched = xnsched_current();
+	xntimer_stop(&sched->htimer);
+
+	if (sched->lflags & XNIDLE) {
+		real_dev = dev->real_device;
+		real_dev->set_state_oneshot_stopped(real_dev);
+	}
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return 0;
+}
+
+static void setup_proxy(struct clock_proxy_device *dev)
+{
+	struct clock_event_device *proxy_dev = &dev->proxy_device;
+
+	dev->handle_oob_event = xn_core_tick;
+	proxy_dev->features |= CLOCK_EVT_FEAT_KTIME;
+	proxy_dev->set_next_ktime = proxy_set_next_ktime;
+	if (proxy_dev->set_state_oneshot_stopped)
+		proxy_dev->set_state_oneshot_stopped = proxy_set_oneshot_stopped;
+	__this_cpu_write(proxy_device, dev);
+}
 
 int pipeline_install_tick_proxy(void)
 {
@@ -18,7 +97,7 @@ int pipeline_install_tick_proxy(void)
 		return ret;
 
 	/* Install the proxy tick device */
-	TODO();	ret = 0;
+	ret = tick_install_proxy(setup_proxy, &xnsched_realtime_cpus);
 	if (ret)
 		goto fail_proxy;
 
@@ -33,7 +112,7 @@ fail_proxy:
 void pipeline_uninstall_tick_proxy(void)
 {
 	/* Uninstall the proxy tick device. */
-	TODO();
+	tick_uninstall_proxy(&xnsched_realtime_cpus);
 
 	pipeline_free_timer_ipi();
 }
-- 
2.26.2


