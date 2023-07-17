Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E542A92D
	for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 09:20:25 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023071709101558b74053aaa56f4b59
        for <xenomai@lists.linux.dev>;
        Mon, 17 Jul 2023 11:10:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Nm6+ltlxcrvme+KGvusLUeZLwpdI3QT/9VfBwuWu5So=;
 b=aWhHBeADsZ58No1soIeTLTz3ht7dQhXXmSWeGui6qic00Gq/kMpTsHVJyDZBevFL8bKkQ2
 sqKxRwl7AiOAJxOg3WfposyJDA+tcN8bNVvXXa68onnbLFJXLh5hnD/fMbNKXHQBaIRgTFOF
 myDlICk/XO2sdllOYGrgSnBbl4MEk=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 17 Jul 2023 11:10:14 +0200
Subject: [PATCH v2 2/4] y2038: cobalt/uapi: Migrate struct sched_param_ex
 to time64_t
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v2-2-b4e888eca2d9@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Instead of implementing time64_t based cobalt services for the
following services we simply break the ABI and make it time64_t aware.

Affected cobalt services:
  - cobalt_thread_create
  - cobalt_thread_setschedparam_ex
  - cobalt_thread_getschedparam_ex
  - cobalt_sched_setconfig_np
  - cobalt_sched_getconfig_np
  - cobalt_sched_setscheduler_ex
  - cobalt_sched_getscheduler_ex

XENOMAI_ABI_REV is incremented on all supported plattforms to express
the ABI breakage.

The memory alignment of some data structures is changed by adding
some anonymous paddings. This allows us to remove some compat specific
services afterwards. The memory layout is identical on all platforms
now.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/kernel/types.h                       |  5 +++++
 include/cobalt/uapi/sched.h                              | 14 +++++++++-----
 .../cobalt/arch/arm/include/asm/xenomai/uapi/features.h  |  2 +-
 .../arch/arm64/include/asm/xenomai/uapi/features.h       |  2 +-
 .../cobalt/arch/x86/include/asm/xenomai/uapi/features.h  |  2 +-
 kernel/cobalt/posix/clock.h                              | 16 ++++++++++------
 kernel/cobalt/posix/sched.c                              | 16 ++++++++--------
 kernel/cobalt/posix/thread.c                             |  8 ++++----
 8 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/include/cobalt/uapi/kernel/types.h b/include/cobalt/uapi/kernel/types.h
index 2c931c29c..495c94506 100644
--- a/include/cobalt/uapi/kernel/types.h
+++ b/include/cobalt/uapi/kernel/types.h
@@ -57,6 +57,11 @@ static inline xnhandle_t xnhandle_get_id(xnhandle_t handle)
 	return handle & ~XN_HANDLE_TRANSIENT_MASK;
 }
 
