From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 1/3] y2038: cobalt/posix/clock: Adding clock_nanosleep64
Date: Wed, 31 Mar 2021 11:26:00 +0800
Message-Id: <1617161160-27144-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org, rpm@xenomai.org

Add a syscall specific for clock_nanosleep with 64bit
time_t.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/clock.c     | 23 +++++++++++++++++++++++
 kernel/cobalt/posix/clock.h     |  5 +++++
 kernel/cobalt/posix/syscall32.c | 23 +++++++++++++++++++++++
 kernel/cobalt/posix/syscall32.h |  6 ++++++
 5 files changed, 58 insertions(+)

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
index f0f9fb4..5be89ad 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -338,6 +338,29 @@ COBALT_SYSCALL(clock_nanosleep, primary,
 	return ret;
 }
 
+COBALT_SYSCALL(clock_nanosleep64, primary,
+	       (clockid_t clock_id, int flags,
+		const struct __kernel_timespec __user *u_rqt,
+		struct __kernel_timespec __user *u_rmt))
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
 int cobalt_clock_register(struct xnclock *clock, const cpumask_t *affinity,
 			  clockid_t *clk_id)
 {
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index fa07c56..f248578 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -134,6 +134,11 @@ COBALT_SYSCALL_DECL(clock_nanosleep,
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
index 1a1b830..eb83c57 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -250,6 +250,29 @@ COBALT_SYSCALL32emu(clock_nanosleep, nonrestartable,
 	return ret;
 }
 
+COBALT_SYSCALL32emu(clock_nanosleep64, nonrestartable,
+		    (clockid_t clock_id, int flags,
+		     const struct __kernel_timespec __user *u_rqt,
+		     struct __kernel_timespec __user *u_rmt))
+{
+	struct timespec64 rqt, rmt, *rmtp = NULL;
+	int ret;
+
+	if (u_rmt)
+		rmtp = &rmt;
+
+	ret = cobalt_get_timespec64(&rqt, u_rqt);
+	if (ret)
+		return ret;
+
+	ret = __cobalt_clock_nanosleep(clock_id, flags, &rqt, rmtp);
+	if (ret == -EINTR && flags == 0 && rmtp)
+		ret = cobalt_put_timespec64(rmtp, u_rmt);
+
+	return ret;
+}
+
+
 COBALT_SYSCALL32emu(mutex_timedlock, primary,
 		    (struct cobalt_mutex_shadow __user *u_mx,
 		     const struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 9095ebd..6c20da1 100644
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




