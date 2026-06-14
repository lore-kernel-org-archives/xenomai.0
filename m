Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E219134AB01
	for <xenomai@lists.linux.dev>; Sun, 14 Jun 2026 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781428668; cv=none; b=qTVJ2Fa3yZAHZtaPckgDFJaX7zC2nNfcTsYSexUR0R2SyJSoRzsgYNdk3d7BUz0DAzNnqEUp1zbL07/6jJGiRmAjMBflUru5/i02FyziegCrnqWHYWmHNMUXCX/A1WkGv9ejhK2YuedJtOCR3B9TOFmkSZhUbxHRYzXMEoFkM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781428668; c=relaxed/simple;
	bh=GpviTYOtDneMiyx1zKXTK0iFHuFYNErT238rk2BbwuE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJC4x3fxK1sgdnFTtnVWSC9zGrXKz1UkgdEMkVV64EmC7RyDdtq5qeC3n1CSGC2IX0Zo2li85/17+Tlfzoyb1xFe138Cf5GlGNhMYfWI9xjxUdfp9zYJqZZNzB2i36GXCGREwJcWW5fi2thmrAVIzgwrWld+y2y4jrT25RKrFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Zdk8MUun; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Zdk8MUun"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260614091736391ff0850e0002072a
        for <xenomai@lists.linux.dev>;
        Sun, 14 Jun 2026 11:17:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=SD0zdS5yMKKibP70CUzHJEVb7nCUNOoA6CLPu865Aio=;
 b=Zdk8MUunydtLnMGeY9dciwd9ed0+t0jFz7S12BWicQKG2p0R+91doqF2khV7hPjISDKd8q
 ONorMayBb+SyCge6mrlZ+4qsmS1uZdarB1FbhFQZ5xEkATR+GtY6V/y5K1mYARgzKaIXNdKN
 xkOA7aewto4oCdZ3uNCIBmMajxWtMAqy1KfcpCR2R5rI4kjUFDxYBWULFCTPt4ReXncyq1kG
 /rYdXUvgzEJVHZ67zFPriyD8fXFduOAQGFEdB9CYzgl+OXwxkZnDu+Wu+LLJu8zmr1UeG19F
 n++H8YNbvprM+CEKwpz9rsTLb/8DSWKnbukaEHFtzGWEXwuQKnGEJ9ug==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 6/6] linux-xenomai: Switch riscv branch to latest integration
Date: Sun, 14 Jun 2026 11:17:34 +0200
Message-ID: <535ce20bf0e8ba49e08dad84f8b65e5bf2916702.1781428654.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1781428654.git.jan.kiszka@siemens.com>
References: <cover.1781428654.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

wip/evl-riscv became stale, use Florian's 7.1 preview branch until
everything is officially merged.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-4_latest.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index a542e80..48499ca 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -34,7 +34,7 @@ GIT_BRANCH = "${@ \
     'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
     else 'v6.18.y-evl-rebase' if is_kernel(d, '6.18') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
-GIT_BRANCH:riscv64 = "wip/evl-riscv"
+GIT_BRANCH:riscv64 = "wip/flo/v7.1-evl-rebase+riscv"
 
 SRC_URI += "git://gitlab.com/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
-- 
2.47.3

