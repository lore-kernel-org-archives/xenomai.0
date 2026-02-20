Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDC731B123
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578541; cv=none; b=k9Xy1yj6Lyn30VaIVuWR9qCdHg4g4cBEZ8afiRlzM6dYAjWnx/G1cxYx8qJW5NhQuM/58GJlSns7rVY+PrFG8UeU5vboEYMufzVxLUd+vo4HV9qeNVRHw1vim+PRPycnR2RYpcq83Xh7I03aDoo3ERMZmJHLpQLzSEMxOandDW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578541; c=relaxed/simple;
	bh=I5lcj8LGQ+XTlri2UNB7C+la2H/lhXoYCjdwiYj4rNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQ/B0LimS9dL+ZSCaJkBJa90HbBd0ZiIqq6aeO1Rqu44VrhKjXJkOGcfFuWeAQR5/iU7BQmPbvscTm7BEOmcxJ3KQ42MBsw5nspTFntc/5iIDQ4zM4Akl4sSPaqJs2fCyNo54Do0Y62T2KKjxYti0UGkfLziEFQsVvLVsRAmzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=diE7/QFL; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="diE7/QFL"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260220090848aa8e0accd900020794
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sc+S1vuX3uscBwJ2h8ZFFnjLqE2zK0R8D07WNCKjHD4=;
 b=diE7/QFLuo9EbY44Cbw5YwjPr22XG9Ho9e9ZrRqB6WLNGc2nyjes1ot/IApZcu6XnGmobd
 cB8mHuHfklBYNVvgBqGxFsXy7NZQVeD56/tXh5bS34xygXRELjIDPFgWXCfyp2SiKGw6C65+
 zQo1Ff4pkv1V+CvCoJtJJWM/rXfpKfGqmLmYP/vll3Vnz8EwMT4LC60ibW/ssU5cpvbFrVVF
 F4YZ/QGOtHe1qN66bwxOW4AdSmOAKkT1hSqaYN7BUqJxuom/QfjZSlifHoHP0lO/IQEWk2DL
 2frQqXx5rjPpVkJIWcJ8APHi9bXz9uMGwA/sSSrht9Xy+0YYzdSaHPzQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:59 +0100
Subject: [PATCH 16/20] lib/cobalt: timerfd: Move time64 related services to
 wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-16-731c773e72cc@siemens.com>
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
 lib/cobalt/timerfd.c         | 39 ---------------------------------------
 lib/cobalt/wrappers_time64.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/lib/cobalt/timerfd.c b/lib/cobalt/timerfd.c
index 70e9a4e0743d503bb4b57d17ed7c77713bebf946..5fa1f1eaa3902293c81600431fb2d97557c671d2 100644
--- a/lib/cobalt/timerfd.c
+++ b/lib/cobalt/timerfd.c
@@ -17,7 +17,6 @@
  */
 
 #include <errno.h>
-#include <unistd.h>
 #include <sys/timerfd.h>
 #include <asm/xenomai/syscall.h>
 #include "internal.h"
@@ -35,41 +34,3 @@ COBALT_IMPL(int, timerfd_create, (int clockid, int flags))
 	return fd;
 }
 
-COBALT_IMPL_TIME64(int, timerfd_settime, __timerfd_settime64,
-		   (int fd, int flags, const struct itimerspec *new_value,
-		    struct itimerspec *old_value))
-{
-	int ret;
-
-#ifdef XN_USE_TIME64_SYSCALL
-	long sc_nr = sc_cobalt_timerfd_settime64;
-#else
-	long sc_nr = sc_cobalt_timerfd_settime;
-#endif
-
-	ret = -XENOMAI_SYSCALL4(sc_nr, fd, flags, new_value, old_value);
-	if (ret == 0)
-		return ret;
-	
-	errno = ret;
-	return -1;
-}
-
-COBALT_IMPL_TIME64(int, timerfd_gettime, __timerfd_gettime64,
-		   (int fd, struct itimerspec *curr_value))
-{
-	int ret;
-
-#ifdef XN_USE_TIME64_SYSCALL
-	long sc_nr = sc_cobalt_timerfd_gettime64;
-#else
-	long sc_nr = sc_cobalt_timerfd_gettime;
-#endif
-
-	ret = -XENOMAI_SYSCALL2(sc_nr, fd, curr_value);
-	if (ret == 0)
-		return ret;
-	
-	errno = ret;
-	return -1;
-}
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index b4714f22ce3d632cf11456838854df9093b83902..bcb954c1f85b93f24ceb59999e57e4c935b2171f 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -1043,3 +1043,42 @@ COBALT_IMPL_TIME64(int, timer_gettime, __timer_gettime64,
 
 	return -1;
 }
+
+COBALT_IMPL_TIME64(int, timerfd_settime, __timerfd_settime64,
+		   (int fd, int flags, const struct itimerspec *new_value,
+		    struct itimerspec *old_value))
+{
+	int ret;
+
+#ifdef XN_USE_TIME64_SYSCALL
+	long sc_nr = sc_cobalt_timerfd_settime64;
+#else
+	long sc_nr = sc_cobalt_timerfd_settime;
+#endif
+
+	ret = -XENOMAI_SYSCALL4(sc_nr, fd, flags, new_value, old_value);
+	if (ret == 0)
+		return ret;
+
+	errno = ret;
+	return -1;
+}
+
+COBALT_IMPL_TIME64(int, timerfd_gettime, __timerfd_gettime64,
+		   (int fd, struct itimerspec *curr_value))
+{
+	int ret;
+
+#ifdef XN_USE_TIME64_SYSCALL
+	long sc_nr = sc_cobalt_timerfd_gettime64;
+#else
+	long sc_nr = sc_cobalt_timerfd_gettime;
+#endif
+
+	ret = -XENOMAI_SYSCALL2(sc_nr, fd, curr_value);
+	if (ret == 0)
+		return ret;
+
+	errno = ret;
+	return -1;
+}

-- 
2.53.0

