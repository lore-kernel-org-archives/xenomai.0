From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 5/9] cobalt/kernel: y2038: switch to new legacy type names
Date: Wed,  5 May 2021 18:53:04 +0200
Message-Id: <2f39970a8863fc60328b3a58fb51a6371d222fea.1620233588.git.jan.kiszka@siemens.com>
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

Since 5.6-rc3, former 32bit compatibility types for time-related
structs have been renamed as follows:

compat_timeval -> old_timeval32
compat_timespec -> old_timespec32
compat_itimerspec -> old_itimerspec32

Apply the same changes to the tree, providing backward compatibility
wrappers for pre-5.7 kernels.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/compat.h                | 22 +++++-----
 .../include/asm-generic/xenomai/wrappers.h    |  3 ++
 kernel/cobalt/posix/compat.c                  | 16 +++----
 kernel/cobalt/posix/syscall32.c               | 42 +++++++++----------
 kernel/cobalt/posix/syscall32.h               | 42 +++++++++----------
 kernel/drivers/ipc/rtipc.c                    |  4 +-
 6 files changed, 66 insertions(+), 63 deletions(-)

diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
index d7f0008d9f..6da7bafaf8 100644
--- a/include/cobalt/kernel/compat.h
+++ b/include/cobalt/kernel/compat.h
@@ -29,13 +29,13 @@ struct mq_attr;
 
 struct __compat_sched_ss_param {
 	int __sched_low_priority;
-	struct compat_timespec __sched_repl_period;
-	struct compat_timespec __sched_init_budget;
+	struct old_timespec32 __sched_repl_period;
+	struct old_timespec32 __sched_init_budget;
 	int __sched_max_repl;
 };
 
 struct __compat_sched_rr_param {
-	struct compat_timespec __sched_rr_quantum;
+	struct old_timespec32 __sched_rr_quantum;
 };
 
 struct compat_sched_param_ex {
@@ -56,8 +56,8 @@ struct compat_mq_attr {
 };
 
 struct compat_sched_tp_window {
-	struct compat_timespec offset;
-	struct compat_timespec duration;
+	struct old_timespec32 offset;
+	struct old_timespec32 duration;
 	int ptid;
 };
 
@@ -87,21 +87,21 @@ struct compat_rtdm_mmap_request {
 };
 
 int sys32_get_timespec(struct timespec64 *ts,
-		       const struct compat_timespec __user *cts);
+		       const struct old_timespec32 __user *cts);
 
-int sys32_put_timespec(struct compat_timespec __user *cts,
+int sys32_put_timespec(struct old_timespec32 __user *cts,
 		       const struct timespec64 *ts);
 
 int sys32_get_itimerspec(struct itimerspec64 *its,
-			 const struct compat_itimerspec __user *cits);
+			 const struct old_itimerspec32 __user *cits);
 
-int sys32_put_itimerspec(struct compat_itimerspec __user *cits,
+int sys32_put_itimerspec(struct old_itimerspec32 __user *cits,
 			 const struct itimerspec64 *its);
 
 int sys32_get_timeval(struct __kernel_old_timeval *tv,
-		      const struct compat_timeval __user *ctv);
+		      const struct old_timeval32 __user *ctv);
 
