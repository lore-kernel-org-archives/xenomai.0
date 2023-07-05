Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E51877
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:48:39 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202307050638245ff1ac941263d6f1ee
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jul 2023 08:38:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=t9E/C15kyQeVqrK1LqQhwoLJdXcAbkzWDDFwc3DF77A=;
 b=JkXgKynszh+lBoL7779y7pCtjSQ3jmrsW/TT/IBGG9bsLp/VK3iPM6b5+jqWXWKqnTCuNh
 v6N9DNtF+K7c/id60EqlfUU8NHkVpmeSwgPGSldIog7I9e+q6H0vStVnhEq9uzTJeFPnrw0f
 +636LlU4LE9/TNLz1Hx8/s1m3wvu8=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 05 Jul 2023 08:38:23 +0200
Subject: [PATCH 01/12] y2038: cobalt: Introduce sched_param_ex64 and use it
 internally
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v1-1-604a089542c2@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Introducing a new type sched_param_ex64. All members are (always) based
on time64_t. All internal APIs have been migrated now. Existing compat
and native system call entry points will do the necessary translation.

This is a preparation step for introducing time64_t based cobalt thread
cobalt services.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/compat.h     |   5 +-
 kernel/cobalt/posix/clock.h        |  38 +++++++++--
 kernel/cobalt/posix/compat.c       |   5 +-
 kernel/cobalt/posix/sched.c        |  39 +++++++-----
 kernel/cobalt/posix/sched.h        |   8 +--
 kernel/cobalt/posix/syscall32.c    |  12 ++--
 kernel/cobalt/posix/thread.c       | 126 ++++++++++++++++++++++++++++++-------
 kernel/cobalt/posix/thread.h       |  39 ++++++++++--
 kernel/cobalt/trace/cobalt-posix.h |  20 +++---
 9 files changed, 219 insertions(+), 73 deletions(-)

diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
index 275735df5..f2dce74b4 100644
--- a/include/cobalt/kernel/compat.h
+++ b/include/cobalt/kernel/compat.h
@@ -26,6 +26,7 @@
 #include <cobalt/uapi/sched.h>
 
 struct mq_attr;
+struct sched_param_ex64;
 
 struct __compat_sched_ss_param {
 	int __sched_low_priority;
@@ -117,12 +118,12 @@ int sys32_put_fdset(compat_fd_set __user *cfds, const fd_set *fds,
 		    size_t fdsize);
 
 int sys32_get_param_ex(int policy,
-		       struct sched_param_ex *p,
+		       struct sched_param_ex64 *p,
 		       const struct compat_sched_param_ex __user *u_cp);
 
 int sys32_put_param_ex(int policy,
 		       struct compat_sched_param_ex __user *u_cp,
-		       const struct sched_param_ex *p);
+		       const struct sched_param_ex64 *p);
 
 int sys32_get_mqattr(struct mq_attr *ap,
 		     const struct compat_mq_attr __user *u_cap);
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 38b59e24f..b0fc84396 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -18,6 +18,7 @@
 #ifndef _COBALT_POSIX_CLOCK_H
 #define _COBALT_POSIX_CLOCK_H
 
+#include <linux/compat.h>
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/cpumask.h>
@@ -38,6 +39,14 @@ static inline void u_ns2ts(struct __user_old_timespec *ts, xnticks_t nsecs)
 	ts->tv_sec = xnclock_divrem_billion(nsecs, &ts->tv_nsec);
 }
 
+static inline void ns2kts(struct __kernel_timespec *kts, xnticks_t ticks)
+{
+	unsigned long nsecs;
+
+	kts->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
+	kts->tv_nsec = (long long)nsecs;
+}
+
 static inline xnticks_t ts2ns(const struct timespec64 *ts)
 {
 	xnticks_t nsecs = ts->tv_nsec;
@@ -48,6 +57,23 @@ static inline xnticks_t ts2ns(const struct timespec64 *ts)
 	return nsecs;
 }
 
