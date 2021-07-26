Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 1/3] y2038: cobalt/posix/monitor: Adding monitor_wait64
Date: Mon, 26 Jul 2021 15:16:23 +0800
Message-Id: <1627283783-3962-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

Add a syscall specific for monitor_wait with 64bit
time_t.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 include/cobalt/uapi/syscall.h   |  2 +-
 kernel/cobalt/posix/monitor.c   | 31 ++++++++++++++++++++++++++++++-
 kernel/cobalt/posix/monitor.h   |  9 +++++++++
 kernel/cobalt/posix/syscall32.c |  8 ++++++++
 kernel/cobalt/posix/syscall32.h |  6 ++++++
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index aaa6dd6..e49110f 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -132,7 +132,7 @@
 #define sc_cobalt_mq_timedsend64		109
 #define sc_cobalt_mq_timedreceive64		110
 #define sc_cobalt_sigtimedwait64		111
+#define sc_cobalt_monitor_wait64		112
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/monitor.c b/kernel/cobalt/posix/monitor.c
index b907e00..2fb4db1 100644
--- a/kernel/cobalt/posix/monitor.c
+++ b/kernel/cobalt/posix/monitor.c
@@ -20,6 +20,7 @@
 #include "clock.h"
 #include "monitor.h"
 #include <trace/events/cobalt-posix.h>
+#include <cobalt/kernel/time.h>
 
 /*
  * The Cobalt monitor is a double-wait condition object, serializing
@@ -218,8 +219,11 @@ int __cobalt_monitor_wait(struct cobalt_monitor_shadow __user *u_mon,
 
 	handle = cobalt_get_handle_from_user(&u_mon->handle);
 
-	if (ts)
+	if (ts) {
+		if (!timespec64_valid(ts))
+			return -EINVAL;
 		timeout = ts2ns(ts) + 1;
+	}
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -307,6 +311,31 @@ COBALT_SYSCALL(monitor_wait, nonrestartable,
 	return __cobalt_monitor_wait(u_mon, event, tsp, u_ret);
 }
 
+int __cobalt_monitor_wait64(struct cobalt_monitor_shadow __user *u_mon,
+	       int event, const struct __kernel_timespec __user *u_ts,
+	       int __user *u_ret)
+{
+	struct timespec64 ts, *tsp = NULL;
+	int ret;
+
+	if (u_ts) {
+		tsp = &ts;
+		ret = cobalt_get_timespec64(&ts, u_ts);
+		if (ret)
+			return ret;
+	}
+
+	return __cobalt_monitor_wait(u_mon, event, tsp, u_ret);
+}
+
+COBALT_SYSCALL(monitor_wait64, nonrestartable,
+	       (struct cobalt_monitor_shadow __user *u_mon,
+	       int event, const struct __kernel_timespec __user *u_ts,
+	       int __user *u_ret))
+{
+	return __cobalt_monitor_wait64(u_mon, event, u_ts, u_ret);
+}
+
 COBALT_SYSCALL(monitor_sync, nonrestartable,
 	       (struct cobalt_monitor_shadow __user *u_mon))
 {
diff --git a/kernel/cobalt/posix/monitor.h b/kernel/cobalt/posix/monitor.h
index d4a4aa2..e101077 100644
--- a/kernel/cobalt/posix/monitor.h
+++ b/kernel/cobalt/posix/monitor.h
@@ -42,6 +42,10 @@ int __cobalt_monitor_wait(struct cobalt_monitor_shadow __user *u_mon,
 			  int event, const struct timespec64 *ts,
 			  int __user *u_ret);
 
+int __cobalt_monitor_wait64(struct cobalt_monitor_shadow __user *u_mon,
+	       int event, const struct __kernel_timespec __user *u_ts,
+	       int __user *u_ret);
+
 COBALT_SYSCALL_DECL(monitor_init,
 		    (struct cobalt_monitor_shadow __user *u_monsh,
 		     clockid_t clk_id,
@@ -61,6 +65,11 @@ COBALT_SYSCALL_DECL(monitor_wait,
 		     int event, const struct __user_old_timespec __user *u_ts,
 		     int __user *u_ret));
 
+COBALT_SYSCALL_DECL(monitor_wait64,
+		    (struct cobalt_monitor_shadow __user *u_monsh,
+		     int event, const struct __kernel_timespec __user *u_ts,
+		     int __user *u_ret));
+
 COBALT_SYSCALL_DECL(monitor_destroy,
 		    (struct cobalt_monitor_shadow __user *u_monsh));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index f93b30c..f3f3382 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -770,6 +770,14 @@ COBALT_SYSCALL32emu(monitor_wait, nonrestartable,
 	return __cobalt_monitor_wait(u_mon, event, tsp, u_ret);
 }
 
+COBALT_SYSCALL32emu(monitor_wait64, nonrestartable,
+		    (struct cobalt_monitor_shadow __user *u_mon,
+		     int event, const struct __kernel_timespec __user *u_ts,
+		     int __user *u_ret))
+{
+	return __cobalt_monitor_wait64(u_mon, event, u_ts, u_ret);
+}
+
 COBALT_SYSCALL32emu(event_wait, primary,
 		    (struct cobalt_event_shadow __user *u_event,
 		     unsigned int bits,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index bddd4de..872f999 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -219,6 +219,12 @@ COBALT_SYSCALL32emu_DECL(monitor_wait,
 			  int event, const struct old_timespec32 __user *u_ts,
 			  int __user *u_ret));
 
+COBALT_SYSCALL32emu_DECL(monitor_wait64,
+			 (struct cobalt_monitor_shadow __user *u_mon,
+			  int event,
+			  const struct __kernel_timespec __user *u_ts,
+			  int __user *u_ret));
+
 COBALT_SYSCALL32emu_DECL(event_wait,
 			 (struct cobalt_event_shadow __user *u_event,
 			  unsigned int bits,
-- 
2.7.4


