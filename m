Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5038F8C
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 14:00:53 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230927135042b7d462d19a24ad40b4
        for <xenomai@lists.linux.dev>;
        Wed, 27 Sep 2023 15:50:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=k3N1s6gjDrjmSZe38eSTaUOCDh5HJbDa+08aDuz2ehQ=;
 b=VEhMAyRE2bm7hECNBGrMN1t+7dhkfyf+6uzo9jAN+lHXxn1cO61YkU0cBDunhXuH2YqFmS
 1+3pwHFA/IgWkMeembe7Uzl+JfbvYfXK2qni4wJAozPbaG4/eG1S2sYTwiuA2jFJJT+6qxgB
 ZqYtibUid+sNPez6rIkDnYhtqAcHo=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 27 Sep 2023 15:50:18 +0200
Subject: [PATCH v2 5/9] y2038: lib/cobalt: Split function name and
 interface in COBALT_DECL()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-florian-y2038-2-v2-5-05f710464d83@siemens.com>
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This is a preparation step for the following introduction of
COBALT_DECL_TIME64().

We can now re-use the COBALT_DECL() macro when function name (FN) and
the signature / interface (I) are split into different parameters.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/fcntl.h       | 10 +++---
 include/cobalt/mqueue.h      | 49 +++++++++++-----------------
 include/cobalt/pthread.h     | 77 +++++++++++++++++++++-----------------------
 include/cobalt/sched.h       | 12 +++----
 include/cobalt/semaphore.h   | 24 +++++++-------
 include/cobalt/signal.h      | 16 ++++-----
 include/cobalt/stdio.h       | 33 +++++++++----------
 include/cobalt/stdlib.h      |  4 +--
 include/cobalt/sys/ioctl.h   |  2 +-
 include/cobalt/sys/mman.h    | 10 +++---
 include/cobalt/sys/select.h  |  8 ++---
 include/cobalt/sys/socket.h  | 69 +++++++++++++++++++--------------------
 include/cobalt/sys/time.h    |  3 +-
 include/cobalt/sys/timerfd.h | 10 +++---
 include/cobalt/syslog.h      | 12 +++----
 include/cobalt/time.h        | 46 ++++++++++++--------------
 include/cobalt/unistd.h      | 10 +++---
 include/cobalt/wrappers.h    |  8 ++---
 18 files changed, 188 insertions(+), 215 deletions(-)

