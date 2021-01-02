From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail 05/13] cobalt/kernel: pipeline: abstract execution
 stage predicates
Date: Sat,  2 Jan 2021 10:33:45 +0100
Message-Id: <20210102093353.3195090-6-rpm@xenomai.org>
In-Reply-To: <20210102093353.3195090-1-rpm@xenomai.org>
References: <20210102093353.3195090-1-rpm@xenomai.org>
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
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

ipipe_root_p, !ipipe_root_p belong to the I-pipe jargon. Dovetail uses
running_inband(), running_oob() for the same purpose instead.

Replace all occurrences of ipipe_root_p found in generic code with
is_primary_domain(), is_secondary_domain(), which in turn map to the
proper predicates depending on the underlying pipeline flavour.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/assert.h      |  5 +++--
 include/cobalt/kernel/clock.h       |  2 +-
 include/cobalt/kernel/rtdm/driver.h |  2 +-
 kernel/cobalt/posix/corectl.c       |  3 +--
 kernel/cobalt/posix/syscall.c       |  6 +++---
 kernel/cobalt/registry.c            |  2 +-
 kernel/cobalt/rtdm/drvlib.c         |  2 +-
 kernel/cobalt/rtdm/fd.c             | 14 +++++++-------
 kernel/cobalt/sched.c               |  5 +++--
 kernel/cobalt/thread.c              |  2 +-
 10 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/cobalt/kernel/assert.h b/include/cobalt/kernel/assert.h
index 7c93b7e5c..7d9433abc 100644
--- a/include/cobalt/kernel/assert.h
+++ b/include/cobalt/kernel/assert.h
@@ -20,6 +20,7 @@
 #define _COBALT_KERNEL_ASSERT_H
 
 #include <linux/kconfig.h>
+#include <pipeline/pipeline.h>
 #include <cobalt/kernel/trace.h>
 #include <cobalt/kernel/ancillaries.h>
 
@@ -57,8 +58,8 @@
 	do { } while (0)
 #endif
 
-#define primary_mode_only()	XENO_BUG_ON(CONTEXT, ipipe_root_p)
-#define secondary_mode_only()	XENO_BUG_ON(CONTEXT, !ipipe_root_p)
+#define primary_mode_only()	XENO_BUG_ON(CONTEXT, is_secondary_domain())
+#define secondary_mode_only()	XENO_BUG_ON(CONTEXT, !is_secondary_domain())
 #define interrupt_only()	XENO_BUG_ON(CONTEXT, !xnsched_interrupt_p())
 #define realtime_cpu_only()	XENO_BUG_ON(CONTEXT, !xnsched_supported_cpu(raw_smp_processor_id()))
 #define thread_only()		XENO_BUG_ON(CONTEXT, xnsched_interrupt_p())
diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
index 94dfd2f99..d4a9d2686 100644
--- a/include/cobalt/kernel/clock.h
+++ b/include/cobalt/kernel/clock.h
@@ -19,7 +19,7 @@
 #ifndef _COBALT_KERNEL_CLOCK_H
 #define _COBALT_KERNEL_CLOCK_H
 
-#include <linux/ipipe.h>
+#include <pipeline/pipeline.h>
 #include <cobalt/kernel/list.h>
 #include <cobalt/kernel/vfile.h>
 #include <cobalt/uapi/kernel/types.h>
diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 84309d0b1..581e7a5c0 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -1316,7 +1316,7 @@ static inline int rtdm_rt_capable(struct rtdm_fd *fd)
 
 static inline int rtdm_in_rt_context(void)
 {
-	return (ipipe_current_domain != ipipe_root_domain);
+	return is_primary_domain();
 }
 
 #define RTDM_IOV_FASTMAX  16
diff --git a/kernel/cobalt/posix/corectl.c b/kernel/cobalt/posix/corectl.c
index f7129ca64..998fe572d 100644
--- a/kernel/cobalt/posix/corectl.c
+++ b/kernel/cobalt/posix/corectl.c
@@ -17,7 +17,6 @@
  */
 #include <linux/types.h>
 #include <linux/errno.h>
-#include <linux/ipipe.h>
 #include <linux/kconfig.h>
 #include <linux/atomic.h>
 #include <linux/printk.h>
@@ -89,7 +88,7 @@ static int do_conf_option(int option, void __user *u_buf, size_t u_bufsz)
 		val = realtime_core_state();
 		break;
 	default:
