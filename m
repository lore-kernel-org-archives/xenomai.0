Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC74266A4
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676564; cv=none; b=FfEl4pH283ZL6jjQbNyvYRFLGj9ou6uLUMUZOsdDW+hm0M3dwmHp80t4j+EgWXFEedtg/9uTUtNf+LUnUA7YpwdP2NTaUWwXR1wgQUX9EMJ4SG36tRAyyVQ/nj/94ieu/CrQPy1c1aRaU76nqas+hd+MvrL6R+c6JDI94caHnk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676564; c=relaxed/simple;
	bh=Gfz1IafP6cxOGUCBgdu3vp5jWJINVEB/jEXoxGte2O8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VMALLglEibo5Aob4Ra1rPh4suNQeg6m+kPa1nDe0d6uGBvxYCAN6sEINxMCvtzFLHsMmE9BNVmIaTtDXDiKebNnZNrwpJVbF44KQeulpRrJhEJpF+D49lCV17xVILQtcXwiqZXBIiu4aInpaD27FJxCxHKgucE/f5uepUKQQoN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YT/WZwlB; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YT/WZwlB"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202605131249158051fad9190002071a
        for <xenomai@lists.linux.dev>;
        Wed, 13 May 2026 14:49:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=2J2zeCVGzY5yP0dVfLBPG8YpCllr8x3SrINu69PZHQk=;
 b=YT/WZwlBQDByczTVff+vWFkxo/9BanNHx01KBd9hfwqK3mjL4AwKeh8E9OZnfbkAFW63cT
 SiyioPU1yFytCB2OZ+oaLs0CI/2R528LYeRlvEgh85AhU00xksJDjRgOfWRlvJeJVukdZ+lG
 v59+w0jgWjnK5JzpbeNzarH3wc5zR4Lz5ScgoWXHLThOheFUogoF40sP4zTSQhtLNWhJdB7x
 P8NEgW/C8RabZ8hLUcyytDehFYtreN0dpxyzMjYrkI7T3ZK5hAzn8L1F8QArosN8tjrKiC94
 46ShL5sebbhFmq88mdPBNz5pFPeER1OBXB3XgVTeSd49QfwckQA7Ngiw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 13 May 2026 14:49:14 +0200
Subject: [PATCH] testsuite/xeno-test: Fix clocktest invocation
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-flo-drive-by-fixes-v1-1-473a263268db@siemens.com>
X-B4-Tracking: v=1; b=H4sIAElzBGoC/x3LTQqAIBBA4avErBvQwLKuEi3UxhoIC4V+CO+et
 Px4vBcSRaYEQ/VCpJMT76FA1hW41YSFkOdiaETTCiU0Xnyg33acI5+E9kHPNyV0SjptqTedlVD
 mI9IfyjtOOX/wHDVPaAAAAA==
X-Change-ID: 20260508-wip-flo-drive-by-fixes-c51c8be9a7b1
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The -D cmdline switch and CLOCK_HOST_REALTIME support has been removed
in commit
e3a3a3025b14 ("testsuite/clocktest: Drop obsolete CLOCK_HOST_REALTIME
               and wallclock offset bits")

so that an invocation with -D resulted in the help message.
Taken from one of our LAVA test logs:

 + /usr/lib/xenomai/testsuite/clocktest -D -T 30 -C CLOCK_HOST_REALTIME
 usage: clocktest [options]
   [-C <clock_id|clock_name>]   # tested clock, defaults to CLOCK_REALTIME
   [-E]                         # -C specifies extension clock
   [-T <test_duration_seconds>] # default=0, so ^C to end
 + /usr/lib/xenomai/testsuite/clocktest -T 30

Removing the first and unnecessary call to clocktest to clean up tests.

Fixes: e3a3a3025b14 ("testsuite/clocktest: Drop obsolete                       CLOCK_HOST_REALTIME and wallclock offset bits")
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Hi all,

During reviews and some code reading some minor regressions in the
testsuite came to light.

Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/xeno-test/xeno-test.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/xeno-test/xeno-test.in b/testsuite/xeno-test/xeno-test.in
index 590eac1e0378309e5a8cfeafac3654bef86fd231..de2749c84592d218889a95cd7bc615aa3f0cae2f 100644
--- a/testsuite/xeno-test/xeno-test.in
+++ b/testsuite/xeno-test/xeno-test.in
@@ -108,7 +108,7 @@ fi
 
 start_timesyncd
 
-$testdir/clocktest -D -T 30 -C CLOCK_HOST_REALTIME || $testdir/clocktest -T 30
+$testdir/clocktest -T 30
 $testdir/switchtest -T 30
 
 start_load

---
base-commit: 54e9c509863439614484b0bf939c32bfadb15423
change-id: 20260508-wip-flo-drive-by-fixes-c51c8be9a7b1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

