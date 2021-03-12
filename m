From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH v2 5/5] [y2038] testsuite: smokey: y2038: testcase for
 settime64 and gettime64
Date: Fri, 12 Mar 2021 12:02:14 +0800
Message-Id: <1615521734-5989-1-git-send-email-chensong@tj.kylinos.cn>
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
 testsuite/smokey/y2038/syscall-tests.c | 114 +++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 5 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 1d61bbd..3634d68 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -17,6 +17,37 @@
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
+
+#define RUN_TEST(name) test_ ## name
+typedef int (*testee_func)(void);
+struct testee_info {
+	char *name;
+	testee_func func;
+	bool risky;
+};
+
+static int test_sc_cobalt_sem_timedwait64(void);
+static int test_sc_cobalt_clock_set_gettime64(void);
+
+#define TESTEE_TABLE_COUNT 32
+static struct testee_info testee_table[TESTEE_TABLE_COUNT] = {
+	{
+		.name = "sc_cobalt_sem_timedwait64",
+		.func = RUN_TEST(sc_cobalt_sem_timedwait64),
+		.risky = false,
+	},
+	{
+		.name = "sc_cobalt_clock_set_gettime64",
+		.func = RUN_TEST(sc_cobalt_clock_set_gettime64),
+		.risky = false,
+	},
+	{
+		.name = NULL,
+		.func = NULL,
+		.risky = false,
+	},
+};
+
 /*
  * libc independent data type representing a time64_t based struct timespec
  */
@@ -25,7 +56,8 @@ struct xn_timespec64 {
 	int64_t tv_nsec;
 };
 
-#define NSEC_PER_SEC 1000000000
+#define NSEC_PER_SEC		1000000000
+#define USEC_PER_SEC		1000000
 
 static void ts_normalise(struct xn_timespec64 *ts)
 {
@@ -117,7 +149,7 @@ static int test_sc_cobalt_sem_timedwait64(void)
 	 * the provided timeout now. Providing an invalid adress has to deliver
 	 * EFAULT
 	 */
-	ret = syscall(code, &sem, (void*) 0xdeadbeefUL);
+	ret = syscall(code, &sem, (void *)0xdeadbeefUL);
 	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
 		return errno;
 
@@ -163,13 +195,85 @@ static int test_sc_cobalt_sem_timedwait64(void)
 	return 0;
 }
 
+static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
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
+	return r.tv_sec * NSEC_PER_SEC + r.tv_nsec;
+}
+
+static inline int64_t calcdiff(struct timespec t1, struct timespec t2)
+{
+	return calcdiff_ns(t1, t2) / NSEC_PER_SEC;
+}
+
+static int test_sc_cobalt_clock_set_gettime64(void)
+{
+	long ret;
+	struct timespec now, after;
+	uint64_t diff;
+	int cset = __xn_syscode(sc_cobalt_clock_settime64);
+	int cget = __xn_syscode(sc_cobalt_clock_gettime64);
+
+
+	/*get current time*/
+	ret = syscall(cget, CLOCK_REALTIME, &now);
+	if (ret)
+		return errno;
+
+	after.tv_sec = now.tv_sec + 10;
+	after.tv_nsec = 0;
+
+	/*
+	 * set time 10 seconds later
+	 * or go to 0xffffffff to trigger y2038,
+	 * but be cautious, it has impact to
+	 * the device you are working on.
+	 */
+	ret = syscall(cset, CLOCK_REALTIME, &after);
+	if (ret)
+		return errno;
+
+	/*get time again*/
+	ret = syscall(cget, CLOCK_REALTIME, &after);
+	if (ret)
+		return errno;
+
+	/*compare*/
+	diff = calcdiff(after, now);
+	if (diff != 10)
+		smokey_warning("clock_gettime64 is imprecise!\n");
+
+	/*set time back*/
+	ret = syscall(cset, CLOCK_REALTIME, &now);
+	if (ret)
+		return errno;
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
+	struct testee_info *p = testee_table;
 
-	ret = test_sc_cobalt_sem_timedwait64();
-	if (ret)
-		return ret;
+	while (p->name != NULL) {
+
+		if (p->risky == false) {
+			ret = p->func();
+			if (ret)
+				smokey_warning("%s failed\n", p->name);
+		}
+
+		p++;
+	}
 
 	return 0;
 }
-- 
2.7.4




