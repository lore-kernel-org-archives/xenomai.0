Message-ID: <4C0E51F0.6080300@domain.hid>
Date: Tue, 08 Jun 2010 16:21:36 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH, RFC] Instrumentation to detect delayed timers
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

the attached patch augments the timer expiration handler with some checks
for excessive timer latencies. Depending on the configuration options, it
freezes the ipipe tracer and creates a list of delayed timers.

This code was useful for us in debugging some problems with faulty hardware.
Would such a thing be suitable for mainline?

Regards, Wolfgang

---
commit 9c2a3908ac4aff21022a577552002fc2622d3670
Author: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date:   Mon Jun 7 15:34:39 2010 +0200

    This patch provides the possibility to check upon timer expiration
    how much a timer has been delayed. When the delay surpasses a configurable
    threshold, the ipipe tracer is frozen. Additionally, the patch allows
    for the creation of a list of timers that have suffered from excessive
    delays.
    
    The mechanism can be disabled at both, compile- and runtime. There is no
    overhead in the former case.
    
    Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

diff --git a/ksrc/nucleus/Kconfig b/ksrc/nucleus/Kconfig
index 211a4ad..ffed3f8 100644
--- a/ksrc/nucleus/Kconfig
+++ b/ksrc/nucleus/Kconfig
@@ -293,6 +293,24 @@ config XENO_OPT_DEBUG_TIMERS
 	This option activates debugging output for critical
 	timer-related operations performed by the Xenomai core.
 
+config XENO_OPT_DEBUG_TIMER_LATENCY
+	bool "Log excessive timer latencies"
+	depends on XENO_OPT_DEBUG && (XENO_OPT_STATS || IPIPE_TRACE)
+	help
+
+	This option activates recording of excessive timer latencies.
+	In contrast to the userland latency checker which is statistical
+	in nature, this test checks every expiring timer and is thus
+	more precise. However, it adds some runtime overhead when
+	activated.
+
+	When the ipipe tracer is enabled, the trace is frozen
+	when a latency maximum above the threshold set in
+	the debugfs file timer_lattest/lat_threshold_us is detected.
+	When Xenomai statistics collection is enabled, a list of
+	excessive latencies together with the names of the timers
+	is kept in the debugfs file timer_lattest/exc_timer_list.
+
 config XENO_OPT_DEBUG_SYNCH_RELAX
 	bool "Detect mutexes held in relaxed sections"
 	depends on XENO_OPT_PERVASIVE && XENO_OPT_DEBUG
