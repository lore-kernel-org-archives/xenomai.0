From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/2] drivers/net: udp, packet: Respect msg_namelen when
 filling msg_name
Message-ID: <1dd874eb-abf1-81f2-d705-8b049a398082@siemens.com>
Date: Sun, 8 Aug 2021 19:19:15 +0200
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

We must not write more than what was allocated and reported via
msg_namelen by userspace. We may truncate, though, then reporting what
would have been written if there had been enough space.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/stack/ipv4/udp/udp.c     | 12 +++++++++---
 kernel/drivers/net/stack/packet/af_packet.c | 11 ++++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index bceb6b5132..db7a902c35 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -441,12 +441,18 @@ ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
 		sin.sin_family = AF_INET;
 		sin.sin_port = uh->source;
 		sin.sin_addr.s_addr = skb->nh.iph->saddr;
-		ret = rtnet_put_arg(fd, msg->msg_name, &sin, sizeof(sin));
+
+		if (msg->msg_namelen < 0) {
+			ret = -EINVAL;
+			goto fail;
+		}
+		namelen = min(sizeof(sin), (size_t)msg->msg_namelen);
+
+		ret = rtnet_put_arg(fd, msg->msg_name, &sin, namelen);
 		if (ret)
 			goto fail;
 
-		namelen = sizeof(sin);
-		msg->msg_namelen = namelen;
+		msg->msg_namelen = sizeof(sin);
 	}
 
 	data_len = ntohs(uh->len) - sizeof(struct udphdr);
diff --git a/kernel/drivers/net/stack/packet/af_packet.c b/kernel/drivers/net/stack/packet/af_packet.c
index 0d5ecd6a7d..b55235ec19 100644
--- a/kernel/drivers/net/stack/packet/af_packet.c
+++ b/kernel/drivers/net/stack/packet/af_packet.c
@@ -347,15 +347,20 @@ static ssize_t rt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
 		sll.sll_pkttype = rtskb->pkt_type;
 		sll.sll_ifindex = rtdev->ifindex;
 
+		if (msg->msg_namelen < 0) {
+			ret = -EINVAL;
+			goto fail;
+		}
+		namelen = min(sizeof(sll), (size_t)msg->msg_namelen);
+
 		/* Ethernet specific - we rather need some parse handler here */
 		memcpy(sll.sll_addr, rtskb->mac.ethernet->h_source, ETH_ALEN);
 		sll.sll_halen = ETH_ALEN;
-		ret = rtnet_put_arg(fd, msg->msg_name, &sll, sizeof(sll));
+		ret = rtnet_put_arg(fd, msg->msg_name, &sll, namelen);
 		if (ret)
 			goto fail;
 
-		namelen = sizeof(sll);
-		msg->msg_namelen = namelen;
+		msg->msg_namelen = sizeof(sll);
 	}
 
 	/* Include the header in raw delivery */
-- 
2.31.1

