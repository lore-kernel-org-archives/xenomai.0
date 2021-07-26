Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 3/3] y2038: testsuite/smokey/y2038: testcase for monitor_wait64
Date: Mon, 26 Jul 2021 15:16:47 +0800
Message-Id: <1627283807-4291-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

add test case for monitor_wait64 in testsuite

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 testsuite/smokey/y2038/syscall-tests.c | 81 +++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index e127cb6..3913938 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -19,6 +19,8 @@
 #include <errno.h>
 #include <mqueue.h>
 #include <signal.h>
+#include <cobalt/uapi/monitor.h>
+#include <sys/cobalt.h>
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
@@ -457,7 +459,8 @@ static int test_sc_cobalt_clock_nanosleep64(void)
 	next.tv_sec  = ts2.tv_sec + interval;
 	next.tv_nsec = ts2.tv_nsec;
 
-	ret = XENOMAI_SYSCALL4(sc_nr, CLOCK_MONOTONIC, TIMER_ABSTIME, &next, &rmt);
+	ret = XENOMAI_SYSCALL4(sc_nr, CLOCK_MONOTONIC, TIMER_ABSTIME,
+				&next, &rmt);
 	if (!smokey_assert(!ret))
 		return ret ? ret : -EINVAL;
 
@@ -762,6 +765,78 @@ static int test_sc_cobalt_sigtimedwait64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_monitor_wait64(void)
+{
+	int ret, opret;
+	int sc_nr = sc_cobalt_monitor_wait64;
+	struct xn_timespec64 ts64, ts_wu;
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
+				(void *)0xdeadbeefUL, NULL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * providing an invalid timeout has to deliver EINVAL
+	 */
+	ts64.tv_sec = -1;
+	ret = XENOMAI_SYSCALL4(sc_nr, &mon, COBALT_MONITOR_WAITGRANT,
+				&ts64, NULL);
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
+	ts64.tv_sec = 0;
+	ts64.tv_nsec = 500000;
+
+	ret = XENOMAI_SYSCALL4(sc_nr, &mon, COBALT_MONITOR_WAITGRANT,
+				&ts64, &opret);
+	if (!smokey_assert(opret == -ETIMEDOUT))
+		return ret;
+
+	ts64.tv_sec = ts_nat.tv_sec;
+	ts64.tv_nsec = ts_nat.tv_nsec;
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret)
+		return -errno;
+
+	ts_wu.tv_sec = ts_nat.tv_sec;
+	ts_wu.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&ts_wu, &ts64))
+		smokey_warning("monitor_wait64 returned to early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       ts64.tv_sec, ts64.tv_nsec, ts_wu.tv_sec,
+			       ts_wu.tv_nsec);
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 
@@ -807,5 +882,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_monitor_wait64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.7.4