+static inline xnticks_t kts2ns(const struct __kernel_timespec *ts)
+{
+	xnticks_t nsecs = ts->tv_nsec;
+
+	/* zero out padding in compat mode */
+	if (in_compat_syscall())
+		nsecs &= 0xFFFFFFFFUL;
+
+	/* In 32-bit mode, this drops the padding */
+	nsecs = (long)nsecs;
+
+	if (ts->tv_sec)
+		nsecs += (xnticks_t)ts->tv_sec * ONE_BILLION;
+
+	return nsecs;
+}
+
 static inline xnticks_t u_ts2ns(const struct __user_old_timespec *ts)
 {
 	xnticks_t nsecs = ts->tv_nsec;
@@ -111,34 +137,34 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     struct timespec64 *rmt);
 
 COBALT_SYSCALL_DECL(clock_getres,
-		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
+		    (clockid_t clock_id, struct __kernel_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_getres64,
 		    (clockid_t clock_id, struct __kernel_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_gettime,
-		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
+		    (clockid_t clock_id, struct __kernel_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_gettime64,
 		    (clockid_t clock_id, struct __kernel_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_settime,
-		    (clockid_t clock_id, const struct __user_old_timespec __user *u_ts));
+		    (clockid_t clock_id, const struct __kernel_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_settime64,
 		    (clockid_t clock_id,
 			 const struct __kernel_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_adjtime,
-		    (clockid_t clock_id, struct __user_old_timex __user *u_tx));
+		    (clockid_t clock_id, struct old_timex32 __user *u_tx));
 
 COBALT_SYSCALL_DECL(clock_adjtime64,
 		    (clockid_t clock_id, struct __kernel_timex __user *u_tx));
 
 COBALT_SYSCALL_DECL(clock_nanosleep,
 		    (clockid_t clock_id, int flags,
-		     const struct __user_old_timespec __user *u_rqt,
-		     struct __user_old_timespec __user *u_rmt));
+		     const struct __kernel_old_timespec __user *u_rqt,
+		     struct __kernel_old_timespec __user *u_rmt));
 
 COBALT_SYSCALL_DECL(clock_nanosleep64,
 		    (clockid_t clock_id, int flags,
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index c7fc4fc33..710cde638 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -21,6 +21,7 @@
 #include <cobalt/kernel/compat.h>
 #include <asm/xenomai/syscall.h>
 #include <xenomai/posix/mqueue.h>
+#include <xenomai/posix/thread.h>
 
 int sys32_get_timespec(struct timespec64 *ts,
 		       const struct old_timespec32 __user *u_cts)
@@ -207,7 +208,7 @@ int sys32_put_fdset(compat_fd_set __user *cfds, const fd_set *fds,
 }
 
 int sys32_get_param_ex(int policy,
-		       struct sched_param_ex *p,
+		       struct sched_param_ex64 *p,
 		       const struct compat_sched_param_ex __user *u_cp)
 {
 	struct compat_sched_param_ex cpex;
@@ -244,7 +245,7 @@ EXPORT_SYMBOL_GPL(sys32_get_param_ex);
 
 int sys32_put_param_ex(int policy,
 		       struct compat_sched_param_ex __user *u_cp,
-		       const struct sched_param_ex *p)
+		       const struct sched_param_ex64 *p)
 {
 	struct compat_sched_param_ex cpex;
 
diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
index 994ee88d9..1c3a7de61 100644
--- a/kernel/cobalt/posix/sched.c
+++ b/kernel/cobalt/posix/sched.c
@@ -24,7 +24,7 @@
 
 struct xnsched_class *
 cobalt_sched_policy_param(union xnsched_policy_param *param,
-			  int u_policy, const struct sched_param_ex *param_ex,
+			  int u_policy, const struct sched_param_ex64 *param_ex,
 			  xnticks_t *tslice_r)
 {
 	struct xnsched_class *sched_class;
@@ -73,7 +73,7 @@ cobalt_sched_policy_param(union xnsched_policy_param *param,
 		break;
 	case SCHED_RR:
 		/* if unspecified, use current one. */
-		tslice = u_ts2ns(&param_ex->sched_rr_quantum);
+		tslice = kts2ns(&param_ex->sched_rr_quantum);
 		if (tslice == XN_INFINITE && tslice_r)
 			tslice = *tslice_r;
 		fallthrough;
@@ -92,8 +92,8 @@ cobalt_sched_policy_param(union xnsched_policy_param *param,
 		param->pss.normal_prio = param_ex->sched_priority;
 		param->pss.low_prio = param_ex->sched_ss_low_priority;
 		param->pss.current_prio = param->pss.normal_prio;
-		param->pss.init_budget = u_ts2ns(&param_ex->sched_ss_init_budget);
-		param->pss.repl_period = u_ts2ns(&param_ex->sched_ss_repl_period);
+		param->pss.init_budget = kts2ns(&param_ex->sched_ss_init_budget);
+		param->pss.repl_period = kts2ns(&param_ex->sched_ss_repl_period);
 		param->pss.max_repl = param_ex->sched_ss_max_repl;
 		sched_class = &xnsched_class_sporadic;
 		break;
@@ -707,7 +707,7 @@ COBALT_SYSCALL(sched_getconfig_np, conforming,
 }
 
 int __cobalt_sched_weightprio(int policy,
-			      const struct sched_param_ex *param_ex)
+			      const struct sched_param_ex64 *param_ex)
 {
 	struct xnsched_class *sched_class;
 	union xnsched_policy_param param;
@@ -728,17 +728,19 @@ int __cobalt_sched_weightprio(int policy,
 COBALT_SYSCALL(sched_weightprio, current,
 	       (int policy, const struct sched_param_ex __user *u_param))
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
+	int ret;
 
-	if (cobalt_copy_from_user(&param_ex, u_param, sizeof(param_ex)))
-		return -EFAULT;
+	ret = cobalt_thread_get_schedparam_ex(&param_ex, u_param, policy);
+	if (ret)
+		return ret;
 
 	return __cobalt_sched_weightprio(policy, &param_ex);
 }
 
 int cobalt_sched_setscheduler_ex(pid_t pid,
 				 int policy,
-				 const struct sched_param_ex *param_ex,
+				 const struct sched_param_ex64 *param_ex,
 				 __u32 __user *u_winoff,
 				 int __user *u_promoted)
 {
@@ -781,10 +783,12 @@ COBALT_SYSCALL(sched_setscheduler_ex, conforming,
 		__u32 __user *u_winoff,
 		int __user *u_promoted))
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
+	int ret;
 
-	if (cobalt_copy_from_user(&param_ex, u_param, sizeof(param_ex)))
-		return -EFAULT;
+	ret = cobalt_thread_get_schedparam_ex(&param_ex, u_param, policy);
+	if (ret)
+		return ret;
 
 	return cobalt_sched_setscheduler_ex(pid, policy, &param_ex,
 					    u_winoff, u_promoted);
@@ -792,7 +796,7 @@ COBALT_SYSCALL(sched_setscheduler_ex, conforming,
 
 int cobalt_sched_getscheduler_ex(pid_t pid,
 				 int *policy_r,
-				 struct sched_param_ex *param_ex)
+				 struct sched_param_ex64 *param_ex)
 {
 	struct cobalt_thread *thread;
 	spl_t s;
@@ -817,15 +821,18 @@ COBALT_SYSCALL(sched_getscheduler_ex, current,
 		int __user *u_policy,
 		struct sched_param_ex __user *u_param))
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
 	int ret, policy;
 
 	ret = cobalt_sched_getscheduler_ex(pid, &policy, &param_ex);
 	if (ret)
 		return ret;
 
-	if (cobalt_copy_to_user(u_param, &param_ex, sizeof(param_ex)) ||
-	    cobalt_copy_to_user(u_policy, &policy, sizeof(policy)))
+	ret = cobalt_thread_put_schedparam_ex(u_param, &param_ex, policy);
+	if (ret)
+		return ret;
+
+	if (cobalt_copy_to_user(u_policy, &policy, sizeof(policy)))
 		return -EFAULT;
 
 	return 0;
diff --git a/kernel/cobalt/posix/sched.h b/kernel/cobalt/posix/sched.h
index 2b23be0a6..e8b9f9113 100644
--- a/kernel/cobalt/posix/sched.h
+++ b/kernel/cobalt/posix/sched.h
@@ -35,7 +35,7 @@ struct cobalt_sched_group {
 };
 
 int __cobalt_sched_weightprio(int policy,
-			      const struct sched_param_ex *param_ex);
+			      const struct sched_param_ex64 *param_ex);
 
 int __cobalt_sched_setconfig_np(int cpu, int policy,
 				void __user *u_config,
@@ -59,17 +59,17 @@ ssize_t __cobalt_sched_getconfig_np(int cpu, int policy,
 							  size_t len));
 int cobalt_sched_setscheduler_ex(pid_t pid,
 				 int policy,
-				 const struct sched_param_ex *param_ex,
+				 const struct sched_param_ex64 *param_ex,
 				 __u32 __user *u_winoff,
 				 int __user *u_promoted);
 
 int cobalt_sched_getscheduler_ex(pid_t pid,
 				 int *policy_r,
-				 struct sched_param_ex *param_ex);
+				 struct sched_param_ex64 *param_ex);
 
 struct xnsched_class *
 cobalt_sched_policy_param(union xnsched_policy_param *param,
-			  int u_policy, const struct sched_param_ex *param_ex,
+			  int u_policy, const struct sched_param_ex64 *param_ex,
 			  xnticks_t *tslice_r);
 
 COBALT_SYSCALL_DECL(sched_yield, (void));
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 780d276b1..9b09d734d 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -44,7 +44,7 @@ COBALT_SYSCALL32emu(thread_create, init,
 		     int xid,
 		     __u32 __user *u_winoff))
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
 	int ret;
 
 	ret = sys32_get_param_ex(policy, &param_ex, u_param_ex);
@@ -61,7 +61,7 @@ COBALT_SYSCALL32emu(thread_setschedparam_ex, conforming,
 		     __u32 __user *u_winoff,
 		     int __user *u_promoted))
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
 	int ret;
 
 	ret = sys32_get_param_ex(policy, &param_ex, u_param_ex);
@@ -77,7 +77,7 @@ COBALT_SYSCALL32emu(thread_getschedparam_ex, current,
 		     int __user *u_policy,
 		     struct compat_sched_param_ex __user *u_param))
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
 	int ret, policy;
 
 	ret = cobalt_thread_getschedparam_ex(pth, &policy, &param_ex);
@@ -343,7 +343,7 @@ COBALT_SYSCALL32emu(sched_weightprio, current,
 		    (int policy,
 		     const struct compat_sched_param_ex __user *u_param))
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
 	int ret;
 
 	ret = sys32_get_param_ex(policy, &param_ex, u_param);
@@ -492,7 +492,7 @@ COBALT_SYSCALL32emu(sched_setscheduler_ex, conforming,
 		     __u32 __user *u_winoff,
 		     int __user *u_promoted))
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
 	int ret;
 
 	ret = sys32_get_param_ex(policy, &param_ex, u_param_ex);
@@ -508,7 +508,7 @@ COBALT_SYSCALL32emu(sched_getscheduler_ex, current,
 		     int __user *u_policy,
 		     struct compat_sched_param_ex __user *u_param))
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
 	int ret, policy;
 
 	ret = cobalt_sched_getscheduler_ex(pid, &policy, &param_ex);
diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index 94a6e394e..2fa8a9e6a 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -240,7 +240,7 @@ struct xnthread_personality *cobalt_thread_finalize(struct xnthread *zombie)
 }
 
 int __cobalt_thread_setschedparam_ex(struct cobalt_thread *thread, int policy,
-				     const struct sched_param_ex *param_ex)
+				     const struct sched_param_ex64 *param_ex)
 {
 	struct xnsched_class *sched_class;
 	union xnsched_policy_param param;
@@ -278,7 +278,7 @@ out:
 
 int __cobalt_thread_getschedparam_ex(struct cobalt_thread *thread,
 				     int *policy_r,
-				     struct sched_param_ex *param_ex)
+				     struct sched_param_ex64 *param_ex)
 {
 	struct xnsched_class *base_class;
 	struct xnthread *base_thread;
@@ -302,7 +302,7 @@ int __cobalt_thread_getschedparam_ex(struct cobalt_thread *thread,
 
 	if (base_class == &xnsched_class_rt) {
 		if (xnthread_test_state(base_thread, XNRRB)) {
-			u_ns2ts(&param_ex->sched_rr_quantum, base_thread->rrperiod);
+			ns2kts(&param_ex->sched_rr_quantum, base_thread->rrperiod);
 			*policy_r = SCHED_RR;
 		}
 		goto out;
@@ -318,8 +318,8 @@ int __cobalt_thread_getschedparam_ex(struct cobalt_thread *thread,
 #ifdef CONFIG_XENO_OPT_SCHED_SPORADIC
 	if (base_class == &xnsched_class_sporadic) {
 		param_ex->sched_ss_low_priority = base_thread->pss->param.low_prio;
-		u_ns2ts(&param_ex->sched_ss_repl_period, base_thread->pss->param.repl_period);
-		u_ns2ts(&param_ex->sched_ss_init_budget, base_thread->pss->param.init_budget);
+		ns2kts(&param_ex->sched_ss_repl_period, base_thread->pss->param.repl_period);
+		ns2kts(&param_ex->sched_ss_init_budget, base_thread->pss->param.init_budget);
 		param_ex->sched_ss_max_repl = base_thread->pss->param.max_repl;
 		goto out;
 	}
@@ -346,7 +346,7 @@ out:
 
 static int pthread_create(struct cobalt_thread **thread_p,
 			  int policy,
-			  const struct sched_param_ex *param_ex,
+			  const struct sched_param_ex64 *param_ex,
 			  struct task_struct *task)
 {
 	struct cobalt_process *process = cobalt_current_process();
@@ -479,9 +479,87 @@ static struct cobalt_thread *thread_lookup_or_shadow(unsigned long pth,
 	return thread;
 }
 
+int cobalt_thread_get_schedparam_ex(struct sched_param_ex64 *out,
+				    const struct sched_param_ex *in, int policy)
+{
+	struct sched_param_ex tmp;
+
+	if (in == NULL || cobalt_copy_from_user(&tmp, in, sizeof(tmp)))
+		return -EFAULT;
+
+	out->sched_priority = tmp.sched_priority;
+
+	switch (policy) {
+	case SCHED_SPORADIC:
+		out->sched_ss_low_priority = tmp.sched_ss_low_priority;
+		out->sched_ss_max_repl = tmp.sched_ss_max_repl;
+		out->sched_ss_repl_period.tv_sec =
+			tmp.sched_ss_repl_period.tv_sec;
+		out->sched_ss_repl_period.tv_nsec =
+			tmp.sched_ss_repl_period.tv_nsec;
+		out->sched_ss_init_budget.tv_sec =
+			tmp.sched_ss_init_budget.tv_sec;
+		out->sched_ss_init_budget.tv_nsec =
+			tmp.sched_ss_init_budget.tv_nsec;
+		break;
+	case SCHED_RR:
+		out->sched_rr_quantum.tv_sec = tmp.sched_rr_quantum.tv_sec;
+		out->sched_rr_quantum.tv_nsec = tmp.sched_rr_quantum.tv_nsec;
+		break;
+	case SCHED_TP:
+		out->sched_tp_partition = tmp.sched_tp_partition;
+		break;
+	case SCHED_QUOTA:
+		out->sched_quota_group = tmp.sched_quota_group;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int cobalt_thread_put_schedparam_ex(struct sched_param_ex *out,
+				    const struct sched_param_ex64 *in,
+				    int policy)
+{
+	struct sched_param_ex tmp;
+
+	tmp.sched_priority = in->sched_priority;
+
+	switch (policy) {
+	case SCHED_SPORADIC:
+		tmp.sched_ss_low_priority = in->sched_ss_low_priority;
+		tmp.sched_ss_max_repl = in->sched_ss_max_repl;
+		tmp.sched_ss_repl_period.tv_sec =
+			in->sched_ss_repl_period.tv_sec;
+		tmp.sched_ss_repl_period.tv_nsec =
+			in->sched_ss_repl_period.tv_nsec;
+		tmp.sched_ss_init_budget.tv_sec =
+			in->sched_ss_init_budget.tv_sec;
+		tmp.sched_ss_init_budget.tv_nsec =
+			in->sched_ss_init_budget.tv_nsec;
+		break;
+	case SCHED_RR:
+		tmp.sched_rr_quantum.tv_sec = in->sched_rr_quantum.tv_sec;
+		tmp.sched_rr_quantum.tv_nsec = in->sched_rr_quantum.tv_nsec;
+		break;
+	case SCHED_TP:
+		tmp.sched_tp_partition = in->sched_tp_partition;
+		break;
+	case SCHED_QUOTA:
+		tmp.sched_quota_group = in->sched_quota_group;
+		break;
+	default:
+		break;
+	}
+
+	return cobalt_copy_to_user(out, &tmp, sizeof(tmp));
+}
+
 int cobalt_thread_setschedparam_ex(unsigned long pth,
 				   int policy,
-				   const struct sched_param_ex *param_ex,
+				   const struct sched_param_ex64 *param_ex,
 				   __u32 __user *u_winoff,
 				   int __user *u_promoted)
 {
@@ -508,18 +586,22 @@ COBALT_SYSCALL(thread_setschedparam_ex, conforming,
 		__u32 __user *u_winoff,
 		int __user *u_promoted))
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
+	int ret;
 
-	if (cobalt_copy_from_user(&param_ex, u_param, sizeof(param_ex)))
-		return -EFAULT;
+	ret = cobalt_thread_get_schedparam_ex(&param_ex, u_param, policy);
+	if (ret)
+		return ret;
 
-	return cobalt_thread_setschedparam_ex(pth, policy, &param_ex,
-					      u_winoff, u_promoted);
+	ret = cobalt_thread_setschedparam_ex(pth, policy, &param_ex, u_winoff,
+					     u_promoted);
+
+	return ret;
 }
 
 int cobalt_thread_getschedparam_ex(unsigned long pth,
 				   int *policy_r,
-				   struct sched_param_ex *param_ex)
+				   struct sched_param_ex64 *param_ex)
 {
 	struct cobalt_local_hkey hkey;
 	struct cobalt_thread *thread;
@@ -545,7 +627,7 @@ COBALT_SYSCALL(thread_getschedparam_ex, current,
 		int __user *u_policy,
 		struct sched_param_ex __user *u_param))
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
 	int ret, policy;
 
 	ret = cobalt_thread_getschedparam_ex(pth, &policy, &param_ex);
@@ -556,7 +638,7 @@ COBALT_SYSCALL(thread_getschedparam_ex, current,
 	if (ret)
 		return ret;
 
-	return cobalt_copy_to_user(u_param, &param_ex, sizeof(param_ex));
+	return cobalt_thread_put_schedparam_ex(u_param, &param_ex, policy);
 }
 
 int cobalt_thread_setschedprio(unsigned long pth,
@@ -564,7 +646,7 @@ int cobalt_thread_setschedprio(unsigned long pth,
 			       __u32 __user *u_winoff,
 			       int __user *u_promoted)
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
 	struct cobalt_thread *thread;
 	int ret, policy, promoted;
 
@@ -597,7 +679,7 @@ COBALT_SYSCALL(thread_setschedprio, conforming,
 }
 
 int __cobalt_thread_create(unsigned long pth, int policy,
-			   struct sched_param_ex *param_ex,
+			   struct sched_param_ex64 *param_ex,
 			   int xid, __u32 __user *u_winoff)
 {
 	struct cobalt_thread *thread = NULL;
@@ -650,10 +732,10 @@ COBALT_SYSCALL(thread_create, init,
 		int xid,
 		__u32 __user *u_winoff))
 {
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
 	int ret;
 
-	ret = cobalt_copy_from_user(&param_ex, u_param, sizeof(param_ex));
+	ret = cobalt_thread_get_schedparam_ex(&param_ex, u_param, policy);
 	if (ret)
 		return ret;
 
@@ -665,7 +747,7 @@ cobalt_thread_shadow(struct cobalt_local_hkey *hkey,
 		     __u32 __user *u_winoff)
 {
 	struct cobalt_thread *thread = NULL;
-	struct sched_param_ex param_ex;
+	struct sched_param_ex64 param_ex;
 	int ret;
 
 	if (xnthread_current())
@@ -911,7 +993,7 @@ EXPORT_SYMBOL_GPL(cobalt_thread_restrict);
 #endif /* !CONFIG_XENO_OPT_COBALT_EXTENSION */
 
 const char *cobalt_trace_parse_sched_params(struct trace_seq *p, int policy,
-					    struct sched_param_ex *params)
+					    struct sched_param_ex64 *params)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
 
@@ -930,7 +1012,7 @@ const char *cobalt_trace_parse_sched_params(struct trace_seq *p, int policy,
 		break;
 	case SCHED_SPORADIC:
 		trace_seq_printf(p, "priority=%d, low_priority=%d, "
-				 "budget=(%ld.%09ld), period=(%ld.%09ld), "
+				 "budget=(%lld.%09lld), period=(%lld.%09lld), "
 				 "maxrepl=%d",
 				 params->sched_priority,
 				 params->sched_ss_low_priority,
diff --git a/kernel/cobalt/posix/thread.h b/kernel/cobalt/posix/thread.h
index 0959ff6d7..8916d05b9 100644
--- a/kernel/cobalt/posix/thread.h
+++ b/kernel/cobalt/posix/thread.h
@@ -112,6 +112,27 @@ struct cobalt_sigwait_context {
 	struct siginfo *si;
 };
 
+struct __sched_ss_param64 {
+	int __sched_low_priority;
+	struct __kernel_timespec __sched_repl_period;
+	struct __kernel_timespec __sched_init_budget;
+	int __sched_max_repl;
+};
+
+struct __sched_rr_param64 {
+	struct __kernel_timespec __sched_rr_quantum;
+};
+
+struct sched_param_ex64 {
+	int sched_priority;
+	union {
+		struct __sched_ss_param64 ss;
+		struct __sched_rr_param64 rr;
+		struct __sched_tp_param tp;
+		struct __sched_quota_param quota;
+	} sched_u;
+};
+
 static inline struct cobalt_thread *cobalt_current_thread(void)
 {
 	struct xnthread *curr = xnthread_current();
@@ -119,25 +140,33 @@ static inline struct cobalt_thread *cobalt_current_thread(void)
 }
 
 int __cobalt_thread_create(unsigned long pth, int policy,
-			   struct sched_param_ex __user *u_param,
+			   struct sched_param_ex64 __user *u_param,
 			   int xid, __u32 __user *u_winoff);
 
+int cobalt_thread_get_schedparam_ex(struct sched_param_ex64 *out,
+				    const struct sched_param_ex *in,
+				    int policy);
+
+int cobalt_thread_put_schedparam_ex(struct sched_param_ex *out,
+				    const struct sched_param_ex64 *in,
+				    int policy);
+
 int __cobalt_thread_setschedparam_ex(struct cobalt_thread *thread, int policy,
-				     const struct sched_param_ex *param_ex);
+				     const struct sched_param_ex64 *param_ex);
 
 int cobalt_thread_setschedparam_ex(unsigned long pth,
 				   int policy,
-				   const struct sched_param_ex *param_ex,
+				   const struct sched_param_ex64 *param_ex,
 				   __u32 __user *u_winoff,
 				   int __user *u_promoted);
 
 int cobalt_thread_getschedparam_ex(unsigned long pth,
 				   int *policy_r,
-				   struct sched_param_ex *param_ex);
+				   struct sched_param_ex64 *param_ex);
 
 int __cobalt_thread_getschedparam_ex(struct cobalt_thread *thread,
 				     int *policy_r,
-				     struct sched_param_ex *param_ex);
+				     struct sched_param_ex64 *param_ex);
 
 int cobalt_thread_setschedprio(unsigned long pth,
 			       int prio,
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 47dc77e1c..c6c430cff 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -217,21 +217,21 @@ DECLARE_EVENT_CLASS(cobalt_syscall_exit,
 			 {SCHED_WEAK, "weak"})
 
 const char *cobalt_trace_parse_sched_params(struct trace_seq *, int,
-					    struct sched_param_ex *);
+					    struct sched_param_ex64 *);
 
 #define __parse_sched_params(policy, params)			\
 	cobalt_trace_parse_sched_params(p, policy,		\
-					(struct sched_param_ex *)(params))
+					(struct sched_param_ex64 *)(params))
 
 DECLARE_EVENT_CLASS(cobalt_posix_schedparam,
 	TP_PROTO(unsigned long pth, int policy,
-		 const struct sched_param_ex *param_ex),
+		 const struct sched_param_ex64 *param_ex),
 	TP_ARGS(pth, policy, param_ex),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, pth)
 		__field(int, policy)
-		__dynamic_array(char, param_ex, sizeof(struct sched_param_ex))
+		__dynamic_array(char, param_ex, sizeof(struct sched_param_ex64))
 	),
 
 	TP_fast_assign(
@@ -250,13 +250,13 @@ DECLARE_EVENT_CLASS(cobalt_posix_schedparam,
 
 DECLARE_EVENT_CLASS(cobalt_posix_scheduler,
 	TP_PROTO(pid_t pid, int policy,
-		 const struct sched_param_ex *param_ex),
+		 const struct sched_param_ex64 *param_ex),
 	TP_ARGS(pid, policy, param_ex),
 
 	TP_STRUCT__entry(
 		__field(pid_t, pid)
 		__field(int, policy)
-		__dynamic_array(char, param_ex, sizeof(struct sched_param_ex))
+		__dynamic_array(char, param_ex, sizeof(struct sched_param_ex64))
 	),
 
 	TP_fast_assign(
@@ -307,19 +307,19 @@ DEFINE_EVENT(cobalt_syscall_exit, cobalt_root_sysexit,
 
 DEFINE_EVENT(cobalt_posix_schedparam, cobalt_pthread_create,
 	TP_PROTO(unsigned long pth, int policy,
-		 const struct sched_param_ex *param_ex),
+		 const struct sched_param_ex64 *param_ex),
 	TP_ARGS(pth, policy, param_ex)
 );
 
 DEFINE_EVENT(cobalt_posix_schedparam, cobalt_pthread_setschedparam,
 	TP_PROTO(unsigned long pth, int policy,
-		 const struct sched_param_ex *param_ex),
+		 const struct sched_param_ex64 *param_ex),
 	TP_ARGS(pth, policy, param_ex)
 );
 
 DEFINE_EVENT(cobalt_posix_schedparam, cobalt_pthread_getschedparam,
 	TP_PROTO(unsigned long pth, int policy,
-		 const struct sched_param_ex *param_ex),
+		 const struct sched_param_ex64 *param_ex),
 	TP_ARGS(pth, policy, param_ex)
 );
 
@@ -501,7 +501,7 @@ TRACE_EVENT(cobalt_sched_get_config,
 
 DEFINE_EVENT(cobalt_posix_scheduler, cobalt_sched_setscheduler,
 	TP_PROTO(pid_t pid, int policy,
-		 const struct sched_param_ex *param_ex),
+		 const struct sched_param_ex64 *param_ex),
 	TP_ARGS(pid, policy, param_ex)
 );
 

-- 
2.39.2

