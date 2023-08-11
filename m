Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AD053A6
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 07:37:59 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023081107375248be241cefcf559b21
        for <xenomai@lists.linux.dev>;
        Fri, 11 Aug 2023 09:37:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kiKvoEC1sq1Zc3iprWWXRICoZ85PeWljxc/C6TMBuLc=;
 b=kuOsXiX4/dYFTfeXpZVkz0L5Gt63rsRUG1V0fl/sF728E6noUoxUxp5gmUM3sBY2gU2b/D
 OIRhJxiBkLgWIRUE6Z9LzdhqtcNJX1Qx4tuej+1cFLT8ll9n3vpHhyPX3uP7QhLLo7kMuWZQ
 B0I8poUZt+E/R81FxfJoGKDAyU8rw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Aug 2023 09:37:41 +0200
Subject: [PATCH 6/7] y2038: Route explicitly requested stdlib calls to
 time64 equivalents
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-florian-y2038-2-v1-6-d1cfe2f394a3@siemens.com>
References: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Xenomai provides the __STD() macro to request a service from Linux.
The code normally looks like below, taking clock_gettime() as example.

Note: Some y2038 safe services in glibc have the "_time64" suffix, while
others only have the 64 at the end. This is taken into account while
redirecting.

  int ret = __STD(clock_gettime(...));

For compat applications with available y2038 support in glibc the
preprocessor will generate the following code:

  int ret = __real_clock_gettime(...);

__real_clock_gettime() is the service taking 32 bit time_t. We have to
make sure that __real_clock_gettime() is redirected to
__real___clock_gettime64() service. The same applies to all other
affected services.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/mqueue.h                | 11 ++++++++
 include/cobalt/pthread.h               | 10 ++++++++
 include/cobalt/semaphore.h             |  4 +++
 include/cobalt/signal.h                |  5 ++++
 include/cobalt/sys/ioctl.h             |  3 +++
 include/cobalt/sys/select.h            |  8 ++++++
 include/cobalt/sys/socket.h            | 15 +++++++++++
 include/cobalt/sys/time.h              |  4 +++
 include/cobalt/sys/timerfd.h           |  9 +++++++
 include/cobalt/time.h                  | 35 ++++++++++++++++++++++++++
 include/cobalt/wrappers.h              | 10 ++++++++
 testsuite/smokey/y2038/syscall-tests.c | 46 ++++++++++++++++++++++++++++++++++
 12 files changed, 160 insertions(+)

