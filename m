Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17012F12DB
	for <xenomai@lists.linux.dev>; Fri,  5 Dec 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925410; cv=none; b=JeJd4yhdPw8d0GBgu/4yvINalczqDCv8zMtdBMK/frDskaBWgnQMAFugkAo7Zz9wBgvyWU+mKZBGkrTHwZFC0Ms9BXZKqdmc2r/wBfpYbNrn+bgJrLfNyhwJRFWW+qlO/zyAUDnXT52Ug0anXOQsotmcKDjoENOEYU82GqGsrjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925410; c=relaxed/simple;
	bh=/s28Lkw86la8bjqeCsSZv806CQ8ZK7SpYVX2M8OAJFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crIydKayE08wQpLKw5kQExTdErQvzi0maMXL0ZlmHQxjTmaRttVD31pbVjPgs9FrcyH+35ZHl/bm5xJ6cNxl7lOCj7g+6OCSYFB0+2KVMVM43AoXRXNOmS3lrpG5iX93hPmK6SHN3nqzM8TJxg1sLfFBJk82oQGAlKRDHPfm/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PbQKuaAD; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PbQKuaAD"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202512050903134ae8e06f4900020772
        for <xenomai@lists.linux.dev>;
        Fri, 05 Dec 2025 10:03:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CbxdMftL7NQfiK6vzeLpntYOgfu2znyl1ZZBVfIY5Oo=;
 b=PbQKuaADSTvzTqvJbcOiKitrhzqxOmQOG8nZqGcwdP03SJV6PAdUAyyqRHOeDTEaAt4xYR
 5Ocn3wz5lszt5tEH2IjH/B0UI5lN7KbOg6Qv9nQd5v7ogRzqMs74mlSuWNNDBeB8uzoqpSIL
 B4no7SgZmCw6NinEYlvVQj3eWD8g4PbyWaGoli6SUDHfEsLBrWS9QiT+xEnOLeJ6F513Ycjg
 QMEbkpzlJvEWoUe8yrAVJSMb+AAhfWUPMGQ4bw6vLqBXyxf9X3cmtdoV51N8gd2tOwCboV3X
 VuWDoZ8UvXW/bJ2cd/4utWUQzcXJJhB8FvrqRxuecFOPuT/VyqDKKzcA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 Dec 2025 10:03:13 +0100
Subject: [PATCH 3/6] cobalt/posix/select: Optimize
 cobalt_timeval_to_timespec64()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-flo-fix-select-syscall-v1-3-7f9c545a63ce@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
In-Reply-To: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
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

