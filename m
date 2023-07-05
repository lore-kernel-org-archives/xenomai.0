Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146FED2
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:48:34 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230705063824185410b775d6293fe3
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jul 2023 08:38:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vKeMibSymWRcil0WubJesUUQmODhxdc4L0G3QqV8WY8=;
 b=mCZ3SF6Em5Q1WFSOXfeTAB7GoVzfsQaHmgz8juf1cWhr72Jw8ktQjY/flvc9W3gILH6lgJ
 aq/BUKDLf1U4moQCrCyXmMnptY/Id0ehpV4OF0e4koHX6a9OUXi/rEiyQJzoNCmtDtUXTV1Z
 SO8Vyb+UvLpjGyfSCqw7NtKT8CfeE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 05 Jul 2023 08:38:24 +0200
Subject: [PATCH 02/12] y2038: cobalt: Introduce sched_config64 and use it
 internally
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v1-2-604a089542c2@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Introducing a new type sched_config64. All members are (always) based
on time64_t. All internal APIs have been migrated. Existing compat
and native system call entry points do the necessary translation.

This is a preparation step for introducing time64_t based cobalt sched
cobalt services.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/clock.h     |  27 ++-----
 kernel/cobalt/posix/sched.c     | 172 ++++++++++++++++++++++++++++++----------
 kernel/cobalt/posix/sched.h     |  30 ++++++-
 kernel/cobalt/posix/syscall32.c |  12 +--
 4 files changed, 171 insertions(+), 70 deletions(-)

diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index b0fc84396..294b1bf02 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -34,11 +34,6 @@ static inline void ns2ts(struct timespec64 *ts, xnticks_t nsecs)
 	ts->tv_sec = xnclock_divrem_billion(nsecs, &ts->tv_nsec);
 }
 
-static inline void u_ns2ts(struct __user_old_timespec *ts, xnticks_t nsecs)
-{
-	ts->tv_sec = xnclock_divrem_billion(nsecs, &ts->tv_nsec);
-}
-
 static inline void ns2kts(struct __kernel_timespec *kts, xnticks_t ticks)
 {
 	unsigned long nsecs;
@@ -74,16 +69,6 @@ static inline xnticks_t kts2ns(const struct __kernel_timespec *ts)
 	return nsecs;
 }
 
