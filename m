From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 3/3] y2038: testsuite/smokey/y2038: Adding tests for
 sigtimedwait64
Date: Tue, 10 Aug 2021 17:27:11 +0200
Message-Id: <20210810152711.227714-4-florian.bezdeka@siemens.com>
In-Reply-To: <20210810152711.227714-1-florian.bezdeka@siemens.com>
References: <20210810152711.227714-1-florian.bezdeka@siemens.com>
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

Heavily inspired by the tests sent from Song but with the following
modifications:
  - return -EAGAIN instead of -ETIMEOUT (posix spec) in case of a
    timeout
  - Fix time calculations for timeout detection

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 80 ++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index d30794fba..427117038 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <mqueue.h>
+#include <signal.h>
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
@@ -768,6 +769,81 @@ static int test_sc_cobalt_mq_timedreceive64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_sigtimedwait64(void)
+{
+	int ret;
+	int sc_nr = sc_cobalt_sigtimedwait64;
+	struct xn_timespec64 t1, t2;
+	struct timespec ts_nat;
+	sigset_t set;
+
+	sigaddset(&set, SIGINT);
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL3(sc_nr, NULL, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("sigtimedwait64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = XENOMAI_SYSCALL3(sc_nr, &set, NULL, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/* providing an invalid timeout has to deliver EINVAL */
+	t1.tv_sec = -1;
+	ret = XENOMAI_SYSCALL3(sc_nr, &set, NULL, &t1);
+	if (!smokey_assert(ret == -EINVAL))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * Providing a zero timeout, should come back immediately, no signal
+	 * will be received
+	 */
+	t1.tv_sec = 0;
+	t1.tv_nsec = 0;
+	ret = XENOMAI_SYSCALL3(sc_nr, &set, NULL, &t1);
+	if (!smokey_assert(ret == -EAGAIN))
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
+	t1.tv_sec = 0;
+	t1.tv_nsec = 500000;
+
+	ret = XENOMAI_SYSCALL3(sc_nr, &set, NULL, &t1);
+	if (!smokey_assert(ret == -EAGAIN))
+		return ret;
+
+	t1.tv_sec = ts_nat.tv_sec;
+	t1.tv_nsec = ts_nat.tv_nsec;
+	ts_add_ns(&t1, 500000);
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret)
+		return -errno;
+
+	t2.tv_sec = ts_nat.tv_sec;
+	t2.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&t2, &t1))
+		smokey_warning("sigtimedwait64 returned too early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
@@ -808,5 +884,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_sigtimedwait64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.30.2


