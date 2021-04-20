Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v2 3/3] y2038: testsuite/smokey/y2038: testcase for nanosleep64
Date: Tue, 20 Apr 2021 14:25:04 +0800
Message-Id: <1618899904-13929-1-git-send-email-chensong_2000@189.cn>
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

add test case for clock_nanosleep64 in testsuite

Signed-off-by: chensong <chensong@tj.kylinos.cn>

---
v2:
1, REALTIME --> MONOTONIC
2, more combinations
3, smokey warning in clock_gettime
4, remove magic number
---
 testsuite/smokey/y2038/syscall-tests.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 990e05c..0ea6ddd 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -228,6 +228,52 @@ static int test_sc_cobalt_clock_settime64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_clock_nanosleep64(void)
+{
+	long ret;
+	int code = __xn_syscode(sc_cobalt_clock_nanosleep64);
+	struct xn_timespec64 next, rmt;
+	struct timespec now;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = syscall(code, NULL, NULL, NULL, NULL);
+	if (ret == -1 && errno == ENOSYS) {
+		smokey_note("clock_nanosleep64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	/* Provide a valid 64bit timespec*/
+	ret = clock_gettime(CLOCK_MONOTONIC, &now);
+	if (ret) {
+		smokey_warning("clock_gettime failed in clock_nanosleep64.");
+		return errno;
+	}
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = syscall(code, CLOCK_MONOTONIC, TIMER_ABSTIME,
+				(void *)0xdeadbeefUL, &rmt);
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	next.tv_sec  = now.tv_sec + 1;
+	next.tv_nsec = now.tv_nsec;
+
+	ret = syscall(code, CLOCK_MONOTONIC, TIMER_ABSTIME,
+				&next, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	next.tv_sec  = next.tv_sec + 1;
+
+	ret = syscall(code, CLOCK_MONOTONIC, TIMER_ABSTIME, &next, &rmt);
+	if (!smokey_assert(!ret))
+		return errno;
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
@@ -244,5 +290,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_clock_nanosleep64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.7.4


