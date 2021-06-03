Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v3 3/3] y2038: testsuite/smokey/y2038: testcase for
 mutex_timedlock64
Date: Thu,  3 Jun 2021 20:05:41 +0800
Message-Id: <1622721941-2348-1-git-send-email-chensong_2000@189.cn>
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
v2:
1, new revision regarding review comments

v3:
1, return -errno
2, throw a warning if timeout is NULL
---
 testsuite/smokey/y2038/syscall-tests.c | 136 +++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 0e6b84f..174596c 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -199,6 +199,138 @@ static int test_sc_cobalt_sem_timedwait64(void)
 	return 0;
 }
 
+static void *__mutex_timedlock64_thread(void *arg)
+{
+	pthread_mutex_t *lock = arg;
+	int ret;
+	int sr_nc = sc_cobalt_mutex_timedlock64;
+	struct xn_timespec64 ts64, ts_wu;
+	struct timespec ts_nat;
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &ts_nat);
+	if (ret)
+		return NULL;
+
+	ts64.tv_sec = ts_nat.tv_sec;
+	ts64.tv_nsec = ts_nat.tv_nsec;
+	ts_add_ns(&ts64, 5000000);
+
+	ret = XENOMAI_SYSCALL2(sr_nc, lock, &ts64);
+	if (!smokey_assert(ret == -ETIMEDOUT))
+		return NULL;
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &ts_nat);
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
+static int __mutex_timedlock64(pthread_mutex_t *lock)
+{
+	int ret;
+	pthread_t tid;
+
+	ret = pthread_mutex_lock(lock);
+	if (ret)
+		return -errno;
+
+	ret = pthread_create(&tid, NULL, __mutex_timedlock64_thread, lock);
+	if (ret)
+		return -errno;
+
+	ret = pthread_join(tid, NULL);
+	if (ret)
+		return -errno;
+
+	ret = pthread_mutex_unlock(lock);
+	if (ret)
+		return -errno;
+
+	ret = pthread_mutex_destroy(lock);
+	if (ret)
+		return -errno;
+
+	return 0;
+}
+
+static int test_sc_cobalt_mutex_timedlock64(void)
+{
+	int ret;
+	int sr_nc = sc_cobalt_mutex_timedlock64;
+	struct xn_timespec64 ts64;
+
+	pthread_mutexattr_t mattr;
+	pthread_mutex_t lock;
+
+	pthread_mutexattr_init(&mattr);
+	pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_NORMAL);
+	pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_PRIVATE);
+	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
+	ret = pthread_mutex_init(&lock, &mattr);
+	pthread_mutexattr_destroy(&mattr);
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL2(sr_nc, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("mutex_timedlock64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EINVAL))
+		return ret ? ret : -EINVAL;
+
+	/* Timeout is never read by the kernel, so NULL should be OK */
+	ret = XENOMAI_SYSCALL2(sr_nc, &lock, NULL);
+	if (!smokey_assert(!ret))
+		smokey_warning("POSIX mutex_timedlock64 violation detected");
+
+	/*
+	 * The mutex is already exhausted, so calling again will validate
+	 * the provided timeout now. Providing NULL has to deliver EFAULT
+	 */
+	ret = XENOMAI_SYSCALL2(sr_nc, &lock, NULL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * The mutex is already exhausted, so calling again will validate
+	 * the provided timeout now. Providing an invalid address has to deliver
+	 * EFAULT
+	 */
+	ret = XENOMAI_SYSCALL2(sr_nc, &lock, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * The mutex is still exhausted, calling again will validate the
+	 * timeout, providing an invalid timeout has to deliver EINVAL
+	 */
+	ts64.tv_sec = -1;
+	ret = XENOMAI_SYSCALL2(sr_nc, &lock, &ts64);
+	if (!smokey_assert(ret == -EINVAL))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * Providing a valid timeout, waiting for it to time out and check
+	 * that we didn't come back to early.
+	 */
+	ret = __mutex_timedlock64(&lock);
+	if (ret)
+		return -errno;
+
+	return 0;
+}
+
 static int test_sc_cobalt_clock_gettime64(void)
 {
 	int ret;
@@ -430,5 +562,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
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


