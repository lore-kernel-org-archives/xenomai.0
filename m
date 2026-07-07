Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C43D647C
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417831; cv=none; b=NmRsnHQlnMHeunVfvEhqTbcnsvGcrfQJ8qZDzEiK7JDKnmSssvvN7Wt8dWLrZ5tKuWC8uOSZBWh1thsFk/uslcT/Fk5sMQT19IST+RNA0MU1LWV0xcQFb4U5kGkETtcXuKQ0rUWFP0fOtTMtMtQ2SUpYHZq6TAO4VngWgWkveWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417831; c=relaxed/simple;
	bh=FzEpM5y8G1Qohnff3MEc0pFLV2BMSCrCCZEZ1f9IG4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RaNovIgSfREPMxa6VTntDAgmYa9jh+RkkV6a1S/TQluEIlpUFpwzRWUTuaZjwrkLTwLBUPPGgUI2JBBxu/1qZcziK44NBCUmn1LrMlovNg2HwEJUlW30lpLv6ZULgb7H2mLWvVqXm5w5q4tVuYrOgPCWN/u0OCLJJ5PvuDNmJBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=M06BMSCw; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="M06BMSCw"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202607070950206220dcabb6000207c4
        for <xenomai@lists.linux.dev>;
        Tue, 07 Jul 2026 11:50:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=y84fhcUXKvOf7nVc/Efu59MqvRot45yMfBa+MFQEBZg=;
 b=M06BMSCwFttZ8Ij9SF+WlZyv4TMtsN03hh4vWbKnudooo0T7Lf7LFtcO/sFeQn1F+HbWWv
 0MA2ZBOJ353pFOLzIMFgnefLncOTW+4Ap2S7Y9TBaKC5lL/H/blWWE5ZyHTqIGI496RE8ErL
 nVA1tgtCd2wO2UpSok3bOhfSCOiKQzjeaLhSbTdXUck/qtUi2GnPyp7/Lvuo4YJ56QcAx7Cw
 4ByXBt3pMBuDgQ8N/LQn0vik0Hgv2V8v2WI3qQvithXx7a60XaDwy8NH650ZjLhWLR6a3IqX
 FMPkBcxkUMidPrBACbNjd0Cfrh1orG8LpZFkT/+eN6v6UVC+ZjM7t6OA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 07 Jul 2026 11:50:21 +0200
Subject: [PATCH Dovetail v4 5/8] genirq: irq_pipeline: Decouple
 kernel/irq/pipeline.c from irqstate bit definitions
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-5-057b8af5a2ca@siemens.com>
References: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
In-Reply-To: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This only affects architectures where CONFIG_GENERIC_ENTRY is not set.

Moving the stall bit definitions into the architecture specific
implementations allows re-use of those definition within the arch
specifics.

Moving the defines to include/linux/irq_pipeline.h turned out to
trigger a lot of trouble as re-use will live in asm/ where including
a "general" header is quite hard.

The platform independent implementation will now need the following
arch specific hooks, all operating on the platform specific
struct pt_regs:
  - arch_kentry_test_stalled()
  - arch_kentry_test_hardirq()
  - arch_kentry_clear_irq_state()
  - arch_kentry_set_stalled()
  - arch_kentry_set_hardirq()

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/irq/pipeline.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index ced7003a8444125ff38d71bf867ce34cfa0235f1..de401973c623017347468e429e19b45d4b069524 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -1401,33 +1401,26 @@ void sync_current_irq_stage(void) /* hard irqs off */
  * in kernel context, indexed on the current register frame.
  */
 
-#define KENTRY_STALL_BIT      BIT(0) /* Tracks INBAND_STALL_BIT */
-#define KENTRY_LOCKDEP_BIT    BIT(1) /* Tracks hardirqs_enabled */
-
 asmlinkage __visible noinstr void kentry_enter_pipelined(struct pt_regs *regs)
 {
-	long irqstate = 0;
-
 	WARN_ON(irq_pipeline_debug() && !hard_irqs_disabled());
 
 	if (!running_inband())
 		return;
 
+	arch_kentry_clear_irq_state(regs);
+
 	if (lockdep_read_irqs_state())
-		irqstate |= KENTRY_LOCKDEP_BIT;
+		arch_kentry_set_hardirq(regs);
 
 	if (irqs_disabled())
-		irqstate |= KENTRY_STALL_BIT;
+		arch_kentry_set_stalled(regs);
 	else
 		trace_hardirqs_off();
-
-	arch_kentry_set_irqstate(regs, irqstate);
 }
 
 asmlinkage void __visible noinstr kentry_exit_pipelined(struct pt_regs *regs)
 {
-	long irqstate;
-
 	WARN_ON(irq_pipeline_debug() && !hard_irqs_disabled());
 
 	if (!running_inband())
@@ -1444,13 +1437,12 @@ asmlinkage void __visible noinstr kentry_exit_pipelined(struct pt_regs *regs)
 	 * do flip the stall bit, but are not tracked by lockdep).
 	 */
 
-	irqstate = arch_kentry_get_irqstate(regs);
-	if (!(irqstate & KENTRY_STALL_BIT)) {
+	if (!arch_kentry_test_stalled(regs)) {
 		stall_inband_nocheck();
 		trace_hardirqs_on();
 		unstall_inband_nocheck();
 	} else {
-		lockdep_write_irqs_state(!!(irqstate & KENTRY_LOCKDEP_BIT));
+		lockdep_write_irqs_state(arch_kentry_test_hardirq(regs));
 	}
 }
 

-- 
2.55.0

