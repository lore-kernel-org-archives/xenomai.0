Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262614D990C
	for <xenomai@lists.linux.dev>; Tue,  8 Sep 2026 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865711; cv=none; b=tzahDYMAdf0QQpnTDhDDux17Rr28IrkCMEpTQ2WwqxwtLEOwq1nPTGsYBTZ67er+UH+ceN4E5ys/kQbv1Ta/YA/5f06ZJdBF1Vj7YNOztYtTq4kdmI2iMo3UYfk5TgCUQhR+S3NE7Nk7cCOJPHv0Cvj+6TuqK8BEsPVGZCb7QLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865711; c=relaxed/simple;
	bh=jeBouHuh7pOU4MYE5PX+yO1zDHHyIHyzrZC58yLQh+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNVKkVrN8f/7EoFLGmQ3t2ynSw4IICChUCtxx0H899KOWuVU6xBjVxWyTdNX3l4lIrvXNJh6uwkAOdcjJ16ZZU3AaladezAP29hh6JrVX9tuUa8vb3T1l7+g5XJYeoY5L7uJBflYSvXMSQcHjJn43vqw9xKBTRONOJ/qCtWh+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=CQt1nOix; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="CQt1nOix"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260908110822d5f7b6014f00020788
        for <xenomai@lists.linux.dev>;
        Tue, 08 Sep 2026 13:08:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EnRNLvvry2UDjmBjzbpdj1OVrdz7tssL2OVEAiLTzU4=;
 b=CQt1nOixhy3L0+rMk5dbhmcxf2zOQJTblrqklgqUkHSUJLjZU1PVCJ+BAJsE1OAayNjePj
 zUXrz+qNJk2Oll/3U9/dv49W+cXsnwXNPGQdCBhBtsc65rgcF7zjpLgTt7lv+332wU9+JAUf
 gmZlE5wbBRlIer7u3ZAFillee6Se8pVIlndu+9xhSLg6xY864qV02DEAq9iwbjPp1ow4SLcf
 ltNWdIAaFwxV2C2GdQ6CefH+f1vzEPqohVcGoJyKczi9aQkqZ+AnPrjvS3hdRAxLJj08NvO8
 0oY8nQ33T4VzstgjJ5BQ8z17vEjf2j5gisUhblE00wH9TUfe7wF/Wasw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 08 Sep 2026 13:08:22 +0200
Subject: [PATCH 2/2] cobalt/x86: Replace {wr,rd}msrl() with {wr,rd}msrq()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-wip-flo-prepare-for-7-2-v1-2-eaf975a56944@siemens.com>
References: <20260908-wip-flo-prepare-for-7-2-v1-0-eaf975a56944@siemens.com>
In-Reply-To: <20260908-wip-flo-prepare-for-7-2-v1-0-eaf975a56944@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

wrmsrl() and rdmsrl() have been "redirected" to {wr,rd}msrq() for
some time and got removed in 7.2. We switch to {wr,rd}msrq() and
provide a wrapper for older kernels.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/arch/x86/c1e.c                         | 5 +++--
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/arch/x86/c1e.c b/kernel/cobalt/arch/x86/c1e.c
index 65ff7bc64f1ef2778ff681bb9c9c8b9038781369..34ecabea8ed040d878a1192b74dedfafece1bc01 100644
--- a/kernel/cobalt/arch/x86/c1e.c
+++ b/kernel/cobalt/arch/x86/c1e.c
@@ -22,6 +22,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/msr.h>
 #include <asm/xenomai/c1e.h>
+#include <asm-generic/xenomai/wrappers.h>
 #include <cobalt/kernel/assert.h>
 
 #define ICPU(model) \
@@ -53,9 +54,9 @@ static void c1e_promotion_disable(void *dummy)
 {
 	unsigned long long msr_bits;
 
-	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
+	rdmsrq(MSR_IA32_POWER_CTL, msr_bits);
 	msr_bits &= ~0x2;
-	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
+	wrmsrq(MSR_IA32_POWER_CTL, msr_bits);
 }
 
 void mach_x86_c1e_disable(void)
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 838e01327f5fd158ddd9383d000724f527465153..0f47507e7b9797e1461237f90299e415a4289c62 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -73,6 +73,8 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(6,16,0)
 #define timer_container_of	from_timer
+#define rdmsrq(msr, val)	rdmsrl(msr, val)
+#define wrmsrq(msr, val)	wrmsrl(msr, val)
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)

-- 
2.55.0

