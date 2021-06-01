From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 3/6] y2038: testsuite/smokey/y2038: testcase for getres64
Date: Tue,  1 Jun 2021 15:31:21 +0200
Message-Id: <20210601133124.1466307-4-florian.bezdeka@siemens.com>
In-Reply-To: <20210601133124.1466307-1-florian.bezdeka@siemens.com>
References: <20210601133124.1466307-1-florian.bezdeka@siemens.com>
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
Cc: jan.kiszka@siemens.com, chensong <chensong@tj.kylinos.cn>, Florian Bezdeka <florian.bezdeka@siemens.com>

From: chensong <chensong@tj.kylinos.cn>

add test case for clock_getres64 in testsuite

Signed-off-by: chensong <chensong@tj.kylinos.cn>
[Florian: syscall()->XENOMAI_SYSCALLx(), fix test error handling]
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 54d529b6b..e08d13639 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -305,8 +305,40 @@ static int test_sc_cobalt_clock_nanosleep64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_clock_getres64(void)
+{
+	int ret;
+	int sc_nr = sc_cobalt_clock_getres64;
+	struct xn_timespec64 ts64;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("clock_getres64: skipped. (no kernel support)");
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
@@ -325,5 +357,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_clock_getres64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.31.1


