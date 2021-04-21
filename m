Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v5 2/5] y2038: cobalt/posix/clock: Adding clock_settime64
Date: Wed, 21 Apr 2021 16:33:24 +0800
Message-Id: <1618994004-21119-1-git-send-email-chensong_2000@189.cn>
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

Adding a new syscall clock_settime64 specific for timespec64,
It can solve y2038 in below scenarios:

1, 64bit kernel, 64bit process, no break. y2038 safe
2, 32bit kernel, 32bit process, 32bit time_t, go to clock_settime,
no break, y2038 not safe.
3, 32bit kernel, 32bit process, 64bit time_t, go to clock_settime64
by the help of libcobalt, no break, y2038 safe.
4, 64bit kernel, 32bit process, 32bit time_t, go to clock_settime,
no break, y2038 not safe.
5, 64bit kernel, 32bit process, 64bit time_t, go to clock_settime64
by the help of libcobalt, no break, y2038 safe.

Signed-off-by: chensong <chensong@tj.kylinos.cn>

---
v5:
1, new helper __cobalt_clock_settime64
---
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/clock.c     | 17 +++++++++++++++++
 kernel/cobalt/posix/clock.h     |  7 +++++++
 kernel/cobalt/posix/syscall32.c |  7 +++++++
 kernel/cobalt/posix/syscall32.h |  4 ++++
 5 files changed, 36 insertions(+)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 9859963..438af30 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -124,6 +124,7 @@
 #define sc_cobalt_thread_setschedprio		101
 #define sc_cobalt_sem_timedwait64		102
 #define sc_cobalt_clock_gettime64		103
+#define sc_cobalt_clock_settime64		104
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 9127013..ca5f266 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -214,6 +214,23 @@ COBALT_SYSCALL(clock_settime, current,
 	return __cobalt_clock_settime(clock_id, &ts);
 }
 
+int __cobalt_clock_settime64(clockid_t clock_id,
+			const struct __kernel_timespec __user *u_ts)
+{
+	struct timespec64 ts64;
+
+	if (cobalt_get_timespec64(&ts64, u_ts))
+		return -EFAULT;
+
+	return __cobalt_clock_settime(clock_id, &ts64);
+}
+
+COBALT_SYSCALL(clock_settime64, current,
+	       (clockid_t clock_id, const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_clock_settime64(clock_id, u_ts);
+}
+
 COBALT_SYSCALL(clock_adjtime, current,
 	       (clockid_t clock_id, struct __user_old_timex __user *u_tx))
 {
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 639f030..74c71c8 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -106,6 +106,9 @@ int __cobalt_clock_gettime64(clockid_t clock_id,
 int __cobalt_clock_settime(clockid_t clock_id,
 			   const struct timespec64 *ts);
 
+int __cobalt_clock_settime64(clockid_t clock_id,
+			const struct __kernel_timespec __user *u_ts);
+
 int __cobalt_clock_adjtime(clockid_t clock_id,
 			   struct __kernel_timex *tx);
 
@@ -125,6 +128,10 @@ COBALT_SYSCALL_DECL(clock_gettime64,
 COBALT_SYSCALL_DECL(clock_settime,
 		    (clockid_t clock_id, const struct __user_old_timespec __user *u_ts));
 
+COBALT_SYSCALL_DECL(clock_settime64,
+		    (clockid_t clock_id,
+			 const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(clock_adjtime,
 		    (clockid_t clock_id, struct __user_old_timex __user *u_tx));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 5770ebc..e84e56c 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -192,6 +192,13 @@ COBALT_SYSCALL32emu(clock_settime, current,
 	return __cobalt_clock_settime(clock_id, &ts);
 }
 
+COBALT_SYSCALL32emu(clock_settime64, current,
+		    (clockid_t clock_id,
+		     const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_clock_settime64(clock_id, u_ts);
+}
+
 COBALT_SYSCALL32emu(clock_adjtime, current,
 		    (clockid_t clock_id, struct old_timex32 __user *u_tx))
 {
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 68067e6..9095ebd 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -67,6 +67,10 @@ COBALT_SYSCALL32emu_DECL(clock_settime,
 			 (clockid_t clock_id,
 			  const struct old_timespec32 __user *u_ts));
 
+COBALT_SYSCALL32emu_DECL(clock_settime64,
+			 (clockid_t clock_id,
+			  const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL32emu_DECL(clock_adjtime,
 			 (clockid_t clock_id,
 			  struct old_timex32 __user *u_tx));
-- 
2.7.4


