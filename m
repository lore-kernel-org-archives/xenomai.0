From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail 11/13] cobalt/timer: pipeline: abstract tick
 management
Date: Sat,  2 Jan 2021 10:33:51 +0100
Message-Id: <20210102093353.3195090-12-rpm@xenomai.org>
In-Reply-To: <20210102093353.3195090-1-rpm@xenomai.org>
References: <20210102093353.3195090-1-rpm@xenomai.org>
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

Dovetail comes with built-in support for proxy tick device management,
which enables a client core to grab control over the timer hardware
based on the common clockevents abstraction.

Once Dovetail's proxy tick device is declared to the common clockevent
device layer, all timing requests issued by the in-band kernel for
programming timer shots and controlling the device are transparently
redirected to the real-time core for handling.

The legacy ipipe_timer interface needs to move to the I-pipe section.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/intr.h                |   1 -
 include/cobalt/kernel/ipipe/pipeline/tick.h |  12 +
 include/cobalt/kernel/stat.h                |   3 -
 include/cobalt/kernel/timer.h               |   4 -
 kernel/cobalt/init.c                        |   5 +-
 kernel/cobalt/ipipe/Makefile                |   2 +-
 kernel/cobalt/ipipe/intr.c                  |   2 +-
 kernel/cobalt/ipipe/tick.c                  | 278 ++++++++++++++++++++
 kernel/cobalt/posix/corectl.c               |   5 +-
 kernel/cobalt/timer.c                       | 265 -------------------
 10 files changed, 298 insertions(+), 279 deletions(-)
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/tick.h
 create mode 100644 kernel/cobalt/ipipe/tick.c

diff --git a/include/cobalt/kernel/intr.h b/include/cobalt/kernel/intr.h
index 2e8253895..107b16bfc 100644
--- a/include/cobalt/kernel/intr.h
+++ b/include/cobalt/kernel/intr.h
@@ -133,7 +133,6 @@ void xnintr_affinity(struct xnintr *intr,
 		     cpumask_t cpumask);
 
 #ifdef CONFIG_XENO_OPT_STATS_IRQS
-extern struct xnintr nktimer;
 
 int xnintr_query_init(struct xnintr_iterator *iterator);
 
diff --git a/include/cobalt/kernel/ipipe/pipeline/tick.h b/include/cobalt/kernel/ipipe/pipeline/tick.h
new file mode 100644
index 000000000..409581a3c
--- /dev/null
+++ b/include/cobalt/kernel/ipipe/pipeline/tick.h
@@ -0,0 +1,12 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _COBALT_KERNEL_IPIPE_TICK_H
+#define _COBALT_KERNEL_IPIPE_TICK_H
+
+int pipeline_install_tick_proxy(void);
+
+void pipeline_uninstall_tick_proxy(void);
+
+#endif /* !_COBALT_KERNEL_IPIPE_TICK_H */
diff --git a/include/cobalt/kernel/stat.h b/include/cobalt/kernel/stat.h
index d252e1429..b08567b41 100644
--- a/include/cobalt/kernel/stat.h
+++ b/include/cobalt/kernel/stat.h
@@ -37,8 +37,6 @@ typedef struct xnstat_exectime {
 
 } xnstat_exectime_t;
 
-#define xnstat_percpu_data	raw_cpu_ptr(nktimer.stats)
-
 /* Return current date which can be passed to other xnstat services for
    immediate or lazy accounting. */
 #define xnstat_exectime_now() xnclock_core_read_raw()
@@ -114,7 +112,6 @@ static inline void xnstat_counter_set(xnstat_counter_t *c, unsigned long value)
 typedef struct xnstat_exectime {
 } xnstat_exectime_t;
 
-#define xnstat_percpu_data					NULL
 #define xnstat_exectime_now()					({ 0; })
 #define xnstat_exectime_update(sched, date)			do { } while (0)
 #define xnstat_exectime_set_current(sched, new_account)		({ (void)sched; NULL; })
