From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Fri,  7 Mar 2014 21:20:36 +0100
Message-Id: <1394223638-13070-7-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <531A29CC.4040201@xenomai.org>
 <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 7/9] drivers/ipc: adapt XDDP after RTDM changes
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
 kernel/drivers/ipc/internal.h |   26 +++++-----
 kernel/drivers/ipc/rtipc.c    |   67 +++++++++++-------------
 kernel/drivers/ipc/xddp.c     |  115 ++++++++++++++++++++++-------------------
 3 files changed, 104 insertions(+), 104 deletions(-)

diff --git a/kernel/drivers/ipc/internal.h b/kernel/drivers/ipc/internal.h
index 34985df..4422ba0 100644
--- a/kernel/drivers/ipc/internal.h
+++ b/kernel/drivers/ipc/internal.h
@@ -42,28 +42,28 @@ struct rtipc_protocol {
 	void (*proto_exit)(void);
 	struct {
 		int (*socket)(struct rtipc_private *priv,
-			      rtdm_user_info_t *user_info);
-		int (*close)(struct rtipc_private *priv,
-			     rtdm_user_info_t *user_info);
+			      struct rtdm_fd *context);
+		void (*close)(struct rtipc_private *priv,
+			struct rtdm_fd *context);
 		ssize_t (*recvmsg)(struct rtipc_private *priv,
-				   rtdm_user_info_t *user_info,
+				   struct rtdm_fd *context,
 				   struct msghdr *msg, int flags);
 		ssize_t (*sendmsg)(struct rtipc_private *priv,
-				   rtdm_user_info_t *user_info,
+				   struct rtdm_fd *context,
 				   const struct msghdr *msg, int flags);
 		ssize_t (*read)(struct rtipc_private *priv,
-				rtdm_user_info_t *user_info,
+				struct rtdm_fd *context,
 				void *buf, size_t len);
 		ssize_t (*write)(struct rtipc_private *priv,
-				 rtdm_user_info_t *user_info,
+				 struct rtdm_fd *context,
 				 const void *buf, size_t len);
 		int (*ioctl)(struct rtipc_private *priv,
-			     rtdm_user_info_t *user_info,
+			     struct rtdm_fd *context,
 			     unsigned int request, void *arg);
 	} proto_ops;
 };
 
-static inline void *rtipc_context_to_state(struct rtdm_dev_context *context)
+static inline void *rtipc_context_to_state(struct rtdm_fd *context)
 {
 	struct rtipc_private *p = rtdm_context_to_private(context);
 	return p->state;
@@ -97,16 +97,16 @@ static inline void rtipc_ns_to_timeval(struct timeval *tv, nanosecs_rel_t ns)
 	tv->tv_usec = nsecs / 1000;
 }
 
