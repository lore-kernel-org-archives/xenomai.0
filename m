Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F45846E
	for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 09:10:24 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230717091016b8528e4e9c77a4f54b
        for <xenomai@lists.linux.dev>;
        Mon, 17 Jul 2023 11:10:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=n3nfe93YhhuciKh1mQpMVgSJSgb5wwrmKySqG4E6HPE=;
 b=JGrEH6WNMfhMipzwObUpccaJgXzpApUe360vHYRd2EerEXzbttQyc2+ZLMAP61ywwVxO1Q
 RcuWQlpYoRX++yeE70fVCdUo9jIlpUsi0w+SctQNPc2l2nRRwnGzNsyCO9Reba7bvSfPPWkN
 UaNFKo5KEiZXQPL9viCYq2DD5+dfc=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 17 Jul 2023 11:10:16 +0200
Subject: [PATCH v2 4/4] y2038: cobalt/{thread,sched}: Remove obsolete
 compat handling
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v2-4-b4e888eca2d9@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Remove the compat specific handling of the following cobalt services:
  - thread_create
  - thread_setschedparam_ex
  - thread_getschedparam_ex
  - sched_weightprio
  - sched_setconfig_np
  - sched_getconfig_np
  - sched_setscheduler_ex
  - sched_getscheduler_ex

All necessary helper functions and compat specific re-decleration of
affected data structures have been removed.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/compat.h                     |  49 -----
 .../arch/x86/include/asm/xenomai/syscall32-table.h |   8 -
 kernel/cobalt/posix/compat.c                       |  72 -------
 kernel/cobalt/posix/syscall32.c                    | 233 ---------------------
 kernel/cobalt/posix/syscall32.h                    |  45 ----
 5 files changed, 407 deletions(-)

diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
index 275735df5..d064cada4 100644
--- a/include/cobalt/kernel/compat.h
+++ b/include/cobalt/kernel/compat.h
@@ -27,27 +27,6 @@
 
 struct mq_attr;
 
