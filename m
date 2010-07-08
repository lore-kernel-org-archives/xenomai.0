From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Thu,  8 Jul 2010 12:18:18 +0200
Message-Id: <1278584301-8064-5-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 4/7] posix: Support reading the host realtime
	clock in realtime context
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: jan.kiszka@domain.hid, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

Wall time management is typically assisted by the NTP
protocol in the Linux context, but this information is
not propagated to Xenomai. This patch adds support
for a CLOCK_HOST_REALTIME clock id that is coupled to the
host operating system's realtime clock. The required
information from the Kernel into Xenomai. The data exchange
is designed to allow for lockless reading from userland.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/posix/time.h     |    7 ++++
 ksrc/skins/posix/clock.c |   86 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletions(-)

diff --git a/include/posix/time.h b/include/posix/time.h
index 4f2d760..92ec1d5 100644
--- a/include/posix/time.h
+++ b/include/posix/time.h
@@ -50,6 +50,13 @@
 #define CLOCK_MONOTONIC 1
 #endif /* CLOCK_MONOTONIC */
 
+/*
+ * This number is supposed to not collide with any of the POSIX and
+ * Linux kernel definitions so that no ambiguities arise when porting
+ * applications in both directions.
+ */
+#define CLOCK_HOST_REALTIME 42
+
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
 struct sigevent;
diff --git a/ksrc/skins/posix/clock.c b/ksrc/skins/posix/clock.c
index 553e123..62493f1 100644
--- a/ksrc/skins/posix/clock.c
+++ b/ksrc/skins/posix/clock.c
@@ -50,6 +50,9 @@
  *@{*/
 
 #include <posix/thread.h>
+#include <nucleus/vdso.h>
+#include <asm-generic/xenomai/arith.h>
+#include <asm-generic/xenomai/system.h>
 
 /**
  * Get the resolution of the specified clock.
@@ -88,6 +91,76 @@ int clock_getres(clockid_t clock_id, struct timespec *res)
 }
 
 /**
+ * Read the host-synchronised realtime clock.
+ *
+ * Obtain the current time with NTP corrections from the Linux domain
+ *
+ * @param tp pointer to a struct timespec
+ *
+ * @retval 0 on success;
+ * @retval -1 if no suitable NTP-corrected clocksource is availabel
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/gettimeofday.html">
+ * Specification.</a>
+ *
+ */
+static int do_clock_host_realtime(struct timespec *tp)
+{
+#ifdef CONFIG_XENO_OPT_HOSTRT
+	cycle_t now, base, mask, cycle_delta;
+	unsigned long mult, shift, nsec, rem;
+	struct xnarch_hostrt_data *hostrt_data;
+	unsigned int seq;
+
+	hostrt_data = get_hostrt_data();
+	BUG_ON(!hostrt_data);
+
+	if (unlikely(!hostrt_data->live))
+		return -1;
+
+	/*
+	 * Note: Disabling HW interrupts around writes to hostrt_data ensures
+	 * that a reader (on the Xenomai side) cannot interrupt a writer (on
+	 * the Linux kernel side) on the same CPU.  The sequence counter is
+	 * required when a reader is interleaved by a writer on a different
+	 * CPU. This follows the approach from userland, where tasking the
+	 * spinlock is not possible.
+	 */
+retry:
+	seq = read_seqcount_begin(&hostrt_data->seqcount);
+
+	now = xnarch_get_cpu_tsc();
+	base = hostrt_data->cycle_last;
+	mask = hostrt_data->mask;
+	mult = hostrt_data->mult;
+	shift = hostrt_data->shift;
+	tp->tv_sec = hostrt_data->wall_time_sec;
+	nsec = hostrt_data->wall_time_nsec;
+
+	if (read_seqcount_retry(&hostrt_data->seqcount, seq))
+		goto retry;
+
+	/*
+	 * At this point, we have a consistent copy of the fundamental
+	 * data structure - calculate the interval between the current
+	 * and base time stamp cycles, and convert the difference
+	 * to nanoseconds.
+	 */
+	cycle_delta = (now - base) & mask;
+	nsec += (cycle_delta * mult) >> shift;
+
+	/* Convert to the desired sec, usec representation */
+	tp->tv_sec += xnarch_divrem_billion(nsec, &rem);
+	tp->tv_nsec = rem;
+
+	return 0;
+#else /* CONFIG_XENO_OPT_HOSTRT */
+	return -EINVAL;
+#endif
+}
+
+/**
  * Read the specified clock. 
  *
  * This service returns, at the address @a tp the current value of the clock @a
@@ -97,8 +170,12 @@ int clock_getres(clockid_t clock_id, struct timespec *res)
  * - CLOCK_MONOTONIC, the clock value is given by an architecture-dependent high
  *   resolution counter, with a precision independent from the system clock tick
  *   duration.
+ * - CLOCK_HOST_REALTIME, the clock value as seen by the host, typically
+ *   Linux. Resolution and precision depend on the host, but it is guaranteed
+ *   that both, host and Xenomai, see the same information.
  *
- * @param clock_id clock identifier, either CLOCK_REALTIME or CLOCK_MONOTONIC;
+ * @param clock_id clock identifier, either CLOCK_REALTIME, CLOCK_MONOTONIC,
+ *        or CLOCK_HOST_REALTIME;
  *
  * @param tp the address where the value of the specified clock will be stored.
  *
@@ -126,6 +203,13 @@ int clock_gettime(clockid_t clock_id, struct timespec *tp)
 		    xnarch_uldivrem(cpu_time, ONE_BILLION, &tp->tv_nsec);
 		break;
 
+	case CLOCK_HOST_REALTIME:
+		if (do_clock_host_realtime(tp) != 0) {
+			thread_set_errno(EINVAL);
+			return -1;
+		}
+		break;
+
 	default:
 		thread_set_errno(EINVAL);
 		return -1;
-- 
1.6.4


