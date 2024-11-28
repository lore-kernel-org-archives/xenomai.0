Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5951A29A
	for <xenomai@lists.linux.dev>; Thu, 28 Nov 2024 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801481; cv=none; b=csccDh/rjLihxoXaWeSVZR/9LbugZcLQ+h69l7uXSEkFpcqTOORq0SNmFCLM1hMXasUDCuqTfIS9NoQ2jw4UUurzoO/iOEsSFhnkBnSfyEPk9TVM1s2PRv7IT138rYWPAoJNJg28DSsSWxEVhm8nJ7odV5ic/xj636XXjHo2VmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801481; c=relaxed/simple;
	bh=PHMn6fkpsY25PAToj6DqkT031XRoqWoLzI3dTQLh5Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lIrnZqpfrMaYahZ5WdtkR63srtfJkbP6Ok46RtwqAKLHAVpH0jzId+Z0CuaN5idMLrlYmmOA1203lQmxG70dwXWiaPey6mcW3hOb3ZlKpKUFIF60LRuZDJBpzNnVAO16wmYEqpQagRRa0Wc1vKffA5CMsE62z5teU0Q7NiM4NTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TkwOXVd9; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TkwOXVd9"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241128130413ae09a19339a87a7b3d
        for <xenomai@lists.linux.dev>;
        Thu, 28 Nov 2024 14:04:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=V+BMAmbuEF3IkSfcy2lK/x9azA103P9VwIBkJsC5J1M=;
 b=TkwOXVd9OwL7auMuaAr8CrKxARpxQSeobQ/+vE6xpqY3YQ+URLJAlWLVqTJNBgIFtkHXoz
 vGao3WDmuv/gQn63m15a5z2lnQT3RJxlH3WyAnrwBkhOu4w+fzE/H/6KTD8UvoKGEZnYUQMl
 zKcOx9P5t/RM/8MX09LFlqgLL0d2p0I2GEpDpwO5NTmZZdhBUENp1hVPYi76ev7o6Bvr5Q0F
 QfdynKHZSQAuyW39mkY4B7t4cKwczStuFHY836h7p/BKbcAay3GGm70kfnq7TicKmk3xrnsS
 Cj2DC158JcprYqFYrjF9yXM9VGghYmJwcCYoyV79i77dY6ZdGFdDtN7A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.12, 6.6] x86: irq_pipeline: Raise oob IPIs only for the requested cpumask
Date: Thu, 28 Nov 2024 14:04:07 +0100
Message-Id: <20241128130408.3512152-1-florian.bezdeka@siemens.com>
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
index 6c4fb847b4d4..1eb0b67479a2 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -280,7 +280,7 @@ DEFINE_IDTENTRY_SYSVEC_PIPELINED(CALL_FUNCTION_SINGLE_VECTOR,
 void irq_send_oob_ipi(unsigned int ipi,
 		const struct cpumask *cpumask)
 {
-	apic_send_IPI_allbutself(apicm_irq_vector(ipi));
+	__apic_send_IPI_mask(cpumask, apicm_irq_vector(ipi));
 }
 EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
 
-- 
2.39.5

