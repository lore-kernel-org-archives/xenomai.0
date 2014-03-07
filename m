From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Fri,  7 Mar 2014 21:20:35 +0100
Message-Id: <1394223638-13070-6-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <531A29CC.4040201@xenomai.org>
 <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 6/9] drivers/testing: adapt rtdmtest after RTDM
	changes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 include/rtdm/uapi/testing.h       |    3 +--
 kernel/drivers/testing/rtdmtest.c |   54 ++++++++++++-------------------------
 testsuite/unit/rtdm.c             |   11 --------
 3 files changed, 18 insertions(+), 50 deletions(-)

diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
index 87a97fd..76d9678 100644
--- a/include/rtdm/uapi/testing.h
+++ b/include/rtdm/uapi/testing.h
@@ -103,8 +103,7 @@ struct rttst_swtest_error {
 };
 
 #define RTTST_RTDM_NORMAL_CLOSE		0
-#define RTTST_RTDM_DEFER_CLOSE_HANDLER	1
-#define RTTST_RTDM_DEFER_CLOSE_CONTEXT	2
+#define RTTST_RTDM_DEFER_CLOSE_CONTEXT	1
 
 #define RTIOC_TYPE_TESTING		RTDM_CLASS_TESTING
 
diff --git a/kernel/drivers/testing/rtdmtest.c b/kernel/drivers/testing/rtdmtest.c
index c107d07..ddb8786 100644
--- a/kernel/drivers/testing/rtdmtest.c
+++ b/kernel/drivers/testing/rtdmtest.c
@@ -48,11 +48,9 @@ static void close_timer_proc(rtdm_timer_t *timer)
 	rtdm_context_unlock(rtdm_private_to_context(ctx));
 }
 
-static int rtdm_test_open(struct rtdm_dev_context *context,
-			  rtdm_user_info_t *user_info, int oflags)
+static int rtdm_test_open(struct rtdm_fd *context, int oflags)
 {
-	struct rtdm_test_context *ctx =
-		(struct rtdm_test_context *)context->dev_private;
+	struct rtdm_test_context *ctx = rtdm_context_to_private(context);
 
 	rtdm_timer_init(&ctx->close_timer, close_timer_proc,
 			"rtdm close test");
@@ -62,60 +60,42 @@ static int rtdm_test_open(struct rtdm_dev_context *context,
 	return 0;
 }
 
-static int rtdm_test_close(struct rtdm_dev_context *context,
-			   rtdm_user_info_t *user_info)
+static void rtdm_test_close(struct rtdm_fd *context)
 {
-	struct rtdm_test_context *ctx =
-		(struct rtdm_test_context *)context->dev_private;
+	struct rtdm_test_context *ctx = rtdm_context_to_private(context);
 
 	ctx->close_counter++;
 
 	switch (ctx->close_deferral) {
-	case RTTST_RTDM_DEFER_CLOSE_HANDLER:
-		if (ctx->close_counter <= 3)
-			return -EAGAIN;
-		if (ctx->close_counter > 4) {
-			printk(KERN_ERR
-			       "rtdmtest: %s: close_counter is %lu, "
-			       "should be 2!\n",
-			       __FUNCTION__, ctx->close_counter);
-			return 0;
-		}
-		break;
-
 	case RTTST_RTDM_DEFER_CLOSE_CONTEXT:
-		if (ctx->close_counter == 1) {
-			rtdm_context_lock(context);
-			rtdm_timer_start(&ctx->close_timer, 300000000ULL, 0,
-					 RTDM_TIMERMODE_RELATIVE);
-			return 0;
-		}
-		if (ctx->close_counter > 2) {
+		if (ctx->close_counter != 2) {
 			printk(KERN_ERR
 			       "rtdmtest: %s: close_counter is %lu, "
 			       "should be 2!\n",
 			       __FUNCTION__, ctx->close_counter);
-			return 0;
+			return;
 		}
 		break;
 	}
 
 	rtdm_timer_destroy(&ctx->close_timer);
-
-	return 0;
 }
 
-static int rtdm_test_ioctl(struct rtdm_dev_context *context,
-			   rtdm_user_info_t *user_info,
-			   unsigned int request, void __user *arg)
+static int 
+rtdm_test_ioctl(struct rtdm_fd *context, unsigned int request, void __user *arg)
 {
-	struct rtdm_test_context *ctx =
-		(struct rtdm_test_context *)context->dev_private;
+	struct rtdm_test_context *ctx = rtdm_context_to_private(context);
 	int err = 0;
 
 	switch (request) {
 	case RTTST_RTIOC_RTDM_DEFER_CLOSE:
 		ctx->close_deferral = (unsigned long)arg;
+		if (ctx->close_deferral == RTTST_RTDM_DEFER_CLOSE_CONTEXT) {
+			++ctx->close_counter;
+			rtdm_context_lock(context);
+			rtdm_timer_start(&ctx->close_timer, 300000000ULL, 0,
+					RTDM_TIMERMODE_RELATIVE);
+		}
 		break;
 
 	default:
@@ -132,10 +112,10 @@ static struct rtdm_device device[2] = { [0 ... 1] = {
 	.context_size		= sizeof(struct rtdm_test_context),
 	.device_name		= "",
 
-	.open_nrt		= rtdm_test_open,
+	.open			= rtdm_test_open,
 
 	.ops = {
-		.close_nrt	= rtdm_test_close,
+		.close		= rtdm_test_close,
 
 		.ioctl_rt	= rtdm_test_ioctl,
 		.ioctl_nrt	= rtdm_test_ioctl,
diff --git a/testsuite/unit/rtdm.c b/testsuite/unit/rtdm.c
index ba39ab8..890badd 100644
--- a/testsuite/unit/rtdm.c
+++ b/testsuite/unit/rtdm.c
@@ -75,17 +75,6 @@ int main(int argc, const char *argv[])
 	dev2 = check("open", open(devname2, O_RDWR), dev + 1);
 	check("close", close(dev2), 0);
 
-	printf("Defer close by driver handler\n");
-	check("ioctl", ioctl(dev, RTTST_RTIOC_RTDM_DEFER_CLOSE,
-			     RTTST_RTDM_DEFER_CLOSE_HANDLER), 0);
-	start = rt_timer_tsc();
-	check("close", close(dev), 0);
-	check("open", open(devname, O_RDWR), -EBUSY);
-	dev2 = check("open", open(devname2, O_RDWR), dev);
-	check("close", close(dev2), 0);
-	usleep(300000);
-	dev = check("open", open(devname, O_RDWR), dev);
-
 	printf("Defer close by pending reference\n");
 	check("ioctl", ioctl(dev, RTTST_RTIOC_RTDM_DEFER_CLOSE,
 			     RTTST_RTDM_DEFER_CLOSE_CONTEXT), 0);
-- 
1.7.10.4