-int rtipc_get_arg(rtdm_user_info_t *user_info,
+int rtipc_get_arg(struct rtdm_fd *fd,
 		  void *dst, const void *src, size_t len);
 
-int rtipc_put_arg(rtdm_user_info_t *user_info,
+int rtipc_put_arg(struct rtdm_fd *fd,
 		  void *dst, const void *src, size_t len);
 
-int rtipc_get_sockaddr(rtdm_user_info_t *user_info,
+int rtipc_get_sockaddr(struct rtdm_fd *fd,
 		       const void *arg, struct sockaddr_ipc **saddrp);
 
-int rtipc_put_sockaddr(rtdm_user_info_t *user_info, void *arg,
+int rtipc_put_sockaddr(struct rtdm_fd *fd, void *arg,
 		       const struct sockaddr_ipc *saddr);
 
 ssize_t rtipc_get_iov_flatlen(struct iovec *iov, int iovlen);
diff --git a/kernel/drivers/ipc/rtipc.c b/kernel/drivers/ipc/rtipc.c
index 20c2a74..e9e815b 100644
--- a/kernel/drivers/ipc/rtipc.c
+++ b/kernel/drivers/ipc/rtipc.c
@@ -37,11 +37,11 @@ static struct rtipc_protocol *protocols[IPCPROTO_MAX] = {
 
 DEFINE_XNPTREE(rtipc_ptree, "rtipc");
 
-int rtipc_get_arg(rtdm_user_info_t *user_info,
+int rtipc_get_arg(struct rtdm_fd *context,
 		  void *dst, const void *src, size_t len)
 {
-	if (user_info) {
-		if (rtdm_safe_copy_from_user(user_info, dst, src, len))
+	if (rtdm_context_user_p(context)) {
+		if (rtdm_safe_copy_from_user(context, dst, src, len))
 			return -EFAULT;
 	} else
 		memcpy(dst, src, len);
@@ -49,11 +49,11 @@ int rtipc_get_arg(rtdm_user_info_t *user_info,
 	return 0;
 }
 
-int rtipc_put_arg(rtdm_user_info_t *user_info,
+int rtipc_put_arg(struct rtdm_fd *context,
 		  void *dst, const void *src, size_t len)
 {
-	if (user_info) {
-		if (rtdm_safe_copy_to_user(user_info, dst, src, len))
+	if (rtdm_context_user_p(context)) {
+		if (rtdm_safe_copy_to_user(context, dst, src, len))
 			return -EFAULT;
 	} else
 		memcpy(dst, src, len);
@@ -61,12 +61,12 @@ int rtipc_put_arg(rtdm_user_info_t *user_info,
 	return 0;
 }
 
-int rtipc_get_sockaddr(rtdm_user_info_t *user_info,
+int rtipc_get_sockaddr(struct rtdm_fd *context,
 		       const void *arg, struct sockaddr_ipc **saddrp)
 {
 	struct _rtdm_setsockaddr_args setaddr;
 
-	if (rtipc_get_arg(user_info,
+	if (rtipc_get_arg(context,
 			  &setaddr, arg, sizeof(setaddr)))
 		return -EFAULT;
 
@@ -74,7 +74,7 @@ int rtipc_get_sockaddr(rtdm_user_info_t *user_info,
 		if (setaddr.addrlen != sizeof(**saddrp))
 			return -EINVAL;
 
-		if (rtipc_get_arg(user_info, *saddrp,
+		if (rtipc_get_arg(context, *saddrp,
 				  setaddr.addr, sizeof(**saddrp)))
 			return -EFAULT;
 	} else {
@@ -86,29 +86,29 @@ int rtipc_get_sockaddr(rtdm_user_info_t *user_info,
 	return 0;
 }
 
-int rtipc_put_sockaddr(rtdm_user_info_t *user_info, void *arg,
+int rtipc_put_sockaddr(struct rtdm_fd *context, void *arg,
 		       const struct sockaddr_ipc *saddr)
 {
 	struct _rtdm_getsockaddr_args getaddr;
 	socklen_t len;
 
-	if (rtipc_get_arg(user_info,
+	if (rtipc_get_arg(context,
 			  &getaddr, arg, sizeof(getaddr)))
 		return -EFAULT;
 
-	if (rtipc_get_arg(user_info,
+	if (rtipc_get_arg(context,
 			  &len, getaddr.addrlen, sizeof(len)))
 		return -EFAULT;
 
 	if (len < sizeof(*saddr))
 		return -EINVAL;
 
-	if (rtipc_put_arg(user_info,
+	if (rtipc_put_arg(context,
 			  getaddr.addr, saddr, sizeof(*saddr)))
 		return -EFAULT;
 
 	len = sizeof(*saddr);
-	if (rtipc_put_arg(user_info,
+	if (rtipc_put_arg(context,
 			  getaddr.addrlen, &len, sizeof(len)))
 		return -EFAULT;
 
@@ -131,8 +131,7 @@ ssize_t rtipc_get_iov_flatlen(struct iovec *iov, int iovlen)
 	return len;
 }
 
-static int rtipc_socket(struct rtdm_dev_context *context,
-			rtdm_user_info_t *user_info, int protocol)
+static int rtipc_socket(struct rtdm_fd *context, int protocol)
 {
 	struct rtipc_protocol *proto;
 	struct rtipc_private *p;
@@ -155,15 +154,14 @@ static int rtipc_socket(struct rtdm_dev_context *context,
 	if (p->state == NULL)
 		return -ENOMEM;
 
-	ret = proto->proto_ops.socket(p, user_info);
+	ret = proto->proto_ops.socket(p, context);
 	if (ret)
 		kfree(p->state);
 
 	return ret;
 }
 
-static int rtipc_close(struct rtdm_dev_context *context,
-		       rtdm_user_info_t *user_info)
+static void rtipc_close(struct rtdm_fd *context)
 {
 	struct rtipc_private *p;
 
@@ -173,47 +171,42 @@ static int rtipc_close(struct rtdm_dev_context *context,
 	 * proto_ops.close() handler when appropriate (which may be
 	 * done asynchronously later, see XDDP).
 	 */
-	return p->proto->proto_ops.close(p, user_info);
+	p->proto->proto_ops.close(p, context);
 }
 
-static ssize_t rtipc_recvmsg(struct rtdm_dev_context *context,
-			     rtdm_user_info_t *user_info,
+static ssize_t rtipc_recvmsg(struct rtdm_fd *context,
 			     struct msghdr *msg, int flags)
 {
 	struct rtipc_private *p = rtdm_context_to_private(context);
-	return p->proto->proto_ops.recvmsg(p, user_info, msg, flags);
+	return p->proto->proto_ops.recvmsg(p, context, msg, flags);
 }
 
-static ssize_t rtipc_sendmsg(struct rtdm_dev_context *context,
-			     rtdm_user_info_t *user_info,
+static ssize_t rtipc_sendmsg(struct rtdm_fd *context,
 			     const struct msghdr *msg, int flags)
 {
 	struct rtipc_private *p = rtdm_context_to_private(context);
-	return p->proto->proto_ops.sendmsg(p, user_info, msg, flags);
+	return p->proto->proto_ops.sendmsg(p, context, msg, flags);
 }
 
-static ssize_t rtipc_read(struct rtdm_dev_context *context,
-			  rtdm_user_info_t *user_info,
+static ssize_t rtipc_read(struct rtdm_fd *context,
 			  void *buf, size_t len)
 {
 	struct rtipc_private *p = rtdm_context_to_private(context);
-	return p->proto->proto_ops.read(p, user_info, buf, len);
+	return p->proto->proto_ops.read(p, context, buf, len);
 }
 
-static ssize_t rtipc_write(struct rtdm_dev_context *context,
-			   rtdm_user_info_t *user_info,
+static ssize_t rtipc_write(struct rtdm_fd *context,
 			   const void *buf, size_t len)
 {
 	struct rtipc_private *p = rtdm_context_to_private(context);
-	return p->proto->proto_ops.write(p, user_info, buf, len);
+	return p->proto->proto_ops.write(p, context, buf, len);
 }
 
-static int rtipc_ioctl(struct rtdm_dev_context *context,
-		       rtdm_user_info_t *user_info,
+static int rtipc_ioctl(struct rtdm_fd *context,
 		       unsigned int request, void *arg)
 {
 	struct rtipc_private *p = rtdm_context_to_private(context);
-	return p->proto->proto_ops.ioctl(p, user_info, request, arg);
+	return p->proto->proto_ops.ioctl(p, context, request, arg);
 }
 
 static struct rtdm_device device = {
@@ -223,9 +216,9 @@ static struct rtdm_device device = {
 	.device_name	=	"rtipc",
 	.protocol_family=	PF_RTIPC,
 	.socket_type	=	SOCK_DGRAM,
-	.socket_nrt	=	rtipc_socket,
+	.socket		=	rtipc_socket,
 	.ops = {
-		.close_nrt	=	rtipc_close,
+		.close		=	rtipc_close,
 		.recvmsg_rt	=	rtipc_recvmsg,
 		.recvmsg_nrt	=	NULL,
 		.sendmsg_rt	=	rtipc_sendmsg,
diff --git a/kernel/drivers/ipc/xddp.c b/kernel/drivers/ipc/xddp.c
index 728a6ed..eef1ed7 100644
--- a/kernel/drivers/ipc/xddp.c
+++ b/kernel/drivers/ipc/xddp.c
@@ -42,7 +42,7 @@ struct xddp_socket {
 	size_t poolsz;
 	xnhandle_t handle;
 	char label[XNOBJECT_NAME_LEN];
-	int fd;			/* i.e. RTDM socket fd */
+	struct rtdm_fd *fd;			/* i.e. RTDM socket fd */
 
 	struct xddp_message *buffer;
 	int buffer_port;
@@ -56,7 +56,7 @@ struct xddp_socket {
 	nanosecs_rel_t timeout;	/* connect()/recvmsg() timeout */
 	size_t reqbufsz;	/* Requested streaming buffer size */
 
-	int (*monitor)(int s, int event, long arg);
+	int (*monitor)(struct rtdm_fd *fd, int event, long arg);
 	struct rtipc_private *priv;
 };
 
@@ -65,7 +65,7 @@ static struct sockaddr_ipc nullsa = {
 	.sipc_port = -1
 };
 
-static int portmap[CONFIG_XENO_OPT_PIPE_NRDEV]; /* indexes RTDM fildes */
+static struct rtdm_fd *portmap[CONFIG_XENO_OPT_PIPE_NRDEV]; /* indexes RTDM fildes */
 
 #define _XDDP_SYNCWAIT  0
 #define _XDDP_ATOMIC    1
@@ -219,7 +219,7 @@ static void __xddp_release_handler(void *skarg) /* nklock free */
 }
 
 static int xddp_socket(struct rtipc_private *priv,
-		       rtdm_user_info_t *user_info)
+		       struct rtdm_fd *context)
 {
 	struct xddp_socket *sk = priv->state;
 
@@ -245,26 +245,28 @@ static int xddp_socket(struct rtipc_private *priv,
 	return 0;
 }
 
-static int xddp_close(struct rtipc_private *priv,
-		      rtdm_user_info_t *user_info)
+static void xddp_close(struct rtipc_private *priv,
+		      struct rtdm_fd *context)
 {
 	struct xddp_socket *sk = priv->state;
 
 	sk->monitor = NULL;
 
 	if (!test_bit(_XDDP_BOUND, &sk->status))
-		return 0;
+		return;
 
-	portmap[sk->name.sipc_port] = -1;
+	RTDM_EXECUTE_ATOMICALLY(
+		portmap[sk->name.sipc_port] = NULL;
+	);
 
 	if (sk->handle)
 		xnregistry_remove(sk->handle);
 
-	return xnpipe_disconnect(sk->minor);
+	xnpipe_disconnect(sk->minor);
 }
 
 static ssize_t __xddp_recvmsg(struct rtipc_private *priv,
-			      rtdm_user_info_t *user_info,
+			      struct rtdm_fd *context,
 			      struct iovec *iov, int iovlen, int flags,
 			      struct sockaddr_ipc *saddr)
 {
@@ -304,7 +306,7 @@ static ssize_t __xddp_recvmsg(struct rtipc_private *priv,
 		if (iov[nvec].iov_len == 0)
 			continue;
 		vlen = wrlen >= iov[nvec].iov_len ? iov[nvec].iov_len : wrlen;
-		if (user_info) {
+		if (rtdm_context_user_p(context)) {
 			xnbufd_map_uread(&bufd, iov[nvec].iov_base, vlen);
 			ret = xnbufd_copy_from_kmem(&bufd, mbuf->data + rdoff, vlen);
 			xnbufd_unmap_uread(&bufd);
@@ -328,7 +330,7 @@ out:
 }
 
 static ssize_t xddp_recvmsg(struct rtipc_private *priv,
-			    rtdm_user_info_t *user_info,
+			    struct rtdm_fd *context,
 			    struct msghdr *msg, int flags)
 {
 	struct iovec iov[RTIPC_IOV_MAX];
@@ -348,23 +350,23 @@ static ssize_t xddp_recvmsg(struct rtipc_private *priv,
 		return -EINVAL;
 
 	/* Copy I/O vector in */
-	if (rtipc_get_arg(user_info, iov, msg->msg_iov,
+	if (rtipc_get_arg(context, iov, msg->msg_iov,
 			  sizeof(iov[0]) * msg->msg_iovlen))
 		return -EFAULT;
 
-	ret = __xddp_recvmsg(priv, user_info,
+	ret = __xddp_recvmsg(priv, context,
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
@@ -374,11 +376,11 @@ static ssize_t xddp_recvmsg(struct rtipc_private *priv,
 }
 
 static ssize_t xddp_read(struct rtipc_private *priv,
-			 rtdm_user_info_t *user_info,
+			 struct rtdm_fd *context,
 			 void *buf, size_t len)
 {
 	struct iovec iov = { .iov_base = buf, .iov_len = len };
-	return __xddp_recvmsg(priv, user_info, &iov, 1, 0, NULL);
+	return __xddp_recvmsg(priv, context, &iov, 1, 0, NULL);
 }
 
 static ssize_t __xddp_stream(struct xddp_socket *sk,
@@ -456,15 +458,15 @@ out:
 }
 
 static ssize_t __xddp_sendmsg(struct rtipc_private *priv,
-			      rtdm_user_info_t *user_info,
+			      struct rtdm_fd *context,
 			      struct iovec *iov, int iovlen, int flags,
 			      const struct sockaddr_ipc *daddr)
 {
 	ssize_t len, rdlen, wrlen, vlen, ret, sublen;
 	struct xddp_socket *sk = priv->state;
-	struct rtdm_dev_context *rcontext;
 	struct xddp_message *mbuf;
 	struct xddp_socket *rsk;
+	struct rtdm_fd *rcontext;
 	int nvec, to, from;
 	struct xnbufd bufd;
 
@@ -475,7 +477,12 @@ static ssize_t __xddp_sendmsg(struct rtipc_private *priv,
 	from = sk->name.sipc_port;
 	to = daddr->sipc_port;
 
-	rcontext = rtdm_context_get(portmap[to]);
+	RTDM_EXECUTE_ATOMICALLY(
+		rcontext = portmap[to];
+		if (rcontext && rtdm_context_lock(rcontext) < 0)
+			rcontext = NULL;
+	);
+	
 	if (rcontext == NULL)
 		return -ECONNRESET;
 
@@ -501,7 +508,7 @@ static ssize_t __xddp_sendmsg(struct rtipc_private *priv,
 			if (iov[nvec].iov_len == 0)
 				continue;
 			vlen = rdlen >= iov[nvec].iov_len ? iov[nvec].iov_len : rdlen;
-			if (user_info) {
+			if (rtdm_context_user_p(context)) {
 				xnbufd_map_uread(&bufd, iov[nvec].iov_base, vlen);
 				ret = __xddp_stream(rsk, from, &bufd);
 				xnbufd_unmap_uread(&bufd);
@@ -544,7 +551,7 @@ nostream:
 		if (iov[nvec].iov_len == 0)
 			continue;
 		vlen = rdlen >= iov[nvec].iov_len ? iov[nvec].iov_len : rdlen;
-		if (user_info) {
+		if (rtdm_context_user_p(context)) {
 			xnbufd_map_uread(&bufd, iov[nvec].iov_base, vlen);
 			ret = xnbufd_copy_to_kmem(mbuf->data + wrlen, &bufd, vlen);
 			xnbufd_unmap_uread(&bufd);
@@ -580,7 +587,7 @@ nostream:
 }
 
 static ssize_t xddp_sendmsg(struct rtipc_private *priv,
-			    rtdm_user_info_t *user_info,
+			    struct rtdm_fd *context,
 			    const struct msghdr *msg, int flags)
 {
 	struct xddp_socket *sk = priv->state;
@@ -608,7 +615,7 @@ static ssize_t xddp_sendmsg(struct rtipc_private *priv,
 			return -EINVAL;
 
 		/* Fetch the destination address to send to. */
-		if (rtipc_get_arg(user_info, &daddr,
+		if (rtipc_get_arg(context, &daddr,
 				  msg->msg_name, sizeof(daddr)))
 			return -EFAULT;
 
@@ -627,17 +634,17 @@ static ssize_t xddp_sendmsg(struct rtipc_private *priv,
 		return -EINVAL;
 
 	/* Copy I/O vector in */
-	if (rtipc_get_arg(user_info, iov, msg->msg_iov,
+	if (rtipc_get_arg(context, iov, msg->msg_iov,
 			  sizeof(iov[0]) * msg->msg_iovlen))
 		return -EFAULT;
 
-	ret = __xddp_sendmsg(priv, user_info, iov,
+	ret = __xddp_sendmsg(priv, context, iov,
 			     msg->msg_iovlen, flags, &daddr);
 	if (ret <= 0)
 		return ret;
 
 	/* Copy updated I/O vector back */
-	if (rtipc_put_arg(user_info, msg->msg_iov, iov,
+	if (rtipc_put_arg(context, msg->msg_iov, iov,
 			  sizeof(iov[0]) * msg->msg_iovlen))
 		return -EFAULT;
 
@@ -645,7 +652,7 @@ static ssize_t xddp_sendmsg(struct rtipc_private *priv,
 }
 
 static ssize_t xddp_write(struct rtipc_private *priv,
-			  rtdm_user_info_t *user_info,
+			  struct rtdm_fd *context,
 			  const void *buf, size_t len)
 {
 	struct iovec iov = { .iov_base = (void *)buf, .iov_len = len };
@@ -654,7 +661,7 @@ static ssize_t xddp_write(struct rtipc_private *priv,
 	if (sk->peer.sipc_port < 0)
 		return -EDESTADDRREQ;
 
-	return __xddp_sendmsg(priv, user_info, &iov, 1, 0, &sk->peer);
+	return __xddp_sendmsg(priv, context, &iov, 1, 0, &sk->peer);
 }
 
 static int __xddp_bind_socket(struct rtipc_private *priv,
@@ -711,7 +718,7 @@ static int __xddp_bind_socket(struct rtipc_private *priv,
 		sk->curbufsz = sk->reqbufsz;
 	}
 
-	sk->fd = rtdm_private_to_context(priv)->fd;
+	sk->fd = rtdm_private_to_context(priv);
 
 	ops.output = &__xddp_output_handler;
 	ops.input = &__xddp_input_handler;
@@ -753,7 +760,7 @@ static int __xddp_bind_socket(struct rtipc_private *priv,
 	}
 
 	RTDM_EXECUTE_ATOMICALLY(
-		portmap[sk->minor] = sk->fd;
+		portmap[sk->minor] = rtdm_private_to_context(priv);
 		__clear_bit(_XDDP_BINDING, &sk->status);
 		__set_bit(_XDDP_BOUND, &sk->status);
 	);
@@ -827,10 +834,10 @@ set_assoc:
 }
 
 static int __xddp_setsockopt(struct xddp_socket *sk,
-			     rtdm_user_info_t *user_info,
+			     struct rtdm_fd *context,
 			     void *arg)
 {
-	int (*monitor)(int s, int event, long arg);
+	int (*monitor)(struct rtdm_fd *fd, int event, long arg);
 	struct _rtdm_setsockopt_args sopt;
 	struct rtipc_port_label plabel;
 	rtdm_lockctx_t lockctx;
@@ -838,7 +845,7 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 	int ret = 0;
 	size_t len;
 
-	if (rtipc_get_arg(user_info, &sopt, arg, sizeof(sopt)))
+	if (rtipc_get_arg(context, &sopt, arg, sizeof(sopt)))
 		return -EFAULT;
 
 	if (sopt.level == SOL_SOCKET) {
@@ -847,7 +854,7 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 		case SO_RCVTIMEO:
 			if (sopt.optlen != sizeof(tv))
 				return -EINVAL;
-			if (rtipc_get_arg(user_info, &tv,
+			if (rtipc_get_arg(context, &tv,
 					  sopt.optval, sizeof(tv)))
 				return -EFAULT;
 			sk->timeout = rtipc_timeval_to_ns(&tv);
@@ -868,7 +875,7 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 	case XDDP_BUFSZ:
 		if (sopt.optlen != sizeof(len))
 			return -EINVAL;
-		if (rtipc_get_arg(user_info, &len,
+		if (rtipc_get_arg(context, &len,
 				  sopt.optval, sizeof(len)))
 			return -EFAULT;
 		if (len > 0) {
@@ -890,7 +897,7 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 	case XDDP_POOLSZ:
 		if (sopt.optlen != sizeof(len))
 			return -EINVAL;
-		if (rtipc_get_arg(user_info, &len,
+		if (rtipc_get_arg(context, &len,
 				  sopt.optval, sizeof(len)))
 			return -EFAULT;
 		if (len == 0)
@@ -906,7 +913,7 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 
 	case XDDP_MONITOR:
 		/* Monitoring is available from kernel-space only. */
-		if (user_info)
+		if (rtdm_context_user_p(context))
 			return -EPERM;
 		if (sopt.optlen != sizeof(monitor))
 			return -EINVAL;
@@ -919,7 +926,7 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 	case XDDP_LABEL:
 		if (sopt.optlen < sizeof(plabel))
 			return -EINVAL;
-		if (rtipc_get_arg(user_info, &plabel,
+		if (rtipc_get_arg(context, &plabel,
 				  sopt.optval, sizeof(plabel)))
 			return -EFAULT;
 		RTDM_EXECUTE_ATOMICALLY(
@@ -941,7 +948,7 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 }
 
 static int __xddp_getsockopt(struct xddp_socket *sk,
-			     rtdm_user_info_t *user_info,
+			     struct rtdm_fd *context,
 			     void *arg)
 {
 	struct _rtdm_getsockopt_args sopt;
@@ -950,10 +957,10 @@ static int __xddp_getsockopt(struct xddp_socket *sk,
 	socklen_t len;
 	int ret = 0;
 
-	if (rtipc_get_arg(user_info, &sopt, arg, sizeof(sopt)))
+	if (rtipc_get_arg(context, &sopt, arg, sizeof(sopt)))
 		return -EFAULT;
 
-	if (rtipc_get_arg(user_info, &len, sopt.optlen, sizeof(len)))
+	if (rtipc_get_arg(context, &len, sopt.optlen, sizeof(len)))
 		return -EFAULT;
 
 	if (sopt.level == SOL_SOCKET) {
@@ -963,7 +970,7 @@ static int __xddp_getsockopt(struct xddp_socket *sk,
 			if (len != sizeof(tv))
 				return -EINVAL;
 			rtipc_ns_to_timeval(&tv, sk->timeout);
-			if (rtipc_put_arg(user_info, sopt.optval,
+			if (rtipc_put_arg(context, sopt.optval,
 					  &tv, sizeof(tv)))
 				return -EFAULT;
 			break;
@@ -986,7 +993,7 @@ static int __xddp_getsockopt(struct xddp_socket *sk,
 		RTDM_EXECUTE_ATOMICALLY(
 			strcpy(plabel.label, sk->label);
 		);
-		if (rtipc_put_arg(user_info, sopt.optval,
+		if (rtipc_put_arg(context, sopt.optval,
 				  &plabel, sizeof(plabel)))
 			return -EFAULT;
 		break;
@@ -999,7 +1006,7 @@ static int __xddp_getsockopt(struct xddp_socket *sk,
 }
 
 static int __xddp_ioctl(struct rtipc_private *priv,
-			rtdm_user_info_t *user_info,
+			struct rtdm_fd *context,
 			unsigned int request, void *arg)
 {
 	struct sockaddr_ipc saddr, *saddrp = &saddr;
@@ -1009,13 +1016,13 @@ static int __xddp_ioctl(struct rtipc_private *priv,
 	switch (request) {
 
 	case _RTIOC_CONNECT:
-		ret = rtipc_get_sockaddr(user_info, arg, &saddrp);
+		ret = rtipc_get_sockaddr(context, arg, &saddrp);
 		if (ret == 0)
 			ret = __xddp_connect_socket(sk, saddrp);
 		break;
 
 	case _RTIOC_BIND:
-		ret = rtipc_get_sockaddr(user_info, arg, &saddrp);
+		ret = rtipc_get_sockaddr(context, arg, &saddrp);
 		if (ret)
 			return ret;
 		if (saddrp == NULL)
@@ -1024,19 +1031,19 @@ static int __xddp_ioctl(struct rtipc_private *priv,
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
-		ret = __xddp_setsockopt(sk, user_info, arg);
+		ret = __xddp_setsockopt(sk, context, arg);
 		break;
 
 	case _RTIOC_GETSOCKOPT:
-		ret = __xddp_getsockopt(sk, user_info, arg);
+		ret = __xddp_getsockopt(sk, context, arg);
 		break;
 
 	case _RTIOC_LISTEN:
@@ -1056,13 +1063,13 @@ static int __xddp_ioctl(struct rtipc_private *priv,
 }
 
 static int xddp_ioctl(struct rtipc_private *priv,
-		      rtdm_user_info_t *user_info,
+		      struct rtdm_fd *context,
 		      unsigned int request, void *arg)
 {
 	if (rtdm_in_rt_context() && request == _RTIOC_BIND)
 		return -ENOSYS;	/* Try downgrading to NRT */
 
-	return __xddp_ioctl(priv, user_info, request, arg);
+	return __xddp_ioctl(priv, context, request, arg);
 }
 
 struct rtipc_protocol xddp_proto_driver = {
-- 
1.7.10.4


