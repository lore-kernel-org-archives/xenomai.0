Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 3/3] y2038: testsuite/smokey/y2038: testcase for adjtime64
Date: Thu, 29 Apr 2021 15:45:20 +0800
Message-Id: <1619682320-16309-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

add test case for clock_adjtime64 in testsuite

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 testsuite/smokey/y2038/syscall-tests.c | 71 ++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index c59a9d6..22fd9b6 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -25,6 +25,43 @@ struct xn_timespec64 {
 	int64_t tv_nsec;
 };
 
+struct xn_timex_timeval {
+	int64_t tv_sec;
+	int64_t	tv_usec;
+};
+
+struct xn_timex64 {
+	unsigned int modes;	/* mode selector */
+	int:32;            /* pad */
+	long long offset;	/* time offset (usec) */
+	long long freq;	/* frequency offset (scaled ppm) */
+	long long maxerror;/* maximum error (usec) */
+	long long esterror;/* estimated error (usec) */
+	int status;		/* clock command/status */
+	int:32;            /* pad */
+	long long constant;/* pll time constant */
+	long long precision;/* clock precision (usec) (read only) */
+	long long tolerance;/* clock frequency tolerance (ppm) (read only) */
+	struct xn_timex_timeval time;	/* (read only, except for ADJ_SETOFFSET) */
+	long long tick;	/* (modified) usecs between clock ticks */
+
+	long long ppsfreq;/* pps frequency (scaled ppm) (ro) */
+	long long jitter; /* pps jitter (us) (ro) */
+	int shift;              /* interval duration (s) (shift) (ro) */
+	int:32;            /* pad */
+	long long stabil;            /* pps stability (scaled ppm) (ro) */
+	long long jitcnt; /* jitter limit exceeded (ro) */
+	long long calcnt; /* calibration intervals (ro) */
+	long long errcnt; /* calibration errors (ro) */
+	long long stbcnt; /* stability limit exceeded (ro) */
+
+	int tai;		/* TAI offset (ro) */
+
+	int:32; int:32; int:32; int:32;
+	int:32; int:32; int:32; int:32;
+	int:32; int:32; int:32;
+};
+
 #define NSEC_PER_SEC 1000000000
 
 static void ts_normalise(struct xn_timespec64 *ts)
@@ -326,6 +363,36 @@ static int test_sc_cobalt_clock_getres64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_clock_adjtime64(void)
+{
+	long ret;
+	int code = __xn_syscode(sc_cobalt_clock_adjtime64);
+	struct xn_timex64 tx64 = {};
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = syscall(code, NULL, NULL);
+	if (ret == -1 && errno == ENOSYS) {
+		smokey_note("clock_adjtime64: skipped. (no kernel support)");
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
+	/* Provide a valid 64bit timex*/
+	tx64.modes = ADJ_SETOFFSET;
+	tx64.time.tv_usec = 123;
+	ret = syscall(code, CLOCK_REALTIME, &tx64);
+	if (!smokey_assert(!ret))
+		return errno;
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 
@@ -351,5 +418,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_clock_adjtime64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.7.4


