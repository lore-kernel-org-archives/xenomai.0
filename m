Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275B539B
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:31:11 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202305050721019a4d7b4bf2ad5ea35c
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8UrrAXPL2eFgW/nWwPECrYxx7jjSWLyYgMXjSXed+oE=;
 b=dSS2igZ+Xckz30v1A50GEvpRW9vPiN+M8n5XxLc6Om5dBhYohUivXpmUFwpNAPYBabZgqa
 Gy0YyRHBgEQzS+29WZSc0hGiQ8Sf47X4FZ9bxeHEnqGE2dcRz/dcPcarEQFv47wqHmfZz3GS
 yqorGyiLl9dH6xhOqXUz3RrQohNXU=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:01 +0200
Subject: [PATCH 06/17] y2038: cobalt: posix/clock: Remove compat syscall
 for clock_adjtime64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-6-64a972ff2189@siemens.com>
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
index 9de90c728..266ccef52 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -254,8 +254,8 @@ COBALT_SYSCALL(clock_adjtime, current,
 	return cobalt_copy_to_user(u_tx, &tx, sizeof(tx));
 }
 
-int __cobalt_clock_adjtime64(clockid_t clock_id,
-			struct __kernel_timex __user *u_tx)
+COBALT_SYSCALL(clock_adjtime64, current,
+	       (clockid_t clock_id, struct __kernel_timex __user *u_tx))
 {
 	struct __kernel_timex tx;
 	int ret;
@@ -270,12 +270,6 @@ int __cobalt_clock_adjtime64(clockid_t clock_id,
 	return cobalt_copy_to_user(u_tx, &tx, sizeof(tx));
 }
 
-COBALT_SYSCALL(clock_adjtime64, current,
-	       (clockid_t clock_id, struct __kernel_timex __user *u_tx))
-{
-	return __cobalt_clock_adjtime64(clock_id, u_tx);
-}
-
 int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     const struct timespec64 *rqt,
 			     struct timespec64 *rmt)
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 305400148..dbaabbc5d 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -106,9 +106,6 @@ int __cobalt_clock_settime(clockid_t clock_id,
 int __cobalt_clock_adjtime(clockid_t clock_id,
 			   struct __kernel_timex *tx);
 
-int __cobalt_clock_adjtime64(clockid_t clock_id,
-			struct __kernel_timex __user *u_tx);
-
 int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     const struct timespec64 *rqt,
 			     struct timespec64 *rmt);
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 2e7c2fc93..245ddb2f0 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -196,13 +196,6 @@ COBALT_SYSCALL32emu(clock_adjtime, current,
 	return sys32_put_timex(u_tx, &tx);
 }
 
-COBALT_SYSCALL32emu(clock_adjtime64, current,
-		    (clockid_t clock_id, struct __kernel_timex __user *u_tx))
-{
-	return __cobalt_clock_adjtime64(clock_id, u_tx);
-}
-
-
 COBALT_SYSCALL32emu(clock_nanosleep, primary,
 		    (clockid_t clock_id, int flags,
 		     const struct old_timespec32 __user *u_rqt,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 2711fb2c8..b7baee94d 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -67,10 +67,6 @@ COBALT_SYSCALL32emu_DECL(clock_adjtime,
 			 (clockid_t clock_id,
 			  struct old_timex32 __user *u_tx));
 
-COBALT_SYSCALL32emu_DECL(clock_adjtime64,
-			 (clockid_t clock_id,
-			  struct __kernel_timex __user *u_tx));
-
 COBALT_SYSCALL32emu_DECL(clock_nanosleep,
 			 (clockid_t clock_id, int flags,
 			  const struct old_timespec32 __user *u_rqt,

-- 
2.39.2

