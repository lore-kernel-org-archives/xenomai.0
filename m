Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8355224
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 07:37:59 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202308110737516670f413f3f227c452
        for <xenomai@lists.linux.dev>;
        Fri, 11 Aug 2023 09:37:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8vb3VhqGRRYESqbJVH9LpczwuX8z+UIuw+RsAepo/js=;
 b=BTRhjuh4qJ3flq/wDSvkf3fONBun9XNbWS3CrHBQUoRKNub4oZoGmn0ZHvR+P/3kcJnIIK
 fas8vSqR6ORkyKU00JbB2YejcRx0U6zWMC8C8u2aLpUUd+Sil3qR5scfZPObQOBOMJtXz3Sm
 k8/aAO+3upeTuRtE2P/XPyaEtofgY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Aug 2023 09:37:40 +0200
Subject: [PATCH 5/7] y2038: lib/cobalt: Add additional time64_t related
 function wrappers
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-florian-y2038-2-v1-5-d1cfe2f394a3@siemens.com>
References: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

When requesting y2038 support from recent glibc versions some
preprocessor magic will happen. clock_nanosleep will be replaced by
__clock_nanosleep_time64 for example.

To fix up the necessary function wrapping that we need on linker level
we have to wrap all the necessary glibc symbols/functions again.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 configure.ac                            |  16 ++-
 lib/cobalt/Makefile.am                  |   7 ++
 lib/cobalt/cobalt-glibc-time64.wrappers |  23 ++++
 lib/cobalt/wrappers-time64.c            | 203 ++++++++++++++++++++++++++++++++
 scripts/xeno-config-cobalt.in           |   5 +
 5 files changed, 251 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index dade7e9d7..d6737a09f 100644
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
diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 3159695b3..436399f21 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -38,6 +38,11 @@ libcobalt_la_SOURCES =		\
 	umm.c			\
 	wrappers.c
 
+if CONFIG_XENO_LIBS_TIME64
+libcobalt_la_SOURCES +=         \
+	wrappers-time64.c
+endif
+
 libcobalt_la_CPPFLAGS =			\
 	@XENO_COBALT_CFLAGS@		\
 	-I$(top_srcdir)/include/cobalt	\
