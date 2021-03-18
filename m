From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH v3 5/5] y2038: testsuite/smokey/y2038: testcase for settime64
 and gettime64
Date: Thu, 18 Mar 2021 15:36:18 +0800
Message-Id: <1616052978-22093-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org, rpm@xenomai.org

new test case for clock_settime64 and clock_gettime64 and reorganize
run_2038.

If you want to trigger and verify y2038 problem, please be careful and
make sure it has no impact to your test device.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 testsuite/smokey/y2038/syscall-tests.c | 115 +++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 6 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 1d61bbd..89e7d47 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -17,6 +17,38 @@
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
+
+#define RUN_TEST(name) test_ ## name
+typedef int (*testee_func)(void);
+struct testee_info {
+	char *name;
+	testee_func func;
+};
+
+static int test_sc_cobalt_sem_timedwait64(void);
+static int test_sc_cobalt_clock_gettime64(void);
+static int test_sc_cobalt_clock_settime64(void);
+
+#define TESTEE_TABLE_COUNT 32
+static struct testee_info testee_table[TESTEE_TABLE_COUNT] = {
+	{
+		.name = "sc_cobalt_sem_timedwait64",
+		.func = RUN_TEST(sc_cobalt_sem_timedwait64),
+	},
+	{
+		.name = "sc_cobalt_clock_gettime64",
+		.func = RUN_TEST(sc_cobalt_clock_gettime64),
+	},
+	{
+		.name = "sc_cobalt_clock_settime64",
+		.func = RUN_TEST(sc_cobalt_clock_settime64),
+	},
+	{
+		.name = NULL,
+		.func = NULL,
+	},
+};
+
 /*
  * libc independent data type representing a time64_t based struct timespec
  */
@@ -25,7 +57,8 @@ struct xn_timespec64 {
 	int64_t tv_nsec;
 };
 
-#define NSEC_PER_SEC 1000000000
+#define NSEC_PER_SEC		1000000000
+#define USEC_PER_SEC		1000000
 
 static void ts_normalise(struct xn_timespec64 *ts)
 {
@@ -114,10 +147,10 @@ static int test_sc_cobalt_sem_timedwait64(void)
 
 	/*
 	 * The semaphore is already exhausted, so calling again will validate
-	 * the provided timeout now. Providing an invalid adress has to deliver
+	 * the provided timeout now. Providing an invalid address has to deliver
 	 * EFAULT
 	 */
-	ret = syscall(code, &sem, (void*) 0xdeadbeefUL);
+	ret = syscall(code, &sem, (void *)0xdeadbeefUL);
 	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
 		return errno;
 
@@ -163,13 +196,83 @@ static int test_sc_cobalt_sem_timedwait64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_clock_gettime64(void)
+{
+	long ret;
+	int code = __xn_syscode(sc_cobalt_clock_gettime64);
+	struct xn_timespec64 ts64;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = syscall(code, NULL, NULL);
+	if (ret == -1 && errno == ENOSYS) {
+		smokey_note("clock_gettime64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EINVAL))
+		return errno;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = syscall(code, CLOCK_REALTIME, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	/* Provide a valid 64bit timespec*/
+	ret = syscall(code, CLOCK_REALTIME, &ts64);
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	return 0;
+}
+
+static int test_sc_cobalt_clock_settime64(void)
+{
+	long ret;
+	int code = __xn_syscode(sc_cobalt_clock_settime64);
+	struct xn_timespec64 ts64;
+	struct timespec now;
+
+	/*Get current time and set it back at the end of the test*/
+	clock_gettime(CLOCK_REALTIME, &now);
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = syscall(code, NULL, NULL);
+	if (ret == -1 && errno == ENOSYS) {
+		smokey_note("clock_settime64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EINVAL))
+		goto out;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = syscall(code, CLOCK_REALTIME, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		goto out;
+
+	/* Provide a valid 64bit timespec*/
+	ts64.tv_sec  = now.tv_sec;
+	ts64.tv_nsec = now.tv_nsec;
+	ret = syscall(code, CLOCK_REALTIME, &ts64);
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		goto out;
+
+out:
+	clock_settime(CLOCK_REALTIME, &now);
+	return errno;
+}
+
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
+	struct testee_info *p = testee_table;
 
-	ret = test_sc_cobalt_sem_timedwait64();
-	if (ret)
-		return ret;
+	while (p->name != NULL) {
+		ret = p->func();
+		if (ret)
+			smokey_warning("%s failed, errno is %d\n", p->name, ret);
+
+		p++;
+	}
 
 	return 0;
 }
-- 
2.7.4




