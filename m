From: Manuel Huber <manuel.h87@gmail.com>
Date: Wed,  2 Oct 2013 22:47:39 +0200
Message-Id: <1380746860-1409-3-git-send-email-manuel.h87@gmail.com>
In-Reply-To: <1380746860-1409-1-git-send-email-manuel.h87@gmail.com>
References: <1380746860-1409-1-git-send-email-manuel.h87@gmail.com>
Subject: [Xenomai] [PATCH 2/3] rtcan: Adapt rtcan_raw to changes in rtdm
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@web.de
Cc: xenomai@xenomai.org

From: Manuel Huber <Manuel.h87@gmail.com>

---
 ksrc/drivers/can/rtcan_raw.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/ksrc/drivers/can/rtcan_raw.c b/ksrc/drivers/can/rtcan_raw.c
index ded024e..c244247 100644
--- a/ksrc/drivers/can/rtcan_raw.c
+++ b/ksrc/drivers/can/rtcan_raw.c
@@ -559,6 +559,7 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_dev_context *context,
     size_t payload_size;
     rtdm_lockctx_t lock_ctx;
     int ret;
+    int copy_timestamp = 0;
 
     /* Clear frame memory location */
     memset(&frame, 0, sizeof(can_frame_t));
@@ -610,8 +611,10 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_dev_context *context,
     }
 
     if (msg->msg_control != NULL) {
-	if (msg->msg_controllen < sizeof(nanosecs_abs_t))
-	    return -EINVAL;
+	if (msg->msg_controllen >= sizeof(timestamp))
+	    copy_timestamp = 1;
+	else
+	    msg->msg_flags |= MSG_CTRUNC;
 
 	if (user_info) {
 	    if (!rtdm_rw_user_ok(user_info, msg->msg_control,
@@ -686,7 +689,7 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_dev_context *context,
 
 
     /* Is a timestamp available and is the caller actually interested? */
-    if (msg->msg_controllen && (can_dlc & RTCAN_HAS_TIMESTAMP)) {
+    if (copy_timestamp && (can_dlc & RTCAN_HAS_TIMESTAMP)) {
 	/* Copy timestamp */
 	MEMCPY_FROM_RING_BUF(&timestamp, RTCAN_TIMESTAMP_SIZE);
     }
@@ -741,15 +744,13 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_dev_context *context,
 	    return -EFAULT;
 
 	/* Copy timestamp if existent and wanted */
-	if (msg->msg_controllen) {
-	    if (can_dlc & RTCAN_HAS_TIMESTAMP) {
-		if (rtdm_copy_to_user(user_info, msg->msg_control,
-				      &timestamp, RTCAN_TIMESTAMP_SIZE))
-		    return -EFAULT;
+	if (copy_timestamp && (can_dlc & RTCAN_HAS_TIMESTAMP)) {
+	    if (rtdm_copy_to_user(user_info, msg->msg_control,
+				  &timestamp, RTCAN_TIMESTAMP_SIZE))
+		return -EFAULT;
 
-		msg->msg_controllen = RTCAN_TIMESTAMP_SIZE;
-	    } else
-		msg->msg_controllen = 0;
+	    msg->msg_controllen -= RTCAN_TIMESTAMP_SIZE;
+	    msg->msg_control += RTCAN_TIMESTAMP_SIZE;
 	}
 
     } else {
@@ -768,12 +769,10 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_dev_context *context,
 	iov->iov_len -= sizeof(can_frame_t);
 
 	/* Copy timestamp if existent and wanted */
-	if (msg->msg_controllen) {
-	    if (can_dlc & RTCAN_HAS_TIMESTAMP) {
-		memcpy(msg->msg_control, &timestamp, RTCAN_TIMESTAMP_SIZE);
-		msg->msg_controllen = RTCAN_TIMESTAMP_SIZE;
-	    } else
-		msg->msg_controllen = 0;
+	if (copy_timestamp && (can_dlc & RTCAN_HAS_TIMESTAMP)) {
+	    memcpy(msg->msg_control, &timestamp, RTCAN_TIMESTAMP_SIZE);
+	    msg->msg_controllen -= RTCAN_TIMESTAMP_SIZE;
+	    msg->msg_control += RTCAN_TIMESTAMP_SIZE;
 	}
     }
 
-- 
1.8.3


