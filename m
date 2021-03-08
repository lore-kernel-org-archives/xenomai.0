From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [RFC PATCH v2 2/4] y2038: Adding sem_timedwait_time64
Date: Mon,  8 Mar 2021 18:02:04 +0100
Message-Id: <20210308170206.313181-3-florian.bezdeka@siemens.com>
In-Reply-To: <20210308170206.313181-1-florian.bezdeka@siemens.com>
References: <87h7lqzzzw.fsf@xenomai.org>
 <20210308170206.313181-1-florian.bezdeka@siemens.com>
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
To: xenomai@xenomai.org, jan.kiszka@siemens.com, rpm@xenomai.org, chensong@kylinos.cn

Implementation is heavily inspired by the sem_timedwait syscall,
but expecting time64 based timespec / timeout.

We need two new syscall handlers:
  - The native one (COBALT_SYSCALL()) to get 32 bit kernels time64
    aware. This handler is added for 64 bit kernels as well, but not
    used. As we don't have separate syscall tables for this both
    worlds we have to add it.

 - The compat handler (COBALT_SYSCALL32emu()) for x32 or x86
   applications running on an x86_64 kernel. Otherwise the redirection
   to the compat / emulation syscalls is broken.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h                 |  1 +
 .../include/asm-generic/xenomai/syscall.h     | 23 +++++++++++++++++++
 kernel/cobalt/posix/sem.c                     | 13 +++++++++++
 kernel/cobalt/posix/sem.h                     |  4 ++++
 kernel/cobalt/posix/syscall32.c               | 13 +++++++++++
 kernel/cobalt/posix/syscall32.h               |  4 ++++
 6 files changed, 58 insertions(+)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index aa3c308d0..9b005da47 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -122,6 +122,7 @@
 #define sc_cobalt_sendmmsg			99
 #define sc_cobalt_clock_adjtime			100
 #define sc_cobalt_thread_setschedprio		101
+#define sc_cobalt_sem_timedwait_time64		102
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index 91bbf3bfd..40d64b7a1 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -19,6 +19,7 @@
 #ifndef _COBALT_ASM_GENERIC_SYSCALL_H
 #define _COBALT_ASM_GENERIC_SYSCALL_H
 
+#include <linux/compat.h>
 #include <linux/types.h>
 #include <linux/version.h>
 #include <linux/uaccess.h>
@@ -82,6 +83,28 @@ static inline int cobalt_strncpy_from_user(char *dst, const char __user *src,
 	return __xn_strncpy_from_user(dst, src, count);
 }
 
+static inline int cobalt_get_timespec64(struct timespec64 *ts,
+				const struct __kernel_timespec __user *uts)
+{
+	struct __kernel_timespec kts;
+	int ret;
+
+	ret = cobalt_copy_from_user(&kts, uts, sizeof(kts));
+	if (ret)
+		return -EFAULT;
+
+	ts->tv_sec = kts.tv_sec;
+
+	/* Zero out the padding in compat mode */
+	if (in_compat_syscall())
+		kts.tv_nsec &= 0xFFFFFFFFUL;
+
+	/* In 32-bit mode, this drops the padding */
+	ts->tv_nsec = kts.tv_nsec;
+
+	return 0;
+}
+
 #if __BITS_PER_LONG == 64
 
 /*
diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index 827a4751a..3055a456d 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -435,6 +435,19 @@ COBALT_SYSCALL(sem_timedwait, primary,
 	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
 }
 
+COBALT_SYSCALL(sem_timedwait_time64, primary,
+	       (struct cobalt_sem_shadow __user *u_sem,
+		const struct __kernel_timespec __user *u_ts))
+{
+	int ret = 1;
+	struct timespec64 ts64;
+
+	if (u_ts)
+		ret = cobalt_get_timespec64(&ts64, u_ts);
+
+	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
+}
+
 COBALT_SYSCALL(sem_trywait, primary,
 	       (struct cobalt_sem_shadow __user *u_sem))
 {
diff --git a/kernel/cobalt/posix/sem.h b/kernel/cobalt/posix/sem.h
index 658e11f7a..8491b69ba 100644
--- a/kernel/cobalt/posix/sem.h
+++ b/kernel/cobalt/posix/sem.h
@@ -66,6 +66,10 @@ __cobalt_sem_open(struct cobalt_sem_shadow __user *usm,
 int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
 			   const struct timespec64 *ts);
 
+COBALT_SYSCALL_DECL(sem_timedwait_time64,
+		    (struct cobalt_sem_shadow __user *u_sem,
+		     const struct __kernel_timespec __user *u_ts));
+
 int __cobalt_sem_destroy(xnhandle_t handle);
 
 void cobalt_nsem_reclaim(struct cobalt_process *process);
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index edac7ea4a..f73bfcda3 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -135,6 +135,19 @@ COBALT_SYSCALL32emu(sem_timedwait, primary,
 	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
 }
 
+COBALT_SYSCALL32emu(sem_timedwait_time64, primary,
+		    (struct cobalt_sem_shadow __user *u_sem,
+		     const struct __kernel_timespec __user *u_ts))
+{
+	int ret = 1;
+	struct timespec64 ts64;
+
+	if (u_ts)
+		ret = cobalt_get_timespec64(&ts64, u_ts);
+
+	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
+}
+
 COBALT_SYSCALL32emu(clock_getres, current,
 		    (clockid_t clock_id,
 		     struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index d72fd2022..3612bf751 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -231,4 +231,8 @@ COBALT_SYSCALL32emu_DECL(sem_timedwait,
 			 (struct cobalt_sem_shadow __user *u_sem,
 			  const struct old_timespec32 __user *u_ts));
 
+COBALT_SYSCALL32emu_DECL(sem_timedwait_time64,
+			 (struct cobalt_sem_shadow __user * u_sem,
+			  const struct __kernel_timespec __user *u_ts));
+
 #endif /* !_COBALT_POSIX_SYSCALL32_H */
-- 
2.29.2


