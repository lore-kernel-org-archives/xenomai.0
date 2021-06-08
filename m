Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 5/5] y2038: testsuite/smokey/y2038: testcase for mq_timed{send, recv}64
Date: Tue,  8 Jun 2021 10:12:41 +0800
Message-Id: <1623118361-7774-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

add test case for mutex_timed{send,recv} in testsuite

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 testsuite/smokey/y2038/syscall-tests.c | 169 +++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 174596c..ca2e597 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -17,6 +17,7 @@
 #include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
+#include <mqueue.h>
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
@@ -533,6 +534,166 @@ static int test_sc_cobalt_clock_adjtime64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_mq_timedsend64(void)
+{
+	int ret;
+	int sc_nr = sc_cobalt_mq_timedsend64;
+	struct xn_timespec64 ts64, ts_wu;
+	struct timespec ts_nat;
+
+	mqd_t mq;
+	struct mq_attr qa;
+	char msg[64] = "Xenomai is cool!";
+
+	mq_unlink("/xenomai_mq_send");
+	qa.mq_maxmsg = 1;
+	qa.mq_msgsize = 128;
+
+	mq = mq_open("/xenomai_mq_send", O_RDWR | O_CREAT, 0, &qa);
+	if (mq < 0)
+		return mq;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("mq_timedsend64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EBADF))
+		return ret ? ret : -EBADF;
+
+	/* Timeout is never read by the kernel, so NULL should be OK */
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, NULL);
+	if (!smokey_assert(!ret))
+		return ret;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg),
+				0, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * providing an invalid timeout has to deliver EINVAL
+	 */
+	ts64.tv_sec = -1;
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, &ts64);
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
+	ts64.tv_sec = ts_nat.tv_sec;
+	ts64.tv_nsec = ts_nat.tv_nsec;
+	ts_add_ns(&ts64, 500000);
+
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, &ts64);
+	if (!smokey_assert(ret == -ETIMEDOUT))
+		return ret;
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret)
+		return -errno;
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
+static int test_sc_cobalt_mq_timedreceive64(void)
+{
+	int ret;
+	int sc_nr = sc_cobalt_mq_timedsend64;
+	struct xn_timespec64 ts64, ts_wu;
+	struct timespec ts_nat;
+
+	mqd_t mq;
+	struct mq_attr qa;
+	char msg[64];
+
+	mq_unlink("/xenomai_mq_recv");
+	qa.mq_maxmsg = 1;
+	qa.mq_msgsize = 128;
+
+	mq = mq_open("/xenomai_mq_recv", O_RDWR | O_CREAT, 0, &qa);
+	if (mq < 0)
+		return mq;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("mq_timedreceive64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EBADF))
+		return ret ? ret : -EBADF;
+
+	/* Timeout is never read by the kernel, so NULL should be OK */
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, NULL);
+	if (!smokey_assert(!ret))
+		return ret;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg),
+				0, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * providing an invalid timeout has to deliver EINVAL
+	 */
+	ts64.tv_sec = -1;
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, &ts64);
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
+	ts64.tv_sec = ts_nat.tv_sec;
+	ts64.tv_nsec = ts_nat.tv_nsec;
+	ts_add_ns(&ts64, 500000);
+
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, &ts64);
+	if (!smokey_assert(ret == -ETIMEDOUT))
+		return ret;
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret)
+		return -errno;
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
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 
@@ -566,5 +727,13 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_mq_timedsend64();
+	if (ret)
+		return ret;
+
+	ret = test_sc_cobalt_mq_timedreceive64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.7.4


