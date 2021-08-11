From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 1/3] y2038: cobalt/posix/monitor: Adding monitor_wait64
Date: Wed, 11 Aug 2021 10:11:18 +0200
Message-Id: <20210811081120.18402-2-florian.bezdeka@siemens.com>
In-Reply-To: <20210811081120.18402-1-florian.bezdeka@siemens.com>
References: <20210811081120.18402-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Adding monitor_wait64. Patch is based on v1 sent out by Song and was
re-worked to apply on top of current next/master.

__cobalt_monitor_wait() is now validating the struct timespec64 it
received from userland. That was not the case up to now.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/monitor.c      | 32 +++++++++++++++++++++++++++++-
 kernel/cobalt/posix/monitor.h      | 10 ++++++++++
 kernel/cobalt/posix/syscall32.c    |  8 ++++++++
 kernel/cobalt/posix/syscall32.h    |  6 ++++++
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 6 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 4de7e59d0..e49110f5d 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -132,6 +132,7 @@
 #define sc_cobalt_mq_timedsend64		109
 #define sc_cobalt_mq_timedreceive64		110
 #define sc_cobalt_sigtimedwait64		111
+#define sc_cobalt_monitor_wait64		112
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/monitor.c b/kernel/cobalt/posix/monitor.c
index b907e0050..0d0213273 100644
--- a/kernel/cobalt/posix/monitor.c
+++ b/kernel/cobalt/posix/monitor.c
@@ -20,6 +20,7 @@
 #include "clock.h"
 #include "monitor.h"
 #include <trace/events/cobalt-posix.h>
+#include <cobalt/kernel/time.h>
 
 /*
  * The Cobalt monitor is a double-wait condition object, serializing
@@ -218,8 +219,12 @@ int __cobalt_monitor_wait(struct cobalt_monitor_shadow __user *u_mon,
 
 	handle = cobalt_get_handle_from_user(&u_mon->handle);
 
-	if (ts)
+	if (ts) {
+		if (!timespec64_valid(ts))
+			return -EINVAL;
+
 		timeout = ts2ns(ts) + 1;
+	}
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -289,6 +294,24 @@ out:
 	return ret;
 }
 
+int __cobalt_monitor_wait64(struct cobalt_monitor_shadow __user *u_mon,
+			    int event,
+			    const struct __kernel_timespec __user *u_ts,
+			    int __user *u_ret)
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
 COBALT_SYSCALL(monitor_wait, nonrestartable,
 	       (struct cobalt_monitor_shadow __user *u_mon,
 	       int event, const struct __user_old_timespec __user *u_ts,
@@ -307,6 +330,13 @@ COBALT_SYSCALL(monitor_wait, nonrestartable,
 	return __cobalt_monitor_wait(u_mon, event, tsp, u_ret);
 }
 
+COBALT_SYSCALL(monitor_wait64, nonrestartable,
+	       (struct cobalt_monitor_shadow __user *u_mon, int event,
+		const struct __kernel_timespec __user *u_ts, int __user *u_ret))
+{
+	return __cobalt_monitor_wait64(u_mon, event, u_ts, u_ret);
+}
+
 COBALT_SYSCALL(monitor_sync, nonrestartable,
 	       (struct cobalt_monitor_shadow __user *u_mon))
 {
diff --git a/kernel/cobalt/posix/monitor.h b/kernel/cobalt/posix/monitor.h
index d4a4aa24e..bf8794e36 100644
--- a/kernel/cobalt/posix/monitor.h
+++ b/kernel/cobalt/posix/monitor.h
@@ -42,6 +42,11 @@ int __cobalt_monitor_wait(struct cobalt_monitor_shadow __user *u_mon,
 			  int event, const struct timespec64 *ts,
 			  int __user *u_ret);
 
+int __cobalt_monitor_wait64(struct cobalt_monitor_shadow __user *u_mon,
+			    int event,
+			    const struct __kernel_timespec __user *u_ts,
+			    int __user *u_ret);
+
 COBALT_SYSCALL_DECL(monitor_init,
 		    (struct cobalt_monitor_shadow __user *u_monsh,
 		     clockid_t clk_id,
@@ -61,6 +66,11 @@ COBALT_SYSCALL_DECL(monitor_wait,
 		     int event, const struct __user_old_timespec __user *u_ts,
 		     int __user *u_ret));
 
+COBALT_SYSCALL_DECL(monitor_wait64,
+		    (struct cobalt_monitor_shadow __user *u_monsh, int event,
+		     const struct __kernel_timespec __user *u_ts,
+		     int __user *u_ret));
+
 COBALT_SYSCALL_DECL(monitor_destroy,
 		    (struct cobalt_monitor_shadow __user *u_monsh));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 79fc365fc..e6c9831b9 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -768,6 +768,14 @@ COBALT_SYSCALL32emu(monitor_wait, nonrestartable,
 	return __cobalt_monitor_wait(u_mon, event, tsp, u_ret);
 }
 
+COBALT_SYSCALL32emu(monitor_wait64, nonrestartable,
+		    (struct cobalt_monitor_shadow __user *u_mon, int event,
+		     const struct __kernel_timespec __user *u_ts,
+		     int __user *u_ret))
+{
+	return __cobalt_monitor_wait64(u_mon, event, u_ts, u_ret);
+}
+
 COBALT_SYSCALL32emu(event_wait, primary,
 		    (struct cobalt_event_shadow __user *u_event,
 		     unsigned int bits,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index cf295ed5e..a2ef67808 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -218,6 +218,12 @@ COBALT_SYSCALL32emu_DECL(monitor_wait,
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
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 5d14d851f..221e25037 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -164,7 +164,8 @@
 		__cobalt_symbolic_syscall(mutex_timedlock64),		\
 		__cobalt_symbolic_syscall(mq_timedsend64),  		\
 		__cobalt_symbolic_syscall(mq_timedreceive64),		\
-		__cobalt_symbolic_syscall(sigtimedwait64))
+		__cobalt_symbolic_syscall(sigtimedwait64),		\
+		__cobalt_symbolic_syscall(monitor_wait64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
-- 
2.30.2


