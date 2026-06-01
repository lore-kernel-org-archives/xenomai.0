Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3579306752
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336734; cv=none; b=X4SvDmRES/ZOQDCi9UFLr1w1AiEt+Bscg3lXWJt3mTgjukDV6FFiSK5RQAz5FWQbzQ/DynCQtHOEIJhQ7slbk+eQLM7fVeUbwCcniKg0GIgsbRrYgdBuTYXl5yQouXfdW1xdWw9lmoYiBOYh6OUf2QuvxMxeZJhB1+cLfZU43cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336734; c=relaxed/simple;
	bh=l8vm6qzqsZtirh8DDpgJh5DQse1x2ZumAqBKWWOjOos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SE7vLkxcdnMn4ivBVxdCkG6jGObm7yr7EAdzPsmm9KVuIEjQ60tuxwI+1m6s1eS9EBu7qH/wd2LCn3IrzsZ4fsHf8R1pu/t8bjCYhcrHguG6wBrAevSU9LQMljX///inbPxbtxV1nJhB1lhdjSK+eEDmJ2/4AdE6PqggBPtO3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=gDTT9xu/; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="gDTT9xu/"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026060117584022372de542000207de
        for <xenomai@lists.linux.dev>;
        Mon, 01 Jun 2026 19:58:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+PKr+kSLg8N9ksFr+jJSJGksPsQLzma8eI0DjlfCQ9w=;
 b=gDTT9xu/GS5A1+ogZ63pg+638OkMhtRe5unPnNimq8zFqR0k9bdZoWuXc+hhp4lrnGUZaZ
 ePsvM4Sl2WUcUwTZ0XrJyVDJHj2f5/XKV26vaJu4MTMLjkal4/kxRg1UAdZrPfGdZ7tP+deo
 lLJOpECbgwm6j91ZmYU3pwDD8mx6mMP6CsRMWHI9VgBp/bmSvpRPfOJyCqHgbrfTDqXcTabl
 9KOC2Ar53/yLFkN+06mmBGjllhIScAyltniuZsHgiFxwwepEOlAjYEwHGhsaxldDIyOr99jM
 vVYCLTHCxr2QQEo5bztb9EOuzo+bh1hpii8UbdBsXr+ylvFW4ouBY0HQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev,
	Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [RFC PATCH Dovetail 7.1] x86: irq_pipeline: Allow X86_FRED to be enabled
Date: Mon,  1 Jun 2026 19:58:38 +0200
Message-ID: <20260601175838.1115533-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some low level entry functions, fred_##func were not defined when
FRED has been enabled:

ld: vmlinux.o:(.data..ro_after_init+0x6100): undefined reference to `fred_sysvec_apic_timer_interrupt'
ld: vmlinux.o:(.data..ro_after_init+0x6120): undefined reference to `fred_sysvec_kvm_posted_intr_nested_ipi'
ld: vmlinux.o:(.data..ro_after_init+0x6128): undefined reference to `fred_sysvec_kvm_posted_intr_wakeup_ipi'
ld: vmlinux.o:(.data..ro_after_init+0x6130): undefined reference to `fred_sysvec_kvm_posted_intr_ipi'
ld: vmlinux.o:(.data..ro_after_init+0x6150): undefined reference to `fred_sysvec_irq_work'
ld: vmlinux.o:(.data..ro_after_init+0x6158): undefined reference to `fred_sysvec_x86_platform_ipi'
ld: vmlinux.o:(.data..ro_after_init+0x6160): undefined reference to `fred_sysvec_reboot'
ld: vmlinux.o:(.data..ro_after_init+0x6178): undefined reference to `fred_sysvec_call_function_single'
ld: vmlinux.o:(.data..ro_after_init+0x6180): undefined reference to `fred_sysvec_call_function'
ld: vmlinux.o:(.data..ro_after_init+0x6188): undefined reference to `fred_sysvec_reschedule_ipi'
ld: vmlinux.o:(.data..ro_after_init+0x6198): undefined reference to `fred_sysvec_spurious_apic_interrupt'

Updating the DEFINE_IDTENTRY_SYSVEC_PIPELINED() and
DEFINE_IDTENTRY_SYSVEC_PIPELINED_NORETURN() macros to define those
functions.

FRED entry points for sysvecs will no go through the IRQ pipeline as
we do it for the IDT.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

Hi Philippe,

input highly welcome. This allows to build x86 with FRED enabled, which
fixes a compile time issue introduced with 7.1-rc5.

On first glance that seems to do the right thing, but as always I might
miss something.

 arch/x86/Kconfig                |  2 +-
 arch/x86/include/asm/idtentry.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4d40fbb58b1c..fc6500301ff9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -554,7 +554,7 @@ config X86_CPU_RESCTRL_INTEL_AET
 
 config X86_FRED
 	bool "Flexible Return and Event Delivery"
-	depends on X86_64 && !IRQ_PIPELINE
+	depends on X86_64
 	help
 	  When enabled, use Flexible Return and Event Delivery
 	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 0b517059ae9d..bb1df662dc56 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -222,6 +222,11 @@ static __always_inline void __##func(struct pt_regs *regs, u8 vector)
  */
 #define DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)			\
 __visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	arch_pipeline_entry(regs, vector);				\
+}									\
+									\
+void fred_##func(struct pt_regs *regs)					\
 {									\
 	arch_pipeline_entry(regs, vector);				\
 }									\
@@ -233,6 +238,12 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	arch_pipeline_entry(regs, vector);				\
 }									\
+									\
+void fred_##func(struct pt_regs *regs)					\
+{									\
+	arch_pipeline_entry(regs, vector);				\
+}									\
+									\
 __visible __noreturn void __##func(struct pt_regs *regs)
 
 #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)		\
-- 
2.54.0

