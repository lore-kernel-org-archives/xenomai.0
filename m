From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="H6P/4zqYy8"
Content-Transfer-Encoding: 7bit
Message-ID: <18350.7401.338371.65277@domain.hid>
Date: Sat, 9 Feb 2008 22:36:41 +0100
In-Reply-To: <18350.7135.108901.491437@domain.hid>
References: <18350.7135.108901.491437@domain.hid>
Subject: [Xenomai-core] [patch 3/4] posix skin kernel-space support for
	select.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--H6P/4zqYy8
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


stats:
 include/posix/syscall.h     |    1
 ksrc/skins/posix/Kconfig    |    9 ++
 ksrc/skins/posix/internal.h |   26 ++++++
 ksrc/skins/posix/mq.c       |   79 ++++++++++++++++++-
 ksrc/skins/posix/syscall.c  |  181 ++++++++++++++++++++++++++++++++++++++++++++
 ksrc/skins/posix/thread.c   |    7 +
 ksrc/skins/posix/thread.h   |    4
 7 files changed, 305 insertions(+), 2 deletions(-)

-- 


					    Gilles Chanteperdrix.

--H6P/4zqYy8
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-select-posix-kernel.diff"
Content-Transfer-Encoding: 7bit

--- include/posix/syscall.h	(revision 3460)
+++ include/posix/syscall.h	(working copy)
@@ -100,6 +100,7 @@
 #define __pse51_condattr_setpshared   74
 #define __pse51_thread_getschedparam  75
 #define __pse51_thread_kill           76
+#define __pse51_select                77
 
 #ifdef __KERNEL__
 
--- ksrc/skins/posix/Kconfig	(revision 3460)
+++ ksrc/skins/posix/Kconfig	(working copy)
@@ -47,6 +47,15 @@ config XENO_OPT_POSIX_INTR
 	RTDM skin is the preferred way of implementing drivers), leave this
 	option unselected.
 
+config XENO_OPT_POSIX_SELECT
+	bool "Select syscall"
+	select XENO_OPT_SELECT
+	help
+
+	This option allows applications using the Xenomai POSIX skin in
+	user-space to use the "select" syscall with Xenomai POSIXK skin file
+	descriptors.
+
 config XENO_OPT_DEBUG_POSIX
 	bool "Debugging support"
 	default y
--- ksrc/skins/posix/syscall.c	(revision 3468)
+++ ksrc/skins/posix/syscall.c	(working copy)
@@ -34,6 +34,9 @@
 #include <posix/sem.h>
 #include <posix/shm.h>
 #include <posix/timer.h>
+#ifdef CONFIG_XENO_SKIN_RTDM
+#include <rtdm/core.h>
+#endif /* CONFIG_XENO_SKIN_RTDM */
 
 int pse51_muxid;
 
@@ -1877,6 +1880,183 @@ static int __timer_getoverrun(struct pt_
 	return rc >= 0 ? rc : -thread_get_errno();
 }
 
