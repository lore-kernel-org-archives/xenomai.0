From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 6/6] y2038: testsuite/smokey/y2038: testcase for adjtime64
Date: Tue,  1 Jun 2021 15:31:24 +0200
Message-Id: <20210601133124.1466307-7-florian.bezdeka@siemens.com>
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

From: Song Chen <chensong_2000@189.cn>

add test case for clock_adjtime64 in testsuite

Signed-off-by: Song Chen <chensong_2000@189.cn>
[Florian: Fix test error handling, style fixes, fix failing test]
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index e08d13639..0e6b84f3f 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -28,6 +28,39 @@ struct xn_timespec64 {
 	int64_t tv_nsec;
 };
 
+struct xn_timex_timeval {
+	int64_t tv_sec;
+	int64_t	tv_usec;
+};
+
+struct xn_timex64 {
+	int32_t modes;		/* mode selector */
+				/* pad */
+	int64_t offset;		/* time offset (usec) */
+	int64_t freq;		/* frequency offset (scaled ppm) */
+	int64_t maxerror;	/* maximum error (usec) */
+	int64_t esterror;	/* estimated error (usec) */
+	int32_t status;		/* clock command/status */
+				/* pad */
+	int64_t constant;	/* pll time constant */
+	int64_t precision;	/* clock precision (usec) (read only) */
+	int64_t tolerance;	/* clock frequency tolerance (ppm) (read only) */
+	struct xn_timex_timeval time;	/* (read only, except for ADJ_SETOFFSET) */
+	int64_t tick;		/* (modified) usecs between clock ticks */
+
+	int64_t ppsfreq;	/* pps frequency (scaled ppm) (ro) */
+	int64_t jitter;		/* pps jitter (us) (ro) */
+	int32_t shift;		/* interval duration (s) (shift) (ro) */
+				/* pad */
+	int64_t stabil;		/* pps stability (scaled ppm) (ro) */
+	int64_t jitcnt;		/* jitter limit exceeded (ro) */
+	int64_t calcnt;		/* calibration intervals (ro) */
+	int64_t errcnt;		/* calibration errors (ro) */
+	int64_t stbcnt;		/* stability limit exceeded (ro) */
+
+	int32_t tai;		/* TAI offset (ro) */
+};
+
 #define NSEC_PER_SEC 1000000000
 
 static void ts_normalise(struct xn_timespec64 *ts)
@@ -336,6 +369,38 @@ static int test_sc_cobalt_clock_getres64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_clock_adjtime64(void)
+{
+	int ret;
+	int sc_nr = sc_cobalt_clock_adjtime64;
+	struct xn_timex64 tx64 = {};
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("clock_adjtime64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = XENOMAI_SYSCALL2(sc_nr, CLOCK_REALTIME, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/* Provide a valid 64bit timex */
+	tx64.modes = ADJ_SETOFFSET;
+	tx64.time.tv_usec = 123;
+	ret = XENOMAI_SYSCALL2(sc_nr, CLOCK_REALTIME, &tx64);
+
+	/* adjtime is supported for external clocks only, expect EOPNOTSUPP */
+	if (!smokey_assert(ret == -EOPNOTSUPP))
+		return ret ? ret : -EINVAL;
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 
@@ -361,5 +426,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_clock_adjtime64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.31.1


