Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31952F619B
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210975; cv=none; b=Mos7yF97hXA/6RfIfT5fY2J2PB1X59coYksNF+1X/ZQbX7GnsiMpJU/RpoCnObcjX8Yv6WutGFpBSyJGsZZWHiNNpjscHvHXQMv0Th8EqQFF1XZNaPBc6x3p9kiHO7Um1auuWz4a+s/oZ1KvOFY+wJyiCYc6Jk3ukIRDSP8YxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210975; c=relaxed/simple;
	bh=QqShGTvIqrkkEy7J9+lBi1u/rNbZ2nc0Ntf0HtRY7Vs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZellUNn6+wlGO6X40+3rmui34Oid6nBD7pT3Jk8Cso2WVO2hctiKfpyy4f6oZQCUIvfh/QCbRy7WXQKs1HswY48za/XU59q7dMemuAVc0AaY/9gjNFWasjwVEES1a2nXEYagKiPJkq8uVNlr/mlB0nytuhBZpNt1ZRyh7kaOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Cci0Cfow; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Cci0Cfow"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250918155608fbfebcaab300020798
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=bL2k2xVMenB9r5atqiZISKdMoRpycg2OIrSOTPaYI0Q=;
 b=Cci0CfowguPx+MNd6CMmRFuPU9IpNhdV86GPYjqzBBjCqbuQ3i6KqJkARbHrVuRiKWTsph
 2NcN1dNfqTrad7cyRUWowuplAOeBFQEaWYiSsu1SXZCXRmFSB0fKRFUETpqralAk3w6Vm7LM
 5ybDIk7AWxZ1Xbr5v0nPoqzYv/U6LTzE5elY0E4a8RZ4gv4C4il2kZqQD31H3A8n8L9Sn54T
 O0HHB2qJuaAQT6dwD9oLcfKBjguJoj5WtvnXH14mUgjXiVGIXJK8pmPR0whuos6Wyloeaz3K
 rYLygcNVA/BBWiWYrPb8SbP3+az/j8RoWYXszsQnOacjZXcroJDI6dmg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 01/13] ci: Fix compat pipeline for 3.3.x
Date: Thu, 18 Sep 2025 17:55:43 +0200
Message-ID: <cb0218f8292beab5bf2260b19b0c59b97170462f.1758210955.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758210955.git.jan.kiszka@siemens.com>
References: <cover.1758210955.git.jan.kiszka@siemens.com>
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

We were accidentally still building the compat-next pipeline.

Fixes: a9baee76f5c9 ("ci: Add coverage for stable/v3.3.x branch")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/xenomai_3_3_x.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/xenomai_3_3_x.yml b/ci/xenomai_3_3_x.yml
index a8dfa29..dd5f823 100644
--- a/ci/xenomai_3_3_x.yml
+++ b/ci/xenomai_3_3_x.yml
@@ -15,7 +15,7 @@ include:
   - local: '/ci/kernel_5_15.yml'
   - local: '/ci/kernel_6_1.yml'
   - local: '/ci/kernel_6_12.yml'
-  - local: '/ci/xenomai_3_next_compat.yml'
+  - local: '/ci/xenomai_3_3_x_compat.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-3.3.x.yml:opt-debug.yml"
-- 
2.51.0

