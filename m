From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Fri,  7 Mar 2014 21:20:37 +0100
Message-Id: <1394223638-13070-8-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <531A29CC.4040201@xenomai.org>
 <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 8/9] drivers/ipc: adapt IDDP after RTDM changes
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
 kernel/drivers/ipc/iddp.c     |  114 +++++++++++++++++++++--------------------
 kernel/drivers/ipc/internal.h |   10 ----
 2 files changed, 59 insertions(+), 65 deletions(-)

diff --git a/kernel/drivers/ipc/iddp.c b/kernel/drivers/ipc/iddp.c
index 3fe43db..86b699a 100644
--- a/kernel/drivers/ipc/iddp.c
+++ b/kernel/drivers/ipc/iddp.c
@@ -192,7 +192,7 @@ static void __iddp_flush_pool(struct xnheap *heap,
 }
 
 static int iddp_socket(struct rtipc_private *priv,
-		       rtdm_user_info_t *user_info)
+		       struct rtdm_fd *context)
 {
 	struct iddp_socket *sk = priv->state;
 
@@ -217,14 +217,16 @@ static int iddp_socket(struct rtipc_private *priv,
 	return 0;
 }
 
-static int iddp_close(struct rtipc_private *priv,
-		      rtdm_user_info_t *user_info)
+static void iddp_close(struct rtipc_private *priv,
+		struct rtdm_fd *context)
 {
 	struct iddp_socket *sk = priv->state;
 	struct iddp_message *mbuf;
 
 	if (sk->name.sipc_port > -1)
-		xnmap_remove(portmap, sk->name.sipc_port);
+		RTDM_EXECUTE_ATOMICALLY(
+			xnmap_remove(portmap, sk->name.sipc_port);
+		);
 
 	rtdm_sem_destroy(&sk->insem);
 	rtdm_event_destroy(&sk->privevt);
@@ -234,7 +236,7 @@ static int iddp_close(struct rtipc_private *priv,
 
 	if (sk->bufpool != &kheap) {
 		xnheap_destroy(&sk->privpool, __iddp_flush_pool, NULL);
-		return 0;
+		return;
 	}
 
 	/* Send unread datagrams back to the system heap. */
@@ -246,11 +248,11 @@ static int iddp_close(struct rtipc_private *priv,
 
 	kfree(sk);
 
-	return 0;
+	return;
 }
 
 static ssize_t __iddp_recvmsg(struct rtipc_private *priv,
-			      rtdm_user_info_t *user_info,
+			      struct rtdm_fd *context,
 			      struct iovec *iov, int iovlen, int flags,
 			      struct sockaddr_ipc *saddr)
 {
@@ -303,7 +305,7 @@ static ssize_t __iddp_recvmsg(struct rtipc_private *priv,
 		if (iov[nvec].iov_len == 0)
 			continue;
 		vlen = wrlen >= iov[nvec].iov_len ? iov[nvec].iov_len : wrlen;
-		if (user_info) {
+		if (rtdm_context_user_p(context)) {
 			xnbufd_map_uread(&bufd, iov[nvec].iov_base, vlen);
 			ret = xnbufd_copy_from_kmem(&bufd, mbuf->data + rdoff, vlen);
 			xnbufd_unmap_uread(&bufd);
@@ -327,7 +329,7 @@ static ssize_t __iddp_recvmsg(struct rtipc_private *priv,
 }
 
 static ssize_t iddp_recvmsg(struct rtipc_private *priv,
-			    rtdm_user_info_t *user_info,
+			    struct rtdm_fd *context,
 			    struct msghdr *msg, int flags)
 {
 	struct iovec iov[RTIPC_IOV_MAX];
@@ -347,23 +349,23 @@ static ssize_t iddp_recvmsg(struct rtipc_private *priv,
 		return -EINVAL;
 
 	/* Copy I/O vector in */
-	if (rtipc_get_arg(user_info, iov, msg->msg_iov,
+	if (rtipc_get_arg(context, iov, msg->msg_iov,
 			  sizeof(iov[0]) * msg->msg_iovlen))
 		return -EFAULT;
 
-	ret = __iddp_recvmsg(priv, user_info,
+	ret = __iddp_recvmsg(priv, context,
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
@@ -373,35 +375,34 @@ static ssize_t iddp_recvmsg(struct rtipc_private *priv,
 }
 
 static ssize_t iddp_read(struct rtipc_private *priv,
-			 rtdm_user_info_t *user_info,
+			 struct rtdm_fd *context,
 			 void *buf, size_t len)
 {
 	struct iovec iov = { .iov_base = buf, .iov_len = len };
-	return __iddp_recvmsg(priv, user_info, &iov, 1, 0, NULL);
+	return __iddp_recvmsg(priv, context, &iov, 1, 0, NULL);
 }
 
 static ssize_t __iddp_sendmsg(struct rtipc_private *priv,
-			      rtdm_user_info_t *user_info,
+			      struct rtdm_fd *context,
 			      struct iovec *iov, int iovlen, int flags,
 			      const struct sockaddr_ipc *daddr)
 {
 	struct iddp_socket *sk = priv->state, *rsk;
-	struct rtdm_dev_context *rcontext;
 	struct iddp_message *mbuf;
 	ssize_t len, rdlen, vlen;
+	struct rtdm_fd *rcontext;
 	int nvec, wroff, ret;
 	struct xnbufd bufd;
-	void *p;
 
 	len = rtipc_get_iov_flatlen(iov, iovlen);
 	if (len == 0)
 		return 0;
 
-	p = xnmap_fetch_nocheck(portmap, daddr->sipc_port);
-	if (p == NULL)
-		return -ECONNRESET;
-
-	rcontext = rtdm_context_get(rtipc_map2fd(p));
+	RTDM_EXECUTE_ATOMICALLY(
+		rcontext = xnmap_fetch_nocheck(portmap, daddr->sipc_port);
+		if (rcontext && rtdm_context_lock(rcontext) < 0)
+			rcontext = NULL;
+	);
 	if (rcontext == NULL)
 		return -ECONNRESET;
 
@@ -423,7 +424,7 @@ static ssize_t __iddp_sendmsg(struct rtipc_private *priv,
 		if (iov[nvec].iov_len == 0)
 			continue;
 		vlen = rdlen >= iov[nvec].iov_len ? iov[nvec].iov_len : rdlen;
-		if (user_info) {
+		if (rtdm_context_user_p(context)) {
 			xnbufd_map_uread(&bufd, iov[nvec].iov_base, vlen);
 			ret = xnbufd_copy_to_kmem(mbuf->data + wroff, &bufd, vlen);
 			xnbufd_unmap_uread(&bufd);
@@ -462,7 +463,7 @@ fail:
 }
 
 static ssize_t iddp_sendmsg(struct rtipc_private *priv,
-			    rtdm_user_info_t *user_info,
+			    struct rtdm_fd *context,
 			    const struct msghdr *msg, int flags)
 {
 	struct iddp_socket *sk = priv->state;
@@ -478,7 +479,7 @@ static ssize_t iddp_sendmsg(struct rtipc_private *priv,
 			return -EINVAL;
 
 		/* Fetch the destination address to send to. */
-		if (rtipc_get_arg(user_info, &daddr,
+		if (rtipc_get_arg(context, &daddr,
 				  msg->msg_name, sizeof(daddr)))
 			return -EFAULT;
 
@@ -497,17 +498,17 @@ static ssize_t iddp_sendmsg(struct rtipc_private *priv,
 		return -EINVAL;
 
 	/* Copy I/O vector in */
-	if (rtipc_get_arg(user_info, iov, msg->msg_iov,
+	if (rtipc_get_arg(context, iov, msg->msg_iov,
 			  sizeof(iov[0]) * msg->msg_iovlen))
 		return -EFAULT;
 
-	ret = __iddp_sendmsg(priv, user_info, iov,
+	ret = __iddp_sendmsg(priv, context, iov,
 			     msg->msg_iovlen, flags, &daddr);
 	if (ret <= 0)
 		return ret;
 
 	/* Copy updated I/O vector back */
-	if (rtipc_put_arg(user_info, msg->msg_iov, iov,
+	if (rtipc_put_arg(context, msg->msg_iov, iov,
 			  sizeof(iov[0]) * msg->msg_iovlen))
 		return -EFAULT;
 
@@ -515,7 +516,7 @@ static ssize_t iddp_sendmsg(struct rtipc_private *priv,
 }
 
 static ssize_t iddp_write(struct rtipc_private *priv,
-			  rtdm_user_info_t *user_info,
+			  struct rtdm_fd *context,
 			  const void *buf, size_t len)
 {
 	struct iovec iov = { .iov_base = (void *)buf, .iov_len = len };
@@ -524,14 +525,15 @@ static ssize_t iddp_write(struct rtipc_private *priv,
 	if (sk->peer.sipc_port < 0)
 		return -EDESTADDRREQ;
 
-	return __iddp_sendmsg(priv, user_info, &iov, 1, 0, &sk->peer);
+	return __iddp_sendmsg(priv, context, &iov, 1, 0, &sk->peer);
 }
 
 static int __iddp_bind_socket(struct rtipc_private *priv,
 			      struct sockaddr_ipc *sa)
 {
 	struct iddp_socket *sk = priv->state;
-	int ret = 0, port, fd;
+	int ret = 0, port;
+	struct rtdm_fd *fd;
 	void *poolmem;
 	size_t poolsz;
 
@@ -552,8 +554,10 @@ static int __iddp_bind_socket(struct rtipc_private *priv,
 
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
 
@@ -680,7 +684,7 @@ set_assoc:
 }
 
 static int __iddp_setsockopt(struct iddp_socket *sk,
-			     rtdm_user_info_t *user_info,
+			     struct rtdm_fd *context,
 			     void *arg)
 {
 	struct _rtdm_setsockopt_args sopt;
@@ -689,7 +693,7 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 	int ret = 0;
 	size_t len;
 
-	if (rtipc_get_arg(user_info, &sopt, arg, sizeof(sopt)))
+	if (rtipc_get_arg(context, &sopt, arg, sizeof(sopt)))
 		return -EFAULT;
 
 	if (sopt.level == SOL_SOCKET) {
@@ -698,7 +702,7 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 		case SO_RCVTIMEO:
 			if (sopt.optlen != sizeof(tv))
 				return -EINVAL;
-			if (rtipc_get_arg(user_info, &tv,
+			if (rtipc_get_arg(context, &tv,
 					  sopt.optval, sizeof(tv)))
 				return -EFAULT;
 			sk->rx_timeout = rtipc_timeval_to_ns(&tv);
@@ -707,7 +711,7 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 		case SO_SNDTIMEO:
 			if (sopt.optlen != sizeof(tv))
 				return -EINVAL;
-			if (rtipc_get_arg(user_info, &tv,
+			if (rtipc_get_arg(context, &tv,
 					  sopt.optval, sizeof(tv)))
 				return -EFAULT;
 			sk->tx_timeout = rtipc_timeval_to_ns(&tv);
@@ -728,7 +732,7 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 	case IDDP_POOLSZ:
 		if (sopt.optlen != sizeof(len))
 			return -EINVAL;
-		if (rtipc_get_arg(user_info, &len,
+		if (rtipc_get_arg(context, &len,
 				  sopt.optval, sizeof(len)))
 			return -EFAULT;
 		if (len == 0)
@@ -749,7 +753,7 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 	case IDDP_LABEL:
 		if (sopt.optlen < sizeof(plabel))
 			return -EINVAL;
-		if (rtipc_get_arg(user_info, &plabel,
+		if (rtipc_get_arg(context, &plabel,
 				  sopt.optval, sizeof(plabel)))
 			return -EFAULT;
 		RTDM_EXECUTE_ATOMICALLY(
@@ -774,7 +778,7 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 }
 
 static int __iddp_getsockopt(struct iddp_socket *sk,
-			     rtdm_user_info_t *user_info,
+			     struct rtdm_fd *context,
 			     void *arg)
 {
 	struct _rtdm_getsockopt_args sopt;
@@ -783,10 +787,10 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 	socklen_t len;
 	int ret = 0;
 
-	if (rtipc_get_arg(user_info, &sopt, arg, sizeof(sopt)))
+	if (rtipc_get_arg(context, &sopt, arg, sizeof(sopt)))
 		return -EFAULT;
 
-	if (rtipc_get_arg(user_info, &len, sopt.optlen, sizeof(len)))
+	if (rtipc_get_arg(context, &len, sopt.optlen, sizeof(len)))
 		return -EFAULT;
 
 	if (sopt.level == SOL_SOCKET) {
@@ -796,7 +800,7 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 			if (len != sizeof(tv))
 				return -EINVAL;
 			rtipc_ns_to_timeval(&tv, sk->rx_timeout);
-			if (rtipc_put_arg(user_info, sopt.optval,
+			if (rtipc_put_arg(context, sopt.optval,
 					  &tv, sizeof(tv)))
 				return -EFAULT;
 			break;
@@ -805,7 +809,7 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 			if (len != sizeof(tv))
 				return -EINVAL;
 			rtipc_ns_to_timeval(&tv, sk->tx_timeout);
-			if (rtipc_put_arg(user_info, sopt.optval,
+			if (rtipc_put_arg(context, sopt.optval,
 					  &tv, sizeof(tv)))
 				return -EFAULT;
 			break;
@@ -828,7 +832,7 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 		RTDM_EXECUTE_ATOMICALLY(
 			strcpy(plabel.label, sk->label);
 		);
-		if (rtipc_put_arg(user_info, sopt.optval,
+		if (rtipc_put_arg(context, sopt.optval,
 				  &plabel, sizeof(plabel)))
 			return -EFAULT;
 		break;
@@ -841,7 +845,7 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 }
 
 static int __iddp_ioctl(struct rtipc_private *priv,
-			rtdm_user_info_t *user_info,
+			struct rtdm_fd *context,
 			unsigned int request, void *arg)
 {
 	struct sockaddr_ipc saddr, *saddrp = &saddr;
@@ -851,14 +855,14 @@ static int __iddp_ioctl(struct rtipc_private *priv,
 	switch (request) {
 
 	case _RTIOC_CONNECT:
-		ret = rtipc_get_sockaddr(user_info, arg, &saddrp);
+		ret = rtipc_get_sockaddr(context, arg, &saddrp);
 		if (ret)
 		  return ret;
 		ret = __iddp_connect_socket(sk, saddrp);
 		break;
 
 	case _RTIOC_BIND:
-		ret = rtipc_get_sockaddr(user_info, arg, &saddrp);
+		ret = rtipc_get_sockaddr(context, arg, &saddrp);
 		if (ret)
 			return ret;
 		if (saddrp == NULL)
@@ -867,19 +871,19 @@ static int __iddp_ioctl(struct rtipc_private *priv,
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
-		ret = __iddp_setsockopt(sk, user_info, arg);
+		ret = __iddp_setsockopt(sk, context, arg);
 		break;
 
 	case _RTIOC_GETSOCKOPT:
-		ret = __iddp_getsockopt(sk, user_info, arg);
+		ret = __iddp_getsockopt(sk, context, arg);
 		break;
 
 	case _RTIOC_LISTEN:
@@ -899,13 +903,13 @@ static int __iddp_ioctl(struct rtipc_private *priv,
 }
 
 static int iddp_ioctl(struct rtipc_private *priv,
-		      rtdm_user_info_t *user_info,
+		      struct rtdm_fd *context,
 		      unsigned int request, void *arg)
 {
 	if (rtdm_in_rt_context() && request == _RTIOC_BIND)
 		return -ENOSYS;	/* Try downgrading to NRT */
 
-	return __iddp_ioctl(priv, user_info, request, arg);
+	return __iddp_ioctl(priv, context, request, arg);
 }
 
 static int iddp_init(void)
diff --git a/kernel/drivers/ipc/internal.h b/kernel/drivers/ipc/internal.h
index 4422ba0..7470342 100644
--- a/kernel/drivers/ipc/internal.h
+++ b/kernel/drivers/ipc/internal.h
@@ -69,16 +69,6 @@ static inline void *rtipc_context_to_state(struct rtdm_fd *context)
 	return p->state;
 }
 
-static inline void *rtipc_fd2map(int fd)
-{
-	return (void *)(long)(fd + 1);
-}
-
-static inline int rtipc_map2fd(void *p)
-{
-	return (long)p - 1;
-}
-
 static inline nanosecs_rel_t rtipc_timeval_to_ns(const struct timeval *tv)
 {
 	nanosecs_rel_t ns = tv->tv_usec * 1000;
-- 
1.7.10.4


