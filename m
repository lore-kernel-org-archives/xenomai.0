From: Manuel Huber <manuel.h87@gmail.com>
Date: Wed,  2 Oct 2013 22:47:40 +0200
Message-Id: <1380746860-1409-4-git-send-email-manuel.h87@gmail.com>
In-Reply-To: <1380746860-1409-1-git-send-email-manuel.h87@gmail.com>
References: <1380746860-1409-1-git-send-email-manuel.h87@gmail.com>
Subject: [Xenomai] [PATCH 3/3] doc: Add documentation to
	rtdm_recvmsg_handler_t
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

Describes consequences of changes in sys_rtdm_recvmsg to the
interface regarding the msghdr struct.
---
 include/rtdm/rtdm_driver.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 8b01f04..d8e3695 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -294,7 +294,14 @@ typedef ssize_t (*rtdm_write_handler_t)(struct rtdm_dev_context *context,
  * @param[in] user_info Opaque pointer to information about user mode caller,
  * NULL if kernel mode call
  * @param[in,out] msg Message descriptor as passed by the user, automatically
- * mirrored to safe kernel memory in case of user mode call
+ * mirrored to safe kernel memory in case of user mode call. If msg_control
+ * points to a valid buffer (not NULL) and msg_controllen is > 0, cmsghdr
+ * structures can be put into msg_control buffer by driver code. Driver code
+ * has to move msg_control to point to the next free byte (or the end of the
+ * buffer). The core layer will update msg_controllen to reflect the actual
+ * number of meaningful bytes written to msg_control buffer. If there is
+ * insufficient space to write all control messages, MSG_CTRUNC has to be set
+ * by the driver (do not abort).
  * @param[in] flags Message flags as passed by the user
  *
  * @return On success, the number of bytes received. On failure return
-- 
1.8.3


