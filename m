From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 3/3] y2038: testsuite/smokey/y2038: testcase for nanosleep64
Date: Wed, 31 Mar 2021 11:26:28 +0800
Message-Id: <1617161188-27230-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org, rpm@xenomai.org

add test case for clock_nanosleep64 in testsuite

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 testsuite/smokey/y2038/syscall-tests.c | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 03a3198..affbb2d 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -226,6 +226,67 @@ static int test_sc_cobalt_clock_settime64(void)
 	return 0;
 }
 
+static inline int64_t calcdiff(struct timespec t1, struct xn_timespec64 t2)
+{
+	struct timespec r;
+
+	r.tv_sec = t1.tv_sec - t2.tv_sec;
+	r.tv_nsec = t1.tv_nsec - t2.tv_nsec;
+	if (r.tv_nsec < 0) {
+		r.tv_sec--;
+		r.tv_nsec += NSEC_PER_SEC;
+	}
+
+	return (r.tv_sec * NSEC_PER_SEC + r.tv_nsec) / 1000;
+}
+
+static int test_sc_cobalt_clock_nanosleep64(void)
+{
+	long ret;
+	int code = __xn_syscode(sc_cobalt_clock_nanosleep64);
+	struct xn_timespec64 next;
+	struct timespec now;
+	int64_t diff;
+	int64_t threshold = 500;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = syscall(code, NULL, NULL, NULL);
+	if (ret == -1 && errno == ENOSYS) {
+		smokey_note("clock_nanosleep64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = syscall(code, CLOCK_MONOTONIC, (void *)0xdeadbeefUL,
+				(void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
+		return errno;
+
+	/* Provide an valid 64bit timespec*/
+	ret = clock_gettime(CLOCK_REALTIME, &now);
+	if (ret)
+		return errno;
+
+	next.tv_sec  = now.tv_sec + 1;
+	next.tv_nsec = now.tv_nsec;
+
+	ret = syscall(code, CLOCK_REALTIME, TIMER_ABSTIME, &next, NULL);
+	if (!smokey_assert(!ret))
+		return errno;
+
+	ret = clock_gettime(CLOCK_REALTIME, &now);
+	if (ret)
+		return errno;
+
+	diff = calcdiff(now, next);
+	if (diff > threshold)
+		smokey_warning("clock_nanosleep64, latency is %dus\n");
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
@@ -242,5 +303,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
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




