Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279851F941
	for <xenomai@lists.linux.dev>; Wed, 30 Apr 2025 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746020864; cv=none; b=Fls3qQ7LTn4vHavPBULlqRBjVcnCJJN4dLo1qOJQq3iCLzkE0QTBybPohzWMO/y1VNQ7h+x1Y9tlIU/izlahqZ9N01nQJoX/0HqE1YpL8p4bf5jM9KkVN5CFuIidQz4j7vxhshgFrdLS0dE+3JZu0aiJvPIrb1doGzJwg4HUNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746020864; c=relaxed/simple;
	bh=8+qroOkKKoQVHnQ0hih7gBdEnHR+L1H23cAz39n01qg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ja5HY5W634Y3iC/cs8s4xQELNL3vJ2Kyrc4e3i+vT8S0UOkQdMopTlWNvXwxih8USXd91CaX+9lVJzHuuqw/MQhMQP25SldUw2uf/ezhCPRm4Dh8X9cht2Qe2xwqmIP0/OdOYtgpszgYkOkLswaJofB4eieKu1ppwpp+AnfpFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ISkBYOT5; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ISkBYOT5"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E6DF43A2C
	for <xenomai@lists.linux.dev>; Wed, 30 Apr 2025 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1746020859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=DHque2PdOK2JGe8Qc8wpqMv9aPLQSR8rCgznHHvsx8A=;
	b=ISkBYOT5KtM18TlO6OHYUtp63ruFnZTfw5T8ss+6nbhdaDxhqpc0ffihfSnyaw9SF5FsRn
	w6PtE4iOY5fscIVzb5VlkOusVMpATtyOP2gdA0XmJ9loQyb4KQlSFF4IV5AzqC4DEumL+W
	LWEyt5UTPO6xDKh90+KCJsRDG2haRbjoSAXgzi5eS4i7dPPrYDoPaK8xAvBZ07zcHVJfCJ
	URNO+9OMHSzMwGuZ1OV29YZATKyhL2VO+3w4XJCHEuMeDeqe8ZjzFjYjZePnBRRDQYkw+4
	XLjqxILP5uwk79pTN4YIL+kjNV+ZAQn2X+eXEjRVR0oye5gVcPAJ35+WHLYtzw==
From: Philippe Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Subject: [PATCH][Dovetail] fix IRQ forwarding to the in-band stage
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 30 Apr 2025 15:47:38 +0200
Message-ID: <87plgtg3r9.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeikeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeeltdejffefieegheekhfelieekleeuveeftefhteevfedtgeduteekgfffvdehtdenucffohhmrghinhepuggvnhigrdguvgenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv
X-GND-Sasl: rpm@xenomai.org


Could some (preferably several) people check the patch below for
non-regression specifically on x86 with stacked irqchips? I ran into
an issue with interrupt forwarding while working on the xenomai4
netstack which that patch addresses. So far, so good here, but we need
more eyeballs and tests for this patch on a tricky and critical piece of
code.

This patch is against the Dovetail tree for 6.1.y-cip, also available
from [1].

TIA,

[1] https://source.denx.de/Xenomai/linux-dovetail/-/tree/urgent/v6.1.y-cip-dovetail?ref_type=heads

--

commit 1b67dc87eaeb0da8d719d1619735b0bba4a06da7 (HEAD -> urgent/v6.1.y-cip-dovetail, linux-dovetail/urgent/v6.1.y-cip-dovetail)
Author: Philippe Gerum <philippe.gerum@exail.com>

    genirq: irq_pipeline: fix IRQ forwarding to the in-band stage
    
    A forwarded interrupt event might trigger again before the in-band
    handler had a chance to run, this confuses get_flow_step() when
    determining the current flow state, leading to invalid calls to
    handle_oob_irq() from the in-band stage.
    
    Fix get_flow_step() by considering the pipeline entry condition
    (in_pipeline()) as a clear hint that we must be handling an event
    delivered by the hardware, not the forwarding code (in do_oob_irq()).
    
    In the same move, disambiguate between forwarded IRQs and replayed
    ones for multiple non-oob events from the same source which don't need
    masking on receipt (e.g. edge IRQs). In this rare case, the condition
    bit (IRQS_DEFERRED) might be cleared by the in-band handling code on
    the first occurrence, leaving no information to handle the second one
    appropriately.  We can figure out that a replay condition is pending
    (instead of a forwarding) by checking the oob capability for the
    interrupt: oob handled IRQs are never deferred (IRQS_DEFERRED), they
    can only be forwarded (IRQS_FORWARDED).
    
    At this chance, drop IRQ_FLOW_PILEUP which adds no additional
    information to the IRQ_FLOW_START state, and was therefore handled
    exactly the same way.
    
    Signed-off-by: Philippe Gerum <philippe.gerum@exail.com>

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 94ac7a5b264eb..82c67b49ef282 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -510,7 +510,6 @@ static bool irq_check_poll(struct irq_desc *desc)
 
 enum {
 	IRQ_FLOW_START,
-	IRQ_FLOW_PILEUP,
 	IRQ_FLOW_REPLAY,
 	IRQ_FLOW_FORWARD,
 };
