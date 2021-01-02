From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail 09/13] cobalt/clock: pipeline: abstract clock,
 timer access services
Date: Sat,  2 Jan 2021 10:33:49 +0100
Message-Id: <20210102093353.3195090-10-rpm@xenomai.org>
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

Dovetail exports integrated services for proxying the host tick, which
requires no specific interface for managing the hardware timer beyond
the common clockevents interface.

Likewise, the monotonic and realtime clocks can be read directly from
the out-of-band stage via the regular kernel calls available from NMI
context (ktime_get_mono_fast_ns(), ktime_get_real_fast()).

Move the related support to the I-pipe section, we won't need it for
Dovetail.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/clock.h                |  6 ++--
 include/cobalt/kernel/ipipe/pipeline/clock.h | 32 ++++++++++++++++++++
 kernel/cobalt/clock.c                        |  5 ++-
 3 files changed, 37 insertions(+), 6 deletions(-)
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/clock.h

diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
index d4a9d2686..2d17c0422 100644
--- a/include/cobalt/kernel/clock.h
+++ b/include/cobalt/kernel/clock.h
@@ -20,6 +20,7 @@
 #define _COBALT_KERNEL_CLOCK_H
 
 #include <pipeline/pipeline.h>
+#include <pipeline/clock.h>
 #include <cobalt/kernel/list.h>
 #include <cobalt/kernel/vfile.h>
 #include <cobalt/uapi/kernel/types.h>
@@ -31,6 +32,7 @@
 
 struct xnsched;
 struct xntimerdata;
+struct timex;
 
 struct xnclock_gravity {
 	unsigned long irq;
@@ -128,9 +130,7 @@ xnticks_t xnclock_core_read_monotonic(void);
 
 static inline xnticks_t xnclock_core_read_raw(void)
 {
-	unsigned long long t;
-	ipipe_read_tsc(t);
-	return t;
+	return pipeline_read_cycle_counter();
 }
 
 /* We use the Linux defaults */
diff --git a/include/cobalt/kernel/ipipe/pipeline/clock.h b/include/cobalt/kernel/ipipe/pipeline/clock.h
new file mode 100644
index 000000000..c607d9585
--- /dev/null
+++ b/include/cobalt/kernel/ipipe/pipeline/clock.h
@@ -0,0 +1,32 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _COBALT_KERNEL_IPIPE_CLOCK_H
+#define _COBALT_KERNEL_IPIPE_CLOCK_H
+
+#include <linux/ipipe_tickdev.h>
+
+static inline u64 pipeline_read_cycle_counter(void)
+{
+	u64 t;
+	ipipe_read_tsc(t);
+	return t;
+}
+
+static inline void pipeline_set_timer_shot(unsigned long cycles)
+{
+	ipipe_timer_set(cycles);
+}
+
+static inline const char *pipeline_timer_name(void)
+{
+	return ipipe_timer_name();
+}
+
+static inline const char *pipeline_clock_name(void)
+{
+	return ipipe_clock_name();
+}
+
+#endif /* !_COBALT_KERNEL_IPIPE_CLOCK_H */
diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index d73ade3f9..cae9dd7a1 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -18,7 +18,6 @@
  */
 #include <linux/percpu.h>
 #include <linux/errno.h>
-#include <linux/ipipe_tickdev.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/timer.h>
 #include <cobalt/kernel/clock.h>
@@ -222,7 +221,7 @@ void xnclock_core_local_shot(struct xnsched *sched)
 
 	xntrace_tick((unsigned)delay);
 
-	ipipe_timer_set(delay);
+	pipeline_set_timer_shot(delay);
 }
 
 #ifdef CONFIG_SMP
@@ -507,7 +506,7 @@ void print_core_clock_status(struct xnclock *clock,
 #endif /* CONFIG_XENO_OPT_WATCHDOG */
 
 	xnvfile_printf(it, "%8s: timer=%s, clock=%s\n",
-		       "devices", ipipe_timer_name(), ipipe_clock_name());
+		       "devices", pipeline_timer_name(), pipeline_clock_name());
 	xnvfile_printf(it, "%8s: %s\n", "watchdog", wd_status);
 	xnvfile_printf(it, "%8s: %Lu\n", "setup",
 		       xnclock_ticks_to_ns(&nkclock, nktimerlat));
-- 
2.26.2


