From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 05/13] cobalt/clock: pipeline: move TSC-related code to the
 I-pipe section
Date: Sun, 31 Jan 2021 15:45:32 +0100
Message-Id: <20210131144540.243363-5-rpm@xenomai.org>
In-Reply-To: <20210131144540.243363-1-rpm@xenomai.org>
References: <20210131144540.243363-1-rpm@xenomai.org>
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

Cobalt over Dovetail represents time values as counts of nanoseconds,
dismissing the legacy (hardware) TSC representation entirely. For this
reason, we can move any code which implements TSC/nanosecs conversion
to the I-pipe specific section.

This includes the handler applying CPU frequency updates
(xnclock_update_freq()) which has no purpose over Dovetail, since
these events are transparently dealt with for the proxy device by the
generic clockevent framework.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/clock.h                |  4 +-
 include/cobalt/kernel/ipipe/pipeline/clock.h |  4 +
 kernel/cobalt/clock.c                        | 80 ++-----------------
 kernel/cobalt/ipipe/clock.c                  | 81 ++++++++++++++++++++
 kernel/cobalt/ipipe/init.c                   |  2 +-
 kernel/cobalt/ipipe/kevents.c                |  3 +-
 6 files changed, 96 insertions(+), 78 deletions(-)

diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
index 2d17c0422..59835951c 100644
--- a/include/cobalt/kernel/clock.h
+++ b/include/cobalt/kernel/clock.h
@@ -348,9 +348,7 @@ static inline void xnclock_init_proc(void) { }
 static inline void xnclock_cleanup_proc(void) { }
 #endif
 
-void xnclock_update_freq(unsigned long long freq);
-
-int xnclock_init(unsigned long long freq);
+int xnclock_init(void);
 
 void xnclock_cleanup(void);
 
diff --git a/include/cobalt/kernel/ipipe/pipeline/clock.h b/include/cobalt/kernel/ipipe/pipeline/clock.h
index eeeae6602..fa7ac2a5e 100644
--- a/include/cobalt/kernel/ipipe/pipeline/clock.h
+++ b/include/cobalt/kernel/ipipe/pipeline/clock.h
@@ -33,4 +33,8 @@ static inline const char *pipeline_clock_name(void)
 
 int pipeline_get_host_time(struct timespec *tp);
 
+void pipeline_update_clock_freq(unsigned long long freq);
+
+void pipeline_init_clock(void);
+
 #endif /* !_COBALT_KERNEL_IPIPE_CLOCK_H */
diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index cae9dd7a1..7d1e00ea1 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -34,22 +34,10 @@
  */
 unsigned long nktimerlat;
 
-static unsigned long long clockfreq;
-
-#ifdef XNARCH_HAVE_LLMULSHFT
-
-static unsigned int tsc_scale, tsc_shift;
-
 #ifdef XNARCH_HAVE_NODIV_LLIMD
 
-static struct xnarch_u32frac tsc_frac;
 static struct xnarch_u32frac bln_frac;
 
