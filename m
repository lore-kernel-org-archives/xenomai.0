From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 1/2] smokey/rtdm: account for device teardown
Date: Fri, 20 Sep 2019 19:00:36 +0200
Message-Id: <20190920170037.6861-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Since recently, RTDM forcibly disconnects files from a device being
unregistered. This has to change the expectations the smokey test may
have about the rmmod logic.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 testsuite/smokey/rtdm/rtdm.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/testsuite/smokey/rtdm/rtdm.c b/testsuite/smokey/rtdm/rtdm.c
index e8056beb1..187333770 100644
--- a/testsuite/smokey/rtdm/rtdm.c
+++ b/testsuite/smokey/rtdm/rtdm.c
@@ -55,21 +55,6 @@ static void check_inner(const char *fn, int line, const char *msg,
 	__status;							\
 })
 
-static void check_sleep_inner(const char *fn, int line,
-			      const char *msg, unsigned long long start)
-{
-	unsigned long long diff = timer_tsc2ns(timer_get_tsc() - start);
-
-	if (diff < 300 * NS_PER_MS) {
-		fprintf(stderr, "FAILED %s:%d: %s waited only %Ld.%06u ms\n",
-			fn, line, msg, diff / 1000000,
-			(unsigned)(diff % 1000000));
-		exit(EXIT_FAILURE);
-	}
-}
-#define check_sleep(msg, start) \
-	check_sleep_inner(__func__, __LINE__, msg, start)
-
 static const char *devname = "/dev/rtdm/rtdm0";
 static const char *devname2 = "/dev/rtdm/rtdm1";
 
@@ -166,7 +151,6 @@ static int test_handover(int fd)
 
 static int run_rtdm(struct smokey_test *t, int argc, char *const argv[])
 {
-	unsigned long long start;
 	int dev, dev2, status;
 
 	status = system("modprobe -q xeno_rtdmtest");
@@ -194,7 +178,6 @@ static int run_rtdm(struct smokey_test *t, int argc, char *const argv[])
 	smokey_trace("Defer close by pending reference");
 	check("ioctl", ioctl(dev, RTTST_RTIOC_RTDM_DEFER_CLOSE,
 			     RTTST_RTDM_DEFER_CLOSE_CONTEXT), 0);
-	start = timer_get_tsc();
 	check("close", close(dev), 0);
 	check("open", open(devname, O_RDWR), -EBUSY);
 	dev2 = check("open", open(devname2, O_RDWR), dev);
@@ -208,13 +191,11 @@ static int run_rtdm(struct smokey_test *t, int argc, char *const argv[])
 	check("close", close(dev), 0);
 	dev = check("open", open(devname, O_RDWR), dev);
 
-	smokey_trace("Deferred module unload");
+	smokey_trace("Disconnect on module unload");
 	check("ioctl", ioctl(dev, RTTST_RTIOC_RTDM_DEFER_CLOSE,
 			     RTTST_RTDM_DEFER_CLOSE_CONTEXT), 0);
-	start = timer_get_tsc();
 	check("close", close(dev), 0);
 	check("rmmod", system("rmmod xeno_rtdmtest"), 0);
-	check_sleep("rmmod", start);
 
 	return 0;
 }
-- 
2.21.0


