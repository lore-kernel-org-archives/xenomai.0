Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v5 1/5] y2038: cobalt/posix/clock: Adding clock_gettime64
Date: Tue, 20 Apr 2021 14:22:51 +0800
Message-Id: <1618899771-13690-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, florian.bezdeka@siemens.com
Cc: chensong <chensong@tj.kylinos.cn>

From: chensong <chensong@tj.kylinos.cn>

Add a syscall specific for clock_gettime with 64bit
time_t.

Signed-off-by: chensong <chensong@tj.kylinos.cn>

---
v5:
1, new helper __cobalt_clock_gettime64
---
 include/cobalt/kernel/time.h    | 11 +++++++++++
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/clock.c     | 23 ++++++++++++++++++++++-
 kernel/cobalt/posix/clock.h     |  6 ++++++
 kernel/cobalt/posix/syscall32.c |  8 ++++++++
 kernel/cobalt/posix/syscall32.h |  4 ++++
 kernel/cobalt/time.c            | 11 +++++++++++
 7 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/time.h b/include/cobalt/kernel/time.h
index 19e8f2c..2890e25 100644
--- a/include/cobalt/kernel/time.h
+++ b/include/cobalt/kernel/time.h
@@ -19,4 +19,15 @@
 int cobalt_get_timespec64(struct timespec64 *ts,
 			  const struct __kernel_timespec __user *uts);
 
+/**
+ * Covert struct timespec64 to struct __kernel_timespec
+ * and copy to userspace
+ *
+ * @param ts The source, provided by kernel
+ * @param uts The destination, will be filled
+ * @return 0 on success, -EFAULT otherwise
+ */
+int cobalt_put_timespec64(const struct timespec64 *ts,
+			   struct __kernel_timespec __user *uts);
+
 #endif //_COBALT_KERNEL_TIME_H
diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 8895d2b..9859963 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -123,6 +123,7 @@
 #define sc_cobalt_clock_adjtime			100
 #define sc_cobalt_thread_setschedprio		101
 #define sc_cobalt_sem_timedwait64		102
+#define sc_cobalt_clock_gettime64		103
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 6a47956..9127013 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -23,6 +23,7 @@
 #include "thread.h"
 #include "clock.h"
 #include <trace/events/cobalt-posix.h>
+#include <cobalt/kernel/time.h>
 
 static struct xnclock *external_clocks[COBALT_MAX_EXTCLOCKS];
 
@@ -134,11 +135,31 @@ COBALT_SYSCALL(clock_gettime, current,
 	if (cobalt_put_u_timespec(u_ts, &ts))
 		return -EFAULT;
 
-	trace_cobalt_clock_gettime(clock_id, &ts);
+	return 0;
+}
+
+int __cobalt_clock_gettime64(clockid_t clock_id,
+			struct __kernel_timespec __user *u_ts)
+{
+	struct timespec64 ts;
+	int ret;
+
+	ret = __cobalt_clock_gettime(clock_id, &ts);
+	if (ret)
+		return ret;
+
+	if (cobalt_put_timespec64(&ts, u_ts))
+		return -EFAULT;
 
 	return 0;
 }
 
+COBALT_SYSCALL(clock_gettime64, current,
+	       (clockid_t clock_id, struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_clock_gettime64(clock_id, u_ts);	
+}
+
 int __cobalt_clock_settime(clockid_t clock_id, const struct timespec64 *ts)
 {
 	int _ret, ret = 0;
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index e69e76e..639f030 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -100,6 +100,9 @@ int __cobalt_clock_getres(clockid_t clock_id,
 int __cobalt_clock_gettime(clockid_t clock_id,
 			   struct timespec64 *ts);
 
+int __cobalt_clock_gettime64(clockid_t clock_id,
+			struct __kernel_timespec __user *u_ts);
+
 int __cobalt_clock_settime(clockid_t clock_id,
 			   const struct timespec64 *ts);
 
@@ -116,6 +119,9 @@ COBALT_SYSCALL_DECL(clock_getres,
 COBALT_SYSCALL_DECL(clock_gettime,
 		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
 
+COBALT_SYSCALL_DECL(clock_gettime64,
+		    (clockid_t clock_id, struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(clock_settime,
 		    (clockid_t clock_id, const struct __user_old_timespec __user *u_ts));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index a5dc6e4..5770ebc 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -35,6 +35,7 @@
 #include "mqueue.h"
 #include "io.h"
 #include "../debug.h"
+#include <cobalt/kernel/time.h>
 
 COBALT_SYSCALL32emu(thread_create, init,
 		    (compat_ulong_t pth,
@@ -170,6 +171,13 @@ COBALT_SYSCALL32emu(clock_gettime, current,
 	return sys32_put_timespec(u_ts, &ts);
 }
 
+COBALT_SYSCALL32emu(clock_gettime64, current,
+		    (clockid_t clock_id,
+		     struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_clock_gettime64(clock_id, u_ts);	
+}
+
 COBALT_SYSCALL32emu(clock_settime, current,
 		    (clockid_t clock_id,
 		     const struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 0b5e26d..68067e6 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -59,6 +59,10 @@ COBALT_SYSCALL32emu_DECL(clock_gettime,
 			 (clockid_t clock_id,
 			  struct old_timespec32 __user *u_ts));
 
+COBALT_SYSCALL32emu_DECL(clock_gettime64,
+			 (clockid_t clock_id,
+			  struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL32emu_DECL(clock_settime,
 			 (clockid_t clock_id,
 			  const struct old_timespec32 __user *u_ts));
diff --git a/kernel/cobalt/time.c b/kernel/cobalt/time.c
index a3fd8a7..4091def 100644
--- a/kernel/cobalt/time.c
+++ b/kernel/cobalt/time.c
@@ -27,3 +27,14 @@ int cobalt_get_timespec64(struct timespec64 *ts,
 
 	return 0;
 }
+
+int cobalt_put_timespec64(const struct timespec64 *ts,
+		   struct __kernel_timespec __user *uts)
+{
+	struct __kernel_timespec kts = {
+		.tv_sec = ts->tv_sec,
+		.tv_nsec = ts->tv_nsec
+	};
+
+	return cobalt_copy_to_user(uts, &kts, sizeof(kts)) ? -EFAULT : 0;
+}
-- 
2.7.4


