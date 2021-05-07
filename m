From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: y2038: Migrate from syscall() to XENOMAI_SYSCALLx()
Date: Fri,  7 May 2021 16:05:59 +0200
Message-Id: <20210507140559.1099146-1-florian.bezdeka@siemens.com>
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
To: chensong_2000@189.cn
Cc: jan.kiszka@siemens.com, xenomai@xenomai.org, Florian Bezdeka <florian.bezdeka@siemens.com>

Hi Song,                                                                 
                                                                         
you may have already noticed that we had a problem running the y2038 on 
some ARM boards. The problem was detected once Jan picked the series of 
the sem_timedwait64 implementation into next and triggered a test run on 
real hardware.                                                           
                                                                         
As a result I had to migrate from syscall() to XENOMAI_SYSCALLx().
                                                                         
As the acutal change is hard to find in v4 that I recently pushed to the 
list: Here is "patch" that shows the pattern I used.                     
                                                                         
Sadly replacing the function call is not enough because glibc 
"communicates" using "errno", while the Xenomai interface does not.      
                                                                         
How to deal with your patches? Any chance that you could "migrate" 
as well? Or should I try to find some time to do that?

Best regards,
Florian                                                                         

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

---
 testsuite/smokey/y2038/Makefile.am     |  3 +-
 testsuite/smokey/y2038/syscall-tests.c | 45 +++++++++++++-------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/testsuite/smokey/y2038/Makefile.am b/testsuite/smokey/y2038/Makefile.am
index 96fc13cb6..4bf629e87 100644
--- a/testsuite/smokey/y2038/Makefile.am
+++ b/testsuite/smokey/y2038/Makefile.am
@@ -6,4 +6,5 @@ liby2038_a_SOURCES = syscall-tests.c
 liby2038_a_CPPFLAGS = 	\
 	@XENO_USER_CFLAGS@	\
 	-I$(top_srcdir)		\
-	-I$(top_srcdir)/include
+	-I$(top_srcdir)/include \
+	-I$(top_srcdir)/lib/cobalt/arch/@XENO_TARGET_ARCH@/include
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index efc7562d7..9d5b93ef9 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -8,6 +8,7 @@
  *
  * Released under the terms of GPLv2.
  */
+#include <asm/xenomai/syscall.h>
 #include <cobalt/uapi/syscall.h>
 #include <smokey/smokey.h>
 #include <semaphore.h>
@@ -82,54 +83,54 @@ static inline bool ts_less(const struct xn_timespec64 *a,
 
 static int test_sc_cobalt_sem_timedwait64(void)
 {
-	long ret;
+	int ret;
 	sem_t sem;
-	int code = __xn_syscode(sc_cobalt_sem_timedwait64);
+	int sc_nr = sc_cobalt_sem_timedwait64;
 	struct xn_timespec64 ts64, ts_wu;
 	struct timespec ts_nat;
 
 	sem_init(&sem, 0, 0);
 
 	/* Make sure we don't crash because of NULL pointers */
-	ret = syscall(code, NULL, NULL);
-	if (ret == -1 && errno == ENOSYS) {
+	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
+	if (ret == -ENOSYS) {
 		smokey_note("sem_timedwait64: skipped. (no kernel support)");
 		return 0; // Not implemented, nothing to test, success
 	}
-	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EINVAL))
-		return errno;
+	if (!smokey_assert(ret == -EINVAL))
+		return ret;
 
 	/* Timeout is never read by the kernel, so NULL should be OK */
 	sem_post(&sem);
-	ret = syscall(code, &sem, NULL);
+	ret = XENOMAI_SYSCALL2(sc_nr, &sem, NULL);
 	if (!smokey_assert(!ret))
-		return errno;
+		return ret;
 
 	/*
 	 * The semaphore is already exhausted, so calling again will validate
 	 * the provided timeout now. Providing NULL has to deliver EFAULT
 	 */
-	ret = syscall(code, &sem, NULL);
-	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
-		return errno;
+	ret = XENOMAI_SYSCALL2(sc_nr, &sem, NULL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret;
 
 	/*
 	 * The semaphore is already exhausted, so calling again will validate
 	 * the provided timeout now. Providing an invalid adress has to deliver
 	 * EFAULT
 	 */
-	ret = syscall(code, &sem, (void*) 0xdeadbeefUL);
-	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
-		return errno;
+	ret = XENOMAI_SYSCALL2(sc_nr, &sem, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret;
 
 	/*
 	 * The semaphore is still exhausted, calling again will validate the
 	 * timeout, providing an invalid timeout has to deliver EINVAL
 	 */
 	ts64.tv_sec = -1;
-	ret = syscall(code, &sem, &ts64);
-	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EINVAL))
-		return errno;
+	ret = XENOMAI_SYSCALL2(sc_nr, &sem, &ts64);
+	if (!smokey_assert(ret == -EINVAL))
+		return ret;
 
 	/*
 	 * Providing a valid timeout, waiting for it to time out and check
@@ -137,19 +138,19 @@ static int test_sc_cobalt_sem_timedwait64(void)
 	 */
 	ret = clock_gettime(CLOCK_MONOTONIC, &ts_nat);
 	if (ret)
-		return errno;
+		return ret;
 
 	ts64.tv_sec = ts_nat.tv_sec;
 	ts64.tv_nsec = ts_nat.tv_nsec;
 	ts_add_ns(&ts64, 500000);
 
-	ret = syscall(code, &sem, &ts64);
-	if (!smokey_assert(ret == -1) || !smokey_assert(errno == ETIMEDOUT))
-		return errno;
+	ret = XENOMAI_SYSCALL2(sc_nr, &sem, &ts64);
+	if (!smokey_assert(ret == -ETIMEDOUT))
+		return ret;
 
 	ret = clock_gettime(CLOCK_MONOTONIC, &ts_nat);
 	if (ret)
-		return errno;
+		return ret;
 
 	ts_wu.tv_sec = ts_nat.tv_sec;
 	ts_wu.tv_nsec = ts_nat.tv_nsec;
-- 
2.31.1


