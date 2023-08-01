Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D21F95A
	for <xenomai@lists.linux.dev>; Tue,  1 Aug 2023 09:39:53 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202308010929442e11ac9dbd4c331311
        for <xenomai@lists.linux.dev>;
        Tue, 01 Aug 2023 11:29:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gOADnEsQ80L6BbIv/AzvmdQ4z0IU1JS2A05MwCGO0W4=;
 b=ps9U/+CRSP/XlYleW5EUIJQZVJWkAm+zMGIh4ieEQzCPPUn0fe4UKBeBey5LZOK4wGNNxq
 7ElfYY4PjeYOzMF5CucvnO5yCkgL/+uIK993xqSjDJHEzvpejmbzhsnFtCsUCWBgLulQX7Vr
 wXZVHwbwxSIKwFDh+b7Co6T1QxNa4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 01 Aug 2023 11:29:37 +0200
Subject: [PATCH v3 3/7] y2038: cobalt/uapi: Remove
 __user_old_{timespec,itimerspec,timeval,timex}
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v3-3-2aea39ad909a@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The types below were "native" types representing 64 bit time_t on 64
bit systems and 32 bit time_t on 32 bit systems. As those types were
xenomai specific types they could not be used for "auto y2038 support"
enablement by using compile time flags.

1:1 type replacements:
  __user_old_timespec    ->  __kernel_old_timespec (still "native")
  __user_old_timeval     ->  __kernel_old_timeval  (still "native")

Type migrations to "32 bit always":
  __user_old_itimerspec  ->  old_itimerspec32
  __user_old_timex       ->  old_timex32

  Affected syscalls will only be used by 32 bit applications. The
  "native" variant will be routed to 64 bit services.

Renamed functions:
  cobalt_get_u_itimerspec -> cobalt_get_itimerspec32
  cobalt_put_u_itimerspec -> cobalt_put_itimerspec32
  cobalt_get_u_timespec   -> cobalt_get_old_timespec
  cobalt_put_u_timespec   -> cobalt_put_old_timespec

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/kernel/types.h                 | 53 ----------------------
 .../cobalt/include/asm-generic/xenomai/syscall.h   | 29 ++++++------
 kernel/cobalt/posix/clock.c                        | 23 +++++-----
 kernel/cobalt/posix/clock.h                        | 12 ++---
 kernel/cobalt/posix/cond.c                         |  4 +-
 kernel/cobalt/posix/cond.h                         |  2 +-
 kernel/cobalt/posix/event.c                        |  4 +-
 kernel/cobalt/posix/event.h                        |  2 +-
 kernel/cobalt/posix/io.c                           |  4 +-
 kernel/cobalt/posix/io.h                           |  2 +-
 kernel/cobalt/posix/monitor.c                      |  4 +-
 kernel/cobalt/posix/monitor.h                      |  2 +-
 kernel/cobalt/posix/mqueue.c                       |  6 +--
 kernel/cobalt/posix/mqueue.h                       |  4 +-
 kernel/cobalt/posix/mutex.c                        |  4 +-
 kernel/cobalt/posix/mutex.h                        |  2 +-
 kernel/cobalt/posix/sem.c                          |  4 +-
 kernel/cobalt/posix/sem.h                          |  2 +-
 kernel/cobalt/posix/signal.c                       |  2 +-
 kernel/cobalt/posix/signal.h                       |  2 +-
 kernel/cobalt/posix/timer.c                        | 14 +++---
 kernel/cobalt/posix/timer.h                        |  6 +--
 kernel/cobalt/posix/timerfd.c                      | 14 +++---
 kernel/cobalt/posix/timerfd.h                      |  6 +--
 lib/cobalt/clock.c                                 |  2 +-
 lib/cobalt/internal.h                              |  5 ++
 lib/cobalt/timer.c                                 |  4 +-
 lib/cobalt/timerfd.c                               |  4 +-
 28 files changed, 90 insertions(+), 132 deletions(-)

diff --git a/include/cobalt/uapi/kernel/types.h b/include/cobalt/uapi/kernel/types.h
index eefc5a764..04ba76c6e 100644
--- a/include/cobalt/uapi/kernel/types.h
+++ b/include/cobalt/uapi/kernel/types.h
@@ -62,57 +62,4 @@ struct xn_ts64 {
 	__s64 tv_nsec;
 };
 
