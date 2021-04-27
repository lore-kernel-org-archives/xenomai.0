Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 3/3] y2038: testsuite/smokey/y2038: testcase for getres64
Date: Tue, 27 Apr 2021 15:27:28 +0800
Message-Id: <1619508448-17174-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org
Cc: chensong <chensong@tj.kylinos.cn>

From: chensong <chensong@tj.kylinos.cn>

add test case for clock_getres64 in testsuite

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 testsuite/smokey/y2038/syscall-tests.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 5bbd35e..c59a9d6 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -296,8 +296,39 @@ static int test_sc_cobalt_clock_nanosleep64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_clock_getres64(void)
+{
+	long ret;
+	int code = __xn_syscode(sc_cobalt_clock_getres64);
+	struct xn_timespec64 ts64;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = syscall(code, NULL, NULL);
+	if (ret == -1 && errno == ENOSYS) {
+		smokey_note("clock_getres64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = syscall(code, CLOCK_MONOTONIC, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	/* Provide a valid 64bit timespec*/
+	ret = syscall(code, CLOCK_MONOTONIC, &ts64);
+	if (!smokey_assert(!ret))
+		return errno;
+	if (ts64.tv_sec != 0 || ts64.tv_nsec != 1)
+		smokey_warning("High resolution timers not available\n");
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
+
 	int ret;
 
 	ret = test_sc_cobalt_sem_timedwait64();
@@ -316,5 +347,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_clock_getres64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.7.4


