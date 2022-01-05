From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 1/7] y2038: cobalt/posix/cond: Adding cond_wait_prologue64
Date: Wed,  5 Jan 2022 15:06:44 +0100
Message-Id: <20220105140650.1033850-2-florian.bezdeka@siemens.com>
In-Reply-To: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
References: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
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

Add a syscall specific for cond_wait_prologue64 with 64bit time_t.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/cond.c         | 26 ++++++++++++++++++++++++++
 kernel/cobalt/posix/cond.h         | 13 +++++++++++++
 kernel/cobalt/posix/syscall32.c    | 10 ++++++++++
 kernel/cobalt/posix/syscall32.h    |  7 +++++++
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 6 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 1523ddd2d..9646a0d97 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -135,6 +135,7 @@
 #define sc_cobalt_monitor_wait64		112
 #define sc_cobalt_event_wait64			113
 #define sc_cobalt_recvmmsg64			114
+#define sc_cobalt_cond_wait_prologue64		115
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/cond.c b/kernel/cobalt/posix/cond.c
index bb18fe316..28400505f 100644
--- a/kernel/cobalt/posix/cond.c
+++ b/kernel/cobalt/posix/cond.c
@@ -21,6 +21,7 @@
 #include "mutex.h"
 #include "cond.h"
 #include "clock.h"
+#include <cobalt/kernel/time.h>
 #include <trace/events/cobalt-posix.h>
 
 static inline int
@@ -276,6 +277,12 @@ static inline int cond_fetch_timeout(struct timespec64 *ts,
 	return u_ts == NULL ? -EFAULT :	cobalt_get_u_timespec(ts, u_ts);
 }
 
+static inline int cond_fetch_timeout64(struct timespec64 *ts,
+				       const void __user *u_ts)
+{
+	return u_ts == NULL ? -EFAULT : cobalt_get_timespec64(ts, u_ts);
+}
+
 int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 				struct cobalt_mutex_shadow __user *u_mx,
 				int *u_err,
@@ -342,6 +349,15 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 	return err == 0 ? perr : err;
 }
 
+int __cobalt_cond_wait_prologue64(struct cobalt_cond_shadow __user *u_cnd,
+				  struct cobalt_mutex_shadow __user *u_mx,
+				  int *u_err, unsigned int timed,
+				  void __user *u_ts)
+{
+	return __cobalt_cond_wait_prologue(u_cnd, u_mx, u_err, u_ts,
+					   timed ? cond_fetch_timeout64 : NULL);
+}
+
 /* pthread_cond_wait_prologue(cond, mutex, count_ptr, timed, timeout) */
 COBALT_SYSCALL(cond_wait_prologue, nonrestartable,
 	       (struct cobalt_cond_shadow __user *u_cnd,
@@ -354,6 +370,16 @@ COBALT_SYSCALL(cond_wait_prologue, nonrestartable,
 					   timed ? cond_fetch_timeout : NULL);
 }
 
+COBALT_SYSCALL(cond_wait_prologue64, nonrestartable,
+	       (struct cobalt_cond_shadow __user *u_cnd,
+		struct cobalt_mutex_shadow __user *u_mx,
+		int *u_err,
+		unsigned int timed,
+		struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_cond_wait_prologue64(u_cnd, u_mx, u_err, timed, u_ts);
+}
+
 COBALT_SYSCALL(cond_wait_epilogue, primary,
 	       (struct cobalt_cond_shadow __user *u_cnd,
 		struct cobalt_mutex_shadow __user *u_mx))
diff --git a/kernel/cobalt/posix/cond.h b/kernel/cobalt/posix/cond.h
index 7bec2a649..b087b189e 100644
--- a/kernel/cobalt/posix/cond.h
+++ b/kernel/cobalt/posix/cond.h
@@ -45,6 +45,12 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 				void __user *u_ts,
 				int (*fetch_timeout)(struct timespec64 *ts,
 						     const void __user *u_ts));
+
+int __cobalt_cond_wait_prologue64(struct cobalt_cond_shadow __user *u_cnd,
+				  struct cobalt_mutex_shadow __user *u_mx,
+				  int *u_err, unsigned int timed,
+				  void __user *u_ts);
+
 COBALT_SYSCALL_DECL(cond_init,
 		    (struct cobalt_cond_shadow __user *u_cnd,
 		     const struct cobalt_condattr __user *u_attr));
@@ -59,6 +65,13 @@ COBALT_SYSCALL_DECL(cond_wait_prologue,
 		     unsigned int timed,
 		     struct __user_old_timespec __user *u_ts));
 
+COBALT_SYSCALL_DECL(cond_wait_prologue64,
+		    (struct cobalt_cond_shadow __user *u_cnd,
+		     struct cobalt_mutex_shadow __user *u_mx,
+		     int *u_err,
+		     unsigned int timed,
+		     struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(cond_wait_epilogue,
 		    (struct cobalt_cond_shadow __user *u_cnd,
 		     struct cobalt_mutex_shadow __user *u_mx));
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 266789611..fbd2b7f79 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -286,6 +286,16 @@ COBALT_SYSCALL32emu(cond_wait_prologue, nonrestartable,
 					   timed ? sys32_fetch_timeout : NULL);
 }
 
+COBALT_SYSCALL32emu(cond_wait_prologue64, nonrestartable,
+		    (struct cobalt_cond_shadow __user *u_cnd,
+		     struct cobalt_mutex_shadow __user *u_mx,
+		     int *u_err,
+		     unsigned int timed,
+		     struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_cond_wait_prologue64(u_cnd, u_mx, u_err, timed, u_ts);
+}
+
 COBALT_SYSCALL32emu(mq_open, lostage,
 		    (const char __user *u_name, int oflags,
 		     mode_t mode, struct compat_mq_attr __user *u_attr))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 72e32f4f8..cdaa903ea 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -109,6 +109,13 @@ COBALT_SYSCALL32emu_DECL(cond_wait_prologue,
 			  unsigned int timed,
 			  struct old_timespec32 __user *u_ts));
 
+COBALT_SYSCALL32emu_DECL(cond_wait_prologue64,
+			 (struct cobalt_cond_shadow __user *u_cnd,
+			  struct cobalt_mutex_shadow __user *u_mx,
+			  int *u_err,
+			  unsigned int timed,
+			  struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL32emu_DECL(mq_open,
 			 (const char __user *u_name, int oflags,
 			  mode_t mode, struct compat_mq_attr __user *u_attr));
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 2bc004dab..c7eef7fba 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -167,7 +167,8 @@
 		__cobalt_symbolic_syscall(sigtimedwait64),		\
 		__cobalt_symbolic_syscall(monitor_wait64),		\
 		__cobalt_symbolic_syscall(event_wait64),		\
-		__cobalt_symbolic_syscall(recvmmsg64))
+		__cobalt_symbolic_syscall(recvmmsg64),			\
+		__cobalt_symbolic_syscall(cond_wait_prologue64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
-- 
2.30.2


