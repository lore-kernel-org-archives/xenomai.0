Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52D37AA9C
	for <xenomai@lists.linux.dev>; Tue, 29 Sep 2026 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715321; cv=none; b=kLpa5MVbMal4s2Hv3JWQ6aocorcTaXwxNvDm841y/rcAMrycS3OAzVQZVSwg1i06JzjhBBfSSgicNhTrqf8W+m3j64KKaVjJ8PurgXJSfxlS1YzNugTcghUTvTV7QXa1xQ53TRE3h+uwjn6ByTexBuh+0kWVX9PSEksBqdrHTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715321; c=relaxed/simple;
	bh=Y4eIefJLU6feEmIsIa9EQDSyR0A74JyQGJxFws10ME8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rEwyswvqay3qe9pF+QZ8sOwXCGsBLUGr5Ib7Ae5Zlq5QQn+ec1perYh1kiPFZ6Zys6byXRJGZ2ing64NGapm+ZuXkvt2V78zMWTRCuppTsMkQIVRh4ho4zwSgDqQaLOI35KATGD3cS/ywYXrkjL3XSEWj6w8x8bTPfUf046rV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=cQN1B3On; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cQN1B3On"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260929205509bc6e7a056e000207e5
        for <xenomai@lists.linux.dev>;
        Tue, 29 Sep 2026 22:55:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ixNV6Lsk1UEpF5m+xvWeIx11kop3C1affll+d7wgNZk=;
 b=cQN1B3OnFubeOQSAQSI/q/B9zVPMGQtD0F5DDOf9hKoP9U5u0XQ1frurJeJd3S6HiUMlCB
 S1U8f/mimqYPO2HZbfoZb7Lp5t8LizXBRkeMnavsjEKR3U2B0VN7VsPi3wCGVF67O6RAlznP
 dUAgLUdlfaQ+b/weKiKW7WuBKmeH4y5BIAfVhw72jwkij/B1YVzUHr7v1hG6EkMkauTgHfg4
 VhB/ivg3i3tpYAztvA12F6fzTtRpHwuMhqmVzlgwy8vuYTbg64VdUQJCZV3xAxwq9NIF++9H
 Ld9Q0Tgrre1m+OH5Nv/e9Btl/uLsfH56lb3zQ3ptzs8gilza4GnSf2Dg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 29 Sep 2026 22:55:09 +0200
Subject: [PATCH Dovetail] arm: irq_pipeline: Fix IRQ state checking in
 do_page_fault()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-wip-flo-7-2-arm-pipeline-fix-v1-1-300c70cfae7f@siemens.com>
X-B4-Tracking: v=1; b=H4sIAKwlvGoC/x3MQQqDMBBG4avIrDuQjqDEdW9Rukh1Un9Ik5AUW
 xDvbujye4u3U9UCrTR1OxXdUJFiw/XS0by6+FLG0kxiZDBWLH+R2YfEIwu78uaMrAFR2ePHtrd
 +HvrR+KdQW+SiLf/3d7qlTT8OgR7HcQKFnPkTeAAAAA==
X-Change-ID: 20260929-wip-flo-7-2-arm-pipeline-fix-939fc6370fb2
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

When correcting some fault handlers in the patch series referenced below
one call site was missed. That is corrected now.

do_page_fault() migrates to the inband stage and enabled the inband IRQs
depending on the hardware state. Instead, we have to check if the inband
stage was stalled on kernel entry.

Link: https://lore.kernel.org/xenomai/20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-6-62c9c477f8f2@siemens.com/
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Found while scanning the code for necessary 7.3-rc adjustments.

To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 8f7feb1a228fc12c2d14389f865b13e23d11460d..91d0afe7985d55b424009cc29d8f3343cfca90fd 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -376,7 +376,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	irqflags = dovetail_fault_entry(ARM_TRAP_ACCESS, regs);
 
 	/* Enable interrupts if they were enabled in the parent context. */
-	if (interrupts_enabled(regs))
+	if (!arch_kentry_test_stalled(regs))
 		local_irq_enable();
 
 	/*

---
base-commit: 58e8e0f74c2b20f6228b7d327ec2e955ffd5b491
change-id: 20260929-wip-flo-7-2-arm-pipeline-fix-939fc6370fb2

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

