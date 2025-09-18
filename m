Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33634BA33
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202918; cv=none; b=BruOh+ebMV+ugEgKbgbhEuKO76YHtIayuxh/vxw6y0bAqMnkrpcpGib9I8XYthhyeofGBX4iXp7hiJEbmUQl+U6GFL6fDu1sT7ceuU7FbabOuhxwV/quwuwKPuXv7DZGRpGel3OqWZWwEav1Mrqu1pU0JDruLOGww0iL0Vtik2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202918; c=relaxed/simple;
	bh=K+RIl3npR8YCsoypkvFTJDIe6hd4JzLPf90bLBfE62U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ya0LFZc/uGCIypb/S59nj22p3v2Y1+QGPUSnJDKl44ax0UcOh9/o9JJclVd1v8uOSA7n9shb0AdTx50DmRa2bGI3V09BTuVCqsGCubUb49fEQXfcc208UkDKfykTjfoMPmmdioS+MPkVX7g76y5KeCCi7EssLzKR5C7lHTh+dpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=lVHzR8nc; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="lVHzR8nc"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250918134153545fb0ccd900020775
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 15:41:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CkIjIVlj3sBNBkWle4h8wNl9nhwplxRkmjPZ5Vbdb7I=;
 b=lVHzR8ncyc6VPXOljWunV8BqBvLI1AFSFs7gaW5pwXYJDFspFiTd8jePiNOJGE+SDTwQ27
 oKo+HvImgwkmDrGQzbbgoxGuMO0IGCJMhtreeoRBQ/U6aPP2nx9c9Tc2qJr4KgUBePL5xhCX
 fSSMeBI3kOz8q4Aj/m3GdTKCo3NQBumrxye/01/ZEHvRs96CNe39UGUzmnDaAGNimmA40VMk
 6gqtTSKAEiPvWy5KzsBMm33dNVxuepfmjZ4Wr1GaIk7QsCtLJwOWyS9FMrWCcaBzRrv03/yq
 0PD+4gNFDYX0dGxgSnS1uvaJ7D40UdwOVXmEBbV7WaZlSncfP4GCvohg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 18 Sep 2025 15:41:52 +0200
Subject: [PATCH Dovetail 6.16 v2 2/4] x86: irq_pipeline: Implement inband
 handler for hyper-v specific vectors
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v2-2-f1c802b1aba3@siemens.com>
References: <20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
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

