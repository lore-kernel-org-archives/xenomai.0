Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0011872
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:48:37 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230705063827c8448414baaed37282
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jul 2023 08:38:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pIveP+qrTHumUeSqJTMC10X2g2+CLDSWGjHWY28WFMs=;
 b=j9eAC0/xIzFFkdS7M2Ts0MzWbmGWdKc8GqaJPbgcfKCe3k6LwYQWrNp5k4vRQ3VaBEVJhD
 Ho8l6w8hyEXCjYLJnZqiozTDjlwqIzcOs5731AfDDzvxQPptPvCbEPYooes+QoZPkpmSXalR
 GlWpoQvI7hwKEa/nHHSD5fBYt8EYc=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 05 Jul 2023 08:38:31 +0200
Subject: [PATCH 09/12] y2038: testsuite/smokey/y2038: Add tests for
 sched_param_ex related syscalls
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v1-9-604a089542c2@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Extend the smokey testsuite to do some tests for the recently added
time64_t based syscalls:
  - thread_setschedparam_ex64
  - thread_getschedparam_ex64
  - sched_setscheduler_ex64
  - sched_getscheduler_ex64

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 322 +++++++++++++++++++++++++++++++++
 1 file changed, 322 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index d5ab2e8b1..ab7c3bb4c 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1601,6 +1601,316 @@ out:
 	return test_pselect64_interruption();
 }
 
