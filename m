Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F81FD6
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 07:14:31 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023022307042258163e6c06facd4998
        for <xenomai@lists.linux.dev>;
        Thu, 23 Feb 2023 08:04:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zEYF+FY8JvskmjJL0kR9A2pT1kIbaNRee2toNxnRrjs=;
 b=IJC8N42E6JEC0vt9mE4QeLw2JlX1Im0uHTG1/+ZUxlxtMK4Fx/0cYamyZN4nzUbVfVphIo
 v80ADmyFjkz9E9qb82ogzeQkNOHFQC9iqeXQY+51i74IYCnECubio749mec3DpqAeY/38e0r
 zJSTnx0QlaMfThHcvlJrYtFhIVeyQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [stable 3.2.x][PATCH 5/7] cobalt/rtdm/fd: Adding helpers for handling compat affected data structures
Date: Thu, 23 Feb 2023 08:04:15 +0100
Message-Id: <20230223070417.3969366-6-florian.bezdeka@siemens.com>
In-Reply-To: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
References: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Several drivers will have to read and write data structures that have
a different memory layout when handling compat applications. Moving
the decission if the compat path has to be taken into the rtdm layer
helps to keep the drivers simple and clean.

Added helpers
  - for reading and writing struct iovec
    (and its compat representation)
  - for reading and writing struct _rtdm_setsockaddr_args
    (and its compat representation)

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/rtdm/fd.h |  16 +++++
 kernel/cobalt/rtdm/drvlib.c     |  17 +----
 kernel/cobalt/rtdm/fd.c         | 122 ++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 15 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
index 058a9c638..176c67e22 100644
--- a/include/cobalt/kernel/rtdm/fd.h
+++ b/include/cobalt/kernel/rtdm/fd.h
@@ -29,6 +29,8 @@
 struct vm_area_struct;
 struct rtdm_fd;
 struct _rtdm_mmap_request;
+struct _rtdm_setsockaddr_args;
+struct _rtdm_setsockopt_args;
 struct xnselector;
 struct cobalt_ppd;
 struct rtdm_device;
@@ -403,6 +405,20 @@ int rtdm_fd_valid_p(int ufd);
 int rtdm_fd_select(int ufd, struct xnselector *selector,
 		   unsigned int type);
 
+int rtdm_fd_get_setsockaddr_args(struct rtdm_fd *fd,
+				 struct _rtdm_setsockaddr_args *dst,
+				 const void *src);
+
+int rtdm_fd_get_setsockopt_args(struct rtdm_fd *fd,
+				struct _rtdm_setsockopt_args *dst,
+				const void *src);
+
+int rtdm_fd_get_iovec(struct rtdm_fd *fd, struct iovec *iov,
+		      const struct user_msghdr *msg, bool rw);
+
+int rtdm_fd_put_iovec(struct rtdm_fd *fd, const struct iovec *iov,
+		      const struct user_msghdr *msg);
+
 int rtdm_device_new_fd(struct rtdm_fd *fd, int ufd,
 		struct rtdm_device *dev);
 
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 4ae1ed672..99d54f58f 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -2212,14 +2212,7 @@ int rtdm_get_iovec(struct rtdm_fd *fd, struct iovec **iovp,
 		return 0;
 	}
 
-#ifdef CONFIG_XENO_ARCH_SYS3264
-	if (rtdm_fd_is_compat(fd))
-		return sys32_get_iovec(iov,
-			       (struct compat_iovec __user *)msg->msg_iov,
-			       msg->msg_iovlen);
-#endif
-
-	return rtdm_copy_from_user(fd, iov, msg->msg_iov, len);
+	return rtdm_fd_get_iovec(fd, iov, msg, false);
 }
 EXPORT_SYMBOL_GPL(rtdm_get_iovec);
 
@@ -2234,13 +2227,7 @@ int rtdm_put_iovec(struct rtdm_fd *fd, struct iovec *iov,
 		memcpy(msg->msg_iov, iov, len);
 		ret = 0;
 	} else
-#ifdef CONFIG_XENO_ARCH_SYS3264
-		if (rtdm_fd_is_compat(fd))
-			ret = sys32_put_iovec((struct compat_iovec __user *)msg->msg_iov,
-					      iov, msg->msg_iovlen);
-		else
-#endif
-			ret = rtdm_copy_to_user(fd, msg->msg_iov, iov, len);
+		ret = rtdm_fd_put_iovec(fd, iov, msg);
 
 	if (iov != iov_fast)
 		xnfree(iov);
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index bbeea06ae..e63fab7dc 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -31,6 +31,7 @@
 #include <cobalt/kernel/time.h>
 #include <pipeline/inband_work.h>
 #include <trace/events/cobalt-rtdm.h>
