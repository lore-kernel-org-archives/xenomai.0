From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH v2 1/5] [y2038] cobalt: posix: clock: Adding clock_settime64
Date: Fri, 12 Mar 2021 12:01:16 +0800
Message-Id: <1615521676-5814-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org, rpm@xenomai.org

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
v2: squash two patches into one
---
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/clock.c     | 12 ++++++++++++
 kernel/cobalt/posix/clock.h     |  4 ++++
 kernel/cobalt/posix/syscall32.c | 13 +++++++++++++
 kernel/cobalt/posix/syscall32.h |  4 ++++
 5 files changed, 34 insertions(+)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 8895d2b..291b550 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -123,6 +123,7 @@
 #define sc_cobalt_clock_adjtime			100
 #define sc_cobalt_thread_setschedprio		101
 #define sc_cobalt_sem_timedwait64		102
+#define sc_cobalt_clock_settime64		103
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 6a47956..9643f8f 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -23,6 +23,7 @@
 #include "thread.h"
 #include "clock.h"
 #include <trace/events/cobalt-posix.h>
+#include <cobalt/kernel/time.h>
 
 static struct xnclock *external_clocks[COBALT_MAX_EXTCLOCKS];
 
@@ -193,6 +194,17 @@ COBALT_SYSCALL(clock_settime, current,
 	return __cobalt_clock_settime(clock_id, &ts);
 }
 
+COBALT_SYSCALL(clock_settime64, current,
+	       (clockid_t clock_id, const struct __kernel_timespec __user *u_ts))
+{
+	struct timespec64 ts64;
+
+	if (cobalt_get_timespec64(&ts64, u_ts))
+		return -EFAULT;
+
+	return __cobalt_clock_settime(clock_id, &ts64);
+}
+
 COBALT_SYSCALL(clock_adjtime, current,
 	       (clockid_t clock_id, struct __user_old_timex __user *u_tx))
 {
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index e69e76e..90f79fa 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -119,6 +119,10 @@ COBALT_SYSCALL_DECL(clock_gettime,
 COBALT_SYSCALL_DECL(clock_settime,
 		    (clockid_t clock_id, const struct __user_old_timespec __user *u_ts));
 
+COBALT_SYSCALL_DECL(clock_settime64,
+		    (clockid_t clock_id,
+			 const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(clock_adjtime,
 		    (clockid_t clock_id, struct __user_old_timex __user *u_tx));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index a5dc6e4..bd698a1 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -35,6 +35,7 @@
 #include "mqueue.h"
 #include "io.h"
 #include "../debug.h"
+#include <cobalt/kernel/time.h>
 
 COBALT_SYSCALL32emu(thread_create, init,
 		    (compat_ulong_t pth,
@@ -184,6 +185,18 @@ COBALT_SYSCALL32emu(clock_settime, current,
 	return __cobalt_clock_settime(clock_id, &ts);
 }
 
+COBALT_SYSCALL32emu(clock_settime64, current,
+		    (clockid_t clock_id,
+		     const struct __kernel_timespec __user *u_ts))
+{
+	struct timespec64 ts64;
+
+	if (cobalt_get_timespec64(&ts64, u_ts))
+		return -EFAULT;
+
+	return __cobalt_clock_settime(clock_id, &ts64);
+}
+
 COBALT_SYSCALL32emu(clock_adjtime, current,
 		    (clockid_t clock_id, struct old_timex32 __user *u_tx))
 {
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 0b5e26d..716c5e3 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -63,6 +63,10 @@ COBALT_SYSCALL32emu_DECL(clock_settime,
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