diff --git a/include/cobalt/kernel/timer.h b/include/cobalt/kernel/timer.h
index 889504324..691be7a3b 100644
--- a/include/cobalt/kernel/timer.h
+++ b/include/cobalt/kernel/timer.h
@@ -557,10 +557,6 @@ static inline void xntimer_set_affinity(struct xntimer *timer,
 char *xntimer_format_time(xnticks_t ns,
 			  char *buf, size_t bufsz);
 
-int xntimer_grab_hardware(void);
-
-void xntimer_release_hardware(void);
-
 /** @} */
 
 #endif /* !_COBALT_KERNEL_TIMER_H */
diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
index 94b653350..f94943f2d 100644
--- a/kernel/cobalt/init.c
+++ b/kernel/cobalt/init.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <xenomai/version.h>
 #include <pipeline/machine.h>
+#include <pipeline/tick.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/timer.h>
 #include <cobalt/kernel/heap.h>
@@ -112,7 +113,7 @@ static void sys_shutdown(void)
 {
 	void *membase;
 
-	xntimer_release_hardware();
+	pipeline_uninstall_tick_proxy();
 	xnsched_destroy_all();
 	xnregistry_cleanup();
 	membase = xnheap_get_membase(&cobalt_heap);
@@ -168,7 +169,7 @@ static __init int sys_init(void)
 	 * not enable the core timer.
 	 */
 	if (realtime_core_state() == COBALT_STATE_WARMUP) {
-		ret = xntimer_grab_hardware();
+		ret = pipeline_install_tick_proxy();
 		if (ret) {
 			sys_shutdown();
 			return ret;
diff --git a/kernel/cobalt/ipipe/Makefile b/kernel/cobalt/ipipe/Makefile
index 13186dc7f..0490f8800 100644
--- a/kernel/cobalt/ipipe/Makefile
+++ b/kernel/cobalt/ipipe/Makefile
@@ -2,4 +2,4 @@ ccflags-y += -Ikernel
 
 obj-y +=	pipeline.o
 
-pipeline-y :=	init.o intr.o kevents.o apc.o
+pipeline-y :=	init.o intr.o kevents.o apc.o tick.o
diff --git a/kernel/cobalt/ipipe/intr.c b/kernel/cobalt/ipipe/intr.c
index d45c22326..91b63d490 100644
--- a/kernel/cobalt/ipipe/intr.c
+++ b/kernel/cobalt/ipipe/intr.c
@@ -143,7 +143,7 @@ static inline xnstat_exectime_t *switch_core_irqstats(struct xnsched *sched)
 	struct xnirqstat *statp;
 	xnstat_exectime_t *prev;
 
-	statp = xnstat_percpu_data;
+	statp = raw_cpu_ptr(nktimer.stats);
 	prev = xnstat_exectime_switch(sched, &statp->account);
 	xnstat_counter_inc(&statp->hits);
 
diff --git a/kernel/cobalt/ipipe/tick.c b/kernel/cobalt/ipipe/tick.c
new file mode 100644
index 000000000..da1563a66
--- /dev/null
+++ b/kernel/cobalt/ipipe/tick.c
@@ -0,0 +1,278 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2001,2002,2003,2007,2012 Philippe Gerum <rpm@xenomai.org>.
+ * Copyright (C) 2004 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
+ */
+#include <linux/ipipe.h>
+#include <linux/ipipe_tickdev.h>
+#include <linux/sched.h>
+#include <cobalt/kernel/sched.h>
+#include <cobalt/kernel/timer.h>
+#include <cobalt/kernel/intr.h>
+#include <cobalt/kernel/clock.h>
+#include <cobalt/kernel/arith.h>
+
+extern struct xnintr nktimer;
+
+/**
+ * @internal
+ * @fn static int program_htick_shot(unsigned long delay, struct clock_event_device *cdev)
+ *
+ * @brief Program next host tick as a Xenomai timer event.
+ *
+ * Program the next shot for the host tick on the current CPU.
+ * Emulation is done using a nucleus timer attached to the master
+ * timebase.
+ *
+ * @param delay The time delta from the current date to the next tick,
+ * expressed as a count of nanoseconds.
+ *
+ * @param cdev An pointer to the clock device which notifies us.
+ *
+ * @coretags{unrestricted}
+ */
+static int program_htick_shot(unsigned long delay,
+			      struct clock_event_device *cdev)
+{
+	struct xnsched *sched;
+	int ret;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+	sched = xnsched_current();
+	ret = xntimer_start(&sched->htimer, delay, XN_INFINITE, XN_RELATIVE);
+	xnlock_put_irqrestore(&nklock, s);
+
+	return ret ? -ETIME : 0;
+}
+
+/**
+ * @internal
+ * @fn void switch_htick_mode(enum clock_event_mode mode, struct clock_event_device *cdev)
+ *
+ * @brief Tick mode switch emulation callback.
+ *
+ * Changes the host tick mode for the tick device of the current CPU.
+ *
+ * @param mode The new mode to switch to. The possible values are:
+ *
+ * - CLOCK_EVT_MODE_ONESHOT, for a switch to oneshot mode.
+ *
+ * - CLOCK_EVT_MODE_PERIODIC, for a switch to periodic mode. The current
+ * implementation for the generic clockevent layer Linux exhibits
+ * should never downgrade from a oneshot to a periodic tick mode, so
+ * this mode should not be encountered. This said, the associated code
+ * is provided, basically for illustration purposes.
+ *
+ * - CLOCK_EVT_MODE_SHUTDOWN, indicates the removal of the current
+ * tick device. Normally, the nucleus only interposes on tick devices
+ * which should never be shut down, so this mode should not be
+ * encountered.
+ *
+ * @param cdev An opaque pointer to the clock device which notifies us.
+ *
+ * @coretags{unrestricted}
+ *
+ * @note GENERIC_CLOCKEVENTS is required from the host kernel.
+ */
+static void switch_htick_mode(enum clock_event_mode mode,
+			      struct clock_event_device *cdev)
+{
+	struct xnsched *sched;
+	xnticks_t tickval;
+	spl_t s;
+
+	if (mode == CLOCK_EVT_MODE_ONESHOT)
+		return;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	sched = xnsched_current();
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		tickval = 1000000000UL / HZ;
+		xntimer_start(&sched->htimer, tickval, tickval, XN_RELATIVE);
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		xntimer_stop(&sched->htimer);
+		break;
+	default:
+		XENO_BUG(COBALT);
+	}
+
+	xnlock_put_irqrestore(&nklock, s);
+}
+
+static int grab_timer_on_cpu(int cpu)
+{
+	int tickval, ret;
+
+	ret = ipipe_timer_start(xnintr_core_clock_handler,
+				switch_htick_mode, program_htick_shot, cpu);
+	switch (ret) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		/*
+		 * Oneshot tick emulation callback won't be used, ask
+		 * the caller to start an internal timer for emulating
+		 * a periodic tick.
+		 */
+		tickval = 1000000000UL / HZ;
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* oneshot tick emulation */
+		tickval = 1;
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+		/* we don't need to emulate the tick at all. */
+		tickval = 0;
+		break;
+
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		return -ENODEV;
+
+	default:
+		return ret;
+	}
+
+	return tickval;
+}
+
+/**
+ * @fn int pipeline_install_tick_proxy(void)
+ * @brief Grab the hardware timer on all real-time CPUs.
+ *
+ * pipeline_install_tick_proxy() grabs and tunes the hardware timer for all
+ * real-time CPUs.
+ *
+ * Host tick emulation is performed for sharing the clock chip between
+ * Linux and Xenomai.
+ *
+ * @return a positive value is returned on success, representing the
+ * duration of a Linux periodic tick expressed as a count of
+ * nanoseconds; zero should be returned when the Linux kernel does not
+ * undergo periodic timing on the given CPU (e.g. oneshot
+ * mode). Otherwise:
+ *
+ * - -EBUSY is returned if the hardware timer has already been
+ * grabbed.  xntimer_release_hardware() must be issued before
+ * pipeline_install_tick_proxy() is called again.
+ *
+ * - -ENODEV is returned if the hardware timer cannot be used.  This
+ * situation may occur after the kernel disabled the timer due to
+ * invalid calibration results; in such a case, such hardware is
+ * unusable for any timing duties.
+ *
+ * @coretags{secondary-only}
+ */
+
+int pipeline_install_tick_proxy(void)
+{
+	struct xnsched *sched;
+	int ret, cpu, _cpu;
+	spl_t s;
+
+#ifdef CONFIG_XENO_OPT_STATS_IRQS
+	/*
+	 * Only for statistical purpose, the timer interrupt is
+	 * attached by pipeline_install_tick_proxy().
+	 */
+	xnintr_init(&nktimer, "[timer]",
+		    per_cpu(ipipe_percpu.hrtimer_irq, 0), NULL, NULL, 0);
+#endif /* CONFIG_XENO_OPT_STATS_IRQS */
+
+	nkclock.wallclock_offset =
+		ktime_to_ns(ktime_get_real()) - xnclock_read_monotonic(&nkclock);
+
+	ret = xntimer_setup_ipi();
+	if (ret)
+		return ret;
+
+	for_each_realtime_cpu(cpu) {
+		ret = grab_timer_on_cpu(cpu);
+		if (ret < 0)
+			goto fail;
+
+		xnlock_get_irqsave(&nklock, s);
+
+		/*
+		 * If the current tick device for the target CPU is
+		 * periodic, we won't be called back for host tick
+		 * emulation. Therefore, we need to start a periodic
+		 * nucleus timer which will emulate the ticking for
+		 * that CPU, since we are going to hijack the hw clock
+		 * chip for managing our own system timer.
+		 *
+		 * CAUTION:
+		 *
+		 * - nucleus timers may be started only _after_ the hw
+		 * timer has been set up for the target CPU through a
+		 * call to pipeline_install_tick_proxy().
+		 *
+		 * - we don't compensate for the elapsed portion of
+		 * the current host tick, since we cannot get this
+		 * information easily for all CPUs except the current
+		 * one, and also because of the declining relevance of
+		 * the jiffies clocksource anyway.
+		 *
+		 * - we must not hold the nklock across calls to
+		 * pipeline_install_tick_proxy().
+		 */
+
+		sched = xnsched_struct(cpu);
+		/* Set up timer with host tick period if valid. */
+		if (ret > 1)
+			xntimer_start(&sched->htimer, ret, ret, XN_RELATIVE);
+		else if (ret == 1)
+			xntimer_start(&sched->htimer, 0, 0, XN_RELATIVE);
+
+		xnlock_put_irqrestore(&nklock, s);
+	}
+
+	return 0;
+fail:
+	for_each_realtime_cpu(_cpu) {
+		if (_cpu == cpu)
+			break;
+		xnlock_get_irqsave(&nklock, s);
+		sched = xnsched_struct(cpu);
+		xntimer_stop(&sched->htimer);
+		xnlock_put_irqrestore(&nklock, s);
+		ipipe_timer_stop(_cpu);
+	}
+
+	xntimer_release_ipi();
+
+	return ret;
+}
+
+/**
+ * @fn void pipeline_uninstall_tick_proxy(void)
+ * @brief Release hardware timers.
+ *
+ * Releases hardware timers previously grabbed by a call to
+ * pipeline_install_tick_proxy().
+ *
+ * @coretags{secondary-only}
+ */
+void pipeline_uninstall_tick_proxy(void)
+{
+	int cpu;
+
+	/*
+	 * We must not hold the nklock while stopping the hardware
+	 * timer, since this could cause deadlock situations to arise
+	 * on SMP systems.
+	 */
+	for_each_realtime_cpu(cpu)
+		ipipe_timer_stop(cpu);
+
+	xntimer_release_ipi();
+
+#ifdef CONFIG_XENO_OPT_STATS_IRQS
+	xnintr_destroy(&nktimer);
+#endif /* CONFIG_XENO_OPT_STATS_IRQS */
+}
diff --git a/kernel/cobalt/posix/corectl.c b/kernel/cobalt/posix/corectl.c
index 998fe572d..fd012d029 100644
--- a/kernel/cobalt/posix/corectl.c
+++ b/kernel/cobalt/posix/corectl.c
@@ -23,6 +23,7 @@
 #include <cobalt/kernel/init.h>
 #include <cobalt/kernel/thread.h>
 #include <xenomai/version.h>
+#include <pipeline/tick.h>
 #include <asm/xenomai/syscall.h>
 #include "corectl.h"
 
@@ -147,7 +148,7 @@ static int stop_services(const void __user *u_buf, size_t u_bufsz)
 		ret = xnthread_killall(final_grace_period, 0);
 		if (ret == -EAGAIN)
 			printk(XENO_WARNING "some RTDM tasks won't stop");
-		xntimer_release_hardware();
+		pipeline_uninstall_tick_proxy();
 		set_realtime_core_state(COBALT_STATE_STOPPED);
 		printk(XENO_INFO "services stopped\n");
 		break;
@@ -170,7 +171,7 @@ static int start_services(void)
 	case COBALT_STATE_RUNNING:
 		break;
 	case COBALT_STATE_STOPPED:
-		xntimer_grab_hardware();
+		pipeline_install_tick_proxy();
 		cobalt_call_state_chain(COBALT_STATE_WARMUP);
 		set_realtime_core_state(COBALT_STATE_RUNNING);
 		printk(XENO_INFO "services started\n");
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index b8c3f5a11..7f5033c87 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -17,8 +17,6 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#include <linux/ipipe.h>
-#include <linux/ipipe_tickdev.h>
 #include <linux/sched.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/thread.h>
@@ -681,269 +679,6 @@ char *xntimer_format_time(xnticks_t ns, char *buf, size_t bufsz)
 }
 EXPORT_SYMBOL_GPL(xntimer_format_time);
 
-/**
- * @internal
- * @fn static int program_htick_shot(unsigned long delay, struct clock_event_device *cdev)
- *
- * @brief Program next host tick as a Xenomai timer event.
- *
- * Program the next shot for the host tick on the current CPU.
- * Emulation is done using a nucleus timer attached to the master
- * timebase.
- *
- * @param delay The time delta from the current date to the next tick,
- * expressed as a count of nanoseconds.
- *
- * @param cdev An pointer to the clock device which notifies us.
- *
- * @coretags{unrestricted}
- */
-static int program_htick_shot(unsigned long delay,
-			      struct clock_event_device *cdev)
-{
-	struct xnsched *sched;
-	int ret;
-	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
-	sched = xnsched_current();
-	ret = xntimer_start(&sched->htimer, delay, XN_INFINITE, XN_RELATIVE);
-	xnlock_put_irqrestore(&nklock, s);
-
-	return ret ? -ETIME : 0;
-}
-
-/**
- * @internal
- * @fn void switch_htick_mode(enum clock_event_mode mode, struct clock_event_device *cdev)
- *
- * @brief Tick mode switch emulation callback.
- *
- * Changes the host tick mode for the tick device of the current CPU.
- *
- * @param mode The new mode to switch to. The possible values are:
- *
- * - CLOCK_EVT_MODE_ONESHOT, for a switch to oneshot mode.
- *
- * - CLOCK_EVT_MODE_PERIODIC, for a switch to periodic mode. The current
- * implementation for the generic clockevent layer Linux exhibits
- * should never downgrade from a oneshot to a periodic tick mode, so
- * this mode should not be encountered. This said, the associated code
- * is provided, basically for illustration purposes.
- *
- * - CLOCK_EVT_MODE_SHUTDOWN, indicates the removal of the current
- * tick device. Normally, the nucleus only interposes on tick devices
- * which should never be shut down, so this mode should not be
- * encountered.
- *
- * @param cdev An opaque pointer to the clock device which notifies us.
- *
- * @coretags{unrestricted}
- *
- * @note GENERIC_CLOCKEVENTS is required from the host kernel.
- */
-static void switch_htick_mode(enum clock_event_mode mode,
-			      struct clock_event_device *cdev)
-{
-	struct xnsched *sched;
-	xnticks_t tickval;
-	spl_t s;
-
-	if (mode == CLOCK_EVT_MODE_ONESHOT)
-		return;
-
-	xnlock_get_irqsave(&nklock, s);
-
-	sched = xnsched_current();
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		tickval = 1000000000UL / HZ;
-		xntimer_start(&sched->htimer, tickval, tickval, XN_RELATIVE);
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		xntimer_stop(&sched->htimer);
-		break;
-	default:
-		XENO_BUG(COBALT);
-	}
-
-	xnlock_put_irqrestore(&nklock, s);
-}
-
-/**
- * @fn int xntimer_grab_hardware(void)
- * @brief Grab the hardware timer on all real-time CPUs.
- *
- * xntimer_grab_hardware() grabs and tunes the hardware timer for all
- * real-time CPUs.
- *
- * Host tick emulation is performed for sharing the clock chip between
- * Linux and Xenomai.
- *
- * @return a positive value is returned on success, representing the
- * duration of a Linux periodic tick expressed as a count of
- * nanoseconds; zero should be returned when the Linux kernel does not
- * undergo periodic timing on the given CPU (e.g. oneshot
- * mode). Otherwise:
- *
- * - -EBUSY is returned if the hardware timer has already been
- * grabbed.  xntimer_release_hardware() must be issued before
- * xntimer_grab_hardware() is called again.
- *
- * - -ENODEV is returned if the hardware timer cannot be used.  This
- * situation may occur after the kernel disabled the timer due to
- * invalid calibration results; in such a case, such hardware is
- * unusable for any timing duties.
- *
- * @coretags{secondary-only}
- */
-static int grab_hardware_timer(int cpu)
-{
-	int tickval, ret;
-
-	ret = ipipe_timer_start(xnintr_core_clock_handler,
-				switch_htick_mode, program_htick_shot, cpu);
-	switch (ret) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		/*
-		 * Oneshot tick emulation callback won't be used, ask
-		 * the caller to start an internal timer for emulating
-		 * a periodic tick.
-		 */
-		tickval = 1000000000UL / HZ;
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* oneshot tick emulation */
-		tickval = 1;
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:
-		/* we don't need to emulate the tick at all. */
-		tickval = 0;
-		break;
-
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		return -ENODEV;
-
-	default:
-		return ret;
-	}
-
-	return tickval;
-}
-
-int xntimer_grab_hardware(void)
-{
-	struct xnsched *sched;
-	int ret, cpu, _cpu;
-	spl_t s;
-
-#ifdef CONFIG_XENO_OPT_STATS_IRQS
-	/*
-	 * Only for statistical purpose, the timer interrupt is
-	 * attached by xntimer_grab_hardware().
-	 */
-	xnintr_init(&nktimer, "[timer]",
-		    per_cpu(ipipe_percpu.hrtimer_irq, 0), NULL, NULL, 0);
-#endif /* CONFIG_XENO_OPT_STATS_IRQS */
-
-	nkclock.wallclock_offset =
-		ktime_to_ns(ktime_get_real()) - xnclock_read_monotonic(&nkclock);
-
-	ret = xntimer_setup_ipi();
-	if (ret)
-		return ret;
-
-	for_each_realtime_cpu(cpu) {
-		ret = grab_hardware_timer(cpu);
-		if (ret < 0)
-			goto fail;
-
-		xnlock_get_irqsave(&nklock, s);
-
-		/*
-		 * If the current tick device for the target CPU is
-		 * periodic, we won't be called back for host tick
-		 * emulation. Therefore, we need to start a periodic
-		 * nucleus timer which will emulate the ticking for
-		 * that CPU, since we are going to hijack the hw clock
-		 * chip for managing our own system timer.
-		 *
-		 * CAUTION:
-		 *
-		 * - nucleus timers may be started only _after_ the hw
-		 * timer has been set up for the target CPU through a
-		 * call to xntimer_grab_hardware().
-		 *
-		 * - we don't compensate for the elapsed portion of
-		 * the current host tick, since we cannot get this
-		 * information easily for all CPUs except the current
-		 * one, and also because of the declining relevance of
-		 * the jiffies clocksource anyway.
-		 *
-		 * - we must not hold the nklock across calls to
-		 * xntimer_grab_hardware().
-		 */
-
-		sched = xnsched_struct(cpu);
-		/* Set up timer with host tick period if valid. */
-		if (ret > 1)
-			xntimer_start(&sched->htimer, ret, ret, XN_RELATIVE);
-		else if (ret == 1)
-			xntimer_start(&sched->htimer, 0, 0, XN_RELATIVE);
-
-		xnlock_put_irqrestore(&nklock, s);
-	}
-
-	return 0;
-fail:
-	for_each_realtime_cpu(_cpu) {
-		if (_cpu == cpu)
-			break;
-		xnlock_get_irqsave(&nklock, s);
-		sched = xnsched_struct(cpu);
-		xntimer_stop(&sched->htimer);
-		xnlock_put_irqrestore(&nklock, s);
-		ipipe_timer_stop(_cpu);
-	}
-
-	xntimer_release_ipi();
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(xntimer_grab_hardware);
-
-/**
- * @fn void xntimer_release_hardware(void)
- * @brief Release hardware timers.
- *
- * Releases hardware timers previously grabbed by a call to
- * xntimer_grab_hardware().
- *
- * @coretags{secondary-only}
- */
-void xntimer_release_hardware(void)
-{
-	int cpu;
-
-	/*
-	 * We must not hold the nklock while stopping the hardware
-	 * timer, since this could cause deadlock situations to arise
-	 * on SMP systems.
-	 */
-	for_each_realtime_cpu(cpu)
-		ipipe_timer_stop(cpu);
-
-	xntimer_release_ipi();
-
-#ifdef CONFIG_XENO_OPT_STATS_IRQS
-	xnintr_destroy(&nktimer);
-#endif /* CONFIG_XENO_OPT_STATS_IRQS */
-}
-EXPORT_SYMBOL_GPL(xntimer_release_hardware);
-
 #if defined(CONFIG_XENO_OPT_TIMER_RBTREE)
 static inline bool xntimerh_is_lt(xntimerh_t *left, xntimerh_t *right)
 {
-- 
2.26.2


