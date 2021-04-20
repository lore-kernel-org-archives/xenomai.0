Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v5 5/5] y2038: testsuite/smokey/y2038: testcase for settime64
 and gettime64
Date: Tue, 20 Apr 2021 14:23:25 +0800
Message-Id: <1618899805-13799-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, florian.bezdeka@siemens.com
Cc: chensong <chensong@tj.kylinos.cn>

From: chensong <chensong@tj.kylinos.cn>

new test case for clock_settime64 and clock_gettime64 and reorganize
run_2038.

If you want to trigger and verify y2038 problem, please be careful and
make sure it has no impact to your test device.

Signed-off-by: chensong <chensong@tj.kylinos.cn>

---
v3:
1, rename structs, variables
2, reorganize registration in run_y2038
3, remove unnecessary definitions

v4:
1, return run_y2038 to its original approach

v5:
1, smokey warning when clock_getime failed
---
 testsuite/smokey/y2038/syscall-tests.c | 77 +++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 1d61bbd..990e05c 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -114,10 +114,10 @@ static int test_sc_cobalt_sem_timedwait64(void)
 
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
 
@@ -163,6 +163,71 @@ static int test_sc_cobalt_sem_timedwait64(void)
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
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = syscall(code, CLOCK_REALTIME, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	/* Provide a valid 64bit timespec*/
+	ret = syscall(code, CLOCK_REALTIME, &ts64);
+	if (!smokey_assert(!ret))
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
+	/* Make sure we don't crash because of NULL pointers */
+	ret = syscall(code, NULL, NULL);
+	if (ret == -1 && errno == ENOSYS) {
+		smokey_note("clock_settime64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = syscall(code, CLOCK_REALTIME, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	/* Provide a valid 64bit timespec*/
+	ret = clock_gettime(CLOCK_REALTIME, &now);
+	if (ret) {
+		smokey_warning("clock_gettime failed in cloc_settime64.");
+		return errno;
+	}
+
+	ts64.tv_sec  = now.tv_sec;
+	ts64.tv_nsec = now.tv_nsec;
+	ret = syscall(code, CLOCK_REALTIME, &ts64);
+	if (!smokey_assert(!ret))
+		return errno;
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
@@ -171,5 +236,13 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_clock_gettime64();
+	if (ret)
+		return ret;
+
+	ret = test_sc_cobalt_clock_settime64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.7.4


