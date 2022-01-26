From: Konstantin Smola <ksmola51@gmail.com>
Subject: [PATCH 1/1] drivers/can: 32-bit userspace app support for rtcan
Date: Tue, 25 Jan 2022 17:32:38 -0800
Message-Id: <1643160758-18297-1-git-send-email-ksmola51@gmail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Konstantin Smola <ksmola51@gmail.com>

kernel/drivers/can: 32-bit userspace app support for rtcan
Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
---
 kernel/drivers/can/rtcan_internal.h |   1 +
 kernel/drivers/can/rtcan_raw.c      | 102 +++++++++++++++++++++++-------------
 2 files changed, 66 insertions(+), 37 deletions(-)

diff --git a/kernel/drivers/can/rtcan_internal.h b/kernel/drivers/can/rtcan_internal.h
index b290005..d1f9d31 100644
--- a/kernel/drivers/can/rtcan_internal.h
+++ b/kernel/drivers/can/rtcan_internal.h
@@ -28,6 +28,7 @@
 
 #include <linux/module.h>
 #include <rtdm/driver.h>
+#include <rtdm/compat.h>
 
 #ifdef CONFIG_XENO_DRIVERS_CAN_DEBUG
 #define RTCAN_ASSERT(expr, func) \
diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
index dffc6e8..8aff03a 100644
--- a/kernel/drivers/can/rtcan_raw.c
+++ b/kernel/drivers/can/rtcan_raw.c
@@ -214,6 +214,51 @@ EXPORT_SYMBOL_GPL(rtcan_loopback);
 
 #endif /* CONFIG_XENO_DRIVERS_CAN_LOOPBACK */
 
+int rtcan_get_sockaddr(struct rtdm_fd *fd, struct sockaddr_can **saddrp,
+               const void *arg)
+{
+    struct _rtdm_setsockaddr_args *setaddr, setaddr_buf;
+    int ret = 0;
+
+    if (!rtdm_fd_is_user(fd)) {
+        setaddr = (struct _rtdm_setsockaddr_args *)arg;
+        *saddrp = (struct sockaddr_can *)setaddr->addr;
+    } else {
+#ifdef CONFIG_XENO_ARCH_SYS3264
+    if (rtdm_fd_is_compat(fd)) {
+        struct compat_rtdm_setsockaddr_args csetaddr_buff;
+
+        /* Copy argument structure from userspace */
+        ret = rtdm_safe_copy_from_user(fd, &csetaddr_buff,
+                        arg, sizeof(csetaddr_buff));
+        if (ret)
+            return ret;
+
+        /* Check size */
+        if (csetaddr_buff.addrlen != sizeof(struct sockaddr_can))
+            return -EINVAL;
+
+        return rtdm_safe_copy_from_user(fd, *saddrp,
+                        compat_ptr(csetaddr_buff.addr),
+                        sizeof(struct sockaddr_can));
+    }
+#endif
+
+    if (rtdm_safe_copy_from_user(fd, &setaddr_buf, arg,
+                sizeof(struct _rtdm_setsockaddr_args)))
+        return -EFAULT;
+
+    setaddr = &setaddr_buf;
+    }
+
+    /* Check size */
+    if (setaddr->addrlen != sizeof(struct sockaddr_can))
+        return -EINVAL;
+
+    return rtdm_safe_copy_from_user(fd, *saddrp,
+                    setaddr->addr,
+                    sizeof(struct sockaddr_can));
+}
 
 int rtcan_raw_socket(struct rtdm_fd *fd, int protocol)
 {
@@ -408,46 +453,21 @@ static int rtcan_raw_setsockopt(struct rtdm_fd *fd,
 int rtcan_raw_ioctl(struct rtdm_fd *fd,
 		    unsigned int request, void *arg)
 {
+    struct sockaddr_can saddr, *saddrp = &saddr;
     int ret = 0;
 
     switch (request) {
-    case _RTIOC_BIND: {
-	struct _rtdm_setsockaddr_args *setaddr, setaddr_buf;
-	struct sockaddr_can *sockaddr, sockaddr_buf;
-
-	if (rtdm_fd_is_user(fd)) {
-	    /* Copy argument structure from userspace */
-	    if (!rtdm_read_user_ok(fd, arg,
-				   sizeof(struct _rtdm_setsockaddr_args)) ||
-		rtdm_copy_from_user(fd, &setaddr_buf, arg,
-				    sizeof(struct _rtdm_setsockaddr_args)))
-		return -EFAULT;
 
-	    setaddr = &setaddr_buf;
+	COMPAT_CASE(_RTIOC_BIND):
+		ret = rtcan_get_sockaddr(fd, &saddrp, arg);
+		if (ret)
+			return ret;
+		if (saddrp == NULL)
+			return -EFAULT;
+		ret = rtcan_raw_bind(fd, saddrp);
+		break;
 
-	    /* Check size */
-	    if (setaddr->addrlen != sizeof(struct sockaddr_can))
-		return -EINVAL;
-
-	    /* Copy argument structure from userspace */
-	    if (!rtdm_read_user_ok(fd, arg,
-				   sizeof(struct sockaddr_can)) ||
-		rtdm_copy_from_user(fd, &sockaddr_buf, setaddr->addr,
-				    sizeof(struct sockaddr_can)))
-		return -EFAULT;
-	    sockaddr = &sockaddr_buf;
-	} else {
-	    setaddr = (struct _rtdm_setsockaddr_args *)arg;
-	    sockaddr = (struct sockaddr_can *)setaddr->addr;
-	}
-
-	/* Now, all required data are in kernel space */
-	ret = rtcan_raw_bind(fd, sockaddr);
-
-	break;
-    }
-
-    case _RTIOC_SETSOCKOPT: {
+	COMPAT_CASE(_RTIOC_SETSOCKOPT): {
 	struct _rtdm_setsockopt_args *setopt;
 	struct _rtdm_setsockopt_args setopt_buf;
 
@@ -532,7 +552,7 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
     struct rtcan_socket *sock = rtdm_fd_to_private(fd);
     struct sockaddr_can scan;
     nanosecs_rel_t timeout;
-    struct iovec *iov = (struct iovec *)msg->msg_iov;
+    struct iovec iov_fast[RTDM_IOV_FASTMAX], *iov;
     struct iovec iov_buf;
     can_frame_t frame;
     nanosecs_abs_t timestamp = 0;
@@ -584,6 +604,10 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
 	iov = &iov_buf;
     }
 
+	ret = rtdm_get_iovec(fd, &iov, msg, iov_fast);
+	if (ret)
+		return ret;
+
     /* Check size of buffer */
     if (iov->iov_len < sizeof(can_frame_t))
 	return -EMSGSIZE;
@@ -862,7 +886,7 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
     struct rtcan_socket *sock = rtdm_fd_to_private(fd);
     struct sockaddr_can *scan = (struct sockaddr_can *)msg->msg_name;
     struct sockaddr_can scan_buf;
-    struct iovec *iov = (struct iovec *)msg->msg_iov;
+    struct iovec iov_fast[RTDM_IOV_FASTMAX], *iov;
     struct iovec iov_buf;
     can_frame_t *frame;
     can_frame_t frame_buf;
@@ -933,6 +957,10 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
 	iov = &iov_buf;
     }
 
+	ret = rtdm_get_iovec(fd, &iov, msg, iov_fast);
+	if (ret)
+		return ret;
+
     n = msg->msg_iovlen;
     while (i < n) {
 	if (iov->iov_len < sizeof(can_frame_t)) {
-- 
2.1.0


