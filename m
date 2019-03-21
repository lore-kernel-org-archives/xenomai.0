From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 06/16] net/udp: allow retrieving irq timestamp with SIOCGSTAMP
 ioctl
Date: Thu, 21 Mar 2019 18:13:20 +0100
Message-Id: <20190321171330.2073-7-rpm@xenomai.org>
In-Reply-To: <20190321171330.2073-1-rpm@xenomai.org>
References: <20190321171330.2073-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/include/rtnet_socket.h | 2 ++
 kernel/drivers/net/stack/ipv4/udp/udp.c         | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/drivers/net/stack/include/rtnet_socket.h b/kernel/drivers/net/stack/include/rtnet_socket.h
index dbf9b7c16..8fe128efd 100644
--- a/kernel/drivers/net/stack/include/rtnet_socket.h
+++ b/kernel/drivers/net/stack/include/rtnet_socket.h
@@ -80,6 +80,8 @@ struct rtsocket {
 		} packet;
 	} prot;
 
+	u64 timestamp;
+
 	struct module *owner;
 };
 
diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index d4003d2ee..8539fe87a 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -361,6 +361,8 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user * arg)
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
 	const struct _rtdm_setsockaddr_args *setaddr;
 	struct _rtdm_setsockaddr_args _setaddr;
+	unsigned long ns;
+	struct timeval tv;
 
 	/* fast path for common socket IOCTLs */
 	if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)
@@ -379,6 +381,12 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user * arg)
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
@@ -472,6 +480,7 @@ ssize_t rt_udp_recvmsg(struct rtdm_fd * fd, struct user_msghdr * u_msg,
 
 	/* iterate over all IP fragments */
 	do {
+		sock->timestamp = skb->time_stamp;
 		rtskb_trim(skb, data_len);
 
 		block_size = skb->len;
-- 
2.20.1


