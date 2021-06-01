From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 6/9] y2038: testsuite/smokey/y2038: testcase for settime64 and
 gettime64
Date: Tue,  1 Jun 2021 11:43:31 +0200
Message-Id: <20210601094334.774394-7-florian.bezdeka@siemens.com>
In-Reply-To: <20210601094334.774394-1-florian.bezdeka@siemens.com>
References: <20210601094334.774394-1-florian.bezdeka@siemens.com>
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
To: xenomai@xenomai.org
Cc: jan.kiszka@siemens.com, chensong@tj.kylinos.cn, Florian Bezdeka <florian.bezdeka@siemens.com>

From: chensong <chensong@tj.kylinos.cn>

Adding new test cases for clock_settime64 and clock_gettime64.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
[Florian: Rebased on top of next, test improvements, reword commit msg]
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 84 ++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 716be4f2a..840be89a5 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -166,6 +166,82 @@ static int test_sc_cobalt_sem_timedwait64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_clock_gettime64(void)
+{
+	int ret;
+	int sc_nr = sc_cobalt_clock_gettime64;
+	struct xn_timespec64 ts64 = {0};
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("clock_gettime64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = XENOMAI_SYSCALL2(sc_nr, CLOCK_MONOTONIC, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/* Provide a valid 64bit timespec */
+	ret = XENOMAI_SYSCALL2(sc_nr, CLOCK_MONOTONIC, &ts64);
+	if (!smokey_assert(!ret))
+		return ret ? ret : -EINVAL;
+
+	/* Validate seconds only, nanoseconds might still be zero */
+	smokey_assert(ts64.tv_sec != 0);
+
+	return 0;
+}
+
+static int test_sc_cobalt_clock_settime64(void)
+{
+	int ret;
+	int sc_nr = sc_cobalt_clock_settime64;
+	struct xn_timespec64 ts64, now64;
+	struct timespec now;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("clock_settime64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = XENOMAI_SYSCALL2(sc_nr, CLOCK_MONOTONIC, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	ret = clock_gettime(CLOCK_REALTIME, &now);
+	if (ret)
+		return -errno;
+
+	/* Provide a valid 64bit timespec */
+	ts64.tv_sec  = now.tv_sec + 1;
+	ts64.tv_nsec = now.tv_nsec;
+	ret = XENOMAI_SYSCALL2(sc_nr, CLOCK_REALTIME, &ts64);
+	if (!smokey_assert(!ret))
+		return ret ? ret : -EINVAL;
+
+	ret = clock_gettime(CLOCK_REALTIME, &now);
+	if (ret)
+		return -errno;
+
+	now64.tv_sec = now.tv_sec;
+	now64.tv_nsec = now.tv_nsec;
+
+	if (ts_less(&now64, &ts64))
+		smokey_warning("clock_settime() reported no error but no new time seen");
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
@@ -174,5 +250,13 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
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
2.31.1


