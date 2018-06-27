From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <20f17f9a-9492-c87b-ac34-7e312b84fa75@siemens.com>
Date: Wed, 27 Jun 2018 12:57:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] can: Fix compiler warning about missing braces
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

The NULL-test is currently performed also in case we assign a
pre-checked value from the master to base_addr. This is harmless, but
the compiler correctly complains about the misaligned code block - or
the missing braces.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/sja1000/rtcan_adv_pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/can/sja1000/rtcan_adv_pci.c b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
index dc8ea2ee4d..32cf71ee1f 100644
--- a/kernel/drivers/can/sja1000/rtcan_adv_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
@@ -158,14 +158,15 @@ static int rtcan_adv_pci_add_chan(struct pci_dev *pdev,
 			(struct rtcan_adv_pci *)(*master_dev)->board_priv;
 		master_board->slave_dev = dev;
 
-		if (offset)
+		if (offset) {
 			base_addr = master_board->base_addr+offset;
-		else
+		} else {
 			base_addr = pci_iomap(pdev, bar, ADV_PCI_BASE_SIZE);
 			if (!base_addr) {
 				ret = -EIO;
 				goto failure;
 			}
+		}
 	} else {
 		base_addr = pci_iomap(pdev, bar, ADV_PCI_BASE_SIZE) + offset;
 		if (!base_addr) {
-- 
2.16.4

