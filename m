Message-ID: <4CBE77DD.8050601@domain.hid>
Date: Wed, 20 Oct 2010 07:02:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] hostrt broken on ARM.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>


Hi,

the hostrt stuff did not compile on ARM, at this chance, I had a look 
and found a few things which I did not like:
- the kernel-space and user-space did not use seqcount implementations 
from the same header, and what is more, seqcount is not available on 2.4
kernels. Since we provide an implementation anyway, I changed the code 
so that only this implementation is used both in kernel-space and 
user-space. Prefixing everything with xn to avoid namespace clashes.
- the xnarch_hostrt_data also had two different definitions, one for 
user-space, one for kernel-space, since this definition is supposed to 
come from newer I-pipe in kernel-space, the code did not compile with 
older I-pipe patches. I separated xnarch_hostrt_data, the structure 
passed by the I-pipe to do_hostrt_event, from xnvdso_hostrt_data, the 
structure, part of the vdso used for exchanges between user-space and 
kernel-space. We can now get xnvdso_hostrt_data defined all the time. We
can probably even move xnvdso_hostrt_data definition to vdso.h
- avoided cycle_t and u32 in order to avoid user-space namespace 
pollution and need for many typedefs with 2.4 kernels. Using unsigned 
long long directly instead of cycle_t revealed a bug in clocktest.c.

Here is the patch.

diff --git a/include/nucleus/Makefile.am b/include/nucleus/Makefile.am
index 9a72b24..5fc1c21 100644
diff --git a/include/nucleus/Makefile.in b/include/nucleus/Makefile.in
index 5e93dc9..a6fa801 100644
diff --git a/include/nucleus/hostrt.h b/include/nucleus/hostrt.h
index 70ffbfe..85b8e88 100644
--- a/include/nucleus/hostrt.h
+++ b/include/nucleus/hostrt.h
@@ -23,32 +23,24 @@
  * 02111-1307, USA.
  */
 
-#include <nucleus/types.h>
-#ifdef __KERNEL__
-#include <asm-generic/xenomai/system.h>
-#else /* !__KERNEL__ */
+#ifndef __KERNEL__
 #include <time.h>
 #include <sys/types.h>
-#include <nucleus/seqlock_user.h>
-typedef u_int32_t u32;
-typedef u_int64_t cycle_t;
+#else /* __KERNEL__ */
+#include <asm-generic/xenomai/system.h>
+#endif /* __KERNEL__ */
+#include <nucleus/seqlock.h>
 
