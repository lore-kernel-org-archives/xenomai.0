From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 3/3] y2038: testsuite/smokey/y2038: Adding testcases for
 monitor_wait64()
Date: Wed, 11 Aug 2021 10:11:20 +0200
Message-Id: <20210811081120.18402-4-florian.bezdeka@siemens.com>
In-Reply-To: <20210811081120.18402-1-florian.bezdeka@siemens.com>
References: <20210811081120.18402-1-florian.bezdeka@siemens.com>
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

The time measurement is a bit different to the other y2038 related
measurements we do. Using a monitor with CLOCK_REALTIME requires an
absolute timeout.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 78 +++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 427117038..839a50e07 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -19,6 +19,8 @@
 #include <errno.h>
 #include <mqueue.h>
 #include <signal.h>
+#include <cobalt/uapi/monitor.h>
+#include <sys/cobalt.h>
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
@@ -367,7 +369,8 @@ static int test_sc_cobalt_clock_nanosleep64(void)
 	next.tv_sec  = ts2.tv_sec + interval;
 	next.tv_nsec = ts2.tv_nsec;
 
-	ret = XENOMAI_SYSCALL4(sc_nr, CLOCK_MONOTONIC, TIMER_ABSTIME, &next, &rmt);
+	ret = XENOMAI_SYSCALL4(sc_nr, CLOCK_MONOTONIC, TIMER_ABSTIME, &next,
+			       &rmt);
 	if (!smokey_assert(!ret))
 		return ret;
 
@@ -844,6 +847,75 @@ static int test_sc_cobalt_sigtimedwait64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_monitor_wait64(void)
+{
+	int ret, opret;
+	int sc_nr = sc_cobalt_monitor_wait64;
+	struct xn_timespec64 t1, t2, to;
+	struct timespec ts_nat;
+	struct cobalt_monitor_shadow mon;
+
+	ret = cobalt_monitor_init(&mon, CLOCK_REALTIME, 0);
+	if (ret)
+		return -errno;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL4(sc_nr, NULL, NULL, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("monitor_wait64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EINVAL))
+		return ret ? ret : -EINVAL;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = XENOMAI_SYSCALL4(sc_nr, &mon, COBALT_MONITOR_WAITGRANT,
+			       (void *)0xdeadbeefUL, NULL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/* providing an invalid timeout has to deliver EINVAL */
+	t1.tv_sec = -1;
+	ret = XENOMAI_SYSCALL4(sc_nr, &mon, COBALT_MONITOR_WAITGRANT, &t1,
+			       NULL);
+	if (!smokey_assert(ret == -EINVAL))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * Providing a valid timeout, waiting for it to time out and check
+	 * that we didn't come back to early.
+	 */
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret)
+		return -errno;
+
+	t1.tv_sec = ts_nat.tv_sec;
+	t1.tv_nsec = ts_nat.tv_nsec;
+
+	to = t1;
+	ts_add_ns(&to, 50000);
+
+	ret = XENOMAI_SYSCALL4(sc_nr, &mon, COBALT_MONITOR_WAITGRANT, &to,
+			       &opret);
+	if (!smokey_assert(opret == -ETIMEDOUT))
+		return ret;
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret)
+		return -errno;
+
+	t2.tv_sec = ts_nat.tv_sec;
+	t2.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&t2, &to))
+		smokey_warning("monitor_wait64 returned too early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       to.tv_sec, to.tv_nsec, t2.tv_sec, t2.tv_nsec);
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
@@ -888,5 +960,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_monitor_wait64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.30.2


