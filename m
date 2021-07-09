Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 1/3] y2038: cobalt/posix/signal: Adding sigtimedwait64
Date: Fri,  9 Jul 2021 15:09:57 +0800
Message-Id: <1625814597-22478-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

Add a syscall specific for sigtimedwait with 64bit
time_t.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/signal.c    | 23 ++++++++++++++++++++---
 kernel/cobalt/posix/signal.h    |  5 +++++
 kernel/cobalt/posix/syscall32.c | 21 +++++++++++++++++++++
 kernel/cobalt/posix/syscall32.h |  5 +++++
 5 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index c27d6d0..4de7e59 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -131,6 +131,7 @@
 #define sc_cobalt_mutex_timedlock64		108
 #define sc_cobalt_mq_timedsend64		109
 #define sc_cobalt_mq_timedreceive64		110
+#define sc_cobalt_sigtimedwait64		111
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index 0b43b5f..c7110ef 100644
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
@@ -306,7 +307,8 @@ wait:
 	ret = xnsynch_sleep_on(&curr->sigwait, timeout, XN_RELATIVE);
 	if (ret) {
 		list_del(&curr->signext);
-		ret = ret & XNBREAK ? -EINTR : -EAGAIN;
+		ret = ret & XNTIMEO ?
+			-ETIMEDOUT : (ret & XNBREAK ? -EINTR : -EAGAIN);
 		goto fail;
 	}
 	sig = si.si_signo;
@@ -413,9 +415,8 @@ int __cobalt_sigtimedwait(sigset_t *set,
 {
 	xnticks_t ticks;
 
-	if ((unsigned long)timeout->tv_nsec >= ONE_BILLION)
+	if (!timespec64_valid(timeout))
 		return -EINVAL;
-
 	ticks = ts2ns(timeout);
 	if (ticks++ == 0)
 		ticks = XN_NONBLOCK;
@@ -440,6 +441,22 @@ COBALT_SYSCALL(sigtimedwait, nonrestartable,
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
 int __cobalt_sigwaitinfo(sigset_t *set,
 			 void __user *u_si,
 			 bool compat)
diff --git a/kernel/cobalt/posix/signal.h b/kernel/cobalt/posix/signal.h
index fc26ad0..121db8f 100644
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
index e24c96a..7e47c63 100644
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
@@ -698,6 +699,26 @@ COBALT_SYSCALL32emu(sigtimedwait, nonrestartable,
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
index 3a551b9..d29ff4d 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -198,6 +198,11 @@ COBALT_SYSCALL32emu_DECL(sigtimedwait,
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
-- 
2.7.4


