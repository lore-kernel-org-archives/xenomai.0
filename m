From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 1/3] y2038: cobalt/posix/signal: Adding sigtimedwait64
Date: Tue, 10 Aug 2021 17:27:09 +0200
Message-Id: <20210810152711.227714-2-florian.bezdeka@siemens.com>
In-Reply-To: <20210810152711.227714-1-florian.bezdeka@siemens.com>
References: <20210810152711.227714-1-florian.bezdeka@siemens.com>
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

Add a syscall specific for sigtimedwait with 64bit
time_t.

Signed-off-by: Song Chen <chensong_2000@189.cn>
[Florian: Tracing, fix return value EAGAIN vs. ETIMEOUT]
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/signal.c       | 21 +++++++++++++++++++--
 kernel/cobalt/posix/signal.h       |  5 +++++
 kernel/cobalt/posix/syscall32.c    | 21 +++++++++++++++++++++
 kernel/cobalt/posix/syscall32.h    |  5 +++++
 kernel/cobalt/trace/cobalt-posix.h |  4 ++--
 6 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index c27d6d044..4de7e59d0 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -131,6 +131,7 @@
 #define sc_cobalt_mutex_timedlock64		108
 #define sc_cobalt_mq_timedsend64		109
 #define sc_cobalt_mq_timedreceive64		110
+#define sc_cobalt_sigtimedwait64		111
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index 0b43b5fcf..e3ba3abcf 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <cobalt/kernel/assert.h>
 #include <cobalt/kernel/compat.h>
+#include <cobalt/kernel/time.h>
 #include "internal.h"
 #include "signal.h"
 #include "thread.h"
@@ -413,9 +414,8 @@ int __cobalt_sigtimedwait(sigset_t *set,
 {
 	xnticks_t ticks;
 
-	if ((unsigned long)timeout->tv_nsec >= ONE_BILLION)
+	if (!timespec64_valid(timeout))
 		return -EINVAL;
-
 	ticks = ts2ns(timeout);
 	if (ticks++ == 0)
 		ticks = XN_NONBLOCK;
@@ -440,6 +440,23 @@ COBALT_SYSCALL(sigtimedwait, nonrestartable,
 	return __cobalt_sigtimedwait(&set, &timeout, u_si, false);
 }
 
+COBALT_SYSCALL(sigtimedwait64, nonrestartable,
+	       (const sigset_t __user *u_set,
+		struct siginfo __user *u_si,
+		const struct __kernel_timespec __user *u_timeout))
+{
+	struct timespec64 timeout;
+	sigset_t set;
+
+	if (cobalt_copy_from_user(&set, u_set, sizeof(set)))
+		return -EFAULT;
+
+	if (cobalt_get_timespec64(&timeout, u_timeout))
+		return -EFAULT;
+
+	return __cobalt_sigtimedwait(&set, &timeout, u_si, false);
+}
+
 int __cobalt_sigwaitinfo(sigset_t *set,
 			 void __user *u_si,
 			 bool compat)
diff --git a/kernel/cobalt/posix/signal.h b/kernel/cobalt/posix/signal.h
index fc26ad065..121db8f9b 100644
--- a/kernel/cobalt/posix/signal.h
+++ b/kernel/cobalt/posix/signal.h
@@ -96,6 +96,11 @@ COBALT_SYSCALL_DECL(sigtimedwait,
 		     struct siginfo __user *u_si,
 		     const struct __user_old_timespec __user *u_timeout));
 
+COBALT_SYSCALL_DECL(sigtimedwait64,
+		    (const sigset_t __user *u_set,
+		     struct siginfo __user *u_si,
+		     const struct __kernel_timespec __user *u_timeout));
+
 COBALT_SYSCALL_DECL(sigwaitinfo,
 		    (const sigset_t __user *u_set,
 		     struct siginfo __user *u_si));
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index d52be0207..79fc365fc 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <cobalt/uapi/syscall.h>
+#include <cobalt/kernel/time.h>
 #include <xenomai/rtdm/internal.h>
 #include "internal.h"
 #include "syscall32.h"
@@ -696,6 +697,26 @@ COBALT_SYSCALL32emu(sigtimedwait, nonrestartable,
 	return __cobalt_sigtimedwait(&set, &timeout, u_si, true);
 }
 
+COBALT_SYSCALL32emu(sigtimedwait64, nonrestartable,
+		    (const compat_sigset_t __user *u_set,
+		     struct compat_siginfo __user *u_si,
+		     const struct __kernel_timespec __user *u_timeout))
+{
+	struct timespec64 timeout;
+	sigset_t set;
+	int ret;
+
+	ret = sys32_get_sigset(&set, u_set);
+	if (ret)
+		return ret;
+
+	ret = cobalt_get_timespec64(&timeout, u_timeout);
+	if (ret)
+		return ret;
+
+	return __cobalt_sigtimedwait(&set, &timeout, u_si, true);
+}
+
 COBALT_SYSCALL32emu(sigwaitinfo, nonrestartable,
 		    (const compat_sigset_t __user *u_set,
 		     struct compat_siginfo __user *u_si))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 006054e85..cf295ed5e 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -197,6 +197,11 @@ COBALT_SYSCALL32emu_DECL(sigtimedwait,
 			  struct compat_siginfo __user *u_si,
 			  const struct old_timespec32 __user *u_timeout));
 
+COBALT_SYSCALL32emu_DECL(sigtimedwait64,
+			 (const compat_sigset_t __user *u_set,
+			  struct compat_siginfo __user *u_si,
+			  const struct __kernel_timespec __user *u_timeout));
+
 COBALT_SYSCALL32emu_DECL(sigwaitinfo,
 			 (const compat_sigset_t __user *u_set,
 			  struct compat_siginfo __user *u_si));
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index b046c8a0e..5d14d851f 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -163,8 +163,8 @@
 		__cobalt_symbolic_syscall(clock_adjtime64),		\
 		__cobalt_symbolic_syscall(mutex_timedlock64),		\
 		__cobalt_symbolic_syscall(mq_timedsend64),  		\
-		__cobalt_symbolic_syscall(mq_timedreceive64))
-
+		__cobalt_symbolic_syscall(mq_timedreceive64),		\
+		__cobalt_symbolic_syscall(sigtimedwait64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
-- 
2.30.2


