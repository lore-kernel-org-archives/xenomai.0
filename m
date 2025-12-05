Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1730B50B
	for <xenomai@lists.linux.dev>; Fri,  5 Dec 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764926013; cv=none; b=c+6xUxg1uepGnRsPg6Ds3VrEyPtUNwN7LW7kgmqaYcg27vQLchztvNwKCqoRHIb8vOhAUO3B7G4sRplHpjr/acnjz2o3X67v+OLGMax5jjXPHanbJOpowJuBirXoVEXmw170l+rIeCrcq3No7LTT3Vqkwggx8pmSNKFft4yQ5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764926013; c=relaxed/simple;
	bh=QIPic52c8MYeoPvzfNgdlvj1hsJEYw0xKF3l4r8hDLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZKyJ7rXqomMipiin+SsI4IEBuEGQArbNZM8g7TijN298bUbS50S5BkVY5p2hpDWnhxh6jCiZ8PLrJss0rvCQ2XfytQDrrQkCqqsRycSAKZuQlawvVT9gpWePFrCE89oDHJJX9ud9OSPpmStDzcxa1suyrvXexCsZ/CIDWYYnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YB3V+slm; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YB3V+slm"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2025120509031362c8d3577f000207e8
        for <xenomai@lists.linux.dev>;
        Fri, 05 Dec 2025 10:03:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+Q7wRCnsmsPHHBOmQ0crvDkozaY8kkRSRsQInt9beIE=;
 b=YB3V+slmM2LnJRWkisEMe5UU1UJWWAvLrzeIXjiMNkPzcWdZnX2yzvEvkh1uMNzyOksajy
 gXvhJTroo6w8jY9VUnSijUCgp+Qj8r4dgLVs/osvI/oU7js31BjfH+2STvodfVIYwhDfWE61
 x2O2IEUQ+BqGzCOUN+/unl/YP5KBVqCjgBz5iGFgtVHWrvXFsdnJx7J7KrVpcyOmUsBxI3j5
 t65irvhcCr3Kl4JskwHkE+Chu6FHik751Jo6WYmnUHNhSyQKI9da9w0gMIVyihFIoSuS/dtu
 zuPToTO9SqxRMFubVLmYhieH46XQG3o+b0x6/N1wAlBO0Fh05mlXUlbA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 Dec 2025 10:03:14 +0100
Subject: [PATCH 4/6] cobalt/posix/select: Optimize
 cobalt_timespec64_to_timeval()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-flo-fix-select-syscall-v1-4-7f9c545a63ce@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
In-Reply-To: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Andreas Ziegler <ziegler.andreas@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The signature of the cobalt_timespec64_to_timeval() helper has been
updated. That saves us one additional struct __kernel_old_timeval
on the stack.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/syscall.h | 12 ++++--------
 kernel/cobalt/posix/io.c                            |  2 +-
 kernel/cobalt/posix/syscall32.c                     |  2 +-
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index 557ba17ba..943491be3 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -147,15 +147,11 @@ cobalt_timeval_to_timespec64(struct timespec64 *ts,
 	ts->tv_nsec = (src->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
 }
 
-static inline struct __kernel_old_timeval
-cobalt_timespec64_to_timeval(const struct timespec64 *src)
+static inline void cobalt_timespec64_to_timeval(struct __kernel_old_timeval *tv,
+						const struct timespec64 *src)
 {
-	struct __kernel_old_timeval tv;
-
-	tv.tv_sec = src->tv_sec + (src->tv_nsec / NSEC_PER_SEC);
-	tv.tv_usec = (src->tv_nsec % NSEC_PER_SEC) / NSEC_PER_USEC;
-
-	return tv;
+	tv->tv_sec = src->tv_sec + (src->tv_nsec / NSEC_PER_SEC);
+	tv->tv_usec = (src->tv_nsec % NSEC_PER_SEC) / NSEC_PER_USEC;
 }
 
 /* 32bit syscall emulation */
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 5b6799b9e..f85fac69e 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -387,7 +387,7 @@ COBALT_SYSCALL(select, primary,
 	ret = __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, false);
 
 	if (u_tv) {
-		tv = cobalt_timespec64_to_timeval(to);
+		cobalt_timespec64_to_timeval(&tv, to);
 		/*
 		 * Writing to u_tv might fail. We ignore a possible error here
 		 * to report back the number of changed fds (or the error).
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 7f05d2070..1731bc7fa 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -526,7 +526,7 @@ COBALT_SYSCALL32emu(select, primary,
 	ret = __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, true);
 
 	if (u_tv) {
-		tv = cobalt_timespec64_to_timeval(to);
+		cobalt_timespec64_to_timeval(&tv, to);
 		/* See CoBaLt_select() */
 		sys32_put_timeval(u_tv, &tv);
 	}

-- 
2.39.5

