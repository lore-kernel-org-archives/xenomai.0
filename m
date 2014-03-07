From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Fri,  7 Mar 2014 21:20:38 +0100
Message-Id: <1394223638-13070-9-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <531A29CC.4040201@xenomai.org>
 <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 9/9] drivers/ipc: adapt BUFP after RTDM changes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 kernel/drivers/ipc/bufp.c |  114 +++++++++++++++++++++++----------------------
 1 file changed, 58 insertions(+), 56 deletions(-)

diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
index 4363c68..6e80148 100644
--- a/kernel/drivers/ipc/bufp.c
+++ b/kernel/drivers/ipc/bufp.c
@@ -113,7 +113,7 @@ static struct xnpnode_link __bufp_pnode = {
 #endif /* !CONFIG_XENO_OPT_VFILE */
 
 static int bufp_socket(struct rtipc_private *priv,
-		       rtdm_user_info_t *user_info)
+		       struct rtdm_fd *context)
 {
 	struct bufp_socket *sk = priv->state;
 
@@ -139,8 +139,8 @@ static int bufp_socket(struct rtipc_private *priv,
 	return 0;
 }
 
-static int bufp_close(struct rtipc_private *priv,
-		      rtdm_user_info_t *user_info)
+static void bufp_close(struct rtipc_private *priv,
+		struct rtdm_fd *context)
 {
 	struct bufp_socket *sk = priv->state;
 
@@ -148,7 +148,9 @@ static int bufp_close(struct rtipc_private *priv,
 	rtdm_event_destroy(&sk->o_event);
 
 	if (sk->name.sipc_port > -1)
-		xnmap_remove(portmap, sk->name.sipc_port);
+		RTDM_EXECUTE_ATOMICALLY(
+			xnmap_remove(portmap, sk->name.sipc_port);
+		);
 
 	if (sk->handle)
 		xnregistry_remove(sk->handle);
@@ -157,8 +159,6 @@ static int bufp_close(struct rtipc_private *priv,
 		free_pages_exact(sk->bufmem, sk->bufsz);
 
 	kfree(sk);
-
-	return 0;
 }
 
 static ssize_t __bufp_readbuf(struct bufp_socket *sk,
@@ -290,7 +290,7 @@ out:
 }
 
 static ssize_t __bufp_recvmsg(struct rtipc_private *priv,
-			      rtdm_user_info_t *user_info,
+			      struct rtdm_fd *context,
 			      struct iovec *iov, int iovlen, int flags,
 			      struct sockaddr_ipc *saddr)
 {
@@ -321,7 +321,7 @@ static ssize_t __bufp_recvmsg(struct rtipc_private *priv,
 		if (iov[nvec].iov_len == 0)
 			continue;
 		vlen = wrlen >= iov[nvec].iov_len ? iov[nvec].iov_len : wrlen;
-		if (user_info) {
+		if (rtdm_context_user_p(context)) {
 			xnbufd_map_uread(&bufd, iov[nvec].iov_base, vlen);
 			ret = __bufp_readbuf(sk, &bufd, flags);
 			xnbufd_unmap_uread(&bufd);
@@ -352,7 +352,7 @@ static ssize_t __bufp_recvmsg(struct rtipc_private *priv,
 }
 
 static ssize_t bufp_recvmsg(struct rtipc_private *priv,
-			    rtdm_user_info_t *user_info,
+			    struct rtdm_fd *context,
 			    struct msghdr *msg, int flags)
 {
 	struct iovec iov[RTIPC_IOV_MAX];
@@ -372,23 +372,23 @@ static ssize_t bufp_recvmsg(struct rtipc_private *priv,
 		return -EINVAL;
 
 	/* Copy I/O vector in */
-	if (rtipc_get_arg(user_info, iov, msg->msg_iov,
+	if (rtipc_get_arg(context, iov, msg->msg_iov,
 			  sizeof(iov[0]) * msg->msg_iovlen))
 		return -EFAULT;
 
-	ret = __bufp_recvmsg(priv, user_info,
+	ret = __bufp_recvmsg(priv, context,
 			     iov, msg->msg_iovlen, flags, &saddr);
 	if (ret <= 0)
 		return ret;
 
 	/* Copy the updated I/O vector back */
-	if (rtipc_put_arg(user_info, msg->msg_iov, iov,
+	if (rtipc_put_arg(context, msg->msg_iov, iov,
 			  sizeof(iov[0]) * msg->msg_iovlen))
 		return -EFAULT;
 
 	/* Copy the source address if required. */
 	if (msg->msg_name) {
-		if (rtipc_put_arg(user_info, msg->msg_name,
+		if (rtipc_put_arg(context, msg->msg_name,
 				  &saddr, sizeof(saddr)))
 			return -EFAULT;
 		msg->msg_namelen = sizeof(struct sockaddr_ipc);
@@ -398,11 +398,11 @@ static ssize_t bufp_recvmsg(struct rtipc_private *priv,
 }
 
 static ssize_t bufp_read(struct rtipc_private *priv,
-			 rtdm_user_info_t *user_info,
+			 struct rtdm_fd *context,
 			 void *buf, size_t len)
 {
 	struct iovec iov = { .iov_base = buf, .iov_len = len };
-	return __bufp_recvmsg(priv, user_info, &iov, 1, 0, NULL);
+	return __bufp_recvmsg(priv, context, &iov, 1, 0, NULL);
 }
 
 static ssize_t __bufp_writebuf(struct bufp_socket *rsk,
@@ -522,26 +522,25 @@ out:
 }
 
 static ssize_t __bufp_sendmsg(struct rtipc_private *priv,
-			      rtdm_user_info_t *user_info,
+			      struct rtdm_fd *context,
 			      struct iovec *iov, int iovlen, int flags,
 			      const struct sockaddr_ipc *daddr)
 {
 	struct bufp_socket *sk = priv->state, *rsk;
-	struct rtdm_dev_context *rcontext;
 	ssize_t len, rdlen, vlen, ret = 0;
+	struct rtdm_fd *rcontext;
 	struct xnbufd bufd;
 	int nvec;
-	void *p;
 
 	len = rtipc_get_iov_flatlen(iov, iovlen);
 	if (len == 0)
 		return 0;
-
-	p = xnmap_fetch_nocheck(portmap, daddr->sipc_port);
-	if (p == NULL)
-		return -ECONNRESET;
-
-	rcontext = rtdm_context_get(rtipc_map2fd(p));
+	
+	RTDM_EXECUTE_ATOMICALLY(
+		rcontext = xnmap_fetch_nocheck(portmap, daddr->sipc_port);
+		if (rcontext && rtdm_context_lock(rcontext) < 0)
+			rcontext = NULL;
+	);
 	if (rcontext == NULL)
 		return -ECONNRESET;
 
@@ -569,7 +568,7 @@ static ssize_t __bufp_sendmsg(struct rtipc_private *priv,
 		if (iov[nvec].iov_len == 0)
 			continue;
 		vlen = rdlen >= iov[nvec].iov_len ? iov[nvec].iov_len : rdlen;
-		if (user_info) {
+		if (rtdm_context_user_p(context)) {
 			xnbufd_map_uread(&bufd, iov[nvec].iov_base, vlen);
 			ret = __bufp_writebuf(rsk, sk, &bufd, flags);
 			xnbufd_unmap_uread(&bufd);
@@ -596,7 +595,7 @@ fail:
 }
 
 static ssize_t bufp_sendmsg(struct rtipc_private *priv,
-			    rtdm_user_info_t *user_info,
+			    struct rtdm_fd *context,
 			    const struct msghdr *msg, int flags)
 {
 	struct bufp_socket *sk = priv->state;
@@ -612,7 +611,7 @@ static ssize_t bufp_sendmsg(struct rtipc_private *priv,
 			return -EINVAL;
 
 		/* Fetch the destination address to send to. */
-		if (rtipc_get_arg(user_info, &daddr,
+		if (rtipc_get_arg(context, &daddr,
 				  msg->msg_name, sizeof(daddr)))
 			return -EFAULT;
 
@@ -631,17 +630,17 @@ static ssize_t bufp_sendmsg(struct rtipc_private *priv,
 		return -EINVAL;
 
 	/* Copy I/O vector in */
-	if (rtipc_get_arg(user_info, iov, msg->msg_iov,
+	if (rtipc_get_arg(context, iov, msg->msg_iov,
 			  sizeof(iov[0]) * msg->msg_iovlen))
 		return -EFAULT;
 
-	ret = __bufp_sendmsg(priv, user_info, iov,
+	ret = __bufp_sendmsg(priv, context, iov,
 			     msg->msg_iovlen, flags, &daddr);
 	if (ret <= 0)
 		return ret;
 
 	/* Copy updated I/O vector back */
-	if (rtipc_put_arg(user_info, msg->msg_iov, iov,
+	if (rtipc_put_arg(context, msg->msg_iov, iov,
 			  sizeof(iov[0]) * msg->msg_iovlen))
 		return -EFAULT;
 
@@ -649,7 +648,7 @@ static ssize_t bufp_sendmsg(struct rtipc_private *priv,
 }
 
 static ssize_t bufp_write(struct rtipc_private *priv,
-			  rtdm_user_info_t *user_info,
+			  struct rtdm_fd *context,
 			  const void *buf, size_t len)
 {
 	struct iovec iov = { .iov_base = (void *)buf, .iov_len = len };
@@ -658,14 +657,15 @@ static ssize_t bufp_write(struct rtipc_private *priv,
 	if (sk->peer.sipc_port < 0)
 		return -EDESTADDRREQ;
 
-	return __bufp_sendmsg(priv, user_info, &iov, 1, 0, &sk->peer);
+	return __bufp_sendmsg(priv, context, &iov, 1, 0, &sk->peer);
 }
 
 static int __bufp_bind_socket(struct rtipc_private *priv,
 			      struct sockaddr_ipc *sa)
 {
 	struct bufp_socket *sk = priv->state;
-	int ret = 0, port, fd;
+	int ret = 0, port;
+	struct rtdm_fd *fd;
 
 	if (sa->sipc_family != AF_RTIPC)
 		return -EINVAL;
@@ -684,8 +684,10 @@ static int __bufp_bind_socket(struct rtipc_private *priv,
 
 	/* Will auto-select a free port number if unspec (-1). */
 	port = sa->sipc_port;
-	fd = rtdm_private_to_context(priv)->fd;
-	port = xnmap_enter(portmap, port, rtipc_fd2map(fd));
+	fd = rtdm_private_to_context(priv);
+	RTDM_EXECUTE_ATOMICALLY(
+		port = xnmap_enter(portmap, port, fd);
+	);
 	if (port < 0)
 		return port == -EEXIST ? -EADDRINUSE : -ENOMEM;
 
@@ -797,7 +799,7 @@ set_assoc:
 }
 
 static int __bufp_setsockopt(struct bufp_socket *sk,
-			     rtdm_user_info_t *user_info,
+			     struct rtdm_fd *context,
 			     void *arg)
 {
 	struct _rtdm_setsockopt_args sopt;
@@ -806,7 +808,7 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 	int ret = 0;
 	size_t len;
 
-	if (rtipc_get_arg(user_info, &sopt, arg, sizeof(sopt)))
+	if (rtipc_get_arg(context, &sopt, arg, sizeof(sopt)))
 		return -EFAULT;
 
 	if (sopt.level == SOL_SOCKET) {
@@ -815,7 +817,7 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 		case SO_RCVTIMEO:
 			if (sopt.optlen != sizeof(tv))
 				return -EINVAL;
-			if (rtipc_get_arg(user_info, &tv,
+			if (rtipc_get_arg(context, &tv,
 					  sopt.optval, sizeof(tv)))
 				return -EFAULT;
 			sk->rx_timeout = rtipc_timeval_to_ns(&tv);
@@ -824,7 +826,7 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 		case SO_SNDTIMEO:
 			if (sopt.optlen != sizeof(tv))
 				return -EINVAL;
-			if (rtipc_get_arg(user_info, &tv,
+			if (rtipc_get_arg(context, &tv,
 					  sopt.optval, sizeof(tv)))
 				return -EFAULT;
 			sk->tx_timeout = rtipc_timeval_to_ns(&tv);
@@ -845,7 +847,7 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 	case BUFP_BUFSZ:
 		if (sopt.optlen != sizeof(len))
 			return -EINVAL;
-		if (rtipc_get_arg(user_info, &len,
+		if (rtipc_get_arg(context, &len,
 				  sopt.optval, sizeof(len)))
 			return -EFAULT;
 		if (len == 0)
@@ -866,7 +868,7 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 	case BUFP_LABEL:
 		if (sopt.optlen < sizeof(plabel))
 			return -EINVAL;
-		if (rtipc_get_arg(user_info, &plabel,
+		if (rtipc_get_arg(context, &plabel,
 				  sopt.optval, sizeof(plabel)))
 			return -EFAULT;
 		RTDM_EXECUTE_ATOMICALLY(
@@ -891,7 +893,7 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 }
 
 static int __bufp_getsockopt(struct bufp_socket *sk,
-			     rtdm_user_info_t *user_info,
+			     struct rtdm_fd *context,
 			     void *arg)
 {
 	struct _rtdm_getsockopt_args sopt;
@@ -900,10 +902,10 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 	socklen_t len;
 	int ret = 0;
 
-	if (rtipc_get_arg(user_info, &sopt, arg, sizeof(sopt)))
+	if (rtipc_get_arg(context, &sopt, arg, sizeof(sopt)))
 		return -EFAULT;
 
-	if (rtipc_get_arg(user_info, &len, sopt.optlen, sizeof(len)))
+	if (rtipc_get_arg(context, &len, sopt.optlen, sizeof(len)))
 		return -EFAULT;
 
 	if (sopt.level == SOL_SOCKET) {
@@ -913,7 +915,7 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 			if (len != sizeof(tv))
 				return -EINVAL;
 			rtipc_ns_to_timeval(&tv, sk->rx_timeout);
-			if (rtipc_put_arg(user_info, sopt.optval,
+			if (rtipc_put_arg(context, sopt.optval,
 					  &tv, sizeof(tv)))
 				return -EFAULT;
 			break;
@@ -922,7 +924,7 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 			if (len != sizeof(tv))
 				return -EINVAL;
 			rtipc_ns_to_timeval(&tv, sk->tx_timeout);
-			if (rtipc_put_arg(user_info, sopt.optval,
+			if (rtipc_put_arg(context, sopt.optval,
 					  &tv, sizeof(tv)))
 				return -EFAULT;
 			break;
@@ -945,7 +947,7 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 		RTDM_EXECUTE_ATOMICALLY(
 			strcpy(plabel.label, sk->label);
 		);
-		if (rtipc_put_arg(user_info, sopt.optval,
+		if (rtipc_put_arg(context, sopt.optval,
 				  &plabel, sizeof(plabel)))
 			return -EFAULT;
 		break;
@@ -958,7 +960,7 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 }
 
 static int __bufp_ioctl(struct rtipc_private *priv,
-			rtdm_user_info_t *user_info,
+			struct rtdm_fd *context,
 			unsigned int request, void *arg)
 {
 	struct sockaddr_ipc saddr, *saddrp = &saddr;
@@ -968,14 +970,14 @@ static int __bufp_ioctl(struct rtipc_private *priv,
 	switch (request) {
 
 	case _RTIOC_CONNECT:
-		ret = rtipc_get_sockaddr(user_info, arg, &saddrp);
+		ret = rtipc_get_sockaddr(context, arg, &saddrp);
 		if (ret)
 		  return ret;
 		ret = __bufp_connect_socket(sk, saddrp);
 		break;
 
 	case _RTIOC_BIND:
-		ret = rtipc_get_sockaddr(user_info, arg, &saddrp);
+		ret = rtipc_get_sockaddr(context, arg, &saddrp);
 		if (ret)
 			return ret;
 		if (saddrp == NULL)
@@ -984,19 +986,19 @@ static int __bufp_ioctl(struct rtipc_private *priv,
 		break;
 
 	case _RTIOC_GETSOCKNAME:
-		ret = rtipc_put_sockaddr(user_info, arg, &sk->name);
+		ret = rtipc_put_sockaddr(context, arg, &sk->name);
 		break;
 
 	case _RTIOC_GETPEERNAME:
-		ret = rtipc_put_sockaddr(user_info, arg, &sk->peer);
+		ret = rtipc_put_sockaddr(context, arg, &sk->peer);
 		break;
 
 	case _RTIOC_SETSOCKOPT:
-		ret = __bufp_setsockopt(sk, user_info, arg);
+		ret = __bufp_setsockopt(sk, context, arg);
 		break;
 
 	case _RTIOC_GETSOCKOPT:
-		ret = __bufp_getsockopt(sk, user_info, arg);
+		ret = __bufp_getsockopt(sk, context, arg);
 		break;
 
 	case _RTIOC_LISTEN:
@@ -1016,13 +1018,13 @@ static int __bufp_ioctl(struct rtipc_private *priv,
 }
 
 static int bufp_ioctl(struct rtipc_private *priv,
-		      rtdm_user_info_t *user_info,
+		      struct rtdm_fd *context,
 		      unsigned int request, void *arg)
 {
 	if (rtdm_in_rt_context() && request == _RTIOC_BIND)
 		return -ENOSYS;	/* Try downgrading to NRT */
 
-	return __bufp_ioctl(priv, user_info, request, arg);
+	return __bufp_ioctl(priv, context, request, arg);
 }
 
 static int bufp_init(void)
-- 
1.7.10.4