+#ifdef CONFIG_XENO_OPT_POSIX_SELECT
+static int fd_valid_p(int fd)
+{
+	pse51_assoc_t *assoc;
+#ifdef CONFIG_XENO_SKIN_RTDM
+	const int rtdm_fd_start = FD_SETSIZE - RTDM_FD_MAX;
+	
+	if (fd >= rtdm_fd_start) {
+		struct rtdm_dev_context *ctx;
+		ctx = __rtdm_context_get(current, fd - rtdm_fd_start);
+		if (ctx) {
+			rtdm_context_unlock(ctx);
+			return 1;
+		}
+		return 0;
+	}
+#endif /* CONFIG_XENO_SKIN_RTDM */
+
+	assoc = pse51_assoc_lookup(&pse51_queues()->uqds, fd);
+	return assoc != NULL;
+}
+
+static int first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
+{
+	int i, fd;
+
+	for (i = 0; i < XNSELECT_MAX_TYPES; i++)
+		if (fds[i]
+		    && (fd = find_first_bit(fds[i]->fds_bits, nfds)) < nfds)
+			return fd_valid_p(fd);
+
+	return 1;
+}
+
+static int select_bind_one(struct xnselector *selector, unsigned type, int fd)
+{
+	pse51_assoc_t *assoc;
+#ifdef CONFIG_XENO_SKIN_RTDM
+	const int rtdm_fd_start = FD_SETSIZE - RTDM_FD_MAX;
+	
+	if (fd >= rtdm_fd_start)
+		return __rt_dev_select_bind(current,
+					    fd - rtdm_fd_start,
+					    selector, type, fd);
+#endif /* CONFIG_XENO_SKIN_RTDM */
+
+	assoc = pse51_assoc_lookup(&pse51_queues()->uqds, fd);
+	if (!assoc)
+		return -EBADF;
+
+	return pse51_mq_select_bind(assoc2ufd(assoc)->kfd, selector, type, fd);
+}
+
+static int select_bind_all(struct xnselector *selector,
+			   fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
+{
+	unsigned fd, type;
+	int err;
+
+	for (type = 0; type < XNSELECT_MAX_TYPES; type++) {
+		fd_set *set = fds[type];
+		if (set)
+			for (fd = find_first_bit(set->fds_bits, nfds);
+			     fd < nfds;
+			     fd = find_next_bit(set->fds_bits, nfds, fd + 1)) {
+				err = select_bind_one(selector, type, fd);
+				if (err)
+					return err;
+			}
+	}
+
+	return 0;
+}
+
+/* int select(int, fd_set *, fd_set *, fd_set *, struct timeval *) */
+static int __select(struct pt_regs *regs)
+{
+	fd_set __user *ufd_sets[XNSELECT_MAX_TYPES] = {
+		[XNSELECT_READ] = (fd_set __user *) __xn_reg_arg2(regs),
+		[XNSELECT_WRITE] = (fd_set __user *) __xn_reg_arg3(regs),
+		[XNSELECT_EXCEPT] = (fd_set __user *) __xn_reg_arg4(regs)
+	};
+	fd_set *in_fds[XNSELECT_MAX_TYPES] = {NULL, NULL, NULL};
+	fd_set *out_fds[XNSELECT_MAX_TYPES] = {NULL, NULL, NULL};
+	fd_set in_fds_storage[XNSELECT_MAX_TYPES],
+		out_fds_storage[XNSELECT_MAX_TYPES];
+	xnticks_t timeout = XN_INFINITE;
+	xntmode_t mode = XN_RELATIVE;
+	struct xnselector *selector;
+	struct timeval tv;
+	pthread_t thread;
+	int i, err, nfds;
+
+	thread = pse51_current_thread();
+	if (!thread)
+		return -EPERM;
+
+	if (__xn_reg_arg5(regs)) {
+		if (__xn_copy_from_user(&tv,
+					(void __user *)__xn_reg_arg5(regs),
+					sizeof(tv)))
+			return -EFAULT;
+
+		if (tv.tv_usec > 1000000)
+			return -EINVAL;
+
+		timeout = clock_get_ticks(CLOCK_MONOTONIC) + tv2ticks_ceil(&tv);
+		mode = XN_ABSOLUTE;
+	}
+
+	nfds = __xn_reg_arg1(regs);
+
+	for (i = 0; i < XNSELECT_MAX_TYPES; i++)
+		if (ufd_sets[i]) {
+			in_fds[i] = &in_fds_storage[i];
+			out_fds[i] = & out_fds_storage[i];
+			if (__xn_copy_from_user(in_fds[i],
+						(void __user *) ufd_sets[i],
+						__FDELT(nfds + __NFDBITS - 1)
+						* sizeof(long)))
+				return -EFAULT;
+		}
+
+	selector = thread->selector;
+	if (!selector) {
+		/* This function may be called from pure Linux fd_sets, we want
+		   to avoid the xnselector allocation in this case, so, we do a
+		   simple test: test if the first file descriptor we find in the
+		   fd_set is an RTDM descriptor or a message queue descriptor. */
+		if (!first_fd_valid_p(in_fds, nfds))
+			return -EBADF;
+
+		if (!(selector = xnmalloc(sizeof(*thread->selector))))
+			return -ENOMEM;
+		xnselector_init(selector);
+		thread->selector = selector;
+
+		/* Bind directly the file descriptors, we do not need to go
+		   through xnselect returning -ECHRNG */
+		if ((err = select_bind_all(selector, in_fds, nfds)))
+			return err;
+	}
+
+	do {
+		err = xnselect(selector, out_fds, in_fds, nfds, timeout, mode);
+
+		if (err == -ECHRNG) {
+			int err = select_bind_all(selector, out_fds, nfds);
+			if (err)
+				return err;
+		}
+	} while (err == -ECHRNG);
+
+	if (__xn_reg_arg5(regs) && (err > 0 || err == -EINTR)) {
+		xnsticks_t diff = timeout - clock_get_ticks(CLOCK_MONOTONIC);
+		if (diff > 0)
+			ticks2tv(&tv, diff);
+		else
+			tv.tv_sec = tv.tv_usec = 0;
+
+		if (__xn_copy_to_user((void __user *)__xn_reg_arg5(regs),
+				      &tv, sizeof(tv)))
+			return -EFAULT;
+	}
+
+	if (err > 0)
+		for (i = 0; i < XNSELECT_MAX_TYPES; i++)
+			if (ufd_sets[i]
+			    && __xn_copy_to_user((void __user *) ufd_sets[i],
+						 out_fds[i], sizeof(fd_set)))
+				return -EFAULT;
+	return err;
+}
+#else /* !CONFIG_XENO_OPT_POSIX_SELECT */
+#define __select __pse51_call_not_available
+#endif /* !CONFIG_XENO_OPT_POSIX_SELECT */
+
 #ifdef CONFIG_XENO_OPT_POSIX_SHM
 
 /* shm_open(name, oflag, mode, ufd) */
@@ -2275,6 +2455,7 @@ static xnsysent_t __systab[] = {
 	    {&__pthread_condattr_getpshared, __xn_exec_any},
 	[__pse51_condattr_setpshared] =
 	    {&__pthread_condattr_setpshared, __xn_exec_any},
+	[__pse51_select] = {&__select, __xn_exec_primary},
 };
 
 static void __shadow_delete_hook(xnthread_t *thread)
--- ksrc/skins/posix/mq.c	(revision 3468)
+++ ksrc/skins/posix/mq.c	(working copy)
@@ -65,6 +65,8 @@ struct pse51_mq {
 
 	xnholder_t link;	/* link in mqq */
 
+	DECLARE_XNSELECT(read_select);
+	DECLARE_XNSELECT(write_select);
 #define link2mq(laddr) \
     ((pse51_mq_t *) (((char *)laddr) - offsetof(pse51_mq_t, link)))
 };
@@ -140,6 +142,8 @@ static int pse51_mq_init(pse51_mq_t * mq
 
 	mq->attr = *attr;
 	mq->target = NULL;
+	xnselect_init(&mq->read_select);
+	xnselect_init(&mq->write_select);
 
 	return 0;
 }
@@ -154,6 +158,8 @@ static void pse51_mq_destroy(pse51_mq_t 
 	resched = (xnsynch_destroy(&mq->senders) == XNSYNCH_RESCHED) || resched;
 	removeq(&pse51_mqq, &mq->link);
 	xnlock_put_irqrestore(&nklock, s);
+	xnselect_destroy(&mq->read_select);
+	xnselect_destroy(&mq->write_select);
 #ifdef __KERNEL__
 	if (!xnpod_root_p())
 		pse51_schedule_lostage(PSE51_LO_FREE_REQ, mq->mem, mq->memsize);
@@ -480,6 +486,9 @@ static pse51_msg_t *pse51_mq_trysend(pse
 	if (!msg)
 		return ERR_PTR(-EAGAIN);
 
+	if (countq(&mq->avail) == 0)
+		xnselect_signal(&mq->write_select, 0);
+
 	*mqp = mq;
 	mq->nodebase.refcount++;
 	return msg;
@@ -504,6 +513,9 @@ static pse51_msg_t *pse51_mq_tryrcv(pse5
 	if (!(holder = getpq(&mq->queued)))
 		return ERR_PTR(-EAGAIN);
 
+	if (countpq(&mq->queued) == 0)
+		xnselect_signal(&mq->read_select, 0);
+
 	*mqp = mq;
 	mq->nodebase.refcount++;
 	return any2msg(holder, link);
@@ -595,13 +607,16 @@ int pse51_mq_finish_send(mqd_t fd, pse51
 	}
 
 	insertpqf(&mq->queued, &msg->link, msg->link.prio);
+	if (countpq(&mq->queued) == 1)
+		resched = xnselect_signal(&mq->read_select, 1);
 
 	if (xnsynch_wakeup_one_sleeper(&mq->receivers))
 		resched = 1;
 	else if (mq->target && countpq(&mq->queued) == 1) {
 		/* First message ? no pending reader ? attempt
 		   to send a signal if mq_notify was called. */
-		resched = pse51_sigqueue_inner(mq->target, &mq->si);
+		if (pse51_sigqueue_inner(mq->target, &mq->si))
+			resched = 1;
 		mq->target = NULL;
 	}
 
@@ -626,6 +641,9 @@ int pse51_mq_finish_send(mqd_t fd, pse51
 	   pool and wakeup any waiting sender. */;
 	pse51_mq_msg_free(mq, msg);
 
+	if (countq(&mq->avail) == 1)
+		resched = xnselect_signal(&mq->write_select, 1);
+
 	if (xnsynch_wakeup_one_sleeper(&mq->senders))
 		resched = 1;
 	goto unref;
@@ -714,6 +732,9 @@ int pse51_mq_finish_rcv(mqd_t fd, pse51_
 
 	pse51_mq_msg_free(mq, msg);
 
+	if (countq(&mq->avail) == 1)
+		resched = xnselect_signal(&mq->write_select, 1);
+
 	if (xnsynch_wakeup_one_sleeper(&mq->senders))
 		resched = 1;
 
@@ -1210,6 +1231,62 @@ int mq_notify(mqd_t fd, const struct sig
 	return -1;
 }
 
+#ifdef CONFIG_XENO_OPT_POSIX_SELECT
+int pse51_mq_select_bind(mqd_t fd, struct xnselector *selector,
+			 unsigned type, unsigned index)
+{
+	struct xnselect_binding *binding;
+	pse51_desc_t *desc;
+	pse51_mq_t *mq;
+	int err;
+	spl_t s;
+	
+	if (type == XNSELECT_READ || type == XNSELECT_WRITE) {
+		binding = xnmalloc(sizeof(*binding));
+		if (!binding)
+			return -ENOMEM;
+	} else
+		return -EBADF;
+
+	xnlock_get_irqsave(&nklock, s);
+	err = -pse51_desc_get(&desc, fd, PSE51_MQ_MAGIC);
+	if (err)
+		goto unlock_and_error;
+
+	mq = node2mq(pse51_desc_node(desc));
+
+	switch(type) {
+	case XNSELECT_READ:
+		err = -EBADF;
+		if ((pse51_desc_getflags(desc) & PSE51_PERMS_MASK) == O_WRONLY)
+			goto unlock_and_error;
+
+		err = xnselect_bind(&mq->read_select, binding,
+				    selector, type, index, countpq(&mq->queued));
+		if (err)
+			goto unlock_and_error;
+		break;
+
+	case XNSELECT_WRITE:
+		err = -EBADF;
+		if ((pse51_desc_getflags(desc) & PSE51_PERMS_MASK) == O_RDONLY)
+			goto unlock_and_error;
+
+		err = xnselect_bind(&mq->write_select, binding,
+				    selector, type, index, countq(&mq->avail));
+		if (err)
+			goto unlock_and_error;
+		break;
+	}
+	xnlock_put_irqrestore(&nklock, s);
+	return 0;
+
+      unlock_and_error:
+	xnlock_put_irqrestore(&nklock, s);
+	return err;
+}
+#endif /* CONFIG_XENO_OPT_POSIX_SELECT */
+
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 static void uqd_cleanup(pse51_assoc_t *assoc)
 {
--- ksrc/skins/posix/thread.c	(revision 3460)
+++ ksrc/skins/posix/thread.c	(working copy)
@@ -84,6 +84,12 @@ static void thread_delete_hook(xnthread_
 	pse51_mark_deleted(thread);
 	pse51_signal_cleanup_thread(thread);
 	pse51_timer_cleanup_thread(thread);
+#ifdef CONFIG_XENO_OPT_POSIX_SELECT
+	if (thread->selector) {
+		xnselector_destroy(thread->selector);
+		thread->selector = NULL;
+	}
+#endif /* CONFIG_XENO_OPT_POSIX_SELECT */
 
 	switch (thread_getdetachstate(thread)) {
 	case PTHREAD_CREATE_DETACHED:
@@ -216,6 +222,7 @@ int pthread_create(pthread_t *tid,
 	pse51_signal_init_thread(thread, cur);
 	pse51_tsd_init_thread(thread);
 	pse51_timer_init_thread(thread);
+	thread->selector = NULL;
 
 	if (thread->attr.policy == SCHED_RR) {
 		xnthread_time_slice(&thread->threadbase) = pse51_time_slice;
--- ksrc/skins/posix/thread.h	(revision 3460)
+++ ksrc/skins/posix/thread.h	(working copy)
@@ -21,6 +21,7 @@
 #define _POSIX_THREAD_H
 
 #include <posix/internal.h>
+#include <nucleus/select.h>
 
 typedef unsigned long long pse51_sigset_t;
 
@@ -90,6 +91,9 @@ struct pse51_thread {
     /* For timers. */
     xnqueue_t timersq;
     
+    /* For select. */
+    struct xnselector *selector;
+
 #ifdef CONFIG_XENO_OPT_PERVASIVE
     struct pse51_hkey hkey;
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
--- ksrc/skins/posix/internal.h	(revision 3468)
+++ ksrc/skins/posix/internal.h	(working copy)
@@ -22,6 +22,7 @@
 #include <nucleus/xenomai.h>
 #include <nucleus/core.h>
 #include <nucleus/ppd.h>
+#include <nucleus/select.h>
 #include <posix/posix.h>
 #include <posix/registry.h>
 
@@ -152,12 +153,32 @@ static inline xnticks_t ts2ticks_ceil(co
 	return rem ? ticks+1 : ticks;
 }
 
+static inline xnticks_t tv2ticks_ceil(const struct timeval *tv)
+{
+	xntime_t nsecs = tv->tv_usec * 1000;
+	unsigned long rem;
+	xnticks_t ticks;
+	if(tv->tv_sec)
+		nsecs += (xntime_t) tv->tv_sec * ONE_BILLION;
+	ticks = xnarch_ulldiv(nsecs, xntbase_get_tickval(pse51_tbase), &rem);
+	return rem ? ticks+1 : ticks;
+}
+
+static inline void ticks2tv(struct timeval *tv, xnticks_t ticks)
+{
+	unsigned long nsecs;
+	tv->tv_sec = xnarch_uldivrem(xntbase_ticks2ns(pse51_tbase, ticks),
+				     ONE_BILLION,
+				     &nsecs);
+	tv->tv_usec = nsecs / 1000;
+}
+
 static inline xnticks_t clock_get_ticks(clockid_t clock_id)
 {
 	if(clock_id == CLOCK_REALTIME)
 		return xntbase_get_time(pse51_tbase);
 	else
-		return xntbase_ns2ticks(pse51_tbase, xnpod_get_cpu_time());
+		return xntbase_get_jiffies(pse51_tbase);
 }
 
 static inline int clock_flag(int flag, clockid_t clock_id)
@@ -178,4 +199,7 @@ static inline int clock_flag(int flag, c
 	return -EINVAL;
 }
 
+int pse51_mq_select_bind(mqd_t fd, struct xnselector *selector,
+			 unsigned type, unsigned index);
+
 #endif /* !_POSIX_INTERNAL_H */

--H6P/4zqYy8--

