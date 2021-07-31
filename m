From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 5/5] y2038: testsuite/smokey/y2038: Adding tests for
 mq_timed{send, recv}64
Date: Sat, 31 Jul 2021 09:19:42 +0200
Message-Id: <20210731071942.69806-6-florian.bezdeka@siemens.com>
In-Reply-To: <20210731071942.69806-1-florian.bezdeka@siemens.com>
References: <20210731071942.69806-1-florian.bezdeka@siemens.com>
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

Extending the test suite for mq_timedsend64() and mq_timedrecv64()
tests.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 177 ++++++++++++++++++++++++-
 1 file changed, 176 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 2e8add864..36475347e 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -17,6 +17,7 @@
 #include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
+#include <mqueue.h>
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
@@ -219,7 +220,7 @@ static int test_sc_cobalt_sem_timedwait64(void)
 
 	ret = XENOMAI_SYSCALL2(sc_nr, &sem, &ts64);
 	if (!smokey_assert(ret == -ETIMEDOUT))
-		return ret;
+		return ret ? ret : -EINVAL;
 
 	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
 	if (ret)
@@ -587,6 +588,172 @@ static int test_sc_cobalt_mutex_timedlock64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_mq_timedsend64(void)
+{
+	int ret;
+	int sc_nr = sc_cobalt_mq_timedsend64;
+	struct xn_timespec64 t1, t2;
+	struct timespec ts_nat;
+
+	mqd_t mq;
+	struct mq_attr qa;
+	char msg[64] = "Xenomai is cool!";
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
+	mq_unlink("/xenomai_mq_send");
+	qa.mq_maxmsg = 1;
+	qa.mq_msgsize = 128;
+
+	mq = mq_open("/xenomai_mq_send", O_RDWR | O_CREAT, 0, &qa);
+	if (mq < 0)
+		return mq;
+
+	/* Timeout is never read by the kernel, so NULL should be OK */
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, NULL);
+	if (!smokey_assert(!ret))
+		return ret;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0,
+			       (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * providing an invalid timeout has to deliver EINVAL
+	 */
+	t1.tv_sec = -1;
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, &t1);
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
+	ts_add_ns(&t1, 500000);
+
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, &t1);
+	if (!smokey_assert(ret == -ETIMEDOUT))
+		return ret ? ret : -EINVAL;
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret)
+		return -errno;
+
+	t2.tv_sec = ts_nat.tv_sec;
+	t2.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&t2, &t1))
+		smokey_warning("mq_timedsend64 returned to early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
+
+	ret = mq_unlink("/xenomai_mq_send");
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int test_sc_cobalt_mq_timedreceive64(void)
+{
+	int ret;
+	int sc_nr = sc_cobalt_mq_timedsend64;
+	struct xn_timespec64 t1, t2;
+	struct timespec ts_nat;
+
+	mqd_t mq;
+	struct mq_attr qa;
+	char msg[64];
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
+	mq_unlink("/xenomai_mq_recv");
+	qa.mq_maxmsg = 1;
+	qa.mq_msgsize = 128;
+
+	mq = mq_open("/xenomai_mq_recv", O_RDWR | O_CREAT, 0, &qa);
+	if (mq < 0)
+		return mq;
+
+	/* Timeout is never read by the kernel, so NULL should be OK */
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, NULL);
+	if (!smokey_assert(!ret))
+		return ret;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0,
+			       (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * providing an invalid timeout has to deliver EINVAL
+	 */
+	t1.tv_sec = -1;
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, &t1);
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
+	ts_add_ns(&t1, 500000);
+
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, &t1);
+	if (!smokey_assert(ret == -ETIMEDOUT))
+		return ret ? ret : -EINVAL;
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret)
+		return -errno;
+
+	t2.tv_sec = ts_nat.tv_sec;
+	t2.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&t2, &t1))
+		smokey_warning("mq_timedreceive64 returned to early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
+
+	ret = mq_unlink("/xenomai_mq_recv");
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
@@ -619,5 +786,13 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
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
2.30.2


