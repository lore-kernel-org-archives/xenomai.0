From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v3 1/5] y2038: cobalt/posix/mqueue: Adding mq_timedsend64
Date: Tue, 10 Aug 2021 12:24:47 +0200
Message-Id: <20210810102451.49642-2-florian.bezdeka@siemens.com>
In-Reply-To: <20210810102451.49642-1-florian.bezdeka@siemens.com>
References: <20210810102451.49642-1-florian.bezdeka@siemens.com>
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

From: Song Chen <chensong_2000@189.cn>

Add a syscall specific for mq_timedsend with 64bit time_t.

Signed-off-by: Song Chen <chensong_2000@189.cn>
[Florian: Reformat commit msg, relocate code, tracing, fix compat decl]
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/mqueue.c       | 23 ++++++++++++++++++++++-
 kernel/cobalt/posix/mqueue.h       |  8 ++++++++
 kernel/cobalt/posix/syscall32.c    |  8 ++++++++
 kernel/cobalt/posix/syscall32.h    |  5 +++++
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 6 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 6fe57c7e8..464e170cc 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -129,6 +129,7 @@
 #define sc_cobalt_clock_getres64		106
 #define sc_cobalt_clock_adjtime64		107
 #define sc_cobalt_mutex_timedlock64		108
+#define sc_cobalt_mq_timedsend64		109
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index dd8acd55b..a1828919c 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -29,6 +29,7 @@
 #include "mqueue.h"
 #include "clock.h"
 #include <trace/events/cobalt-posix.h>
+#include <cobalt/kernel/time.h>
 
 #define COBALT_MSGMAX		65536
 #define COBALT_MSGSIZEMAX	(16*1024*1024)
@@ -499,7 +500,7 @@ redo:
 		ret = fetch_timeout(&ts, u_ts);
 		if (ret)
 			return ERR_PTR(ret);
-		if ((unsigned long)ts.tv_nsec >= ONE_BILLION)
+		if (!timespec64_valid(&ts))
 			return ERR_PTR(-EINVAL);
 		to = ts2ns(&ts) + 1;
 		tmode = XN_REALTIME;
@@ -889,6 +890,12 @@ static inline int mq_fetch_timeout(struct timespec64 *ts,
 	return u_ts == NULL ? -EFAULT : cobalt_get_u_timespec(ts, u_ts);
 }
 
+static inline int mq_fetch_timeout64(struct timespec64 *ts,
+				     const void __user *u_ts)
+{
+	return u_ts == NULL ? -EFAULT : cobalt_get_timespec64(ts, u_ts);
+}
+
 int __cobalt_mq_timedsend(mqd_t uqd, const void __user *u_buf, size_t len,
 			  unsigned int prio, const void __user *u_ts,
 			  int (*fetch_timeout)(struct timespec64 *ts,
@@ -933,6 +940,13 @@ out:
 	return ret;
 }
 
+int __cobalt_mq_timedsend64(mqd_t uqd, const void __user *u_buf, size_t len,
+			    unsigned int prio, const void __user *u_ts)
+{
+	return __cobalt_mq_timedsend(uqd, u_buf, len, prio, u_ts,
+				     u_ts ? mq_fetch_timeout64 : NULL);
+}
+
 COBALT_SYSCALL(mq_timedsend, primary,
 	       (mqd_t uqd, const void __user *u_buf, size_t len,
 		unsigned int prio, const struct __user_old_timespec __user *u_ts))
@@ -941,6 +955,13 @@ COBALT_SYSCALL(mq_timedsend, primary,
 				     u_ts, u_ts ? mq_fetch_timeout : NULL);
 }
 
+COBALT_SYSCALL(mq_timedsend64, primary,
+	       (mqd_t uqd, const void __user *u_buf, size_t len,
+		unsigned int prio, const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_mq_timedsend64(uqd, u_buf, len, prio, u_ts);
+}
+
 int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
 			     ssize_t *lenp,
 			     unsigned int __user *u_prio,
diff --git a/kernel/cobalt/posix/mqueue.h b/kernel/cobalt/posix/mqueue.h
index d33220227..f16774a3b 100644
--- a/kernel/cobalt/posix/mqueue.h
+++ b/kernel/cobalt/posix/mqueue.h
@@ -40,6 +40,9 @@ int __cobalt_mq_timedsend(mqd_t uqd, const void __user *u_buf, size_t len,
 			  int (*fetch_timeout)(struct timespec64 *ts,
 					       const void __user *u_ts));
 
+int __cobalt_mq_timedsend64(mqd_t uqd, const void __user *u_buf, size_t len,
+			    unsigned int prio, const void __user *u_ts);
+
 int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
 			     ssize_t *lenp,
 			     unsigned int __user *u_prio,
@@ -63,6 +66,11 @@ COBALT_SYSCALL_DECL(mq_timedsend,
 		    (mqd_t uqd, const void __user *u_buf, size_t len,
 		     unsigned int prio, const struct __user_old_timespec __user *u_ts));
 
+COBALT_SYSCALL_DECL(mq_timedsend64,
+		    (mqd_t uqd, const void __user *u_buf, size_t len,
+		     unsigned int prio,
+		     const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(mq_timedreceive,
 		    (mqd_t uqd, void __user *u_buf, ssize_t __user *u_len,
 		     unsigned int __user *u_prio,
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index bd30decce..d3f87c246 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -324,6 +324,14 @@ COBALT_SYSCALL32emu(mq_timedsend, primary,
 				     u_ts, u_ts ? sys32_fetch_timeout : NULL);
 }
 
+COBALT_SYSCALL32emu(mq_timedsend64, primary,
+		    (mqd_t uqd, const void __user *u_buf, size_t len,
+		     unsigned int prio,
+		     const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_mq_timedsend64(uqd, u_buf, len, prio, u_ts);
+}
+
 COBALT_SYSCALL32emu(mq_timedreceive, primary,
 		    (mqd_t uqd, void __user *u_buf,
 		     compat_ssize_t __user *u_len,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index d464d967f..0e552202e 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -121,6 +121,11 @@ COBALT_SYSCALL32emu_DECL(mq_timedsend,
 			  unsigned int prio,
 			  const struct old_timespec32 __user *u_ts));
 
+COBALT_SYSCALL32emu_DECL(mq_timedsend64,
+			 (mqd_t uqd, const void __user *u_buf, size_t len,
+			  unsigned int prio,
+			  const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL32emu_DECL(mq_timedreceive,
 			 (mqd_t uqd, void __user *u_buf,
 			  compat_ssize_t __user *u_len,
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 71c5116fb..d67a6ce09 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -161,7 +161,8 @@
 		__cobalt_symbolic_syscall(clock_nanosleep64),		\
 		__cobalt_symbolic_syscall(clock_getres64),		\
 		__cobalt_symbolic_syscall(clock_adjtime64),		\
-		__cobalt_symbolic_syscall(mutex_timedlock64))
+		__cobalt_symbolic_syscall(mutex_timedlock64),		\
+		__cobalt_symbolic_syscall(mq_timedsend64))
 
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
-- 
2.30.2


