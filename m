From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:49 +0200
Message-Id: <3c61c263798334cd8642f13b77d332e66e589584.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 09/25] 16550A: Drop support for device
	opening/closing in real-time
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is deprected now, RT callers will automatically be switched to
non-RT. Along this, simplify the allocation logic for the RX timestamp
history buffer. We only support allocations from non-RT now and migrate
RT callers as required.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/drivers/serial/16550A.c |   51 +++++++++++------------------------------
 1 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/ksrc/drivers/serial/16550A.c b/ksrc/drivers/serial/16550A.c
index db8a515..4c46d86 100644
--- a/ksrc/drivers/serial/16550A.c
+++ b/ksrc/drivers/serial/16550A.c
@@ -297,7 +297,7 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 
 static int rt_16550_set_config(struct rt_16550_context *ctx,
 			       const struct rtser_config *config,
-			       uint64_t ** in_history_ptr)
+			       uint64_t **in_history_ptr)
 {
 	rtdm_lockctx_t lock_ctx;
 	unsigned long base = ctx->base_addr;
@@ -537,12 +537,7 @@ int rt_16550_close(struct rtdm_dev_context *context,
 
 	rt_16550_cleanup_ctx(ctx);
 
-	if (in_history) {
-		if (test_bit(RTDM_CREATED_IN_NRT, &context->context_flags))
-			kfree(in_history);
-		else
-			rtdm_free(in_history);
-	}
+	kfree(in_history);
 
 	return 0;
 }
@@ -602,40 +597,24 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 
 		if (testbits(config->config_mask,
 			     RTSER_SET_TIMESTAMP_HISTORY)) {
-			if (test_bit(RTDM_CREATED_IN_NRT,
-				     &context->context_flags)
-			    && rtdm_in_rt_context()) {
-				/* Already fail here if we MAY allocate or
-				   release a non-RT buffer in RT context. */
-				return -EPERM;
-			}
+			/*
+			 * Reflect the call to non-RT as we will likely
+			 * allocate or free the buffer.
+			 */
+			if (rtdm_in_rt_context())
+				return -ENOSYS;
 
 			if (testbits(config->timestamp_history,
-				     RTSER_RX_TIMESTAMP_HISTORY)) {
-				if (test_bit(RTDM_CREATED_IN_NRT,
-					     &context->context_flags))
-					hist_buf =
-					    kmalloc(IN_BUFFER_SIZE *
-						    sizeof(nanosecs_abs_t),
-						    GFP_KERNEL);
-				else
-					hist_buf =
-					    rtdm_malloc(IN_BUFFER_SIZE *
-						sizeof(nanosecs_abs_t));
-					if (!hist_buf)
-						return -ENOMEM;
-			}
+				     RTSER_RX_TIMESTAMP_HISTORY))
+				hist_buf = kmalloc(IN_BUFFER_SIZE *
+						   sizeof(nanosecs_abs_t),
+						   GFP_KERNEL);
 		}
 
 		rt_16550_set_config(ctx, config, &hist_buf);
 
-		if (hist_buf) {
-			if (test_bit(RTDM_CREATED_IN_NRT,
-				     &context->context_flags))
-				kfree(hist_buf);
-			else
-				rtdm_free(hist_buf);
-		}
+		if (hist_buf)
+			kfree(hist_buf);
 
 		break;
 	}
@@ -1107,11 +1086,9 @@ static const struct rtdm_device __initdata device_tmpl = {
 	.context_size		= sizeof(struct rt_16550_context),
 	.device_name		= "",
 
-	.open_rt		= rt_16550_open,
 	.open_nrt		= rt_16550_open,
 
 	.ops = {
-		.close_rt	= rt_16550_close,
 		.close_nrt	= rt_16550_close,
 
 		.ioctl_rt	= rt_16550_ioctl,
-- 
1.6.0.2


