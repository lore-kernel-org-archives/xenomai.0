From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 3/5] net/ipv4: ioctl: remove direct references to user memory
Date: Fri, 22 Mar 2019 10:59:33 +0100
Message-Id: <20190322095935.8066-4-rpm@xenomai.org>
In-Reply-To: <20190322095935.8066-1-rpm@xenomai.org>
References: <20190322095935.8066-1-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/ipv4/ip_sock.c | 172 +++++++++++++++++-------
 1 file changed, 123 insertions(+), 49 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/ip_sock.c b/kernel/drivers/net/stack/ipv4/ip_sock.c
index 96944a891..26bde8658 100644
--- a/kernel/drivers/net/stack/ipv4/ip_sock.c
+++ b/kernel/drivers/net/stack/ipv4/ip_sock.c
@@ -28,9 +28,10 @@
 #include <rtnet_socket.h>
 #include <ipv4/igmp.h>
 
-int rt_ip_setsockopt(struct rtsocket *s, int level, int optname,
-		     const void *optval, socklen_t optlen)
+static int rt_ip_setsockopt(struct rtdm_fd *fd, int level, int optname,
+		     const void __user *u_optval, socklen_t optlen)
 {
+	struct rtsocket *s = rtdm_fd_to_private(fd);
 	int err = 0, in_rt;
 
 	if (level != SOL_IP)
@@ -39,16 +40,24 @@ int rt_ip_setsockopt(struct rtsocket *s, int level, int optname,
 	in_rt = rtdm_in_rt_context();
 
 	switch (optname) {
-	case IP_TOS:
+	case IP_TOS: {
+		unsigned int *tos, _tos;
+
 		if (optlen < sizeof(unsigned int))
 			return -EINVAL;
 
-		s->prot.inet.tos = *(unsigned int *)optval;
+		tos = rtnet_get_arg(fd, &_tos, u_optval, sizeof(_tos));
+		if (IS_ERR(tos))
+			return PTR_ERR(tos);
+
+		s->prot.inet.tos = *tos;
 		break;
+	}
 
 #ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_IGMP
 	case IP_ADD_MEMBERSHIP: {
-		struct ip_mreq *mreq = (struct ip_mreq *)optval;
+		const struct ip_mreq *mreq;
+		struct ip_mreq _mreq;
 
 		if (optlen < sizeof(*mreq))
 			return -EINVAL;
@@ -56,12 +65,17 @@ int rt_ip_setsockopt(struct rtsocket *s, int level, int optname,
 		if (!in_rt)
 			return -ENOSYS;
 
+		mreq = rtnet_get_arg(fd, &_mreq, u_optval, sizeof(_mreq));
+		if (IS_ERR(mreq))
+			return PTR_ERR(mreq);
+
 		err = rt_ip_mc_join_group(s, mreq);
 		break;
 	}
 
 	case IP_DROP_MEMBERSHIP: {
-		struct ip_mreq *mreq = (struct ip_mreq *)optval;
+		const struct ip_mreq *mreq;
+		struct ip_mreq _mreq;
 
 		if (optlen < sizeof(*mreq))
 			return -EINVAL;
@@ -69,23 +83,35 @@ int rt_ip_setsockopt(struct rtsocket *s, int level, int optname,
 		if (!in_rt)
 			return -ENOSYS;
 
+		mreq = rtnet_get_arg(fd, &_mreq, u_optval, sizeof(_mreq));
+		if (IS_ERR(mreq))
+			return PTR_ERR(mreq);
+
 		err = rt_ip_mc_leave_group(s, mreq);
 		break;
 	}
 
 	case IP_MULTICAST_IF: {
-	    struct ip_mreq mreq;
-
-	    if (optlen < sizeof(struct in_addr))
-		return -EINVAL;
+		if (optlen < sizeof(struct in_addr))
+			return -EINVAL;
 
-	    if (optlen >= sizeof(mreq))
-		memcpy(&mreq, optval, sizeof(mreq));
-	    else
-		memcpy(&mreq.imr_interface, optval, sizeof(mreq.imr_interface));
+		if (optlen >= sizeof(struct ip_mreq)) {
+			const struct ip_mreq *mreq;
+			struct ip_mreq _mreq;
+			mreq = rtnet_get_arg(fd, &_mreq, u_optval, sizeof(_mreq));
+			if (IS_ERR(mreq))
+				return PTR_ERR(mreq);
+			s->prot.inet.mc_if_addr = mreq->imr_interface.s_addr;
+		} else {
+			const struct in_addr *in_addr;
+			struct in_addr _in_addr;
+			in_addr = rtnet_get_arg(fd, &_in_addr, u_optval, sizeof(_in_addr));
+			if (IS_ERR(in_addr))
+				return PTR_ERR(in_addr);
+			s->prot.inet.mc_if_addr = in_addr->s_addr;
+		}
 
-	    s->prot.inet.mc_if_addr = mreq.imr_interface.s_addr;
-	    break;
+		break;
 	}
 #endif
 	default:
@@ -96,18 +122,30 @@ int rt_ip_setsockopt(struct rtsocket *s, int level, int optname,
 	return err;
 }
 
-int rt_ip_getsockopt(struct rtsocket *s, int level, int optname,
-		     void *optval, socklen_t * optlen)
+static int rt_ip_getsockopt(struct rtdm_fd *fd, int level, int optname,
+		     void __user *u_optval, socklen_t __user *u_optlen)
 {
+	struct rtsocket *s = rtdm_fd_to_private(fd);
+	socklen_t *optlen, _optlen;
+	unsigned int tos;
 	int err = 0;
 
-	if (*optlen < sizeof(unsigned int))
-		return -EINVAL;
+	optlen = rtnet_get_arg(fd, &_optlen, u_optlen, sizeof(_optlen));
+	if (IS_ERR(optlen))
+		return PTR_ERR(optlen);
 
 	switch (optname) {
 	case IP_TOS:
-		*(unsigned int *)optval = s->prot.inet.tos;
-		*optlen = sizeof(unsigned int);
+		if (*optlen < sizeof(tos))
+			return -EINVAL;
+		tos = s->prot.inet.tos;
+		err = rtnet_put_arg(fd, u_optval, &tos, sizeof(tos));
+		if (err)
+			return err;
+		*optlen = sizeof(tos);
+		err = rtnet_put_arg(fd, u_optlen, optlen, sizeof(*optlen));
+		if (err)
+			return err;
 		break;
 
 	default:
@@ -118,65 +156,101 @@ int rt_ip_getsockopt(struct rtsocket *s, int level, int optname,
 	return err;
 }
 
-int rt_ip_getsockname(struct rtsocket *s, struct sockaddr *addr,
-		      socklen_t * addrlen)
+static int rt_ip_getsockname(struct rtdm_fd *fd,
+			struct sockaddr __user *u_addr,
+			socklen_t __user *u_addrlen)
 {
-	struct sockaddr_in *usin = (struct sockaddr_in *)addr;
+	struct rtsocket *s = rtdm_fd_to_private(fd);
+	socklen_t *addrlen, _addrlen;
+	struct sockaddr_in in;
+	int err;
+
+	addrlen = rtnet_get_arg(fd, &_addrlen, u_addrlen, sizeof(_addrlen));
+	if (IS_ERR(addrlen))
+		return PTR_ERR(addrlen);
 
 	if (*addrlen < sizeof(struct sockaddr_in))
 		return -EINVAL;
 
-	usin->sin_family = AF_INET;
-	usin->sin_addr.s_addr = s->prot.inet.saddr;
-	usin->sin_port = s->prot.inet.sport;
+	in.sin_family = AF_INET;
+	in.sin_addr.s_addr = s->prot.inet.saddr;
+	in.sin_port = s->prot.inet.sport;
+	memset(in.sin_zero, 0, sizeof(in.sin_zero));
 
-	memset(usin->sin_zero, 0, sizeof(usin->sin_zero));
+	err = rtnet_put_arg(fd, u_addr, &in, sizeof(in));
+	if (err)
+		return err;
 
-	*addrlen = sizeof(struct sockaddr_in);
+	*addrlen = sizeof(in);
 
-	return 0;
+	return rtnet_put_arg(fd, u_addrlen, addrlen, sizeof(*addrlen));
 }
 
-int rt_ip_getpeername(struct rtsocket *s, struct sockaddr *addr,
-		      socklen_t * addrlen)
+static int rt_ip_getpeername(struct rtdm_fd *fd,
+			struct sockaddr __user *u_addr,
+			socklen_t __user *u_addrlen)
 {
-	struct sockaddr_in *usin = (struct sockaddr_in *)addr;
+	struct rtsocket *s = rtdm_fd_to_private(fd);
+	socklen_t *addrlen, _addrlen;
+	struct sockaddr_in in;
+	int err;
+
+	addrlen = rtnet_get_arg(fd, &_addrlen, u_addrlen, sizeof(_addrlen));
+	if (IS_ERR(addrlen))
+		return PTR_ERR(addrlen);
 
 	if (*addrlen < sizeof(struct sockaddr_in))
 		return -EINVAL;
 
-	usin->sin_family = AF_INET;
-	usin->sin_addr.s_addr = s->prot.inet.daddr;
-	usin->sin_port = s->prot.inet.dport;
+	in.sin_family = AF_INET;
+	in.sin_addr.s_addr = s->prot.inet.daddr;
+	in.sin_port = s->prot.inet.dport;
+	memset(in.sin_zero, 0, sizeof(in.sin_zero));
 
-	memset(usin->sin_zero, 0, sizeof(usin->sin_zero));
+	err = rtnet_put_arg(fd, u_addr, &in, sizeof(in));
+	if (err)
+		return err;
 
-	*addrlen = sizeof(struct sockaddr_in);
+	*addrlen = sizeof(in);
 
-	return 0;
+	return rtnet_put_arg(fd, u_addrlen, addrlen, sizeof(*addrlen));
 }
 
-int rt_ip_ioctl(struct rtdm_fd *fd, int request, void *arg)
+int rt_ip_ioctl(struct rtdm_fd *fd, int request, void __user *arg)
 {
-	struct rtsocket *sock = rtdm_fd_to_private(fd);
-	struct _rtdm_getsockaddr_args *getaddr = arg;
-	struct _rtdm_getsockopt_args *getopt = arg;
-	struct _rtdm_setsockopt_args *setopt = arg;
+	const struct _rtdm_getsockopt_args *getopt;
+	struct _rtdm_getsockopt_args _getopt;
+	const struct _rtdm_setsockopt_args *setopt;
+	struct _rtdm_setsockopt_args _setopt;
+	const struct _rtdm_getsockaddr_args *getaddr;
+	struct _rtdm_getsockaddr_args _getaddr;
 
 	switch (request) {
 	case _RTIOC_SETSOCKOPT:
-		return rt_ip_setsockopt(sock, setopt->level, setopt->optname,
+		setopt = rtnet_get_arg(fd, &_setopt, arg, sizeof(_setopt));
+		if (IS_ERR(setopt))
+			return PTR_ERR(setopt);
+		return rt_ip_setsockopt(fd, setopt->level, setopt->optname,
 					setopt->optval, setopt->optlen);
 
 	case _RTIOC_GETSOCKOPT:
-		return rt_ip_getsockopt(sock, getopt->level, getopt->optname,
+		getopt = rtnet_get_arg(fd, &_getopt, arg, sizeof(_getopt));
+		if (IS_ERR(getopt))
+			return PTR_ERR(getopt);
+		return rt_ip_getsockopt(fd, getopt->level, getopt->optname,
 					getopt->optval, getopt->optlen);
 
 	case _RTIOC_GETSOCKNAME:
-		return rt_ip_getsockname(sock, getaddr->addr, getaddr->addrlen);
+		getaddr = rtnet_get_arg(fd, &_getaddr, arg, sizeof(_getaddr));
+		if (IS_ERR(getaddr))
+			return PTR_ERR(getaddr);
+		return rt_ip_getsockname(fd, getaddr->addr, getaddr->addrlen);
 
 	case _RTIOC_GETPEERNAME:
-		return rt_ip_getpeername(sock, getaddr->addr, getaddr->addrlen);
+		getaddr = rtnet_get_arg(fd, &_getaddr, arg, sizeof(_getaddr));
+		if (IS_ERR(getaddr))
+			return PTR_ERR(getaddr);
+		return rt_ip_getpeername(fd, getaddr->addr, getaddr->addrlen);
 
 	default:
 		return rt_socket_if_ioctl(fd, request, arg);
-- 
2.20.1


