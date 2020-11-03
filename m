From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 3/5] kernel/cobalt: introduct clock_settime64
Date: Tue,  3 Nov 2020 11:05:07 +0800
Message-Id: <1604372707-2897-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com, henning.schild@siemens.com

Implement a new syscall, clock_settime64  specific for
processes with 64bit timespec.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 include/cobalt/uapi/syscall.h                        |  1 +
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h |  8 ++++++++
 kernel/cobalt/posix/clock.c                          | 16 ++++++++++++++++
 kernel/cobalt/posix/clock.h                          |  4 ++++
 4 files changed, 29 insertions(+)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index aa3c308..07e6ecd 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -122,6 +122,7 @@
 #define sc_cobalt_sendmmsg			99
 #define sc_cobalt_clock_adjtime			100
 #define sc_cobalt_thread_setschedprio		101
+#define sc_cobalt_clock_settime64			102
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 07faa26..5214933 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -165,4 +165,12 @@ struct old_timespec32 {
 };
 #endif /* < 4.19 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 18, 0)
+typedef long long __kernel_time64_t;
+struct __kernel_timespec {
+	__kernel_time64_t       tv_sec;                 /* seconds */
+	long long               tv_nsec;                /* nanoseconds */
+};
+#endif /* < 4.18 */
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index d169ffd..120e1ec 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -257,6 +257,22 @@ COBALT_SYSCALL(clock_settime, current,
 	return __cobalt_clock_settime(clock_id, &ts64);
 }
 
+COBALT_SYSCALL(clock_settime64, current,
+	       (clockid_t clock_id,
+			const struct __kernel_timespec __user *u_ts))
+{
+	struct __kernel_timespec kts;
+	struct timespec64 ts64;
+
+	if (cobalt_copy_from_user(&kts, u_ts, sizeof(kts)))
+		return -EFAULT;
+
+	ts64.tv_sec  = kts.tv_sec;
+	ts64.tv_nsec = kts.tv_nsec;
+
+	return __cobalt_clock_settime(clock_id, &ts64);
+}
+
 COBALT_SYSCALL(clock_adjtime, current,
 	       (clockid_t clock_id, struct timex __user *u_tx))
 {
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index bcc608e..5387e17 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -115,6 +115,10 @@ COBALT_SYSCALL_DECL(clock_settime,
 		    (clockid_t clock_id,
 			 const struct old_timespec32 __user *u_ts));
 
+COBALT_SYSCALL_DECL(clock_settime64,
+		    (clockid_t clock_id,
+			 const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(clock_adjtime,
 		    (clockid_t clock_id, struct timex __user *u_tx));
 
-- 
2.7.4