diff --git a/include/cobalt/fcntl.h b/include/cobalt/fcntl.h
index f1052c28d..69fd77b0d 100644
--- a/include/cobalt/fcntl.h
+++ b/include/cobalt/fcntl.h
@@ -27,15 +27,15 @@
 extern "C" {
 #endif
 
-COBALT_DECL(int, open(const char *path, int oflag, ...));
+COBALT_DECL(int, open, (const char *path, int oflag, ...));
 
-COBALT_DECL(int, open64(const char *path, int oflag, ...));
+COBALT_DECL(int, open64, (const char *path, int oflag, ...));
 
-COBALT_DECL(int, __open_2(const char *path, int oflag));
+COBALT_DECL(int, __open_2, (const char *path, int oflag));
 
-COBALT_DECL(int, __open64_2(const char *path, int oflag));
+COBALT_DECL(int, __open64_2, (const char *path, int oflag));
 
-COBALT_DECL(int, fcntl(int fd, int cmd, ...));
+COBALT_DECL(int, fcntl, (int fd, int cmd, ...));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/mqueue.h b/include/cobalt/mqueue.h
index 496632dea..c33baf649 100644
--- a/include/cobalt/mqueue.h
+++ b/include/cobalt/mqueue.h
@@ -27,45 +27,34 @@
 extern "C" {
 #endif
 
-COBALT_DECL(mqd_t, mq_open(const char *name,
-			   int oflags,
-			   ...));
+COBALT_DECL(mqd_t, mq_open, (const char *name, int oflags, ...));
 
-COBALT_DECL(int, mq_close(mqd_t qd));
+COBALT_DECL(int, mq_close, (mqd_t qd));
 
-COBALT_DECL(int, mq_unlink(const char *name));
+COBALT_DECL(int, mq_unlink, (const char *name));
 
-COBALT_DECL(int, mq_getattr(mqd_t qd,
-			    struct mq_attr *attr));
+COBALT_DECL(int, mq_getattr, (mqd_t qd, struct mq_attr *attr));
 
-COBALT_DECL(int, mq_setattr(mqd_t qd,
-			    const struct mq_attr *__restrict__ attr,
-			    struct mq_attr *__restrict__ oattr));
+COBALT_DECL(int, mq_setattr,
+	    (mqd_t qd, const struct mq_attr *__restrict__ attr,
+	     struct mq_attr *__restrict__ oattr));
 
-COBALT_DECL(int, mq_send(mqd_t qd,
-			 const char *buffer,
-			 size_t len,
-			 unsigned prio));
+COBALT_DECL(int, mq_send,
+	    (mqd_t qd, const char *buffer, size_t len, unsigned prio));
 
-COBALT_DECL(int, mq_timedsend(mqd_t q,
-			      const char * buffer,
-			      size_t len,
-			      unsigned prio,
-			      const struct timespec *timeout));
+COBALT_DECL(int, mq_timedsend,
+	    (mqd_t q, const char *buffer, size_t len, unsigned prio,
+	     const struct timespec *timeout));
 
-COBALT_DECL(ssize_t, mq_receive(mqd_t q,
-				char *buffer,
-				size_t len,
-				unsigned *prio));
+COBALT_DECL(ssize_t, mq_receive,
+	    (mqd_t q, char *buffer, size_t len, unsigned *prio));
 
-COBALT_DECL(ssize_t, mq_timedreceive(mqd_t q,
-				     char *__restrict__ buffer,
-				     size_t len,
-				     unsigned *__restrict__ prio,
-				     const struct timespec *__restrict__ timeout));
+COBALT_DECL(ssize_t, mq_timedreceive,
+	    (mqd_t q, char *__restrict__ buffer, size_t len,
+	     unsigned *__restrict__ prio,
+	     const struct timespec *__restrict__ timeout));
 
-COBALT_DECL(int, mq_notify(mqd_t q,
-			   const struct sigevent *evp));
+COBALT_DECL(int, mq_notify, (mqd_t q, const struct sigevent *evp));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
index 3e9bd4705..4585dd409 100644
--- a/include/cobalt/pthread.h
+++ b/include/cobalt/pthread.h
@@ -38,63 +38,60 @@ typedef struct pthread_attr_ex {
 extern "C" {
 #endif
 
-COBALT_DECL(int, pthread_attr_init(pthread_attr_t *attr));
+COBALT_DECL(int, pthread_attr_init, (pthread_attr_t *attr));
 
-COBALT_DECL(int, pthread_create(pthread_t *ptid_r,
-				const pthread_attr_t *attr,
-				void *(*start) (void *),
-				void *arg));
+COBALT_DECL(int, pthread_create,
+	    (pthread_t *ptid_r, const pthread_attr_t *attr,
+	     void *(*start)(void *), void *arg));
 
-COBALT_DECL(int, pthread_getschedparam(pthread_t thread,
-				       int *policy,
-				       struct sched_param *param));
+COBALT_DECL(int, pthread_getschedparam,
+	    (pthread_t thread, int *policy, struct sched_param *param));
 
-COBALT_DECL(int, pthread_setschedparam(pthread_t thread,
-				       int policy,
-				       const struct sched_param *param));
+COBALT_DECL(int, pthread_setschedparam,
+	    (pthread_t thread, int policy, const struct sched_param *param));
 
-COBALT_DECL(int, pthread_setschedprio(pthread_t thread, int prio));
+COBALT_DECL(int, pthread_setschedprio, (pthread_t thread, int prio));
 
-COBALT_DECL(int, pthread_mutex_init(pthread_mutex_t *mutex,
-				    const pthread_mutexattr_t *attr));
+COBALT_DECL(int, pthread_mutex_init,
+	    (pthread_mutex_t *mutex, const pthread_mutexattr_t *attr));
 
-COBALT_DECL(int, pthread_mutex_destroy(pthread_mutex_t *mutex));
+COBALT_DECL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex));
 
-COBALT_DECL(int, pthread_mutex_lock(pthread_mutex_t *mutex));
+COBALT_DECL(int, pthread_mutex_lock, (pthread_mutex_t *mutex));
 
-COBALT_DECL(int, pthread_mutex_timedlock(pthread_mutex_t *mutex,
-					 const struct timespec *to));
+COBALT_DECL(int, pthread_mutex_timedlock,
+	    (pthread_mutex_t *mutex, const struct timespec *to));
 
-COBALT_DECL(int, pthread_mutex_trylock(pthread_mutex_t *mutex));
+COBALT_DECL(int, pthread_mutex_trylock, (pthread_mutex_t *mutex));
 
-COBALT_DECL(int, pthread_mutex_unlock(pthread_mutex_t *mutex));
+COBALT_DECL(int, pthread_mutex_unlock, (pthread_mutex_t *mutex));
 
-COBALT_DECL(int, pthread_mutex_setprioceiling(pthread_mutex_t *__restrict mutex,
-					      int prioceiling,
-					      int *__restrict old_ceiling));
-  
-COBALT_DECL(int, pthread_mutex_getprioceiling(pthread_mutex_t *__restrict mutex,
-					      int *__restrict old_ceiling));
+COBALT_DECL(int, pthread_mutex_setprioceiling,
+	    (pthread_mutex_t *__restrict mutex, int prioceiling,
+	     int *__restrict old_ceiling));
 
-COBALT_DECL(int, pthread_cond_init (pthread_cond_t *cond,
-				    const pthread_condattr_t *attr));
+COBALT_DECL(int, pthread_mutex_getprioceiling,
+	    (pthread_mutex_t *__restrict mutex, int *__restrict old_ceiling));
 
-COBALT_DECL(int, pthread_cond_destroy(pthread_cond_t *cond));
+COBALT_DECL(int, pthread_cond_init,
+	    (pthread_cond_t *cond, const pthread_condattr_t *attr));
 
-COBALT_DECL(int, pthread_cond_wait(pthread_cond_t *cond,
-				   pthread_mutex_t *mutex));
+COBALT_DECL(int, pthread_cond_destroy, (pthread_cond_t *cond));
 
-COBALT_DECL(int, pthread_cond_timedwait(pthread_cond_t *cond,
-					pthread_mutex_t *mutex,
-					const struct timespec *abstime));
+COBALT_DECL(int, pthread_cond_wait,
+	    (pthread_cond_t *cond, pthread_mutex_t *mutex));
 
-COBALT_DECL(int, pthread_cond_signal(pthread_cond_t *cond));
+COBALT_DECL(int, pthread_cond_timedwait,
+	    (pthread_cond_t *cond, pthread_mutex_t *mutex,
+	     const struct timespec *abstime));
 
-COBALT_DECL(int, pthread_cond_broadcast(pthread_cond_t *cond));
+COBALT_DECL(int, pthread_cond_signal, (pthread_cond_t *cond));
 
-COBALT_DECL(int, pthread_kill(pthread_t ptid, int sig));
+COBALT_DECL(int, pthread_cond_broadcast, (pthread_cond_t *cond));
 
-COBALT_DECL(int, pthread_join(pthread_t ptid, void **retval));
+COBALT_DECL(int, pthread_kill, (pthread_t ptid, int sig));
+
+COBALT_DECL(int, pthread_join, (pthread_t ptid, void **retval));
 
 #ifndef pthread_yield
 /*
@@ -104,13 +101,13 @@ COBALT_DECL(int, pthread_join(pthread_t ptid, void **retval));
  * sched_yield() implementation internally, we can live with this
  * wrapping.
  */
-COBALT_DECL(int, pthread_yield(void));
+COBALT_DECL(int, pthread_yield, (void));
 #endif
 
 int pthread_setmode_np(int clrmask, int setmask,
 		       int *mask_r);
 
-COBALT_DECL(int, pthread_setname_np(pthread_t thread, const char *name));
+COBALT_DECL(int, pthread_setname_np, (pthread_t thread, const char *name));
 
 int pthread_create_ex(pthread_t *ptid_r,
 		      const pthread_attr_ex_t *attr_ex,
diff --git a/include/cobalt/sched.h b/include/cobalt/sched.h
index 7c5b26e77..9889e9aef 100644
--- a/include/cobalt/sched.h
+++ b/include/cobalt/sched.h
@@ -29,16 +29,16 @@
 extern "C" {
 #endif
 
-COBALT_DECL(int, sched_yield(void));
+COBALT_DECL(int, sched_yield, (void));
 
-COBALT_DECL(int, sched_get_priority_min(int policy));
+COBALT_DECL(int, sched_get_priority_min, (int policy));
 
-COBALT_DECL(int, sched_get_priority_max(int policy));
+COBALT_DECL(int, sched_get_priority_max, (int policy));
 
-COBALT_DECL(int, sched_setscheduler(pid_t pid, int policy,
-				    const struct sched_param *param));
+COBALT_DECL(int, sched_setscheduler,
+	    (pid_t pid, int policy, const struct sched_param *param));
 
-COBALT_DECL(int, sched_getscheduler(pid_t pid));
+COBALT_DECL(int, sched_getscheduler, (pid_t pid));
 
 int sched_get_priority_min_ex(int policy);
 
diff --git a/include/cobalt/semaphore.h b/include/cobalt/semaphore.h
index a7714fd34..ed26520ec 100644
--- a/include/cobalt/semaphore.h
+++ b/include/cobalt/semaphore.h
@@ -29,28 +29,26 @@
 extern "C" {
 #endif
 
-COBALT_DECL(int, sem_init(sem_t *sem,
-			  int pshared,
-			  unsigned int value));
+COBALT_DECL(int, sem_init, (sem_t *sem, int pshared, unsigned int value));
 
-COBALT_DECL(int, sem_destroy(sem_t *sem));
+COBALT_DECL(int, sem_destroy, (sem_t *sem));
 
-COBALT_DECL(int, sem_post(sem_t *sem));
+COBALT_DECL(int, sem_post, (sem_t *sem));
 
-COBALT_DECL(int, sem_wait(sem_t *sem));
+COBALT_DECL(int, sem_wait, (sem_t *sem));
 
-COBALT_DECL(int, sem_timedwait(sem_t *sem,
-			       const struct timespec *abs_timeout));
+COBALT_DECL(int, sem_timedwait,
+	    (sem_t *sem, const struct timespec *abs_timeout));
 
-COBALT_DECL(int, sem_trywait(sem_t *sem));
+COBALT_DECL(int, sem_trywait, (sem_t *sem));
 
-COBALT_DECL(int, sem_getvalue(sem_t *sem, int *value));
+COBALT_DECL(int, sem_getvalue, (sem_t *sem, int *value));
 
-COBALT_DECL(sem_t *, sem_open(const char *name, int oflags, ...));
+COBALT_DECL(sem_t *, sem_open, (const char *name, int oflags, ...));
 
-COBALT_DECL(int, sem_close(sem_t *sem));
+COBALT_DECL(int, sem_close, (sem_t *sem));
 
-COBALT_DECL(int, sem_unlink(const char *name));
+COBALT_DECL(int, sem_unlink, (const char *name));
 
 int sem_init_np(sem_t *sem,
 		int flags,
diff --git a/include/cobalt/signal.h b/include/cobalt/signal.h
index 62694f93a..d92ccf2c5 100644
--- a/include/cobalt/signal.h
+++ b/include/cobalt/signal.h
@@ -40,19 +40,19 @@ int cobalt_sigshadow_handler(int sig, siginfo_t *si,
 void cobalt_sigdebug_handler(int sig, siginfo_t *si,
 			     void *context);
 
-COBALT_DECL(int, sigpending(sigset_t *set));
+COBALT_DECL(int, sigpending, (sigset_t *set));
 
-COBALT_DECL(int, sigwait(const sigset_t *set, int *sig));
+COBALT_DECL(int, sigwait, (const sigset_t *set, int *sig));
 
-COBALT_DECL(int, sigwaitinfo(const sigset_t *set, siginfo_t *si));
+COBALT_DECL(int, sigwaitinfo, (const sigset_t *set, siginfo_t *si));
 
-COBALT_DECL(int, sigtimedwait(const sigset_t *set, siginfo_t *si,
-			      const struct timespec *timeout));
+COBALT_DECL(int, sigtimedwait,
+	    (const sigset_t *set, siginfo_t *si,
+	     const struct timespec *timeout));
 
-COBALT_DECL(int, kill(pid_t pid, int sig));
+COBALT_DECL(int, kill, (pid_t pid, int sig));
 
-COBALT_DECL(int, sigqueue(pid_t pid, int sig,
-			  const union sigval value));
+COBALT_DECL(int, sigqueue, (pid_t pid, int sig, const union sigval value));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/stdio.h b/include/cobalt/stdio.h
index 5b9df8006..83121bdbf 100644
--- a/include/cobalt/stdio.h
+++ b/include/cobalt/stdio.h
@@ -31,19 +31,18 @@
 extern "C" {
 #endif /* __cplusplus */
 
-COBALT_DECL(int, vfprintf(FILE *stream, const char *fmt, va_list args));
+COBALT_DECL(int, vfprintf, (FILE *stream, const char *fmt, va_list args));
 
 #ifdef CONFIG_XENO_FORTIFY
 
-COBALT_DECL(int, __vfprintf_chk(FILE *stream, int level,
-				const char *fmt, va_list ap));
+COBALT_DECL(int, __vfprintf_chk,
+	    (FILE *stream, int level, const char *fmt, va_list ap));
 
-COBALT_DECL(int, __vprintf_chk(int flag,
-			       const char *fmt, va_list ap));
+COBALT_DECL(int, __vprintf_chk, (int flag, const char *fmt, va_list ap));
 
-COBALT_DECL(int, __printf_chk(int flag, const char *fmt, ...));
+COBALT_DECL(int, __printf_chk, (int flag, const char *fmt, ...));
 
-COBALT_DECL(int, __fprintf_chk(FILE *fp, int flag, const char *fmt, ...));
+COBALT_DECL(int, __fprintf_chk, (FILE *fp, int flag, const char *fmt, ...));
 
 int __rt_vfprintf_chk(FILE *stream, int level,
 		      const char *fmt, va_list args);
@@ -53,18 +52,18 @@ void __rt_vsyslog_chk(int priority, int level,
 
 #endif	/* CONFIG_XENO_FORTIFY */
 
-COBALT_DECL(int, vprintf(const char *fmt, va_list args));
+COBALT_DECL(int, vprintf, (const char *fmt, va_list args));
 
-COBALT_DECL(int, fprintf(FILE *stream, const char *fmt, ...));
+COBALT_DECL(int, fprintf, (FILE *stream, const char *fmt, ...));
 
-COBALT_DECL(int, printf(const char *fmt, ...));
+COBALT_DECL(int, printf, (const char *fmt, ...));
 
-COBALT_DECL(int, puts(const char *s));
+COBALT_DECL(int, puts, (const char *s));
 
-COBALT_DECL(int, fputs(const char *s, FILE *stream));
+COBALT_DECL(int, fputs, (const char *s, FILE *stream));
 
 #ifndef putchar
-COBALT_DECL(int, putchar(int c));
+COBALT_DECL(int, putchar, (int c));
 #else
 static inline int __real_putchar(int c)
 {
@@ -77,7 +76,7 @@ int __cobalt_putchar(int c);
 #endif
 
 #ifndef fputc
-COBALT_DECL(int, fputc(int c, FILE *stream));
+COBALT_DECL(int, fputc, (int c, FILE *stream));
 #else
 static inline int __real_fputc(int c, FILE *stream)
 {
@@ -89,10 +88,10 @@ int __cobalt_fputc(int c, FILE *stream);
 #define fputc fputc
 #endif
 
-COBALT_DECL(size_t,
-	    fwrite(const void *ptr, size_t sz, size_t nmemb, FILE *stream));
+COBALT_DECL(size_t, fwrite,
+	    (const void *ptr, size_t sz, size_t nmemb, FILE *stream));
 
-COBALT_DECL(int, fclose(FILE *stream));
+COBALT_DECL(int, fclose, (FILE *stream));
 
 int rt_vfprintf(FILE *stream, const char *format, va_list args);
 
diff --git a/include/cobalt/stdlib.h b/include/cobalt/stdlib.h
index 6b664f547..544e383cd 100644
--- a/include/cobalt/stdlib.h
+++ b/include/cobalt/stdlib.h
@@ -29,9 +29,9 @@
 extern "C" {
 #endif /* __cplusplus */
 
-COBALT_DECL(void, free(void *ptr));
+COBALT_DECL(void, free, (void *ptr));
 
-COBALT_DECL(void *, malloc(size_t size));
+COBALT_DECL(void *, malloc, (size_t size));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/sys/ioctl.h b/include/cobalt/sys/ioctl.h
index 553aa566d..ab3189591 100644
--- a/include/cobalt/sys/ioctl.h
+++ b/include/cobalt/sys/ioctl.h
@@ -27,7 +27,7 @@
 extern "C" {
 #endif
 
-COBALT_DECL(int, ioctl(int fildes, unsigned int request, ...));
+COBALT_DECL(int, ioctl, (int fildes, unsigned int request, ...));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
index 75a00da0c..e291f50ef 100644
--- a/include/cobalt/sys/mman.h
+++ b/include/cobalt/sys/mman.h
@@ -28,12 +28,14 @@
 extern "C" {
 #endif
 
-COBALT_DECL(void *, mmap(void *addr, size_t length, int prot, int flags,
-			 int fd, off_t offset));
+COBALT_DECL(void *, mmap,
+	    (void *addr, size_t length, int prot, int flags, int fd,
+	     off_t offset));
 
 #if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
-COBALT_DECL(void *, mmap64(void *addr, size_t length, int prot, int flags,
-			   int fd, off64_t offset));
+COBALT_DECL(void *, mmap64,
+	    (void *addr, size_t length, int prot, int flags, int fd,
+	     off64_t offset));
 #endif
 
 #ifdef __cplusplus
diff --git a/include/cobalt/sys/select.h b/include/cobalt/sys/select.h
index 76e8476bb..e823874f8 100644
--- a/include/cobalt/sys/select.h
+++ b/include/cobalt/sys/select.h
@@ -27,10 +27,10 @@
 extern "C" {
 #endif
 
-COBALT_DECL(int, select(int __nfds, fd_set *__restrict __readfds,
-			fd_set *__restrict __writefds,
-			fd_set *__restrict __exceptfds,
-			struct timeval *__restrict __timeout));
+COBALT_DECL(int, select,
+	    (int __nfds, fd_set *__restrict __readfds,
+	     fd_set *__restrict __writefds, fd_set *__restrict __exceptfds,
+	     struct timeval *__restrict __timeout));
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/cobalt/sys/socket.h b/include/cobalt/sys/socket.h
index 156b49356..af7dcc159 100644
--- a/include/cobalt/sys/socket.h
+++ b/include/cobalt/sys/socket.h
@@ -27,59 +27,56 @@
 extern "C" {
 #endif
 
-COBALT_DECL(int, socket(int protocol_family,
-			int socket_type, int protocol));
+COBALT_DECL(int, socket, (int protocol_family, int socket_type, int protocol));
 
-COBALT_DECL(ssize_t, recvmsg(int fd,
-			     struct msghdr *msg, int flags));
+COBALT_DECL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags));
 
-COBALT_DECL(int, recvmmsg(int fd,
-			  struct mmsghdr *msgvec, unsigned int vlen,
-			  unsigned int flags, struct timespec *timeout));
+COBALT_DECL(int, recvmmsg,
+	    (int fd, struct mmsghdr *msgvec, unsigned int vlen,
+	     unsigned int flags, struct timespec *timeout));
 
-COBALT_DECL(ssize_t, sendmsg(int fd,
-			     const struct msghdr *msg, int flags));
+COBALT_DECL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int flags));
 
-COBALT_DECL(int, sendmmsg(int fd,
-			  struct mmsghdr *msgvec, unsigned int vlen,
-			  unsigned int flags));
+COBALT_DECL(int, sendmmsg,
+	    (int fd, struct mmsghdr *msgvec, unsigned int vlen,
+	     unsigned int flags));
 
-COBALT_DECL(ssize_t, recvfrom(int fd, void *buf, size_t len, int flags,
-			      struct sockaddr *from, socklen_t *fromlen));
+COBALT_DECL(ssize_t, recvfrom,
+	    (int fd, void *buf, size_t len, int flags, struct sockaddr *from,
+	     socklen_t *fromlen));
 
-COBALT_DECL(ssize_t, sendto(int fd, const void *buf, size_t len, int flags,
-			    const struct sockaddr *to, socklen_t tolen));
+COBALT_DECL(ssize_t, sendto,
+	    (int fd, const void *buf, size_t len, int flags,
+	     const struct sockaddr *to, socklen_t tolen));
 
-COBALT_DECL(ssize_t, recv(int fd, void *buf,
-			  size_t len, int flags));
+COBALT_DECL(ssize_t, recv, (int fd, void *buf, size_t len, int flags));
 
-COBALT_DECL(ssize_t, send(int fd, const void *buf,
-			  size_t len, int flags));
+COBALT_DECL(ssize_t, send, (int fd, const void *buf, size_t len, int flags));
 
-COBALT_DECL(int, getsockopt(int fd, int level, int optname,
-			    void *optval, socklen_t *optlen));
+COBALT_DECL(int, getsockopt,
+	    (int fd, int level, int optname, void *optval, socklen_t *optlen));
 
-COBALT_DECL(int, setsockopt(int fd, int level, int optname,
-			    const void *optval, socklen_t optlen));
+COBALT_DECL(int, setsockopt,
+	    (int fd, int level, int optname, const void *optval,
+	     socklen_t optlen));
 
-COBALT_DECL(int, bind(int fd, const struct sockaddr *my_addr,
-		      socklen_t addrlen));
+COBALT_DECL(int, bind,
+	    (int fd, const struct sockaddr *my_addr, socklen_t addrlen));
 
-COBALT_DECL(int, connect(int fd, const struct sockaddr *serv_addr,
-			 socklen_t addrlen));
+COBALT_DECL(int, connect,
+	    (int fd, const struct sockaddr *serv_addr, socklen_t addrlen));
 
-COBALT_DECL(int, listen(int fd, int backlog));
+COBALT_DECL(int, listen, (int fd, int backlog));
 
-COBALT_DECL(int, accept(int fd, struct sockaddr *addr,
-			socklen_t *addrlen));
+COBALT_DECL(int, accept, (int fd, struct sockaddr *addr, socklen_t *addrlen));
 
-COBALT_DECL(int, getsockname(int fd, struct sockaddr *name,
-			     socklen_t *namelen));
+COBALT_DECL(int, getsockname,
+	    (int fd, struct sockaddr *name, socklen_t *namelen));
 
-COBALT_DECL(int, getpeername(int fd, struct sockaddr *name,
-			     socklen_t *namelen));
+COBALT_DECL(int, getpeername,
+	    (int fd, struct sockaddr *name, socklen_t *namelen));
 
-COBALT_DECL(int, shutdown(int fd, int how));
+COBALT_DECL(int, shutdown, (int fd, int how));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/sys/time.h b/include/cobalt/sys/time.h
index 38f5a34b6..b27dec815 100644
--- a/include/cobalt/sys/time.h
+++ b/include/cobalt/sys/time.h
@@ -29,8 +29,7 @@ struct timezone;
 extern "C" {
 #endif
 
-COBALT_DECL(int, gettimeofday(struct timeval *tv,
-			      struct timezone *tz));
+COBALT_DECL(int, gettimeofday, (struct timeval *tv, struct timezone *tz));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/sys/timerfd.h b/include/cobalt/sys/timerfd.h
index a7df836e6..6649a19e0 100644
--- a/include/cobalt/sys/timerfd.h
+++ b/include/cobalt/sys/timerfd.h
@@ -27,13 +27,13 @@
 extern "C" {
 #endif /* __cplusplus */
 
-COBALT_DECL(int, timerfd_create(int clockid, int flags));
+COBALT_DECL(int, timerfd_create, (int clockid, int flags));
 
-COBALT_DECL(int, timerfd_settime(int fd, int flags,
-		const struct itimerspec *new_value,
-		struct itimerspec *old_value));
+COBALT_DECL(int, timerfd_settime,
+	    (int fd, int flags, const struct itimerspec *new_value,
+	     struct itimerspec *old_value));
 
-COBALT_DECL(int, timerfd_gettime(int fd, struct itimerspec *curr_value));
+COBALT_DECL(int, timerfd_gettime, (int fd, struct itimerspec *curr_value));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/syslog.h b/include/cobalt/syslog.h
index 236c8a219..c677edec5 100644
--- a/include/cobalt/syslog.h
+++ b/include/cobalt/syslog.h
@@ -29,18 +29,16 @@
 extern "C" {
 #endif /* __cplusplus */
 
-COBALT_DECL(void, syslog(int priority, const char *fmt, ...));
+COBALT_DECL(void, syslog, (int priority, const char *fmt, ...));
 
-COBALT_DECL(void, vsyslog(int priority,
-			  const char *fmt, va_list ap));
+COBALT_DECL(void, vsyslog, (int priority, const char *fmt, va_list ap));
 
 #ifdef CONFIG_XENO_FORTIFY
 
-COBALT_DECL(void, __vsyslog_chk(int priority, int level,
-				const char *fmt, va_list ap));
+COBALT_DECL(void, __vsyslog_chk,
+	    (int priority, int level, const char *fmt, va_list ap));
 
-COBALT_DECL(void, __syslog_chk(int pri, int flag,
-			       const char *fmt, ...));
+COBALT_DECL(void, __syslog_chk, (int pri, int flag, const char *fmt, ...));
 
 #endif /* CONFIG_XENO_FORTIFY */
 
diff --git a/include/cobalt/time.h b/include/cobalt/time.h
index e3f355c61..006a0ae03 100644
--- a/include/cobalt/time.h
+++ b/include/cobalt/time.h
@@ -32,43 +32,37 @@ extern "C" {
 
 struct timex;
 
-COBALT_DECL(int, clock_getres(clockid_t clock_id,
-			      struct timespec *tp));
+COBALT_DECL(int, clock_getres, (clockid_t clock_id, struct timespec *tp));
 
-COBALT_DECL(int, clock_gettime(clockid_t clock_id,
-			       struct timespec *tp));
+COBALT_DECL(int, clock_gettime, (clockid_t clock_id, struct timespec *tp));
 
-COBALT_DECL(int, clock_settime(clockid_t clock_id,
-			       const struct timespec *tp));
+COBALT_DECL(int, clock_settime,
+	    (clockid_t clock_id, const struct timespec *tp));
 
-COBALT_DECL(int, clock_adjtime(clockid_t clock_id,
-			       struct timex *tx));
+COBALT_DECL(int, clock_adjtime, (clockid_t clock_id, struct timex *tx));
 
-COBALT_DECL(int, clock_nanosleep(clockid_t clock_id,
-				 int flags,
-				 const struct timespec *rqtp,
-				 struct timespec *rmtp));
+COBALT_DECL(int, clock_nanosleep,
+	    (clockid_t clock_id, int flags, const struct timespec *rqtp,
+	     struct timespec *rmtp));
 
-COBALT_DECL(time_t, time(time_t *t));
+COBALT_DECL(time_t, time, (time_t *t));
 
-COBALT_DECL(int, nanosleep(const struct timespec *rqtp,
-			   struct timespec *rmtp));
+COBALT_DECL(int, nanosleep,
+	    (const struct timespec *rqtp, struct timespec *rmtp));
 
-COBALT_DECL(int, timer_create(clockid_t clockid,
-			      const struct sigevent *__restrict__ evp,
-			      timer_t * __restrict__ timerid));
+COBALT_DECL(int, timer_create,
+	    (clockid_t clockid, const struct sigevent *__restrict__ evp,
+	     timer_t *__restrict__ timerid));
 
-COBALT_DECL(int, timer_delete(timer_t timerid));
+COBALT_DECL(int, timer_delete, (timer_t timerid));
 
-COBALT_DECL(int, timer_settime(timer_t timerid,
-			       int flags,
-			       const struct itimerspec *value,
-			       struct itimerspec *ovalue));
+COBALT_DECL(int, timer_settime,
+	    (timer_t timerid, int flags, const struct itimerspec *value,
+	     struct itimerspec *ovalue));
 
-COBALT_DECL(int, timer_gettime(timer_t timerid,
-			       struct itimerspec *value));
+COBALT_DECL(int, timer_gettime, (timer_t timerid, struct itimerspec *value));
 
-COBALT_DECL(int, timer_getoverrun(timer_t timerid));
+COBALT_DECL(int, timer_getoverrun, (timer_t timerid));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/unistd.h b/include/cobalt/unistd.h
index fe3992af6..ae3988558 100644
--- a/include/cobalt/unistd.h
+++ b/include/cobalt/unistd.h
@@ -27,15 +27,15 @@
 extern "C" {
 #endif
 
-COBALT_DECL(ssize_t, read(int fd, void *buf, size_t nbyte));
+COBALT_DECL(ssize_t, read, (int fd, void *buf, size_t nbyte));
 
-COBALT_DECL(ssize_t, write(int fd, const void *buf, size_t nbyte));
+COBALT_DECL(ssize_t, write, (int fd, const void *buf, size_t nbyte));
 
-COBALT_DECL(int, close(int fildes));
+COBALT_DECL(int, close, (int fildes));
 
-COBALT_DECL(unsigned int, sleep(unsigned int seconds));
+COBALT_DECL(unsigned int, sleep, (unsigned int seconds));
 
-COBALT_DECL(int, usleep(useconds_t usec));
+COBALT_DECL(int, usleep, (useconds_t usec));
 
 #ifdef __cplusplus
 }
diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index 7e061caf9..aaa581db4 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -27,10 +27,10 @@
 #define __STD(call)		__real_ ## call
 #define __COBALT(call)		__cobalt_ ## call
 #define __RT(call)		__COBALT(call)
-#define COBALT_DECL(T, P)	\
-	__typeof__(T) __RT(P);	\
-	__typeof__(T) __STD(P); \
-	__typeof__(T) __WRAP(P)
+#define COBALT_DECL(T, FN, I)                                                  \
+	__typeof__(T) __RT(FN) I;                                              \
+	__typeof__(T) __STD(FN) I;                                             \
+	__typeof__(T) __WRAP(FN) I
 
 /*
  * 

-- 
2.39.2