+#include <rtdm/compat.h>
 #include <rtdm/fd.h>
 #include "internal.h"
 #include "posix/process.h"
@@ -999,6 +1000,127 @@ int rtdm_fd_select(int ufd, struct xnselector *selector,
 	return ret;
 }
 
+int rtdm_fd_get_setsockaddr_args(struct rtdm_fd *fd,
+				 struct _rtdm_setsockaddr_args *dst,
+				 const void *src)
+{
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	if (rtdm_fd_is_compat(fd)) {
+		struct compat_rtdm_setsockaddr_args cargs;
+		int ret;
+
+		if (!rtdm_read_user_ok(fd, src, sizeof(cargs)))
+			return -EFAULT;
+
+		ret = rtdm_copy_from_user(fd, &cargs, src, sizeof(cargs));
+		if (ret)
+			return ret;
+
+		dst->addr = compat_ptr(cargs.addr);
+		dst->addrlen = cargs.addrlen;
+
+		return 0;
+	}
+#endif
+
+	if (!rtdm_read_user_ok(fd, src, sizeof(*dst)))
+		return -EFAULT;
+
+	return rtdm_copy_from_user(fd, dst, src, sizeof(*dst));
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_get_setsockaddr_args);
+
+int rtdm_fd_get_setsockopt_args(struct rtdm_fd *fd,
+				struct _rtdm_setsockopt_args *dst,
+				const void *src)
+{
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	if (rtdm_fd_is_compat(fd)) {
+		struct compat_rtdm_setsockopt_args cargs;
+		int ret;
+
+		if (!rtdm_read_user_ok(fd, src, sizeof(cargs)))
+			return -EFAULT;
+
+		ret = rtdm_copy_from_user(fd, &cargs, src, sizeof(cargs));
+		if (ret)
+			return ret;
+
+		dst->optlen = cargs.optlen;
+		dst->optval = compat_ptr(cargs.optval);
+		dst->optname = cargs.optname;
+		dst->level = cargs.level;
+
+		return 0;
+	}
+#endif
+
+	if (!rtdm_read_user_ok(fd, src, sizeof(*dst)))
+		return -EFAULT;
+
+	return rtdm_copy_from_user(fd, dst, src, sizeof(*dst));
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_get_setsockopt_args);
+
+int rtdm_fd_get_iovec(struct rtdm_fd *fd, struct iovec *iov,
+		      const struct user_msghdr *msg, bool rw)
+{
+	size_t sz;
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	sz = rtdm_fd_is_compat(fd) ? sizeof(struct compat_iovec) : sizeof(*iov);
+#else
+	sz = sizeof(*iov);
+#endif
+
+	sz *= msg->msg_iovlen;
+
+	if (!rw && !rtdm_read_user_ok(fd, msg->msg_iov, sz))
+		return -EFAULT;
+
+	if (rw && !rtdm_rw_user_ok(fd, msg->msg_iov, sz))
+		return -EFAULT;
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	if (rtdm_fd_is_compat(fd))
+		return sys32_get_iovec(
+			iov, (struct compat_iovec __user *)msg->msg_iov,
+			(int)msg->msg_iovlen);
+#endif
+
+	return rtdm_copy_from_user(fd, iov, msg->msg_iov, sz);
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_get_iovec);
+
+int rtdm_fd_put_iovec(struct rtdm_fd *fd, const struct iovec *iov,
+		      const struct user_msghdr *msg)
+{
+	size_t sz;
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	sz = rtdm_fd_is_compat(fd) ? sizeof(struct compat_iovec) : sizeof(*iov);
+#else
+	sz = sizeof(*iov);
+#endif
+
+	sz *= msg->msg_iovlen;
+
+	if (!rtdm_rw_user_ok(fd, msg->msg_iov, sz))
+		return -EFAULT;
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	if (rtdm_fd_is_compat(fd))
+		return sys32_put_iovec(
+			(struct compat_iovec __user *)msg->msg_iov, iov,
+			(int)msg->msg_iovlen);
+#endif
+
+	return rtdm_copy_to_user(fd, msg->msg_iov, iov, sz);
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_put_iovec);
+
 static void destroy_fd(void *cookie, struct xnid *id)
 {
 	struct cobalt_ppd *p = cookie;
-- 
2.39.1

