Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB521AB346
	for <xenomai@lists.linux.dev>; Thu, 20 Jun 2024 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880409; cv=none; b=hTq1w4zNMhMrxL2SQjVF9AYCI8DUU/o1w46C3+NVOZoeDPs9Z5p5OYNamz2QrnhtflPSGD6odD8EMCIbYMi91olFoODPw9zgHmXu29hv1aSYc/NJKqZgCe7ou/Z6qwcnMEcb8mYzS8au+5zGGgd4Emt2ExbTMxkasIKHd3r0xss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880409; c=relaxed/simple;
	bh=XikxlugtxOY4/mb+3pwPP8fLSZWgt4nFc5fK/3xiVbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=byb6aScaeNqFugCSshmoC+dc5NR8GF1GdFzZTso55AljIHlkMeDL8aZpqxxR9F8jm7r0Smb+npHg5Gqef1C3POAAIxTXPaiJYw+FiQ31wtj0PZ3aR0td22X920PFZvX2AOp5/eI2KmgMSl5hnIuSL/bX5n3jCEDT6kWdWuXORJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Pu53Vh+n; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Pu53Vh+n"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202406201036315f6d0d8e823076ca1e
        for <xenomai@lists.linux.dev>;
        Thu, 20 Jun 2024 12:36:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZkfPkCABINqfeO3+FF1m8bMRQKuXlqp/bGw1NCKQ87E=;
 b=Pu53Vh+nvaiPezebtOJgKxDMlkCWlzgmSkL5ip89hlPXigt96Wf9LP50cGSc7UkPAbzi8I
 xqrIl0IEukg8d8ii40P6CGjrdx0pdKZuKD6D5Ev5iA3cTMOkRp5URIlt3CqfokcDIoy8edNB
 fyq5lwhSGXklZJ51P+sLIA6Rnlisc=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 20 Jun 2024 12:36:26 +0200
Subject: [PATCH dovetail v4 2/2] KVM: x86: dovetail: Allow kvm_wait() to be
 called from any context
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-flo-fix-kvm-guest-for-6-9-v4-2-77471c9473d8@siemens.com>
References: <20240531-flo-fix-kvm-guest-for-6-9-v4-0-77471c9473d8@siemens.com>
In-Reply-To: <20240531-flo-fix-kvm-guest-for-6-9-v4-0-77471c9473d8@siemens.com>
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
    Using safe_halt().

  - Task context, hard IRQs on, in-band IRQs on:
    Same as Linux IRQ context.

The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
Linux to keep trace events.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/kernel/kvm.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 655b1cf8c9ab..90387564d06c 100644
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
+			safe_halt(); /* enables hard IRQs */
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

