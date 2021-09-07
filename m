Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 1/3] y2038: cobalt/posix/io: Adding recvmmsg64
Date: Tue,  7 Sep 2021 15:11:18 +0800
Message-Id: <1630998678-22249-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

Add a syscall specific for recvmmsg64 with 64bit time_t.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/io.c        | 15 +++++++++++++++
 kernel/cobalt/posix/io.h        |  5 +++++
 kernel/cobalt/posix/syscall32.c | 16 ++++++++++++++++
 kernel/cobalt/posix/syscall32.h |  6 ++++++
 kernel/cobalt/rtdm/fd.c         |  2 +-
 6 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 16edce1..1523ddd 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -134,6 +134,7 @@
 #define sc_cobalt_sigtimedwait64		111
 #define sc_cobalt_monitor_wait64		112
 #define sc_cobalt_event_wait64			113
+#define sc_cobalt_recvmmsg64			114
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 0c17f55..e71c81e 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -26,6 +26,7 @@
 #include "internal.h"
 #include "clock.h"
 #include "io.h"
+#include <cobalt/kernel/time.h>
 
 COBALT_SYSCALL(open, lostage,
 	       (const char __user *u_path, int oflag))
@@ -94,6 +95,12 @@ COBALT_SYSCALL(recvmsg, handover,
 	return cobalt_copy_to_user(umsg, &m, sizeof(*umsg)) ?: ret;
 }
 
+static int get_timespec64_xeno(struct timespec64 *ts,
+			const void __user *u_ts)
+{
+	return cobalt_get_timespec64(ts, u_ts);
+}
+
 static int get_timespec(struct timespec64 *ts,
 			const void __user *u_ts)
 {
@@ -121,6 +128,14 @@ COBALT_SYSCALL(recvmmsg, primary,
 				  get_mmsg, put_mmsg, get_timespec);
 }
 
+COBALT_SYSCALL(recvmmsg64, primary,
+	       (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
+		unsigned int flags, struct __kernel_timespec __user *u_timeout))
+{
+	return __rtdm_fd_recvmmsg(fd, u_msgvec, vlen, flags, u_timeout,
+				  get_mmsg, put_mmsg, get_timespec64_xeno);
+}
+
 COBALT_SYSCALL(sendmsg, handover,
 	       (int fd, struct user_msghdr __user *umsg, int flags))
 {
diff --git a/kernel/cobalt/posix/io.h b/kernel/cobalt/posix/io.h
index d9f29fa..635fc57 100644
--- a/kernel/cobalt/posix/io.h
+++ b/kernel/cobalt/posix/io.h
@@ -58,6 +58,11 @@ COBALT_SYSCALL_DECL(recvmmsg,
 		    (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
 		     unsigned int flags, struct __user_old_timespec __user *u_timeout));
 
+COBALT_SYSCALL_DECL(recvmmsg64,
+		    (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
+		     unsigned int flags,
+			 struct __kernel_timespec __user *u_timeout));
+
 COBALT_SYSCALL_DECL(sendmsg,
 		    (int fd, struct user_msghdr __user *umsg, int flags));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 2d88fac..f9dadea 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -838,6 +838,12 @@ static int get_timespec32(struct timespec64 *ts,
 	return sys32_get_timespec(ts, u_ts);
 }
 
+static int get_timespec64_xeno(struct timespec64 *ts,
+			  const void __user *u_ts)
+{
+	return cobalt_get_timespec64(ts, u_ts);
+}
+
 static int get_mmsg32(struct mmsghdr *mmsg, void __user *u_mmsg)
 {
 	return sys32_get_mmsghdr(mmsg, u_mmsg);
@@ -860,6 +866,16 @@ COBALT_SYSCALL32emu(recvmmsg, primary,
 				  get_timespec32);
 }
 
+COBALT_SYSCALL32emu(recvmmsg64, primary,
+	       (int ufd, struct compat_mmsghdr __user *u_msgvec,
+			unsigned int vlen, unsigned int flags,
+			struct __kernel_timespec *u_timeout))
+{
+	return __rtdm_fd_recvmmsg(ufd, u_msgvec, vlen, flags, u_timeout,
+				  get_mmsg32, put_mmsg32,
+				  get_timespec64_xeno);
+}
+
 COBALT_SYSCALL32emu(sendmsg, handover,
 		    (int fd, struct compat_msghdr __user *umsg, int flags))
 {
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 3eb6657..72e32f4 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -253,6 +253,12 @@ COBALT_SYSCALL32emu_DECL(recvmmsg,
 			  unsigned int vlen,
 			  unsigned int flags, struct old_timespec32 *u_timeout));
 
+COBALT_SYSCALL32emu_DECL(recvmmsg64,
+			 (int fd, struct compat_mmsghdr __user *u_msgvec,
+			  unsigned int vlen,
+			  unsigned int flags,
+			  struct __kernel_timespec *u_timeout));
+
 COBALT_SYSCALL32emu_DECL(sendmsg,
 			 (int fd, struct compat_msghdr __user *umsg,
 			  int flags));
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index 8e4e15e..99beb4e 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -689,7 +689,7 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 		if (ret)
 			goto fail;
 
-		if ((unsigned long)ts.tv_nsec >= ONE_BILLION) {
+		if (!timespec64_valid(&ts)) {
 			ret = -EINVAL;
 			goto fail;
 		}
-- 
2.7.4


