Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v2 1/3] y2038: cobalt/posix/mutex: Adding mutex_timedlock64
Date: Thu,  3 Jun 2021 18:56:02 +0800
Message-Id: <1622717762-23282-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

Add a syscall specific for mutex_timedlock with 64bit
time_t.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/mutex.c     | 22 +++++++++++++++++++++-
 kernel/cobalt/posix/mutex.h     |  7 +++++++
 kernel/cobalt/posix/syscall32.c |  7 +++++++
 kernel/cobalt/posix/syscall32.h |  4 ++++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index a2795a3..6fe57c7 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -128,6 +128,7 @@
 #define sc_cobalt_clock_nanosleep64		105
 #define sc_cobalt_clock_getres64		106
 #define sc_cobalt_clock_adjtime64		107
+#define sc_cobalt_mutex_timedlock64		108
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/mutex.c b/kernel/cobalt/posix/mutex.c
index 70fe796..1bd4703 100644
--- a/kernel/cobalt/posix/mutex.c
+++ b/kernel/cobalt/posix/mutex.c
@@ -21,6 +21,7 @@
 #include "mutex.h"
 #include "cond.h"
 #include "clock.h"
+#include <cobalt/kernel/time.h>
 
 static int cobalt_mutex_init_inner(struct cobalt_mutex_shadow *shadow,
 				   struct cobalt_mutex *mutex,
@@ -76,7 +77,7 @@ int __cobalt_mutex_acquire_unchecked(struct xnthread *cur,
 	int ret;
 
 	if (ts) {
-		if (ts->tv_nsec >= ONE_BILLION)
+		if (!timespec64_valid(ts))
 			return -EINVAL;
 		ret = xnsynch_acquire(&mutex->synchbase, ts2ns(ts) + 1, XN_REALTIME);
 	} else
@@ -359,6 +360,25 @@ COBALT_SYSCALL(mutex_timedlock, primary,
 	return __cobalt_mutex_timedlock_break(u_mx, u_ts, mutex_fetch_timeout);
 }
 
+static inline int mutex_fetch_timeout64(struct timespec64 *ts,
+				      const void __user *u_ts)
+{
+	return u_ts == NULL ? -EFAULT : cobalt_get_timespec64(ts, u_ts);
+}
+
+int __cobalt_mutex_timedlock64(struct cobalt_mutex_shadow __user *u_mx,
+				   const void __user *u_ts)
+{
+	return __cobalt_mutex_timedlock_break(u_mx, u_ts, mutex_fetch_timeout64);
+}
+
+COBALT_SYSCALL(mutex_timedlock64, primary,
+	       (struct cobalt_mutex_shadow __user *u_mx,
+		const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_mutex_timedlock64(u_mx, u_ts);
+}
+
 COBALT_SYSCALL(mutex_unlock, nonrestartable,
 	       (struct cobalt_mutex_shadow __user *u_mx))
 {
diff --git a/kernel/cobalt/posix/mutex.h b/kernel/cobalt/posix/mutex.h
index d76f2a9..d7d4321 100644
--- a/kernel/cobalt/posix/mutex.h
+++ b/kernel/cobalt/posix/mutex.h
@@ -40,6 +40,9 @@ int __cobalt_mutex_timedlock_break(struct cobalt_mutex_shadow __user *u_mx,
 				   int (*fetch_timeout)(struct timespec64 *ts,
 							const void __user *u_ts));
 
+int __cobalt_mutex_timedlock64(struct cobalt_mutex_shadow __user *u_mx,
+				   const void __user *u_ts);
+
 int __cobalt_mutex_acquire_unchecked(struct xnthread *cur,
 				     struct cobalt_mutex *mutex,
 				     const struct timespec64 *ts);
@@ -64,6 +67,10 @@ COBALT_SYSCALL_DECL(mutex_timedlock,
 		    (struct cobalt_mutex_shadow __user *u_mx,
 		     const struct __user_old_timespec __user *u_ts));
 
+COBALT_SYSCALL(mutex_timedlock64, primary,
+	       (struct cobalt_mutex_shadow __user *u_mx,
+		const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(mutex_unlock,
 		    (struct cobalt_mutex_shadow __user *u_mx));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 29c99bd..65dbd55 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -267,6 +267,13 @@ COBALT_SYSCALL32emu(mutex_timedlock, primary,
 	return __cobalt_mutex_timedlock_break(u_mx, u_ts, sys32_fetch_timeout);
 }
 
+COBALT_SYSCALL32emu(mutex_timedlock64, primary,
+		    (struct cobalt_mutex_shadow __user *u_mx,
+		     const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_mutex_timedlock64(u_mx, u_ts);
+}
+
 COBALT_SYSCALL32emu(cond_wait_prologue, nonrestartable,
 		    (struct cobalt_cond_shadow __user *u_cnd,
 		     struct cobalt_mutex_shadow __user *u_mx,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 64f6e49..d464d96 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -98,6 +98,10 @@ COBALT_SYSCALL32emu_DECL(mutex_timedlock,
 			 (struct cobalt_mutex_shadow __user *u_mx,
 			  const struct old_timespec32 __user *u_ts));
 
+COBALT_SYSCALL32emu_DECL(mutex_timedlock64,
+			 (struct cobalt_mutex_shadow __user *u_mx,
+			  const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL32emu_DECL(cond_wait_prologue,
 			 (struct cobalt_cond_shadow __user *u_cnd,
 			  struct cobalt_mutex_shadow __user *u_mx,
-- 
2.7.4


