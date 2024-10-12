Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C270154434
	for <xenomai@lists.linux.dev>; Sat, 12 Oct 2024 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728817; cv=none; b=U6dHXHNn4DjiAOAiIrktTy/oBn3H7vu5NPeKEHnta7R5NZ+AMnmzpgejOoCvY8+Z0REAKIOAxjvIrqXwhPPBRXLIKtw4LMQYp7G8IlwdVWFVBxRdqj9ApuAua+gzhtyUkTF+oFM7VxFl+eLLyNKlMFA5YSxdEFqg6TjnbYhLUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728817; c=relaxed/simple;
	bh=lRpN8WUBwd1YX1Ro3cdooh4wKiVIuPpjDSHSOzvjO+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3QjK6jqtPHEj3loLY4yCDUiN0beM4ztKGx7WJvYdN4uCvKITZH6ZdLtBj564AeJLQhOhV/eiDNofjViUcGwe8aQfpvr7ie4rLaTGXq2d9Yz+9c/jIm1i6ATs2tSBnk8L+lQPG4pCEDghROXZC6Kt9X59Qk3LvXYvZ9MKQFFnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=AfXly7Vw; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="AfXly7Vw"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20241012102645bb166f9a1fcd5c9f0d
        for <xenomai@lists.linux.dev>;
        Sat, 12 Oct 2024 12:26:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gAQAlGJn8Q6q4OayZ3ywo+bHvayijxD6fOr+A5AbYbs=;
 b=AfXly7VwUr8LRLm9lgAkIFMX5JRiosn5oriQRqhqvW84TgFr/KG4qZsGSg5xXswDLcNOwX
 A2qQ52zZ7pFJviCc1FxkCZnY+Dlbra3aNj6z+gm2FC1BDePIiNcCrDOQTebnTDCj2cstbq8s
 z7hdOIIXx1b9cyClnLq1IVM9ud9SqGwyNffuqgkpjjrg2Az8TFIffJsPUW+SHgH/ciKXhy1Q
 EhmAWQefpyXdL1clvOSR/iTe8ZR/QDYORR8gy6iCbPw7BRajUmIBEZRz6nRyaXotgMTdyFx1
 oThFDscx9mNGF2rYF+OGlJcDpq+kSEc6xZ7vS2CaUBA5ayRsTUZMKd9A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Sat, 12 Oct 2024 12:26:45 +0200
