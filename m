Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3B1576EB5
	for <xenomai@lists.linux.dev>; Wed,  9 Sep 2026 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964394; cv=none; b=FyFLIVHbJ8TkbkolJSl+8/8I9iwbbi2LcFJWjKcGrxyAy88a4W8wo8NqiUZhgCZFvf/Zmg21zvVDGMR+spqw31dS/sKbRaOlyl8sVor72azdLZbHoaR16YfQb1HGirNT19BfDOYQjy3wyY8f9800pJSgrIdqNBAXdzIxoAcZxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964394; c=relaxed/simple;
	bh=qC6IOYOM8sZbMR4UfZTy5fRn1ViDQFpEWdWlaj77ub4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IfQatIwUVHYFBKJvmrwEQx48BCbi9Of8dBLiEsnQ3s9nVVI1x+vqSS+8/3PayHp5my+BTn/suPIxYAmhBsGnxIuFs443BCSKCLhJlS1i7PEkNmFaVG5VRN90wNUm1XKUGgSdwytxtIxYbntirxb74wuxCPRkJ55/lvO5Jh7UcFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=C9mQNoYT; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="C9mQNoYT"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202609091433011e59807dd600020708
        for <xenomai@lists.linux.dev>;
        Wed, 09 Sep 2026 16:33:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=c+xWNJidFNhSuZmadk7OK/1dQqP3hlM0ZfrU2pRN3es=;
 b=C9mQNoYT7M/uZ3STIfXVc83rfKb/F8OyTHFraU+suMAtqgN9JhWt4oB1KZ1GcP4lWQJkJT
 P8ksV3MTNwEItrsLCXPVpgN11BOKqIh/3VGJ/q/an3pPrhyfcDVC+FaGGRtFT/0Xa2AaA3cv
 UFCKU5wnqxgc864l7WKT0PMhL/lw+klO9Tjd1L/9x/mq9Whvm+YC9EHlgDmu338NCSOU2asU
 w5raJWYzulLdX8ImsH4naqgW2pEx432EC34PJJFtWvWZ6cWZ8mLUF6BjnQnmlAN4RjKaDEy4
 0M93sz79/3lXyjN611Ebt24PEchO6PDws+3/XT57EtGJ9VM9ertbrY4w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 09 Sep 2026 16:32:59 +0200
Subject: [PATCH Dovetail 2/2] irq_pipeline: Introduce IRQ_TICK to obsolete
 IRQF_TIMER on tick IRQs
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-wip-flo-v7-2-irq-cleanup-v1-2-825a908785ae@siemens.com>
References: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
In-Reply-To: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Gerte Hoogewerf <ghoogewerf@lmi3d.com>, 
 Andrew MacPherson <andrew@elk.audio>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Currently, all clock tick IRQs need to be marked with the IRQF_TIMER
flag, so that the registers could be saved when handling a pipeline
entry for timer IRQs / ticks.

It turned out that it is quite easy to miss that flag when enabling
the drivers for the pipelining case. In addition, IRQF_TIMER also
includes setting IRQF_NO_SUSPEND and IRQF_NO_THREAD, which is
misleading.

We hook into the clock event device registration now and check for
the CLOCK_EVT_FEAT_PIPELINE flag on the event device. If this flag
is set, we mark the underlying IRQ as IRQ_TICK.

The IRQ_TICK flag is only used for that pipeline internal purpose.

Suggested-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/linux/irq.h       | 11 +++++++++--
 kernel/irq/debug.h        |  1 +
 kernel/irq/manage.c       | 11 +++++++++++
 kernel/irq/pipeline.c     |  3 ++-
 kernel/irq/settings.h     | 17 +++++++++++++++++
 kernel/time/clockevents.c |  3 +++
 kernel/time/tick-common.c |  5 +++++
 7 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index b13e4e90ab18f027e43b4f892ca37ef482a6cf0a..5f7a2c78b3ca7a7a23894f68e16503c785eb5686 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -81,6 +81,7 @@ enum irqchip_irq_state;
  *                                when pipelining is enabled (CONFIG_IRQ_PIPELINE),
  *                                regardless of the (virtualized) interrupt state
  *                                maintained by local_irq_save/disable().
+ * IRQ_TICK                     - Interrupt is a timer tick source.
  */
 enum {
 	IRQ_TYPE_NONE		= 0x00000000,
@@ -109,14 +110,15 @@ enum {
 	IRQ_HIDDEN		= (1 << 20),
 	IRQ_NO_DEBUG		= (1 << 21),
 	IRQ_OOB			= (1 << 22),
-	IRQ_RESERVED		= (1 << 23),
+	IRQ_TICK		= (1 << 23),
+	IRQ_RESERVED		= (1 << 24),
 };
 
 #define IRQF_MODIFY_MASK	\
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
 	 IRQ_NOAUTOEN | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
-	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_OOB)
+	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_OOB | IRQ_TICK)
 
 #define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
 
@@ -1258,6 +1260,7 @@ static inline struct irq_chip_type *irq_data_get_chip_type(struct irq_data *d)
 
 #ifdef CONFIG_IRQ_PIPELINE
 int irq_switch_oob(unsigned int irq, bool on);
+void irq_switch_tick(unsigned int irq, bool on);
 void irq_clear_deferral(struct irq_desc *desc);
 void irq_clear_forward(struct irq_desc *desc);
 #else
@@ -1266,6 +1269,10 @@ static inline int irq_switch_oob(unsigned int irq, bool on)
 	return 0;
 }
 
