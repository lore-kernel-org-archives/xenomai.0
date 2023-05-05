Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AE85393
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:31:10 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230505072059e1dd91319778f990f6
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:20:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KICBqMMk7qDqiTNrZQ+wNndgojQ20tpBSxhRaEfWTC4=;
 b=R8BHYryvRwJbBgTNstUm1oCNjDq1WCGR1h2upKPq6wzfw1socMg+8YgXlrr5UNrWle3EkN
 9mIzXLImN9dSbi4Z1byykEpNA/wTkyUtjC/kUmtEG77GKG4h/Y5gW4NM+1i2Qv9nnp1cilaV
 rUe8rsswgFQRWPsTc+b87bTae94ak=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:20:58 +0200
Subject: [PATCH 03/17] y2038: cobalt: posix/clock: Remove compat syscall
 for clock_settime64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-3-64a972ff2189@siemens.com>
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
 kernel/cobalt/posix/clock.c     | 11 +++--------
 kernel/cobalt/posix/clock.h     |  3 ---
 kernel/cobalt/posix/syscall32.c |  7 -------
 kernel/cobalt/posix/syscall32.h |  4 ----
 4 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index bd393bb11..c4457b6c9 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -232,8 +232,9 @@ COBALT_SYSCALL(clock_settime, current,
 	return __cobalt_clock_settime(clock_id, &ts);
 }
 
-int __cobalt_clock_settime64(clockid_t clock_id,
-			const struct __kernel_timespec __user *u_ts)
+COBALT_SYSCALL(clock_settime64, current,
+	       (clockid_t clock_id,
+		const struct __kernel_timespec __user *u_ts))
 {
 	struct timespec64 ts64;
 
@@ -243,12 +244,6 @@ int __cobalt_clock_settime64(clockid_t clock_id,
 	return __cobalt_clock_settime(clock_id, &ts64);
 }
 
-COBALT_SYSCALL(clock_settime64, current,
-	       (clockid_t clock_id, const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_clock_settime64(clock_id, u_ts);
-}
-
 COBALT_SYSCALL(clock_adjtime, current,
 	       (clockid_t clock_id, struct __user_old_timex __user *u_tx))
 {
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 169d51e62..2607522e8 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -106,9 +106,6 @@ int __cobalt_clock_gettime(clockid_t clock_id,
 int __cobalt_clock_settime(clockid_t clock_id,
 			   const struct timespec64 *ts);
 
-int __cobalt_clock_settime64(clockid_t clock_id,
-			const struct __kernel_timespec __user *u_ts);
-
 int __cobalt_clock_adjtime(clockid_t clock_id,
 			   struct __kernel_timex *tx);
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 917a67625..30d7e1bcd 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -186,13 +186,6 @@ COBALT_SYSCALL32emu(clock_settime, current,
 	return __cobalt_clock_settime(clock_id, &ts);
 }
 
-COBALT_SYSCALL32emu(clock_settime64, current,
-		    (clockid_t clock_id,
-		     const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_clock_settime64(clock_id, u_ts);
-}
-
 COBALT_SYSCALL32emu(clock_adjtime, current,
 		    (clockid_t clock_id, struct old_timex32 __user *u_tx))
 {
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 7d448d0ef..c016c904c 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -67,10 +67,6 @@ COBALT_SYSCALL32emu_DECL(clock_settime,
 			 (clockid_t clock_id,
 			  const struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(clock_settime64,
-			 (clockid_t clock_id,
-			  const struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(clock_adjtime,
 			 (clockid_t clock_id,
 			  struct old_timex32 __user *u_tx));

-- 
2.39.2

