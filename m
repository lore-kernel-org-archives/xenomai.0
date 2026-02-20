Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2631B136
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578540; cv=none; b=tX5h419Zi+xYxrZeLli856UwHrK/j//pZ3BWxjVxfX2f6ZTUz+0eH405C9lIi8QdQuIVIiHeQbridPXwOZQM41CoLEH2Ne7vlu7H9b20MSk5mCEphyl9pNc09R77QOlAPvM7UofS7KXB2L5c1+6/6H5EPg0EuyLw6NxSMtMbwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578540; c=relaxed/simple;
	bh=m2oGHjyhJgi4U5COm5/KWbodtMAk+OwoZ10E5cyYSLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uz7SuBK0GisZJ04YCy1y27JWMOqKxe2IaIL8PyDQioPJGwdqRgdj0Abz0/5+X2kVvDYNHMBCeBb0dEAJzfO1KWvaoDUdJ5IDcKfYPn6UKV/TVQDukVne25RBQ4D17sZuSCdI1eyWFqCOogZr1fe4B9VK6bKP+Fmf4c6BZb4fDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZZzhLK9m; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZZzhLK9m"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260220090848324f6dfdbc000207e8
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iVJRNjbQ+bvva277NvFn+UNhIn2erwfeO5oOrWVZjJw=;
 b=ZZzhLK9mtd8TE1qdVbjRs/HP+oktoODR4d4pm47sid9afqWT/Q1P7t8R9TL7YmHOdU7rq3
 P2LNjHxcJy9PMEOIoBF50QZaLtBtGaes0Z6OoId7JK+PPM8Ia/vkYx8YlQQZFu/hAirlLVzM
 GtKKkqt9NbktIhiBWDZ35GuAM1u6nIaygbKdkTfcMwH2JCGfmaRUQXpykxTinl0g2r8YCu7C
 QM0BxE4QArtJqzHdveX2QICxypEa2ROoGhIHL28gVBvwTAxKQLadR9B44qQ+tYk60gHm8AlQ
 C5a1GyDEqitNr6fo++010tIDU6Aw3Cw/bWawb1u9KBlRJmIw391OCO6w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:09:00 +0100
Subject: [PATCH 17/20] lib/cobalt: Move XN_USE_TIME64_SYSCALL to
 wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-17-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The usage of XN_USE_TIME64_SYSCALL is now limited to wrappers_time64.c.
Moving to clean up.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/internal.h        | 5 -----
 lib/cobalt/wrappers_time64.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
index 049ab3fc4d1047a1cf0ed3bd9a193938be85826a..0703c721758fdc778708cae70a0e9d53c6fb8eef 100644
--- a/lib/cobalt/internal.h
+++ b/lib/cobalt/internal.h
@@ -25,11 +25,6 @@
 #include <cobalt/sys/cobalt.h>
 #include "current.h"
 
-#if defined(__USE_TIME_BITS64) || __WORDSIZE == 64 ||                          \
-	(defined(__SYSCALL_WORDSIZE) && __SYSCALL_WORDSIZE == 64)
-#define XN_USE_TIME64_SYSCALL
-#endif
-
 extern void *cobalt_umm_private;
 
 extern void *cobalt_umm_shared;
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index bcb954c1f85b93f24ceb59999e57e4c935b2171f..d43812f88be0e5dc411e1df20cf02329eed60b57 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -22,6 +22,11 @@
 #include <sys/time.h>
 #include <time.h>
 
+#if defined(__USE_TIME_BITS64) || __WORDSIZE == 64 ||                          \
+	(defined(__SYSCALL_WORDSIZE) && __SYSCALL_WORDSIZE == 64)
+#define XN_USE_TIME64_SYSCALL
+#endif
+
 /**
  * Get the resolution of the specified clock.
  * @ingroup cobalt_api_time

-- 
2.53.0