diff --git a/include/cobalt/mqueue.h b/include/cobalt/mqueue.h
index 496632dea..3da525a04 100644
--- a/include/cobalt/mqueue.h
+++ b/include/cobalt/mqueue.h
@@ -67,6 +67,17 @@ COBALT_DECL(ssize_t, mq_timedreceive(mqd_t q,
 COBALT_DECL(int, mq_notify(mqd_t q,
 			   const struct sigevent *evp));
 
+COBALT_DECL_TIME64(int, mq_timedsend,
+		   (mqd_t q, const char *buffer, size_t len, unsigned int prio,
+		    const struct timespec *timeout),
+		   __mq_timedsend64);
+
+COBALT_DECL_TIME64(int, mq_timedreceive,
+		   (mqd_t q, char *__restrict__ buffer, size_t len,
+		    unsigned *__restrict__ prio,
+		    const struct timespec *__restrict__ timeout),
+		   __mq_timedsend_time64);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
index 3e9bd4705..1caa54372 100644
--- a/include/cobalt/pthread.h
+++ b/include/cobalt/pthread.h
@@ -173,6 +173,16 @@ int pthread_attr_getpersonality_ex(const pthread_attr_ex_t *attr_ex,
 
 int pthread_attr_setpersonality_ex(pthread_attr_ex_t *attr_ex,
 				   int personality);
+
+COBALT_DECL_TIME64(int, pthread_mutex_timedlock,
+		   (pthread_mutex_t *mutex, const struct timespec *to),
+		   __pthread_mutex_timedlock64);
+
+COBALT_DECL_TIME64(int, pthread_cond_timedwait,
+		   (pthread_cond_t *cond, pthread_mutex_t *mutex,
+		    const struct timespec *abstime),
+		   __pthread_cond_timedwait64);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/cobalt/semaphore.h b/include/cobalt/semaphore.h
index a7714fd34..20195094c 100644
--- a/include/cobalt/semaphore.h
+++ b/include/cobalt/semaphore.h
@@ -58,6 +58,10 @@ int sem_init_np(sem_t *sem,
 
 int sem_broadcast_np(sem_t *sem);
 
+COBALT_DECL_TIME64(int, sem_timedwait,
+		   (sem_t *sem, const struct timespec *abs_timeout),
+		   __sem_timedwait64);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/cobalt/signal.h b/include/cobalt/signal.h
index 62694f93a..9082765d0 100644
--- a/include/cobalt/signal.h
+++ b/include/cobalt/signal.h
@@ -54,6 +54,11 @@ COBALT_DECL(int, kill(pid_t pid, int sig));
 COBALT_DECL(int, sigqueue(pid_t pid, int sig,
 			  const union sigval value));
 
+COBALT_DECL_TIME64(int, sigtimedwait,
+		   (const sigset_t *set, siginfo_t *si,
+		    const struct timespec *timeout),
+		   __sigtimedwait64);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/cobalt/sys/ioctl.h b/include/cobalt/sys/ioctl.h
index 553aa566d..d7602ddf8 100644
--- a/include/cobalt/sys/ioctl.h
+++ b/include/cobalt/sys/ioctl.h
@@ -29,6 +29,9 @@ extern "C" {
 
 COBALT_DECL(int, ioctl(int fildes, unsigned int request, ...));
 
+COBALT_DECL_TIME64(int, ioctl, (int fd, unsigned int request, ...),
+		   __ioctl_time64);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/cobalt/sys/select.h b/include/cobalt/sys/select.h
index 76e8476bb..8262e7764 100644
--- a/include/cobalt/sys/select.h
+++ b/include/cobalt/sys/select.h
@@ -31,6 +31,14 @@ COBALT_DECL(int, select(int __nfds, fd_set *__restrict __readfds,
 			fd_set *__restrict __writefds,
 			fd_set *__restrict __exceptfds,
 			struct timeval *__restrict __timeout));
+
+COBALT_DECL_TIME64(int, select,
+		   (int __nfds, fd_set *__restrict __readfds,
+		    fd_set *__restrict __writefds,
+		    fd_set *__restrict __exceptfds,
+		    struct timeval *__restrict __timeout),
+		   __select64);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/cobalt/sys/socket.h b/include/cobalt/sys/socket.h
index 156b49356..d16843877 100644
--- a/include/cobalt/sys/socket.h
+++ b/include/cobalt/sys/socket.h
@@ -81,6 +81,21 @@ COBALT_DECL(int, getpeername(int fd, struct sockaddr *name,
 
 COBALT_DECL(int, shutdown(int fd, int how));
 
+COBALT_DECL_TIME64(int, recvmmsg,
+		   (int fd, struct mmsghdr *msgvec, unsigned int vlen,
+		    unsigned int flags, struct timespec *timeout),
+		   __recvmmsg64);
+
+COBALT_DECL_TIME64(int, getsockopt,
+		   (int fd, int level, int optname, void *optval,
+		    socklen_t *optlen),
+		   __getsockopt64);
+
+COBALT_DECL_TIME64(int, setsockopt,
+		   (int fd, int level, int optname, const void *optval,
+		    socklen_t optlen),
+		   __setsockopt64);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/cobalt/sys/time.h b/include/cobalt/sys/time.h
index 38f5a34b6..d3bd9f1f5 100644
--- a/include/cobalt/sys/time.h
+++ b/include/cobalt/sys/time.h
@@ -32,6 +32,10 @@ extern "C" {
 COBALT_DECL(int, gettimeofday(struct timeval *tv,
 			      struct timezone *tz));
 
+COBALT_DECL_TIME64(int, gettimeofday,
+		   (struct timeval *tv, struct timezone *tz),
+		   __gettimeofday64);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/cobalt/sys/timerfd.h b/include/cobalt/sys/timerfd.h
index a7df836e6..109409cf7 100644
--- a/include/cobalt/sys/timerfd.h
+++ b/include/cobalt/sys/timerfd.h
@@ -35,6 +35,15 @@ COBALT_DECL(int, timerfd_settime(int fd, int flags,
 
 COBALT_DECL(int, timerfd_gettime(int fd, struct itimerspec *curr_value));
 
+COBALT_DECL_TIME64(int, timerfd_settime,
+		   (int fd, int flags, const struct itimerspec *new_value,
+		    struct itimerspec *old_value),
+		   __timerfd_settime64);
+
+COBALT_DECL_TIME64(int, timerfd_gettime,
+		   (int fd, struct itimerspec *curr_value),
+		   __timerfd_gettime64);
+
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */
diff --git a/include/cobalt/time.h b/include/cobalt/time.h
index e3f355c61..38e43fb9e 100644
--- a/include/cobalt/time.h
+++ b/include/cobalt/time.h
@@ -70,6 +70,41 @@ COBALT_DECL(int, timer_gettime(timer_t timerid,
 
 COBALT_DECL(int, timer_getoverrun(timer_t timerid));
 
+COBALT_DECL_TIME64(int, clock_gettime,
+		   (clockid_t __clock_id, struct timespec *tp),
+		   __clock_gettime64);
+
+COBALT_DECL_TIME64(int, clock_settime,
+		   (clockid_t __clock_id, const struct timespec *tp),
+		   __clock_settime64);
+
+COBALT_DECL_TIME64(int, clock_nanosleep,
+		   (clockid_t clock_id, int flags, const struct timespec *rqtp,
+		    struct timespec *rmtp),
+		   __clock_nanosleep_time64);
+
+COBALT_DECL_TIME64(int, clock_getres, (clockid_t clock_id, struct timespec *tp),
+		   __clock_getres64);
+
+COBALT_DECL_TIME64(int, clock_adjtime, (clockid_t clock_id, struct timex *tx),
+		   __clock_adjtime64);
+
+COBALT_DECL_TIME64(int, timer_settime,
+		   (timer_t timerid, int flags,
+		    const struct itimerspec *__restrict__ value,
+		    struct itimerspec *__restrict__ ovalue),
+		   __timer_settime64);
+
+COBALT_DECL_TIME64(int, timer_gettime,
+		   (timer_t timerid, struct itimerspec *value),
+		   __timer_gettime64);
+
+COBALT_DECL_TIME64(time_t, time, (time_t *t), __time64);
+
+COBALT_DECL_TIME64(int, nanosleep,
+		   (const struct timespec *rqtp, struct timespec *rmtp),
+		   __nanosleep64);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index 7e061caf9..fe3132127 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -32,6 +32,16 @@
 	__typeof__(T) __STD(P); \
 	__typeof__(T) __WRAP(P)
 
+#if __USE_TIME_BITS64
+/*
+ * Make __STD() usable in combination with time64_t related services.
+ */
+#define COBALT_DECL_TIME64(T, F, I, A)                                         \
+	extern T __REDIRECT_NTH(__STD(F), I, __real_##A)
+#else
+#define COBALT_DECL_TIME64(T, F, I, A)
+#endif
+
 /*
  * 
  * Each "foo" Cobalt routine shadowing a POSIX service may be
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 0c7de5216..45508641e 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1613,6 +1613,48 @@ out:
 	return test_pselect64_interruption();
 }
 
+static int test_function_wrapping(void)
+{
+#ifndef __USE_TIME_BITS64
+	/*
+	 * We're testing some functions here that are wrapped only for 32 bit
+	 * applications with y2038 support enabled. If that's not the case we
+	 * can simply bail out and simulate success.
+	 */
+	return 0;
+#endif
+	struct timespec ts64 = { 0 };
+	int ret;
+
+	/*
+	 * If the nsec part of ts64 is still 0 it's a good indication that our
+	 * function wrapping does not work as expected. We retry up to three
+	 * times to avoid shaky test results.
+	 *
+	 * __STD(clock_gettime()) is replaced with
+	 * __real_clock_gettime() by the preprocessor. If
+	 * __real_clock_gettime() is not properly redirected by the use of
+	 * COBALT_DECL_TIME64() (linker magic) we will end up in the glibc
+	 * implementation with "native" time_t.
+	 */
+	for (int i = 0; i < 3; i++) {
+		ret = smokey_check_errno(
+			__STD(clock_gettime(CLOCK_REALTIME, &ts64)));
+		if (ret)
+			return ret;
+
+		if (ts64.tv_nsec != 0)
+			break;
+
+		if (i == 2) {
+			smokey_warning("Function wrapping seems broken.");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int check_kernel_version(void)
 {
 	int ret, major, minor;
@@ -1722,5 +1764,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_function_wrapping();
+	if (ret)
+		return ret;
+
 	return 0;
 }

-- 
2.39.2

