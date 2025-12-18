Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868452566E9
	for <xenomai@lists.linux.dev>; Thu, 18 Dec 2025 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088139; cv=none; b=Jt+wiXnuLNE40TXrNi/74T9Xs+Yvh+jdsGPVTeUrygu+7Uhcsndpu3b0qsVl3NTXYwt/CMUNzYG1F8TZYEacUsk/3jJ0mQQQMNKepjOxBpBBwdyCpVNB07CDE2ChdKfNvCxIBqt3s55CdVLjF7HSkUoL+vOx1fS7b2SpGEd92h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088139; c=relaxed/simple;
	bh=/s28Lkw86la8bjqeCsSZv806CQ8ZK7SpYVX2M8OAJFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oTlF7I7GuySdaPzE/8jcl510WC3V/32HTYwsiat9mVxJoyvM4nnqxidurzoAJISNG9jFtCTyZSIaZRKghegGBqKGCf7YcZwN38pc+ORrZzLTpeWMtBekM4y9T6uc9YYjemg2ggs003d9p5Nl0qD0J15wIVGVAfvdTIvsdV4SzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=H7SVdc8i; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="H7SVdc8i"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202512182002074f20b7008d00020757
        for <xenomai@lists.linux.dev>;
        Thu, 18 Dec 2025 21:02:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CbxdMftL7NQfiK6vzeLpntYOgfu2znyl1ZZBVfIY5Oo=;
 b=H7SVdc8iw0FvZ1hZQP7EQ5QzBRAkdGON4Ruf+PEDwBUOXhGBViFmc7sjNR1hdKA5g7NQKl
 AF8hSN71tYrTTYSk88PPrzCfZpRTgjapjlo34rtBnwnTNJmgn6iDbjBVQkgkvmVz1NlwPVmz
 L9zExbtPd6XZ8mYmJH05AQYKb1t+bm99XkMUWqmGKV4gKT8wjuFIF/Hw1tkLiGe137LwgCfC
 UovJ1Jbrf1fje15ac5uhUJtZNDpOzc+QxQvhM2tc8GrplEWILpWa1u2AfdFXHBOCtuKjK+Mi
 PI0R07ogRZGWteWWQgniPDN2e406iXDXjEk9GB10s7ESlqDVmISUYhGA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 18 Dec 2025 21:02:03 +0100
Subject: [PATCH v2 3/6] cobalt/posix/select: Optimize
 cobalt_timeval_to_timespec64()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-flo-fix-select-syscall-v2-3-f606e54e8d57@siemens.com>
References: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
In-Reply-To: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Andreas Ziegler <ziegler.andreas@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The signature of the cobalt_timeval_to_timespec64() helper
has been updated. That saves us one additional struct timespec64 on the
stack.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/syscall.h | 13 +++++--------
 kernel/cobalt/posix/io.c                            |  2 +-
 kernel/cobalt/posix/syscall32.c                     |  2 +-
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index facc60bcc..557ba17ba 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -139,15 +139,12 @@ static inline int cobalt_put_itimerspec32(struct old_itimerspec32 __user *dst,
 	return cobalt_copy_to_user(dst, &u_its, sizeof(*dst));
 }
 
-static inline struct timespec64
-cobalt_timeval_to_timespec64(const struct __kernel_old_timeval *src)
+static inline void
+cobalt_timeval_to_timespec64(struct timespec64 *ts,
+			     const struct __kernel_old_timeval *src)
 {
-	struct timespec64 ts;
-
-	ts.tv_sec = src->tv_sec + (src->tv_usec / USEC_PER_SEC);
-	ts.tv_nsec = (src->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
-
-	return ts;
+	ts->tv_sec = src->tv_sec + (src->tv_usec / USEC_PER_SEC);
+	ts->tv_nsec = (src->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
 }
 
 static inline struct __kernel_old_timeval
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 4e20ca19d..5b6799b9e 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -380,7 +380,7 @@ COBALT_SYSCALL(select, primary,
 		return -EFAULT;
 
 	if (u_tv) {
-		ts64 = cobalt_timeval_to_timespec64(&tv);
+		cobalt_timeval_to_timespec64(&ts64, &tv);
 		to = &ts64;
 	}
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 484f05984..7f05d2070 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -519,7 +519,7 @@ COBALT_SYSCALL32emu(select, primary,
 		return -EFAULT;
 
 	if (u_tv) {
-		ts64 = cobalt_timeval_to_timespec64(&tv);
+		cobalt_timeval_to_timespec64(&ts64, &tv);
 		to = &ts64;
 	}
 

-- 
2.39.5

