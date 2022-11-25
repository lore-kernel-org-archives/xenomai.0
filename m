Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD812570
	for <xenomai@lists.linux.dev>; Fri, 25 Nov 2022 09:08:53 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202211250908449c9183362a215f18f4
        for <xenomai@lists.linux.dev>;
        Fri, 25 Nov 2022 10:08:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=SWDCJPrAUVaYu8Inrr0zeihkSAELaUD1y+xCUflQnXg=;
 b=co/VRyChDicmxCP7n8iZublWzPMlWV95yF2hb+u7G69VVlLmABWmK3TIlykqCIRIsbxssC
 1Ah7OvSl/g5/vkCDWpPBn57naN/yyYtNWij55LjMBpizkSK0tVWPL+TYO8TV79A/PdhEOoqJ
 mGqSN+LoDgud9aecNUpwLBKk5ym1c=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Greg Gallagher <greg@embeddedgreg.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [ipipe 4.19][RFC PATCH] ipipe: Do not report spurious interrupts by using printk
Date: Fri, 25 Nov 2022 10:08:34 +0100
Message-Id: <20221125090834.617271-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

Hi all,

I need this patch to get the Hikey board (part of the Xenomai CI lab) up
and running. The problem appeared when updating the test images from
Debian 11 to Debian 12 and with that from gcc 10 to gcc 12.

My understanding is:
 - During boot a UART hangup occurs, so we release the IRQ
 - While that happens there is still on IRQ in flight on a different CPU
 - The in-flight IRQ is detected as spurious interrupt
 - We try to report that using printk()

printk() internally calls ipipe_unstall_root() - by using one of the 
_irqrestore() macros/functions - which unconditionally calls 
hard_local_irq_enable() so HW IRQs are enabled now.

I end up in an IRQ stack overflow.

I assume this happens because the UART IRQ is a level-triggered IRQ. So
it simply fires again.

Does that make sense?

How to fix that properly? Ideas welcome...

The problem can be reproduced on the hikey board quite well. Nearly
every boot ends up in the IRQ stack overflow.

Best regards,
Florian
 

 kernel/ipipe/core.c | 2 +-
 kernel/irq/handle.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index d12e71103424..17ad6f2841f9 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1491,7 +1491,7 @@ void __ipipe_dispatch_irq(unsigned int irq, int flags) /* hw interrupts off */
 
 #ifdef CONFIG_IPIPE_DEBUG
 	if (irq >= IPIPE_NR_IRQS) {
-		pr_err("I-pipe: spurious interrupt %u\n", irq);
+		//pr_err("I-pipe: spurious interrupt %u\n", irq);
 		return;
 	}
 #endif
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index e2f7afcb1ae6..1c3221c72977 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -32,7 +32,7 @@ void handle_bad_irq(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 
-	print_irq_desc(irq, desc);
+	//print_irq_desc(irq, desc);
 	kstat_incr_irqs_this_cpu(desc);
 	ack_bad_irq(irq);
 }
-- 
2.35.1