+struct xn_ts64 {
+	__u64 tv_sec;
+	__u64 tv_nsec;
+};
+
 /*
  * Our representation of time specs at the kernel<->user interface
  * boundary at the moment, until we have fully transitioned to a
diff --git a/include/cobalt/uapi/sched.h b/include/cobalt/uapi/sched.h
index 14095870f..6b1639feb 100644
--- a/include/cobalt/uapi/sched.h
+++ b/include/cobalt/uapi/sched.h
@@ -33,15 +33,17 @@
 
 struct __sched_ss_param {
 	int __sched_low_priority;
-	struct __user_old_timespec __sched_repl_period;
-	struct __user_old_timespec __sched_init_budget;
+	int: 32;
+	struct xn_ts64 __sched_repl_period;
+	struct xn_ts64 __sched_init_budget;
 	int __sched_max_repl;
+	int: 32;
 };
 
 #define sched_rr_quantum	sched_u.rr.__sched_rr_quantum
 
 struct __sched_rr_param {
-	struct __user_old_timespec __sched_rr_quantum;
+	struct xn_ts64 __sched_rr_quantum;
 };
 
 #ifndef SCHED_TP
@@ -54,9 +56,10 @@ struct __sched_tp_param {
 };
 
 struct sched_tp_window {
-	struct __user_old_timespec offset;
-	struct __user_old_timespec duration;
+	struct xn_ts64 offset;
+	struct xn_ts64 duration;
 	int ptid;
+	int: 32;
 };
 
 enum {
@@ -122,6 +125,7 @@ struct __sched_config_quota {
 
 struct sched_param_ex {
 	int sched_priority;
+	int: 32;
 	union {
 		struct __sched_ss_param ss;
 		struct __sched_rr_param rr;
diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
index 43b7afb10..fdd5c0e32 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
@@ -22,7 +22,7 @@
 #define _COBALT_ARM_ASM_UAPI_FEATURES_H
 
 /* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   18UL
+#define XENOMAI_ABI_REV   19UL
 
 #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
 
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
index b98a96392..301797748 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
@@ -22,7 +22,7 @@
 #define _COBALT_ARM64_ASM_UAPI_FEATURES_H
 
 /* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   2UL
+#define XENOMAI_ABI_REV   3UL
 
 #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
 
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
index 65f8164a0..045adf0c1 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
@@ -19,7 +19,7 @@
 #define _COBALT_X86_ASM_UAPI_FEATURES_H
 
 /* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   18UL
+#define XENOMAI_ABI_REV   19UL
 
 #define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
 
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 38b59e24f..82c26ea08 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -33,11 +33,6 @@ static inline void ns2ts(struct timespec64 *ts, xnticks_t nsecs)
 	ts->tv_sec = xnclock_divrem_billion(nsecs, &ts->tv_nsec);
 }
 
-static inline void u_ns2ts(struct __user_old_timespec *ts, xnticks_t nsecs)
-{
-	ts->tv_sec = xnclock_divrem_billion(nsecs, &ts->tv_nsec);
-}
-
 static inline xnticks_t ts2ns(const struct timespec64 *ts)
 {
 	xnticks_t nsecs = ts->tv_nsec;
@@ -48,7 +43,7 @@ static inline xnticks_t ts2ns(const struct timespec64 *ts)
 	return nsecs;
 }
 
-static inline xnticks_t u_ts2ns(const struct __user_old_timespec *ts)
+static inline xnticks_t xnts64_2ns(const struct xn_ts64 *ts)
 {
 	xnticks_t nsecs = ts->tv_nsec;
 
@@ -76,6 +71,15 @@ static inline void ticks2ts64(struct timespec64 *ts, xnticks_t ticks)
 	ts->tv_nsec = nsecs;
 }
 
+static inline void ticks2xnts64(struct xn_ts64 *ts, xnticks_t ticks)
+{
+	unsigned long nsecs;
+
+	ts->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
+	ts->tv_nsec = nsecs;
+}
+
+
 static inline xnticks_t clock_get_ticks(clockid_t clock_id)
 {
 	return clock_id == CLOCK_REALTIME ?
diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
index 994ee88d9..41c935f59 100644
--- a/kernel/cobalt/posix/sched.c
+++ b/kernel/cobalt/posix/sched.c
@@ -73,7 +73,7 @@ cobalt_sched_policy_param(union xnsched_policy_param *param,
 		break;
 	case SCHED_RR:
 		/* if unspecified, use current one. */
-		tslice = u_ts2ns(&param_ex->sched_rr_quantum);
+		tslice = xnts64_2ns(&param_ex->sched_rr_quantum);
 		if (tslice == XN_INFINITE && tslice_r)
 			tslice = *tslice_r;
 		fallthrough;
