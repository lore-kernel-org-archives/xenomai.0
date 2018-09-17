From: Edouard Tisserant <edouard.tisserant@gmail.com>
Message-ID: <51e26820-fb3f-0404-f799-2c87020a211d@gmail.com>
Date: Mon, 17 Sep 2018 09:53:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] [PATCH 0/1] Add non-RT sendmsg and recvmsg in rtpacket.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>


Edouard Tisserant (1):
  Add non-RT sendmsg and recvmsg in rtpacket.

 kernel/drivers/net/stack/packet/af_packet.c | 56 +++++++++++++++++++++
 1 file changed, 56 insertions(+)

-- 
2.17.1

>From 89155c30d2ffe1ed0b7c51d2b990866eff77a53f Mon Sep 17 00:00:00 2001
From: Edouard Tisserant <edouard.tisserant@gmail.com>
Date: Sat, 15 Sep 2018 14:51:11 +0200
Subject: [PATCH 1/1] Add non-RT sendmsg and recvmsg in rtpacket.

---
 kernel/drivers/net/stack/packet/af_packet.c | 56 +++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/kernel/drivers/net/stack/packet/af_packet.c
b/kernel/drivers/net/stack/packet/af_packet.c
index 9fa985d37..00337892b 100644
--- a/kernel/drivers/net/stack/packet/af_packet.c
+++ b/kernel/drivers/net/stack/packet/af_packet.c
@@ -26,6 +26,7 @@
 #include <linux/sched.h>
 #include <linux/err.h>
 +#include <rtnet_rtpc.h>
 #include <rtnet_iovec.h>
 #include <rtnet_socket.h>
 #include <stack_mgr.h>
@@ -411,7 +412,31 @@ fail:
     goto out;
 }
 +struct recvmsg_params {
+    struct rtdm_fd *fd;
+    struct user_msghdr *msg;
+    int msg_flags;
+};
+
+static int recvmsg_handler(struct rt_proc_call *call)
+{
+    struct recvmsg_params *params;
 +    params = rtpc_get_priv(call, struct recvmsg_params);
+
+    return rt_packet_recvmsg(params->fd, params->msg, params->msg_flags);
+}
+
+static ssize_t
+nrt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg, int
msg_flags)
+{
+    int ret;
+    struct recvmsg_params params = {fd,msg,msg_flags};
+
+    ret = rtpc_dispatch_call(recvmsg_handler, 0, &params,
+                             sizeof(params), NULL, NULL);
+    return ret;
+}
  /***
  *  rt_packet_sendmsg
@@ -544,6 +569,33 @@ rt_packet_sendmsg(struct rtdm_fd *fd, const struct
user_msghdr *msg, int msg_fla
     goto out;
 }
 +struct sendmsg_params {
+    struct rtdm_fd *fd;
+    const struct user_msghdr *msg;
+    int msg_flags;
+};
+
+static int sendmsg_handler(struct rt_proc_call *call)
+{
+    struct sendmsg_params *params;
+
+    params = rtpc_get_priv(call, struct sendmsg_params);
+
+    return rt_packet_sendmsg(params->fd, params->msg, params->msg_flags);
+}
+
+static ssize_t
+nrt_packet_sendmsg(struct rtdm_fd *fd, const struct user_msghdr *msg,
int msg_flags)
+{
+    int ret;
+    struct sendmsg_params params = {fd,msg,msg_flags};
+
+    ret = rtpc_dispatch_call(sendmsg_handler, 0, &params,
+                             sizeof(params), NULL, NULL);
+    return ret;
+}
+
+
   static struct rtdm_driver packet_proto_drv = {
@@ -566,6 +618,8 @@ static struct rtdm_driver packet_proto_drv = {
 	.ioctl_nrt =    rt_packet_ioctl,
 	.recvmsg_rt =   rt_packet_recvmsg,
 	.sendmsg_rt =   rt_packet_sendmsg,
+	.recvmsg_nrt =   nrt_packet_recvmsg,
+	.sendmsg_nrt =   nrt_packet_sendmsg,
 	.select =       rt_socket_select_bind,
     },
 };
@@ -595,6 +649,8 @@ static struct rtdm_driver raw_packet_proto_drv = {
 	.ioctl_nrt =    rt_packet_ioctl,
 	.recvmsg_rt =   rt_packet_recvmsg,
 	.sendmsg_rt =   rt_packet_sendmsg,
+	.recvmsg_nrt =   nrt_packet_recvmsg,
+	.sendmsg_nrt =   nrt_packet_sendmsg,
 	.select =       rt_socket_select_bind,
     },
 };
-- 
2.17.1


