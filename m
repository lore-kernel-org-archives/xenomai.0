MIME-Version: 1.0
References: <CA+K1mPGLQ5-B-qrTasdwc_G38cr6T78V0Nip3bEkdD89761ukA@mail.gmail.com>
 <9a0553a5-aa37-a089-54e8-45a59ebf1095@siemens.com>
 <CA+K1mPE4d9qQ2-tT+rDGBR4v__vzrXu2736+JFADco8a6Y7xLQ@mail.gmail.com>
 <87ba187f-5e89-a0f3-10f6-fc14eb5efe21@siemens.com>
 <93290885-9113-dd98-b1df-550604fc6fff@siemens.com>
 <03214e1aeb2ad8c681e63a01fd6051ec3c309aec.camel@siemens.com>
 <CA+K1mPGzCcaxm4qT4vF5kkk2yc5c8mTxq1mJ1Wp6UW6H2ftmuw@mail.gmail.com>
 <8ba75fe52f21b3dc56d261e22282f7ef8bc5b050.camel@siemens.com>
In-Reply-To: <8ba75fe52f21b3dc56d261e22282f7ef8bc5b050.camel@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 5 Nov 2021 00:09:34 -0700
Message-ID: <CA+K1mPFkjVhKh_28+k7GowYs3mWvHnKiYhPnj4sVb2O0CHbSgg@mail.gmail.com>
Subject: Re: rtcansend 32-bit
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>

Please review and accept this patch, which allows 32 bit apps to send and
receive CAN. It is tested successfully with 32bit and 64bit compiles of
utils/can/rtcansend.c / and rtcanrecv.c. The compat interface is now
implemented, rtdm_get_iovec() is used and the get_sockaddr() methodology
from the xddp sockets code was emulated to get the CAN receive to work.

Signed-off-by: C Smith <csmithquestions@gmail.com>
---
 kernel/drivers/can/rtcan_internal.h |   3 +
 kernel/drivers/can/rtcan_raw.c      | 111
++++++++++++++++++++++++------------
 2 files changed, 76 insertions(+), 38 deletions(-)

diff --git a/kernel/drivers/can/rtcan_internal.h
b/kernel/drivers/can/rtcan_internal.h
index b290005..03febef 100644
--- a/kernel/drivers/can/rtcan_internal.h
+++ b/kernel/drivers/can/rtcan_internal.h
@@ -28,6 +28,7 @@

 #include <linux/module.h>
 #include <rtdm/driver.h>
+#include <rtdm/compat.h>

 #ifdef CONFIG_XENO_DRIVERS_CAN_DEBUG
 #define RTCAN_ASSERT(expr, func) \
