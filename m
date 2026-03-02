Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04C38F63D
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444302; cv=none; b=dDbFbIQ94qsM1gy/O/Ec6YwRFeanz9g8Ub2nznJZ+KcSn2mo8U/kDFb5zJVL6iUfOULz0oxpmE4kXQcXDPkSprpig1JP9bYnEnS4ENmi9lfSGegNjjcdScWLQ83Va9FSvzRTpunz1UHrWISYvjr5st/ZHpHQ8PEmbPrAg/o8Z20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444302; c=relaxed/simple;
	bh=y35uB0oH+64SFs3LtfABfD2pWR6RoylZBoHJmYNAMq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szrLmh2r944EpIUaaGZ0RCqN1rorcQD3+qsZalHb1Uwnpz6xPx6O2jv8g0D9JJoPwLaLRXRz0Q3VhJb2ICxJR285vuhntBeqEfgtZZkWzLj1juiph5SzgG+GbKkPF2BApMFN3mUcaoS5jxrRqWwUB6kEaAfavLc3rhegL+Lep1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bP1G/D9p; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bP1G/D9p"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026030209380912e09bb8e10002076c
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wjhqskGFpFfYUURChHQ/o9NFT2ALb9MCjTvtgcpR/d4=;
 b=bP1G/D9pgtIHhCcdUWZeaOgREfkAQp5m9fKfmzIRm1wxMOUpbmOsFWJawNruhPxkp2evHl
 yGdRdck6u4GTvbE4s+YQ2+0oNoQX7ZPB/I0BwsoaFddbvm6mTcCCkbOxIQpAFnllMI9+sORy
 tDWdn7nj8z4tQ41H1epVo8eaC12PimzvRavDuAJncoUrYwPxuXag0heaKY1JyvurgP3B78gE
 d81JCan2dvdMvoKRjEPFNypyLfc8qHNyqIr9OcUcRgoZRCtzyyjGJgWs6m4QQuqw7SN6HFJc
 HCWY8bQ08/sfh8YEGGYrO74rDb0mnj0UFQZ7RzgcXtdgSqJzmggMR2MA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:10 +0100
Subject: [PATCH v2 11/20] lib/cobalt: rtdm: Move all time64 related
 services to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-11-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Code movement only.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/rtdm.c            | 71 ------------------------------------------
 lib/cobalt/wrappers_time64.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 71 deletions(-)

diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index ec950e15db921b32458d746d300ff6c542a8b23b..df7aa7eb69904f0953be2d324f29d60913916a4a 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -169,24 +169,6 @@ COBALT_IMPL(int, fcntl, (int fd, int cmd, ...))
 	return __STD(fcntl(fd, cmd, arg));
 }
 
-COBALT_IMPL_TIME64(int, ioctl, __ioctl_time64,
-		   (int fd, unsigned int request, ...))
-{
-	va_list ap;
-	void *arg;
-	int ret;
-
-	va_start(ap, request);
-	arg = va_arg(ap, void *);
-	va_end(ap);
-
-	ret = do_ioctl(fd, request, arg);
-	if (ret != -EADV && ret != -ENOSYS)
-		return set_errno(ret);
-
-	return __STD(ioctl(fd, request, arg));
-}
-
 COBALT_IMPL(ssize_t, read, (int fd, void *buf, size_t nbyte))
 {
 	int ret, oldtype;
@@ -243,29 +225,6 @@ COBALT_IMPL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags))
 	return __STD(recvmsg(fd, msg, flags));
 }
 
-COBALT_IMPL_TIME64(int, recvmmsg, __recvmmsg64,
-		   (int fd, struct mmsghdr *msgvec, unsigned int vlen,
-		    unsigned int flags, struct timespec *timeout))
-{
-	int ret, oldtype;
-
-	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-#ifdef __USE_TIME_BITS64
-	ret = XENOMAI_SYSCALL5(sc_cobalt_recvmmsg64, fd, msgvec,
-				vlen, flags, timeout);
-#else
-	ret = XENOMAI_SYSCALL5(sc_cobalt_recvmmsg, fd, msgvec, vlen, flags, timeout);
-#endif
-
-	pthread_setcanceltype(oldtype, NULL);
-
-	if (ret != -EADV && ret != -ENOSYS)
-		return set_errno(ret);
-
-	return __STD(recvmmsg(fd, msgvec, vlen, flags, timeout));
-}
-
 static ssize_t do_sendmsg(int fd, const struct msghdr *msg, int flags)
 {
 	int ret, oldtype;
@@ -408,36 +367,6 @@ COBALT_IMPL(ssize_t, send, (int fd, const void *buf, size_t len, int flags))
 	return __STD(send(fd, buf, len, flags));
 }
 