-struct __compat_sched_ss_param {
-	int __sched_low_priority;
-	struct old_timespec32 __sched_repl_period;
-	struct old_timespec32 __sched_init_budget;
-	int __sched_max_repl;
-};
-
-struct __compat_sched_rr_param {
-	struct old_timespec32 __sched_rr_quantum;
-};
-
-struct compat_sched_param_ex {
-	int sched_priority;
-	union {
-		struct __compat_sched_ss_param ss;
-		struct __compat_sched_rr_param rr;
-		struct __sched_tp_param tp;
-		struct __sched_quota_param quota;
-	} sched_u;
-};
-
 struct compat_mq_attr {
 	compat_long_t mq_flags;
 	compat_long_t mq_maxmsg;
@@ -55,26 +34,6 @@ struct compat_mq_attr {
 	compat_long_t mq_curmsgs;
 };
 
-struct compat_sched_tp_window {
-	struct old_timespec32 offset;
-	struct old_timespec32 duration;
-	int ptid;
-};
-
-struct __compat_sched_config_tp {
-	int op;
-	int nr_windows;
-	struct compat_sched_tp_window windows[0];
-};
-
-union compat_sched_config {
-	struct __compat_sched_config_tp tp;
-	struct __sched_config_quota quota;
-};
-
-#define compat_sched_tp_confsz(nr_win) \
-  (sizeof(struct __compat_sched_config_tp) + nr_win * sizeof(struct compat_sched_tp_window))
-
 typedef struct {
 	compat_ulong_t fds_bits[__FD_SETSIZE / (8 * sizeof(compat_long_t))];
 } compat_fd_set;
@@ -116,14 +75,6 @@ int sys32_get_fdset(fd_set *fds, const compat_fd_set __user *cfds,
 int sys32_put_fdset(compat_fd_set __user *cfds, const fd_set *fds,
 		    size_t fdsize);
 
-int sys32_get_param_ex(int policy,
-		       struct sched_param_ex *p,
-		       const struct compat_sched_param_ex __user *u_cp);
-
-int sys32_put_param_ex(int policy,
-		       struct compat_sched_param_ex __user *u_cp,
-		       const struct sched_param_ex *p);
-
 int sys32_get_mqattr(struct mq_attr *ap,
 		     const struct compat_mq_attr __user *u_cap);
 
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
index 3986b227b..3d64c46a7 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
@@ -24,9 +24,6 @@
  * table. Only preprocessor stuff and syscall entries here.
  */
 
-__COBALT_CALL32emu_THUNK(thread_create)
-__COBALT_CALL32emu_THUNK(thread_setschedparam_ex)
-__COBALT_CALL32emu_THUNK(thread_getschedparam_ex)
 __COBALT_CALL32emu_THUNK(thread_setschedprio)
 __COBALT_CALL32emu_THUNK(sem_open)
 __COBALT_CALL32emu_THUNK(sem_timedwait)
@@ -41,11 +38,6 @@ __COBALT_CALL32emu_THUNK(mq_getattr)
 __COBALT_CALL32emu_THUNK(mq_timedsend)
 __COBALT_CALL32emu_THUNK(mq_timedreceive)
 __COBALT_CALL32emu_THUNK(mq_notify)
-__COBALT_CALL32emu_THUNK(sched_weightprio)
-__COBALT_CALL32emu_THUNK(sched_setconfig_np)
-__COBALT_CALL32emu_THUNK(sched_getconfig_np)
-__COBALT_CALL32emu_THUNK(sched_setscheduler_ex)
-__COBALT_CALL32emu_THUNK(sched_getscheduler_ex)
 __COBALT_CALL32emu_THUNK(timer_create)
 __COBALT_CALL32emu_THUNK(timer_settime)
 __COBALT_CALL32emu_THUNK(timer_gettime)
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index c7fc4fc33..080eda449 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -206,78 +206,6 @@ int sys32_put_fdset(compat_fd_set __user *cfds, const fd_set *fds,
 	return 0;
 }
 
-int sys32_get_param_ex(int policy,
-		       struct sched_param_ex *p,
-		       const struct compat_sched_param_ex __user *u_cp)
-{
-	struct compat_sched_param_ex cpex;
-
-	if (u_cp == NULL || cobalt_copy_from_user(&cpex, u_cp, sizeof(cpex)))
-		return -EFAULT;
-
-	p->sched_priority = cpex.sched_priority;
-
-	switch (policy) {
-	case SCHED_SPORADIC:
-		p->sched_ss_low_priority = cpex.sched_ss_low_priority;
-		p->sched_ss_max_repl = cpex.sched_ss_max_repl;
-		p->sched_ss_repl_period.tv_sec = cpex.sched_ss_repl_period.tv_sec;
-		p->sched_ss_repl_period.tv_nsec = cpex.sched_ss_repl_period.tv_nsec;
-		p->sched_ss_init_budget.tv_sec = cpex.sched_ss_init_budget.tv_sec;
-		p->sched_ss_init_budget.tv_nsec = cpex.sched_ss_init_budget.tv_nsec;
-		break;
-	case SCHED_RR:
-		p->sched_rr_quantum.tv_sec = cpex.sched_rr_quantum.tv_sec;
-		p->sched_rr_quantum.tv_nsec = cpex.sched_rr_quantum.tv_nsec;
-		break;
-	case SCHED_TP:
-		p->sched_tp_partition = cpex.sched_tp_partition;
-		break;
-	case SCHED_QUOTA:
-		p->sched_quota_group = cpex.sched_quota_group;
-		break;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(sys32_get_param_ex);
-
-int sys32_put_param_ex(int policy,
-		       struct compat_sched_param_ex __user *u_cp,
-		       const struct sched_param_ex *p)
-{
-	struct compat_sched_param_ex cpex;
-
-	if (u_cp == NULL)
-		return -EFAULT;
-
-	cpex.sched_priority = p->sched_priority;
-
-	switch (policy) {
-	case SCHED_SPORADIC:
-		cpex.sched_ss_low_priority = p->sched_ss_low_priority;
-		cpex.sched_ss_max_repl = p->sched_ss_max_repl;
-		cpex.sched_ss_repl_period.tv_sec = p->sched_ss_repl_period.tv_sec;
-		cpex.sched_ss_repl_period.tv_nsec = p->sched_ss_repl_period.tv_nsec;
-		cpex.sched_ss_init_budget.tv_sec = p->sched_ss_init_budget.tv_sec;
-		cpex.sched_ss_init_budget.tv_nsec = p->sched_ss_init_budget.tv_nsec;
-		break;
-	case SCHED_RR:
-		cpex.sched_rr_quantum.tv_sec = p->sched_rr_quantum.tv_sec;
-		cpex.sched_rr_quantum.tv_nsec = p->sched_rr_quantum.tv_nsec;
-		break;
-	case SCHED_TP:
-		cpex.sched_tp_partition = p->sched_tp_partition;
-		break;
-	case SCHED_QUOTA:
-		cpex.sched_quota_group = p->sched_quota_group;
-		break;
-	}
-
-	return cobalt_copy_to_user(u_cp, &cpex, sizeof(cpex));
-}
-EXPORT_SYMBOL_GPL(sys32_put_param_ex);
-
 int sys32_get_mqattr(struct mq_attr *ap,
 		     const struct compat_mq_attr __user *u_cap)
 {
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index c82cc60a2..793bde138 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -37,58 +37,6 @@
 #include "io.h"
 #include "../debug.h"
 
-COBALT_SYSCALL32emu(thread_create, init,
-		    (compat_ulong_t pth,
-		     int policy,
-		     const struct compat_sched_param_ex __user *u_param_ex,
-		     int xid,
-		     __u32 __user *u_winoff))
-{
-	struct sched_param_ex param_ex;
-	int ret;
-
-	ret = sys32_get_param_ex(policy, &param_ex, u_param_ex);
-	if (ret)
-		return ret;
-
-	return __cobalt_thread_create(pth, policy, &param_ex, xid, u_winoff);
-}
-
-COBALT_SYSCALL32emu(thread_setschedparam_ex, conforming,
-		    (compat_ulong_t pth,
-		     int policy,
-		     const struct compat_sched_param_ex __user *u_param_ex,
-		     __u32 __user *u_winoff,
-		     int __user *u_promoted))
-{
-	struct sched_param_ex param_ex;
-	int ret;
-
-	ret = sys32_get_param_ex(policy, &param_ex, u_param_ex);
-	if (ret)
-		return ret;
-
-	return cobalt_thread_setschedparam_ex(pth, policy, &param_ex,
-					      u_winoff, u_promoted);
-}
-
-COBALT_SYSCALL32emu(thread_getschedparam_ex, current,
-		    (compat_ulong_t pth,
-		     int __user *u_policy,
-		     struct compat_sched_param_ex __user *u_param))
-{
-	struct sched_param_ex param_ex;
-	int ret, policy;
-
-	ret = cobalt_thread_getschedparam_ex(pth, &policy, &param_ex);
-	if (ret)
-		return ret;
-
-	ret = cobalt_copy_to_user(u_policy, &policy, sizeof(policy));
-
-	return ret ?: sys32_put_param_ex(policy, u_param, &param_ex);
-}
-
 COBALT_SYSCALL32emu(thread_setschedprio, conforming,
 		    (compat_ulong_t pth,
 		     int prio,
@@ -333,187 +281,6 @@ COBALT_SYSCALL32emu(mq_notify, primary,
 	return __cobalt_mq_notify(fd, u_cev ? &sev : NULL);
 }
 
-COBALT_SYSCALL32emu(sched_weightprio, current,
-		    (int policy,
-		     const struct compat_sched_param_ex __user *u_param))
-{
-	struct sched_param_ex param_ex;
-	int ret;
-
-	ret = sys32_get_param_ex(policy, &param_ex, u_param);
-	if (ret)
-		return ret;
-
-	return __cobalt_sched_weightprio(policy, &param_ex);
-}
-
-static union sched_config *
-sys32_fetch_config(int policy, const void __user *u_config, size_t *len)
-{
-	union compat_sched_config *cbuf;
-	union sched_config *buf;
-	int ret, n;
-
-	if (u_config == NULL)
-		return ERR_PTR(-EFAULT);
-
-	if (policy == SCHED_QUOTA && *len < sizeof(cbuf->quota))
-		return ERR_PTR(-EINVAL);
-
-	cbuf = xnmalloc(*len);
-	if (cbuf == NULL)
-		return ERR_PTR(-ENOMEM);
-
-	ret = cobalt_copy_from_user(cbuf, u_config, *len);
-	if (ret) {
-		buf = ERR_PTR(ret);
-		goto out;
-	}
-
-	switch (policy) {
-	case SCHED_TP:
-		*len = sched_tp_confsz(cbuf->tp.nr_windows);
-		break;
-	case SCHED_QUOTA:
-		break;
-	default:
-		buf = ERR_PTR(-EINVAL);
-		goto out;
-	}
-
-	buf = xnmalloc(*len);
-	if (buf == NULL) {
-		buf = ERR_PTR(-ENOMEM);
-		goto out;
-	}
-
-	if (policy == SCHED_QUOTA)
-		memcpy(&buf->quota, &cbuf->quota, sizeof(cbuf->quota));
-	else {
-		buf->tp.op = cbuf->tp.op;
-		buf->tp.nr_windows = cbuf->tp.nr_windows;
-		for (n = 0; n < buf->tp.nr_windows; n++) {
-			buf->tp.windows[n].ptid = cbuf->tp.windows[n].ptid;
-			buf->tp.windows[n].offset.tv_sec = cbuf->tp.windows[n].offset.tv_sec;
-			buf->tp.windows[n].offset.tv_nsec = cbuf->tp.windows[n].offset.tv_nsec;
-			buf->tp.windows[n].duration.tv_sec = cbuf->tp.windows[n].duration.tv_sec;
-			buf->tp.windows[n].duration.tv_nsec = cbuf->tp.windows[n].duration.tv_nsec;
-		}
-	}
-out:
-	xnfree(cbuf);
-
-	return buf;
-}
-
-static int sys32_ack_config(int policy, const union sched_config *config,
-			    void __user *u_config)
-{
-	union compat_sched_config __user *u_p = u_config;
-
-	if (policy != SCHED_QUOTA)
-		return 0;
-
-	return u_config == NULL ? -EFAULT :
-		cobalt_copy_to_user(&u_p->quota.info, &config->quota.info,
-				       sizeof(u_p->quota.info));
-}
-
-static ssize_t sys32_put_config(int policy,
-				void __user *u_config, size_t u_len,
-				const union sched_config *config, size_t len)
-{
-	union compat_sched_config __user *u_p = u_config;
-	int n, ret;
-
-	if (u_config == NULL)
-		return -EFAULT;
-
-	if (policy == SCHED_QUOTA) {
-		if (u_len < sizeof(u_p->quota))
-			return -EINVAL;
-		return cobalt_copy_to_user(&u_p->quota.info, &config->quota.info,
-					      sizeof(u_p->quota.info)) ?:
-			sizeof(u_p->quota.info);
-	}
-
-	/* SCHED_TP */
-
-	if (u_len < compat_sched_tp_confsz(config->tp.nr_windows))
-		return -ENOSPC;
-
-	__xn_put_user(config->tp.op, &u_p->tp.op);
-	__xn_put_user(config->tp.nr_windows, &u_p->tp.nr_windows);
-
-	for (n = 0, ret = 0; n < config->tp.nr_windows; n++) {
-		ret |= __xn_put_user(config->tp.windows[n].ptid,
-				     &u_p->tp.windows[n].ptid);
-		ret |= __xn_put_user(config->tp.windows[n].offset.tv_sec,
-				     &u_p->tp.windows[n].offset.tv_sec);
-		ret |= __xn_put_user(config->tp.windows[n].offset.tv_nsec,
-				     &u_p->tp.windows[n].offset.tv_nsec);
-		ret |= __xn_put_user(config->tp.windows[n].duration.tv_sec,
-				     &u_p->tp.windows[n].duration.tv_sec);
-		ret |= __xn_put_user(config->tp.windows[n].duration.tv_nsec,
-				     &u_p->tp.windows[n].duration.tv_nsec);
-	}
-
-	return ret ?: u_len;
-}
-
-COBALT_SYSCALL32emu(sched_setconfig_np, conforming,
-		    (int cpu, int policy,
-		     union compat_sched_config __user *u_config,
-		     size_t len))
-{
-	return __cobalt_sched_setconfig_np(cpu, policy, u_config, len,
-					   sys32_fetch_config, sys32_ack_config);
-}
-
-COBALT_SYSCALL32emu(sched_getconfig_np, conformin,
-		    (int cpu, int policy,
-		     union compat_sched_config __user *u_config,
-		     size_t len))
-{
-	return __cobalt_sched_getconfig_np(cpu, policy, u_config, len,
-					   sys32_fetch_config, sys32_put_config);
-}
-
-COBALT_SYSCALL32emu(sched_setscheduler_ex, conforming,
-		    (compat_pid_t pid,
-		     int policy,
-		     const struct compat_sched_param_ex __user *u_param_ex,
-		     __u32 __user *u_winoff,
-		     int __user *u_promoted))
-{
-	struct sched_param_ex param_ex;
-	int ret;
-
-	ret = sys32_get_param_ex(policy, &param_ex, u_param_ex);
-	if (ret)
-		return ret;
-
-	return cobalt_sched_setscheduler_ex(pid, policy, &param_ex,
-					    u_winoff, u_promoted);
-}
-
-COBALT_SYSCALL32emu(sched_getscheduler_ex, current,
-		    (compat_pid_t pid,
-		     int __user *u_policy,
-		     struct compat_sched_param_ex __user *u_param))
-{
-	struct sched_param_ex param_ex;
-	int ret, policy;
-
-	ret = cobalt_sched_getscheduler_ex(pid, &policy, &param_ex);
-	if (ret)
-		return ret;
-
-	ret = cobalt_copy_to_user(u_policy, &policy, sizeof(policy));
-
-	return ret ?: sys32_put_param_ex(policy, u_param, &param_ex);
-}
-
 COBALT_SYSCALL32emu(timer_create, current,
 		    (clockid_t clock,
 		     const struct compat_sigevent __user *u_sev,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 3df6224b7..abe7e4404 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -26,25 +26,6 @@ struct cobalt_cond_shadow;
 struct cobalt_sem_shadow;
 struct cobalt_monitor_shadow;
 
-COBALT_SYSCALL32emu_DECL(thread_create,
-			 (compat_ulong_t pth,
-			  int policy,
-			  const struct compat_sched_param_ex __user *u_param_ex,
-			  int xid,
-			  __u32 __user *u_winoff));
-
-COBALT_SYSCALL32emu_DECL(thread_setschedparam_ex,
-			 (compat_ulong_t pth,
-			  int policy,
-			  const struct compat_sched_param_ex __user *u_param,
-			  __u32 __user *u_winoff,
-			  int __user *u_promoted));
-
-COBALT_SYSCALL32emu_DECL(thread_getschedparam_ex,
-			 (compat_ulong_t pth,
-			  int __user *u_policy,
-			  struct compat_sched_param_ex __user *u_param));
-
 COBALT_SYSCALL32emu_DECL(thread_setschedprio,
 			 (compat_ulong_t pth,
 			  int prio,
@@ -110,32 +91,6 @@ COBALT_SYSCALL32emu_DECL(mq_timedreceive64,
 COBALT_SYSCALL32emu_DECL(mq_notify,
 			 (mqd_t fd, const struct compat_sigevent *__user u_cev));
 
-COBALT_SYSCALL32emu_DECL(sched_weightprio,
-			 (int policy,
-			  const struct compat_sched_param_ex __user *u_param));
-
-COBALT_SYSCALL32emu_DECL(sched_setconfig_np,
-			 (int cpu, int policy,
-			  union compat_sched_config __user *u_config,
-			  size_t len));
-
-COBALT_SYSCALL32emu_DECL(sched_getconfig_np,
-			 (int cpu, int policy,
-			  union compat_sched_config __user *u_config,
-			  size_t len));
-
-COBALT_SYSCALL32emu_DECL(sched_setscheduler_ex,
-			 (compat_pid_t pid,
-			  int policy,
-			  const struct compat_sched_param_ex __user *u_param,
-			  __u32 __user *u_winoff,
-			  int __user *u_promoted));
-
-COBALT_SYSCALL32emu_DECL(sched_getscheduler_ex,
-			 (compat_pid_t pid,
-			  int __user *u_policy,
-			  struct compat_sched_param_ex __user *u_param));
-
 COBALT_SYSCALL32emu_DECL(timer_create,
 			 (clockid_t clock,
 			  const struct compat_sigevent __user *u_sev,

-- 
2.39.2

