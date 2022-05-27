From: Konstantin Smola <ksmola51@gmail.com>
Subject: [PATCH 1/1] drivers/serial/16550A_pci.h: allow custom baud_base with
 pci cards
Date: Fri, 27 May 2022 14:34:46 -0700
Message-Id: <1653687286-31621-1-git-send-email-ksmola51@gmail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Konstantin Smola <ksmola51@gmail.com>

pci probe was overwriting baud_base with default values, ignoring baud_base arguments passed in while loading driver.

Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
---
 kernel/drivers/serial/16550A_pci.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/serial/16550A_pci.h b/kernel/drivers/serial/16550A_pci.h
index 91b0390..b747a10 100644
--- a/kernel/drivers/serial/16550A_pci.h
+++ b/kernel/drivers/serial/16550A_pci.h
@@ -244,7 +244,8 @@ static int rt_16550_pci_probe(struct pci_dev *pdev,
 			io[i] = base_addr + port * board->port_ofs;
 			irq[i] = pdev->irq;
 			irqtype[i] = board->irqtype;
-			baud_base[i] = board->baud_base;
+         if (baud_base[i] == 0)
+			   baud_base[i] = board->baud_base;
 			tx_fifo[i] = board->tx_fifo;
 			port++;
 		}
-- 
2.1.0