+static void *cobalt_getset_schedparam_ex64_thread(void *arg)
+{
+	long sc_set = sc_cobalt_thread_setschedparam_ex64;
+	long sc_get = sc_cobalt_thread_getschedparam_ex64;
+	pthread_t thread = pthread_self();
+	int promoted;
+	int policy;
+	int ret;
+
+	/* ABI compatible to struct sched_param_ex64. */
+	struct {
+		int sched_priority;
+		int: 32;
+		union {
+			struct {
+				struct xn_timespec64 __sched_rr_quantum;
+			} rr;
+			struct {
+				int sched_low_priority;
+				int: 32;
+				struct xn_timespec64 sched_repl_period;
+				struct xn_timespec64 sched_init_budget;
+				int sched_max_repl;
+				int: 32;
+			} ss;
+		} sched_u;
+	} p;
+
+	/* get: Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL5(sc_get, 0, 0, NULL, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_thread_getschedparam_ex64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+
+	/* set: Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL5(sc_set, 0, 0, NULL, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_thread_setschedparam_ex64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	/* Overwrite */
+	policy = SCHED_RR;
+	p.sched_priority = 50;
+	p.sched_rr_quantum.tv_sec = 12345;
+	p.sched_rr_quantum.tv_nsec = 67890123;
+	ret = XENOMAI_SYSCALL5(sc_set, thread, policy, &p, NULL, &promoted);
+	if (!smokey_assert(!ret)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	/* Fetch again and compare, reset compare values first */
+	p.sched_priority = 0;
+	p.sched_rr_quantum.tv_sec = 0;
+	p.sched_rr_quantum.tv_nsec = 0;
+	ret = XENOMAI_SYSCALL5(sc_get, thread, &policy, &p, NULL, &promoted);
+	if (!smokey_assert(!ret)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	ret = 1;
+	ret &= smokey_assert(policy == SCHED_RR);
+	ret &= smokey_assert(p.sched_priority == 50);
+	ret &= smokey_assert(p.sched_rr_quantum.tv_sec == 12345);
+	ret &= smokey_assert(p.sched_rr_quantum.tv_nsec == 67890123);
+	if (!ret)
+		ret = -EINVAL;
+	else
+		ret = 0;
+out:
+	return (void *)(long)ret;
+}
+
+static int test_sc_cobalt_thread_set_and_getschedparam_ex64(void)
+{
+	struct sched_param param = { .sched_priority = 1 };
+	pthread_attr_t attr;
+	pthread_t t;
+	void *res;
+	int ret;
+
+	ret = smokey_check_status(pthread_attr_init(&attr));
+	ret |= smokey_check_status(
+		pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE));
+	ret |= smokey_check_status(
+		pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED));
+	ret |= smokey_check_status(
+		pthread_attr_setschedpolicy(&attr, SCHED_RR));
+	ret |= smokey_check_status(pthread_attr_setschedparam(&attr, &param));
+	if (ret)
+		return ret;
+
+	ret = smokey_check_status(pthread_create(
+		&t, &attr, cobalt_getset_schedparam_ex64_thread, NULL));
+	if (ret)
+		return ret;
+
+	ret = smokey_check_status(pthread_join(t, &res));
+	if (ret)
+		return ret;
+
+	if (res)
+		return (int)(long)res;
+
+	return smokey_check_status(pthread_attr_destroy(&attr));
+}
+
+static void *cobalt_sched_setandget_config_np64_thread(void *arg)
+{
+#define WINDOWS 2
+	long sc_nr_set = sc_cobalt_sched_setconfig_np64;
+	long sc_nr_get = sc_cobalt_sched_getconfig_np64;
+	size_t len_out;
+	size_t len_in;
+	int avail;
+	int ret;
+
+	/* ABI compatible to union sched_config64 */
+	union {
+		struct {
+			int op;
+			int nr_windows;
+			struct {
+				struct xn_timespec64 offset;
+				struct xn_timespec64 duration;
+				int ptid;
+				int: 32;
+			} windows[WINDOWS];
+		} tp;
+
+	} cfg_in = { 0 }, cfg_out = { 0 };
+
+	ret = cobalt_corectl(_CC_COBALT_GET_POLICIES, &avail, sizeof(avail));
+	if (ret || (avail & _CC_COBALT_SCHED_TP) == 0)
+		return (void *)(long)-ENOSYS;
+
+	len_in = sizeof(cfg_in);
+
+	cfg_in.tp.op = sched_tp_install;
+	cfg_in.tp.nr_windows = WINDOWS;
+	cfg_in.tp.windows[0].offset.tv_sec = 0;
+	cfg_in.tp.windows[0].offset.tv_nsec = 0;
+	cfg_in.tp.windows[0].duration.tv_sec = 0;
+	cfg_in.tp.windows[0].duration.tv_nsec = 100000000;
+	cfg_in.tp.windows[0].ptid = 1;
+	cfg_in.tp.windows[1].offset.tv_sec = 0;
+	cfg_in.tp.windows[1].offset.tv_nsec = 100000000;
+	cfg_in.tp.windows[1].duration.tv_sec = 0;
+	cfg_in.tp.windows[1].duration.tv_nsec = 100000000;
+	cfg_in.tp.windows[1].ptid = 1;
+
+	ret = XENOMAI_SYSCALL4(sc_nr_set, 0, SCHED_TP, &cfg_in, len_in);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_sched_setconfig_np64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(!ret)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	len_out = len_in;
+	ret = XENOMAI_SYSCALL4(sc_nr_get, 0, SCHED_TP, &cfg_out, len_out);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_sched_getconfig_np64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == len_in)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/* We can't use memcmp() here, the padding will be uninitialized */
+	ret = 1;
+	ret &= smokey_assert(cfg_in.tp.op == cfg_out.tp.op);
+	ret &= smokey_assert(cfg_in.tp.nr_windows == cfg_out.tp.nr_windows);
+	for (int i = 0; i < WINDOWS; i++) {
+		ret &= smokey_assert(cfg_in.tp.windows[i].offset.tv_sec ==
+				     cfg_out.tp.windows[i].offset.tv_sec);
+		ret &= smokey_assert(cfg_in.tp.windows[i].offset.tv_nsec ==
+				     cfg_out.tp.windows[i].offset.tv_nsec);
+		ret &= smokey_assert(cfg_in.tp.windows[i].duration.tv_sec ==
+				     cfg_out.tp.windows[i].duration.tv_sec);
+		ret &= smokey_assert(cfg_in.tp.windows[i].duration.tv_nsec ==
+				     cfg_out.tp.windows[i].duration.tv_nsec);
+		ret &= smokey_assert(cfg_in.tp.windows[i].ptid ==
+				     cfg_out.tp.windows[i].ptid);
+		if (!ret)
+			break;
+	}
+
+	if (ret)
+		ret = 0;
+	else
+		ret = -EINVAL;
+
+out:
+	return (void *)(long)ret;
+}
+
+static int test_sc_cobalt_sched_set_and_getconfig_np64(void)
+{
+	return run_thread(cobalt_sched_setandget_config_np64_thread, NULL, 0);
+}
+
+static void *cobalt_sched_setandget_ex64_thread(void *arg)
+{
+	long sc_nr_set = sc_cobalt_sched_setscheduler_ex64;
+	long sc_nr_get = sc_cobalt_sched_getscheduler_ex64;
+	int avail, policy, promoted;
+	uint32_t winoff;
+	int ret;
+
+	/* ABI compatible to sched_param_ex64 */
+	struct {
+		int sched_priority;
+		int: 32;
+		union {
+			struct {
+				int __sched_low_priority;
+				int: 32;
+				struct xn_timespec64 __sched_repl_period;
+				struct xn_timespec64 __sched_init_budget;
+				int __sched_max_repl;
+				int: 32;
+			} ss;
+		} sched_u;
+	} in, out;
+
+	ret = cobalt_corectl(_CC_COBALT_GET_POLICIES, &avail, sizeof(avail));
+	if (ret || (avail & _CC_COBALT_SCHED_SPORADIC) == 0)
+		return (void *)(long)-ENOSYS;
+
+	policy = SCHED_SPORADIC;
+	in.sched_priority = 50;
+	in.sched_ss_low_priority = 40;
+	in.sched_ss_repl_period.tv_sec = 0;
+	in.sched_ss_repl_period.tv_nsec = 100000;
+	in.sched_ss_init_budget.tv_sec = 0;
+	in.sched_ss_init_budget.tv_nsec = 100000;
+	in.sched_ss_max_repl = 5;
+
+	ret = XENOMAI_SYSCALL5(sc_nr_set, 0, policy, &in, &winoff, &promoted);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_sched_setparam_ex64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(!ret)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	ret = XENOMAI_SYSCALL5(sc_nr_get, 0, &policy, &out, &winoff, &promoted);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_sched_getparam_ex64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(!ret)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	/* We can't use memcmp() here as the padding will be uninitialized */
+	ret = 1;
+	ret &= smokey_assert(policy == SCHED_SPORADIC);
+	ret &= smokey_assert(in.sched_priority == out.sched_priority);
+	ret &= smokey_assert(in.sched_ss_low_priority ==
+			     out.sched_ss_low_priority);
+	ret &= smokey_assert(in.sched_ss_repl_period.tv_sec ==
+			     out.sched_ss_repl_period.tv_sec);
+	ret &= smokey_assert(in.sched_ss_repl_period.tv_nsec ==
+			     out.sched_ss_repl_period.tv_nsec);
+	ret &= smokey_assert(in.sched_ss_init_budget.tv_sec ==
+			     out.sched_ss_init_budget.tv_sec);
+	ret &= smokey_assert(in.sched_ss_init_budget.tv_nsec ==
+			     out.sched_ss_init_budget.tv_nsec);
+	ret &= smokey_assert(in.sched_ss_max_repl == out.sched_ss_max_repl);
+	if (ret)
+		ret = 0;
+	else
+		ret = -EINVAL;
+
+out:
+	return (void *)(long)ret;
+}
+
+static int test_sc_cobalt_sched_set_and_get_scheduler_ex64(void)
+{
+	return run_thread(cobalt_sched_setandget_ex64_thread, NULL, 0);
+}
+
 static int check_kernel_version(void)
 {
 	int ret, major, minor;
@@ -1710,5 +2020,17 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_thread_set_and_getschedparam_ex64();
+	if (ret)
+		return ret;
+
+	ret = test_sc_cobalt_sched_set_and_getconfig_np64();
+	if (ret)
+		return ret;
+
+	ret = test_sc_cobalt_sched_set_and_get_scheduler_ex64();
+	if (ret)
+		return ret;
+
 	return 0;
 }

-- 
2.39.2

