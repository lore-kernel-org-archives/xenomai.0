Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B528EA
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405390; cv=none; b=ZVb/ogpi4CJx2LivKbLA1R1Z0bexMV+OOdzFKlsMMczgrDCPi23OOQbKn42ffnobpRZ8Ll40KuhE1gtk7AoJuCDYln22bHFBDw6cjyGTmJ6b5G4eOlxEKJPLhFJyX/+9C9ZK0aiR1at1yo66dIL9e+62o96fcWzalZiCu2rDlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405390; c=relaxed/simple;
	bh=pCG/4kLci03Co0+hW4pp1e3YOxI8gjZCZplYhpMVzAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nny1xXOhA+jwTP3yHE0E5qgxZANGowNaoiaBW5ASRFad4E0njXitpGY1nb+n7hQVMQO116YRo/3TC4zSKvXYgyYrcuoC1mwrJmMFTF+JZSibpuUJzpqV71YkdZCEH284a6kiTTBx70ZNXRacLTCVLqkVJEytXsPcG/G/EHrNS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Fru73lBK; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Fru73lBK"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202408230919300ff2dafd25f4e0bb3d
        for <xenomai@lists.linux.dev>;
        Fri, 23 Aug 2024 11:19:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Dzs7MWSVWvtH2PP27RLxtazE6IlZ9UMxQX1aCbOt53s=;
 b=Fru73lBKXfmUrXMiwwywQUANtA/8zmRr0CUkKasRbwqeIhtURGuvNgd2HWZE0s0I1wB540
 IMZ6C1lkjkqonoQbn/saS9IN4eps3nzDFn2pu5PxSDl+tGuZzG6zPYw3U6EL1Fz/d82AHEor
 iuqpvLNqwJJOmIgGywJDexz2wuF7Su6vW296raRyQbB9i2S7YBTpsB3XScYBcqvt06ro+1Qv
 QgHlAwihzg/Hj5BTbArU3z4guo4kT3EsTtphkfw1lhjhAFMXeWp2cmFsGfd5OPX4YWQsmTVa
 9svDFtiL4dxSKKmhz+z24oLXyHwPVZ1fJ0QNc2jNnpA8LwoLzBnthb/w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Ionut Nechita <ionut.nechita@intel.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH dovetail 6.10] x86: dovetail: Allow multiple HV guest extensions to be enabled
Date: Fri, 23 Aug 2024 11:18:54 +0200
Message-Id: <20240823091858.3355791-1-florian.bezdeka@siemens.com>
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

Hi all,

changes compared to the RFC:
- Changed title
- Some renamings, mainly taking care of the feedback provided by
  Philippe
- Added backports for all dovetail/Linux LTS versions

All patches are build tested and runtime tested for KVM guests. I have
no other HV / VMM at hand.

Ionut, it would be very nice if you could test at least one version for
ACRN. Thanks!

Best regards,
Florian

 arch/x86/include/asm/idtentry.h | 10 ++++++++++
 arch/x86/kernel/irq_pipeline.c  | 18 ++++++++----------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 524cb93afc34..e7d434e2ace0 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -235,6 +235,13 @@ __visible __noreturn void __##func(struct pt_regs *regs)
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
@@ -274,6 +281,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
 									\
 static noinline void __##func(struct pt_regs *regs, u32 vector)
 
+static inline void pipeline_install_sysvec(vector, function) {}
+
 #endif	/* !CONFIG_IRQ_PIPELINE */
 
 /**
@@ -523,6 +532,7 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
 #endif
 
 #define sysvec_install(vector, function) {				\
+	pipeline_install_sysvec(vector, __##function);			\
 	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
 		fred_install_sysvec(vector, function);			\
 	else								\
diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 73e97fba55e7..7a64af5dab73 100644
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
-- 
2.39.2

