Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD61C681
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 14:00:51 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230927135040a1e2942e2db9699c1e
        for <xenomai@lists.linux.dev>;
        Wed, 27 Sep 2023 15:50:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8c8G0sAT+fXWwHxX7UzmTZMNNz1I4VLXiY4XY0fh7TY=;
 b=ot1Wpad42Numvzxjav3CKrflACre8TDCgb+fno1tRE2G0ux+PZbNMhqLdiY+BXFZLdd3sl
 jlXEYULQOejEYmdBUsPLK7G+aKH27jaBQvOM0YWkflErfTZEs9StWnZ+pn5nx7X6ZkSph12l
 Vea5uixezh03ZtCtYocCPHGo2na0M=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 27 Sep 2023 15:50:14 +0200
Subject: [PATCH v2 1/9] y2038: kernel/drivers: Implement SO_RCVTIMEO_NEW
 and SO_SNDTIMEO_NEW
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-florian-y2038-2-v2-1-05f710464d83@siemens.com>
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

When requesting y2038 support from recent glibc versions SO_RCVTIMEO and
SO_SNDTIMEO will be auto-converted to the _NEW variants to make clear
that we have to deal with a different (now y2038 safe) ABI.

Implementing SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW where necessary.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/ipc/bufp.c               | 34 +++++++++++++++++++++++++++++++++
 kernel/drivers/ipc/iddp.c               | 34 +++++++++++++++++++++++++++++++++
 kernel/drivers/ipc/internal.h           | 27 ++++++++++++++++++++++++++
 kernel/drivers/ipc/rtipc.c              | 29 ++++++++++++++++++++++++++++
 kernel/drivers/ipc/xddp.c               | 18 +++++++++++++++++
 kernel/drivers/net/stack/ipv4/tcp/tcp.c | 31 ++++++++++++++++++++++++++++++
 6 files changed, 173 insertions(+)

diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
index 565409dd6..f1936d846 100644
--- a/kernel/drivers/ipc/bufp.c
+++ b/kernel/drivers/ipc/bufp.c
@@ -824,6 +824,7 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 			     void *arg)
 {
 	struct _rtdm_setsockopt_args sopt;
+	struct __kernel_sock_timeval stv;
 	struct rtipc_port_label plabel;
 	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
@@ -844,6 +845,14 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 			sk->rx_timeout = rtipc_timeval_to_ns(&tv);
 			break;
 
+		case SO_RCVTIMEO_NEW:
+			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
+						     sopt.optlen);
+			if (ret)
+				return ret;
+			sk->rx_timeout = rtipc_sock_timeval_to_ns(&stv);
+			break;
+
 		case SO_SNDTIMEO_OLD:
 			ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
 			if (ret)
@@ -851,6 +860,14 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 			sk->tx_timeout = rtipc_timeval_to_ns(&tv);
 			break;
 
+		case SO_SNDTIMEO_NEW:
+			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
+						     sopt.optlen);
+			if (ret)
+				return ret;
+			sk->tx_timeout = rtipc_sock_timeval_to_ns(&stv);
+			break;
+
 		default:
 			ret = -EINVAL;
 		}
@@ -913,6 +930,7 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 			     void *arg)
 {
 	struct _rtdm_getsockopt_args sopt;
+	struct __kernel_sock_timeval stv;
 	struct rtipc_port_label plabel;
 	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
@@ -936,6 +954,14 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 				return ret;
 			break;
 
+		case SO_RCVTIMEO_NEW:
+			rtipc_ns_to_sock_timeval(&stv, sk->rx_timeout);
+			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
+						     len);
+			if (ret)
+				return ret;
+			break;
+
 		case SO_SNDTIMEO_OLD:
 			rtipc_ns_to_timeval(&tv, sk->tx_timeout);
 			ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
@@ -943,6 +969,14 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 				return ret;
 			break;
 
+		case SO_SNDTIMEO_NEW:
+			rtipc_ns_to_sock_timeval(&stv, sk->tx_timeout);
+			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
+						     len);
+			if (ret)
+				return ret;
+			break;
+
 		default:
 			ret = -EINVAL;
 		}
diff --git a/kernel/drivers/ipc/iddp.c b/kernel/drivers/ipc/iddp.c
index 05d019339..e4893a378 100644
--- a/kernel/drivers/ipc/iddp.c
+++ b/kernel/drivers/ipc/iddp.c
@@ -704,6 +704,7 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 			     void *arg)
 {
 	struct _rtdm_setsockopt_args sopt;
+	struct __kernel_sock_timeval stv;
 	struct rtipc_port_label plabel;
 	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
@@ -724,6 +725,14 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 			sk->rx_timeout = rtipc_timeval_to_ns(&tv);
 			break;
 
+		case SO_RCVTIMEO_NEW:
+			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
+						     sopt.optlen);
+			if (ret)
+				return ret;
+			sk->rx_timeout = rtipc_sock_timeval_to_ns(&stv);
+			break;
+
 		case SO_SNDTIMEO_OLD:
 			ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
 			if (ret)
