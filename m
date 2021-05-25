Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 3/3] y2038: testsuite/smokey/y2038: testcase for
 mutex_timedlock64
Date: Tue, 25 May 2021 11:03:56 +0800
Message-Id: <1621911836-29209-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

add test case for mutex_timedlock64 in testsuite

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 testsuite/smokey/y2038/syscall-tests.c | 139 ++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 22fd9b6..45f2fbe 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -14,6 +14,8 @@
 #include <unistd.h>
 #include <stdint.h>
 #include <errno.h>
+#include <pthread.h>
+#include <asm/xenomai/syscall.h>
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
@@ -200,6 +202,138 @@ static int test_sc_cobalt_sem_timedwait64(void)
 	return 0;
 }
 
+static void *__mutex_timedlock64_thread(void *arg)
+{
+	pthread_mutex_t *lock = arg;
+	long ret;
+	int code = sc_cobalt_mutex_timedlock64;
+	struct xn_timespec64 ts64, ts_wu;
+	struct timespec ts_nat;
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret)
+		return NULL;
+
+	ts64.tv_sec = ts_nat.tv_sec;
+	ts64.tv_nsec = ts_nat.tv_nsec;
+	ts_add_ns(&ts64, 5000000);
+
+	ret = XENOMAI_SYSCALL2(code, lock, &ts64);
+	if (!smokey_assert(ret == -ETIMEDOUT))
+		return NULL;
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret)
+		return NULL;
+
+	ts_wu.tv_sec = ts_nat.tv_sec;
+	ts_wu.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&ts_wu, &ts64))
+		smokey_warning("mutex_timedlock64 returned to early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       ts64.tv_sec, ts64.tv_nsec, ts_wu.tv_sec,
+			       ts_wu.tv_nsec);
+
+	return NULL;
+}
+
+static int __mutex_timdlock64(pthread_mutex_t *lock)
+{
+	long ret;
+	pthread_t tid;
+
+	ret = pthread_mutex_lock(lock);
+	if (ret)
+		return errno;
+
+	ret = pthread_create(&tid, NULL, __mutex_timedlock64_thread, lock);
+	if (ret)
+		return errno;
+
+	ret = pthread_join(tid, NULL);
+	if (ret)
+		return errno;
+
+	ret = pthread_mutex_unlock(lock);
+	if (ret)
+		return errno;
+
+	ret = pthread_mutex_destroy(lock);
+	if (ret)
+		return errno;
+
+	return 0;
+}
+
+static int test_sc_cobalt_mutex_timedlock64(void)
+{
+	long ret;
+	int code = sc_cobalt_mutex_timedlock64;
+	struct xn_timespec64 ts64;
+
+	pthread_mutexattr_t mattr;
+	pthread_mutex_t lock;
+
+	pthread_mutexattr_init(&mattr);
+	pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_NORMAL);
+	pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_PRIVATE);
+	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
+	ret = __RT(pthread_mutex_init(&lock, &mattr));
+	pthread_mutexattr_destroy(&mattr);
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL2(code, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("mutex_timedlock64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EINVAL))
+		return ret ? ret : -EINVAL;
+
+	/* Timeout is never read by the kernel, so NULL should be OK */
+	ret = XENOMAI_SYSCALL2(code, &lock, NULL);
+	if (!smokey_assert(ret))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * The mutex is already exhausted, so calling again will validate
+	 * the provided timeout now. Providing NULL has to deliver EFAULT
+	 */
+	ret = XENOMAI_SYSCALL2(code, &lock, NULL);
+	if (!smokey_assert(ret))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * The mutex is already exhausted, so calling again will validate
+	 * the provided timeout now. Providing an invalid address has to deliver
+	 * EFAULT
+	 */
+	ret = XENOMAI_SYSCALL2(code, &lock, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * The mutex is still exhausted, calling again will validate the
+	 * timeout, providing an invalid timeout has to deliver EINVAL
+	 */
+	ts64.tv_sec = -1;
+	ret = XENOMAI_SYSCALL2(code, &lock, &ts64);
+	if (!smokey_assert(ret))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * Providing a valid timeout, waiting for it to time out and check
+	 * that we didn't come back to early.
+	 */
+	ret = __mutex_timdlock64(&lock);
+	if (ret)
+		return errno;
+
+	return 0;
+}
+
 static int test_sc_cobalt_clock_gettime64(void)
 {
 	long ret;
@@ -395,7 +529,6 @@ static int test_sc_cobalt_clock_adjtime64(void)
 
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
-
 	int ret;
 
 	ret = test_sc_cobalt_sem_timedwait64();
@@ -422,5 +555,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_mutex_timedlock64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.7.4


