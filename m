From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v4 3/4] y2038: Add tests for the sc_cobalt_sem_timedwait64
 syscall
Date: Fri,  7 May 2021 14:49:52 +0200
Message-Id: <20210507124953.1079415-4-florian.bezdeka@siemens.com>
In-Reply-To: <20210507124953.1079415-1-florian.bezdeka@siemens.com>
References: <20210507124953.1079415-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Introducing a new smokey plugin that can be extended for all kind of
y2038 tests. For now we are testing the new sc_cobalt_sem_timedwait64
syscall without using any libc wrappers provided by libcobalt.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 configure.ac                           |   1 +
 testsuite/smokey/Makefile.am           |   6 +-
 testsuite/smokey/y2038/Makefile.am     |  10 ++
 testsuite/smokey/y2038/syscall-tests.c | 177 +++++++++++++++++++++++++
 4 files changed, 192 insertions(+), 2 deletions(-)
 create mode 100644 testsuite/smokey/y2038/Makefile.am
 create mode 100644 testsuite/smokey/y2038/syscall-tests.c

diff --git a/configure.ac b/configure.ac
index abe538dbd..bd5fd5ba9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -990,6 +990,7 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/net_common/Makefile \
 	testsuite/smokey/cpu-affinity/Makefile \
 	testsuite/smokey/gdb/Makefile \
+	testsuite/smokey/y2038/Makefile \
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
 	utils/Makefile \
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index 02613c7dc..56c873026 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -38,7 +38,8 @@ COBALT_SUBDIRS = 	\
 	timerfd		\
 	tsc		\
 	vdso-access 	\
-	xddp
+	xddp		\
+	y2038
 
 MERCURY_SUBDIRS =	\
 	memory-heapmem	\
@@ -76,7 +77,8 @@ DIST_SUBDIRS = 		\
 	timerfd		\
 	tsc		\
 	vdso-access 	\
-	xddp
+	xddp		\
+	y2038
 
 if XENO_COBALT
 if CONFIG_XENO_LIBS_DLOPEN
