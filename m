Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74FA43165
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405386; cv=none; b=eiTLM5+tCVbVxJBAtadnv5WryIOlLFo9IS7W7g+vERX9Vu3dt6ee+KB/ckgVs64os8zjiSHjcl+H/gqczvV+H/yRWf/GGEPx8LGcsChYIL+ZWa12YZqrlim7z/vNmfMb5+sLAOu5pZaYem+FUgGYi3ZfPXv7yuzcF5u9XqjmSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405386; c=relaxed/simple;
	bh=N5A6IWpYFpNmS+mppR2RRsE8orGOUhwjrQaUn9Afrh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQ25Ozbw0a8J+EPc9g89OIpIkt7HwPVRaA3EgReeueugwnmZ7BRZd9IT5vre+Z7fmVPwJT7GjQNnHf7z3r25MsPPAPZZ4fDfwPOab0bAwtpvpz79R8doGm3+2gLcwZmHwiRUskSl4Bt/Y9N/mgeoODy6NysxJ5qYbX6kEEKB8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PfWXRAY3; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PfWXRAY3"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024082309193136600216c12480949f
        for <xenomai@lists.linux.dev>;
        Fri, 23 Aug 2024 11:19:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Z0j1BChvqT4uZA0HxDtreK/PA9jK3Fc0LLT4B8jLQbs=;
 b=PfWXRAY3wRUaevbjr8kLOcIvhYAiY7e3b3ad72NWViKC9Yg0XX2U+Vtoj+9R9JqqbmbquR
 8ti1hnIc/FnvikU3FpIxnjYKHK/snUS5wyEwR3kLwj3sM2grc6pXylXs2aDwYtdKHB0HkZuw
 0JJsFP32/vzatVXPRF9L0cpFLd8eN/kt492V02iGbNL639Asy5POJuJPrhubzEIscQ7Sfuxx
 7Moeix1dzadHElk4GTH+HsuTo7SfeJqCdxA8jMMDPmCLfWnUuMv03Scs0LkKJThfCcpVIqeZ
 8kgLVk/10f32DhX4CxQSyHSB1/UDchwEbWUGvViuWhfp/PE3ds+xa6OQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Ionut Nechita <ionut.nechita@intel.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH dovetail 6.1] x86: dovetail: Allow multiple HV guest extensions to be enabled
Date: Fri, 23 Aug 2024 11:18:56 +0200
Message-Id: <20240823091858.3355791-3-florian.bezdeka@siemens.com>
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

The trampoline function (pipeline_hv_callback()) is needed to statisfy
type checks done by run_sysvec_on_irqstack_cond().

Reported-by: Ionut Nechita <ionut.nechita@intel.com>
Closes: https://lore.kernel.org/xenomai/PH0PR11MB59498BE915597AEF0B5BBB30F4B42@PH0PR11MB5949.namprd11.prod.outlook.com/

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/include/asm/idtentry.h  | 15 +++++++++++++++
 arch/x86/kernel/cpu/acrn.c       |  2 +-
 arch/x86/kernel/cpu/mshyperv.c   |  2 +-
 arch/x86/kernel/irq_pipeline.c   | 18 ++++++++----------
 arch/x86/kernel/kvm.c            |  2 +-
 drivers/xen/events/events_base.c |  2 +-
 6 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 61984b960a9f..c176e541fd1d 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -220,6 +220,13 @@ __visible __noreturn void __##func(struct pt_regs *regs)
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
@@ -259,6 +266,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
 									\
 static noinline void __##func(struct pt_regs *regs, u32 vector)
 
+static inline void pipeline_install_sysvec(vector, function) {}
+
 #endif	/* !CONFIG_IRQ_PIPELINE */
 
 /**
@@ -476,6 +485,12 @@ __visible noinstr void func(struct pt_regs *regs,			\
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
index 8fa6c605b579..8fb5f4945325 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -27,7 +27,7 @@ static u32 __init acrn_detect(void)
 static void __init acrn_init_platform(void)
 {
 	/* Setup the IDT for ACRN hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_acrn_hv_callback);
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
 
 	x86_platform.calibrate_tsc = acrn_get_tsc_khz;
 	x86_platform.calibrate_cpu = acrn_get_tsc_khz;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 54d8436ee56a..db92a583c126 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -422,7 +422,7 @@ static void __init ms_hyperv_init_platform(void)
 	x86_platform.apic_post_init = hyperv_init;
 	hyperv_setup_mmu_ops();
 	/* Setup the IDT for hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_hyperv_callback);
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
 
 	/* Setup the IDT for reenlightenment notifications */
 	if (ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT) {
diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 8a71a61327d5..d48440081f83 100644
--- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -14,6 +14,8 @@
 #include <asm/mshyperv.h>
 #include <asm/idtentry.h>
 
+void (*pipeline_hv_callback_fn)(struct pt_regs *regs) = NULL;
+
 static struct irq_domain *sipic_domain;
 
 static void sipic_irq_noop(struct irq_data *data) { }
@@ -76,6 +78,11 @@ static void pipeline_exit_rcu(irqentry_state_t state)
 		ct_irq_exit();
 }
 
+static void pipeline_hv_callback(struct pt_regs *regs)
+{
+	pipeline_hv_callback_fn(regs);
+}
+
 static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
@@ -150,18 +157,9 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
 					regs);
 		break;
 #endif
-#ifdef CONFIG_ACRN_GUEST
 	case HYPERVISOR_CALLBACK_VECTOR:
-		run_sysvec_on_irqstack_cond(__sysvec_acrn_hv_callback,
-					regs);
+		run_sysvec_on_irqstack_cond(pipeline_hv_callback, regs);
 		break;
-#endif
-#ifdef CONFIG_KVM_GUEST
-	case HYPERVISOR_CALLBACK_VECTOR:
-		run_sysvec_on_irqstack_cond(__sysvec_kvm_asyncpf_interrupt,
-					    regs);
-		break;
-#endif
 	case LOCAL_TIMER_VECTOR:
 		run_sysvec_on_irqstack_cond(__sysvec_apic_timer_interrupt,
 					regs);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 9dde33d59efe..6af49d30816c 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -845,7 +845,7 @@ static void __init kvm_guest_init(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_INT) && kvmapf) {
 		static_branch_enable(&kvm_async_pf_enabled);
-		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_kvm_asyncpf_interrupt);
+		sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_kvm_asyncpf_interrupt);
 	}
 
 #ifdef CONFIG_SMP
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 96b96516c980..867ead24d93a 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -2238,7 +2238,7 @@ static __init void xen_alloc_callback_vector(void)
 		return;
 
 	pr_info("Xen HVM callback vector for event delivery is enabled\n");
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_xen_hvm_callback);
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_xen_hvm_callback);
 }
 #else
 void xen_setup_callback_vector(void) {}
-- 
2.39.2

