Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 1/3] y2038: cobalt/posix/event: Adding event_wait64
Date: Tue, 27 Jul 2021 14:55:30 +0800
Message-Id: <1627368930-12676-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

Add a syscall specific for event_wait with 64bit
time_t.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/event.c     | 37 +++++++++++++++++++++++++++++++++----
 kernel/cobalt/posix/event.h     | 12 ++++++++++++
 kernel/cobalt/posix/syscall32.c |  9 +++++++++
 kernel/cobalt/posix/syscall32.h |  7 +++++++
 5 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index e49110f..16edce1 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -133,6 +133,7 @@
 #define sc_cobalt_mq_timedreceive64		110
 #define sc_cobalt_sigtimedwait64		111
 #define sc_cobalt_monitor_wait64		112
+#define sc_cobalt_event_wait64			113
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/event.c b/kernel/cobalt/posix/event.c
index 3712154..4001a18 100644
--- a/kernel/cobalt/posix/event.c
+++ b/kernel/cobalt/posix/event.c
@@ -20,6 +20,7 @@
 #include "clock.h"
 #include "event.h"
 #include <trace/events/cobalt-posix.h>
+#include <cobalt/kernel/time.h>
 
 /*
  * Cobalt event notification services
@@ -119,9 +120,9 @@ int __cobalt_event_wait(struct cobalt_event_shadow __user *u_event,
 	handle = cobalt_get_handle_from_user(&u_event->handle);
 
 	if (ts) {
-		if ((unsigned long)ts->tv_nsec >= ONE_BILLION)
+		if (!timespec64_valid(ts))
 			return -EINVAL;
-	
+
 		timeout = ts2ns(ts);
 		if (timeout) {
 			timeout++;
@@ -208,6 +209,33 @@ COBALT_SYSCALL(event_wait, primary,
 	return __cobalt_event_wait(u_event, bits, u_bits_r, mode, tsp);
 }
 
+int __cobalt_event_wait64(struct cobalt_event_shadow __user *u_event,
+		unsigned int bits,
+		unsigned int __user *u_bits_r,
+		int mode, const struct __kernel_timespec __user *u_ts)
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
+	return __cobalt_event_wait(u_event, bits, u_bits_r, mode, tsp);
+}
+
+COBALT_SYSCALL(event_wait64, primary,
+	       (struct cobalt_event_shadow __user *u_event,
+		unsigned int bits,
+		unsigned int __user *u_bits_r,
+		int mode, const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_event_wait64(u_event, bits, u_bits_r, mode, u_ts);
+}
+
 COBALT_SYSCALL(event_sync, current,
 	       (struct cobalt_event_shadow __user *u_event))
 {
@@ -278,7 +306,7 @@ COBALT_SYSCALL(event_destroy, current,
 	}
 
 	cobalt_event_reclaim(&event->resnode, s); /* drops lock */
-	
+
 	return 0;
 }
 
@@ -360,7 +388,8 @@ COBALT_SYSCALL(event_inquire, current,
 
 	ret = cobalt_copy_to_user(u_info, &info, sizeof(info));
 	if (ret == 0 && nrwait > 0)
-		ret = cobalt_copy_to_user(u_waitlist, t, nrwait * sizeof(pid_t));
+		ret = cobalt_copy_to_user(u_waitlist, t,
+					nrwait * sizeof(pid_t));
 
 	if (t && t != fbuf)
 		xnfree(t);
diff --git a/kernel/cobalt/posix/event.h b/kernel/cobalt/posix/event.h
index ef592f7..b1dc61f 100644
--- a/kernel/cobalt/posix/event.h
+++ b/kernel/cobalt/posix/event.h
@@ -41,6 +41,11 @@ int __cobalt_event_wait(struct cobalt_event_shadow __user *u_event,
 			unsigned int __user *u_bits_r,
 			int mode, const struct timespec64 *ts);
 
+int __cobalt_event_wait64(struct cobalt_event_shadow __user *u_event,
+		unsigned int bits,
+		unsigned int __user *u_bits_r,
+		int mode, const struct __kernel_timespec __user *u_ts);
+
 COBALT_SYSCALL_DECL(event_init,
 		    (struct cobalt_event_shadow __user *u_evtsh,
 		     unsigned int value,
@@ -53,6 +58,13 @@ COBALT_SYSCALL_DECL(event_wait,
 		     int mode,
 		     const struct __user_old_timespec __user *u_ts));
 
+COBALT_SYSCALL_DECL(event_wait64,
+		    (struct cobalt_event_shadow __user *u_evtsh,
+		     unsigned int bits,
+		     unsigned int __user *u_bits_r,
+		     int mode,
+		     const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(event_sync,
 		    (struct cobalt_event_shadow __user *u_evtsh));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 4102431..f3f3382 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -797,6 +797,15 @@ COBALT_SYSCALL32emu(event_wait, primary,
 	return __cobalt_event_wait(u_event, bits, u_bits_r, mode, tsp);
 }
 
+COBALT_SYSCALL32emu(event_wait64, primary,
+		    (struct cobalt_event_shadow __user *u_event,
+		     unsigned int bits,
+		     unsigned int __user *u_bits_r,
+		     int mode, const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_event_wait64(u_event, bits, u_bits_r, mode, u_ts);
+}
+
 COBALT_SYSCALL32emu(select, nonrestartable,
 		    (int nfds,
 		     compat_fd_set __user *u_rfds,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 4c27d66..db05821 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -231,6 +231,13 @@ COBALT_SYSCALL32emu_DECL(event_wait,
 			  unsigned int __user *u_bits_r,
 			  int mode, const struct old_timespec32 __user *u_ts));
 
+COBALT_SYSCALL32emu_DECL(event_wait64,
+			 (struct cobalt_event_shadow __user *u_event,
+			  unsigned int bits,
+			  unsigned int __user *u_bits_r,
+			  int mode,
+			  const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL32emu_DECL(select,
 			 (int nfds,
 			  compat_fd_set __user *u_rfds,
-- 
2.7.4


