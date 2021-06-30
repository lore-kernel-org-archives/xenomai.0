Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 2/2] y2038: testsuite/smokey/2038: move mutex test to another
 thread
Date: Wed, 30 Jun 2021 14:32:27 +0800
Message-Id: <1625034747-30055-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

If a process is able to acquire a mutex immediately, we should lock
the mutex in the main thread and validate timeout in the other thread.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 testsuite/smokey/y2038/syscall-tests.c | 74 +++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 174596c..6dea376 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -207,7 +207,34 @@ static void *__mutex_timedlock64_thread(void *arg)
 	struct xn_timespec64 ts64, ts_wu;
 	struct timespec ts_nat;
 
-	ret = clock_gettime(CLOCK_MONOTONIC, &ts_nat);
+	/*
+	 * The mutex is already exhausted, so calling again will validate
+	 * the provided timeout now. Providing NULL has to deliver EFAULT
+	 */
+	ret = XENOMAI_SYSCALL2(sr_nc, lock, NULL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * The mutex is already exhausted, so calling again will validate
+	 * the provided timeout now. Providing an invalid address has to deliver
+	 * EFAULT
+	 */
+	ret = XENOMAI_SYSCALL2(sr_nc, lock, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * The mutex is still exhausted, calling again will validate the
+	 * timeout, providing an invalid timeout has to deliver EINVAL
+	 */
+	ts64.tv_sec = -1;
+	ret = XENOMAI_SYSCALL2(sr_nc, lock, &ts64);
+	if (!smokey_assert(ret == -EINVAL))
+		return ret ? ret : -EINVAL;
+
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
 	if (ret)
 		return NULL;
 
@@ -219,7 +246,7 @@ static void *__mutex_timedlock64_thread(void *arg)
 	if (!smokey_assert(ret == -ETIMEDOUT))
 		return NULL;
 
-	ret = clock_gettime(CLOCK_MONOTONIC, &ts_nat);
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
 	if (ret)
 		return NULL;
 
@@ -240,10 +267,12 @@ static int __mutex_timedlock64(pthread_mutex_t *lock)
 {
 	int ret;
 	pthread_t tid;
+	int sr_nc = sc_cobalt_mutex_timedlock64;
 
-	ret = pthread_mutex_lock(lock);
-	if (ret)
-		return -errno;
+	/* Timeout is never read by the kernel, so NULL should be OK */
+	ret = XENOMAI_SYSCALL2(sr_nc, lock, NULL);
+	if (!smokey_assert(!ret))
+		return ret ? ret : -EINVAL;
 
 	ret = pthread_create(&tid, NULL, __mutex_timedlock64_thread, lock);
 	if (ret)
@@ -289,40 +318,9 @@ static int test_sc_cobalt_mutex_timedlock64(void)
 	if (!smokey_assert(ret == -EINVAL))
 		return ret ? ret : -EINVAL;
 
-	/* Timeout is never read by the kernel, so NULL should be OK */
-	ret = XENOMAI_SYSCALL2(sr_nc, &lock, NULL);
-	if (!smokey_assert(!ret))
-		smokey_warning("POSIX mutex_timedlock64 violation detected");
-
-	/*
-	 * The mutex is already exhausted, so calling again will validate
-	 * the provided timeout now. Providing NULL has to deliver EFAULT
-	 */
-	ret = XENOMAI_SYSCALL2(sr_nc, &lock, NULL);
-	if (!smokey_assert(ret == -EFAULT))
-		return ret ? ret : -EINVAL;
-
-	/*
-	 * The mutex is already exhausted, so calling again will validate
-	 * the provided timeout now. Providing an invalid address has to deliver
-	 * EFAULT
-	 */
-	ret = XENOMAI_SYSCALL2(sr_nc, &lock, (void *)0xdeadbeefUL);
-	if (!smokey_assert(ret == -EFAULT))
-		return ret ? ret : -EINVAL;
-
-	/*
-	 * The mutex is still exhausted, calling again will validate the
-	 * timeout, providing an invalid timeout has to deliver EINVAL
-	 */
-	ts64.tv_sec = -1;
-	ret = XENOMAI_SYSCALL2(sr_nc, &lock, &ts64);
-	if (!smokey_assert(ret == -EINVAL))
-		return ret ? ret : -EINVAL;
-
 	/*
-	 * Providing a valid timeout, waiting for it to time out and check
-	 * that we didn't come back to early.
+	 * mutex will be acquired in current thread, timeout will be
+	 * validated in the other thread
 	 */
 	ret = __mutex_timedlock64(&lock);
 	if (ret)
-- 
2.7.4


