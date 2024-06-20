Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909EC2594
	for <xenomai@lists.linux.dev>; Thu, 20 Jun 2024 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879806; cv=none; b=njL39W6B0p2OWAGnMYKWdwDVGdmoso4h7dGjj03Q3UKJw4ctOu/eIsrsTBrbAUG/SAmoanSYWsEwwHsOo6RiBDH2Yxc0v0VaW34Dxvtfb1rVNPXaZnODT22MZfsFjw6bmNbLg9V6JvfhnUuY/qeMGw1LaOIHBgYpsmqDPW4+Wt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879806; c=relaxed/simple;
	bh=MlXqrA3j27baup2eMRYzCGZYqrdFACoAREVazhsltAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EWoYbY6/KxDvlsDpJ63/auTfNYTxl2b1hCSQr+YwWnVvNo1tgmEm/mGByBPT37KKFNOSbj8pg7JBa86KJ78jQ/GA2bzHxZhmwrKImZw+AccM9UBgkF+mfqa1e+In0hfXuYXm53/ut45KxdQbF5NwZe/S19QGOEDc++5oB7Dj9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=h6sqKSK2; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="h6sqKSK2"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024062010362945a87249d24b4b675c
        for <xenomai@lists.linux.dev>;
        Thu, 20 Jun 2024 12:36:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PXYJwVNgn68VcbCuNjNjRo5wDePT/CcycuSgtrnhm+4=;
 b=h6sqKSK25fbfTW+FTg5YVHFEAa89pvVriGQCK1QxxCSbSfTNsJz5LhQXIR8N3pDBPtzZ9U
 PElNftOkpbkMd3l67RahrQkAU9nIFIg5pUlJk0SNgoHU12StRRwyAvhCXY6wWs+q7cKSyNpt
 suD9QfVVLdTA7LT8Y5yhTmrNGVRQY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 20 Jun 2024 12:36:25 +0200
Subject: [PATCH dovetail v4 1/2] KVM: x86: dovetail: Move handling async
 page faults to the inband stage
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-flo-fix-kvm-guest-for-6-9-v4-1-77471c9473d8@siemens.com>
References: <20240531-flo-fix-kvm-guest-for-6-9-v4-0-77471c9473d8@siemens.com>
In-Reply-To: <20240531-flo-fix-kvm-guest-for-6-9-v4-0-77471c9473d8@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Dovetail was stuck in the boot phase as KVM guest on a system that
reported the asynchronous page fault handling feature.

The apic_eoi() call in sysvec_kvm_asyncpf_interrupt() has no effect in
case CONFIG_IRQPIPELINE is enabled, thus those IRQs / vectors where
never ACKed at APIC level, the CPUs stalled.

Instead of migrating to __apic_oie() the IDT entry for
HYPERVISOR_CALLBACK_VECTOR for KVM on x86 is now marked as PIPELINED.
Other architectures (and other guest extensions) already used
DECLARE_IDTENTRY_SYSVEC_PIPELINED().

The imbalance of how HYPERVISOR_CALLBACK_VECTOR is being used /
pipelined goes back to 5.10. Backporting might be required.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/include/asm/idtentry.h | 2 +-
 arch/x86/kernel/irq_pipeline.c  | 6 ++++++
 arch/x86/kernel/kvm.c           | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 500f4e8c6542..e544b24f61bf 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -829,7 +829,7 @@ DECLARE_IDTENTRY_SYSVEC_PIPELINED(HYPERVISOR_CALLBACK_VECTOR,	sysvec_xen_hvm_cal
 #endif
 
 #ifdef CONFIG_KVM_GUEST
-DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_kvm_asyncpf_interrupt);
+DECLARE_IDTENTRY_SYSVEC_PIPELINED(HYPERVISOR_CALLBACK_VECTOR,	sysvec_kvm_asyncpf_interrupt);
 #endif
 
 #undef X86_TRAP_OTHER
diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 15b6cbdb8f13..73e97fba55e7 100644
--- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -155,6 +155,12 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
 		run_sysvec_on_irqstack_cond(__sysvec_acrn_hv_callback,
 					regs);
 		break;
+#endif
+#ifdef CONFIG_KVM_GUEST
+	case HYPERVISOR_CALLBACK_VECTOR:
+		run_sysvec_on_irqstack_cond(__sysvec_kvm_asyncpf_interrupt,
+					    regs);
+		break;
 #endif
 	case LOCAL_TIMER_VECTOR:
 		run_sysvec_on_irqstack_cond(__sysvec_apic_timer_interrupt,
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index c65e88f94f32..655b1cf8c9ab 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -292,7 +292,8 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 	return true;
 }
 
-DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_asyncpf_interrupt)
+DEFINE_IDTENTRY_SYSVEC_PIPELINED(HYPERVISOR_CALLBACK_VECTOR,
+				 sysvec_kvm_asyncpf_interrupt)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	u32 token;

-- 
2.39.2

