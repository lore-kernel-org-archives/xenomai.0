From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Wed, 30 Nov 2011 12:58:03 +0100
Message-Id: <1322654284-6867-2-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1322654284-6867-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1322654284-6867-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Adeos-main] [PATCH 1/2] Fix fasteoi masking
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

To prevent interrupt storms, the fasteoi handler must mask
the interrupt line in oneshot mode. Backported from c69e3758ff56.
---
 kernel/irq/chip.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 9671529..2d25c62 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -575,6 +575,9 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
 		goto out;
 	}
 
+	if (desc->status & IRQ_ONESHOT)
+		mask_irq(desc);
+
 	desc->status |= IRQ_INPROGRESS;
 	desc->status &= ~IRQ_PENDING;
 	raw_spin_unlock(&desc->lock);
-- 
1.7.6.4


