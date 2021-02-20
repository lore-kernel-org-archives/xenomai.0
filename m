From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/5] cobalt/kernel: y2038: convert struct timeval to
 __kernel_old_timeval
Date: Sat, 20 Feb 2021 16:18:36 +0100
Message-Id: <20210220151840.409745-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Philippe Gerum <rpm@xenomai.org>

As internal interfaces are gradually being made y2038-safe, the
deprecated timeval type is now available as __kernel_old_timeval in
the mainline kernel for the sake of clarity. Switch to this type until
Cobalt is y2038-safe as well.

A wrapper is provided to build on older kernels not defining
__kernel_old_timeval yet.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/compat.h                       | 4 ++--
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 ++++
 kernel/cobalt/posix/clock.h                          | 4 ++--
 kernel/cobalt/posix/compat.c                         | 4 ++--
 kernel/cobalt/posix/io.c                             | 6 +++---
 kernel/cobalt/posix/io.h                             | 2 +-
 kernel/cobalt/posix/syscall32.c                      | 2 +-
 kernel/drivers/ipc/bufp.c                            | 5 +++--
 kernel/drivers/ipc/iddp.c                            | 5 +++--
 kernel/drivers/ipc/internal.h                        | 9 +++++----
 kernel/drivers/ipc/rtipc.c                           | 9 +++++----
 kernel/drivers/ipc/xddp.c                            | 5 +++--
 kernel/drivers/net/stack/ipv4/tcp/tcp.c              | 2 +-
 13 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
index c9cb84f72..313b6251b 100644
--- a/include/cobalt/kernel/compat.h
+++ b/include/cobalt/kernel/compat.h
@@ -98,11 +98,11 @@ int sys32_get_itimerspec(struct itimerspec *its,
 int sys32_put_itimerspec(struct compat_itimerspec __user *cits,
 			 const struct itimerspec *its);
 
-int sys32_get_timeval(struct timeval *tv,
+int sys32_get_timeval(struct __kernel_old_timeval *tv,
 		      const struct compat_timeval __user *ctv);
 
 int sys32_put_timeval(struct compat_timeval __user *ctv,
-		      const struct timeval *tv);
+		      const struct __kernel_old_timeval *tv);
 
 int sys32_get_timex(struct timex *tx,
 		    const struct old_timex32 __user *ctx);
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index e093676e1..2e9fb203a 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -162,4 +162,8 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define mmiowb()		do { } while (0)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
+#define __kernel_old_timeval	timeval
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 0b06b9316..7cb161df2 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -43,7 +43,7 @@ static inline xnticks_t ts2ns(const struct timespec *ts)
 	return nsecs;
 }
 
-static inline xnticks_t tv2ns(const struct timeval *tv)
+static inline xnticks_t tv2ns(const struct __kernel_old_timeval *tv)
 {
 	xnticks_t nsecs = tv->tv_usec * 1000;
 
@@ -53,7 +53,7 @@ static inline xnticks_t tv2ns(const struct timeval *tv)
 	return nsecs;
 }
 
