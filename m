From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 4/5] kernel/cobalt/posix/syscall32:introduce old_timespec32
 and __kernel_timespec to clock_settime of syscall32
Date: Tue,  3 Nov 2020 11:05:23 +0800
Message-Id: <1604372723-2941-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com, henning.schild@siemens.com

1, introduce old_timespec32 for 32bit process with 32bit timespec
2, implement clock_settime64 for 32bit process with 64bit timespec

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 include/cobalt/kernel/compat.h  |  6 ++++++
 kernel/cobalt/posix/compat.c    | 20 ++++++++++++++++++++
 kernel/cobalt/posix/syscall32.c | 20 +++++++++++++++++---
 kernel/cobalt/posix/syscall32.h |  6 +++++-
 4 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
index 05754cb..adf8bae 100644
--- a/include/cobalt/kernel/compat.h
+++ b/include/cobalt/kernel/compat.h
@@ -89,6 +89,12 @@ struct compat_rtdm_mmap_request {
 int sys32_get_timespec(struct timespec *ts,
 		       const struct compat_timespec __user *cts);
 
+int sys32_get_timespec_old(struct timespec64 *ts,
+		       const struct old_timespec32 __user *cts);
+
+int sys32_get_timespec64(struct timespec64 *ts,
+		       const struct __kernel_timespec __user *cts);
+
 int sys32_put_timespec(struct compat_timespec __user *cts,
 		       const struct timespec *ts);
 
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index 17968bf..3042dc0 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -32,6 +32,26 @@ int sys32_get_timespec(struct timespec *ts,
 }
 EXPORT_SYMBOL_GPL(sys32_get_timespec);
 
+int sys32_get_timespec_old(struct timespec64 *ts,
+		       const struct old_timespec32 __user *cts)
+{
+	return (cts == NULL ||
+		!access_rok(cts, sizeof(*cts)) ||
+		__xn_get_user(ts->tv_sec, &cts->tv_sec) ||
+		__xn_get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
+}
+EXPORT_SYMBOL_GPL(sys32_get_timespec_old);
+
+int sys32_get_timespec64(struct timespec64 *ts,
+		       const struct __kernel_timespec __user *cts)
+{
+	return (cts == NULL ||
+		!access_rok(cts, sizeof(*cts)) ||
+		__xn_get_user(ts->tv_sec, &cts->tv_sec) ||
+		__xn_get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
+}
+EXPORT_SYMBOL_GPL(sys32_get_timespec64);
+
 int sys32_put_timespec(struct compat_timespec __user *cts,
 		       const struct timespec *ts)
 {
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index faa7ef5..47a8ad3 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -159,12 +159,26 @@ COBALT_SYSCALL32emu(clock_gettime, current,
 
 COBALT_SYSCALL32emu(clock_settime, current,
 		    (clockid_t clock_id,
-		     const struct compat_timespec __user *u_ts))
+		     const struct old_timespec32 __user *u_ts))
 {
-	struct timespec ts;
+	struct timespec64 ts;
+	int ret;
+
+	ret = sys32_get_timespec_old(&ts, u_ts);
+	if (ret)
+		return ret;
+
+	return __cobalt_clock_settime(clock_id, &ts);
+}
+
+COBALT_SYSCALL32emu(clock_settime64, current,
+		    (clockid_t clock_id,
+		     const struct __kernel_timespec __user *u_ts))
+{
+	struct timespec64 ts;
 	int ret;
 
-	ret = sys32_get_timespec(&ts, u_ts);
+	ret = sys32_get_timespec64(&ts, u_ts);
 	if (ret)
 		return ret;
 
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 34904f9..32b87c4 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -57,7 +57,11 @@ COBALT_SYSCALL32emu_DECL(clock_getres,
 
 COBALT_SYSCALL32emu_DECL(clock_gettime,
 			 (clockid_t clock_id,
-			  struct compat_timespec __user *u_ts));
+			  struct old_timespec32 __user *u_ts));
+
+COBALT_SYSCALL32emu_DECL(clock_settime64,
+			 (clockid_t clock_id,
+			  const struct __kernel_timespec __user *u_ts));
 
 COBALT_SYSCALL32emu_DECL(clock_settime,
 			 (clockid_t clock_id,
-- 
2.7.4




