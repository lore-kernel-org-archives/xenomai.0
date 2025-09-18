Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556F30BBAC
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202691; cv=none; b=W6DbPOxAruVU3O9D1tzcQSl71vKuZlcRlh/xFaAaVg5tN7qwgIa7kgR3tEQlvZ0gicdhGQra7mQriGNS5MB/9SVC8rNrfVtHJJKV09ZQDkx3OUOccC2H0DYGeSCXti1Yu8nlcGA5Y2uI1o7wLLfRYbB8qK4UsNyt7Yeea5GOqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202691; c=relaxed/simple;
	bh=K+RIl3npR8YCsoypkvFTJDIe6hd4JzLPf90bLBfE62U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnwmsWIYjG/LohluHVsldM4FOAv5oTu2jAieerqAsBaybB+zUZGUlI+zJb0rMKAQhSKpLwPibHqCrWIrQ4KTeRqPEn8eAaktji9mOrc/jvvrnxF+n/5/UY0GNgNC5J6sGqxHKGv8BY4+YRd77eE3PQzuOqm2IQUpnPBCBLAd7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=tli1AQCq; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="tli1AQCq"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202509181338005f7410700100020712
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 15:38:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CkIjIVlj3sBNBkWle4h8wNl9nhwplxRkmjPZ5Vbdb7I=;
 b=tli1AQCqnBEB8P8Z54cNMoAcPAdIEzp24ZvY/RVsKs/EtCdGIRCBwmGFwiCvwfYG20w4h8
 YdUZt/1aTqjxnCPqzqMM23k3Yw5NlOoY8CmrqkyjSAI7TQXEMdbNr5xvuSIPGDBac/nw2TjA
 ZAnSOW595VhM3RYdtat8avYJaXW1kFea2wuRMLq97N82JUO7Fdr0xaVTOG4ebv0GAQnBJCe9
 R5N5vIg7d1S1Ttx0SYCnYIk3CcutJZ9NUhpfvxIKjjj91WpOwFBfU1StfyIKnDCqETxF2dqd
 SQdXs3mQUwj4jzlTRamiyPWCAdzBMUPU3d2HMQv3D8RtBHcIj5f2rY4w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 18 Sep 2025 15:37:58 +0200
Subject: [PATCH 2/4] x86: irq_pipeline: Implement inband handler for
 hyper-v specific vectors
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v1-2-449e6c20debd@siemens.com>
References: <20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com>
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
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

