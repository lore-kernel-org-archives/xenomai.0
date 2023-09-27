Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03738F90
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 14:00:54 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230927135043fdb57e6bf0cc1fc541
        for <xenomai@lists.linux.dev>;
        Wed, 27 Sep 2023 15:50:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=A5wmDYmYDfVDchQf9kWlWWRL2zclnjG59+Alte2PIJI=;
 b=oTmBevmeXiBqSJWqDhADKL29I59Z7ebDC8YdDcpqsNOtT5y3I88dOe9hEnHp1k9Km3EWw2
 WT61WQjSqFNt19OrrK30hbCyCYBDuIupjtGPL5QV7ReQgVPYqyGdeGoQjfiUWoLDzQTHFPEb
 4DItJBHoEUyVREbN3HcdNoyDeDZsA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 27 Sep 2023 15:50:19 +0200
Subject: [PATCH v2 6/9] y2038: lib/cobalt: Implement necessary wrappers for
 y2038 support
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-florian-y2038-2-v2-6-05f710464d83@siemens.com>
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

COBALT_IMPL_TIME64():
  This macro is based on COBALT_IMPL() and will add the necessary
  __wrap_ function as weak symbol to the cobalt implementation
  (starting with __cobalt_) when y2038 support has been requested.
  This allows the usage of the __RT() macro in combination with
  y2038/time64 wrappers.

COBALT_DECL_TIME64():
  This macro is based on COBALT_DECL() and allows the usage of __STD()
  in combination with y2038/time64 wrappers.

Both macros will fall back to their basements if y2038 support was
not requested.

Examples, assuming code is located in application code:
  select():       will be redirected by glibc to __select64() when
                  y2038 support is requested. We additionally wrap the
                  __select64() function so __wrap___select64() will be
                  called - which is a weak symbol aliased to
                  __cobalt_select(). That allows users to overwrite
                  __wrap___select64() if they need to.

  __RT(select()): result after preprocessor: __cobalt_select()
                  __cobalt_select() is y2038 safe when y2038 has been
                  requested.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 configure.ac                            | 16 +++++++--
 include/cobalt/mqueue.h                 |  8 ++---
 include/cobalt/pthread.h                | 10 +++---
 include/cobalt/semaphore.h              |  4 +--
 include/cobalt/signal.h                 |  6 ++--
 include/cobalt/sys/ioctl.h              |  3 +-
 include/cobalt/sys/select.h             |  2 +-
 include/cobalt/sys/socket.h             | 11 +++---
 include/cobalt/sys/time.h               |  3 +-
 include/cobalt/sys/timerfd.h            |  9 ++---
 include/cobalt/time.h                   | 34 ++++++++++---------
 include/cobalt/wrappers.h               | 23 +++++++++++--
 lib/cobalt/Makefile.am                  |  2 ++
 lib/cobalt/clock.c                      | 26 ++++++++------
 lib/cobalt/cobalt-glibc-time64.wrappers | 23 +++++++++++++
 lib/cobalt/cond.c                       |  6 ++--
 lib/cobalt/mq.c                         | 16 ++++-----
 lib/cobalt/mutex.c                      |  4 +--
 lib/cobalt/rtdm.c                       | 18 ++++++----
 lib/cobalt/select.c                     | 60 ++++++++++++++++++++++++++++++---
 lib/cobalt/semaphore.c                  |  3 +-
 lib/cobalt/signal.c                     |  5 +--
 lib/cobalt/timer.c                      | 11 +++---
 lib/cobalt/timerfd.c                    |  9 ++---
 scripts/xeno-config-cobalt.in           |  5 +++
 25 files changed, 222 insertions(+), 95 deletions(-)

diff --git a/configure.ac b/configure.ac
index f1734b27a..aa3794a5f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -944,17 +944,27 @@ dnl in-tree executables which require POSIX symbol wrapping.
 
    modechk_wrappers="$topdir/lib/cobalt/modechk.wrappers"
    cobalt_wrappers="$topdir/lib/cobalt/cobalt.wrappers"
+   cobalt_wrappers_glibc_time64="$topdir/lib/cobalt/cobalt-glibc-time64.wrappers"
+   all_wrappers="$modechk_wrappers $cobalt_wrappers"
+
+   linker_flags="-Wl,@$modechk_wrappers -Wl,@$cobalt_wrappers"
+
+   if [[ "$CONFIG_XENO_LIBS_TIME64" = "yes" ]]; then
+      all_wrappers="$all_wrappers $cobalt_wrappers_glibc_time64"
+      linker_flags="$linker_flags -Wl,@$cobalt_wrappers_glibc_time64"
+   fi
+
    if [[ $ac_cv_ld_file_option = yes ]]; then
