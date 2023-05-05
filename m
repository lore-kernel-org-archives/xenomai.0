Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C114C8C
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:09 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023050507210198d2dab98542ef4348
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=F9jokeQUCjUnQ97f9PdLomxTX96JyeOVYvv514oR42I=;
 b=oqIsWT7fZVHpCSFICiOYNZwJArmyYGF7EEji56Oe46edZfBdPM3ucPa7vX80RXX3WBj+lX
 PQbspBpfkZX7g9TeLjP5xM4ZKTtdgV82F/WBzWzswB4uQn/4QrryBCR49D8ZuDrD1A/uUUGT
 2kY9YOGUBca3UM2FQsdaQ7j0hlasY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:02 +0200
Subject: [PATCH 07/17] y2038: cobalt: posix/mutex: Remove compat syscall
 for mutex_timedlock64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-7-64a972ff2189@siemens.com>
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
 kernel/cobalt/posix/mutex.c     | 10 ++--------
 kernel/cobalt/posix/mutex.h     |  3 ---
 kernel/cobalt/posix/syscall32.c |  7 -------
 kernel/cobalt/posix/syscall32.h |  4 ----
 4 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/kernel/cobalt/posix/mutex.c b/kernel/cobalt/posix/mutex.c
index 0f1c01851..2bdb66d17 100644
--- a/kernel/cobalt/posix/mutex.c
+++ b/kernel/cobalt/posix/mutex.c
@@ -364,13 +364,6 @@ static inline int mutex_fetch_timeout64(struct timespec64 *ts,
 	return u_ts == NULL ? -EFAULT : cobalt_get_timespec64(ts, u_ts);
 }
 
-int __cobalt_mutex_timedlock64(struct cobalt_mutex_shadow __user *u_mx,
-			       const void __user *u_ts)
-{
-	return __cobalt_mutex_timedlock_break(u_mx, u_ts,
-					      mutex_fetch_timeout64);
-}
-
 COBALT_SYSCALL(mutex_timedlock, primary,
 	       (struct cobalt_mutex_shadow __user *u_mx,
 		const struct __user_old_timespec __user *u_ts))
@@ -382,7 +375,8 @@ COBALT_SYSCALL(mutex_timedlock64, primary,
 	       (struct cobalt_mutex_shadow __user *u_mx,
 		const struct __kernel_timespec __user *u_ts))
 {
-	return __cobalt_mutex_timedlock64(u_mx, u_ts);
+	return __cobalt_mutex_timedlock_break(u_mx, u_ts,
+					      mutex_fetch_timeout64);
 }
 
 COBALT_SYSCALL(mutex_unlock, nonrestartable,
diff --git a/kernel/cobalt/posix/mutex.h b/kernel/cobalt/posix/mutex.h
index d7fede27d..800515a69 100644
--- a/kernel/cobalt/posix/mutex.h
+++ b/kernel/cobalt/posix/mutex.h
@@ -40,9 +40,6 @@ int __cobalt_mutex_timedlock_break(struct cobalt_mutex_shadow __user *u_mx,
 				   int (*fetch_timeout)(struct timespec64 *ts,
 							const void __user *u_ts));
 
-int __cobalt_mutex_timedlock64(struct cobalt_mutex_shadow __user *u_mx,
-				   const void __user *u_ts);
-
 int __cobalt_mutex_acquire_unchecked(struct xnthread *cur,
 				     struct cobalt_mutex *mutex,
 				     const struct timespec64 *ts);
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 245ddb2f0..d3cc79878 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -225,13 +225,6 @@ COBALT_SYSCALL32emu(mutex_timedlock, primary,
 	return __cobalt_mutex_timedlock_break(u_mx, u_ts, sys32_fetch_timeout);
 }
 
-COBALT_SYSCALL32emu(mutex_timedlock64, primary,
-		    (struct cobalt_mutex_shadow __user *u_mx,
-		     const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_mutex_timedlock64(u_mx, u_ts);
-}
-
 COBALT_SYSCALL32emu(cond_wait_prologue, nonrestartable,
 		    (struct cobalt_cond_shadow __user *u_cnd,
 		     struct cobalt_mutex_shadow __user *u_mx,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index b7baee94d..ab7dbb945 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -76,10 +76,6 @@ COBALT_SYSCALL32emu_DECL(mutex_timedlock,
 			 (struct cobalt_mutex_shadow __user *u_mx,
 			  const struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(mutex_timedlock64,
-			 (struct cobalt_mutex_shadow __user *u_mx,
-			  const struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(cond_wait_prologue,
 			 (struct cobalt_cond_shadow __user *u_cnd,
 			  struct cobalt_mutex_shadow __user *u_mx,

-- 
2.39.2

