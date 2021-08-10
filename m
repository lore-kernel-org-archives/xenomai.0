From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v3 5/5] y2038: testsuite/smokey/y2038: Adding tests for
 mq_timed{send, recv}64
Date: Tue, 10 Aug 2021 12:24:51 +0200
Message-Id: <20210810102451.49642-6-florian.bezdeka@siemens.com>
In-Reply-To: <20210810102451.49642-1-florian.bezdeka@siemens.com>
References: <20210810102451.49642-1-florian.bezdeka@siemens.com>
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
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 190 ++++++++++++++++++++++++-
 1 file changed, 189 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 628fe852f..d30794fba 100644
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
@@ -588,6 +589,185 @@ static int test_sc_cobalt_mutex_timedlock64(void)
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
+	qa.mq_msgsize = 64;
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
+		smokey_warning("mq_timedsend64 returned too early!\n"
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
+	int sc_nr = sc_cobalt_mq_timedreceive64;
+	struct xn_timespec64 t1, t2;
+	struct timespec ts_nat;
+
+	mqd_t mq;
+	struct mq_attr qa;
+	char msg[64];
+	unsigned int prio = 0;
+	size_t size = 64;
+
+	mq_unlink("/xenomai_mq_recv");
+	qa.mq_maxmsg = 1;
+	qa.mq_msgsize = 64;
+
+	mq = mq_open("/xenomai_mq_recv", O_RDWR | O_CREAT, 0, &qa);
+	if (mq < 0)
+		return mq;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, NULL, NULL, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("mq_timedreceive64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/* Send something, we want to receive it later */
+	ret = mq_send(mq, "msg", 4, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Timeout is never read by the kernel, so NULL should be OK, the queue
+	 * is empty afterwards
+	 */
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, &size, &prio, NULL);
+	if (!smokey_assert(!ret))
+		return ret;
+
+	/* Check the message content, we should have received "msg" */
+	if (!smokey_assert(!memcmp(msg, "msg", 3)))
+		return -EINVAL;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	size = 64;
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, &size, &prio,
+			       (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/* providing an invalid timeout has to deliver EINVAL */
+	t1.tv_sec = -1;
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, &size, &prio, &t1);
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
+	ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, &size, &prio, &t1);
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
+		smokey_warning("mq_timedreceive64 returned too early!\n"
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
@@ -620,5 +800,13 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
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


