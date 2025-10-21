Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF82441A6
	for <xenomai@lists.linux.dev>; Tue, 21 Oct 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049405; cv=none; b=jG9o+FHG99d8xfx8nES9Rb4oLw39+hwxhk0xrqhEGeMwNcWwND0XUfhG+KvEiVxDFxpUWK1ZyFfVkV41xR4TFOplofa2X7nIZFEmhr7N995LoJisfaJqbmCrlGRmMSoMBdH3dg0yc1s21h0hnBUjjZUM+ygb15agnZgYQG9iQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049405; c=relaxed/simple;
	bh=K+RIl3npR8YCsoypkvFTJDIe6hd4JzLPf90bLBfE62U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sGhq6uWNns6NGBngwiqiQi59Dhga4B5lm5qE5ipo0C+XtOAji4ltBmQdEwMPwsgaNvKnNCRNmFPRApYitnLRJEdzOJxuoEqDx7GcNdJ22DWecbZMfX41Vr01uJPwR4ezQDKUUVINdl5ChH2kA/9iuekJu2dszZc3pEy2G7Ooq2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=C/rgOUJT; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="C/rgOUJT"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025102112231241c256a0d4000207b5
        for <xenomai@lists.linux.dev>;
        Tue, 21 Oct 2025 14:23:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CkIjIVlj3sBNBkWle4h8wNl9nhwplxRkmjPZ5Vbdb7I=;
 b=C/rgOUJTLYE0fgD4ua0S4XVeBdlKcDDnlx1HU0j14oO0tl1ZdNgXCgN8jfC/n6bjJDzlKl
 TEf2kKf/ixdpru08DCcnWOR/dswi4dKkjOWgxpKKgPE5+D5tdzHMvVggve/4T2wYPcJw3ThZ
 z2X1li3lv2KevJ95cUPClokRtuhPABtVhMgvnmoaX0EJL4RIviWTrAG8d/R+Uvp7yjIzjYLh
 xVo5LXXJWaTVuRCozGDE54W5Hefsv19d9yjZ2bj0SiXLv/yb4aSM0yVpErAY7Ccbsgdcnlnl
 t9LX1YInW0OKSHWLqEcxwuhYTNktb7MUTQaruO5YJWyGBL445Few1OIA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 21 Oct 2025 14:23:12 +0200
Subject: [PATCH Dovetail 6.17 v3 2/4] x86: irq_pipeline: Implement inband
 handler for hyper-v specific vectors
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v3-2-f3b45eaed2e8@siemens.com>
References: <20250602-flo-add-hyperv-support-for-6-15-v3-0-f3b45eaed2e8@siemens.com>
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v3-0-f3b45eaed2e8@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Both vectors were already routed to the inband stage but were not
implemented / handled there. We ended up ignoring those IRQs. That
resulted in a boot hang on hyper-v.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/kernel/irq_pipeline.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 1d6dfc6e95122..d6162310929c6 100644
--- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -160,6 +160,15 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
 	case POSTED_INTR_NESTED_VECTOR:
 		run_sysvec_on_irqstack_cond(__sysvec_kvm_posted_intr_nested_ipi, regs);
 		break;
+#endif
+#if IS_ENABLED(CONFIG_HYPERV)
+	case HYPERV_REENLIGHTENMENT_VECTOR:
+		run_sysvec_on_irqstack_cond(__sysvec_hyperv_reenlightenment,
+					regs);
+		break;
+	case HYPERV_STIMER0_VECTOR:
+		run_sysvec_on_irqstack_cond(__sysvec_hyperv_stimer0, regs);
+		break;
 #endif
 	case HYPERVISOR_CALLBACK_VECTOR:
 		run_sysvec_on_irqstack_cond(pipeline_hv_callback, regs);

-- 
2.39.5

