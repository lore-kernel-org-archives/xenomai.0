Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1938513D2A4
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404784; cv=none; b=PLO2BTzKst3CroKrum/2gljSz/MdDtlzBWByLJATLD4cNvYUgRS6GsdS0qSNrt4OM1IXBVXbIekfTwum1nr8GCA/odZUc4dw/cVO7WPEYNFa/H/DQUzZhVJKfYo6Rthz2Z0pGSK1NrzspvYl3B9YxWOjIVBleeuLFPSj/pKZri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404784; c=relaxed/simple;
	bh=2QSnJaKu3Qqmf0SVpLH0B4RiC0z9GbSR+g2NMvjfeWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zn6OHbKvje9Ai5m9bWkPMIdm43scY+UkU7gk1nUr5AjuT65vjFpOxU72Cpd+jW5qxEvm4Bi5xXlCjbshnbQZD7j4f45XGzt3sVfYpbVN8Q/D1bVvdaBGYxxdMjHtRKf4O+TZ1fMyDdTkljkZZ4wBwL+igAgnnpFwrkxN+XM7W8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=T2aOO3eR; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="T2aOO3eR"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024082309193236d7fb6f1bd6922378
        for <xenomai@lists.linux.dev>;
        Fri, 23 Aug 2024 11:19:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uQ2Ru883qwIyiKAXLSaBjpyL8Tkzl2xAyRG7JwKUWjg=;
 b=T2aOO3eRrAmnHkXzH5EFgMnQp4+iT/aBECBnRUkBF6RyCa6pLvx65e3qiiUmeFZMIQ/kpP
 5swJAl/WR6QV9KMetUvYtRAg4YZNSvRnDhgaC3ChgJhrZN4nTkPafZH5LpbTR8iYk5lK1NOi
 sius6Bd3DLatP7YQ9eJB4SKRO5Q/3edzp87cnJBfVwUgP7ZqvCkG+J9lcUiwjuPlXisMAiPJ
 4zp6d1Dxf4tXHtLes4rFtkoykSTemv3A4wCTL76ICI/J1MTSZPatJUTVgxM1wLzkxrRA2HeS
 MhjkZM4gE9Ho3LaJ+sZF7C6zxod4Wnjq+Djs5a1Gm82hTtVVwg5GP0+Q==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Ionut Nechita <ionut.nechita@intel.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH dovetail 5.10] x86: dovetail: Allow multiple HV guest extensions to be enabled
Date: Fri, 23 Aug 2024 11:18:58 +0200
Message-Id: <20240823091858.3355791-5-florian.bezdeka@siemens.com>
In-Reply-To: <20240823091858.3355791-1-florian.bezdeka@siemens.com>
References: <20240823091858.3355791-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

do_sysvec_inband() assumed that only one of CONFIG_ACRN_GUEST and
CONFIG_KVM_GUEST is active at the same time. If both were enabled we
run into a compile issue:

arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
   160 |         case HYPERVISOR_CALLBACK_VECTOR:
       |         ^~~~
arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
   154 |         case HYPERVISOR_CALLBACK_VECTOR:
       |         ^~~~

As only one hypervisor (HV) can be active at the same time, but support
for more than one can be compiled in, we have to migrate from a build
time decision to a runtime based one.

We introduce sysvec_install() macro - like modern kernels already do -
and call a dovetail specific pipelined_sysvec_install() before
registering the IDT gate.

All HYPERVISOR_CALLBACK_VECTOR related callsites of alloc_intr_gate()
have been migrated to sysvec_install(). sysvec_install() is able to
distinguish between the low level entry point (asm_ variant) and the
higher entry point (__ variant).

Reported-by: Ionut Nechita <ionut.nechita@intel.com>
Closes: https://lore.kernel.org/xenomai/PH0PR11MB59498BE915597AEF0B5BBB30F4B42@PH0PR11MB5949.namprd11.prod.outlook.com/

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/include/asm/idtentry.h  | 15 +++++++++++++++
 arch/x86/kernel/cpu/acrn.c       |  2 +-
 arch/x86/kernel/cpu/mshyperv.c   |  2 +-
 arch/x86/kernel/irq_pipeline.c   | 19 +++----------------
 arch/x86/kernel/kvm.c            |  2 +-
 drivers/xen/events/events_base.c |  2 +-
 6 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index e60cc4c79541..e636b0b1859e 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -224,6 +224,13 @@ __visible __noreturn void __##func(struct pt_regs *regs)
 #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)		\
 	DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)
 
