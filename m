Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B887145B05
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404783; cv=none; b=CfVY7GR1jwPz4bFA8h/kWMtynfMpCg8ohuNYI9lNbyK7Zi+H7gwmw57wwuc0syAR5mbpClQNYDzXEL56jO6Wr2+5wXhacgmfN/12qNwJTtffGvQD9VzOLRvpUKLPpRz9aAl3QDVkXayJkTOqQSrMXxQQuW6iW5N31bmwfofKSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404783; c=relaxed/simple;
	bh=2LJSHyzEqN0w6OPxNz/Sui58amfTuXh64Ej8O/2ZhKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=darC4wP0gFw2lo8RwjIuLAxtQSBCK6OcJSEQzH8MD6TLd5io2LeedAOAGOfZOSzm/FdCN2HpkwiAeNlCk1jtTlFvxGt6Jn0R3rsoqSekQPn2mEjgWFG3PB1N9sLMZgg4+a7K+18AjVsw4YHX1/Kzhiz7QvBf4DPuI5ucqpdHPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Vwd57txF; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Vwd57txF"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202408230919315746d916abee21dad5
        for <xenomai@lists.linux.dev>;
        Fri, 23 Aug 2024 11:19:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5eb9MBo7WmdWb+qxEBUar0FaSgoD8E8NrJD07fGTyrc=;
 b=Vwd57txFM9yxbV0Wut9UtzFYqKVabIK3haQkcHtNHtur5KbYGyXeXtLgxgUk73zEzbLHCR
 iZX4U5PV85TI/sCwEvWz8OyjaFWB8vvYPuFe+CZ2JjsJGBq6bIgQT11ESYogHF2iT9b8Smm6
 WLHlj/aPjzoBhelGdmt8C55If+Cg5THjM0gtnZN0/3XCMdZgjjZKdB3LTKGSrkx1N1MpInZ0
 vpL8hZaeqocg/uEDKqkSeLZ7Bdc0OywcVMqA6zWhLJDzmbQV43a/Uj7xGGB/ubSRg8WquUtN
 cs+EbIjYfQ28yUEve03NVqdGvu7rW/kiH8hbSUbwjbRtCZZGS8NGS4rw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Ionut Nechita <ionut.nechita@intel.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH dovetail 5.15] x86: dovetail: Allow multiple HV guest extensions to be enabled
Date: Fri, 23 Aug 2024 11:18:57 +0200
Message-Id: <20240823091858.3355791-4-florian.bezdeka@siemens.com>
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
index 1f277e852c4a..5d1140bb5acc 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -218,6 +218,13 @@ __visible __noreturn void __##func(struct pt_regs *regs)
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
@@ -257,6 +264,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
 									\
 static noinline void __##func(struct pt_regs *regs, u32 vector)
 
+static inline void pipeline_install_sysvec(vector, function) {}
+
 #endif	/* !CONFIG_IRQ_PIPELINE */
 
 /**
@@ -474,6 +483,12 @@ __visible noinstr void func(struct pt_regs *regs,			\
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
index 0c9d6953f89a..3b02a4fbec97 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -27,7 +27,7 @@ static u32 __init acrn_detect(void)
 static void __init acrn_init_platform(void)
 {
 	/* Setup the IDT for ACRN hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_acrn_hv_callback);
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
 }
 
 static bool acrn_x2apic_available(void)
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 53ded40f3a48..01242d5c204a 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -406,7 +406,7 @@ static void __init ms_hyperv_init_platform(void)
 	x86_platform.apic_post_init = hyperv_init;
 	hyperv_setup_mmu_ops();
 	/* Setup the IDT for hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_hyperv_callback);
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
 
 	/* Setup the IDT for reenlightenment notifications */
 	if (ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT) {
diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 1332f328a45b..921898cbc7b3 100644
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
 		rcu_irq_exit();
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
index 9beb81d32d98..107190bd2309 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -751,7 +751,7 @@ static void __init kvm_guest_init(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_INT) && kvmapf) {
 		static_branch_enable(&kvm_async_pf_enabled);
-		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_kvm_asyncpf_interrupt);
+		sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_kvm_asyncpf_interrupt);
 	}
 
 #ifdef CONFIG_SMP
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 04ff194fecf4..7d0c56f6bf90 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -2213,7 +2213,7 @@ static __init void xen_alloc_callback_vector(void)
 		return;
 
 	pr_info("Xen HVM callback vector for event delivery is enabled\n");
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_xen_hvm_callback);
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_xen_hvm_callback);
 }
 #else
 void xen_setup_callback_vector(void) {}
-- 
2.39.2

