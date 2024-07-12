Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216F14F9ED
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781340; cv=none; b=r+clpwhkVwecvOpLHNTq1e8u4F+KrQTFmX7mvZ/gZBUti6lyxZ3ha9H62pSPG18Gjb9bRPSVAAMg5aVVogX1a5yFJKIsBLPseAXkqn87wZB/ztln9YKBrJ2BvvBUB+cQiZHKhQYFuXMaLqjWVGq6tGaqbeyznINvUrEqwdh41EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781340; c=relaxed/simple;
	bh=HtAtxsiMvLLPTbI/mk85S6ts9GVGiqSX1yUKeXDxU84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwDvLO0BW6n762cESUdnK9oHzGkxMWBYkwjdwuv7ywnOKh58Xa7Ds0D8w1E0ppjXP2YEYRI1P7i3qd+jyIfjbV+ZGiQgrGZNQa8EdS1bAFxa5N+lGbA4SqGFlwcxM+8QOFdCNzrc2JwYJ+ne0j1GB86g3Flwdg6kta8+svkVv0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Q+CgRQJF; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Q+CgRQJF"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202407121048494eb2d1f0092e2cf1fd
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cjrrTa3b6icZtMEhoGXibqDqEqfs81F31kM7MInO6Ng=;
 b=Q+CgRQJFn3ExI1Ee40506IPwDfphyC3Byz8LqhkG+u/ltYJiZmVo+7rBCzptxAwHDxBwC1
 +SWZG4VoXlgj6yec1wPtRRFK6d/A+LafM+0tBLyqoI4zwH9nBhxGIQ4biNfvGlfIMinK59PF
 AVxMUYNp/OSKvW9ykJMNw0A0KNWXU=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:48:48 +0200
Subject: [PATCH v2 02/33] cobalt/x86: Add missing log level to printk()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-2-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The Xenomai prefix was used, but the log level information was missing.
Addressed by using XENO_INFO.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/arch/x86/c1e.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/x86/c1e.c b/kernel/cobalt/arch/x86/c1e.c
index 492ed1dae..65ff7bc64 100644
--- a/kernel/cobalt/arch/x86/c1e.c
+++ b/kernel/cobalt/arch/x86/c1e.c
@@ -22,6 +22,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/msr.h>
 #include <asm/xenomai/c1e.h>
+#include <cobalt/kernel/assert.h>
 
 #define ICPU(model) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, 1UL }
@@ -63,7 +64,8 @@ void mach_x86_c1e_disable(void)
 
 	id = x86_match_cpu(c1e_ids);
 	if (id) {
-		printk("[Xenomai] disabling automatic C1E state promotion on Intel processor\n");
+		printk(XENO_INFO
+		       "disabling automatic C1E state promotion on Intel processor\n");
 		/*
 		 * cpu uses C1E, disable this feature (copied from
 		 * intel_idle driver)

-- 
2.39.2

