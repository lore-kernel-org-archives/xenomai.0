From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 03/13] cobalt/clock: pipeline: abstract access to host
 (real)time
Date: Sun, 31 Jan 2021 15:45:30 +0100
Message-Id: <20210131144540.243363-3-rpm@xenomai.org>
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

Dovetail enables applications to get timestamps from the
CLOCK_MONOTONIC and CLOCK_REALTIME clocks via the regular vDSO by
calling clock_gettime(), including from the out-of-band stage
(i.e. primary mode).

Legacy support involving IPIPE_HOSTRT can move to the I-pipe specific
section.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/ipipe/pipeline/clock.h |  4 ++
 include/cobalt/uapi/kernel/vdso.h            |  5 ++
 kernel/cobalt/ipipe/Makefile                 |  2 +-
 kernel/cobalt/ipipe/clock.c                  | 62 ++++++++++++++++++++
 kernel/cobalt/posix/clock.c                  | 57 +-----------------
 5 files changed, 73 insertions(+), 57 deletions(-)
 create mode 100644 kernel/cobalt/ipipe/clock.c

diff --git a/include/cobalt/kernel/ipipe/pipeline/clock.h b/include/cobalt/kernel/ipipe/pipeline/clock.h
index c607d9585..eeeae6602 100644
--- a/include/cobalt/kernel/ipipe/pipeline/clock.h
+++ b/include/cobalt/kernel/ipipe/pipeline/clock.h
@@ -7,6 +7,8 @@
 
 #include <linux/ipipe_tickdev.h>
 
+struct timespec;
+
 static inline u64 pipeline_read_cycle_counter(void)
 {
 	u64 t;
@@ -29,4 +31,6 @@ static inline const char *pipeline_clock_name(void)
 	return ipipe_clock_name();
 }
 
+int pipeline_get_host_time(struct timespec *tp);
+
 #endif /* !_COBALT_KERNEL_IPIPE_CLOCK_H */
diff --git a/include/cobalt/uapi/kernel/vdso.h b/include/cobalt/uapi/kernel/vdso.h
index 396594bb0..5b9b1b66b 100644
--- a/include/cobalt/uapi/kernel/vdso.h
+++ b/include/cobalt/uapi/kernel/vdso.h
@@ -20,6 +20,11 @@
 
 #include <cobalt/uapi/kernel/urw.h>
 
