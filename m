From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Wed, 30 Nov 2011 12:58:04 +0100
Message-Id: <1322654284-6867-3-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1322654284-6867-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1322654284-6867-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Adeos-main] [PATCH 2/2] Don't unconditionally unmask fasteoi
	interrupts
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: jan.kiszka@domain.hid, adeos-main@gna.org, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, gernot.hillier@domain.hid

For threaded interrupt handlers in oneshot mode, the
hard irq handler will not yet have satisfied the device,
so we need to keep the line masked until irq_finalize_oneshot().
---
 kernel/irq/chip.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 2d25c62..b79ec1d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -589,7 +589,8 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
 	raw_spin_lock(&desc->lock);
 	desc->status &= ~IRQ_INPROGRESS;
 #ifdef CONFIG_IPIPE
-	desc->irq_data.chip->irq_unmask(&desc->irq_data);
+	if (!(desc->status & IRQ_MASKED))
+		desc->irq_data.chip->irq_unmask(&desc->irq_data);
 out:
 #else
 out:
-- 
1.7.6.4


