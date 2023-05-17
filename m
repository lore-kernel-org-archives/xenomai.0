Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5643D1548D
	for <xenomai@lists.linux.dev>; Wed, 17 May 2023 09:34:49 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023051709344260a60fd2847584f689
        for <xenomai@lists.linux.dev>;
        Wed, 17 May 2023 11:34:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=y5pQZ/zlp79LGHWYm3KUVbyBejVUiihiDPQful3QDt0=;
 b=JreURy8cZqXn6s3qd6hSrkeNC0qn/YXongC/og5A8Hhbhkn2j3SJ+gBwGsDdFI0cf3RFcD
 VlCZk3nbbk0tLcrbRlfQdFEPURpc8quB7wue0BVIFAsUYBGfBioOOZ4tAWUe6g3hFd4KLg6G
 bsxSGGCXhQ8blW41P78aTPYnPGiLw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 17 May 2023 11:34:40 +0200
Subject: [PATCH 1/3] y2038: cobalt/posix/select: Refactor __cobalt_select()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230516-florian-y2038-part-three-v1-1-b140278b26c6@siemens.com>
References: <20230516-florian-y2038-part-three-v1-0-b140278b26c6@siemens.com>
In-Reply-To: <20230516-florian-y2038-part-three-v1-0-b140278b26c6@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is no y2038 safe select() syscall provided by Linuy. If y2038
safety is required the application should not use select() and move on
to something like pselect().

As we still want to support select() for keeping backward compatibility
- even if y2038 safety is requested - an additional pselect() based
entry will be introduced soon which will re-use __cobalt_select().

This patch moves all the timeout related userspace copy operations out
of __cobalt_select() and migrates __cobalt_select() to
struct timespec64. That will allow pselect64() to be based on
__cobalt_select() as well.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .../cobalt/include/asm-generic/xenomai/syscall.h   | 22 ++++++++
 kernel/cobalt/posix/clock.h                        |  6 +--
 kernel/cobalt/posix/io.c                           | 62 +++++++++++-----------
 kernel/cobalt/posix/syscall32.c                    | 24 ++++++++-
 4 files changed, 78 insertions(+), 36 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index 70b3e68f9..d61b985fb 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -138,6 +138,28 @@ static inline int cobalt_put_u_itimerspec(
 	return cobalt_copy_to_user(dst, &u_its, sizeof(*dst));
 }
 
+static inline struct timespec64
+cobalt_timeval_to_timespec64(const struct __kernel_old_timeval *src)
+{
+	struct timespec64 ts;
+
+	ts.tv_sec = src->tv_sec + (src->tv_usec / USEC_PER_SEC);
+	ts.tv_nsec = (src->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
+
+	return ts;
+}
+
+static inline struct __kernel_old_timeval
+cobalt_timespec64_to_timeval(const struct timespec64 *src)
+{
+	struct __kernel_old_timeval tv;
+
+	tv.tv_sec = src->tv_sec + (src->tv_nsec / NSEC_PER_SEC);
+	tv.tv_usec = (src->tv_nsec % NSEC_PER_SEC) / NSEC_PER_USEC;
+
+	return tv;
+}
+
 /* 32bit syscall emulation */
 #define __COBALT_COMPAT_BIT	0x1
 /* 32bit syscall emulation - extended form */
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index dbaabbc5d..38b59e24f 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -68,12 +68,12 @@ static inline xnticks_t tv2ns(const struct __kernel_old_timeval *tv)
 	return nsecs;
 }
 
-static inline void ticks2tv(struct __kernel_old_timeval *tv, xnticks_t ticks)
+static inline void ticks2ts64(struct timespec64 *ts, xnticks_t ticks)
 {
 	unsigned long nsecs;
 
-	tv->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
-	tv->tv_usec = nsecs / 1000;
+	ts->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
+	ts->tv_nsec = nsecs;
 }
 
 static inline xnticks_t clock_get_ticks(clockid_t clock_id)
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 45ec09fae..ebe7791ab 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -221,7 +221,7 @@ static int __cobalt_select_bind_all(struct xnselector *selector,
 }
 
 int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
