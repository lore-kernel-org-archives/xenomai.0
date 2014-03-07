From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Fri,  7 Mar 2014 21:20:33 +0100
Message-Id: <1394223638-13070-4-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <531A29CC.4040201@xenomai.org>
 <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 4/9] drivers/testing: adapt timerbench after RTDM
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
 kernel/drivers/testing/timerbench.c |   90 +++++++++++++++--------------------
 1 file changed, 39 insertions(+), 51 deletions(-)

diff --git a/kernel/drivers/testing/timerbench.c b/kernel/drivers/testing/timerbench.c
index efb5ca2..4852703 100644
--- a/kernel/drivers/testing/timerbench.c
+++ b/kernel/drivers/testing/timerbench.c
@@ -189,12 +189,11 @@ static void timer_proc(rtdm_timer_t *timer)
 	} while (err);
 }
 
-static int rt_tmbench_open(struct rtdm_dev_context *context,
-			   rtdm_user_info_t *user_info, int oflags)
+static int rt_tmbench_open(struct rtdm_fd *context, int oflags)
 {
 	struct rt_tmbench_context *ctx;
 
-	ctx = (struct rt_tmbench_context *)context->dev_private;
+	ctx = rtdm_context_to_private(context);
 
 	ctx->mode = RTTST_TMBENCH_INVALID;
 	sema_init(&ctx->nrt_mutex, 1);
@@ -202,12 +201,11 @@ static int rt_tmbench_open(struct rtdm_dev_context *context,
 	return 0;
 }
 
-static int rt_tmbench_close(struct rtdm_dev_context *context,
-			    rtdm_user_info_t *user_info)
+static void rt_tmbench_close(struct rtdm_fd *context)
 {
 	struct rt_tmbench_context *ctx;
 
-	ctx = (struct rt_tmbench_context *)context->dev_private;
+	ctx = rtdm_context_to_private(context);
 
 	down(&ctx->nrt_mutex);
 
@@ -227,13 +225,10 @@ static int rt_tmbench_close(struct rtdm_dev_context *context,
 	}
 
 	up(&ctx->nrt_mutex);
-
-	return 0;
 }
 
-static int rt_tmbench_start(struct rtdm_dev_context *context,
+static int rt_tmbench_start(struct rtdm_fd *context,
 			    struct rt_tmbench_context *ctx,
-			    rtdm_user_info_t *user_info,
 			    struct rttst_tmbench_config __user *user_config)
 {
 	int err = 0;
@@ -242,9 +237,9 @@ static int rt_tmbench_start(struct rtdm_dev_context *context,
 	struct rttst_tmbench_config *config =
 		(struct rttst_tmbench_config *)user_config;
 
-	if (user_info) {
+	if (rtdm_context_user_p(context)) {
 		if (rtdm_safe_copy_from_user
-		    (user_info, &config_buf,user_config,
+		    (context, &config_buf,user_config,
 		     sizeof(struct rttst_tmbench_config)) < 0)
 			return -EFAULT;
 
@@ -295,33 +290,28 @@ static int rt_tmbench_start(struct rtdm_dev_context *context,
 	rtdm_event_init(&ctx->result_event, 0);
 
 	if (config->mode == RTTST_TMBENCH_TASK) {
-		if (!test_bit(RTDM_CLOSING, &context->context_flags)) {
-			err = rtdm_task_init(&ctx->timer_task, "timerbench",
-					     timer_task_proc, ctx,
-					     config->priority, 0);
-			if (!err)
-				ctx->mode = RTTST_TMBENCH_TASK;
-		}
+		err = rtdm_task_init(&ctx->timer_task, "timerbench",
+				timer_task_proc, ctx,
+				config->priority, 0);
+		if (!err)
+			ctx->mode = RTTST_TMBENCH_TASK;
 	} else {
 		rtdm_timer_init(&ctx->timer, timer_proc,
-				context->device->device_name);
+				rtdm_context_device(context)->device_name);
 
 		ctx->curr.test_loops = 0;
 
-		if (!test_bit(RTDM_CLOSING, &context->context_flags)) {
-			ctx->mode = RTTST_TMBENCH_HANDLER;
+		ctx->mode = RTTST_TMBENCH_HANDLER;
 
-			RTDM_EXECUTE_ATOMICALLY(
-				ctx->start_time = rtdm_clock_read_monotonic();
+		RTDM_EXECUTE_ATOMICALLY(
+			ctx->start_time = rtdm_clock_read_monotonic();
 
-				/* first event: one millisecond from now. */
-				ctx->date = ctx->start_time + 1000000;
+			/* first event: one millisecond from now. */
+			ctx->date = ctx->start_time + 1000000;
 
-				err =
-				    rtdm_timer_start(&ctx->timer, ctx->date, 0,
-						     RTDM_TIMERMODE_ABSOLUTE);
-			);
-		}
+			err = rtdm_timer_start(&ctx->timer, ctx->date, 0,
+					RTDM_TIMERMODE_ABSOLUTE);
+					);
 	}
 
 	up(&ctx->nrt_mutex);
@@ -330,9 +320,9 @@ static int rt_tmbench_start(struct rtdm_dev_context *context,
 }
 
 static int rt_tmbench_stop(struct rt_tmbench_context *ctx,
-			   rtdm_user_info_t *user_info,
 			   struct rttst_overall_bench_res __user *user_res)
 {
+	struct rtdm_fd *context = rtdm_private_to_context(ctx);
 	int err = 0;
 
 	down(&ctx->nrt_mutex);
@@ -356,8 +346,8 @@ static int rt_tmbench_stop(struct rt_tmbench_context *ctx,
 		   ((ctx->result.overall.test_loops) > 1 ?
 		    ctx->result.overall.test_loops : 2) - 1);
 
-	if (user_info)
-		err = rtdm_safe_copy_to_user(user_info, &user_res->result,
+	if (rtdm_context_user_p(context))
+		err = rtdm_safe_copy_to_user(context, &user_res->result,
 					     &ctx->result.overall,
 					     sizeof(struct rttst_bench_res));
 		/* Do not break on error here - we may have to free a
@@ -373,19 +363,19 @@ static int rt_tmbench_stop(struct rt_tmbench_context *ctx,
 	if (ctx->histogram_size > 0) {
 		int size = ctx->histogram_size * sizeof(long);
 
-		if (user_info) {
+		if (rtdm_context_user_p(context)) {
 			struct rttst_overall_bench_res res_buf;
 
-			if (rtdm_safe_copy_from_user(user_info,
+			if (rtdm_safe_copy_from_user(context,
 						     &res_buf, user_res,
 						     sizeof(res_buf)) < 0 ||
-			    rtdm_safe_copy_to_user(user_info,
+			    rtdm_safe_copy_to_user(context,
 				    (void __user *)res_buf.histogram_min,
 				    ctx->histogram_min, size) < 0 ||
-			    rtdm_safe_copy_to_user(user_info,
+			    rtdm_safe_copy_to_user(context,
 				    (void __user *)res_buf.histogram_max,
 				    ctx->histogram_max, size) < 0 ||
-			    rtdm_safe_copy_to_user(user_info,
+			    rtdm_safe_copy_to_user(context,
 				    (void __user *)res_buf.histogram_avg,
 				    ctx->histogram_avg, size) < 0)
 				err = -EFAULT;
@@ -406,22 +396,21 @@ static int rt_tmbench_stop(struct rt_tmbench_context *ctx,
 	return err;
 }
 
-static int rt_tmbench_ioctl_nrt(struct rtdm_dev_context *context,
-				rtdm_user_info_t *user_info,
+static int rt_tmbench_ioctl_nrt(struct rtdm_fd *context,
 				unsigned int request, void __user *arg)
 {
 	struct rt_tmbench_context *ctx;
 	int err = 0;
 
-	ctx = (struct rt_tmbench_context *)context->dev_private;
+	ctx = rtdm_context_to_private(context);
 
 	switch (request) {
 	case RTTST_RTIOC_TMBENCH_START:
-		err = rt_tmbench_start(context, ctx, user_info, arg);
+		err = rt_tmbench_start(context, ctx, arg);
 		break;
 
 	case RTTST_RTIOC_TMBENCH_STOP:
-		err = rt_tmbench_stop(ctx, user_info, arg);
+		err = rt_tmbench_stop(ctx, arg);
 		break;
 
 	case RTTST_RTIOC_INTERM_BENCH_RES:
@@ -435,14 +424,13 @@ static int rt_tmbench_ioctl_nrt(struct rtdm_dev_context *context,
 	return err;
 }
 
-static int rt_tmbench_ioctl_rt(struct rtdm_dev_context *context,
-			       rtdm_user_info_t *user_info,
+static int rt_tmbench_ioctl_rt(struct rtdm_fd *context,
 			       unsigned int request, void __user *arg)
 {
 	struct rt_tmbench_context *ctx;
 	int err = 0;
 
-	ctx = (struct rt_tmbench_context *)context->dev_private;
+	ctx = rtdm_context_to_private(context);
 
 	switch (request) {
 	case RTTST_RTIOC_INTERM_BENCH_RES:
@@ -450,10 +438,10 @@ static int rt_tmbench_ioctl_rt(struct rtdm_dev_context *context,
 		if (err)
 			return err;
 
-		if (user_info) {
+		if (rtdm_context_user_p(context)) {
 			struct rttst_interm_bench_res __user *user_res = arg;
 
-			err = rtdm_safe_copy_to_user(user_info, user_res,
+			err = rtdm_safe_copy_to_user(context, user_res,
 						     &ctx->result,
 						     sizeof(*user_res));
 		} else {
@@ -483,10 +471,10 @@ static struct rtdm_device device = {
 	.context_size		= sizeof(struct rt_tmbench_context),
 	.device_name		= "",
 
-	.open_nrt		= rt_tmbench_open,
+	.open			= rt_tmbench_open,
 
 	.ops = {
-		.close_nrt	= rt_tmbench_close,
+		.close		= rt_tmbench_close,
 
 		.ioctl_rt	= rt_tmbench_ioctl_rt,
 		.ioctl_nrt	= rt_tmbench_ioctl_nrt,
-- 
1.7.10.4


