Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC191E2821
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599453; cv=none; b=iU+rr8iHMmwkYeHPTxdhqO/AgnY/fxs54KVTBOVRlRT1PoZsamGMiBPq0rhFj2waWfmLQZKCKEqyXuJy8joz+1JxP8JDokUbUiYhy/YdcffqiGeo2Km2d7JoPaGfymAiemOayV0VjlIW6DgPJiGco0QygTOG3NHZ85Gt1OqRfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599453; c=relaxed/simple;
	bh=fSBEWwJiPJ59hk9MPMgSAKFl+e/ISHNiu/ttNGGpClk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaCEseX/D7eCHqCZHYRbp/M6suDc2cM/U5Vle+GUOigWM4iLDNJS0Q9spvl/m8d7A8fgZ7nd5ZzT8yGvPrR4IvxNJe0DzQRJ/4kLuhvnb6kJ3NRuCf/SfRplaw2MKAc8550jEZjHS7B/LdfARKKMyjRN9eREZhI7PYeMZOZOQLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=J8qVfWCT; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="J8qVfWCT"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202410102230468ba848c318c9fe8e54
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 00:30:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/19ocL9XlFOZAJV/LDfhqAnOMMy10QmcSNSPnf/e3yQ=;
 b=J8qVfWCTvLTvbVhO/zIeOkYJfQQ5U8+7h9EgH1OzZIoIuuTkmyrUCne3gxutTFMjQJeC/F
 CTV8D+YG7OOgsWt5wLJ+Gv3w33b2EN0OfjW/ut0Re8dMITQW00vBUG9QERB7qI2SufQsF72w
 HuWjBuatHmgks/lWtwFc1bR6jehHl9MuJ6rFFwdf/ZeB7P7gVqh92DFdh7obAq6Udh2DJ6Sw
 Gt8KEZ2K+BDCaiCVEFpnEZ9kj0cMabWnORDwL5Ivv1JlYN+WYi9Tkkg3i5FlzLOdkPcNrGLo
 rhUWf7N0Fqfs54kr8CkTOq+5IWi++CEsz5PdjSXFM7BoyYk4/w/ZdG6g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Oct 2024 00:30:48 +0200
Subject: [PATCH v2 4/4] y2038: testsuite/clocktest: Fix link compile error
 observed on Debian 13
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241011-flo-cleanup-y2038-v2-4-0ef0d52cf9c1@siemens.com>
References: <20241011-flo-cleanup-y2038-v2-0-0ef0d52cf9c1@siemens.com>
In-Reply-To: <20241011-flo-cleanup-y2038-v2-0-0ef0d52cf9c1@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kisza <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The following build failure was detected on Debian sid/trixie:

clocktest.c: In function ‘read_reference_clock’:
clocktest.c:90:17: error: ‘SYS_clock_gettime64’ undeclared (first use in this function); did you mean ‘SYS_clock_gettime’?
   90 |         syscall(SYS_clock_gettime64, CLOCK_REALTIME, &ts);
      |                 ^~~~~~~~~~~~~~~~~~~
      |                 SYS_clock_gettime

The problem here is once again the changed behavior of the
__USE_TIME_BITS64 macro. Up to glibc 2.39 this was only set/defined when
building a compat application. So when time_t was "upgraded" from 4 to 8
bytes.

From glibc 2.40 onwards this macro will always be defined when time_t
is 8 bytes. So we basically run into the different code paths when
building 64 bit applications.

The reason for the compile error is that SYS_clock_gettime64() are only
provided by glibc when building compat applications.

Nice side effect: Should increase the support of libc implementations
where time_t is always 8 bytes, like musl.

The glibc commit that changed the behavior can be found at [1].

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a4ed0471d71739928a0d0fa3258b3ff3b158e9b9;hp=a0698a5e92ceeed3409d28623b1d599da6bc887d

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/clocktest/clocktest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/clocktest/clocktest.c b/testsuite/clocktest/clocktest.c
index a611ee889..a8158918c 100644
--- a/testsuite/clocktest/clocktest.c
+++ b/testsuite/clocktest/clocktest.c
@@ -86,7 +86,7 @@ static inline uint64_t read_reference_clock(void)
 	 * Make sure we do not pick the vsyscall variant. It won't
 	 * switch us into secondary mode and can easily deadlock.
 	 */
-#if __USE_TIME_BITS64
+#if __USE_TIME_BITS64 && defined(SYS_clock_gettime64)
 	syscall(SYS_clock_gettime64, CLOCK_REALTIME, &ts);
 #else
 	syscall(SYS_clock_gettime, CLOCK_REALTIME, &ts);

-- 
2.39.5

