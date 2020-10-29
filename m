From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH v3 5/7][wip/dovetail] cobalt/timer: make use of tick-proxy
 instead of original host tick
Date: Wed, 28 Oct 2020 22:15:38 -0400
Message-Id: <20201029021540.2824-5-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

make use of tick-proxy which is base infastructure of pipeline to
replace host tick of ipipeline.

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 include/cobalt/kernel/sched.h |  6 +++
 kernel/cobalt/timer.c         | 88 +++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index d4f449e4a..7faabdcae 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -53,6 +53,12 @@ DECLARE_PER_CPU(struct xn_machine_cpudata, xn_machine_cpudata);
 #define XNINIRQ		0x00004000	/* In IRQ handling context */
 #define XNHDEFER	0x00002000	/* Host tick deferred */
 
+/*
+ * Hardware timer is stopped.
+ */
+
+#define XNTSTOP		0x00008000
+
 struct xnsched_rt {
 	xnsched_queue_t runnable;	/*!< Runnable thread queue. */
 };
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index 9da2c6143..646166b87 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -20,6 +20,8 @@
 //#include <linux/ipipe.h>
 //#include <linux/ipipe_tickdev.h>
 #include <linux/sched.h>
+#include <linux/tick.h>
+#include <linux/clockchips.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/thread.h>
 #include <cobalt/kernel/timer.h>
@@ -29,6 +31,8 @@
 #include <cobalt/kernel/arith.h>
 #include <trace/events/cobalt-core.h>
 
+static DEFINE_PER_CPU(struct clock_proxy_device *, proxy_device);
+
 /**
  * @ingroup cobalt_core
  * @defgroup cobalt_core_timer Timer services
@@ -849,6 +853,83 @@ static int grab_hardware_timer(int cpu)
 	return -ENODEV;
 }
 
+void xn_core_tick(struct clock_event_device *dummy) /* hard irqs off */
+{
+	xnintr_core_clock_handler();
+}
+
+static int proxy_set_oneshot_stopped(struct clock_event_device *proxy_dev)
+{
+	struct clock_event_device *real_dev;
+	struct clock_proxy_device *dev;
+	unsigned long flags;
+	struct xnsched *sched;
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
+	flags = hard_local_irq_save();
+
+	sched = xnsched_current();
+	xntimer_stop(&sched->htimer);
+	sched->lflags |= XNTSTOP;
+
+	if (sched->lflags & XNIDLE) {
+		real_dev = dev->real_device;
+		real_dev->set_state_oneshot_stopped(real_dev);
+	}
+
+	hard_local_irq_restore(flags);
+
+	return 0;
+}
+
+/* refer to program_htick_shot  */
+
+static int proxy_set_next_ktime(ktime_t expires,
+				struct clock_event_device *proxy_dev)
+{
+	struct xnsched *sched;
+	unsigned long flags;
+	ktime_t delta;
+	int ret;
+
+	/*
+	 * Negative delta have been observed. evl_start_timer()
+	 * will trigger an immediate shot in such an event.
+	 */
+	delta = ktime_sub(expires, ktime_get());
+
+	flags = hard_local_irq_save(); /* Prevent CPU migration. */
+	sched = xnsched_current();
+	ret = xntimer_start(&sched->htimer, delta, XN_INFINITE, XN_RELATIVE);
+	hard_local_irq_restore(flags);
+
+	return ret ? -ETIME : 0;
+}
+
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
+
+	__this_cpu_write(proxy_device, dev);
+}
+
 int xntimer_grab_hardware(void)
 {
 	struct xnsched *sched;
@@ -871,6 +952,10 @@ int xntimer_grab_hardware(void)
 	if (ret)
 		return ret;
 
+	ret = tick_install_proxy(setup_proxy, &xnsched_realtime_cpus);
+	if (ret)
+		goto fail_proxy;
+
 	for_each_realtime_cpu(cpu) {
 		ret = grab_hardware_timer(cpu);
 		if (ret < 0)
@@ -914,6 +999,9 @@ int xntimer_grab_hardware(void)
 
 	return 0;
 fail:
+	tick_uninstall_proxy(&xnsched_realtime_cpus);
+
+fail_proxy:
 	for_each_realtime_cpu(_cpu) {
 		if (_cpu == cpu)
 			break;
-- 
2.17.1