-long long xnclock_core_ns_to_ticks(long long ns)
-{
-	return xnarch_nodiv_llimd(ns, tsc_frac.frac, tsc_frac.integ);
-}
-
 unsigned long long xnclock_divrem_billion(unsigned long long value,
 					  unsigned long *rem)
 {
@@ -66,57 +54,17 @@ unsigned long long xnclock_divrem_billion(unsigned long long value,
 	return q;
 }
 
-#else /* !XNARCH_HAVE_NODIV_LLIMD */
-
-long long xnclock_core_ns_to_ticks(long long ns)
-{
-	return xnarch_llimd(ns, 1 << tsc_shift, tsc_scale);
-}
-
-#endif /* !XNARCH_HAVE_NODIV_LLIMD */
-
-xnsticks_t xnclock_core_ticks_to_ns(xnsticks_t ticks)
-{
-	return xnarch_llmulshft(ticks, tsc_scale, tsc_shift);
-}
-
-xnsticks_t xnclock_core_ticks_to_ns_rounded(xnsticks_t ticks)
-{
-	unsigned int shift = tsc_shift - 1;
-	return (xnarch_llmulshft(ticks, tsc_scale, shift) + 1) / 2;
-}
-
-#else  /* !XNARCH_HAVE_LLMULSHFT */
-
-xnsticks_t xnclock_core_ticks_to_ns(xnsticks_t ticks)
-{
-	return xnarch_llimd(ticks, 1000000000, clockfreq);
-}
+#else
 
-xnsticks_t xnclock_core_ticks_to_ns_rounded(xnsticks_t ticks)
-{
-	return (xnarch_llimd(ticks, 1000000000, clockfreq/2) + 1) / 2;
-}
-
-xnsticks_t xnclock_core_ns_to_ticks(xnsticks_t ns)
-{
-	return xnarch_llimd(ns, clockfreq, 1000000000);
-}
-
-#endif /* !XNARCH_HAVE_LLMULSHFT */
-
-#ifndef XNARCH_HAVE_NODIV_LLIMD
 unsigned long long xnclock_divrem_billion(unsigned long long value,
 					  unsigned long *rem)
 {
 	return xnarch_ulldiv(value, 1000000000, rem);
 
 }
+
 #endif /* !XNARCH_HAVE_NODIV_LLIMD */
 
-EXPORT_SYMBOL_GPL(xnclock_core_ticks_to_ns);
-EXPORT_SYMBOL_GPL(xnclock_core_ticks_to_ns_rounded);
-EXPORT_SYMBOL_GPL(xnclock_core_ns_to_ticks);
 EXPORT_SYMBOL_GPL(xnclock_divrem_billion);
 
 DEFINE_PRIVATE_XNLOCK(ratelimit_lock);
@@ -823,23 +771,6 @@ void xnclock_tick(struct xnclock *clock)
 }
 EXPORT_SYMBOL_GPL(xnclock_tick);
 
-void xnclock_update_freq(unsigned long long freq)
-{
-	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
-	clockfreq = freq;
-#ifdef XNARCH_HAVE_LLMULSHFT
-	xnarch_init_llmulshft(1000000000, freq, &tsc_scale, &tsc_shift);
-#ifdef XNARCH_HAVE_NODIV_LLIMD
-	xnarch_init_u32frac(&tsc_frac, 1 << tsc_shift, tsc_scale);
-	xnarch_init_u32frac(&bln_frac, 1, 1000000000);
-#endif
-#endif
-	cobalt_pipeline.clock_freq = freq;
-	xnlock_put_irqrestore(&nklock, s);
-}
-
 static int set_core_clock_gravity(struct xnclock *clock,
 				  const struct xnclock_gravity *p)
 {
@@ -880,9 +811,12 @@ void xnclock_cleanup(void)
 	xnclock_deregister(&nkclock);
 }
 
