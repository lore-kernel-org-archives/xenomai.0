Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B124C7C
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:07 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023050507205949d40ef4ec22d992c3
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:20:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=X2nwIKsyXOj+5YwIBKf6MoRc9e5Jqu1A7b4hmatnv2E=;
 b=KXiKZgbtfgooEXMGGvAMX7VrfEOL8PYl7aGKoSLtqRZpa2h3iF/MxlC0Kl5nq61Cc9KyG/
 vA+EytCosnYa/+zcSpEF2hM+weVCRsUZJTB+l0kK3c5RTUuJyLQAe2CQggpqtuC8MQXN6/LX
 M5QZ0z7EWNOFMcKgr2BZboINbDTbw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:20:57 +0200
Subject: [PATCH 02/17] y2038: cobalt: posix/clock: Remove compat syscall
 for clock_gettime64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-2-64a972ff2189@siemens.com>
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
 kernel/cobalt/posix/clock.c     | 10 ++--------
 kernel/cobalt/posix/clock.h     |  3 ---
 kernel/cobalt/posix/syscall32.c |  7 -------
 kernel/cobalt/posix/syscall32.h |  4 ----
 4 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 16cc8b20a..bd393bb11 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -162,8 +162,8 @@ COBALT_SYSCALL(clock_gettime, current,
 	return 0;
 }
 
-int __cobalt_clock_gettime64(clockid_t clock_id,
-			struct __kernel_timespec __user *u_ts)
+COBALT_SYSCALL(clock_gettime64, current,
+	       (clockid_t clock_id, struct __kernel_timespec __user *u_ts))
 {
 	struct timespec64 ts;
 	int ret;
@@ -178,12 +178,6 @@ int __cobalt_clock_gettime64(clockid_t clock_id,
 	return 0;
 }
 
-COBALT_SYSCALL(clock_gettime64, current,
-	       (clockid_t clock_id, struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_clock_gettime64(clock_id, u_ts);
-}
-
 int __cobalt_clock_settime(clockid_t clock_id, const struct timespec64 *ts)
 {
 	int _ret, ret = 0;
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index e18373979..169d51e62 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -103,9 +103,6 @@ int __cobalt_clock_getres64(clockid_t clock_id,
 int __cobalt_clock_gettime(clockid_t clock_id,
 			   struct timespec64 *ts);
 
-int __cobalt_clock_gettime64(clockid_t clock_id,
-			struct __kernel_timespec __user *u_ts);
-
 int __cobalt_clock_settime(clockid_t clock_id,
 			   const struct timespec64 *ts);
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 2b4911c59..917a67625 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -172,13 +172,6 @@ COBALT_SYSCALL32emu(clock_gettime, current,
 	return sys32_put_timespec(u_ts, &ts);
 }
 
-COBALT_SYSCALL32emu(clock_gettime64, current,
-		    (clockid_t clock_id,
-		     struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_clock_gettime64(clock_id, u_ts);
-}
-
 COBALT_SYSCALL32emu(clock_settime, current,
 		    (clockid_t clock_id,
 		     const struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index f36fff272..7d448d0ef 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -63,10 +63,6 @@ COBALT_SYSCALL32emu_DECL(clock_gettime,
 			 (clockid_t clock_id,
 			  struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(clock_gettime64,
-			 (clockid_t clock_id,
-			  struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(clock_settime,
 			 (clockid_t clock_id,
 			  const struct old_timespec32 __user *u_ts));

-- 
2.39.2

