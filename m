Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB651487D8
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306211; cv=none; b=nHz0pM/ukInGdxbJm/yARMmah3I/VCs+4lMkzJpWRsFg39QodCUdSft2OactkxgF1Brdjl7SUWz+7pkrNdv4kOvceMzqPmV7puL5JhE1mK6PalbnDmKtNx/TFDjeuXrNWVIwzyUwTyyc0Huj5C00uN2h9K/5gEMQpR9HvX54xDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306211; c=relaxed/simple;
	bh=lZpzQuVLlKFWtK5k4RkQP5xJ1Gg8sw+XC4BkGVcyk3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q3tdjdO/aGrHvAe+MsPOa8Y9E5NBgRI6YWpR7uu0vIdaP/cQzNoXOXICH7irCOFwwTarz/yqFlUihRIJKCBqXOW1adzUMOVvb/UOe99vopg2WdifVKN6vf3Iy/lX5UD4hX4GzRxjZ3C2oH+TYSBzaJctTF333Q0lf3r79Uyec+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hco2ZJA3; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hco2ZJA3"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240625090319c97e2f1dee9f3c8455
        for <xenomai@lists.linux.dev>;
        Tue, 25 Jun 2024 11:03:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ThwnRX6RQRKoA4H7V1MLVxN/onLVVV8sFUKdLZT+tX8=;
 b=hco2ZJA3mLTR+8If6DS53GKC7vJmE2zQwCEkkrhGFV1GxFA2t5yQV/g646nYFNFQpHrHny
 XTKnYvMudENzGMlKcJ+SWe9fPaHtTUf+KYUEkZYeV813yjBMvcMArrPdg7ipf709UJW/EWJM
 jaVv9ySekWZeF8AvTzZ+NIEIBDwIE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 25 Jun 2024 11:03:16 +0200
Subject: [PATCH dovetail v5 2/2] KVM: x86: dovetail: Allow kvm_wait() to be
 called from any context
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-flo-fix-kvm-guest-for-6-9-v5-2-1efec77fe0a0@siemens.com>
References: <20240531-flo-fix-kvm-guest-for-6-9-v5-0-1efec77fe0a0@siemens.com>
In-Reply-To: <20240531-flo-fix-kvm-guest-for-6-9-v5-0-1efec77fe0a0@siemens.com>
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

  - Linux IRQ context, hard IRQs on, in-band IRQs off:
    Wakeup on the next hard IRQ, or by a vCPU kick.
    Using native_safe_halt() to statisfy lockdep.

  - Task context, hard IRQs on, in-band IRQs on:
    Same as Linux IRQ context.

The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
Linux to keep trace events.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/kernel/kvm.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 655b1cf8c9ab..655056316d27 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -1059,22 +1059,36 @@ static void kvm_wait(u8 *ptr, u8 val)
 	 * for irq enabled case to avoid hang when lock info is overwritten
 	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
 	 */
-	if (irqs_disabled()) {
-		hard_local_irq_disable();
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+	if (hard_irqs_disabled()) {
 		if (READ_ONCE(*ptr) == val)
 			halt();
+	} else {
+		hard_local_irq_disable();
+
+		if (READ_ONCE(*ptr) == val)
+			native_safe_halt(); /* enables hard IRQs */
+		else
+			hard_local_irq_enable();
+	}
 
-		hard_local_irq_enable();
+#else /* !CONFIG_IRQ_PIPELINE */
+
+	if (irqs_disabled()) {
+		if (READ_ONCE(*ptr) == val)
+			halt();
 	} else {
-		local_irq_disable_full();
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