+extern void (*pipeline_hv_callback_fn)(struct pt_regs *regs);
+static inline void pipeline_install_sysvec(int vector, const void *function)
+{
+	if (vector == HYPERVISOR_CALLBACK_VECTOR)
+		pipeline_hv_callback_fn = function;
+}
+
 #else  /* !CONFIG_IRQ_PIPELINE */
 
 #define DECLARE_IDTENTRY_SYSVEC_PIPELINED(vector, func)		DECLARE_IDTENTRY_SYSVEC(vector, func)
@@ -264,6 +271,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
 									\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector)
 
+static inline void pipeline_install_sysvec(vector, function) {}
+
 #endif	/* !CONFIG_IRQ_PIPELINE */
 
 /**
@@ -483,6 +492,12 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #define DEFINE_IDTENTRY_DEBUG_USER	DEFINE_IDTENTRY_NOIST
 #endif
 
+#define sysvec_install(vector, function)                       \
+	{                                                      \
+		pipeline_install_sysvec(vector, __##function); \
+		alloc_intr_gate(vector, asm_##function);       \
+	}
+
 #else /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 7f0694b812e6..c9eca7840143 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -25,7 +25,7 @@ static u32 __init acrn_detect(void)
 static void __init acrn_init_platform(void)
 {
 	/* Setup the IDT for ACRN hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_acrn_hv_callback);
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
 }
 
 static bool acrn_x2apic_available(void)
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index ffa7ff0bd10d..e9f5fb02c27c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -350,7 +350,7 @@ static void __init ms_hyperv_init_platform(void)
 	x86_platform.apic_post_init = hyperv_init;
 	hyperv_setup_mmu_ops();
 	/* Setup the IDT for hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_hyperv_callback);
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
 
 	/* Setup the IDT for reenlightenment notifications */
 	if (ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT) {
diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 687a9375d374..2a5909384c09 100644
--- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -14,6 +14,8 @@
 #include <asm/mshyperv.h>
 #include <asm/idtentry.h>
 
+void (*pipeline_hv_callback_fn)(struct pt_regs *regs) = NULL;
+
 static struct irq_domain *sipic_domain;
 
 static void sipic_irq_noop(struct irq_data *data) { }
@@ -117,9 +119,6 @@ static void do_sysvec_inband(struct irq_desc *desc)
 		break;
 #endif
 #ifdef CONFIG_HYPERV
-	case HYPERVISOR_CALLBACK_VECTOR:
-		__sysvec_hyperv_callback(regs);
-		break;
 	case HYPERV_REENLIGHTENMENT_VECTOR:
 		__sysvec_hyperv_reenlightenment(regs);
 		break;
@@ -127,21 +126,9 @@ static void do_sysvec_inband(struct irq_desc *desc)
 		__sysvec_hyperv_stimer0(regs);
 		break;
 #endif
-#ifdef CONFIG_ACRN_GUEST
-	case HYPERVISOR_CALLBACK_VECTOR:
-		__sysvec_acrn_hv_callback(regs);
-		break;
-#endif
-#ifdef CONFIG_XEN_PVHVM
 	case HYPERVISOR_CALLBACK_VECTOR:
-		__sysvec_xen_hvm_callback(regs);
+		pipeline_hv_callback_fn(regs);
 		break;
-#endif
-#ifdef CONFIG_KVM_GUEST
-	case HYPERVISOR_CALLBACK_VECTOR:
-		__sysvec_kvm_asyncpf_interrupt(regs);
-		break;
-#endif
 	case LOCAL_TIMER_VECTOR:
 		__sysvec_apic_timer_interrupt(regs);
 		break;
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 82e929abb7bb..8745e48966e0 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -740,7 +740,7 @@ static void __init kvm_guest_init(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_INT) && kvmapf) {
 		static_branch_enable(&kvm_async_pf_enabled);
-		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_kvm_asyncpf_interrupt);
+		sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_kvm_asyncpf_interrupt);
 	}
 
 #ifdef CONFIG_SMP
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index f608663bdfd5..ef80482fcfe4 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -2132,7 +2132,7 @@ static __init void xen_alloc_callback_vector(void)
 		return;
 
 	pr_info("Xen HVM callback vector for event delivery is enabled\n");
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_xen_hvm_callback);
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_xen_hvm_callback);
 }
 #else
 void xen_setup_callback_vector(void) {}
-- 
2.39.2

