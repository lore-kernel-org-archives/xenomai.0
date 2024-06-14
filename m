Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA6195B2A
	for <xenomai@lists.linux.dev>; Fri, 14 Jun 2024 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365998; cv=none; b=uNJu2NP5n0uXEVDJk/qIUj3PgONRG14ejls0ubXaTQvi6+aJWsrkm3EbEvosn44QvFDCMSWTxAC1j9kHm5u74l7OY9hqC+11RsetU5qDLapXuF7AXMoorvRySv0sHwyIeHaWnGM4orwsdosczkgtke0Vr4dzlXOpWVpIj47xvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365998; c=relaxed/simple;
	bh=kc07ACyl64pRPY1untesXTq0W7yGJ2+IMUXH4gRrYpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cu+6vftcGByHKZx/3OnfAR7xRChlJpaJKcjh89nSMdishoxziy8zZ3S6f+NtkN+Cuhvn0ZNwXJQ+HYsLjOfm3HrHmi/TWwn1kWS4jahU/ZgN2/iTpLUD9IVMHUUUyjFraOcOGbIoYRDIi8UIVu4Dfc0mHn1PT6jg4a29d0s73lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=GAj5mbRg; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="GAj5mbRg"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202406141153060eea387f23a291fd4d
        for <xenomai@lists.linux.dev>;
        Fri, 14 Jun 2024 13:53:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kKCQeePvvu5qsW9fCeov9KZ1+k5S7sbidiBHKiA8Uvs=;
 b=GAj5mbRg2fG2MJ5TA7zTp5JDd8nxmm6Gn5cLahOYkjh3ZPuPsGzy8DAaghsSqFSRFEB9eM
 s0qkBvfQCV7WQcTj8mPWSOylmXi64Yy1IsRApI4X/CCv1YIXIFLQLSDwOw/BFOiVN4LrUJAR
 UOSjKMRMWEtaLOTeN65izPB6dE6+o=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 14 Jun 2024 13:53:06 +0200
Subject: [PATCH dovetail v3 2/2] KVM: x86: dovetail: Allow kvm_wait() to be
 called from any context
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-flo-fix-kvm-guest-for-6-9-v3-2-ebcf517500a3@siemens.com>
References: <20240531-flo-fix-kvm-guest-for-6-9-v3-0-ebcf517500a3@siemens.com>
In-Reply-To: <20240531-flo-fix-kvm-guest-for-6-9-v3-0-ebcf517500a3@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

kvm_wait() unconditionally enabled HW interrupts when called from
pipeline entry code. That broke the PV (paravirtualized) spinlock
implementation.

The following calling contexts are supported now:
  - pipeline entry, hard IRQs off:
    Wakeup on vCPU kicks only, triggered by the current lock owner via
    hypercall. Using halt().

  - Linux IRQ context, hard IRQs on, inband IRQs off:
    Wakeup on the next hard IRQ, or by a vCPU kick.
    Using safe_halt().

  - Task context, hard IRQs on, inband IRQs on:
    Same as Linux IRQ context. We stall the inband stage before calling
    safe_halt().

The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
Linux.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/kernel/kvm.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 655b1cf8c9ab..76bd881e1137 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -1059,22 +1059,59 @@ static void kvm_wait(u8 *ptr, u8 val)
 	 * for irq enabled case to avoid hang when lock info is overwritten
 	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
 	 */
-	if (irqs_disabled()) {
-		hard_local_irq_disable();
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+	/*
+	 * Hard IRQs off:
+	 * Only wake up on a vCPU kick triggered by the current lock owner.
+	 */
+	if (hard_irqs_disabled()) {
 		if (READ_ONCE(*ptr) == val)
 			halt();
+		return;
+	}
 
-		hard_local_irq_enable();
+	/*
+	 * Hard IRQs on:
+	 *
+	 * We always use safe_halt() to be interruptable by hard IRQs.
+	 *
+	 * Inband IRQs disabled: Linux IRQ context
+	 * Inband IRQs enabled: Task context
+	 */
+	if (irqs_disabled()) {
+		hard_local_irq_disable();
+
+		if (READ_ONCE(*ptr) == val)
+			safe_halt(); /* enables hard IRQs */
+		else
+			hard_local_irq_enable();
 	} else {
 		local_irq_disable_full();
 
+		if (READ_ONCE(*ptr) == val) {
+			safe_halt(); /* enables hard irqs */
+			local_irq_enable();
+		} else {
+			local_irq_enable_full();
+		}
+	}
+
+#else /* !CONFIG_IRQ_PIPELINE */
+	if (irqs_disabled()) {
+		if (READ_ONCE(*ptr) == val)
+			halt();
+	} else {
+		local_irq_disable();
+
 		/* safe_halt() will enable IRQ */
 		if (READ_ONCE(*ptr) == val)
 			safe_halt();
-
-		local_irq_enable_full();
+		else
+			local_irq_enable();
 	}
+#endif
 }
 
 /*

-- 
2.39.2