Subject: [PATCH 6/7] cobalt: sycall API: Reformat all XENOMAI_SYSCALLx call
 sites
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-flo-cleanup-before-release-v1-6-df05bfa0ac80@siemens.com>
References: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
In-Reply-To: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Clara Kowalsky <clara.kowalsky@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Reformatting to clang-format rules only. No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/clock.c                     |  8 ++++----
 lib/cobalt/cond.c                      |  8 ++++----
 lib/cobalt/internal.c                  | 18 +++++++++---------
 lib/cobalt/rtdm.c                      | 17 +++++++++--------
 lib/cobalt/sched.c                     | 21 ++++++++++-----------
 lib/cobalt/select.c                    |  4 ++--
 lib/cobalt/semaphore.c                 | 11 +++++------
 lib/cobalt/thread.c                    | 21 ++++++++++-----------
 lib/cobalt/timer.c                     |  2 +-
 lib/cobalt/trace.c                     |  4 ++--
 testsuite/smokey/y2038/syscall-tests.c |  4 ++--
 11 files changed, 58 insertions(+), 60 deletions(-)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 297249d22..ca30cde56 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -288,11 +288,11 @@ COBALT_IMPL_TIME64(int, clock_nanosleep, __clock_nanosleep_time64,
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
 #ifdef __USE_TIME_BITS64
-	ret = -XENOMAI_SYSCALL4(sc_cobalt_clock_nanosleep64,
-				clock_id, flags, rqtp, rmtp);
+	ret = -XENOMAI_SYSCALL4(sc_cobalt_clock_nanosleep64, clock_id, flags,
+				rqtp, rmtp);
 #else
-	ret = -XENOMAI_SYSCALL4(sc_cobalt_clock_nanosleep,
-				clock_id, flags, rqtp, rmtp);
+	ret = -XENOMAI_SYSCALL4(sc_cobalt_clock_nanosleep, clock_id, flags,
+				rqtp, rmtp);
 #endif
 
 	pthread_setcanceltype(oldtype, NULL);
diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index a48395e71..265ac7fbc 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -138,7 +138,7 @@ COBALT_IMPL(int, pthread_cond_init, (pthread_cond_t *cond,
 		return err;
 	kcattr.clock = tmp;
 
-	err = -XENOMAI_SYSCALL2( sc_cobalt_cond_init, _cnd, &kcattr);
+	err = -XENOMAI_SYSCALL2(sc_cobalt_cond_init, _cnd, &kcattr);
 	if (err)
 		return err;
 
@@ -206,7 +206,7 @@ COBALT_IMPL(int, pthread_cond_destroy, (pthread_cond_t *cond))
 	if (_cond->magic != COBALT_COND_MAGIC)
 		return (cobalt_cond_autoinit_type(cond) < 0) ? EINVAL : 0;
 
-	return -XENOMAI_SYSCALL1( sc_cobalt_cond_destroy, _cond);
+	return -XENOMAI_SYSCALL1(sc_cobalt_cond_destroy, _cond);
 }
 
 struct cobalt_cond_cleanup_t {
@@ -222,8 +222,8 @@ static void __pthread_cond_cleanup(void *data)
 	int err;
 
 	do {
-		err = XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue,
-				       c->cond, c->mutex);
+		err = XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue, c->cond,
+				       c->mutex);
 	} while (err == -EINTR);
 
 	c->mutex->lockcnt = c->count;
diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index 5858c2bf6..f6519d966 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -482,11 +482,11 @@ int cobalt_event_wait(cobalt_event_t *event,
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
 #ifdef __USE_TIME_BITS64
-	ret = XENOMAI_SYSCALL5(sc_cobalt_event_wait64,
-			       event, bits, bits_r, mode, timeout);
+	ret = XENOMAI_SYSCALL5(sc_cobalt_event_wait64, event, bits, bits_r,
+			       mode, timeout);
 #else
-	ret = XENOMAI_SYSCALL5(sc_cobalt_event_wait,
-			       event, bits, bits_r, mode, timeout);
+	ret = XENOMAI_SYSCALL5(sc_cobalt_event_wait, event, bits, bits_r, mode,
+			       timeout);
 #endif
 
 	pthread_setcanceltype(oldtype, NULL);
@@ -506,17 +506,17 @@ int cobalt_event_inquire(cobalt_event_t *event,
 			 struct cobalt_event_info *info,
 			 pid_t *waitlist, size_t waitsz)
 {
-	return XENOMAI_SYSCALL4(sc_cobalt_event_inquire, event,
-				info, waitlist, waitsz);
+	return XENOMAI_SYSCALL4(sc_cobalt_event_inquire, event, info, waitlist,
+				waitsz);
 }
 
 int cobalt_sem_inquire(sem_t *sem, struct cobalt_sem_info *info,
 		       pid_t *waitlist, size_t waitsz)
 {
 	struct cobalt_sem_shadow *_sem = &((union cobalt_sem_union *)sem)->shadow_sem;
-	
-	return XENOMAI_SYSCALL4(sc_cobalt_sem_inquire, _sem,
-				info, waitlist, waitsz);
+
+	return XENOMAI_SYSCALL4(sc_cobalt_sem_inquire, _sem, info, waitlist,
+				waitsz);
 }
 
 int cobalt_sched_weighted_prio(int policy,
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index ba0c84823..06c915895 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -53,7 +53,7 @@ static int do_open(const char *path, int oflag, mode_t mode)
 	 * the kernel service.
 	 */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-	fd = XENOMAI_SYSCALL2( sc_cobalt_open, path, oflag);
+	fd = XENOMAI_SYSCALL2(sc_cobalt_open, path, oflag);
 	pthread_setcanceltype(oldtype, NULL);
 	if (fd < 0) {
 		if (fd != -EADV && fd != -ENOSYS)
@@ -128,8 +128,8 @@ COBALT_IMPL(int, socket, (int protocol_family, int socket_type, int protocol))
 {
 	int s;
 
-	s = XENOMAI_SYSCALL3(sc_cobalt_socket, protocol_family,
-			     socket_type, protocol);
+	s = XENOMAI_SYSCALL3(sc_cobalt_socket, protocol_family, socket_type,
+			     protocol);
 	if (s < 0) {
 		if (s != -EAFNOSUPPORT &&
 		    s != -EPROTONOSUPPORT &&
@@ -165,7 +165,7 @@ static int do_ioctl(int fd, unsigned int request, void *arg)
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	ret = XENOMAI_SYSCALL3(sc_cobalt_ioctl,	fd, request, arg);
+	ret = XENOMAI_SYSCALL3(sc_cobalt_ioctl, fd, request, arg);
 
 	pthread_setcanceltype(oldtype, NULL);
 
@@ -230,7 +230,7 @@ COBALT_IMPL(ssize_t, write, (int fd, const void *buf, size_t nbyte))
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	ret = XENOMAI_SYSCALL3(sc_cobalt_write,	fd, buf, nbyte);
+	ret = XENOMAI_SYSCALL3(sc_cobalt_write, fd, buf, nbyte);
 
 	pthread_setcanceltype(oldtype, NULL);
 
@@ -273,10 +273,11 @@ COBALT_IMPL_TIME64(int, recvmmsg, __recvmmsg64,
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
 #ifdef __USE_TIME_BITS64
-	ret = XENOMAI_SYSCALL5(sc_cobalt_recvmmsg64, fd, msgvec,
-				vlen, flags, timeout);
+	ret = XENOMAI_SYSCALL5(sc_cobalt_recvmmsg64, fd, msgvec, vlen, flags,
+			       timeout);
 #else
-	ret = XENOMAI_SYSCALL5(sc_cobalt_recvmmsg, fd, msgvec, vlen, flags, timeout);
+	ret = XENOMAI_SYSCALL5(sc_cobalt_recvmmsg, fd, msgvec, vlen, flags,
+			       timeout);
 #endif
 
 	pthread_setcanceltype(oldtype, NULL);
diff --git a/lib/cobalt/sched.c b/lib/cobalt/sched.c
index 42662d382..f8f080a5f 100644
--- a/lib/cobalt/sched.c
+++ b/lib/cobalt/sched.c
@@ -300,9 +300,8 @@ int sched_setscheduler_ex(pid_t pid,
 			return errno;
 	}
 
-	ret = -XENOMAI_SYSCALL5(sc_cobalt_sched_setscheduler_ex,
-				pid, policy, param_ex,
-				&u_winoff, &promoted);
+	ret = -XENOMAI_SYSCALL5(sc_cobalt_sched_setscheduler_ex, pid, policy,
+				param_ex, &u_winoff, &promoted);
 
 	/*
 	 * If the kernel has no reference to the target thread, let glibc
@@ -356,8 +355,8 @@ COBALT_IMPL(int, sched_getscheduler, (pid_t pid))
 		return -1;
 	}
 
-	ret = XENOMAI_SYSCALL3(sc_cobalt_sched_getscheduler_ex,
-			       pid, &policy, &param_ex);
+	ret = XENOMAI_SYSCALL3(sc_cobalt_sched_getscheduler_ex, pid, &policy,
+			       &param_ex);
 	if (ret == -ESRCH)
 		return __STD(sched_getscheduler(pid));
 
@@ -402,8 +401,8 @@ int sched_getscheduler_ex(pid_t pid, int *policy_r,
 	if (pid < 0 || param_ex == NULL)
 		return EINVAL;
 
-	return -XENOMAI_SYSCALL3(sc_cobalt_sched_getscheduler_ex,
-				 pid, policy_r, param_ex);
+	return -XENOMAI_SYSCALL3(sc_cobalt_sched_getscheduler_ex, pid, policy_r,
+				 param_ex);
 }
 
 /**
@@ -558,8 +557,8 @@ int sched_get_priority_max_ex(int policy)
 int sched_setconfig_np(int cpu, int policy,
 		       const union sched_config *config, size_t len)
 {
-	return -XENOMAI_SYSCALL4(sc_cobalt_sched_setconfig_np,
-				 cpu, policy, config, len);
+	return -XENOMAI_SYSCALL4(sc_cobalt_sched_setconfig_np, cpu, policy,
+				 config, len);
 }
 
 /**
@@ -617,8 +616,8 @@ ssize_t sched_getconfig_np(int cpu, int policy,
 {
 	ssize_t ret;
 
-	ret = XENOMAI_SYSCALL4(sc_cobalt_sched_getconfig_np,
-			       cpu, policy, config, *len_r);
+	ret = XENOMAI_SYSCALL4(sc_cobalt_sched_getconfig_np, cpu, policy,
+			       config, *len_r);
 	if (ret < 0)
 		return -ret;
 
diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
index 997977d27..7a4aa52a2 100644
--- a/lib/cobalt/select.c
+++ b/lib/cobalt/select.c
@@ -71,8 +71,8 @@ static inline int do_select(int __nfds, fd_set *__restrict __readfds,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	err = XENOMAI_SYSCALL5(sc_cobalt_select, __nfds,
-			       __readfds, __writefds, __exceptfds, __timeout);
+	err = XENOMAI_SYSCALL(sc_cobalt_select, __nfds, __readfds, __writefds,
+			      __exceptfds, __timeout);
 
 	pthread_setcanceltype(oldtype, NULL);
 
diff --git a/lib/cobalt/semaphore.c b/lib/cobalt/semaphore.c
index e148f5579..c76967019 100644
--- a/lib/cobalt/semaphore.c
+++ b/lib/cobalt/semaphore.c
@@ -89,8 +89,8 @@ COBALT_IMPL(int, sem_init, (sem_t *sem, int pshared, unsigned int value))
 	struct cobalt_sem_shadow *_sem = &((union cobalt_sem_union *)sem)->shadow_sem;
 	int ret;
 
-	ret = XENOMAI_SYSCALL3(sc_cobalt_sem_init,
-			       _sem, pshared ? SEM_PSHARED : 0, value);
+	ret = XENOMAI_SYSCALL3(sc_cobalt_sem_init, _sem,
+			       pshared ? SEM_PSHARED : 0, value);
 	if (ret) {
 		errno = -ret;
 		return -1;
@@ -375,8 +375,7 @@ COBALT_IMPL_TIME64(int, sem_timedwait, __sem_timedwait64,
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
 #ifdef __USE_TIME_BITS64
-	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait64, _sem,
-			       abs_timeout);
+	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait64, _sem, abs_timeout);
 #else
 	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait, _sem, abs_timeout);
 #endif
@@ -509,8 +508,8 @@ COBALT_IMPL(sem_t *, sem_open, (const char *name, int oflags, ...))
 		goto error;
 	}
 
-	err = XENOMAI_SYSCALL5(sc_cobalt_sem_open,
-			       &rsem, name, oflags, mode, value);
+	err = XENOMAI_SYSCALL5(sc_cobalt_sem_open, &rsem, name, oflags, mode,
+			       value);
 	if (err == 0) {
 		if (rsem != sem)
 			free(sem);
diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
index 41227ba33..9a168bcb7 100644
--- a/lib/cobalt/thread.c
+++ b/lib/cobalt/thread.c
@@ -92,8 +92,8 @@ static void *cobalt_thread_trampoline(void *p)
 	 * Do _not_ inline the call to pthread_self() in the syscall
 	 * macro: this trashes the syscall regs on some archs.
 	 */
-	ret = -XENOMAI_SYSCALL5(sc_cobalt_thread_create, ptid,
-				policy, &param_ex, personality, &u_winoff);
+	ret = -XENOMAI_SYSCALL5(sc_cobalt_thread_create, ptid, policy,
+				&param_ex, personality, &u_winoff);
 	if (ret == 0)
 		cobalt_set_tsd(u_winoff);
 
@@ -379,8 +379,8 @@ COBALT_IMPL(int, pthread_create, (pthread_t *ptid_r,
  */
 int pthread_setmode_np(int clrmask, int setmask, int *mode_r)
 {
-	return -XENOMAI_SYSCALL3(sc_cobalt_thread_setmode,
-				 clrmask, setmask, mode_r);
+	return -XENOMAI_SYSCALL3(sc_cobalt_thread_setmode, clrmask, setmask,
+				 mode_r);
 }
 
 /**
@@ -639,9 +639,8 @@ int pthread_setschedparam_ex(pthread_t thread,
 	/* only request promotion when this targets the current thread */
 	u_winoff_ptr = thread == pthread_self() ? &u_winoff : NULL;
 
-	ret = -XENOMAI_SYSCALL5(sc_cobalt_thread_setschedparam_ex,
-				thread, policy, param_ex,
-				u_winoff_ptr, &promoted);
+	ret = -XENOMAI_SYSCALL5(sc_cobalt_thread_setschedparam_ex, thread,
+				policy, param_ex, u_winoff_ptr, &promoted);
 
 	/*
 	 * If the kernel has no reference to the target thread. let glibc
@@ -678,8 +677,8 @@ COBALT_IMPL(int, pthread_setschedprio, (pthread_t thread, int prio))
 	/* only request promotion when this targets the current thread */
 	u_winoff_ptr = thread == pthread_self() ? &u_winoff : NULL;
 
-	ret = -XENOMAI_SYSCALL4(sc_cobalt_thread_setschedprio,
-				thread, prio, u_winoff_ptr, &promoted);
+	ret = -XENOMAI_SYSCALL4(sc_cobalt_thread_setschedprio, thread, prio,
+				u_winoff_ptr, &promoted);
 
 	/*
 	 * If the kernel has no reference to the target thread. let glibc
@@ -773,8 +772,8 @@ int pthread_getschedparam_ex(pthread_t thread,
 	struct sched_param short_param;
 	int ret;
 
-	ret = -XENOMAI_SYSCALL3(sc_cobalt_thread_getschedparam_ex,
-				thread, policy_r, param_ex);
+	ret = -XENOMAI_SYSCALL3(sc_cobalt_thread_getschedparam_ex, thread,
+				policy_r, param_ex);
 	if (ret == ESRCH) {
 		ret = __STD(pthread_getschedparam(thread, policy_r, &short_param));
 		if (ret == 0)
diff --git a/lib/cobalt/timer.c b/lib/cobalt/timer.c
index a7e315264..b90a1f148 100644
--- a/lib/cobalt/timer.c
+++ b/lib/cobalt/timer.c
@@ -77,7 +77,7 @@ COBALT_IMPL(int, timer_create, (clockid_t clockid,
 {
 	int ret;
 
-	ret = -XENOMAI_SYSCALL3(sc_cobalt_timer_create,	clockid, evp, timerid);
+	ret = -XENOMAI_SYSCALL3(sc_cobalt_timer_create, clockid, evp, timerid);
 	if (ret == 0)
 		return 0;
 
diff --git a/lib/cobalt/trace.c b/lib/cobalt/trace.c
index ae3933f75..70a4af665 100644
--- a/lib/cobalt/trace.c
+++ b/lib/cobalt/trace.c
@@ -49,8 +49,8 @@ int xntrace_user_stop(unsigned long v)
 
 int xntrace_user_freeze(unsigned long v, int once)
 {
-	return XENOMAI_SYSCALL3(sc_cobalt_trace, __xntrace_op_user_freeze,
-				v, once);
+	return XENOMAI_SYSCALL3(sc_cobalt_trace, __xntrace_op_user_freeze, v,
+				once);
 }
 
 void xntrace_latpeak_freeze(int delay)
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 506e9b52f..592723816 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -322,8 +322,8 @@ static int test_sc_cobalt_clock_nanosleep64(void)
 	next.tv_sec  = ts1.tv_sec + interval;
 	next.tv_nsec = ts1.tv_nsec;
 
-	ret = XENOMAI_SYSCALL4(sc_nr, CLOCK_MONOTONIC, TIMER_ABSTIME,
-			       &next, (void *)0xdeadbeefUL);
+	ret = XENOMAI_SYSCALL4(sc_nr, CLOCK_MONOTONIC, TIMER_ABSTIME, &next,
+			       (void *)0xdeadbeefUL);
 	if (!smokey_assert(!ret))
 		return ret;
 

-- 
2.39.5

