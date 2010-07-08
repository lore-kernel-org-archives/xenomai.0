From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Thu,  8 Jul 2010 12:18:19 +0200
Message-Id: <1278584301-8064-6-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 5/7] posix: Userspace hostrt reading without
	switching to kernel mode
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

From: Wolfgang Mauerer (none) <wolfgang@domain.hid>

We can do this since the data are on the shared semaphore heap.
The basis data structure is placed so that it is accessible from
both the Linux kernel and Xenomai kernel/userland. This also
requires to make the structure work with both kernel and userland
definitions for elementary data types.

We use a seqlock retry mechanism to ensure that we obtain a
consistent data set.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/nucleus/Makefile.am    |    1 +
 include/nucleus/seqlock_user.h |   57 +++++++++++++++++++++++++
 src/skins/posix/clock.c        |   92 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 138 insertions(+), 12 deletions(-)
 create mode 100644 include/nucleus/seqlock_user.h

diff --git a/include/nucleus/Makefile.am b/include/nucleus/Makefile.am
index b04d7f6..9a72b24 100644
--- a/include/nucleus/Makefile.am
+++ b/include/nucleus/Makefile.am
@@ -35,5 +35,6 @@ includesub_HEADERS = \
 	trace.h \
 	types.h \
 	vdso.h \
+	seqlock_user.h \
 	version.h \
 	xenomai.h
diff --git a/include/nucleus/seqlock_user.h b/include/nucleus/seqlock_user.h
new file mode 100644
index 0000000..598d4da
--- /dev/null
+++ b/include/nucleus/seqlock_user.h
@@ -0,0 +1,57 @@
+#ifndef __SEQLOCK_USER_H
+#define __SEQLOCK_USER_H
+
+/* Originally from the linux kernel, adapted for userland and Xenomai */
+
+#include <asm/xenomai/atomic.h>
+
+typedef struct seqcount {
+	unsigned sequence;
+} seqcount_t;
+
+#define SEQCNT_ZERO { 0 }
+#define seqcount_init(x) do { *(x) = (seqcount_t) SEQCNT_ZERO; } while (0)
+
+/* Start of read using pointer to a sequence counter only.  */
+static inline unsigned read_seqcount_begin(const seqcount_t *s)
+{
+	unsigned ret;
+
+repeat:
+	ret = s->sequence;
+	xnarch_read_memory_barrier();
+	if (unlikely(ret & 1)) {
+		cpu_relax();
+		goto repeat;
+	}
+	return ret;
+}
+
+/*
+ * Test if reader processed invalid data because sequence number has changed.
+ */
+static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
+{
+	xnarch_read_memory_barrier();
+
+	return s->sequence != start;
+}
+
+
+/*
+ * The sequence counter only protects readers from concurrent writers.
+ * Writers must use their own locking.
+ */
+static inline void write_seqcount_begin(seqcount_t *s)
+{
+	s->sequence++;
+	xnarch_write_memory_barrier();
+}
+
+static inline void write_seqcount_end(seqcount_t *s)
+{
+	xnarch_write_memory_barrier();
+	s->sequence++;
+}
+
+#endif
diff --git a/src/skins/posix/clock.c b/src/skins/posix/clock.c
index e27a2ec..14ddf1d 100644
--- a/src/skins/posix/clock.c
+++ b/src/skins/posix/clock.c
@@ -25,6 +25,9 @@
 #include <time.h>
 #include <asm/xenomai/arith.h>
 #include <asm-generic/xenomai/timeconv.h>
+#include <nucleus/seqlock_user.h>
+#include <sys/types.h>
+#include <nucleus/vdso.h>
 
 extern int __pse51_muxid;
 
@@ -56,25 +59,90 @@ int __wrap_clock_getres(clockid_t clock_id, struct timespec *tp)
 	return -1;
 }
 
-int __wrap_clock_gettime(clockid_t clock_id, struct timespec *tp)
+int __do_clock_host_realtime(struct timespec *ts, void *tzp)
 {
 	int err;
 #ifdef XNARCH_HAVE_NONPRIV_TSC
-	if (clock_id == CLOCK_MONOTONIC && __pse51_sysinfo.tickval == 1) {
-		unsigned long long ns;
-		unsigned long rem;
+	unsigned int seq;
+	cycle_t now, base, mask, cycle_delta;
+	unsigned long mult, shift, nsec, rem;
+	struct xnarch_hostrt_data *hostrt_data;
+
+	if (!xnvdso_test_feature(XNVDSO_FEAT_HOST_REALTIME))
+		return -1;
+
+	hostrt_data = &nkvdso->hostrt_data;
+
+	if (unlikely(!hostrt_data->live))
+		return -1;
+
+	/*
+	 * The following is essentially a verbatim copy of the
+	 * mechanism in the kernel.
+	 */
+retry:
+	seq = read_seqcount_begin(&hostrt_data->seqcount);
+
+	now = __xn_rdtsc();
+	base = hostrt_data->cycle_last;
+	mask = hostrt_data->mask;
+	mult = hostrt_data->mult;
+	shift = hostrt_data->shift;
+	ts->tv_sec = hostrt_data->wall_time_sec;
+	nsec = hostrt_data->wall_time_nsec;
+
+	/* If the data changed during the read, try the
+	   alternative data element */
+	if (read_seqcount_retry(&hostrt_data->seqcount, seq))
+		goto retry;
+
+	cycle_delta = (now - base) & mask;
+	nsec += (cycle_delta * mult) >> shift;
+
+	ts->tv_sec += xnarch_divrem_billion(nsec, &rem);
+	ts->tv_nsec = rem;
+
+	return 0;
+#else /* XNARCH_HAVE_NONPRIV_TSC */
+	err = -XENOMAI_SKINCALL2(__pse51_muxid,
+				 __pse51_clock_gettime,
+				 CLOCK_HOST_REALTIME, ts);
 
-		ns = xnarch_tsc_to_ns(__xn_rdtsc());
-		tp->tv_sec = xnarch_divrem_billion(ns, &rem);
-		tp->tv_nsec = rem;
+	if (!err)
 		return 0;
-	}
+
+	errno = err;
+	return -1;
 #endif /* XNARCH_HAVE_NONPRIV_TSC */
+}
 
-	err = -XENOMAI_SKINCALL2(__pse51_muxid,
-				 __pse51_clock_gettime,
-				 clock_id,
-				 tp);
+int __wrap_clock_gettime(clockid_t clock_id, struct timespec *tp)
+{
+	int err;
+
+	switch (clock_id) {
+#ifdef XNARCH_HAVE_NONPRIV_TSC
+	case CLOCK_MONOTONIC:
+		if (__pse51_sysinfo.tickval == 1) {
+			unsigned long long ns;
+			unsigned long rem;
+
+			ns = xnarch_tsc_to_ns(__xn_rdtsc());
+			tp->tv_sec = xnarch_divrem_billion(ns, &rem);
+			tp->tv_nsec = rem;
+			return 0;
+		}
+		break;
+	case CLOCK_HOST_REALTIME:
+		err = __do_clock_host_realtime(tp, NULL);
+		break;
+#endif /* XNARCH_HAVE_NONPRIV_TSC */
+	default:
+		err = -XENOMAI_SKINCALL2(__pse51_muxid,
+					 __pse51_clock_gettime,
+					 clock_id,
+					 tp);
+	}
 
 	if (!err)
 		return 0;
-- 
1.6.4


