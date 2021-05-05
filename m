From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 3/9] cobalt/kernel: y2038: convert struct itimerspec to
 itimerspec64
Date: Wed,  5 May 2021 18:53:02 +0200
Message-Id: <3efca583d1ce9695a2adabb9c9829233aab873ad.1620233588.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620233588.git.jan.kiszka@siemens.com>
References: <cover.1620233588.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

As internal interfaces are gradually being made y2038-safe, the
itimerspec64 type should be used internally by the kernel to represent
interval timer specs. Apply the same reasoning to Cobalt.

We still use a legacy y2038-unsafe itimerspec type at the
kernel<->user interface boundary (struct __user_old_itimerspec) until
libcobalt is y2038-safe.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/compat.h                |  4 +-
 include/cobalt/uapi/kernel/types.h            |  5 ++
 .../include/asm-generic/xenomai/syscall.h     | 47 ++++++++++++++++++-
 kernel/cobalt/posix/compat.c                  |  4 +-
 kernel/cobalt/posix/extension.h               |  4 +-
 kernel/cobalt/posix/syscall32.c               |  8 ++--
 kernel/cobalt/posix/timer.c                   | 30 ++++++------
 kernel/cobalt/posix/timer.h                   | 16 +++----
 kernel/cobalt/posix/timerfd.c                 | 22 ++++-----
 kernel/cobalt/posix/timerfd.h                 | 12 ++---
 10 files changed, 101 insertions(+), 51 deletions(-)

diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
index c57ef65325..7bec8c3be5 100644
--- a/include/cobalt/kernel/compat.h
+++ b/include/cobalt/kernel/compat.h
@@ -92,11 +92,11 @@ int sys32_get_timespec(struct timespec64 *ts,
 int sys32_put_timespec(struct compat_timespec __user *cts,
 		       const struct timespec64 *ts);
 
-int sys32_get_itimerspec(struct itimerspec *its,
+int sys32_get_itimerspec(struct itimerspec64 *its,
 			 const struct compat_itimerspec __user *cits);
 
 int sys32_put_itimerspec(struct compat_itimerspec __user *cits,
-			 const struct itimerspec *its);
+			 const struct itimerspec64 *its);
 
 int sys32_get_timeval(struct __kernel_old_timeval *tv,
 		      const struct compat_timeval __user *ctv);
diff --git a/include/cobalt/uapi/kernel/types.h b/include/cobalt/uapi/kernel/types.h
index 8ce9b03df4..10abbb55a5 100644
--- a/include/cobalt/uapi/kernel/types.h
+++ b/include/cobalt/uapi/kernel/types.h
@@ -67,4 +67,9 @@ struct __user_old_timespec {
 	long  tv_nsec;
 };
 
+struct __user_old_itimerspec {
+	struct __user_old_timespec it_interval;
+	struct __user_old_timespec it_value;
+};
+
 #endif /* !_COBALT_UAPI_KERNEL_TYPES_H */
diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index 05a7d28685..91bbf3bfd1 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -86,7 +86,7 @@ static inline int cobalt_strncpy_from_user(char *dst, const char __user *src,
 
 /*
  * NOTE: those copy helpers won't work in compat mode: use
- * sys32_get_timespec(), sys32_put_timespec() instead.
+ * sys32_get_*(), sys32_put_*() instead.
  */
 
 static inline int cobalt_get_u_timespec(struct timespec64 *dst,
@@ -102,6 +102,19 @@ static inline int cobalt_put_u_timespec(
 	return cobalt_copy_to_user(dst, src, sizeof(*dst));
 }
 
+static inline int cobalt_get_u_itimerspec(struct itimerspec64 *dst,
+			const struct __user_old_itimerspec __user *src)
+{
+	return cobalt_copy_from_user(dst, src, sizeof(*dst));
+}
+
+static inline int cobalt_put_u_itimerspec(
+	struct __user_old_itimerspec __user *dst,
+	const struct itimerspec64 *src)
+{
+	return cobalt_copy_to_user(dst, src, sizeof(*dst));
+}
+
 #else /* __BITS_PER_LONG == 32 */
 
 static inline int cobalt_get_u_timespec(struct timespec64 *dst,
@@ -137,6 +150,38 @@ static inline int cobalt_put_u_timespec(
 	return 0;
 }
 
+static inline int cobalt_get_u_itimerspec(struct itimerspec64 *dst,
+			const struct __user_old_itimerspec __user *src)
+{
+	struct __user_old_itimerspec u_its;
+	int ret;
+
+	ret = cobalt_copy_from_user(&u_its, src, sizeof(u_its));
+	if (ret)
+		return ret;
+
+	dst->it_interval.tv_sec = u_its.it_interval.tv_sec;
+	dst->it_interval.tv_nsec = u_its.it_interval.tv_nsec;
+	dst->it_value.tv_sec = u_its.it_value.tv_sec;
+	dst->it_value.tv_nsec = u_its.it_value.tv_nsec;
+
+	return 0;
+}
+
+static inline int cobalt_put_u_itimerspec(
+	struct __user_old_itimerspec __user *dst,
+	const struct itimerspec64 *src)
+{
+	struct __user_old_itimerspec u_its;
+
+	u_its.it_interval.tv_sec = src->it_interval.tv_sec;
+	u_its.it_interval.tv_nsec = src->it_interval.tv_nsec;
+	u_its.it_value.tv_sec = src->it_value.tv_sec;
+	u_its.it_value.tv_nsec = src->it_value.tv_nsec;
+
+	return cobalt_copy_to_user(dst, &u_its, sizeof(*dst));
+}
+
 #endif
 
 /* 32bit syscall emulation */
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index 1852950821..767a8033a6 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -60,7 +60,7 @@ int sys32_put_timespec(struct compat_timespec __user *u_cts,
 }
 EXPORT_SYMBOL_GPL(sys32_put_timespec);
 
-int sys32_get_itimerspec(struct itimerspec *its,
+int sys32_get_itimerspec(struct itimerspec64 *its,
 			 const struct compat_itimerspec __user *cits)
 {
 	int ret = sys32_get_timespec(&its->it_value, &cits->it_value);
@@ -70,7 +70,7 @@ int sys32_get_itimerspec(struct itimerspec *its,
 EXPORT_SYMBOL_GPL(sys32_get_itimerspec);
 
 int sys32_put_itimerspec(struct compat_itimerspec __user *cits,
-			 const struct itimerspec *its)
+			 const struct itimerspec64 *its)
 {
 	int ret = sys32_put_timespec(&cits->it_value, &its->it_value);
 
diff --git a/kernel/cobalt/posix/extension.h b/kernel/cobalt/posix/extension.h
index ae365c7874..e23c26ccca 100644
--- a/kernel/cobalt/posix/extension.h
+++ b/kernel/cobalt/posix/extension.h
@@ -39,10 +39,10 @@ struct cobalt_extension {
 		(*timer_init)(struct cobalt_extref *reftimer, /* nklocked, IRQs off. */
 			      const struct sigevent *__restrict__ evp);
 		int (*timer_settime)(struct cobalt_extref *reftimer, /* nklocked, IRQs off. */
-				     const struct itimerspec *__restrict__ value,
+				     const struct itimerspec64 *__restrict__ value,
 				     int flags);
 		int (*timer_gettime)(struct cobalt_extref *reftimer, /* nklocked, IRQs off. */
-				     struct itimerspec *__restrict__ value);
+				     struct itimerspec64 *__restrict__ value);
 		int (*timer_delete)(struct cobalt_extref *reftimer); /* nklocked, IRQs off. */
 		int (*timer_cleanup)(struct cobalt_extref *reftimer); /* nklocked, IRQs off. */
 		int (*signal_deliver)(struct cobalt_extref *refthread,
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index ae25a6e743..5c858806b6 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -514,7 +514,7 @@ COBALT_SYSCALL32emu(timer_settime, primary,
 		     const struct compat_itimerspec __user *u_newval,
 		     struct compat_itimerspec __user *u_oldval))
 {
-	struct itimerspec newv, oldv, *oldvp = &oldv;
+	struct itimerspec64 newv, oldv, *oldvp = &oldv;
 	int ret;
 
 	if (u_oldval == NULL)
@@ -540,7 +540,7 @@ COBALT_SYSCALL32emu(timer_settime, primary,
 COBALT_SYSCALL32emu(timer_gettime, current,
 		    (timer_t tm, struct compat_itimerspec __user *u_val))
 {
-	struct itimerspec val;
+	struct itimerspec64 val;
 	int ret;
 
 	ret = __cobalt_timer_gettime(tm, &val);
@@ -553,7 +553,7 @@ COBALT_SYSCALL32emu(timerfd_settime, primary,
 		     const struct compat_itimerspec __user *new_value,
 		     struct compat_itimerspec __user *old_value))
 {
-	struct itimerspec ovalue, value;
+	struct itimerspec64 ovalue, value;
 	int ret;
 
 	ret = sys32_get_itimerspec(&value, new_value);
@@ -577,7 +577,7 @@ COBALT_SYSCALL32emu(timerfd_settime, primary,
 COBALT_SYSCALL32emu(timerfd_gettime, current,
 		    (int fd, struct compat_itimerspec __user *curr_value))
 {
-	struct itimerspec value;
+	struct itimerspec64 value;
 	int ret;
 
 	ret = __cobalt_timerfd_gettime(fd, &value);
diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
index 3aca90de9f..a58ea99a36 100644
--- a/kernel/cobalt/posix/timer.c
+++ b/kernel/cobalt/posix/timer.c
@@ -261,7 +261,7 @@ out:
 }
 
 void __cobalt_timer_getval(struct xntimer *__restrict__ timer,
-			   struct itimerspec *__restrict__ value)
+			   struct itimerspec64 *__restrict__ value)
 {
 	ns2ts(&value->it_interval, xntimer_interval(timer));
 
@@ -275,7 +275,7 @@ void __cobalt_timer_getval(struct xntimer *__restrict__ timer,
 
 static inline void
 timer_gettimeout(struct cobalt_timer *__restrict__ timer,
-		 struct itimerspec *__restrict__ value)
+		 struct itimerspec64 *__restrict__ value)
 {
 	int ret = 0;
 
@@ -287,7 +287,7 @@ timer_gettimeout(struct cobalt_timer *__restrict__ timer,
 }
 
 int __cobalt_timer_setval(struct xntimer *__restrict__ timer, int clock_flag,
-			  const struct itimerspec *__restrict__ value)
+			  const struct itimerspec64 *__restrict__ value)
 {
 	xnticks_t start, period;
 
@@ -312,7 +312,7 @@ int __cobalt_timer_setval(struct xntimer *__restrict__ timer, int clock_flag,
 }
 
 static inline int timer_set(struct cobalt_timer *timer, int flags,
-			    const struct itimerspec *__restrict__ value)
+			    const struct itimerspec64 *__restrict__ value)
 {				/* nklocked, IRQs off. */
 	struct cobalt_thread *thread;
 	int ret = 0;
@@ -362,8 +362,8 @@ timer_deliver_late(struct cobalt_process *cc, timer_t timerid)
 }
 
 int __cobalt_timer_settime(timer_t timerid, int flags,
-			   const struct itimerspec *__restrict__ value,
-			   struct itimerspec *__restrict__ ovalue)
+			   const struct itimerspec64 *__restrict__ value,
+			   struct itimerspec64 *__restrict__ ovalue)
 {
 	struct cobalt_timer *timer;
 	struct cobalt_process *cc;
@@ -402,7 +402,7 @@ out:
 	return ret;
 }
 
-int __cobalt_timer_gettime(timer_t timerid, struct itimerspec *value)
+int __cobalt_timer_gettime(timer_t timerid, struct itimerspec64 *value)
 {
 	struct cobalt_timer *timer;
 	struct cobalt_process *cc;
@@ -471,23 +471,23 @@ COBALT_SYSCALL(timer_create, current,
 
 COBALT_SYSCALL(timer_settime, primary,
 	       (timer_t tm, int flags,
-		const struct itimerspec __user *u_newval,
-		struct itimerspec __user *u_oldval))
+		const struct __user_old_itimerspec __user *u_newval,
+		struct __user_old_itimerspec __user *u_oldval))
 {
-	struct itimerspec newv, oldv, *oldvp = &oldv;
+	struct itimerspec64 newv, oldv, *oldvp = &oldv;
 	int ret;
 
 	if (u_oldval == NULL)
 		oldvp = NULL;
 
-	if (cobalt_copy_from_user(&newv, u_newval, sizeof(newv)))
+	if (cobalt_get_u_itimerspec(&newv, u_newval))
 		return -EFAULT;
 
 	ret = __cobalt_timer_settime(tm, flags, &newv, oldvp);
 	if (ret)
 		return ret;
 
-	if (oldvp && cobalt_copy_to_user(u_oldval, oldvp, sizeof(oldv))) {
+	if (oldvp && cobalt_put_u_itimerspec(u_oldval, oldvp)) {
 		__cobalt_timer_settime(tm, flags, oldvp, NULL);
 		return -EFAULT;
 	}
@@ -496,16 +496,16 @@ COBALT_SYSCALL(timer_settime, primary,
 }
 
 COBALT_SYSCALL(timer_gettime, current,
-	       (timer_t tm, struct itimerspec __user *u_val))
+	       (timer_t tm, struct __user_old_itimerspec __user *u_val))
 {
-	struct itimerspec val;
+	struct itimerspec64 val;
 	int ret;
 
 	ret = __cobalt_timer_gettime(tm, &val);
 	if (ret)
 		return ret;
 
-	return cobalt_copy_to_user(u_val, &val, sizeof(val));
+	return cobalt_put_u_itimerspec(u_val, &val);
 }
 
 COBALT_SYSCALL(timer_getoverrun, current, (timer_t timerid))
diff --git a/kernel/cobalt/posix/timer.h b/kernel/cobalt/posix/timer.h
index 0f5402aee9..3b580d4707 100644
--- a/kernel/cobalt/posix/timer.h
+++ b/kernel/cobalt/posix/timer.h
@@ -51,20 +51,20 @@ cobalt_timer_by_id(struct cobalt_process *p, timer_t timer_id);
 void cobalt_timer_handler(struct xntimer *xntimer);
 
 void __cobalt_timer_getval(struct xntimer *__restrict__ timer, 
-			   struct itimerspec *__restrict__ value);
+			   struct itimerspec64 *__restrict__ value);
 
 int __cobalt_timer_setval(struct xntimer *__restrict__ timer, int clock_flag, 
-			  const struct itimerspec *__restrict__ value);
+			  const struct itimerspec64 *__restrict__ value);
 
 int __cobalt_timer_create(clockid_t clock,
 			  const struct sigevent *sev,
 			  timer_t __user *u_tm);
 
 int __cobalt_timer_settime(timer_t timerid, int flags,
-			   const struct itimerspec *__restrict__ value,
-			   struct itimerspec *__restrict__ ovalue);
+			   const struct itimerspec64 *__restrict__ value,
+			   struct itimerspec64 *__restrict__ ovalue);
 
-int __cobalt_timer_gettime(timer_t timerid, struct itimerspec *value);
+int __cobalt_timer_gettime(timer_t timerid, struct itimerspec64 *value);
 
 COBALT_SYSCALL_DECL(timer_create,
 		    (clockid_t clock,
@@ -75,11 +75,11 @@ COBALT_SYSCALL_DECL(timer_delete, (timer_t tm));
 
 COBALT_SYSCALL_DECL(timer_settime,
 		    (timer_t tm, int flags,
-		     const struct itimerspec __user *u_newval,
-		     struct itimerspec __user *u_oldval));
+		     const struct __user_old_itimerspec __user *u_newval,
+		     struct __user_old_itimerspec __user *u_oldval));
 
 COBALT_SYSCALL_DECL(timer_gettime,
-		    (timer_t tm, struct itimerspec __user *u_val));
+		    (timer_t tm, struct __user_old_itimerspec __user *u_val));
 
 COBALT_SYSCALL_DECL(timer_getoverrun, (timer_t tm));
 
diff --git a/kernel/cobalt/posix/timerfd.c b/kernel/cobalt/posix/timerfd.c
index 29046cfec5..472c4cba0c 100644
--- a/kernel/cobalt/posix/timerfd.c
+++ b/kernel/cobalt/posix/timerfd.c
@@ -32,7 +32,7 @@ struct cobalt_tfd {
 	struct rtdm_fd fd;
 	struct xntimer timer;
 	DECLARE_XNSELECT(read_select);
-	struct itimerspec value;
+	struct itimerspec64 value;
 	struct xnsynch readers;
 	struct xnthread *target;
 };
@@ -236,8 +236,8 @@ static inline void tfd_put(struct cobalt_tfd *tfd)
 }
 
 int __cobalt_timerfd_settime(int fd, int flags,
-			     const struct itimerspec *value,
-			     struct itimerspec *ovalue)
+			     const struct itimerspec64 *value,
+			     struct itimerspec64 *ovalue)
 {
 	struct cobalt_tfd *tfd;
 	int cflag, ret;
@@ -280,13 +280,13 @@ out:
 
 COBALT_SYSCALL(timerfd_settime, primary,
 	       (int fd, int flags,
-		const struct itimerspec __user *new_value,
-		struct itimerspec __user *old_value))
+		const struct __user_old_itimerspec __user *new_value,
+		struct __user_old_itimerspec __user *old_value))
 {
-	struct itimerspec ovalue, value;
+	struct itimerspec64 ovalue, value;
 	int ret;
 
-	ret = cobalt_copy_from_user(&value, new_value, sizeof(value));
+	ret = cobalt_get_u_itimerspec(&value, new_value);
 	if (ret)
 		return ret;
 
@@ -304,7 +304,7 @@ COBALT_SYSCALL(timerfd_settime, primary,
 	return ret;
 }
 
-int __cobalt_timerfd_gettime(int fd, struct itimerspec *value)
+int __cobalt_timerfd_gettime(int fd, struct itimerspec64 *value)
 {
 	struct cobalt_tfd *tfd;
 	spl_t s;
@@ -323,12 +323,12 @@ int __cobalt_timerfd_gettime(int fd, struct itimerspec *value)
 }
 
 COBALT_SYSCALL(timerfd_gettime, current,
-	       (int fd, struct itimerspec __user *curr_value))
+	       (int fd, struct __user_old_itimerspec __user *curr_value))
 {
-	struct itimerspec value;
+	struct itimerspec64 value;
 	int ret;
 
 	ret = __cobalt_timerfd_gettime(fd, &value);
 
-	return ret ?: cobalt_copy_to_user(curr_value, &value, sizeof(value));
+	return ret ?: cobalt_put_u_itimerspec(curr_value, &value);
 }
diff --git a/kernel/cobalt/posix/timerfd.h b/kernel/cobalt/posix/timerfd.h
index 5787ff60a0..245b8698bf 100644
--- a/kernel/cobalt/posix/timerfd.h
+++ b/kernel/cobalt/posix/timerfd.h
@@ -22,21 +22,21 @@
 #include <xenomai/posix/syscall.h>
 
 int __cobalt_timerfd_settime(int fd, int flags,
-			     const struct itimerspec *new_value,
-			     struct itimerspec *old_value);
+			     const struct itimerspec64 *new_value,
+			     struct itimerspec64 *old_value);
 
 int __cobalt_timerfd_gettime(int fd,
-			     struct itimerspec *value);
+			     struct itimerspec64 *value);
 
 COBALT_SYSCALL_DECL(timerfd_create,
 		    (int clockid, int flags));
 
 COBALT_SYSCALL_DECL(timerfd_settime,
 		    (int fd, int flags,
-		     const struct itimerspec __user *new_value,
-		     struct itimerspec __user *old_value));
+		     const struct __user_old_itimerspec __user *new_value,
+		     struct __user_old_itimerspec __user *old_value));
 
 COBALT_SYSCALL_DECL(timerfd_gettime,
-		    (int fd, struct itimerspec __user *curr_value));
+		    (int fd, struct __user_old_itimerspec __user *curr_value));
 
 #endif /* TIMERFD_H */
-- 
2.26.2