-int __init xnclock_init(unsigned long long freq)
+int __init xnclock_init()
 {
-	xnclock_update_freq(freq);
+#ifdef XNARCH_HAVE_NODIV_LLIMD
+	xnarch_init_u32frac(&bln_frac, 1, 1000000000);
+#endif
+	pipeline_init_clock();
 	nktimerlat = xnarch_timer_calibrate();
 	xnclock_reset_gravity(&nkclock);
 	xnclock_register(&nkclock, &xnsched_realtime_cpus);
diff --git a/kernel/cobalt/ipipe/clock.c b/kernel/cobalt/ipipe/clock.c
index d0135dc7a..606c6bf8c 100644
--- a/kernel/cobalt/ipipe/clock.c
+++ b/kernel/cobalt/ipipe/clock.c
@@ -6,6 +6,66 @@
 
 #include <cobalt/kernel/clock.h>
 #include <cobalt/kernel/vdso.h>
+#include <cobalt/kernel/arith.h>
+#include <pipeline/machine.h>
+
+static unsigned long long clockfreq;
+
+#ifdef XNARCH_HAVE_LLMULSHFT
+
+static unsigned int tsc_scale, tsc_shift;
+
+#ifdef XNARCH_HAVE_NODIV_LLIMD
+
+static struct xnarch_u32frac tsc_frac;
+
+long long xnclock_core_ns_to_ticks(long long ns)
+{
+	return xnarch_nodiv_llimd(ns, tsc_frac.frac, tsc_frac.integ);
+}
+
+#else /* !XNARCH_HAVE_NODIV_LLIMD */
+
+long long xnclock_core_ns_to_ticks(long long ns)
+{
+	return xnarch_llimd(ns, 1 << tsc_shift, tsc_scale);
+}
+
+#endif /* !XNARCH_HAVE_NODIV_LLIMD */
+
+xnsticks_t xnclock_core_ticks_to_ns(xnsticks_t ticks)
+{
+	return xnarch_llmulshft(ticks, tsc_scale, tsc_shift);
+}
+
+xnsticks_t xnclock_core_ticks_to_ns_rounded(xnsticks_t ticks)
+{
+	unsigned int shift = tsc_shift - 1;
+	return (xnarch_llmulshft(ticks, tsc_scale, shift) + 1) / 2;
+}
+
+#else  /* !XNARCH_HAVE_LLMULSHFT */
+
+xnsticks_t xnclock_core_ticks_to_ns(xnsticks_t ticks)
+{
+	return xnarch_llimd(ticks, 1000000000, clockfreq);
+}
+
+xnsticks_t xnclock_core_ticks_to_ns_rounded(xnsticks_t ticks)
+{
+	return (xnarch_llimd(ticks, 1000000000, clockfreq/2) + 1) / 2;
+}
+
+xnsticks_t xnclock_core_ns_to_ticks(xnsticks_t ns)
+{
+	return xnarch_llimd(ns, clockfreq, 1000000000);
+}
+
+#endif /* !XNARCH_HAVE_LLMULSHFT */
+
+EXPORT_SYMBOL_GPL(xnclock_core_ticks_to_ns);
+EXPORT_SYMBOL_GPL(xnclock_core_ticks_to_ns_rounded);
+EXPORT_SYMBOL_GPL(xnclock_core_ns_to_ticks);
 
 int pipeline_get_host_time(struct timespec *tp)
 {
@@ -60,3 +120,24 @@ int pipeline_get_host_time(struct timespec *tp)
 	return -EINVAL;
 #endif
 }
+
+void pipeline_update_clock_freq(unsigned long long freq)
+{
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+	clockfreq = freq;
+#ifdef XNARCH_HAVE_LLMULSHFT
+	xnarch_init_llmulshft(1000000000, freq, &tsc_scale, &tsc_shift);
+#ifdef XNARCH_HAVE_NODIV_LLIMD
+	xnarch_init_u32frac(&tsc_frac, 1 << tsc_shift, tsc_scale);
+#endif
+#endif
+	cobalt_pipeline.clock_freq = freq;
+	xnlock_put_irqrestore(&nklock, s);
+}
+
+void pipeline_init_clock(void)
+{
+	pipeline_update_clock_freq(cobalt_pipeline.clock_freq);
+}
diff --git a/kernel/cobalt/ipipe/init.c b/kernel/cobalt/ipipe/init.c
index d61d150d7..1dde7bc4b 100644
--- a/kernel/cobalt/ipipe/init.c
+++ b/kernel/cobalt/ipipe/init.c
@@ -61,7 +61,7 @@ int __init pipeline_init(void)
 			  (ipipe_irq_handler_t)__xnsched_run_handler,
 			  NULL, NULL);
 
-	ret = xnclock_init(cobalt_pipeline.clock_freq);
+	ret = xnclock_init();
 	if (ret)
 		goto fail_clock;
 
diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
index e1e1e3a95..f0314cd44 100644
--- a/kernel/cobalt/ipipe/kevents.c
+++ b/kernel/cobalt/ipipe/kevents.c
@@ -16,6 +16,7 @@
 #include <pipeline/kevents.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/thread.h>
+#include <cobalt/kernel/clock.h>
 #include <cobalt/kernel/vdso.h>
 #include <rtdm/driver.h>
 #include <trace/events/cobalt-core.h>
@@ -675,7 +676,7 @@ static inline int handle_clockfreq_event(unsigned int *p)
 {
 	unsigned int newfreq = *p;
 
-	xnclock_update_freq(newfreq);
+	pipeline_update_clock_freq(newfreq);
 
 	return KEVENT_PROPAGATE;
 }
-- 
2.26.2