diff --git a/testsuite/smokey/y2038/Makefile.am b/testsuite/smokey/y2038/Makefile.am
new file mode 100644
index 000000000..4bf629e87
--- /dev/null
+++ b/testsuite/smokey/y2038/Makefile.am
@@ -0,0 +1,10 @@
+
+noinst_LIBRARIES = liby2038.a
+
+liby2038_a_SOURCES = syscall-tests.c
+
+liby2038_a_CPPFLAGS = 	\
+	@XENO_USER_CFLAGS@	\
+	-I$(top_srcdir)		\
+	-I$(top_srcdir)/include \
+	-I$(top_srcdir)/lib/cobalt/arch/@XENO_TARGET_ARCH@/include
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
new file mode 100644
index 000000000..9d5b93ef9
--- /dev/null
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -0,0 +1,177 @@
+/*
+ * y2038 tests
+ *
+ * Copyright (c) Siemens AG 2021
+ *
+ * Authors:
+ *  Florian Bezdeka <florian.bezdeka@siemens.com>
+ *
+ * Released under the terms of GPLv2.
+ */
+#include <asm/xenomai/syscall.h>
+#include <cobalt/uapi/syscall.h>
+#include <smokey/smokey.h>
+#include <semaphore.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <errno.h>
+
+smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
+
+/*
+ * libc independent data type representing a time64_t based struct timespec
+ */
+struct xn_timespec64 {
+	int64_t tv_sec;
+	int64_t tv_nsec;
+};
+
+#define NSEC_PER_SEC 1000000000
+
+static void ts_normalise(struct xn_timespec64 *ts)
+{
+	while (ts->tv_nsec >= NSEC_PER_SEC) {
+		ts->tv_nsec += 1;
+		ts->tv_nsec -= NSEC_PER_SEC;
+	}
+
+	while (ts->tv_nsec <= -NSEC_PER_SEC) {
+		ts->tv_sec -= 1;
+		ts->tv_nsec += NSEC_PER_SEC;
+	}
+
+	if (ts->tv_nsec < 0) {
+		/*
+		 * Negative nanoseconds isn't valid according to POSIX.
+		 * Decrement tv_sec and roll tv_nsec over.
+		 */
+		ts->tv_sec -= 1;
+		ts->tv_nsec = (NSEC_PER_SEC + ts->tv_nsec);
+	}
+}
+
+static inline void ts_add_ns(struct xn_timespec64 *ts, int ns)
+{
+	ts->tv_nsec += ns;
+	ts_normalise(ts);
+}
+
+/**
+ * Compare two struct timespec instances
+ *
+ * @param a
+ * @param b
+ * @return True if a < b, false otherwise
+ */
+static inline bool ts_less(const struct xn_timespec64 *a,
+			   const struct xn_timespec64 *b)
+{
+	if (a->tv_sec < b->tv_sec)
+		return true;
+
+	if (a->tv_sec > b->tv_sec)
+		return false;
+
+	/* a->tv_sec == b->tv_sec */
+
+	if (a->tv_nsec < b->tv_nsec)
+		return true;
+
+	return false;
+}
+
+static int test_sc_cobalt_sem_timedwait64(void)
+{
+	int ret;
+	sem_t sem;
+	int sc_nr = sc_cobalt_sem_timedwait64;
+	struct xn_timespec64 ts64, ts_wu;
+	struct timespec ts_nat;
+
+	sem_init(&sem, 0, 0);
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("sem_timedwait64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EINVAL))
+		return ret;
+
+	/* Timeout is never read by the kernel, so NULL should be OK */
+	sem_post(&sem);
+	ret = XENOMAI_SYSCALL2(sc_nr, &sem, NULL);
+	if (!smokey_assert(!ret))
+		return ret;
+
+	/*
+	 * The semaphore is already exhausted, so calling again will validate
+	 * the provided timeout now. Providing NULL has to deliver EFAULT
+	 */
+	ret = XENOMAI_SYSCALL2(sc_nr, &sem, NULL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret;
+
+	/*
+	 * The semaphore is already exhausted, so calling again will validate
+	 * the provided timeout now. Providing an invalid adress has to deliver
+	 * EFAULT
+	 */
+	ret = XENOMAI_SYSCALL2(sc_nr, &sem, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret;
+
+	/*
+	 * The semaphore is still exhausted, calling again will validate the
+	 * timeout, providing an invalid timeout has to deliver EINVAL
+	 */
+	ts64.tv_sec = -1;
+	ret = XENOMAI_SYSCALL2(sc_nr, &sem, &ts64);
+	if (!smokey_assert(ret == -EINVAL))
+		return ret;
+
+	/*
+	 * Providing a valid timeout, waiting for it to time out and check
+	 * that we didn't come back to early.
+	 */
+	ret = clock_gettime(CLOCK_MONOTONIC, &ts_nat);
+	if (ret)
+		return ret;
+
+	ts64.tv_sec = ts_nat.tv_sec;
+	ts64.tv_nsec = ts_nat.tv_nsec;
+	ts_add_ns(&ts64, 500000);
+
+	ret = XENOMAI_SYSCALL2(sc_nr, &sem, &ts64);
+	if (!smokey_assert(ret == -ETIMEDOUT))
+		return ret;
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &ts_nat);
+	if (ret)
+		return ret;
+
+	ts_wu.tv_sec = ts_nat.tv_sec;
+	ts_wu.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&ts_wu, &ts64))
+		smokey_warning("sem_timedwait64 returned to early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       ts64.tv_sec, ts64.tv_nsec, ts_wu.tv_sec,
+			       ts_wu.tv_nsec);
+
+	return 0;
+}
+
+static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
+{
+	int ret;
+
+	ret = test_sc_cobalt_sem_timedwait64();
+	if (ret)
+		return ret;
+
+	return 0;
+}
-- 
2.31.1


