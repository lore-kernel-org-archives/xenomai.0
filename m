Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE4A5387
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:31:11 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023050507210014711a3ee0a65a5b54
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uQcVGDGqcthl6U6IRrWgtyO+FwafspjTTTrmzUQ4lCs=;
 b=Xz1JTynjoGku8gOkSueJS/FVNaNHdsthvtwJAORIsyOPlmPKueN+a2SLymzJsx8UBiUiab
 MMFViBNh9lOEtLz3VrNf/GU0EM8W1kLXYRHowbFUJjNaAz4t/pZz7ypylUawe8wb1OjtEf0z
 68gIVuxd04BJvO7abOKBEZdRU1kA8=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:00 +0200
Subject: [PATCH 05/17] y2038: cobalt: posix/clock: Remove compat syscall
 for clock_getres64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-5-64a972ff2189@siemens.com>
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
index 7b1693612..9de90c728 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -93,8 +93,8 @@ COBALT_SYSCALL(clock_getres, current,
 	return 0;
 }
 
-int __cobalt_clock_getres64(clockid_t clock_id,
-			struct __kernel_timespec __user *u_ts)
+COBALT_SYSCALL(clock_getres64, current,
+	       (clockid_t clock_id, struct __kernel_timespec __user *u_ts))
 {
 	struct timespec64 ts;
 	int ret;
@@ -111,12 +111,6 @@ int __cobalt_clock_getres64(clockid_t clock_id,
 	return 0;
 }
 
-COBALT_SYSCALL(clock_getres64, current,
-	       (clockid_t clock_id, struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_clock_getres64(clock_id, u_ts);
-}
-
 int __cobalt_clock_gettime(clockid_t clock_id, struct timespec64 *ts)
 {
 	xnticks_t ns;
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index b5ab39b44..305400148 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -97,9 +97,6 @@ static inline int clock_flag(int flag, clockid_t clock_id)
 int __cobalt_clock_getres(clockid_t clock_id,
 			  struct timespec64 *ts);
 
-int __cobalt_clock_getres64(clockid_t clock_id,
-			struct __kernel_timespec __user *u_ts);
-
 int __cobalt_clock_gettime(clockid_t clock_id,
 			   struct timespec64 *ts);
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index a245e91af..2e7c2fc93 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -151,13 +151,6 @@ COBALT_SYSCALL32emu(clock_getres, current,
 	return u_ts ? sys32_put_timespec(u_ts, &ts) : 0;
 }
 
-COBALT_SYSCALL32emu(clock_getres64, current,
-		    (clockid_t clock_id,
-		     struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_clock_getres64(clock_id, u_ts);
-}
-
 COBALT_SYSCALL32emu(clock_gettime, current,
 		    (clockid_t clock_id,
 		     struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 0e06e12c1..2711fb2c8 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -55,10 +55,6 @@ COBALT_SYSCALL32emu_DECL(clock_getres,
 			 (clockid_t clock_id,
 			  struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(clock_getres64,
-			 (clockid_t clock_id,
-			  struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(clock_gettime,
 			 (clockid_t clock_id,
 			  struct old_timespec32 __user *u_ts));

-- 
2.39.2