+/*
+ * I-pipe only. Dovetail enables the common vDSO for getting
+ * CLOCK_REALTIME timestamps from the out-of-band stage
+ * (XNVDSO_FEAT_HOST_REALTIME is cleared in this case).
+ */
 struct xnvdso_hostrt_data {
 	__u64 wall_sec;
 	__u64 wtom_sec;
diff --git a/kernel/cobalt/ipipe/Makefile b/kernel/cobalt/ipipe/Makefile
index eae6a4a7c..f2b877d45 100644
--- a/kernel/cobalt/ipipe/Makefile
+++ b/kernel/cobalt/ipipe/Makefile
@@ -2,4 +2,4 @@ ccflags-y += -I$(srctree)/kernel
 
 obj-y +=	pipeline.o
 
-pipeline-y :=	init.o intr.o kevents.o tick.o syscall.o sched.o
+pipeline-y :=	init.o intr.o kevents.o tick.o syscall.o sched.o clock.o
diff --git a/kernel/cobalt/ipipe/clock.c b/kernel/cobalt/ipipe/clock.c
new file mode 100644
index 000000000..d0135dc7a
--- /dev/null
+++ b/kernel/cobalt/ipipe/clock.c
@@ -0,0 +1,62 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Written by Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
+ */
+
+#include <cobalt/kernel/clock.h>
+#include <cobalt/kernel/vdso.h>
+
+int pipeline_get_host_time(struct timespec *tp)
+{
+#ifdef CONFIG_IPIPE_HAVE_HOSTRT
+	struct xnvdso_hostrt_data *hostrt_data;
+	u64 now, base, mask, cycle_delta;
+	__u32 mult, shift;
+	unsigned long rem;
+	urwstate_t tmp;
+	__u64 nsec;
+
+	hostrt_data = get_hostrt_data();
+	BUG_ON(!hostrt_data);
+
+	if (unlikely(!hostrt_data->live))
+		return -1;
+
+	/*
+	 * Note: Disabling HW interrupts around writes to hostrt_data
+	 * ensures that a reader (on the Xenomai side) cannot
+	 * interrupt a writer (on the Linux kernel side) on the same
+	 * CPU.  The urw block is required when a reader is
+	 * interleaved by a writer on a different CPU. This follows
+	 * the approach from userland, where taking the spinlock is
+	 * not possible.
+	 */
+	unsynced_read_block(&tmp, &hostrt_data->lock) {
+		now = xnclock_read_raw(&nkclock);
+		base = hostrt_data->cycle_last;
+		mask = hostrt_data->mask;
+		mult = hostrt_data->mult;
+		shift = hostrt_data->shift;
+		tp->tv_sec = hostrt_data->wall_sec;
+		nsec = hostrt_data->wall_nsec;
+	}
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
+	tp->tv_sec += xnclock_divrem_billion(nsec, &rem);
+	tp->tv_nsec = rem;
+
+	return 0;
+#else
+	return -EINVAL;
+#endif
+}
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 40271f3ed..e957dd956 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -18,7 +18,6 @@
 
 #include <linux/clocksource.h>
 #include <linux/bitmap.h>
-#include <cobalt/kernel/vdso.h>
 #include <cobalt/kernel/clock.h>
 #include "internal.h"
 #include "thread.h"
@@ -29,60 +28,6 @@ static struct xnclock *external_clocks[COBALT_MAX_EXTCLOCKS];
 
 DECLARE_BITMAP(cobalt_clock_extids, COBALT_MAX_EXTCLOCKS);
 
-static int do_clock_host_realtime(struct timespec *tp)
-{
-#ifdef CONFIG_IPIPE_HAVE_HOSTRT
-	struct xnvdso_hostrt_data *hostrt_data;
-	u64 now, base, mask, cycle_delta;
-	__u32 mult, shift;
-	unsigned long rem;
-	urwstate_t tmp;
-	__u64 nsec;
-
-	hostrt_data = get_hostrt_data();
-	BUG_ON(!hostrt_data);
-
-	if (unlikely(!hostrt_data->live))
-		return -1;
-
-	/*
-	 * Note: Disabling HW interrupts around writes to hostrt_data
-	 * ensures that a reader (on the Xenomai side) cannot
-	 * interrupt a writer (on the Linux kernel side) on the same
-	 * CPU.  The urw block is required when a reader is
-	 * interleaved by a writer on a different CPU. This follows
-	 * the approach from userland, where taking the spinlock is
-	 * not possible.
-	 */
-	unsynced_read_block(&tmp, &hostrt_data->lock) {
-		now = xnclock_read_raw(&nkclock);
-		base = hostrt_data->cycle_last;
-		mask = hostrt_data->mask;
-		mult = hostrt_data->mult;
-		shift = hostrt_data->shift;
-		tp->tv_sec = hostrt_data->wall_sec;
-		nsec = hostrt_data->wall_nsec;
-	}
-
-	/*
-	 * At this point, we have a consistent copy of the fundamental
-	 * data structure - calculate the interval between the current
-	 * and base time stamp cycles, and convert the difference
-	 * to nanoseconds.
-	 */
-	cycle_delta = (now - base) & mask;
-	nsec += (cycle_delta * mult) >> shift;
-
-	/* Convert to the desired sec, usec representation */
-	tp->tv_sec += xnclock_divrem_billion(nsec, &rem);
-	tp->tv_nsec = rem;
-
-	return 0;
-#else
-	return -EINVAL;
-#endif
-}
-
 #define do_ext_clock(__clock_id, __handler, __ret, __args...)	\
 ({								\
 	struct xnclock *__clock;				\
@@ -161,7 +106,7 @@ int __cobalt_clock_gettime(clockid_t clock_id, struct timespec *ts)
 		ns2ts(ts, xnclock_read_monotonic(&nkclock));
 		break;
 	case CLOCK_HOST_REALTIME:
-		if (do_clock_host_realtime(ts) != 0)
+		if (pipeline_get_host_time(ts) != 0)
 			return -EINVAL;
 		break;
 	default:
-- 
2.26.2