@@ -58,4 +59,6 @@
 #define rtcandev_err(dev, fmt, args...) \
  printk(KERN_ERR "%s: " fmt, (dev)->name, ##args)

+#define COMPAT_CASE(__op) case __op __COMPAT_CASE(__op  ## _COMPAT)
+
 #endif /* __RTCAN_INTERNAL_H_ */
diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
index 693b927..6e8ebe6 100644
--- a/kernel/drivers/can/rtcan_raw.c
+++ b/kernel/drivers/can/rtcan_raw.c
@@ -215,6 +215,58 @@ EXPORT_SYMBOL_GPL(rtcan_loopback);
 #endif /* CONFIG_XENO_DRIVERS_CAN_LOOPBACK */


+int rtcan_get_sockaddr(struct rtdm_fd *fd, struct sockaddr_can **saddrp,
+       const void *arg)
+{
+    struct _rtdm_setsockaddr_args *setaddr, setaddr_buf;
+    int ret = 0;
+
+    if (!rtdm_fd_is_user(fd)) {
+        setaddr = (struct _rtdm_setsockaddr_args *)arg;
+        *saddrp = (struct sockaddr_can *)setaddr->addr;
+    }
+
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
+        if (csetaddr_buff.addrlen != sizeof(**saddrp))
+            return -EINVAL;
+
+        return rtdm_safe_copy_from_user(fd, *saddrp,
+                        compat_ptr(csetaddr_buff.addr),
+                        sizeof(struct sockaddr_can));
+        *saddrp = NULL;
+        return 0;
+    }
+#endif
+
+    if (rtdm_safe_copy_from_user(fd, &setaddr_buf, arg,
+                sizeof(struct _rtdm_setsockaddr_args)))
+        return -EFAULT;
+
+    setaddr = &setaddr_buf;
+
+    /* Check size */
+    if (setaddr->addrlen != sizeof(struct sockaddr_can))
+        return -EINVAL;
+
+    return rtdm_safe_copy_from_user(fd, *saddrp,
+                    setaddr->addr,
+                    sizeof(struct sockaddr_can));
+
+    *saddrp = NULL;
+    return 0;
+}
+
+
 int rtcan_raw_socket(struct rtdm_fd *fd, int protocol)
 {
     /* Only protocol CAN_RAW is supported */
@@ -408,46 +460,21 @@ static int rtcan_raw_setsockopt(struct rtdm_fd *fd,
 int rtcan_raw_ioctl(struct rtdm_fd *fd,
     unsigned int request, void *arg)
 {
+    struct sockaddr_can saddr, *saddrp = &saddr;
     int ret = 0;

     switch (request) {
-    case _RTIOC_BIND: {
- struct _rtdm_setsockaddr_args *setaddr, setaddr_buf;
- struct sockaddr_can *sockaddr, sockaddr_buf;
-
- if (rtdm_fd_is_user(fd)) {
-    /* Copy argument structure from userspace */
-    if (!rtdm_read_user_ok(fd, arg,
-   sizeof(struct _rtdm_setsockaddr_args)) ||
- rtdm_copy_from_user(fd, &setaddr_buf, arg,
-    sizeof(struct _rtdm_setsockaddr_args)))
- return -EFAULT;

-    setaddr = &setaddr_buf;
+    COMPAT_CASE(_RTIOC_BIND):
+        ret = rtcan_get_sockaddr(fd, &saddrp, arg);
+ if (ret)
+ return ret;
+        if (saddrp == NULL)
+ return -EFAULT;
+    ret = rtcan_raw_bind(fd, saddrp);
+    break;

-    /* Check size */
-    if (setaddr->addrlen != sizeof(struct sockaddr_can))
- return -EINVAL;
-
-    /* Copy argument structure from userspace */
-    if (!rtdm_read_user_ok(fd, arg,
-   sizeof(struct sockaddr_can)) ||
- rtdm_copy_from_user(fd, &sockaddr_buf, setaddr->addr,
-    sizeof(struct sockaddr_can)))
- return -EFAULT;
-    sockaddr = &sockaddr_buf;
- } else {
-    setaddr = (struct _rtdm_setsockaddr_args *)arg;
-    sockaddr = (struct sockaddr_can *)setaddr->addr;
- }
-
- /* Now, all required data are in kernel space */
- ret = rtcan_raw_bind(fd, sockaddr);
-
- break;
-    }
-
-    case _RTIOC_SETSOCKOPT: {
+    COMPAT_CASE(_RTIOC_SETSOCKOPT): {
  struct _rtdm_setsockopt_args *setopt;
  struct _rtdm_setsockopt_args setopt_buf;

@@ -532,7 +559,7 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
     struct rtcan_socket *sock = rtdm_fd_to_private(fd);
     struct sockaddr_can scan;
     nanosecs_rel_t timeout;
-    struct iovec *iov = (struct iovec *)msg->msg_iov;
+ struct iovec iov_fast[RTDM_IOV_FASTMAX], *iov;
     struct iovec iov_buf;
     can_frame_t frame;
     nanosecs_abs_t timestamp = 0;
@@ -584,6 +611,10 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
  iov = &iov_buf;
     }

+ ret = rtdm_get_iovec(fd, &iov, msg, iov_fast);
+ if (ret)
+ return ret;
+
     /* Check size of buffer */
     if (iov->iov_len < sizeof(can_frame_t))
  return -EMSGSIZE;
@@ -768,7 +799,7 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
     struct rtcan_socket *sock = rtdm_fd_to_private(fd);
     struct sockaddr_can *scan = (struct sockaddr_can *)msg->msg_name;
     struct sockaddr_can scan_buf;
-    struct iovec *iov = (struct iovec *)msg->msg_iov;
+ struct iovec iov_fast[RTDM_IOV_FASTMAX], *iov;
     struct iovec iov_buf;
     can_frame_t *frame;
     can_frame_t frame_buf;
@@ -841,8 +872,12 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
  iov = &iov_buf;
     }

+ ret = rtdm_get_iovec(fd, &iov, msg, iov_fast);
+ if (ret)
+ return ret;
+
     /* Check size of buffer */
-    if (iov->iov_len != sizeof(can_frame_t))
+    if (iov->iov_len != sizeof(can_frame_t))
  return -EMSGSIZE;

     frame = (can_frame_t *)iov->iov_base;
-- 
2.1.0
