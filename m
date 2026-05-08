Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DA33A544A
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234333; cv=none; b=DznHIOZ1MMp9phHI6FH5FP6t8+2/HNqCWZmIBMH4X1XHUvZe3ISrcql8snUishCPpeJhDfyg7El37r+y6lm124FXRWZeXbtKERKinkLO1OH44IvQ5yly9RDXxYl1Y4lw+aWaDyVIPq3KBmuIQR4shdfJGCIMsHIg8SeEB2PAI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234333; c=relaxed/simple;
	bh=ReOUeA4giWvrpSVRh2aWEyEl8nMPvKFYY2xQV4wWQmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BB7ZRVf4xDYPAOIWNxcNFSV9QWQ/GAlhaVH+fUBLiN1vsU65yse5vTlHijQohvJAp5CZPUOmBMSCY/LigkdqeE627Y3GqhT1MuTFKwgQC67kS87ixklfnqARwf93aRNGny/wHNxbyqjPZd6wIqAo6sIq3v+TidkhK4i/GyP/Wy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=JZeyFeQP; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="JZeyFeQP"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202605080958462f1804507e00020766
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 11:58:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LE3it82knAF0K6YEU6ha4xDc0JCtfavovHFSHDol878=;
 b=JZeyFeQPZADOrirOReN1ux7vKOhIXb5g3+KjisQoRzmFF4NGes05yFEeRz//3InCLpLxJd
 Kp9pal/kbiBjT+sqWqVdS+/zdhOLKW5ItBy0oE5JCn9eoHMyuJUaZcgNkv+jMNX9M/WGtdSE
 vh2aIxjIRDgwO0TWb31bHfmshJEIYBIb4GipHzE1LniV/shNG3mfe6bwhm2sUbesWL0qgAm+
 ALh8ttAgpCHo4M6qX8PvYemxzZl6oAv8w6Hrg1eHLjuYWjmWnOkVUMLBBaQK2mhmRltWPO/1
 J8yqMj51dN/zir8mkjNlmvLwwkiJu2/SSr9m/70U5pGjAMCHY1GEDCYA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 1/3] testsuite/smokey/alchemytests: Fix garbage args in case no --vm option is passed
Date: Fri,  8 May 2026 11:58:42 +0200
Message-ID: <bc8fb708e3c7b78b78a7b598d615893e1e8c8ab2.1778234324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1778234324.git.jan.kiszka@siemens.com>
References: <cover.1778234324.git.jan.kiszka@siemens.com>
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

We are no longer skipping over "--vm" here, args is only "--vm" by now.

Fixes: 61fc9ff4b721 ("alchemytests: Set cpu-affinity by env var")
Reported-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/alchemytests/alchemytests.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index edbafe6e71..b596a1e175 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -52,8 +52,7 @@ static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 
 	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
-					 smokey_on_vm ? args : args + 5,
-					 &test_ret);
+					 smokey_on_vm ? args : NULL, &test_ret);
 		if (test_ret)
 			ret = test_ret; /* Return the last failed test result */
 		if (tmp)
-- 
2.47.3

