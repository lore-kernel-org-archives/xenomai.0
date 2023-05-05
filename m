Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA64C87
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:11 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230505072103f05a2977a7b9f71c3b
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VJGu5EM3bvP5bXs4C6G5E0SPWRfpEnOShNNPsAhmD+Y=;
 b=O0UhUmDW4vNBBN1aB+HWbXNhPLRZjvOdWjXJBnZcFr8SS5b+bmyrAI95gSVr9t2NyIdJBz
 V9x0yszh7MpHU0+KfrPR+PmHubaA+NfUDCRExqSk2Ds7YSL1BR8TwYcPbiTuV/YV6Cvt57Nt
 CyzQNr9UK/Ai5EECLRbLtYN3g37mo=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:06 +0200
Subject: [PATCH 11/17] y2038: cobalt: posix/cond: Remove compat syscall for
 cond_wait_prologue64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-11-64a972ff2189@siemens.com>
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
 kernel/cobalt/posix/cond.c      | 12 ++----------
 kernel/cobalt/posix/cond.h      |  5 -----
 kernel/cobalt/posix/syscall32.c | 10 ----------
 kernel/cobalt/posix/syscall32.h |  7 -------
 4 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/kernel/cobalt/posix/cond.c b/kernel/cobalt/posix/cond.c
index 95d1e75bc..7b87fe908 100644
--- a/kernel/cobalt/posix/cond.c
+++ b/kernel/cobalt/posix/cond.c
@@ -354,15 +354,6 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 	return err == 0 ? perr : err;
 }
 
-int __cobalt_cond_wait_prologue64(struct cobalt_cond_shadow __user *u_cnd,
-				  struct cobalt_mutex_shadow __user *u_mx,
-				  int __user *u_err, unsigned int timed,
-				  void __user *u_ts)
-{
-	return __cobalt_cond_wait_prologue(u_cnd, u_mx, u_err, u_ts,
-					   timed ? cond_fetch_timeout64 : NULL);
-}
-
 /* pthread_cond_wait_prologue(cond, mutex, count_ptr, timed, timeout) */
 COBALT_SYSCALL(cond_wait_prologue, nonrestartable,
 	       (struct cobalt_cond_shadow __user *u_cnd,
@@ -382,7 +373,8 @@ COBALT_SYSCALL(cond_wait_prologue64, nonrestartable,
 		unsigned int timed,
 		struct __kernel_timespec __user *u_ts))
 {
-	return __cobalt_cond_wait_prologue64(u_cnd, u_mx, u_err, timed, u_ts);
+	return __cobalt_cond_wait_prologue(u_cnd, u_mx, u_err, u_ts,
+					   timed ? cond_fetch_timeout64 : NULL);
 }
 
 COBALT_SYSCALL(cond_wait_epilogue, primary,
diff --git a/kernel/cobalt/posix/cond.h b/kernel/cobalt/posix/cond.h
index 1fd4256ce..c2fdd40e0 100644
--- a/kernel/cobalt/posix/cond.h
+++ b/kernel/cobalt/posix/cond.h
@@ -46,11 +46,6 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 				int (*fetch_timeout)(struct timespec64 *ts,
 						     const void __user *u_ts));
 
-int __cobalt_cond_wait_prologue64(struct cobalt_cond_shadow __user *u_cnd,
-				  struct cobalt_mutex_shadow __user *u_mx,
-				  int __user *u_err, unsigned int timed,
-				  void __user *u_ts);
-
 COBALT_SYSCALL_DECL(cond_init,
 		    (struct cobalt_cond_shadow __user *u_cnd,
 		     const struct cobalt_condattr __user *u_attr));
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 97981bda9..10b080dfd 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -236,16 +236,6 @@ COBALT_SYSCALL32emu(cond_wait_prologue, nonrestartable,
 					   timed ? sys32_fetch_timeout : NULL);
 }
 
-COBALT_SYSCALL32emu(cond_wait_prologue64, nonrestartable,
-		    (struct cobalt_cond_shadow __user *u_cnd,
-		     struct cobalt_mutex_shadow __user *u_mx,
-		     int __user *u_err,
-		     unsigned int timed,
-		     struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_cond_wait_prologue64(u_cnd, u_mx, u_err, timed, u_ts);
-}
-
 COBALT_SYSCALL32emu(mq_open, lostage,
 		    (const char __user *u_name, int oflags,
 		     mode_t mode, struct compat_mq_attr __user *u_attr))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index c96fa1379..3df6224b7 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -83,13 +83,6 @@ COBALT_SYSCALL32emu_DECL(cond_wait_prologue,
 			  unsigned int timed,
 			  struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(cond_wait_prologue64,
-			 (struct cobalt_cond_shadow __user *u_cnd,
-			  struct cobalt_mutex_shadow __user *u_mx,
-			  int __user *u_err,
-			  unsigned int timed,
-			  struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(mq_open,
 			 (const char __user *u_name, int oflags,
 			  mode_t mode, struct compat_mq_attr __user *u_attr));

-- 
2.39.2

