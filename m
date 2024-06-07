Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17162D600
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717801515; cv=none; b=FHGopOLHRAMYcaEi6fYKQvspaIRJaOI3Yxmhpf0ER6QEDvmx9+GB0krzlmH61VjaZFrSmcKyc+CCs8SNlBPmrXpMlEooR4QWvJBjPFT4Ekm6TejcCv+z81ed8hl8m2+fp4lvaspRdtJnYIIQwzysMp+yZg600q8+MK1Z7mdCvWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717801515; c=relaxed/simple;
	bh=gpHMHX/kdV8hid93IBNmTKEzMZ9Ur9FSefaayFDA2lU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dmsqXrQzVOTNFMQJHzYIimIng85KGYX1UOrAQCLNWuUZ3wrFABQ96lsQVFmuNkqPIjD2JLLcE3ydGuAup+kIjvl8ElhMTfo2as7mAR2VXMEUxHwpyU4B2NpGOPE8uvjfGtLaFzosutkjOlusp9U0I0t52yy+uoD6cLae5Wh+Ijk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=rrgzQ9jC; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="rrgzQ9jC"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240607230502cbd6762fc191cafef1
        for <xenomai@lists.linux.dev>;
        Sat, 08 Jun 2024 01:05:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=34ikLTs7/a8GrznF1HA0FFhdNZ5sNark0rSm3HDVOF4=;
 b=rrgzQ9jCEBXDHAUKlTdnnHwwLo/LvSZ0kiwMDOfCMyFlMynDu7eqBa9F67oCT3oNmWuwwq
 zcOm9YoSHyYLYycxYehEqGNHiprZsDf+IrjUZx1bM72+xLP2Ziwh4q6pHcSc7VBy75rswGQA
 MvxGWg2obKpNQQYT81J5s2uQss7c0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Sat, 08 Jun 2024 01:04:54 +0200
Subject: [PATCH RFC dovetail 6.9 v2 2/2] KVM: x86: dovetail: Allow
 kvm_wait() to be called from any context
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-flo-fix-kvm-guest-for-6-9-v2-2-5534fcae4eb5@siemens.com>
References: <20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com>
In-Reply-To: <20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

kvm_wait() unconditionally enabled HW interrupts when called from
pipeline entry code. That broke the PV (paravirtualized) spinlock
implementation.

When running with CONFIG_IRQ_PIPELINE enabled we always call
safe_halt() to allow HW IRQs to be handled.

The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
Linux.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/kernel/kvm.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 655b1cf8c9ab..3180a26cdfe1 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -1059,22 +1059,69 @@ static void kvm_wait(u8 *ptr, u8 val)
 	 * for irq enabled case to avoid hang when lock info is overwritten
 	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
 	 */
+
+#ifdef CONFIG_IRQ_PIPELINE
+	unsigned long flags;
+
+	/*
+	 * We always use safe_halt() to be interruptable by HW IRQs.
+	 *
+	 * HW IRQs off:
+	 *
+	 * Wake up on next HW IRQ or by a vCPU kick triggered by the current
+	 * lock owner.
+	 */
+	if (hard_irqs_disabled()) {
+		if (READ_ONCE(*ptr) == val) {
+			safe_halt(); // enables HW IRQs
+			hard_local_irq_disable();
+		}
+		return;
+	}
+
+	/*
+	 * HW IRQs on:
+	 *
+	 * If inband IRQs are disabled the LOCKDEP state is already correct.
+	 * We can disable/enable HW IRQs without further bookkeeping.
+	 * = Linux IRQ context
+	 *
+	 * If inband IRQs are enabled we have to inform tracing / LOCKDEP
+	 * infrastructure about the HW IRQ disable/enable event.
+	 * = Task context
+	 */
 	if (irqs_disabled()) {
-		hard_local_irq_disable();
+		flags = hard_local_irq_save();
 
 		if (READ_ONCE(*ptr) == val)
-			halt();
+			safe_halt(); // enables HW IRQs
 
-		hard_local_irq_enable();
+		hard_local_irq_restore(flags);
 	} else {
-		local_irq_disable_full();
+		local_irq_save_full(flags);
+
+		if (READ_ONCE(*ptr) == val) {
+			safe_halt(); // enables HW IRQs
+			hard_local_irq_disable(); // fix HW state for LOCKDEP
+		}
+
+		local_irq_restore_full(flags);
+	}
+
+#else /* !CONFIG_IRQ_PIPELINE */
+	if (irqs_disabled()) {
+		if (READ_ONCE(*ptr) == val)
+			halt();
+	} else {
+		local_irq_disable();
 
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