-static inline xnticks_t u_ts2ns(const struct __user_old_timespec *ts)
-{
-	xnticks_t nsecs = ts->tv_nsec;
-
-	if (ts->tv_sec)
-		nsecs += (xnticks_t)ts->tv_sec * ONE_BILLION;
-
-	return nsecs;
-}
-
 static inline xnticks_t tv2ns(const struct __kernel_old_timeval *tv)
 {
 	xnticks_t nsecs = tv->tv_usec * 1000;
@@ -137,34 +122,34 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     struct timespec64 *rmt);
 
 COBALT_SYSCALL_DECL(clock_getres,
-		    (clockid_t clock_id, struct __kernel_old_timespec __user *u_ts));
+		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_getres64,
 		    (clockid_t clock_id, struct __kernel_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_gettime,
-		    (clockid_t clock_id, struct __kernel_old_timespec __user *u_ts));
+		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_gettime64,
 		    (clockid_t clock_id, struct __kernel_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_settime,
-		    (clockid_t clock_id, const struct __kernel_old_timespec __user *u_ts));
+		    (clockid_t clock_id, const struct __user_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_settime64,
 		    (clockid_t clock_id,
 			 const struct __kernel_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_adjtime,
-		    (clockid_t clock_id, struct old_timex32 __user *u_tx));
+		    (clockid_t clock_id, struct __user_old_timex __user *u_tx));
 
 COBALT_SYSCALL_DECL(clock_adjtime64,
 		    (clockid_t clock_id, struct __kernel_timex __user *u_tx));
 
 COBALT_SYSCALL_DECL(clock_nanosleep,
 		    (clockid_t clock_id, int flags,
-		     const struct __kernel_old_timespec __user *u_rqt,
-		     struct __kernel_old_timespec __user *u_rmt));
+		     const struct __user_old_timespec __user *u_rqt,
+		     struct __user_old_timespec __user *u_rmt));
 
 COBALT_SYSCALL_DECL(clock_nanosleep64,
 		    (clockid_t clock_id, int flags,
diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
index 1c3a7de61..5163863c2 100644
--- a/kernel/cobalt/posix/sched.c
+++ b/kernel/cobalt/posix/sched.c
@@ -229,13 +229,13 @@ COBALT_SYSCALL(sched_yield, primary, (void))
 
 #ifdef CONFIG_XENO_OPT_SCHED_TP
 
-static inline
-int set_tp_config(int cpu, union sched_config *config, size_t len)
+static inline int set_tp_config(int cpu, union sched_config64 *config,
+				size_t len)
 {
 	xnticks_t offset, duration, next_offset;
 	struct xnsched_tp_schedule *gps, *ogps;
 	struct xnsched_tp_window *w;
-	struct sched_tp_window *p;
+	struct sched_tp_window64 *p;
 	struct xnsched *sched;
 	spl_t s;
 	int n;
@@ -280,11 +280,11 @@ int set_tp_config(int cpu, union sched_config *config, size_t len)
 		 * be defined using windows assigned to the pseudo
 		 * partition #-1.
 		 */
-		offset = u_ts2ns(&p->offset);
+		offset = kts2ns(&p->offset);
 		if (offset != next_offset)
 			goto cleanup_and_fail;
 
-		duration = u_ts2ns(&p->duration);
+		duration = kts2ns(&p->duration);
 		if (duration <= 0)
 			goto cleanup_and_fail;
 
@@ -318,18 +318,15 @@ cleanup_and_fail:
 
 static inline
 ssize_t get_tp_config(int cpu, void __user *u_config, size_t len,
-		      union sched_config *(*fetch_config)
-		      (int policy, const void __user *u_config,
-		       size_t *len),
 		      ssize_t (*put_config)(int policy, void __user *u_config,
 					    size_t u_len,
-					    const union sched_config *config,
+					    const union sched_config64 *config,
 					    size_t len))
 {
 	struct xnsched_tp_window *pw, *w;
 	struct xnsched_tp_schedule *gps;
-	struct sched_tp_window *pp, *p;
-	union sched_config *config;
+	struct sched_tp_window64 *pp, *p;
+	union sched_config64 *config;
 	struct xnsched *sched;
 	ssize_t ret, elen;
 	spl_t s;
@@ -346,9 +343,9 @@ ssize_t get_tp_config(int cpu, void __user *u_config, size_t len,
 
 	xnlock_put_irqrestore(&nklock, s);
 
-	elen = sched_tp_confsz(gps->pwin_nr);
+	elen = sched_tp_confsz64(gps->pwin_nr);
 	config = xnmalloc(elen);
-	if (config == NULL) {
+	if (!config) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -357,11 +354,11 @@ ssize_t get_tp_config(int cpu, void __user *u_config, size_t len,
 	config->tp.nr_windows = gps->pwin_nr;
 	for (n = 0, pp = p = config->tp.windows, pw = w = gps->pwins;
 	     n < gps->pwin_nr; pp = p, p++, pw = w, w++, n++) {
-		u_ns2ts(&p->offset, w->w_offset);
-		u_ns2ts(&pp->duration, w->w_offset - pw->w_offset);
+		ns2kts(&p->offset, w->w_offset);
+		ns2kts(&pp->duration, w->w_offset - pw->w_offset);
 		p->ptid = w->w_part;
 	}
-	u_ns2ts(&pp->duration, gps->tf_duration - pw->w_offset);
+	ns2kts(&pp->duration, gps->tf_duration - pw->w_offset);
 	ret = put_config(SCHED_TP, u_config, len, config, elen);
 	xnfree(config);
 out:
@@ -380,12 +377,9 @@ set_tp_config(int cpu, union sched_config *config, size_t len)
 
 static inline ssize_t
 get_tp_config(int cpu, union sched_config __user *u_config, size_t len,
-	      union sched_config *(*fetch_config)
-	      (int policy, const void __user *u_config,
-	       size_t *len),
 	      ssize_t (*put_config)(int policy, void __user *u_config,
 				    size_t u_len,
-				    const union sched_config *config,
+				    const union sched_config64 *config,
 				    size_t len))
 {
 	return -EINVAL;
@@ -396,7 +390,7 @@ get_tp_config(int cpu, union sched_config __user *u_config, size_t len,
 #ifdef CONFIG_XENO_OPT_SCHED_QUOTA
 
 static inline
-int set_quota_config(int cpu, union sched_config *config, size_t len)
+int set_quota_config(int cpu, union sched_config64 *config, size_t len)
 {
 	struct __sched_config_quota *p = &config->quota;
 	struct __sched_quota_info *iq = &p->info;
@@ -484,17 +478,17 @@ bad_tgid:
 
 static inline
 ssize_t get_quota_config(int cpu, void __user *u_config, size_t len,
-			 union sched_config *(*fetch_config)
+			 union sched_config64 *(*fetch_config)
 			 (int policy, const void __user *u_config,
 			  size_t *len),
 			 ssize_t (*put_config)(int policy, void __user *u_config,
 					       size_t u_len,
-					       const union sched_config *config,
+					       const union sched_config64 *config,
 					       size_t len))
 {
 	struct cobalt_sched_group *group;
 	struct xnsched_quota_group *tg;
-	union sched_config *config;
+	union sched_config64 *config;
 	struct xnsched *sched;
 	ssize_t ret;
 	spl_t s;
@@ -533,7 +527,7 @@ bad_tgid:
 #else /* !CONFIG_XENO_OPT_SCHED_QUOTA */
 
 static inline
-int set_quota_config(int cpu, union sched_config *config, size_t len)
+int set_quota_config(int cpu, union sched_config64 *config, size_t len)
 {
 	return -EINVAL;
 }
@@ -541,7 +535,7 @@ int set_quota_config(int cpu, union sched_config *config, size_t len)
 static inline
 ssize_t get_quota_config(int cpu, void __user *u_config,
 			 size_t len,
-			 union sched_config *(*fetch_config)
+			 union sched_config64 *(*fetch_config)
 			 (int policy, const void __user *u_config,
 			  size_t *len),
 			 ssize_t (*put_config)(int policy, void __user *u_config,
@@ -554,10 +548,76 @@ ssize_t get_quota_config(int cpu, void __user *u_config,
 
 #endif /* !CONFIG_XENO_OPT_SCHED_QUOTA */
 
-static union sched_config *
+static union sched_config64 *
 sched_fetch_config(int policy, const void __user *u_config, size_t *len)
 {
-	union sched_config *buf;
+	union sched_config64 *buf;
+	union sched_config *sbuf;
+	int ret;
+	int n;
+
+	if (u_config == NULL)
+		return ERR_PTR(-EFAULT);
+
+	if (policy == SCHED_QUOTA && *len < sizeof(buf->quota))
+		return ERR_PTR(-EINVAL);
+
+	sbuf = xnmalloc(*len);
+	if (!sbuf)
+		return ERR_PTR(-ENOMEM);
+
+	ret = cobalt_copy_from_user(sbuf, u_config, *len);
+	if (ret) {
+		buf = ERR_PTR(ret);
+		goto out;
+	}
+
+	switch (policy) {
+	case SCHED_TP:
+		*len = sched_tp_confsz64(sbuf->tp.nr_windows);
+		break;
+	case SCHED_QUOTA:
+		break;
+	default:
+		buf = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	buf = xnmalloc(*len);
+	if (buf == NULL) {
+		buf = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	if (policy == SCHED_QUOTA) {
+		memcpy(&buf->quota, &sbuf->quota, sizeof(sbuf->quota));
+		goto out;
+	}
+
+	buf->tp.op = sbuf->tp.op;
+	buf->tp.nr_windows = sbuf->tp.nr_windows;
+	for (n = 0, ret = 0; n < buf->tp.nr_windows; n++) {
+		buf->tp.windows[n].ptid = sbuf->tp.windows[n].ptid;
+		buf->tp.windows[n].offset.tv_sec =
+			sbuf->tp.windows[n].offset.tv_sec;
+		buf->tp.windows[n].offset.tv_nsec =
+			sbuf->tp.windows[n].offset.tv_nsec;
+		buf->tp.windows[n].duration.tv_sec =
+			sbuf->tp.windows[n].duration.tv_sec;
+		buf->tp.windows[n].duration.tv_nsec =
+			sbuf->tp.windows[n].duration.tv_nsec;
+	}
+
+out:
+	xnfree(sbuf);
+
+	return buf;
+}
+
+static union sched_config64 *
+sched_fetch_config64(int policy, const void __user *u_config, size_t *len)
+{
+	union sched_config64 *buf;
 	int ret;
 
 	if (u_config == NULL)
@@ -579,7 +639,7 @@ sched_fetch_config(int policy, const void __user *u_config, size_t *len)
 	return buf;
 }
 
-static int sched_ack_config(int policy, const union sched_config *config,
+static int sched_ack_config(int policy, const union sched_config64 *config,
 			    void __user *u_config)
 {
 	union sched_config __user *u_p = u_config;
@@ -587,16 +647,18 @@ static int sched_ack_config(int policy, const union sched_config *config,
 	if (policy != SCHED_QUOTA)
 		return 0;
 
+	/* SCHED_QUOTA does not need special time64_t handling */
 	return u_p == NULL ? -EFAULT :
 		cobalt_copy_to_user(&u_p->quota.info, &config->quota.info,
 				       sizeof(u_p->quota.info));
 }
 
-static ssize_t sched_put_config(int policy,
-				void __user *u_config, size_t u_len,
-				const union sched_config *config, size_t len)
+static ssize_t sched_put_config(int policy, void __user *u_config, size_t u_len,
+				const union sched_config64 *config, size_t len)
 {
 	union sched_config *u_p = u_config;
+	struct __kernel_old_timespec ts;
+	int ret, n;
 
 	if (u_config == NULL)
 		return -EFAULT;
@@ -609,20 +671,51 @@ static ssize_t sched_put_config(int policy,
 			sizeof(u_p->quota.info);
 	}
 
-	return cobalt_copy_to_user(u_config, config, len) ?: len;
+	if (u_len < sched_tp_confsz(config->tp.nr_windows))
+		return -ENOSPC;
+
+	__xn_put_user(config->tp.op, &u_p->tp.op);
+	__xn_put_user(config->tp.nr_windows, &u_p->tp.nr_windows);
+
+	for (n = 0, ret = 0; n < config->tp.nr_windows; n++) {
+		ret |= __xn_put_user(config->tp.windows[n].ptid,
+				     &u_p->tp.windows[n].ptid);
+
+		/* Write offset */
+		ts.tv_sec = config->tp.windows[n].offset.tv_sec;
+		ts.tv_nsec = config->tp.windows[n].offset.tv_nsec;
+		ret |= __xn_put_user(ts.tv_sec,
+				     &u_p->tp.windows[n].offset.tv_sec);
+		ret |= __xn_put_user(ts.tv_nsec,
+				     &u_p->tp.windows[n].offset.tv_nsec);
+		if (ret)
+			break;
+
+		/* Write duration */
+		ts.tv_sec = config->tp.windows[n].duration.tv_sec;
+		ts.tv_nsec = config->tp.windows[n].duration.tv_nsec;
+		ret |= __xn_put_user(ts.tv_sec,
+				     &u_p->tp.windows[n].duration.tv_sec);
+		ret |= __xn_put_user(ts.tv_nsec,
+				     &u_p->tp.windows[n].duration.tv_nsec);
+		if (ret)
+			break;
+	}
+
+	return ret ?: u_len;
 }
 
 int __cobalt_sched_setconfig_np(int cpu, int policy,
 				void __user *u_config,
 				size_t len,
-				union sched_config *(*fetch_config)
+				union sched_config64 *(*fetch_config)
 				(int policy, const void __user *u_config,
 				 size_t *len),
 				int (*ack_config)(int policy,
-						  const union sched_config *config,
+						  const union sched_config64 *config,
 						  void __user *u_config))
 {
-	union sched_config *buf;
+	union sched_config64 *buf;
 	int ret;
 
 	trace_cobalt_sched_setconfig(cpu, policy, len);
@@ -668,21 +761,20 @@ COBALT_SYSCALL(sched_setconfig_np, conforming,
 ssize_t __cobalt_sched_getconfig_np(int cpu, int policy,
 				    void __user *u_config,
 				    size_t len,
-				    union sched_config *(*fetch_config)
+				    union sched_config64 *(*fetch_config)
 				    (int policy, const void __user *u_config,
 				     size_t *len),
 				    ssize_t (*put_config)(int policy,
 							  void __user *u_config,
 							  size_t u_len,
-							  const union sched_config *config,
+							  const union sched_config64 *config,
 							  size_t len))
 {
 	ssize_t ret;
 
 	switch (policy)	{
 	case SCHED_TP:
-		ret = get_tp_config(cpu, u_config, len,
-				    fetch_config, put_config);
+		ret = get_tp_config(cpu, u_config, len, put_config);
 		break;
 	case SCHED_QUOTA:
 		ret = get_quota_config(cpu, u_config, len,
diff --git a/kernel/cobalt/posix/sched.h b/kernel/cobalt/posix/sched.h
index e8b9f9113..a226c39d3 100644
--- a/kernel/cobalt/posix/sched.h
+++ b/kernel/cobalt/posix/sched.h
@@ -34,28 +34,50 @@ struct cobalt_sched_group {
 	struct list_head next;
 };
 
+struct sched_tp_window64 {
+	struct __kernel_timespec offset;
+	struct __kernel_timespec duration;
+	int ptid;
+	int: 32;
+};
+
+struct __sched_config_tp64 {
+	int op;
+	int nr_windows;
+	struct sched_tp_window64 windows[0];
+};
+
+union sched_config64 {
+	struct __sched_config_tp64 tp;
+	struct __sched_config_quota quota;
+};
+
+#define sched_tp_confsz64(nr_win)             \
+	(sizeof(struct __sched_config_tp64) + \
+	 (nr_win) * sizeof(struct sched_tp_window64))
+
 int __cobalt_sched_weightprio(int policy,
 			      const struct sched_param_ex64 *param_ex);
 
 int __cobalt_sched_setconfig_np(int cpu, int policy,
 				void __user *u_config,
 				size_t len,
-				union sched_config *(*fetch_config)
+				union sched_config64 *(*fetch_config)
 				(int policy, const void __user *u_config,
 				 size_t *len),
 				int (*ack_config)(int policy,
-						  const union sched_config *config,
+						  const union sched_config64 *config,
 						  void __user *u_config));
 
 ssize_t __cobalt_sched_getconfig_np(int cpu, int policy,
 				    void __user *u_config,
 				    size_t len,
-				    union sched_config *(*fetch_config)
+				    union sched_config64 *(*fetch_config)
 				    (int policy, const void __user *u_config,
 				     size_t *len),
 				    ssize_t (*put_config)(int policy,
 							  void __user *u_config, size_t u_len,
-							  const union sched_config *config,
+							  const union sched_config64 *config,
 							  size_t len));
 int cobalt_sched_setscheduler_ex(pid_t pid,
 				 int policy,
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 9b09d734d..6914173c0 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -353,11 +353,11 @@ COBALT_SYSCALL32emu(sched_weightprio, current,
 	return __cobalt_sched_weightprio(policy, &param_ex);
 }
 
-static union sched_config *
+static union sched_config64 *
 sys32_fetch_config(int policy, const void __user *u_config, size_t *len)
 {
 	union compat_sched_config *cbuf;
-	union sched_config *buf;
+	union sched_config64 *buf;
 	int ret, n;
 
 	if (u_config == NULL)
@@ -378,7 +378,7 @@ sys32_fetch_config(int policy, const void __user *u_config, size_t *len)
 
 	switch (policy) {
 	case SCHED_TP:
-		*len = sched_tp_confsz(cbuf->tp.nr_windows);
+		*len = sched_tp_confsz64(cbuf->tp.nr_windows);
 		break;
 	case SCHED_QUOTA:
 		break;
@@ -412,7 +412,7 @@ out:
 	return buf;
 }
 
-static int sys32_ack_config(int policy, const union sched_config *config,
+static int sys32_ack_config(int policy, const union sched_config64 *config,
 			    void __user *u_config)
 {
 	union compat_sched_config __user *u_p = u_config;
@@ -420,6 +420,7 @@ static int sys32_ack_config(int policy, const union sched_config *config,
 	if (policy != SCHED_QUOTA)
 		return 0;
 
+	/* SCHED_QUOTA does not need special time64_t handling */
 	return u_config == NULL ? -EFAULT :
 		cobalt_copy_to_user(&u_p->quota.info, &config->quota.info,
 				       sizeof(u_p->quota.info));
@@ -427,7 +428,7 @@ static int sys32_ack_config(int policy, const union sched_config *config,
 
 static ssize_t sys32_put_config(int policy,
 				void __user *u_config, size_t u_len,
-				const union sched_config *config, size_t len)
+				const union sched_config64 *config, size_t len)
 {
 	union compat_sched_config __user *u_p = u_config;
 	int n, ret;
@@ -435,6 +436,7 @@ static ssize_t sys32_put_config(int policy,
 	if (u_config == NULL)
 		return -EFAULT;
 
+	/* SCHED_QUOTA does not need special time64_t handling */
 	if (policy == SCHED_QUOTA) {
 		if (u_len < sizeof(u_p->quota))
 			return -EINVAL;

-- 
2.39.2

