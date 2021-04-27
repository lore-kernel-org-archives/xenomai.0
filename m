Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v3 1/3] y2038: cobalt/posix/clock: Adding clock_nanosleep64
Date: Tue, 27 Apr 2021 14:40:59 +0800
Message-Id: <1619505659-13846-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org
Cc: chensong <chensong@tj.kylinos.cn>

From: chensong <chensong@tj.kylinos.cn>

Add a syscall specific for clock_nanosleep with 64bit
time_t.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/clock.c     | 30 ++++++++++++++++++++++++++++++
 kernel/cobalt/posix/clock.h     |  9 +++++++++
 kernel/cobalt/posix/syscall32.c |  9 +++++++++
 kernel/cobalt/posix/syscall32.h |  6 ++++++
 5 files changed, 55 insertions(+)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 438af30..acb8260 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -125,6 +125,7 @@
 #define sc_cobalt_sem_timedwait64		102
 #define sc_cobalt_clock_gettime64		103
 #define sc_cobalt_clock_settime64		104
+#define sc_cobalt_clock_nanosleep64		105
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 828895d..9b3a499 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -350,6 +350,36 @@ COBALT_SYSCALL(clock_nanosleep, primary,
 	return ret;
 }
 
+int __cobalt_clock_nanosleep64(clockid_t clock_id, int flags,
+		const struct __kernel_timespec __user *u_rqt,
+		struct __kernel_timespec __user *u_rmt)
+{
+	struct timespec64 rqt, rmt, *rmtp = NULL;
+	int ret;
+
+	if (u_rmt)
+		rmtp = &rmt;
+
+	if (cobalt_get_timespec64(&rqt, u_rqt))
+		return -EFAULT;
+
+	ret = __cobalt_clock_nanosleep(clock_id, flags, &rqt, rmtp);
+	if (ret == -EINTR && flags == 0 && rmtp) {
+		if (cobalt_put_timespec64(rmtp, u_rmt))
+			return -EFAULT;
+	}
+
+	return ret;
+}
+
+COBALT_SYSCALL(clock_nanosleep64, primary,
+	       (clockid_t clock_id, int flags,
+		const struct __kernel_timespec __user *u_rqt,
+		struct __kernel_timespec __user *u_rmt))
+{
+	return __cobalt_clock_nanosleep64(clock_id, flags, u_rqt, u_rmt);
+}
+
 int cobalt_clock_register(struct xnclock *clock, const cpumask_t *affinity,
 			  clockid_t *clk_id)
 {
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 74c71c8..ff8653b 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -116,6 +116,10 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     const struct timespec64 *rqt,
 			     struct timespec64 *rmt);
 
+int __cobalt_clock_nanosleep64(clockid_t clock_id, int flags,
+		const struct __kernel_timespec __user *u_rqt,
+		struct __kernel_timespec __user *u_rmt);
+
 COBALT_SYSCALL_DECL(clock_getres,
 		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
 
@@ -140,6 +144,11 @@ COBALT_SYSCALL_DECL(clock_nanosleep,
 		     const struct __user_old_timespec __user *u_rqt,
 		     struct __user_old_timespec __user *u_rmt));
 
+COBALT_SYSCALL_DECL(clock_nanosleep64,
+		    (clockid_t clock_id, int flags,
+		     const struct __kernel_timespec __user *u_rqt,
+		     struct __kernel_timespec __user *u_rmt));
+
 int cobalt_clock_register(struct xnclock *clock,
 			  const cpumask_t *affinity,
 			  clockid_t *clk_id);
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index e7c0676..35bb454 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -238,6 +238,15 @@ COBALT_SYSCALL32emu(clock_nanosleep, nonrestartable,
 	return ret;
 }
 
+COBALT_SYSCALL32emu(clock_nanosleep64, nonrestartable,
+		    (clockid_t clock_id, int flags,
+		     const struct __kernel_timespec __user *u_rqt,
+		     struct __kernel_timespec __user *u_rmt))
+{
+	return __cobalt_clock_nanosleep64(clock_id, flags, u_rqt, u_rmt);
+}
+
+
 COBALT_SYSCALL32emu(mutex_timedlock, primary,
 		    (struct cobalt_mutex_shadow __user *u_mx,
 		     const struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index ee9cf81..e82596e 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -80,6 +80,12 @@ COBALT_SYSCALL32emu_DECL(clock_nanosleep,
 			  const struct old_timespec32 __user *u_rqt,
 			  struct old_timespec32 __user *u_rmt));
 
+COBALT_SYSCALL32emu_DECL(clock_nanosleep64,
+			 (clockid_t clock_id, int flags,
+			  const struct __kernel_timespec __user *u_rqt,
+			  struct __kernel_timespec __user *u_rmt));
+
+
 COBALT_SYSCALL32emu_DECL(mutex_timedlock,
 			 (struct cobalt_mutex_shadow __user *u_mx,
 			  const struct old_timespec32 __user *u_ts));
-- 
2.7.4


