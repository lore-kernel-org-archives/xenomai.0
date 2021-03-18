From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH v3 1/5] y2038: cobalt/posix/clock: Adding clock_gettime64
Date: Thu, 18 Mar 2021 15:35:20 +0800
Message-Id: <1616052920-21921-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org, rpm@xenomai.org

Add a syscall specific for clock_gettime with 64bit
time_t.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 include/cobalt/kernel/time.h    | 11 +++++++++++
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/clock.c     | 16 +++++++++++++++-
 kernel/cobalt/posix/clock.h     |  3 +++
 kernel/cobalt/posix/syscall32.c | 14 ++++++++++++++
 kernel/cobalt/posix/syscall32.h |  4 ++++
 kernel/cobalt/time.c            | 11 +++++++++++
 7 files changed, 59 insertions(+), 1 deletion(-)

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
index 6a47956..bc7dc1f 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -134,7 +134,21 @@ COBALT_SYSCALL(clock_gettime, current,
 	if (cobalt_put_u_timespec(u_ts, &ts))
 		return -EFAULT;
 
-	trace_cobalt_clock_gettime(clock_id, &ts);
+	return 0;
+}
+
+COBALT_SYSCALL(clock_gettime64, current,
+	       (clockid_t clock_id, struct __kernel_timespec __user *u_ts))
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
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index e69e76e..3d636dc 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -116,6 +116,9 @@ COBALT_SYSCALL_DECL(clock_getres,
 COBALT_SYSCALL_DECL(clock_gettime,
 		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
 
+COBALT_SYSCALL_DECL(clock_gettime64,
+		    (clockid_t clock_id, struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(clock_settime,
 		    (clockid_t clock_id, const struct __user_old_timespec __user *u_ts));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index a5dc6e4..cc9852b 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -170,6 +170,20 @@ COBALT_SYSCALL32emu(clock_gettime, current,
 	return sys32_put_timespec(u_ts, &ts);
 }
 
+COBALT_SYSCALL32emu(clock_gettime64, current,
+		    (clockid_t clock_id,
+		     struct __kernel_timespec __user *u_ts))
+{
+	struct timespec64 ts;
+	int ret;
+
+	ret = __cobalt_clock_gettime(clock_id, &ts);
+	if (ret)
+		return ret;
+
+	return cobalt_put_timespec64(&ts, u_ts);
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





