From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Date: Wed, 29 Aug 2018 12:00:58 +0200
Message-Id: <1535536858-3022-1-git-send-email-sebastian.smolorz@gmx.de>
Subject: [Xenomai] [PATCH] drivers/can: Add PCAN-PCI Express OEM ID.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 kernel/drivers/can/sja1000/rtcan_peak_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/drivers/can/sja1000/rtcan_peak_pci.c b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
index 3da1657..0fdc598 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
@@ -78,6 +78,7 @@ struct rtcan_peak_pci
 #define PEAK_PC_104P_DEVICE_ID  0x0006  // PCAN-PC/104+ cards
 #define PEAK_PCI_104E_DEVICE_ID 0x0007  // PCAN-PCI/104 Express cards
 #define PEAK_MPCIE_DEVICE_ID    0x0008  // The miniPCIe slot cards
+#define PEAK_PCIE_OEM_ID        0x0009  // PCAN-PCI Express OEM
 
 #define PCI_CONFIG_PORT_SIZE 0x1000  // size of the config io-memory
 #define PCI_PORT_SIZE        0x0400  // size of a channel io-memory
@@ -90,6 +91,7 @@ static struct pci_device_id peak_pci_tbl[] = {
 	{PEAK_PCI_VENDOR_ID, PEAK_PC_104P_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PEAK_PCI_VENDOR_ID, PEAK_PCI_104E_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PEAK_PCI_VENDOR_ID, PEAK_CPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_OEM_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{ }
 };
 MODULE_DEVICE_TABLE (pci, peak_pci_tbl);
-- 
2.7.4


