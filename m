Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5C30DD05
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520016; cv=none; b=qS+pWD7VL5Wd4E0W7KVrnSbnUs/Ip/MEX0PKojHHi9Uvwj7fd4BcYLY4Suuf487UwlhxmUC5IWYZfZxdeMVEpszgEglrAgEC7SgaeP1bfGiZPFwWXEG1EyaarV8JC2+nHMpfFYsSbuNxrZYcrJ9kJD2JS7WSe4Bq9i8AYGtlhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520016; c=relaxed/simple;
	bh=xZ5lyr/+iWGPI6g1U3QmBMG+1GkN8dIVroQjRgSzxxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSTQjALpK3GXU9Zi1QrRHUVo76Iiq97BdsS3XHheZxw3zKCuLyil2SyQ0Rkfo/6pHarvGmi2zu33y6oWk9b4epcRmru7TIY4p8zHcUDfIW92Ot5MVHtXnCeWOe1pT2usV4j7eMvoNDxlWZUvFrog1sd2Uqdtc3xfMU03A0LI6zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HNimR1iK; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HNimR1iK"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250818122646bed44ed894175ebbe6
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pTYOm3RJSSSCD2sNMYawI3DkP32lHnn9nbQuuHe+yuw=;
 b=HNimR1iKLUFf7KKYgytEnRuCjO1pTNhUA4E1+cDqtPmcBBzlqMYsyZwthnZJP8MEEW/dCw
 hjNKXERMhPjrD6eKc7eArT3tu+QA993wmReOr0d1j2GIH0FzlNlEFuiE5GCeiiWVCEh2uyVX
 jHgqPkV/cKiHjLMJ15CQizAwH0f2yNHJZJRmgWR8ujS77XJrrHDFBpSq/WbZUEhaEaefsfV4
 RqjciSc1LamMl8foHPCZ7DR8aNWCuAJXZvkKdOAeG37s/ll0qzxja2DG5IAM7C85RYkneCdu
 IYb/YWLqBhZJkzuJMhikbIIdXK5a6IlgaMGQD0oP9KDZ/b4pepcmEXFQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:48 +0200
Subject: [PATCH 06/13] drivers/stack/rtmac: Add missing
 MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-6-c57f195e3f93@siemens.com>
References: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
In-Reply-To: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is a build warning triggered when MODULE_DESCRIPTION() is
missing. Seen on builds with Dovetail 6.16, but likely older versions
are also already triggering the warning.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/rtmac/nomac/nomac_module.c | 1 +
 kernel/drivers/net/stack/rtmac/rtmac_module.c       | 1 +
 kernel/drivers/net/stack/rtmac/tdma/tdma_module.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_module.c b/kernel/drivers/net/stack/rtmac/nomac/nomac_module.c
index 3bd2b0d69..ef5d902c5 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/nomac_module.c
+++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_module.c
@@ -161,3 +161,4 @@ module_exit(nomac_release);
 
 MODULE_AUTHOR("Jan Kiszka");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("rtmac - NoMAC");
diff --git a/kernel/drivers/net/stack/rtmac/rtmac_module.c b/kernel/drivers/net/stack/rtmac/rtmac_module.c
index d4174dd32..6da87f707 100644
--- a/kernel/drivers/net/stack/rtmac/rtmac_module.c
+++ b/kernel/drivers/net/stack/rtmac/rtmac_module.c
@@ -80,3 +80,4 @@ module_exit(rtmac_release);
 
 MODULE_AUTHOR("Marc Kleine-Budde, Jan Kiszka");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("rtmac - real-time networking media access control subsystem");
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
index 77ad1200b..7b752af97 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
@@ -316,3 +316,4 @@ module_exit(tdma_release);
 
 MODULE_AUTHOR("Jan Kiszka");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("rtmac - TDMA");

-- 
2.39.5