-/*
- * Our representation of time specs at the kernel<->user interface
- * boundary at the moment, until we have fully transitioned to a
- * y2038-safe implementation in libcobalt. Once done, those legacy
- * types will be removed.
- */
-struct __user_old_timespec {
-	long  tv_sec;
-	long  tv_nsec;
-};
-
-struct __user_old_itimerspec {
-	struct __user_old_timespec it_interval;
-	struct __user_old_timespec it_value;
-};
-
-struct __user_old_timeval {
-	long  tv_sec;
-	long  tv_usec;
-};
-
-/* Lifted from include/uapi/linux/timex.h. */
-struct __user_old_timex {
-	unsigned int modes;	/* mode selector */
-	__kernel_long_t offset;	/* time offset (usec) */
-	__kernel_long_t freq;	/* frequency offset (scaled ppm) */
-	__kernel_long_t maxerror;/* maximum error (usec) */
-	__kernel_long_t esterror;/* estimated error (usec) */
-	int status;		/* clock command/status */
-	__kernel_long_t constant;/* pll time constant */
-	__kernel_long_t precision;/* clock precision (usec) (read only) */
-	__kernel_long_t tolerance;/* clock frequency tolerance (ppm)
-				   * (read only)
-				   */
-	struct __user_old_timeval time;	/* (read only, except for ADJ_SETOFFSET) */
-	__kernel_long_t tick;	/* (modified) usecs between clock ticks */
-
-	__kernel_long_t ppsfreq;/* pps frequency (scaled ppm) (ro) */
-	__kernel_long_t jitter; /* pps jitter (us) (ro) */
-	int shift;              /* interval duration (s) (shift) (ro) */
-	__kernel_long_t stabil;            /* pps stability (scaled ppm) (ro) */
-	__kernel_long_t jitcnt; /* jitter limit exceeded (ro) */
-	__kernel_long_t calcnt; /* calibration intervals (ro) */
-	__kernel_long_t errcnt; /* calibration errors (ro) */
-	__kernel_long_t stbcnt; /* stability limit exceeded (ro) */
-
-	int tai;		/* TAI offset (ro) */
-
-	int  :32; int  :32; int  :32; int  :32;
-	int  :32; int  :32; int  :32; int  :32;
-	int  :32; int  :32; int  :32;
-};
-
 #endif /* !_COBALT_UAPI_KERNEL_TYPES_H */
diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index d61b985fb..facc60bcc 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -73,10 +73,11 @@ static inline int cobalt_strncpy_from_user(char *dst, const char __user *src,
  * sys32_get_*(), sys32_put_*() instead.
  */
 
-static inline int cobalt_get_u_timespec(struct timespec64 *dst,
-			const struct __user_old_timespec __user *src)
+static inline int
+cobalt_get_old_timespec(struct timespec64 *dst,
+			const struct __kernel_old_timespec __user *src)
 {
-	struct __user_old_timespec u_ts;
+	struct __kernel_old_timespec u_ts;
 	int ret;
 
 	ret = cobalt_copy_from_user(&u_ts, src, sizeof(u_ts));
@@ -89,11 +90,11 @@ static inline int cobalt_get_u_timespec(struct timespec64 *dst,
 	return 0;
 }
 
-static inline int cobalt_put_u_timespec(
-	struct __user_old_timespec __user *dst,
-	const struct timespec64 *src)
+static inline int
+cobalt_put_old_timespec(struct __kernel_old_timespec __user *dst,
+			const struct timespec64 *src)
 {
-	struct __user_old_timespec u_ts;
+	struct __kernel_old_timespec u_ts;
 	int ret;
 
 	u_ts.tv_sec = src->tv_sec;
@@ -106,10 +107,11 @@ static inline int cobalt_put_u_timespec(
 	return 0;
 }
 
-static inline int cobalt_get_u_itimerspec(struct itimerspec64 *dst,
-			const struct __user_old_itimerspec __user *src)
+static inline int
+cobalt_get_itimerspec32(struct itimerspec64 *dst,
+			const struct old_itimerspec32 __user *src)
 {
-	struct __user_old_itimerspec u_its;
+	struct old_itimerspec32 u_its;
 	int ret;
 
 	ret = cobalt_copy_from_user(&u_its, src, sizeof(u_its));
@@ -124,11 +126,10 @@ static inline int cobalt_get_u_itimerspec(struct itimerspec64 *dst,
 	return 0;
 }
 
-static inline int cobalt_put_u_itimerspec(
-	struct __user_old_itimerspec __user *dst,
-	const struct itimerspec64 *src)
+static inline int cobalt_put_itimerspec32(struct old_itimerspec32 __user *dst,
+					  const struct itimerspec64 *src)
 {
-	struct __user_old_itimerspec u_its;
+	struct old_itimerspec32 u_its;
 
 	u_its.it_interval.tv_sec = src->it_interval.tv_sec;
 	u_its.it_interval.tv_nsec = src->it_interval.tv_nsec;
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 48cd87aef..845918a4a 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -76,7 +76,7 @@ int __cobalt_clock_getres(clockid_t clock_id, struct timespec64 *ts)
 }
 
 COBALT_SYSCALL(clock_getres, current,
-	       (clockid_t clock_id, struct __user_old_timespec __user *u_ts))
+	       (clockid_t clock_id, struct __kernel_old_timespec __user *u_ts))
 {
 	struct timespec64 ts;
 	int ret;
@@ -85,7 +85,7 @@ COBALT_SYSCALL(clock_getres, current,
 	if (ret)
 		return ret;
 
-	if (u_ts && cobalt_put_u_timespec(u_ts, &ts))
+	if (u_ts && cobalt_put_old_timespec(u_ts, &ts))
 		return -EFAULT;
 
 	trace_cobalt_clock_getres(clock_id, &ts);
@@ -141,7 +141,7 @@ int __cobalt_clock_gettime(clockid_t clock_id, struct timespec64 *ts)
 }
 
 COBALT_SYSCALL(clock_gettime, current,
-	       (clockid_t clock_id, struct __user_old_timespec __user *u_ts))
+	       (clockid_t clock_id, struct __kernel_old_timespec __user *u_ts))
 {
 	struct timespec64 ts;
 	int ret;
@@ -150,7 +150,7 @@ COBALT_SYSCALL(clock_gettime, current,
 	if (ret)
 		return ret;
 
-	if (cobalt_put_u_timespec(u_ts, &ts))
+	if (cobalt_put_old_timespec(u_ts, &ts))
 		return -EFAULT;
 
 	return 0;
@@ -216,11 +216,11 @@ int __cobalt_clock_adjtime(clockid_t clock_id, struct __kernel_timex *tx)
 }
 
 COBALT_SYSCALL(clock_settime, current,
-	       (clockid_t clock_id, const struct __user_old_timespec __user *u_ts))
+	       (clockid_t clock_id, const struct __kernel_old_timespec __user *u_ts))
 {
 	struct timespec64 ts;
 
-	if (cobalt_get_u_timespec(&ts, u_ts))
+	if (cobalt_get_old_timespec(&ts, u_ts))
 		return -EFAULT;
 
 	return __cobalt_clock_settime(clock_id, &ts);
@@ -238,8 +238,9 @@ COBALT_SYSCALL(clock_settime64, current,
 	return __cobalt_clock_settime(clock_id, &ts64);
 }
 
+/* Only used by 32 bit applications without time64_t support */
 COBALT_SYSCALL(clock_adjtime, current,
-	       (clockid_t clock_id, struct __user_old_timex __user *u_tx))
+	       (clockid_t clock_id, struct old_timex32 __user *u_tx))
 {
 	struct __kernel_timex tx;
 	int ret;
@@ -349,8 +350,8 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 
 COBALT_SYSCALL(clock_nanosleep, primary,
 	       (clockid_t clock_id, int flags,
-		const struct __user_old_timespec __user *u_rqt,
-		struct __user_old_timespec __user *u_rmt))
+		const struct __kernel_old_timespec __user *u_rqt,
+		struct __kernel_old_timespec __user *u_rmt))
 {
 	struct timespec64 rqt, rmt, *rmtp = NULL;
 	int ret;
@@ -358,12 +359,12 @@ COBALT_SYSCALL(clock_nanosleep, primary,
 	if (u_rmt)
 		rmtp = &rmt;
 
-	if (cobalt_get_u_timespec(&rqt, u_rqt))
+	if (cobalt_get_old_timespec(&rqt, u_rqt))
 		return -EFAULT;
 
 	ret = __cobalt_clock_nanosleep(clock_id, flags, &rqt, rmtp);
 	if (ret == -EINTR && flags == 0 && rmtp) {
-		if (cobalt_put_u_timespec(u_rmt, rmtp))
+		if (cobalt_put_old_timespec(u_rmt, rmtp))
 			return -EFAULT;
 	}
 
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 82c26ea08..12e8f702b 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -115,34 +115,34 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     struct timespec64 *rmt);
 
 COBALT_SYSCALL_DECL(clock_getres,
-		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
+		    (clockid_t clock_id, struct __kernel_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_getres64,
 		    (clockid_t clock_id, struct __kernel_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_gettime,
-		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
+		    (clockid_t clock_id, struct __kernel_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_gettime64,
 		    (clockid_t clock_id, struct __kernel_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_settime,
-		    (clockid_t clock_id, const struct __user_old_timespec __user *u_ts));
+		    (clockid_t clock_id, const struct __kernel_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_settime64,
 		    (clockid_t clock_id,
 			 const struct __kernel_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_adjtime,
-		    (clockid_t clock_id, struct __user_old_timex __user *u_tx));
+		    (clockid_t clock_id, struct old_timex32 __user *u_tx));
 
 COBALT_SYSCALL_DECL(clock_adjtime64,
 		    (clockid_t clock_id, struct __kernel_timex __user *u_tx));
 
 COBALT_SYSCALL_DECL(clock_nanosleep,
 		    (clockid_t clock_id, int flags,
-		     const struct __user_old_timespec __user *u_rqt,
-		     struct __user_old_timespec __user *u_rmt));
+		     const struct __kernel_old_timespec __user *u_rqt,
+		     struct __kernel_old_timespec __user *u_rmt));
 
 COBALT_SYSCALL_DECL(clock_nanosleep64,
 		    (clockid_t clock_id, int flags,
diff --git a/kernel/cobalt/posix/cond.c b/kernel/cobalt/posix/cond.c
index 7b87fe908..cd9cf0cb9 100644
--- a/kernel/cobalt/posix/cond.c
+++ b/kernel/cobalt/posix/cond.c
@@ -273,7 +273,7 @@ struct us_cond_data {
 static inline int cond_fetch_timeout(struct timespec64 *ts,
 				     const void __user *u_ts)
 {
-	return u_ts == NULL ? -EFAULT :	cobalt_get_u_timespec(ts, u_ts);
+	return u_ts == NULL ? -EFAULT :	cobalt_get_old_timespec(ts, u_ts);
 }
 
 static inline int cond_fetch_timeout64(struct timespec64 *ts,
@@ -360,7 +360,7 @@ COBALT_SYSCALL(cond_wait_prologue, nonrestartable,
 		struct cobalt_mutex_shadow __user *u_mx,
 		int __user *u_err,
 		unsigned int timed,
-		struct __user_old_timespec __user *u_ts))
+		struct __kernel_old_timespec __user *u_ts))
 {
 	return __cobalt_cond_wait_prologue(u_cnd, u_mx, u_err, u_ts,
 					   timed ? cond_fetch_timeout : NULL);
diff --git a/kernel/cobalt/posix/cond.h b/kernel/cobalt/posix/cond.h
index c2fdd40e0..1eab5d26b 100644
--- a/kernel/cobalt/posix/cond.h
+++ b/kernel/cobalt/posix/cond.h
@@ -58,7 +58,7 @@ COBALT_SYSCALL_DECL(cond_wait_prologue,
 		     struct cobalt_mutex_shadow __user *u_mx,
 		     int __user *u_err,
 		     unsigned int timed,
-		     struct __user_old_timespec __user *u_ts));
+		     struct __kernel_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(cond_wait_prologue64,
 		    (struct cobalt_cond_shadow __user *u_cnd,
diff --git a/kernel/cobalt/posix/event.c b/kernel/cobalt/posix/event.c
index a5fa45db8..4e9895004 100644
--- a/kernel/cobalt/posix/event.c
+++ b/kernel/cobalt/posix/event.c
@@ -194,14 +194,14 @@ COBALT_SYSCALL(event_wait, primary,
 	       (struct cobalt_event_shadow __user *u_event,
 		unsigned int bits,
 		unsigned int __user *u_bits_r,
-		int mode, const struct __user_old_timespec __user *u_ts))
+		int mode, const struct __kernel_old_timespec __user *u_ts))
 {
 	struct timespec64 ts, *tsp = NULL;
 	int ret;
 
 	if (u_ts) {
 		tsp = &ts;
-		ret = cobalt_get_u_timespec(&ts, u_ts);
+		ret = cobalt_get_old_timespec(&ts, u_ts);
 		if (ret)
 			return ret;
 	}
diff --git a/kernel/cobalt/posix/event.h b/kernel/cobalt/posix/event.h
index a67141f2b..d8c83ed75 100644
--- a/kernel/cobalt/posix/event.h
+++ b/kernel/cobalt/posix/event.h
@@ -51,7 +51,7 @@ COBALT_SYSCALL_DECL(event_wait,
 		     unsigned int bits,
 		     unsigned int __user *u_bits_r,
 		     int mode,
-		     const struct __user_old_timespec __user *u_ts));
+		     const struct __kernel_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(event_wait64,
 		    (struct cobalt_event_shadow __user *u_evtsh,
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 9e6f3edfa..e581ec6db 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -98,7 +98,7 @@ COBALT_SYSCALL(recvmsg, handover,
 static int get_timespec(struct timespec64 *ts,
 			const void __user *u_ts)
 {
-	return cobalt_get_u_timespec(ts, u_ts);
+	return cobalt_get_old_timespec(ts, u_ts);
 }
 
 static int get_mmsg(struct mmsghdr *mmsg, void __user *u_mmsg)
@@ -116,7 +116,7 @@ static int put_mmsg(void __user **u_mmsg_p, const struct mmsghdr *mmsg)
 
 COBALT_SYSCALL(recvmmsg, primary,
 	       (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
-		unsigned int flags, struct __user_old_timespec __user *u_timeout))
+		unsigned int flags, struct __kernel_old_timespec __user *u_timeout))
 {
 	return __rtdm_fd_recvmmsg(fd, u_msgvec, vlen, flags, u_timeout,
 				  get_mmsg, put_mmsg, get_timespec);
diff --git a/kernel/cobalt/posix/io.h b/kernel/cobalt/posix/io.h
index ca46aa309..106e2d523 100644
--- a/kernel/cobalt/posix/io.h
+++ b/kernel/cobalt/posix/io.h
@@ -51,7 +51,7 @@ COBALT_SYSCALL_DECL(recvmsg,
 
 COBALT_SYSCALL_DECL(recvmmsg,
 		    (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
-		     unsigned int flags, struct __user_old_timespec __user *u_timeout));
+		     unsigned int flags, struct __kernel_old_timespec __user *u_timeout));
 
 COBALT_SYSCALL_DECL(recvmmsg64,
 		    (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
diff --git a/kernel/cobalt/posix/monitor.c b/kernel/cobalt/posix/monitor.c
index c266b8b3b..fb7fb27e9 100644
--- a/kernel/cobalt/posix/monitor.c
+++ b/kernel/cobalt/posix/monitor.c
@@ -296,7 +296,7 @@ out:
 
 COBALT_SYSCALL(monitor_wait, nonrestartable,
 	       (struct cobalt_monitor_shadow __user *u_mon,
-	       int event, const struct __user_old_timespec __user *u_ts,
+	       int event, const struct __kernel_old_timespec __user *u_ts,
 	       int __user *u_ret))
 {
 	struct timespec64 ts, *tsp = NULL;
@@ -304,7 +304,7 @@ COBALT_SYSCALL(monitor_wait, nonrestartable,
 
 	if (u_ts) {
 		tsp = &ts;
-		ret = cobalt_get_u_timespec(&ts, u_ts);
+		ret = cobalt_get_old_timespec(&ts, u_ts);
 		if (ret)
 			return ret;
 	}
diff --git a/kernel/cobalt/posix/monitor.h b/kernel/cobalt/posix/monitor.h
index 3c76a036b..0cf53c768 100644
--- a/kernel/cobalt/posix/monitor.h
+++ b/kernel/cobalt/posix/monitor.h
@@ -58,7 +58,7 @@ COBALT_SYSCALL_DECL(monitor_exit,
 
 COBALT_SYSCALL_DECL(monitor_wait,
 		    (struct cobalt_monitor_shadow __user *u_monsh,
-		     int event, const struct __user_old_timespec __user *u_ts,
+		     int event, const struct __kernel_old_timespec __user *u_ts,
 		     int __user *u_ret));
 
 COBALT_SYSCALL_DECL(monitor_wait64,
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index 4487e23de..878fb521b 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -921,7 +921,7 @@ COBALT_SYSCALL(mq_getattr, current,
 static inline int mq_fetch_timeout(struct timespec64 *ts,
 				   const void __user *u_ts)
 {
-	return u_ts == NULL ? -EFAULT : cobalt_get_u_timespec(ts, u_ts);
+	return u_ts == NULL ? -EFAULT : cobalt_get_old_timespec(ts, u_ts);
 }
 
 static inline int mq_fetch_timeout64(struct timespec64 *ts,
@@ -976,7 +976,7 @@ out:
 
 COBALT_SYSCALL(mq_timedsend, primary,
 	       (mqd_t uqd, const void __user *u_buf, size_t len,
-		unsigned int prio, const struct __user_old_timespec __user *u_ts))
+		unsigned int prio, const struct __kernel_old_timespec __user *u_ts))
 {
 	return __cobalt_mq_timedsend(uqd, u_buf, len, prio,
 				     u_ts, u_ts ? mq_fetch_timeout : NULL);
@@ -1054,7 +1054,7 @@ COBALT_SYSCALL(mq_timedreceive, primary,
 	       (mqd_t uqd, void __user *u_buf,
 		ssize_t __user *u_len,
 		unsigned int __user *u_prio,
-		const struct __user_old_timespec __user *u_ts))
+		const struct __kernel_old_timespec __user *u_ts))
 {
 	ssize_t len;
 	int ret;
diff --git a/kernel/cobalt/posix/mqueue.h b/kernel/cobalt/posix/mqueue.h
index 755623f47..7cf45c3dc 100644
--- a/kernel/cobalt/posix/mqueue.h
+++ b/kernel/cobalt/posix/mqueue.h
@@ -66,7 +66,7 @@ COBALT_SYSCALL_DECL(mq_getattr, (mqd_t uqd, struct mq_attr __user *u_attr));
 
 COBALT_SYSCALL_DECL(mq_timedsend,
 		    (mqd_t uqd, const void __user *u_buf, size_t len,
-		     unsigned int prio, const struct __user_old_timespec __user *u_ts));
+		     unsigned int prio, const struct __kernel_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(mq_timedsend64,
 		    (mqd_t uqd, const void __user *u_buf, size_t len,
@@ -76,7 +76,7 @@ COBALT_SYSCALL_DECL(mq_timedsend64,
 COBALT_SYSCALL_DECL(mq_timedreceive,
 		    (mqd_t uqd, void __user *u_buf, ssize_t __user *u_len,
 		     unsigned int __user *u_prio,
-		     const struct __user_old_timespec __user *u_ts));
+		     const struct __kernel_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(mq_timedreceive64,
 		    (mqd_t uqd, void __user *u_buf, ssize_t __user *u_len,
diff --git a/kernel/cobalt/posix/mutex.c b/kernel/cobalt/posix/mutex.c
index 2bdb66d17..65882081e 100644
--- a/kernel/cobalt/posix/mutex.c
+++ b/kernel/cobalt/posix/mutex.c
@@ -355,7 +355,7 @@ COBALT_SYSCALL(mutex_lock, primary,
 static inline int mutex_fetch_timeout(struct timespec64 *ts,
 				      const void __user *u_ts)
 {
-	return u_ts == NULL ? -EFAULT : cobalt_get_u_timespec(ts, u_ts);
+	return u_ts == NULL ? -EFAULT : cobalt_get_old_timespec(ts, u_ts);
 }
 
 static inline int mutex_fetch_timeout64(struct timespec64 *ts,
@@ -366,7 +366,7 @@ static inline int mutex_fetch_timeout64(struct timespec64 *ts,
 
 COBALT_SYSCALL(mutex_timedlock, primary,
 	       (struct cobalt_mutex_shadow __user *u_mx,
-		const struct __user_old_timespec __user *u_ts))
+		const struct __kernel_old_timespec __user *u_ts))
 {
 	return __cobalt_mutex_timedlock_break(u_mx, u_ts, mutex_fetch_timeout);
 }
diff --git a/kernel/cobalt/posix/mutex.h b/kernel/cobalt/posix/mutex.h
index 800515a69..4e977fd07 100644
--- a/kernel/cobalt/posix/mutex.h
+++ b/kernel/cobalt/posix/mutex.h
@@ -62,7 +62,7 @@ COBALT_SYSCALL_DECL(mutex_lock,
 
 COBALT_SYSCALL_DECL(mutex_timedlock,
 		    (struct cobalt_mutex_shadow __user *u_mx,
-		     const struct __user_old_timespec __user *u_ts));
+		     const struct __kernel_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(mutex_timedlock64,
 		    (struct cobalt_mutex_shadow __user *u_mx,
diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index aca03a555..e53bcad9b 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -458,13 +458,13 @@ COBALT_SYSCALL(sem_wait, primary,
 
 COBALT_SYSCALL(sem_timedwait, primary,
 	       (struct cobalt_sem_shadow __user *u_sem,
-		const struct __user_old_timespec __user *u_ts))
+		const struct __kernel_old_timespec __user *u_ts))
 {
 	struct timespec64 ts64;
 	int ret = 1;
 
 	if (u_ts)
-		ret = cobalt_get_u_timespec(&ts64, u_ts);
+		ret = cobalt_get_old_timespec(&ts64, u_ts);
 
 	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
 }
diff --git a/kernel/cobalt/posix/sem.h b/kernel/cobalt/posix/sem.h
index e1e4d68f0..ae0d929e0 100644
--- a/kernel/cobalt/posix/sem.h
+++ b/kernel/cobalt/posix/sem.h
@@ -89,7 +89,7 @@ COBALT_SYSCALL_DECL(sem_wait,
 
 COBALT_SYSCALL_DECL(sem_timedwait,
 		    (struct cobalt_sem_shadow __user *u_sem,
-		     const struct __user_old_timespec __user *u_ts));
+		     const struct __kernel_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(sem_timedwait64,
 		    (struct cobalt_sem_shadow __user *u_sem,
diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index ced534079..1842aa5e8 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -426,7 +426,7 @@ int __cobalt_sigtimedwait(sigset_t *set,
 COBALT_SYSCALL(sigtimedwait, nonrestartable,
 	       (const sigset_t __user *u_set,
 		struct siginfo __user *u_si,
-		const struct __user_old_timespec __user *u_timeout))
+		const struct __kernel_old_timespec __user *u_timeout))
 {
 	struct timespec64 timeout;
 	sigset_t set;
diff --git a/kernel/cobalt/posix/signal.h b/kernel/cobalt/posix/signal.h
index 0b5d11e81..227086756 100644
--- a/kernel/cobalt/posix/signal.h
+++ b/kernel/cobalt/posix/signal.h
@@ -94,7 +94,7 @@ COBALT_SYSCALL_DECL(sigwait,
 COBALT_SYSCALL_DECL(sigtimedwait,
 		    (const sigset_t __user *u_set,
 		     struct siginfo __user *u_si,
-		     const struct __user_old_timespec __user *u_timeout));
+		     const struct __kernel_old_timespec __user *u_timeout));
 
 COBALT_SYSCALL_DECL(sigtimedwait64,
 		    (const sigset_t __user *u_set,
diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
index 0f111a42c..3107698ca 100644
--- a/kernel/cobalt/posix/timer.c
+++ b/kernel/cobalt/posix/timer.c
@@ -469,10 +469,11 @@ COBALT_SYSCALL(timer_create, current,
 	return __cobalt_timer_create(clock, evp, u_tm);
 }
 
+/* Only used by 32 bit applications without time64_t support */
 COBALT_SYSCALL(timer_settime, primary,
 	       (timer_t tm, int flags,
-		const struct __user_old_itimerspec __user *u_newval,
-		struct __user_old_itimerspec __user *u_oldval))
+		const struct old_itimerspec32 __user *u_newval,
+		struct old_itimerspec32 __user *u_oldval))
 {
 	struct itimerspec64 newv, oldv, *oldvp = &oldv;
 	int ret;
@@ -480,14 +481,14 @@ COBALT_SYSCALL(timer_settime, primary,
 	if (u_oldval == NULL)
 		oldvp = NULL;
 
-	if (cobalt_get_u_itimerspec(&newv, u_newval))
+	if (cobalt_get_itimerspec32(&newv, u_newval))
 		return -EFAULT;
 
 	ret = __cobalt_timer_settime(tm, flags, &newv, oldvp);
 	if (ret)
 		return ret;
 
-	if (oldvp && cobalt_put_u_itimerspec(u_oldval, oldvp)) {
+	if (oldvp && cobalt_put_itimerspec32(u_oldval, oldvp)) {
 		__cobalt_timer_settime(tm, flags, oldvp, NULL);
 		return -EFAULT;
 	}
@@ -521,8 +522,9 @@ COBALT_SYSCALL(timer_settime64, primary,
 	return 0;
 }
 
+/* Only used by 32 bit applications without time64_t support */
 COBALT_SYSCALL(timer_gettime, current,
-	       (timer_t tm, struct __user_old_itimerspec __user *u_val))
+	       (timer_t tm, struct old_itimerspec32 __user *u_val))
 {
 	struct itimerspec64 val;
 	int ret;
@@ -531,7 +533,7 @@ COBALT_SYSCALL(timer_gettime, current,
 	if (ret)
 		return ret;
 
-	return cobalt_put_u_itimerspec(u_val, &val);
+	return cobalt_put_itimerspec32(u_val, &val);
 }
 
 COBALT_SYSCALL(timer_gettime64, current,
diff --git a/kernel/cobalt/posix/timer.h b/kernel/cobalt/posix/timer.h
index 864c780e8..96df80334 100644
--- a/kernel/cobalt/posix/timer.h
+++ b/kernel/cobalt/posix/timer.h
@@ -75,8 +75,8 @@ COBALT_SYSCALL_DECL(timer_delete, (timer_t tm));
 
 COBALT_SYSCALL_DECL(timer_settime,
 		    (timer_t tm, int flags,
-		     const struct __user_old_itimerspec __user *u_newval,
-		     struct __user_old_itimerspec __user *u_oldval));
+		     const struct old_itimerspec32 __user *u_newval,
+		     struct old_itimerspec32 __user *u_oldval));
 
 COBALT_SYSCALL_DECL(timer_settime64,
 		    (timer_t tm, int flags,
@@ -84,7 +84,7 @@ COBALT_SYSCALL_DECL(timer_settime64,
 		     struct __kernel_itimerspec __user *u_oldval));
 
 COBALT_SYSCALL_DECL(timer_gettime,
-		    (timer_t tm, struct __user_old_itimerspec __user *u_val));
+		    (timer_t tm, struct old_itimerspec32 __user *u_val));
 
 COBALT_SYSCALL_DECL(timer_gettime64,
 		    (timer_t tm, struct __kernel_itimerspec __user *u_val));
diff --git a/kernel/cobalt/posix/timerfd.c b/kernel/cobalt/posix/timerfd.c
index ae7578d29..4839a0861 100644
--- a/kernel/cobalt/posix/timerfd.c
+++ b/kernel/cobalt/posix/timerfd.c
@@ -279,15 +279,16 @@ out:
 	return ret;
 }
 
+/* Only used by 32 bit applications without time64_t support */
 COBALT_SYSCALL(timerfd_settime, primary,
 	       (int fd, int flags,
-		const struct __user_old_itimerspec __user *new_value,
-		struct __user_old_itimerspec __user *old_value))
+		const struct old_itimerspec32 __user *new_value,
+		struct old_itimerspec32 __user *old_value))
 {
 	struct itimerspec64 ovalue, value;
 	int ret;
 
-	ret = cobalt_get_u_itimerspec(&value, new_value);
+	ret = cobalt_get_itimerspec32(&value, new_value);
 	if (ret)
 		return ret;
 
@@ -296,7 +297,7 @@ COBALT_SYSCALL(timerfd_settime, primary,
 		return ret;
 
 	if (old_value) {
-		ret = cobalt_put_u_itimerspec(old_value, &ovalue);
+		ret = cobalt_put_itimerspec32(old_value, &ovalue);
 		value.it_value.tv_sec = 0;
 		value.it_value.tv_nsec = 0;
 		__cobalt_timerfd_settime(fd, flags, &value, NULL);
@@ -349,15 +350,16 @@ int __cobalt_timerfd_gettime(int fd, struct itimerspec64 *value)
 	return 0;
 }
 
+/* Only used by 32 bit applications without time64_t support */
 COBALT_SYSCALL(timerfd_gettime, current,
-	       (int fd, struct __user_old_itimerspec __user *curr_value))
+	       (int fd, struct old_itimerspec32 __user *curr_value))
 {
 	struct itimerspec64 value;
 	int ret;
 
 	ret = __cobalt_timerfd_gettime(fd, &value);
 
-	return ret ?: cobalt_put_u_itimerspec(curr_value, &value);
+	return ret ?: cobalt_put_itimerspec32(curr_value, &value);
 }
 
 COBALT_SYSCALL(timerfd_gettime64, current,
diff --git a/kernel/cobalt/posix/timerfd.h b/kernel/cobalt/posix/timerfd.h
index b82dac748..004985f46 100644
--- a/kernel/cobalt/posix/timerfd.h
+++ b/kernel/cobalt/posix/timerfd.h
@@ -33,8 +33,8 @@ COBALT_SYSCALL_DECL(timerfd_create,
 
 COBALT_SYSCALL_DECL(timerfd_settime,
 		    (int fd, int flags,
-		     const struct __user_old_itimerspec __user *new_value,
-		     struct __user_old_itimerspec __user *old_value));
+		     const struct old_itimerspec32 __user *new_value,
+		     struct old_itimerspec32 __user *old_value));
 
 COBALT_SYSCALL_DECL(timerfd_settime64,
 		    (int fd, int flags,
@@ -42,7 +42,7 @@ COBALT_SYSCALL_DECL(timerfd_settime64,
 		     struct __kernel_itimerspec __user *old_value));
 
 COBALT_SYSCALL_DECL(timerfd_gettime,
-		    (int fd, struct __user_old_itimerspec __user *curr_value));
+		    (int fd, struct old_itimerspec32 __user *curr_value));
 
 COBALT_SYSCALL_DECL(timerfd_gettime64,
 		    (int fd, struct __kernel_itimerspec __user *curr_value));
diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 490426499..dbfcd4d76 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -309,7 +309,7 @@ COBALT_IMPL(int, clock_adjtime, (clockid_t clock_id, struct timex *tx))
 {
 	int ret;
 
-#ifdef __USE_TIME_BITS64
+#ifdef XN_USE_TIME64_SYSCALL
 	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_adjtime64, clock_id, tx);
 #else
 	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_adjtime, clock_id, tx);
diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
index acb3989f1..00f51fa23 100644
--- a/lib/cobalt/internal.h
+++ b/lib/cobalt/internal.h
@@ -25,6 +25,11 @@
 #include <cobalt/sys/cobalt.h>
 #include "current.h"
 
+#if defined(__USE_TIME_BITS64) || __WORDSIZE == 64 ||                          \
+	(defined(__SYSCALL_WORDSIZE) && __SYSCALL_WORDSIZE == 64)
+#define XN_USE_TIME64_SYSCALL
+#endif
+
 extern void *cobalt_umm_private;
 
 extern void *cobalt_umm_shared;
diff --git a/lib/cobalt/timer.c b/lib/cobalt/timer.c
index d8955832e..d86d01417 100644
--- a/lib/cobalt/timer.c
+++ b/lib/cobalt/timer.c
@@ -166,7 +166,7 @@ COBALT_IMPL(int, timer_settime, (timer_t timerid,
 {
 	int ret;
 
-#ifdef __USE_TIME_BITS64
+#ifdef XN_USE_TIME64_SYSCALL
 	long sc_nr = sc_cobalt_timer_settime64;
 #else
 	long sc_nr = sc_cobalt_timer_settime;
@@ -214,7 +214,7 @@ COBALT_IMPL(int, timer_gettime, (timer_t timerid, struct itimerspec *value))
 {
 	int ret;
 
-#ifdef __USE_TIME_BITS64
+#ifdef XN_USE_TIME64_SYSCALL
 	long sc_nr = sc_cobalt_timer_gettime64;
 #else
 	long sc_nr = sc_cobalt_timer_gettime;
diff --git a/lib/cobalt/timerfd.c b/lib/cobalt/timerfd.c
index c0e64929a..5e7db928f 100644
--- a/lib/cobalt/timerfd.c
+++ b/lib/cobalt/timerfd.c
@@ -41,7 +41,7 @@ COBALT_IMPL(int, timerfd_settime,
 {
 	int ret;
 
-#ifdef __USE_TIME_BITS64
+#ifdef XN_USE_TIME64_SYSCALL
 	long sc_nr = sc_cobalt_timerfd_settime64;
 #else
 	long sc_nr = sc_cobalt_timerfd_settime;
@@ -59,7 +59,7 @@ COBALT_IMPL(int, timerfd_gettime, (int fd, struct itimerspec *curr_value))
 {
 	int ret;
 
-#ifdef __USE_TIME_BITS64
+#ifdef XN_USE_TIME64_SYSCALL
 	long sc_nr = sc_cobalt_timerfd_gettime64;
 #else
 	long sc_nr = sc_cobalt_timerfd_gettime;

-- 
2.39.2