-	XENO_POSIX_WRAPPERS="-Wl,@$modechk_wrappers -Wl,@$cobalt_wrappers"
+	XENO_POSIX_WRAPPERS="$linker_flags"
    else
-	XENO_POSIX_WRAPPERS=`cat $modechk_wrappers $cobalt_wrappers | \
+	XENO_POSIX_WRAPPERS=`cat $all_wrappers | \
 			while read wrap_option symbol ; do \
 				echo -n "-Wl,$wrap_option,$symbol " ; \
 			done`
    fi
 
    AC_SUBST(XENO_POSIX_WRAPPERS)
-   AC_SUBST([CONFIG_STATUS_DEPENDENCIES], ["$modechk_wrappers $cobalt_wrappers"])
+   AC_SUBST([CONFIG_STATUS_DEPENDENCIES], ["$all_wrappers"])
 fi
 
 dnl Multi-library support.
diff --git a/include/cobalt/mqueue.h b/include/cobalt/mqueue.h
index c33baf649..89d4bff79 100644
--- a/include/cobalt/mqueue.h
+++ b/include/cobalt/mqueue.h
@@ -42,14 +42,14 @@ COBALT_DECL(int, mq_setattr,
 COBALT_DECL(int, mq_send,
 	    (mqd_t qd, const char *buffer, size_t len, unsigned prio));
 
-COBALT_DECL(int, mq_timedsend,
-	    (mqd_t q, const char *buffer, size_t len, unsigned prio,
-	     const struct timespec *timeout));
+COBALT_DECL_TIME64(int, mq_timedsend, __mq_timedsend64,
+		   (mqd_t q, const char *buffer, size_t len, unsigned prio,
+		    const struct timespec *timeout));
 
 COBALT_DECL(ssize_t, mq_receive,
 	    (mqd_t q, char *buffer, size_t len, unsigned *prio));
 
-COBALT_DECL(ssize_t, mq_timedreceive,
+COBALT_DECL_TIME64(ssize_t, mq_timedreceive, __mq_timedsend_time64,
 	    (mqd_t q, char *__restrict__ buffer, size_t len,
 	     unsigned *__restrict__ prio,
 	     const struct timespec *__restrict__ timeout));
diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
index 4585dd409..1a8991f5c 100644
--- a/include/cobalt/pthread.h
+++ b/include/cobalt/pthread.h
@@ -59,8 +59,8 @@ COBALT_DECL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex));
 
 COBALT_DECL(int, pthread_mutex_lock, (pthread_mutex_t *mutex));
 
-COBALT_DECL(int, pthread_mutex_timedlock,
-	    (pthread_mutex_t *mutex, const struct timespec *to));
+COBALT_DECL_TIME64(int, pthread_mutex_timedlock, __pthread_mutex_timedlock64,
+		   (pthread_mutex_t *mutex, const struct timespec *to));
 
 COBALT_DECL(int, pthread_mutex_trylock, (pthread_mutex_t *mutex));
 
@@ -81,9 +81,9 @@ COBALT_DECL(int, pthread_cond_destroy, (pthread_cond_t *cond));
 COBALT_DECL(int, pthread_cond_wait,
 	    (pthread_cond_t *cond, pthread_mutex_t *mutex));
 
-COBALT_DECL(int, pthread_cond_timedwait,
-	    (pthread_cond_t *cond, pthread_mutex_t *mutex,
-	     const struct timespec *abstime));
+COBALT_DECL_TIME64(int, pthread_cond_timedwait, __pthread_cond_timedwait64,
+		   (pthread_cond_t *cond, pthread_mutex_t *mutex,
+		    const struct timespec *abstime));
 
 COBALT_DECL(int, pthread_cond_signal, (pthread_cond_t *cond));
 
diff --git a/include/cobalt/semaphore.h b/include/cobalt/semaphore.h
index ed26520ec..d5e835a8d 100644
--- a/include/cobalt/semaphore.h
+++ b/include/cobalt/semaphore.h
@@ -37,8 +37,8 @@ COBALT_DECL(int, sem_post, (sem_t *sem));
 
 COBALT_DECL(int, sem_wait, (sem_t *sem));
 
-COBALT_DECL(int, sem_timedwait,
-	    (sem_t *sem, const struct timespec *abs_timeout));
+COBALT_DECL_TIME64(int, sem_timedwait, __sem_timedwait64,
+		   (sem_t *sem, const struct timespec *abs_timeout));
 
 COBALT_DECL(int, sem_trywait, (sem_t *sem));
 
diff --git a/include/cobalt/signal.h b/include/cobalt/signal.h
index d92ccf2c5..55cb2baba 100644
--- a/include/cobalt/signal.h
+++ b/include/cobalt/signal.h
@@ -46,9 +46,9 @@ COBALT_DECL(int, sigwait, (const sigset_t *set, int *sig));
 
 COBALT_DECL(int, sigwaitinfo, (const sigset_t *set, siginfo_t *si));
 
-COBALT_DECL(int, sigtimedwait,
-	    (const sigset_t *set, siginfo_t *si,
-	     const struct timespec *timeout));
+COBALT_DECL_TIME64(int, sigtimedwait, __sigtimedwait64,
+		   (const sigset_t *set, siginfo_t *si,
+		    const struct timespec *timeout));
 
 COBALT_DECL(int, kill, (pid_t pid, int sig));
 
diff --git a/include/cobalt/sys/ioctl.h b/include/cobalt/sys/ioctl.h
index ab3189591..1dd06dd09 100644
--- a/include/cobalt/sys/ioctl.h
+++ b/include/cobalt/sys/ioctl.h
@@ -27,7 +27,8 @@
 extern "C" {
 #endif
 
-COBALT_DECL(int, ioctl, (int fildes, unsigned int request, ...));
+COBALT_DECL_TIME64(int, ioctl, __ioctl_time64,
+		   (int fd, unsigned int request, ...));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/sys/select.h b/include/cobalt/sys/select.h
index e823874f8..89062875c 100644
--- a/include/cobalt/sys/select.h
+++ b/include/cobalt/sys/select.h
@@ -27,7 +27,7 @@
 extern "C" {
 #endif
 
-COBALT_DECL(int, select,
+COBALT_DECL_TIME64(int, select, __select64,
 	    (int __nfds, fd_set *__restrict __readfds,
 	     fd_set *__restrict __writefds, fd_set *__restrict __exceptfds,
 	     struct timeval *__restrict __timeout));
diff --git a/include/cobalt/sys/socket.h b/include/cobalt/sys/socket.h
index af7dcc159..d5e81e5bd 100644
--- a/include/cobalt/sys/socket.h
+++ b/include/cobalt/sys/socket.h
@@ -53,12 +53,13 @@ COBALT_DECL(ssize_t, recv, (int fd, void *buf, size_t len, int flags));
 
 COBALT_DECL(ssize_t, send, (int fd, const void *buf, size_t len, int flags));
 
-COBALT_DECL(int, getsockopt,
-	    (int fd, int level, int optname, void *optval, socklen_t *optlen));
+COBALT_DECL_TIME64(int, getsockopt, __getsockopt64,
+		   (int fd, int level, int optname, void *optval,
+		    socklen_t *optlen));
 
-COBALT_DECL(int, setsockopt,
-	    (int fd, int level, int optname, const void *optval,
-	     socklen_t optlen));
+COBALT_DECL_TIME64(int, setsockopt, __setsockopt64,
+		   (int fd, int level, int optname, const void *optval,
+		    socklen_t optlen));
 
 COBALT_DECL(int, bind,
 	    (int fd, const struct sockaddr *my_addr, socklen_t addrlen));
diff --git a/include/cobalt/sys/time.h b/include/cobalt/sys/time.h
index b27dec815..e52f2e162 100644
--- a/include/cobalt/sys/time.h
+++ b/include/cobalt/sys/time.h
@@ -29,7 +29,8 @@ struct timezone;
 extern "C" {
 #endif
 
-COBALT_DECL(int, gettimeofday, (struct timeval *tv, struct timezone *tz));
+COBALT_DECL_TIME64(int, gettimeofday, __gettimeofday64,
+		   (struct timeval *tv, struct timezone *tz));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/sys/timerfd.h b/include/cobalt/sys/timerfd.h
index 6649a19e0..46055d105 100644
--- a/include/cobalt/sys/timerfd.h
+++ b/include/cobalt/sys/timerfd.h
@@ -29,11 +29,12 @@ extern "C" {
 
 COBALT_DECL(int, timerfd_create, (int clockid, int flags));
 
-COBALT_DECL(int, timerfd_settime,
-	    (int fd, int flags, const struct itimerspec *new_value,
-	     struct itimerspec *old_value));
+COBALT_DECL_TIME64(int, timerfd_settime, __timerfd_settime64,
+		   (int fd, int flags, const struct itimerspec *new_value,
+		    struct itimerspec *old_value));
 
-COBALT_DECL(int, timerfd_gettime, (int fd, struct itimerspec *curr_value));
+COBALT_DECL_TIME64(int, timerfd_gettime, __timerfd_gettime64,
+		   (int fd, struct itimerspec *curr_value));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/time.h b/include/cobalt/time.h
index 006a0ae03..65d33e298 100644
--- a/include/cobalt/time.h
+++ b/include/cobalt/time.h
@@ -32,23 +32,26 @@ extern "C" {
 
 struct timex;
 
-COBALT_DECL(int, clock_getres, (clockid_t clock_id, struct timespec *tp));
+COBALT_DECL_TIME64(int, clock_getres, __clock_getres64,
+		   (clockid_t clock_id, struct timespec *tp));
 
-COBALT_DECL(int, clock_gettime, (clockid_t clock_id, struct timespec *tp));
+COBALT_DECL_TIME64(int, clock_gettime, __clock_gettime64,
+		   (clockid_t clock_id, struct timespec *tp));
 
-COBALT_DECL(int, clock_settime,
-	    (clockid_t clock_id, const struct timespec *tp));
+COBALT_DECL_TIME64(int, clock_settime, __clock_settime64,
+		   (clockid_t clock_id, const struct timespec *tp));
 
-COBALT_DECL(int, clock_adjtime, (clockid_t clock_id, struct timex *tx));
+COBALT_DECL_TIME64(int, clock_adjtime, __clock_adjtime64,
+		   (clockid_t clock_id, struct timex *tx));
 
-COBALT_DECL(int, clock_nanosleep,
-	    (clockid_t clock_id, int flags, const struct timespec *rqtp,
-	     struct timespec *rmtp));
+COBALT_DECL_TIME64(int, clock_nanosleep, __clock_nanosleep_time64,
+		   (clockid_t clock_id, int flags, const struct timespec *rqtp,
+		    struct timespec *rmtp));
 
-COBALT_DECL(time_t, time, (time_t *t));
+COBALT_DECL_TIME64(time_t, time, __time64, (time_t *t));
 
-COBALT_DECL(int, nanosleep,
-	    (const struct timespec *rqtp, struct timespec *rmtp));
+COBALT_DECL_TIME64(int, nanosleep, __nanosleep64,
+		   (const struct timespec *rqtp, struct timespec *rmtp));
 
 COBALT_DECL(int, timer_create,
 	    (clockid_t clockid, const struct sigevent *__restrict__ evp,
@@ -56,11 +59,12 @@ COBALT_DECL(int, timer_create,
 
 COBALT_DECL(int, timer_delete, (timer_t timerid));
 
-COBALT_DECL(int, timer_settime,
-	    (timer_t timerid, int flags, const struct itimerspec *value,
-	     struct itimerspec *ovalue));
+COBALT_DECL_TIME64(int, timer_settime, __timer_settime64,
+		   (timer_t timerid, int flags, const struct itimerspec *value,
+		    struct itimerspec *ovalue));
 
-COBALT_DECL(int, timer_gettime, (timer_t timerid, struct itimerspec *value));
+COBALT_DECL_TIME64(int, timer_gettime, __timer_gettime64,
+		   (timer_t timerid, struct itimerspec *value));
 
 COBALT_DECL(int, timer_getoverrun, (timer_t timerid));
 
diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index aaa581db4..21f4ceacb 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -32,6 +32,22 @@
 	__typeof__(T) __STD(FN) I;                                             \
 	__typeof__(T) __WRAP(FN) I
 
+#if __USE_TIME_BITS64
+/*
+ * Make __RT() and __STD() usable in combination with time64_t related services.
+ */
+#define COBALT_IMPL_TIME64(T, FN, FN_64, I)                                    \
+	__typeof__(T) __wrap_##FN_64 I                                         \
+		__attribute__((alias("__cobalt_" __stringify(FN)), weak));     \
+	COBALT_IMPL(T, FN, I)
+#define COBALT_DECL_TIME64(T, FN, A, I)                                        \
+	extern T __REDIRECT_NTH(__STD(FN), I, __real_##A);                     \
+	COBALT_DECL(T, FN, I)
+#else
+#define COBALT_IMPL_TIME64(T, FN, FN_64, I) COBALT_IMPL(T, FN, I)
+#define COBALT_DECL_TIME64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
+#endif
+
 /*
  * 
  * Each "foo" Cobalt routine shadowing a POSIX service may be
@@ -48,8 +64,9 @@
  * version. The original Cobalt implementation can still be
  * referenced as __COBALT(foo).
  */
-#define COBALT_IMPL(T, I, A)								\
-__typeof__(T) __wrap_ ## I A __attribute__((alias("__cobalt_" __stringify(I)), weak));	\
-__typeof__(T) __cobalt_ ## I A
+#define COBALT_IMPL(T, FN, I)                                                  \
+	__typeof__(T) __wrap_##FN I                                            \
+		__attribute__((alias("__cobalt_" __stringify(FN)), weak));     \
+	__typeof__(T) __cobalt_##FN I
 
 #endif /* !_COBALT_WRAPPERS_H */
diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 3159695b3..4318adf18 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -59,10 +59,12 @@ AM_LIBTOOLFLAGS = --silent
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(libdir)
 	$(INSTALL_DATA) $(srcdir)/cobalt.wrappers $(DESTDIR)$(libdir)
+	$(INSTALL_DATA) $(srcdir)/cobalt-glibc-time64.wrappers $(DESTDIR)$(libdir)
 	$(INSTALL_DATA) $(srcdir)/modechk.wrappers $(DESTDIR)$(libdir)
 
 uninstall-local:
 	$(RM) $(DESTDIR)$(libdir)/cobalt.wrappers
+	$(RM) $(DESTDIR)$(libdir)/cobalt-glibc-time64.wrappers
 	$(RM) $(DESTDIR)$(libdir)/modechk.wrappers
 
 EXTRA_DIST = cobalt.wrappers modechk.wrappers
diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 377582cf3..9289d8787 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -96,7 +96,8 @@
  *
  * @apitags{unrestricted}
  */
-COBALT_IMPL(int, clock_getres, (clockid_t clock_id, struct timespec *tp))
+COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,
+		   (clockid_t clock_id, struct timespec *tp))
 {
 	int ret;
 
@@ -152,7 +153,8 @@ static int __do_clock_gettime(clockid_t clock_id, struct timespec *tp)
  *
  * @apitags{unrestricted}
  */
-COBALT_IMPL(int, clock_gettime, (clockid_t clock_id, struct timespec *tp))
+COBALT_IMPL_TIME64(int, clock_gettime, __clock_gettime64,
+		   (clockid_t clock_id, struct timespec *tp))
 {
 	int ret;
 
@@ -201,7 +203,8 @@ COBALT_IMPL(int, clock_gettime, (clockid_t clock_id, struct timespec *tp))
  *
  * @apitags{unrestricted, switch-secondary}
  */
-COBALT_IMPL(int, clock_settime, (clockid_t clock_id, const struct timespec *tp))
+COBALT_IMPL_TIME64(int, clock_settime, __clock_settime64,
+		   (clockid_t clock_id, const struct timespec *tp))
 {
 	int ret;
 
@@ -223,7 +226,8 @@ COBALT_IMPL(int, clock_settime, (clockid_t clock_id, const struct timespec *tp))
 
 /* @apitags{unrestricted} */
 
-COBALT_IMPL(int, clock_adjtime, (clockid_t clock_id, struct timex *tx))
+COBALT_IMPL_TIME64(int, clock_adjtime, __clock_adjtime64,
+		   (clockid_t clock_id, struct timex *tx))
 {
 	int ret;
 
@@ -281,9 +285,9 @@ COBALT_IMPL(int, clock_adjtime, (clockid_t clock_id, struct timex *tx))
  *
  * @apitags{xthread-only, switch-primary}
  */
-COBALT_IMPL(int, clock_nanosleep, (clockid_t clock_id,
-				   int flags,
-				   const struct timespec *rqtp, struct timespec *rmtp))
+COBALT_IMPL_TIME64(int, clock_nanosleep, __clock_nanosleep_time64,
+		   (clockid_t clock_id, int flags, const struct timespec *rqtp,
+		    struct timespec *rmtp))
 {
 	int ret, oldtype;
 
@@ -332,7 +336,8 @@ COBALT_IMPL(int, clock_nanosleep, (clockid_t clock_id,
  *
  * @apitags{xthread-only, switch-primary}
  */
-COBALT_IMPL(int, nanosleep, (const struct timespec *rqtp, struct timespec *rmtp))
+COBALT_IMPL_TIME64(int, nanosleep, __nanosleep64,
+		   (const struct timespec *rqtp, struct timespec *rmtp))
 {
 	int ret;
 
@@ -380,7 +385,8 @@ COBALT_IMPL(int, usleep, (useconds_t usec))
 
 /* @apitags{unrestricted} */
 
-COBALT_IMPL(int, gettimeofday, (struct timeval *tv, struct timezone *tz))
+COBALT_IMPL_TIME64(int, gettimeofday, __gettimeofday64,
+		   (struct timeval *tv, struct timezone *tz))
 {
 	struct timespec ts;
 	int ret = __WRAP(clock_gettime(CLOCK_REALTIME, &ts));
@@ -393,7 +399,7 @@ COBALT_IMPL(int, gettimeofday, (struct timeval *tv, struct timezone *tz))
 
 /* @apitags{unrestricted} */
 
-COBALT_IMPL(time_t, time, (time_t *t))
+COBALT_IMPL_TIME64(time_t, time, __time64, (time_t *t))
 {
 	struct timespec ts;
 	int ret = __WRAP(clock_gettime(CLOCK_REALTIME, &ts));
diff --git a/lib/cobalt/cobalt-glibc-time64.wrappers b/lib/cobalt/cobalt-glibc-time64.wrappers
new file mode 100644
index 000000000..0bf895ca9
--- /dev/null
+++ b/lib/cobalt/cobalt-glibc-time64.wrappers
@@ -0,0 +1,23 @@
+--wrap __sem_timedwait64
+--wrap __clock_gettime64
+--wrap __clock_settime64
+--wrap __clock_nanosleep_time64
+--wrap __clock_getres64
+--wrap __clock_adjtime64
+--wrap __pthread_mutex_timedlock64
+--wrap __mq_timedsend_time64
+--wrap __mq_timedreceive_time64
+--wrap __sigtimedwait64
+--wrap __recvmmsg64
+--wrap __pthread_cond_timedwait64
+--wrap __timer_settime64
+--wrap __timer_gettime64
+--wrap __timerfd_settime64
+--wrap __timerfd_gettime64
+--wrap __setsockopt64
+--wrap __getsockopt64
+--wrap __select64
+--wrap __ioctl_time64
+--wrap __gettimeofday64
+--wrap __time64
+--wrap __nanosleep64
diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index 35b367a73..7f1906bf9 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -375,9 +375,9 @@ COBALT_IMPL(int, pthread_cond_wait, (pthread_cond_t *cond, pthread_mutex_t *mute
  *
  * @apitags{xthread-only, switch-primary}
  */
-COBALT_IMPL(int, pthread_cond_timedwait, (pthread_cond_t *cond,
-					  pthread_mutex_t *mutex,
-					  const struct timespec *abstime))
+COBALT_IMPL_TIME64(int, pthread_cond_timedwait, __pthread_cond_timedwait64,
+		   (pthread_cond_t *cond, pthread_mutex_t *mutex,
+		    const struct timespec *abstime))
 {
 	struct cobalt_cond_shadow *_cnd = &((union cobalt_cond_union *)cond)->shadow_cond;
 	struct cobalt_mutex_shadow *_mx =
diff --git a/lib/cobalt/mq.c b/lib/cobalt/mq.c
index 365a28e7a..117f05d3f 100644
--- a/lib/cobalt/mq.c
+++ b/lib/cobalt/mq.c
@@ -391,10 +391,9 @@ COBALT_IMPL(int, mq_send, (mqd_t q, const char *buffer, size_t len, unsigned pri
  *
  * @apitags{xthread-only, switch-primary}
  */
-COBALT_IMPL(int, mq_timedsend, (mqd_t q,
-				const char *buffer,
-				size_t len,
-				unsigned prio, const struct timespec *timeout))
+COBALT_IMPL_TIME64(int, mq_timedsend, __mq_timedsend_time64,
+		   (mqd_t q, const char *buffer, size_t len, unsigned prio,
+		    const struct timespec *timeout))
 {
 	int err, oldtype;
 
@@ -524,11 +523,10 @@ COBALT_IMPL(ssize_t, mq_receive, (mqd_t q, char *buffer, size_t len, unsigned *p
  *
  * @apitags{xthread-only, switch-primary}
  */
-COBALT_IMPL(ssize_t, mq_timedreceive, (mqd_t q,
-				       char *__restrict__ buffer,
-				       size_t len,
-				       unsigned *__restrict__ prio,
-				       const struct timespec * __restrict__ timeout))
+COBALT_IMPL_TIME64(ssize_t, mq_timedreceive, __mq_timedreceive_time64,
+		   (mqd_t q, char *__restrict__ buffer, size_t len,
+		    unsigned *__restrict__ prio,
+		    const struct timespec *__restrict__ timeout))
 {
 	ssize_t rlen = (ssize_t) len;
 	int err, oldtype;
diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index 73e45a1c4..a578675f3 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -423,8 +423,8 @@ protect:
  *
  * @apitags{xthread-only, switch-primary}
  */
-COBALT_IMPL(int, pthread_mutex_timedlock, (pthread_mutex_t *mutex,
-					   const struct timespec *to))
+COBALT_IMPL_TIME64(int, pthread_mutex_timedlock, __pthread_mutex_timedlock64,
+		   (pthread_mutex_t *mutex, const struct timespec *to))
 {
 	struct cobalt_mutex_shadow *_mutex =
 		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 82323104a..98c8c679a 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -192,7 +192,8 @@ COBALT_IMPL(int, fcntl, (int fd, int cmd, ...))
 	return __STD(fcntl(fd, cmd, arg));
 }
 
-COBALT_IMPL(int, ioctl, (int fd, unsigned int request, ...))
+COBALT_IMPL_TIME64(int, ioctl, __ioctl_time64,
+		   (int fd, unsigned int request, ...))
 {
 	va_list ap;
 	void *arg;
@@ -265,8 +266,9 @@ COBALT_IMPL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags))
 	return __STD(recvmsg(fd, msg, flags));
 }
 
-COBALT_IMPL(int, recvmmsg, (int fd, struct mmsghdr *msgvec, unsigned int vlen,
-			    unsigned int flags, struct timespec *timeout))
+COBALT_IMPL_TIME64(int, recvmmsg, __recvmmsg64,
+		   (int fd, struct mmsghdr *msgvec, unsigned int vlen,
+		    unsigned int flags, struct timespec *timeout))
 {
 	int ret, oldtype;
 
@@ -429,8 +431,9 @@ COBALT_IMPL(ssize_t, send, (int fd, const void *buf, size_t len, int flags))
 	return __STD(send(fd, buf, len, flags));
 }
 
-COBALT_IMPL(int, getsockopt, (int fd, int level, int optname, void *optval,
-			      socklen_t *optlen))
+COBALT_IMPL_TIME64(int, getsockopt, __getsockopt64,
+		   (int fd, int level, int optname, void *optval,
+		    socklen_t *optlen))
 {
 	struct _rtdm_getsockopt_args args = { level, optname, optval, optlen };
 	int ret;
@@ -442,8 +445,9 @@ COBALT_IMPL(int, getsockopt, (int fd, int level, int optname, void *optval,
 	return __STD(getsockopt(fd, level, optname, optval, optlen));
 }
 
-COBALT_IMPL(int, setsockopt, (int fd, int level, int optname, const void *optval,
-			      socklen_t optlen))
+COBALT_IMPL_TIME64(int, setsockopt, __setsockopt64,
+		   (int fd, int level, int optname, const void *optval,
+		    socklen_t optlen))
 {
 	struct _rtdm_setsockopt_args args = {
 		level, optname, (void *)optval, optlen
diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
index 7727012c7..9577fa256 100644
--- a/lib/cobalt/select.c
+++ b/lib/cobalt/select.c
@@ -20,12 +20,52 @@
 #include <pthread.h>
 #include <sys/select.h>
 #include <asm/xenomai/syscall.h>
-#include "internal.h"
 
-COBALT_IMPL(int, select, (int __nfds, fd_set *__restrict __readfds,
-			  fd_set *__restrict __writefds,
-			  fd_set *__restrict __exceptfds,
-			  struct timeval *__restrict __timeout))
+#if __USE_TIME_BITS64
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
+		to.tv_sec = __timeout->tv_sec;
+		to.tv_nsec = __timeout->tv_usec * 1000;
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
+	if (err == -EADV || err == -EPERM || err == -ENOSYS)
+		err = __STD(__select64(__nfds, __readfds, __writefds,
+				       __exceptfds, __timeout));
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
 {
 	int err, oldtype;
 
@@ -46,3 +86,13 @@ COBALT_IMPL(int, select, (int __nfds, fd_set *__restrict __readfds,
 	errno = -err;
 	return -1;
 }
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
diff --git a/lib/cobalt/semaphore.c b/lib/cobalt/semaphore.c
index bff005440..b6652b763 100644
--- a/lib/cobalt/semaphore.c
+++ b/lib/cobalt/semaphore.c
@@ -362,7 +362,8 @@ COBALT_IMPL(int, sem_wait, (sem_t *sem))
  *
  * @apitags{xthread-only, switch-primary}
  */
-COBALT_IMPL(int, sem_timedwait, (sem_t *sem, const struct timespec *abs_timeout))
+COBALT_IMPL_TIME64(int, sem_timedwait, __sem_timedwait64,
+		   (sem_t *sem, const struct timespec *abs_timeout))
 {
 	struct cobalt_sem_shadow *_sem = &((union cobalt_sem_union *)sem)->shadow_sem;
 	int ret, oldtype;
diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
index 40d315ebb..d4bc2463d 100644
--- a/lib/cobalt/signal.c
+++ b/lib/cobalt/signal.c
@@ -55,8 +55,9 @@ COBALT_IMPL(int, sigwaitinfo, (const sigset_t *set, siginfo_t *si))
 	return ret;
 }
 
-COBALT_IMPL(int, sigtimedwait, (const sigset_t *set, siginfo_t *si,
-				const struct timespec *timeout))
+COBALT_IMPL_TIME64(int, sigtimedwait, __sigtimedwait64,
+		   (const sigset_t *set, siginfo_t *si,
+		    const struct timespec *timeout))
 {
 	int ret, oldtype;
 
diff --git a/lib/cobalt/timer.c b/lib/cobalt/timer.c
index d86d01417..e20d30e83 100644
--- a/lib/cobalt/timer.c
+++ b/lib/cobalt/timer.c
@@ -159,10 +159,10 @@ COBALT_IMPL(int, timer_delete, (timer_t timerid))
  *
  * @apitags{xcontext, switch-primary}
  */
-COBALT_IMPL(int, timer_settime, (timer_t timerid,
-				 int flags,
-				 const struct itimerspec *__restrict__ value,
-				 struct itimerspec *__restrict__ ovalue))
+COBALT_IMPL_TIME64(int, timer_settime, __timer_settime64,
+		   (timer_t timerid, int flags,
+		    const struct itimerspec *__restrict__ value,
+		    struct itimerspec *__restrict__ ovalue))
 {
 	int ret;
 
@@ -210,7 +210,8 @@ COBALT_IMPL(int, timer_settime, (timer_t timerid,
  *
  * @apitags{unrestricted}
  */
-COBALT_IMPL(int, timer_gettime, (timer_t timerid, struct itimerspec *value))
+COBALT_IMPL_TIME64(int, timer_gettime, __timer_gettime64,
+		   (timer_t timerid, struct itimerspec *value))
 {
 	int ret;
 
diff --git a/lib/cobalt/timerfd.c b/lib/cobalt/timerfd.c
index 5e7db928f..11e0b04e3 100644
--- a/lib/cobalt/timerfd.c
+++ b/lib/cobalt/timerfd.c
@@ -35,9 +35,9 @@ COBALT_IMPL(int, timerfd_create, (int clockid, int flags))
 	return fd;
 }
 
-COBALT_IMPL(int, timerfd_settime,
-	    (int fd, int flags, const struct itimerspec *new_value,
-	     struct itimerspec *old_value))
+COBALT_IMPL_TIME64(int, timerfd_settime, __timerfd_settime64,
+		   (int fd, int flags, const struct itimerspec *new_value,
+		    struct itimerspec *old_value))
 {
 	int ret;
 
@@ -55,7 +55,8 @@ COBALT_IMPL(int, timerfd_settime,
 	return -1;
 }
 
-COBALT_IMPL(int, timerfd_gettime, (int fd, struct itimerspec *curr_value))
+COBALT_IMPL_TIME64(int, timerfd_gettime, __timerfd_gettime64,
+		   (int fd, struct itimerspec *curr_value))
 {
 	int ret;
 
diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
index a093779b9..46b6c11b9 100644
--- a/scripts/xeno-config-cobalt.in
+++ b/scripts/xeno-config-cobalt.in
@@ -20,6 +20,7 @@ XENO_COBALT_LDFLAGS="-L${staging}${libdir} -lcobalt"
 XENO_POSIX_LDFLAGS="-lpthread -lrt @XENO_USER_APP_LDFLAGS@"
 XENO_LIBRARY_DIR="${staging}${libdir}"
 LD_FILE_OPTION="@LD_FILE_OPTION@"
+CONFIG_XENO_LIBS_TIME64="@CONFIG_XENO_LIBS_TIME64@"
 
 unset skin_list compat codegen
 
@@ -252,6 +253,10 @@ if test x$do_ldflags = xy; then
 	case "$skin" in
 	    posix|rtdm)
 		ldflags="`dump_wrappers cobalt.wrappers` $ldflags"
+
+		if test "$CONFIG_XENO_LIBS_TIME64" = "yes"; then
+			ldflags="$(dump_wrappers cobalt-glibc-time64.wrappers) $ldflags"
+		fi
 		;;
 	    cobalt)
 		# do NOT wrap POSIX symbols in application code with

-- 
2.39.2