-/*
- * xnarch_hostrt_data must be kept in sync with the corresponding ipipe
- * definitions in ipipe_tickdev.h We cannot directly include the file
- * here because the definitions are also required in Xenomai userland.
- */
-struct xnarch_hostrt_data {
+struct xnvdso_hostrt_data {
 	short live;
-	seqcount_t seqcount;
+	xnseqcount_t seqcount;
 	time_t wall_time_sec;
-	u32 wall_time_nsec;
+	unsigned wall_time_nsec;
 	struct timespec wall_to_monotonic;
-	cycle_t cycle_last;
-	cycle_t mask;
-	u32 mult;
-	u32 shift;
+	unsigned long long cycle_last;
+	unsigned long long mask;
+	unsigned mult;
+	unsigned shift;
 };
-#endif /* !__KERNEL__ */
 
 #endif
diff --git a/include/nucleus/seqlock.h b/include/nucleus/seqlock.h
new file mode 100644
index 0000000..897d411
--- /dev/null
+++ b/include/nucleus/seqlock.h
@@ -0,0 +1,57 @@
+#ifndef __SEQLOCK_H
+#define __SEQLOCK_H
+
+/* Originally from the linux kernel, adapted for userland and Xenomai */
+
+#include <asm/xenomai/atomic.h>
+
+typedef struct xnseqcount {
+	unsigned sequence;
+} xnseqcount_t;
+
+#define XNSEQCNT_ZERO { 0 }
+#define xnseqcount_init(x) do { *(x) = (xnseqcount_t) SEQCNT_ZERO; } while (0)
+
+/* Start of read using pointer to a sequence counter only.  */
+static inline unsigned xnread_seqcount_begin(const xnseqcount_t *s)
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
+static inline int xnread_seqcount_retry(const xnseqcount_t *s, unsigned start)
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
+static inline void xnwrite_seqcount_begin(xnseqcount_t *s)
+{
+	s->sequence++;
+	xnarch_write_memory_barrier();
+}
+
+static inline void xnwrite_seqcount_end(xnseqcount_t *s)
+{
+	xnarch_write_memory_barrier();
+	s->sequence++;
+}
+
+#endif /* __SEQLOCK_H */
diff --git a/include/nucleus/seqlock_user.h b/include/nucleus/seqlock_user.h
deleted file mode 100644
index 598d4da..0000000
--- a/include/nucleus/seqlock_user.h
+++ /dev/null
@@ -1,57 +0,0 @@
-#ifndef __SEQLOCK_USER_H
-#define __SEQLOCK_USER_H
-
-/* Originally from the linux kernel, adapted for userland and Xenomai */
-
-#include <asm/xenomai/atomic.h>
-
-typedef struct seqcount {
-	unsigned sequence;
-} seqcount_t;
-
-#define SEQCNT_ZERO { 0 }
-#define seqcount_init(x) do { *(x) = (seqcount_t) SEQCNT_ZERO; } while (0)
-
-/* Start of read using pointer to a sequence counter only.  */
-static inline unsigned read_seqcount_begin(const seqcount_t *s)
-{
-	unsigned ret;
-
-repeat:
-	ret = s->sequence;
-	xnarch_read_memory_barrier();
-	if (unlikely(ret & 1)) {
-		cpu_relax();
-		goto repeat;
-	}
-	return ret;
-}
-
-/*
- * Test if reader processed invalid data because sequence number has changed.
- */
-static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
-{
-	xnarch_read_memory_barrier();
-
-	return s->sequence != start;
-}
-
-
-/*
- * The sequence counter only protects readers from concurrent writers.
- * Writers must use their own locking.
- */
-static inline void write_seqcount_begin(seqcount_t *s)
-{
-	s->sequence++;
-	xnarch_write_memory_barrier();
-}
-
-static inline void write_seqcount_end(seqcount_t *s)
-{
-	xnarch_write_memory_barrier();
-	s->sequence++;
-}
-
-#endif
diff --git a/include/nucleus/vdso.h b/include/nucleus/vdso.h
index bce4c5a..279574b 100644
--- a/include/nucleus/vdso.h
+++ b/include/nucleus/vdso.h
@@ -34,7 +34,7 @@
 struct xnvdso {
 	unsigned long long features;
 
-	struct xnarch_hostrt_data hostrt_data;
+	struct xnvdso_hostrt_data hostrt_data;
 	/*
 	 * Embed further domain specific structures that
 	 * describe the shared data here
@@ -61,7 +61,7 @@ struct xnvdso {
 
 extern struct xnvdso *nkvdso;
 
-static inline struct xnarch_hostrt_data *get_hostrt_data(void)
+static inline struct xnvdso_hostrt_data *get_hostrt_data(void)
 {
 	return &nkvdso->hostrt_data;
 }
diff --git a/ksrc/nucleus/module.c b/ksrc/nucleus/module.c
index 3f962ba..fc8ceac 100644
--- a/ksrc/nucleus/module.c
+++ b/ksrc/nucleus/module.c
@@ -69,7 +69,7 @@ static inline void do_hostrt_event(struct xnarch_hostrt_data *hostrt)
 	 */
 
 	spin_lock_irqsave(&__hostrtlock, flags);
-	write_seqcount_begin(&nkvdso->hostrt_data.seqcount);
+	xnwrite_seqcount_begin(&nkvdso->hostrt_data.seqcount);
 
 	nkvdso->hostrt_data.live = 1;
 	nkvdso->hostrt_data.cycle_last = hostrt->cycle_last;
@@ -80,7 +80,7 @@ static inline void do_hostrt_event(struct xnarch_hostrt_data *hostrt)
 	nkvdso->hostrt_data.wall_time_nsec = hostrt->wall_time_nsec;
 	nkvdso->hostrt_data.wall_to_monotonic = hostrt->wall_to_monotonic;
 
-	write_seqcount_end(&nkvdso->hostrt_data.seqcount);
+	xnwrite_seqcount_end(&nkvdso->hostrt_data.seqcount);
 	spin_unlock_irqrestore(&__hostrtlock, flags);
 }
 
diff --git a/src/skins/posix/clock.c b/src/skins/posix/clock.c
index 7232c48..4f2171b 100644
--- a/src/skins/posix/clock.c
+++ b/src/skins/posix/clock.c
@@ -25,7 +25,6 @@
 #include <time.h>
 #include <asm/xenomai/arith.h>
 #include <asm-generic/xenomai/timeconv.h>
-#include <nucleus/seqlock_user.h>
 #include <sys/types.h>
 #include <nucleus/vdso.h>
 
@@ -63,9 +62,9 @@ int __do_clock_host_realtime(struct timespec *ts, void *tzp)
 {
 #ifdef XNARCH_HAVE_NONPRIV_TSC
 	unsigned int seq;
-	cycle_t now, base, mask, cycle_delta;
+	unsigned long long now, base, mask, cycle_delta;
 	unsigned long mult, shift, nsec, rem;
-	struct xnarch_hostrt_data *hostrt_data;
+	struct xnvdso_hostrt_data *hostrt_data;
 
 	if (!xnvdso_test_feature(XNVDSO_FEAT_HOST_REALTIME))
 		return -1;
@@ -80,7 +79,7 @@ int __do_clock_host_realtime(struct timespec *ts, void *tzp)
 	 * mechanism in the kernel.
 	 */
 retry:
-	seq = read_seqcount_begin(&hostrt_data->seqcount);
+	seq = xnread_seqcount_begin(&hostrt_data->seqcount);
 
 	now = __xn_rdtsc();
 	base = hostrt_data->cycle_last;
@@ -92,7 +91,7 @@ retry:
 
 	/* If the data changed during the read, try the
 	   alternative data element */
-	if (read_seqcount_retry(&hostrt_data->seqcount, seq))
+	if (xnread_seqcount_retry(&hostrt_data->seqcount, seq))
 		goto retry;
 
 	cycle_delta = (now - base) & mask;
diff --git a/src/testsuite/clocktest/clocktest.c b/src/testsuite/clocktest/clocktest.c
index bf4feb6..038cfbc 100644
--- a/src/testsuite/clocktest/clocktest.c
+++ b/src/testsuite/clocktest/clocktest.c
@@ -99,8 +99,8 @@ static void show_hostrt_diagnostics(void)
 	       (intmax_t)nkvdso->hostrt_data.wall_to_monotonic.tv_sec);
 	printf("         tv_nsec : %ld\n",
 	       nkvdso->hostrt_data.wall_to_monotonic.tv_nsec);
-	printf("cycle_last       : %lu\n", nkvdso->hostrt_data.cycle_last);
-	printf("mask             : 0x%lx\n", nkvdso->hostrt_data.mask);
+	printf("cycle_last       : %Lu\n", nkvdso->hostrt_data.cycle_last);
+	printf("mask             : 0x%Lx\n", nkvdso->hostrt_data.mask);
 	printf("mult             : %u\n", nkvdso->hostrt_data.mult);
 	printf("shift            : %u\n\n", nkvdso->hostrt_data.shift);
 }

Everybody OK?

-- 
                                                                Gilles.