@@ -731,6 +740,14 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 			sk->tx_timeout = rtipc_timeval_to_ns(&tv);
 			break;
 
+		case SO_SNDTIMEO_NEW:
+			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
+						     sopt.optlen);
+			if (ret)
+				return ret;
+			sk->tx_timeout = rtipc_sock_timeval_to_ns(&stv);
+			break;
+
 		default:
 			ret = -EINVAL;
 		}
@@ -793,6 +810,7 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 			     void *arg)
 {
 	struct _rtdm_getsockopt_args sopt;
+	struct __kernel_sock_timeval stv;
 	struct rtipc_port_label plabel;
 	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
@@ -817,6 +835,14 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 				return ret;
 			break;
 
+		case SO_RCVTIMEO_NEW:
+			rtipc_ns_to_sock_timeval(&stv, sk->rx_timeout);
+			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
+						     len);
+			if (ret)
+				return ret;
+			break;
+
 		case SO_SNDTIMEO_OLD:
 			rtipc_ns_to_timeval(&tv, sk->tx_timeout);
 			ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
@@ -824,6 +850,14 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 				return ret;
 			break;
 
+		case SO_SNDTIMEO_NEW:
+			rtipc_ns_to_sock_timeval(&stv, sk->tx_timeout);
+			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
+						     len);
+			if (ret)
+				return ret;
+			break;
+
 		default:
 			ret = -EINVAL;
 		}
diff --git a/kernel/drivers/ipc/internal.h b/kernel/drivers/ipc/internal.h
index 919a5d978..f29ba2204 100644
--- a/kernel/drivers/ipc/internal.h
+++ b/kernel/drivers/ipc/internal.h
@@ -76,6 +76,17 @@ static inline nanosecs_rel_t rtipc_timeval_to_ns(const struct __kernel_old_timev
 	return ns;
 }
 
+static inline nanosecs_rel_t
+rtipc_sock_timeval_to_ns(const struct __kernel_sock_timeval *tv)
+{
+	nanosecs_rel_t ns = tv->tv_usec * 1000;
+
+	if (tv->tv_sec)
+		ns += (nanosecs_rel_t)tv->tv_sec * 1000000000UL;
+
+	return ns;
+}
+
 static inline void rtipc_ns_to_timeval(struct __kernel_old_timeval *tv, nanosecs_rel_t ns)
 {
 	unsigned long nsecs;
@@ -84,6 +95,15 @@ static inline void rtipc_ns_to_timeval(struct __kernel_old_timeval *tv, nanosecs
 	tv->tv_usec = nsecs / 1000;
 }
 
+static inline void rtipc_ns_to_sock_timeval(struct __kernel_sock_timeval *tv,
+					    nanosecs_rel_t ns)
+{
+	unsigned long nsecs;
+
+	tv->tv_sec = xnclock_divrem_billion(ns, &nsecs);
+	tv->tv_usec = nsecs / 1000;
+}
+
 int rtipc_get_sockaddr(struct rtdm_fd *fd,
 		       struct sockaddr_ipc **saddrp,
 		       const void *arg);
@@ -105,9 +125,16 @@ int rtipc_get_sockoptin(struct rtdm_fd *fd,
 int rtipc_get_timeval(struct rtdm_fd *fd, struct __kernel_old_timeval *tv,
 		      const void *arg, size_t arglen);
 
+int rtipc_get_sock_timeval(struct rtdm_fd *fd, struct __kernel_sock_timeval *tv,
+			   const void *arg, size_t arglen);
+
 int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
 		      const struct __kernel_old_timeval *tv, size_t arglen);
 
+int rtipc_put_sock_timeval(struct rtdm_fd *fd, void *arg,
+			   const struct __kernel_sock_timeval *tv,
+			   size_t arglen);
+
 int rtipc_get_length(struct rtdm_fd *fd, size_t *lenp,
 		     const void *arg, size_t arglen);
 
diff --git a/kernel/drivers/ipc/rtipc.c b/kernel/drivers/ipc/rtipc.c
index 211b496ec..66176adad 100644
--- a/kernel/drivers/ipc/rtipc.c
+++ b/kernel/drivers/ipc/rtipc.c
@@ -290,6 +290,20 @@ int rtipc_get_timeval(struct rtdm_fd *fd, struct __kernel_old_timeval *tv,
 	return rtdm_safe_copy_from_user(fd, tv, arg, sizeof(*tv));
 }
 
+int rtipc_get_sock_timeval(struct rtdm_fd *fd, struct __kernel_sock_timeval *tv,
+			   const void *arg, size_t arglen)
+{
+	if (arglen != sizeof(*tv))
+		return -EINVAL;
+
+	if (!rtdm_fd_is_user(fd)) {
+		*tv = *(struct __kernel_sock_timeval *)arg;
+		return 0;
+	}
+
+	return rtdm_safe_copy_from_user(fd, tv, arg, sizeof(*tv));
+}
+
 int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
 		      const struct __kernel_old_timeval *tv, size_t arglen)
 {
@@ -312,6 +326,21 @@ int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
 	return rtdm_safe_copy_to_user(fd, arg, tv, sizeof(*tv));
 }
 
