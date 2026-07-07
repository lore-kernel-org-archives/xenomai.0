Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058B3DA5D9
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417831; cv=none; b=I3isn+25qWMV7TO4Va7mJ7ZTSd2l+LgxFxdSF57aTqSMbGnZpckogMr5UNjUQao1twE4tf2pK0kBEOv1JACKRtKD1BNxCrt42OP2GZrL3srJUd3IBtNmRjF40llTBFtGF7Va+Vh02fUKpsZjTdAdtMu1SvqS7CxpOK6TFrqk81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417831; c=relaxed/simple;
	bh=nkJxuNghzAffmLYItxfVfoz2QozzaSA2yKgghY4S6Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfJ6CHiIuSUH7QvhNUB+mAldTlOMaMFJE7CohcXq6ZI0rzrjA2YoPDrgmqW8C8uRMUR5sqhVZVYXWUquZZag9f/rJm3dSEzNkODtb+RWxZBqLCywZOllWXX3r/Xzp2/bX0MJ08K5w2lh1jpbqHKvNx1RuY8qufj9fYnbjWo1s+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=sYO7X8gX; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="sYO7X8gX"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026070709502132465ef6c50002072f
        for <xenomai@lists.linux.dev>;
        Tue, 07 Jul 2026 11:50:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=f8vjJ650n25SLiq8cSSox/tY4EYW7Hsn6hmG6WbXu4I=;
 b=sYO7X8gXp2aOgCRocSN0GOCp4+H7aDJ4gr5tWDwhGNww18cqNsPVhbcc+bF6CjpQfNgkIM
 GgaHy70jbiPAjGVRN07GfyaHp4PWYsQ3sv0F9H8nkKQVA8+PzjmW/RY2wuSqxjgyL746+JY2
 IpPo0zZ6A5Awen4BFBmR0o7prqz74IU4UMACEASUz1Mn9QqEEanQ6U5xlPvjuExzYexPebak
 D4O7PHaud3IEFSKxnTYSgnJ8r8fcETeuDS3td+ZMgh8LPPkzMaGnwczV87ghfq4Dh6klqSD2
 MoSiWuI3w3tM/8KQagD+5n02UqHBZ859qFfe2+St2x7VwKaurjlOO80g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 07 Jul 2026 11:50:23 +0200
Subject: [PATCH Dovetail v4 7/8] arm64: irq_pipeline: Add arch specific
 arch_kentry_ implementation
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-7-057b8af5a2ca@siemens.com>
References: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
In-Reply-To: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The generic implementation is not used, but we need to add a dummy
implementation to avoid a build failure.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/include/asm/irq_pipeline.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/irq_pipeline.h b/arch/arm64/include/asm/irq_pipeline.h
index 09cb33b826cb63701678f40b61b65df885923db2..7c86ebbf27b669d0d202edc5ba4fb55ad7c23f96 100644
--- a/arch/arm64/include/asm/irq_pipeline.h
+++ b/arch/arm64/include/asm/irq_pipeline.h
@@ -102,10 +102,11 @@ static inline void arch_handle_irq_pipelined(struct pt_regs *regs)
  * the latter for now, until we enventually switch to using whichever
  * of them is available first.
  */
-#define arch_kentry_get_irqstate(__regs)	0
-
-#define arch_kentry_set_irqstate(__regs, __irqstate)	\
-	do { (void)__irqstate; } while (0)
+#define arch_kentry_test_stalled(__regs)	0
+#define arch_kentry_test_hardirq(__regs)	0
+#define arch_kentry_clear_irq_state(__regs)
+#define arch_kentry_set_stalled(__regs)
+#define arch_kentry_set_hardirq(__regs)
 
 #else  /* !CONFIG_IRQ_PIPELINE */
 

-- 
2.55.0

