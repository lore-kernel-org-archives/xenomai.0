From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v5 1/3] y2038: cobalt/posix/io: Adding recvmmsg64
Date: Wed,  6 Oct 2021 15:54:13 +0200
Message-Id: <20211006135415.223689-2-florian.bezdeka@siemens.com>
In-Reply-To: <20211006135415.223689-1-florian.bezdeka@siemens.com>
References: <20211006135415.223689-1-florian.bezdeka@siemens.com>
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

Add a syscall specific for recvmmsg64 with 64bit time_t.

Signed-off-by: Song Chen <chensong_2000@189.cn>
[Florian: Fixed some style issues]
[Florian: Added Song's Signed-off back (malformed patch received)]
[Florian: Fixed tracing infrastructure]
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/rtdm/fd.h    |  5 +++++
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/io.c           |  9 +++++++++
 kernel/cobalt/posix/io.h           |  5 +++++
 kernel/cobalt/posix/syscall32.c    |  9 +++++++++
 kernel/cobalt/posix/syscall32.h    |  6 ++++++
 kernel/cobalt/rtdm/fd.c            | 21 ++++++++++++++++++++-
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 8 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
index 37a09c43e..058a9c638 100644
--- a/include/cobalt/kernel/rtdm/fd.h
+++ b/include/cobalt/kernel/rtdm/fd.h
@@ -382,6 +382,11 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg),
 		       int (*get_timespec)(struct timespec64 *ts, const void __user *u_ts));
 
+int __rtdm_fd_recvmmsg64(int ufd, void __user *u_msgvec, unsigned int vlen,
+			 unsigned int flags, void __user *u_timeout,
+			 int (*get_mmsg)(struct mmsghdr *mmsg, void __user *u_mmsg),
+			 int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg));
+
 ssize_t rtdm_fd_sendmsg(int ufd, const struct user_msghdr *msg,
 			int flags);
 
diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 16edce15d..1523ddd2d 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -134,6 +134,7 @@
 #define sc_cobalt_sigtimedwait64		111
 #define sc_cobalt_monitor_wait64		112
 #define sc_cobalt_event_wait64			113
+#define sc_cobalt_recvmmsg64			114
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 0c17f55bf..0f9c963ad 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -26,6 +26,7 @@
 #include "internal.h"
 #include "clock.h"
 #include "io.h"
+#include <cobalt/kernel/time.h>
 
 COBALT_SYSCALL(open, lostage,
 	       (const char __user *u_path, int oflag))
@@ -121,6 +122,14 @@ COBALT_SYSCALL(recvmmsg, primary,
 				  get_mmsg, put_mmsg, get_timespec);
 }
 
+COBALT_SYSCALL(recvmmsg64, primary,
+	       (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
+		unsigned int flags, struct __kernel_timespec __user *u_timeout))
+{
+	return __rtdm_fd_recvmmsg64(fd, u_msgvec, vlen, flags, u_timeout,
+				    get_mmsg, put_mmsg);
+}
+
 COBALT_SYSCALL(sendmsg, handover,
 	       (int fd, struct user_msghdr __user *umsg, int flags))
 {
diff --git a/kernel/cobalt/posix/io.h b/kernel/cobalt/posix/io.h
index d9f29fa59..842db084e 100644
--- a/kernel/cobalt/posix/io.h
+++ b/kernel/cobalt/posix/io.h
@@ -58,6 +58,11 @@ COBALT_SYSCALL_DECL(recvmmsg,
 		    (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
 		     unsigned int flags, struct __user_old_timespec __user *u_timeout));
 
+COBALT_SYSCALL_DECL(recvmmsg64,
+		    (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
+		     unsigned int flags,
+		     struct __kernel_timespec __user *u_timeout));
+
 COBALT_SYSCALL_DECL(sendmsg,
 		    (int fd, struct user_msghdr __user *umsg, int flags));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 2d88fac83..b0b2785e0 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -860,6 +860,15 @@ COBALT_SYSCALL32emu(recvmmsg, primary,
 				  get_timespec32);
 }
 
+COBALT_SYSCALL32emu(recvmmsg64, primary,
+		    (int ufd, struct compat_mmsghdr __user *u_msgvec,
+		     unsigned int vlen, unsigned int flags,
+		     struct __kernel_timespec *u_timeout))
+{
+	return __rtdm_fd_recvmmsg64(ufd, u_msgvec, vlen, flags, u_timeout,
+				    get_mmsg32, put_mmsg32);
+}
+
 COBALT_SYSCALL32emu(sendmsg, handover,
 		    (int fd, struct compat_msghdr __user *umsg, int flags))
 {
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 3eb66571b..72e32f4f8 100644
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
index 8e4e15e79..c314d9f65 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -28,6 +28,7 @@
 #include <cobalt/kernel/registry.h>
 #include <cobalt/kernel/lock.h>
 #include <cobalt/kernel/ppd.h>
+#include <cobalt/kernel/time.h>
 #include <pipeline/inband_work.h>
 #include <trace/events/cobalt-rtdm.h>
 #include <rtdm/fd.h>
@@ -689,7 +690,7 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 		if (ret)
 			goto fail;
 
-		if ((unsigned long)ts.tv_nsec >= ONE_BILLION) {
+		if (!timespec64_valid(&ts)) {
 			ret = -EINVAL;
 			goto fail;
 		}
@@ -753,6 +754,24 @@ out:
 	return ret;
 }
 
+static inline int __rtdm_fetch_timeout64(struct timespec64 *ts,
+					 const void __user *u_ts)
+{
+	return u_ts == NULL ? -EFAULT : cobalt_get_timespec64(ts, u_ts);
+}
+
+int __rtdm_fd_recvmmsg64(int ufd, void __user *u_msgvec, unsigned int vlen,
+			 unsigned int flags, void __user *u_timeout,
+			 int (*get_mmsg)(struct mmsghdr *mmsg,
+					 void __user *u_mmsg),
+			 int (*put_mmsg)(void __user **u_mmsg_p,
+					 const struct mmsghdr *mmsg))
+{
+	return __rtdm_fd_recvmmsg(ufd, u_msgvec, vlen, flags, u_timeout,
+				  get_mmsg, put_mmsg, __rtdm_fetch_timeout64);
+}
+
+
 ssize_t rtdm_fd_sendmsg(int ufd, const struct user_msghdr *msg, int flags)
 {
 	struct rtdm_fd *fd;
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 45e3cbcf7..2bc004dab 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -166,7 +166,8 @@
 		__cobalt_symbolic_syscall(mq_timedreceive64),		\
 		__cobalt_symbolic_syscall(sigtimedwait64),		\
 		__cobalt_symbolic_syscall(monitor_wait64),		\
-		__cobalt_symbolic_syscall(event_wait64))
+		__cobalt_symbolic_syscall(event_wait64),		\
+		__cobalt_symbolic_syscall(recvmmsg64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
-- 
2.31.1


