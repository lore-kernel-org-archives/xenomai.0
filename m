Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8FF3214
	for <xenomai@lists.linux.dev>; Mon, 28 Nov 2022 12:10:11 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2022112812100419bbea10c95a98a458
        for <xenomai@lists.linux.dev>;
        Mon, 28 Nov 2022 13:10:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xo5wLzcCdN56dr/zvfb1aYeJZsZmDt3BwVp6Y0Oetds=;
 b=Yyp7TD6RtFcOzwbd9QSBH1OBzRrU2NSSTimuGpIJ/+Byf9t3kzEKI0cp/zTSfCTE311KV5
 8OS1Sla50buNtqtovxRyUE/jbLF4B3/Jb6SCa60eCmgC/4QMMwe63jgtkXPNRyEs1xU4DYxW
 WoFiTKxO21FqQo82F2ZeT4SC5+4zM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Greg Gallagher <greg@embeddedgreg.com>,
	Gunter Grau <gunter.grau@philips.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [ipipe 4.4][PATCH] ipipe: Fix imbalance of level triggered IRQ states
Date: Mon, 28 Nov 2022 13:10:02 +0100
Message-Id: <20221128121002.1136269-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There are two states maintained for each IRQ by the kernel:
  - a software flag flipped by irq_state_{clr,set}_masked()
  - the hardware state flipped by the IRQ chip's irq_mask() and
    irq_unmask() members

When ipipe masks a level triggered IRQ both states were updated while
during unmask only the hardware state was updated.

For the 4.4 series this is not a critical thing as the hardware state is
always updated. Newer kernels avoid calling the low level hardware irq
(un)masking infrastructure by reading the software state first. A
imbalanced IRQ state might skip IRQ masking on next IRQ entry resulting
in IRQ storms.

Backporting the fix from 4.19 and 5.4 to keep the IRQ software state
balanced.

Link: https://lore.kernel.org/xenomai/20220210153313.2229625-1-gunter.grau@philips.com/
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/irq/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 83dee72e6f0e..c33953e39055 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -797,7 +797,7 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
 
 void __ipipe_end_level_irq(struct irq_desc *desc)
 {
-	desc->irq_data.chip->irq_unmask(&desc->irq_data);
+	unmask_irq(desc);
 }
 
 void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
-- 
2.35.1