+static inline void irq_switch_tick(unsigned int irq, bool on)
+{
+}
+
 static inline void irq_clear_deferral(struct irq_desc *desc) { }
 static inline void irq_clear_forward(struct irq_desc *desc) { }
 #endif	/* !CONFIG_IRQ_PIPELINE */
diff --git a/kernel/irq/debug.h b/kernel/irq/debug.h
index 4eafd04a629628553c11d639b4958d5007bbc012..9813c8ec66a447e4acde5ac2ca2fa1f8ab70021b 100644
--- a/kernel/irq/debug.h
+++ b/kernel/irq/debug.h
@@ -34,6 +34,7 @@ static inline void print_irq_desc(unsigned int irq, struct irq_desc *desc)
 	___P(IRQ_NOTHREAD);
 	___P(IRQ_NOAUTOEN);
 	___P(IRQ_OOB);
+	___P(IRQ_TICK);
 
 	___PS(IRQS_AUTODETECT);
 	___PS(IRQS_REPLAY);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1c1920f5fbc083ec299433dcddd4fae53e0d6ce8..a10d1081bea8c8887c61cb3ef5a87b274e1c9e08 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -949,6 +949,17 @@ int irq_switch_oob(unsigned int irq, bool on)
 }
 EXPORT_SYMBOL_GPL(irq_switch_oob);
 
+void irq_switch_tick(unsigned int irq, bool on)
+{
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		if (on)
+			irq_settings_set_tick(scoped_irqdesc);
+		else
+			irq_settings_clr_tick(scoped_irqdesc);
+	}
+}
+EXPORT_SYMBOL_GPL(irq_switch_tick);
+
 #endif /* CONFIG_IRQ_PIPELINE */
 
 /*
diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index 85ec0cbf5fb1e1fa38dee98d1f79a3ee4ae18774..88911489aeb632a00aab9784407f09ff835f7861 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -1064,8 +1064,9 @@ void copy_timer_regs(struct irq_desc *desc, struct pt_regs *regs)
 {
 	struct irq_pipeline_data *p;
 
-	if (desc->action == NULL || !(desc->action->flags & __IRQF_TIMER))
+	if (!irq_settings_is_tick(desc))
 		return;
+
 	/*
 	 * Given our deferred dispatching model for regular IRQs, we
 	 * record the preempted context registers only for the latest
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 27a37d992f237f6429f58b0b51eb9db39a62e8f7..c4b48d22d271a24e49951c4289784e44090f02dd 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -19,6 +19,7 @@ enum {
 	_IRQ_HIDDEN		= IRQ_HIDDEN,
 	_IRQ_NO_DEBUG		= IRQ_NO_DEBUG,
 	_IRQ_OOB		= IRQ_OOB,
+	_IRQ_TICK		= IRQ_TICK,
 	_IRQ_PROC_VALID		= IRQ_RESERVED,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
@@ -37,6 +38,7 @@ enum {
 #define IRQ_HIDDEN		GOT_YOU_MORON
 #define IRQ_NO_DEBUG		GOT_YOU_MORON
 #define IRQ_OOB			GOT_YOU_MORON
+#define IRQ_TICK		GOT_YOU_MORON
 #define IRQ_RESERVED		GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
@@ -210,3 +212,18 @@ static inline void irq_settings_set_oob(struct irq_desc *desc)
 {
 	desc->status_use_accessors |= _IRQ_OOB;
 }
+
+static inline bool irq_settings_is_tick(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_TICK;
+}
+
+static inline void irq_settings_clr_tick(struct irq_desc *desc)
+{
+	desc->status_use_accessors &= ~_IRQ_TICK;
+}
+
+static inline void irq_settings_set_tick(struct irq_desc *desc)
+{
+	desc->status_use_accessors |= _IRQ_TICK;
+}
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 0ed4122d40986708bd57f32ebf825aef60756f7d..d8d2dd43baaa0053a73bb18764ece562e8b49024 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp.h>
+#include <linux/irq.h>
 #include <linux/device.h>
 
 #include "tick-internal.h"
@@ -177,6 +178,8 @@ void clockevents_shutdown(struct clock_event_device *dev)
 	clockevents_switch_state(dev, CLOCK_EVT_STATE_SHUTDOWN);
 	dev->next_event = KTIME_MAX;
 	dev->next_event_forced = 0;
+	if (dev->features & CLOCK_EVT_FEAT_PIPELINE)
+		irq_switch_tick(dev->irq, false);
 }
 
 /**
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 90fae659e4ea68578a8ab5a739eccc1184ed5ff9..97e3ff40405dfbe670fe45aebdff015163cb6f31 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -12,7 +12,9 @@
 #include <linux/err.h>
 #include <linux/hrtimer.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/nmi.h>
+#include <linux/irq.h>
 #include <linux/percpu.h>
 #include <linux/profile.h>
 #include <linux/sched.h>
@@ -244,6 +246,9 @@ static void tick_setup_device(struct tick_device *td,
 	if (!cpumask_equal(newdev->cpumask, cpumask))
 		irq_set_affinity(newdev->irq, cpumask);
 
+	if (newdev->features & CLOCK_EVT_FEAT_PIPELINE)
+		irq_switch_tick(newdev->irq, true);
+
 	/*
 	 * When global broadcasting is active, check if the current
 	 * device is registered as a placeholder for broadcast mode.

-- 
2.55.0