diff --git a/ksrc/nucleus/timer.c b/ksrc/nucleus/timer.c
index d813c4f..01dad44 100644
--- a/ksrc/nucleus/timer.c
+++ b/ksrc/nucleus/timer.c
@@ -36,11 +36,37 @@
  *
  *@{*/
 
+#include <linux/debugfs.h>
 #include <nucleus/pod.h>
 #include <nucleus/thread.h>
 #include <nucleus/timer.h>
+#include <nucleus/trace.h>
 #include <asm/xenomai/bits/timer.h>
 
+#ifdef CONFIG_XENO_OPT_DEBUG_TIMER_LATENCY
+#define NANO 1000000000ll
+#define MU   1000000ll
+#define NANO_PER_MU (NANO/MU)
+
+static u32 lat_thresh = 0; /* in \mu s, set to zero to disable */
+
+#ifdef CONFIG_XENO_OPT_STATS
+#include <linux/seq_file.h>
+
+#define NUM_REC_LATENCIES	500
+static int num_lat_exc_timers = -1;
+static bool lat_rec_overflow = false; /* Set when more than NUM_REC_LATENCIES
+				       * excessive latencies have been
+				       * observed */
+struct lat_rec {
+	char name[XNOBJECT_NAME_LEN];
+	xnsticks_t delta;
+};
+
+static struct lat_rec delayed_timers[NUM_REC_LATENCIES];
+#endif // CONFIG_XENO_OPT_STATS
+#endif // XENO_OPT_DEBUG_TIMER_LATENCY
+
 static inline void xntimer_enqueue_aperiodic(xntimer_t *timer)
 {
 	xntimerq_t *q = &timer->sched->timerqueue;
@@ -368,6 +394,32 @@ void xntimer_tick_aperiodic(void)
 		if (delta > (xnsticks_t)nklatency)
 			break;
 
+#ifdef CONFIG_XENO_OPT_DEBUG_TIMER_LATENCY
+		/*
+		 * Check for severly delayed timers, but omit the host tick
+		 * timer as it can be delayed intentionally, thus causing
+		 * spurious excessive latencies (see
+		 * xntimer_next_local_shot()).
+		 */
+		if (lat_thresh && (timer != &sched->htimer)) {
+			delta = xnarch_tsc_to_ns(-delta);
+			if (delta > ((xnsticks_t)lat_thresh)*NANO_PER_MU) {
+				xnarch_trace_user_freeze(delta, 1);
+#ifdef CONFIG_XENO_OPT_STATS
+				if (num_lat_exc_timers < NUM_REC_LATENCIES - 1) {
+					num_lat_exc_timers++;
+				} else {
+					lat_rec_overflow = true;
+					num_lat_exc_timers = 0;
+				}
+				xnobject_copy_name(delayed_timers[num_lat_exc_timers].name,
+						   timer->name);
+				delayed_timers[num_lat_exc_timers].delta = delta;
+#endif // XENO_OPT_STATS
+			}
+		}
+#endif // XENO_OPT_DEBUG_TIMER_LATENCY
+
 		trace_mark(xn_nucleus, timer_expire, "timer %p", timer);
 
 		xntimer_dequeue_aperiodic(timer);
@@ -1147,10 +1199,70 @@ static int timer_read_proc(char *page,
 	return len;
 }
 
+#ifdef CONFIG_XENO_OPT_STATS
+static int lat_exc_seq_show(struct seq_file *f, void *v)
+{
+	int count, max;
+
+	if (num_lat_exc_timers < 0) {
+		seq_printf(f, "(No excessive timer latencies detected)\n");
+		return 0;
+	}
+
+	if (lat_rec_overflow)
+		max = NUM_REC_LATENCIES;
+	else
+		max = num_lat_exc_timers;
+
+	for (count = 0; count < max; count++) {
+		seq_printf(f, "Timer '%s', delay %lld ns\n",
+			   delayed_timers[count].name,
+			   delayed_timers[count].delta);
+	}
+
+	if (lat_rec_overflow) {
+		seq_printf(f, "WARNING: Latency tracking array overflow detected.\n");
+		seq_printf(f, "         Not all excessive latencies are shown.\n");
+
+	}
+	return 0;
+}
+
+static int lat_exc_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, lat_exc_seq_show, NULL);
+}
+
+static struct file_operations lat_exc_fops = {
+        .owner          = THIS_MODULE,
+        .open           = lat_exc_seq_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+};
+#endif // CONFIG_XENO_OPT_STATS
+
 void xntimer_init_proc(void)
 {
 	rthal_add_proc_leaf("timer", &timer_read_proc, NULL, NULL,
 			    rthal_proc_root);
+
+#ifdef CONFIG_XENO_OPT_DEBUG_TIMER_LATENCY
+	struct dentry *debugfs_dir;
+
+	debugfs_dir = debugfs_create_dir("timer_lattest", NULL);
+
+	if (debugfs_dir) {
+		if (!debugfs_create_u32("lat_threshold_us", 0666,
+					debugfs_dir, &lat_thresh))
+			panic("Could not create lat_threshold_us");
+
+#ifdef CONFIG_XENO_OPT_STATS
+		if (!debugfs_create_file("exc_timer_list", 0600,
+					 debugfs_dir, NULL, &lat_exc_fops))
+			panic("Could not create exc_timer_list");
+#endif // XENO_OPT_STATS
+	}
+#endif // XENO_OPT_DEBUG_TIMER_LATENCY
 }
 
 void xntimer_cleanup_proc(void)

