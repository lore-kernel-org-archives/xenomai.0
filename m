Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E872631
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444300; cv=none; b=oe/fOOi8fmsUZyQ98HHr7ZlwTMx4fHQRb4XAso+h1kO43ivx7gGhzD5XUnevIrvp6fRtOg4LMIhuDvUgzdTUy0jhZkGidN2EvlsNZfTK9pP0qKGRO9OOmHgTVmOKQ1sS/zqkdf4/QBsnZUgms+Z9Fbomws/Ze5KmkuOIAV0nb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444300; c=relaxed/simple;
	bh=oQv/QPZeB51zyLyqka4hHnxF1AqOKW3YtB2u9+n9lDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0W1ImAXdkogSR4v/WqfHaw6aORUD5OkLbrAQC9BZrD0r7weCFqnHJ/Q2rL/rgBPGm+Otq092Qd5I3V31500wbhlrLxg4/LQBgrLKgXhSXj3+DEGpEP3eB4AJU04mKmQADobhlvOdQ+n86NsUgQGhibiS2YxNxDaKtXtC7JH8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dcOF5rb7; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dcOF5rb7"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260302093809069057cc37000207a0
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZtQkjaOi5slamAc+hxZuYkfHH5Av4VEoYAZkyiNa3u4=;
 b=dcOF5rb7jtuRbXpEGiJTL/Dc3wXmGA4lGAcq/EeIjZPKTU5V0MoT7ItIKJoXQjc1xLv3hx
 mLYVRCC6Re8+cSsJhrBiJnOTbTNOoPizwphz3kjl/fNaeYeCziiHree+O2waJ3zddjUitQrK
 pwdAPUGt23d0R9CpLrB1ng2YWZdtgr5sYHIgipCF/VHJakJu9qiGdbZ+JbPRkUHs8DipcVPx
 QymuZW8FvCH9vUh2V1bnXfpsVP61qNzKtWTANeZrVtv93mlwo/DHk7LJkNT4HsPfe1uEM46V
 mf/LyxVQuJjXjyz3j+gWGWaqhIqaSMhv/E62C43czxNm4tFiPc7qc4OA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:11 +0100
Subject: [PATCH v2 12/20] lib/cobalt: select: Move select services into
 wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-12-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
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
 lib/cobalt/wrappers_time64.c |  87 ++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 109 deletions(-)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 68900c35104ff9bd94d1cb7534dfdc10b9795a18..be678eedf18f2d8a60afbf36060e27f2511383ec 100644
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
index 1e830945f381117ac6180476dd95a3608b5596b6..524d2774d3dad551e599de30aea4919967719bab 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -2,6 +2,7 @@
 
 /*
  * Copyright (C) 2026 Florian Bezdeka <florian.bezdeka@siemens.com>.
+ * Copyright (C) 2010 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
  * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
  */
 
@@ -761,3 +762,89 @@ COBALT_IMPL_TIME64(int, setsockopt, __setsockopt64,
 
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

