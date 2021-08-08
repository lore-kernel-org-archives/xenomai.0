From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/2] drivers/net: udp, packet: Fix returning of msg_namelen
 and msg_flags from recvmsg
Message-ID: <31c54628-280a-c423-4fdc-a9e92257dffe@siemens.com>
Date: Sun, 8 Aug 2021 19:19:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

The msg struct passed to the recvmsg handler for udp and packet sockets
is not located in userspace. Therefore, we must not use rtnet_put_arg to
update its content, it may fail on some archs, namely arm and arm64.
Just assign, the syscall entry function will take care of copying it
back.

Fixes: 25a53f5cd352 ("rtnet: udp: Remove duplicate copy_from/to_user")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/stack/ipv4/udp/udp.c     | 12 ++----------
 kernel/drivers/net/stack/packet/af_packet.c | 13 +++----------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 6fe1aeb12e..bceb6b5132 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -446,10 +446,7 @@ ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
 			goto fail;
 
 		namelen = sizeof(sin);
-		ret = rtnet_put_arg(fd, &msg->msg_namelen, &namelen,
-				    sizeof(namelen));
-		if (ret)
-			goto fail;
+		msg->msg_namelen = namelen;
 	}
 
 	data_len = ntohs(uh->len) - sizeof(struct udphdr);
@@ -489,12 +486,7 @@ ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
 	if (data_len > 0)
 		flags |= MSG_TRUNC;
 
-	if (flags != msg->msg_flags) {
-		ret = rtnet_put_arg(fd, &msg->msg_flags, &flags,
-				    sizeof(flags));
-		if (ret)
-			goto fail;
-	}
+	msg->msg_flags = flags;
 out:
 	if ((msg_flags & MSG_PEEK) == 0)
 		kfree_rtskb(first_skb);
diff --git a/kernel/drivers/net/stack/packet/af_packet.c b/kernel/drivers/net/stack/packet/af_packet.c
index 8a8072c640..0d5ecd6a7d 100644
--- a/kernel/drivers/net/stack/packet/af_packet.c
+++ b/kernel/drivers/net/stack/packet/af_packet.c
@@ -302,7 +302,7 @@ static ssize_t rt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
 	size_t copy_len;
 	struct rtskb *rtskb;
 	struct sockaddr_ll sll;
-	int ret, flags;
+	int ret;
 	nanosecs_rel_t timeout = sock->timeout;
 	socklen_t namelen;
 	struct iovec iov_fast[RTDM_IOV_FASTMAX], *iov;
@@ -355,10 +355,7 @@ static ssize_t rt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
 			goto fail;
 
 		namelen = sizeof(sll);
-		ret = rtnet_put_arg(fd, &msg->msg_namelen, &namelen,
-				    sizeof(namelen));
-		if (ret)
-			goto fail;
+		msg->msg_namelen = namelen;
 	}
 
 	/* Include the header in raw delivery */
@@ -375,11 +372,7 @@ static ssize_t rt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
 
 	if (copy_len > len) {
 		copy_len = len;
-		flags = msg->msg_flags | MSG_TRUNC;
-		ret = rtnet_put_arg(fd, &msg->msg_flags, &flags,
-				    sizeof(flags));
-		if (ret)
-			goto fail;
+		msg->msg_flags |= MSG_TRUNC;
 	}
 
 	copy_len = rtnet_write_to_iov(fd, iov, msg->msg_iovlen, rtskb->data,
-- 
2.31.1