@@ -581,7 +580,10 @@ irqreturn_t forward_irq_event(struct irq_desc *desc)
  *   issue a forwarding request of the incoming event to the in-band
  *   stage once done. In this case, the same IRQ action handler is
  *   called twice, first from the oob stage then from the in-band
- *   stage.
+ *   stage. The IRQ handling code should account for the fact that
+ *   multiple incoming events may be received on the oob stage from a
+ *   given source before the forwarding handler is eventually called
+ *   in-band only once by the pipeline core to cover all of them.
  *
  * When IRQ forwarding is requested by an oob action handler
  * (IRQS_FORWARDED is set in the per-descriptor state), acknowledge
@@ -593,44 +595,60 @@ irqreturn_t forward_irq_event(struct irq_desc *desc)
  * stage as well. The internal per-descriptor IRQS_DEFERRED flag
  * disambiguates between the latter context and events being replayed
  * after deferral to the in-band stage, so that we do ack the hardware
- * for cascaded events as expected.
+ * for cascaded events as expected. We might also receive an event
+ * while a previous one is still pending replay or forwarding.
  *
- * We might also receive a subsequent unmasked edge event on the same
- * line while a deferred one is still pending replay from the in-band
- * stage (hard irqs are on for replay). The flow state enumeration
- * disambiguates all cases as follows:
+ * The flow state enumeration below disambiguates all cases:
  *
  * - IRQ_FLOW_START: we are running oob on behalf of the low-level irq
- *   entry code, no deferred event is pending replay for the same
- *   line, we need to send ack to the hardware.
- *
- * - IRQ_FLOW_PILEUP: we are running in-band for synchronizing the irq
- *   log, one or more deferred events are already pending replay for
- *   the same line, we need to ack the subsequent event to the
- *   hardware too.
+ *   entry code, we need to send ack to the hardware. This includes
+ *   the case when we receive a new event on any stage while an event
+ *   of the same type is already pending replay or forwarding.
  *
  * - IRQ_FLOW_REPLAY: we are (re)playing a deferred event from the
  *   in-band stage, as a result of synchronizing the irq log. A
  *   deferred event was NOT handled from the oob stage by definition.
  *
- * - IRQ_FLOW_FORWARD: we are running in-band for passing a forwarded
- *   event already handled from the oob stage to the action
- *   handler. This mode allows for two-step subsequent handling of an
- *   IRQ event over both stages by the same action
+ * - IRQ_FLOW_FORWARD: an event already handled from the oob stage by
+ *   an action handler is forwarded to the same handler for execution
+ *   on the in-band stage.  This mode allows for two-step handling of
+ *   an IRQ event over both stages by the same action
  *   handler. IRQ_FLOW_FORWARD is mutually exclusive with
  *   IRQ_FLOW_REPLAY since only the oob handler may request
  *   forwarding.
  */
 static inline unsigned int get_flow_step(struct irq_desc *desc)
 {
-	if (!irqs_pipelined())
+	if (likely(!irqs_pipelined() || in_pipeline()))
 		return IRQ_FLOW_START;
 
-	if (!(desc->istate & IRQS_DEFERRED))
-		return desc->istate & IRQS_FORWARDED ?
-			IRQ_FLOW_FORWARD : IRQ_FLOW_START;
+	/*
+	 * We must be running in-band, synchronizing the interrupt log
+	 * on the current CPU. Determine whether we are handling a
+	 * deferred or forwarded interrupt.
+	 */
+	WARN_ON(irq_pipeline_debug() && running_oob());
+
+	if (desc->istate & IRQS_FORWARDED)
+		return IRQ_FLOW_FORWARD;
+
+	if (desc->istate & IRQS_DEFERRED)
+		return IRQ_FLOW_REPLAY;
 
-	return in_pipeline() ? IRQ_FLOW_PILEUP : IRQ_FLOW_REPLAY;
+	/*
+	 * Rare case: disambiguate between forwarded IRQs and replayed
+	 * ones for multiple non-oob events from the same source which
+	 * don't need masking on receipt (e.g. edge IRQs), causing the
+	 * replay condition bit to be cleared by
+	 * should_feed_pipeline() on the first occurrence, leaving no
+	 * information to handle the second one appropriately.  We can
+	 * still figure out that a replay condition is pending
+	 * nevertheless (instead of a forwarding) by checking the oob
+	 * capability for the interrupt: oob handled IRQs visible to
+	 * the in-band stage are never deferred (IRQS_DEFERRED), they
+	 * can only be forwarded (IRQS_FORWARDED).
+	 */
+	return irq_settings_is_oob(desc) ? IRQ_FLOW_FORWARD : IRQ_FLOW_REPLAY;
 }
 
 /*

-- 
Philippe.
