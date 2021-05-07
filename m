From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v5 2/4] y2038: Adding sem_timedwait64
Date: Fri,  7 May 2021 20:19:51 +0200
Message-Id: <20210507181953.1396348-3-florian.bezdeka@siemens.com>
In-Reply-To: <20210507181953.1396348-1-florian.bezdeka@siemens.com>
References: <20210507181953.1396348-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

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
 include/cobalt/kernel/time.h    | 22 ++++++++++++++++++++++
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/Makefile          |  1 +
 kernel/cobalt/posix/sem.c       | 20 ++++++++++++++++++++
 kernel/cobalt/posix/sem.h       |  7 +++++++
 kernel/cobalt/posix/syscall32.c |  7 +++++++
 kernel/cobalt/posix/syscall32.h |  4 ++++
 kernel/cobalt/time.c            | 29 +++++++++++++++++++++++++++++
 8 files changed, 91 insertions(+)
 create mode 100644 include/cobalt/kernel/time.h
 create mode 100644 kernel/cobalt/time.c

diff --git a/include/cobalt/kernel/time.h b/include/cobalt/kernel/time.h
new file mode 100644
index 000000000..19e8f2c56
--- /dev/null
+++ b/include/cobalt/kernel/time.h
@@ -0,0 +1,22 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _COBALT_KERNEL_TIME_H
+#define _COBALT_KERNEL_TIME_H
+
+#include <linux/time.h>
+#include <linux/time64.h>
+
+/**
+ * Read struct __kernel_timespec from userspace and convert to
+ * struct timespec64
+ *
+ * @param ts The destination, will be filled
+ * @param uts The source, provided by an application
+ * @return 0 on success, -EFAULT otherwise
+ */
+int cobalt_get_timespec64(struct timespec64 *ts,
+			  const struct __kernel_timespec __user *uts);
+
+#endif //_COBALT_KERNEL_TIME_H
diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index aa3c308d0..8895d2bff 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -122,6 +122,7 @@
 #define sc_cobalt_sendmmsg			99
 #define sc_cobalt_clock_adjtime			100
 #define sc_cobalt_thread_setschedprio		101
+#define sc_cobalt_sem_timedwait64		102
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/Makefile b/kernel/cobalt/Makefile
index 129005d8f..6cd2d5994 100644
--- a/kernel/cobalt/Makefile
+++ b/kernel/cobalt/Makefile
@@ -13,6 +13,7 @@ xenomai-y :=	arith.o 	\
 		select.o	\
 		synch.o		\
 		thread.o	\
+		time.o		\
 		timer.o		\
 		tree.o
 
diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index 827a4751a..72b20c78d 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -19,6 +19,7 @@
 
 #include <stddef.h>
 #include <linux/err.h>
+#include <cobalt/kernel/time.h>
 #include "internal.h"
 #include "thread.h"
 #include "clock.h"
@@ -326,6 +327,18 @@ int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
 	return ret;
 }
 
+int __cobalt_sem_timedwait64(struct cobalt_sem_shadow __user *u_sem,
+			     const struct __kernel_timespec __user *u_ts)
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
 static int sem_post(xnhandle_t handle)
 {
 	struct cobalt_sem *sem;
@@ -435,6 +448,13 @@ COBALT_SYSCALL(sem_timedwait, primary,
 	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
 }
 
+COBALT_SYSCALL(sem_timedwait64, primary,
+	       (struct cobalt_sem_shadow __user *u_sem,
+		const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_sem_timedwait64(u_sem, u_ts);
+}
+
 COBALT_SYSCALL(sem_trywait, primary,
 	       (struct cobalt_sem_shadow __user *u_sem))
 {
diff --git a/kernel/cobalt/posix/sem.h b/kernel/cobalt/posix/sem.h
index 658e11f7a..d7dbb9098 100644
--- a/kernel/cobalt/posix/sem.h
+++ b/kernel/cobalt/posix/sem.h
@@ -66,6 +66,9 @@ __cobalt_sem_open(struct cobalt_sem_shadow __user *usm,
 int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
 			   const struct timespec64 *ts);
 
+int __cobalt_sem_timedwait64(struct cobalt_sem_shadow __user *u_sem,
+			     const struct __kernel_timespec __user *u_ts);
+
 int __cobalt_sem_destroy(xnhandle_t handle);
 
 void cobalt_nsem_reclaim(struct cobalt_process *process);
@@ -91,6 +94,10 @@ COBALT_SYSCALL_DECL(sem_timedwait,
 		    (struct cobalt_sem_shadow __user *u_sem,
 		     const struct __user_old_timespec __user *u_ts));
 
+COBALT_SYSCALL_DECL(sem_timedwait64,
+		    (struct cobalt_sem_shadow __user *u_sem,
+		     const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(sem_trywait,
 		    (struct cobalt_sem_shadow __user *u_sem));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index edac7ea4a..a5dc6e48f 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -135,6 +135,13 @@ COBALT_SYSCALL32emu(sem_timedwait, primary,
 	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
 }
 
+COBALT_SYSCALL32emu(sem_timedwait64, primary,
+		    (struct cobalt_sem_shadow __user *u_sem,
+		     const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_sem_timedwait64(u_sem, u_ts);
+}
+
 COBALT_SYSCALL32emu(clock_getres, current,
 		    (clockid_t clock_id,
 		     struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index d72fd2022..0b5e26d9e 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -231,4 +231,8 @@ COBALT_SYSCALL32emu_DECL(sem_timedwait,
 			 (struct cobalt_sem_shadow __user *u_sem,
 			  const struct old_timespec32 __user *u_ts));
 
+COBALT_SYSCALL32emu_DECL(sem_timedwait64,
+			 (struct cobalt_sem_shadow __user * u_sem,
+			  const struct __kernel_timespec __user *u_ts));
+
 #endif /* !_COBALT_POSIX_SYSCALL32_H */
diff --git a/kernel/cobalt/time.c b/kernel/cobalt/time.c
new file mode 100644
index 000000000..a3fd8a740
--- /dev/null
+++ b/kernel/cobalt/time.c
@@ -0,0 +1,29 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <asm-generic/xenomai/syscall.h>
+#include <cobalt/kernel/time.h>
+#include <linux/compat.h>
+
+int cobalt_get_timespec64(struct timespec64 *ts,
+			  const struct __kernel_timespec __user *uts)
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
-- 
2.31.1


