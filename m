From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 07/31] net/udp: allow retrieving irq timestamp with SIOCGSTAMP
 ioctl
Date: Tue, 11 May 2021 18:05:11 +0200
Message-Id: <20210511160535.26580-8-jean-baptiste.tredez@alstefgroup.com>
In-Reply-To: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/include/rtnet_socket.h | 2 ++
 kernel/drivers/net/stack/ipv4/udp/udp.c         | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/drivers/net/stack/include/rtnet_socket.h b/kernel/drivers/net/stack/include/rtnet_socket.h
index af972c1a5..61bf8bea5 100644
--- a/kernel/drivers/net/stack/include/rtnet_socket.h
+++ b/kernel/drivers/net/stack/include/rtnet_socket.h
@@ -79,6 +79,8 @@ struct rtsocket {
 			int ifindex;
 		} packet;
 	} prot;
+
+	u64 timestamp;
 };
 
 static inline struct rtdm_fd *rt_socket_fd(struct rtsocket *sock)
diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index dcaec5618..beceb28cf 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -359,6 +359,8 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
 	const struct _rtdm_setsockaddr_args *setaddr;
 	struct _rtdm_setsockaddr_args _setaddr;
+	unsigned long ns;
+	struct timeval tv;
 
 	/* fast path for common socket IOCTLs */
 	if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)
@@ -377,6 +379,12 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
 		return rt_udp_connect(fd, sock, setaddr->addr,
 				      setaddr->addrlen);
 
+	case SIOCGSTAMP:
+		tv.tv_sec = xnclock_divrem_billion(sock->timestamp, &ns);
+		tv.tv_usec = ns / 1000;
+
+		return copy_to_user(arg, &tv, sizeof(tv));
+
 	default:
 		return rt_ip_ioctl(fd, request, arg);
 	}
@@ -464,6 +472,7 @@ ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
 
 	/* iterate over all IP fragments */
 	do {
+		sock->timestamp = skb->time_stamp;
 		rtskb_trim(skb, data_len);
 
 		block_size = skb->len;
-- 
2.17.1