@@ -92,8 +92,8 @@ cobalt_sched_policy_param(union xnsched_policy_param *param,
 		param->pss.normal_prio = param_ex->sched_priority;
 		param->pss.low_prio = param_ex->sched_ss_low_priority;
 		param->pss.current_prio = param->pss.normal_prio;
-		param->pss.init_budget = u_ts2ns(&param_ex->sched_ss_init_budget);
-		param->pss.repl_period = u_ts2ns(&param_ex->sched_ss_repl_period);
+		param->pss.init_budget = xnts64_2ns(&param_ex->sched_ss_init_budget);
+		param->pss.repl_period = xnts64_2ns(&param_ex->sched_ss_repl_period);
 		param->pss.max_repl = param_ex->sched_ss_max_repl;
 		sched_class = &xnsched_class_sporadic;
 		break;
@@ -280,11 +280,11 @@ int set_tp_config(int cpu, union sched_config *config, size_t len)
 		 * be defined using windows assigned to the pseudo
 		 * partition #-1.
 		 */
-		offset = u_ts2ns(&p->offset);
+		offset = xnts64_2ns(&p->offset);
 		if (offset != next_offset)
 			goto cleanup_and_fail;
 
-		duration = u_ts2ns(&p->duration);
+		duration = xnts64_2ns(&p->duration);
 		if (duration <= 0)
 			goto cleanup_and_fail;
 
@@ -357,11 +357,11 @@ ssize_t get_tp_config(int cpu, void __user *u_config, size_t len,
 	config->tp.nr_windows = gps->pwin_nr;
 	for (n = 0, pp = p = config->tp.windows, pw = w = gps->pwins;
 	     n < gps->pwin_nr; pp = p, p++, pw = w, w++, n++) {
-		u_ns2ts(&p->offset, w->w_offset);
-		u_ns2ts(&pp->duration, w->w_offset - pw->w_offset);
+		ticks2xnts64(&p->offset, w->w_offset);
+		ticks2xnts64(&pp->duration, w->w_offset - pw->w_offset);
 		p->ptid = w->w_part;
 	}
-	u_ns2ts(&pp->duration, gps->tf_duration - pw->w_offset);
+	ticks2xnts64(&pp->duration, gps->tf_duration - pw->w_offset);
 	ret = put_config(SCHED_TP, u_config, len, config, elen);
 	xnfree(config);
 out:
diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index 94a6e394e..46c3f4797 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -302,7 +302,7 @@ int __cobalt_thread_getschedparam_ex(struct cobalt_thread *thread,
 
 	if (base_class == &xnsched_class_rt) {
 		if (xnthread_test_state(base_thread, XNRRB)) {
-			u_ns2ts(&param_ex->sched_rr_quantum, base_thread->rrperiod);
+			ticks2xnts64(&param_ex->sched_rr_quantum, base_thread->rrperiod);
 			*policy_r = SCHED_RR;
 		}
 		goto out;
@@ -318,8 +318,8 @@ int __cobalt_thread_getschedparam_ex(struct cobalt_thread *thread,
 #ifdef CONFIG_XENO_OPT_SCHED_SPORADIC
 	if (base_class == &xnsched_class_sporadic) {
 		param_ex->sched_ss_low_priority = base_thread->pss->param.low_prio;
-		u_ns2ts(&param_ex->sched_ss_repl_period, base_thread->pss->param.repl_period);
-		u_ns2ts(&param_ex->sched_ss_init_budget, base_thread->pss->param.init_budget);
+		ticks2xnts64(&param_ex->sched_ss_repl_period, base_thread->pss->param.repl_period);
+		ticks2xnts64(&param_ex->sched_ss_init_budget, base_thread->pss->param.init_budget);
 		param_ex->sched_ss_max_repl = base_thread->pss->param.max_repl;
 		goto out;
 	}
@@ -930,7 +930,7 @@ const char *cobalt_trace_parse_sched_params(struct trace_seq *p, int policy,
 		break;
 	case SCHED_SPORADIC:
 		trace_seq_printf(p, "priority=%d, low_priority=%d, "
-				 "budget=(%ld.%09ld), period=(%ld.%09ld), "
+				 "budget=(%lld.%09lld), period=(%lld.%09lld), "
 				 "maxrepl=%d",
 				 params->sched_priority,
 				 params->sched_ss_low_priority,

-- 
2.39.2

