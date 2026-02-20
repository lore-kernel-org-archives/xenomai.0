Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775C31B10D
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578544; cv=none; b=o9n//xFQB0npfz0oyyxGpvoM1bgsrYg1Mtm1PmGbrhjFA0WxB8qohGYfXtomVpgfoJHOA7wiOFoaeCAjGq75naNVHERbqwVDH7SBMKhyUSFo9SG83vja0nwvbKeOn9azUfSBpdEAiILWp6T8TNiSb3KJcmeIJ8UDcn2fwX833tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578544; c=relaxed/simple;
	bh=rUukH7Q8GkaP6rGAW1bhhoXldpJxv8JKKHk8PYt9zYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g6XVtxRnHzZNgas9R54/FhS1BxmyWwK81Am+e7ly9gLcFfMWkaHpLtKhcImAMSbC8au85yHWW22PSJzlKCHPPUwMMGdq9t/MmXDei0gp3j0AQXtc728xB/1yYbpyiSVA0/uKSdtpfIBw70YbPW8zkYvOy9rivXcttE2Wmmvro7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FubznjcY; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FubznjcY"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026022009084743cdafb5ba00020714
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rBoeKLfsr6iSgENCRwYzWy8e7X1s950c+JMuriNq9JQ=;
 b=FubznjcYWMEd4bZGcNWRFS9ocZnFb4HBPpOyAIhLTqu8SOfA0dRpdVphQ77SJQpwKeo+um
 GQDvgfqpEzdDzBMii9Y9YVfg1l58t7vPCxdAiFuZqsntzHA4SuVI8MeHoWvGg02XGpVQwu8Q
 LexMBI9LtY4Qh5aiD/o3bPxnSd8oOi9SNSIhvtgRcPieC1NHYYdEFf3ff3OfFJT8QfWC+P91
 K0slUXaeZI5fKLOYJflqLzyefUyk94m17JTjw7K4vn0YbyUNeW7D1f2U/HxQQBmHTJKBb3SF
 9yn9AwPLerD5uq5pyIRFjvtQ0rOJxybTjCFXpHvjnL+cCZj888wBoXtA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:54 +0100
Subject: [PATCH 11/20] lib/cobalt: rtdm: Move all time64 related services
 to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-11-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
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
index fbd644bef485b4ec9d319373ffa702bc1927a75d..ded0232824fade9b2f656c03ac3e5515fb5f8b38 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -9,13 +9,16 @@
 #include "internal.h"
 #include "mutex.h"
 #include "mq.h"
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
 
@@ -680,3 +683,74 @@ int pthread_timedmutex_lock_interruptible_np(pthread_mutex_t *mutex,
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