-int sys32_put_timeval(struct compat_timeval __user *ctv,
+int sys32_put_timeval(struct old_timeval32 __user *ctv,
 		      const struct __kernel_old_timeval *tv);
 
 int sys32_get_timex(struct __kernel_timex *tx,
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 42cd1955ac..930e6364e5 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -205,6 +205,9 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(5,7,0)
 #define pci_aer_clear_nonfatal_status	pci_cleanup_aer_uncorrect_error_status
+#define old_timespec32    compat_timespec
+#define old_itimerspec32  compat_itimerspec
+#define old_timeval32     compat_timeval
 #endif
 
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index 6002d74802..dbc9a9cf02 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -23,9 +23,9 @@
 #include <xenomai/posix/mqueue.h>
 
 int sys32_get_timespec(struct timespec64 *ts,
-		       const struct compat_timespec __user *u_cts)
+		       const struct old_timespec32 __user *u_cts)
 {
-	struct compat_timespec cts;
+	struct old_timespec32 cts;
 
 	if (u_cts == NULL || !access_rok(u_cts, sizeof(*u_cts)))
 		return -EFAULT;
@@ -41,10 +41,10 @@ int sys32_get_timespec(struct timespec64 *ts,
 }
 EXPORT_SYMBOL_GPL(sys32_get_timespec);
 
-int sys32_put_timespec(struct compat_timespec __user *u_cts,
+int sys32_put_timespec(struct old_timespec32 __user *u_cts,
 		       const struct timespec64 *ts)
 {
-	struct compat_timespec cts;
+	struct old_timespec32 cts;
 
 	if (u_cts == NULL || !access_wok(u_cts, sizeof(*u_cts)))
 		return -EFAULT;
@@ -61,7 +61,7 @@ int sys32_put_timespec(struct compat_timespec __user *u_cts,
 EXPORT_SYMBOL_GPL(sys32_put_timespec);
 
 int sys32_get_itimerspec(struct itimerspec64 *its,
-			 const struct compat_itimerspec __user *cits)
+			 const struct old_itimerspec32 __user *cits)
 {
 	int ret = sys32_get_timespec(&its->it_value, &cits->it_value);
 
@@ -69,7 +69,7 @@ int sys32_get_itimerspec(struct itimerspec64 *its,
 }
 EXPORT_SYMBOL_GPL(sys32_get_itimerspec);
 
-int sys32_put_itimerspec(struct compat_itimerspec __user *cits,
+int sys32_put_itimerspec(struct old_itimerspec32 __user *cits,
 			 const struct itimerspec64 *its)
 {
 	int ret = sys32_put_timespec(&cits->it_value, &its->it_value);
@@ -79,7 +79,7 @@ int sys32_put_itimerspec(struct compat_itimerspec __user *cits,
 EXPORT_SYMBOL_GPL(sys32_put_itimerspec);
 
 int sys32_get_timeval(struct __kernel_old_timeval *tv,
-		      const struct compat_timeval __user *ctv)
+		      const struct old_timeval32 __user *ctv)
 {
 	return (ctv == NULL ||
 		!access_rok(ctv, sizeof(*ctv)) ||
@@ -88,7 +88,7 @@ int sys32_get_timeval(struct __kernel_old_timeval *tv,
 }
 EXPORT_SYMBOL_GPL(sys32_get_timeval);
 
-int sys32_put_timeval(struct compat_timeval __user *ctv,
+int sys32_put_timeval(struct old_timeval32 __user *ctv,
 		      const struct __kernel_old_timeval *tv)
 {
 	return (ctv == NULL ||
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 4f819e0e5a..57aa7251a4 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -124,14 +124,14 @@ COBALT_SYSCALL32emu(sem_open, lostage,
 
 COBALT_SYSCALL32emu(sem_timedwait, primary,
 		    (struct cobalt_sem_shadow __user *u_sem,
-		     struct compat_timespec __user *u_ts))
+		     struct old_timespec32 __user *u_ts))
 {
 	return __cobalt_sem_timedwait(u_sem, u_ts, sys32_fetch_timeout);
 }
 
 COBALT_SYSCALL32emu(clock_getres, current,
 		    (clockid_t clock_id,
-		     struct compat_timespec __user *u_ts))
+		     struct old_timespec32 __user *u_ts))
 {
 	struct timespec64 ts;
 	int ret;
@@ -145,7 +145,7 @@ COBALT_SYSCALL32emu(clock_getres, current,
 
 COBALT_SYSCALL32emu(clock_gettime, current,
 		    (clockid_t clock_id,
-		     struct compat_timespec __user *u_ts))
+		     struct old_timespec32 __user *u_ts))
 {
 	struct timespec64 ts;
 	int ret;
@@ -159,7 +159,7 @@ COBALT_SYSCALL32emu(clock_gettime, current,
 
 COBALT_SYSCALL32emu(clock_settime, current,
 		    (clockid_t clock_id,
-		     const struct compat_timespec __user *u_ts))
+		     const struct old_timespec32 __user *u_ts))
 {
 	struct timespec64 ts;
 	int ret;
@@ -190,8 +190,8 @@ COBALT_SYSCALL32emu(clock_adjtime, current,
 
 COBALT_SYSCALL32emu(clock_nanosleep, nonrestartable,
 		    (clockid_t clock_id, int flags,
-		     const struct compat_timespec __user *u_rqt,
-		     struct compat_timespec __user *u_rmt))
+		     const struct old_timespec32 __user *u_rqt,
+		     struct old_timespec32 __user *u_rmt))
 {
 	struct timespec64 rqt, rmt, *rmtp = NULL;
 	int ret;
@@ -212,7 +212,7 @@ COBALT_SYSCALL32emu(clock_nanosleep, nonrestartable,
 
 COBALT_SYSCALL32emu(mutex_timedlock, primary,
 		    (struct cobalt_mutex_shadow __user *u_mx,
-		     const struct compat_timespec __user *u_ts))
+		     const struct old_timespec32 __user *u_ts))
 {
 	return __cobalt_mutex_timedlock_break(u_mx, u_ts, sys32_fetch_timeout);
 }
@@ -222,7 +222,7 @@ COBALT_SYSCALL32emu(cond_wait_prologue, nonrestartable,
 		     struct cobalt_mutex_shadow __user *u_mx,
 		     int *u_err,
 		     unsigned int timed,
-		     struct compat_timespec __user *u_ts))
+		     struct old_timespec32 __user *u_ts))
 {
 	return __cobalt_cond_wait_prologue(u_cnd, u_mx, u_err, u_ts,
 					   timed ? sys32_fetch_timeout : NULL);
@@ -261,7 +261,7 @@ COBALT_SYSCALL32emu(mq_getattr, current,
 COBALT_SYSCALL32emu(mq_timedsend, primary,
 		    (mqd_t uqd, const void __user *u_buf, size_t len,
 		     unsigned int prio,
-		     const struct compat_timespec __user *u_ts))
+		     const struct old_timespec32 __user *u_ts))
 {
 	return __cobalt_mq_timedsend(uqd, u_buf, len, prio,
 				     u_ts, u_ts ? sys32_fetch_timeout : NULL);
@@ -271,7 +271,7 @@ COBALT_SYSCALL32emu(mq_timedreceive, primary,
 		    (mqd_t uqd, void __user *u_buf,
 		     compat_ssize_t __user *u_len,
 		     unsigned int __user *u_prio,
-		     const struct compat_timespec __user *u_ts))
+		     const struct old_timespec32 __user *u_ts))
 {
 	compat_ssize_t clen;
 	ssize_t len;
@@ -511,8 +511,8 @@ COBALT_SYSCALL32emu(timer_create, current,
 
 COBALT_SYSCALL32emu(timer_settime, primary,
 		    (timer_t tm, int flags,
-		     const struct compat_itimerspec __user *u_newval,
-		     struct compat_itimerspec __user *u_oldval))
+		     const struct old_itimerspec32 __user *u_newval,
+		     struct old_itimerspec32 __user *u_oldval))
 {
 	struct itimerspec64 newv, oldv, *oldvp = &oldv;
 	int ret;
@@ -538,7 +538,7 @@ COBALT_SYSCALL32emu(timer_settime, primary,
 }
 
 COBALT_SYSCALL32emu(timer_gettime, current,
-		    (timer_t tm, struct compat_itimerspec __user *u_val))
+		    (timer_t tm, struct old_itimerspec32 __user *u_val))
 {
 	struct itimerspec64 val;
 	int ret;
@@ -550,8 +550,8 @@ COBALT_SYSCALL32emu(timer_gettime, current,
 
 COBALT_SYSCALL32emu(timerfd_settime, primary,
 		    (int fd, int flags,
-		     const struct compat_itimerspec __user *new_value,
-		     struct compat_itimerspec __user *old_value))
+		     const struct old_itimerspec32 __user *new_value,
+		     struct old_itimerspec32 __user *old_value))
 {
 	struct itimerspec64 ovalue, value;
 	int ret;
@@ -575,7 +575,7 @@ COBALT_SYSCALL32emu(timerfd_settime, primary,
 }
 
 COBALT_SYSCALL32emu(timerfd_gettime, current,
-		    (int fd, struct compat_itimerspec __user *curr_value))
+		    (int fd, struct old_itimerspec32 __user *curr_value))
 {
 	struct itimerspec64 value;
 	int ret;
@@ -606,7 +606,7 @@ COBALT_SYSCALL32emu(sigwait, primary,
 COBALT_SYSCALL32emu(sigtimedwait, nonrestartable,
 		    (const compat_sigset_t __user *u_set,
 		     struct compat_siginfo __user *u_si,
-		     const struct compat_timespec __user *u_timeout))
+		     const struct old_timespec32 __user *u_timeout))
 {
 	struct timespec64 timeout;
 	sigset_t set;
@@ -658,7 +658,7 @@ COBALT_SYSCALL32emu(sigqueue, conforming,
 
 COBALT_SYSCALL32emu(monitor_wait, nonrestartable,
 		    (struct cobalt_monitor_shadow __user *u_mon,
-		     int event, const struct compat_timespec __user *u_ts,
+		     int event, const struct old_timespec32 __user *u_ts,
 		     int __user *u_ret))
 {
 	struct timespec64 ts, *tsp = NULL;
@@ -678,7 +678,7 @@ COBALT_SYSCALL32emu(event_wait, primary,
 		    (struct cobalt_event_shadow __user *u_event,
 		     unsigned int bits,
 		     unsigned int __user *u_bits_r,
-		     int mode, const struct compat_timespec __user *u_ts))
+		     int mode, const struct old_timespec32 __user *u_ts))
 {
 	struct timespec64 ts, *tsp = NULL;
 	int ret;
@@ -698,7 +698,7 @@ COBALT_SYSCALL32emu(select, nonrestartable,
 		     compat_fd_set __user *u_rfds,
 		     compat_fd_set __user *u_wfds,
 		     compat_fd_set __user *u_xfds,
-		     struct compat_timeval __user *u_tv))
+		     struct old_timeval32 __user *u_tv))
 {
 	compat_fd_set __user *ufd_sets[XNSELECT_MAX_TYPES] = {
 		[XNSELECT_READ] = u_rfds,
@@ -829,7 +829,7 @@ static int put_mmsg32(void __user **u_mmsg_p, const struct mmsghdr *mmsg)
 
 COBALT_SYSCALL32emu(recvmmsg, primary,
 	       (int ufd, struct compat_mmsghdr __user *u_msgvec, unsigned int vlen,
-		unsigned int flags, struct compat_timespec *u_timeout))
+		unsigned int flags, struct old_timespec32 *u_timeout))
 {
 	return __rtdm_fd_recvmmsg(ufd, u_msgvec, vlen, flags, u_timeout,
 				  get_mmsg32, put_mmsg32,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 9da4052297..66cd2a5d24 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -53,15 +53,15 @@ COBALT_SYSCALL32emu_DECL(thread_setschedprio,
 
 COBALT_SYSCALL32emu_DECL(clock_getres,
 			 (clockid_t clock_id,
-			  struct compat_timespec __user *u_ts));
+			  struct old_timespec32 __user *u_ts));
 
 COBALT_SYSCALL32emu_DECL(clock_gettime,
 			 (clockid_t clock_id,
-			  struct compat_timespec __user *u_ts));
+			  struct old_timespec32 __user *u_ts));
 
 COBALT_SYSCALL32emu_DECL(clock_settime,
 			 (clockid_t clock_id,
-			  const struct compat_timespec __user *u_ts));
+			  const struct old_timespec32 __user *u_ts));
 
 COBALT_SYSCALL32emu_DECL(clock_adjtime,
 			 (clockid_t clock_id,
@@ -69,19 +69,19 @@ COBALT_SYSCALL32emu_DECL(clock_adjtime,
 
 COBALT_SYSCALL32emu_DECL(clock_nanosleep,
 			 (clockid_t clock_id, int flags,
-			  const struct compat_timespec __user *u_rqt,
-			  struct compat_timespec __user *u_rmt));
+			  const struct old_timespec32 __user *u_rqt,
+			  struct old_timespec32 __user *u_rmt));
 
 COBALT_SYSCALL32emu_DECL(mutex_timedlock,
 			 (struct cobalt_mutex_shadow __user *u_mx,
-			  const struct compat_timespec __user *u_ts));
+			  const struct old_timespec32 __user *u_ts));
 
 COBALT_SYSCALL32emu_DECL(cond_wait_prologue,
 			 (struct cobalt_cond_shadow __user *u_cnd,
 			  struct cobalt_mutex_shadow __user *u_mx,
 			  int *u_err,
 			  unsigned int timed,
-			  struct compat_timespec __user *u_ts));
+			  struct old_timespec32 __user *u_ts));
 
 COBALT_SYSCALL32emu_DECL(mq_open,
 			 (const char __user *u_name, int oflags,
@@ -93,13 +93,13 @@ COBALT_SYSCALL32emu_DECL(mq_getattr,
 COBALT_SYSCALL32emu_DECL(mq_timedsend,
 			 (mqd_t uqd, const void __user *u_buf, size_t len,
 			  unsigned int prio,
-			  const struct compat_timespec __user *u_ts));
+			  const struct old_timespec32 __user *u_ts));
 
 COBALT_SYSCALL32emu_DECL(mq_timedreceive,
 			 (mqd_t uqd, void __user *u_buf,
 			  compat_ssize_t __user *u_len,
 			  unsigned int __user *u_prio,
-			  const struct compat_timespec __user *u_ts));
+			  const struct old_timespec32 __user *u_ts));
 
 COBALT_SYSCALL32x_DECL(mq_timedreceive,
 		       (mqd_t uqd, void __user *u_buf,
@@ -143,20 +143,20 @@ COBALT_SYSCALL32emu_DECL(timer_create,
 
 COBALT_SYSCALL32emu_DECL(timer_settime,
 			 (timer_t tm, int flags,
-			  const struct compat_itimerspec __user *u_newval,
-			  struct compat_itimerspec __user *u_oldval));
+			  const struct old_itimerspec32 __user *u_newval,
+			  struct old_itimerspec32 __user *u_oldval));
 
 COBALT_SYSCALL32emu_DECL(timer_gettime,
 			 (timer_t tm,
-			  struct compat_itimerspec __user *u_val));
+			  struct old_itimerspec32 __user *u_val));
 
 COBALT_SYSCALL32emu_DECL(timerfd_settime,
 			 (int fd, int flags,
-			  const struct compat_itimerspec __user *new_value,
-			  struct compat_itimerspec __user *old_value));
+			  const struct old_itimerspec32 __user *new_value,
+			  struct old_itimerspec32 __user *old_value));
 
 COBALT_SYSCALL32emu_DECL(timerfd_gettime,
-			 (int fd, struct compat_itimerspec __user *value));
+			 (int fd, struct old_itimerspec32 __user *value));
 
 COBALT_SYSCALL32emu_DECL(sigwait,
 			 (const compat_sigset_t __user *u_set,
@@ -165,7 +165,7 @@ COBALT_SYSCALL32emu_DECL(sigwait,
 COBALT_SYSCALL32emu_DECL(sigtimedwait,
 			 (const compat_sigset_t __user *u_set,
 			  struct compat_siginfo __user *u_si,
-			  const struct compat_timespec __user *u_timeout));
+			  const struct old_timespec32 __user *u_timeout));
 
 COBALT_SYSCALL32emu_DECL(sigwaitinfo,
 			 (const compat_sigset_t __user *u_set,
@@ -180,21 +180,21 @@ COBALT_SYSCALL32emu_DECL(sigqueue,
 
 COBALT_SYSCALL32emu_DECL(monitor_wait,
 			 (struct cobalt_monitor_shadow __user *u_mon,
-			  int event, const struct compat_timespec __user *u_ts,
+			  int event, const struct old_timespec32 __user *u_ts,
 			  int __user *u_ret));
 
 COBALT_SYSCALL32emu_DECL(event_wait,
 			 (struct cobalt_event_shadow __user *u_event,
 			  unsigned int bits,
 			  unsigned int __user *u_bits_r,
-			  int mode, const struct compat_timespec __user *u_ts));
+			  int mode, const struct old_timespec32 __user *u_ts));
 
 COBALT_SYSCALL32emu_DECL(select,
 			 (int nfds,
 			  compat_fd_set __user *u_rfds,
 			  compat_fd_set __user *u_wfds,
 			  compat_fd_set __user *u_xfds,
-			  struct compat_timeval __user *u_tv));
+			  struct old_timeval32 __user *u_tv));
 
 COBALT_SYSCALL32emu_DECL(recvmsg,
 			 (int fd, struct compat_msghdr __user *umsg,
@@ -203,7 +203,7 @@ COBALT_SYSCALL32emu_DECL(recvmsg,
 COBALT_SYSCALL32emu_DECL(recvmmsg,
 			 (int fd, struct compat_mmsghdr __user *u_msgvec,
 			  unsigned int vlen,
-			  unsigned int flags, struct compat_timespec *u_timeout));
+			  unsigned int flags, struct old_timespec32 *u_timeout));
 
 COBALT_SYSCALL32emu_DECL(sendmsg,
 			 (int fd, struct compat_msghdr __user *umsg,
@@ -229,6 +229,6 @@ COBALT_SYSCALL32emu_DECL(sem_open,
 
 COBALT_SYSCALL32emu_DECL(sem_timedwait,
 			 (struct cobalt_sem_shadow __user *u_sem,
-			  struct compat_timespec __user *u_ts));
+			  struct old_timespec32 __user *u_ts));
 
 #endif /* !_COBALT_POSIX_SYSCALL32_H */
diff --git a/kernel/drivers/ipc/rtipc.c b/kernel/drivers/ipc/rtipc.c
index b6fafdb413..abb76817a6 100644
--- a/kernel/drivers/ipc/rtipc.c
+++ b/kernel/drivers/ipc/rtipc.c
@@ -273,7 +273,7 @@ int rtipc_get_timeval(struct rtdm_fd *fd, struct __kernel_old_timeval *tv,
 {
 #ifdef CONFIG_XENO_ARCH_SYS3264
 	if (rtdm_fd_is_compat(fd)) {
-		if (arglen != sizeof(struct compat_timeval))
+		if (arglen != sizeof(struct old_timeval32))
 			return -EINVAL;
 		return sys32_get_timeval(tv, arg);
 	}
@@ -295,7 +295,7 @@ int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
 {
 #ifdef CONFIG_XENO_ARCH_SYS3264
 	if (rtdm_fd_is_compat(fd)) {
-		if (arglen != sizeof(struct compat_timeval))
+		if (arglen != sizeof(struct old_timeval32))
 			return -EINVAL;
 		return sys32_put_timeval(arg, tv);
 	}
-- 
2.26.2


