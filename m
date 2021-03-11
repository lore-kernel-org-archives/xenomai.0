From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 3/4] [y2038]cobalt: posix: syscall32: Adding compat
 clock_settime64
Date: Thu, 11 Mar 2021 10:46:20 +0800
Message-Id: <1615430780-23779-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org, rpm@xenomai.org

Add a new compat syscall clock_settime64 specific for
timespec64, It can solve y2038 in below scenarios:

1, 64bit kernel, 32bit process, 32bit time_t, go to clock_settime,
no break, y2038 not safe.
3, 64bit kernel, 32bit process, 64bit time_t, go to clock_settime64
by the help of libcobalt, no break, y2038 safe.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 kernel/cobalt/posix/syscall32.c | 13 +++++++++++++
 kernel/cobalt/posix/syscall32.h |  4 ++++
 2 files changed, 17 insertions(+)

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