-COBALT_IMPL_TIME64(int, getsockopt, __getsockopt64,
-		   (int fd, int level, int optname, void *optval,
-		    socklen_t *optlen))
-{
-	struct _rtdm_getsockopt_args args = { level, optname, optval, optlen };
-	int ret;
-
-	ret = do_ioctl(fd, _RTIOC_GETSOCKOPT, &args);
-	if (ret != -EADV && ret != -ENOSYS)
-		return set_errno(ret);
-
-	return __STD(getsockopt(fd, level, optname, optval, optlen));
-}
-
-COBALT_IMPL_TIME64(int, setsockopt, __setsockopt64,
-		   (int fd, int level, int optname, const void *optval,
-		    socklen_t optlen))
-{
-	struct _rtdm_setsockopt_args args = {
-		level, optname, (void *)optval, optlen
-	};
-	int ret;
-
-	ret = do_ioctl(fd, _RTIOC_SETSOCKOPT, &args);
-	if (ret != -EADV && ret != -ENOSYS)
-		return set_errno(ret);
-
-	return __STD(setsockopt(fd, level, optname, optval, optlen));
-}
-
 COBALT_IMPL(int, bind, (int fd, const struct sockaddr *my_addr, socklen_t addrlen))
 {
 	struct _rtdm_setsockaddr_args args = { my_addr, addrlen };
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index 404e0c63f8a1241b5a34ad663e5ac020dcf0b44a..1e830945f381117ac6180476dd95a3608b5596b6 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -16,13 +16,16 @@
 #include "internal.h"
 #include "mq.h"
 #include "mutex.h"
+#include "rtdm.h"
 
 #include <asm/xenomai/syscall.h>
 #include <cobalt/uapi/syscall.h>
+#include <rtdm/rtdm.h>
 
 #include <errno.h>
 #include <mqueue.h>
 #include <pthread.h>
+#include <sys/socket.h>
 #include <sys/time.h>
 #include <time.h>
 
@@ -687,3 +690,74 @@ int pthread_timedmutex_lock_interruptible_np(pthread_mutex_t *mutex,
 	return __pthread_mutex_timedlock(mutex, to);
 }
 #endif
+
+COBALT_IMPL_TIME64(int, ioctl, __ioctl_time64,
+		   (int fd, unsigned int request, ...))
+{
+	va_list ap;
+	void *arg;
+	int ret;
+
+	va_start(ap, request);
+	arg = va_arg(ap, void *);
+	va_end(ap);
+
+	ret = do_ioctl(fd, request, arg);
+	if (ret != -EADV && ret != -ENOSYS)
+		return set_errno(ret);
+
+	return __STD(ioctl(fd, request, arg));
+}
+
+COBALT_IMPL_TIME64(int, recvmmsg, __recvmmsg64,
+		   (int fd, struct mmsghdr *msgvec, unsigned int vlen,
+		    unsigned int flags, struct timespec *timeout))
+{
+	int ret, oldtype;
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL5(sc_cobalt_recvmmsg64, fd, msgvec, vlen, flags,
+			       timeout);
+#else
+	ret = XENOMAI_SYSCALL5(sc_cobalt_recvmmsg, fd, msgvec, vlen, flags,
+			       timeout);
+#endif
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	if (ret != -EADV && ret != -ENOSYS)
+		return set_errno(ret);
+
+	return __STD(recvmmsg(fd, msgvec, vlen, flags, timeout));
+}
+
+COBALT_IMPL_TIME64(int, getsockopt, __getsockopt64,
+		   (int fd, int level, int optname, void *optval,
+		    socklen_t *optlen))
+{
+	struct _rtdm_getsockopt_args args = { level, optname, optval, optlen };
+	int ret;
+
+	ret = do_ioctl(fd, _RTIOC_GETSOCKOPT, &args);
+	if (ret != -EADV && ret != -ENOSYS)
+		return set_errno(ret);
+
+	return __STD(getsockopt(fd, level, optname, optval, optlen));
+}
+
+COBALT_IMPL_TIME64(int, setsockopt, __setsockopt64,
+		   (int fd, int level, int optname, const void *optval,
+		    socklen_t optlen))
+{
+	struct _rtdm_setsockopt_args args = { level, optname, (void *)optval,
+					      optlen };
+	int ret;
+
+	ret = do_ioctl(fd, _RTIOC_SETSOCKOPT, &args);
+	if (ret != -EADV && ret != -ENOSYS)
+		return set_errno(ret);
+
+	return __STD(setsockopt(fd, level, optname, optval, optlen));
+}

-- 
2.53.0

