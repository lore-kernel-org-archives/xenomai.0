Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC8031B111
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578544; cv=none; b=FtWLYrfQxoArl2gzee9mNktmgbtyTTMrLitpSH1qY3lvwxQgnZJH3fAaC1aojjk9vLsyWAVRdUrlsHZaYyxPdennQRrycqKu5hGUpH3ayVbmSKNvQgM7H/WC4CJ2mWsUXPVXHmvHLKJwmPv8HEMAuzCCXHhbjueMmT1eBm4fJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578544; c=relaxed/simple;
	bh=0fnzWNtRaemhnfHjdZwymPbl3AW7jQrOKasugYtKEOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwC+mZL3N+Ep2wBxorJXBOAl0V0rlYi5bxVsoW8oPmxc7Fkq/hDf/GzeEuvgv2Fx9vv54PxKzv5rsla2X8yB5pErzz1jqJg30BVdHbjxhWILs7Ra7JA15/SUN6bZzCdtrAf1qy70Brzt1PUe/LwopZ95M/wDHDkQ1W3Z/EAmJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bnbDnU1R; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bnbDnU1R"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260220090847c629ee6709000207e5
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=afLcFcYHciWlO/b42g1z4M/6ZOXdcxJK/8378CjHGLM=;
 b=bnbDnU1R5RalKXDnZo6ZC8YxL5/8wGHy4R3ehJnESYsM8bi73kJ/0ZBMB+NyPRPgLzUzzE
 0TaQHJtUE+BUD1o9pcXDdlG9XecUPgZLuZceFZYGK6pLez9ryd/VK611jOKrgMgo8NeKIDqz
 rEP2zfXha7hzcuSZEN2vnCugu31KFAyhKCm+UQByc/FdP2p/D/IT1QB81Mdoov7lQdxFd32E
 vzswePqDUZQDb6RuKTlYuo+Wi+WQyOFVnPS5RPJKurl1gpuYWVDZIqvNl3GonZmP/Y9Tj8S1
 x/qQUWghpqGRARAFl8Pb3ipPItPnoVCl8D3c0UNZxL/hUC+jDjNMEr8w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:55 +0100
Subject: [PATCH 12/20] lib/cobalt: select: Move select services into
 wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-12-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

select.c is no longer needed as everything inside is time64_t affected.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/Makefile.am       |   1 -
 lib/cobalt/select.c          | 108 -------------------------------------------
 lib/cobalt/wrappers_time64.c |  86 ++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 109 deletions(-)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 17e203f9015fe2bb5306609e4d51c62f3a725780..c31f030117dfc3ddf5ae386897fbc8a2435912a8 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -33,7 +33,6 @@ libcobalt_la_SOURCES =		\
 	printf.c		\
 	rtdm.c			\
 	sched.c			\
-	select.c		\
 	semaphore.c		\
 	signal.c		\
 	sigshadow.c		\
diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
deleted file mode 100644
index 5472e991e126c2f521b346a7cf3c884bbf6f6317..0000000000000000000000000000000000000000
--- a/lib/cobalt/select.c
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- * Copyright (C) 2010 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
-
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-
-#include <errno.h>
-#include <pthread.h>
-#include <sys/select.h>
-#include <asm/xenomai/syscall.h>
-
-#if __USE_TIME_BITS64 && __TIMESIZE == 32
-
-#define USEC_PER_SEC	1000000L
-#define NSEC_PER_USEC	1000L
-
-/*
- * The time64 wrapper for select() is a little different:
- * There is no y2038 safe syscall for select() itself, but we have pselect()
- * without signal support.
- */
-static inline int do_select(int __nfds, fd_set *__restrict __readfds,
-			      fd_set *__restrict __writefds,
-			      fd_set *__restrict __exceptfds,
-			      struct timeval *__restrict __timeout)
-{
-	struct timespec to;
-	int err, oldtype;
-
-	if (__timeout) {
-		to.tv_sec =
-			__timeout->tv_sec + (__timeout->tv_usec / USEC_PER_SEC);
-		to.tv_nsec =
-			(__timeout->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
-	}
-
-	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-	/*
-	 * Note: No sigmask here, we already reached the limit of 5
-	 * syscall parameters
-	 */
-	err = XENOMAI_SYSCALL5(sc_cobalt_pselect64, __nfds, __readfds,
-			       __writefds, __exceptfds, __timeout ? &to : NULL);
-
-	pthread_setcanceltype(oldtype, NULL);
-
-	if (err == -EADV || err == -EPERM || err == -ENOSYS) {
-		err = __STD(__select64(__nfds, __readfds, __writefds,
-				       __exceptfds, __timeout));
-	} else if (__timeout) {
-		__timeout->tv_sec = to.tv_sec;
-		__timeout->tv_usec = to.tv_nsec / 1000;
-	}
-
-	if (err >= 0)
-		return err;
-
-	errno = -err;
-	return -1;
-}
-#else
-static inline int do_select(int __nfds, fd_set *__restrict __readfds,
-			    fd_set *__restrict __writefds,
-			    fd_set *__restrict __exceptfds,
-			    struct timeval *__restrict __timeout)
-{
-	int err, oldtype;
-
-	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-	err = XENOMAI_SYSCALL5(sc_cobalt_select, __nfds,
-			       __readfds, __writefds, __exceptfds, __timeout);
-
-	pthread_setcanceltype(oldtype, NULL);
-
-	if (err == -EADV || err == -EPERM || err == -ENOSYS)
-		return __STD(select(__nfds, __readfds,
-				    __writefds, __exceptfds, __timeout));
-
-	if (err >= 0)
-		return err;
-
-	errno = -err;
-	return -1;
-}
-#endif
-
-COBALT_IMPL_TIME64(int, select, __select64,
-		   (int __nfds, fd_set *__restrict __readfds,
-		    fd_set *__restrict __writefds,
-		    fd_set *__restrict __exceptfds,
-		    struct timeval *__restrict __timeout))
-{
-	return do_select(__nfds, __readfds, __writefds, __exceptfds, __timeout);
-}
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index ded0232824fade9b2f656c03ac3e5515fb5f8b38..7b634976eb07d7ae143b4567983dbea7f4ddebea 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -754,3 +754,89 @@ COBALT_IMPL_TIME64(int, setsockopt, __setsockopt64,
 
 	return __STD(setsockopt(fd, level, optname, optval, optlen));
 }
+
+#if __USE_TIME_BITS64 && __TIMESIZE == 32
+
+#define USEC_PER_SEC	1000000L
+#define NSEC_PER_USEC	1000L
+
+/*
+ * The time64 wrapper for select() is a little different:
+ * There is no y2038 safe syscall for select() itself, but we have pselect()
+ * without signal support.
+ */
+static inline int do_select(int __nfds, fd_set *__restrict __readfds,
+			      fd_set *__restrict __writefds,
+			      fd_set *__restrict __exceptfds,
+			      struct timeval *__restrict __timeout)
+{
+	struct timespec to;
+	int err, oldtype;
+
+	if (__timeout) {
+		to.tv_sec =
+			__timeout->tv_sec + (__timeout->tv_usec / USEC_PER_SEC);
+		to.tv_nsec =
+			(__timeout->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
+	}
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+	/*
+	 * Note: No sigmask here, we already reached the limit of 5
+	 * syscall parameters
+	 */
+	err = XENOMAI_SYSCALL5(sc_cobalt_pselect64, __nfds, __readfds,
+			       __writefds, __exceptfds, __timeout ? &to : NULL);
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	if (err == -EADV || err == -EPERM || err == -ENOSYS) {
+		err = __STD(__select64(__nfds, __readfds, __writefds,
+				       __exceptfds, __timeout));
+	} else if (__timeout) {
+		__timeout->tv_sec = to.tv_sec;
+		__timeout->tv_usec = to.tv_nsec / 1000;
+	}
+
+	if (err >= 0)
+		return err;
+
+	errno = -err;
+	return -1;
+}
+#else
+static inline int do_select(int __nfds, fd_set *__restrict __readfds,
+			    fd_set *__restrict __writefds,
+			    fd_set *__restrict __exceptfds,
+			    struct timeval *__restrict __timeout)
+{
+	int err, oldtype;
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+	err = XENOMAI_SYSCALL5(sc_cobalt_select, __nfds,
+			       __readfds, __writefds, __exceptfds, __timeout);
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	if (err == -EADV || err == -EPERM || err == -ENOSYS)
+		return __STD(select(__nfds, __readfds,
+				    __writefds, __exceptfds, __timeout));
+
+	if (err >= 0)
+		return err;
+
+	errno = -err;
+	return -1;
+}
+#endif
+
+COBALT_IMPL_TIME64(int, select, __select64,
+		   (int __nfds, fd_set *__restrict __readfds,
+		    fd_set *__restrict __writefds,
+		    fd_set *__restrict __exceptfds,
+		    struct timeval *__restrict __timeout))
+{
+	return do_select(__nfds, __readfds, __writefds, __exceptfds, __timeout);
+}

-- 
2.53.0

