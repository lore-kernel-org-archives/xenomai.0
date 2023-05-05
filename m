Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54FD1C08
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:03 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202305050721009cf99c860b5c86c363
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5cjYig4txBemPkWgX7sTFnR2P+CuYmWO08pR7ENLUK8=;
 b=UdRDsNXuHJ0PwoChwBqKWANJqzlQ+pI+xOkTb8hNZSQJLJhidJhoowvtmAdFifjKyVOXaF
 0926QIo6PAgtSw38l+RpL8pmQn+uz+6vqxiSeNOKqq0NK7uV11WnIa+Oser/MOVyMi3Iozjt
 JuIGAFcAZpMh1B0iclMIcalVr/AFs=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:20:59 +0200
Subject: [PATCH 04/17] y2038: cobalt: posix/clock: Remove compat syscall
 for clock_nanosleep64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-4-64a972ff2189@siemens.com>
References: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
In-Reply-To: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is no difference between the native and the compat entry point,
so let's keep it simple. The native entrypoint is already linked into
the syscall table at the right offset.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/clock.c     | 13 +++----------
 kernel/cobalt/posix/clock.h     |  4 ----
 kernel/cobalt/posix/syscall32.c |  9 ---------
 kernel/cobalt/posix/syscall32.h |  6 ------
 4 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index c4457b6c9..7b1693612 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -385,9 +385,10 @@ COBALT_SYSCALL(clock_nanosleep, primary,
 	return ret;
 }
 
-int __cobalt_clock_nanosleep64(clockid_t clock_id, int flags,
+COBALT_SYSCALL(clock_nanosleep64, primary,
+	       (clockid_t clock_id, int flags,
 		const struct __kernel_timespec __user *u_rqt,
-		struct __kernel_timespec __user *u_rmt)
+		struct __kernel_timespec __user *u_rmt))
 {
 	struct timespec64 rqt, rmt, *rmtp = NULL;
 	int ret;
@@ -407,14 +408,6 @@ int __cobalt_clock_nanosleep64(clockid_t clock_id, int flags,
 	return ret;
 }
 
-COBALT_SYSCALL(clock_nanosleep64, primary,
-	       (clockid_t clock_id, int flags,
-		const struct __kernel_timespec __user *u_rqt,
-		struct __kernel_timespec __user *u_rmt))
-{
-	return __cobalt_clock_nanosleep64(clock_id, flags, u_rqt, u_rmt);
-}
-
 int cobalt_clock_register(struct xnclock *clock, const cpumask_t *affinity,
 			  clockid_t *clk_id)
 {
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 2607522e8..b5ab39b44 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -116,10 +116,6 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     const struct timespec64 *rqt,
 			     struct timespec64 *rmt);
 
-int __cobalt_clock_nanosleep64(clockid_t clock_id, int flags,
-		const struct __kernel_timespec __user *u_rqt,
-		struct __kernel_timespec __user *u_rmt);
-
 COBALT_SYSCALL_DECL(clock_getres,
 		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 30d7e1bcd..a245e91af 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -232,15 +232,6 @@ COBALT_SYSCALL32emu(clock_nanosleep, primary,
 	return ret;
 }
 
-COBALT_SYSCALL32emu(clock_nanosleep64, nonrestartable,
-		    (clockid_t clock_id, int flags,
-		     const struct __kernel_timespec __user *u_rqt,
-		     struct __kernel_timespec __user *u_rmt))
-{
-	return __cobalt_clock_nanosleep64(clock_id, flags, u_rqt, u_rmt);
-}
-
-
 COBALT_SYSCALL32emu(mutex_timedlock, primary,
 		    (struct cobalt_mutex_shadow __user *u_mx,
 		     const struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index c016c904c..0e06e12c1 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -80,12 +80,6 @@ COBALT_SYSCALL32emu_DECL(clock_nanosleep,
 			  const struct old_timespec32 __user *u_rqt,
 			  struct old_timespec32 __user *u_rmt));
 
-COBALT_SYSCALL32emu_DECL(clock_nanosleep64,
-			 (clockid_t clock_id, int flags,
-			  const struct __kernel_timespec __user *u_rqt,
-			  struct __kernel_timespec __user *u_rmt));
-
-
 COBALT_SYSCALL32emu_DECL(mutex_timedlock,
 			 (struct cobalt_mutex_shadow __user *u_mx,
 			  const struct old_timespec32 __user *u_ts));

-- 
2.39.2

