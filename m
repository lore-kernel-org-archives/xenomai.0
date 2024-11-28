Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3C19EEB4
	for <xenomai@lists.linux.dev>; Thu, 28 Nov 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799679; cv=none; b=PGM5lfqGK3ZgUbBtu43QdzpyJbA78LScl9PK28zzCmcwV60vReNKz/V43NyulkKzJubL1UFA85zN0k/RoxCMNJv1Ryq7pQFpRSRQHg6GWOQ4ILXMegSDCZVgpAsOS5b/6HXGfcgi47A7vEwBC4Nl+swZJ5+ssQsoHMbkOdkZM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799679; c=relaxed/simple;
	bh=xOITRJrbl6O3rdqMBjsQDHn5AZDSU7UBVl/e4bvi+Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxz7l+Lg6a+8ITYt0vRSgAOTks6Rs0jwCPVKvxOGpFsIIE1/2b5APQ5KgsrooJXk6PttysV4e2A5CA0X7K1dt+1JBAb27n3La8f0JOScnNW9VGpqeNwTD8sC9GSMjWwH2S3xUo3Xd78VXGH4oCrQ0sEEKgtuTpUcKFfJcFc2koA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=nBCH0zEP; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="nBCH0zEP"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241128130416edc08dd3c80f947984
        for <xenomai@lists.linux.dev>;
        Thu, 28 Nov 2024 14:04:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=F9ZZga1pIOOAELsdFU9U0wj2eiQVKdsNuSYovAhFcdQ=;
 b=nBCH0zEPJ8PdNMWSTYRQNwMxOny1ETF/olBKVxhV6X9WSJ9tUX6u+VuVL6gOapAM/ZGuDR
 wCQwgRdRyukzjR/jef2fk2MG35IZ5ahaU88JY2aYNhicQbEFQq/oFMGMuYDcelnJiCOZTJwZ
 /tAKiu2+zj59nmi6t3VFo+1SSMo6a2YU/Vkbo2MT+AiLuj3b/QMjyHqGh4Y/3TKUqhL9cGr7
 fX0uT0c0wY3yNVpIj12WBkGOaL3wMt3seVmdHUevcldD1CWAIlOATEjf0688ElhcB0DbZBBc
 EVZ8hvRiBu2fjtEcs6eH+jeS2rBbHoHlz7sfymtkN8JcslT228VP3pAQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.1, 5.15, 5.10] x86: irq_pipeline: Raise oob IPIs only for the requested cpumask
Date: Thu, 28 Nov 2024 14:04:08 +0100
Message-Id: <20241128130408.3512152-2-florian.bezdeka@siemens.com>
In-Reply-To: <20241128130408.3512152-1-florian.bezdeka@siemens.com>
References: <20241128130408.3512152-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

irq_send_oob_ipi() silently migrates from the supplied cpumask to
allbutself, which is a overkill - especially for the OOB resched
vector.

Seen in a real world trace - cpumask=6 requested but each CPU got one:

       SCTSeqRun-17771 [000]  5888.449485: ipi_send_cpumask:     cpumask=6 callsite=run_oob_call+0x91 callback=0x0
       SCTSeqRun-17771 [000]  5888.449487: write_msr:            830, value c00ea
   OMP-TT-P19511-22125 [021]  5888.449489: irq_pipeline_entry:   irq=524545
 PARC92.rawobjpr-19511 [019]  5888.449489: irq_pipeline_entry:   irq=524545
       SCTSeqRun-17771 [000]  5888.449489: cobalt_head_sysexit:  result=0
              ps-23075 [018]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22138 [004]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22129 [024]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22131 [013]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22147 [011]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22128 [010]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22137 [003]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22144 [001]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22145 [005]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22140 [015]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22136 [014]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22134 [007]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22121 [012]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22127 [009]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22130 [025]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22149 [008]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22148 [002]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22122 [028]  5888.449489: irq_pipeline_entry:   irq=524545
   OMP-TT-P19511-22126 [027]  5888.449489: irq_pipeline_entry:   irq=524545
   ...

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index d8d7e37d03a8..5903a7c99c20 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -276,7 +276,7 @@ DEFINE_IDTENTRY_SYSVEC_PIPELINED(CALL_FUNCTION_SINGLE_VECTOR,
 void irq_send_oob_ipi(unsigned int ipi,
 		const struct cpumask *cpumask)
 {
-	apic_send_IPI_allbutself(apicm_irq_vector(ipi));
+	apic->send_IPI_mask(cpumask, apicm_irq_vector(ipi));
 }
 EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
 
-- 
2.39.5

