From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 22 Jun 2018 17:42:34 +0200
Message-Id: <9a97e904888a800492b05b62cc69c3a1c3a98574.1529682156.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1529682156.git.jan.kiszka@siemens.com>
References: <cover.1529682156.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1529682156.git.jan.kiszka@siemens.com>
References: <cover.1529682156.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 2/4] cobalt/posix: Convert put_siginfo callback
	into boolean
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

We want to pass the information "compat invocation" to the extension
signal_copyinfo as well and therefore need it in boolean form. To avoid
unneeded conversions, pass it as bool from the source to the sink.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/signal.c    | 33 ++++++++++++++++-----------------
 kernel/cobalt/posix/signal.h    |  8 ++------
 kernel/cobalt/posix/syscall32.c |  4 ++--
 3 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index a71bb1085b..c29b45ebd5 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -17,6 +17,7 @@
  */
 #include <linux/sched.h>
 #include <cobalt/kernel/assert.h>
+#include <cobalt/kernel/compat.h>
 #include "internal.h"
 #include "signal.h"
 #include "thread.h"
@@ -233,10 +234,7 @@ static int signal_put_siginfo(void __user *u_si, const struct siginfo *si,
 }
 
 static int signal_wait(sigset_t *set, xnticks_t timeout,
-		       void __user *u_si,
-		       int (*put_siginfo)(void __user *u_si,
-					  const struct siginfo *si,
-					  int overrun))
+		       void __user *u_si, bool compat)
 {
 	struct cobalt_sigpending *sigp = NULL;
 	struct cobalt_sigwait_context swc;
@@ -338,7 +336,12 @@ done:
 	if (u_si == NULL)
 		goto out;	/* Return signo only. */
 
-	ret = put_siginfo(u_si, sip, overrun);
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	if (compat)
+		ret = sys32_put_siginfo(u_si, sip, overrun);
+	else
+#endif
+		ret = signal_put_siginfo(u_si, sip, overrun);
 	if (ret)
 		goto out;
 
@@ -368,7 +371,7 @@ fail:
 
 int __cobalt_sigwait(sigset_t *set)
 {
-	return signal_wait(set, XN_INFINITE, NULL, NULL);
+	return signal_wait(set, XN_INFINITE, NULL, false);
 }
 
 COBALT_SYSCALL(sigwait, primary,
@@ -380,7 +383,7 @@ COBALT_SYSCALL(sigwait, primary,
 	if (cobalt_copy_from_user(&set, u_set, sizeof(set)))
 		return -EFAULT;
 
-	sig = signal_wait(&set, XN_INFINITE, NULL, NULL);
+	sig = signal_wait(&set, XN_INFINITE, NULL, false);
 	if (sig < 0)
 		return sig;
 
@@ -390,9 +393,7 @@ COBALT_SYSCALL(sigwait, primary,
 int __cobalt_sigtimedwait(sigset_t *set,
 			  const struct timespec *timeout,
 			  void __user *u_si,
-			  int (*put_siginfo)(void __user *u_si,
-					     const struct siginfo *si,
-					     int overrun))
+			  bool compat)
 {
 	xnticks_t ticks;
 
@@ -403,7 +404,7 @@ int __cobalt_sigtimedwait(sigset_t *set,
 	if (ticks++ == 0)
 		ticks = XN_NONBLOCK;
 
-	return signal_wait(set, ticks, u_si, put_siginfo);
+	return signal_wait(set, ticks, u_si, compat);
 }
 
 COBALT_SYSCALL(sigtimedwait, nonrestartable,
@@ -420,16 +421,14 @@ COBALT_SYSCALL(sigtimedwait, nonrestartable,
 	if (cobalt_copy_from_user(&timeout, u_timeout, sizeof(timeout)))
 		return -EFAULT;
 
-	return __cobalt_sigtimedwait(&set, &timeout, u_si, signal_put_siginfo);
+	return __cobalt_sigtimedwait(&set, &timeout, u_si, false);
 }
 
 int __cobalt_sigwaitinfo(sigset_t *set,
 			 void __user *u_si,
-			 int (*put_siginfo)(void __user *u_si,
-					    const struct siginfo *si,
-					    int overrun))
+			 bool compat)
 {
-	return signal_wait(set, XN_INFINITE, u_si, put_siginfo);
+	return signal_wait(set, XN_INFINITE, u_si, compat);
 }
 
 COBALT_SYSCALL(sigwaitinfo, nonrestartable,
@@ -440,7 +439,7 @@ COBALT_SYSCALL(sigwaitinfo, nonrestartable,
 	if (cobalt_copy_from_user(&set, u_set, sizeof(set)))
 		return -EFAULT;
 
-	return __cobalt_sigwaitinfo(&set, u_si, signal_put_siginfo);
+	return __cobalt_sigwaitinfo(&set, u_si, false);
 }
 
 COBALT_SYSCALL(sigpending, primary, (old_sigset_t __user *u_set))
diff --git a/kernel/cobalt/posix/signal.h b/kernel/cobalt/posix/signal.h
index 993c48b99b..a4edc094f8 100644
--- a/kernel/cobalt/posix/signal.h
+++ b/kernel/cobalt/posix/signal.h
@@ -61,15 +61,11 @@ int __cobalt_sigwait(sigset_t *set);
 int __cobalt_sigtimedwait(sigset_t *set,
 			  const struct timespec *timeout,
 			  void __user *u_si,
-			  int (*put_siginfo)(void __user *u_si,
-					     const struct siginfo *si,
-					     int overrun));
+			  bool compat);
 
 int __cobalt_sigwaitinfo(sigset_t *set,
 			 void __user *u_si,
-			 int (*put_siginfo)(void __user *u_si,
-					    const struct siginfo *si,
-					    int overrun));
+			 bool compat);
 
 int __cobalt_sigqueue(pid_t pid, int sig, const union sigval *value);
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 9559991d7c..a2482b7a00 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -613,7 +613,7 @@ COBALT_SYSCALL32emu(sigtimedwait, nonrestartable,
 	if (ret)
 		return ret;
 
-	return __cobalt_sigtimedwait(&set, &timeout, u_si, sys32_put_siginfo);
+	return __cobalt_sigtimedwait(&set, &timeout, u_si, true);
 }
 
 COBALT_SYSCALL32emu(sigwaitinfo, nonrestartable,
@@ -627,7 +627,7 @@ COBALT_SYSCALL32emu(sigwaitinfo, nonrestartable,
 	if (ret)
 		return ret;
 
-	return __cobalt_sigwaitinfo(&set, u_si, sys32_put_siginfo);
+	return __cobalt_sigwaitinfo(&set, u_si, true);
 }
 
 COBALT_SYSCALL32emu(sigpending, primary, (compat_old_sigset_t __user *u_set))
-- 
2.13.7


