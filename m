Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066A19ABB1
	for <xenomai@lists.linux.dev>; Wed, 21 Aug 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247353; cv=none; b=opsF/ad1ilnmw56pfvpMT9oZScRwopP/+HqI4Exa17nFvt2jNedPApNeXJF2D5LD/soOHQ37KEDmR5pJHFLuYYTBIzar/lerNfrEpgGq2S2Ab55tUSdVh5S9/8uV8kX8Ssrj7TzlGh5s7qG3amdxIj9Y2M3/sQ7NStKb3JEFFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247353; c=relaxed/simple;
	bh=WkOEezhWHzFlBEDsEW/Q2F9GkK4N5oCXiLl5XDX/yAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=osi/5SDx8DbX5xIYmvgdSfsDuekA6BhiYiIJcRF8DAQDLtbo260BTQkUnJTkD0b37n10kpRkTT1/8apZdwRtMrSxB7hX2newwliGwTM9Wr8hwEats/rmxSKD0rHBIAiNBn//lEB1Ibrp7xxqgpeazVNVNwY3JXT/OpCcnUYSy6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=eZg5dMYM; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="eZg5dMYM"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240821133537e78b54114a586011ac
        for <xenomai@lists.linux.dev>;
        Wed, 21 Aug 2024 15:35:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=LpJYXGduPk6Aw9aS8WvF9mYbnWRm0MbX0/ytBbrtkLM=;
 b=eZg5dMYM6IDZzn2M5Vs9RDTag/WM6FibDL0A60mwyj0kRXx3rXsIPpZdPulYU79lt85HgW
 E/ALKZZ/iYrcK/LUBCzsZKKSCAwHPHwbMoLOvS8UGIJXwpH7e/hitmZEvrepL9/9UpxeWF/O
 rcJKk8i8NRDdZKtGIbboqN1zQde7lSBrqec2DQp3kS+mQ8WFTOEV0uIYOqH25BZm8Vo8Oa7l
 l5oC5/dEG+rDTLYlP1CbqHTHFLkz2BjTdwz/nfg5u6rczLaQn2BCL9zhBK6Tq6JZZO+hmTGZ
 5xIh7ZHJncKAtGpdJc6uZKeKECu0y8P7yY/OiaeMvWOFCjXafyAJmzdQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 21 Aug 2024 15:35:24 +0200
Subject: [PATCH RFC dovetail 6.11,6.10] x86: dovetail: Allow
 CONFIG_ACRN_GUEST and CONFIG_KVM_GUEST at the same time
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-flo-6-10-fix-kvm-acrn-both-active-v1-1-7473ea13b638@siemens.com>
X-B4-Tracking: v=1; b=H4sIABvtxWYC/x2NwQrCMBBEf6XsuStJjKV6FfwAr+IhSbc2GBNJa
 hBK/92tl2FmGN4sUCh7KnBqFshUffEpcpBtA24y8UHoB86ghNKiVxLHkLBDKXD0X3zWFxqXI9o
 0T+xmXwmF1b0e3f6o3QGYY00htNlENzEpfkLg8p2JAf/jG1wv5204pEqz8WHz3U7KlkXAfV1/h
 HPkY6YAAAA=
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Ionut Nechita <ionut.nechita@intel.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
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

We hook into the sysvec_install() macro and call a dovetail specific
pipelined_sysvec_install(). This way we get informed about the init
phase of HV guest code and handle all hypervisors the same way.

The trampoline function (pipeline_hv_callback()) is needed to statisfy
type checks done by run_sysvec_on_irqstack_cond().

Link: https://lore.kernel.org/xenomai/PH0PR11MB59498BE915597AEF0B5BBB30F4B42@PH0PR11MB5949.namprd11.prod.outlook.com/
Reported-by: Ionut Nechita <ionut.nechita@intel.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Hi all,

this is my first try to fix the build error shown in patch 1 that
appears when both CONFIG_ACRN_GUEST and CONFIG_KVM_GUEST are active.

This patch (series) applies to recent dovetail versions only. I tested 6.11,
6.10 and 6.9. LTS versions (like 6.6, 6.1 and below) would require a
backport. The FRED support added in recent version makes a difference
here.

Feedback welcome...
---
 arch/x86/include/asm/idtentry.h |  9 +++++++++
 arch/x86/kernel/irq_pipeline.c  | 19 +++++++++----------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 524cb93afc34..3107f2cbf7f8 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -235,6 +235,12 @@ __visible __noreturn void __##func(struct pt_regs *regs)
 #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)		\
 	DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)
 
+extern void (*pipelined_hv_callback_fn)(struct pt_regs *regs);
+static inline void pipelined_sysvec_install(int vector, const void *function)
+{
+	if (vector == HYPERVISOR_CALLBACK_VECTOR)
+		pipelined_hv_callback_fn = function;
+}
 #else  /* !CONFIG_IRQ_PIPELINE */
 
 #define DECLARE_IDTENTRY_SYSVEC_PIPELINED(vector, func)		DECLARE_IDTENTRY_SYSVEC(vector, func)
@@ -274,6 +280,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
 									\
 static noinline void __##func(struct pt_regs *regs, u32 vector)
 
+#define pipelined_sysvec_install(vector, function)
+
 #endif	/* !CONFIG_IRQ_PIPELINE */
 
 /**
@@ -523,6 +531,7 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
 #endif
 
 #define sysvec_install(vector, function) {				\
+        pipelined_sysvec_install(vector, __##function);			\
 	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
 		fred_install_sysvec(vector, function);			\
 	else								\
diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 73e97fba55e7..21e40eafd9d5 100644
--- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -14,6 +14,8 @@
 #include <asm/mshyperv.h>
 #include <asm/idtentry.h>
 
+void (*pipelined_hv_callback_fn)(struct pt_regs *regs) = NULL;
+
 static struct irq_domain *sipic_domain;
 
 static void sipic_irq_noop(struct irq_data *data) { }
@@ -76,6 +78,12 @@ static void pipeline_exit_rcu(irqentry_state_t state)
 		ct_irq_exit();
 }
 
+static void pipeline_hv_callback(struct pt_regs *regs)
+{
+	if (pipelined_hv_callback_fn)
+		pipelined_hv_callback_fn(regs);
+}
+
 static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
@@ -150,18 +158,9 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
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

---
base-commit: 107c7caba1cea149373d22247c5b77f18eede354
change-id: 20240821-flo-6-10-fix-kvm-acrn-both-active-0b484fc394c5

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