-		    void __user *u_xfds, void __user *u_tv, bool compat)
+		    void __user *u_xfds, struct timespec64 *to, bool compat)
 {
 	void __user *ufd_sets[XNSELECT_MAX_TYPES] = {
 		[XNSELECT_READ] = u_rfds,
@@ -237,13 +237,12 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 	xntmode_t mode = XN_RELATIVE;
 	struct xnselector *selector;
 	struct xnthread *curr;
-	struct __kernel_old_timeval tv;
 	size_t fds_size;
 	int i, err;
 
 	curr = xnthread_current();
 
-	if (u_tv) {
+	if (to) {
 		if (xnthread_test_localinfo(curr, XNSYSRST)) {
 			xnthread_clear_localinfo(curr, XNSYSRST);
 
@@ -255,23 +254,11 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 				goto out;
 			}
 		} else {
-#ifdef CONFIG_XENO_ARCH_SYS3264
-			if (compat) {
-				if (sys32_get_timeval(&tv, u_tv))
-					return -EFAULT;
-			} else
-#endif
-			{
-				if (!access_ok(u_tv, sizeof(tv))
-				    || cobalt_copy_from_user(&tv, u_tv,
-							     sizeof(tv)))
-					return -EFAULT;
-			}
 
-			if (tv.tv_usec >= 1000000)
+			if (!timespec64_valid(to))
 				return -EINVAL;
 
-			timeout = clock_get_ticks(CLOCK_MONOTONIC) + tv2ns(&tv);
+			timeout = clock_get_ticks(CLOCK_MONOTONIC) + ts2ns(to);
 		}
 
 		mode = XN_ABSOLUTE;
@@ -343,23 +330,12 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 	}
 
 out:
-	if (u_tv && (err > 0 || err == -EINTR)) {
+	if (to && (err > 0 || err == -EINTR)) {
 		xnsticks_t diff = timeout - clock_get_ticks(CLOCK_MONOTONIC);
 		if (diff > 0)
-			ticks2tv(&tv, diff);
+			ticks2ts64(to, diff);
 		else
-			tv.tv_sec = tv.tv_usec = 0;
-
-#ifdef CONFIG_XENO_ARCH_SYS3264
-		if (compat) {
-			if (sys32_put_timeval(u_tv, &tv))
-				return -EFAULT;
-		} else
-#endif
-		{
-			if (cobalt_copy_to_user(u_tv, &tv, sizeof(tv)))
-				return -EFAULT;
-		}
+			to->tv_sec = to->tv_nsec = 0;
 	}
 
 	if (err >= 0)
@@ -390,5 +366,27 @@ COBALT_SYSCALL(select, primary,
 		fd_set __user *u_xfds,
 		struct __kernel_old_timeval __user *u_tv))
 {
-	return __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, u_tv, false);
+	struct timespec64 ts64, *to = NULL;
+	struct __kernel_old_timeval tv;
+	int ret;
+
+	if (u_tv && (!access_ok(u_tv, sizeof(tv)) ||
+		     cobalt_copy_from_user(&tv, u_tv, sizeof(tv))))
+		return -EFAULT;
+
+	if (u_tv) {
+		ts64 = cobalt_timeval_to_timespec64(&tv);
+		to = &ts64;
+	}
+
+	ret = __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, false);
+	if (ret)
+		return ret;
+
+	if (u_tv) {
+		tv = cobalt_timespec64_to_timeval(to);
+		ret = cobalt_copy_to_user(u_tv, &tv, sizeof(tv));
+	}
+
+	return ret;
 }
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 10b080dfd..466534f4c 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -749,7 +749,29 @@ COBALT_SYSCALL32emu(select, primary,
 		     compat_fd_set __user *u_xfds,
 		     struct old_timeval32 __user *u_tv))
 {
-	return __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, u_tv, true);
+	struct timespec64 ts64, *to = NULL;
+	struct __kernel_old_timeval tv;
+	int ret;
+
+	if (u_tv &&
+	    (!access_ok(u_tv, sizeof(tv)) || sys32_get_timeval(&tv, u_tv)))
+		return -EFAULT;
+
+	if (u_tv) {
+		ts64 = cobalt_timeval_to_timespec64(&tv);
+		to = &ts64;
+	}
+
+	ret = __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, true);
+	if (ret)
+		return ret;
+
+	if (u_tv) {
+		tv = cobalt_timespec64_to_timeval(to);
+		ret = sys32_put_timeval(u_tv, &tv);
+	}
+
+	return ret;
 }
 
 COBALT_SYSCALL32emu(recvmsg, handover,

-- 
2.39.2

