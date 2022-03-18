From: Scott Reed <scott.reed@arcor.de>
Subject: [PATCH] ipipe: noarch: Fix handling of PCIe MSI interrupts for dwc
 PCIe controller
Message-ID: <e8077dad-f6ae-329a-d7df-a6be28b43b76@arcor.de>
Date: Fri, 18 Mar 2022 17:53:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Handling of PCIe MSI interrupts resulted in system
hanging or high latencies.

Fix is to replaced missed call to generic_handle_irq with
ipipe_handle_irq().

Signed-off-by: Scott Reed <scott.reed@arcor.de>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c9fd4e4966ba..7b566da64438 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -100,7 +100,7 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 			irq = irq_find_mapping(pp->irq_domain,
 					       (i * MAX_MSI_IRQS_PER_CTRL) +
 					       pos);
-			generic_handle_irq(irq);
+			ipipe_handle_demuxed_irq(irq);
 			pos++;
 		}
 	}
-- 
2.25.1


