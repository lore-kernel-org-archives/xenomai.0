From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Fri,  7 Mar 2014 21:20:34 +0100
Message-Id: <1394223638-13070-5-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <531A29CC.4040201@xenomai.org>
 <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 5/9] drivers/testing: adapt switchtest after RTDM
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
 kernel/drivers/testing/switchtest.c |  111 ++++++++++++++---------------------
 1 file changed, 45 insertions(+), 66 deletions(-)

diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index f48c4e2..d88625b 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -511,11 +511,9 @@ static void rtswitch_utask_waker(rtdm_nrtsig_t sig, void *arg)
 	up(&ctx->utask->nrt_synch);
 }
 
-static int rtswitch_open(struct rtdm_dev_context *context,
-			 rtdm_user_info_t *user_info,
-			 int oflags)
+static int rtswitch_open(struct rtdm_fd *context, int oflags)
 {
-	rtswitch_context_t *ctx = (rtswitch_context_t *) context->dev_private;
+	rtswitch_context_t *ctx = rtdm_context_to_private(context);
 	int err;
 
 	ctx->tasks = NULL;
@@ -534,10 +532,9 @@ static int rtswitch_open(struct rtdm_dev_context *context,
 	return 0;
 }
 
-static int rtswitch_close(struct rtdm_dev_context *context,
-			  rtdm_user_info_t *user_info)
+static void rtswitch_close(struct rtdm_fd *context)
 {
-	rtswitch_context_t *ctx = (rtswitch_context_t *) context->dev_private;
+	rtswitch_context_t *ctx = rtdm_context_to_private(context);
 	unsigned i;
 
 	if (ctx->tasks) {
@@ -556,16 +553,13 @@ static int rtswitch_close(struct rtdm_dev_context *context,
 	}
 	rtdm_timer_destroy(&ctx->wake_up_delay);
 	rtdm_nrtsig_destroy(&ctx->wake_utask);
-
-	return 0;
 }
 
-static int rtswitch_ioctl_nrt(struct rtdm_dev_context *context,
-			      rtdm_user_info_t *user_info,
+static int rtswitch_ioctl_nrt(struct rtdm_fd *context,
 			      unsigned int request,
 			      void *arg)
 {
-	rtswitch_context_t *ctx = (rtswitch_context_t *) context->dev_private;
+	rtswitch_context_t *ctx = rtdm_context_to_private(context);
 	struct rttst_swtest_task task;
 	struct rttst_swtest_dir fromto;
 	unsigned long count;
@@ -588,15 +582,15 @@ static int rtswitch_ioctl_nrt(struct rtdm_dev_context *context,
 		return 0;
 
 	case RTTST_RTIOC_SWTEST_REGISTER_UTASK:
-		if (!rtdm_rw_user_ok(user_info, arg, sizeof(task)))
+		if (!rtdm_rw_user_ok(context, arg, sizeof(task)))
 			return -EFAULT;
 
-		rtdm_copy_from_user(user_info, &task, arg, sizeof(task));
+		rtdm_copy_from_user(context, &task, arg, sizeof(task));
 
 		err = rtswitch_register_task(ctx, &task);
 
 		if (!err)
-			rtdm_copy_to_user(user_info,
+			rtdm_copy_to_user(context,
 					  arg,
 					  &task,
 					  sizeof(task));
@@ -604,15 +598,15 @@ static int rtswitch_ioctl_nrt(struct rtdm_dev_context *context,
 		return err;
 
 	case RTTST_RTIOC_SWTEST_CREATE_KTASK:
-		if (!rtdm_rw_user_ok(user_info, arg, sizeof(task)))
+		if (!rtdm_rw_user_ok(context, arg, sizeof(task)))
 			return -EFAULT;
 
-		rtdm_copy_from_user(user_info, &task, arg, sizeof(task));
+		rtdm_copy_from_user(context, &task, arg, sizeof(task));
 
 		err = rtswitch_create_ktask(ctx, &task);
 
 		if (!err)
-			rtdm_copy_to_user(user_info,
+			rtdm_copy_to_user(context,
 					  arg,
 					  &task,
 					  sizeof(task));
@@ -620,18 +614,18 @@ static int rtswitch_ioctl_nrt(struct rtdm_dev_context *context,
 		return err;
 
 	case RTTST_RTIOC_SWTEST_PEND:
-		if (!rtdm_read_user_ok(user_info, arg, sizeof(task)))
+		if (!rtdm_read_user_ok(context, arg, sizeof(task)))
 			return -EFAULT;
 
-		rtdm_copy_from_user(user_info, &task, arg, sizeof(task));
+		rtdm_copy_from_user(context, &task, arg, sizeof(task));
 
 		return rtswitch_pend_nrt(ctx, task.index);
 
 	case RTTST_RTIOC_SWTEST_SWITCH_TO:
-		if (!rtdm_read_user_ok(user_info, arg, sizeof(fromto)))
+		if (!rtdm_read_user_ok(context, arg, sizeof(fromto)))
 			return -EFAULT;
 
-		rtdm_copy_from_user(user_info,
+		rtdm_copy_from_user(context,
 				    &fromto,
 				    arg,
 				    sizeof(fromto));
@@ -639,20 +633,20 @@ static int rtswitch_ioctl_nrt(struct rtdm_dev_context *context,
 		return rtswitch_to_nrt(ctx, fromto.from, fromto.to);
 
 	case RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT:
-		if (!rtdm_rw_user_ok(user_info, arg, sizeof(count)))
+		if (!rtdm_rw_user_ok(context, arg, sizeof(count)))
 			return -EFAULT;
 
 		count = ctx->switches_count;
 
-		rtdm_copy_to_user(user_info, arg, &count, sizeof(count));
+		rtdm_copy_to_user(context, arg, &count, sizeof(count));
 
 		return 0;
 
 	case RTTST_RTIOC_SWTEST_GET_LAST_ERROR:
-		if (!rtdm_rw_user_ok(user_info, arg, sizeof(ctx->error)))
+		if (!rtdm_rw_user_ok(context, arg, sizeof(ctx->error)))
 			return -EFAULT;
 
-		rtdm_copy_to_user(user_info,
+		rtdm_copy_to_user(context,
 				  arg,
 				  &ctx->error,
 				  sizeof(ctx->error));
@@ -664,12 +658,11 @@ static int rtswitch_ioctl_nrt(struct rtdm_dev_context *context,
 	}
 }
 
-static int rtswitch_ioctl_rt(struct rtdm_dev_context *context,
-			     rtdm_user_info_t *user_info,
+static int rtswitch_ioctl_rt(struct rtdm_fd *context,
 			     unsigned int request,
 			     void *arg)
 {
-	rtswitch_context_t *ctx = (rtswitch_context_t *) context->dev_private;
+	rtswitch_context_t *ctx = rtdm_context_to_private(context);
 	struct rttst_swtest_task task;
 	struct rttst_swtest_dir fromto;
 
@@ -680,18 +673,18 @@ static int rtswitch_ioctl_rt(struct rtdm_dev_context *context,
 		return -ENOSYS;
 
 	case RTTST_RTIOC_SWTEST_PEND:
-		if (!rtdm_read_user_ok(user_info, arg, sizeof(task)))
+		if (!rtdm_read_user_ok(context, arg, sizeof(task)))
 			return -EFAULT;
 
-		rtdm_copy_from_user(user_info, &task, arg, sizeof(task));
+		rtdm_copy_from_user(context, &task, arg, sizeof(task));
 
 		return rtswitch_pend_rt(ctx, task.index);
 
 	case RTTST_RTIOC_SWTEST_SWITCH_TO:
-		if (!rtdm_read_user_ok(user_info, arg, sizeof(fromto)))
+		if (!rtdm_read_user_ok(context, arg, sizeof(fromto)))
 			return -EFAULT;
 
-		rtdm_copy_from_user(user_info,
+		rtdm_copy_from_user(context,
 				    &fromto,
 				    arg,
 				    sizeof(fromto));
@@ -699,10 +692,10 @@ static int rtswitch_ioctl_rt(struct rtdm_dev_context *context,
 		return rtswitch_to_rt(ctx, fromto.from, fromto.to);
 
 	case RTTST_RTIOC_SWTEST_GET_LAST_ERROR:
-		if (!rtdm_rw_user_ok(user_info, arg, sizeof(ctx->error)))
+		if (!rtdm_rw_user_ok(context, arg, sizeof(ctx->error)))
 			return -EFAULT;
 
-		rtdm_copy_to_user(user_info,
+		rtdm_copy_to_user(context,
 				  arg,
 				  &ctx->error,
 				  sizeof(ctx->error));
@@ -715,43 +708,29 @@ static int rtswitch_ioctl_rt(struct rtdm_dev_context *context,
 }
 
 static struct rtdm_device device = {
-	struct_version: RTDM_DEVICE_STRUCT_VER,
-
-	device_flags: RTDM_NAMED_DEVICE,
-	context_size: sizeof(rtswitch_context_t),
-	device_name:  "",
-
-	open_rt: NULL,
-	open_nrt: rtswitch_open,
-
-	ops: {
-		close_rt: NULL,
-		close_nrt: rtswitch_close,
-
-		ioctl_rt: rtswitch_ioctl_rt,
-		ioctl_nrt: rtswitch_ioctl_nrt,
+	.struct_version = RTDM_DEVICE_STRUCT_VER,
 
-		read_rt: NULL,
-		read_nrt: NULL,
+	.device_flags = RTDM_NAMED_DEVICE,
+	.context_size = sizeof(rtswitch_context_t),
+	.device_name = "",
 
-		write_rt: NULL,
-		write_nrt: NULL,
+	.open = rtswitch_open,
 
-		recvmsg_rt: NULL,
-		recvmsg_nrt: NULL,
+	.ops = {
+		.close = rtswitch_close,
 
-		sendmsg_rt: NULL,
-		sendmsg_nrt: NULL,
+		.ioctl_rt = rtswitch_ioctl_rt,
+		.ioctl_nrt = rtswitch_ioctl_nrt,
 	},
 
-	device_class: RTDM_CLASS_TESTING,
-	device_sub_class: RTDM_SUBCLASS_SWITCHTEST,
-	profile_version: RTTST_PROFILE_VER,
-	driver_name: "xeno_switchtest",
-	driver_version: RTDM_DRIVER_VER(0, 1, 1),
-	peripheral_name: "Context Switch Test",
-	provider_name: "Gilles Chanteperdrix",
-	proc_name: device.device_name,
+	.device_class = RTDM_CLASS_TESTING,
+	.device_sub_class = RTDM_SUBCLASS_SWITCHTEST,
+	.profile_version = RTTST_PROFILE_VER,
+	.driver_name = "xeno_switchtest",
+	.driver_version = RTDM_DRIVER_VER(0, 1, 1),
+	.peripheral_name = "Context Switch Test",
+	.provider_name = "Gilles Chanteperdrix",
+	.proc_name = device.device_name,
 };
 
 int __init __switchtest_init(void)
-- 
1.7.10.4