-		if (!ipipe_root_p)
+		if (is_primary_domain())
 			/* Switch to secondary mode first. */
 			return -ENOSYS;
 		vec.u_buf = u_buf;
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 0a09322be..4d2331ddc 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -112,7 +112,7 @@ static COBALT_SYSCALL(migrate, current, (int domain))
 {
 	struct xnthread *thread = xnthread_current();
 
-	if (ipipe_root_p) {
+	if (is_secondary_domain()) {
 		if (domain == COBALT_PRIMARY) {
 			if (thread == NULL)
 				return -EPERM;
@@ -129,7 +129,7 @@ static COBALT_SYSCALL(migrate, current, (int domain))
 		return 0;
 	}
 
-	/* ipipe_current_domain != ipipe_root_domain */
+	/* We are running on the head stage, apply relax request. */
 	if (domain == COBALT_SECONDARY) {
 		xnthread_relax(0, 0);
 		return 1;
@@ -779,7 +779,7 @@ ret_handled:
 
 int ipipe_syscall_hook(struct ipipe_domain *ipd, struct pt_regs *regs)
 {
-	if (unlikely(ipipe_root_p))
+	if (unlikely(is_secondary_domain()))
 		return handle_root_syscall(ipd, regs);
 
 	return handle_head_syscall(ipd, regs);
diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
index 4b01abd63..dc1edd01a 100644
--- a/kernel/cobalt/registry.c
+++ b/kernel/cobalt/registry.c
@@ -852,7 +852,7 @@ int xnregistry_remove(xnhandle_t handle)
 			 */
 			if (object->pnode) {
 				xnlock_put_irqrestore(&nklock, s);
-				if (ipipe_root_p)
+				if (is_secondary_domain())
 					flush_work(&registry_proc_work);
 				return 0;
 			}
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 5778ad559..40d2e401b 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1630,7 +1630,7 @@ void rtdm_schedule_nrt_work(struct work_struct *lostage_work)
 		.lostage_work = lostage_work,
 	};
 
-	if (ipipe_root_p)
+	if (is_secondary_domain())
 		schedule_work(lostage_work);
 	else
 		ipipe_post_work_root(&ipipe_work, work);
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index eb80aa7bf..afb9ca5c5 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -306,7 +306,7 @@ static void __put_fd(struct rtdm_fd *fd, spl_t s)
 	if (!destroy)
 		return;
 
-	if (ipipe_root_p)
+	if (is_secondary_domain())
 		fd->ops->close(fd);
 	else {
 		struct lostage_trigger_close closework = {
@@ -470,7 +470,7 @@ static struct rtdm_fd *get_fd_fixup_mode(int ufd)
 	 * the syscall from secondary mode.
 	 */
 	thread = xnthread_current();
-	if (unlikely(ipipe_root_p)) {
+	if (unlikely(is_secondary_domain())) {
 		if (thread == NULL ||
 		    xnthread_test_localinfo(thread, XNDESCENT))
 			return fd;
@@ -508,7 +508,7 @@ int rtdm_fd_ioctl(int ufd, unsigned int request, ...)
 
 	trace_cobalt_fd_ioctl(current, fd, ufd, request);
 
-	if (ipipe_root_p)
+	if (is_secondary_domain())
 		err = fd->ops->ioctl_nrt(fd, request, arg);
 	else
 		err = fd->ops->ioctl_rt(fd, request, arg);
@@ -547,7 +547,7 @@ rtdm_fd_read(int ufd, void __user *buf, size_t size)
 
 	trace_cobalt_fd_read(current, fd, ufd, size);
 
-	if (ipipe_root_p)
+	if (is_secondary_domain())
 		ret = fd->ops->read_nrt(fd, buf, size);
 	else
 		ret = fd->ops->read_rt(fd, buf, size);
@@ -580,7 +580,7 @@ ssize_t rtdm_fd_write(int ufd, const void __user *buf, size_t size)
 
 	trace_cobalt_fd_write(current, fd, ufd, size);
 
-	if (ipipe_root_p)
+	if (is_secondary_domain())
 		ret = fd->ops->write_nrt(fd, buf, size);
 	else
 		ret = fd->ops->write_rt(fd, buf, size);
@@ -616,7 +616,7 @@ ssize_t rtdm_fd_recvmsg(int ufd, struct user_msghdr *msg, int flags)
 	if (fd->oflags & O_NONBLOCK)
 		flags |= MSG_DONTWAIT;
 
-	if (ipipe_root_p)
+	if (is_secondary_domain())
 		ret = fd->ops->recvmsg_nrt(fd, msg, flags);
 	else
 		ret = fd->ops->recvmsg_rt(fd, msg, flags);
@@ -761,7 +761,7 @@ ssize_t rtdm_fd_sendmsg(int ufd, const struct user_msghdr *msg, int flags)
 	if (fd->oflags & O_NONBLOCK)
 		flags |= MSG_DONTWAIT;
 
-	if (ipipe_root_p)
+	if (is_secondary_domain())
 		ret = fd->ops->sendmsg_nrt(fd, msg, flags);
 	else
 		ret = fd->ops->sendmsg_rt(fd, msg, flags);
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 7ff8a6c82..b16903bd8 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -912,7 +912,8 @@ int ___xnsched_run(struct xnsched *sched)
 	int switched, shadow;
 	spl_t s;
 
-	XENO_WARN_ON_ONCE(COBALT, !hard_irqs_disabled() && ipipe_root_p);
+	XENO_WARN_ON_ONCE(COBALT,
+			  !hard_irqs_disabled() && is_secondary_domain());
 
 	if (xnarch_escalate())
 		return 0;
@@ -983,7 +984,7 @@ int ___xnsched_run(struct xnsched *sched)
 	 * In such a case, we are running over the regular schedule()
 	 * tail code, so we have to skip our tail code.
 	 */
-	if (shadow && ipipe_root_p)
+	if (shadow && is_secondary_domain())
 		goto shadow_epilogue;
 
 	switched = 1;
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index b871e6069..88a4ff621 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2107,7 +2107,7 @@ void xnthread_relax(int notify, int reason)
 	 * Basic sanity check after an expected transition to secondary
 	 * mode.
 	 */
-	XENO_WARN(COBALT, !ipipe_root_p,
+	XENO_WARN(COBALT, is_primary_domain(),
 		  "xnthread_relax() failed for thread %s[%d]",
 		  thread->name, xnthread_host_pid(thread));
 
-- 
2.26.2