@@ -59,10 +64,12 @@ AM_LIBTOOLFLAGS = --silent
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
diff --git a/lib/cobalt/wrappers-time64.c b/lib/cobalt/wrappers-time64.c
new file mode 100644
index 000000000..4a3ac44dc
--- /dev/null
+++ b/lib/cobalt/wrappers-time64.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: LGPL-2.0-or-later
+/*
+ * Copyright (c) Siemens AG 2023
+ *
+ * Authors:
+ *  Florian Bezdeka <florian.bezdeka@siemens.com>
+ */
+#include <asm/xenomai/syscall.h>
+#include <cobalt/mqueue.h>
+#include <cobalt/pthread.h>
+#include <cobalt/semaphore.h>
+#include <cobalt/signal.h>
+#include <cobalt/sys/ioctl.h>
+#include <cobalt/sys/select.h>
+#include <cobalt/sys/socket.h>
+#include <cobalt/sys/time.h>
+#include <cobalt/sys/timerfd.h>
+
+#include <errno.h>
+#include <time.h>
+#include <stdarg.h>
+
+COBALT_IMPL(int, __sem_timedwait64,
+	    (sem_t *sem, const struct timespec *abs_timeout))
+{
+	return __WRAP(sem_timedwait(sem, abs_timeout));
+}
+
+COBALT_IMPL(int, __clock_gettime64, (clockid_t clock_id, struct timespec *tp))
+{
+	return __WRAP(clock_gettime(clock_id, tp));
+}
+
+COBALT_IMPL(int, __clock_settime64,
+	    (clockid_t clock_id, const struct timespec *tp))
+{
+	return __WRAP(clock_settime(clock_id, tp));
+}
+
+COBALT_IMPL(int, __clock_nanosleep_time64,
+	    (clockid_t clock_id, int flags, const struct timespec *rqtp,
+	     struct timespec *rmtp))
+{
+	return __WRAP(clock_nanosleep(clock_id, flags, rqtp, rmtp));
+}
+
+COBALT_IMPL(int, __clock_getres64, (clockid_t clock_id, struct timespec *tp))
+{
+	return __WRAP(clock_getres(clock_id, tp));
+}
+
+COBALT_IMPL(int, __clock_adjtime64, (clockid_t clock_id, struct timex *tx))
+{
+	return __WRAP(clock_adjtime(clock_id, tx));
+}
+
+COBALT_IMPL(int, __pthread_mutex_timedlock64,
+	    (pthread_mutex_t *mutex, const struct timespec *to))
+{
+	return __WRAP(pthread_mutex_timedlock(mutex, to));
+}
+
+COBALT_IMPL(int, __mq_timedsend_time64,
+	    (mqd_t q, const char *buffer, size_t len, unsigned int prio,
+	     const struct timespec *timeout))
+{
+	return __WRAP(mq_timedsend(q, buffer, len, prio, timeout));
+}
+
+COBALT_IMPL(ssize_t, __mq_timedreceive_time64,
+	    (mqd_t q, char *__restrict__ buffer, size_t len,
+	     unsigned *__restrict__ prio,
+	     const struct timespec *__restrict__ timeout))
+{
+	return __WRAP(mq_timedreceive(q, buffer, len, prio, timeout));
+}
+
+COBALT_IMPL(int, __sigtimedwait64,
+	    (const sigset_t *set, siginfo_t *si,
+	     const struct timespec *timeout))
+{
+	return __WRAP(sigtimedwait(set, si, timeout));
+}
+
+COBALT_IMPL(int, __recvmmsg64,
+	    (int fd, struct mmsghdr *msgvec, unsigned int vlen,
+	     unsigned int flags, struct timespec *timeout))
+{
+	return __WRAP(recvmmsg(fd, msgvec, vlen, flags, timeout));
+}
+
+COBALT_IMPL(int, __pthread_cond_timedwait64,
+	    (pthread_cond_t *cond, pthread_mutex_t *mutex,
+	     const struct timespec *abstime))
+{
+	return __WRAP(pthread_cond_timedwait(cond, mutex, abstime));
+}
+
+COBALT_IMPL(int, __timer_settime64,
+	    (timer_t timerid, int flags,
+	     const struct itimerspec *__restrict__ value,
+	     struct itimerspec *__restrict__ ovalue))
+{
+	return __WRAP(timer_settime(timerid, flags, value, ovalue));
+}
+
+COBALT_IMPL(int, __timer_gettime64, (timer_t timerid, struct itimerspec *value))
+{
+	return __WRAP(timer_gettime(timerid, value));
+}
+
+COBALT_IMPL(int, __timerfd_settime64,
+	    (int fd, int flags, const struct itimerspec *new_value,
+	     struct itimerspec *old_value))
+{
+	return __WRAP(timerfd_settime(fd, flags, new_value, old_value));
+}
+
+COBALT_IMPL(int, __timerfd_gettime64, (int fd, struct itimerspec *curr_value))
+{
+	return __WRAP(timerfd_gettime(fd, curr_value));
+}
+
+COBALT_IMPL(int, __getsockopt64,
+	    (int fd, int level, int optname, void *optval, socklen_t *optlen))
+{
+	return __WRAP(getsockopt(fd, level, optname, optval, optlen));
+}
+
+COBALT_IMPL(int, __setsockopt64,
+	    (int fd, int level, int optname, const void *optval,
+	     socklen_t optlen))
+{
+	return __WRAP(setsockopt(fd, level, optname, optval, optlen));
+}
+
+COBALT_IMPL(int, __ioctl_time64, (int fd, unsigned int request, ...))
+{
+	va_list ap;
+	void *arg;
+
+	va_start(ap, request);
+	arg = va_arg(ap, void *);
+	va_end(ap);
+
+	return __WRAP(ioctl(fd, request, arg));
+}
+
+/*
+ * The y2038 wrapper for select() is a little different:
+ * There is no y2038 safe syscall for select() itself, but we have pselect()
+ * without signal support.
+ */
+COBALT_IMPL(int, __select64,
+	    (int __nfds, fd_set *__restrict __readfds,
+	     fd_set *__restrict __writefds, fd_set *__restrict __exceptfds,
+	     struct timeval *__restrict __timeout))
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
+
+COBALT_IMPL(int, __gettimeofday64, (struct timeval *tv, struct timezone *tz))
+{
+	return __WRAP(gettimeofday(tv, tz));
+}
+
+COBALT_IMPL(time_t, __time64, (time_t *t))
+{
+	return __WRAP(time(t));
+}
+
+COBALT_IMPL(int, __nanosleep64,
+	    (const struct timespec *rqtp, struct timespec *rmtp))
+{
+	return __WRAP(nanosleep(rqtp, rmtp));
+}
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

