Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703F111E
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:48:35 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202307050638252fe7db6b84f93731a8
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jul 2023 08:38:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9RiQi3ibEIkj9oFS+RK0kxYr4dFmB/MCc2ZEZekSNyw=;
 b=M/FvefY1PHPXaa4kymAMpM1M+jtM8AGaMtiDxujQJYXRjjAIu4EVS/OQ9VpqCYTwkP87eV
 iIL05Ag1uHc5PLc2nNkTyRGJn2VHupf5Ff74ojYj8deKe/Gua5LxTPNRkhHCEz+AEZ6+ruRp
 /aM2xPRxUt53wLqQsMJcB43WLUTyE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 05 Jul 2023 08:38:26 +0200
Subject: [PATCH 04/12] y2038: lib/cobalt/{sched,thread}: Dispatch time64_t
 related services
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v1-4-604a089542c2@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

If libc reports time64_t support all y2038 related services are now
dispatched to the time64_t based syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/sched.c  | 38 +++++++++++++++++++++++++++++---------
 lib/cobalt/thread.c | 29 +++++++++++++++++++++--------
 2 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/lib/cobalt/sched.c b/lib/cobalt/sched.c
index bdb8603da..d44cab70a 100644
--- a/lib/cobalt/sched.c
+++ b/lib/cobalt/sched.c
@@ -304,9 +304,13 @@ int sched_setscheduler_ex(pid_t pid,
 			return errno;
 	}
 
-	ret = -XENOMAI_SYSCALL5(sc_cobalt_sched_setscheduler_ex,
-				pid, policy, param_ex,
-				&u_winoff, &promoted);
+#if __USE_TIME_BITS64
+	ret = -XENOMAI_SYSCALL5(sc_cobalt_sched_setscheduler_ex64, pid, policy,
+				param_ex, &u_winoff, &promoted);
+#else
+	ret = -XENOMAI_SYSCALL5(sc_cobalt_sched_setscheduler_ex, pid, policy,
+				param_ex, &u_winoff, &promoted);
+#endif
 
 	/*
 	 * If the kernel has no reference to the target thread, let glibc
@@ -360,8 +364,14 @@ COBALT_IMPL(int, sched_getscheduler, (pid_t pid))
 		return -1;
 	}
 
-	ret = XENOMAI_SYSCALL3(sc_cobalt_sched_getscheduler_ex,
-			       pid, &policy, &param_ex);
+#if __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL3(sc_cobalt_sched_getscheduler_ex64, pid, &policy,
+			       &param_ex);
+#else
+	ret = XENOMAI_SYSCALL3(sc_cobalt_sched_getscheduler_ex, pid, &policy,
+			       &param_ex);
+#endif
+
 	if (ret == -ESRCH)
 		return __STD(sched_getscheduler(pid));
 
@@ -562,8 +572,13 @@ int sched_get_priority_max_ex(int policy)
 int sched_setconfig_np(int cpu, int policy,
 		       const union sched_config *config, size_t len)
 {
-	return -XENOMAI_SYSCALL4(sc_cobalt_sched_setconfig_np,
-				 cpu, policy, config, len);
+#ifdef __USE_TIME_BITS64
+	return -XENOMAI_SYSCALL4(sc_cobalt_sched_setconfig_np64, cpu, policy,
+				 config, len);
+#else
+	return -XENOMAI_SYSCALL4(sc_cobalt_sched_setconfig_np, cpu, policy,
+				 config, len);
+#endif
 }
 
 /**
@@ -621,8 +636,13 @@ ssize_t sched_getconfig_np(int cpu, int policy,
 {
 	ssize_t ret;
 
-	ret = XENOMAI_SYSCALL4(sc_cobalt_sched_getconfig_np,
-			       cpu, policy, config, *len_r);
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL4(sc_cobalt_sched_getconfig_np64, cpu, policy,
+			       config, *len_r);
+#else
+	ret = XENOMAI_SYSCALL4(sc_cobalt_sched_getconfig_np, cpu, policy,
+			       config, *len_r);
+#endif
 	if (ret < 0)
 		return -ret;
 
diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
index bb23cdcb9..b68c11709 100644
--- a/lib/cobalt/thread.c
+++ b/lib/cobalt/thread.c
@@ -93,8 +93,13 @@ static void *cobalt_thread_trampoline(void *p)
 	 * Do _not_ inline the call to pthread_self() in the syscall
 	 * macro: this trashes the syscall regs on some archs.
 	 */
-	ret = -XENOMAI_SYSCALL5(sc_cobalt_thread_create, ptid,
-				policy, &param_ex, personality, &u_winoff);
+#ifdef __USE_TIME_BITS64
+	ret = -XENOMAI_SYSCALL5(sc_cobalt_thread_create64, ptid, policy,
+				&param_ex, personality, &u_winoff);
+#else
+	ret = -XENOMAI_SYSCALL5(sc_cobalt_thread_create, ptid, policy,
+				&param_ex, personality, &u_winoff);
+#endif
 	if (ret == 0)
 		cobalt_set_tsd(u_winoff);
 
@@ -640,10 +645,13 @@ int pthread_setschedparam_ex(pthread_t thread,
 	/* only request promotion when this targets the current thread */
 	u_winoff_ptr = thread == pthread_self() ? &u_winoff : NULL;
 
-	ret = -XENOMAI_SYSCALL5(sc_cobalt_thread_setschedparam_ex,
-				thread, policy, param_ex,
-				u_winoff_ptr, &promoted);
-
+#ifdef __USE_TIME_BITS64
+	ret = -XENOMAI_SYSCALL5(sc_cobalt_thread_setschedparam_ex64, thread,
+				policy, param_ex, u_winoff_ptr, &promoted);
+#else
+	ret = -XENOMAI_SYSCALL5(sc_cobalt_thread_setschedparam_ex, thread,
+				policy, param_ex, u_winoff_ptr, &promoted);
+#endif
 	/*
 	 * If the kernel has no reference to the target thread. let glibc
 	 * handle the call.
@@ -774,8 +782,13 @@ int pthread_getschedparam_ex(pthread_t thread,
 	struct sched_param short_param;
 	int ret;
 
-	ret = -XENOMAI_SYSCALL3(sc_cobalt_thread_getschedparam_ex,
-				thread, policy_r, param_ex);
+#ifdef __USE_TIME_BITS64
+	ret = -XENOMAI_SYSCALL3(sc_cobalt_thread_getschedparam_ex64, thread,
+				policy_r, param_ex);
+#else
+	ret = -XENOMAI_SYSCALL3(sc_cobalt_thread_getschedparam_ex, thread,
+				policy_r, param_ex);
+#endif
 	if (ret == ESRCH) {
 		ret = __STD(pthread_getschedparam(thread, policy_r, &short_param));
 		if (ret == 0)

-- 
2.39.2