+int rtipc_put_sock_timeval(struct rtdm_fd *fd, void *arg,
+			   const struct __kernel_sock_timeval *tv,
+			   size_t arglen)
+{
+	if (arglen != sizeof(*tv))
+		return -EINVAL;
+
+	if (!rtdm_fd_is_user(fd)) {
+		*(struct __kernel_sock_timeval *)arg = *tv;
+		return 0;
+	}
+
+	return rtdm_safe_copy_to_user(fd, arg, tv, sizeof(*tv));
+}
+
 int rtipc_get_length(struct rtdm_fd *fd, size_t *lenp,
 		     const void *arg, size_t arglen)
 {
diff --git a/kernel/drivers/ipc/xddp.c b/kernel/drivers/ipc/xddp.c
index 2ca0da5fd..8f1b2ece7 100644
--- a/kernel/drivers/ipc/xddp.c
+++ b/kernel/drivers/ipc/xddp.c
@@ -859,6 +859,7 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 {
 	int (*monitor)(struct rtdm_fd *fd, int event, long arg);
 	struct _rtdm_setsockopt_args sopt;
+	struct __kernel_sock_timeval stv;
 	struct rtipc_port_label plabel;
 	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
@@ -879,6 +880,14 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 			sk->timeout = rtipc_timeval_to_ns(&tv);
 			break;
 
+		case SO_RCVTIMEO_NEW:
+			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
+						     sopt.optlen);
+			if (ret)
+				return ret;
+
+			sk->timeout = rtipc_sock_timeval_to_ns(&stv);
+			break;
 		default:
 			ret = -EINVAL;
 		}
@@ -965,6 +974,7 @@ static int __xddp_getsockopt(struct xddp_socket *sk,
 			     void *arg)
 {
 	struct _rtdm_getsockopt_args sopt;
+	struct __kernel_sock_timeval stv;
 	struct rtipc_port_label plabel;
 	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
@@ -988,6 +998,14 @@ static int __xddp_getsockopt(struct xddp_socket *sk,
 				return ret;
 			break;
 
+		case SO_RCVTIMEO_NEW:
+			rtipc_ns_to_sock_timeval(&stv, sk->timeout);
+			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
+						     len);
+			if (ret)
+				return ret;
+			break;
+
 		default:
 			ret = -EINVAL;
 		}
diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 71628ba03..5bd114530 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -1743,6 +1743,7 @@ static int rt_tcp_setsockopt(struct rtdm_fd *fd, struct tcp_socket *ts,
 			     socklen_t optlen)
 {
 	/* uint64_t val; */
+	struct __kernel_sock_timeval stv;
 	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t context;
 
@@ -1793,6 +1794,36 @@ static int rt_tcp_setsockopt(struct rtdm_fd *fd, struct tcp_socket *ts,
 
 		return 0;
 
+	case SO_SNDTIMEO_NEW:
+		if (optlen < sizeof(stv))
+			return -EINVAL;
+		if (rtdm_copy_from_user(fd, &stv, optval, sizeof(stv)))
+			return -EFAULT;
+		if (stv.tv_usec < 0 || stv.tv_usec >= 1000000)
+			return -EDOM;
+
+		rtdm_lock_get_irqsave(&ts->socket_lock, context);
+
+		if (stv.tv_sec < 0) {
+			ts->sk_sndtimeo = RTDM_TIMEOUT_NONE;
+			rtdm_lock_put_irqrestore(&ts->socket_lock, context);
+			return 0;
+		}
+
+		ts->sk_sndtimeo = RTDM_TIMEOUT_INFINITE;
+		if (stv.tv_sec == 0 && stv.tv_usec == 0) {
+			rtdm_lock_put_irqrestore(&ts->socket_lock, context);
+			return 0;
+		}
+
+		if (stv.tv_sec < (MAX_SCHEDULE_TIMEOUT / 1000000000ull - 1))
+			ts->sk_sndtimeo =
+				(stv.tv_sec * 1000000 + stv.tv_usec) * 1000;
+
+		rtdm_lock_put_irqrestore(&ts->socket_lock, context);
+
+		return 0;
+
 	case SO_REUSEADDR:
 		/* to implement */
 		return -EOPNOTSUPP;

-- 
2.39.2

