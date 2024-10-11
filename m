Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5AA2185B1
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653877; cv=none; b=sEXyqvjut6x7ij6UFpU3bUc3doh8F//njPB306jupVc9pcY876tiD+2b42pLf+jm9DOsrNtUxt6rt7TEyYYG3JehIePuVEENO4YtY1kuFZShjfi1PcdlQyjqIo1i6cggtcTt746UgbPlFTcvWQekbIFEB2YtCwXJ/FI6DdXYfuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653877; c=relaxed/simple;
	bh=MN4UCH4c/bjbBobJNGQfhfptc1tyyZqMz7db5Ooggtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULjzCf89n6p/T6IW8C0Frkm106bXZi0zLR+qP5PLRSRRiG45hp5WXBTgha+z1A8DjQl0SclsIerjcPdTO13x/kQMyvwrZ49YZ6Lq3bWDGjkJZ+QbVBWAWs2P2KfjqI2irZz7/y9cy6ENHGPJTbw1uYt8rpBmBU7K5dr5d+rf29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=M0an1iaX; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="M0an1iaX"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20241011133751f70078cf3749b0bb2a
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 15:37:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lla19PsMixOhkr3IvFoYZnpEp/krSoKiyqx4rNEtdcU=;
 b=M0an1iaXMitAH1tbAdW2KIUhwFkxQ5SYpodLa/HgTdPaZntKCcr/otN6mLwPZOdoVE+wD1
 2tD2dF1hVZ7CbEClms5Ndn3HzjDqc3ITpFKjDvaIEnlkG5F+yDlzUCfTrIJrXZZ7szYIpAF0
 94u2H574ku/HTVCMSP5CDNWsVKs5rmSAmOxtmD1mCqfelz5CCl0/GXRDrNQYt1S6VOgpKHlj
 tKbjC91XZk8OSydhTYWr2wg5HX04lPzy7fsH0si8nlvMYsjGuKuW8yFWjZE/yrwXmiq7cYiI
 y6zZq/AHbbS1roD0oDaYON1AvMCfXMms6r7gJSun/4hezQD+hVIcU8Aw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Oct 2024 15:37:52 +0200
Subject: [PATCH v4 4/4] y2038: testsuite/clocktest: Fix link compile error
 observed on Debian 13
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241011-flo-cleanup-y2038-v4-4-788b3a4bf3cc@siemens.com>
References: <20241011-flo-cleanup-y2038-v4-0-788b3a4bf3cc@siemens.com>
In-Reply-To: <20241011-flo-cleanup-y2038-v4-0-788b3a4bf3cc@siemens.com>
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
index a611ee889..4d87ee700 100644
--- a/testsuite/clocktest/clocktest.c
+++ b/testsuite/clocktest/clocktest.c
@@ -86,7 +86,7 @@ static inline uint64_t read_reference_clock(void)
 	 * Make sure we do not pick the vsyscall variant. It won't
 	 * switch us into secondary mode and can easily deadlock.
 	 */
-#if __USE_TIME_BITS64
+#if __USE_TIME_BITS64 && __TIMESIZE == 32
 	syscall(SYS_clock_gettime64, CLOCK_REALTIME, &ts);
 #else
 	syscall(SYS_clock_gettime, CLOCK_REALTIME, &ts);

-- 
2.39.5

