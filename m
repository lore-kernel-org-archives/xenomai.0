Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69003214
	for <xenomai@lists.linux.dev>; Mon, 28 Nov 2022 12:09:19 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20221128120911b21231e19e39a19a97
        for <xenomai@lists.linux.dev>;
        Mon, 28 Nov 2022 13:09:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=SCil96qzGDVlKN2CCuJCw+/SGipXq1iO8Xnru3HEki4=;
 b=bTexr7fBPD8tNkhQeG6dLkm0QclCfOcr5SIIPWyV48yIjb35uTDSEie9hDTqsjIrlmayrj
 r7KZb366BmwDKwpcDbtkrLuvR2o/57zn5VQvp6jwylTOAow0Mh8IsxaSy+9TFIHY4VPQuJqf
 B6d4DVc69byREyjvUa5Q8D4rsmaJs=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Greg Gallagher <greg@embeddedgreg.com>,
	Gunter Grau <gunter.grau@philips.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [ipipe 4.19 5.4][PATCH] ipipe: Fix handling of level triggered IRQs
Date: Mon, 28 Nov 2022 13:09:08 +0100
Message-Id: <20221128120908.1136136-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hardware IRQs are enabled here! It might happen that right after
enabling the IRQ at hardware level the IRQ comes in again, even before
we could fix the software IRQ state flag.

The result was a IRQ storm and system freeze because the same IRQ was
not properly masked at hw level during next IRQ arrival. The software
IRQ flag is checked before going down to the HW level.

Switching to unmask_irq() has two effects:
  - We do not have to care about the software IRQ state flag anymore
  - IRQ state is updated in a hwirq off section together with the hw
    state, so the software state flag and hw state should no longer
    diverge.

Link: https://lore.kernel.org/xenomai/20220210153313.2229625-1-gunter.grau@philips.com/
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/irq/chip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 41415a5ef7d0..6b34403858aa 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -990,8 +990,7 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
 
 void __ipipe_end_level_irq(struct irq_desc *desc)
 {
-	desc->irq_data.chip->irq_unmask(&desc->irq_data);
-	irq_state_clr_masked(desc);
+	unmask_irq(desc);
 }
 
 void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
-- 
2.35.1

