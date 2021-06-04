From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 10/12] cobalt/clock: pipeline: abstract handling of
 CLOCK_REALTIME
Date: Fri,  4 Jun 2021 12:05:20 +0200
Message-Id: <9ec113055e134621346b0951afc61048515be818.1622801122.git.jan.kiszka@siemens.com>
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

Dovetail allows the client core to share the common kernel clocks,
including CLOCK_REALTIME. This means the core does not have to
maintain the latter clock, but should hand over all requests to read
the clock and change its epoch to the corresponding in-band kernel
services instead. Conversely, Cobalt should keep on maintaining
CLOCK_REALTIME when running on top of the legacy I-pipe.

Abstract the management of CLOCK_REALTIME to enable such split based
on the underlying IRQ pipeline layer.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/clock.h                 | 12 ++--
 .../cobalt/kernel/dovetail/pipeline/clock.h   | 11 ++++
 include/cobalt/kernel/ipipe/pipeline/clock.h  |  5 ++
 kernel/cobalt/clock.c                         | 66 +++++++++++--------
 kernel/cobalt/dovetail/kevents.c              | 10 +++
 kernel/cobalt/ipipe/clock.c                   | 15 +++++
 kernel/cobalt/ipipe/tick.c                    |  3 -
 kernel/cobalt/posix/clock.c                   |  9 +--
 8 files changed, 89 insertions(+), 42 deletions(-)

diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
index 0e4f1e1cb..2f7b71404 100644
--- a/include/cobalt/kernel/clock.h
+++ b/include/cobalt/kernel/clock.h
@@ -43,7 +43,7 @@ struct xnclock_gravity {
 
 struct xnclock {
 	/** (ns) */
-	xnticks_t wallclock_offset;
+	xnsticks_t wallclock_offset;
 	/** (ns) */
 	xnticks_t resolution;
 	/** (raw clock ticks). */
@@ -112,9 +112,6 @@ void xnclock_deregister(struct xnclock *clock);
 
 void xnclock_tick(struct xnclock *clock);
 
-void xnclock_adjust(struct xnclock *clock,
-		    xnsticks_t delta);
-
 void xnclock_core_local_shot(struct xnsched *sched);
 
 void xnclock_core_remote_shot(struct xnsched *sched);
@@ -319,6 +316,8 @@ static inline void xnclock_reset_gravity(struct xnclock *clock)
 
 static inline xnticks_t xnclock_read_realtime(struct xnclock *clock)
 {
+	if (likely(clock == &nkclock))
+		return pipeline_read_wallclock();
 	/*
 	 * Return an adjusted value of the monotonic time with the
 	 * translated system wallclock offset.
@@ -326,6 +325,11 @@ static inline xnticks_t xnclock_read_realtime(struct xnclock *clock)
 	return xnclock_read_monotonic(clock) + xnclock_get_offset(clock);
 }
 
+void xnclock_apply_offset(struct xnclock *clock,
+			  xnsticks_t delta_ns);
+
+void xnclock_set_wallclock(xnticks_t epoch_ns);
+
 unsigned long long xnclock_divrem_billion(unsigned long long value,
 					  unsigned long *rem);
 
diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
index 388367e6e..d8c94ab43 100644
--- a/include/cobalt/kernel/dovetail/pipeline/clock.h
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -8,6 +8,7 @@
 #include <cobalt/uapi/kernel/types.h>
 #include <cobalt/kernel/assert.h>
 #include <linux/ktime.h>
+#include <linux/errno.h>
 
 struct timespec64;
 
@@ -23,6 +24,16 @@ static inline u64 pipeline_read_cycle_counter(void)
 	return ktime_get_mono_fast_ns();
 }
 
+static inline xnticks_t pipeline_read_wallclock(void)
+{
+	return ktime_get_real_fast_ns();
+}
+
+static inline int pipeline_set_wallclock(xnticks_t epoch_ns)
+{
+	return -EOPNOTSUPP;
+}
+
 void pipeline_set_timer_shot(unsigned long cycles);
 
 const char *pipeline_timer_name(void);
diff --git a/include/cobalt/kernel/ipipe/pipeline/clock.h b/include/cobalt/kernel/ipipe/pipeline/clock.h
index d35aea17b..a06d1aaae 100644
--- a/include/cobalt/kernel/ipipe/pipeline/clock.h
+++ b/include/cobalt/kernel/ipipe/pipeline/clock.h
@@ -6,6 +6,7 @@
 #define _COBALT_KERNEL_IPIPE_CLOCK_H
 
 #include <linux/ipipe_tickdev.h>
+#include <cobalt/uapi/kernel/types.h>
 
 struct timespec64;
 
@@ -16,6 +17,10 @@ static inline u64 pipeline_read_cycle_counter(void)
 	return t;
 }
 
+xnticks_t pipeline_read_wallclock(void);
+
+int pipeline_set_wallclock(xnticks_t epoch_ns);
+
 static inline void pipeline_set_timer_shot(unsigned long cycles)
 {
 	ipipe_timer_set(cycles);
diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index 2115b15ef..2b9efad4e 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -226,18 +226,28 @@ enqueue:
 	xntimer_enqueue(timer, q);
 }
 
-static void adjust_clock_timers(struct xnclock *clock, xnsticks_t delta)
+void xnclock_apply_offset(struct xnclock *clock, xnsticks_t delta_ns)
 {
 	struct xntimer *timer, *tmp;
 	struct list_head adjq;
 	struct xnsched *sched;
+	xnsticks_t delta;
 	xntimerq_it_t it;
 	unsigned int cpu;
 	xntimerh_t *h;
 	xntimerq_t *q;
 
+	atomic_only();
+
+	/*
+	 * The (real-time) epoch just changed for the clock. Since
+	 * timeout dates of timers are expressed as monotonic ticks
+	 * internally, we need to apply the new offset to the
+	 * monotonic clock to all outstanding timers based on the
+	 * affected clock.
+	 */
 	INIT_LIST_HEAD(&adjq);
-	delta = xnclock_ns_to_ticks(clock, delta);
+	delta = xnclock_ns_to_ticks(clock, delta_ns);
 
 	for_each_online_cpu(cpu) {
 		sched = xnsched_struct(cpu);
@@ -265,34 +275,28 @@ static void adjust_clock_timers(struct xnclock *clock, xnsticks_t delta)
 			xnclock_program_shot(clock, sched);
 	}
 }
+EXPORT_SYMBOL_GPL(xnclock_apply_offset);
 
-/**
- * @fn void xnclock_adjust(struct xnclock *clock, xnsticks_t delta)
- * @brief Adjust a clock time.
- *
- * This service changes the epoch for the given clock by applying the
- * specified tick delta on its wallclock offset.
- *
- * @param clock The clock to adjust.
- *
- * @param delta The adjustment value expressed in nanoseconds.
- *
- * @coretags{task-unrestricted, atomic-entry}
- *
- * @note Xenomai tracks the system time in @a nkclock, as a
- * monotonously increasing count of ticks since the epoch. The epoch
- * is initially the same as the underlying machine time.
- */
-void xnclock_adjust(struct xnclock *clock, xnsticks_t delta)
+void xnclock_set_wallclock(xnticks_t epoch_ns)
 {
-	xnticks_t now;
+	xnsticks_t old_offset_ns, offset_ns;
+	spl_t s;
 
-	nkclock.wallclock_offset += delta;
-	nkvdso->wallclock_offset = nkclock.wallclock_offset;
-	now = xnclock_read_monotonic(clock) + nkclock.wallclock_offset;
-	adjust_clock_timers(clock, delta);
+	/*
+	 * The epoch of CLOCK_REALTIME just changed. Since timeouts
+	 * are expressed as monotonic ticks, we need to apply the
+	 * wallclock-to-monotonic offset to all outstanding timers
+	 * based on this clock.
+	 */
+	xnlock_get_irqsave(&nklock, s);
+	old_offset_ns = nkclock.wallclock_offset;
+	offset_ns = (xnsticks_t)(epoch_ns - xnclock_core_read_monotonic());
+	nkclock.wallclock_offset = offset_ns;
+	nkvdso->wallclock_offset = offset_ns;
+	xnclock_apply_offset(&nkclock, offset_ns - old_offset_ns);
+	xnlock_put_irqrestore(&nklock, s);
 }
-EXPORT_SYMBOL_GPL(xnclock_adjust);
+EXPORT_SYMBOL_GPL(xnclock_set_wallclock);
 
 xnticks_t xnclock_core_read_monotonic(void)
 {
@@ -464,7 +468,7 @@ static int clock_show(struct xnvfile_regular_iterator *it, void *data)
 
 	if (clock->id >= 0)	/* External clock, print id. */
 		xnvfile_printf(it, "%7s: %d\n", "id", __COBALT_CLOCK_EXT(clock->id));
-		
+
 	xnvfile_printf(it, "%7s: irq=%Ld kernel=%Ld user=%Ld\n", "gravity",
 		       xnclock_ticks_to_ns(clock, xnclock_get_gravity(clock, irq)),
 		       xnclock_ticks_to_ns(clock, xnclock_get_gravity(clock, kernel)),
@@ -700,7 +704,7 @@ void xnclock_tick(struct xnclock *clock)
 	else
 #endif
 		tmq = &xnclock_this_timerdata(clock)->q;
-	
+
 	/*
 	 * Optimisation: any local timer reprogramming triggered by
 	 * invoked timer handlers can wait until we leave the tick
@@ -807,11 +811,17 @@ void xnclock_cleanup(void)
 
 int __init xnclock_init()
 {
+	spl_t s;
+
 #ifdef XNARCH_HAVE_NODIV_LLIMD
 	xnarch_init_u32frac(&bln_frac, 1, 1000000000);
 #endif
 	pipeline_init_clock();
 	xnclock_reset_gravity(&nkclock);
+	xnlock_get_irqsave(&nklock, s);
+	nkclock.wallclock_offset = pipeline_read_wallclock() -
+		xnclock_core_read_monotonic();
+	xnlock_put_irqrestore(&nklock, s);
 	xnclock_register(&nkclock, &xnsched_realtime_cpus);
 
 	return 0;
diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 37ff6ca4b..3987d119a 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -15,6 +15,7 @@
 #include <cobalt/kernel/thread.h>
 #include <cobalt/kernel/clock.h>
 #include <cobalt/kernel/vdso.h>
+#include <cobalt/kernel/init.h>
 #include <rtdm/driver.h>
 #include <trace/events/cobalt-core.h>
 #include "../posix/process.h"
@@ -528,6 +529,15 @@ void handle_inband_event(enum inband_event_type event, void *data)
 	}
 }
 
+/*
+ * Called by the in-band kernel when the CLOCK_REALTIME epoch changes.
+ */
+void inband_clock_was_set(void)
+{
+	if (realtime_core_enabled())
+		xnclock_set_wallclock(ktime_get_real_fast_ns());
+}
+
 #ifdef CONFIG_MMU
 
 int pipeline_prepare_current(void)
diff --git a/kernel/cobalt/ipipe/clock.c b/kernel/cobalt/ipipe/clock.c
index d40b0ac89..1c04eed94 100644
--- a/kernel/cobalt/ipipe/clock.c
+++ b/kernel/cobalt/ipipe/clock.c
@@ -7,6 +7,8 @@
 #include <cobalt/kernel/clock.h>
 #include <cobalt/kernel/vdso.h>
 #include <cobalt/kernel/arith.h>
+#include <cobalt/kernel/timer.h>
+#include <xenomai/posix/clock.h>
 #include <pipeline/machine.h>
 
 static unsigned long long clockfreq;
@@ -121,6 +123,19 @@ int pipeline_get_host_time(struct timespec64 *tp)
 #endif
 }
 
+xnticks_t pipeline_read_wallclock(void)
+{
+	return xnclock_read_monotonic(&nkclock) + xnclock_get_offset(&nkclock);
+}
+EXPORT_SYMBOL_GPL(pipeline_read_wallclock);
+
+int pipeline_set_wallclock(xnticks_t epoch_ns)
+{
+	xnclock_set_wallclock(epoch_ns);
+
+	return 0;
+}
+
 void pipeline_update_clock_freq(unsigned long long freq)
 {
 	spl_t s;
diff --git a/kernel/cobalt/ipipe/tick.c b/kernel/cobalt/ipipe/tick.c
index d6dacad9b..db6e37cfe 100644
--- a/kernel/cobalt/ipipe/tick.c
+++ b/kernel/cobalt/ipipe/tick.c
@@ -184,9 +184,6 @@ int pipeline_install_tick_proxy(void)
 		    per_cpu(ipipe_percpu.hrtimer_irq, 0), NULL, NULL, 0);
 #endif /* CONFIG_XENO_OPT_STATS_IRQS */
 
-	nkclock.wallclock_offset =
-		ktime_to_ns(ktime_get_real()) - xnclock_read_monotonic(&nkclock);
-
 #ifdef CONFIG_SMP
 	ret = ipipe_request_irq(&cobalt_pipeline.domain,
 				IPIPE_HRTIMER_IPI,
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 23a45bba9..6a479568c 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -142,18 +142,13 @@ COBALT_SYSCALL(clock_gettime, current,
 int __cobalt_clock_settime(clockid_t clock_id, const struct timespec64 *ts)
 {
 	int _ret, ret = 0;
-	xnticks_t now;
-	spl_t s;
 
 	if ((unsigned long)ts->tv_nsec >= ONE_BILLION)
 		return -EINVAL;
 
 	switch (clock_id) {
 	case CLOCK_REALTIME:
-		xnlock_get_irqsave(&nklock, s);
-		now = xnclock_read_realtime(&nkclock);
-		xnclock_adjust(&nkclock, (xnsticks_t) (ts2ns(ts) - now));
-		xnlock_put_irqrestore(&nklock, s);
+		ret = pipeline_set_wallclock(ts2ns(ts));
 		break;
 	default:
 		_ret = do_ext_clock(clock_id, set_time, ret, ts);
@@ -163,7 +158,7 @@ int __cobalt_clock_settime(clockid_t clock_id, const struct timespec64 *ts)
 
 	trace_cobalt_clock_settime(clock_id, ts);
 
-	return 0;
+	return ret;
 }
 
 int __cobalt_clock_adjtime(clockid_t clock_id, struct __kernel_timex *tx)
-- 
2.26.2