-static inline void ticks2tv(struct timeval *tv, xnticks_t ticks)
+static inline void ticks2tv(struct __kernel_old_timeval *tv, xnticks_t ticks)
 {
 	unsigned long nsecs;
 
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index e53e72e0c..2ffc0dbdf 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -60,7 +60,7 @@ int sys32_put_itimerspec(struct compat_itimerspec __user *cits,
 }
 EXPORT_SYMBOL_GPL(sys32_put_itimerspec);
 
-int sys32_get_timeval(struct timeval *tv,
+int sys32_get_timeval(struct __kernel_old_timeval *tv,
 		      const struct compat_timeval __user *ctv)
 {
 	return (ctv == NULL ||
@@ -71,7 +71,7 @@ int sys32_get_timeval(struct timeval *tv,
 EXPORT_SYMBOL_GPL(sys32_get_timeval);
 
 int sys32_put_timeval(struct compat_timeval __user *ctv,
-		      const struct timeval *tv)
+		      const struct __kernel_old_timeval *tv)
 {
 	return (ctv == NULL ||
 		!access_wok(ctv, sizeof(*ctv)) ||
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index f35aaf8cd..e9908feeb 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -212,13 +212,13 @@ int __cobalt_select_bind_all(struct xnselector *selector,
 	return 0;
 }
 
-/* int select(int, fd_set *, fd_set *, fd_set *, struct timeval *) */
+/* int select(int, fd_set *, fd_set *, fd_set *, struct __kernel_old_timeval *) */
 COBALT_SYSCALL(select, primary,
 	       (int nfds,
 		fd_set __user *u_rfds,
 		fd_set __user *u_wfds,
 		fd_set __user *u_xfds,
-		struct timeval __user *u_tv))
+		struct __kernel_old_timeval __user *u_tv))
 {
 	fd_set __user *ufd_sets[XNSELECT_MAX_TYPES] = {
 		[XNSELECT_READ] = u_rfds,
@@ -234,7 +234,7 @@ COBALT_SYSCALL(select, primary,
 	xntmode_t mode = XN_RELATIVE;
 	struct xnselector *selector;
 	struct xnthread *curr;
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	size_t fds_size;
 	int i, err;
 
diff --git a/kernel/cobalt/posix/io.h b/kernel/cobalt/posix/io.h
index 6f20dbedd..82187cc7b 100644
--- a/kernel/cobalt/posix/io.h
+++ b/kernel/cobalt/posix/io.h
@@ -71,6 +71,6 @@ COBALT_SYSCALL_DECL(select,
 		     fd_set __user *u_rfds,
 		     fd_set __user *u_wfds,
 		     fd_set __user *u_xfds,
-		     struct timeval __user *u_tv));
+		     struct __kernel_old_timeval __user *u_tv));
 
 #endif /* !_COBALT_POSIX_IO_H */
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index c2fd6a1e0..cb02dacd3 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -715,7 +715,7 @@ COBALT_SYSCALL32emu(select, nonrestartable,
 	xntmode_t mode = XN_RELATIVE;
 	struct xnselector *selector;
 	struct xnthread *curr;
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	xnsticks_t diff;
 	size_t fds_size;
 	int i, err;
diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
index d45480f94..5692f3146 100644
--- a/kernel/drivers/ipc/bufp.c
+++ b/kernel/drivers/ipc/bufp.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
+#include <linux/time.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/map.h>
 #include <cobalt/kernel/bufd.h>
@@ -818,7 +819,7 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 {
 	struct _rtdm_setsockopt_args sopt;
 	struct rtipc_port_label plabel;
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
 	size_t len;
 	int ret;
@@ -907,7 +908,7 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 {
 	struct _rtdm_getsockopt_args sopt;
 	struct rtipc_port_label plabel;
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
 	socklen_t len;
 	int ret;
diff --git a/kernel/drivers/ipc/iddp.c b/kernel/drivers/ipc/iddp.c
index f31b9bb66..3a9de845f 100644
--- a/kernel/drivers/ipc/iddp.c
+++ b/kernel/drivers/ipc/iddp.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
+#include <linux/time.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/bufd.h>
 #include <cobalt/kernel/map.h>
@@ -700,7 +701,7 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 {
 	struct _rtdm_setsockopt_args sopt;
 	struct rtipc_port_label plabel;
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
 	size_t len;
 	int ret;
@@ -789,7 +790,7 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 {
 	struct _rtdm_getsockopt_args sopt;
 	struct rtipc_port_label plabel;
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
 	socklen_t len;
 	int ret;
diff --git a/kernel/drivers/ipc/internal.h b/kernel/drivers/ipc/internal.h
index 7c09dd312..919a5d978 100644
--- a/kernel/drivers/ipc/internal.h
+++ b/kernel/drivers/ipc/internal.h
@@ -21,6 +21,7 @@
 #define _RTIPC_INTERNAL_H
 
 #include <linux/uio.h>
+#include <linux/time.h>
 #include <cobalt/kernel/registry.h>
 #include <cobalt/kernel/clock.h>
 #include <cobalt/kernel/select.h>
@@ -65,7 +66,7 @@ static inline void *rtipc_fd_to_state(struct rtdm_fd *fd)
 	return p->state;
 }
 
-static inline nanosecs_rel_t rtipc_timeval_to_ns(const struct timeval *tv)
+static inline nanosecs_rel_t rtipc_timeval_to_ns(const struct __kernel_old_timeval *tv)
 {
 	nanosecs_rel_t ns = tv->tv_usec * 1000;
 
@@ -75,7 +76,7 @@ static inline nanosecs_rel_t rtipc_timeval_to_ns(const struct timeval *tv)
 	return ns;
 }
 
-static inline void rtipc_ns_to_timeval(struct timeval *tv, nanosecs_rel_t ns)
+static inline void rtipc_ns_to_timeval(struct __kernel_old_timeval *tv, nanosecs_rel_t ns)
 {
 	unsigned long nsecs;
 
@@ -101,11 +102,11 @@ int rtipc_get_sockoptin(struct rtdm_fd *fd,
 			struct _rtdm_setsockopt_args *sopt,
 			const void *arg);
 
-int rtipc_get_timeval(struct rtdm_fd *fd, struct timeval *tv,
+int rtipc_get_timeval(struct rtdm_fd *fd, struct __kernel_old_timeval *tv,
 		      const void *arg, size_t arglen);
 
 int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
-		      const struct timeval *tv, size_t arglen);
+		      const struct __kernel_old_timeval *tv, size_t arglen);
 
 int rtipc_get_length(struct rtdm_fd *fd, size_t *lenp,
 		     const void *arg, size_t arglen);
diff --git a/kernel/drivers/ipc/rtipc.c b/kernel/drivers/ipc/rtipc.c
index 99f73202d..b6fafdb41 100644
--- a/kernel/drivers/ipc/rtipc.c
+++ b/kernel/drivers/ipc/rtipc.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
+#include <linux/time.h>
 #include <rtdm/ipc.h>
 #include <rtdm/compat.h>
 #include "internal.h"
@@ -267,7 +268,7 @@ int rtipc_get_sockoptin(struct rtdm_fd *fd, struct _rtdm_setsockopt_args *sopt,
 	return rtdm_safe_copy_from_user(fd, sopt, arg, sizeof(*sopt));
 }
 
-int rtipc_get_timeval(struct rtdm_fd *fd, struct timeval *tv,
+int rtipc_get_timeval(struct rtdm_fd *fd, struct __kernel_old_timeval *tv,
 		      const void *arg, size_t arglen)
 {
 #ifdef CONFIG_XENO_ARCH_SYS3264
@@ -282,7 +283,7 @@ int rtipc_get_timeval(struct rtdm_fd *fd, struct timeval *tv,
 		return -EINVAL;
 
 	if (!rtdm_fd_is_user(fd)) {
-		*tv = *(struct timeval *)arg;
+		*tv = *(struct __kernel_old_timeval *)arg;
 		return 0;
 	}
 
@@ -290,7 +291,7 @@ int rtipc_get_timeval(struct rtdm_fd *fd, struct timeval *tv,
 }
 
 int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
-		      const struct timeval *tv, size_t arglen)
+		      const struct __kernel_old_timeval *tv, size_t arglen)
 {
 #ifdef CONFIG_XENO_ARCH_SYS3264
 	if (rtdm_fd_is_compat(fd)) {
@@ -304,7 +305,7 @@ int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
 		return -EINVAL;
 
 	if (!rtdm_fd_is_user(fd)) {
-		*(struct timeval *)arg = *tv;
+		*(struct __kernel_old_timeval *)arg = *tv;
 		return 0;
 	}
 
diff --git a/kernel/drivers/ipc/xddp.c b/kernel/drivers/ipc/xddp.c
index c9236a229..25dd68a9d 100644
--- a/kernel/drivers/ipc/xddp.c
+++ b/kernel/drivers/ipc/xddp.c
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
+#include <linux/time.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/bufd.h>
 #include <cobalt/kernel/pipe.h>
@@ -855,7 +856,7 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 	int (*monitor)(struct rtdm_fd *fd, int event, long arg);
 	struct _rtdm_setsockopt_args sopt;
 	struct rtipc_port_label plabel;
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
 	size_t len;
 	int ret;
@@ -961,7 +962,7 @@ static int __xddp_getsockopt(struct xddp_socket *sk,
 {
 	struct _rtdm_getsockopt_args sopt;
 	struct rtipc_port_label plabel;
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
 	socklen_t len;
 	int ret;
diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 54d6f7925..08753e48a 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -1742,7 +1742,7 @@ static int rt_tcp_setsockopt(struct rtdm_fd *fd, struct tcp_socket *ts,
 			     socklen_t optlen)
 {
 	/* uint64_t val; */
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t context;
 
 	switch (optname) {
-- 
2.26.2


